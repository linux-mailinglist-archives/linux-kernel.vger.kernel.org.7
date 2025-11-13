Return-Path: <linux-kernel+bounces-899896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98493C59055
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EA31502A6C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDA03570BE;
	Thu, 13 Nov 2025 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JwzwDNoN"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F7B36A00B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052604; cv=none; b=pC1rkA6j31eyDXidUDwteB5XV802mquQjw3t71ig7q0YmgSEyCgjJ1nl1oE3GiH9wJcjl3Va7O+kqdVb3XFrCMX0buVwjJA+jD5AORAtH3vQjZETKXuqo6/EyvKyh8Fy1WrE0cFm5fHR7PmGKpzgUy6cESPZq9CUk0mgF9f5sOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052604; c=relaxed/simple;
	bh=5sEycPMLXD/u82elFmHaNTYEhudgmp6SE5qHqWsdcAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vDbjidKw0HxNkxEUjBrC7XsvPwAXfq2yOwNPU2c9xBBuk8R2MmJST/ksxLXUTZiWMLjsQu32fHkyMt9T1bjFHmh1m6568fn+99IAmlvqVVFf4ggChtTJqXWWn4JioeWORP4obLTWmP4J3kMk4Dby3ilovcYSnv2aw1M2dqvrOYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JwzwDNoN; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADEACBp028898;
	Thu, 13 Nov 2025 16:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=kIenK
	1Hz7DEw9GF8Hjzf1LEA+DSZpA9RYpgc7Bh7CGg=; b=JwzwDNoN5vUiFhQCkpWA7
	LFtpX6mKm0g1KDVvAFoaiteWSkWP0A05qch148tp8PEjYHV7VANinzxEnjDaDSm5
	a9XxY+E9kck9gBdB37oIBy41hGqtvbJ6/H39X9T+yik2TZxD2fR50KoV6wdoYP/5
	TXeSvtxPvwO7Pfb9+FKPwT5a9I1xu3veGPQBqg49eGVcinTWGjqeO89pFzz3TfB8
	GgjRankGqPPCMpkZuHryDF0hGDZPhug//CnPhvix8V5MZbriV+lB6CWMzFEVZGYp
	mR24/y8e9bdJUCTY3dUPJuQPK/I7MrJWpiHgZ80vxU8verv1pDdiAaAzmQTRR+M+
	w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acxpnjb02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADGAeOw038607;
	Thu, 13 Nov 2025 16:49:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacc3x7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:54 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ADGnKAP008288;
	Thu, 13 Nov 2025 16:49:54 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-172-143.vpn.oracle.com [10.154.172.143])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vacc38f-21;
	Thu, 13 Nov 2025 16:49:54 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v4 20/28] objtool: Disassemble exception table alternatives
Date: Thu, 13 Nov 2025 17:49:09 +0100
Message-ID: <20251113164917.2563486-21-alexandre.chartre@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=Criys34D c=1 sm=1 tr=0 ts=69160c33 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=UEfQvUvM895RRNYFhMwA:9
X-Proofpoint-GUID: K42ZqXq5oyhxawAgD5PUkcNGrr8CcCLN
X-Proofpoint-ORIG-GUID: K42ZqXq5oyhxawAgD5PUkcNGrr8CcCLN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0MSBTYWx0ZWRfX7dnBuvL6aVPE
 Q6XQNLCpZIcuW1XchHHi3pLdF8uNUZeWl8yAbHk3rOIUkw7ykNg/ldNShH1HPifNP00M05NzHqP
 wxQlAh30RoJPaA69D4z2epqAS0kGnhp6jT5X4HcZBh1JUIB3njnJ9sOQ7Xzp6GnNV4KQpHuI+T/
 igBTNpEQ0pSOl5wol/VH4r854RdmnjnxhJHg68IyEtiIJxyHkzKxaH8Ou71pDIOpCra7ZQFy1Xd
 24m+izI12Hlj/IMq+oH+xQ4bGv2ONVy8G3m49ZuNepCgmdqfwU7Co3xWjVLTkZaMpWq9xcz7WxX
 5ay1wryp94jg5IGvjUpJWKxocJ0JD0ZKG0+JdF80YUrgwy4hPXuMkud4/xsZM4S+kHGq8tgEQnB
 BToSJohlgSp8XYKZYxcPRJxpwkPiuQ==

When using the --disas option, also disable exception tables (EX_TABLE)

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/disas.c | 45 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index f4bd802e38474..670fb8c646282 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -567,13 +567,26 @@ static int disas_alt_init(struct disas_alt *dalt,
 			  struct alternative *alt,
 			  int alt_num)
 {
+	char *str;
+
 	dalt->orig_insn = orig_insn;
 	dalt->alt = alt;
 	dalt->insn_idx = 0;
-	dalt->name = alt ? strfmt("ALTERNATIVE %d", alt_num) :
-		strfmt("<alternative.%lx>", orig_insn->offset);
-	if (!dalt->name)
+	if (!alt) {
+		str = strfmt("<alternative.%lx>", orig_insn->offset);
+	} else {
+		switch (alt->type) {
+		case ALT_TYPE_EX_TABLE:
+			str = strdup("EXCEPTION");
+			break;
+		default:
+			str = strfmt("ALTERNATIVE %d", alt_num);
+			break;
+		}
+	}
+	if (!str)
 		return -1;
+	dalt->name = str;
 	dalt->width = strlen(dalt->name);
 
 	return 0;
@@ -599,6 +612,26 @@ static int disas_alt_add_insn(struct disas_alt *dalt, int index, char *insn_str,
 	return 0;
 }
 
+/*
+ * Disassemble an exception table alternative.
+ */
+static int disas_alt_extable(struct disas_alt *dalt)
+{
+	struct instruction *alt_insn;
+	char *str;
+
+	alt_insn = dalt->alt->insn;
+	str = strfmt("resume at 0x%lx <%s+0x%lx>",
+		     alt_insn->offset, alt_insn->sym->name,
+		     alt_insn->offset - alt_insn->sym->offset);
+	if (!str)
+		return -1;
+
+	disas_alt_add_insn(dalt, 0, str, 0);
+
+	return 1;
+}
+
 /*
  * Disassemble an alternative and store instructions in the disas_alt
  * structure. Return the number of instructions in the alternative.
@@ -762,12 +795,16 @@ static void *disas_alt(struct disas_context *dctx,
 			goto error;
 
 		/*
-		 * Only group alternatives are supported at the moment.
+		 * Only group alternatives and exception tables are
+		 * supported at the moment.
 		 */
 		switch (dalt->alt->type) {
 		case ALT_TYPE_INSTRUCTIONS:
 			count = disas_alt_group(dctx, dalt);
 			break;
+		case ALT_TYPE_EX_TABLE:
+			count = disas_alt_extable(dalt);
+			break;
 		default:
 			count = 0;
 		}
-- 
2.43.5


