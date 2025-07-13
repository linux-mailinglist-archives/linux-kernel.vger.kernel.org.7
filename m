Return-Path: <linux-kernel+bounces-728919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA9BB02F05
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 09:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C1FA3BF8B4
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 07:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A209B1CEADB;
	Sun, 13 Jul 2025 07:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cQqEprMk"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABD5433A6;
	Sun, 13 Jul 2025 07:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752390524; cv=none; b=sUHjjM3/o74NSJsMv9YberTxxAmCe5W6otSziKLtvDiwRYNExM0egr9r9POV/EurWSHCilCM85dcajymcaB6dmn/fh4RShAThOKd8b/pbRNWQZivy60F+OOYeg5YJ4mnAm2yaJq1Za7mTZFA+LB/A/x/ul7DcQxBQoMZ5MjBs9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752390524; c=relaxed/simple;
	bh=w54rj8ekri+M1ICfnO0Nezvd11Lr9SwsgnVebAaFS1c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=G1dK4YKEFxADPSH3js0Hx1o78DnpeytLpWrss2ynfqjoZZJI6+OvNkxxikuX/1lSqZLObmuP0EfvHuAUbkpGcU07vSr8xru3M6EHA6qBLANjm+ob5WEWDmRs8au+au76aNlZVSzYGHiVoT+/QmsH27dOe7tsy65NcitKx2j8FCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cQqEprMk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=zFtvEvyBciFT3r9fW1rqR4J+2fCl4FouNSJeOjEQj+Y=; b=cQqEprMk+gYMv7bBm6ZHy855Hn
	u4INP5PwGPQRh8R5u7bYwnOJUeoK1CnkmZ92rx4yJQiywqeo75WcIuNPyGdtWLhiUXSj8O1/TYd+z
	ZFOd0fyjyNgvFofeAL7Ew3wRvZnBjQMMUKdpuSMOzXHJnz9FzSr12iNg1cVxvhJdOdDx3OEyYlt4v
	lP+zRPQMbZnTa//YeJdkOCpEJdMW0FLtZLhUThZw29OONdBjLCy1OxhXqU5WMYVij1yUC8MuxgEol
	+WYppQaydF1D9CO9XiIDaUsQJ5gW9g7A+Dq2daZf+ytRruShl1Q+qx/XVTgX0n1cYRmlX5p10rrkJ
	8DjrLnLg==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaqpB-0000000HQca-13XR;
	Sun, 13 Jul 2025 07:08:37 +0000
Message-ID: <38c87db9-3ab6-4fb7-b853-b4a24e7e84bb@infradead.org>
Date: Sun, 13 Jul 2025 00:08:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] docs: document linked lists
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: kernel@collabora.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250702-linked-list-docs-v2-1-e36532f4b638@collabora.com>
Content-Language: en-US
In-Reply-To: <20250702-linked-list-docs-v2-1-e36532f4b638@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/2/25 1:24 PM, Nicolas Frattaroli wrote:
> The kernel contains various generic data structures that should ideally
> not be reinvented. However, it often fails to document the usage of
> these in the in-tree kernel documentation beyond just a listing of
> header symbols in the very lengthy kernel-api docs page. This is fine
> for things that have simple invocations, but occasionally things devolve
> into several layers of concatenating macros, which are subpar for humans
> to parse.
> 
> Begin making a small impact by adding some rudimentary example-driven
> documentation for the linked list functions. Many aspects are covered,
> though it is not an exhaustive listing of the entire set of list
> operations. We also direct readers towards further documentation should
> they be interested in concurrency.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---

> Based against lwn/docs-next, but b4 should let you know already.
> ---
>  Documentation/core-api/index.rst |   1 +
>  Documentation/core-api/list.rst  | 847 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 848 insertions(+)
> 

