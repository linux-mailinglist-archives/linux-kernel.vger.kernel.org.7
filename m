Return-Path: <linux-kernel+bounces-897670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CECF4C5354B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 34B1935459B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A66133CE92;
	Wed, 12 Nov 2025 16:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dZ3I0KFH"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9006123909F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963448; cv=none; b=AN1zhvq/kwQqDeyHZpJ7nrFKQ7E+7aCCbZD6GygqB3JR7O8bSGojCuqonCIm9YbTWwmZciT3IoVssMYgHwu0VTvDui4NHoG8biCeFhHbZUtzRNqL/qCoG/Mg2YmlGn52B+M4gPbCin9UdcxsbKPNInMWQ4g2gsgeuEFBrvT1vRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963448; c=relaxed/simple;
	bh=NW9ODej7ximkTYrc6vBqdXhJRqxG5v0OGwgjDFKhrUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VLdrLFN+tQlZhbaPIZZybG+QjQ/q5Gsd36EweDH4rzQ/HXsj48NOtPeDsflyp/ljR9bhdlx9YB1O0Kw879ZzOHWabJR5vHPIbkoZE0ALQkBJ0IBHrc1KEhA0Mn2LAwVg8fa5kuLJiGj1NluhGbS4clxdCcMXwV+wAoYk4sVlfoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dZ3I0KFH; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACFRN9t007907;
	Wed, 12 Nov 2025 16:03:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=h8SBH
	nvcaPR/IKOBM+v6EDFM9OxNcNCr5nG/59SC/gI=; b=dZ3I0KFHf3Xp8427rZVk+
	CGdWtL4EXVh7CidQ07MHuE/7o3gsuPKsebV1wg5mXy2CIZGUG+XORZBdnzxx5G+X
	JeQIza6Ct6HxOVTU23YjOvbfBIz3e9ie3F0ry5q8rUN+cPK2YUH6f5RmFi5/Kv/w
	DYMARWuXrGjis9zds+ilutRgzRG40NtjeE0oCUH0bw3e60OtshoTQKvTw2YUslzI
	eKbBZUa71UK+LCCFyFC/OhkgCQtXjaY45R7kMMUK+EEQMjXPsySo59kvqUHjfT5t
	QCrGHzfgEGvHKWhYaJrsvj9ILFx0MVRBL0QvC0fxxGIS+ZyIju0jjwchtPhtLxVn
	Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acu650dhs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:03:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEG3mU018584;
	Wed, 12 Nov 2025 16:03:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaavps2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:03:52 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ACFxw3I004655;
	Wed, 12 Nov 2025 16:03:48 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-173-131.vpn.oracle.com [10.154.173.131])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vaavnq6-2;
	Wed, 12 Nov 2025 16:03:48 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v3 01/28] objtool: Move disassembly functions to a separated file
Date: Wed, 12 Nov 2025 17:02:48 +0100
Message-ID: <20251112160315.2207947-2-alexandre.chartre@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEwOSBTYWx0ZWRfXxUX8xqqL1Gtm
 Rx/xtP3U2ZeZExyTIjzNst4h8u+5F4FQfTwRwL67kQS5xXJPigxIhUDzWmYKt5pmZSPyjEqtYD/
 UK17CmFbJJOPgCQYGggGZRkjiKzYy5q0iYt26tHzQjaC7HPh1bXYC0uXjyA9XVsFf0RTdTDM8Fh
 2nPFdOY5W6Gj1+ICTkMQR0kipUzxg9ztZIL8nkJGUdFXrS1i41IJfYVBr3ftCYTL3w4Re36kHQS
 eaTvPlRvJBXRpTnG1aAYzGlgVLdZKi2NGcsoTrftUwLFiESWAfVzwwcIjWLh/1GTglrqFiYqqPl
 Pks9lLinKt41rBBCl2Us7E6GwoS7gyPS+4gPS5IbmUg4YqnDPVO6I+2WUKzgBVRrueO07VjR1WH
 zFJDWiuLFr5yvEf5hUspq/bVpzafjA==
