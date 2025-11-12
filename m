Return-Path: <linux-kernel+bounces-897688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2043FC53651
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37163568CA1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9113B34B1AF;
	Wed, 12 Nov 2025 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jq4hYyWO"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD89834AB03
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963470; cv=none; b=AecphASkZWwLCPVcwqGFCa3z+nDTfkQwyrTSmVjzCPfx3DHDIy8CLcNaRHWeNUZcLOR8khK9HVBre7sAHxjtGs6ICknp41Rm0Din9c1XmZMbFO/U9mowF/QZSRdHpALElyYhbwa4JnNMI9DUhjBnanUvZ98BESqx9zbt5AGOZE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963470; c=relaxed/simple;
	bh=ku/+OqRRYJmOqfxHIS/dfuY3pj18QT7pndOO7gvVbdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FwUlZ2IUGyTEubM9WmE4LJT+WxWNqz/kbPctuxvPrIrkXgEQQwd1WnUj/MfelUsk5DWv92AzQOhR2K22tOTVlJV4wPJwcqv8ldcSu5i3TKSNWnH+tj6hYdXy/8EFDkm6ervJ+/VNYxLcFt7BYA3pH3XCe2dQxxLD7+2LeoK8hPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jq4hYyWO; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACFjbol007206;
	Wed, 12 Nov 2025 16:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=D0sFP
	+ZGOAx8ChM2bzSKXGKXtPMGODiE8h83xtluZA8=; b=Jq4hYyWOC2Ncv7v4y3fBj
	IyAV3eZNIABLEa8TXcxBQPj6nSvA3MiXJEAVryuYi0pW1uxuMl/lwZocwL19MSwb
	Op2unFp6dO+6yTq2qbdEvxHrKGuxxcTebzDmdjzaqtn1UOK96xQaE9BKx8Nii+9u
	KeK8DiLb7aOnpmuQHFU+iB/FfDntrqakpnH9xXAohh9KFF2RT0Tx0aqQb4lsbNNi
	9+/+Te8RJR/fXYFOt7+nF/3cUcUc69cimXrgr+yXlpMai5g86G05diupTcMqEtnj
	zALvxqo0pRowQ3CG3H66bYMIkWt7s+vlmgoU07iwvun7rnrnVKogmzB2BkmZ+cAv
	Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acw5f01yp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEG4YQ018650;
	Wed, 12 Nov 2025 16:04:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaavqmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:20 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ACFxw3q004655;
	Wed, 12 Nov 2025 16:04:20 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-173-131.vpn.oracle.com [10.154.173.131])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vaavnq6-19;
	Wed, 12 Nov 2025 16:04:20 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v3 18/28] objtool: Disassemble group alternatives
Date: Wed, 12 Nov 2025 17:03:05 +0100
Message-ID: <20251112160315.2207947-19-alexandre.chartre@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyNiBTYWx0ZWRfX06LY6MoYNS0b
 Vouw/KXvLNivUhQG+frbManoO/iIBPyLN4s9QPkgY985KlSQD8MNQwzfTGSWvEOhK70wOHOHNbr
 8tgeo8kTELwIdTuWZLo/gj7QZqXnz+mE9IgSHmT5qUWW8T9rFDRFW89eI/YJrwFDnfWIQu8w6F3
 O3Wz2iQ0CitbhV92YkdjOa03DnCPvgDAb57CjCVCwRwRQiGBhGCyzTnTUPZWCr+7oDE7wu7fqY+
 Fc2QbmLXDOSmP+biD2h1UNbrVqrlydIMnQ+GPHy2hQ3Wjr/ocJp308zMlakTj0YvKEg81rl1fBd
 5eHENJXb2LzMZre6Dd/vcuKjUs7YpSSYK+cxq3BlCqYY22R63eeKMvmYLhUUe9QrWlj3ZFovC6g
 Y/KtD5NqFfD3RWDhRp+TQ83W6hwXzw==
X-Proofpoint-GUID: cgrS_5Q4hNkwy63NNwALIfkifoBPQXXD
X-Proofpoint-ORIG-GUID: cgrS_5Q4hNkwy63NNwALIfkifoBPQXXD
X-Authority-Analysis: v=2.4 cv=Ju38bc4C c=1 sm=1 tr=0 ts=6914b006 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=BZlt5mrdIDfIrSVFCwQA:9

When using the --disas option, disassemble all group alternatives.
Jump tables and exception tables (which are handled as alternatives)
are not disassembled at the moment.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/disas.c | 146 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 138 insertions(+), 8 deletions(-)

diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index 43dc51f614f1c..28c77762b1bd5 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -47,8 +47,14 @@ struct disas_alt {
 	struct alternative *alt;		/* alternative or NULL if default code */
 	char *name;				/* name for this alternative */
 	int width;				/* formatting width */
+	char *insn[DISAS_ALT_INSN_MAX];		/* alternative instructions */
 };
 
