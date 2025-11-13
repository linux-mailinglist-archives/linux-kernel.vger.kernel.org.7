Return-Path: <linux-kernel+bounces-899890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B70C590AF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 47B7F367AB8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D70F369962;
	Thu, 13 Nov 2025 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X/4RHLy4"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F93364E9C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052599; cv=none; b=SLxHj9JqJ6VlQdbE07PKIM17dWUEO7m8SSHpfjg0lOmte9sxrvW359sT4sCjYMxwjZP6KLqiLlSWckx1tc6JpGCYcY1MlNrwH5NAyw7Wo5dm01hN+GmMpGpDmOXzZ2aJk/ZItmto60f/OtuKytVfdt27FhL0Y00fORCNYbNCtKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052599; c=relaxed/simple;
	bh=FMSGnbKxEL01sZ20PRImDAVPUOXXYS4m+KlLsw2RokU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eN0OPpimjwsmzFA8qKEeNJzxM2BWjMfm4RgbhFaT017tmA/WJlBygIDwCC4Q1zxZvtsUfglDMyOcG+7/2W+WlgkFLBnYc6a8/XaIl93bKwbq4Fqb5DlfK32G/J8DmQ9craHoNuuGKXFA8EYKEVXN41jLYtCcPOdfXRCLvttC6Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X/4RHLy4; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADEA1pu024816;
	Thu, 13 Nov 2025 16:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=R0M5o
	8fzPyLjmmNK4LXPsrcKOj2yQvDlaQDE9alZKVc=; b=X/4RHLy4ek6Oc+EBfvu4j
	OL7xj8RKwJo4P039eQn76mRyf53q8+wxf8Oqsab9zN/hGYHyHKGeiU9gU7ZU/zIV
	oDDGDr7Xqn9UdTM6WQ/6upwADwwrSGm253+r9aBxLhpXOQarosYdldLJ9rqgqTfY
	p0QZ5ipoMKlOWt3QD1G95xbU5q9WKEKQ9fz+9+rx9xz9+LAhyEc7i8WOFvV27fZP
	z1Wjy8cYq00C5Wc9fRbBcTMJJC9Xh4D1zUAMcGOpuvM8qV9smQYwCk3BFOq0JRif
	YqrLVsvENCItgNedXglTs9zRXCMVCLE6AjtkHhG6ob7Uy4AILSfLnhPm+rA7v8cy
	g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acvsstnn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADG8EKI039173;
	Thu, 13 Nov 2025 16:49:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacc3rs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:49 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ADGnKAJ008288;
	Thu, 13 Nov 2025 16:49:49 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-172-143.vpn.oracle.com [10.154.172.143])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vacc38f-18;
	Thu, 13 Nov 2025 16:49:49 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v4 17/28] objtool: Print headers for alternatives
Date: Thu, 13 Nov 2025 17:49:06 +0100
Message-ID: <20251113164917.2563486-18-alexandre.chartre@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=bJUb4f+Z c=1 sm=1 tr=0 ts=69160c2e cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=8cgdJ23b6Str3pk9HK8A:9
X-Proofpoint-GUID: ataKvWXpqmRw75CQDu6xxOMeyZvWw-UV
X-Proofpoint-ORIG-GUID: ataKvWXpqmRw75CQDu6xxOMeyZvWw-UV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyMyBTYWx0ZWRfX/xBUqXWP/UhU
 PykA6N/HsQl5V9HKohv+taU+qaZF54+FGdRKmVt0rp40OFWmzz1H/Z3RSrXc07WHdRkI7eeCpnD
 nH+quctRaTmR7+etogy1HkKY5GJV40SOBjl/+PSjPLoJnewYXqeFly44x/c+mdbvfJbCu2rRw8o
 T+aNOOpGcn4rrBhORk5HR+0/ZKjPmgNu2bT2povZ0AKiYx8kOIUrK2+PY6XZmVG2ac1wH8uweTh
 MhvpNOrN7ulGlO378lbGCC2QXSuRD3veC8uXW4/I81G3wLGF9dl37lJto01sL7Fln4uWHdO/ima
 gjvv7mDT5ZOYvdtFdKzsrQkjmLxGT68LOlgKP1vQVfnLoJD7LRod0Pq2FyK6/D7N9/xaBhutnOS
 vi2Oo4Ak65x31SC8mAKzUd59OKJ+lg==

When using the --disas option, objtool doesn't currently disassemble
any alternative. Print an header for each alternative. This identifies
places where alternatives are present but alternative code is still
not disassembled at the moment.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/disas.c | 154 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 148 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index 9b5d9075ab2d3..57a13da5e1b39 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -29,6 +29,43 @@ struct disas_context {
 	struct disassemble_info info;
 };
 
