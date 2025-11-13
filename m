Return-Path: <linux-kernel+bounces-899875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DA205C593DD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E8E14F3E9F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D0B28725B;
	Thu, 13 Nov 2025 16:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jfu7wevT"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8202FDC50
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052579; cv=none; b=pi+Z+GkoQTyP8NlgeLB5XY4rOjvM8NMAPQmIV5ybOGGYzXsxiDbRMaKA8z69/J8NH5OdKyqpx4FR2Qi3FCLHqjn2G9YDLNQR87+ZmPMHtPAmEXEGO5LTPzuTm4tkiqarxouhCHRWeZU+myffTpD6dIJ7kOTX9unNsi74oohvYFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052579; c=relaxed/simple;
	bh=y+f42A7JvxwlCYs9lZRBZaYEuUvBOM/jlbSPz3pra4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9ykXzY+PowFmvb54oUe7zL8wIda5gfy2lKZZ7yC/I6mj9KXRkRPxYKIWHPT0flVDUSB5rwAYDXsZ/9OSub1O6ZWXa1lrnqMYwOsXzCEd7dWkcyr4XzLd+nB5+2T2FAvSfkJiB3ywHP9Pqz4BDKWdGhwAXWd/D38F+jr1srpb14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jfu7wevT; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADE9utE015549;
	Thu, 13 Nov 2025 16:49:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=4P/PW
	B6DyanXCLPNsd1extPQtV24iAUr4mJbjPckT0M=; b=Jfu7wevTEa0hGuT2patKF
	Dx9M577AGVPwM1G1slj56HuzD7y2G8WrgxZdDoa3dViAJ6tBcnRuXpqd4xY3NXvZ
	wqcm5IYNuiPIEqyIYYUhH7CjyLqrBAm3OzCO0p0bLyaHb7dgklw3BHVHnDxgNhaf
	m4Szlo3I9FBMkEJvuElzPE1TNbXhPIZrVdjLBMjO4x4Sz0osj83FUouHbKtyJyif
	Ma/XCgn1sKzEO3YwIjCu5w71y5QDSaMhJdjZBDyh+v9a0WVaa2l60OUQYteyo4ma
	b9GTgo/z6lFHyXMM/Z8XycbXjwAF+xqt/wRoLbXgvBZw9WigCfI9QcCsm7AW5nOi
	g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acxfvjak2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADG7MWs039422;
	Thu, 13 Nov 2025 16:49:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacc3b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:27 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ADGnK9r008288;
	Thu, 13 Nov 2025 16:49:27 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-172-143.vpn.oracle.com [10.154.172.143])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vacc38f-5;
	Thu, 13 Nov 2025 16:49:26 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v4 04/28] tool build: Remove annoying newline in build output
Date: Thu, 13 Nov 2025 17:48:53 +0100
Message-ID: <20251113164917.2563486-5-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251113164917.2563486-1-alexandre.chartre@oracle.com>
References: <20251113164917.2563486-1-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_03,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511130130
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEzOSBTYWx0ZWRfX1tMbs1nIVDxH
 WGyR4y5oHawMEaq7SaSvi8iwjIaTqCEJv6kgN7su6eLMcIfQmSkOJfcKRlZM5wEo27Twxf8lrZg
 Z9K5Ikgb4otYUBYFVdzkqn/N9NInycbqP4IQIbtHR6bwg6nrwjuE6NTiiFYPSnPiz+Lq3o3Qtxb
 Jucn+QNS3l9tY/GqIob/SCWUdfm6OLGrssUP+3l4G0LPRefHx570AMWuX1IKl25kQRGVqDY02sQ
 5i0qyCp1i80E2iJQkTVM60TeEu3aXtggNCEkiZEfLzuaQtwJcIQSlmZmkPWeR41W2MGRRp3ZNN4
 OE1+FUtNWGW2sle3I9BJ/Z1op/zjS5T9r2PAMCCE9tJKgTqAcSIigRJlZ3iykk2kOsPJNIKzTFh
 xw+zpBj1W9jTzTcCWS1DY9Vc6vbKEw==
X-Proofpoint-ORIG-GUID: zTN9VgTbzq13LngoH82GKvp7upzTT9ir
X-Proofpoint-GUID: zTN9VgTbzq13LngoH82GKvp7upzTT9ir
X-Authority-Analysis: v=2.4 cv=FKYWBuos c=1 sm=1 tr=0 ts=69160c18 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=gaUgYgG710qbGCIvUrAA:9

Remove the newline which is printed during feature discovery
when nothing else is printed.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/build/Makefile.feature | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 32bbe29fe5f6c..300a329bc581d 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -315,5 +315,7 @@ endef
 
 ifeq ($(FEATURE_DISPLAY_DEFERRED),)
   $(call feature_display_entries)
-  $(info )
+  ifeq ($(feature_display),1)
+    $(info )
+  endif
 endif
-- 
2.43.5


