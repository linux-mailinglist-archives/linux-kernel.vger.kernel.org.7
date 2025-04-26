Return-Path: <linux-kernel+bounces-621261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B34C1A9D6FD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Apr 2025 03:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E9D925246
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Apr 2025 01:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE58191F95;
	Sat, 26 Apr 2025 01:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="AMFMwdci"
Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com [209.85.210.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95EA19AD89
	for <linux-kernel@vger.kernel.org>; Sat, 26 Apr 2025 01:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745630259; cv=none; b=BJHUHcnUvzlWsvGweOr1Td+EL7SLby0mKVqPCYBFxbTkc0mXzYg7gBcdpx29tL/q/B/oYX4RrEpoaQTN74+uD0FCzPNhbiIuERY/ofxFDu70c5cAlb9uNM9QRW07BHnQ76/YTNLCsUZ6GtLVOcua2+BMYb1yfPLYWZe4t30VGcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745630259; c=relaxed/simple;
	bh=7Gq3wwrmMHKBA3zsEW0C8C//gz0mlIzt82TbCLdxWyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MUeZKX3SYdPjKcwGHkaj538057Io2Ji/dlkhDaMsZsZ+dLhQtwcqqP4Jp5/awrJRT9dscyRfds9CKXaGLOTRDUXYWAeldBn4qtgVxvKk6n7G4vrDzYO4foadPNcUEuoLP0oOCGxpuNLv5GRar1l5Mh+x9iH9RUfpJcfuXsFaQzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=AMFMwdci; arc=none smtp.client-ip=209.85.210.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ot1-f98.google.com with SMTP id 46e09a7af769-72b93770ba0so267770a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 18:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745630257; x=1746235057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQQLXKvkPDoUVqHziv2SJ8rfj54eLgcHoYOfmOv7bJ0=;
        b=AMFMwdci63SZVZ7BjCIRDJNawW9tC+bZNpiaTi175otDWltGVr28/VLC5ejB99d1Hb
         0OLTnfJgdn2Zew/MYrswOTLq9JxEnCe3H0wHg2I1Q8JFEjkkqBfTlHmcmFCnXQBN711x
         WA0iemEddS7GCKeM4bX2Wn3SRaQNW4zTxw9ETfZ6eNqoIfpeLhERxsxk4w1QjXoDQQfr
         2yKzl7/Lqx2cOXW98jI4QWJ10ESDoDX3xXuUId/ydMgKK3CF73tVVgis2fw8hZX1X5ua
         kBHFMkMo2/P7LpacNRn9qKnpu+UYy1HxtiGrClGnSL+0tQ5zKZsDHB3Dgvbos7dveuUx
         GUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745630257; x=1746235057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQQLXKvkPDoUVqHziv2SJ8rfj54eLgcHoYOfmOv7bJ0=;
        b=CZ60a+5z5rnVcdNZrWjxdOLbtJaEu+71CvfwTLb1fPktKLs+vXQYbUhB/5dnJekHQu
         PnCl7KU7HviCOMeUfJW46hbP1XtH2Ml+f4Th8od+R6qA5/HCTPUWQ4+Aulm0Z/YDpbaE
         xI8rRCHOMDYLEFFtD8xoc93wzClGlrDFUCCoDqjjBbsy4/4S3CCk2pYK6u5kC1E6+vzb
         Rnwru94C0MqaLPerz0osHjBHu7js5ZxazMcRpuG1JcVBGEWPeLAi3TUpOhZgAiqwrHY2
         +y6GPzJ3ghg3rLsnEA8/WeFx7M2WIxECcOjBuWB7yKWaamLvzzRdqEBEy/3IhOZTJ6Si
         4VlA==
X-Forwarded-Encrypted: i=1; AJvYcCUMUd2PYwQe0hXC0kKoAMVKIUCdJUnxxf4oQUh8h3e88QFOOegKBk8mtOCzGF5uzEwKMwSxgbn1845k1Wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCOPC/q6+jfSllMBwMNPilv0B+pfShLMId9jbpFYFZAq1LL4Fo
	jnTXPLtw3QMkJNnr3FFL7C2R4szGFfcrjXQeDAicpOgd9mrmy/+kN6m1UkN/Xhckl5QezLxDXpX
	BJmHFbB8oslOjAtyDZQQA6W9CoqFd1Uex
X-Gm-Gg: ASbGncvdJhsyfgEQdwewxjj0umT7h2MH3JyjB6yfMr7wJNvvWatXfCDgTH/Y35cq8xV
	ypmg7tICBX6dLnMZ0QlBaie/Ioh1lfv6Rfs/gy+10Xm+iaWMKfFHZ9sTd7tYtWOcwCrJvu6gBpp
	wOLoULv0zBh9mnPZqR+FqeOjym1MPcGDFot9RmV4A8JOhRygSwQdvzckGC63FV3l7EdZhNqcFCR
	pejq5FYEoE8HRErEf1by7al2K2FWMb9Ua5AQ/7U0wwlMCMr1qjgLwN92v4dD7mY0PbD+SlCFOJK
	pL50uMXNnfLaZB/3AF3ztvAEosYHme0KXPHspzrr+S/D
X-Google-Smtp-Source: AGHT+IHXP7V6kKd4jmPTmsjz5FjMWXaru01e0xXLDD7oOeyxuDoFtEBZnBnDtZ6TKjJSid7gKI4g+NNRbWqg
X-Received: by 2002:a05:6871:7420:b0:296:9146:f455 with SMTP id 586e51a60fabf-2d99d8602eamr828101fac.7.1745630256855;
        Fri, 25 Apr 2025 18:17:36 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-2d9756b17b9sm174106fac.22.2025.04.25.18.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 18:17:36 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 25DC2340615;
	Fri, 25 Apr 2025 19:17:36 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 2398FE41BE9; Fri, 25 Apr 2025 19:17:36 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 2/3] block: factor out blk_mq_dispatch_queue_requests() helper
