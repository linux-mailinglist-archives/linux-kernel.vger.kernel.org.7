Return-Path: <linux-kernel+bounces-899889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C60C594E5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C97C50070D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E1D368284;
	Thu, 13 Nov 2025 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SOuDJnxy"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34B135292F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052598; cv=none; b=k6r7yE4gxgurQZMEdrb2GP41iiYoRsiImI+hNXUzXiJpQzGo2zegt4Pv1aBGQ8sGK80CVvCRDlkmcGLtWIRzY3rS0uXw6QJcE8676LyBOpF4f4keJFE4fA0BK0co4NyyxrRtQB+OI8WGuYMJPSlMfpL3uJI2eaQkbGsVi4CWAgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052598; c=relaxed/simple;
	bh=mDJm++wM5GxELzNLJ6G7scMX1MRzAMycFy+sdevP8+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mDn0IpOfcpKfNL1h5zfLibE7oJvHRRbZKRy0JGja5iBz2xgAbOBeuZafe5Dwm/XYIT42CNmJyaqWyZZ8/C543zdR57RZSeH95Op5AgRHXsO59E8iKLoszoAWSLCDhJ+G6/DFbLQEUvSqw48HBoE8uJAA5xVKb7+5orNGorjtav4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SOuDJnxy; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADE9tMB015519;
	Thu, 13 Nov 2025 16:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=j/2Ey
	pPAlF5Zh+YyDHr+VZy/4XUs9JZKLIYh2ZToZf4=; b=SOuDJnxyLYd9YZqyz6e4a
	gMRGW20PA7kiqjAxTOR9iRnktV9wQo+4DSTyPvueI5icq8xJcZe8K2sFRd3y76Ck
	QQvXgYG8QnhLRTn4pII2WKkEaK3j2N6NOB7tDgw3nAkjY6xhP3e7dZ5RXtU2qLAR
	HptVmefzl/RGvtvj3r936O6B+hSfT1dOvRhtGfek4NfnprWs6GQ6RabbU+msJO93
	gOfYOg/NhS86aIqWGBHtH1QcWT7jKAcyTsYfQEx890MTll75my5sO+eSkEHsKMQp
	GP18qsgyI+iryqDGlyLTfcA5oL46T69yfDFJRFKOQrm88dVN7VPJ4VMJAkYW9SqK
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acxfvjaks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADGGxtO038510;
	Thu, 13 Nov 2025 16:49:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacc3q0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:48 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ADGnKAH008288;
	Thu, 13 Nov 2025 16:49:47 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-172-143.vpn.oracle.com [10.154.172.143])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vacc38f-17;
	Thu, 13 Nov 2025 16:49:47 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v4 16/28] objtool: Add the --disas=<function-pattern> action
Date: Thu, 13 Nov 2025 17:49:05 +0100
Message-ID: <20251113164917.2563486-17-alexandre.chartre@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEzOSBTYWx0ZWRfX63rH6NtkBvXF
 w97RZr0KlfltA2Ht9AoKzJHoOLrHWPX4VspOs7FHFRkpywEx/kVGe0tMdPXqA9VSb+ZDEyjUBEK
 B8rTtMwjqyvjqYP/89uWPd0ia66Cg0nYPTM81zAkqCBjYZFqFMfrezduyxykdcuIizjlM/fJvVY
 yc3oPM3y/BCZORft3f0yTt2r+GFdVYaIG6kK7OaeCX849Ni/ytmMTih6ineyVcnAJcMvgvTiHhz
 2yDjH9WOvOWxcclbqV+C1qR3dW1AyKbo84AUjCh+6ptwfWaBxUd6IOplYsmbKVhoDiN9KpjcVi4
 sSi3twWw5tJ3V9Wx+f3ubvdudg8OjAF7U2aF+S//ZZGL0eARbQZQnhT7iLew5aHytx7LWXLMmQn
 qqKUAr06j2iSq470SP6eT1zgeSeblA==
X-Proofpoint-ORIG-GUID: xwvaa3faij0q82modmpCaVJE4mrN8OZz
X-Proofpoint-GUID: xwvaa3faij0q82modmpCaVJE4mrN8OZz
X-Authority-Analysis: v=2.4 cv=FKYWBuos c=1 sm=1 tr=0 ts=69160c2c cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=LcGi4TWirBIM2so6JHsA:9

Add the --disas=<function-pattern> actions to disassemble the specified
functions. The function pattern can be a single function name (e.g.
--disas foo to disassemble the function with the name "foo"), or a shell
wildcard pattern (e.g. --disas foo* to disassemble all functions with a
name starting with "foo").

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/builtin-check.c           |  4 ++-
 tools/objtool/check.c                   | 35 ++++++++++++++-----------
 tools/objtool/disas.c                   | 27 +++++++++++++++++++
 tools/objtool/include/objtool/builtin.h |  1 +
 tools/objtool/include/objtool/disas.h   |  2 ++
 5 files changed, 52 insertions(+), 17 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 7c95d3d263d72..7ce49a00bdabc 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -73,6 +73,7 @@ static int parse_hacks(const struct option *opt, const char *str, int unset)
 
 static const struct option check_options[] = {
 	OPT_GROUP("Actions:"),
+	OPT_STRING_OPTARG('d',   "disas", &opts.disas, "function-pattern", "disassemble functions", "*"),
 	OPT_CALLBACK_OPTARG('h', "hacks", NULL, NULL, "jump_label,noinstr,skylake", "patch toolchain bugs/limitations", parse_hacks),
 	OPT_BOOLEAN('i', "ibt", &opts.ibt, "validate and annotate IBT"),
 	OPT_BOOLEAN('m', "mcount", &opts.mcount, "annotate mcount/fentry calls for ftrace"),
@@ -160,7 +161,8 @@ static bool opts_valid(void)
 		return false;
 	}
 
