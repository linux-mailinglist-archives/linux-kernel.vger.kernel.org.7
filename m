Return-Path: <linux-kernel+bounces-802444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9E9B45276
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22963188E2F9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801AE30CD80;
	Fri,  5 Sep 2025 09:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZytPNDN/"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E638C2848A8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062984; cv=none; b=peludwHph/Oe5LP9IJtJsmAtVw3bORNBuyMJQQ8Fqdx9AlLAlusVs3Mt75kPy51lDtiMa3xFXwMeQRuhIEu9K551wT6ouQqDtbDa+Rl8r24VfOySGj+0tXdTS1Cuw7p03j/XAm8gw1cl7nOh4jWrMQDtI0CG0YmYhkHEBSJOaEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062984; c=relaxed/simple;
	bh=jYtZGnUPk8TgIyW+b8csFVYVlJvMLTdatpkz7jEPuI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8s5LsMob3XMMtTThhgIT3TXKmDe8Vg5Lwid4vzNMMV+gZzv0jQhORqcgQrVm5KcntGcpUCnE/eiBhsKas1XlLsqFbTdMt44swguz9kZ3Zu9JhBscj3obDrv1egtPOjXZZ4vhkS0A9gliLIP7DiuuA5AOFd31QKtnHk5q0r/O2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZytPNDN/; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3db9641b725so1798984f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757062981; x=1757667781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ubNq+Qi0idaAj0yap4V8A/g4fdG3/e0+F+Gyy6T2N0=;
        b=ZytPNDN/bO1rJbp4sxIwfh7qTsjtSjIXDKu/yYuLQ7WAzWkDF7ldDYuC9aW4IbvS9O
         nHEetN7ZAmBIQSk6X5K5paJIL+MDpM4GFAjtaZk6LQzUEST8jbhIl2A5jvHlxiE9b7iD
         lW/oXGutBpeuwiFZfTlux5N1c5ZH/T6uAiI8ugHdFMI/6owhphB5LdDQIqeCXkUHytBz
         S7HNZVmL6RFunGIEQffx7ftAx/ZMHm3I/M2/QIxmfKA6+VyJIg0Ccm+iaTV9VlAnzOlw
         RoN44j1+0rpLtxkCcKXmFmSVTrwxnbxxV8NzOv8f/61oBOQAQnqEVdUw1OHVSYjEEZ9w
         hKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062981; x=1757667781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ubNq+Qi0idaAj0yap4V8A/g4fdG3/e0+F+Gyy6T2N0=;
        b=wOYl0AiQwmtInCD37itJ6gO2DRlb5iOQPwnhjDxKtUovgxKkN5Gjx4jVrsla3igH/b
         l/8Wems5DeCDOFhrq4LSR1wrcroo2s3+c7wm9OItDbnLKOBbVS/xr4t4JPg+gJVg0Yp/
         DyPuI5ux0TBPykAfyw4X57o3UqVpsaAi9Iwk0/qWfc9eBxInnbxMio3RBodWxmNEkXy8
         s3otXn7pxT9wZM1sTsY++lk5R2IboglZq7lkdYxSXhX5+4QwuAOIrF6HNTR8czZrVxrx
         4uL+AL6KZVWOrgHJePlD8JE0D+acTj5hvcyQSpu2Y35x4ekNgat1lLZfwapFdfdY9QV1
         NaHQ==
X-Gm-Message-State: AOJu0YxOGzwV4GRTJWhwPCIVZgR9DCPKgFoPm+CM3BK3pVt/kil1uh3T
	fHV25bAudbyg5wanzMLY0mSqeUajA1lhAdKv/3BlDa4UNM33D+heoESBql83DdRGWrwy1mQN22R
	8SQcY
X-Gm-Gg: ASbGncuqtmh3cUzIgz0ms7ECncQ4kskH8biFZef+LmJwTgRsJSJy+GxEZSmRy3GhCbC
	g+izPyBeGVJdMFDPBhlmWzKnxvP6xwce/KfFB38ed5cX0VSFcMN5r+Zv0WlRTBoTwSFT/JLuwn0
	U9LMOQW9IQ8rzmJgzUzTFtjplA8s4Zh/QwQG8VMADUquh6xrIQbh7jgE1h0/aYeXeFKXg0c7jUJ
	6flWPyqxRNeEn1LmGL7/kLN5stp5Lf2Gp+kVhXTpghUtjY+ZndKD2733mtA9kWnZNuKs6Hd0Yjm
	NTfl3TyzkMf0DzY3cBS4qSuXZWfYk2v9GaZeBPnBEuC0/2Q+Qj2so8eCQJN3eaC6FZPeUkJQQVV
	k07fvlZvuaa7g50RlUmiy9OgH+LwNsnOS1dckAs3PUVGSP+L3kDJBuTPD0A==
X-Google-Smtp-Source: AGHT+IFcTOET/gdirbR7ulY8RekMt7OMSfV1l5dnHmKT/NuEkW0FIbB2FKJIsT6nvYtvE2OtXaSIvw==
X-Received: by 2002:a05:6000:3110:b0:3d0:b3cc:c1ff with SMTP id ffacd0b85a97d-3d1de4bc2e1mr17930105f8f.39.1757062980901;
        Fri, 05 Sep 2025 02:03:00 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d66b013b7dsm19653105f8f.28.2025.09.05.02.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:03:00 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 1/2] io_uring: replace use of system_wq with system_percpu_wq
Date: Fri,  5 Sep 2025 11:02:39 +0200
Message-ID: <20250905090240.102790-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905090240.102790-1-marco.crivellari@suse.com>
References: <20250905090240.102790-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

system_wq is a per-CPU worqueue, yet nothing in its name tells about that
CPU affinity constraint, which is very often not required by users. Make
it clear by adding a system_percpu_wq.

queue_work() / queue_delayed_work() mod_delayed_work() will now use the
new per-cpu wq: whether the user still stick on the old name a warn will
be printed along a wq redirect to the new one.

This patch add the new system_percpu_wq except for mm, fs and net
subsystem, whom are handled in separated patches.

The old wq will be kept for a few release cylces.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 io_uring/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index c6209fe44cb1..2a6ead3c7d36 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2986,7 +2986,7 @@ static __cold void io_ring_ctx_wait_and_kill(struct io_ring_ctx *ctx)
 	 * Use system_unbound_wq to avoid spawning tons of event kworkers
 	 * if we're exiting a ton of rings at the same time. It just adds
 	 * noise and overhead, there's no discernable change in runtime
-	 * over using system_wq.
+	 * over using system_percpu_wq.
 	 */
 	queue_work(iou_wq, &ctx->exit_work);
 }
-- 
2.51.0


