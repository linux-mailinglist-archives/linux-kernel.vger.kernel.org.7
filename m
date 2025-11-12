Return-Path: <linux-kernel+bounces-897695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90749C53A8C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0070B5605B2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F0334DB5F;
	Wed, 12 Nov 2025 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gtsEr7kN"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F6D34D915
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963483; cv=none; b=hj2Xmw3ZoLDmj/Uu/On8yIFq+8eIWDXjYpS+YfATAPyjU7byMhwoJxdqo/ibMWAf72jHDEa66T/pYGnqNw6IUKED5+p30lheVlJ0cn99QALWD7Wqo0W0tIgZNngCY9ctqPyP/i5T34zjnWVa3niR2rqMBv7lbICUd7zPUeEBYLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963483; c=relaxed/simple;
	bh=eIxCYhHSOL+oNmbEIGu94KL9sV5D9lg2Tv2ttjN8frE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XOsxq5c9uTbpXsyCb3R8v0EWziDxZYLZU7ONEGDZHsQW8zD4uEzVhbQHuaQZ3ATagd7n5fVDFU3lqisJX0+sXLJEeEP96mnvrIBr08NuqCIh/iaAFo+5RDfYrUZIRy4fLB/c0UrelRmZRV0HWkcjPogkRnBN2aDNZqh1R0SecX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gtsEr7kN; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACFVq1K012427;
	Wed, 12 Nov 2025 16:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=S1Egb
	1+ME0q8V4/JrKMkVaBg3nzb4w/nBbivIVSR9OA=; b=gtsEr7kNQmKMuO0mV3ubF
	RAEpYTQPzTsOHHVUt+f08fyUl0f+Mm4bd1dsgbh6O290t87BBZIwnl9zq/dQhBZw
	4o7VajPQ0NpvjU9NXcchs7m62PE0nvjlhdJyT+2WNTuDptVZAVIGbGIA5VbXXWle
	4rlbxnnzdPDB6++6Vs3QDFoepZh+PdcVax95JCpah1sXR6AFvSLQcpgmperl7wfP
	C3eRe8JfPdesw+eSZlXThXKdklHq7GxUE15fcprP4RzL9gfPtrGrJUpj3wK4KJ6T
	HWeQk89KRtLlVE+rVIeXgZC1q6Y756R31J1lEokAwCA1Fi/Dwfd9O8+60/aXXmZD
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acv97r6ed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACG4ESw018676;
	Wed, 12 Nov 2025 16:04:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaavqrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:32 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ACFxw46004655;
	Wed, 12 Nov 2025 16:04:32 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-173-131.vpn.oracle.com [10.154.173.131])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vaavnq6-26;
	Wed, 12 Nov 2025 16:04:32 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v3 25/28] objtool: Improve naming of group alternatives
Date: Wed, 12 Nov 2025 17:03:12 +0100
Message-ID: <20251112160315.2207947-26-alexandre.chartre@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=Cseys34D c=1 sm=1 tr=0 ts=6914b011 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=kqIM495-9hGHbGdz7BEA:9
X-Proofpoint-ORIG-GUID: ttJgmGjVXxLkLk6QE2x2TTTo3MTrjMOY
X-Proofpoint-GUID: ttJgmGjVXxLkLk6QE2x2TTTo3MTrjMOY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExOSBTYWx0ZWRfX0ltuWNwZL3uq
 LEXxFdfAcycPJyf2Bz70/YDM4ah/pgJ9VTrowIyDxsgVRAWKdlsuufBw3Gdynn9SuJj2+AH3DhK
 NUJSH5/xuQaAhtlZQ4/q8xqC98RnvlYGT0gvv5YsEOzfCor8kJkuPn02tUcIa8iwJ5cEiyTDz8d
 tuDliidsqXHx636lAw9tPNz57sV5qguxaD4UeeFS27qtzzhOOVznDjm3W9kviT5FLaXCbkiEwOB
 3hZOC6hLUN/Shy3xl2SvXc0P+1iPsBrta6FGWGtmbTsk+IMNQvnTEsZje72OWPMhBZuYt0OSGEw
 xyxlKBCVG02B6lqQUagE47s9qJADM979JX8LcfNpNygJ1NtZ3yslwTjFRimNnRk/0UDRH+p6CU3
 rVKW18d88joRy3kTdgDM0FoBcV8fnw==

