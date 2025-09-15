Return-Path: <linux-kernel+bounces-817265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F12DB57FE8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A463A4B4F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34711324B01;
	Mon, 15 Sep 2025 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i0ayDrjQ"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126FB3002A3
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948726; cv=none; b=RoPK3yPyYM3jrJcYIPMmUHUIqoqcisNgor1YehBP6Z5hyXJeqtNEC2vCwGTvMJm6Ym50KsKzxQkN/goOhV8FZFxLMAQpGXB7Uv8dc74cxXybVxfOAl+Ku+mEwSyOsZiTL4Jd9io2IHMbxhm0kPL3VqM5xL55LuZYko+rkGdLnPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948726; c=relaxed/simple;
	bh=qD+hXQctnO3RcDTXDqGmGD77+1vbeZ+pUX4vmONs9/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tKD/Pp+N50OK5O1wAwqvOktVJOBIivml16yKHhRkCuG9xXh2TKJTOtf3uO+zjqArIJhbJLMn13Vwpe7fZFHIvLlqL5P3oWiMG09dk3zE4HkCBAhaaxvWkPTAKpdO8lRgc2V5lr+2IimWEnsgLIFwszJeoaypC3Y9OkIhufk+JwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i0ayDrjQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FBMpZV031871;
	Mon, 15 Sep 2025 15:03:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=cSCcHOLheBZ60BBBWDtHpgyihcu89/daUQs3juAmL
	Y0=; b=i0ayDrjQVjq0lkBxaeMVC6wcFPu8TcD1cXvypg2vjSCjz089Xlf6SeVFo
	9OCsO2aFy3KbQzrMCf5HypFpyrfWJg8atyiJWOKbaMtYWyFMA7FCv2DXpZiQKFNy
	wSDVbl4x3iOhpsMCivJXTqR3jfOAJ8CxjXsdvnZ/qhsoTOf3UOX277bvkZHjVOra
	lT4asSwhrZm5tga99VzhOdslhpkkkFqRKopdYhA7gCID5ESi8peZYiWm56UijFgu
	EduIQCBmCKb6CcTjBH7+9GmhxSS/6NMMLgCvzPHq8rp5MjkJDPD04Ajufs3qG2Ad
	ElAfFP9y+nU1sN3ot6GH0FENIHX1Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 494x1tb1ny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 15:03:17 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58FF1VfG010538;
	Mon, 15 Sep 2025 15:03:17 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 494x1tb1nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 15:03:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58FBdItx027308;
	Mon, 15 Sep 2025 15:03:16 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495memxxqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 15:03:16 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58FF3Cpd51314952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 15:03:12 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DF5820043;
	Mon, 15 Sep 2025 15:03:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9897920040;
	Mon, 15 Sep 2025 15:03:09 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.in.ibm.com (unknown [9.109.215.183])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Sep 2025 15:03:09 +0000 (GMT)
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
Subject: [PATCH v2 0/3] mm/ksm: Fix incorrect accounting of KSM counters during fork.
Date: Mon, 15 Sep 2025 20:33:03 +0530
Message-ID: <cover.1757946863.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OMsn3TaB c=1 sm=1 tr=0 ts=68c82ab5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=8dabxjvEmk4eI1i_HKQA:9
X-Proofpoint-ORIG-GUID: O6Pn4dbXVKFzHep12KWTtyqNC5MstEit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAwMSBTYWx0ZWRfX6FjBQv4Cc3yL
 yXvdYlJcNW8w/DURJa/TjchGcLgafZnS657WUjiiBosfIWYiEH37DyZLczSImTdSlvBC5Gw/zzF
 TY9a9hGCFEen6mJsdk93t1jghZtfxjRAmfn9yJ1tFj8vH6EtNu+LAbo3rQZlfhdSwWSV0lGB2qc
 nFlqntk/ChiBLdGKPcwO1t/tNNFr5vdyvHpzcOs6sCQ8+E6GBdlKObdqPPBPqX331HBV65gKSFy
 6JXZEevzEu2o/8q1rfHFAc0NI4BAKdZENeWE1gAtQFsM1R1vZuTxzcIaSDWYPspozqp5zoH6wN/
 AD0CPvSKoyUsR4NnPCJEvXbizIUDg6eCUfmKIkQw89ZuMXdZTjd9nIIcb+Rpay78nSsB/KB31cF
 UAP/QrWV
X-Proofpoint-GUID: 9AwENwd4pSzlgdVpYoJ6_4Q0WypDhWZf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_05,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130001

The first patch in this series fixes the incorrect accounting of KSM
counters such as ksm_merging_pages, ksm_rmap_items, and the global
ksm_zero_pages during fork.

The following two patches add selftests to verify that the
ksm_merging_pages counter and the global ksm_zero_pages counter are
updated correctly during fork.

Test Results
============
Without the first patch
-----------------------
# [RUN] test_fork_ksm_merging_page_count
not ok 10 ksm_merging_page in child: 32
# [RUN] test_fork_global_ksm_zero_pages_count
not ok 11 Incorrect global ksm zero page counter after fork

With the first patch
--------------------
# [RUN] test_fork_ksm_merging_page_count
ok 10 ksm_merging_pages is not inherited after fork
# [RUN] test_fork_global_ksm_zero_pages_count
ok 11 Global ksm zero page count is correct after fork

Changes:

v1 -> v2 :
 - Rebased to mm-new branch
 - Fixed incorrect global ksm_zero_pages counter issue during fork and
 added a selftest to verify it.

v1: https://lore.kernel.org/all/2e662107e01417bf9af23bc7f52863cd538419be.1756211338.git.donettom@linux.ibm.com/


Donet Tom (3):
  mm/ksm: Fix incorrect KSM counter handling in mm_struct during fork
  selftests/mm: Added fork inheritance test for ksm_merging_pages
    counter
  selftests/mm: Added fork test to verify global ksm_zero_pages counter
    behavior

 include/linux/ksm.h                           |   8 +-
 .../selftests/mm/ksm_functional_tests.c       | 114 +++++++++++++++++-
 2 files changed, 120 insertions(+), 2 deletions(-)

-- 
2.51.0


