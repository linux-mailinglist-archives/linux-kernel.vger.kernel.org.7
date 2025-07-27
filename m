Return-Path: <linux-kernel+bounces-747227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BE6B1312F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 20:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 667D27A8618
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 18:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDB6224AF0;
	Sun, 27 Jul 2025 18:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M9HsAh0y"
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89101221FAE
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 18:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753641072; cv=none; b=ZGa2fLZ54+XYvd3qj2YPKcDusjnmUH/GbnGPSyU3IqNJ71EWANkWEtBLOJP8rVwv+FOZeED6fTKgRMC5AXFCy08/TTtQWQpcw+qKtz7ToxGSRXN8OblMO1pYCjrxbZjtJ78dOloqwlJLSgU2cM3O+4l1VD4VD6iw+XtwuuT1GOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753641072; c=relaxed/simple;
	bh=pgcoFaEO5e2jWlUnn8djk+glagmUEPUIlqDIRVPO+QQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pUYo+/zkaiOFe+p+eRr1BYfx4+SGCNmUXijtFrIrYcgI6Iw5zy5YUCzByTjVuDjJacgYX+0PtWe/yw66mgQJ7M/nz4guFWvvp8238oTCOHw4uGLbMhqAvOSvPkfBJLJY81XUex8IX0FDrg4lNnST5xro49ma0lx6uciSdj5+myc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M9HsAh0y; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7e333fae758so895844485a.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 11:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753641069; x=1754245869; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=07ZTFzAwI7AoDMGWdPj2CS/hPyS57ZZsGkQWvuCqmTo=;
        b=M9HsAh0y8QBa/suIRNwStk30y+BGInLXwPlziTkopurh88dwi7M4LvE9nGxvYS7UOx
         QBEP6IVrVs3Sj6EsUGFe7f59Qs4tXEYlVpnd+AQIsUMlR/fXpWKACSXQ794hM7k17esm
         yxd1BKp+Twyg+27DkYPjnI2xaatjutvvzd/lbOs8QxI7n+PDVEkE5lZSuehSYek4jJ5b
         13tG4PSDCRF2d/u96P+lR18NfD5UkBvB2RcLUOyVTAaTyvmr9lpAy1y2VwJi11VGSYk0
         ewwneAzlL8yzbH5AxJam3beQs19Zxeaniin/NumIMTZEURA6NFRJoCZSBiDmJUKjI9f+
         ldLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753641069; x=1754245869;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=07ZTFzAwI7AoDMGWdPj2CS/hPyS57ZZsGkQWvuCqmTo=;
        b=hiKz0RpJvNAsDpHU9DOe2NuQZYCb6YHz89c5AdIOD3H9OzHLBe289z9AYUSgtn06Zv
         NBI63cU4Nte7JuDuHf44+4sAp0EAbBOEXWBSCYaPftCQ1Z/2sGX+YvbvuZWW4POJD0jL
         DYBDL+2jHqHWjzx3A+tqqj6YJs3o+rbxskJTAJwlZ/STeP24RhFAMV19GmSDs4ywGlJw
         ux1VoiUikJas9RutMWxmVm0X3bexOWPXN2Tp5obrQv8YBEkE4lw+EIUU5Jz3zizg3Q3p
         1W5vPTulNjskmRwpHkvYxBrWrFddyAC+Oqdbk1el/MkKQfxieLOqgpKkbcs1Kz7Tt4ie
         DeKw==
X-Forwarded-Encrypted: i=1; AJvYcCXdONeSbVh5kPlSv/ClPQlfnX96A0gzVEZFAeoKLxdokNDZIgw9jAP+UjWWE3GyD29qptNKD4Qon5Dvtc0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7KLb2hjL5au/vctSRPZLfTA3VQn9bcRdgQ7HDcYbhpQRsZ6p8
	zHAphdgY15GH01MMaBlt/3mBexRvvYnlnqK5HKUTQ7xszWvYMape0V73r+/5Yv9AsfrDEZTyPjm
	3NdswYbkbwMCHjw==
X-Google-Smtp-Source: AGHT+IHjtGI0qmGHLUxczNbE1Waqr8gyN+H+qjHlOz0C8aMabStKlmQJl8rPJ9I4ADTEdjP00E3/3uglgauauQ==
X-Received: from pjqx22.prod.google.com ([2002:a17:90a:b016:b0:31e:a865:8b32])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3908:b0:312:1d2d:18df with SMTP id 98e67ed59e1d1-31e77a19c31mr11279560a91.23.1753641055397;
 Sun, 27 Jul 2025 11:30:55 -0700 (PDT)
Date: Sun, 27 Jul 2025 18:29:04 +0000
In-Reply-To: <20250727182932.2499194-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250727182932.2499194-1-cmllamas@google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250727182932.2499194-2-cmllamas@google.com>
Subject: [PATCH v20 1/5] binder: pre-allocate binder_transaction
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: Tiffany Yang <ynaffit@google.com>, John Stultz <jstultz@google.com>, 
	Shai Barack <shayba@google.com>, "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Move the allocation of 'struct binder_transaction' to the beginning of
the binder_transaction() function, along with the initialization of all
the members that are known at that time. This minor refactoring helps to
consolidate the usage of transaction information at later points.

