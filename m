Return-Path: <linux-kernel+bounces-744645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4A8B10F7E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 134DA3AA0CB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28B42EAD06;
	Thu, 24 Jul 2025 16:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ITXEcKcU"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE182EA493
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753373806; cv=none; b=iMN3ZV82XCOoy8mavlzWNAyLmRMtRsAutid0JcO/KYKGCENeqPCYP2zjDZahYUd2LgJAJJK95kdO0g9hkIMYmlB0xODCtM/U6Vl9RgQz/ViMAazRBNEjTfskdSyfULrcr3uSYCTnuBhSqVUAp1JB37qGTOoPSctil4HB3LPR5JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753373806; c=relaxed/simple;
	bh=bOkwpVY/Gsv62eCQGe3o5VZGmAnmYb8l9xLj4n61gLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOW2p17stOKqrl6GKyQ4oqr6sOE1lv6GUxYbsRH/l0HfG26Sx8qHFbrfWqKt7PuNkZKR3d9Z5VIQZGuGGY1wWBL09E7wlPahUiQeihOBtPLQX7LdXz6E1aA7yISXgQ5uRd5F4XNHETJLIi4LNZvOLRD5ymeIHXddm1f6uqAvXcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ITXEcKcU; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ODRRdk002850;
	Thu, 24 Jul 2025 16:16:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=iUmhe
	cKkWU+OIR3wXYc7zBqQzdcel+64iEjdQOLWYtE=; b=ITXEcKcUPBcqkFmN3Ci9U
	D2LeprRN9gKVIMBjxWy7yS92aTtvwFBniwSuTu/XOIARwXiIvVgD5DgZfBgEXkaF
	5XjqWj7OidZSojKPsaTFvR+2yQG8XLXWCWtKYXjAoCN34Ek4RleQ7fCMehFNDx8G
	z42a7MQpl0I+sCnbqKGLx4YhI4aE1QMP+M7NdrOgTxvsolckgufQgYiYXh0tZCjo
	zpHr+P10ux7aR1pM11lUfa9tPd6s6RBZsjAn9G6K7SggHqdCFTWoMwSJPXRYa1r+
	xIADoy13zjIuE54hOLApY2Rg2dFKDhKKBI3tT7dYvSrY52TXi9W2hB12/5tc1Lc3
	Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 482cwhveb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 16:16:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56OEu250014553;
	Thu, 24 Jul 2025 16:16:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tjcfrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 24 Jul 2025 16:16:30 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56OGGRNS034466;
	Thu, 24 Jul 2025 16:16:30 GMT
Received: from psang-work.osdevelopmeniad.oraclevcn.com (psang-work.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.35])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tjcfne-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 24 Jul 2025 16:16:30 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        tglx@linutronix.de, bigeasy@linutronix.de, kprateek.nayak@amd.com,
        vineethr@linux.ibm.com, prakash.sangappa@oracle.com
Subject: [PATCH V7 06/11] Add API to query supported rseq cs flags
Date: Thu, 24 Jul 2025 16:16:20 +0000
Message-ID: <20250724161625.2360309-7-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250724161625.2360309-1-prakash.sangappa@oracle.com>
References: <20250724161625.2360309-1-prakash.sangappa@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507240123
X-Proofpoint-GUID: yh9zTwq3BvkqmRkFCyaZ5oPXayHU44RB
X-Proofpoint-ORIG-GUID: yh9zTwq3BvkqmRkFCyaZ5oPXayHU44RB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDEyMyBTYWx0ZWRfX/AGEUbNoFjD3
 SP0l2aEWqPSzDGkWn4CMnLD1aLv8MWZwTHh4Q8IUpftusBWmzjIY/yDCDDB0s291wkeX9gvT3f3
 6e2UrvqgRn7Fwliqtv7XW9TYde1guLDndQvbdwuC5lxN/PKgfqOZw+x4bK4pkAVFfvW9UMxGuci
 UMfJ8RDo5guoIcf2AML7o0PPDbgTpKLfnQHvdJ/+sB0opvs9cThlK3kBwcCSqYTvCw2VqMfBwET
 qRk7dPWykOqBveB4UBy5m60xqZfgrdimiGWDL7902MQHGJGAAZE0M+e+3nrBH4xbg72/Wocvjz1
 k/aNqbmN9dkSbtltg6jlNY89muV+qZZcUzFEe+ktwCv+II9inrCCvTTPxGUIX04QkFdsFcICokE
 z1E2ARZL7gIeQV9Vwv2kOCXoLAJ7W2MCDkOPZ1VEPZpeRo8JKMgm73FcRyXiaDfRzCxDbNYK
X-Authority-Analysis: v=2.4 cv=IPoCChvG c=1 sm=1 tr=0 ts=68825c5f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=XZOol5B-I9QkcwWuj0oA:9 cc=ntf
 awl=host:12061

For the API, add a new flag to sys_rseq 'flags' argument called
RSEQ_FLAG_QUERY_CS_FLAGS.

When this flag is passed it returns a bit mask of all the supported
rseq cs flags in the user provided rseq struct's 'flags' member.

Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
---
 include/uapi/linux/rseq.h |  1 +
 kernel/rseq.c             | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index 015534f064af..44baea9dd10a 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -20,6 +20,7 @@ enum rseq_cpu_id_state {
 
 enum rseq_flags {
 	RSEQ_FLAG_UNREGISTER = (1 << 0),
+	RSEQ_FLAG_QUERY_CS_FLAGS = (1 << 1),
 };
 
 enum rseq_cs_flags_bit {
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 6ca3ca959b66..7f4daeba6d0d 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -550,6 +550,21 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		return 0;
 	}
 
+	/*
+	 * Return supported rseq_cs flags.
+	 */
+	if (flags & RSEQ_FLAG_QUERY_CS_FLAGS) {
+		u32 rseq_csflags = RSEQ_CS_FLAG_DELAY_RESCHED |
+				   RSEQ_CS_FLAG_RESCHEDULED;
+		if (!IS_ENABLED(CONFIG_RSEQ_RESCHED_DELAY))
+			return -EINVAL;
+		if (!rseq)
+			return -EINVAL;
+		if (copy_to_user(&rseq->flags, &rseq_csflags, sizeof(u32)))
+			return -EFAULT;
+		return 0;
+	}
+
 	if (unlikely(flags))
 		return -EINVAL;
 
-- 
2.43.5


