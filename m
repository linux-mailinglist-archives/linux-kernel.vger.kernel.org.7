Return-Path: <linux-kernel+bounces-864854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF177BFBB4F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DEB7583A70
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334303451C9;
	Wed, 22 Oct 2025 11:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bH7JCXy+"
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0AC33F8B7;
	Wed, 22 Oct 2025 11:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761133381; cv=none; b=ejvFi7XJ+ApXbT9i/IgeymOFcMLUZfDxa5HlhPn4jwyM5hzFzI9o5ILbSmSoKqrluYmiS09lRv2xTFpKZjeMFh4MCEuG4pmvxzi1mtJA1mSLr7dVFs+cXK6u1CbLtiXjJczxHBwbfn4pgqA5vX0nkAyJjo5EtOV8Elp/23YQgsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761133381; c=relaxed/simple;
	bh=As/CEf46/YeYB07VYuH9bVF61eSWzmj8AZoCzaoE0TA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hG+nm9xPKcG82oBSXXTD0kuwwLRz4pUVO00Du1MXFuyHFq+IaJKvM460Q9fmLDKWzl8RXpBhjzkGE/VDuvy6UItoTRXGATo4Vbvwi0gT4ZSkoayaeUXgVyVQ4xR0FRYwbYDX4COARwWkKYmZ+y4v+MoAGREzui2MIFXwBmu7WHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bH7JCXy+; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761133379; x=1792669379;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=As/CEf46/YeYB07VYuH9bVF61eSWzmj8AZoCzaoE0TA=;
  b=bH7JCXy+xHGbNGcfHo0sCUxdWR3yj42b6nLQdjgVg40KRnmXtsaOzU6k
   rA1KJIwAonLjPOl8nsRsbJsJSBaJBJ9sW4roiCgvPQ3/tfzdrQdhldmhy
   Y3SbmaS3ecVAtHLYEnFzw1WKAIeIBdt5sjFdZLQz1WmEsfxw1v+GrtC55
   8xbemVUHuWzqS1PMbezNwSqNQKcji0Qbe4f71xiDY7jLIC/CnoUPtFcTm
   vMgAnsXtRwQqzf7ZPyp6ECxb2peOHnkl9mBZUIGEPPLBVIbcOCqXtXcIR
   ZYVTy8/nbXp0jP+3XGAyYBSMzhIMKEfmJa03LFo30PccRu0De6RbirADs
   w==;
X-CSE-ConnectionGUID: z/2z3r6CRHmu9kOgt2X5/g==
X-CSE-MsgGUID: j9akQGNeRKSWpVoQetOTOQ==
X-IronPort-AV: E=Sophos;i="6.19,247,1754928000"; 
   d="scan'208";a="133602992"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2025 19:42:59 +0800
IronPort-SDR: 68f8c342_5bVtdsHGfYzWaqwGJXcCW8imSbxe6AOxWyhLQGyCCY+a01h
 G1L13LK+MF7C/0nrxBgGwy4L9yeeJ6tkhpksBbg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Oct 2025 04:42:59 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.49])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Oct 2025 04:42:53 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: axboe@kernel.dk
Cc: chaitanyak@nvidia.com,
	dlemoal@kernel.org,
	hare@suse.de,
	hch@lst.de,
	john.g.garry@oracle.com,
	linux-block@vger.kernel.org,
	linux-btrace@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.petersen@oracle.com,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	naohiro.aota@wdc.com,
	rostedt@goodmis.org,
	shinichiro.kawasaki@wdc.com,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 15/16] blktrace: trace zone write plugging operations
Date: Wed, 22 Oct 2025 13:41:14 +0200
Message-ID: <20251022114115.213865-16-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022114115.213865-1-johannes.thumshirn@wdc.com>
References: <20251022114115.213865-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trace zone write plugging operations on block devices.

As tracing of zoned block commands needs the upper 32bit of the widened
64bit action, only add traces to blktrace if user-space has requested
version 2 of the blktrace protocol.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/uapi/linux/blktrace_api.h |  5 ++++
 kernel/trace/blktrace.c           | 39 +++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
