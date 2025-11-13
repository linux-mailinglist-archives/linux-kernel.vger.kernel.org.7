Return-Path: <linux-kernel+bounces-899895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 84159C590B8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CBE2736505A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E8436CE0E;
	Thu, 13 Nov 2025 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WTvqBvXH"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804C536999A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052603; cv=none; b=CD3EaIdoqbrlDLBmMwvfo/2eoV/BcmkRAq7OQfeQnDrFO9dzuuJ0P9wuSO0wzeTHIlBSSz1aU+FILa87UKHw0IBbfL7eeznoAT5UlgUBtD16nL6Ene3H03/ZkmtjBIWaJj3tiT/dutPs9G1qopGBK1qfF3n+kKyajFocfJ0VeRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052603; c=relaxed/simple;
	bh=FlVFBT6oZY2IDD6hO+du+x/huN0yXjvoBQfQjVLEu2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gF28Yw2nVMUXG9Q+G+zHbyN8xgmB3YGlBJqkT3FXFd+42rEi7OUPC1VKi6hf36Cln3A7zQ5HcCKCH0gdicvRWNSviUxWtK2cp0CYxNKSj4dTIs8QoJiwtI5BuVcytWUMWoQUjTHEnB2tx7kDrM+1tSpL0AtFs7T455Bc74drVkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WTvqBvXH; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADEA6VF028865;
	Thu, 13 Nov 2025 16:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=5H1K8
	PxA4tuOMbESqPA3aePI5+UCeoDPy0LIarZYvWA=; b=WTvqBvXHaYrHteEbr+ug8
	sZkxjRe4zWmL268c694OqGZjsrvsQuNNiiIg0FYG+4hTfh8yBK1OautShXuDBD52
	fNTrN30T68ueHoffKudNVQLgjwRj2lTbE9PJAsqSNw2fwPOPAXZ8yRgZsmEUksE7
	eCXLzgldT6pDDI+x6TWIbRIh2Efl7icyLQEI3HesB2nkx36NNVtx3AFpqRWkn3Qg
	3nrIPtGBiH0tf50ye3n2qjVTRHkCPUGCeUQL1kXWhjdAshs0IfTJOeHm/Aq1DKSs
	p4Y8/roiS+X0Rk2y5iRMtX7XpaVwRuVrzIRo0Xo0JPjevtjEruSvu3qtL9Nu0w06
	w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acxpnjb00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADGGxtR038510;
	Thu, 13 Nov 2025 16:49:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacc3vn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:53 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ADGnKAN008288;
	Thu, 13 Nov 2025 16:49:52 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-172-143.vpn.oracle.com [10.154.172.143])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vacc38f-20;
	Thu, 13 Nov 2025 16:49:52 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v4 19/28] objtool: Print addresses with alternative instructions
Date: Thu, 13 Nov 2025 17:49:08 +0100
Message-ID: <20251113164917.2563486-20-alexandre.chartre@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=Criys34D c=1 sm=1 tr=0 ts=69160c32 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=WFXfjiaBZm73b8CXPiEA:9
X-Proofpoint-GUID: FK6mA87YbP45O3z-CcxgOt_g57w5XzJx
X-Proofpoint-ORIG-GUID: FK6mA87YbP45O3z-CcxgOt_g57w5XzJx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0MSBTYWx0ZWRfX+fu80ODm5K7S
 w8pit4v6cQ/OEWbmF+MC9HwZyjFODwmu2R8T7Re+JM1huJx1lqEOvSIQsf6rp3TdyZW+GAoJTXD
 QQMfj1iyNd1h6/MeF+vmLEDmOe+xyrVAiVzQ03H61XmGnGpDjpvVMGrIm117J0CU9VCdyqnUxpc
 WmMZQRx+/MWZcVacQNOCIlntFnUu3XqgbyIFosbzuWUzlOQ8GLmX87EbLf7nf2dXMpxZkYPBfEB
 P9Y1ATfHLj1eNh0bTZvwjOrGNCMm2VpJ6DpthnL1yUdmd26q2LHRKwoLHWos1Y/tgFnJ8c7Kq71
 6nKf2arxgeBT6g+iyvDgtK97RKJn7UfaqBnauROxgGhzjVN3DGgJ2bYdCyxltZ2i4PDIXSvgSGU
 X2v1qEPRHgw/wZw9EzH3t7KEJjuupQ==

