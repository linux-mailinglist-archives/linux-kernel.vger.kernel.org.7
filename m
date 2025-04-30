Return-Path: <linux-kernel+bounces-626711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFA4AA465C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 11:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF614A0F4E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 09:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97140221F02;
	Wed, 30 Apr 2025 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JXA0JVx9"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D9E221DB4;
	Wed, 30 Apr 2025 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003868; cv=none; b=jd+18HRQh9HG50+ud68PKCh5eQ5ND/UUJI9uuIO7XG60KfQbWYRty2kmEwh6I9gDOID3Z999nxxuWsX/BiI2A1Lj+hAhulbBLRt3/UJhTvqAEJFgkAp0z7ygtOiZ+oG8EN8Ik7wf+/RHBa83o31oLZIkjMvOtV/0kpIwDeI7neE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003868; c=relaxed/simple;
	bh=sg4nP1vsmKRyIOjaBfvOLljwCcb3ODZxzVhxgr0uGp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MW0TV0JN1Ou0TwqNuUYEEArlA24F34EdeS2jpfsdeeCchDyL3HoNrF1yRE0e7mXpcwMdObqrihTo5UWoQ5ujEOVi/creKybeB417F14xa4yzLguFxbGXHkry9TpqzKt1N1ck+nRTL2OpUedp9F4BI+LzDgg9jxI0Ikf1sXMhj78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JXA0JVx9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TNkg4F028053;
	Wed, 30 Apr 2025 09:04:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kZmvUAuKXTdsxm2nV
	PwxC8EqEMZqr7IelCZT3bJXADk=; b=JXA0JVx93qGUJGvtmm/AnnbZX4LED35xe
	paeYvkAN3mYlCKrJWBqDcs74Ycttl4IV2aYrnALji5Y0m37+mepzbpb3wE5vbCla
	NgERwXeFmms25HXhabg2LqcVogVbMDVEQiG1quPW2bivtE8fTsDHt3xeeZ3pcrdZ
	Ouq6TXzTlXUvY7KB18UJr7pWY+un1Ccoa8l6T4ixDseyEqbFNY0KdS0pijhD3Zhe
	TstKGGqUgk2u/cCesNTX5WClVjUY+Frh5pcMEhjTPZq1hunncyfZ77vtxEXkLVor
	12hF2lmGQMFip7x7Wyn+WETU+9oZkny28r6SpeS3yvAnQJtzef4Qg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46b8r0sqmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 09:04:14 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53U941h6020790;
	Wed, 30 Apr 2025 09:04:14 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46b8r0sqmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 09:04:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53U7Ugv1031628;
	Wed, 30 Apr 2025 09:04:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4699tu79x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 09:04:13 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53U9497N58917316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 09:04:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9964820079;
	Wed, 30 Apr 2025 09:04:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE65B20065;
	Wed, 30 Apr 2025 09:04:06 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com.com (unknown [9.39.31.221])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Apr 2025 09:04:06 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, naveen@kernel.org, ajd@linux.ibm.com,
        zohar@linux.ibm.com, nayna@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] integrity/platform_certs: Allow loading of keys in static key management mode
Date: Wed, 30 Apr 2025 14:33:50 +0530
Message-ID: <20250430090350.30023-4-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430090350.30023-1-ssrish@linux.ibm.com>
References: <20250430090350.30023-1-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDA2MCBTYWx0ZWRfXxkwx/pBELxXi PUkHSRULFE+jO/gPAFl3QyEU+/snpcLYfpHt8hJ9aIlfM2HZk8MGREWd42y5l/df8XxBRX80kXD 4lCF4PAoAUskv9sGZ6yus8rFTfTmQpXqoiPMm2aApe79zfhBGFmlToCGWtKGbleZRMVKyPHUz6m
 7x3d+NqWPhrtmOnZU5fcgGhzqsnc/ppYDBdcLZnJA/tCDeyMKcBJLE89sO2AS8KmuUFlqeyZmjq eN+LzuV+fVSI/NmnYQO0dg9dA0F5ADVTuwsXd8ucBt/IROhmDbPPtWXc6NwivQ2pq3exihsjF7Z xCn8THK1T6nijoo2SFooJqQ5alsFJjTIS9Rrh6LKUpMgRvCqPjT0tI4bFCcfz0ivKxbHskkzdau
 li/xFQg2NeCFik9BNKBmxXD5RTMo3HtiqqKFSmwaNMJE3cJ81UFrDCJHZiyOMMavFi++OO/h
X-Authority-Analysis: v=2.4 cv=OqdPyz/t c=1 sm=1 tr=0 ts=6811e78e cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=AtMIOgTZpS777Q0Lz8kA:9
X-Proofpoint-GUID: YUFNTwMgtxTxrtbS7pwWlX3I7nRR7VGC
X-Proofpoint-ORIG-GUID: DnfyhYWRTC1PWnK5XbqbXaZbp3tDUmfB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504300060

On PLPKS enabled PowerVM LPAR, there is no provision to load signed
third-party kernel modules when the key management mode is static. This
is because keys from secure boot secvars are only loaded when the key
management mode is dynamic.

Allow loading of the trustedcadb and moduledb keys even in the static
key management mode, where the secvar format string takes the form
"ibm,plpks-sb-v0".

Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/platform_certs/load_powerpc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/integrity/platform_certs/load_powerpc.c
index c85febca3343..714c961a00f5 100644
--- a/security/integrity/platform_certs/load_powerpc.c
+++ b/security/integrity/platform_certs/load_powerpc.c
@@ -75,12 +75,13 @@ static int __init load_powerpc_certs(void)
 		return -ENODEV;
 
 	// Check for known secure boot implementations from OPAL or PLPKS
-	if (strcmp("ibm,edk2-compat-v1", buf) && strcmp("ibm,plpks-sb-v1", buf)) {
+	if (strcmp("ibm,edk2-compat-v1", buf) && strcmp("ibm,plpks-sb-v1", buf) &&
+	    strcmp("ibm,plpks-sb-v0", buf)) {
 		pr_err("Unsupported secvar implementation \"%s\", not loading certs\n", buf);
 		return -ENODEV;
 	}
 
-	if (strcmp("ibm,plpks-sb-v1", buf) == 0)
+	if (strcmp("ibm,plpks-sb-v1", buf) == 0 || strcmp("ibm,plpks-sb-v0", buf) == 0)
 		/* PLPKS authenticated variables ESL data is prefixed with 8 bytes of timestamp */
 		offset = 8;
 
-- 
2.47.1


