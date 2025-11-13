Return-Path: <linux-kernel+bounces-899888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DB1C590F5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 54A393577C9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1007F366573;
	Thu, 13 Nov 2025 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AA2dfbQ6"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A769364059
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052597; cv=none; b=I5UQL2Y8uXNKg7g9y8oDUDS4GKIMRfoFu3oduEaaXufs9j3klwdAM8qhrsBzlmSyjvq3S5grIZ1M6/5eJ49ljCOf+lksCV9xWy53D0uXN2EhzIiOaW7pYVq/KTY6Ka58bg3JIXH0849H12H+EhJ6HJ/JDLce2XlsSwZ8bvWs5Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052597; c=relaxed/simple;
	bh=XUAXAF74DOhHMef9jBz0QJoaQApmYe65pyFCdnksUbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZHVv4EAynZH0ZxMORzM/OQ89ejzVlhfHjm6gWX+RjD6IWb4ROrsHPOU4qpe8SaeSSm5SNZlOLrsq1ylZEyr3sEbdEZQyC3mCKr3t+JE/mD49ksYD3VngKuDTZk+9tO3MLyyx1BeLcv9L9XubsTA7C0EN+fnCh2E5l6U9+pL/m4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AA2dfbQ6; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADE9t5w023876;
	Thu, 13 Nov 2025 16:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=ncNzw
	JPhFH+djZbeGtAnKcG8QPze06VheaySiwD/GOk=; b=AA2dfbQ6zflAI0T4v+Dlv
	mDSAhqolBFgV0fvoliWVIatr4qDARMJ2uVejqfZpcC02vQEHdCKcvCMGu3LqjsoH
	f4e0fvPRP+jZ6jyxTobwmtHBLgmO2guWXHAuG1Uxm3cRMuukzbzwbprkDGgc+OyX
	eWYHbJSaFKvrUczSmlIOjWTrOQD8laNNIClPaNZybaVf5HpwzmxKDqAAjSi+OgCy
	oWTh8eSXjgmmK68x+JELzqWt9W5yYWY6nMI/XgDFKAj6GqwLc8Z76N0zwHoG/CsF
	Hbu4Ya86g1hYr+EGR+09ThvRdU7rw/xE5Q6dgPMUTAg0T5io+DvqLxGWdUWGoQ6m
	A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acvsstnn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADG8EKD039173;
	Thu, 13 Nov 2025 16:49:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacc3jh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:42 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ADGnKAB008288;
	Thu, 13 Nov 2025 16:49:42 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-172-143.vpn.oracle.com [10.154.172.143])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vacc38f-14;
	Thu, 13 Nov 2025 16:49:42 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v4 13/28] objtool: Identify the different types of alternatives
Date: Thu, 13 Nov 2025 17:49:02 +0100
Message-ID: <20251113164917.2563486-14-alexandre.chartre@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=bJUb4f+Z c=1 sm=1 tr=0 ts=69160c2d cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=RDt3PK5YzZswrGw8on0A:9
X-Proofpoint-GUID: H4nV52YDjxQykx9EGhaZo5FQ00X0zRUn
X-Proofpoint-ORIG-GUID: H4nV52YDjxQykx9EGhaZo5FQ00X0zRUn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyMyBTYWx0ZWRfXwCsNKWCHoTuL
 nMqiyNNvBkX3CCLGM0H8dVoptPKtOgdfp15cP/82u3KIgL5yRbp2UboxO2hi7MYDHmfitcFBmrO
 Ma5gFbIwquxI/DfuABtNjGM9RLmOHURFf1B9QMUNcTqTy9+IJzqUjjeL3GBJDbVPGMjPWSSi/z4
 1UbtC2CrybwnjanI5iMgcpUUVM0XwPmr8VVs4FEfYRz0ZRBr2BHrIrkA/OZkyrupuuTgCs/+S/f
 XqXjgDOcqA9Vx87H86U7qow82oi4TncdFB4bFmkqB6abMA4O5qAo/fXOZ3msMik+d3DOfkmZDnd
 OdDfVWtODc7jBEJIRaGVgSlliI2YeQ3+gzu/Sv5hzyuGCiC5kuZFUDjPVfT+V1arIDzrnLCyAnV
 T/kN9KMSDwcgAttNwpymDbe5vRDA1Q==

Alternative code, including jump table and exception table, is represented
with the same struct alternative structure. But there is no obvious way to
identify whether the struct represents alternative instructions, a jump
table or an exception table.

So add a type to struct alternative to clearly identify the type of
alternative.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/check.c                 | 13 ++++++++-----
 tools/objtool/include/objtool/check.h | 12 ++++++++++++
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 26682ac0185ec..93268b7c015e3 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -25,11 +25,6 @@
 #include <linux/static_call_types.h>
 #include <linux/string.h>
 
-struct alternative {
-	struct alternative *next;
-	struct instruction *insn;
-};
-
 static unsigned long nr_cfi, nr_cfi_reused, nr_cfi_cache;
 
 static struct cfi_init_state initial_func_cfi;
@@ -1910,6 +1905,7 @@ static int add_special_section_alts(struct objtool_file *file)
 	struct list_head special_alts;
 	struct instruction *orig_insn, *new_insn;
 	struct special_alt *special_alt, *tmp;
+	enum alternative_type alt_type;
 	struct alternative *alt;
 	int ret;
 
@@ -1948,11 +1944,17 @@ static int add_special_section_alts(struct objtool_file *file)
 			if (ret)
 				return ret;
 
+			alt_type = ALT_TYPE_INSTRUCTIONS;
+
 		} else if (special_alt->jump_or_nop) {
 			ret = handle_jump_alt(file, special_alt, orig_insn,
 					      &new_insn);
 			if (ret)
 				return ret;
+
+			alt_type = ALT_TYPE_JUMP_TABLE;
+		} else {
+			alt_type = ALT_TYPE_EX_TABLE;
 		}
 
 		alt = calloc(1, sizeof(*alt));
@@ -1963,6 +1965,7 @@ static int add_special_section_alts(struct objtool_file *file)
 
 		alt->insn = new_insn;
 		alt->next = orig_insn->alts;
+		alt->type = alt_type;
 		orig_insn->alts = alt;
 
 		list_del(&special_alt->list);
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index e5f97acb62522..73310c56e91b6 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -38,6 +38,18 @@ struct alt_group {
 	bool ignore;
 };
 
+enum alternative_type {
+	ALT_TYPE_INSTRUCTIONS,
+	ALT_TYPE_JUMP_TABLE,
+	ALT_TYPE_EX_TABLE,
+};
+
+struct alternative {
+	struct alternative *next;
+	struct instruction *insn;
+	enum alternative_type type;
+};
+
 #define INSN_CHUNK_BITS		8
 #define INSN_CHUNK_SIZE		(1 << INSN_CHUNK_BITS)
 #define INSN_CHUNK_MAX		(INSN_CHUNK_SIZE - 1)
-- 
2.43.5


