Return-Path: <linux-kernel+bounces-897697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BDEC538F0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 043E8503662
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6685B34DCE9;
	Wed, 12 Nov 2025 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KalFP18L"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C763833F8BE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963485; cv=none; b=ooYlVaIb6KH2NxjORV0XwJjaXy9EfOaRkcsAiyHFhont3Dh8iiXLl/cE0HH+tZYvihllNs9c0cx8gaPsG66k3+cBIOZEK9vSuWA2z9AMHkBkjISyfmA7AwBmgxAWYGwaDH71ajgOhtgmaPLWrGMtolFQSD4aoxZNjDWLN7Q0fos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963485; c=relaxed/simple;
	bh=Y3RgpzdLv8DcizmWss8orCI0E+29f4IgMygjmCW0QD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OroqPiAZTkT9k68CfKxZkqQRHJWUGHleZdr4nNLioBgYUCwVwA1GJHYqO06BSZ+cGhMPmV5KytovJuMyA1kRehb5JoQE7TXUjgIxfC+nqbTcuPo9CunqmZs3sKS5OTQQnMWOE4xGcBLbGdo1+E/IGD1My4OGfE3SvyiyWpzb7aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KalFP18L; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACFWJh7012803;
	Wed, 12 Nov 2025 16:04:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=UXRRB
	xRUvb8DGbk9rGxPY4YhNOEmQqlz8hEYYwTqgyQ=; b=KalFP18LeCSklD4zLd5Hb
	mia/ONmfjPvwSvN2b9Sf4WCrborDK1Uky2R4ORJGAG38B68X86dgmnGNYDk0Rx2L
	WE0iI99hVAMLtKG4fC+jjeeJpN4RUiieso/g6l2JMjw28D5QKAlPdeM8bo0pjCLN
	nfXUlqjbX1j1lH4BfPRQkNXFdm3zWY/RUDWFZLYXKgQKoFppZvcKoGiuWaVVt0rS
	mu665sRs+2iRm2kLAcQkRXjqUlKEnynXTczr2xR1taEJ+xE7GkM7A0cTdh9wibKQ
	j9ycOkJcqqjH8Ax6wKPF9Fd/WMYNuuG4vWkxpQGnv6TXHVjrniumg7EMr+OuIubE
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acv97r6ej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEG42h018660;
	Wed, 12 Nov 2025 16:04:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaavqsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:36 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ACFxw4A004655;
	Wed, 12 Nov 2025 16:04:35 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-173-131.vpn.oracle.com [10.154.173.131])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vaavnq6-28;
	Wed, 12 Nov 2025 16:04:35 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v3 27/28] objtool: Improve the disassembly of the pv_ops call
Date: Wed, 12 Nov 2025 17:03:14 +0100
Message-ID: <20251112160315.2207947-28-alexandre.chartre@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=Cseys34D c=1 sm=1 tr=0 ts=6914b015 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=tMX4VmICG43G860zTSsA:9
X-Proofpoint-ORIG-GUID: iOCOm898BormwCnF3xNOMF1JVktQIAw3
X-Proofpoint-GUID: iOCOm898BormwCnF3xNOMF1JVktQIAw3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExOSBTYWx0ZWRfXwgE8lTCErftG
 26qW42oJMuSlM0sqPCwZc+zx5/x5TwTkurmMrjHPia3J/GtVfL0dqoEKwHHTcGShMkycSOM0yJ1
 8QswZ5BTBV5Jmf464+8BT06BJ6LlFTO6Xr16Zi7Po86ymjhqp0dowXImvU4zrLC60oqbcJf2qN+
 jVsYRYhn5s6VwLOW8+f/iUSivPE05jszeVLVbdO72oWH1M0z44I+9jQAL2yZxpZJlDVH8Sz5Ev4
 IaNi2SVNFxaxUCB7b4u/erV2wLFrGKP5Yy50n8gIuFTvP4U2Q2zUKTg1ajab6kqV7v82t69XeIK
 38wa1TjvBZQDDcri1R/qjqrhwaYRSHlZ7FOpFBVmThCTgHMXBcJC9KHzGRKfDWL+i79eTPaloQa
 MBA47tAm0LGuHrX6I2FxOFZORPuVxA==

When using the --disas option, print the destination name of pv_ops
calls when we can figure out if XENPV mode is used or not. If the
PV mode can't be predicted when print the default pv_ops destination
as a destination example.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/disas.c | 101 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 89 insertions(+), 12 deletions(-)

diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index 2a6c3708ec315..20d64b58182ce 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -12,6 +12,7 @@
 #include <objtool/special.h>
 #include <objtool/warn.h>
 
+#include <asm/cpufeatures.h>
 #include <bfd.h>
 #include <linux/string.h>
 #include <tools/dis-asm-compat.h>
@@ -54,6 +55,7 @@ struct disas_alt {
 		int offset;			/* instruction offset */
 	} insn[DISAS_ALT_INSN_MAX];		/* alternative instructions */
 	int insn_idx;				/* index of the next instruction to print */
+	int pv_mode;				/* PV mode */
 };
 
 #define DALT_DEFAULT(dalt)	(!(dalt)->alt)
@@ -665,13 +667,65 @@ char *disas_alt_name(struct alternative *alt)
 	return str;
 }
 
