Return-Path: <linux-kernel+bounces-899894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE6BC59572
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 19:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A414C4EC85C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B11363C7A;
	Thu, 13 Nov 2025 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UmO6xd/Y"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AE9368271
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052600; cv=none; b=K8b1WVecDmWkDFssvYO1HxMz4Mb5CEJGMmeK/+byStYaBDFJAxKx1Unm/rBUBlPetwpyjYRx8F45rbrctQ+KfbMvzEdzqppHBpumXPw316l+pekT5nDjZZCnjrUCAtRvpKnXGvZEOG6C93r4V30vxrEktZhOBIi/h0R2XGKJAJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052600; c=relaxed/simple;
	bh=8hK/J3eagHLSJX7FGwqPu/wqoJQoWFec06nic7DyRPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxurFSH5YO40Yb4ZPNADlsX3KjodHy6fmVCj9dHBu4PEhM+C2MRJqN6PgUFx6eoxXltnOJQyTBNtdVK+HhQIAg/tr4BZyAyyqHYEF5KgcPAJEz+s0wqf21MGJ6BzQ/C7U0jiWOFBAgAkXcsts0kWjqAX8tzmcuk2zR9RlnqgEK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UmO6xd/Y; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADE9wLm024388;
	Thu, 13 Nov 2025 16:49:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=+bERS
	0LC/NsnljbQk/9xyULPRD1sZXy5xfjhB435WzY=; b=UmO6xd/YLc8AKSEmP/19y
	ISlZqift+Qbr9BmKFxJF996qJpk1g4HgTQQPBUTKrSI00tGtQoY30L5133Oqs7hz
	3GK0W9jeZZtT74CHp9dzL9gGAKP0JC2dZtNkFGeU/TWWcWpMlegnq0Leva1WllvW
	9d1+I+MRDQOWxM+o6o5sZ1jWmMfeqrWZRpeq+Szhbu+Aul7Nk5qFZ33cQSRK8fMN
	PlmOL1dOKd9LKgN6ovdR/zNRkHA1ez+rcL/G53zLJMr7NMb+QWestWYKC3PsaL7r
	k0wRaxaLh4cPWoZMB7h1VgugRnXaM2iqcvjvKfG5jxOAKb3hVlNRUws6PeeeSply
	A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acyjta47g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADG6di4039063;
	Thu, 13 Nov 2025 16:49:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacc3n4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:46 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ADGnKAF008288;
	Thu, 13 Nov 2025 16:49:45 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-172-143.vpn.oracle.com [10.154.172.143])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vacc38f-16;
	Thu, 13 Nov 2025 16:49:45 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v4 15/28] objtool: Do not validate IBT for .return_sites and .call_sites
Date: Thu, 13 Nov 2025 17:49:04 +0100
Message-ID: <20251113164917.2563486-16-alexandre.chartre@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0OSBTYWx0ZWRfXxiqyTwA/9qNY
 P4pS50PjaeUG79QvTJb43sO7p9UnP4SyRuNSkf49KdVrlKaU80ewOcJC9LuYfMAx8i7fVwh5Adu
 qXkTPESmUIz64Bi96/hCPSSniz2Y6qo4NZQX3QqkVkTHgD+xSJJ8xr6FgBWPVsEccUtKuPgUHNw
 nVoTK1s4K7v9KPIJWU9DauKILWi5L4kWbT2zSEjlHXdWMamUS+hyObf1SUBmPqKvxR+Ks5FaoNs
 NUdVQdEroAoG6pzpJBnJBHY9FU063Cs4YV/Wbskde3olfGEhq1dHE5setwZwLa44YmM/UyKGX68
 HCz0+I6LUZmcOQzwlU0XtZqgOrnjS5BNMOp30uM9vBCwGBZQu1bZWjmyW1FdkgBzUMk/5ECruvC
 BI31ji+UJ48rjaZ036q4YVbPLyPuYg==
X-Authority-Analysis: v=2.4 cv=S6/UAYsP c=1 sm=1 tr=0 ts=69160c31 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=yvIqsss6GtJD96b7xZoA:9
X-Proofpoint-ORIG-GUID: 6LRi8_U2YbdDpL75F3rZhigS2nK9uwD_
X-Proofpoint-GUID: 6LRi8_U2YbdDpL75F3rZhigS2nK9uwD_

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
index 9321486e6265e..646cb7fe61b02 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4627,6 +4627,8 @@ static int validate_ibt(struct objtool_file *file)
 		    !strcmp(sec->name, ".llvm.call-graph-profile")	||
 		    !strcmp(sec->name, ".llvm_bb_addr_map")		||
 		    !strcmp(sec->name, "__tracepoints")			||
+		    !strcmp(sec->name, ".return_sites")			||
+		    !strcmp(sec->name, ".call_sites")			||
 		    strstr(sec->name, "__patchable_function_entries"))
 			continue;
 
-- 
2.43.5


