Return-Path: <linux-kernel+bounces-899891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F692C594F4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 19:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A23B50122D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC0B357A31;
	Thu, 13 Nov 2025 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IWBVV6pG"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2612E366578
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052600; cv=none; b=OkvN7YAON+YvEWvDNi3ugxke+XjaIRRX0WJhFJH+q1TqOuFUxTHTBNYLJWxSqtQ/nllUjmE0mRrZqJfv1M6yTkkRSvJk24xRtw8HiObwRDXqD4hQ6sCH7rwy4/1IGWBT1bV6jOZn8rJIm2QrXMgDU2S7JFuMqEI7LRYIYpE/tAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052600; c=relaxed/simple;
	bh=xkPHbeEa/fyoEXZ+IfoRNpBXeQZNyTaLsImOKbE6Tjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/nn7W1x0MRAN93uMVk/yFD2VmO6UdSbjXZxcI9LwdHPhV4MU/b8jOCXVDI3aT92f6A35YCi2B/gmdNfbLgg4FSsWS9QM7GYfYWYnBnTyVAdtOgXvEwlBainazZybN7yvh/15/RWqmuFdjaWQIQC+/6PDX+NxLl3IADRMo9UFeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IWBVV6pG; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADE9tSv023882;
	Thu, 13 Nov 2025 16:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=ynjPT
	RHYEswaRnW1oTgJz838cGYP3Pd020uwtpiU0WE=; b=IWBVV6pGtqLVzOdaC2C5H
	AoszfNOc842Xe2BBAARjVmSXs8KUWRi2cyXywx4fDWU9LX83TUuQ6Td4x15Fn7e1
	Cz+L0iQ6l/1zF+PViHgiT5jCUKDOaEOhnONuSq8YYgeq3rLZ9n+3RBGwM765y2DA
	bEqbfJZvkOLSF4144l9nzd4qnnjHEq2UMkPFtAAFYRao3KFIAWSK0Ym776o9VDzI
	Q5Lm1U0/TawPIeLbQ1QOupF/3SYc3qF6gQLE/XuHSl909iFDnaslhGnLdIDk27VA
	01IeCQGSPZtUcCSKuAwdEKYeLPWpQHC9bVEwN0Sh7pznQ4eTYmgAH8PTRpLeL/DQ
	g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acvsstnnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADG207b038612;
	Thu, 13 Nov 2025 16:49:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacc3tx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:51 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ADGnKAL008288;
	Thu, 13 Nov 2025 16:49:51 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-172-143.vpn.oracle.com [10.154.172.143])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vacc38f-19;
	Thu, 13 Nov 2025 16:49:50 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v4 18/28] objtool: Disassemble group alternatives
Date: Thu, 13 Nov 2025 17:49:07 +0100
Message-ID: <20251113164917.2563486-19-alexandre.chartre@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=bJUb4f+Z c=1 sm=1 tr=0 ts=69160c30 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=BZlt5mrdIDfIrSVFCwQA:9
X-Proofpoint-GUID: W10CRdUWyr9DuYn6gj6w95RFTZIHa6_P
X-Proofpoint-ORIG-GUID: W10CRdUWyr9DuYn6gj6w95RFTZIHa6_P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyMyBTYWx0ZWRfX7GfEcU5xL09+
 x0Vbpfvlnglzr0yE9xA+8JJuZhG6WjDbifO7UGTNU2KYbB6utCkK69A7ZPJWifKK2glhFnNtu9X
 YII1c7mtgqwDXop8NR1aOh+4F+T6P1zvBuzQymegiq8FQI/Y320Np9dRmhLLEOenKrZpm5rll6w
 anlebfQRk/EBR8HSmBQwJP/iqqpIhiOA+9I8MmjB6qnz2S53jVlnCX6cG3QsnU1d6jLwSxpOQ2U
 jz0lum+SXOcQ/X+bAUbS1hIU42s+th6SZZMjZ7fxuEPCRMXE9BseJeBLqjlxhDPrGBAjW20EgN4
 JYtMT5slg28tNJsZnXYDDBoQcDR8/QY8HzDuf3AMdXFzrK2y7Y1PxksAfLFEAz1TasKE9809K7U
 HFlptihlGGYezELzwO4fIjTSVKtMnw==

When using the --disas option, disassemble all group alternatives.
Jump tables and exception tables (which are handled as alternatives)
are not disassembled at the moment.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/disas.c | 146 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 138 insertions(+), 8 deletions(-)

diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index 57a13da5e1b39..321256f746425 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -47,8 +47,14 @@ struct disas_alt {
 	struct alternative *alt;		/* alternative or NULL if default code */
 	char *name;				/* name for this alternative */
 	int width;				/* formatting width */
+	char *insn[DISAS_ALT_INSN_MAX];		/* alternative instructions */
 };
 
+#define DALT_DEFAULT(dalt)	(!(dalt)->alt)
+#define DALT_INSN(dalt)		(DALT_DEFAULT(dalt) ? (dalt)->orig_insn : (dalt)->alt->insn)
+#define DALT_GROUP(dalt)	(DALT_INSN(dalt)->alt_group)
+#define DALT_ALTID(dalt)	((dalt)->orig_insn->offset)
+
 /*
  * Wrapper around asprintf() to allocate and format a string.
  * Return the allocated string or NULL on error.
@@ -470,6 +476,21 @@ size_t disas_insn(struct disas_context *dctx, struct instruction *insn)
 	return disasm(insn->offset, &dctx->info);
 }
 
+static struct instruction *next_insn_same_alt(struct objtool_file *file,
+					      struct alt_group *alt_grp,
+					      struct instruction *insn)
+{
+	if (alt_grp->last_insn == insn || alt_grp->nop == insn)
+		return NULL;
+
+	return next_insn_same_sec(file, insn);
+}
+
+#define alt_for_each_insn(file, alt_grp, insn)			\
+	for (insn = alt_grp->first_insn; 			\
+	     insn;						\
+	     insn = next_insn_same_alt(file, alt_grp, insn))
+
 /*
  * Provide a name for an alternative.
  */