Date: Fri, 25 Apr 2025 19:17:27 -0600
Message-ID: <20250426011728.4189119-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250426011728.4189119-1-csander@purestorage.com>
References: <20250426011728.4189119-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out the logic from blk_mq_flush_plug_list() that calls
->queue_rqs() with a fallback to ->queue_rq() into a helper function
blk_mq_dispatch_queue_requests(). This is in preparation for using this
code with other lists of requests.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index fb514fd41d76..a777cb361ee3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2834,10 +2834,31 @@ static void __blk_mq_flush_list(struct request_queue *q, struct rq_list *rqs)
 	if (blk_queue_quiesced(q))
 		return;
 	q->mq_ops->queue_rqs(rqs);
 }
 
+static void blk_mq_dispatch_queue_requests(struct rq_list *rqs, unsigned depth)
+{
+	struct request_queue *q = rq_list_peek(rqs)->q;
+
+	trace_block_unplug(q, depth, true);
+
+	/*
+	 * Peek first request and see if we have a ->queue_rqs() hook.
+	 * If we do, we can dispatch the whole list in one go.
+	 * We already know at this point that all requests belong to the
+	 * same queue, caller must ensure that's the case.
+	 */
+	if (q->mq_ops->queue_rqs) {
+		blk_mq_run_dispatch_ops(q, __blk_mq_flush_list(q, rqs));
+		if (rq_list_empty(rqs))
+			return;
+	}
+
+	blk_mq_run_dispatch_ops(q, blk_mq_issue_direct(rqs));
+}
+
 static void blk_mq_dispatch_list(struct rq_list *rqs, bool from_sched)
 {
 	struct blk_mq_hw_ctx *this_hctx = NULL;
 	struct blk_mq_ctx *this_ctx = NULL;
 	struct rq_list requeue_list = {};
@@ -2881,11 +2902,10 @@ static void blk_mq_dispatch_list(struct rq_list *rqs, bool from_sched)
 	percpu_ref_put(&this_hctx->queue->q_usage_counter);
 }
 
 void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 {
-	struct request *rq;
 	unsigned int depth;
 
 	/*
 	 * We may have been called recursively midway through handling
 	 * plug->mq_list via a schedule() in the driver's queue_rq() callback.
@@ -2897,30 +2917,11 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 		return;
 	depth = plug->rq_count;
 	plug->rq_count = 0;
 
 	if (!plug->multiple_queues && !plug->has_elevator && !from_schedule) {
-		struct request_queue *q;
-
-		rq = rq_list_peek(&plug->mq_list);
-		q = rq->q;
-		trace_block_unplug(q, depth, true);
-
-		/*
-		 * Peek first request and see if we have a ->queue_rqs() hook.
-		 * If we do, we can dispatch the whole plug list in one go. We
-		 * already know at this point that all requests belong to the
-		 * same queue, caller must ensure that's the case.
-		 */
-		if (q->mq_ops->queue_rqs) {
-			blk_mq_run_dispatch_ops(q,
-				__blk_mq_flush_list(q, &plug->mq_list));
-			if (rq_list_empty(&plug->mq_list))
-				return;
-		}
-
-		blk_mq_run_dispatch_ops(q, blk_mq_issue_direct(&plug->mq_list));
+		blk_mq_dispatch_queue_requests(&plug->mq_list, depth);
 		if (rq_list_empty(&plug->mq_list))
 			return;
 	}
 
 	do {
-- 
2.45.2


