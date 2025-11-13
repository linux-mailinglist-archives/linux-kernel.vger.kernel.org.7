Return-Path: <linux-kernel+bounces-899901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D23CC5904C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 74F79344B4A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90284393DC7;
	Thu, 13 Nov 2025 16:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kRJN29gu"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37965393DC5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052617; cv=none; b=luCnb1Wsjsqy939knlvX2eeOyKpGHydpnLwXbv+tnaplWuhAmrcBVDOzAst4aVXvmqptcheT6jLByr69cBIu1oGP28WqRS78m8IRXNJaya/SCpfwZQPhTK7fuqne9HX8vu+rClB9Rtyq44utGSRtmrTYk5A0f27U+KK59+r+eyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052617; c=relaxed/simple;
	bh=PDid6cqsEMEYl/A2Kyqeifs2qppo5WweKFE0beqV0fA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GjyAqjYcc2RNElMe2TTaEJii93oa/2NW3jz2VV0v8doHkR9I+pwi6bCjpP//WT6whgSgwsEIVbAeS8nEL72tzzn8HSKNPzO0HveNVJtOrrpRhNIMZfyXNTyTIJu0Y283u8giAdhycPFwGV0m6bGGFzLtGuyIdtxrhBwS7yVtri0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kRJN29gu; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADE9w29012345;
	Thu, 13 Nov 2025 16:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=Qa6XG
	W4jBEuv5YFs5WWAWkLlhe/mXZ5Qjesi69dQmsQ=; b=kRJN29guDip6z3TU1PJz5
	U2Wwy5JshPPseiZwwnk87o3/RZtrfT3wW9ijo0gJsFIZVIwAt4mrF7aR3E+r2NHN
	b7+XY/yk2uvKRxVlwsQZeCx8scPywX4aj4ANUYT5pussm5psw+bilcv0Br88RC9H
	ySaZ8x0ETDrNwzQTk7erRQZ5Mp+qfRHIgibxYfZEH/Zu+1BJqmV3Oq7qENVbRmJD
	Asjg1xOlywqOrKO4ncID+rxEV2n2Yw5JzRNeMF2FYcm/NU3zOVsaQOPQWvABFcVV
	uRk4iVNdz0MhkOxff2tPpwgR/tNkudTz+UdUyZpTZpoGZDu9HGbc76rGIHGsrcJD
	A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acybqt8ny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:50:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADGH8Q0038719;
	Thu, 13 Nov 2025 16:50:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacc491-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:50:03 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ADGnKAZ008288;
	Thu, 13 Nov 2025 16:50:03 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-172-143.vpn.oracle.com [10.154.172.143])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vacc38f-26;
	Thu, 13 Nov 2025 16:50:03 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v4 25/28] objtool: Improve naming of group alternatives
Date: Thu, 13 Nov 2025 17:49:14 +0100
Message-ID: <20251113164917.2563486-26-alexandre.chartre@oracle.com>
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
X-Proofpoint-GUID: HbNHYFNgizWkcinWegDQG-R-v9pS2876
X-Proofpoint-ORIG-GUID: HbNHYFNgizWkcinWegDQG-R-v9pS2876
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0NyBTYWx0ZWRfXw8A3hmxMAe3S
 DfMAY5ShaZRVthdKsc4TSyQXBma4pMmFPkwUsqbXoTyjv98K7oEgGqOmsRxmYWAgz+BybQBd+XV
 TUmDh2g1Zk5TXaM9OdjFc+TUdFH24qpZi3NqC2zWalDiUKlAXPJccmGkoFtXCv8+ph+ltXiGl2f
 iozKxR7r5uz4JxmjftjbYQIaMdt9OmsSlzCaSWb7HuTRKcTK/DnjztEaS0pQ7vaJlcXGyh8BLQl
 sp0hkCpvxNxtFaqZxW7lGIjTG+tmAPJFzG0vDFcwZ764ahW4Opzjym/bilfjWVSzR6rUPdTUDbh
 qpkwM8uVhBpCJVEqbTM3c/C3c8PVRtqabX+ZhZCt66sVT6S1cBBU65DQCAqXBAu9IU3t9sB88Ap
 A/rs6v8XojdnbiQqcDWA7E/CPZ0quQ==
X-Authority-Analysis: v=2.4 cv=X7hf6WTe c=1 sm=1 tr=0 ts=69160c3c cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=axKxejlUv49_pL_PyZUA:9

Improve the naming of group alternatives by showing the feature name and
flags used by the alternative.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/check.c |  1 -
 tools/objtool/disas.c | 86 ++++++++++++++++++++++++++++---------------
 2 files changed, 57 insertions(+), 30 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 817ac70fed9fa..43593766e80e0 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3661,7 +3661,6 @@ static int validate_insn(struct objtool_file *file, struct symbol *func,
 				return ret;
 			}
 		}
-
 		TRACE_ALT_INFO_NOADDR(insn, "/ ", "DEFAULT");
 	}
 
diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index e506fdda4d897..2a6c3708ec315 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -9,6 +9,7 @@
 #include <objtool/arch.h>
 #include <objtool/check.h>
 #include <objtool/disas.h>
+#include <objtool/special.h>
 #include <objtool/warn.h>
 
 #include <bfd.h>
@@ -60,6 +61,21 @@ struct disas_alt {
 #define DALT_GROUP(dalt)	(DALT_INSN(dalt)->alt_group)
 #define DALT_ALTID(dalt)	((dalt)->orig_insn->offset)
 
+#define ALT_FLAGS_SHIFT		16
+#define ALT_FLAG_NOT		(1 << 0)
+#define ALT_FLAG_DIRECT_CALL	(1 << 1)
+#define ALT_FEATURE_MASK	((1 << ALT_FLAGS_SHIFT) - 1)
+
+static int alt_feature(unsigned ft_flags)
+{
+	return (ft_flags & ALT_FEATURE_MASK);
+}
+
+static int alt_flags(unsigned ft_flags)
+{
+	return (ft_flags >> ALT_FLAGS_SHIFT);
+}
+
 /*
  * Wrapper around asprintf() to allocate and format a string.
  * Return the allocated string or NULL on error.
@@ -593,7 +609,12 @@ static struct instruction *next_insn_same_alt(struct objtool_file *file,
  */
 char *disas_alt_name(struct alternative *alt)
 {
+	char pfx[4] = { 0 };
 	char *str = NULL;
+	const char *name;
+	int feature;
+	int flags;
+	int num;
 
 	switch (alt->type) {
 
@@ -607,13 +628,37 @@ char *disas_alt_name(struct alternative *alt)
 
 	case ALT_TYPE_INSTRUCTIONS:
 		/*
-		 * This is a non-default group alternative. Create a unique
-		 * name using the offset of the first original and alternative
-		 * instructions.
+		 * This is a non-default group alternative. Create a name
+		 * based on the feature and flags associated with this
+		 * alternative. Use either the feature name (it is available)
+		 * or the feature number. And add a prefix to show the flags
+		 * used.
+		 *
+		 * Prefix flags characters:
+		 *
+		 *   '!'  alternative used when feature not enabled
+		 *   '+'  direct call alternative
+		 *   '?'  unknown flag
 		 */
-		asprintf(&str, "ALTERNATIVE %lx.%lx",
-			 alt->insn->alt_group->orig_group->first_insn->offset,
-			 alt->insn->alt_group->first_insn->offset);
+
+		feature = alt->insn->alt_group->feature;
+		num = alt_feature(feature);
+		flags = alt_flags(feature);
+		str = pfx;
+
+		if (flags & ~(ALT_FLAG_NOT | ALT_FLAG_DIRECT_CALL))
+			*str++ = '?';
+		if (flags & ALT_FLAG_DIRECT_CALL)
+			*str++ = '+';
+		if (flags & ALT_FLAG_NOT)
+			*str++ = '!';
+
+		name = arch_cpu_feature_name(num);
+		if (!name)
+			str = strfmt("%sFEATURE 0x%X", pfx, num);
+		else
+			str = strfmt("%s%s", pfx, name);
+
 		break;
 	}
 
@@ -626,32 +671,15 @@ char *disas_alt_name(struct alternative *alt)
  */
 static int disas_alt_init(struct disas_alt *dalt,
 			  struct instruction *orig_insn,
-			  struct alternative *alt,
-			  int alt_num)
+			  struct alternative *alt)
 {
-	char *str;
-
 	dalt->orig_insn = orig_insn;
 	dalt->alt = alt;
 	dalt->insn_idx = 0;
-	if (!alt) {
-		str = strfmt("<alternative.%lx>", orig_insn->offset);
-	} else {
-		switch (alt->type) {
-		case ALT_TYPE_EX_TABLE:
-			str = strdup("EXCEPTION");
-			break;
-		case ALT_TYPE_JUMP_TABLE:
-			str = strdup("JUMP");
-			break;
-		default:
-			str = strfmt("ALTERNATIVE %d", alt_num);
-			break;
-		}
-	}
-	if (!str)
+	dalt->name = alt ? disas_alt_name(alt) :
+		strfmt("<alternative.%lx>", orig_insn->offset);
+	if (!dalt->name)
 		return -1;
-	dalt->name = str;
 	dalt->width = strlen(dalt->name);
 
 	return 0;
@@ -864,7 +892,7 @@ static void *disas_alt(struct disas_context *dctx,
 	/*
 	 * Initialize and disassemble the default alternative.
 	 */
-	err = disas_alt_init(&alts[0], orig_insn, NULL, 0);
+	err = disas_alt_init(&alts[0], orig_insn, NULL);
 	if (err)
 		goto error;
 
@@ -883,7 +911,7 @@ static void *disas_alt(struct disas_context *dctx,
 			break;
 		}
 		dalt = &alts[i];
-		err = disas_alt_init(dalt, orig_insn, alt, i);
+		err = disas_alt_init(dalt, orig_insn, alt);
 		if (err)
 			goto error;
 
-- 
2.43.5


