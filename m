Return-Path: <linux-kernel+bounces-899881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2393DC59077
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F1FC53624D7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD48364028;
	Thu, 13 Nov 2025 16:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mzf1EMb2"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850FE3624CC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052589; cv=none; b=oRLnwK0zaWEEBFQBshjXSJ7bDMoBClXndQbD0e6KuWx3TJj7FW30mfIKoWSFzlMqbawIIt/GOH4Hgh8mwI6UwZt190R7PEc8EU8sUXpV74Yir286BDJ2INvy4ppeLAAYLMWIvZCPA8re0Ao2e+PGYQuFdN0NSWRnUH4PtQYvoik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052589; c=relaxed/simple;
	bh=IFwJFcZiuuz+FhuZr+Gu8S/HF/N2dyr6EohjkrgVBQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTLO9/NZgNHok1/dDTunpCaXa/Z+qYEgWaa02ix3fMnQ5c7TOZGUyJsKRRR0Z+Y2DGQy/55QfA0AiStufBJ05+KFNmpZKGWdt8wZmr95fBF/LCcLCOr91Q6NfiFcXzxM1XJcVafKxOSbLbfy/fQo5KZNxLS2iTJC1aWJmQ0fAFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mzf1EMb2; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADEAMvF006389;
	Thu, 13 Nov 2025 16:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=YZWmZ
	4ZXB0Msaovq4srMHeSz1mpLuFlCt+fLwzcWWsM=; b=mzf1EMb2O7cLUx5Co6Bp5
	BpQdbyQp8B2l7cTrDB9xXdLTv94z7K+SQ+PIkKcKpLi5URyRcDX/S6/kjqCHGyqo
	isaQr1OGslJQpZZBxqF4tTrfnkMAIr9Ic/Eob67/sR0by45fBqL2XrG4ZNbszIzh
	Rioo7lntMBEtt31/K2VQFALRTCUZDBX3BHm1FmMmA+PrbBw4YHdn7QqOpjYau+FV
	OzO75fDJHYm1yJ4Gl5o2nuSnvHL1efQcO6UXrsjVesIrWcu+IoPyrzFIZUHHTFzC
	X+tyOQDKZiz9JIxCPiprUaYrMAq4PPKCOB7cvLZlCGYPhs6DUzBB3lHhTNc+Sbx5
	w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acyraa677-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADGC5pk039018;
	Thu, 13 Nov 2025 16:49:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacc3fp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:37 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ADGnKA5008288;
	Thu, 13 Nov 2025 16:49:37 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-172-143.vpn.oracle.com [10.154.172.143])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vacc38f-11;
	Thu, 13 Nov 2025 16:49:36 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v4 10/28] objtool: Add option to trace function validation
Date: Thu, 13 Nov 2025 17:48:59 +0100
Message-ID: <20251113164917.2563486-11-alexandre.chartre@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE1MSBTYWx0ZWRfXwNTD7OBgwzmZ
 3AlwNYGbYRzhttvPT841UcZLTbJhXDAw8FEA/HaclydMYbLaxncI23K8xYHbnRPB1MKxWstxg9L
 AaCCKnte0eXmUimbYMvm+OJo7qlv4Qbo64N87pbLKNABHEYugWXnm7YP4qbBFeCLuvdLAR40KGF
 d2vhj+CMLYx6r9MD90+5F1axt/b/1EKta9S8BMYU7nUKeBeGyXRGx7Hu69An/EWUnFO9nf2BATe
 x94m/cJUOrk7qe0ypfm/rX8RTwJhxqaN9iIfA9VQJhq/3RhUt8LJ/93Fcw0HRiepwAsozhbKGDw
 TyozUgAn96n2cV+TjKzl+XcwpL2jz0tvozwxWHn6DVlqFspdUD2ZudVIhOnfmFe0p2Pp5IpNzjH
 cQ8pyIDeOc47I7s0Qd8BICYKhnMfJA==
X-Proofpoint-GUID: 8-x708JXy0rPGz18voOHmwjeCmcExXvk
X-Authority-Analysis: v=2.4 cv=ILgPywvG c=1 sm=1 tr=0 ts=69160c22 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=7nqSK5V4zRp-Hs5t_LEA:9
X-Proofpoint-ORIG-GUID: 8-x708JXy0rPGz18voOHmwjeCmcExXvk

