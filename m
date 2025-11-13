Return-Path: <linux-kernel+bounces-899876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34642C59126
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2353C3A9AD0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30703043B8;
	Thu, 13 Nov 2025 16:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pfcPPP3j"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C75535CBBD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052579; cv=none; b=S7MsnlVC+GUDMGg+TyIUbuue26dgOjHNdHuBLUCDib6R90bozkOtSqVWp2BofCtQJcNpLHWjFQAcXbaytDXJyZYdO6jGQjfHGaISJb5a94Qaw+bYXBllvk61oFGwZQHir4X/z/QPUdfNaugs/xufKbVY2XY7wSLqGCKx9KbAlpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052579; c=relaxed/simple;
	bh=gbvnhYzubzx7H/BNj1qdsqisuuBReqtUkoUxNeKZ5+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RtHG7O+Goqiq7sGyv5I6HfMoA3w9OQ0zHFUHQJZuK5yDRECEh1ZiavaCcp57p3e3JqcwmkJOq4wRwr/pQevKotbWw+0HLztAFFGFKUGUng9rmUmjqMYrRp1SNc16GvUxoEu4KBx0fiNIeZo+XetI4UYPa6Fbwa+Tcqlz2g1Q2ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pfcPPP3j; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADE9wwa014756;
	Thu, 13 Nov 2025 16:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=VCjhb
	Xg8e8BhVZxWVj3eoHY4yrmjKQhyPe9SZQIpC4o=; b=pfcPPP3j4Fh637EflvjAd
	dwsmgFlJzCHYHSDt2pmyQDA8gj1oR+oQM/vqYo8Eda5/qGL5mV+s8Z/ORncrK3FW
	5bjD3NsPwUz2ad8xbmEQSJOydCnZN2I8troH8pbu/7bYvkiuH6X0nEbNUOGxkS0Q
	1YtbEHE0512sfIptswZpYVLn3MH7ZlbP6ak+RG2edi+/mKil5lws3p5WbPIrp56p
	dkfbvC7no3OD3VKIab9trSJoyQ04g4qj9NYkTj/4xRypwyfoMmjySA+BHwVcFjrF
	+C9FprM/4XzNeh4Vvmpvy6xxzU1YWGzQEyElqj50oeHkCEkFgHoFs6oldpgtEb30
	g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acxwq27sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADFrVQW038513;
	Thu, 13 Nov 2025 16:49:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacc3ch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:30 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ADGnK9v008288;
	Thu, 13 Nov 2025 16:49:30 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-172-143.vpn.oracle.com [10.154.172.143])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vacc38f-7;
	Thu, 13 Nov 2025 16:49:30 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v4 06/28] objtool: Store instruction disassembly result
Date: Thu, 13 Nov 2025 17:48:55 +0100
Message-ID: <20251113164917.2563486-7-alexandre.chartre@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0MSBTYWx0ZWRfX7y0S2x2c/ziI
 ko9gIVQyCLHEERwQBHG2qp2B7g3j+x4jKlE7j1TMkhIwPl0MlATAc/50GsgZMN7ccVLpEsQVC+1
 3zorQ38x5a5e3ZCUW3g2or5LywEoXApMVJW5AoKO5rYmhslGSQ79TkV4yVn+WhZ8BlSCPR75UuV
 AVNSjmGqJsJtVGF/5eqJw65KHIFfTUMqIiEcOcjuRgzZhLGB2U0eEu1I0LYeN+gYNGWnAaab30q
 /D6SLeWucPvzR7cqboRAQCF+a31nG5Kawvu4EjNnJufhLdmhPrBTUYt119o0zYCg4CBgACOkRms
 jWc68Xm8UJQitf0L4IN21MdhhVfgtchh3PKi0wbF7u/ErY4GcZaO9v1Sq4A6hIUCNUoctbQwJg1
 BJBVF6zlBt6eW85+5xsPfC8Wd7b4HQ==
X-Proofpoint-ORIG-GUID: qCDvkfczIcC-_8b3e1x4t3jVr4Nhfr1Z
X-Authority-Analysis: v=2.4 cv=RrjI7SmK c=1 sm=1 tr=0 ts=69160c1b cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=jcmHYjYDc9FjrwFKAggA:9
X-Proofpoint-GUID: qCDvkfczIcC-_8b3e1x4t3jVr4Nhfr1Z

