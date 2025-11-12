Return-Path: <linux-kernel+bounces-897674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CB2C53594
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 94D713588AD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23344342514;
	Wed, 12 Nov 2025 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LxfKl9B/"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2975F341AC6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963452; cv=none; b=F6TBGn/koiXmzhE+2mxcr0cXlkqJRp0vwOzuAKxu/73953swLIkHCVMi4tVx2yjHpWtwfwsx4BhpTBSrn5IByHb0ZEXfB0PteXh6YRP+ltqoytl+7Nq6JWAku8+LdWgdRaUq5h+wlDhebxA1EBG0dS0MZzFjsDWS8tnpg7Px18E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963452; c=relaxed/simple;
	bh=gbvnhYzubzx7H/BNj1qdsqisuuBReqtUkoUxNeKZ5+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dr7FZy7x7qSC9e1ZEi3ngJH47hWk1jtrqyuZLq9X6br22P6YItRRwzlC8M2MBpEchM6DFIkWyvdPiyGXUFbRMF1hqYxoH0SFJydhWWSUq5bdvAg1lYJeBBijczPVPIK3qsFLs7+bsF/E0kgEzQlocQPpQz8eA7uyBETFBIXOj7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LxfKl9B/; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACFVxV5012517;
	Wed, 12 Nov 2025 16:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=VCjhb
	Xg8e8BhVZxWVj3eoHY4yrmjKQhyPe9SZQIpC4o=; b=LxfKl9B/v4at3dSik1fIJ
	K0AUMjgzavXHI0l4H/YVqEZY7qEcRCWe2cB+ClsCYuPPWMrb5R64BWxX9HR1vUEM
	8n41whRRr8mdk/l16uWAAppCsuaGPs91SKwJRmPqnqBEfgYaCKW0HLAZAs2jbjU3
	ha0/ZqNSGWGingN392sTQ7f3um+SJNdx9tKvo4wvHmh6vrMZWWAJtnCxh14jkRPO
	aqXp8C8zB8+7hRMUuvT32MvUFtNw28DpVVm6Ukw9I6FlW1jYoeo12vovRjurdbkH
	rwLh0YMxk+fuHC4+nZTazB/fiZL6cckzGn+TFcpEIw32MwOMCcaqrWXO/zBbyAHf
	Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acv97r6ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEG4lr018761;
	Wed, 12 Nov 2025 16:03:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaavq2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:03:59 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ACFxw3S004655;
	Wed, 12 Nov 2025 16:03:58 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-173-131.vpn.oracle.com [10.154.173.131])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vaavnq6-7;
	Wed, 12 Nov 2025 16:03:58 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v3 06/28] objtool: Store instruction disassembly result
Date: Wed, 12 Nov 2025 17:02:53 +0100
Message-ID: <20251112160315.2207947-7-alexandre.chartre@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=Cseys34D c=1 sm=1 tr=0 ts=6914aff0 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=jcmHYjYDc9FjrwFKAggA:9
X-Proofpoint-ORIG-GUID: WPaAo5DS0xNLZW_V6DOlEG5OghyBh8Gh
X-Proofpoint-GUID: WPaAo5DS0xNLZW_V6DOlEG5OghyBh8Gh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExOSBTYWx0ZWRfX7yf9UAykp8Ur
 8bLWGKh0Tl2oy4um0Dwg0tV+ls8DzWO7kue5Hr95IzvmuLsdrMzIqj+dWLaR2E6XsSb+qXH9CfE
 LSDUv2E7g+V+NBOWHoXk1joIXeWCD6abwTGbYoOcsggffH/7kZQupiYLUZW/VHR1D+IuWSA8ab1
 qa69tMYjGqedMM4FGDzbCoNheBPfbsrHoDt5/g3VsjPv2emKKrRXcZ3DB7gync1H7hjufGneFmN
 fom7smZRZ5VDI+0AisbK3fe0u/ovV5DjgUnMp1qsrQVukwMJU+9KFjRX+Qm08A5oxVA9sVh/BFI
 ClPGXo5LYGHBehijXYpSSRJlA3M9WbQDsutvmcGig7+ilM8Ku3nH2ZkK2v5J0Z6JnosqYeXXXx9
 4D9A3h7+hEDr6645nToMBU27QHvgYQ==

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


