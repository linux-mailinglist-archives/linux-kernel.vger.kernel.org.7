Return-Path: <linux-kernel+bounces-829507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB3CB973C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D2A07B6865
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FBD27B325;
	Tue, 23 Sep 2025 18:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J1WktLVE"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6037178F39
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 18:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758653250; cv=none; b=uZeY5Lh5hEkEdJkzU1mDUnXyMHLqczOkYehvVL8uVOJC/sudSYS7gg5YOXa/MoT5WrE2pzsMaRhUNnfZ3h0GdAW4QuLkCnLC5GeNiBDs2KulYNeb5mUKTC6E8C54UuGDKK+0UCw0mrWsiXwUHUWoSz+JI9e8sg91N+dLGSsUIyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758653250; c=relaxed/simple;
	bh=xxbaPCsKLk+OF/ZV+WHXJBx+Wvi6MJ/TUTnW0TZnxkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lgLJ09f3IX2AyHd0IrYVtXC3d+/PvzdC8LL1u2QQ3iii8UnHTPttaQWNqhbX1wHWdq7EDeytvF96uaa4B0CAhpE5Y3bdXaA4xqcGImurlb8ruaLs9MfCZmNdhAv9HNX8IjwasD+QYwR/jvv8tNd3nYNVs6NnOAQ+aML+OQpFrUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J1WktLVE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58NEE2aF013794;
	Tue, 23 Sep 2025 18:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=x+zutkjkcpITR/cVlfWCAq8Vz9RcZ8fZjfSm0216P
	bc=; b=J1WktLVEVK2gcBRPrfQYgAES326ihgJ4g3nwsInNPGVAoqC4Kk3VzM5Gn
	RY9ASX3Fp3jBTnUaIhO0XFjWD0U/Aan2BM2TEu+sZS511jo591dIMNCPDkxJLUAG
	U8jAaFKYFrYkSObLJEWT0klYNvF1FaprzrNZMIT4+NQfC6904nL+Gx+lBDBu4YB8
	5X47JCw8gN0q1iF9Zl4OHfubZtv2Er9Wlc4w/yiMuPQJqtMJymUkuBPhsLAoTm3j
	Gkmae6NV8eGnKqsxMDz2+gt5YChM8IAqGpna5DfgkCDIx/7fs8D1AqESA6bbwGcB
	a4n0xIITTlQ7/XUBG/InFEbklU4iw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499jpkapf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 18:47:20 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58NIlJCj023409;
	Tue, 23 Sep 2025 18:47:19 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499jpkapf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 18:47:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58NGigZv020197;
	Tue, 23 Sep 2025 18:47:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49a83k4vr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 18:47:19 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58NIlF5d33948080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Sep 2025 18:47:15 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 147B120043;
	Tue, 23 Sep 2025 18:47:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5038620040;
	Tue, 23 Sep 2025 18:47:12 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.ibm.com.com (unknown [9.39.28.7])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Sep 2025 18:47:12 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Wei Yang <richard.weiyang@gmail.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
        Donet Tom <donettom@linux.ibm.com>
Subject: [PATCH v3 0/2] mm/ksm: Fix incorrect accounting of KSM counters during fork.
Date: Wed, 24 Sep 2025 00:16:58 +0530
Message-ID: <cover.1758648700.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L50dQ/T8 c=1 sm=1 tr=0 ts=68d2eb38 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=sIImd-A5PneLSRPQBKwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMCBTYWx0ZWRfX1Dqzv8uZYpWZ
 uZ5LkamgnttkKj3jHM4LSCw43b1SR3rwmKjkpMI/zhgEiFR+ig5KlHKbGxtHLCMacpQ4yRXxizJ
 m7wkBytJpyiaksJ3mKWGsz1rmtSRpgeYyKswJHeL68u5hqmY+zt1KmWuvcEhtekyj6nhsF5Eo69
 HjSEHzRnrToJL/3+ckuXFr2j9rjkwb2ne08hynlXHiDMmQ5TH9CcpqM08P0EGCFFmg327YT0Zj2
 xXuytrDUYoMOkR0ukuv70C10/s1dRQRAJFbmMvVhvuMn3Yy38zYRACQD8MLmmjmEBz1tkEtKntw
 Lxllqnr8kuLc9C4xWjL20ravcUubPe224a9paX4GS2uiQBqnIsBYZnYpko3OBnmlf5i35lTeSbH
 hnohqcDi
X-Proofpoint-ORIG-GUID: HTuF79VZUro-IVeOrC4eXkUtMXWbhVjy
X-Proofpoint-GUID: mANJ3viSGXY_txc0F596Y8jBwYg7Jcph
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_04,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200010

The first patch in this series fixes the incorrect accounting of KSM
counters such as ksm_merging_pages, ksm_rmap_items, and the global
ksm_zero_pages during fork.

The following patch added a selftest to verify the ksm_merging_pages
counter was updated correctly during fork.

Test Results
============
Without the first patch
-----------------------
 # [RUN] test_fork_ksm_merging_page_count
 not ok 10 ksm_merging_page in child: 32

With the first patch
--------------------
 # [RUN] test_fork_ksm_merging_page_count
 ok 10 ksm_merging_pages is not inherited after fork

Changes:
V2 -> v3:
- Added Reviewed-by and Acked-by tags
- Added cleanup on exit in ksm_merging_pages test.
- Dropped test_fork_global_ksm_zero_pages_count because it can give false
  failures if multiple processes attempt KSM zero-page merging and unmerging
  during test execution.

v2: https://lore.kernel.org/all/cover.1757946863.git.donettom@linux.ibm.com/#t

v1: https://lore.kernel.org/all/2e662107e01417bf9af23bc7f52863cd538419be.1756211338.git.donettom@linux.ibm.com/

Donet Tom (2):
  mm/ksm: Fix incorrect KSM counter handling in mm_struct during fork
  selftests/mm: Added fork inheritance test for ksm_merging_pages
    counter

 include/linux/ksm.h                           |  8 +++-
 .../selftests/mm/ksm_functional_tests.c       | 43 ++++++++++++++++++-
 2 files changed, 49 insertions(+), 2 deletions(-)

-- 
2.51.0


