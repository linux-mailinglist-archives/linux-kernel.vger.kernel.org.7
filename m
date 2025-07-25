Return-Path: <linux-kernel+bounces-746205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF142B1242E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9182418979B5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64C62586E8;
	Fri, 25 Jul 2025 18:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gdnHZJoe"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5B1257AD1
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 18:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468736; cv=none; b=QNAzzL1KsIDcxUFL30oHsjP4afaTrJarCmC8hFMaKU43ZwKhYE6VkjXfwg1wos921VsIomYwU1eH737ho3GOu/h3Ia4bdtWmEJ/TdpgbDcW5umlA+lRtTlflyRHF9asfmaMNRpRYUvVlb8U/B+mRYRpXeqRzdK+MAYHNs4gCdeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468736; c=relaxed/simple;
	bh=HNdw2Y2WCnhZqIPQ+M+4zVLBT3PzyW7Ihk8KCE6gAxo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rfgXhJuC8dNydpYreaqBXd5Pz5xSS5Vrh0zvtEW9h8K+Za43rO9/+GLlC6Rq56h5ufzASVF/uEP+cHlLZq3RTAvqQA+pf8B9hHVNOvxu615vaI4/E8xUYjSrwnLcyLSiAp4qpozlxtJzBTAKvbsyHgYuLwMG3s/SnWy19TnXzsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gdnHZJoe; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2fa1a84566so1977566a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753468733; x=1754073533; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BtHJWM2gXUsv6xzq7C6P5vZ0vTx2NB+Xsxgc7a7A5cA=;
        b=gdnHZJoesypWylctChe9EPLBCzsFtbH8dKVQyz8KKzzhmSmFKrKW1eIzlAmq9Sflx9
         RSh3T8V4sVMTiXuDqhK6d8HUOSAqE8/7BXK14Uy4A5CvbIuImoma4ZPo0BTVsOLfey7g
         z0+LqPzwq4w15rUYwUdMAkXoqv5fg3Os5jyuDp9wp1h4jAcZVZ/fTdYT36po+5ZI5XpX
         xPALA2Hvuh+9Ly2OUjNWQdxYbm0j1h69IHpa/fzLWCs/7S8Md89/OLF3PIJaVY5Y5Er8
         ynYFnpzoPrx9kwAKHiRtNYFv28uzUlzcAJ3F+I4YMoOHlPDScW4FyEN9HmrvD8ALxTTS
         jMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753468733; x=1754073533;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BtHJWM2gXUsv6xzq7C6P5vZ0vTx2NB+Xsxgc7a7A5cA=;
        b=B6JDJNpeFOD9IP1UcKjpC7Yme/PU9ZtLACfjyjg47zdLgPHYRHGuKFcpe3UkBUvVGX
         Kh/1NEL0oVKU6clE2HW9lj4D8bKeoleHB99qskFm1Bxovs9VDoUS28ZhDgZbqc+A/zuB
         SAOCi+iyzH+3S1Zdy+C18WHHs97Rbtc3b2ta2VSfqDAjjwcvG8NncZRCiiAasjl3krTm
         FhPfHqhB2gKvBv5JO7DrE2Ld8Ls48rZfS5cfFO3p+Dy+EgrsLHWwUYZXeUbUKVSL/WMc
         pPivrg6kA4/uoBImzbf2+5euue59eCIiqce6MDplpt+EJx2YT476+3UGaGjJbzm2kd4n
         z9hg==
X-Forwarded-Encrypted: i=1; AJvYcCWyvy2KFpIkPVOsYYPFYTPDmc2UgpJ6+M6KGRCYS3Ayu3x3SuW0Jrv7bL8Dz/oHWE1Egxef1/uxzTQPD4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4wesv/z/gXw4GrveiNxzn/lUZoQWMiZqh8nUYnIQfVBqQ7yIw
	Jdx/o2DPRH6Val9RJTn574Z63qPBcRKuCabJ1EWDULkacashwJPVFnG+fs7fNdltbuIGvWz8VyK
	Yd9d0DAiGRzoqkg==
X-Google-Smtp-Source: AGHT+IHehI44CPZIxqVRMYAOdwAyVvBYGJhn1tV9DCg+jG+3LDBGdiqqf60J1xPbMKfHKRoH4sberB1zlyk2rg==
X-Received: from plbmm6.prod.google.com ([2002:a17:903:a06:b0:236:9738:9180])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:234c:b0:237:f7f8:7453 with SMTP id d9443c01a7336-23fb313a5d9mr48044665ad.51.1753468732937;
 Fri, 25 Jul 2025 11:38:52 -0700 (PDT)
Date: Fri, 25 Jul 2025 18:37:48 +0000
In-Reply-To: <20250725183811.409580-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725183811.409580-1-cmllamas@google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250725183811.409580-6-cmllamas@google.com>
Subject: [PATCH v19 5/5] binder: add tracepoint for netlink reports
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


