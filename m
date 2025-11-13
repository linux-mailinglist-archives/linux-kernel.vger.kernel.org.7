Return-Path: <linux-kernel+bounces-899879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2E9C5910D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 01DD44F7D12
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384A93624CA;
	Thu, 13 Nov 2025 16:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OqiyAS1j"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CD3361DD5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052584; cv=none; b=AuHWtDY9AC+TLAInRg8SGLuzCjU+NRkrTr6kNNbccKxJcXVLhZYqLv4bJXBM14GKb+MZFDZhamHZOis6d/toCuyb2iLwtUuw/NGuE83vj2aYnJJfYmSMXoQOYRW0KtCl84WXgeF2h+cJj+tiUF4tJIN1FJAkdE7h7MHVtHlt280=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052584; c=relaxed/simple;
	bh=CVdUBf+Wgi7dxn66PVbR1h3zdfzGRUACq+X+Gsf7sSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3pIUDyt/6ebsjGIbETS8HH3FKNyFkzN1e4RM85vQHtuOYC71vSHe3SGac1+BmLBzQul31rKBjyZplaJKZlJPzC9FM6kD+RwuyN1NKCl+UXBt6BclNO+nV4UUfLw/lBnBOdJJWJUWPjvGvFQLbm6BiyE6qNrQrQ7QjMmu2Hpl1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OqiyAS1j; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADE9uWr023921;
	Thu, 13 Nov 2025 16:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=2Pvki
	wZj0+fyLZUdBNms87y9ptFPtvpYZhWD/2eW3+w=; b=OqiyAS1jj6MH1t0SyhemE
	QgLvYUh0q2yL6lnXXsfkGdoRLKAwpN7ybBzGmu12cw6C9HSglaK3AiKSzeQC5pnM
	wSGQZpV2mHjO6ZfK9YEVDwuMI5b7koXXrCG6GUDLw6K39/Z86X2LU7kyinRR/X9r
	duO2eONa3Cl5H/lMPFYG/Dp2wkF5RZJ6EVl+kZHgUYnC48g7CEUD6QrVfWw3KIRb
	Ptxn5ZtGxfPXGfxyL9u5ZqJXy0xnINH3RVwIFoHaOk96dZddbdkQBpGhNJgnmeBf
	cXupZoc/IlanKLhKPl+wz10dOex52gArTsFnViZHVCd0h9rYtFBzubcLnQllaRfw
	A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acvsstnmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADG9pRF038873;
	Thu, 13 Nov 2025 16:49:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacc3ex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:35 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ADGnKA3008288;
	Thu, 13 Nov 2025 16:49:35 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-172-143.vpn.oracle.com [10.154.172.143])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vacc38f-10;
	Thu, 13 Nov 2025 16:49:35 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v4 09/28] objtool: Record symbol name max length
Date: Thu, 13 Nov 2025 17:48:58 +0100
Message-ID: <20251113164917.2563486-10-alexandre.chartre@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=bJUb4f+Z c=1 sm=1 tr=0 ts=69160c20 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=xKpiAcmDGk3KfUQPlkUA:9
X-Proofpoint-GUID: 0nDhnBPX1aNScVLej6p86VcyKB8ZDolL
X-Proofpoint-ORIG-GUID: 0nDhnBPX1aNScVLej6p86VcyKB8ZDolL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyMyBTYWx0ZWRfX5sKgLh06ipIv
 +vzSolBqXkdQgQ4J1nAQAASFr6x8IDfUa4RdkrTZWn3qlvIuwwDrKkZsvorFpKtB6oQNJxIbsEc
 3Y45OnRbQABNJS+uLb671n8spQsduxnrDCWKCi7giBIGnwGd+Hh+I66YzFr+jmwdInkUiLHB2g4
 mj4w+mLifxS/YKFoNcf1ertSIWbzOKYvulPqO9CgdiGwXG3vnXfIAAFHlOmIYbCCPqMVY6vq17U
 iG859vJmMQ2bu9V2uXYQiLVsutCfC3Wi7Rjl7fxkzgGeV5mj616wqXWsTIVjqfNkeM8G+5BEU4x
 P0vfr6hfVrJNLHlxf+9PaIEzPa9TCAI+RXa8cFALolMUp+xJvEnxAiouh5frIZ6NADUNXNVCpDl
 7Ld3/z1m3OQWItIwVWJY1fxmfZWjuA==

Keep track of the maximum length of symbol names. This will help
formatting the code flow between different functions.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/check.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 609994ad6ab41..1fd56e8afbfc6 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -35,6 +35,8 @@ static struct cfi_state init_cfi;
 static struct cfi_state func_cfi;
 static struct cfi_state force_undefined_cfi;
 
+static size_t sym_name_max_len;
+
 struct instruction *find_insn(struct objtool_file *file,
 			      struct section *sec, unsigned long offset)
 {
@@ -2463,6 +2465,7 @@ static bool is_profiling_func(const char *name)
 static int classify_symbols(struct objtool_file *file)
 {
 	struct symbol *func;
+	size_t len;
 
 	for_each_sym(file, func) {
 		if (func->type == STT_NOTYPE && strstarts(func->name, ".L"))
@@ -2489,6 +2492,10 @@ static int classify_symbols(struct objtool_file *file)
 
 		if (is_profiling_func(func->name))
 			func->profiling_func = true;
+
+		len = strlen(func->name);
+		if (len > sym_name_max_len)
+			sym_name_max_len = len;
 	}
 
 	return 0;
-- 
2.43.5


