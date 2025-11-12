Return-Path: <linux-kernel+bounces-897690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF9FC537D5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B902568EBA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1974234B434;
	Wed, 12 Nov 2025 16:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X9NBfDO/"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61EF34B1A2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963472; cv=none; b=BXG4wchOkC5xJukY+RdPytNs9UjTRtmu/X9aNcaTcUw8cG243Vf/6Xm/eDhvcbBucUH4cjcIvnvkp/HKr++WoVjjc40bWpEoXgu2TC5qatEYiStpguPK/iaCOtPryOnuYK7eou9Bz8wJgs2UPW8JqVznPeoR7aGTgWmb41k49aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963472; c=relaxed/simple;
	bh=TVlCGa6GV92+xYOqZDO+z6v/96TqDiytNb7hpvtpK3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RtaZCyZqzUUgSY81A7IZUfixP9mjlJZRIqUsLDR+3pqLNNKAmgR1I/x9VN0jPuT5fWNHje8ytWscCVyKJEo/Ohb4o1N8ZSulSMfhCOXfMhTeMwxP/mIq3bgBkj6CCk5Xc+mI76isjD+nTu0qnl0nuVMoCWEetRLuKWzKMlwnkuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X9NBfDO/; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACFRDk7008543;
	Wed, 12 Nov 2025 16:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=5LgQ2
	f+rSDmiAonxwWPjQhXnmpPT9QWpdX3ApHmQH/g=; b=X9NBfDO/itwwHk2d+KXrx
	hE+N5aeYKFFbpACVW9UkCzLaQD0lr9mmCm8F6C0ShVhFS3s3MdAHri6ZL8LZW8bK
	G/nYsVolvrihKh7zpLIXd5n+50v4CNXzGkMuWZjKAd4O/117XvCzXlwjf4gVUHmK
	hu7RzfDx2Ix2qg/wJroi3nuTQwML4PuN0BBeFNQZFCuFQkOwjdiXi+lpjA4Z467V
	Y4/Tr/qAMakVI8YmKRFSUse/diZaUV0Xxp8r9DELYtxHxzyIYo/RqOHly3Xx3UO8
	d6HAh57BC31ihOrwEXO5X1jJpsDj3F0J62/R4AbtqdjDRFREMtrl8gdwrc0WSHNl
	A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acvssr4ns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEG4Vg018640;
	Wed, 12 Nov 2025 16:04:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaavqnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:24 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ACFxw3u004655;
	Wed, 12 Nov 2025 16:04:23 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-173-131.vpn.oracle.com [10.154.173.131])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vaavnq6-21;
	Wed, 12 Nov 2025 16:04:23 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v3 20/28] objtool: Disassemble exception table alternatives
Date: Wed, 12 Nov 2025 17:03:07 +0100
Message-ID: <20251112160315.2207947-21-alexandre.chartre@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=bJUb4f+Z c=1 sm=1 tr=0 ts=6914b008 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=UEfQvUvM895RRNYFhMwA:9
X-Proofpoint-GUID: qEBhNCEoyTKa_oQB7_xgxOhCehPENlAm
X-Proofpoint-ORIG-GUID: qEBhNCEoyTKa_oQB7_xgxOhCehPENlAm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyMyBTYWx0ZWRfXwNe4saDL0dIv
 R8KCMSKyhfwPd0O3VLQrnf1V2STA/K2ZbFeNJpeZXq/Kg3SQThGVZleIOpDqN8nvZK/ET4uBoRb
 ky3G8iURPHfq/vyvcsmIUkzNSh0jhQOdhy7dysMpc4rFmV0zOIMT+4KYUE1SYWMS9FRJmapYJXY
 wGLmaTXucZYKap/RIJkya4X3YuOWsUI7Md42B6lKhRU+d8ZIavhGWreJUg7qyjy/DfZDTjreVEq
 WbUyLjYCgriQYWhVKdWKUp5SjdNPa9W59v6JAKs+PJblHVKBrv5QrH1zUs1dAdyXzNuAdzQpC1M
 42uIvka3cy529RMNj3Zmv0GxzUO3Qbnwo6/iBxIS/ySDb9f6IKZ0B5dOkOAsZLgMK671CYdNxdi
 S0oEltuU+U1YRLkXCEkqd31In4Lkdg==

When using the --disas option, also disable exception tables (EX_TABLE)

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/disas.c | 45 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index dabf2340e9ccf..42f3bf310b033 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -535,13 +535,26 @@ static int disas_alt_init(struct disas_alt *dalt,
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
@@ -567,6 +580,26 @@ static int disas_alt_add_insn(struct disas_alt *dalt, int index, char *insn_str,
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
@@ -730,12 +763,16 @@ static void *disas_alt(struct disas_context *dctx,
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


