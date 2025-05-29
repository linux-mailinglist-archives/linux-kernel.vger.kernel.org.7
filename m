Return-Path: <linux-kernel+bounces-666668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3857AAC7A5C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 10:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 201157A61C8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 08:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935F921C16A;
	Thu, 29 May 2025 08:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NgCwMIE9"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3009C21ADAB
	for <linux-kernel@vger.kernel.org>; Thu, 29 May 2025 08:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748508246; cv=none; b=T3REX3EqYVBm/fMia2kdHDeyJLQld/GnXfIRDgWVb+uzlbIDdQUOdcjsf4XWyTSDcd80h/DtWAPSjLZ7WNhAAGZWbCpcRHMXGu+LNajuAMwgqtarc6nSghxs2qaB/EUDW39ad48pktp8QeXvS09W1NgiWQgbcE+Hhhu7vOgjkPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748508246; c=relaxed/simple;
	bh=XmGdEU36BUAiC7kUZrGnekLq2NsKJ2cGEQT5mOw/Xbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vl3SguHfrjC+Kn8DS1fYppAJPnwv5nET9eacxN2EOoYWIzqDIlDw6jVRWXV/NLe/Uu4CDBgYdUHgmSvtnmru1o3NuOm3Tthx2TOHYhEqtPTutl1Uz/hhqPDF04C/X1VQ/yS/j+6SGKzCocYfGehdHqCkg/UauGRL78hJSZDeIYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NgCwMIE9; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54T7uEIf012665;
	Thu, 29 May 2025 08:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=w36aE
	uz2rTPydr4H8wvvcPpzatbtsXmBXQl9a/AhbNw=; b=NgCwMIE9oGE9EYx6Arr3o
	QUhkD0g9o9SUTU6VPwFwkCK/TgY9HSZH/nxaoyLWTfG62zvYePZhzcugRglBXr+E
	kryIRRFrqTDbesNP9A/ftEh5EDUnvXL7JoQyn5f1K6o4HwTuDroX8rXQMx+1RHF0
	Y1akowUlYpF6KjGgsbpakOtz/Zdk+kNbpKmXZFqOIYNvYr8W1zVCu9JubSMOCyyO
	lSpthwiuzgU4wMM1yM0Z9OQOoN484u8HO2OFj4OBoZ3Tpy+fLdnbhPHG5FL3N1Xk
	AWEiA7Cuz/Fs91PfsrloAx9zWB0AFIq1Ku7SR10spjz3y/ejXYYCPNwUnBywtebT
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v21s7nxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 08:43:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54T7JSx1023202;
	Thu, 29 May 2025 08:43:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jbe80q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 08:43:56 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54T8hsd4040383;
	Thu, 29 May 2025 08:43:55 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 46u4jbe7xf-2;
	Thu, 29 May 2025 08:43:55 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: david@redhat.com, mst@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
        virtualization@lists.linux.dev
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org,
        darren.kenny@oracle.com
Subject: [PATCH v2 2/3] virtio-mem: fix multiple typos in struct comments and function docs
Date: Thu, 29 May 2025 01:42:40 -0700
Message-ID: <20250529084350.3145699-2-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250529084350.3145699-1-alok.a.tiwari@oracle.com>
References: <20250529084350.3145699-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_04,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290084
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDA4NCBTYWx0ZWRfXwAYQ0N2XM1IX iS91jvKkFKASlidScYjxGC1t482nWvIVkwW5q+za4774/QgthWSDq2416z48ax4pWyRSKuNWWkx QqO35RYSGx2H9FSwM0/lvSMSGvvaxZEFAz6CScoALmq07dh8OVIoGMSCJQ8oj+S2IxHx/npqNKF
 icPtQKWZPlfEA6gKOf2QpYeAg6MnCp99Xtdy2cHU4kGWDBmax8agkBechsqLPXJ+xkAW2ROo3xd paUMgIbbIWL9raLyZl7fkEbZL/B0vDrDuj26RthyHrGrAaFnpBdPB2YJ98pEQyJFVwo2+yJV3QA ea88pCSxdj41l5VSDdjIgQSAQYonttc4Mq3ZcT58dUQVcnwQWLI0rXSSU1dlw7d6rOUopmUM7u1
 QZCZzF3U0LUBqfZGsXwrhA64uwnEAu8zX79cJTIF5LpJ9g97Wb0I5lieZ4jySnbnL0yLHFTf
