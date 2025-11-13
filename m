Return-Path: <linux-kernel+bounces-899886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F4BC5914F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A786D3A0376
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1DA364048;
	Thu, 13 Nov 2025 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mLiu5CKL"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE16D363C7A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052595; cv=none; b=ECoVbU/uJLwBENqg3/v+gyh9/YwMYG87SQ6Y6O/2EGnzmRO0G6PhBcTmutCoaDL9FHEE/XKVgY0MfhV2Aty8LwqiHpet98l8eADTDqQVmN7mzC3pX3m1g1k5/aHbGMYXHQb1u8H/TGpMjwN433jprslk+icbnQHcGz0MO4KPFxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052595; c=relaxed/simple;
	bh=NW9ODej7ximkTYrc6vBqdXhJRqxG5v0OGwgjDFKhrUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MkVM4wTIQgp6JbMOKTVVyYqkNaPRopiMrFwRBa9eciGNfn7Ga2wVJz9hr46jiXXFPMcLYPBP3F49fqJC2npYEC9YFQSlF08PT1AqmHCRZc+OSduOrKaZnp9XzNRfjid5BLR7R11SwkrsEzjsnp7FJrZuJMSeKVnWMOjhfObAHgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mLiu5CKL; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADEAVwH006599;
	Thu, 13 Nov 2025 16:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=h8SBH
	nvcaPR/IKOBM+v6EDFM9OxNcNCr5nG/59SC/gI=; b=mLiu5CKLsQ01sAsA9LCI0
	refscuYtqNy0CoXJYJqPT+t3uq70ZXvFWY2F5O//pKyZqzcqbbMx8QHgwzGLhvhm
	d+GT5qOf5MCdS3I0N8njnDTZ64ROpd8Y31Rz7WAZdWV+H31AxbIOmbphioyDVf5d
	DwW9ECDW0JrLvEC1YZililQgUIW73B7zH5RtF21PYfb4ExjKab6I9Nj20Hy71J3h
	VZx+bwTTW7/NALQdU7atfn56yyQffIJNsFDSumyzC4/nHqvdg2eMTOKpKxGsMTRW
	r66cWqIsiBtPJx8l1O0II+Hw2ccUV4K8jrjngS6ILzvRj2zYa1F1IYQR5+wP3an2
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acyraa66n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADG3wQB039231;
	Thu, 13 Nov 2025 16:49:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacc39p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:22 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ADGnK9l008288;
	Thu, 13 Nov 2025 16:49:21 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-172-143.vpn.oracle.com [10.154.172.143])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vacc38f-2;
	Thu, 13 Nov 2025 16:49:21 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v4 01/28] objtool: Move disassembly functions to a separated file
Date: Thu, 13 Nov 2025 17:48:50 +0100
Message-ID: <20251113164917.2563486-2-alexandre.chartre@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE1MSBTYWx0ZWRfX56jwZbLvRQxX
 gV5dMfp0MSNsucAQ+DT3PKissVgM2kcjE6MTdc5rtyj4LbU/jt4Aa3Gbt3R6hU0Y+K5gLeFpEX3
 5ewgXqY7BO8pdJCED03e1yUIAhtzAT9h1ltyymvvboNBv0EPNbjz5InmvHLXABy479ZcDloN2m5
 ikacLo4nSn8Tkz4tM+NEqH+W23JNnyzrZzgEbrullPj2/Cj2DLI9+M638ostVmJU8U11SDlWjN9
 f+5iyJeNQBh8HRf5uTcJV+cSTyihzihcOL7QnLbeCc6biz4d2uW48AVY+oseodYLnaWkM6MtTQe
 BkfIZSM9iysJkI4acueRNyG0kM72ZLSTtM7v19XqsNw+GImy002PNG0fmSiV3SXdaHlXGS3rLcj
 9WJWPJs01n/pNOrxbWC8VNzSuNYv1Q==
X-Proofpoint-GUID: EOKiHZgIwTi_6pIzQE-SK8C34Y_E1PK7
X-Authority-Analysis: v=2.4 cv=ILgPywvG c=1 sm=1 tr=0 ts=69160c13 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=dBVU6wt392Vc8wzyTJAA:9
X-Proofpoint-ORIG-GUID: EOKiHZgIwTi_6pIzQE-SK8C34Y_E1PK7

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


