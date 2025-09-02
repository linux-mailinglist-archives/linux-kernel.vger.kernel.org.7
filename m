Return-Path: <linux-kernel+bounces-797393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0360B40FDD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 00:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84B1370132F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FEA274FD7;
	Tue,  2 Sep 2025 22:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="QQaikoks"
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93994277804
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 22:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756850896; cv=none; b=tKYzA1iD+Mcwaciox6mQhvEny/7WBlNDSLtIBAd6ASZCXNchuy/TBhBixQavilik261S2n7K8zJAlq6o8rQYZVMEFYRlrK0uvyf1YOpOjpP7xgQVdrJZp/H41WHjq7tLmjNINnH73N4yk6BrjAqaINXfxfG13QUZpTwsNOehNVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756850896; c=relaxed/simple;
	bh=ImgJ+08fKEjfMojQOkHQFAmBOTeJebqjPQWHFiTfvp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dp7FXq0CU82niSy43INw3v7ZVe7Z0nkbIxFL+Eo2jzJn/4lJqb8643g4rVDyueZazrBy67k+G5g1X8Q5KrQaDyed0pDF98h5vYUIaxsfaKfV+Sus/TmDQN+8GQGc3MbbSIFv4OVkX6g1xu7UnBF1vnmeV3s5gt/KRB6IBidvSkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=QQaikoks; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-24aacdf40a2so8070945ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 15:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1756850892; x=1757455692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAonx/bmXDCVaViB1VqlrTFlzUKjezpOhMXA1F7pd6Y=;
        b=QQaikokstTjCJ8oOoljWgxGWN0C1oy5avFKJ9aJ9tdPrFp0dzGY0ajWvGufUlRBjUP
         okO5P6JHwKk6GEaI647Ke9F5zKqRVuorqiNW7K80c/w+f/17J+wBsSvwDnS+XNrxlbF9
         PEs6tbjYcn92am8m7Iv/637sS3s6fAErRzhPWaPeCkMAtJiHouOAdV+IlDsJDU+xK1Ic
         5ZwUO5V9101tbB1EDzaSCe3LVdWYECFmkFmLx2QwoARp2Ri1qQgL1Z0rfulqoLhUtvfn
         NsK26rtb0wxZqQnHs7qXDi8mojYO2Xw7FHPVyl9dhzBmU6ZnAvhsjG4oSiAh3m8x/ICZ
         qUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756850892; x=1757455692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KAonx/bmXDCVaViB1VqlrTFlzUKjezpOhMXA1F7pd6Y=;
        b=edWpp8qqIwoUT4Hf9KiKLk5yNOVXlQ935JKjSzfTNZBsOYi0Cud54sP/oAK64+mByg
         za3NnWJU38tgRLzKkZVn8NcGlTbY4ISUIBgDvAWGVfmBMeVQDIglsYrMOhK4C1vGA7jE
         rjNH4U3ULIuAa5jWu5WkLxHHyVgN6dDGbTw0p6JANAdHhyfit2fkrbbV5Bu8jlHy2Ujx
         4CFGUO4L1LBSpN4R61pmEMMzzSANiKFhnOaMRRogapAUvQwqJdkb2A9h8nDELT72FdZH
         fHQEtCXDSMTQ+fb+55BncAG0Du50LWI2TRUi7KqN2YWVdAaOWTYv94xhyT0NkOI4aaDd
         Y0Mg==
X-Gm-Message-State: AOJu0YyB8SqIjGidSYqJnNmK6seDm8vXNTlZZZWB283+MjH5nLyGoSmD
	ieNIW/YyKnr6tifh0caPbajzQIisfpL7btRfoi7vF4X0GDwblL+obr5+FwHeR2eZlzqo1ShrENe
	AwR0mbR333p4HOonX3nQZIs1PEkdyP8C3hvjv
X-Gm-Gg: ASbGncvRbYl6xFn+4byA1hSHjyuMPw6vLbZ6iWYxKCT54hovSGr1r/9NGjHo+3VlmCV
	lJD0NxTNJ4Tn/xi0q0yguOBnUmQXHCbqM04fBsiTHE8lzHk6wDKscuxR/EwMlFO6EoNU+eYlml0
	uUed6i/lXN/o1Q8aw9pmEbX/ypM4yGeazXqt0/ORqhVAGY8RVsYB5wl//aMkb7u6v1hqGiKB4i6
	Ll/0b9E+r6K4kRIVYb5L22zrfrAOJq4KtgyPrEXgV3dbcjzY7qgFnOxfqgkgMHvzaNky28GZLIz
	FRMhM/agmq/gINn5VJ9jF1t0yie0T8VOXcC5l/SbidAUFH5Y/c3/Ygb3FyJkRhr3KV39DGB1
X-Google-Smtp-Source: AGHT+IF/g0AccOfET3Or6k/aBakS7qHo8JlE7t80RUk3unbjuaC3XImG1wdJPl+5EjoBGr7CHTvpx3hyvnhD
X-Received: by 2002:a17:90b:38c3:b0:327:956b:fd49 with SMTP id 98e67ed59e1d1-327e664ff1emr11912104a91.6.1756850891787;
        Tue, 02 Sep 2025 15:08:11 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-329ca196b98sm358097a91.3.2025.09.02.15.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 15:08:11 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 07F69340214;
	Tue,  2 Sep 2025 16:08:11 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 05D25E41920; Tue,  2 Sep 2025 16:08:11 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 4/4] io_uring: avoid uring_lock for IORING_SETUP_SINGLE_ISSUER
Date: Tue,  2 Sep 2025 16:08:03 -0600
Message-ID: <20250902220803.1932692-5-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250902220803.1932692-1-csander@purestorage.com>
References: <20250902220803.1932692-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_ring_ctx's mutex uring_lock can be quite expensive in high-IOPS
workloads. Even when only one thread pinned to a single CPU is accessing
the io_ring_ctx, the atomic CAS required to lock and unlock the mutex is
a very hot instruction. The mutex's primary purpose is to prevent
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
---
 io_uring/io_uring.c |  6 +++++-
 io_uring/io_uring.h | 14 ++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 7f19b6da5d3d..5793f6122159 100644
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


