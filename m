Return-Path: <linux-kernel+bounces-897685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68399C536DC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BDCF502C9F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A275934886B;
	Wed, 12 Nov 2025 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B50epT69"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E05D347BB5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963464; cv=none; b=DH/RC8B+pG5ybe+XWRY6YSVbiPNuUSxNBnHStGNp4fLQSLXe2JskH4QGvtv/kqVS3nN9Co1UiOM6A3LPwXgTsig6S6uJYb8IRyxCZo8uKyCY7vvjbb1r4pswvyvvSOJ+IhXO7QrPYnHV8Ckk8zCr++2jX1OZt+9krPIYpuKaucA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963464; c=relaxed/simple;
	bh=kh4isedaQC7r2sc6Zjcf8tsxC1mVuPPsYRKKcCEg44g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qhqoA0bDIBMrpztoWNV08SQwBcerFiJDUKfYHC+UHghj2KqUS1aATXlSzglEoyDvfQ83z+EL0AWgGOsGOLzhNESYTMJZ4RLPH10AXQF6Ps5HYIeKaJ2+ez/lfJ2x7sCG2nt4SpAsHZNsRj0VFig//uWGPbzM9h5+tAGiS7bdKqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B50epT69; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACFj7KL006355;
	Wed, 12 Nov 2025 16:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=+hDPt
	atHAjbURZ8hT3mb5FGrLiADvXzdJWmrLzarRSc=; b=B50epT69sadi7UmdF38wP
	yYYa2AmW1fsqL29etwWLoVmaC776NXB4QbX6NeQFqKpjfqbe6ciw9kjf8qPXTAaM
	WT1cfvutmikfTM213dLM8IApYb01cfaQbk6PrgRIL/MwV5QKmNqlUktZ6f+cqKA3
	cUvn4ABdgb/C36Tabk5hXwJIGm9apcMM5gPHGcYls7rusIi290dHgbHF2ewBMzu7
	YyfRTKw44UxfbT180nGlzrG+LvKBV0PRXKuS71cyKc20rV+6Vi3Jz4nR2rTh1pCe
	apDui7jEbDVfGF79WM0cOGVK2Gvc7Myqtjm9nqxKUH7ckcEpKbRdaZ11Net0Vw50
	Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acw5f01xu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEG4WZ018708;
	Wed, 12 Nov 2025 16:04:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaavqfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:15 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ACFxw3k004655;
	Wed, 12 Nov 2025 16:04:15 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-173-131.vpn.oracle.com [10.154.173.131])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vaavnq6-16;
	Wed, 12 Nov 2025 16:04:14 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v3 15/28] objtool: Do not validate IBT for .return_sites and .call_sites
Date: Wed, 12 Nov 2025 17:03:02 +0100
Message-ID: <20251112160315.2207947-16-alexandre.chartre@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyNiBTYWx0ZWRfX97+Ikv38wxv4
 UUwtMWfhBLV8BPm+algUCEspkTZge+UYTTxd442aMIlTgXaBas33O8jOs+yYMrn6DfEOblvVEUC
 IrzHb7qJcf0j1NBajig7r6NVnt8FErfjBS47bEPhSbrBQ36/PFFUpUZr1Hs8QnFasqXkqRxOVlU
 aFrBwT1/h94XzK9B7cE5oTvhP1Tmfi8+l1DzQAwUQz9AEuen9x5Rg8J4hyD9VbCGaUD7IPLda5Y
 DRgotcgWfveiLjNf+96jbcoV4f/ztJz7VOIHVBq07DZI++CyprWWWlkRxU7wBUFv7zauNN/SMrx
 zEGNauCIBCFY7B8s1ZyJJN5+bgZrCayDC2TtJUkjo9atEqsXLucF7S2mj9J0bJ4FhLm9wX8I0cK
 KKoj81q6phel7cDBU0O6o8+5DdT84w==
X-Proofpoint-GUID: rjKbl-oc68metcYyDYtlOOhGOWAl2jOo
X-Proofpoint-ORIG-GUID: rjKbl-oc68metcYyDYtlOOhGOWAl2jOo
X-Authority-Analysis: v=2.4 cv=Ju38bc4C c=1 sm=1 tr=0 ts=6914b000 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=yvIqsss6GtJD96b7xZoA:9

The .return_sites and .call_sites sections reference text addresses,
but not with the intent to indirect branch to them, so they don't
need to be validated for IBT.

This is useful when running objtool on object files which already
have .return_sites or .call_sites sections, for example to re-run
objtool after it has reported an error or a warning.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/check.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index de3ddb0fd6198..14b9220c1058c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4653,6 +4653,8 @@ static int validate_ibt(struct objtool_file *file)
 		    !strcmp(sec->name, ".llvm.call-graph-profile")	||
 		    !strcmp(sec->name, ".llvm_bb_addr_map")		||
 		    !strcmp(sec->name, "__tracepoints")			||
+		    !strcmp(sec->name, ".return_sites")			||
+		    !strcmp(sec->name, ".call_sites")			||
 		    strstr(sec->name, "__patchable_function_entries"))
 			continue;
 
-- 
2.43.5


