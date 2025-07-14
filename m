Return-Path: <linux-kernel+bounces-729596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C92CCB038DB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0989A3B2F06
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80300239E60;
	Mon, 14 Jul 2025 08:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="V21aMUuG"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461661E5B82;
	Mon, 14 Jul 2025 08:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752480930; cv=pass; b=jc+TClAprIdnEEspPXxKrKr92CZa00QVN6OO4XE98r3JSpshHBpoqLeteYJxtSYU0DRIIpr+RwAr/ezfRoeZ/FdIExHdIdRVFDgwDge0sLt1DKdZWcD0mn1cORAApWj5QfEoeFp53g3NU2al+jRV0U3YqihHdZJTzTiIIGclQ6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752480930; c=relaxed/simple;
	bh=Kn+umG7ELj2zn622oiPU+bNajsRZjfnuobovlSsDmjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bbqHfYO6IpIwfEWdoyr+yRWwFNXBSx+jug/5OBb++ixPZH3bAW99F5nU0YiVkLyAgIr1ocQYkQtN6Vi9FnMjHBJuRRCuQP6rFfCRR+iROPER6gzcKGJtZxltdDscjfdiSBUsHLmex702Y4+HARxvVvmWCX6qJUz/2HCfxGMrKA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=V21aMUuG; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752480904; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WifZnxfbP5ug6/Ip1ll1peggL/EjwmHgMHgJunY39igVSr9MT6iUOjH0y25HJwIjiDvB9g2kOo/pvu0Ko9fWVT0ItzlwzkQmBmM5GpwCI9jL4r0+AZ5S3/nVI14E/OaIvU0Ar9eygBcI0ZCTTvr7n7qPa/KrpLHT+KUxx/gKlaQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752480904; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3+iX8k7Jgn057JgmzJMCuryKDzE7Motdy3a1DDai1Ik=; 
	b=FnDgKSU/x3L96qSYuG3Ri1ckWnZ7TJd+yfz6y55xExIhEVjpQ43izJNryA6e00kLMmmRPYuCq1l0DxU6XKHNebSTCp3cIUmpWrrLPa8i8t9XrDvLUqMusNCc0J/KS90Gw3jPYCdZqBDsDu/9QHzWnbxbuMhtHZ+6E2xzpHvjIgA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752480904;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=3+iX8k7Jgn057JgmzJMCuryKDzE7Motdy3a1DDai1Ik=;
	b=V21aMUuGwqfx8vhzt5eSH5z1R2QpzoG5DpedaWD5EdK0BXHEHd+darA/zDTanNTa
	D7/KdKy7nZJM91jB/6KRSYzFHNM6vuMWoTShP+vXLujAJJ+KXq9wMsOoVH7udqvKB68
	5bPCWARDV7WDCbMqSOz0IYGp1UOfNOpEc9joV90A=
Received: by mx.zohomail.com with SMTPS id 1752480901854427.77231693846363;
	Mon, 14 Jul 2025 01:15:01 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 14 Jul 2025 10:14:47 +0200
Subject: [PATCH v3] docs: document linked lists
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-linked-list-docs-v3-1-56c461580866@collabora.com>
X-B4-Tracking: v=1; b=H4sIAHa8dGgC/3XOy07EMAwF0F+pssYocV7trPgPxCIPh4noNJCUC
 jTqvxM6CyQEK+ta8vG9skY1U2On4coqbbnlsvQg7wYWzm55JsixZ4YcNdfIYc7LC8U+2gqxhAa
 BtJ+0icpwZP3stVLKHwf5+HTLld7eu7zelsy7RhDK5ZLX05C09jI4GZKIwmgMyks1Cm+smBRXR
 kgpopkS+7bO/Wupn0fbTRzY/8U2ARyitypZpSY76odQ5tn5Ut19/36AG/4gluMfCIIAkkZLTMo
 bOf5G9n3/AnCt6Y1FAQAA
X-Change-ID: 20250520-linked-list-docs-ce5b956d4602
To: Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>, kernel@collabora.com, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

Add example-driven documentation for the kernel's generic linked list
data structure. This includes discussion of situations where linked
lists are likely inappropriate, and references to further reading.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
This series started out with a much more ambitious goal of documenting
every undocumented generic kernel data structure. About 6 hours in I had
to tell myself that maybe it's better to do this piece-meal. So here is
the first of what will hopefully be many similar series: documenting
linked lists.

