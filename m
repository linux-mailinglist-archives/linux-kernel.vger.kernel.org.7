Return-Path: <linux-kernel+bounces-746202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 405B6B12428
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D8631888E62
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0356B255F39;
	Fri, 25 Jul 2025 18:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jcAfgE1n"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25E22550CA
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 18:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468708; cv=none; b=g2AO6cQYsh4xrUHlK42mY9cq7F8zds9i1jJfdLC50anx0ng1/BfdtrILh3lfNE6imGlYfHaqtuROk4H0gYLH+jhKxkFwN9P1C1GibHzRfFr7xb89QlXF5/RSKyaSfOush3VSF1ZZqrThjKH635hBk9e1Qk8j+mRQ76hfFpGdNnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468708; c=relaxed/simple;
	bh=EIkXJlJ7/tVrwsE5890JqYG99zH0rcdBwoFWoNtENeM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UZsyz5d2fV+yy49rx1gA/Ww9qEYgkCxOI7MJL/N2BfHpH1J9WzKaA3lTVQrC/Fmopg02FxPllvs35gFVwbLh2V07yqssU7J2Qqsjk4oVK+c4UVhSiPCw+pfnl47QUpveNo52tMq8uY8pual7aMsQlEUoMt6UJI9uMIhOp5xdhTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jcAfgE1n; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-234906c5e29so29795125ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753468706; x=1754073506; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WtfOw8me2fehz6S9vL0y0tL4JPXzL4OPlqHFwldn0qA=;
        b=jcAfgE1nOiMmGKo26v3KiPVk/3kmO+6dQrh1Kas0zedJGhTHRaywTQiLemsmZTBFV2
         e/X6sOOv89FJZ9fpIvMbBnYoIdqHWn8NshGSm6S8UDVW5KnG7f5W7CnbW//iXtlne8Hb
         W5epnguTKnv+09fIYiiKTHb7NCnJx5NmFNonelU/FSgIWyAVncHKAtijdcLL0RLlT4J+
         OjSh4b3YnV5TZXbkylkHqhDaVwuX+yEBT2/mrdsuIS7Se8VMUAHjanNPZuGo/mzwEG6g
         Q66sXzVGUxP/4yA5oi7qhNtEXbvYtV5ElDJ6MgGoZmt+HsjURqjh0g83+BgSuY8wn2VS
         J1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753468706; x=1754073506;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WtfOw8me2fehz6S9vL0y0tL4JPXzL4OPlqHFwldn0qA=;
        b=kUelYlYdNqGyB9ZUBV3zS7fMc8EfwN9NxJ8TacMax6KbLVvsSZF4MsdRAnOglIxuMO
         sUxJsdJTrkSTZMPCTLIsO21nfmGtWX8dnQJkza9TW804fBeZyoFUsLtGNM/iCA9H0Q/d
         KwtVLle6tpDg09yaOlgsras+UUU2B5ty4bbli+5ZEZxYo7scxYqvXsHF2XAtjeDvFmid
         zbHlzssfBB62qsKp7PhSupkIcuDpCgJ4c4HCAhOL+3T4cp7Z6buFJ5YLsvb25sl9xf7e
         G73NNQkwLpdcwoRIr8fTp20XxbCcDBAI+Ua8IZjCGAcuIOL/JPDal7wlQgiy8ZDmTnvk
         AoPw==
X-Forwarded-Encrypted: i=1; AJvYcCUB01KzcXny0l1BsPWE4C5Q313fx9JvsykILHpyomRdKMZi7aA0j3UhjFvlYuWGJVaM49VTGiL0FxyMaeg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy08ZK+c1gvZzFboy69bYppIA8IKuFbK5/vE/doxisOwOU2/Lr
	Z5r6mwwff7K8XUq3CoR6iLh8hj/6fPqOrWliZsT6VjwUGVr1hObad2FHmIDkRS0ppyoKjNBOZzT
	BtObTfZceg+QUlw==