+/*
+ * Set the PV mode for the current alternative and return the PV mode
+ * to use for next alternatives.
+ */
+static enum pv_mode disas_alt_set_pvmode(struct disas_alt *dalt,
+					 enum pv_mode pv_mode)
+{
+	struct alt_group *alt_group;
+	int feature;
+	int flags;
+
+	dalt->pv_mode = pv_mode;
+
+	alt_group = DALT_GROUP(dalt);
+	if (!alt_group)
+		return pv_mode;
+
+	feature = alt_feature(alt_group->feature);
+	flags = alt_flags(alt_group->feature);
+
+	/*
+	 * The only PV mode we identify is the XENPV mode which is
+	 * enabled with the X86_FEATURE_XENPV feature. When we are
+	 * sure that XENPV mode is not used then assume that the
+	 * default PV mode is used.
+	 */
+	if (feature != X86_FEATURE_XENPV)
+		return pv_mode;
+
+	if (flags & ALT_FLAG_NOT) {
+		/*
+		 * This alternative is not used with XENPV mode, so
+		 * it is used in default mode. Then next alternatives
+		 * will be used in XENPV mode.
+		 */
+		dalt->pv_mode = PV_MODE_DEFAULT;
+		pv_mode = PV_MODE_XENPV;
+	} else {
+		/*
+		 * This alternative is used with XENPV mode so next
+		 * alternatives will apply in default mode.
+		 */
+		dalt->pv_mode = PV_MODE_XENPV;
+		pv_mode = PV_MODE_DEFAULT;
+	}
+
+	return pv_mode;
+}
+
 /*
  * Initialize an alternative. The default alternative should be initialized
  * with alt=NULL.
+ *
+ * Return the PV mode to use for the next alternative or -1 on error.
  */
-static int disas_alt_init(struct disas_alt *dalt,
-			  struct instruction *orig_insn,
-			  struct alternative *alt)
+static enum pv_mode disas_alt_init(struct disas_alt *dalt,
+				   struct instruction *orig_insn,
+				   struct alternative *alt,
+				   enum pv_mode pv_mode)
 {
 	dalt->orig_insn = orig_insn;
 	dalt->alt = alt;
@@ -682,7 +736,7 @@ static int disas_alt_init(struct disas_alt *dalt,
 		return -1;
 	dalt->width = strlen(dalt->name);
 
-	return 0;
+	return disas_alt_set_pvmode(dalt, pv_mode);
 }
 
 static int disas_alt_add_insn(struct disas_alt *dalt, int index, char *insn_str,
@@ -753,27 +807,50 @@ static int disas_alt_extable(struct disas_alt *dalt)
 	return 1;
 }
 
+static bool disas_alt_is_direct_call(struct instruction *insn)
+{
+	return (insn->alt_group &&
+		(alt_flags(insn->alt_group->feature) & ALT_FLAG_DIRECT_CALL));
+}
+
 /*
  * Disassemble an alternative and store instructions in the disas_alt
  * structure. Return the number of instructions in the alternative.
  */
 static int disas_alt_group(struct disas_context *dctx, struct disas_alt *dalt)
 {
+	struct instruction *orig_insn;
 	struct objtool_file *file;
 	struct instruction *insn;
+	const char *name;
 	int offset;
 	char *str;
 	int count;
 	int err;
 
 	file = dctx->file;
+	orig_insn = dalt->orig_insn;
 	count = 0;
 	offset = 0;
 
 	alt_for_each_insn(file, DALT_GROUP(dalt), insn) {
-
-		disas_insn_alt(dctx, insn);
-		str = strdup(disas_result(dctx));
+		/*
+		 * An alternative direct call initially has the
+		 * "call BUG_func" instruction but it will be
+		 * replaced with a direct call to the target of
+		 * the pv_ops call in the original instruction.
+		 */
+		if (disas_alt_is_direct_call(insn)) {
+			name = pv_call_dest_name(file, orig_insn,
+						 dalt->pv_mode);
+			if (name)
+				str = strfmt("callq  %s", name);
+			else
+				str = strdup("NOP");
+		} else {
+			disas_insn_alt(dctx, insn);
+			str = strdup(disas_result(dctx));
+		}
 		if (!str)
 			return -1;
 
@@ -876,6 +953,7 @@ static void *disas_alt(struct disas_context *dctx,
 		       struct instruction *orig_insn)
 {
 	struct disas_alt alts[DISAS_ALT_MAX] = { 0 };
+	enum pv_mode pv_mode = PV_MODE_UNKNOWN;
 	struct alternative *alt;
 	struct disas_alt *dalt;
 	int offset_next;
@@ -884,7 +962,6 @@ static void *disas_alt(struct disas_context *dctx,
 	int alt_id;
 	int offset;
 	int count;
-	int err;
 	int i;
 
 	alt_id = orig_insn->offset;
@@ -892,8 +969,8 @@ static void *disas_alt(struct disas_context *dctx,
 	/*
 	 * Initialize and disassemble the default alternative.
 	 */
-	err = disas_alt_init(&alts[0], orig_insn, NULL);
-	if (err)
+	pv_mode = disas_alt_init(&alts[0], orig_insn, NULL, pv_mode);
+	if (pv_mode < 0)
 		goto error;
 
 	insn_count = disas_alt_default(dctx, &alts[0]);
@@ -911,8 +988,8 @@ static void *disas_alt(struct disas_context *dctx,
 			break;
 		}
 		dalt = &alts[i];
-		err = disas_alt_init(dalt, orig_insn, alt);
-		if (err)
+		pv_mode = disas_alt_init(dalt, orig_insn, alt, pv_mode);
+		if (pv_mode < 0)
 			goto error;
 
 		count = -1;
-- 
2.43.5