As an aside note, I didn't set out to exclusively use Swiss clowns in my
examples, but as I reached for more names to illustrate longer lists, I
discovered that the tiny nation of Switzerland has a rich history of
clowning. You learn something new every day.

For future en-beautification, we could add integration for svgbob
(<https://github.com/ivanceras/svgbob>) into the kernel docs sphinx in
the future, which would let us generate drawn diagrams from the text
doodles, therefore serving both audiences a satisfactory viewing
experience.

Based against lwn/docs-next, but b4 should let you know already.
---
Changes in v3:
- Reword commit message.
- Fix INIT_LIST_HEAD invocation.
- Stronger wording to advice against using linked lists, mention data
  locality.
- Fix wording of "data struct" to be "data structure" instead.
- Fix automagic markup of struct list_head et al., including removing
  some false-positives by changing "struct" to "data structure" where a
  reference would be inappropriate.
- list_add() function -> list_add() macro.
- Add a sentence explaining what list_entry() does.
- Remove explanatory paragraphs after each diagram starting from where
  corbet pointed out they're getting tiresome. They were originally
  intended to be there to assist people using screen readers, but in
  retrospect, the lack of suitable markup for them as "alt text" so to
  speak makes it frustratingly verbose for regular readers.
- Move list kerneldoc from kernel-api.rst to the end of list.rst.
- Change "initialised" to "initialized" for consistency.
- Remove stray comma after "during".
- "left up" -> "left"
- Link to v2: https://lore.kernel.org/r/20250702-linked-list-docs-v2-1-e36532f4b638@collabora.com

Changes in v2:
- drop unrelated sphinx theme patch.
- replace graphviz diagrams with simpler ascii art in literal blocks,
  which omit the back edges for clarity and are readable as plain text.
- add explanatory paragraphs after every diagram that describe what is
  depicted in plain English. This is to help users that use assistive
  technologies like screen readers.
- add examples illustrating the use of list_cut_position and
  list_cut_before.
- add examples illustrating the use of list_move, list_move_tail and
  list_bulk_move_tail.
- add examples illustrating the use of list_rotate_left and
  list_rotate_to_front.
- add example illustrating the use of list_swap.
- add example illustrating the use of list_splice, and its caveats with
  regards to stale pointers.
- Link to v1: https://lore.kernel.org/r/20250520-linked-list-docs-v1-0-db74f7449785@collabora.com
---
 Documentation/core-api/index.rst      |   1 +
 Documentation/core-api/kernel-api.rst |   6 -
 Documentation/core-api/list.rst       | 776 ++++++++++++++++++++++++++++++++++
 3 files changed, 777 insertions(+), 6 deletions(-)

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index 7a4ca18ca6e2d37644553cfcb0c41c9f05513294..a03a99c2cac56f4ade418f43da723e49216b1062 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -54,6 +54,7 @@ Library functionality that is used throughout the kernel.
    union_find
    min_heap
    parser
+   list
 
 Low level entry and exit
 ========================
diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
index ae92a2571388ae7fc0b7c5f23a19ed59ac1312cc..ab8563b013f52465225e6ec49d337948e82a42ae 100644
--- a/Documentation/core-api/kernel-api.rst
+++ b/Documentation/core-api/kernel-api.rst
@@ -3,12 +3,6 @@ The Linux Kernel API
 ====================
 
 
-List Management Functions
-=========================
-
-.. kernel-doc:: include/linux/list.h
-   :internal:
-
 Basic C Library Functions
 =========================
 
diff --git a/Documentation/core-api/list.rst b/Documentation/core-api/list.rst
new file mode 100644
index 0000000000000000000000000000000000000000..86873ce9adbf873212fd6adbac1ffa96a9aad1bc
--- /dev/null
+++ b/Documentation/core-api/list.rst
@@ -0,0 +1,776 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+=====================
+Linked Lists in Linux
+=====================
+
+:Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
+
+.. contents::
+
+Introduction
+============
+
+Linked lists are one of the most basic data structures used in many programs.
+The Linux kernel implements several different flavours of linked lists. The
+purpose of this document is not to explain linked lists in general, but to show
+new kernel developers how to use the Linux kernel implementations of linked
+lists.
+
+Please note that while linked lists certainly are ubiquitous, they are rarely
+the best data structure to use in cases where a simple array doesn't already
+suffice. In particular, due to their poor data locality, linked lists are a bad
+choice in situations where performance may be of consideration. Familiarizing
+oneself with other in-kernel generic data structures, especially for concurrent
+accesses, is highly encouraged.
+
+Linux implementation of doubly linked lists
+===========================================
+
+Linux's linked list implementations can be used by including the header file
+``<linux/list.h>``.
+
+The doubly-linked list will likely be the most familiar to many readers. It's a
+list that can efficiently be traversed forwards and backwards.
+
+The Linux kernel's doubly-linked list is circular in nature. This means that to
+get from the head node to the tail, we can just travel one edge backwards.
+Similarly, to get from the tail node to the head, we can simply travel forwards
+"beyond" the tail and arrive back at the head.
+
+Declaring a node
+----------------
+
+A node in a doubly-linked list is declared by adding a struct list_head
+member to the data structure you wish to be contained in the list:
+
+.. code-block:: c
+
+  struct clown {
+          unsigned long long shoe_size;
+          const char *name;
+          struct list_head node;  /* the aforementioned member */
+  };
+
+This may be an unfamiliar approach to some, as the classical explanation of a
+linked list is a list node data structure with pointers to the previous and next
+list node, as well the payload data. Linux chooses this approach because it
+allows for generic list modification code regardless of what data structure is
+contained within the list. Since the struct list_head member is not a pointer
+but part of the data structure proper, the container_of() pattern can be used by
+the list implementation to access the payload data regardless of its type, while
+staying oblivious to what said type actually is.
+
+Declaring and initializing a list
+---------------------------------
+
+A doubly-linked list can then be declared as just another struct list_head,
+and initialized with the LIST_HEAD_INIT() macro during initial assignment, or
+with the INIT_LIST_HEAD() function later:
+
+.. code-block:: c
+
+  struct clown_car {
+          int tyre_pressure[4];
+          struct list_head clowns;        /* Looks like a node! */
+  };
+
+  /* ... Somewhere later in our driver ... */
+
+  static int circus_init(struct circus_priv *circus)
+  {
+          struct clown_car other_car = {
+                .tyre_pressure = {10, 12, 11, 9},
+                .clowns = LIST_HEAD_INIT(other_car.clowns)
+          };
+
+          INIT_LIST_HEAD(&circus->car.clowns);
+
+          return 0;
+  }
+
+A further point of confusion to some may be that the list itself doesn't really
+have its own type. The concept of the entire linked list and a
+struct list_head member that points to other entries in the list are one and
+the same.
+
+Adding nodes to the list
+------------------------
+
+Adding a node to the linked list is done through the list_add() macro.
+
+We'll return to our clown car example to illustrate how nodes get added to the
+list:
+
+.. code-block:: c
+
+  static int circus_fill_car(struct circus_priv *circus)
+  {
+          struct clown_car *car = &circus->car;
+          struct clown *grock;
+          struct clown *dimitri;
+
+          /* State 1 */
+
+          grock = kzalloc(sizeof(*grock), GFP_KERNEL);
+          if (!grock)
+                  return -ENOMEM;
+          grock->name = "Grock";
+          grock->shoe_size = 1000;
+
+          /* Note that we're adding the "node" member */
+          list_add(&grock->node, &car->clowns);
+
+          /* State 2 */
+
+          dimitri = kzalloc(sizeof(*dimitri), GFP_KERNEL);
+          if (!dimitri)
+                  return -ENOMEM;
+          dimitri->name = "Dimitri";
+          dimitri->shoe_size = 50;
+
+          list_add(&dimitri->node, &car->clowns);
+
+          /* State 3 */
+
+          return 0;
+  }
+
+In State 1, our list of clowns is still empty::
+
+         .------.
+         v      |
+    .--------.  |
+    | clowns |--'
+    '--------'
+
+This diagram shows the singular "clowns" node pointing at itself. In this
+diagram, and all following diagrams, only the forward edges are shown, to aid in
+clarity.
+
+In State 2, we've added Grock after the list head::
+
+         .--------------------.
+         v                    |
+    .--------.     .-------.  |
+    | clowns |---->| Grock |--'
+    '--------'     '-------'
+
+This diagram shows the "clowns" node pointing at a new node labeled "Grock".
+The Grock node is pointing back at the "clowns" node.
+
+In State 3, we've added Dimitri after the list head, resulting in the following::
+
+         .------------------------------------.
+         v                                    |
+    .--------.     .---------.     .-------.  |
+    | clowns |---->| Dimitri |---->| Grock |--'
+    '--------'     '---------'     '-------'
+
+This diagram shows the "clowns" node pointing at a new node labeled "Dimitri",
+which then points at the node labeled "Grock". The "Grock" node still points
+back at the "clowns" node.
+
+If we wanted to have Dimitri inserted at the end of the list instead, we'd use
+list_add_tail(). Our code would then look like this:
+
+.. code-block:: c
+
+  static int circus_fill_car(struct circus_priv *circus)
+  {
+          /* ... */
+
+          list_add_tail(&dimitri->node, &car->clowns);
+
+          /* State 3b */
+
+          return 0;
+  }
+
+This results in the following list::
+
+         .------------------------------------.
+         v                                    |
+    .--------.     .-------.     .---------.  |
+    | clowns |---->| Grock |---->| Dimitri |--'
+    '--------'     '-------'     '---------'
+
+This diagram shows the "clowns" node pointing at the node labeled "Grock",
+which points at the new node labeled "Dimitri". The node labeled "Dimitri"
+points back at the "clowns" node.
+
+Traversing the list
+-------------------
+
+To iterate the list, we can loop through all nodes within the list with
+list_for_each().
+
+In our clown example, this results in the following somewhat awkward code:
+
+.. code-block:: c
+
+  static unsigned long long circus_get_max_shoe_size(struct circus_priv *circus)
+  {
+          unsigned long long res = 0;
+          struct clown *e;
+          struct list_head *cur;
+
+          list_for_each(cur, &circus->car.clowns) {
+                  e = list_entry(cur, struct clown, node);
+                  if (e->shoe_size > res)
+                          res = e->shoe_size;
+          }
+
+          return res;
+  }
+
+The list_entry() macro internally uses the aforementioned container_of() to
+retrieve the data structure instance that ``node`` is a member of.
+
+Note how the additional list_entry() call is a little awkward here. It's only
+there because we're iterating through the ``node`` members, but we really want
+to iterate through the payload, i.e. the ``struct clown`` that contains each
+node's struct list_head. For this reason, there is a second macro:
+list_for_each_entry()
+
+Using it would change our code to something like this:
+
+.. code-block:: c
+
+  static unsigned long long circus_get_max_shoe_size(struct circus_priv *circus)
+  {
+          unsigned long long res = 0;
+          struct clown *e;
+
+          list_for_each_entry(e, &circus->car.clowns, node) {
+                  if (e->shoe_size > res)
+                          res = e->shoe_size;
+          }
+
+          return res;
+  }
+
+This eliminates the need for the list_entry() step, and our loop cursor is now
+of the type of our payload. The macro is given the member name that corresponds
+to the list's struct list_head within the clown data structure so that it can
+still walk the list.
+
+Removing nodes from the list
+----------------------------
+
+The list_del() function can be used to remove entries from the list. It not only
+removes the given entry from the list, but poisons the entry's ``prev`` and
+``next`` pointers, so that unintended use of the entry after removal does not
+go unnoticed.
+
+We can extend our previous example to remove one of the entries:
+
+.. code-block:: c
+
+  static int circus_fill_car(struct circus_priv *circus)
+  {
+          /* ... */
+
+          list_add(&dimitri->node, &car->clowns);
+
+          /* State 3 */
+
+          list_del(&dimitri->node);
+
+          /* State 4 */
+
+          return 0;
+  }
+
+The result of this would be this::
+
+         .--------------------.
+         v                    |
+    .--------.     .-------.  |      .---------.
+    | clowns |---->| Grock |--'      | Dimitri |
+    '--------'     '-------'         '---------'
+
+This diagram shows the "clowns" node pointing at the node labeled "Grock",
+which points back at the "clowns" node. Off to the side is a lone node labeled
+"Dimitri", which has no arrows pointing anywhere.
+
+Note how the Dimitri node does not point to itself; its pointers are
+intentionally set to a "poison" value that the list code refuses to traverse.
+
+If we wanted to reinitialize the removed node instead to make it point at itself
+again like an empty list head, we can use list_del_init() instead:
+
+.. code-block:: c
+
+  static int circus_fill_car(struct circus_priv *circus)
+  {
+          /* ... */
+
+          list_add(&dimitri->node, &car->clowns);
+
+          /* State 3 */
+
+          list_del_init(&dimitri->node);
+
+          /* State 4b */
+
+          return 0;
+  }
+
+This results in the deleted node pointing to itself again::
+
+         .--------------------.           .-------.
+         v                    |           v       |
+    .--------.     .-------.  |      .---------.  |
+    | clowns |---->| Grock |--'      | Dimitri |--'
+    '--------'     '-------'         '---------'
+
+This diagram shows the "clowns" node pointing at the node labeled "Grock",
+which points back at the "clowns" node. Off to the side is a lone node labeled
+"Dimitri", which points to itself.
+
+Traversing whilst removing nodes
+--------------------------------
+
+Deleting entries while we're traversing the list will cause problems if we use
+list_for_each() and list_for_each_entry(), as deleting the current entry would
+modify the ``next`` pointer of it, which means the traversal can't properly
+advance to the next list entry.
+
+There is a solution to this however: list_for_each_safe() and
+list_for_each_entry_safe(). These take an additional parameter of a pointer to
+a struct list_head to use as temporary storage for the next entry during
+iteration, solving the issue.
+
+An example of how to use it:
+
+.. code-block:: c
+
+  static void circus_eject_insufficient_clowns(struct circus_priv *circus)
+  {
+          struct clown *e;
+          struct clown *n;      /* temporary storage for safe iteration */
+
+          list_for_each_entry_safe(e, n, &circus->car.clowns, node) {
+                if (e->shoe_size < 500)
+                        list_del(&e->node);
+          }
+  }
+
+Proper memory management (i.e. freeing the deleted node while making sure
+nothing still references it) in this case is left as an exercise to the reader.
+
+Cutting a list
+--------------
+
+There are two helper functions to cut lists with. Both take elements from the
+list ``head``, and replace the contents of the list ``list``.
+
+The first such function is list_cut_position(). It removes all list entries from
+``head`` up to and including ``entry``, placing them in ``list`` instead.
+
+In this example, it's assumed we start with the following list::
+
+         .----------------------------------------------------------------.
+         v                                                                |
+    .--------.     .-------.     .---------.     .-----.     .---------.  |
+    | clowns |---->| Grock |---->| Dimitri |---->| Pic |---->| Alfredo |--'
+    '--------'     '-------'     '---------'     '-----'     '---------'
+
+With the following code, every clown up to and including "Pic" is moved from
+the "clowns" list head to a separate struct list_head initialized at local
+stack variable ``retirement``:
+
+.. code-block:: c
+
+  static void circus_retire_clowns(struct circus_priv *circus)
+  {
+          struct list_head retirement = LIST_HEAD_INIT(retirement);
+          struct clown *grock, *dimitri, *pic, *alfredo;
+          struct clown_car *car = &circus->car;
+
+          /* ... clown initialization, list adding ... */
+
+          list_cut_position(&retirement, &car->clowns, &pic->node);
+
+          /* State 1 */
+  }
+
+The resulting ``car->clowns`` list would be this::
+
+         .----------------------.
+         v                      |
+    .--------.     .---------.  |
+    | clowns |---->| Alfredo |--'
+    '--------'     '---------'
+
+Meanwhile, the ``retirement`` list is transformed to the following::
+
+           .--------------------------------------------------.
+           v                                                  |
+    .------------.     .-------.     .---------.     .-----.  |
+    | retirement |---->| Grock |---->| Dimitri |---->| Pic |--'
+    '------------'     '-------'     '---------'     '-----'
+
+The second function, list_cut_before(), is much the same, except it cuts before
+the ``entry`` node, i.e. it removes all list entries from ``head`` up to but
+excluding ``entry``, placing them in ``list`` instead. This example assumes the
+same initial starting list as the previous example:
+
+.. code-block:: c
+
+  static void circus_retire_clowns(struct circus_priv *circus)
+  {
+          struct list_head retirement = LIST_HEAD_INIT(retirement);
+          struct clown *grock, *dimitri, *pic, *alfredo;
+          struct clown_car *car = &circus->car;
+
+          /* ... clown initialization, list adding ... */
+
+          list_cut_before(&retirement, &car->clowns, &pic->node);
+
+          /* State 1b */
+  }
+
+The resulting ``car->clowns`` list would be this::
+
+         .----------------------------------.
+         v                                  |
+    .--------.     .-----.     .---------.  |
+    | clowns |---->| Pic |---->| Alfredo |--'
+    '--------'     '-----'     '---------'
+
+Meanwhile, the ``retirement`` list is transformed to the following::
+
+           .--------------------------------------.
+           v                                      |
+    .------------.     .-------.     .---------.  |
+    | retirement |---->| Grock |---->| Dimitri |--'
+    '------------'     '-------'     '---------'
+
+It should be noted that both functions will destroy links to any existing nodes
+in the destination ``struct list_head *list``.
+
+Moving entries and partial lists
+--------------------------------
+
+The list_move() and list_move_tail() functions can be used to move an entry
+from one list to another, to either the start or end respectively.
+
+In the following example, we'll assume we start with two lists ("clowns" and
+"sidewalk" in the following initial state "State 0"::
+
+         .----------------------------------------------------------------.
+         v                                                                |
+    .--------.     .-------.     .---------.     .-----.     .---------.  |
+    | clowns |---->| Grock |---->| Dimitri |---->| Pic |---->| Alfredo |--'
+    '--------'     '-------'     '---------'     '-----'     '---------'
+
+          .-------------------.
+          v                   |
+    .----------.     .-----.  |
+    | sidewalk |---->| Pio |--'
+    '----------'     '-----'
+
+We apply the following example code to the two lists:
+
+.. code-block:: c
+
+  static void circus_clowns_exit_car(struct circus_priv *circus)
+  {
+          struct list_head sidewalk = LIST_HEAD_INIT(sidewalk);
+          struct clown *grock, *dimitri, *pic, *alfredo, *pio;
+          struct clown_car *car = &circus->car;
+
+          /* ... clown initialization, list adding ... */
+
+          /* State 0 */
+
+          list_move(&pic->node, &sidewalk);
+
+          /* State 1 */
+
+          list_move_tail(&dimitri->node, &sidewalk);
+
+          /* State 2 */
+  }
+
+In State 1, we arrive at the following situation::
+
+        .-----------------------------------------------------.
+        |                                                     |
+        v                                                     |
+    .--------.     .-------.     .---------.     .---------.  |
+    | clowns |---->| Grock |---->| Dimitri |---->| Alfredo |--'
+    '--------'     '-------'     '---------'     '---------'
+
+          .-------------------------------.
+          v                               |
+    .----------.     .-----.     .-----.  |
+    | sidewalk |---->| Pic |---->| Pio |--'
+    '----------'     '-----'     '-----'
+
+In State 2, after we've moved Dimitri to the tail of sidewalk, the situation
+changes as follows::
+
+        .-------------------------------------.
+        |                                     |
+        v                                     |
+    .--------.     .-------.     .---------.  |
+    | clowns |---->| Grock |---->| Alfredo |--'
+    '--------'     '-------'     '---------'
+
+          .-----------------------------------------------.
+          v                                               |
+    .----------.     .-----.     .-----.     .---------.  |
+    | sidewalk |---->| Pic |---->| Pio |---->| Dimitri |--'
+    '----------'     '-----'     '-----'     '---------'
+
+As long as the source and destination list head are part of the same list, we
+can also efficiently bulk move a segment of the list to the tail end of the
+list. We continue the previous example by adding a list_bulk_move_tail() after
+State 2, moving Pic and Pio to the tail end of the sidewalk list.
+
+.. code-block:: c
+
+  static void circus_clowns_exit_car(struct circus_priv *circus)
+  {
+          struct list_head sidewalk = LIST_HEAD_INIT(sidewalk);
+          struct clown *grock, *dimitri, *pic, *alfredo, *pio;
+          struct clown_car *car = &circus->car;
+
+          /* ... clown initialization, list adding ... */
+
+          /* State 0 */
+
+          list_move(&pic->node, &sidewalk);
+
+          /* State 1 */
+
+          list_move_tail(&dimitri->node, &sidewalk);
+
+          /* State 2 */
+
+          list_bulk_move_tail(&sidewalk, &pic->node, &pio->node);
+
+          /* State 3 */
+  }
+
+For the sake of brevity, only the altered "sidewalk" list at State 3 is depicted
+in the following diagram::
+
+          .-----------------------------------------------.
+          v                                               |
+    .----------.     .---------.     .-----.     .-----.  |
+    | sidewalk |---->| Dimitri |---->| Pic |---->| Pio |--'
+    '----------'     '---------'     '-----'     '-----'
+
+Do note that list_bulk_move_tail() does not do any checking as to whether all
+three supplied ``struct list_head *`` parameters really do belong to the same
+list. If you use it outside the constraints the documentation gives, then the
+result is a matter between you and the implementation.
+
+Rotating entries
+----------------
+
+A common write operation on lists, especially when using them as queues, is
+to rotate it. A list rotation means entries at the front are sent to the back.
+
+For rotation, Linux provides us with two functions: list_rotate_left() and
+list_rotate_to_front(). The former can be pictured like a bicycle chain, taking
+the entry after the supplied ``struct list_head *`` and moving it to the tail,
+which in essence means the entire list, due to its circular nature, rotates by
+one position.
+
+The latter, list_rotate_to_front(), takes the same concept one step further:
+instead of advancing the list by one entry, it advances it *until* the specified
+entry is the new front.
+
+In the following example, our starting state, State 0, is the following::
+
+         .-----------------------------------------------------------------.
+         v                                                                 |
+    .--------.   .-------.   .---------.   .-----.   .---------.   .-----. |
+    | clowns |-->| Grock |-->| Dimitri |-->| Pic |-->| Alfredo |-->| Pio |-'
+    '--------'   '-------'   '---------'   '-----'   '---------'   '-----'
+
+The example code being used to demonstrate list rotations is the following:
+
+.. code-block:: c
+
+  static void circus_clowns_rotate(struct circus_priv *circus)
+  {
+          struct clown *grock, *dimitri, *pic, *alfredo, *pio;
+          struct clown_car *car = &circus->car;
+
+          /* ... clown initialization, list adding ... */
+
+          /* State 0 */
+
+          list_rotate_left(&car->clowns);
+
+          /* State 1 */
+
+          list_rotate_to_front(&alfredo->node, &car->clowns);
+
+          /* State 2 */
+
+  }
+
+In State 1, we arrive at the following situation::
+
+         .-----------------------------------------------------------------.
+         v                                                                 |
+    .--------.   .---------.   .-----.   .---------.   .-----.   .-------. |
+    | clowns |-->| Dimitri |-->| Pic |-->| Alfredo |-->| Pio |-->| Grock |-'
+    '--------'   '---------'   '-----'   '---------'   '-----'   '-------'
+
+Next, after the list_rotate_to_front() call, we arrive in the following
+State 2::
+
+         .-----------------------------------------------------------------.
+         v                                                                 |
+    .--------.   .---------.   .-----.   .-------.   .---------.   .-----. |
+    | clowns |-->| Alfredo |-->| Pio |-->| Grock |-->| Dimitri |-->| Pic |-'
+    '--------'   '---------'   '-----'   '-------'   '---------'   '-----'
+
+As is hopefully evident from the diagrams, the entries in front of "Alfredo"
+were cycled to the tail end of the list.
+
+Swapping entries
+----------------
+
+Another common operation is that two entries need to be swapped with each other.
+
+For this, Linux provides us with list_swap().
+
+In the following example, we have a list with three entries, and swap two of
+them. This is our starting state in "State 0"::
+
+         .-----------------------------------------.
+         v                                         |
+    .--------.   .-------.   .---------.   .-----. |
+    | clowns |-->| Grock |-->| Dimitri |-->| Pic |-'
+    '--------'   '-------'   '---------'   '-----'
+
+.. code-block:: c
+
+  static void circus_clowns_swap(struct circus_priv *circus)
+  {
+          struct clown *grock, *dimitri, *pic;
+          struct clown_car *car = &circus->car;
+
+          /* ... clown initialization, list adding ... */
+
+          /* State 0 */
+
+          list_swap(&dimitri->node, &pic->node);
+
+          /* State 1 */
+  }
+
+The resulting list at State 1 is the following::
+
+         .-----------------------------------------.
+         v                                         |
+    .--------.   .-------.   .-----.   .---------. |
+    | clowns |-->| Grock |-->| Pic |-->| Dimitri |-'
+    '--------'   '-------'   '-----'   '---------'
+
+As is evident by comparing the diagrams, the "Pic" and "Dimitri" nodes have
+traded places.
+
+Splicing two lists together
+---------------------------
+
+Say we have two lists, in the following example one represented by a list head
+we call "knie" and one we call "stey". In a hypothetical circus acquisition,
+the two list of clowns should be spliced together. The following is our
+situation in "State 0"::
+
+        .-----------------------------------------.
+        |                                         |
+        v                                         |
+    .------.   .-------.   .---------.   .-----.  |
+    | knie |-->| Grock |-->| Dimitri |-->| Pic |--'
+    '------'   '-------'   '---------'   '-----'
+
+        .-----------------------------.
+        v                             |
+    .------.   .---------.   .-----.  |
+    | stey |-->| Alfredo |-->| Pio |--'
+    '------'   '---------'   '-----'
+
+The function to splice these two lists together is list_splice(). Our example
+code is as follows:
+
+.. code-block:: c
+
+  static void circus_clowns_splice(void)
+  {
+          struct clown *grock, *dimitri, *pic, *alfredo, *pio;
+          struct list_head knie = LIST_HEAD_INIT(knie);
+          struct list_head stey = LIST_HEAD_INIT(stey);
+
+          /* ... Clown allocation and initialization here ... */
+
+          list_add_tail(&grock->node, &knie);
+          list_add_tail(&dimitri->node, &knie);
+          list_add_tail(&pic->node, &knie);
+          list_add_tail(&alfredo->node, &stey);
+          list_add_tail(&pio->node, &stey);
+
+          /* State 0 */
+
+          list_splice(&stey, &dimitri->node);
+
+          /* State 1 */
+  }
+
+The list_splice() call here adds all the entries in ``stey`` to the list
+``dimitri``'s ``node`` list_head is in, after the ``node`` of ``dimitri``. A
+somewhat surprising diagram of the resulting "State 1" follows::
+
+        .-----------------------------------------------------------------.
+        |                                                                 |
+        v                                                                 |
+    .------.   .-------.   .---------.   .---------.   .-----.   .-----.  |
+    | knie |-->| Grock |-->| Dimitri |-->| Alfredo |-->| Pio |-->| Pic |--'
+    '------'   '-------'   '---------'   '---------'   '-----'   '-----'
+                                              ^
+              .-------------------------------'
+              |
+    .------.  |
+    | stey |--'
+    '------'
+
+Traversing the ``stey`` list no longer results in correct behavior. A call of
+list_for_each() on ``stey`` results in an infinite loop, as it never returns
+back to the ``stey`` list head.
+
+This is because list_splice() did not reinitialize the list_head it took
+entries from, leaving its pointer pointing into what is now a different list.
+
+If we want to avoid this situation, list_splice_init() can be used. It does the
+same thing as list_splice(), except reinitalizes the donor list_head after the
+transplant.
+
+Concurrency considerations
+--------------------------
+
+Concurrent access and modification of a list needs to be protected with a lock
+in most cases. Alternatively and preferably, one may use the RCU primitives for
+lists in read-mostly use-cases, where read accesses to the list are common but
+modifications to the list less so. See Documentation/RCU/listRCU.rst for more
+details.
+
+Further reading
+---------------
+
+* `How does the kernel implements Linked Lists? - KernelNewbies <https://kernelnewbies.org/FAQ/LinkedLists>`_
+
+Full List API
+=============
+
+.. kernel-doc:: include/linux/list.h
+   :internal:

---
base-commit: f55b3ca3cf1d1652c4b3481b671940461331d69f
change-id: 20250520-linked-list-docs-ce5b956d4602

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>


