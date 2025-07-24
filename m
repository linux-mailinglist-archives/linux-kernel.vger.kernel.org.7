Return-Path: <linux-kernel+bounces-744825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C50B1114C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 008C91CE3CF3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327372ECE9C;
	Thu, 24 Jul 2025 18:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RmjBAmxA"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EB8269806
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 18:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753383577; cv=none; b=QK+E+ZOCESPcCTDDHLoCYndgYe0yiFaRhmImY8NpKWyBQuHeZUutsMW20L4uoXGeE4EoQFm5U/ZIN4tVUK5lZdA9Lp0Z4bQIDB11GtFPFI6SyRA3rbvdx3+jVx7bnbj7CaYUlMMRfay0pAtuflJZqdJDFog4qa8B6H8Vfx/oj7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753383577; c=relaxed/simple;
	bh=EIkXJlJ7/tVrwsE5890JqYG99zH0rcdBwoFWoNtENeM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K3DcYfh305ue5FyQGIUoJWBTbcHzkFJlM01X/dxOjFggieVP9vM0aiXCzUJnNtghQHFrW3J9pSNZQJN0VYt8Ol83UYdnBA37jLAtO2ngWKJEQu6mT5KeVgLEbF/61zlS7XABo6DYUWEz2K/Dn77dncBeEStuZE3pg+n4E2hRG/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RmjBAmxA; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7494999de28so1973097b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753383575; x=1753988375; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WtfOw8me2fehz6S9vL0y0tL4JPXzL4OPlqHFwldn0qA=;
        b=RmjBAmxAHjUoqAv0GiZNzxvu3TlkYy32d4ihat0VeEv2ksDRemgOcrxUS/eAm+ZxD8
         H8SFKty+xVvoGVCAqP26pgwB09Arjd89BwB44O1/35PVvKk3KoCZXnrH1xefMeZKtcyv
         BWjb2w0lSYSGQCUlm1dyoQ1HCuAL4u+HZbJz8Xh3MIqYAOKYwH5/5imrSTUTo8JnmJuS
         Qy0c/R0KqYbOE0TOqVBwGTDkDWtUR5ArFXnUmTFukgeah/cqvb8ErM6ruOSXkP++cKk3
         bT9gWQBwADFyGJhmSxS1IuLRAaSEhvh2rovs8m0kppXdtz+EzJuO0xJhjfgDZCNHBRPO
         WCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753383575; x=1753988375;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WtfOw8me2fehz6S9vL0y0tL4JPXzL4OPlqHFwldn0qA=;
        b=UvZkm6ibKiQ8a57sdVJLRrgI0xTomhy7xgjwLc71V1HbhSz7X+xaRNMMXFMG6H8Qd7
         lKuDY/IBz4NUaBaOyiNY2wqn2Txp54prcc1VxwNVyA7yFbr2QFmECGOQQrPXD0b5XLPr
         hM+sKzlBYeu1Htg/gGIIue6MKzwFSqCgZInQPHYHR5Gxh8/ldY2j8IkSq+ACMnG+uPQy
         f5b9O4pkrIL+UZxPBT7BtV5OLF9rjjiulIg62/ZV343SUrZC9RwYjZJj5Q3D33ZCXBeg
         PnE9KNtefw906m5p0b/VoqIp1wftONcqUARxSoYVJtugzG1DW10TUIW6Mwp+totK6Qwl
         3Jrw==
X-Forwarded-Encrypted: i=1; AJvYcCVeqt55R5qwAxKJ93fDXXgnJhCMF7eChTI0oYU2ODX9MT9aSRYHSq05MFAE9yrdjUkHTShtdQnB6DZtMWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH+j4zs6KJgyXOWReX8FI/g4TGYsOHKvAEh4WcHHkwRLEiatBG
	DV8ntQuMP5xduGwSvjQ16RjHAaGpK/dVbRXL9vMqCc2733wLPFWtT6ib6OzwuJEHOWal733tMHD
	DhmtwX/RHRIqXlg==
X-Google-Smtp-Source: AGHT+IGkDl/8egF+i175RMDqrCunqfQJGHEXJiyr6XgfkbevOHsUY4xuGRiCKYLJx8pJKFmaR3WHe9vhiYtS8g==
X-Received: from pgac23.prod.google.com ([2002:a05:6a02:2957:b0:b2b:f469:cf78])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:9190:b0:220:83e1:49a0 with SMTP id adf61e73a8af0-23d49198cd9mr12364207637.42.1753383575145;
 Thu, 24 Jul 2025 11:59:35 -0700 (PDT)
Date: Thu, 24 Jul 2025 18:58:56 +0000
In-Reply-To: <20250724185922.486207-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724185922.486207-1-cmllamas@google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250724185922.486207-3-cmllamas@google.com>
Subject: [PATCH v18 2/5] binder: add t->is_async and t->is_reply
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: Tiffany Yang <ynaffit@google.com>, John Stultz <jstultz@google.com>, 
	Shai Barack <shayba@google.com>, "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, kernel-team@android.com, 
	"open list:ANDROID DRIVERS" <linux-kernel@vger.kernel.org>
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


