Return-Path: <linux-kernel+bounces-801349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCD7B443F7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0CAAA43A41
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294D530DEB8;
	Thu,  4 Sep 2025 17:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="OEpxYVvT"
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849E33074A9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757005755; cv=none; b=bBXMw2J4ilTOEmhNUzr8QN4/Xw7bNBOC0TbcwBJSUtg/hDJTBRwIwAC9ysSSwl9F0mJh9dspTRQFBhL5rBY3fbZcgybcp6/VTeteTKBjX0zac0Lm1RK+rLEzd5GznJnJiHmw24iN97zc6PPoLAVhgZc5R7uMi0YL5BYkRt/LOTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757005755; c=relaxed/simple;
	bh=07i1la9fQN2kersPZyNzWMELEigPqbG6prB/BWQc0vU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+Dh6pS4+FilaGW4HnzRHnGNQkmBLiLnc+52516grQMRhN/7MWGIgvi7Gir7EcR4wJF/2p1Tc7zSkkotdnCa4CAGF0owYwHSIa3JT2lMVNeOx+wcdubEUGXa4dbzBWSDMZwORHgQFOvTFpZqoGQJhYj8Cc6TZ1uUQXyXUSWeGHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=OEpxYVvT; arc=none smtp.client-ip=209.85.215.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-b475b63ab66so63247a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 10:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1757005753; x=1757610553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+M1NG6B6OFwu9tHRBdLZUCrMLKtMyNhR+7C4mUFY85M=;
        b=OEpxYVvTPbdEawCFHCOb4ZhFn/TUxF9LrytY7iLKeJQLXj9HjVzgVbM7x0K6Ryo+6C
         WuzqvmfWwhf8S5fm5ZfK6jwf+wJib7dvb0KiKDOugaSwtn9xQx/bBD78Jm397pahbyPb
         erDVTF7ODOk7ajDVzQKfVK43OIKm6LwsG0RKNBs8jIvsVlghrqOBRYVEYmiFME0FK4hi
         FWvP9EfcVKCyDzuzwvnvM+VBawrVLUHoadUOaGGdkWpSDD3csft3U0IrYdTbLYcPHg3A
         jpeAyO6pi/GhDc79TRfJf91CFNNpmgm6A+xvu7HlGjPY2HkMtJFF0le6lclHp0LDGxHa
         t9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757005753; x=1757610553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+M1NG6B6OFwu9tHRBdLZUCrMLKtMyNhR+7C4mUFY85M=;
        b=PICY7CjNJsVfZm8e9zkgMGhpidRTJwgoGtIsdGgYxeTGC41eltPdigvuAon8NFXSsa
         Kd9nCW30dj1QmZpDT7LpP+LutI4muPJmgnKT1K51hsl4ymuE6nXdiNhROKpW35FE0jFF
         qMRIpdoB1MN9vpF2l9oUAAwVkVAIVOzzepCMuD7U8cv1dPy2o7I48WXCMtlUoGbh4xW3
         IYPRG77aURzfzmLEl6enYa8h4g6gsuyXFu3m2LuO9qY7keK8SAIrBJTDZROEa81IVD3+
         i3TYKc5Ko7FMRMvgLOyAN3CiMtLFCDlbDrGp8sZxIn0IpibVbcl+RYLHMuQ/l8ZvmpqA
         2pgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXS2dWRlqhcu8Gb6fTNTZ5G88B9+FMyyLSgh/FwupfT8f9X59kAdiNIQOAruSo6bv5yYUDul9bw4cvy2LQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx251IyZjhOaJcQMeYsbn2+2zlQHFWfK3UzzMN5nK2YIDXFjY+g
	apI3pqGQC/cRl8vmoz+beIl5lwDHC8stk1eivpDUXoEH4IWMhQTSI+kJWLH/btGe25KorDpJ1uN
	qmvVV5W31rDbuXdsv47qdYYNtv7BZKCAUiU18iHqSFsNna07o8H/U
X-Gm-Gg: ASbGncsy9JRD7nYrK7ZX+5/NsgK3EBXKwEgSUlVCfHRbRj7QX9OhgsfX2OLSZX4T69g
	Ej7/VkeDBsaeppa99YPVgYhKr2slwk3Ex6IueU1hmXVDXn1U5E8JN6Q7mpk86SvxgkP/SzUnSuA
	Dh/TBOAnNX2abRwOYag60CmZQ3os2WmDPqU9zz+efG4zhFDFGYySF8wLqZxWU5NLfwvAZLHKt9a
	lKIuMA3pq/xhmHMxH5DWBIUS7SUy8JEP0ZAqX1I5k40ESDDAJ9nc8xXJABjONZ1P8Hezpih1Wn8
	r9WRACQQbrv/hUV7sIseURXzgJiHurfPVoUP4u7pzyRm4u0xDHgeAtyrfw==
X-Google-Smtp-Source: AGHT+IEUAb2fI0uxQLFAx7fccXEm/xCcSAwNTQKZiDEgvh/+EuOZbLhdWCVu7LFWtcFIBcxojFilsb9OTo4N
X-Received: by 2002:a17:90a:2ca7:b0:32b:4c51:628a with SMTP id 98e67ed59e1d1-32b4c51649fmr4354942a91.8.1757005752432;
        Thu, 04 Sep 2025 10:09:12 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-32b915e55afsm91173a91.0.2025.09.04.10.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 10:09:12 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id CD013340647;
	Thu,  4 Sep 2025 11:09:11 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id BA681E41979; Thu,  4 Sep 2025 11:09:11 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>,
	syzbot@syzkaller.appspotmail.com
