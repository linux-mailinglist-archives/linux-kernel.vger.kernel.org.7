Return-Path: <linux-kernel+bounces-897669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B62C53579
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5909B3576B1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA37339B2F;
	Wed, 12 Nov 2025 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mpa4YKhW"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD4F277CB8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963447; cv=none; b=i8hu9xBCaGTJfRlyxefYdavrtJJ1I2/dvtSv13vya8np5jTf595lS6EtLv9LXqWyEeshkh+SBGSM9x+yWnS9qteLmeEDZZ+2dFIJU9ORuYY87S1LzYzUqSrtoObCxrgNI77wK4FVH9ieP7pJuUNOJNTdnhuCxl3jeaYss3QcEMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963447; c=relaxed/simple;
	bh=8RtqaxDHlrQUHgvilvJPUgfHiqU6XiXvPA6YKdJMFiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m6aQj3fNnqeITeLAem/iQlnnojfU9L1bm9qcs9Xz8a5tM1cLfRHD82xw6UlqurlilV+Ylkpuwer0YvgAgW9aZM9zj8XlBLST1JsihGcOjD6rMEI1iILD1Gy7bGY0U4FnHBnWz/5Zc5YD71iPNeJsTnVBf7ecJHohJiAU/cNBZhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Mpa4YKhW; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACG02t8013321;
	Wed, 12 Nov 2025 16:03:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=CAQP1
	9TFDDxrt0SkXNzDO71RH+/FAyrNChWX1/wVvdY=; b=Mpa4YKhWIY/PS8m+fTr1e
	Fz8PpF96CV3Aokb6x6gD5gtAkZUr1rGD/DhvyD6b5S7H2cFUnznTHerJcVWERiIg
	A6Q3ceIFNfZABAblu2chuJ+vwPXzBpAP6JxeB+6UeIuYxJJPnKPi0Csk9225BUGk
	D3AgBaU1SNOGSrMncOQexyu+wPvLVg0ET+XHqrzsPvz72u9g/Ecs74MdZW648IdB
	lhkeusihDOHnhEp/AR73SSh/Lk+vOyPgUcvo4/2jqIF+2mm8coRdLdpbijoptTeu
	VkBG0l2IwvlZ2HFjg185hxq054fo8sl6whcEyEc44yE23J/WIAGajWVjRu2zCvS0
	w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acwcg007v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:03:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEG4ln018761;
	Wed, 12 Nov 2025 16:03:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaavpv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:03:52 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ACFxw3K004655;
	Wed, 12 Nov 2025 16:03:51 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-173-131.vpn.oracle.com [10.154.173.131])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vaavnq6-3;
	Wed, 12 Nov 2025 16:03:51 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v3 02/28] objtool: Create disassembly context
Date: Wed, 12 Nov 2025 17:02:49 +0100
Message-ID: <20251112160315.2207947-3-alexandre.chartre@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=XL09iAhE c=1 sm=1 tr=0 ts=6914afeb b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=-R_vEHidSSj7PnaEDHgA:9 a=EBa_rOYxF3VBboPlVeQ_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyOSBTYWx0ZWRfX2bGbMv3wNCd/
 rMfWHkoFghxE8NMOFVtA1mWcuLhd26jrpx7KKeivE7xwLRb+HoPYpu6qcA8IszVp7FhAgeCYr+Q
 uxDB3+dAHGhqYIBPNLEho6G8jysvG26nHZdPB2joWUOl7Nguz57c9ZXbqqytFDmIDTVrlpHzZKT
 ABBZP7UuBJjodDUE0mgmRN0YXhL4TFk/SOvXLe8t5z7yV0R8liVppOjAWR8pxXz3X9G5yc5z+b5
 mM9oykqdsMC3clmRx2KYP7rdNJXB6LJB8p5uxDdrHMf4B7NQwrM6S76zkFGzycLFI0S8SfPQFId
 gG00Od5zVcSVGEwf6jF8B1OXf0nJ1EQlVPvTxxUhiqgu+8V9exAtPWINNCFk9LlOT0vAMkixrCF
 J/qbS4KzfW6MELhwqZxdhu48Zd9aaA==
X-Proofpoint-ORIG-GUID: 0HjqzmgaKFUb3hRBYrBrECI-Em7JrFPf
X-Proofpoint-GUID: 0HjqzmgaKFUb3hRBYrBrECI-Em7JrFPf