Improve the naming of group alternatives by showing the feature name and
flags used by the alternative.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/check.c                 |  31 ++------
 tools/objtool/disas.c                 | 106 ++++++++++++++++++++------
 tools/objtool/include/objtool/disas.h |   2 +
 3 files changed, 90 insertions(+), 49 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 89b35e8a068d0..1aad636a8d630 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3566,6 +3566,7 @@ static int validate_insn(struct objtool_file *file, struct symbol *func,
 	/* prev_state is not used if there is no disassembly support */
 	struct insn_state prev_state __maybe_unused;
 	struct alternative *alt;
+	char *alt_name = NULL;
 	u8 visited;
 	int ret;
 
@@ -3651,43 +3652,21 @@ static int validate_insn(struct objtool_file *file, struct symbol *func,
 		return 1;
 
 	if (insn->alts) {
-		char alt_name[35];
-		int i, num_alts;
-
-		num_alts = 0;
-		for (alt = insn->alts; alt; alt = alt->next) {
-			if (alt->type == ALT_TYPE_INSTRUCTIONS)
-				num_alts++;
-		}
-
-		i = 1;
 		for (alt = insn->alts; alt; alt = alt->next) {
 			if (trace) {
-				switch (alt->type) {
-				case ALT_TYPE_EX_TABLE:
-					strcpy(alt_name, "EXCEPTION");
-					break;
-				case ALT_TYPE_JUMP_TABLE:
-					strcpy(alt_name, "JUMP");
-					break;
-				case ALT_TYPE_INSTRUCTIONS:
-					snprintf(alt_name, sizeof(alt_name),
-						"ALTERNATIVE %d/%d", i, num_alts);
-					break;
-				}
+				alt_name = disas_alt_name(alt);
 				trace_alt_begin(insn, alt, alt_name);
 			}
 			ret = validate_branch(file, func, alt->insn, *statep);
-			if (trace)
+			if (trace) {
 				trace_alt_end(insn, alt, alt_name);
+				free(alt_name);
+			}
 			if (ret) {
 				BT_INSN(insn, "(alt)");
 				return ret;
 			}
-			if (alt->insn->alt_group)
-				i++;
 		}
-
 		TRACE_ALT_INFO_NOADDR(insn, "/ ", "DEFAULT");
 	}
 
diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index ae3b4d20cf35c..2a6c3708ec315 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -9,6 +9,7 @@
 #include <objtool/arch.h>
 #include <objtool/check.h>
 #include <objtool/disas.h>
+#include <objtool/special.h>
 #include <objtool/warn.h>
 
 #include <bfd.h>
@@ -60,6 +61,21 @@ struct disas_alt {
 #define DALT_GROUP(dalt)	(DALT_INSN(dalt)->alt_group)
 #define DALT_ALTID(dalt)	((dalt)->orig_insn->offset)
 
+#define ALT_FLAGS_SHIFT		16
+#define ALT_FLAG_NOT		(1 << 0)
+#define ALT_FLAG_DIRECT_CALL	(1 << 1)
+#define ALT_FEATURE_MASK	((1 << ALT_FLAGS_SHIFT) - 1)
+
+static int alt_feature(unsigned ft_flags)
+{
+	return (ft_flags & ALT_FEATURE_MASK);
+}
+
+static int alt_flags(unsigned ft_flags)
+{
+	return (ft_flags >> ALT_FLAGS_SHIFT);
+}
+
 /*
  * Wrapper around asprintf() to allocate and format a string.
  * Return the allocated string or NULL on error.
@@ -588,38 +604,82 @@ static struct instruction *next_insn_same_alt(struct objtool_file *file,
 	     insn;						\
 	     insn = next_insn_same_alt(file, alt_grp, insn))
 
+/*
+ * Provide a name for an alternative.
+ */
+char *disas_alt_name(struct alternative *alt)
+{
+	char pfx[4] = { 0 };
+	char *str = NULL;
+	const char *name;
+	int feature;
+	int flags;
+	int num;
+
+	switch (alt->type) {
+
+	case ALT_TYPE_EX_TABLE:
+		str = strdup("EXCEPTION");
+		break;
+
+	case ALT_TYPE_JUMP_TABLE:
+		str = strdup("JUMP");
+		break;
+
+	case ALT_TYPE_INSTRUCTIONS:
+		/*
+		 * This is a non-default group alternative. Create a name
+		 * based on the feature and flags associated with this
+		 * alternative. Use either the feature name (it is available)
+		 * or the feature number. And add a prefix to show the flags
+		 * used.
+		 *
+		 * Prefix flags characters:
+		 *
+		 *   '!'  alternative used when feature not enabled
+		 *   '+'  direct call alternative
+		 *   '?'  unknown flag
+		 */
+
+		feature = alt->insn->alt_group->feature;
+		num = alt_feature(feature);
+		flags = alt_flags(feature);
+		str = pfx;
+
+		if (flags & ~(ALT_FLAG_NOT | ALT_FLAG_DIRECT_CALL))
+			*str++ = '?';
+		if (flags & ALT_FLAG_DIRECT_CALL)
+			*str++ = '+';
+		if (flags & ALT_FLAG_NOT)
+			*str++ = '!';
+
+		name = arch_cpu_feature_name(num);
+		if (!name)
+			str = strfmt("%sFEATURE 0x%X", pfx, num);
+		else
+			str = strfmt("%s%s", pfx, name);
+
+		break;
+	}
+
+	return str;
+}
+
 /*
  * Initialize an alternative. The default alternative should be initialized
  * with alt=NULL.
  */
 static int disas_alt_init(struct disas_alt *dalt,
 			  struct instruction *orig_insn,
-			  struct alternative *alt,
-			  int alt_num)
+			  struct alternative *alt)
 {
-	char *str;
-
 	dalt->orig_insn = orig_insn;
 	dalt->alt = alt;
 	dalt->insn_idx = 0;
-	if (!alt) {
-		str = strfmt("<alternative.%lx>", orig_insn->offset);
-	} else {
-		switch (alt->type) {
-		case ALT_TYPE_EX_TABLE:
-			str = strdup("EXCEPTION");
-			break;
-		case ALT_TYPE_JUMP_TABLE:
-			str = strdup("JUMP");
-			break;
-		default:
-			str = strfmt("ALTERNATIVE %d", alt_num);
-			break;
-		}
-	}
-	if (!str)
+	dalt->name = alt ? disas_alt_name(alt) :
+		strfmt("<alternative.%lx>", orig_insn->offset);
+	if (!dalt->name)
 		return -1;
-	dalt->name = str;
 	dalt->width = strlen(dalt->name);
 
 	return 0;
@@ -832,7 +892,7 @@ static void *disas_alt(struct disas_context *dctx,
 	/*
 	 * Initialize and disassemble the default alternative.
 	 */
-	err = disas_alt_init(&alts[0], orig_insn, NULL, 0);
+	err = disas_alt_init(&alts[0], orig_insn, NULL);
 	if (err)
 		goto error;
 
@@ -851,7 +911,7 @@ static void *disas_alt(struct disas_context *dctx,
 			break;
 		}
 		dalt = &alts[i];
-		err = disas_alt_init(dalt, orig_insn, alt, i);
+		err = disas_alt_init(dalt, orig_insn, alt);
 		if (err)
 			goto error;
 
diff --git a/tools/objtool/include/objtool/disas.h b/tools/objtool/include/objtool/disas.h
index 5d2149ffac335..5272acd61dd03 100644
--- a/tools/objtool/include/objtool/disas.h
+++ b/tools/objtool/include/objtool/disas.h
@@ -6,6 +6,7 @@
 #ifndef _DISAS_H
 #define _DISAS_H
 
+struct alternative;
 struct disas_context;
 struct disassemble_info;
 
@@ -25,6 +26,7 @@ void disas_print_info(FILE *stream, struct instruction *insn, int depth,
 void disas_print_insn(FILE *stream, struct disas_context *dctx,
 		      struct instruction *insn, int depth,
 		      const char *format, ...);
+char *disas_alt_name(struct alternative *alt);
 
 #else /* DISAS */
 
-- 
2.43.5