> diff --git a/Documentation/core-api/list.rst b/Documentation/core-api/list.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..b0586056abb04d2bcc4518f7238ff9a94d3dd774
> --- /dev/null
> +++ b/Documentation/core-api/list.rst
> @@ -0,0 +1,847 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +=====================
> +Linked Lists in Linux
> +=====================
> +
> +:Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> +
> +.. contents::
> +
> +Introduction
> +============
> +
> +Linked lists are one of the most basic data structures used in many programs.
> +The Linux kernel implements several different flavours of linked lists. The
> +purpose of this document is not to explain linked lists in general, but to show
> +new kernel developers how to use the Linux kernel implementations of linked
> +lists.
> +
> +Please note that while linked lists certainly are ubiquitous, they may not
> +always be the best data structure to use in cases where a simple array doesn't
> +already suffice. Familiarizing oneself with other in-kernel generic data
> +structures, especially for concurrent accesses, is highly encouraged.
> +
> +Linux implementation of doubly linked lists
> +===========================================
> +
> +Linux's linked list implementations can be used by including the header file
> +``<linux/list.h>``.
> +
> +The doubly-linked list will likely be the most familiar to many readers. It's a
> +list that can efficiently be traversed forwards and backwards.
> +
> +The Linux kernel's doubly-linked list is circular in nature. This means that to
> +get from the head node to the tail, we can just travel one edge backwards.
> +Similarly, to get from the tail node to the head, we can simply travel forwards
> +"beyond" the tail and arrive back at the head.
> +
> +Declaring a node
> +----------------
> +
> +A node in a doubly-linked list is declared by adding a ``struct list_head``
> +member to the struct you wish to be contained in the list:
> +
> +.. code-block:: c
> +
> +  struct clown {
> +          unsigned long long shoe_size;
> +          const char *name;
> +          struct list_head node;  /* the aforementioned member */
> +  };
> +
> +This may be an unfamiliar approach to some, as the classical explanation of a
> +linked list is a list node struct with pointers to the previous and next list
> +node, as well the payload data. Linux chooses this approach because it allows
> +for generic list modification code regardless of what data struct is contained
> +within the list. Since the ``struct list_head`` member is not a pointer but part
> +of the struct proper, the ``container_of`` pattern can be used by the list
> +implementation to access the payload data regardless of its type, while staying
> +oblivious to what said type actually is.
> +
> +Declaring and initializing a list
> +---------------------------------
> +
> +A doubly-linked list can then be declared as just another ``struct list_head``,
> +and initialised with the LIST_HEAD_INIT() macro during initial assignment, or

       initialized
just be be consistent with this document file. (Yes, I know that we accept either
spelling, but we could at least be consistent within one file.)

In <linux/list.h>, I see that INIT_LIST_HEAD() has kernel-doc comments.
Would you mind adding kernel-doc for LIST_HEAD() and LIST_HEAD_INIT()
in the header file?  (separate patch, not in this patch)

I checked the entire linux/list.h file: all other functions and macros
have kernel-doc except for ones that begin with __, which are intended
for internal use (primarily).

> +with the INIT_LIST_HEAD() function later:
> +
> +.. code-block:: c
> +
> +  struct clown_car {
> +          int tyre_pressure[4];
> +          struct list_head clowns;        /* Looks like a node! */

Looks like a node because it is at the same struct offset as 'node'.
Right? I think it would be good to add something like:
  The struct list_head in both structures has to be at the same offset
  (for container_of() to work correctly).


> +  };
> +
> +  /* ... Somewhere later in our driver ... */
> +

struct circus_priv is not described because it doesn't matter?


