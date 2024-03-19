const express = require("express");
const router = express.Router();
const { Pool } = require("pg");
const { json } = require("express");

const pool = new Pool({
  connectionString: "postgres://postgres:pass@localhost:5432/asambeni_db",
  ssl: false,
});

router.get("/", function (req, res) {
  pool.query("SELECT * FROM public.admins", (err, result) => {
    if (err) {
      res.status(400).send("Error: " + err);
    } else res.status(200).json({ admins: result?.rows });
  });
});

router.get("/:id", function (req, res) {
  const id = req.params.id;
  res.send("Hey ID: " + id);
});

router.post("/", function (req, res) {
  const body = req.body;
  const { firstName, lastName, email, phone, username } = req.body;
  pool.query(
    "INSERT INTO admins (firstName, lastName, email, phone, username) VALUES ($1, $2, $3, $4, $4)",
    [firstName, lastName, email, phone, username],
    (err, result) => {
      if (err) {
        res.status(400).send("Error: " + err);
      } else res.status(201).send(result);
    }
  );
});

router.put("/", function (req, res) {
  const body = req.body;
  res.send(body);
});

router.delete("/", function (req, res) {
  const body = req.body;
  res.send(body);
});

module.exports = {
  router,
  path: "/admins",
};
