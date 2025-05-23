Return-Path: <linux-kernel+bounces-660596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 128BEAC1FC2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 11:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACD894E7DA9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 09:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAB5225413;
	Fri, 23 May 2025 09:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ai-sast.com header.i=@ai-sast.com header.b="iLgNnpnO"
Received: from outbound.pv.icloud.com (p-west1-cluster2-host1-snip4-6.eps.apple.com [57.103.64.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF7F223DDB
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 09:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747992587; cv=none; b=uqFcfxIYe0YykuofgN21r52I84DHPvvWh7MxMqj9Ai5/l8cCs493ctSswuQGmBNErv7xGRBgTCw0k6VhRT+wyB06D+IVPdX3EJfnAFxT2QJOUcnv09gGa1LFypfcQ9F5+hDbSsfNkO58ZqmGkhudRcl9SKuxNXD/BWgeEyvHauc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747992587; c=relaxed/simple;
	bh=OrYDeqLb9L3FqLqRI4fBgydGfOLxMj87fQRbRXEFWn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TZtwjHkbSZpFQYEkJjNOirrzcO+ls/DcvT2saKg2oFtCMzYPoZc7QlLwGCei7otaAwk8TFZVrf9OftaeqFet/Rfk28T8SnJ8wN3LSwxbmZJOl0SIwtc6x4jeEMtX+URw8pFhbmiUa4rC5so4aGY13jVk1ExNZJze7FA1Z9ZXJNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ai-sast.com; spf=pass smtp.mailfrom=ai-sast.com; dkim=pass (2048-bit key) header.d=ai-sast.com header.i=@ai-sast.com header.b=iLgNnpnO; arc=none smtp.client-ip=57.103.64.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ai-sast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ai-sast.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ai-sast.com; s=sig1;
	bh=chPEdH003U8EyNzhIxlcFt/TxOyl8ajL3GUIh6TORUo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=iLgNnpnOdzkDzLVZu/l74HuRNbsE7MyEsWMYLOBe4wZKJ9O3jyF4Z4tPalNZDDSsi
	 /CVz6xU5AlvqIP4Pn+CnargGffvQQ5G4oXQSfiBSx/Qf51I2yGRe4pGdBlLlYXvyF4
	 X5+MnsNBcn/UUxo8OinNWfa5ICCxQX6HA8vaNRWNxrYAVpGRHMVQBbxhxohhD17N+z
	 qnYE7IB1mM4uU7M/femB2tJlOAJbDzDWISk18Ci7TClnl65zsYh/c5l4AJufwRo7oC
	 UxelA/c79vJblZvG8eFmeOZAVw7O+/4goqCMbbbP1yVCu1hsWgBkX0LZ/RjDAueOQ1
	 WRJdji97R96+Q==
Received: from outbound.pv.icloud.com (localhost [127.0.0.1])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 04FF01801831;
	Fri, 23 May 2025 09:29:42 +0000 (UTC)
Received: from localhost.localdomain (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 917EA1801EDD;
	Fri, 23 May 2025 09:29:40 +0000 (UTC)
From: Ye Chey <yechey@ai-sast.com>
To: cem@kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ye Chey <yechey@ai-sast.com>
Subject: [PATCH] xfs: fix potential NULL pointer dereference in zone GC
Date: Fri, 23 May 2025 17:29:31 +0800
Message-ID: <20250523092931.16976-1-yechey@ai-sast.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6Pywo7oa_3fGxJhUxNAAfz-4P7x8BNwc
X-Proofpoint-GUID: 6Pywo7oa_3fGxJhUxNAAfz-4P7x8BNwc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_02,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 phishscore=0 clxscore=1030 adultscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2503310001 definitions=main-2505230082

Under memory pressure, bio_alloc_bioset() may fail and return NULL,
which could lead to a NULL pointer dereference in the zone GC code.
Add proper error handling to prevent this scenario by checking the
return value and cleaning up resources appropriately.

Signed-off-by: Ye Chey <yechey@ai-sast.com>
---
 fs/xfs/xfs_zone_gc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/xfs/xfs_zone_gc.c b/fs/xfs/xfs_zone_gc.c
index d613a4094..ec87b5d6b 100644
--- a/fs/xfs/xfs_zone_gc.c
+++ b/fs/xfs/xfs_zone_gc.c
@@ -697,6 +697,11 @@ xfs_zone_gc_start_chunk(
 	}
 
 	bio = bio_alloc_bioset(bdev, 1, REQ_OP_READ, GFP_NOFS, &data->bio_set);
+	if (!bio) {
+		xfs_irele(ip);
+		xfs_open_zone_put(oz);
+		return false;
+	}
 
 	chunk = container_of(bio, struct xfs_gc_bio, bio);
 	chunk->ip = ip;
-- 
2.44.0