Add an option to trace and have information during the validation
of specified functions. Functions are specified with the --trace
option which can be a single function name (e.g. --trace foo to
trace the function with the name "foo"), or a shell wildcard
pattern (e.g. --trace foo* to trace all functions with a name
starting with "foo").

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/Build                     |   1 +
 tools/objtool/builtin-check.c           |   1 +
 tools/objtool/check.c                   | 108 ++++++++++++++++++++----
 tools/objtool/disas.c                   |  89 +++++++++++++++++++
 tools/objtool/include/objtool/builtin.h |   1 +
 tools/objtool/include/objtool/check.h   |   8 +-
 tools/objtool/include/objtool/disas.h   |  11 +++
 tools/objtool/include/objtool/trace.h   |  68 +++++++++++++++
 tools/objtool/include/objtool/warn.h    |   1 +
 tools/objtool/trace.c                   |   9 ++
 10 files changed, 278 insertions(+), 19 deletions(-)
 create mode 100644 tools/objtool/include/objtool/trace.h
 create mode 100644 tools/objtool/trace.c

diff --git a/tools/objtool/Build b/tools/objtool/Build
index ee04fba8c9d16..6e62ffd407926 100644
--- a/tools/objtool/Build
+++ b/tools/objtool/Build
@@ -9,6 +9,7 @@ objtool-y += elf.o
 objtool-y += objtool.o
 
 objtool-$(BUILD_DISAS) += disas.o