Create a structure to store information for disassembling functions.
For now, it is just a wrapper around an objtool file.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/check.c                   |  6 ++++-
 tools/objtool/disas.c                   | 32 +++++++++++++++++++++++--
 tools/objtool/include/objtool/disas.h   | 14 +++++++++++
 tools/objtool/include/objtool/objtool.h |  2 --
 4 files changed, 49 insertions(+), 5 deletions(-)
 create mode 100644 tools/objtool/include/objtool/disas.h

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5207e62ab690c..7b6fa1e3e9aac 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -11,6 +11,7 @@
 #include <objtool/builtin.h>
 #include <objtool/cfi.h>
 #include <objtool/arch.h>
+#include <objtool/disas.h>
 #include <objtool/check.h>
 #include <objtool/special.h>
 #include <objtool/warn.h>
@@ -4672,6 +4673,7 @@ static void free_insns(struct objtool_file *file)
 
 int check(struct objtool_file *file)
 {
+	struct disas_context *disas_ctx;
 	int ret = 0, warnings = 0;
 
 	arch_initial_func_cfi_state(&initial_func_cfi);
@@ -4804,7 +4806,9 @@ int check(struct objtool_file *file)
 		if (opts.werror && warnings)
 			WARN("%d warning(s) upgraded to errors", warnings);
 		print_args();
-		disas_warned_funcs(file);
+		disas_ctx = disas_context_create(file);
+		disas_warned_funcs(disas_ctx);
+		disas_context_destroy(disas_ctx);
 	}
 
 	return ret;
diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index 77de46beb496c..8c751f3394865 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -4,10 +4,35 @@
  */
 
 #include <objtool/arch.h>
+#include <objtool/disas.h>
 #include <objtool/warn.h>
 
 #include <linux/string.h>
 
+struct disas_context {
+	struct objtool_file *file;
+};
+
+struct disas_context *disas_context_create(struct objtool_file *file)
+{
+	struct disas_context *dctx;
+
+	dctx = malloc(sizeof(*dctx));
+	if (!dctx) {
+		WARN("failed to allocate disassembly context");
+		return NULL;
+	}
+
+	dctx->file = file;
+
+	return dctx;
+}
+
+void disas_context_destroy(struct disas_context *dctx)
+{
+	free(dctx);
+}
+
 /* 'funcs' is a space-separated list of function names */
 static void disas_funcs(const char *funcs)
 {
@@ -58,12 +83,15 @@ static void disas_funcs(const char *funcs)
 	}
 }
 
-void disas_warned_funcs(struct objtool_file *file)
+void disas_warned_funcs(struct disas_context *dctx)
 {
 	struct symbol *sym;
 	char *funcs = NULL, *tmp;
 
-	for_each_sym(file, sym) {
+	if (!dctx)
+		return;
+
+	for_each_sym(dctx->file, sym) {
 		if (sym->warned) {
 			if (!funcs) {
 				funcs = malloc(strlen(sym->name) + 1);
diff --git a/tools/objtool/include/objtool/disas.h b/tools/objtool/include/objtool/disas.h
new file mode 100644
index 0000000000000..5c543b69fc612
--- /dev/null
+++ b/tools/objtool/include/objtool/disas.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2025, Oracle and/or its affiliates.
+ */
+
+#ifndef _DISAS_H
+#define _DISAS_H
+
+struct disas_context;
+struct disas_context *disas_context_create(struct objtool_file *file);
+void disas_context_destroy(struct disas_context *dctx);
+void disas_warned_funcs(struct disas_context *dctx);
+
+#endif /* _DISAS_H */
diff --git a/tools/objtool/include/objtool/objtool.h b/tools/objtool/include/objtool/objtool.h
index 4d3e94b70fd84..c0dc86a78ff65 100644
--- a/tools/objtool/include/objtool/objtool.h
+++ b/tools/objtool/include/objtool/objtool.h
@@ -47,6 +47,4 @@ int check(struct objtool_file *file);
 int orc_dump(const char *objname);
 int orc_create(struct objtool_file *file);
 
-void disas_warned_funcs(struct objtool_file *file);
-
 #endif /* _OBJTOOL_H */
-- 
2.43.5


