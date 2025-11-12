Return-Path: <linux-kernel+bounces-897693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9DEC535BB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 286FC350708
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A7E34D390;
	Wed, 12 Nov 2025 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G2cUgzcV"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C0A34CFCF
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963479; cv=none; b=Y/yh7sSEZYMjtxreqz1p0IImxgJMQvuRJnDTwLUYmbg48aFfxg4RO77EowxhZVDyG87goixG4umP5jYBMkU2TUvDKyTNOFVJOA7dpO/1drqyUkieiuJNuojr9slZeuprl0ZLkV1OkuJOgRtpcSeF/6ufzNfQbhcQvu7aEBhPtHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963479; c=relaxed/simple;
	bh=8iH5b/8bHsd6ulPC09Rvbti0ZLSraHYLpRBYKqf4eyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AcLIav+2wdN/4pXLE8FIdMqEjsRPzs8AkqiCvJhHY2QXfrE8S6eo8m3bz7pkY55bQFWSVYBvyUklUMkEbvYvxzelHf2TS40MA6oRO9agqePAUA6eE+wAggKx98LvJFJ95LJw7/0x/kZC72VDq4TLEfOforBSofgWEfn2y7cwtzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G2cUgzcV; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACG0RR5008396;
	Wed, 12 Nov 2025 16:04:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=sTxhO
	yc7Y9UCmdDybOr6o/rtgJgzfv5J44tqBQ//aGk=; b=G2cUgzcV3PduywxKdzrp4
	JfAW5Q56bNRDVIXHpi4haoxaJHOYB2R+700FcoXWa6IuYsm8v6LT8Qtwjmj80wBQ
	8TcjRsIkMxdVYDEw0W6BfL+lURS6qLs7aY1Ucm5ZSd8PukyV6FykFeIKCJzy1yk9
	rKv3WJE1K8f9CYbmaBUS6T0w/5tMqqtWxpSKLcr1tfaf9IkrK40xB94g0SKyQvlS
	RVLsejua7IRJVHJHd5yVAPJA9qn7THN+XuJ09KC/UNZ89Z9LKKQFwqHlx65Ofk/E
	Qru+k0D2HXUNMklatd9ne0noUmN2kaUSTObJVpXVaxdoO1lzg9dOy6qjcLxjM+3w
	A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acwcg80jc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEG3LB018598;
	Wed, 12 Nov 2025 16:04:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaavqq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:29 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ACFxw42004655;
	Wed, 12 Nov 2025 16:04:29 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-173-131.vpn.oracle.com [10.154.173.131])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vaavnq6-24;
	Wed, 12 Nov 2025 16:04:28 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v3 23/28] objtool: Provide access to feature and flags of group alternatives
Date: Wed, 12 Nov 2025 17:03:10 +0100
Message-ID: <20251112160315.2207947-24-alexandre.chartre@oracle.com>
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
X-Proofpoint-GUID: inKBDMY1iE1e0TydUAehKb37EsgdCJTV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyOSBTYWx0ZWRfX7E0WnEgmLW8s
 0UCA68NOhJz+YLwTNueE3JiloGqPiMb7hzkmkiUuqPnElooDWtPiyyyhVWHmhT97e1kl9m5i9Pd
 sxWewSiv0xURSs5JWpZ83MzHQsnDdf2VbIkklH21ZAlvDmt//f6gt+l1LQk+hJFt0HyOXxlg3Ve
 ZvponVMGLVUpOnpc4NST1gT2ju9sKF1BoY0Hq25yvAd3lCgHmsPk0YnMcQu7Mo2Ado6G0TniLXh
 jxEKr2W2FFa+ATArYlW5uDGrAB3WGhP3ioZvLFdRVHtu36POiPkVSDU9ZlAETjbakDTUvlD8Wyv
 8IBPu/pHRm5wxFrIA4NwN3ZLP+WKDuiJ2jJ0qSF2N183X5hvEFqKZ3lKGJSp4pR37Z3e9dbGB9n
 WplQZ0wiQz+X3zp+BvVu2a4T+LdpPg==
X-Proofpoint-ORIG-GUID: inKBDMY1iE1e0TydUAehKb37EsgdCJTV
X-Authority-Analysis: v=2.4 cv=LewxKzfi c=1 sm=1 tr=0 ts=6914b00e b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=OMdgKRDbd2JaGKt5H5wA:9 a=OtpQxBYiIDA4NW_S:21

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
index f4e419c895a74..89b35e8a068d0 100644
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


