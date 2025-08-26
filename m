Return-Path: <linux-kernel+bounces-786894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E903BB36D82
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050E62A7375
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8B02D7BF;
	Tue, 26 Aug 2025 15:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p02d0fdD"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C40221FF25
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756221236; cv=none; b=KkXIDQPwVGx7CrMFxRsB//JrbYHJsRFnCZh65iJrhAjN7brGmVxZipo/SaxR7HJ7CAzkWA2efkMcLm4HQ482JzcQvGG2urPe12ee9P3SQOKmFzM1N5VzkD9ucRBSlNZ43NvKALlFDAOFH4SUvPT3NhQzcbaXtxneU1pxbV5Jm4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756221236; c=relaxed/simple;
	bh=DkRCJqnMM4jww8s5w14KNew//6BgyW0VKemUeA/8BvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gTWbFhHOQcXwqbXtqgvjLdT8mc39jzBuWePmAR19fuZASvpwmaIVW8/H2oSOqBNeBSaxBLvSI71jfZafRapdRrNGfE4nTNM0aulwlpCMDg7TFaa1QkvojPbYarD94Nhh9EILZQi1+bA5B+dV+4YMMvsP/77Um+rfkZ35IK6jUyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=p02d0fdD; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QFDDRI019284;
	Tue, 26 Aug 2025 15:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=NqcY609p1/QPUlesrUSagSKQZFPNH
	0BjM/RQfv6wimg=; b=p02d0fdD8qq7So40+bhANsa+w3v7fnrzenpRiCFcQ7WTb
	oioHF7HhFMAUZLmqXvxiLS2BisekZ29FuaZMgnSAsZUE/3XhTfp7wBhZiswNiaW1
	hzi1RdVJ4wJgG3D3+I9BILB1EP0W2MObkoHfeV6ITdGY/vAmTbg5ffKf0LtHQ7q5
	ynu8jvdc7TGgZdREjTIw18HtkwwW6jtHsjTvAL9bm47LUjtlBWU/mCbXCO1EI7Iq
	6o/b6Baq+w6WM4ZgjX0YaT/7T7Fi7p7eBwIeIXbJxY8TbU0T8XY/W+kvV4dTLAAU
	wuJAEThwEbhcHdzC4f6oAvdXocYX08mY2kfc5El/g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48r8twbee8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 15:13:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57QF6jBO012287;
	Tue, 26 Aug 2025 15:13:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48q439mxba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 15:13:48 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57QFDllX022738;
	Tue, 26 Aug 2025 15:13:47 GMT
Received: from sidhakum-ubuntu.osdevelopmeniad.oraclevcn.com (sidhakum-ubuntu.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.250.108])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 48q439mxb1-1;
	Tue, 26 Aug 2025 15:13:47 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH] maple_tree: fix MAPLE_PARENT_RANGE32 and parent pointer docs
Date: Tue, 26 Aug 2025 15:13:44 +0000
Message-ID: <20250826151344.403286-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508260134
X-Proofpoint-ORIG-GUID: Sju9f3nmqLMVoLWpTMp3KaLuAC17ctzP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI0MDE4NCBTYWx0ZWRfXzfIS+Th36Ku0
 lAyKcy/kxBpSnT7I97i2Y/ovGMWT06RRBKq8b1PqA9FNfcMJYhHs8iiA1CZAtY2VA1uj13czdQT
 sE1Z/3A9h0DxQJR/CygqR10oUSmb4vVKaamamOcjQlvraLmz1qnUwfP3exuInKekefdfxxFAIMO
 Pf8pV1j9rz195YOdgyLt2HGWinycDKWenkvNOAg2GWKKLJeiKPvY9ztrZgsG3A5xHtYIUb+r+VF
 dmdUBirFZjAPiw611ahGk8htBrD8Ohc7tnV+Tkvkk+XvO10nHIi+AUKgP95Pa9wN+HrbppZN3cW
 Rc1Urmx+mfbbnuwRqpb/+vGX2TlZ7dvTmAwEbTlJ5oabxy7q6NofMKE7/SMMl2xT4GrnJtgBXZc
 ER3fl5jKPfITBsgWaAy97mXiMO9hKw==
X-Proofpoint-GUID: Sju9f3nmqLMVoLWpTMp3KaLuAC17ctzP
X-Authority-Analysis: v=2.4 cv=IciHWXqa c=1 sm=1 tr=0 ts=68adcf2d b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=QCsb3DoeUs1ygUayxS4A:9 cc=ntf
 awl=host:12069

MAPLE_PARENT_RANGE32 should be 0x02 as a 32 bit node is
indicated by the bit pattern 0b010 which is the hex value 0x02.
There are no users currently, so there is no associated bug with this
wrong value.

Fix typo Note -> Node and replace x with b to indicate binary
values.

Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/maple_tree.h | 16 ++++++++--------
 lib/maple_tree.c           | 12 ++++++------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index bafe143b1f78..41e633264e51 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -57,17 +57,17 @@
  * MT_FLAGS_ALLOC_RANGE flag.
  *
  *  Node types:
- *   0x??1 = Root
- *   0x?00 = 16 bit nodes
- *   0x010 = 32 bit nodes
- *   0x110 = 64 bit nodes
+ *   0b??1 = Root
+ *   0b?00 = 16 bit nodes
+ *   0b010 = 32 bit nodes
+ *   0b110 = 64 bit nodes
  *
  *  Slot size and location in the parent pointer:
  *   type  : slot location
- *   0x??1 : Root
- *   0x?00 : 16 bit values, type in 0-1, slot in 2-6
- *   0x010 : 32 bit values, type in 0-2, slot in 3-6
- *   0x110 : 64 bit values, type in 0-2, slot in 3-6
+ *   0b??1 : Root
+ *   0b?00 : 16 bit values, type in 0-1, slot in 2-6
+ *   0b010 : 32 bit values, type in 0-2, slot in 3-6
+ *   0b110 : 64 bit values, type in 0-2, slot in 3-6
  */
 
 /*
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 38fb68c08291..d1d513bb6e95 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -405,11 +405,11 @@ static __always_inline bool mt_is_alloc(struct maple_tree *mt)
  * a reuse of the last bit in the node type.  This is possible by using bit 1 to
  * indicate if bit 2 is part of the type or the slot.
  *
- * Note types:
- *  0x??1 = Root
- *  0x?00 = 16 bit nodes
- *  0x010 = 32 bit nodes
- *  0x110 = 64 bit nodes
+ * Node types:
+ *  0b??1 = Root
+ *  0b?00 = 16 bit nodes
+ *  0b010 = 32 bit nodes
+ *  0b110 = 64 bit nodes
  *
  * Slot size and alignment
  *  0b??1 : Root
@@ -427,7 +427,7 @@ static __always_inline bool mt_is_alloc(struct maple_tree *mt)
 #define MAPLE_PARENT_16B_SLOT_MASK	0xFC
 
 #define MAPLE_PARENT_RANGE64		0x06
-#define MAPLE_PARENT_RANGE32		0x04
+#define MAPLE_PARENT_RANGE32		0x02
 #define MAPLE_PARENT_NOT_RANGE16	0x02
 
 /*
-- 
2.43.0


