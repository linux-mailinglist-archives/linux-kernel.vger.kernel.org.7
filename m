Return-Path: <linux-kernel+bounces-897687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 895E9C53914
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C438544D62
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D475234AB04;
	Wed, 12 Nov 2025 16:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XmAW3iep"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5CE33F371
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963468; cv=none; b=K1wsGrIAPgdYpdoQQ85ZOdvyKNClpHcNNyVi+81pwNdcrdHMzur3JkZ+1MbkvBOD7muI5ryAwOEVZBqpF3sM1tvTuXTbs8QyUaBUMMxUEitNbtq3Bo392EqKwbPeVk2ABfegfo1vVPQwsHXoNTew0lAHM15Bar00vT0roKTw86w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963468; c=relaxed/simple;
	bh=UeJC7A8yySa2jJk5mj+Xf5wFPcalhbRb2J1/db9X0S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ITZOaPa88tzZB//kIxjxlZi4Pyj9n1Llw2oXx4rQHDBTNnGm8+UNtbDb4z45JUDQot5zdPbq3Yzl69MDSP2pspdxoBsP7GWacG9KA/DS8TyU+5C8/HWSInqR6lZsu0+apFNOvI+sSMNGtYn/yNESvqD1QWF83z/B+gG8KfqIv6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XmAW3iep; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACFVU3j011666;
	Wed, 12 Nov 2025 16:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=Cv5Oe
	/SwAi5Jd6gACqUVIeySjoXHjenLha5Q3HYStGk=; b=XmAW3iepqpbz2r3bRl2Hw
	/bv8Gb1PL6jRyGxyESYo2cXR9FRrcin3y5WTtQGeBy34QDHCedBJTdHGEWZKYPwJ
	a4qPoMFd0EnrJvWWQK9e19kLk4g1jyhaHAu8/B6B10Jrgq+eB0xRyXWKUlISPDwj
	C/yl4YHITLHMXQZFUGgUPUMhFGO/kneU3FO4tactWnfhEW5AL4DrGLAEAdMqiRHj
	C+uns3ggUcYr4TCdUNQ5JtRj91ObRY9gOzh9DRz3q3hdSBqprjB5tZXXtvvojd3B
	7tBKyYqa4G1PDBCCOySgIFdhgIvrraM5XGGIFU/GglH3ttlEY38JQ7B0qL4VHU2I
	w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acv97r6dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEG4oB018707;
	Wed, 12 Nov 2025 16:04:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaavqkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:19 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ACFxw3o004655;
	Wed, 12 Nov 2025 16:04:18 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-173-131.vpn.oracle.com [10.154.173.131])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vaavnq6-18;
	Wed, 12 Nov 2025 16:04:18 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v3 17/28] objtool: Print headers for alternatives
Date: Wed, 12 Nov 2025 17:03:04 +0100
Message-ID: <20251112160315.2207947-18-alexandre.chartre@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=Cseys34D c=1 sm=1 tr=0 ts=6914b004 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=RozQtDkvD__u-kIZZ1wA:9
X-Proofpoint-ORIG-GUID: ui_9dKVEdadQbscG6j8-wS6LjYba6ZII
X-Proofpoint-GUID: ui_9dKVEdadQbscG6j8-wS6LjYba6ZII
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExOSBTYWx0ZWRfX6jyXDDBrNOP0
 BLnHb6hTXrTFblaXiGzkDwSemz96farxyxjwYy04+5l2arHT9f47bmgSKf5NOyTWe6ED/Uh/SGv
 37LXx8iDyKTixfTGVHNTC81m5ofuK589HmDBxVC0lfvcfy6XIKiMUxp40ZUPh2oK9OYSAgnKX9d
 Fd4mgYSq1CvZbqB7cWR7GaSp23zMXbZCuHQPINTvO2Rkmw+LEzLzNIzL4fckEHUsNCdovHcsqNI
 zW5AJ9SH8w6oOkhgZT/+qCWv01KDIMLBIC0A5q95g/rWwDmpnWidildw+udsEd/W6kZ6ZQ19DZB
 2I6U4nOFOyCukTmjvQkq9Wl3gCmG1rcKR8Py++Yc5TLm6nUhh70iqnNCEfDbLFCqP1OujzJLtiR
 Ar4uXd9FsPCHaizC+4oMlzlT/x/o/Q==

When using the --disas option, objtool doesn't currently disassemble
any alternative. Print an header for each alternative. This identifies
places where alternatives are present but alternative code is still
not disassembled at the moment.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/disas.c | 155 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 149 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index cb7e0c7ba165a..43dc51f614f1c 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2015-2017 Josh Poimboeuf <jpoimboe@redhat.com>
  */
 
+#define _GNU_SOURCE
 #include <fnmatch.h>
 
 #include <objtool/arch.h>
@@ -28,6 +29,43 @@ struct disas_context {
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
@@ -316,6 +354,9 @@ char *disas_result(struct disas_context *dctx)
 #define DISAS_INSN_OFFSET_SPACE		10
 #define DISAS_INSN_SPACE		60
 
+#define DISAS_PRINSN(dctx, insn, depth)			\
+	disas_print_insn(stdout, dctx, insn, depth, "\n")
+
 /*
  * Print a message in the instruction flow. If insn is not NULL then
  * the instruction address is printed in addition of the message,
@@ -429,21 +470,123 @@ size_t disas_insn(struct disas_context *dctx, struct instruction *insn)
 	return disasm(insn->offset, &dctx->info);
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


