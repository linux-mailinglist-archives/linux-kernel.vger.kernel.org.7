Return-Path: <linux-kernel+bounces-897683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A033C53603
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6895A359A88
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B49533B6C7;
	Wed, 12 Nov 2025 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lPrheImo"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E579A3469EB
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963460; cv=none; b=mT5Fdpz9mJ9DItK9Y0WpYL3qN/RQugZHISxxvgiRHU/XJlDwLOAoargun3QE6yEsRwq7Tt3Suyv0ygLJcKbCPLj5q5sozYVcQdrOZZ+RCAuKyW/nr/Zdnip9sPABKIgq+R9Nkp7LoaEtKVJPLjuXFBqpVELAG1uSOt9iJHkClqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963460; c=relaxed/simple;
	bh=XUAXAF74DOhHMef9jBz0QJoaQApmYe65pyFCdnksUbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=osdA0H26kRUz+nZa0OMNHgfiwZm/WW9z9KRWmaQZFplTiukPmv7sq9pJXNKT6cimmMNtoSKYSMTCMmBHPXPTH62gIvAaRVx5IRMvTUJJ+II1x3Fi1zhxXADa1Ef56soAb3v/l21+/WC/TbiOnj5yX+NfweL+jwC7o8lGp0fhj7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lPrheImo; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACG0Vt9008495;
	Wed, 12 Nov 2025 16:04:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=ncNzw
	JPhFH+djZbeGtAnKcG8QPze06VheaySiwD/GOk=; b=lPrheImom9pTq0Aqv9Z36
	O5VuUgy7MZPnOHXxMXpOY2mCRkk15KykZZNwJnBV5onVlS8Y41AXHdsDrefPvHdc
	6Dv8fixHLHropw1CKyjrpUePsj+CH71V32vgQuPesaU6FU6dhc+yOak+AFWEKN7S
	jlc7P/+IURLxGetbzBW7ElMfUyUDKr1Mj9YPCPvMELQI3TEXoDV0CZLad8nmNVXj
	WAFlIQt9mAoTKhOGGqxvqzUt4P0mfp4//wg4a7gKWlz8BJTBT7/g6FZzWEfab/K0
	7fftwAp5QAxfAOa+ucGxne+5kgorVVjvl/k6q9Irz3i4cyFzLzNgzrWf4SFqcwdC
	A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acwcg80g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEG42T018660;
	Wed, 12 Nov 2025 16:04:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaavqch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:12 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ACFxw3g004655;
	Wed, 12 Nov 2025 16:04:11 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-173-131.vpn.oracle.com [10.154.173.131])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vaavnq6-14;
	Wed, 12 Nov 2025 16:04:11 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v3 13/28] objtool: Identify the different types of alternatives
Date: Wed, 12 Nov 2025 17:03:00 +0100
Message-ID: <20251112160315.2207947-14-alexandre.chartre@oracle.com>
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
X-Proofpoint-GUID: mBB2jVSSo0h8ZQEm8Ag8HC6rXiqSBOgJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyOSBTYWx0ZWRfX7waKF1dIa6Fb
 BeCLWymoYirQ74ANKKRPsBWd6+S61OmXyh1RtsWKe0w2pN1suTxLoN+tKvPTigGvWRRmGX7Gslx
 oMDSy2+mDBedt2RhVi46zxBsTcvaREAk3332gzi7gceICvImWisQVMZhPL/XH9du9+4UrE9PkJ/
 bdHeb+prfmTs8DjPFg4Mdri1P8J0inpGjiijiYiDjxv0L3bJj9L5WhTc+40GGCEAShaBP0LNAP2
 USvWSWxHSXpy5WPGZnz9I8DbfMpN8HmetBu9s5sJtLZizbdzXLPu6/Af0QzoccFweA2vMD504em
 cdGMxyUNKgAIhWxIayew9CQyFHUSUaU5/+IN/SdtGhmoPF2ZI8Hl3+61Edk+qvT4CxoDuWsBEi/
 OoJVRkSrbGqZu48ZklMrUqVA+ra4Pw==
X-Proofpoint-ORIG-GUID: mBB2jVSSo0h8ZQEm8Ag8HC6rXiqSBOgJ
X-Authority-Analysis: v=2.4 cv=LewxKzfi c=1 sm=1 tr=0 ts=6914affc b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=RDt3PK5YzZswrGw8on0A:9

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