All alternatives are disassemble side-by-side when using the --disas
option. However the address of each instruction is not printed because
instructions from different alternatives are not necessarily aligned.

Change this behavior to print the address of each instruction. Spaces
will appear between instructions from the same alternative when
instructions from different alternatives do not have the same alignment.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/disas.c | 152 +++++++++++++++++++++++++++++++++---------
 1 file changed, 121 insertions(+), 31 deletions(-)

diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index 321256f746425..f4bd802e38474 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -47,7 +47,11 @@ struct disas_alt {
 	struct alternative *alt;		/* alternative or NULL if default code */
 	char *name;				/* name for this alternative */
 	int width;				/* formatting width */
-	char *insn[DISAS_ALT_INSN_MAX];		/* alternative instructions */
+	struct {
+		char *str;			/* instruction string */
+		int offset;			/* instruction offset */
+	} insn[DISAS_ALT_INSN_MAX];		/* alternative instructions */
+	int insn_idx;				/* index of the next instruction to print */
 };
 
 #define DALT_DEFAULT(dalt)	(!(dalt)->alt)
@@ -364,16 +368,14 @@ char *disas_result(struct disas_context *dctx)
 	disas_print_insn(stdout, dctx, insn, depth, "\n")
 
 /*
- * Print a message in the instruction flow. If insn is not NULL then
- * the instruction address is printed in addition of the message,
- * otherwise only the message is printed. In all cases, the instruction
- * itself is not printed.
+ * Print a message in the instruction flow. If sec is not NULL then the
+ * address at the section offset is printed in addition of the message,
+ * otherwise only the message is printed.
  */
