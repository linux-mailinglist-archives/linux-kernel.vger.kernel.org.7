Return-Path: <linux-kernel+bounces-744828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0110B11151
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36D765A7414
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C112ED854;
	Thu, 24 Jul 2025 19:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZT0aOXcf"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5A52ECD08
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 19:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753383603; cv=none; b=tMYJFI8qIGFufDBnIQzxuSrkQmUqlkuDs7s9E2B/Ol63DNZUNZBEIIvlD2ikwUHL9GLGR8EgObD5D+rROffMvJk6rsgFq5Qmge3r97bOl6czz3kNHJwaLS+cE4UkP5ZyLG/SEzxfvpwcXeZzHXxKUzN3AnLuGbrF4s+ySl3e1Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753383603; c=relaxed/simple;
	bh=HNdw2Y2WCnhZqIPQ+M+4zVLBT3PzyW7Ihk8KCE6gAxo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QIq4iCaBxIs/LWuk0sP0YiNCHHqOSJj5biTE9kfYbiJbE/XJfwU6H4+s6ObdyOf0T9rwJIGvjIYXK5XjGdfo3Gh+Khp1v6ouq1gjFG1bg6iGlBTVBKin4a1jluYzjl113vA1vaK8/l0kJUQXkZb8Ba28TXl0EH9LTC/uR5mmAwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZT0aOXcf; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b1ffc678adfso934358a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753383601; x=1753988401; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BtHJWM2gXUsv6xzq7C6P5vZ0vTx2NB+Xsxgc7a7A5cA=;
        b=ZT0aOXcfZOsBvCS+pwSA0S6Y9T2sMTBllzNNJC0L6AjX30c4XfVk2L06XCmKm92p+D
         aBpsX8wIZihs/bEOJE7lIxZY1HkjryqumGRE+wEz7n7o35BOSKOinWsPft77YSuqQ3vO
         LWIxnqE7/FsSCmKSblSTWjUDxaz3bQwbZYQ9J22fPqIzGqpfR+0AT/2HCnsYE18tZsQX
         DULIb/BmEqWzbx5su+4jIYH71W7jJIm/aWjYO9T+Ob/JT8FWeZOTkfYv0FPEoCbnwysJ
         mBm67/C7gtrFZCzNLqpsw2MV/pAPG9QioKXxp9yNwOBoKuQy/1qSzog1R5mwQSrJzXU8
         hxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753383601; x=1753988401;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BtHJWM2gXUsv6xzq7C6P5vZ0vTx2NB+Xsxgc7a7A5cA=;
        b=t0hFePzC1J+/WEs+6FQhy2yTkNrRbRcuqRcAPfDzO0pKh1BPMOUvwJVXxShrydvhsK
         1GNiFs1b1BZcVUNnpugyJHmtNnWDk5z8AoVuca5ub3KahQRsuxOx3mVXylNKIwZbW67y
         Rc7IJimM5InwGzCIx2MwfQkX7D2AhlykYBX5clI9P1Mf2TrZoVDSkrBA8r0x3r57dcH5
         ShQfomJ5ZX4czZx42XVDExxy2eGkUSLb8RGUq42nngki0zxgTlKn6TVOU758UXdlZgx7
         /r54GHEe4uBlH9TS7v36rBAmMwMo4286oJO5M/JUeKNUPMxCFnEOF6Ymem4W8idM5ES4
         Wx2w==
X-Forwarded-Encrypted: i=1; AJvYcCWZt8h4Y360A7nF1ImJhhkISoDpucnLaHn4AdAyCkVFw+rui2nTFNFZpXzRdEEYPm4mQ2lcLGButOIPtzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydj0jv3AuiGmYvaF3XwZSuIqtgWt/EKTeBRlamlaZeaTVHvLcH
	IsLnV1+qB22vjSrqvPpgRS7yvaZzpg7AMBnbQbM86bewv4XMT9XVTPU2ArJ42FC07xQN/U07WCL
	jMpTIX6b9rivNaw==
X-Google-Smtp-Source: AGHT+IHqmXOS9Gz4LTT4nX7Kuq8zLreVysiNbN02D8zrQO5/onMa/GthFvmHwH6FcoCLQ8yGl3FIp3S/bUATVw==
X-Received: from pjbqn14.prod.google.com ([2002:a17:90b:3d4e:b0:31c:2fe4:33b4])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4e83:b0:31c:15d9:8ae with SMTP id 98e67ed59e1d1-31e507ff8efmr13048699a91.33.1753383601536;
 Thu, 24 Jul 2025 12:00:01 -0700 (PDT)
Date: Thu, 24 Jul 2025 18:58:59 +0000
In-Reply-To: <20250724185922.486207-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724185922.486207-1-cmllamas@google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250724185922.486207-6-cmllamas@google.com>
Subject: [PATCH v18 5/5] binder: add tracepoint for netlink reports
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: Tiffany Yang <ynaffit@google.com>, John Stultz <jstultz@google.com>, 
	Shai Barack <shayba@google.com>, "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, kernel-team@android.com, 
	"open list:ANDROID DRIVERS" <linux-kernel@vger.kernel.org>
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


