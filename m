Return-Path: <linux-kernel+bounces-617045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AD7A999BD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 22:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B79897ABFC4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 20:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDD927D781;
	Wed, 23 Apr 2025 20:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="StX+oTby"
Received: from mail-io1-f100.google.com (mail-io1-f100.google.com [209.85.166.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EC626B953
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 20:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745441497; cv=none; b=sHJOSWy1JQyK7gGV3cABPolheA12IO+fp4xOaegDuU9HHDwyaPs2hZMmUsH03aST3eddbIXRTOsM5POw0hPbDq1k98gUgLsUlvz0zCI0i1KkPcps7K4v6PBfiXION9I02vEreBAcV+N5vCfb8k7LercHbhTfUgBdkEErMvQ2JKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745441497; c=relaxed/simple;
	bh=lNtRTij/kdPLKZxepwEn5KKyU0DtZ6R8eX1YGzaUvfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5Mlai2crsafqNhVlrG7NweH9SvBGBScBPXkbSYiTyW0NK/oCCdS1A4ebkH7P0dCT0OiKXEjFa/QpOjss+xx2VPLlc0OoDCwiv0Qze/Foj02tMuv+0e4zQl+XTSEAvRh066GNnyNXw8FA9uJdBNl2Slnpd/H72bKv5GaPvhp2qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=StX+oTby; arc=none smtp.client-ip=209.85.166.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-io1-f100.google.com with SMTP id ca18e2360f4ac-8640c6163f2so1394139f.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 13:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745441494; x=1746046294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWHmi7U03uv5Tv+dtowxYZMDQUd28bYLC+apU9ROBaA=;
        b=StX+oTby8KA4Jk8Ni1M9sEF2VCEyG2iQSo8j8N3iHlWRGWzbJ4vr2Oz36sKsI3rWbc
         UyOUeyjwVJRV+4RZ/r6X4Q6yiyI8IQN5JHYgUCVfFsD5O7qBJEg+1Y/FXamnJCYXcyl8
         zWyyt5IOZ82UaoWVKxLWMNp/ENZ8vzxQ+UwrgnQrLUxiJ/GJ0gDqzuxfiG3jfhF7SPl+
         3Dot9Kxjq5RuiqpIS7UivETxTHVL35u+qcmegA7ZZgKnTu1inrDMEQaW4F2kR+bTPazy
         Fxa7rNNQC0I6a3vfJ0+YKCErKXNde1xUggIUBUjBlaIENK55GogciW2lrrxjvAEYNwti
         hDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745441494; x=1746046294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWHmi7U03uv5Tv+dtowxYZMDQUd28bYLC+apU9ROBaA=;
        b=WTOu3NHbUEqmmuPkM6kWb6vAaETXc1p04qqMIrQb/55diGbKyKWE66gSevant3fP1w
         4qXnR1Ov4h8WcgE3UnqSQ2Jx8XDcf3Ycep1b5mvqkuV5inzmnTfSZ1/C3ZMxufvP0Dqs
         6RzsBMLoAqrtjeKmfLepsvFPePuoPA63P/cv3+QqRjgTdhNZ3gDYg0u09YZdkHhrQz+N
         pkeV2joQ4euxqMxLSluZQBKCLxFJyX/2Bb7Vfj+OzsCiP9UgUNuPadjUc2MzV4F0365+
         VRXgrw+aeBfzRNULtqnNUGygVSzs4050mDQPIuku0Pq+uHB6fPsWijsTWsA73HhUfJpR
         XbEw==
X-Forwarded-Encrypted: i=1; AJvYcCWyI9aKCKLRJD1iyLxEz0nznlZshOiJ+Vknvr7Larp1veSCcl9nLYfd0O5CIDE6oiOOP21RH0QMrBO0wuE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7/YqlYJb15iIOvu90iqDSBUP2T3CCy70+5Am3QGvsh+5/oBbe
	xZyTR/83vXjauRWnckyy8k8kV/6HXQ6jKXBf/M4XqUtUGi9qjNOXx4/+xNTTUYQcjqNilNDl8ez
	4KDizXsYOPQvFGGNOwR11bNp9uJOc69r4WlvRmGoP/smx4vJ0
X-Gm-Gg: ASbGncshmPHP9/29AM7Xv3v+57huGSSPX22/exy5RVZvTQaj06sPRnd6ypmqH5gIZQJ
	tNYarAIwau6DgHSNaDnwkl0uED2Nibiv3mCroOMRX3eaWmCxFc0jqcJ/sKDwRxH2J1yzE69LPNZ
	YBMvaX5X8eP3W018Dq0ylps+gIpehVislWK98hTR8hcWqox0q7bI/BwrlljAhdr7aESK4+dMPQz
	EoLoONJfp+tgK7xzK4EvdfQOIGiXN2NgQeXd0qyJBY1Lt/AWvXT0zayPt/A0py2S5YZNacl96xr
	7Bo5DCPzB5NI44NK90GtUBph+8ZGpw==
X-Google-Smtp-Source: AGHT+IHqT55VMq3aAVcdjK3iZb2NqKPkeixuITq/SEY9d+tOugQ7pOMBgq9vEEkQYGym57eRPF+Lu7Z0EKnq
X-Received: by 2002:a05:6602:1694:b0:85e:12c1:fe90 with SMTP id ca18e2360f4ac-8644fabb3b2mr13521539f.5.1745441494124;
        Wed, 23 Apr 2025 13:51:34 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-4f6a393ab9esm483652173.58.2025.04.23.13.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 13:51:34 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id CA2CA34058D;
	Wed, 23 Apr 2025 14:51:33 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id C660EE42AD1; Wed, 23 Apr 2025 14:51:33 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 2/3] block: factor out blk_mq_dispatch_queue_requests() helper
Date: Wed, 23 Apr 2025 14:51:26 -0600
Message-ID: <20250423205127.2976981-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250423205127.2976981-1-csander@purestorage.com>
References: <20250423205127.2976981-1-csander@purestorage.com>
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