> +  static int circus_init(struct circus_priv *circus)
> +  {
> +          struct clown_car other_car = {
> +                .tyre_pressure = {10, 12, 11, 9},
> +                .clowns = LIST_HEAD_INIT(other_car.clowns)
> +          };
> +
> +          circus->car.clowns = INIT_LIST_HEAD(&circus->car.clowns);

syntax error; just use
		INIT_LIST_HEAD(&circus->car.clowns);

> +
> +          return 0;
> +  }
> +
> +A further point of confusion to some may be that the list itself doesn't really
> +have its own type. The concept of the entire linked list and a
> +``struct list_head`` member that points to other entries in the list are one and
> +the same.
> +
> +Adding nodes to the list
> +------------------------
> +
> +Adding a node to the linked list is done through the list_add() function.
> +
> +We'll return to our clown car example to illustrate how nodes get added to the
> +list:
> +
> +.. code-block:: c
> +
> +  static int circus_fill_car(struct circus_priv *circus)
> +  {
> +          struct clown_car *car = &circus->car;
> +          struct clown *grock;
> +          struct clown *dimitri;
> +
> +          /* State 1 */
> +
> +          grock = kzalloc(sizeof(*grock), GFP_KERNEL);
> +          if (!grock)
> +                  return -ENOMEM;
> +          grock->name = "Grock";
> +          grock->shoe_size = 1000;
> +
> +          /* Note that we're adding the "node" member */
> +          list_add(&grock->node, &car->clowns);
> +
> +          /* State 2 */
> +
> +          dimitri = kzalloc(sizeof(*dimitri), GFP_KERNEL);
> +          if (!dimitri)
> +                  return -ENOMEM;
> +          dimitri->name = "Dimitri";
> +          dimitri->shoe_size = 50;
> +
> +          list_add(&dimitri->node, &car->clowns);
> +
> +          /* State 3 */
> +
> +          return 0;
> +  }
> +
> +In State 1, our list of clowns is still empty::
> +
> +         .------.
> +         v      |
> +    .--------.  |
> +    | clowns |--'
> +    '--------'
> +
> +This diagram shows the singular "clowns" node pointing at itself. In this
> +diagram, and all following diagrams, only the forward edges are shown, to aid in
> +clarity.
> +
> +In State 2, we've added Grock after the list head::
> +
> +         .--------------------.
> +         v                    |
> +    .--------.     .-------.  |
> +    | clowns |---->| Grock |--'
> +    '--------'     '-------'
> +
> +This diagram shows the "clowns" node pointing at a new node labeled "Grock".
> +The Grock node is pointing back at the "clowns" node.
> +
> +In State 3, we've added Dimitri after the list head, resulting in the following::
> +
> +         .------------------------------------.
> +         v                                    |
> +    .--------.     .---------.     .-------.  |
> +    | clowns |---->| Dimitri |---->| Grock |--'
> +    '--------'     '---------'     '-------'
> +
> +This diagram shows the "clowns" node pointing at a new node labeled "Dimitri",
> +which then points at the node labeled "Grock". The "Grock" node still points
> +back at the "clowns" node.
> +
> +If we wanted to have Dimitri inserted at the end of the list instead, we'd use
> +list_add_tail(). Our code would then look like this:
> +
> +.. code-block:: c
> +
> +  static int circus_fill_car(struct circus_priv *circus)
> +  {
> +          /* ... */
> +
> +          list_add_tail(&dimitri->node, &car->clowns);
> +
> +          /* State 3b */
> +
> +          return 0;
> +  }
> +
> +This results in the following list::
> +
> +         .------------------------------------.
> +         v                                    |
> +    .--------.     .-------.     .---------.  |
> +    | clowns |---->| Grock |---->| Dimitri |--'
> +    '--------'     '-------'     '---------'
> +
> +This diagram shows the "clowns" node pointing at the node labeled "Grock",
> +which points at the new node labeled "Dimitri". The node labeled "Dimitri"
> +points back at the "clowns" node.
> +
> +Traversing the list
> +-------------------
> +
> +To iterate the list, we can loop through all nodes within the list with
> +list_for_each().
> +
> +In our clown example, this results in the following somewhat awkward code:
> +
> +.. code-block:: c
> +
> +  static unsigned long long circus_get_max_shoe_size(struct circus_priv *circus)
> +  {
> +          unsigned long long res = 0;
> +          struct clown *e;
> +          struct list_head *cur;
> +
> +          list_for_each(cur, &circus->car.clowns) {
> +                  e = list_entry(cur, struct clown, node);
> +                  if (e->shoe_size > res)
> +                          res = e->shoe_size;
> +          }
> +
> +          return res;
> +  }
> +
> +Note how the additional ``list_entry`` call is a little awkward here. It's only
> +there because we're iterating through the ``node`` members, but we really want
> +to iterate through the payload, i.e. the ``struct clown`` that contains each
> +node's ``struct list_head``. For this reason, there is a second macro:
> +list_for_each_entry()
> +
> +Using it would change our code to something like this:
> +
> +.. code-block:: c
> +
> +  static unsigned long long circus_get_max_shoe_size(struct circus_priv *circus)
> +  {
> +          unsigned long long res = 0;
> +          struct clown *e;
> +
> +          list_for_each_entry(e, &circus->car.clowns, node) {
> +                  if (e->shoe_size > res)
> +                          res = e->shoe_size;
> +          }
> +
> +          return res;
> +  }
> +
> +This eliminates the need for the ``list_entry`` step, and our loop cursor is now
> +of the type of our payload. The macro is given the member name that corresponds
> +to the list's ``struct list_head`` within the clown struct so that it can still
> +walk the list.
> +
> +Removing nodes from the list
> +----------------------------
> +
> +The list_del() function can be used to remove entries from the list. It not only
> +removes the given entry from the list, but poisons the entry's ``prev`` and
> +``next`` pointers, so that unintended use of the entry after removal does not
> +go unnoticed.
> +
> +We can extend our previous example to remove one of the entries:
> +
> +.. code-block:: c
> +
> +  static int circus_fill_car(struct circus_priv *circus)
> +  {
> +          /* ... */
> +
> +          list_add(&dimitri->node, &car->clowns);
> +
> +          /* State 3 */
> +
> +          list_del(&dimitri->node);
> +
> +          /* State 4 */
> +
> +          return 0;
> +  }
> +
> +The result of this would be this::
> +
> +         .--------------------.
> +         v                    |
> +    .--------.     .-------.  |      .---------.
> +    | clowns |---->| Grock |--'      | Dimitri |
> +    '--------'     '-------'         '---------'
> +
> +This diagram shows the "clowns" node pointing at the node labeled "Grock",
> +which points back at the "clowns" node. Off to the side is a lone node labeled
> +"Dimitri", which has no arrows pointing anywhere.
> +
> +Note how the Dimitri node does not point to itself; its pointers are
> +intentionally set to a "poison" value that the list code refuses to traverse.
> +
> +If we wanted to reinitialize the removed node instead to make it point at itself
> +again like an empty list head, we can use list_del_init() instead:
> +
> +.. code-block:: c
> +
> +  static int circus_fill_car(struct circus_priv *circus)
> +  {
> +          /* ... */
> +
> +          list_add(&dimitri->node, &car->clowns);
> +
> +          /* State 3 */
> +
> +          list_del_init(&dimitri->node);
> +
> +          /* State 4b */
> +
> +          return 0;
> +  }
> +
> +This results in the deleted node pointing to itself again::
> +
> +         .--------------------.           .-------.
> +         v                    |           v       |
> +    .--------.     .-------.  |      .---------.  |
> +    | clowns |---->| Grock |--'      | Dimitri |--'
> +    '--------'     '-------'         '---------'
> +
> +This diagram shows the "clowns" node pointing at the node labeled "Grock",
> +which points back at the "clowns" node. Off to the side is a lone node labeled
> +"Dimitri", which points to itself.
> +
> +Traversing whilst removing nodes
> +--------------------------------
> +
> +Deleting entries while we're traversing the list will cause problems if we use
> +list_for_each() and list_for_each_entry(), as deleting the current entry would
> +modify the ``next`` pointer of it, which means the traversal can't properly
> +advance to the next list entry.
> +
> +There is a solution to this however: list_for_each_safe() and
> +list_for_each_entry_safe(). These take an additional parameter of a pointer to
> +a ``struct list_head`` to use as temporary storage for the next entry during,