-void disas_print_info(FILE *stream, struct instruction *insn, int depth,
-		      const char *format, ...)
+static void disas_vprint(FILE *stream, struct section *sec, unsigned long offset,
+			 int depth, const char *format, va_list ap)
 {
 	const char *addr_str;
-	va_list args;
 	int len;
 	int i;
 
@@ -383,9 +385,9 @@ void disas_print_info(FILE *stream, struct instruction *insn, int depth,
 		depth = 0;
 	}
 
-	if (insn && insn->sec) {
-		addr_str = offstr(insn->sec, insn->offset);
-		fprintf(stream, "%6lx:  %-*s  ", insn->offset, len, addr_str);
+	if (sec) {
+		addr_str = offstr(sec, offset);
+		fprintf(stream, "%6lx:  %-*s  ", offset, len, addr_str);
 		free((char *)addr_str);
 	} else {
 		len += DISAS_INSN_OFFSET_SPACE + 1;
@@ -396,11 +398,44 @@ void disas_print_info(FILE *stream, struct instruction *insn, int depth,
 	for (i = 0; i < depth; i++)
 		fprintf(stream, "| ");
 
-	if (format) {
-		va_start(args, format);
-		vfprintf(stream, format, args);
-		va_end(args);
+	if (format)
+		vfprintf(stream, format, ap);
+}
+
+static void disas_print(FILE *stream, struct section *sec, unsigned long offset,
+			int depth, const char *format, ...)
+{
+	va_list args;
+
+	va_start(args, format);
+	disas_vprint(stream, sec, offset, depth, format, args);
+	va_end(args);
+}
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
+	struct section *sec;
+	unsigned long off;
+	va_list args;
+
+	if (insn) {
+		sec = insn->sec;
+		off = insn->offset;
+	} else {
+		sec = NULL;
+		off = 0;
 	}
+
+	va_start(args, format);
+	disas_vprint(stream, sec, off, depth, format, args);
+	va_end(args);
 }
 
 /*
@@ -534,6 +569,7 @@ static int disas_alt_init(struct disas_alt *dalt,
 {
 	dalt->orig_insn = orig_insn;
 	dalt->alt = alt;
+	dalt->insn_idx = 0;
 	dalt->name = alt ? strfmt("ALTERNATIVE %d", alt_num) :
 		strfmt("<alternative.%lx>", orig_insn->offset);
 	if (!dalt->name)
@@ -543,7 +579,8 @@ static int disas_alt_init(struct disas_alt *dalt,
 	return 0;
 }
 
-static int disas_alt_add_insn(struct disas_alt *dalt, int index, char *insn_str)
+static int disas_alt_add_insn(struct disas_alt *dalt, int index, char *insn_str,
+			      int offset)
 {
 	int len;
 
@@ -554,7 +591,8 @@ static int disas_alt_add_insn(struct disas_alt *dalt, int index, char *insn_str)
 	}
 
 	len = strlen(insn_str);
-	dalt->insn[index] = insn_str;
+	dalt->insn[index].str = insn_str;
+	dalt->insn[index].offset = offset;
 	if (len > dalt->width)
 		dalt->width = len;
 
@@ -569,12 +607,14 @@ static int disas_alt_group(struct disas_context *dctx, struct disas_alt *dalt)
 {
 	struct objtool_file *file;
 	struct instruction *insn;
+	int offset;
 	char *str;
 	int count;
 	int err;
 
 	file = dctx->file;
 	count = 0;
+	offset = 0;
 
 	alt_for_each_insn(file, DALT_GROUP(dalt), insn) {
 
@@ -583,9 +623,10 @@ static int disas_alt_group(struct disas_context *dctx, struct disas_alt *dalt)
 		if (!str)
 			return -1;
 
-		err = disas_alt_add_insn(dalt, count, str);
+		err = disas_alt_add_insn(dalt, count, str, offset);
 		if (err)
 			break;
+		offset += insn->len;
 		count++;
 	}
 
@@ -613,13 +654,63 @@ static int disas_alt_default(struct disas_context *dctx, struct disas_alt *dalt)
 	str = strdup(disas_result(dctx));
 	if (!str)
 		return -1;
-	err = disas_alt_add_insn(dalt, 0, str);
+	err = disas_alt_add_insn(dalt, 0, str, 0);
 	if (err)
 		return -1;
 
 	return 1;
 }
 
+/*
+ * For each alternative, if there is an instruction at the specified
+ * offset then print this instruction, otherwise print a blank entry.
+ * The offset is an offset from the start of the alternative.
+ *
+ * Return the offset for the next instructions to print, or -1 if all
+ * instructions have been printed.
+ */
+static int disas_alt_print_insn(struct disas_alt *alts, int alt_count,
+				int insn_count, int offset)
+{
+	struct disas_alt *dalt;
+	int offset_next;
+	char *str;
+	int i, j;
+
+	offset_next = -1;
+
+	for (i = 0; i < alt_count; i++) {
+		dalt = &alts[i];
+		j = dalt->insn_idx;
+		if (j == -1) {
+			printf("| %-*s ", dalt->width, "");
+			continue;
+		}
+
+		if (dalt->insn[j].offset == offset) {
+			str = dalt->insn[j].str;
+			printf("| %-*s ", dalt->width, str ?: "");
+			free(str);
+			if (++j < insn_count) {
+				dalt->insn_idx = j;
+			} else {
+				dalt->insn_idx = -1;
+				continue;
+			}
+		} else {
+			printf("| %-*s ", dalt->width, "");
+		}
+
+		if (dalt->insn[j].offset > 0 &&
+		    (offset_next == -1 ||
+		     (dalt->insn[j].offset < offset_next)))
+			offset_next = dalt->insn[j].offset;
+	}
+	printf("\n");
+
+	return offset_next;
+}
+
 /*
  * Disassemble an alternative.
  *
@@ -633,13 +724,14 @@ static void *disas_alt(struct disas_context *dctx,
 	struct disas_alt alts[DISAS_ALT_MAX] = { 0 };
 	struct alternative *alt;
 	struct disas_alt *dalt;
+	int offset_next;
 	int insn_count;
 	int alt_count;
 	int alt_id;
-	char *str;
+	int offset;
 	int count;
-	int i, j;
 	int err;
+	int i;
 
 	alt_id = orig_insn->offset;
 
@@ -700,16 +792,14 @@ static void *disas_alt(struct disas_context *dctx,
 	/*
 	 * Print instructions for each alternative.
 	 */
-	for (j = 0; j < insn_count; j++) {
-		disas_print_info(stdout, NULL, -2, NULL);
-		for (i = 0; i < alt_count; i++) {
-			dalt = &alts[i];
-			str = dalt->insn[j];
-			printf("| %-*s ", dalt->width, str ?: "");
-			free(str);
-		}
-		printf("\n");
-	}
+	offset_next = 0;
+	do {
+		offset = offset_next;
+		disas_print(stdout, orig_insn->sec, orig_insn->offset + offset,
+			    -2, NULL);
+		offset_next = disas_alt_print_insn(alts, alt_count, insn_count,
+						   offset);
+	} while (offset_next > offset);
 
 	return orig_insn->alt_group ? orig_insn->alt_group->last_insn : orig_insn;
 
-- 
2.43.5