X-Google-Smtp-Source: AGHT+IG1rCtczBqr+lq8W7k1f3zjP1ilx/RuyK0T6pY2mAVoYZTMNCcgASMw4XdxgNw+luYRa06N53JN8bDlxA==
X-Received: from pja16.prod.google.com ([2002:a17:90b:5490:b0:311:1a09:11ff])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f70b:b0:235:27b6:a891 with SMTP id d9443c01a7336-23fb30ad041mr42070095ad.28.1753468706298;
 Fri, 25 Jul 2025 11:38:26 -0700 (PDT)
Date: Fri, 25 Jul 2025 18:37:45 +0000
In-Reply-To: <20250725183811.409580-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725183811.409580-1-cmllamas@google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250725183811.409580-3-cmllamas@google.com>
Subject: [PATCH v19 2/5] binder: add t->is_async and t->is_reply
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: Tiffany Yang <ynaffit@google.com>, John Stultz <jstultz@google.com>, 
	Shai Barack <shayba@google.com>, "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Replace the t->need_reply flag with the more descriptive t->is_async and
and t->is_reply flags. The 'need_reply' flag was only used for debugging
purposes and the new flags can be used to distinguish between the type
of transactions too: sync, async and reply.

For now, only update the logging in print_binder_transaction_ilocked().
However, the new flags can be used in the future to replace the current
patterns and improve readability. e.g.:

  - if (!reply && !(tr->flags & TF_ONE_WAY))
  + if (t->is_async)

This patch is in preparation for binder's generic netlink implementation
and no functional changes are intended.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c          | 7 ++++---
 drivers/android/binder_internal.h | 4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 6bb1c9076951..95aa1fae53e2 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3063,6 +3063,8 @@ static void binder_transaction(struct binder_proc *proc,
 	t->flags = tr->flags;
 	t->priority = task_nice(current);
 	t->work.type = BINDER_WORK_TRANSACTION;
+	t->is_async = !reply && (tr->flags & TF_ONE_WAY);
+	t->is_reply = reply;
 	if (!reply && !(tr->flags & TF_ONE_WAY))
 		t->from = thread;
 
@@ -3708,7 +3710,6 @@ static void binder_transaction(struct binder_proc *proc,
 		 * the target replies (or there is an error).
 		 */
 		binder_enqueue_deferred_thread_work_ilocked(thread, tcomplete);
-		t->need_reply = 1;
 		t->from_parent = thread->transaction_stack;
 		thread->transaction_stack = t;
 		binder_inner_proc_unlock(proc);
@@ -6328,13 +6329,13 @@ static void print_binder_transaction_ilocked(struct seq_file *m,
 	spin_lock(&t->lock);
 	to_proc = t->to_proc;
 	seq_printf(m,
-		   "%s %d: %pK from %d:%d to %d:%d code %x flags %x pri %ld r%d elapsed %lldms",
+		   "%s %d: %pK from %d:%d to %d:%d code %x flags %x pri %ld a%d r%d elapsed %lldms",
 		   prefix, t->debug_id, t,
 		   t->from_pid,
 		   t->from_tid,
 		   to_proc ? to_proc->pid : 0,
 		   t->to_thread ? t->to_thread->pid : 0,
-		   t->code, t->flags, t->priority, t->need_reply,
+		   t->code, t->flags, t->priority, t->is_async, t->is_reply,
 		   ktime_ms_delta(current_time, t->start_time));
 	spin_unlock(&t->lock);
 
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index b5d3014fb4dc..1b69bba2c816 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -539,8 +539,8 @@ struct binder_transaction {
 	struct binder_proc *to_proc;
 	struct binder_thread *to_thread;
 	struct binder_transaction *to_parent;
-	unsigned need_reply:1;
-	/* unsigned is_dead:1; */       /* not used at the moment */
+	unsigned is_async:1;
+	unsigned is_reply:1;
 
 	struct binder_buffer *buffer;
 	unsigned int    code;
-- 
2.50.1.470.g6ba607880d-goog


