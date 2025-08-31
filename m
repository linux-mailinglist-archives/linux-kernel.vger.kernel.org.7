Return-Path: <linux-kernel+bounces-793472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F30B0B3D406
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 17:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF75B17AF45
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 15:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6DE264A86;
	Sun, 31 Aug 2025 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fg1mDL7g"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6502635;
	Sun, 31 Aug 2025 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756652840; cv=none; b=E1+eGkinRQgDufcohIQNyP9iVsJqYNNllFu7T6zzNMdQCiEYmD1ZgVWUvJUIrC1zPxV/qIOk9Kqc5dJajpC/UQBOrPsGoAwQFLDU3UoezkjN5gZcVunh7DeQWUQgRBG45rCTf3vjNRKbh9begkdFr5Fg5iwD53WmVPydzt1jPE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756652840; c=relaxed/simple;
	bh=yTV2wjhkDfm25Fp5iDK5v5aI48ggTYgh2TVcsEvuPWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a/r2k6HQzest+kX3khp1bDifH/AkQ+GBuSFVcgkYzyJzW+ppw9tSh3wb17OP6zz1jUta946SAyaensaLhUCS5VNBg2ZNz/h6DFA5hRwD2SgyyapBo0qe7OYZ/g1yvBCV58kyoKFrollqRU/pHTAfM0GIHoSjlce7Eo8No56MWuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fg1mDL7g; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57VCoRX2002058;
	Sun, 31 Aug 2025 15:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=dNkoUnPG4puVUSoJqTTyN/b4BozRp
	WKA7B3AykXKud8=; b=fg1mDL7gZum2NHBsqW4wsQDCxxAtfi3kxlkFLDwfNFwTZ
	qYvizWBdGpilCInzTo0O5VevsArLvh2PRZIns8kRqMXYjnHf1N8O2ZBzJSa46pL/
	iPnMMj9IufWkY93Es2C2g/PzkHUWXEmoK6ttH43MlwjHKOLj/OyIkAap9FzdajQ3
	VLZ2jXjKZb5AlySfZMYaL1iX+/Do1p4xGR2Ip9wX3I+xWammezrUc3GNuvEVne3x
	sKHPwadYUBViSsR7II3nuFkawbsmF3U1nBpWEiBWhxeQ+tr/a8Li3nhC7/9OL2NR
	w9ZziOI2FBZldP9g5FpNYf6pvOmdu8gJ+/ORzeDrA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmn968c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 31 Aug 2025 15:07:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57VEt93f004260;
	Sun, 31 Aug 2025 15:07:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr7c7gd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 31 Aug 2025 15:07:14 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57VF7D4A020123;
	Sun, 31 Aug 2025 15:07:13 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48uqr7c7g5-1;
	Sun, 31 Aug 2025 15:07:13 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>,
        Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH] Documentation: dev-tools: Fix a typo in autofdo documentation
Date: Sun, 31 Aug 2025 08:07:10 -0700
Message-ID: <20250831150710.1274546-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-31_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508310162
X-Proofpoint-GUID: UKdF-vCp-6ulIfoRVNoP3OdZHD_8hzto
X-Proofpoint-ORIG-GUID: UKdF-vCp-6ulIfoRVNoP3OdZHD_8hzto
X-Authority-Analysis: v=2.4 cv=Of2YDgTY c=1 sm=1 tr=0 ts=68b46522 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=agUXu52olvX-UjPa_NkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX+LOuWJIcBZyL
 4YXGHl/kkUZn/9C1VtC9SjBl/1UsmRlpXPZcu2ZrV7OgPdHmigLFQ+Saw/f0Jk9JxsPEyqMGaH/
 R2e8651TDQvLOzqX1AU9/2cJ1o8rDsSVp3ZulvRJWBiPpjIgqp3JOs3UXopdoUVKCrk/jOGwKI3
 4hBwtF1Jea6iJkosKuQKpOZtgvK3MT5V4/S02cJDyuB/ckEzUegt8Qzv8uQnKSqZizocY7IaibV
 BVZfLqlaBWyiHdVb/SdzH2/iUmFlxuPwKts1tpurI4QFRPCKoAfF8+9SCxTO237JH7gIQfsNFIv
 PTz1O5YXwAupvI88Ei55nYEUxpxUZtLz6T5Ctpe6b9Pr4jjMJtb3B5OicvIOnwvWSQxaJsbAErI
 KlmcjBVz

Use cat /proc/cpuinfo as opposed cat proc/cpuinfo.

Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 Documentation/dev-tools/autofdo.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/autofdo.rst b/Documentation/dev-tools/autofdo.rst
index 1f0a451e9ccd..bcf06e7d6ffa 100644
--- a/Documentation/dev-tools/autofdo.rst
+++ b/Documentation/dev-tools/autofdo.rst
@@ -131,11 +131,11 @@ Here is an example workflow for AutoFDO kernel:
 
      For Zen3::
 
-      $ cat proc/cpuinfo | grep " brs"
+      $ cat /proc/cpuinfo | grep " brs"
 
      For Zen4::
 
-      $ cat proc/cpuinfo | grep amd_lbr_v2
+      $ cat /proc/cpuinfo | grep amd_lbr_v2
 
      The following command generated the perf data file::
 
-- 
2.50.1


