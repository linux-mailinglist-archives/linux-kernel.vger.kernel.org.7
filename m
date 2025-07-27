Return-Path: <linux-kernel+bounces-747226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B64B1312E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 20:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5602E3B7E78
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 18:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C50225388;
	Sun, 27 Jul 2025 18:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cp3Autqi"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F6D137923
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 18:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753641061; cv=none; b=BtGRWelt56rY3uxMdnuhSEAfZCkRpphD/ERFllUwXIHWdvngoQZDS/VqIv3VCG2O/kcrNbF82RDyhn2dZsltn3BNpc+EHPLI6MMEAbpMRNUKaDP8iCuRuULzgxOsp0vd/kIt5e3gJMcGmVSoj36j9g270vC2oj3WkR1olNqd6xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753641061; c=relaxed/simple;
	bh=EIkXJlJ7/tVrwsE5890JqYG99zH0rcdBwoFWoNtENeM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z2VXQSy+r3guDdjG5jjAyTATx371+Pfn/qqIwNorFt4sPrgKNdoakfnDub6ANhps8BLdILRIfkEnUFqkpDtE6CnVwljQTJUoOz8O8fD2Q4ugUMEz+q6FXIXfMnHgvtvXuniGKO+Ompqg+PR5mTYQZEPwGfrIgS5you9jysqQfMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cp3Autqi; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23ff063d087so6041475ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 11:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753641059; x=1754245859; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WtfOw8me2fehz6S9vL0y0tL4JPXzL4OPlqHFwldn0qA=;
        b=cp3AutqiOIrLa23pOesWqXvukMMP99aWnet4I0fdMNRVNGipV0fLV79f4YkxGJ5V1i
         5jK2U9pIkyyO+aGqtqfLCJPybil+JpZEJbJ7MzYKweuubmuNyOtpQ4ewSCWYVhMMqlQP
         DtE1fpYI4lYib9Xb3gqtuDnj1wWv527MmktLjCdKEgL0X1K+EtTr1aNwp4AB2hLoRx+d
         TgLL4NipAS0cEnunlySrM03CZFVSxTIFJltZrtap5gEGcTRr95tvjdhf8CPooR4dKIAz
         Y4vXwbGgB06dRVXtzW0StIhHxZLWr0rh3i7RmtsqK6rsaiEYqsTX6mODSAOMf7sb0wN4
         uWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753641059; x=1754245859;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WtfOw8me2fehz6S9vL0y0tL4JPXzL4OPlqHFwldn0qA=;
        b=wJjgITYmIZlt9BwycOQexEZ5pck+WrZEsF32Uq7/UgPuli3jofFUUOjZb8wlKngHXb
         LUVYj/s1zSYG0+5OPICy5VYZ/3EulaF+l5075yjYAwKkG+VSWEFFj52bcufFjPUfceSc
         Z8hMJXdU14e+2He8wMOrbeTYf8zb5QPNec6qUTqG/ZKusbECLJBtwdGThwgJDOkfzJWv
         FnzzFO+HM4hqY27mkeNPuL6AoCfScHdjmP7w9ZtpdBPZtBix9iucPAld8uZZDXv6yURN
         aKv6CqQObE5X57REqMkOzDkzrMcXiCp2+ZCSzZC4t6uO1vfIOVlde5y4ulkJdy5Jwp8h
         960A==
X-Forwarded-Encrypted: i=1; AJvYcCWjWSi01RGzv+/gxzuoyMMR7bPs89zcUblIN14eE/5ZpWEp1eWR76Vztve9VOmmOWIGtc0RRlofaezcUuk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzobzg23HJlGn0IH2ir9waE827gQ7gnwcmtFZSx9iDxAhP0QBFB
	hddjfJ4JxJjcIlNZlTMIWwJj8dneYp9gALI+JtYAKxPKjiI+RQHG+AXao2VIfq69yLTnNAO3pVK
	CSoiWxAepFDNV5g==
X-Google-Smtp-Source: AGHT+IGSkmjG2Ncqd/7AzzGIAL6IFLlDbJiRW2CDnt5lfPA4hkA5BNV7k7rc74a9xl89KBLTsiABl0RMVTOuWw==
X-Received: from plgd12.prod.google.com ([2002:a17:902:cecc:b0:240:6ec:28e9])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1446:b0:234:d7b2:2ab9 with SMTP id d9443c01a7336-23fb306bcbfmr153785535ad.12.1753641059486;
 Sun, 27 Jul 2025 11:30:59 -0700 (PDT)
Date: Sun, 27 Jul 2025 18:29:05 +0000
In-Reply-To: <20250727182932.2499194-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250727182932.2499194-1-cmllamas@google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250727182932.2499194-3-cmllamas@google.com>
Subject: [PATCH v20 2/5] binder: add t->is_async and t->is_reply
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