X-Proofpoint-GUID: _uX3FlOrlrZ4-DTZxfawIYaQ1QxdC_sS
X-Authority-Analysis: v=2.4 cv=UvhjN/wB c=1 sm=1 tr=0 ts=68381e4d b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=g6tw7J_2hcjgWMFmvSMA:9 cc=ntf awl=host:14714
X-Proofpoint-ORIG-GUID: _uX3FlOrlrZ4-DTZxfawIYaQ1QxdC_sS

Corrected several spelling mistakes in code comments, including:
- "bock" -> "block"
- "valued" -> "value"
- "actipn" -> "action"
- "accidentially" -> "accidentally"
- Improved grammar in a few places for clarity.

These changes are purely cosmetic and do not affect functionality.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
v1 -> v2
retained original wording "getting onlined" per David's comment.
---
 drivers/virtio/virtio_mem.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 56d0dbe62163..90f7739858e0 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -164,7 +164,7 @@ struct virtio_mem {
 			unsigned long first_mb_id;
 			/* Id of the last usable memory block of this device. */
 			unsigned long last_usable_mb_id;
-			/* Id of the next memory bock to prepare when needed. */
+			/* Id of the next memory block to prepare when needed. */
 			unsigned long next_mb_id;
 
 			/* The subblock size. */
@@ -209,7 +209,7 @@ struct virtio_mem {
 			unsigned long first_bb_id;
 			/* Id of the last usable big block of this device. */
 			unsigned long last_usable_bb_id;
-			/* Id of the next device bock to prepare when needed. */
+			/* Id of the next device block to prepare when needed. */
 			unsigned long next_bb_id;
 
 			/* Summary of all big block states. */
@@ -240,7 +240,7 @@ struct virtio_mem {
 	/* An error occurred we cannot handle - stop processing requests. */
 	bool broken;
 
-	/* Cached valued of is_kdump_kernel() when the device was probed. */
+	/* Cached value of is_kdump_kernel() when the device was probed. */
 	bool in_kdump;
 
 	/* The driver is being removed. */
@@ -808,7 +808,7 @@ static int virtio_mem_sbm_try_remove_unplugged_mb(struct virtio_mem *vm,
 }
 
 /*
- * See virtio_mem_offline_and_remove_memory(): Try to offline and remove a
+ * See virtio_mem_offline_and_remove_memory(): Try to offline and remove
  * all Linux memory blocks covered by the big block.
  */
 static int virtio_mem_bbm_offline_and_remove_bb(struct virtio_mem *vm,
@@ -1080,7 +1080,7 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
 		atomic64_sub(size, &vm->offline_size);
 		/*
 		 * Start adding more memory once we onlined half of our
-		 * threshold. Don't trigger if it's possibly due to our actipn
+		 * threshold. Don't trigger if it's possibly due to our action
 		 * (e.g., us adding memory which gets onlined immediately from
 		 * the core).
 		 */
@@ -2124,7 +2124,7 @@ static int virtio_mem_sbm_unplug_request(struct virtio_mem *vm, uint64_t diff)
 	 * whole memory blocks along with metadata. We prioritize ZONE_MOVABLE
 	 * as it's more reliable to unplug memory and remove whole memory
 	 * blocks, and we don't want to trigger a zone imbalances by
-	 * accidentially removing too much kernel memory.
+	 * accidentally removing too much kernel memory.
 	 */
 	for (i = 0; i < ARRAY_SIZE(mb_states); i++) {
 		virtio_mem_sbm_for_each_mb_rev(vm, mb_id, mb_states[i]) {
-- 
2.47.1


