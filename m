Return-Path: <linux-kernel+bounces-899899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10839C593A4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3EC2650435A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD705377E97;
	Thu, 13 Nov 2025 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aWSTcKoy"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587EB377E82
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052611; cv=none; b=KpVVdooK481TpGeMWiXUUugULst+9OPAqZJdUzTSWBJpNAA+lF/Y46cPePCDxn2sZ2tcwue2aEMaX/28wuQIU1C3K5rnaEzhbyONnv3LmHyGaYKM0mwQEAWrPjEN3UkevMnaoS5lyQYuDDMexsMnvr2F8ePoyGB2tCbNgDingso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052611; c=relaxed/simple;
	bh=h8dOoKAF+f/m/Sm7jIWqLl5pUPnTSMT6so3kKeyyxKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2XszoCZRs3PVIYeUMwGRArU+yugRtYD7v9L+zp0dmtOQZBaGEsJF+Nwkq+k8mCz8emZfdoUPxwpk4lLL3U1gXmkDVzWqvkGzLaLITj0ljOjor/FQC6CkD703XH2aw9eivy2sNyupJF/0hfHL+ssitRsTQhFKyRdQQXikAP7CZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aWSTcKoy; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADE9v9N028022;
	Thu, 13 Nov 2025 16:50:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=m4Jyb
	hwVGsijDuSe4c/+hAWgB433wQsPQQhvIoTjetw=; b=aWSTcKoyagLvpK3BE2TwY
	ILmCJ7dx1A+DxotUPQqfSNWOoL9KrcejVp474xbfa39Xj2rb7nSOwdmYV0XYhuuf
	AGUxgzoJ2nNxyFOnXWgQX5Ld8JmlD6N7GAucDpFWZqsYD2AkeZwZvEGrLtjhc0TV
	SIDCV79DDPXl/LmaBTHz0AfSlSFJRg2bekL9RPWtyua8giMTespUZ3cF+3yZEHKc
	AZTnZH/rxUGZ0YAYCI+Fu+ekD0Z49dB86RQCF+vSAl5HUpDKe0TiHJ5Fw+FRQF56
	Ss2q6X2WtgP1rRPm+ECVsNuIGRGMLWm3EpG0OkpnjNsF9yn2tHAJtJB+xyFWLuCe
	w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acyjsa7v3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:50:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADG6diH039063;
	Thu, 13 Nov 2025 16:50:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacc434-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:50:00 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ADGnKAV008288;
	Thu, 13 Nov 2025 16:49:59 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-172-143.vpn.oracle.com [10.154.172.143])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vacc38f-24;
	Thu, 13 Nov 2025 16:49:59 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v4 23/28] objtool: Provide access to feature and flags of group alternatives
Date: Thu, 13 Nov 2025 17:49:12 +0100
Message-ID: <20251113164917.2563486-24-alexandre.chartre@oracle.com>
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
X-Proofpoint-GUID: MwKkRLfGAkfN1_kHCBicZIWwvL6vWZ4j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0OSBTYWx0ZWRfX0XP3Tqr1mbfD
 Smwj1F+EBMgDAZYzVo1Bj3GFpENrMIiFv0mXN6LN0F743CGAIxJdwr0NG/S/2vpOMWatUpJrfIe
 tqUQ3M0fgug4omyDj7tPl3tzbKhFvHJvi5KadYB7x/atBdNNZoCiaUruelG0aReCG6rMLOjimW9
 qCmAw3UfRKod4J3ylozQ1R3rr83CZ/C7aqZWh5IkskDsMKyEt5sk3L6Fc5bfl9K7sFNW5I1NUOe
 vq5SwK6oxUem/LL0Ona8HJqwTG2BGsBTHvhRXqsF3oxQXbYOwJAIIVO8wA2B7hyByqUJl4J7tTv
 eeMMrwuvvJYDOnnhq0wmFBLYSGkENMgcGu6GWLYgi56YLuuqz99VbsPz9XHW88kW7BM5azcQlNm
 98Krjsz0f3BUEo7KodQCMPRu/WVWcw==
X-Proofpoint-ORIG-GUID: MwKkRLfGAkfN1_kHCBicZIWwvL6vWZ4j
X-Authority-Analysis: v=2.4 cv=HLzO14tv c=1 sm=1 tr=0 ts=69160c39 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=OMdgKRDbd2JaGKt5H5wA:9

Each alternative of a group alternative depends on a specific
feature and flags. Provide access to the feature/flags for each
alternative as an attribute (feature) in struct alt_group.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/check.c                   | 2 ++
 tools/objtool/include/objtool/check.h   | 1 +
 tools/objtool/include/objtool/special.h | 2 +-
 tools/objtool/special.c                 | 2 ++
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 25c1c7185d4f6..817ac70fed9fa 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1738,6 +1738,7 @@ static int handle_group_alt(struct objtool_file *file,
 		orig_alt_group->last_insn = last_orig_insn;
 		orig_alt_group->nop = NULL;
 		orig_alt_group->ignore = orig_insn->ignore_alts;
+		orig_alt_group->feature = 0;
 	} else {
 		if (orig_alt_group->last_insn->offset + orig_alt_group->last_insn->len -
 		    orig_alt_group->first_insn->offset != special_alt->orig_len) {
@@ -1841,6 +1842,7 @@ static int handle_group_alt(struct objtool_file *file,
 	new_alt_group->nop = nop;
 	new_alt_group->ignore = (*new_insn)->ignore_alts;
 	new_alt_group->cfi = orig_alt_group->cfi;
+	new_alt_group->feature = special_alt->feature;
 	return 0;
 }
 
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index 73310c56e91b6..c54dd0aae1f60 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -36,6 +36,7 @@ struct alt_group {
 	struct cfi_state **cfi;
 
 	bool ignore;
+	unsigned int feature;
 };
 
 enum alternative_type {
diff --git a/tools/objtool/include/objtool/special.h b/tools/objtool/include/objtool/special.h
index 72d09c0adf1a1..b22410745e4a1 100644
--- a/tools/objtool/include/objtool/special.h
+++ b/tools/objtool/include/objtool/special.h
@@ -25,7 +25,7 @@ struct special_alt {
 	struct section *new_sec;
 	unsigned long new_off;
 
-	unsigned int orig_len, new_len; /* group only */
+	unsigned int orig_len, new_len, feature; /* group only */
 };
 
 int special_get_alts(struct elf *elf, struct list_head *alts);
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index c80fed8a840ee..93fb371b05207 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -82,6 +82,8 @@ static int get_alt_entry(struct elf *elf, const struct special_entry *entry,
 						   entry->orig_len);
 		alt->new_len = *(unsigned char *)(sec->data->d_buf + offset +
 						  entry->new_len);
+		alt->feature = *(unsigned int *)(sec->data->d_buf + offset +
+						 entry->feature);
 	}
 
 	orig_reloc = find_reloc_by_dest(elf, sec, offset + entry->orig);
-- 
2.43.5