This patch is in preparation for binder's generic netlink implementation
and no functional changes are intended.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 64 +++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 34 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 262334851aad..6bb1c9076951 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3042,6 +3042,30 @@ static void binder_transaction(struct binder_proc *proc,
 	binder_set_extended_error(&thread->ee, t_debug_id, BR_OK, 0);
 	binder_inner_proc_unlock(proc);
 
+	t = kzalloc(sizeof(*t), GFP_KERNEL);
+	if (!t) {
+		binder_txn_error("%d:%d cannot allocate transaction\n",
+				 thread->pid, proc->pid);
+		return_error = BR_FAILED_REPLY;
+		return_error_param = -ENOMEM;
+		return_error_line = __LINE__;
+		goto err_alloc_t_failed;
+	}
+	INIT_LIST_HEAD(&t->fd_fixups);
+	binder_stats_created(BINDER_STAT_TRANSACTION);
+	spin_lock_init(&t->lock);
+	t->debug_id = t_debug_id;
+	t->start_time = t_start_time;
+	t->from_pid = proc->pid;
+	t->from_tid = thread->pid;
+	t->sender_euid = task_euid(proc->tsk);
+	t->code = tr->code;
+	t->flags = tr->flags;
+	t->priority = task_nice(current);
+	t->work.type = BINDER_WORK_TRANSACTION;
+	if (!reply && !(tr->flags & TF_ONE_WAY))
+		t->from = thread;
+
 	if (reply) {
 		binder_inner_proc_lock(proc);
 		in_reply_to = thread->transaction_stack;
@@ -3228,24 +3252,13 @@ static void binder_transaction(struct binder_proc *proc,
 		}
 		binder_inner_proc_unlock(proc);
 	}
+
+	t->to_proc = target_proc;
+	t->to_thread = target_thread;
 	if (target_thread)
 		e->to_thread = target_thread->pid;
 	e->to_proc = target_proc->pid;
 
-	/* TODO: reuse incoming transaction for reply */
-	t = kzalloc(sizeof(*t), GFP_KERNEL);
-	if (t == NULL) {
-		binder_txn_error("%d:%d cannot allocate transaction\n",
-			thread->pid, proc->pid);
-		return_error = BR_FAILED_REPLY;
-		return_error_param = -ENOMEM;
-		return_error_line = __LINE__;
-		goto err_alloc_t_failed;
-	}
-	INIT_LIST_HEAD(&t->fd_fixups);
-	binder_stats_created(BINDER_STAT_TRANSACTION);
-	spin_lock_init(&t->lock);
-
 	tcomplete = kzalloc(sizeof(*tcomplete), GFP_KERNEL);
 	if (tcomplete == NULL) {
 		binder_txn_error("%d:%d cannot allocate work for transaction\n",
@@ -3257,9 +3270,6 @@ static void binder_transaction(struct binder_proc *proc,
 	}
 	binder_stats_created(BINDER_STAT_TRANSACTION_COMPLETE);
 
-	t->debug_id = t_debug_id;
-	t->start_time = t_start_time;
-
 	if (reply)
 		binder_debug(BINDER_DEBUG_TRANSACTION,
 			     "%d:%d BC_REPLY %d -> %d:%d, data size %lld-%lld-%lld\n",
@@ -3275,19 +3285,6 @@ static void binder_transaction(struct binder_proc *proc,
 			     (u64)tr->data_size, (u64)tr->offsets_size,
 			     (u64)extra_buffers_size);
 
-	if (!reply && !(tr->flags & TF_ONE_WAY))
-		t->from = thread;
-	else
-		t->from = NULL;
-	t->from_pid = proc->pid;
-	t->from_tid = thread->pid;
-	t->sender_euid = task_euid(proc->tsk);
-	t->to_proc = target_proc;
-	t->to_thread = target_thread;
-	t->code = tr->code;
-	t->flags = tr->flags;
-	t->priority = task_nice(current);
-
 	if (target_node && target_node->txn_security_ctx) {
 		u32 secid;
 		size_t added_size;
@@ -3684,7 +3681,6 @@ static void binder_transaction(struct binder_proc *proc,
 		tcomplete->type = BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT;
 	else
 		tcomplete->type = BINDER_WORK_TRANSACTION_COMPLETE;
-	t->work.type = BINDER_WORK_TRANSACTION;
 
 	if (reply) {
 		binder_enqueue_thread_work(thread, tcomplete);
@@ -3783,9 +3779,6 @@ static void binder_transaction(struct binder_proc *proc,
 err_alloc_tcomplete_failed:
 	if (trace_binder_txn_latency_free_enabled())
 		binder_txn_latency_free(t);
-	kfree(t);
-	binder_stats_deleted(BINDER_STAT_TRANSACTION);
-err_alloc_t_failed:
 err_bad_todo_list:
 err_bad_call_stack:
 err_empty_call_stack:
@@ -3795,6 +3788,9 @@ static void binder_transaction(struct binder_proc *proc,
 		binder_dec_node(target_node, 1, 0);
 		binder_dec_node_tmpref(target_node);
 	}
+	kfree(t);
+	binder_stats_deleted(BINDER_STAT_TRANSACTION);
+err_alloc_t_failed:
 
 	binder_debug(BINDER_DEBUG_FAILED_TRANSACTION,
 		     "%d:%d transaction %s to %d:%d failed %d/%d/%d, code %u size %lld-%lld line %d\n",
-- 
2.50.1.470.g6ba607880d-goog


