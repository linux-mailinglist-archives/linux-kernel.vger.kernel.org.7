Return-Path: <linux-kernel+bounces-621260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F121AA9D6FC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Apr 2025 03:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33FD14C3750
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Apr 2025 01:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291B51F55E0;
	Sat, 26 Apr 2025 01:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="AAdmAtym"
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C63C1531E3
	for <linux-kernel@vger.kernel.org>; Sat, 26 Apr 2025 01:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745630259; cv=none; b=KE55ooZ2IpRYUHECqiTK7R0SP97nF3k0+ZBhTdQhmbiJhl8LNQXjgyFt+A2Ks2zLsZr02m/hi+jG8CN30Y1T5TUZQKcUCH95Zu8zxpqvpp5MP+Qg0T2pSEWTA/qyXoWrYNgHd5MlmXPUuvVNf1ppJomao4jh04G8ZUWQnpAO9d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745630259; c=relaxed/simple;
	bh=vDrHtxaXCASrQzRkEIF0GNIz5C0/SSp+lBfDNtlXLYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O84YY5q2IlhvQhoaUctutURtmnNc4YUsJf8Dg9egLhzbOqZWR8Hy+vrEt5lJcir/BJur/2TCFd4Ou9XqXP6r7FOgEHo7Fp/WXn6mKHhVbpiQhz2I5AH/s78ouEkDe12EZQ2NZOF8w9xBODK8pZ8BiaGLGryptm8/Kz4juE7wyMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=AAdmAtym; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-227e29b6c55so4935045ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 18:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745630257; x=1746235057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kn7WNOBSA3+MlrBrNQ2tCaRe/xJOjXsGpS6QMvkVlSs=;
        b=AAdmAtymMYT6RkWIspfg4jaU79dleZrlXVaMBJa+7U4dgr5QWxWwYs8aLFjxWzlx2P
         7TxumkYglU2s+i5RV519Te73tJ1uMVPgqWLZaZTIs8Gi6x/7ZIqjsdz2Y8rDP2qVu5r0
         7y++kPXlXcnxCSrL1h/pxuqVnrcz4epU7NBRAFghUxIeiq5oK1jcFDsc/zVznSDD4pjl
         jOjnjsiTLkhuoR8RrtvzDwM4lSK8E095EDywwIWOmkGQPXMap3BYbTWdC6Q/GcpgGpqk
         5rsjWLfH7bLl5zbpjKB68paz9S07n72ZzU1LGy3Zj6+IRhzRPLC7mIdOEtaZyh6tEgCz
         Hhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745630257; x=1746235057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kn7WNOBSA3+MlrBrNQ2tCaRe/xJOjXsGpS6QMvkVlSs=;
        b=gJIhCI+yUZKOwzA9MDkYkUDJLr67qvat72DhGWvEylwQMjE/XjWyVmbR2ZMZU2xMBd
         /wipLRjvxP9xdDiDlqhm9fWtEIJpn0UNs7pGnMKEk80pbdCn+kKaIn1S448aSyHeI0E4
         /5s1ME4rnlTCdB7l6f/QiKJTpjg6C3lBcOOyAl/++5S3bR/ajQjkQUN5h71de+BgaVGl
         ndGKWlIrxGBk85IdATH0pnOoQ/5TAzXKTvvwBNMKLqrdeBxHfwKsdqbJmXs5tVcGBEzk
         I9DyYtUzVKmkyOHMXL5DnKIgw4sA1nDIEZWojxaWMlk3MmSJhYoCPDMHFguAEJW6JHIO
         8D5A==
X-Forwarded-Encrypted: i=1; AJvYcCX1LuUoBiEoL7yuAtEFT1P1CQmv+ggo/K5gzQwpe2YLpYmtD42VGpqn9pFmgiPWmbC7EepO8Fv0BF5OKxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXKjHiTEBwoUnNHS/p6hNNArF2vkbX0dGBOyhmBloCw2Tm99Ra
	eksapHAo9ykPiogQ1S/04dX1wKuTScu4BZlqkYd+7XuiunVUaBvcpkAdFgqdS+qcEM62FdA7Um0
	7C0Dskp9iD0vOUCWogI4myIbxAgoaZy0w
X-Gm-Gg: ASbGnctkgFmUD7RRcyWmg4Dl3jta+Si0sMd3fhCAMGAfT9g36/34tSq493+hFodIGbx
	Kw0gr94so/bbGZVe1iULhke4H562RtzM93+Sw6zF9ego1YqYmT5FMUFr2uB+oVfoCFOqT+cCoGA
	7NAq7Z8yrsIO2NaEyXa5GfEUg1jWN+CENm0OpDOCYAwzH04odUuQ5VysPO3MUS6DS+SvXmz+tpj
	b10iJ7ieLkrtgVaXZKGYhla5GDp81Ub847amCI4lyEB/B3JEFs7rEnF/UidGu8UCJlHZnr5GVJs
	lCcVyFxlbuQZTMkMXTQ4/5sfxun9t9PmVu1uwaj2FGGP
X-Google-Smtp-Source: AGHT+IGF8OjXCTgKiDS6URxBaFTTypnMe621FigXusTuihJwufzzZI1acv3nPcxmOKS5nrg/1xh6Agf7y3VF
X-Received: by 2002:a17:902:dac2:b0:21f:356:758f with SMTP id d9443c01a7336-22dbf5df830mr24444435ad.3.1745630256635;
        Fri, 25 Apr 2025 18:17:36 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-22db4df11b8sm2187395ad.49.2025.04.25.18.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 18:17:36 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 0B056340572;
	Fri, 25 Apr 2025 19:17:36 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id AA6C4E41BE9; Fri, 25 Apr 2025 19:17:35 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 1/3] block: take rq_list instead of plug in dispatch functions
