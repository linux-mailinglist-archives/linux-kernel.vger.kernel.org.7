Return-Path: <linux-kernel+bounces-897689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 51767C535E2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8B2EC35A11A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B172034B425;
	Wed, 12 Nov 2025 16:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M+1afVG8"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BA334AB18
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963471; cv=none; b=M4CIiXt/PphupTvTOcNL5zCyBwWOj722ZZFG2VgEryrSSpAb8THVPlTelOo9j9oSAyz30Y+iWYBsPb/5VMJppriVoa1S3ufpqcydkjbQ14i9y8aWzqpRJQGPGK/Lo4Kk30jh3PTnR+dJRO/65zM5gmK+Ndx6irS5pn/G1XvtbTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963471; c=relaxed/simple;
	bh=6EJ98B4JqQMBzEuAKbzZlN0UjYeA5mkvLlGhpF4/wIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G57oah08xJ34I/iFfc0IlzfZjJTJIN69YQNOLLghvCbNu2BaRsgOQ8kODQ1w/wW4/IyLog6D4tdYmZwicUT/4Ulm5E2UgoC173/oDFm7gyqF8NcOfVT3Dsu3f+74DpQVbUekdhl0Aw5B3hz5pU8tO/dxq01WQZWdRjmyBhr0wUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M+1afVG8; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACG0OmJ008381;
	Wed, 12 Nov 2025 16:04:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=TCQUr
	4DREFS+7R++57ZBXFr0tLhz1BZePCi/aCKDPRk=; b=M+1afVG8gJANAR6VfcZXH
	9StwOKQ35cxmLjvcieE1e2fsqvMweYG9X/v+lOmwqn+4hF15xo5n+DMoXk7IH1Nd
	MosnIGs5XLyIbawo/hYwj1C+rkiXB0Cs5OmWO2XOTW0NbTPzqxmBgfY9wR7S7Fsr
	8gaRrqE4o1saheEHp1RHORM8PvvjKFCbchN63Eu9qF0ps2yXPQRDLdtc6opSNOjJ
	k819EE26pg7HYyZSHvhG6l5FFJ6JTFrhBXgS0azsoqeHNvunwIwFc1i837H2ioye
	86BdVJzxtEqmVgIkgfs7htuIJjMDmhdsx/OGM7+jOyewPbRyX+3OkV8MY+fow91I
	Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acwcg80hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEG3P3018594;
	Wed, 12 Nov 2025 16:04:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaavqn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:22 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ACFxw3s004655;
	Wed, 12 Nov 2025 16:04:22 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-173-131.vpn.oracle.com [10.154.173.131])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vaavnq6-20;
	Wed, 12 Nov 2025 16:04:21 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v3 19/28] objtool: Print addresses with alternative instructions
Date: Wed, 12 Nov 2025 17:03:06 +0100
Message-ID: <20251112160315.2207947-20-alexandre.chartre@oracle.com>
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
X-Proofpoint-GUID: 95EPsvnR7eeQQ7a1gtIc9FZ5you_4PvX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyOSBTYWx0ZWRfX+bswGnWlSiJE
 3botO2/NCV1bDQCtdJPFsI0RPMjHBaPFe6Sj5qOiKLEmiOiEoVv4Qo60RL0vXdd0GacrDNiJTYC
 jm8LSfJnAbIuTmJEsubTdjvVhZP8sOGOZG5jJMhPLYjJo++ObL5llzFm7oUPm7r96nRRzYImfZr
 X+1c8JeGc9y2H5jUdh9IhMNplaMLVJg/dtqJheLztdi5/e5nKyr3hhmK4R7WAqZTUtLbLGiCgeD
 4gNpP2m0PPFiSRpqq+dKXy2sN+2BaRpWEGiisnMrMWadeE4dccvAe/q2jxrmHJP+FHjBM/yZvp8
 DIvjuwjzMzbyI2ckDNVXigd7TMDSTCsOVDySjC9Mu90qcjY2P8JHKS5b/U8wvTHCIIOMz3pPiky
 sKVEmxZPWsYd2CdvfV376RA16AsoVQ==
X-Proofpoint-ORIG-GUID: 95EPsvnR7eeQQ7a1gtIc9FZ5you_4PvX
X-Authority-Analysis: v=2.4 cv=LewxKzfi c=1 sm=1 tr=0 ts=6914b007 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=WFXfjiaBZm73b8CXPiEA:9

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
index 28c77762b1bd5..dabf2340e9ccf 100644
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
@@ -502,6 +537,7 @@ static int disas_alt_init(struct disas_alt *dalt,
 {
 	dalt->orig_insn = orig_insn;
 	dalt->alt = alt;
+	dalt->insn_idx = 0;
 	dalt->name = alt ? strfmt("ALTERNATIVE %d", alt_num) :
 		strfmt("<alternative.%lx>", orig_insn->offset);
 	if (!dalt->name)
@@ -511,7 +547,8 @@ static int disas_alt_init(struct disas_alt *dalt,
 	return 0;
 }
 
-static int disas_alt_add_insn(struct disas_alt *dalt, int index, char *insn_str)
+static int disas_alt_add_insn(struct disas_alt *dalt, int index, char *insn_str,
+			      int offset)
 {
 	int len;
 
@@ -522,7 +559,8 @@ static int disas_alt_add_insn(struct disas_alt *dalt, int index, char *insn_str)
 	}
 
 	len = strlen(insn_str);
-	dalt->insn[index] = insn_str;
+	dalt->insn[index].str = insn_str;
+	dalt->insn[index].offset = offset;
 	if (len > dalt->width)
 		dalt->width = len;
 
@@ -537,12 +575,14 @@ static int disas_alt_group(struct disas_context *dctx, struct disas_alt *dalt)
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
 
@@ -551,9 +591,10 @@ static int disas_alt_group(struct disas_context *dctx, struct disas_alt *dalt)
 		if (!str)
 			return -1;
 
-		err = disas_alt_add_insn(dalt, count, str);
+		err = disas_alt_add_insn(dalt, count, str, offset);
 		if (err)
 			break;
+		offset += insn->len;
 		count++;
 	}
 
@@ -581,13 +622,63 @@ static int disas_alt_default(struct disas_context *dctx, struct disas_alt *dalt)
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
@@ -601,13 +692,14 @@ static void *disas_alt(struct disas_context *dctx,
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
 
@@ -668,16 +760,14 @@ static void *disas_alt(struct disas_context *dctx,
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


