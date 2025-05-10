Return-Path: <linux-kernel+bounces-642593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFCBAB20C9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 May 2025 03:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4305E4A8032
	for <lists+linux-kernel@lfdr.de>; Sat, 10 May 2025 01:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D1A23A9BE;
	Sat, 10 May 2025 01:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="khDfseoT"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D701E2852
	for <linux-kernel@vger.kernel.org>; Sat, 10 May 2025 01:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746840934; cv=none; b=lKzyYI3IQzRYIS73QcsouUejPCDdMOMGfh7Sae5SuL80koEHEgVODLhM6ldu0J7oTJOyDm7OQh78h+bkzNq3tM5U7Jxql8ugfGz9G9s6LZXYmy/MsNjVWNf8YnbMWnViLo0aBW70aAK0PBrtowGxLOAHVBGx7e/ViEcR7yXBpok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746840934; c=relaxed/simple;
	bh=qYL6xyOqlNHmEcHUDFX8KOgZK5j+gI/KYlgKxttQ6oE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SFZKfHEtqGahghSYtigIf7VE7/oRQtt3pN1FoAD40ZbQp3oyzJTyJBoHjVUiTy5ZIvRcP1khwu5ROw6sDMj1k66CcrXbiGGontDGdqjpxBjixCrGuu5RZCRQ/oMZOfEw5UOvOASnLsSr2pEtqhAvJFxCQZtAKTbfkZlv9Ff2tH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=khDfseoT; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-af8e645a1d1so1836725a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 May 2025 18:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746840932; x=1747445732; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5yAdwYPk/dHZyDlGWX3uSFrKaKPhopB8djZyrRSb7PU=;
        b=khDfseoTvTT3kXrdsC20c1cpSGamtnz9jSLhfzejkzX7o4S8pM9FhblX1C744RVIt2
         lCjTrhUxm8dVclMLCt82sHfEupfEpUTMFAppojmt2HlEgk7vkq4uN6ZzRoLebAF0pGxQ
         kQAkSR2/HdA43DZ7BR/6Po9Vtv5KP+T+DvkqfQ/57UQsFtdNVp6EKG6tVmk7hauuZSVC
         CqDVVkL9ZQm4vIc3dykv88bZ66NgZ2VKoyQYnxBYE8IC992MYugC9w/Zzq/VAW6HaawE
         GEluWSTbm+Jy7o6bRafSk61yrauEEhdF26V+5rJr4CXumaHWehb9F1Dvsc5r1t4Podjw
         qrug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746840932; x=1747445732;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5yAdwYPk/dHZyDlGWX3uSFrKaKPhopB8djZyrRSb7PU=;
        b=ICeJ7ZhPRom4H31n1KwZei50yotsdVkl/b6wUGXxCHCUu9SWeXx4kB6yjuYi9ux2Gu
         qqgJpsOn2H7ai0mk9qku3MWkRvRNoAEXQBM0hBRySP/DhEj/jWQv8wDRvibNfC4MYGMx
         VDxu3Grn254OaJIQHTpCagALGBIvI8VjA+UPxPonLTd1gFWsaTz8j8ACpbfr3myjxhoZ
         h32v3PFa0Og33G4IzTYTpcrel9ofIcvurcM0//bs/d9O17xSaR1ugQ/shs0wmmVP1HCn
         7VyMezEs7FNh/a19QV4TszNEwbMmcSuCwMEPz7MK3+yMT6gvY1PwYbBb5WJPlh86zyvE
         qFRw==
X-Gm-Message-State: AOJu0Yx6XBiJsdupr3QiyAtqSgzWMvkJ5YDEW2D/iHz8y2Zt8hJaLw2/
	ihb3wNqATPt2Ey0WybJzSoCPJa08fsAlatqXIvXI+cUoWOmPZ6C+33DIkgKy9MVwumZxJlP+g3k
	v5Qz/Ag==
X-Google-Smtp-Source: AGHT+IHj8I99VpkIkOinLBR3j9BXDkBx5q4u9/CEOgXjmOYZOuwXRSG+CGfNT77V8oZURU/zx+VvFmqqKEAf
X-Received: from pjbsm8.prod.google.com ([2002:a17:90b:2e48:b0:2fc:c98:ea47])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1844:b0:30a:4ce4:5287
 with SMTP id 98e67ed59e1d1-30c3b8fea1bmr11625120a91.0.1746840932310; Fri, 09
 May 2025 18:35:32 -0700 (PDT)
Date: Sat, 10 May 2025 01:34:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250510013435.1520671-5-ynaffit@google.com>
Subject: [PATCH v4 1/2] binder: Refactor binder_node print synchronization
From: "Tiffany Y. Yang" <ynaffit@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

The binder driver outputs information about each dead binder node by
iterating over the dead nodes list, and it prints the state of each live
node in the system by traversing each binder_proc's proc->nodes tree.
Both cases require similar logic to maintain the global lock ordering
while accessing each node.

