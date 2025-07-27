Return-Path: <linux-kernel+bounces-747230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B853B13134
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 20:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42DC9175AB9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 18:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C765722D792;
	Sun, 27 Jul 2025 18:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Fx0iJTk"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E8122A7E0
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 18:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753641089; cv=none; b=gkNGcSChT72kjO77GDDj153639ZpfQQnAQXrPc+leLrvBNZv7twWji1tXd8GJXtt0kNPaMbdcbq/OZX0VPINdU3kLLksBL7DIZuSaUF7Z1xOeQsf05/uj03/mFouNZPLk49/2nv9h36NM7Jsrng3ZydZhaLEIrUnYmBRhol8+08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753641089; c=relaxed/simple;
	bh=HNdw2Y2WCnhZqIPQ+M+4zVLBT3PzyW7Ihk8KCE6gAxo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=flnSgobqLq2rfQi0N70/iOHxf5bWycwhHK3E6LLfQhWVQpdPxRNoz816rS4Vs8At63XtpFEi4HZXgktH3jBdPq5/q4tp4PuRn7qAbozkn4Bn5Q8t6yYQE2NPJSoLWBr7MTataTrXo8Sbbypjr/gwU0WzXCUgSDl76zK5uAzSpv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Fx0iJTk; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23fc5b1c983so11961735ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 11:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753641087; x=1754245887; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BtHJWM2gXUsv6xzq7C6P5vZ0vTx2NB+Xsxgc7a7A5cA=;
        b=0Fx0iJTkQHtTnn/vAyXrQxjWwCK7NIgVZh7BDVGyUPUexPnGLkchy7v8TkgSZRZBKR
         KnANgYeGjX1SPp2kBEaj7spxJ6YY3eLQ48//GnFMUOtHYnt0veL9DN9qB0FrSeDuJ7Mu
         Mbp+oJXW4/HCCvLH0nXp87DfxhOjYKw5rx2/VrxYFN7cWd6bMfybrm2kCNNKQaPpgiiP
         1hbUAP/U9LHPMLd04mLP4WEzHO4hytRcnYYNl9qPnw+xx1A4DdzpILBiHr8Oy4t7DxbL
         CvxA62/8AfY/ON8CHkJccOY+QgAqqEId357w83996Sv1jjTKcEo/okqXekzJwlHm5aH3
         6YBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753641087; x=1754245887;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BtHJWM2gXUsv6xzq7C6P5vZ0vTx2NB+Xsxgc7a7A5cA=;
        b=v6TPf/wTo4yEaIKAxo57cfEqMEpmdqIHJtU3JrL8K64i3l/zSMZc/NZDK7yxisKIlT
         RIPmfvbEnEL2DW2GOGsUfI2Qp5Qj6IiZRukFX4aRAlSvOkSx6QRPqe533UpAHLYMnmO1
         dWNfkYT+vz84YZJwbdzF9FS5pnBCK/9lb4c3FgjhlIYXw4mPpm66ssnNy+PdI43FK1EX
         lfA+a+M5i9BMQG/rHdpp2XoZ0X2wRrf2cn0CgUEcNesrPsGXCbD1Z9jS7rtb8KLXd2I6
         e7ZQFqDjidqE9b0PhVeZ3lNgceH6+09QT3R/sEigExJIZC2vzPk1BNkmRl6zm6AeeQ6d
         oI8w==
X-Forwarded-Encrypted: i=1; AJvYcCX6jX9c+DsXjkZ9cWlXmpIsUp6UqdmcBGG1pE9wxrC8NzszVEotGpcrGpYMjxQHQz/Xa0bOHa82YkPq3XE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ed5JgwaQLrqhbM8gM5mPOdPpVVYWO/AuxNbwxOml01L2c9Qk
	1XkammcctineheLvRhbZDTGjGIaL8Gp8N4Dn0QaO+D5YsREUm8n6nNRJ6DaPr3z9bm9iibS3VSx
	BYBKUN7nximTt4A==
X-Google-Smtp-Source: AGHT+IG8Z/EDkUlGuSIQr6Lxryh0dNjc5GK140pZ00kEg37MPO71RZjRx9AJ3+o8Ml6tBRZwKG6UvndyiMjhgA==
X-Received: from plbka12.prod.google.com ([2002:a17:903:334c:b0:23f:b150:396e])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2a88:b0:234:9fe1:8fc6 with SMTP id d9443c01a7336-23fa5da5ea6mr191691345ad.18.1753641086890;
 Sun, 27 Jul 2025 11:31:26 -0700 (PDT)
Date: Sun, 27 Jul 2025 18:29:08 +0000
In-Reply-To: <20250727182932.2499194-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250727182932.2499194-1-cmllamas@google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250727182932.2499194-6-cmllamas@google.com>
Subject: [PATCH v20 5/5] binder: add tracepoint for netlink reports
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: Tiffany Yang <ynaffit@google.com>, John Stultz <jstultz@google.com>, 
	Shai Barack <shayba@google.com>, "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Add a tracepoint to capture the same details that are being sent through
the generic netlink interface during transaction failures. This provides
a useful debugging tool to observe the events independently from the
netlink listeners.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c       |  2 ++
 drivers/android/binder_trace.h | 37 ++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 0d37eca514f9..695c1631703b 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3014,6 +3014,8 @@ static void binder_netlink_report(struct binder_proc *proc,
 				BINDER_NLGRP_REPORT))
 		return;
 
+	trace_binder_netlink_report(context, t, data_size, error);
+
 	skb = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!skb)
 		return;
diff --git a/drivers/android/binder_trace.h b/drivers/android/binder_trace.h
index 97a78e5623db..fa5eb61cf580 100644
--- a/drivers/android/binder_trace.h
+++ b/drivers/android/binder_trace.h
@@ -402,6 +402,43 @@ TRACE_EVENT(binder_return,
 			  "unknown")
 );
 
+TRACE_EVENT(binder_netlink_report,
+	TP_PROTO(const char *context,
+		 struct binder_transaction *t,
+		 u32 data_size,
+		 u32 error),
+	TP_ARGS(context, t, data_size, error),
+	TP_STRUCT__entry(
+		__field(const char *, context)
+		__field(u32, error)
+		__field(int, from_pid)
+		__field(int, from_tid)
+		__field(int, to_pid)
+		__field(int, to_tid)
+		__field(bool, is_reply)
+		__field(unsigned int, flags)
+		__field(unsigned int, code)
+		__field(size_t, data_size)
+	),
+	TP_fast_assign(
+		__entry->context = context;
+		__entry->error = error;
+		__entry->from_pid = t->from_pid;
+		__entry->from_tid = t->from_tid;
+		__entry->to_pid = t->to_proc ? t->to_proc->pid : 0;
+		__entry->to_tid = t->to_thread ? t->to_thread->pid : 0;
+		__entry->is_reply = t->is_reply;
+		__entry->flags = t->flags;
+		__entry->code = t->code;
+		__entry->data_size = data_size;
+	),
+	TP_printk("from %d:%d to %d:%d context=%s error=%d is_reply=%d flags=0x%x code=0x%x size=%zu",
+		  __entry->from_pid, __entry->from_tid,
+		  __entry->to_pid, __entry->to_tid,
+		  __entry->context, __entry->error, __entry->is_reply,
+		  __entry->flags, __entry->code, __entry->data_size)
+);
+
 #endif /* _BINDER_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.50.1.470.g6ba607880d-goog