+objtool-$(BUILD_DISAS) += trace.o
 
 objtool-$(BUILD_ORC) += orc_gen.o
 objtool-$(BUILD_ORC) += orc_dump.o
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 0f6b197cfcb03..7c95d3d263d72 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -100,6 +100,7 @@ static const struct option check_options[] = {
 	OPT_STRING('o',  "output", &opts.output, "file", "output file name"),
 	OPT_BOOLEAN(0,   "sec-address", &opts.sec_address, "print section addresses in warnings"),
 	OPT_BOOLEAN(0,   "stats", &opts.stats, "print statistics"),
+	OPT_STRING(0,    "trace", &opts.trace, "func", "trace function validation"),
 	OPT_BOOLEAN('v', "verbose", &opts.verbose, "verbose warnings"),
 	OPT_BOOLEAN(0,   "Werror", &opts.werror, "return error on warnings"),
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 1fd56e8afbfc6..e047cf12f0ddb 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2015-2017 Josh Poimboeuf <jpoimboe@redhat.com>
  */
 
+#include <fnmatch.h>
 #include <string.h>
 #include <stdlib.h>
 #include <inttypes.h>
@@ -14,6 +15,7 @@
 #include <objtool/disas.h>
 #include <objtool/check.h>
 #include <objtool/special.h>
+#include <objtool/trace.h>
 #include <objtool/warn.h>
 #include <objtool/endianness.h>
 
@@ -35,7 +37,9 @@ static struct cfi_state init_cfi;
 static struct cfi_state func_cfi;
 static struct cfi_state force_undefined_cfi;
 
-static size_t sym_name_max_len;
+struct disas_context *objtool_disas_ctx;
+
+size_t sym_name_max_len;
 
 struct instruction *find_insn(struct objtool_file *file,
 			      struct section *sec, unsigned long offset)
@@ -3519,8 +3523,10 @@ static bool skip_alt_group(struct instruction *insn)
 		return false;
 
 	/* ANNOTATE_IGNORE_ALTERNATIVE */
-	if (insn->alt_group->ignore)
+	if (insn->alt_group->ignore) {
+		TRACE_INSN(insn, "alt group ignored");
 		return true;
+	}
 
 	/*
 	 * For NOP patched with CLAC/STAC, only follow the latter to avoid
@@ -3544,6 +3550,8 @@ static bool skip_alt_group(struct instruction *insn)
 
 static int validate_branch(struct objtool_file *file, struct symbol *func,
 			   struct instruction *insn, struct insn_state state);
+static int do_validate_branch(struct objtool_file *file, struct symbol *func,
+			      struct instruction *insn, struct insn_state state);
 
 static int validate_insn(struct objtool_file *file, struct symbol *func,
 			 struct instruction *insn, struct insn_state *statep,
@@ -3565,8 +3573,10 @@ static int validate_insn(struct objtool_file *file, struct symbol *func,
 		if (!insn->hint && !insn_cfi_match(insn, &statep->cfi))
 			return 1;
 
-		if (insn->visited & visited)
+		if (insn->visited & visited) {
+			TRACE_INSN(insn, "already visited");
 			return 0;
+		}
 	} else {
 		nr_insns_visited++;
 	}
@@ -3603,8 +3613,10 @@ static int validate_insn(struct objtool_file *file, struct symbol *func,
 				 * It will be seen later via the
 				 * straight-line path.
 				 */
-				if (!prev_insn)
+				if (!prev_insn) {
+					TRACE_INSN(insn, "defer restore");
 					return 0;
+				}
 
 				WARN_INSN(insn, "objtool isn't smart enough to handle this CFI save/restore combo");
 				return 1;
@@ -3632,13 +3644,24 @@ static int validate_insn(struct objtool_file *file, struct symbol *func,
 		return 1;
 
 	if (insn->alts) {
+		int i, num_alts;
+
+		num_alts = 0;
+		for (alt = insn->alts; alt; alt = alt->next)
+			num_alts++;
+
+		i = 1;
 		for (alt = insn->alts; alt; alt = alt->next) {
+			TRACE_INSN(insn, "alternative %d/%d", i, num_alts);
 			ret = validate_branch(file, func, alt->insn, *statep);
 			if (ret) {
 				BT_INSN(insn, "(alt)");
 				return ret;
 			}
+			i++;
 		}
+
+		TRACE_INSN(insn, "alternative orig");
 	}
 
 	if (skip_alt_group(insn))
@@ -3650,10 +3673,16 @@ static int validate_insn(struct objtool_file *file, struct symbol *func,
 	switch (insn->type) {
 
 	case INSN_RETURN:
+		TRACE_INSN(insn, "return");
 		return validate_return(func, insn, statep);
 
 	case INSN_CALL:
 	case INSN_CALL_DYNAMIC:
+		if (insn->type == INSN_CALL)
+			TRACE_INSN(insn, "call");
+		else
+			TRACE_INSN(insn, "indirect call");
+
 		ret = validate_call(file, insn, statep);
 		if (ret)
 			return ret;
@@ -3669,13 +3698,18 @@ static int validate_insn(struct objtool_file *file, struct symbol *func,
 	case INSN_JUMP_CONDITIONAL:
 	case INSN_JUMP_UNCONDITIONAL:
 		if (is_sibling_call(insn)) {
+			TRACE_INSN(insn, "sibling call");
 			ret = validate_sibling_call(file, insn, statep);
 			if (ret)
 				return ret;
 
 		} else if (insn->jump_dest) {
-			ret = validate_branch(file, func,
-					      insn->jump_dest, *statep);
+			if (insn->type == INSN_JUMP_UNCONDITIONAL)
+				TRACE_INSN(insn, "unconditional jump");
+			else
+				TRACE_INSN(insn, "jump taken");
+
+			ret = validate_branch(file, func, insn->jump_dest, *statep);
 			if (ret) {
 				BT_INSN(insn, "(branch)");
 				return ret;
@@ -3685,10 +3719,12 @@ static int validate_insn(struct objtool_file *file, struct symbol *func,
 		if (insn->type == INSN_JUMP_UNCONDITIONAL)
 			return 0;
 
+		TRACE_INSN(insn, "jump not taken");
 		break;
 
 	case INSN_JUMP_DYNAMIC:
 	case INSN_JUMP_DYNAMIC_CONDITIONAL:
+		TRACE_INSN(insn, "indirect jump");
 		if (is_sibling_call(insn)) {
 			ret = validate_sibling_call(file, insn, statep);
 			if (ret)
@@ -3701,6 +3737,7 @@ static int validate_insn(struct objtool_file *file, struct symbol *func,
 		break;
 
 	case INSN_SYSCALL:
+		TRACE_INSN(insn, "syscall");
 		if (func && (!next_insn || !next_insn->hint)) {
 			WARN_INSN(insn, "unsupported instruction in callable function");
 			return 1;
@@ -3709,6 +3746,7 @@ static int validate_insn(struct objtool_file *file, struct symbol *func,
 		break;
 
 	case INSN_SYSRET:
+		TRACE_INSN(insn, "sysret");
 		if (func && (!next_insn || !next_insn->hint)) {
 			WARN_INSN(insn, "unsupported instruction in callable function");
 			return 1;
@@ -3717,6 +3755,7 @@ static int validate_insn(struct objtool_file *file, struct symbol *func,
 		return 0;
 
 	case INSN_STAC:
+		TRACE_INSN(insn, "stac");
 		if (!opts.uaccess)
 			break;
 
@@ -3729,6 +3768,7 @@ static int validate_insn(struct objtool_file *file, struct symbol *func,
 		break;
 
 	case INSN_CLAC:
+		TRACE_INSN(insn, "clac");
 		if (!opts.uaccess)
 			break;
 
@@ -3746,6 +3786,7 @@ static int validate_insn(struct objtool_file *file, struct symbol *func,
 		break;
 
 	case INSN_STD:
+		TRACE_INSN(insn, "std");
 		if (statep->df) {
 			WARN_INSN(insn, "recursive STD");
 			return 1;
@@ -3755,6 +3796,7 @@ static int validate_insn(struct objtool_file *file, struct symbol *func,
 		break;
 
 	case INSN_CLD:
+		TRACE_INSN(insn, "cld");
 		if (!statep->df && func) {
 			WARN_INSN(insn, "redundant CLD");
 			return 1;
@@ -3767,8 +3809,10 @@ static int validate_insn(struct objtool_file *file, struct symbol *func,
 		break;
 	}
 
-	*dead_end = insn->dead_end;
+	if (insn->dead_end)
+		TRACE_INSN(insn, "dead end");
 
+	*dead_end = insn->dead_end;
 	return 0;
 }
 
@@ -3778,8 +3822,8 @@ static int validate_insn(struct objtool_file *file, struct symbol *func,
  * each instruction and validate all the rules described in
  * tools/objtool/Documentation/objtool.txt.
  */
-static int validate_branch(struct objtool_file *file, struct symbol *func,
-			   struct instruction *insn, struct insn_state state)
+static int do_validate_branch(struct objtool_file *file, struct symbol *func,
+			      struct instruction *insn, struct insn_state state)
 {
 	struct instruction *next_insn, *prev_insn = NULL;
 	struct section *sec;
@@ -3791,7 +3835,10 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 	sec = insn->sec;
 
-	while (1) {
+	do {
+
+		insn->trace = 0;
+
 		next_insn = next_insn_to_validate(file, insn);
 
 		if (func && insn_func(insn) && func != insn_func(insn)->pfunc) {
@@ -3814,10 +3861,15 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 		ret = validate_insn(file, func, insn, &state, prev_insn, next_insn,
 				    &dead_end);
-		if (dead_end)
-			break;
 
-		if (!next_insn) {
+		if (!insn->trace) {
+			if (ret)
+				TRACE_INSN(insn, "warning (%d)", ret);
+			else
+				TRACE_INSN(insn, NULL);
+		}
+
+		if (!dead_end && !next_insn) {
 			if (state.cfi.cfa.base == CFI_UNDEFINED)
 				return 0;
 			if (file->ignore_unreachables)
@@ -3831,7 +3883,20 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 		prev_insn = insn;
 		insn = next_insn;
-	}
+
+	} while (!dead_end);
+
+	return ret;
+}
+
+static int validate_branch(struct objtool_file *file, struct symbol *func,
+			   struct instruction *insn, struct insn_state state)
+{
+	int ret;
+
+	trace_depth_inc();
+	ret = do_validate_branch(file, func, insn, state);
+	trace_depth_dec();
 
 	return ret;
 }
@@ -4277,9 +4342,18 @@ static int validate_symbol(struct objtool_file *file, struct section *sec,
 	if (opts.uaccess)
 		state->uaccess = sym->uaccess_safe;
 
+	if (opts.trace && !fnmatch(opts.trace, sym->name, 0)) {
+		trace_enable();
+		TRACE("%s: validation begin\n", sym->name);
+	}
+
 	ret = validate_branch(file, insn_func(insn), insn, *state);
 	if (ret)
 		BT_INSN(insn, "<=== (sym)");
+
+	TRACE("%s: validation %s\n\n", sym->name, ret ? "failed" : "end");
+	trace_disable();
+
 	return ret;
 }
 
@@ -4693,8 +4767,6 @@ static void free_insns(struct objtool_file *file)
 		free(chunk->addr);
 }
 
-static struct disas_context *objtool_disas_ctx;
-
 const char *objtool_disas_insn(struct instruction *insn)
 {
 	struct disas_context *dctx = objtool_disas_ctx;
@@ -4716,8 +4788,10 @@ int check(struct objtool_file *file)
 	 * disassembly context to disassemble instruction or function
 	 * on warning or backtrace.
 	 */
-	if (opts.verbose || opts.backtrace) {
+	if (opts.verbose || opts.backtrace || opts.trace) {
 		disas_ctx = disas_context_create(file);
+		if (!disas_ctx)
+			opts.trace = false;
 		objtool_disas_ctx = disas_ctx;
 	}
 
diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index c8f3fad086faa..181e4ce975d36 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -311,6 +311,95 @@ char *disas_result(struct disas_context *dctx)
 	return dctx->result;
 }
 
+#define DISAS_INSN_OFFSET_SPACE		10
+#define DISAS_INSN_SPACE		60
+
+/*
+ * Print a message in the instruction flow. If insn is not NULL then
+ * the instruction address is printed in addition of the message,
+ * otherwise only the message is printed. In all cases, the instruction
+ * itself is not printed.
+ */
+void disas_print_info(FILE *stream, struct instruction *insn, int depth,
+		      const char *format, ...)
+{
+	const char *addr_str;
+	va_list args;
+	int len;
+	int i;
+
+	len = sym_name_max_len + DISAS_INSN_OFFSET_SPACE;
+	if (depth < 0) {
+		len += depth;
+		depth = 0;
+	}
+
+	if (insn && insn->sec) {
+		addr_str = offstr(insn->sec, insn->offset);
+		fprintf(stream, "%6lx:  %-*s  ", insn->offset, len, addr_str);
+		free((char *)addr_str);
+	} else {
+		len += DISAS_INSN_OFFSET_SPACE + 1;
+		fprintf(stream, "%-*s", len, "");
+	}
+
+	/* print vertical bars to show the code flow */
+	for (i = 0; i < depth; i++)
+		fprintf(stream, "| ");
+
+	if (format) {
+		va_start(args, format);
+		vfprintf(stream, format, args);
+		va_end(args);
+	}
+}
+
+/*
+ * Print an instruction address (offset and function), the instruction itself
+ * and an optional message.
+ */
+void disas_print_insn(FILE *stream, struct disas_context *dctx,
+		      struct instruction *insn, int depth,
+		      const char *format, ...)
+{
+	char fake_nop_insn[32];
+	const char *insn_str;
+	bool fake_nop;
+	va_list args;
+	int len;
+
+	/*
+	 * Alternative can insert a fake nop, sometimes with no
+	 * associated section so nothing to disassemble.
+	 */
+	fake_nop = (!insn->sec && insn->type == INSN_NOP);
+	if (fake_nop) {
+		snprintf(fake_nop_insn, 32, "<fake nop> (%d bytes)", insn->len);
+		insn_str = fake_nop_insn;
+	} else {
+		disas_insn(dctx, insn);
+		insn_str = disas_result(dctx);
+	}
+
+	/* print the instruction */
+	len = (depth + 1) * 2 < DISAS_INSN_SPACE ? DISAS_INSN_SPACE - (depth+1) * 2 : 1;
+	disas_print_info(stream, insn, depth, "%-*s", len, insn_str);
+
+	/* print message if any */
+	if (!format)
+		return;
+
+	if (strcmp(format, "\n") == 0) {
+		fprintf(stream, "\n");
+		return;
+	}
+
+	fprintf(stream, " - ");
+	va_start(args, format);
+	vfprintf(stream, format, args);
+	va_end(args);
+}
+
 /*
  * Disassemble a single instruction. Return the size of the instruction.
  */
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index ab22673862e1b..e79a52c098883 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -38,6 +38,7 @@ struct opts {
 	const char *output;
 	bool sec_address;
 	bool stats;
+	const char *trace;
 	bool verbose;
 	bool werror;
 };
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index f3ea144d4746c..e5f97acb62522 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -64,8 +64,9 @@ struct instruction {
 	    noendbr		: 1,
 	    unret		: 1,
 	    visited		: 4,
-	    no_reloc		: 1;
-		/* 10 bit hole */
+	    no_reloc		: 1,
+	    trace		: 1;
+		/* 9 bit hole */
 
 	struct alt_group *alt_group;
 	struct instruction *jump_dest;
@@ -141,4 +142,7 @@ struct instruction *next_insn_same_sec(struct objtool_file *file, struct instruc
 
 const char *objtool_disas_insn(struct instruction *insn);
 
+extern size_t sym_name_max_len;
+extern struct disas_context *objtool_disas_ctx;
+
 #endif /* _CHECK_H */
diff --git a/tools/objtool/include/objtool/disas.h b/tools/objtool/include/objtool/disas.h
index 1aee1fbe0bb97..5db75d06f2197 100644
--- a/tools/objtool/include/objtool/disas.h
+++ b/tools/objtool/include/objtool/disas.h
@@ -19,6 +19,11 @@ int disas_info_init(struct disassemble_info *dinfo,
 		    const char *options);
 size_t disas_insn(struct disas_context *dctx, struct instruction *insn);
 char *disas_result(struct disas_context *dctx);
+void disas_print_info(FILE *stream, struct instruction *insn, int depth,
+		      const char *format, ...);
+void disas_print_insn(FILE *stream, struct disas_context *dctx,
+		      struct instruction *insn, int depth,
+		      const char *format, ...);
 
 #else /* DISAS */
 
@@ -51,6 +56,12 @@ static inline char *disas_result(struct disas_context *dctx)
 	return NULL;
 }
 
+static inline void disas_print_info(FILE *stream, struct instruction *insn,
+				    int depth, const char *format, ...) {}
+static inline void disas_print_insn(FILE *stream, struct disas_context *dctx,
+				    struct instruction *insn, int depth,
+				    const char *format, ...) {}
+
 #endif /* DISAS */
 
 #endif /* _DISAS_H */
diff --git a/tools/objtool/include/objtool/trace.h b/tools/objtool/include/objtool/trace.h
new file mode 100644
index 0000000000000..ea0904a0ce001
--- /dev/null
+++ b/tools/objtool/include/objtool/trace.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2025, Oracle and/or its affiliates.
+ */
+
+#ifndef _TRACE_H
+#define _TRACE_H
+
+#include <objtool/check.h>
+#include <objtool/disas.h>
+
+#ifdef DISAS
+
+extern bool trace;
+extern int trace_depth;
+
+#define TRACE(fmt, ...)						\
+({	if (trace)						\
+		fprintf(stderr, fmt, ##__VA_ARGS__);		\
+})
+
+#define TRACE_INSN(insn, fmt, ...)				\
+({								\
+	if (trace) {						\
+		disas_print_insn(stderr, objtool_disas_ctx,	\
+				 insn, trace_depth - 1,	\
+				 fmt, ##__VA_ARGS__);		\
+		fprintf(stderr, "\n");				\
+		insn->trace = 1;				\
+	}							\
+})
+
+static inline void trace_enable(void)
+{
+	trace = true;
+	trace_depth = 0;
+}
+
+static inline void trace_disable(void)
+{
+	trace = false;
+}
+
+static inline void trace_depth_inc(void)
+{
+	if (trace)
+		trace_depth++;
+}
+
+static inline void trace_depth_dec(void)
+{
+	if (trace)
+		trace_depth--;
+}
+
+#else /* DISAS */
+
+#define TRACE(fmt, ...)
+#define TRACE_INSN(insn, fmt, ...)
+
+static inline void trace_enable(void) {}
+static inline void trace_disable(void) {}
+static inline void trace_depth_inc(void) {}
+static inline void trace_depth_dec(void) {}
+
+#endif
+
+#endif /* _TRACE_H */
diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/objtool/warn.h
index 8be02483823dc..08540baa02126 100644
--- a/tools/objtool/include/objtool/warn.h
+++ b/tools/objtool/include/objtool/warn.h
@@ -97,6 +97,7 @@ static inline char *offstr(struct section *sec, unsigned long offset)
 		_len = (_len < 50) ? 50 - _len : 0;		\
 		WARN("  %s: " format "  %*s%s", _str, ##__VA_ARGS__, _len, "", _istr); \
 		free(_str);						\
+		__insn->trace = 1;				\
 	}							\
 })
 
diff --git a/tools/objtool/trace.c b/tools/objtool/trace.c
new file mode 100644
index 0000000000000..bc3113ba72fdb
--- /dev/null
+++ b/tools/objtool/trace.c
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2025, Oracle and/or its affiliates.
+ */
+
+#include <objtool/trace.h>
+
+bool trace;
+int trace_depth;
-- 
2.43.5


