Return-Path: <linux-kernel+bounces-746201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAD6B12429
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A37B417FF58
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D27B2550D5;
	Fri, 25 Jul 2025 18:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CgvU5fAw"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0751F25392D
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 18:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468706; cv=none; b=KUbaFzGARQD2mV+HQIcIsrs81xh8qVRu+T3+Wf2yhUUous6YOKCmH/iSCwuEyk+Db3sCuwtcal4pi6fczpmSSx5TqXFtsmRF814M0MwomjsyomVdyQJESXaioyHIXiAP3yr6GKcVt0x/LO0Dayv89xHTRzxVJKSRfC3lKo1Iqcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468706; c=relaxed/simple;
	bh=pgcoFaEO5e2jWlUnn8djk+glagmUEPUIlqDIRVPO+QQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FLHuvceugV6wci0RqukcIozhBrTEz0ayfJcuhFE3U5vE1KwgqrwFlL9bdK5+jgcSFavpPLDjngRvddpS2f+xUAslAcfNRyhyTzwUGMXx20HtulLgEVqKQkh1d1hzQRzASpFyaQmHZxt7QLU38G9vIted3iQtvGwLzNuWabOXZxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CgvU5fAw; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3132e7266d3so2502068a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753468704; x=1754073504; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=07ZTFzAwI7AoDMGWdPj2CS/hPyS57ZZsGkQWvuCqmTo=;
        b=CgvU5fAwfjRcvz0BPU1HvnSzIvc56PwI0DU4ddUQp/ndrGBSELGGRcZZdG+C/sUZYN
         URERAQlJ16u5JX8akzafM1wirXk9rEc8YEB2Uy3nT1Dao26d3bvXCJTetv1rZs1nb4sG
         yOBu0RZB9cuQ3L4Gymns9NVXHmjqP3cdkNXywABSoDgh9HqR/CdpUPDnhBSySDjf7CWu
         hXkfqXiG3ICQNSnPWxY1BWx4L2kfFs+TOKGgCkNQCd/ac+xRPPV5MBqUmcp5jUyIfFN5
         0COLUF7Wbq+6RLPldtNPqXtTo57co1jd2qqwSU+mAOxasSzPtl00BWeccoGeg+uvuDnQ
         aetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753468704; x=1754073504;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=07ZTFzAwI7AoDMGWdPj2CS/hPyS57ZZsGkQWvuCqmTo=;
        b=F8P6zGw6MfBKIAhEKT6DSxmXz8D1OUgzKEIlfaMJYjFAgu+S/BBEY+Umj8w7PS7D2y
         2GPeCzNZmcbD5+g8HMApCvqCjkl+fR7k2OziaFZUN2s8NNH4C4eBHb7JjJTalG9lNtep
         peaCGotnffvC1nncUSkP64q4vtWLJ9wn7eKqX5Il6doAzAfMT/MAiJy14QT7a63XbLlL
         4dvnuOvCbfNojjgPueqIFTZpLfcEkaFH2Gta8wSjeGZ3ItkNdPEQ5NTSxzwYVikgYp+T
         fIZqMuZlWdUEV08zN6gGmbBdw0snEFzSJSn41z5P4/vFnUHSChGs+9G21ko579HHWSk6
         92gw==
X-Forwarded-Encrypted: i=1; AJvYcCV9TajqfSSsxNykhWrydrh+sMSq4N4A0HwVfo68bGoWmcd3JEQpUNz/5Wu1IaYeuDFDvuMeCx5gaCKHce4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf9LvO5ZRTshJWQVRbm6xkoXVzJ4ap4uUCs3oTTSv84E2Zg3aB
	dgHlBZrnuZG/gsTjZ6LcY/iLVXYEORvMwV2cUiZNoYG1YNPsg5vyfUE92wDtwARY4ofxE6kNn4g
	PR13zQMS0H0Eghg==
X-Google-Smtp-Source: AGHT+IFGPDK3olJm2hcTg+BT/dsjXGWEuaJNtDdOkf1WEpLux5tDqz4FjCMsdW1oD94A0R5TYrvirmglOL9/zg==
X-Received: from pjbsw11.prod.google.com ([2002:a17:90b:2c8b:b0:31c:2fe4:33bd])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d40e:b0:313:1e9d:404b with SMTP id 98e67ed59e1d1-31e7783b3c0mr4746407a91.2.1753468704305;
 Fri, 25 Jul 2025 11:38:24 -0700 (PDT)
Date: Fri, 25 Jul 2025 18:37:44 +0000
In-Reply-To: <20250725183811.409580-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725183811.409580-1-cmllamas@google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250725183811.409580-2-cmllamas@google.com>
Subject: [PATCH v19 1/5] binder: pre-allocate binder_transaction
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