+/*
+ * Maximum number of alternatives
+ */
+#define DISAS_ALT_MAX		5
+
+/*
+ * Maximum number of instructions per alternative
+ */
+#define DISAS_ALT_INSN_MAX	50
+
+/*
+ * Information to disassemble an alternative
+ */
+struct disas_alt {
+	struct instruction *orig_insn;		/* original instruction */
+	struct alternative *alt;		/* alternative or NULL if default code */
+	char *name;				/* name for this alternative */
+	int width;				/* formatting width */
+};
+
+/*
+ * Wrapper around asprintf() to allocate and format a string.
+ * Return the allocated string or NULL on error.
+ */
+static char *strfmt(const char *fmt, ...)
+{
+	va_list ap;
+	char *str;
+	int rv;
+
+	va_start(ap, fmt);
+	rv = vasprintf(&str, fmt, ap);
+	va_end(ap);
+
+	return rv == -1 ? NULL : str;
+}
+
 static int sprint_name(char *str, const char *name, unsigned long offset)
 {
 	int len;
@@ -317,6 +354,9 @@ char *disas_result(struct disas_context *dctx)
 #define DISAS_INSN_OFFSET_SPACE		10
 #define DISAS_INSN_SPACE		60
 
+#define DISAS_PRINSN(dctx, insn, depth)			\
+	disas_print_insn(stdout, dctx, insn, depth, "\n")
+
 /*
  * Print a message in the instruction flow. If insn is not NULL then
  * the instruction address is printed in addition of the message,
@@ -462,21 +502,123 @@ char *disas_alt_name(struct alternative *alt)
 	return str;
 }
 
+/*
+ * Initialize an alternative. The default alternative should be initialized
+ * with alt=NULL.
+ */
+static int disas_alt_init(struct disas_alt *dalt,
+			  struct instruction *orig_insn,
+			  struct alternative *alt,
+			  int alt_num)
+{
+	dalt->orig_insn = orig_insn;
+	dalt->alt = alt;
+	dalt->name = alt ? strfmt("ALTERNATIVE %d", alt_num) :
+		strfmt("<alternative.%lx>", orig_insn->offset);
+	if (!dalt->name)
+		return -1;
+	dalt->width = strlen(dalt->name);
+
+	return 0;
+}
+
+/*
+ * Disassemble an alternative.
+ *
+ * Return the last instruction in the default alternative so that
+ * disassembly can continue with the next instruction. Return NULL
+ * on error.
+ */
+static void *disas_alt(struct disas_context *dctx,
+		       struct instruction *orig_insn)
+{
+	struct disas_alt alts[DISAS_ALT_MAX] = { 0 };
+	struct alternative *alt;
+	int alt_count;
+	int alt_id;
+	int i;
+	int err;
+
+	alt_id = orig_insn->offset;
+
+	/*
+	 * Initialize the default alternative.
+	 */
+	err = disas_alt_init(&alts[0], orig_insn, NULL, 0);
+	if (err)
+		goto error;
+
+	/*
+	 * Initialize all other alternatives.
+	 */
+	i = 1;
+	for (alt = orig_insn->alts; alt; alt = alt->next) {
+		if (i >= DISAS_ALT_MAX) {
+			WARN("Alternative %lx has more alternatives than supported",
+			     orig_insn->offset);
+			break;
+		}
+		err = disas_alt_init(&alts[i], orig_insn, alt, i);
+		if (err)
+			goto error;
+
+		i++;
+	}
+	alt_count = i;
+
+	/*
+	 * Print an header with the name of each alternative.
+	 */
+	disas_print_info(stdout, orig_insn, -2, NULL);
+	for (i = 0; i < alt_count; i++) {
+		printf("| %-*s ", alts[i].width, alts[i].name);
+		free(alts[i].name);
+	}
+	printf("\n");
+
+	/*
+	 * Currently we are not disassembling any alternative but just
+	 * printing alternative names. Return NULL to have disas_func()
+	 * resume the disassembly with the default alternative.
+	 */
+	return NULL;
+
+error:
+	WARN("Failed to disassemble alternative %x", alt_id);
+
+	for (i = 0; i < DISAS_ALT_MAX; i++)
+		free(alts[i].name);
+
+	return NULL;
+}
+
 /*
  * Disassemble a function.
  */
 static void disas_func(struct disas_context *dctx, struct symbol *func)
 {
+	struct instruction *insn_start;
 	struct instruction *insn;
-	size_t addr;
 
 	printf("%s:\n", func->name);
 	sym_for_each_insn(dctx->file, func, insn) {
-		addr = insn->offset;
-		disas_insn(dctx, insn);
-		printf(" %6lx:  %s+0x%-6lx      %s\n",
-		       addr, func->name, addr - func->offset,
-		       disas_result(dctx));
+		if (insn->alts) {
+			insn_start = insn;
+			insn = disas_alt(dctx, insn);
+			if (insn)
+				continue;
+			/*
+			 * There was an error with disassembling
+			 * the alternative. Resume disassembling
+			 * at the current instruction, this will
+			 * disassemble the default alternative
+			 * only and continue with the code after
+			 * the alternative.
+			 */
+			insn = insn_start;
+		}
+
+		DISAS_PRINSN(dctx, insn, 0);
 	}
 	printf("\n");
 }
-- 
2.43.5