X-Authority-Analysis: v=2.4 cv=UvFu9uwB c=1 sm=1 tr=0 ts=6914afe9 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=dBVU6wt392Vc8wzyTJAA:9
X-Proofpoint-ORIG-GUID: F4t_c0DKCze1eDbvUAWZdafTn0bsvzIX
X-Proofpoint-GUID: F4t_c0DKCze1eDbvUAWZdafTn0bsvzIX

objtool disassembles functions which have warnings. Move the code
to do that to a dedicated file. The code is just moved, it is not
changed.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/Build                     |  1 +
 tools/objtool/check.c                   | 81 ----------------------
 tools/objtool/disas.c                   | 90 +++++++++++++++++++++++++
 tools/objtool/include/objtool/objtool.h |  2 +
 4 files changed, 93 insertions(+), 81 deletions(-)
 create mode 100644 tools/objtool/disas.c

diff --git a/tools/objtool/Build b/tools/objtool/Build
index a3cdf8af6635a..677bf9148cba1 100644
--- a/tools/objtool/Build
+++ b/tools/objtool/Build
@@ -7,6 +7,7 @@ objtool-y += special.o
 objtool-y += builtin-check.o
 objtool-y += elf.o
 objtool-y += objtool.o
+objtool-y += disas.o
 
 objtool-$(BUILD_ORC) += orc_gen.o
 objtool-$(BUILD_ORC) += orc_dump.o
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 9004fbc067693..5207e62ab690c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4601,87 +4601,6 @@ static int validate_reachable_instructions(struct objtool_file *file)
 	return warnings;
 }
 
