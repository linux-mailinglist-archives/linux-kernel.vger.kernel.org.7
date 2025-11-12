Return-Path: <linux-kernel+bounces-897686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBC9C53832
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F2DCD503ECE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283DE3491F5;
	Wed, 12 Nov 2025 16:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ptXy5Fmf"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8B2347FDF
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963465; cv=none; b=igIPmtLlBIaBf+yBAgOVvW9WclzeKmMN7sEqE/Yt70Q9FGYUROwW50svrMiSB8LVyvMAvlUwCceiH8j+pZei/H9/89X8rnjm68+jLF4/NgV3tMjqPZOPyHwrcIyQq020+JPX40sAfE8VtjjG4/uu81E4lf/ahp+TFka1nMq9azA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963465; c=relaxed/simple;
	bh=82F9kJU7gTRjL+gFHNCgewGPKv2/RebjEuUvurBNQrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=STqVxyvcx0ubb9nPwUdioBeyqBnR9xdYoIKNri8q/Qc+4sq6z6UiBGhfpNRS3qzbcpjS+c1GjfePvhvRbTIx3bU0H9Z0zcn8iXHGHhpV1P9TIIcre+5XW1GLp9GNjyaPZnEfvbMTlvc7y0Dvw+v33FECkLQ9DHvBeIkdt8sQfjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ptXy5Fmf; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACFjaAX007112;
	Wed, 12 Nov 2025 16:04:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=gzqRW
	zZBDDYIEv3/sw4STDqkkZK/2yJeEMQonuBuLRk=; b=ptXy5FmfqjZMT6hQr3pEc
	NkVIS5NOhszRXIeg7rxjWtx0z8xlgSNxKmMgAV1mqHBo8zL1VFNWdRqXFUOqUqlQ
	7jcNTmJOdvK7bFD9Z+9rNEuMqNO8f1RrQAiHpjR5ICMC4UltaY6fqewwBbgJIe6r
	dD7UUbXjNZ8mgqW2GLYC9OBz3gYNq3MGJYrQ/1ZmPXV74KDp44Dkm12+8RdIQKZb
	VFXe6d98fZbC1LCAnJvjZIU18xx+Izip3le1ypk1AZrWpI+Wcpv6IEDJlJSXI26G
	Xr1qA83yvdwrgp7Ux/29wzY2eDyeg1WS9cpnUO7RFwBgBvQdKopiYRGiohWnfWR3
	w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acw5f01y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEG3xQ018591;
	Wed, 12 Nov 2025 16:04:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaavqj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:17 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ACFxw3m004655;
	Wed, 12 Nov 2025 16:04:16 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-173-131.vpn.oracle.com [10.154.173.131])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vaavnq6-17;
	Wed, 12 Nov 2025 16:04:16 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v3 16/28] objtool: Add the --disas=<function-pattern> action
Date: Wed, 12 Nov 2025 17:03:03 +0100
Message-ID: <20251112160315.2207947-17-alexandre.chartre@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyNiBTYWx0ZWRfX87YJhx/hi06d
 DBMJkVyOcWOlUfnMnhUHxVnUUVmfJJfskLsaNC1KiIZ3IUV8d+IJmfMIQpEQiTdJtlTFSJLCeKl
 B1XL15+EHOHynDNgZOzJmcmoiTDcbUli0GgkEs2lwMq2ooTccwR10XMNPuauh6gFO0qWI277o4Q
 P58IxgoG89GCGurrsG4Ao3ohIEMhNQKdhMFGdTHi6fNN85xZhDVU3Ldbj3oqPzn3pyUhYGnQTTw
 3jiYEQuBuGyLRPGTagmt41EaNkQB6hka4P0u4ObnYRKdOJkjllkyR2zYegCyT9TeBJWk/AB7n8y
 vl0Ii0942k9YL63wb+3NxG3+tfhiRhaHHQOKv+DMWL925BVUYRHGH/G6Sd8AY++W8PozdQaYTdN
 TeW+bhczh8zBVuN46KCjGhFQdacXxA==
X-Proofpoint-GUID: RQnn3kYB1mZFftLArcdf2MyQmtt9EFrc
X-Proofpoint-ORIG-GUID: RQnn3kYB1mZFftLArcdf2MyQmtt9EFrc
X-Authority-Analysis: v=2.4 cv=Ju38bc4C c=1 sm=1 tr=0 ts=6914b002 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=Yos37rPc9-vhJleOp_oA:9

Add the --disas=<function-pattern> actions to disassemble the specified
functions. The function pattern can be a single function name (e.g.
--disas foo to disassemble the function with the name "foo"), or a shell
wildcard pattern (e.g. --disas foo* to disassemble all functions with a
name starting with "foo").

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/builtin-check.c           |  4 ++-
 tools/objtool/check.c                   | 35 ++++++++++++++-----------
 tools/objtool/disas.c                   | 28 ++++++++++++++++++++
 tools/objtool/include/objtool/builtin.h |  1 +
 tools/objtool/include/objtool/disas.h   |  2 ++
 5 files changed, 53 insertions(+), 17 deletions(-)

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
index 14b9220c1058c..f4e419c895a74 100644
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
@@ -4815,14 +4815,15 @@ int check(struct objtool_file *file)
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
 
@@ -4944,19 +4945,21 @@ int check(struct objtool_file *file)
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
index 181e4ce975d36..cb7e0c7ba165a 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -3,6 +3,8 @@
  * Copyright (C) 2015-2017 Josh Poimboeuf <jpoimboe@redhat.com>
  */
 
+#include <fnmatch.h>
+
 #include <objtool/arch.h>
 #include <objtool/check.h>
 #include <objtool/disas.h>
@@ -461,3 +463,29 @@ void disas_warned_funcs(struct disas_context *dctx)
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
index 5db75d06f2197..5d2149ffac335 100644
--- a/tools/objtool/include/objtool/disas.h
+++ b/tools/objtool/include/objtool/disas.h
@@ -14,6 +14,7 @@ struct disassemble_info;
 struct disas_context *disas_context_create(struct objtool_file *file);
 void disas_context_destroy(struct disas_context *dctx);
 void disas_warned_funcs(struct disas_context *dctx);
+void disas_funcs(struct disas_context *dctx);
 int disas_info_init(struct disassemble_info *dinfo,
 		    int arch, int mach32, int mach64,
 		    const char *options);
@@ -37,6 +38,7 @@ static inline struct disas_context *disas_context_create(struct objtool_file *fi
 
 static inline void disas_context_destroy(struct disas_context *dctx) {}
 static inline void disas_warned_funcs(struct disas_context *dctx) {}
+static inline void disas_funcs(struct disas_context *dctx) {}
 
 static inline int disas_info_init(struct disassemble_info *dinfo,
 				  int arch, int mach32, int mach64,
-- 
2.43.5


