Return-Path: <linux-kernel+bounces-899887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75195C59341
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3414C4EDC75
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFDA364E9F;
	Thu, 13 Nov 2025 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vy056PJ3"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE090342C9E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052595; cv=none; b=nCtAA04VRq42CWYW5phkb8BHU8kzZyJtI60Xb4tZbfIGotQtLfs03obqBqN1nrgaUNdh3h6auGhXpZjhr0X+m6/Owtv2wFvB3FyuXjdHiZtlnM7NBvdl2x+LpXjhYWmMSBXaiB/4E4Kyk3Y9WXqbL6Y4+mE9zUMoREudFknob6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052595; c=relaxed/simple;
	bh=8RtqaxDHlrQUHgvilvJPUgfHiqU6XiXvPA6YKdJMFiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYVSzImMLCC+DdItj9/9NgtgSUgyr87FI4TDy1yD6hCg2/ltar7qEIfKarUckCBdg7uqApyORR0qQbjhvky1H8tqZ/Ze2b3wrSUpKfVUZLLi6w2dLJ4MSCh6epOA3PEM7BV3BzOOQ5bIvtN6/dtH369bJ5M5lXoq75Q5cbHU+NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vy056PJ3; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADE9wLj024388;
	Thu, 13 Nov 2025 16:49:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=CAQP1
	9TFDDxrt0SkXNzDO71RH+/FAyrNChWX1/wVvdY=; b=Vy056PJ3wvWNWaKEaPeiS
	0FIXzTQTv+O7/mBHFrQQVTKi0veOi532VzLpN+Oyb9RXdKPZUV8FVHA5vdYvVwH4
	LOgmXqfb7u8KSyDo37lGwJBBV/XxEKF2esH18M3VXN5V46n18MiRDe1HS9MWNvUB
	iIWcoe8CIpCiFm1WSXjJlMXXn9NrHcJoWcBHHWsPkyiXaUCDHzlTXNPMPqdxNnZG
	hs9XG1QJ/beMrlXE+fda7KKh1SmyG/WXRK+R9zgObCytcF2co7LIXERratF+9PW/
	AUe5GpSCINciZzCwk5I/D+1TLh/PNwp/xREb/6fgvcYf0kjBukGAhcJKNAmDR5nd
	A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acyjta46s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADG6dhv039063;
	Thu, 13 Nov 2025 16:49:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacc3a8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:24 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ADGnK9n008288;
	Thu, 13 Nov 2025 16:49:23 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-172-143.vpn.oracle.com [10.154.172.143])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vacc38f-3;
	Thu, 13 Nov 2025 16:49:23 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v4 02/28] objtool: Create disassembly context
Date: Thu, 13 Nov 2025 17:48:51 +0100
Message-ID: <20251113164917.2563486-3-alexandre.chartre@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0OSBTYWx0ZWRfX4whS+0LZjeWn
 DJIPYtAZetHpsasaqWHOgbW+Qi7Oi5zVEizSPssRPT+WNLuz6JEkrqpmXRSjhWWoth4ki4KfSyx
 HToYjBpCF3w9kIEA3/eBlU7EgYhFB0kcj+A0umJqpGs7Sw/qOtibT7PguozgqSkvYdMSANcZtYe
 TjUgor9XFNdm5WASvj8vJjl2oKjI8pL7vGZhOQHkqcjkcAimiU/P6sDcf1PGfgLDDZcQxfYjbwI
 fTiFciSPGe3ScwVZg11e+X4+g3UktuumDSbq3d6WrUXFVAa8Vgns7Hv/Mnydv7Y+n3Gg7NxT3lU
 aBIkuS9d59K41/4rf9ZXprcCwOAmPN2HpjzxPil94ol2h9zHoN1N7tvfQ1TFPl6OQLOo8A6oxAx
 oGCG+BTHy2dxdYUAXIzfgN8iJvB/jw==
X-Authority-Analysis: v=2.4 cv=S6/UAYsP c=1 sm=1 tr=0 ts=69160c15 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=-R_vEHidSSj7PnaEDHgA:9
X-Proofpoint-ORIG-GUID: uk20vdrOyobfYaLBDAxhXmFlY89uGQ-0
X-Proofpoint-GUID: uk20vdrOyobfYaLBDAxhXmFlY89uGQ-0

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


