Return-Path: <linux-kernel+bounces-797391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC54B40FDB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 00:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D758C5621C9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB20276028;
	Tue,  2 Sep 2025 22:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="JE19jBBh"
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F22C26F2AF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 22:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756850893; cv=none; b=Jx9OVXn0sC+1r9YAucva1mCumHdG1tlN25exJIrihlVUfORKNqiyDmcYvrgK8ilro6UFBr7D1FYPesmiN/vJzziVK2Gy0DET56V6plJL/DSwZ2FF4gx2q7ATCfClG/wWiUSEl6KTUsG+Gzn/ieubvv+rBQOucbJsLOrBBzV5+mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756850893; c=relaxed/simple;
	bh=vT37VwGjZOyCl9u5Iz9sHTvtTUWCCe6Xb+1IziJLUvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qa3YFFUP4qkWr1QWmQtDKv8y0N1MORpzXaTYAahGM+zutmeWeBOF6xbk72uXZEDt5YLXqut9oMOiPFGxnP7ZpBXilHbHcGotiXcRqHaN2SDwzG0VivMXdg7dANBbTJKRlBnjvoqXnMu4mj0cycjtNAHibR2iwsBEYr4iep9Nq3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=JE19jBBh; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-77280e7bde3so7134b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 15:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1756850890; x=1757455690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/lOOvLhOLy/sorN2ba6lIemJd4kQXZprLIftfp53Us=;
        b=JE19jBBh8535OZeFgbdyiPZRoAMCX47NwCfGqgQP1b3mmCc4pV0aZUwFau+icWWQCd
         11r/6ZzmAJi3BADFy9/Rh6LXLSFGl+/cZSYUpFG88nB2LHhxMnQ3PHShB461gH4GHlso
         ISyoVRHHf+uWYvAGFVKPyHP7jIqGHhE1HpdTqFBgjLNVF3tjcj1c0cBPQfPGx9WoO7hX
         Q7M4E52TEwr+KHzqGuCZwUMjSRzS6lqSYjztto0DQY13iC96yikxbvYX7fYSWzjKptKT
         /wslBruhhppT/eNkIVfhtmGjMQ+6Y/p4smnJAUxC5QULqJ2iZbD6fnp4cACIHEscBO9p
         f+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756850890; x=1757455690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/lOOvLhOLy/sorN2ba6lIemJd4kQXZprLIftfp53Us=;
        b=UYUftysd/5R9dWoezgEaO31o7wL7siaq/KO1CKL7LUySNo/I5GWlqkXP/kewj8W9eD
         HEeUboMZ2t73vT9JXrdlEww2p3mmEAFWlvpOxsdp0L83ylUQT3KA1FcTAJa3BUmz0phz
         I9u2qJxbu+60Gn80T5envmj/e4bkr0uYyRut7C7idcE2l1PHunU1dIoPBhdLo7o6+rCw
         crauaQbykPSjTBuVLC3k809M62ri9NJpzwc+B9wJCsPEUnBjotoNljUC1K3n3Kh4ACIf
         6cs7Kog39b9TlUmA74qYiejm98h+fTekhGEYdXFoH/jtvHZYMS3VKsdABmeEmnLO44kq
         e97Q==
X-Gm-Message-State: AOJu0YxjL5NuSdTaEpnBXunpfqtRlpy2BpjQzKbqHoycvLFcM6iQj930
	hesPrwhU0vJFVpjRKxxFmOH0M1Pm1N3VMjDoZKzlWiwm1eQnNnRygwxyGLLWhdOyL01DqY26rd4
	T+lMdrlN3GeF34KHK8UKnZhQ246pWZHSHy/FyY5b3Rr1Ssctxx3sI
X-Gm-Gg: ASbGncuXulGCdvZZMwaQhvYxLBfmxssF9TPMKYvzYI1wEbbs9wCd9zNH2gDc2jltW9i
	GUlZFkxJTeluovZKkDm0nFtO9wxypxzVr2zApJL0ZhagvhhYi7NGyuMm2kcbSu9gX0FfSprDyNn
	ltCqp0h7DZvyzMmeHltJfwHXz1B5eAFJRhLlmNDjuEDEqnoSra85vc/Bz87wTOz7+hCKzGk66Rn
	SY2kQQHEPF0PrhWRDgel7zlBoZDjuUFgTAJgCNjZ98rOS+mbn3UaOLuvGTo5IcZ9umOcozUENpP
	+0Us2OfE6g80bTitrWpH8KRQlXFYCdyYNGbCL6PJhPyMgWHGWU3o/OiZlg==
X-Google-Smtp-Source: AGHT+IHh+E9h0g9rhY441U7b2SSrjQdzMOg8UHKGFQ/wObDq1Onwn0jP32Wu6Yh0SeN4X2EX63FdAmoOI0tx
X-Received: by 2002:a05:6a20:244a:b0:243:a2f1:f872 with SMTP id adf61e73a8af0-243c32f53c3mr14059892637.5.1756850890377;
        Tue, 02 Sep 2025 15:08:10 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-b4cd0736486sm962640a12.6.2025.09.02.15.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 15:08:10 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id B5A6C340214;
	Tue,  2 Sep 2025 16:08:09 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id B3532E41920; Tue,  2 Sep 2025 16:08:09 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 2/4] io_uring/rsrc: respect submitter_task in io_register_clone_buffers()
Date: Tue,  2 Sep 2025 16:08:01 -0600
Message-ID: <20250902220803.1932692-3-csander@purestorage.com>
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

io_ring_ctx's enabled with IORING_SETUP_SINGLE_ISSUER are only allowed
a single task submitting to the ctx. Although the documentation only
mentions this restriction applying to io_uring_enter() syscalls,
commit d7cce96c449e ("io_uring: limit registration w/ SINGLE_ISSUER")
extends it to io_uring_register(). Ensuring only one task interacts
with the io_ring_ctx will be important to allow this task to avoid
taking the uring_lock.
There is, however, one gap in these checks: io_register_clone_buffers()
may take the uring_lock on a second (source) io_ring_ctx, but
__io_uring_register() only checks the current thread against the
*destination* io_ring_ctx's submitter_task. Fail the
IORING_REGISTER_CLONE_BUFFERS with -EEXIST if the source io_ring_ctx has
a registered submitter_task other than the current task.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 io_uring/rsrc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 2d15b8785a95..1e5b7833076a 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1298,14 +1298,21 @@ int io_register_clone_buffers(struct io_ring_ctx *ctx, void __user *arg)
 
 	src_ctx = file->private_data;
 	if (src_ctx != ctx) {
 		mutex_unlock(&ctx->uring_lock);
 		lock_two_rings(ctx, src_ctx);
+
+		if (src_ctx->submitter_task && 
+		    src_ctx->submitter_task != current) {
+			ret = -EEXIST;
+			goto out;
+		}
 	}
 
 	ret = io_clone_buffers(ctx, src_ctx, &buf);
 
+out:
 	if (src_ctx != ctx)
 		mutex_unlock(&src_ctx->uring_lock);
 
 	fput(file);
 	return ret;
-- 
2.45.2


