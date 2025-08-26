Return-Path: <linux-kernel+bounces-786644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E3DB35F84
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9644D3A0812
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB610537F8;
	Tue, 26 Aug 2025 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s+TvbI2s"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D921C6BE
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 12:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212589; cv=none; b=lXLrfJu7+tiejhPkHtjPozROrCFb2x+S0lAj/EYG92VSTkoJkwM3pHfYSp1JEWfystVtk+sdWTWal+IsA9UOsIDLExah5Q9qXfs0+TskboELlIrLjiFaDnBd0mWMIBul6QP6LSx07iWd6G0Z0lulMqrPZDehsmGpIwrEu9KKBgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212589; c=relaxed/simple;
	bh=2vsn1IkG5bGCsNn0pmRm3qp7YPjKg9Yx2DCAqGTctp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SU41Jwp1mRaMf0fgvM8BnB6yd8xvsEl43WtOzEogTHqTGoYMQgHedta1ffrFiVBAE3r8Rrc/9br+yEm7asvtI3kOfCRgQ0Vl9zhhiz0leo/Zd4jk/x8bHAe1O4x/sWY711ntfr751u0hjCw5Qf1GOndTyvbgsMIlaow6w6Gjz/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s+TvbI2s; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q8ksQW008022;
	Tue, 26 Aug 2025 12:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=DAGGijW6cNEN/XBrOA32YvUP9CyWMG6BMXPWcFXNn
	2I=; b=s+TvbI2sAU9sNskdBsITQy/SnQsX2PDdG/v+wg+7zC/ckqvadWvTTY65Z
	+YgTcK3EriSOM/psnUfBUs07SRzjhbUJeIry8nQzB2N2qDf87bwcwa7Eka4iGMiL
	usqiBpmKHqkKltaG8rXHm5YmAt5vqh1fzkkotOhIPCYCmaCFlx2YFzy9UxhQwM16
	Xm0qfL+mmKxRD7VHcmJ0MLFCVktTKHhT5I6pxBew/T8vrpve8AtbQCzlCfItZNH7
	KRF+I1Eo4N3rETA0mvnMGS2mM5gkSdv6ucc2xON9LfHmCDtdgpfWGWGGQ/DuOCPw
	vkJx4VDn/kX3X77UbIpZc1a/vUnCA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q42hxj2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 12:49:33 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57QCkfdv032135;
	Tue, 26 Aug 2025 12:49:33 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q42hxj2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 12:49:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q8pp0a002524;
	Tue, 26 Aug 2025 12:49:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qt6magwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 12:49:32 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57QCnSO453805510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 12:49:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FCFB20043;
	Tue, 26 Aug 2025 12:49:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFAB120040;
	Tue, 26 Aug 2025 12:49:25 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.in.ibm.com (unknown [9.109.215.183])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 Aug 2025 12:49:25 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Wei Yang <richard.weiyang@gmail.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Donet Tom <donettom@linux.ibm.com>
Subject: [PATCH 1/2] mm/ksm: Reset KSM counters in mm_struct during fork
Date: Tue, 26 Aug 2025 18:19:21 +0530
Message-ID: <2e662107e01417bf9af23bc7f52863cd538419be.1756211338.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxMCBTYWx0ZWRfXydYkEKYVYR12
 9GYbng7zDTwaFmkIyJ+1SHjYxLupFkAQYTBOEytf0HF6SthYXCjLx1K7UOCkvFV+DQoaY4OgRdU
 EuADlD7T5u+W2Ng4cjr5/9qeLp23k/obauCT2cqGeAtSEhrdXGWmd5Y12LXPlhNUgC8M123f5Rw
 J/kdDw3n13wzPJnEG3gedGUe6JnAVVPyEus94r6R8tIgC2na9VGv3HS4Z3pzgjAWAJ/INvKyMZr
 /H7J1NmTn1uZXdM5HqYKA1IWIhZdZk+M2KjdhUf8lS3sKHiGwYdEAwJtZoFkkTQTdSCqfCutp4C
 ctEV9OIs5W6bUX/7o0t1eg9iPOmXB+gsjP9aSOdKbJ7T+ZZw+FkCHYXs5uYgjtCtWPmZzxR33m9
 vYPo1Qrn
X-Proofpoint-ORIG-GUID: X1kt7dpWXr41pu_7Z6YhmU7QhZ9kIS_o
X-Proofpoint-GUID: Dz170ztLRn2G-QQbmUmmLpUe42C34bRS
X-Authority-Analysis: v=2.4 cv=evffzppX c=1 sm=1 tr=0 ts=68adad5d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=bffXwCTgIVeg__Yz0z8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0
 impostorscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230010

Currently, the KSM-related counters in `mm_struct` such as
`ksm_merging_pages`, `ksm_rmap_items`, and `ksm_zero_pages` are
inherited by the child process during fork. This results in
incorrect accounting, since the child has not performed any
KSM page merging.

To fix this, reset these counters to 0 in the newly created
`mm_struct` during fork. This ensures that KSM statistics
remain accurate and only reflect the activity of each process.

Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 include/linux/ksm.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 22e67ca7cba3..61b8892c632b 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -56,8 +56,12 @@ static inline long mm_ksm_zero_pages(struct mm_struct *mm)
 static inline void ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
 {
 	/* Adding mm to ksm is best effort on fork. */
-	if (mm_flags_test(MMF_VM_MERGEABLE, oldmm))
+	if (mm_flags_test(MMF_VM_MERGEABLE, oldmm)) {
+		mm->ksm_merging_pages = 0;
+		mm->ksm_rmap_items = 0;
+		atomic_long_set(&mm->ksm_zero_pages, 0);
 		__ksm_enter(mm);
+	}
 }
 
 static inline int ksm_execve(struct mm_struct *mm)
-- 
2.51.0


