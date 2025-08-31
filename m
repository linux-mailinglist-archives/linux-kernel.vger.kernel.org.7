Return-Path: <linux-kernel+bounces-793474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE8EB3D40D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 17:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E87C47AE455
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 15:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831B626D4D4;
	Sun, 31 Aug 2025 15:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F3RK7huB"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6644E2475E3;
	Sun, 31 Aug 2025 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756653085; cv=none; b=TiuPh/4syZrPmWFitewlEftc0Bb7kPxh+6FNCLmCVMn6oy01P2HedlDZRBNL64yjUtN3xXo99bBcXgxhjlkDH/xWVmoLtDzzbAH/HmzurgfElGVW1OVHUa8f5bXYAoELXN6uAQIjFY2Nh23FSlGRD1bt8hkUkPrMfiDxBgmQ3ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756653085; c=relaxed/simple;
	bh=aoAkFeodl/HwM82mrz30Whx5EF1oZmvZS+XrtpmnKDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LdNOVsgvMmcAsQ+3b/JnlKeZK9Z0MgSr8bWRosfoL+h4Ijt2tQhFf0b3XT7MRkLdAe9DMDmtVtAcoWAwosHtMurpSrGAYaxN8zuGMnW1gaLSxL9AXegC7NGu92BQUylueoatxOUFatKjP3aRdy4k+kaRC1EtnPXfawORerLZCys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F3RK7huB; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57VBtsPO008008;
	Sun, 31 Aug 2025 15:11:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=RjdvhbNbTB7VPLeStEcWkLeD5smHr
	+LeezI0ulHQlGI=; b=F3RK7huBOb28daUU7OfVrcd5kxN+YkFcJEgOUN2eHt1hg
	eQgUlZBafmx/5Ln3+fKYqOM2JlTh7YEXqRqRlXfN8MOxonHvL0BHPNptq6V/jWyL
	As+Nke4kR/v2rjqlR9bh7TI180rNqvtgXHzEmGZDUvv9keV5AbEaCxQpU8UWFQ6T
	V1Z/gPHyn8b88E6Z9FaYkyMsoutiMiIb2m9oblfQ8QwsiRdsEOS7aWYSRQMwAe25
	06+TVKIMa0Du9XDHEtNV14qw91IrZWdJQgZA4ds4ACGiiI1qeNWy3V+JI4G3+trS
	aLBIfUlQ4Txyer0rnBwlvb/SqUG/5LLn4eeekhXiw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmn95ur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 31 Aug 2025 15:11:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57VB7NtM024906;
	Sun, 31 Aug 2025 15:11:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr746t8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 31 Aug 2025 15:11:21 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57VFBKU9006376;
	Sun, 31 Aug 2025 15:11:20 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48uqr746t4-1;
	Sun, 31 Aug 2025 15:11:20 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>,
        Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH v2] Documentation: dev-tools: Fix a typo in autofdo documentation
Date: Sun, 31 Aug 2025 08:11:18 -0700
Message-ID: <20250831151118.1274826-1-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508310163
X-Authority-Analysis: v=2.4 cv=D8xHKuRj c=1 sm=1 tr=0 ts=68b46619 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=agUXu52olvX-UjPa_NkA:9
X-Proofpoint-GUID: JkYxUx6SL9-CNbqZiufx3CzomIrtPV_E
X-Proofpoint-ORIG-GUID: JkYxUx6SL9-CNbqZiufx3CzomIrtPV_E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfXz0zXIWYCbNrg
 7eRf0srX8/DLB8VJ6hqi5BAEZKvUERe+KhfriFf5+lZC0C0NQqRTqj8WKaA0ifWzE8J7qVvaOWT
 4Z5u43HHrOjVVhZcb9ZkWCV6PluDy5TUhRYqkpsFnfHE3dTZnOs+D99Wtcu00yBT5FxrWoyPz1H
 sAn/TL0Gt/XlxFP0TuWZhdx8aVcuNYoeT5jmLYPyf0XcHlPIn/aMnoH8O6jWjbPrEZ9Nsferqc0
 KeKQ8g2BIAy3LegVirDmKH8+MtUEsVhg3eDIrx1nsI/qZla6Es/u1oMQK3DRGXD92j9TFqgRxIH
 ysnC9uBYfph/YD9TaNxqlIB4QQDqwpxp1zEXZKlyHGPtQsS5Umst3d6KMg/Xdh2Q4p1Sm1EnJa3
 983DzoWh

Use "cat /proc/cpuinfo" instead of "cat proc/cpuinfo".

Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 v1 -> v2: Fix a typo in commit message.

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