+#define DALT_DEFAULT(dalt)	(!(dalt)->alt)
+#define DALT_INSN(dalt)		(DALT_DEFAULT(dalt) ? (dalt)->orig_insn : (dalt)->alt->insn)
+#define DALT_GROUP(dalt)	(DALT_INSN(dalt)->alt_group)
+#define DALT_ALTID(dalt)	((dalt)->orig_insn->offset)
+
 /*
  * Wrapper around asprintf() to allocate and format a string.
  * Return the allocated string or NULL on error.
@@ -470,6 +476,21 @@ size_t disas_insn(struct disas_context *dctx, struct instruction *insn)
 	return disasm(insn->offset, &dctx->info);
 }
 
+static struct instruction *next_insn_same_alt(struct objtool_file *file,
+					      struct alt_group *alt_grp,
+					      struct instruction *insn)
+{
+	if (alt_grp->last_insn == insn || alt_grp->nop == insn)
+		return NULL;
+
+	return next_insn_same_sec(file, insn);
+}
+
+#define alt_for_each_insn(file, alt_grp, insn)			\
+	for (insn = alt_grp->first_insn; 			\
+	     insn;						\
+	     insn = next_insn_same_alt(file, alt_grp, insn))
+
 /*
  * Initialize an alternative. The default alternative should be initialized
  * with alt=NULL.
@@ -490,6 +511,83 @@ static int disas_alt_init(struct disas_alt *dalt,
 	return 0;
 }
 
+static int disas_alt_add_insn(struct disas_alt *dalt, int index, char *insn_str)
+{
+	int len;
+
+	if (index >= DISAS_ALT_INSN_MAX) {
+		WARN("Alternative %lx.%s has more instructions than supported",
+		     DALT_ALTID(dalt), dalt->name);
+		return -1;
+	}
+
+	len = strlen(insn_str);
+	dalt->insn[index] = insn_str;
+	if (len > dalt->width)
+		dalt->width = len;
+
+	return 0;
+}
+
+/*
+ * Disassemble an alternative and store instructions in the disas_alt
+ * structure. Return the number of instructions in the alternative.
+ */
+static int disas_alt_group(struct disas_context *dctx, struct disas_alt *dalt)
+{
+	struct objtool_file *file;
+	struct instruction *insn;
+	char *str;
+	int count;
+	int err;
+
+	file = dctx->file;
+	count = 0;
+
+	alt_for_each_insn(file, DALT_GROUP(dalt), insn) {
+
+		disas_insn(dctx, insn);
+		str = strdup(disas_result(dctx));
+		if (!str)
+			return -1;
+
+		err = disas_alt_add_insn(dalt, count, str);
+		if (err)
+			break;
+		count++;
+	}
+
+	return count;
+}
+
+/*
+ * Disassemble the default alternative.
+ */
+static int disas_alt_default(struct disas_context *dctx, struct disas_alt *dalt)
+{
+	char *str;
+	int err;
+
+	if (DALT_GROUP(dalt))
+		return disas_alt_group(dctx, dalt);
+
+	/*
+	 * Default alternative with no alt_group: this is the default
+	 * code associated with either a jump table or an exception
+	 * table and no other instruction alternatives. In that case
+	 * the default alternative is made of a single instruction.
+	 */
+	disas_insn(dctx, dalt->orig_insn);
+	str = strdup(disas_result(dctx));
+	if (!str)
+		return -1;
+	err = disas_alt_add_insn(dalt, 0, str);
+	if (err)
+		return -1;
+
+	return 1;
+}
+
 /*
  * Disassemble an alternative.
  *
@@ -502,22 +600,30 @@ static void *disas_alt(struct disas_context *dctx,
 {
 	struct disas_alt alts[DISAS_ALT_MAX] = { 0 };
 	struct alternative *alt;
+	struct disas_alt *dalt;
+	int insn_count;
 	int alt_count;
 	int alt_id;
-	int i;
+	char *str;
+	int count;
+	int i, j;
 	int err;
 
 	alt_id = orig_insn->offset;
 
 	/*
-	 * Initialize the default alternative.
+	 * Initialize and disassemble the default alternative.
 	 */
 	err = disas_alt_init(&alts[0], orig_insn, NULL, 0);
 	if (err)
 		goto error;
 
+	insn_count = disas_alt_default(dctx, &alts[0]);
+	if (insn_count < 0)
+		goto error;
+
 	/*
-	 * Initialize all other alternatives.
+	 * Initialize and disassemble all other alternatives.
 	 */
 	i = 1;
 	for (alt = orig_insn->alts; alt; alt = alt->next) {
@@ -526,10 +632,25 @@ static void *disas_alt(struct disas_context *dctx,
 			     orig_insn->offset);
 			break;
 		}
-		err = disas_alt_init(&alts[i], orig_insn, alt, i);
+		dalt = &alts[i];
+		err = disas_alt_init(dalt, orig_insn, alt, i);
 		if (err)
 			goto error;
 
+		/*
+		 * Only group alternatives are supported at the moment.
+		 */
+		switch (dalt->alt->type) {
+		case ALT_TYPE_INSTRUCTIONS:
+			count = disas_alt_group(dctx, dalt);
+			break;
+		default:
+			count = 0;
+		}
+		if (count < 0)
+			goto error;
+
+		insn_count = count > insn_count ? count : insn_count;
 		i++;
 	}
 	alt_count = i;
@@ -545,11 +666,20 @@ static void *disas_alt(struct disas_context *dctx,
 	printf("\n");
 
 	/*
-	 * Currently we are not disassembling any alternative but just
-	 * printing alternative names. Return NULL to have disas_func()
-	 * resume the disassembly with the default alternative.
+	 * Print instructions for each alternative.
 	 */
-	return NULL;
+	for (j = 0; j < insn_count; j++) {
+		disas_print_info(stdout, NULL, -2, NULL);
+		for (i = 0; i < alt_count; i++) {
+			dalt = &alts[i];
+			str = dalt->insn[j];
+			printf("| %-*s ", dalt->width, str ?: "");
+			free(str);
+		}
+		printf("\n");
+	}
+
+	return orig_insn->alt_group ? orig_insn->alt_group->last_insn : orig_insn;
 
 error:
 	WARN("Failed to disassemble alternative %x", alt_id);
-- 
2.43.5


