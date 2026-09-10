# lieferando-checkout-conversion-analysis

**Product / Data Analytics — Funnel Analysis**  
*A self-directed case study using synthetic Lieferando order data*

---

## 📌 Context

Lieferando connects customers with restaurants — discover food, order it, and get it delivered.

The ordering journey has multiple steps between opening the app and getting a meal: browsing restaurants, picking food, building a cart, checking out, paying, and finally placing the order.

Every one of those steps is a potential point of drop-off.

**Checkout is the focus of this analysis.**

By the time a user starts checkout, they have already decided to order. Losing them at this stage is less about restaurant discovery or menu selection and more about friction in the checkout process.

That makes checkout drop-off both **costly and potentially solvable**.

---

## 🎯 Goal

**Improve checkout conversion:** the share of people who actually complete an order once they've started checkout.

> More completed orders → more transactions → more revenue.

This is the main business outcome that the analysis ties back to.

---

## 🔎 The Problem

The largest leak currently identified is:

**Payment Method Selected → Payment Submitted**

This step loses **16.78% of users** that's nearly double the drop-off at any other step in checkout.

### Checkout Funnel

```text
Checkout Started
        ↓
Address Confirmed
        ↓
Delivery Time Selected
        ↓
Payment Method Selected
        ↓
Payment Submitted
        ↓
Order Placed
