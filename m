Return-Path: <linux-kernel+bounces-899897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FCEC59078
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 83C6D35F0F9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D0C3730C8;
	Thu, 13 Nov 2025 16:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ML97FX/V"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDFE36A03D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052605; cv=none; b=qCLlpctNLhNitegppLU6wuZtNuWFVZhPqrjIsr3dDGyxL2ukyIla8OqF+QAwCSg90gvbFSO9OD8pLsYTQVQsKwEYadL3sTUhiX21O182INt8LfsAnvxdSoWdEOJjYVV1osc0BS7V+qajNLW7xMADqW6wiw+u+rvIFuUUpAiBKOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052605; c=relaxed/simple;
	bh=60XqvTxYtvBgpKu1JSbAySRnsUputvEtOSWt4LZJSQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cHzFMPCHL1doDYCnFKTeXXT8jVwcL6xX+CbKGqz+/R3X32OWjS1S/86RZqu8i4NCOjNS6AT0PBkc/vm9nzoH2l96ddE3ES2ozpJ3jIF9Tjt7YV4Z5T2hSlnj5u42rIruAYXNUTFIq19TEDzWCp9BGxQ4eRZzTWPAeQ3VMz3kwhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ML97FX/V; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADEA2KN028782;
	Thu, 13 Nov 2025 16:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=7GTPB
	6wGPmwDh9ro0FXo6DAIReHKYJYMHCsHjqDZO+I=; b=ML97FX/VqIrLsGx5LUZH8
	hqBkSmnLzDaO/rbxtOG8QXpIN8KSxqaEndtBbWJdDNz+5MUrpiHTp09gifPU1njr
	wddidtZN/gTBZ8OVbmnYgyEe+O1nvRt4UeuOZAOgKigagLwjsyuC6xnc9I/hnYxC
	rwRFdxQaNuXbCyd6c6apvdLWZwdPZTjeQMn1zdZPSAX4xqCWBfDY9+70cbZSq1DC
	UaF4Qul+4bZuyuI6gwn3Npoi7FE+YAdPPKJ3RSVCVaKXiDDRr3YNv+FN9fYaSwIc
	YerQwq+TcGUZ6zaQavEzwIdFtNiTdBwY91X8NGwaNIT/GBGGmZyrYPnjJ8ECYe/R
	w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acxpnjb05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADGDUdk038611;
	Thu, 13 Nov 2025 16:49:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacc3ys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:56 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ADGnKAR008288;
	Thu, 13 Nov 2025 16:49:56 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-172-143.vpn.oracle.com [10.154.172.143])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vacc38f-22;
	Thu, 13 Nov 2025 16:49:56 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v4 21/28] objtool: Disassemble jump table alternatives
Date: Thu, 13 Nov 2025 17:49:10 +0100
Message-ID: <20251113164917.2563486-22-alexandre.chartre@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=Criys34D c=1 sm=1 tr=0 ts=69160c35 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=lcG_xirucoqnFA0wguoA:9
X-Proofpoint-GUID: ORAi2kUt1cTj3BJAPdW08_A6RxHACQZX
X-Proofpoint-ORIG-GUID: ORAi2kUt1cTj3BJAPdW08_A6RxHACQZX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0MSBTYWx0ZWRfX6oJNRdD86h+8
 LB9AQmvrIgL8yRuFrJzwxwsZ0DJWi5cqxPZl+tz61UrltbnI99krJ3bndrIWJP4pbsaNIgVAnwd
 vF0v6C7yiMInDbDUpEIg/UNnZso66c3zznncCsENzDxQDULDQCN/8bveV/m6GGLsQZshj9Z+zpY
 me6n1EDIo3eJ1k4fztXpat7oQxqc6EabbnNOFHvcrwAd3j2MaJmP04UxMxyXh0SXFJsGklzG7xk
 qcmw75t7MEOnH8PwQsgVbwOTcCh8NnO3e7ugbQLhiZvO75Bru+YIaNKXv/47El3sLrbID8DT63g
 y40C/kJ/o2gQ741o8ZEG2IyOHbYcpVBqtH/GEyep8VGfWiE2UAUW2/PC2T57JNPeGrs1f8JD+3S
 ZxxVRaILJvvaiYAw0889C3+Slaq3Ng==

When using the --disas option, also disable jump tables.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/disas.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index 670fb8c646282..6ec241806f5c4 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -579,6 +579,9 @@ static int disas_alt_init(struct disas_alt *dalt,
 		case ALT_TYPE_EX_TABLE:
 			str = strdup("EXCEPTION");
 			break;
+		case ALT_TYPE_JUMP_TABLE:
+			str = strdup("JUMP");
+			break;
 		default:
 			str = strfmt("ALTERNATIVE %d", alt_num);
 			break;
@@ -612,6 +615,34 @@ static int disas_alt_add_insn(struct disas_alt *dalt, int index, char *insn_str,
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
@@ -794,10 +825,7 @@ static void *disas_alt(struct disas_context *dctx,
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
@@ -805,8 +833,9 @@ static void *disas_alt(struct disas_context *dctx,
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