@@ -522,6 +543,83 @@ static int disas_alt_init(struct disas_alt *dalt,
 	return 0;
 }
 
+static int disas_alt_add_insn(struct disas_alt *dalt, int index, char *insn_str)
+{
+	int len;
+
+	if (index >= DISAS_ALT_INSN_MAX) {
+		WARN("Alternative %lx.%s has more instructions than supported",
+		     DALT_ALTID(dalt), dalt->name);
+		return -1;
+	}
+
+	len = strlen(insn_str);
+	dalt->insn[index] = insn_str;
+	if (len > dalt->width)
+		dalt->width = len;
+
+	return 0;
+}
+
+/*
+ * Disassemble an alternative and store instructions in the disas_alt
+ * structure. Return the number of instructions in the alternative.
+ */
+static int disas_alt_group(struct disas_context *dctx, struct disas_alt *dalt)
+{
+	struct objtool_file *file;
+	struct instruction *insn;
+	char *str;
+	int count;
+	int err;
+
+	file = dctx->file;
+	count = 0;
+
+	alt_for_each_insn(file, DALT_GROUP(dalt), insn) {
+
+		disas_insn(dctx, insn);
+		str = strdup(disas_result(dctx));
+		if (!str)
+			return -1;
+
+		err = disas_alt_add_insn(dalt, count, str);
+		if (err)
+			break;
+		count++;
+	}
+
+	return count;
+}
+
+/*
+ * Disassemble the default alternative.
+ */
+static int disas_alt_default(struct disas_context *dctx, struct disas_alt *dalt)
+{
+	char *str;
+	int err;
+
+	if (DALT_GROUP(dalt))
+		return disas_alt_group(dctx, dalt);
+
+	/*
+	 * Default alternative with no alt_group: this is the default
+	 * code associated with either a jump table or an exception
+	 * table and no other instruction alternatives. In that case
+	 * the default alternative is made of a single instruction.
+	 */
+	disas_insn(dctx, dalt->orig_insn);
+	str = strdup(disas_result(dctx));
+	if (!str)
+		return -1;
+	err = disas_alt_add_insn(dalt, 0, str);
+	if (err)
+		return -1;
+
+	return 1;
+}
+
 /*
  * Disassemble an alternative.
  *
@@ -534,22 +632,30 @@ static void *disas_alt(struct disas_context *dctx,
 {
 	struct disas_alt alts[DISAS_ALT_MAX] = { 0 };
 	struct alternative *alt;
+	struct disas_alt *dalt;
+	int insn_count;
 	int alt_count;
 	int alt_id;
-	int i;
+	char *str;
+	int count;
+	int i, j;
 	int err;
 
 	alt_id = orig_insn->offset;
 
 	/*
-	 * Initialize the default alternative.
+	 * Initialize and disassemble the default alternative.
 	 */
 	err = disas_alt_init(&alts[0], orig_insn, NULL, 0);
 	if (err)
 		goto error;
 
+	insn_count = disas_alt_default(dctx, &alts[0]);
+	if (insn_count < 0)
+		goto error;
+
 	/*
-	 * Initialize all other alternatives.
+	 * Initialize and disassemble all other alternatives.
 	 */
 	i = 1;
 	for (alt = orig_insn->alts; alt; alt = alt->next) {
@@ -558,10 +664,25 @@ static void *disas_alt(struct disas_context *dctx,
 			     orig_insn->offset);
 			break;
 		}
-		err = disas_alt_init(&alts[i], orig_insn, alt, i);
+		dalt = &alts[i];
+		err = disas_alt_init(dalt, orig_insn, alt, i);
 		if (err)
 			goto error;
 
+		/*
+		 * Only group alternatives are supported at the moment.
+		 */
+		switch (dalt->alt->type) {
+		case ALT_TYPE_INSTRUCTIONS:
+			count = disas_alt_group(dctx, dalt);
+			break;
+		default:
+			count = 0;
+		}
+		if (count < 0)
+			goto error;
+
+		insn_count = count > insn_count ? count : insn_count;
 		i++;
 	}
 	alt_count = i;
@@ -577,11 +698,20 @@ static void *disas_alt(struct disas_context *dctx,
 	printf("\n");
 
 	/*
-	 * Currently we are not disassembling any alternative but just
-	 * printing alternative names. Return NULL to have disas_func()
-	 * resume the disassembly with the default alternative.
+	 * Print instructions for each alternative.
 	 */
-	return NULL;
+	for (j = 0; j < insn_count; j++) {
+		disas_print_info(stdout, NULL, -2, NULL);
+		for (i = 0; i < alt_count; i++) {
+			dalt = &alts[i];
+			str = dalt->insn[j];
+			printf("| %-*s ", dalt->width, str ?: "");
+			free(str);
+		}
+		printf("\n");
+	}
+
+	return orig_insn->alt_group ? orig_insn->alt_group->last_insn : orig_insn;
 
 error:
 	WARN("Failed to disassemble alternative %x", alt_id);
-- 
2.43.5


