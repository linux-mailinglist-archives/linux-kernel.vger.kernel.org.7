Return-Path: <linux-kernel+bounces-897691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E207FC53953
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01E13B7E47
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BA434BA53;
	Wed, 12 Nov 2025 16:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ptjLiXEZ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144D234B410
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963473; cv=none; b=DhH1NLCMKxh7wVIqwUuByFERVB13cFpZ7swLpscICD3mAy/CYyyOhAvXi/09mooZCvqwkRzg446s0nHDjdmeINutcQyw7OyqAmZRGbEWQfYXUxlfSHcUlAfDRJUTHpob4lcjAI8DneUcRgKSA0uzBBn/Ce7jNzljdO4Wc/rhgG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963473; c=relaxed/simple;
	bh=bdY34+Hk+iO6II3DlvBr0qmzUTdVLbu3xcJKQGcFbGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=agVHz/I7epEFOyUA3AeWMNa2C7nmaLR4uDBjdCQVGhZ5nzRBmG53PNnVc/XOTXLrP+5XJ1XUrscmtpp4bDauykAlbL8RiNpsMpjc6jR+IGOkDIXPPSKsh0iHsYHzhii2H9nDvPfiu3jqvUVQVE8jGBpuUoPFySktzRlNJ8A4bAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ptjLiXEZ; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACFRHv5008644;
	Wed, 12 Nov 2025 16:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=UFlCn
	5Lj55QJAeI6msqkpGV89L9woRHvuDucSYgSwT4=; b=ptjLiXEZY6Mc9AxRj+rvk
	N37y2eSRr4iHaNrlIvDgpKCkGEE8qlb8BW+9IUV5yk1rGnvTU1p9JL8iNOgFhD4C
	Xr4buLDEEcrJcQ4+vIlHCdOdMed7sdLnbMK4GPKEAXG7kM6guSn+YVxlsWufQ7r0
	7Z+ErbijAWWX2YVrqRJ2jGDz5TJI32pHQcol9+uxhL8RdA4nsK5sLq5CNf9qBCFQ
	3MyE8/49vWYnaOBT1/J8UvucmRdlyUdzFlNyvD+GIJlswywXnZtfLkkRnxCm2VcQ
	X6UjsOVI6CW/zHJtQO+JIqNV6CqZtXvgj69pwwAjH6y/CfughLS8Z4/mSNOczk3q
	w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acvssr4p0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEG3BJ018617;
	Wed, 12 Nov 2025 16:04:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaavqp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:25 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ACFxw3w004655;
	Wed, 12 Nov 2025 16:04:25 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-173-131.vpn.oracle.com [10.154.173.131])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vaavnq6-22;
	Wed, 12 Nov 2025 16:04:25 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v3 21/28] objtool: Disassemble jump table alternatives
Date: Wed, 12 Nov 2025 17:03:08 +0100
Message-ID: <20251112160315.2207947-22-alexandre.chartre@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=bJUb4f+Z c=1 sm=1 tr=0 ts=6914b00a b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=lcG_xirucoqnFA0wguoA:9
X-Proofpoint-GUID: hsdOicLNgVhBevOXSRQUNa_FPBE2LXKz
X-Proofpoint-ORIG-GUID: hsdOicLNgVhBevOXSRQUNa_FPBE2LXKz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyMyBTYWx0ZWRfX8l7edgIap+tZ
 kWDOA27MR7BGFoR06nM5n924saegBM1et4vBr+9pmihfL6shFLqeX6zndygwI+KnKq/rNhB1U0S
 80U2Dimi68N/i20nCGHvh3bCd6qfOhCOIjD2ZNzPMaU9tUDF3DXMRwFu0qbdX2yzCJ+8OOfKL1O
 I9Fklksk4X4DvIG19yQoaKlv33+HO5kENGpIKTYBIsdt3g2cO4qI0fiYj124iuTh5DD4s6Aw4PS
 Z2NbmITYmKp0d5PzAe6whRdkKlpPZYc2VtSXi2mS2XnUUbrbF3K3wfh5gdAgII0x82GrmzdU60s
 ArrfpL3Zp3oJHFN3rkX6bFgM0aoIm2RQAxb/AQFlJ4JakNPBiCh5awYeqxhtS9Ta9/h56yGGzzU
 OQH1AWWZCcxNYRlI8vqaKNmZG8gpKw==

When using the --disas option, also disable jump tables.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/disas.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index 42f3bf310b033..96056e873f97e 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -547,6 +547,9 @@ static int disas_alt_init(struct disas_alt *dalt,
 		case ALT_TYPE_EX_TABLE:
 			str = strdup("EXCEPTION");
 			break;
+		case ALT_TYPE_JUMP_TABLE:
+			str = strdup("JUMP");
+			break;
 		default:
 			str = strfmt("ALTERNATIVE %d", alt_num);
 			break;
@@ -580,6 +583,34 @@ static int disas_alt_add_insn(struct disas_alt *dalt, int index, char *insn_str,
 	return 0;
 }
 
+static int disas_alt_jump(struct disas_alt *dalt)
+{
+	struct instruction *orig_insn;
+	struct instruction *dest_insn;
+	char suffix[2] = { 0 };
+	char *str;
+
+	orig_insn = dalt->orig_insn;
+	dest_insn = dalt->alt->insn;
+
+	if (orig_insn->type == INSN_NOP) {
+		if (orig_insn->len == 5)
+			suffix[0] = 'q';
+		str = strfmt("jmp%-3s %lx <%s+0x%lx>", suffix,
+			     dest_insn->offset, dest_insn->sym->name,
+			     dest_insn->offset - dest_insn->sym->offset);
+	} else {
+		str = strfmt("NOP%d", orig_insn->len);
+	}
+
+	if (!str)
+		return -1;
+
+	disas_alt_add_insn(dalt, 0, str, 0);
+
+	return 1;
+}
+
 /*
  * Disassemble an exception table alternative.
  */
@@ -762,10 +793,7 @@ static void *disas_alt(struct disas_context *dctx,
 		if (err)
 			goto error;
 
-		/*
-		 * Only group alternatives and exception tables are
-		 * supported at the moment.
-		 */
+		count = -1;
 		switch (dalt->alt->type) {
 		case ALT_TYPE_INSTRUCTIONS:
 			count = disas_alt_group(dctx, dalt);
@@ -773,8 +801,9 @@ static void *disas_alt(struct disas_context *dctx,
 		case ALT_TYPE_EX_TABLE:
 			count = disas_alt_extable(dalt);
 			break;
-		default:
-			count = 0;
+		case ALT_TYPE_JUMP_TABLE:
+			count = disas_alt_jump(dalt);
+			break;
 		}
 		if (count < 0)
 			goto error;
-- 
2.43.5