index 289872e51fc5..30f3d2589365 100644
--- a/include/uapi/linux/blktrace_api.h
+++ b/include/uapi/linux/blktrace_api.h
@@ -62,6 +62,8 @@ enum blktrace_act {
 	__BLK_TA_REMAP,			/* bio was remapped */
 	__BLK_TA_ABORT,			/* request aborted */
 	__BLK_TA_DRV_DATA,		/* driver-specific binary data */
+	__BLK_TA_ZONE_PLUG,		/* zone write plug was plugged */
+	__BLK_TA_ZONE_UNPLUG,		/* zone write plug was unplugged */
 	__BLK_TA_CGROUP = 1 << 8,	/* from a cgroup*/
 };
 
@@ -99,6 +101,9 @@ enum blktrace_notify {
 
 #define BLK_TA_ZONE_APPEND	(__BLK_TA_COMPLETE |\
 				 BLK_TC_ACT(BLK_TC_ZONE_APPEND))
+#define BLK_TA_ZONE_PLUG	(__BLK_TA_ZONE_PLUG | BLK_TC_ACT(BLK_TC_QUEUE))
+#define BLK_TA_ZONE_UNPLUG	(__BLK_TA_ZONE_UNPLUG |\
+				 BLK_TC_ACT(BLK_TC_QUEUE))
 
 #define BLK_TN_PROCESS		(__BLK_TN_PROCESS | BLK_TC_ACT(BLK_TC_NOTIFY))
 #define BLK_TN_TIMESTAMP	(__BLK_TN_TIMESTAMP | BLK_TC_ACT(BLK_TC_NOTIFY))
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index c83577096607..6bfe1b36a1d3 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1084,6 +1084,37 @@ static void blk_add_trace_unplug(void *ignore, struct request_queue *q,
 	rcu_read_unlock();
 }
 
+static void blk_add_trace_zone_plug(void *ignore, struct request_queue *q,
+				    unsigned int zno, sector_t sector,
+				    unsigned int sectors)
+{
+	struct blk_trace *bt;
+
+	rcu_read_lock();
+	bt = rcu_dereference(q->blk_trace);
+	if (bt && bt->version >= 2)
+		__blk_add_trace(bt, sector, sectors << SECTOR_SHIFT, 0,
+				BLK_TA_ZONE_PLUG, 0, 0, NULL, 0);
+	rcu_read_unlock();
+
+	return;
+}
+
+static void blk_add_trace_zone_unplug(void *ignore, struct request_queue *q,
+				      unsigned int zno, sector_t sector,
+				      unsigned int sectors)
+{
+	struct blk_trace *bt;
+
+	rcu_read_lock();
+	bt = rcu_dereference(q->blk_trace);
+	if (bt && bt->version >= 2)
+		__blk_add_trace(bt, sector, sectors << SECTOR_SHIFT, 0,
+				BLK_TA_ZONE_UNPLUG, 0, 0, NULL, 0);
+	rcu_read_unlock();
+	return;
+}
+
 static void blk_add_trace_split(void *ignore, struct bio *bio, unsigned int pdu)
 {
 	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
@@ -1227,6 +1258,12 @@ static void blk_register_tracepoints(void)
 	ret = register_trace_blk_zone_append_update_request_bio(
 		blk_add_trace_zone_update_request, NULL);
 	WARN_ON(ret);
+	ret = register_trace_disk_zone_wplug_add_bio(blk_add_trace_zone_plug,
+						     NULL);
+	WARN_ON(ret);
+	ret = register_trace_blk_zone_wplug_bio(blk_add_trace_zone_unplug,
+						NULL);
+	WARN_ON(ret);
 	ret = register_trace_block_plug(blk_add_trace_plug, NULL);
 	WARN_ON(ret);
 	ret = register_trace_block_unplug(blk_add_trace_unplug, NULL);
@@ -1246,6 +1283,8 @@ static void blk_unregister_tracepoints(void)
 	unregister_trace_block_split(blk_add_trace_split, NULL);
 	unregister_trace_block_unplug(blk_add_trace_unplug, NULL);
 	unregister_trace_block_plug(blk_add_trace_plug, NULL);
+	unregister_trace_blk_zone_wplug_bio(blk_add_trace_zone_unplug, NULL);
+	unregister_trace_disk_zone_wplug_add_bio(blk_add_trace_zone_plug, NULL);
 	unregister_trace_blk_zone_append_update_request_bio(
 		blk_add_trace_zone_update_request, NULL);
 	unregister_trace_block_getrq(blk_add_trace_getrq, NULL);
-- 
2.51.0