Subject: [PATCH v2 5/5] io_uring: avoid uring_lock for IORING_SETUP_SINGLE_ISSUER
Date: Thu,  4 Sep 2025 11:09:02 -0600
Message-ID: <20250904170902.2624135-6-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250904170902.2624135-1-csander@purestorage.com>
References: <20250904170902.2624135-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_ring_ctx's mutex uring_lock can be quite expensive in high-IOPS
workloads. Even when only one thread pinned to a single CPU is accessing
the io_ring_ctx, the atomic CASes required to lock and unlock the mutex
are very hot instructions. The mutex's primary purpose is to prevent
concurrent io_uring system calls on the same io_ring_ctx. However, there
is already a flag IORING_SETUP_SINGLE_ISSUER that promises only one
task will make io_uring_enter() and io_uring_register() system calls on
the io_ring_ctx once it's enabled.
So if the io_ring_ctx is setup with IORING_SETUP_SINGLE_ISSUER, skip the
uring_lock mutex_lock() and mutex_unlock() for the io_uring_enter()
submission as well as for io_handle_tw_list(). io_uring_enter()
submission calls __io_uring_add_tctx_node_from_submit() to verify the
current task matches submitter_task for IORING_SETUP_SINGLE_ISSUER. And
task work can only be scheduled on tasks that submit io_uring requests,
so io_handle_tw_list() will also only be called on submitter_task.
There is a goto from the io_uring_enter() submission to the middle of
the IOPOLL block which assumed the uring_lock would already be held.
This is no longer the case for IORING_SETUP_SINGLE_ISSUER, so goto the
preceding mutex_lock() in that case.
It may be possible to avoid taking uring_lock in other places too for
IORING_SETUP_SINGLE_ISSUER, but these two cover the primary hot paths.
The uring_lock in io_uring_register() is necessary at least before the
io_uring is enabled because submitter_task isn't set yet. uring_lock is
also used to synchronize IOPOLL on submitting tasks with io_uring worker
tasks, so it's still needed there. But in principle, it should be
possible to remove the mutex entirely for IORING_SETUP_SINGLE_ISSUER by
running any code needing exclusive access to the io_ring_ctx in task
work context on submitter_task.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Tested-by: syzbot@syzkaller.appspotmail.com
---
 io_uring/io_uring.c |  6 +++++-
 io_uring/io_uring.h | 14 ++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 69e1175256bb..b743644a3fac 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3534,12 +3534,15 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 		if (ret != to_submit) {
 			io_ring_ctx_unlock(ctx);
 			goto out;
 		}
 		if (flags & IORING_ENTER_GETEVENTS) {
-			if (ctx->syscall_iopoll)
+			if (ctx->syscall_iopoll) {
+				if (ctx->flags & IORING_SETUP_SINGLE_ISSUER)
+					goto iopoll;
 				goto iopoll_locked;
+			}
 			/*
 			 * Ignore errors, we'll soon call io_cqring_wait() and
 			 * it should handle ownership problems if any.
 			 */
 			if (ctx->flags & IORING_SETUP_DEFER_TASKRUN)
@@ -3556,10 +3559,11 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 			 * We disallow the app entering submit/complete with
 			 * polling, but we still need to lock the ring to
 			 * prevent racing with polled issue that got punted to
 			 * a workqueue.
 			 */
+iopoll:
 			mutex_lock(&ctx->uring_lock);
 iopoll_locked:
 			ret2 = io_validate_ext_arg(ctx, flags, argp, argsz);
 			if (likely(!ret2))
 				ret2 = io_iopoll_check(ctx, min_complete);
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index a0580a1bf6b5..7296b12b0897 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -121,20 +121,34 @@ bool io_match_task_safe(struct io_kiocb *head, struct io_uring_task *tctx,
 
 void io_activate_pollwq(struct io_ring_ctx *ctx);
 
 static inline void io_ring_ctx_lock(struct io_ring_ctx *ctx)
 {
+	if (ctx->flags & IORING_SETUP_SINGLE_ISSUER) {
+		WARN_ON_ONCE(current != ctx->submitter_task);
+		return;
+	}
+
 	mutex_lock(&ctx->uring_lock);
 }
 
 static inline void io_ring_ctx_unlock(struct io_ring_ctx *ctx)
 {
+	if (ctx->flags & IORING_SETUP_SINGLE_ISSUER) {
+		WARN_ON_ONCE(current != ctx->submitter_task);
+		return;
+	}
+
 	mutex_unlock(&ctx->uring_lock);
 }
 
 static inline void io_ring_ctx_assert_locked(const struct io_ring_ctx *ctx)
 {
+	if (ctx->flags & IORING_SETUP_SINGLE_ISSUER &&
+	    current == ctx->submitter_task)
+		return;
+
 	lockdep_assert_held(&ctx->uring_lock);
 }
 
 static inline void io_lockdep_assert_cq_locked(struct io_ring_ctx *ctx)
 {
-- 
2.45.2