-	if (opts.hack_jump_label	||
+	if (opts.disas			||
+	    opts.hack_jump_label	||
 	    opts.hack_noinstr		||
 	    opts.ibt			||
 	    opts.mcount			||
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 646cb7fe61b02..25c1c7185d4f6 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2570,7 +2570,7 @@ static int decode_sections(struct objtool_file *file)
 	 * Must be before add_jump_destinations(), which depends on 'func'
 	 * being set for alternatives, to enable proper sibling call detection.
 	 */
-	if (opts.stackval || opts.orc || opts.uaccess || opts.noinstr) {
+	if (opts.stackval || opts.orc || opts.uaccess || opts.noinstr || opts.disas) {
 		ret = add_special_section_alts(file);
 		if (ret)
 			return ret;
@@ -4789,14 +4789,15 @@ int check(struct objtool_file *file)
 	int ret = 0, warnings = 0;
 
 	/*
-	 * If the verbose or backtrace option is used then we need a
-	 * disassembly context to disassemble instruction or function
-	 * on warning or backtrace.
+	 * Create a disassembly context if we might disassemble any
+	 * instruction or function.
 	 */
-	if (opts.verbose || opts.backtrace || opts.trace) {
+	if (opts.verbose || opts.backtrace || opts.trace || opts.disas) {
 		disas_ctx = disas_context_create(file);
-		if (!disas_ctx)
+		if (!disas_ctx) {
+			opts.disas = false;
 			opts.trace = false;
+		}
 		objtool_disas_ctx = disas_ctx;
 	}
 
@@ -4918,19 +4919,21 @@ int check(struct objtool_file *file)
 	}
 
 out:
-	if (!ret && !warnings)
-		return 0;
-
-	if (opts.werror && warnings)
-		ret = 1;
-
-	if (opts.verbose) {
+	if (ret || warnings) {
 		if (opts.werror && warnings)
-			WARN("%d warning(s) upgraded to errors", warnings);
-		print_args();
-		disas_warned_funcs(disas_ctx);
+			ret = 1;
+
+		if (opts.verbose) {
+			if (opts.werror && warnings)
+				WARN("%d warning(s) upgraded to errors", warnings);
+			print_args();
+			disas_warned_funcs(disas_ctx);
+		}
 	}
 
+	if (opts.disas)
+		disas_funcs(disas_ctx);
+
 	if (disas_ctx) {
 		disas_context_destroy(disas_ctx);
 		objtool_disas_ctx = NULL;
diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index 058e2053c31a7..9b5d9075ab2d3 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -4,6 +4,7 @@
  */
 
 #define _GNU_SOURCE
+#include <fnmatch.h>
 
 #include <objtool/arch.h>
 #include <objtool/check.h>
@@ -495,3 +496,29 @@ void disas_warned_funcs(struct disas_context *dctx)
 			disas_func(dctx, sym);
 	}
 }
+
+void disas_funcs(struct disas_context *dctx)
+{
+	bool disas_all = !strcmp(opts.disas, "*");
+	struct section *sec;
+	struct symbol *sym;
+
+	for_each_sec(dctx->file, sec) {
+
+		if (!(sec->sh.sh_flags & SHF_EXECINSTR))
+			continue;
+
+		sec_for_each_sym(sec, sym) {
+			/*
+			 * If the function had a warning and the verbose
+			 * option is used then the function was already
+			 * disassemble.
+			 */
+			if (opts.verbose && sym->warned)
+				continue;
+
+			if (disas_all || fnmatch(opts.disas, sym->name, 0) == 0)
+				disas_func(dctx, sym);
+		}
+	}
+}
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index e79a52c098883..cde9474b57820 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -27,6 +27,7 @@ struct opts {
 	int prefix;
 	bool cfi;
 	bool noabs;
+	const char *disas;
 
 	/* options: */
 	bool backtrace;
diff --git a/tools/objtool/include/objtool/disas.h b/tools/objtool/include/objtool/disas.h
index f1bef2a6003e8..15fd1237f03fc 100644
--- a/tools/objtool/include/objtool/disas.h
+++ b/tools/objtool/include/objtool/disas.h
@@ -15,6 +15,7 @@ struct disassemble_info;
 struct disas_context *disas_context_create(struct objtool_file *file);
 void disas_context_destroy(struct disas_context *dctx);
 void disas_warned_funcs(struct disas_context *dctx);
+void disas_funcs(struct disas_context *dctx);
 int disas_info_init(struct disassemble_info *dinfo,
 		    int arch, int mach32, int mach64,
 		    const char *options);
@@ -39,6 +40,7 @@ static inline struct disas_context *disas_context_create(struct objtool_file *fi
 
 static inline void disas_context_destroy(struct disas_context *dctx) {}
 static inline void disas_warned_funcs(struct disas_context *dctx) {}
+static inline void disas_funcs(struct disas_context *dctx) {}
 
 static inline int disas_info_init(struct disassemble_info *dinfo,
 				  int arch, int mach32, int mach64,
-- 
2.43.5