Create a helper function to synchronize around printing binder nodes in
a list. Opportunistically make minor cosmetic changes to binder print
functions.

Acked-by: Carlos Llamas <cmllamas@google.com>
Signed-off-by: Tiffany Y. Yang <ynaffit@google.com>
---
v2:
* Updated print_next_binder_node_ilocked function comment to reflect
  dropped locks
* Added acked-by tag
v4:
* Specify binder_proc to re-lock on instead of using node->proc to avoid
  error from race with binder_node_release that Alice pointed out

---
 drivers/android/binder.c | 119 ++++++++++++++++++++++-----------------
 1 file changed, 68 insertions(+), 51 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 5fc2c8ee61b1..8e4912643749 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6377,10 +6377,10 @@ static void print_binder_transaction_ilocked(struct seq_file *m,
 }
 
 static void print_binder_work_ilocked(struct seq_file *m,
-				     struct binder_proc *proc,
-				     const char *prefix,
-				     const char *transaction_prefix,
-				     struct binder_work *w)
+				      struct binder_proc *proc,
+				      const char *prefix,
+				      const char *transaction_prefix,
+				      struct binder_work *w)
 {
 	struct binder_node *node;
 	struct binder_transaction *t;
@@ -6430,7 +6430,7 @@ static void print_binder_work_ilocked(struct seq_file *m,
 
 static void print_binder_thread_ilocked(struct seq_file *m,
 					struct binder_thread *thread,
-					int print_always)
+					bool print_always)
 {
 	struct binder_transaction *t;
 	struct binder_work *w;
@@ -6505,8 +6505,53 @@ static void print_binder_ref_olocked(struct seq_file *m,
 	binder_node_unlock(ref->node);
 }
 
-static void print_binder_proc(struct seq_file *m,
-			      struct binder_proc *proc, int print_all)
+/**
+ * print_next_binder_node_ilocked() - Print binder_node from a locked list
+ * @m:          struct seq_file for output via seq_printf()
+ * @proc:       struct binder_proc we hold the inner_proc_lock to (if any)
+ * @node:       struct binder_node to print fields of
+ * @prev_node:	struct binder_node we hold a temporary reference to (if any)
+ *
+ * Helper function to handle synchronization around printing a struct
+ * binder_node while iterating through @proc->nodes or the dead nodes list.
+ * Caller must hold either @proc->inner_lock (for live nodes) or
+ * binder_dead_nodes_lock. This lock will be released during the body of this
+ * function, but it will be reacquired before returning to the caller.
+ *
+ * Return:	pointer to the struct binder_node we hold a tmpref on
+ */
+static struct binder_node *
+print_next_binder_node_ilocked(struct seq_file *m, struct binder_proc *proc,
+			       struct binder_node *node,
+			       struct binder_node *prev_node)
+{
+	/*
+	 * Take a temporary reference on the node so that isn't freed while
+	 * we print it.
+	 */
+	binder_inc_node_tmpref_ilocked(node);
+	/*
+	 * Live nodes need to drop the inner proc lock and dead nodes need to
+	 * drop the binder_dead_nodes_lock before trying to take the node lock.
+	 */
+	if (proc)
+		binder_inner_proc_unlock(proc);
+	else
+		spin_unlock(&binder_dead_nodes_lock);
+	if (prev_node)
+		binder_put_node(prev_node);
+	binder_node_inner_lock(node);
+	print_binder_node_nilocked(m, node);
+	binder_node_inner_unlock(node);
+	if (proc)
+		binder_inner_proc_lock(proc);
+	else
+		spin_lock(&binder_dead_nodes_lock);
+	return node;
+}
+
+static void print_binder_proc(struct seq_file *m, struct binder_proc *proc,
+			      bool print_all)
 {
 	struct binder_work *w;
 	struct rb_node *n;
@@ -6519,31 +6564,18 @@ static void print_binder_proc(struct seq_file *m,
 	header_pos = m->count;
 
 	binder_inner_proc_lock(proc);
-	for (n = rb_first(&proc->threads); n != NULL; n = rb_next(n))
+	for (n = rb_first(&proc->threads); n; n = rb_next(n))
 		print_binder_thread_ilocked(m, rb_entry(n, struct binder_thread,
 						rb_node), print_all);
 
-	for (n = rb_first(&proc->nodes); n != NULL; n = rb_next(n)) {
+	for (n = rb_first(&proc->nodes); n; n = rb_next(n)) {
 		struct binder_node *node = rb_entry(n, struct binder_node,
 						    rb_node);
 		if (!print_all && !node->has_async_transaction)
 			continue;
 
-		/*
-		 * take a temporary reference on the node so it
-		 * survives and isn't removed from the tree
-		 * while we print it.
-		 */
-		binder_inc_node_tmpref_ilocked(node);
-		/* Need to drop inner lock to take node lock */
-		binder_inner_proc_unlock(proc);
-		if (last_node)
-			binder_put_node(last_node);
-		binder_node_inner_lock(node);
-		print_binder_node_nilocked(m, node);
-		binder_node_inner_unlock(node);
-		last_node = node;
-		binder_inner_proc_lock(proc);
+		last_node = print_next_binder_node_ilocked(m, proc, node,
+							   last_node);
 	}
 	binder_inner_proc_unlock(proc);
 	if (last_node)
@@ -6551,12 +6583,10 @@ static void print_binder_proc(struct seq_file *m,
 
 	if (print_all) {
 		binder_proc_lock(proc);
-		for (n = rb_first(&proc->refs_by_desc);
-		     n != NULL;
-		     n = rb_next(n))
+		for (n = rb_first(&proc->refs_by_desc); n; n = rb_next(n))
 			print_binder_ref_olocked(m, rb_entry(n,
-							    struct binder_ref,
-							    rb_node_desc));
+							     struct binder_ref,
+							     rb_node_desc));
 		binder_proc_unlock(proc);
 	}
 	binder_alloc_print_allocated(m, &proc->alloc);
@@ -6696,7 +6726,7 @@ static void print_binder_proc_stats(struct seq_file *m,
 	count = 0;
 	ready_threads = 0;
 	binder_inner_proc_lock(proc);
-	for (n = rb_first(&proc->threads); n != NULL; n = rb_next(n))
+	for (n = rb_first(&proc->threads); n; n = rb_next(n))
 		count++;
 
 	list_for_each_entry(thread, &proc->waiting_threads, waiting_thread_node)
@@ -6710,7 +6740,7 @@ static void print_binder_proc_stats(struct seq_file *m,
 			ready_threads,
 			free_async_space);
 	count = 0;
-	for (n = rb_first(&proc->nodes); n != NULL; n = rb_next(n))
+	for (n = rb_first(&proc->nodes); n; n = rb_next(n))
 		count++;
 	binder_inner_proc_unlock(proc);
 	seq_printf(m, "  nodes: %d\n", count);
@@ -6718,7 +6748,7 @@ static void print_binder_proc_stats(struct seq_file *m,
 	strong = 0;
 	weak = 0;
 	binder_proc_lock(proc);
-	for (n = rb_first(&proc->refs_by_desc); n != NULL; n = rb_next(n)) {
+	for (n = rb_first(&proc->refs_by_desc); n; n = rb_next(n)) {
 		struct binder_ref *ref = rb_entry(n, struct binder_ref,
 						  rb_node_desc);
 		count++;
@@ -6756,29 +6786,16 @@ static int state_show(struct seq_file *m, void *unused)
 	spin_lock(&binder_dead_nodes_lock);
 	if (!hlist_empty(&binder_dead_nodes))
 		seq_puts(m, "dead nodes:\n");
-	hlist_for_each_entry(node, &binder_dead_nodes, dead_node) {
-		/*
-		 * take a temporary reference on the node so it
-		 * survives and isn't removed from the list
-		 * while we print it.
-		 */
-		node->tmp_refs++;
-		spin_unlock(&binder_dead_nodes_lock);
-		if (last_node)
-			binder_put_node(last_node);
-		binder_node_lock(node);
-		print_binder_node_nilocked(m, node);
-		binder_node_unlock(node);
-		last_node = node;
-		spin_lock(&binder_dead_nodes_lock);
-	}
+	hlist_for_each_entry(node, &binder_dead_nodes, dead_node)
+		last_node = print_next_binder_node_ilocked(m, NULL, node,
+							   last_node);
 	spin_unlock(&binder_dead_nodes_lock);
 	if (last_node)
 		binder_put_node(last_node);
 
 	mutex_lock(&binder_procs_lock);
 	hlist_for_each_entry(proc, &binder_procs, proc_node)
-		print_binder_proc(m, proc, 1);
+		print_binder_proc(m, proc, true);
 	mutex_unlock(&binder_procs_lock);
 
 	return 0;
@@ -6807,7 +6824,7 @@ static int transactions_show(struct seq_file *m, void *unused)
 	seq_puts(m, "binder transactions:\n");
 	mutex_lock(&binder_procs_lock);
 	hlist_for_each_entry(proc, &binder_procs, proc_node)
-		print_binder_proc(m, proc, 0);
+		print_binder_proc(m, proc, false);
 	mutex_unlock(&binder_procs_lock);
 
 	return 0;
@@ -6822,7 +6839,7 @@ static int proc_show(struct seq_file *m, void *unused)
 	hlist_for_each_entry(itr, &binder_procs, proc_node) {
 		if (itr->pid == pid) {
 			seq_puts(m, "binder proc state:\n");
-			print_binder_proc(m, itr, 1);
+			print_binder_proc(m, itr, true);
 		}
 	}
 	mutex_unlock(&binder_procs_lock);
-- 
2.49.0.1045.g170613ef41-goog