-/* 'funcs' is a space-separated list of function names */
-static void disas_funcs(const char *funcs)
-{
-	const char *objdump_str, *cross_compile;
-	int size, ret;
-	char *cmd;
-
-	cross_compile = getenv("CROSS_COMPILE");
-	if (!cross_compile)
-		cross_compile = "";
-
-	objdump_str = "%sobjdump -wdr %s | gawk -M -v _funcs='%s' '"
-			"BEGIN { split(_funcs, funcs); }"
-			"/^$/ { func_match = 0; }"
-			"/<.*>:/ { "
-				"f = gensub(/.*<(.*)>:/, \"\\\\1\", 1);"
-				"for (i in funcs) {"
-					"if (funcs[i] == f) {"
-						"func_match = 1;"
-						"base = strtonum(\"0x\" $1);"
-						"break;"
-					"}"
-				"}"
-			"}"
-			"{"
-				"if (func_match) {"
-					"addr = strtonum(\"0x\" $1);"
-					"printf(\"%%04x \", addr - base);"
-					"print;"
-				"}"
-			"}' 1>&2";
-
-	/* fake snprintf() to calculate the size */
-	size = snprintf(NULL, 0, objdump_str, cross_compile, objname, funcs) + 1;
-	if (size <= 0) {
-		WARN("objdump string size calculation failed");
-		return;
-	}
-
-	cmd = malloc(size);
-
-	/* real snprintf() */
-	snprintf(cmd, size, objdump_str, cross_compile, objname, funcs);
-	ret = system(cmd);
-	if (ret) {
-		WARN("disassembly failed: %d", ret);
-		return;
-	}
-}
-
-static void disas_warned_funcs(struct objtool_file *file)
-{
-	struct symbol *sym;
-	char *funcs = NULL, *tmp;
-
-	for_each_sym(file, sym) {
-		if (sym->warned) {
-			if (!funcs) {
-				funcs = malloc(strlen(sym->name) + 1);
-				if (!funcs) {
-					ERROR_GLIBC("malloc");
-					return;
-				}
-				strcpy(funcs, sym->name);
-			} else {
-				tmp = malloc(strlen(funcs) + strlen(sym->name) + 2);
-				if (!tmp) {
-					ERROR_GLIBC("malloc");
-					return;
-				}
-				sprintf(tmp, "%s %s", funcs, sym->name);
-				free(funcs);
-				funcs = tmp;
-			}
-		}
-	}
-
-	if (funcs)
-		disas_funcs(funcs);
-}
-
 __weak bool arch_absolute_reloc(struct elf *elf, struct reloc *reloc)
 {
 	unsigned int type = reloc_type(reloc);
diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
new file mode 100644
index 0000000000000..77de46beb496c
--- /dev/null
+++ b/tools/objtool/disas.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2015-2017 Josh Poimboeuf <jpoimboe@redhat.com>
+ */
+
+#include <objtool/arch.h>
+#include <objtool/warn.h>
+
+#include <linux/string.h>
+
+/* 'funcs' is a space-separated list of function names */
+static void disas_funcs(const char *funcs)
+{
+	const char *objdump_str, *cross_compile;
+	int size, ret;
+	char *cmd;
+
+	cross_compile = getenv("CROSS_COMPILE");
+	if (!cross_compile)
+		cross_compile = "";
+
+	objdump_str = "%sobjdump -wdr %s | gawk -M -v _funcs='%s' '"
+			"BEGIN { split(_funcs, funcs); }"
+			"/^$/ { func_match = 0; }"
+			"/<.*>:/ { "
+				"f = gensub(/.*<(.*)>:/, \"\\\\1\", 1);"
+				"for (i in funcs) {"
+					"if (funcs[i] == f) {"
+						"func_match = 1;"
+						"base = strtonum(\"0x\" $1);"
+						"break;"
+					"}"
+				"}"
+			"}"
+			"{"
+				"if (func_match) {"
+					"addr = strtonum(\"0x\" $1);"
+					"printf(\"%%04x \", addr - base);"
+					"print;"
+				"}"
+			"}' 1>&2";
+
+	/* fake snprintf() to calculate the size */
+	size = snprintf(NULL, 0, objdump_str, cross_compile, objname, funcs) + 1;
+	if (size <= 0) {
+		WARN("objdump string size calculation failed");
+		return;
+	}
+
+	cmd = malloc(size);
+
+	/* real snprintf() */
+	snprintf(cmd, size, objdump_str, cross_compile, objname, funcs);
+	ret = system(cmd);
+	if (ret) {
+		WARN("disassembly failed: %d", ret);
+		return;
+	}
+}
+
+void disas_warned_funcs(struct objtool_file *file)
+{
+	struct symbol *sym;
+	char *funcs = NULL, *tmp;
+
+	for_each_sym(file, sym) {
+		if (sym->warned) {
+			if (!funcs) {
+				funcs = malloc(strlen(sym->name) + 1);
+				if (!funcs) {
+					ERROR_GLIBC("malloc");
+					return;
+				}
+				strcpy(funcs, sym->name);
+			} else {
+				tmp = malloc(strlen(funcs) + strlen(sym->name) + 2);
+				if (!tmp) {
+					ERROR_GLIBC("malloc");
+					return;
+				}
+				sprintf(tmp, "%s %s", funcs, sym->name);
+				free(funcs);
+				funcs = tmp;
+			}
+		}
+	}
+
+	if (funcs)
+		disas_funcs(funcs);
+}
diff --git a/tools/objtool/include/objtool/objtool.h b/tools/objtool/include/objtool/objtool.h
index c0dc86a78ff65..4d3e94b70fd84 100644
--- a/tools/objtool/include/objtool/objtool.h
+++ b/tools/objtool/include/objtool/objtool.h
@@ -47,4 +47,6 @@ int check(struct objtool_file *file);
 int orc_dump(const char *objname);
 int orc_create(struct objtool_file *file);
 
+void disas_warned_funcs(struct objtool_file *file);
+
 #endif /* _OBJTOOL_H */
-- 
2.43.5


