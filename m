Return-Path: <linux-kernel+bounces-897672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B8CC53527
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 99716357C5F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C456C34251E;
	Wed, 12 Nov 2025 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ikr+xjLf"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7703D33A026
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963450; cv=none; b=VV6tXJBainm06MlO6TeIGNs0K8ZzX0vBZzSp7UVcG/fXWaSUjkex593DTepcIcIIsEYFM6KL+2InFq84slfwsp/hCbwZTZV7M5loOao6xnGT6td+x3zhxRe1s7KAH/hWG6+Jz+spPj/yNPNX6lQD5n4RF6u6xoSQzwqweF8YUYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963450; c=relaxed/simple;
	bh=y+f42A7JvxwlCYs9lZRBZaYEuUvBOM/jlbSPz3pra4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vC0IxW3h73er20XQUxH/9t2bj+yfgyrIcuZtVG+IVYWtf13elz40H5xqkYdh3ieStS7Tqf85CSNqBluKpF2KjBEdBmdGv69yt4RiCxOixMENzHh5sMU91QaL5DaNYbYmO9g42LjqRkbCBpvomppFr2E1pyXvnWEgYAisyCdamOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ikr+xjLf; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACFWJh1012803;
	Wed, 12 Nov 2025 16:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=4P/PW
	B6DyanXCLPNsd1extPQtV24iAUr4mJbjPckT0M=; b=Ikr+xjLfLeNF3CfAtUWQQ
	k35cpTz0dQCaLRusiitiZIasFfapmYqaOsb29I+jFXXi2CKbLkgueemxNmxo3xRW
	ynvAcyqQcjlSzHONSWATzrtoSQqPOcvsplUBVx+7xgslfeIF5g5/o+i88BKr70aR
	UTLlGZzfMqZW6361msU7HZvVo4UtaLnAkH0fH99jCI4pP5Dby8sN4x/RFBkvqJfR
	UG4VG2rCIXb4TvWWJwnHmchy3FsmEsy0jN85zlRGJDa7qHGhDUVfKYB+PxbvNlnX
	eVpgzVwekpm17Rwfw3hSWbfW6LI1e++iJ7i4UVPdQ67Wn+e7jZY5+9ck028jhLg3
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acv97r6cn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:03:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEG3Av018617;
	Wed, 12 Nov 2025 16:03:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaavpym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:03:55 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ACFxw3O004655;
	Wed, 12 Nov 2025 16:03:55 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-173-131.vpn.oracle.com [10.154.173.131])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vaavnq6-5;
	Wed, 12 Nov 2025 16:03:55 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v3 04/28] tool build: Remove annoying newline in build output
Date: Wed, 12 Nov 2025 17:02:51 +0100
Message-ID: <20251112160315.2207947-5-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251112160315.2207947-1-alexandre.chartre@oracle.com>
References: <20251112160315.2207947-1-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_05,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511120130
X-Authority-Analysis: v=2.4 cv=Cseys34D c=1 sm=1 tr=0 ts=6914afec b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=gaUgYgG710qbGCIvUrAA:9
X-Proofpoint-ORIG-GUID: W9EQ5nRsRFEeWuw_G9oMYX4bFAMKcNTk
X-Proofpoint-GUID: W9EQ5nRsRFEeWuw_G9oMYX4bFAMKcNTk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExOSBTYWx0ZWRfX8+omib4eXBgk
 HBJNiJITdlRjTLRDnd3yKPGsHN5QUKfJpeiLE2Wi0LUs+ExPBzpHCk0X4CMOK1YCEptA98iGuWw
 hAKalHGkzENCIfKdoGQx4TZ7OF1vwgyGZpmYHd0f4PJN8CJDpoH7OJkPT/ML/xjs+eY4cCK0nS6
 /CW5Ogi8KwYnmtUVw9kq/QnezKWK7ACl+z4MtcSwK2tW2EUBYzJVjG9Ee+WTlbF3nJwSOj5duaK
 vptyJpuZgC7wlcbEVbbiV5ZxZ2WsYnmy5kLqPtkbbP1RRVl8kbTXkfRSst6nA6OO0nyuovN7Yqh
 /thFXtKmFbpvUkcJX8agBBcYIwzw40sR+QgQARZQW60pJhxjjyiAkeNgM1aVqmNc/JA90F2LDMz
 eD6gt+qxyTcIVhYsunwMDG58Md9rEA==

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


