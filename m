Return-Path: <linux-kernel+bounces-744824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55443B1114B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74AE95A7207
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADF42741CE;
	Thu, 24 Jul 2025 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2WP5b9Zb"
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F792135AD
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753383575; cv=none; b=E+B5bF0knDfxvngriYrk9yEi/94sJl36p2EMn9jddXytpWlRtsm4xjQjhLLv1qvUJCn57uumfcNTr0bqGgxZSjc6dEIiO/uGmZbNOkao27tg/XGREXZyr2CaYxPLKDh+FO8WkR4Y+4DT19Hye2Q5CElxTBgEGoSOsmdgirBU3Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753383575; c=relaxed/simple;
	bh=pgcoFaEO5e2jWlUnn8djk+glagmUEPUIlqDIRVPO+QQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q4TnHXRQpzKPaFz0QGcFcyglGAKDJ64aDsZDKzkfu5qllVyKRwqIteXbDd/FscvJhvqaU7RL7c8lbDt5jnMKImeZaHKrHlc6sDXhDswroN8Sya8nY4/Msv3MrybkL2FjnzTqPXcfLC88zzr7nd+0QXEFfeWjd+MMXYFjg76ebSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2WP5b9Zb; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-30179e8d7b9so2470679fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753383573; x=1753988373; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=07ZTFzAwI7AoDMGWdPj2CS/hPyS57ZZsGkQWvuCqmTo=;
        b=2WP5b9Zb5fEVmE9dVgrja/PlmK+nm6xYyvkouGqQCpAzDrtjIY+Pq8+4+yJCGx96ix
         22COs/b4pKwq4qkRhX/k/L8og2Qe2v1r4ppAvbogvPzPpbG8Qg4nkc16lgVF3q/FmF16
         yA1nA51gpilS311/OZRcRcIKUhGkJSbLwoRKLmGJKec1ma/adxVN2L8Xk+cKujp5BxMY
         tZk4UpFAJ0qhnkCIcl9U7qSu07ArjuHOSOCzTiTeyM2oxULNHIGGfrAQ2hjj2wg8nNNy
         8wDRJ0jhIWHZ+pBsogvaSo1qho/viK3L8vnprFrqT3h3ZKwaVYx183Vf+TMuKyU22VGD
         TmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753383573; x=1753988373;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=07ZTFzAwI7AoDMGWdPj2CS/hPyS57ZZsGkQWvuCqmTo=;
        b=rUYDKKalZjOXgD3GgzIGSYtG/WwdGkzS5bBCrXT/jZ43374aLZlNaj+in0ARwNQmpD
         gNOjVFfVsk+u37mWneBHi6DUBrnDx38kZgrQLp/2WpANXQ4p2+0LAs4cJAKbSqC26krc
         XilGRBaU12Cy51VrteCa7s0/8T3i7KjXVgGO4UAsVcEWdoJt30Xb+HD/cGwBnzJ335oG
         ZJejnkam7+pyfpZiiZHu7+yhi+WOW5TFbsdLc36e7xHG4+of3lwSqhClqJaTDZNRpJTi
         N9jLLCxe8MMAIKgz5//M/FH+dwItcAsoN4WmN5o9z8DVA/tbDdpiRsNG4kGb+tIipY6r
         9jLg==
X-Forwarded-Encrypted: i=1; AJvYcCW9c2rVlMfuyDK5FeVxQyq0JqiEhT3JUTy3TJVvQaWxsqMKJySsPOkdGnXJ7fRKKXca9FhcpXrymxk2Cdo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/s9CwW8E+rnDO7m50cf+77zizERoTy7yiKR35PYPeizZHUj4h
	b9ASJrbe1b3AeNCBFLgaNWohPu5GWDaF9zm+2oD0pbBa7A/N9uvwfi/KLLV87oGOHEy+hagIA6S
	FJQISqtCVsoh7bQ==
X-Google-Smtp-Source: AGHT+IE0Gt+dyTvmGnP+4J8cj9WIDbmIe/wD9F25pxjN4i2nC9SixctOWbopPHllw53XNHTpXovRZbFM5e0zcg==
X-Received: from oabti11.prod.google.com ([2002:a05:6871:890b:b0:2f6:e173:40c0])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6870:854e:b0:2f3:e087:6315 with SMTP id 586e51a60fabf-306c6f4b9fdmr5838468fac.4.1753383573086;
 Thu, 24 Jul 2025 11:59:33 -0700 (PDT)
Date: Thu, 24 Jul 2025 18:58:55 +0000
In-Reply-To: <20250724185922.486207-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724185922.486207-1-cmllamas@google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250724185922.486207-2-cmllamas@google.com>
Subject: [PATCH v18 1/5] binder: pre-allocate binder_transaction
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: Tiffany Yang <ynaffit@google.com>, John Stultz <jstultz@google.com>, 
	Shai Barack <shayba@google.com>, "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, kernel-team@android.com, 
	"open list:ANDROID DRIVERS" <linux-kernel@vger.kernel.org>
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