drop comma above.

> +iteration, solving the issue.
> +
> +An example of how to use it:
> +
> +.. code-block:: c
> +
> +  static void circus_eject_insufficient_clowns(struct circus_priv *circus)
> +  {
> +          struct clown *e;
> +          struct clown *n;      /* temporary storage for safe iteration */
> +
> +          list_for_each_entry_safe(e, n, &circus->car.clowns, node) {
> +                if (e->shoe_size < 500)
> +                        list_del(&e->node);
> +          }
> +  }
> +
> +Proper memory management (i.e. freeing the deleted node while making sure
> +nothing still references it) in this case is left up as an exercise to the

s/up //
(or is that a British thing?)

> +reader.
> +
> +Cutting a list
> +--------------
> +
> +There are two helper functions to cut lists with. Both take elements from the
> +list ``head``, and replace the contents of the list ``list``.
> +
> +The first such function is list_cut_position(). It removes all list entries from
> +``head`` up to and including ``entry``, placing them in ``list`` instead.
> +
> +In this example, it's assumed we start with the following list::
> +
> +         .----------------------------------------------------------------.
> +         v                                                                |
> +    .--------.     .-------.     .---------.     .-----.     .---------.  |
> +    | clowns |---->| Grock |---->| Dimitri |---->| Pic |---->| Alfredo |--'
> +    '--------'     '-------'     '---------'     '-----'     '---------'
> +
> +This diagram depicts the list head "clowns" pointing to a node labeled "Grock",
> +which points to a node labeled "Dimitri", which points to a node labeled
> +"Pic", which points to a node labeled "Alfredo", which points back to the
> +"clowns" list head.
> +
> +With the following code, every clown up to and including "Pic" is moved from
> +the "clowns" list head to a separate ``struct list_head`` initialized at local
> +stack variable ``retirement``:
> +
> +.. code-block:: c
> +
> +  static void circus_retire_clowns(struct circus_priv *circus)
> +  {
> +          struct list_head retirement = LIST_HEAD_INIT(retirement);
> +          struct clown *grock, *dimitri, *pic, *alfredo;
> +          struct clown_car *car = &circus->car;
> +
> +          /* ... clown initialization, list adding ... */
> +
> +          list_cut_position(&retirement, &car->clowns, &pic->node);
> +
> +          /* State 1 */
> +  }
> +
> +The resulting ``car->clowns`` list would be this::
> +
> +         .----------------------.
> +         v                      |
> +    .--------.     .---------.  |
> +    | clowns |---->| Alfredo |--'
> +    '--------'     '---------'
> +
> +This diagram depicts the "clowns" list head at State 1, with "clowns" pointing
> +to a node labeled "Alfredo", which points back at the "clowns" list head.
> +
> +Meanwhile, the ``retirement`` list is transformed to the following::
> +
> +           .--------------------------------------------------.
> +           v                                                  |
> +    .------------.     .-------.     .---------.     .-----.  |
> +    | retirement |---->| Grock |---->| Dimitri |---->| Pic |--'
> +    '------------'     '-------'     '---------'     '-----'
> +
> +This diagram depicts the list head "retirement" at State 1, with "retirement"
> +pointing to a node labeled "Grock", which points to a node labeled "Dimitri",
> +which in turn points to a node labeled "Pic", which finally points back to the
> +"retirement" list head.
> +
> +The second function, list_cut_before(), is much the same, except it cuts before
> +the ``entry`` node, i.e. it removes all list entries from ``head`` up to but
> +excluding ``entry``, placing them in ``list`` instead. This example assumes the
> +same initial starting list as the previous example:
> +
> +.. code-block:: c
> +
> +  static void circus_retire_clowns(struct circus_priv *circus)
> +  {
> +          struct list_head retirement = LIST_HEAD_INIT(retirement);
> +          struct clown *grock, *dimitri, *pic, *alfredo;
> +          struct clown_car *car = &circus->car;
> +
> +          /* ... clown initialization, list adding ... */
> +
> +          list_cut_before(&retirement, &car->clowns, &pic->node);
> +
> +          /* State 1b */
> +  }
> +
> +The resulting ``car->clowns`` list would be this::
> +
> +         .----------------------------------.
> +         v                                  |
> +    .--------.     .-----.     .---------.  |
> +    | clowns |---->| Pic |---->| Alfredo |--'
> +    '--------'     '-----'     '---------'
> +
> +This diagram depicts the "clowns" list head at State 1b, with "clowns" pointing
> +to a node labeled "Pic", which in turn points to a node labeled "Alfredo",
> +which points back at the "clowns" list head.
> +
> +Meanwhile, the ``retirement`` list is transformed to the following::
> +
> +           .--------------------------------------.
> +           v                                      |
> +    .------------.     .-------.     .---------.  |
> +    | retirement |---->| Grock |---->| Dimitri |--'
> +    '------------'     '-------'     '---------'
> +
> +This diagram depicts the "retirement" list at State 1b, with the "retirement"
> +list head pointing at a node labeled "Grock", which in turn points at a node
> +labeled "Dimitri", which finally points back at the "retirement" list head.
> +
> +It should be noted that both functions will destroy links to any existing nodes
> +in the destination ``struct list_head *list``.
> +
> +Moving entries and partial lists
> +--------------------------------
> +
> +The list_move() and list_move_tail() functions can be used to move an entry
> +from one list to another, to either the start or end respectively.
> +
> +In the following example, we'll assume we start with two lists ("clowns" and
> +"sidewalk" in the following initial state "State 0"::
> +
> +         .----------------------------------------------------------------.
> +         v                                                                |
> +    .--------.     .-------.     .---------.     .-----.     .---------.  |
> +    | clowns |---->| Grock |---->| Dimitri |---->| Pic |---->| Alfredo |--'
> +    '--------'     '-------'     '---------'     '-----'     '---------'
> +
> +          .-------------------.
> +          v                   |
> +    .----------.     .-----.  |
> +    | sidewalk |---->| Pio |--'
> +    '----------'     '-----'
> +
> +This diagram depicts two list heads. The first, "clowns", points to a node
> +labeled "Grock", which points to a node labeled "Dimitri", which points to a
> +node labeled "Pic", which points to a node labeled "Alfredo", which points
> +back at the list head "clowns". The second list head, "sidewalk", points to a
> +node labeled "Pio", which points back to the "sidewalk" list head.
> +
> +We apply the following example code to the two lists:
> +
> +.. code-block:: c
> +
> +  static void circus_clowns_exit_car(struct circus_priv *circus)
> +  {
> +          struct list_head sidewalk = LIST_HEAD_INIT(sidewalk);
> +          struct clown *grock, *dimitri, *pic, *alfredo, *pio;
> +          struct clown_car *car = &circus->car;
> +
> +          /* ... clown initialization, list adding ... */
> +
> +          /* State 0 */
> +
> +          list_move(&pic->node, &sidewalk);
> +
> +          /* State 1 */
> +
> +          list_move_tail(&dimitri->node, &sidewalk);
> +
> +          /* State 2 */
> +  }
> +
> +In State 1, we arrive at the following situation::
> +
> +        .-----------------------------------------------------.
> +        |                                                     |
> +        v                                                     |
> +    .--------.     .-------.     .---------.     .---------.  |
> +    | clowns |---->| Grock |---->| Dimitri |---->| Alfredo |--'
> +    '--------'     '-------'     '---------'     '---------'
> +
> +          .-------------------------------.
> +          v                               |
> +    .----------.     .-----.     .-----.  |
> +    | sidewalk |---->| Pic |---->| Pio |--'
> +    '----------'     '-----'     '-----'
> +
> +This diagram depicts two list heads. The first, "clowns", points to a node
> +labeled "Grock", which points to a node labeled "Dimitri", which points to a
> +node labeled "Alfredo", which points back to the list head "clowns". The node
> +labeled "Pic" is no longer part of the "clowns" list. The second list head,
> +"sidewalk", points to a node labeled "Pic", which points to a node labeled
> +"Pio", which points back to the "sidewalk" list head.
> +
> +In State 2, after we've moved Dimitri to the tail of sidewalk, the situation
> +changes as follows::
> +
> +        .-------------------------------------.
> +        |                                     |
> +        v                                     |
> +    .--------.     .-------.     .---------.  |
> +    | clowns |---->| Grock |---->| Alfredo |--'
> +    '--------'     '-------'     '---------'
> +
> +          .-----------------------------------------------.
> +          v                                               |
> +    .----------.     .-----.     .-----.     .---------.  |
> +    | sidewalk |---->| Pic |---->| Pio |---->| Dimitri |--'
> +    '----------'     '-----'     '-----'     '---------'
> +
> +This diagram depicts two list heads. The first, "clowns", points to a node
> +labeled "Grock", which points to a node labeled "Alfredo", which points back
> +to the list head "clowns". The node labeled "Dimitri" is no longer part of the
> +"clowns" list. The second list head, "sidewalk", points to a node labeled
> +"Pic", which points to a node labeled "Pio", which points to a node labeled
> +"Dimitri", which points back to the "sidewalk" list head.
> +
> +As long as the source and destination list head are part of the same list, we
> +can also efficiently bulk move a segment of the list to the tail end of the
> +list. We continue the previous example by adding a list_bulk_move_tail() after
> +State 2, moving Pic and Pio to the tail end of the sidewalk list.
> +
> +.. code-block:: c
> +
> +  static void circus_clowns_exit_car(struct circus_priv *circus)
> +  {
> +          struct list_head sidewalk = LIST_HEAD_INIT(sidewalk);
> +          struct clown *grock, *dimitri, *pic, *alfredo, *pio;
> +          struct clown_car *car = &circus->car;
> +
> +          /* ... clown initialization, list adding ... */
> +
> +          /* State 0 */
> +
> +          list_move(&pic->node, &sidewalk);
> +
> +          /* State 1 */
> +
> +          list_move_tail(&dimitri->node, &sidewalk);
> +
> +          /* State 2 */
> +
> +          list_bulk_move_tail(&sidewalk, &pic->node, &pio->node);
> +
> +          /* State 3 */
> +  }
> +
> +For the sake of brevity, only the altered "sidewalk" list at State 3 is depicted
> +in the following diagram::
> +
> +          .-----------------------------------------------.
> +          v                                               |
> +    .----------.     .---------.     .-----.     .-----.  |
> +    | sidewalk |---->| Dimitri |---->| Pic |---->| Pio |--'
> +    '----------'     '---------'     '-----'     '-----'
> +
> +This diagram depicts a list head "sidewalk". It points to at node labeled
> +"Dimitri", which points to a node labeled "Pic", which points to a node
> +labeled "Pio", which points back to the list head "sidewalk".
> +
> +Do note that list_bulk_move_tail() does not do any checking as to whether all
> +three supplied ``struct list_head *`` parameters really do belong to the same
> +list. If you use it outside the constraints the documentation gives, then the
> +result is a matter between you and the implementation.
> +
> +Rotating entries
> +----------------
> +
> +A common write operation on lists, especially when using them as queues, is
> +to rotate it. A list rotation means entries at the front are sent to the back.
> +
> +For rotation, Linux provides us with two functions: list_rotate_left() and
> +list_rotate_to_front(). The former can be pictured like a bicycle chain, taking
> +the entry after the supplied ``struct list_head *`` and moving it to the tail,
> +which in essence means the entire list, due to its circular nature, rotates by
> +one position.
> +
> +The latter, list_rotate_to_front(), takes the same concept one step further:
> +instead of advancing the list by one entry, it advances it *until* the specified
> +entry is the new front.
> +
> +In the following example, our starting state, State 0, is the following::
> +
> +         .-----------------------------------------------------------------.
> +         v                                                                 |
> +    .--------.   .-------.   .---------.   .-----.   .---------.   .-----. |
> +    | clowns |-->| Grock |-->| Dimitri |-->| Pic |-->| Alfredo |-->| Pio |-'
> +    '--------'   '-------'   '---------'   '-----'   '---------'   '-----'
> +
> +This diagram depicts a list head "clowns". It points to a node labeled "Grock",
> +which points to a node labeled "Dimitri", which points to a node labeled
> +"Pic", which points to a node labeled "Alfredo", which points to a node
> +labeled "Pio", which finally points back to the "clowns" list head.
> +
> +The example code being used to demonstrate list rotations is the following:
> +
> +.. code-block:: c
> +
> +  static void circus_clowns_rotate(struct circus_priv *circus)
> +  {
> +          struct clown *grock, *dimitri, *pic, *alfredo, *pio;
> +          struct clown_car *car = &circus->car;
> +
> +          /* ... clown initialization, list adding ... */
> +
> +          /* State 0 */
> +
> +          list_rotate_left(&car->clowns);
> +
> +          /* State 1 */
> +
> +          list_rotate_to_front(&alfredo->node, &car->clowns);
> +
> +          /* State 2 */
> +
> +  }
> +
> +In State 1, we arrive at the following situation::
> +
> +         .-----------------------------------------------------------------.
> +         v                                                                 |
> +    .--------.   .---------.   .-----.   .---------.   .-----.   .-------. |
> +    | clowns |-->| Dimitri |-->| Pic |-->| Alfredo |-->| Pio |-->| Grock |-'
> +    '--------'   '---------'   '-----'   '---------'   '-----'   '-------'
> +
> +This diagram depicts a list head "clowns". It points to a node labeled
> +"Dimitri", which points to a node labeled "Pic", which points to a node
> +labeled "Alfredo", which points to a node labeled "Pio", which points to a
> +note labeled "Grock", which finally points back to the "clowns" list head.
> +
> +Next, after the list_rotate_to_front() call, we arrive in the following
> +State 2::
> +
> +         .-----------------------------------------------------------------.
> +         v                                                                 |
> +    .--------.   .---------.   .-----.   .-------.   .---------.   .-----. |
> +    | clowns |-->| Alfredo |-->| Pio |-->| Grock |-->| Dimitri |-->| Pic |-'
> +    '--------'   '---------'   '-----'   '-------'   '---------'   '-----'
> +
> +This diagram depicts a list head "clowns". It points to a node labeled
> +"Alfredo", which points to a node labeled "Pio", which points to a node
> +labeled "Grock", which points to a node labeled "Dimitri", which points to a
> +node labeled "Pic", which then finally points back to the "clowns" list head.
> +
> +As is hopefully evident from the diagrams, the entries in front of "Alfredo"
> +were cycled to the tail end of the list.
> +
> +Swapping entries
> +----------------
> +
> +Another common operation is that two entries need to be swapped with each other.
> +
> +For this, Linux provides us with list_swap().
> +
> +In the following example, we have a list with three entries, and swap two of
> +them. This is our starting state in "State 0"::
> +
> +         .-----------------------------------------.
> +         v                                         |
> +    .--------.   .-------.   .---------.   .-----. |
> +    | clowns |-->| Grock |-->| Dimitri |-->| Pic |-'
> +    '--------'   '-------'   '---------'   '-----'
> +
> +This diagram depicts a list head "clowns". It points to a node labeled "Grock",
> +which points to a node labeled "Dimitri", which points to a node labeled
> +"Pic", which finally points back to the "clowns" list head.
> +
> +.. code-block:: c
> +
> +  static void circus_clowns_swap(struct circus_priv *circus)
> +  {
> +          struct clown *grock, *dimitri, *pic;
> +          struct clown_car *car = &circus->car;
> +
> +          /* ... clown initialization, list adding ... */
> +
> +          /* State 0 */
> +
> +          list_swap(&dimitri->node, &pic->node);
> +
> +          /* State 1 */
> +  }
> +
> +The resulting list at State 1 is the following::
> +
> +         .-----------------------------------------.
> +         v                                         |
> +    .--------.   .-------.   .-----.   .---------. |
> +    | clowns |-->| Grock |-->| Pic |-->| Dimitri |-'
> +    '--------'   '-------'   '-----'   '---------'
> +
> +This diagram depicts a list head "clowns". It points to a node labeled "Grock",
> +which points to a node labeled "Pic", which points to a node labeled
> +"Dimitri", which finally points back to the "clowns" list head.
> +
> +As is evident by comparing the diagrams, the "Pic" and "Dimitri" nodes have
> +traded places.
> +
> +Splicing two lists together
> +---------------------------
> +
> +Say we have two lists, in the following example one represented by a list head
> +we call "knie" and one we call "stey". In a hypothetical circus acquisition,
> +the two list of clowns should be spliced together. The following is our
> +situation in "State 0"::
> +
> +        .-----------------------------------------.
> +        |                                         |
> +        v                                         |
> +    .------.   .-------.   .---------.   .-----.  |
> +    | knie |-->| Grock |-->| Dimitri |-->| Pic |--'
> +    '------'   '-------'   '---------'   '-----'
> +
> +        .-----------------------------.
> +        v                             |
> +    .------.   .---------.   .-----.  |
> +    | stey |-->| Alfredo |-->| Pio |--'
> +    '------'   '---------'   '-----'
> +
> +This diagram depicts two lists. The first list_head, labeled "knie", points to
> +a node labeled "Grock", which points to a node labeled "Dimitri", which points
> +to a node labeled "Pic", which points back to the "knie" list head. The second
> +list_head, labeled "stey", points to a node labeled "Alfredo", which points to
> +a node labeled "Pio", which points back to the "stey" list head.
> +
> +The function to splice these two lists together is list_splice(). Our example
> +code is as follows:
> +
> +.. code-block:: c
> +
> +  static void circus_clowns_splice(void)
> +  {
> +          struct clown *grock, *dimitri, *pic, *alfredo, *pio;
> +          struct list_head knie = LIST_HEAD_INIT(knie);
> +          struct list_head stey = LIST_HEAD_INIT(stey);
> +
> +          /* ... Clown allocation and initialization here ... */
> +
> +          list_add_tail(&grock->node, &knie);
> +          list_add_tail(&dimitri->node, &knie);
> +          list_add_tail(&pic->node, &knie);
> +          list_add_tail(&alfredo->node, &stey);
> +          list_add_tail(&pio->node, &stey);
> +
> +          /* State 0 */
> +
> +          list_splice(&stey, &dimitri->node);
> +
> +          /* State 1 */
> +  }
> +
> +The list_splice() call here adds all the entries in ``stey`` to the list
> +``dimitri``'s ``node`` list_head is in, after the ``node`` of ``dimitri``. A
> +somewhat surprising diagram of the resulting "State 1" follows::
> +
> +        .-----------------------------------------------------------------.
> +        |                                                                 |
> +        v                                                                 |
> +    .------.   .-------.   .---------.   .---------.   .-----.   .-----.  |
> +    | knie |-->| Grock |-->| Dimitri |-->| Alfredo |-->| Pio |-->| Pic |--'
> +    '------'   '-------'   '---------'   '---------'   '-----'   '-----'
> +                                              ^
> +              .-------------------------------'
> +              |
> +    .------.  |
> +    | stey |--'
> +    '------'
> +
> +This diagram depicts a list_head labeled "knie". It points at a node labeled
> +"Grock", which points at a node labeled "Dimitri", which points at a node
> +labeled "Alfredo", which points at a node labeled "Pio", which points at a
> +node labeled "Pic", which points back at the "knie" list head. A second list
> +head labeled "stey" still exists. It points at the "Alfredo" node which is now
> +part of the "knie" list.
> +
> +Traversing the ``stey`` list no longer results in correct behavior. A call of
> +list_for_each() on ``stey`` results in an infinite loop, as it never returns
> +back to the ``stey`` list head.
> +
> +This is because list_splice() did not reinitialize the list_head it took
> +entries from, leaving its pointer pointing into what is now a different list.
> +
> +If we want to avoid this situation, list_splice_init() can be used. It does the
> +same thing as list_splice(), except reinitalizes the donor list_head after the
> +transplant.
> +
> +Concurrency considerations
> +--------------------------
> +
> +Concurrent access and modification of a list needs to be protected with a lock
> +in most cases. Alternatively and preferably, one may use the RCU primitives for
> +lists in read-mostly use-cases, where read accesses to the list are common but
> +modifications to the list less so. See Documentation/RCU/listRCU.rst for more
> +details.
> +
> +Further reading
> +---------------
> +
> +* `How does the kernel implements Linked Lists? - KernelNewbies <https://kernelnewbies.org/FAQ/LinkedLists>`_
> 
> ---
> base-commit: f304c25980ae6d101faa62a9dcc1ddeed260bd38
> change-id: 20250520-linked-list-docs-ce5b956d4602
> 
> Best regards,

-- 
~Randy