When disassembling an instruction store the result instead of directly
printing it.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/disas.c | 77 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 71 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index d1b1c215e7f25..aad5bc3651b8c 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -12,9 +12,16 @@
 #include <linux/string.h>
 #include <tools/dis-asm-compat.h>
 
+/*
+ * Size of the buffer for storing the result of disassembling
+ * a single instruction.
+ */
+#define DISAS_RESULT_SIZE	1024
+
 struct disas_context {
 	struct objtool_file *file;
 	struct instruction *insn;
+	char result[DISAS_RESULT_SIZE];
 	disassembler_ftype disassembler;
 	struct disassemble_info info;
 };
@@ -34,6 +41,59 @@ static int sprint_name(char *str, const char *name, unsigned long offset)
 #define DINFO_FPRINTF(dinfo, ...)	\
 	((*(dinfo)->fprintf_func)((dinfo)->stream, __VA_ARGS__))
 
+static int disas_result_fprintf(struct disas_context *dctx,
+				const char *fmt, va_list ap)
+{
+	char *buf = dctx->result;
+	size_t avail, len;
+
+	len = strlen(buf);
+	if (len >= DISAS_RESULT_SIZE - 1) {
+		WARN_FUNC(dctx->insn->sec, dctx->insn->offset,
+			  "disassembly buffer is full");
+		return -1;
+	}
+	avail = DISAS_RESULT_SIZE - len;
+
+	len = vsnprintf(buf + len, avail, fmt, ap);
+	if (len < 0 || len >= avail) {
+		WARN_FUNC(dctx->insn->sec, dctx->insn->offset,
+			  "disassembly buffer is truncated");
+		return -1;
+	}
+
+	return 0;
+}
+
+static int disas_fprintf(void *stream, const char *fmt, ...)
+{
+	va_list arg;
+	int rv;
+
+	va_start(arg, fmt);
+	rv = disas_result_fprintf(stream, fmt, arg);
+	va_end(arg);
+
+	return rv;
+}
+
+/*
+ * For init_disassemble_info_compat().
+ */
+static int disas_fprintf_styled(void *stream,
+				enum disassembler_style style,
+				const char *fmt, ...)
+{
+	va_list arg;
+	int rv;
+
+	va_start(arg, fmt);
+	rv = disas_result_fprintf(stream, fmt, arg);
+	va_end(arg);
+
+	return rv;
+}
+
 static void disas_print_addr_sym(struct section *sec, struct symbol *sym,
 				 bfd_vma addr, struct disassemble_info *dinfo)
 {
@@ -198,9 +258,8 @@ struct disas_context *disas_context_create(struct objtool_file *file)
 	dctx->file = file;
 	dinfo = &dctx->info;
 
-	init_disassemble_info_compat(dinfo, stdout,
-				     (fprintf_ftype)fprintf,
-				     fprintf_styled);
+	init_disassemble_info_compat(dinfo, dctx,
+				     disas_fprintf, disas_fprintf_styled);
 
 	dinfo->read_memory_func = buffer_read_memory;
 	dinfo->print_address_func = disas_print_address;
@@ -247,6 +306,11 @@ void disas_context_destroy(struct disas_context *dctx)
 	free(dctx);
 }
 
+static char *disas_result(struct disas_context *dctx)
+{
+	return dctx->result;
+}
+
 /*
  * Disassemble a single instruction. Return the size of the instruction.
  */
@@ -257,6 +321,7 @@ static size_t disas_insn(struct disas_context *dctx,
 	struct disassemble_info *dinfo = &dctx->info;
 
 	dctx->insn = insn;
+	dctx->result[0] = '\0';
 
 	if (insn->type == INSN_NOP) {
 		DINFO_FPRINTF(dinfo, "NOP%d", insn->len);
@@ -285,10 +350,10 @@ static void disas_func(struct disas_context *dctx, struct symbol *func)
 	printf("%s:\n", func->name);
 	sym_for_each_insn(dctx->file, func, insn) {
 		addr = insn->offset;
-		printf(" %6lx:  %s+0x%-6lx      ",
-		       addr, func->name, addr - func->offset);
 		disas_insn(dctx, insn);
-		printf("\n");
+		printf(" %6lx:  %s+0x%-6lx      %s\n",
+		       addr, func->name, addr - func->offset,
+		       disas_result(dctx));
 	}
 	printf("\n");
 }
-- 
2.43.5