Date: Fri, 25 Apr 2025 19:17:26 -0600
Message-ID: <20250426011728.4189119-2-csander@purestorage.com>
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

blk_mq_plug_issue_direct(), __blk_mq_flush_plug_list(), and
blk_mq_dispatch_plug_list() take a struct blk_plug * but only use its
mq_list. Pass the struct rq_list * instead in preparation for calling
them with other lists of requests.

Drop "plug" from the function names as they are no longer plug-specific.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c      | 26 ++++++++++++--------------
 block/mq-deadline.c |  2 +-
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 554380bfd002..fb514fd41d76 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2788,19 +2788,19 @@ static blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
 	if (!blk_mq_get_budget_and_tag(rq))
 		return BLK_STS_RESOURCE;
 	return __blk_mq_issue_directly(hctx, rq, last);
 }
 
-static void blk_mq_plug_issue_direct(struct blk_plug *plug)
+static void blk_mq_issue_direct(struct rq_list *rqs)
 {
 	struct blk_mq_hw_ctx *hctx = NULL;
 	struct request *rq;
 	int queued = 0;
 	blk_status_t ret = BLK_STS_OK;
 
-	while ((rq = rq_list_pop(&plug->mq_list))) {
-		bool last = rq_list_empty(&plug->mq_list);
+	while ((rq = rq_list_pop(rqs))) {
+		bool last = rq_list_empty(rqs);
 
 		if (hctx != rq->mq_hctx) {
 			if (hctx) {
 				blk_mq_commit_rqs(hctx, queued, false);
 				queued = 0;
@@ -2827,29 +2827,28 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug)
 out:
 	if (ret != BLK_STS_OK)
 		blk_mq_commit_rqs(hctx, queued, false);
 }
 
-static void __blk_mq_flush_plug_list(struct request_queue *q,
-				     struct blk_plug *plug)
+static void __blk_mq_flush_list(struct request_queue *q, struct rq_list *rqs)
 {
 	if (blk_queue_quiesced(q))
 		return;
-	q->mq_ops->queue_rqs(&plug->mq_list);
+	q->mq_ops->queue_rqs(rqs);
 }
 
-static void blk_mq_dispatch_plug_list(struct blk_plug *plug, bool from_sched)
+static void blk_mq_dispatch_list(struct rq_list *rqs, bool from_sched)
 {
 	struct blk_mq_hw_ctx *this_hctx = NULL;
 	struct blk_mq_ctx *this_ctx = NULL;
 	struct rq_list requeue_list = {};
 	unsigned int depth = 0;
 	bool is_passthrough = false;
 	LIST_HEAD(list);
 
 	do {
-		struct request *rq = rq_list_pop(&plug->mq_list);
+		struct request *rq = rq_list_pop(rqs);
 
 		if (!this_hctx) {
 			this_hctx = rq->mq_hctx;
 			this_ctx = rq->mq_ctx;
 			is_passthrough = blk_rq_is_passthrough(rq);
@@ -2858,13 +2857,13 @@ static void blk_mq_dispatch_plug_list(struct blk_plug *plug, bool from_sched)
 			rq_list_add_tail(&requeue_list, rq);
 			continue;
 		}
 		list_add_tail(&rq->queuelist, &list);
 		depth++;
-	} while (!rq_list_empty(&plug->mq_list));
+	} while (!rq_list_empty(rqs));
 
-	plug->mq_list = requeue_list;
+	*rqs = requeue_list;
 	trace_block_unplug(this_hctx->queue, depth, !from_sched);
 
 	percpu_ref_get(&this_hctx->queue->q_usage_counter);
 	/* passthrough requests should never be issued to the I/O scheduler */
 	if (is_passthrough) {
@@ -2912,23 +2911,22 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 		 * already know at this point that all requests belong to the
 		 * same queue, caller must ensure that's the case.
 		 */
 		if (q->mq_ops->queue_rqs) {
 			blk_mq_run_dispatch_ops(q,
-				__blk_mq_flush_plug_list(q, plug));
+				__blk_mq_flush_list(q, &plug->mq_list));
 			if (rq_list_empty(&plug->mq_list))
 				return;
 		}
 
-		blk_mq_run_dispatch_ops(q,
-				blk_mq_plug_issue_direct(plug));
+		blk_mq_run_dispatch_ops(q, blk_mq_issue_direct(&plug->mq_list));
 		if (rq_list_empty(&plug->mq_list))
 			return;
 	}
 
 	do {
-		blk_mq_dispatch_plug_list(plug, from_schedule);
+		blk_mq_dispatch_list(&plug->mq_list, from_schedule);
 	} while (!rq_list_empty(&plug->mq_list));
 }
 
 static void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 		struct list_head *list)
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 754f6b7415cd..2edf1cac06d5 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -713,11 +713,11 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 		list_add_tail(&rq->queuelist, &per_prio->fifo_list[data_dir]);
 	}
 }
 
 /*
- * Called from blk_mq_insert_request() or blk_mq_dispatch_plug_list().
+ * Called from blk_mq_insert_request() or blk_mq_dispatch_list().
  */
 static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
 			       struct list_head *list,
 			       blk_insert_t flags)
 {
-- 
2.45.2


