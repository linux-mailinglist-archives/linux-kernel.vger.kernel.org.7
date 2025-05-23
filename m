Return-Path: <linux-kernel+bounces-660600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7824EAC1FD2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 11:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFF221BC720A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 09:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BB12253A9;
	Fri, 23 May 2025 09:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ai-sast.com header.i=@ai-sast.com header.b="buibqAwa"
Received: from outbound.pv.icloud.com (p-west1-cluster5-host2-snip4-6.eps.apple.com [57.103.66.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B697083A
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 09:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.66.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747992967; cv=none; b=J3uIkn3A1bHlAMXwpuyQbA1M4bn1OoCtw3OqjTN2ykFAsbFDPlWCw1m8kC9l9yNse1M5WcLb6MzlFhMVRpqJnRf0hv6bIdCPZTMRePuWb+Gbve4S5kGl2Zz7fJkyjlRsqa0/W9qlXpUqCMsewnz9KhVyu+W2C/IzGSRTExUy6rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747992967; c=relaxed/simple;
	bh=+Og7aBEda3gPq0RfB5PFxY6xLqwp/Aoc+gvqgDaSTQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qYwb/epUD4Tl+TATbZ1cZhSqE1cNa5OnubyeEwwkPJdx8widSRCw7dk63tJkp+Ur6LxsW0d8b/pkmTTR0atBkaXZW6C1ikcO36fxesCcWTp8eE1W+SxONvUtkjCBk32TuuhHEkquyN7viNfMfs1eNz4lSmt1GqzRE8F5yyfALkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ai-sast.com; spf=pass smtp.mailfrom=ai-sast.com; dkim=pass (2048-bit key) header.d=ai-sast.com header.i=@ai-sast.com header.b=buibqAwa; arc=none smtp.client-ip=57.103.66.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ai-sast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ai-sast.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ai-sast.com; s=sig1;
	bh=RYXA2vKn6ZR/Byqfx63L16xIChW71m4Xhy45GJ85kkQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=buibqAwaxQ1Rax53LFiLLAEf6CQM3D1/zHCGg0GAp2+9AWKievjh5J0AdNaAxSYs2
	 w9RI2eQVr31fgAHdA3dvfNW2X0Fjy8Kyk4jQR/ItII3ZdCzlW9DrdI/VAGMeD7sdFA
	 uDKkDulkH6u86lM6uaDY1eHYxR1D9YGrX2Xkkl0FmQMQcMqugCU6CfA9A7lI2BtODO
	 5wvE5ulpSgpo/gcsqqFk1ENAfGWjrvbLcnt6Fdn2y1FJjwKfEwjQOS7utfBYRC8Yzg
	 vwoVf1uEtA7ug1ur0qoTuzofJfGQcbcp83scnV3ctRfiWaqFeuw1k9n6brHu7D0bHt
	 nLmFP0uQrVB3Q==
Received: from outbound.pv.icloud.com (localhost [127.0.0.1])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 6B098180081E;
	Fri, 23 May 2025 09:36:03 +0000 (UTC)
Received: from localhost.localdomain (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id AF5FC18002E0;
	Fri, 23 May 2025 09:36:00 +0000 (UTC)
From: Ye Chey <yechey@ai-sast.com>
To: song@kernel.org,
	yukuai3@huawei.com
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ye Chey <yechey@ai-sast.com>
Subject: [PATCH] md: fix potential NULL pointer dereference in md_super_write
Date: Fri, 23 May 2025 17:35:54 +0800
Message-ID: <20250523093554.23182-1-yechey@ai-sast.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: U-dkdIBxQKuexYUPRuSzaByVK8F7_68y
X-Proofpoint-ORIG-GUID: U-dkdIBxQKuexYUPRuSzaByVK8F7_68y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_03,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 clxscore=1030 phishscore=0 adultscore=0 suspectscore=0
 mlxlogscore=727 spamscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2503310001 definitions=main-2505230084

The bio_alloc_bioset() call in md_super_write() could fail under memory
pressure and return NULL. Add a check to handle this case gracefully by
returning early, preventing a potential NULL pointer dereference.

Signed-off-by: Ye Chey <yechey@ai-sast.com>
---
 drivers/md/md.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 9daa78c5f..a0e2d90d4 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1002,6 +1002,8 @@ void md_super_write(struct mddev *mddev, struct md_rdev *rdev,
 			      REQ_OP_WRITE | REQ_SYNC | REQ_IDLE | REQ_META
 				  | REQ_PREFLUSH | REQ_FUA,
 			      GFP_NOIO, &mddev->sync_set);
+	if (!bio)
+		return;
 
 	atomic_inc(&rdev->nr_pending);
 
-- 
2.44.0


