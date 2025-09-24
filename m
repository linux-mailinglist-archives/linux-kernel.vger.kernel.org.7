Return-Path: <linux-kernel+bounces-831101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFC7B9B8AB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E2B61BC161A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B8731A548;
	Wed, 24 Sep 2025 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MN586EU7"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC6131AF16
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758739298; cv=none; b=WSAr/GxSL7c2tOuXmNLLEv2KugWzf4NMYZsP/yh9tsylXz6xsfcoSCFbmOQ+BLMqRB9jT6BiYiZ56fOjS0GoKZf0mRt20JTxeQ9KL5n/Pb/EWT6Uh+5LdbpyU7ZJ+i2Ru6yEiQcn2jmAvSe2I36nyMKXHOAMmneYi0KS7baFApY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758739298; c=relaxed/simple;
	bh=EYLvaRYjWgQzxfevE0NYJaSJep7MsCprgc2ldvWQaDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ONCuCDldeNAV/YCAAGQLSPuVpH4letvDMyXgofKPcdL11XF0KTGQA8OoxhXZNuXYtnDdPTqwaWA0Pk+3AKCzj1V5EBNwEH1m7H8/dK7qxT9lVeT5dIcH3wLZNeXlj2k/yHrWx3zrmiMq2t/U4b+nSqjK+TOtKwIFrtrsW6R8c1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MN586EU7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OAWNhn032221;
	Wed, 24 Sep 2025 18:41:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=UxrvbhRi5qIbb53e4q9T6m/KTCcP0t1N9Grz7dih7
	2s=; b=MN586EU7SDSkvQyJKHTD31RRBBSnCwqRe6vkLxYqPOq7VAfQxdnbwvl2M
	lXI32BtJ/92gi0HVFwOfZZLIM/csybWAKoCIay1E6rsWpuSdHVhntp+iI9KjR3w2
	PR+hPiTuxPBC0t6aYg2Jv1iiYGaN++ux8zAubAuxCZK90SMPq030hoGJCpzIy/KT
	2j8+la2mcyCChX0Ly7Owqid3ZXkcPbXdbSec4z2tMtQEpRFC3bZ+XleTSSSG40bm
	mTG0ZXUuud5ToSb6JojABKULmwcJCf+aM89BVH2VHwSg3y/KvxVnmvj8x/RN0Azf
	RRSp9gWEAkCwcGzFnuGnH6M3lqhTw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499hpqgwjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 18:41:05 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58OIUJpH031936;
	Wed, 24 Sep 2025 18:41:04 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499hpqgwjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 18:41:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58OGZ5iL031166;
	Wed, 24 Sep 2025 18:41:03 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49b9vdb3s6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 18:41:03 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58OIf0ht53477778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 18:41:00 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 066D920040;
	Wed, 24 Sep 2025 18:41:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7BDC20043;
	Wed, 24 Sep 2025 18:40:55 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.ibm.com.com (unknown [9.39.28.85])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Sep 2025 18:40:55 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, Donet Tom <donettom@linux.ibm.com>
Subject: [PATCH 0/2] drivers/base/node: fold node register and unregister functions
Date: Thu, 25 Sep 2025 00:10:49 +0530
Message-ID: <cover.1758736423.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FrEF/3rq c=1 sm=1 tr=0 ts=68d43b41 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=KFY20ALy1DZ1KhuY3mYA:9
X-Proofpoint-ORIG-GUID: czx2wiS_tSVfgnNn8tsKr_m-DZkTk-BC
X-Proofpoint-GUID: TmIYvx6EGz04tjFfpJeHy-d1Mz-GBxyD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE5MDIyNCBTYWx0ZWRfX370bLG+S6F2M
 wcTVuBvEi37um2hyQ9MnyXoGynceg8EHVrS+w/8fSRxMCD6EPemdeP0Oe67b0pwiRjtiHAN4XBx
 rnZIBQM6tUPVre8sBmj8wOS2Ebcw00WaCpr12HeHxSbvmBLBIwdPFolPZb7dGIeGqDVRyHLJcsW
 YWq7b+FyoQPL5B+Eec6wlaCpUdy4ysN3uZkpxd9vRf0nD9fYyRGwqmlAz2+WiFha97wJRS75Y8p
 M9lkZJhGHSAFcbE9r626xh+NbwWjKcWk/VWrLealcXccYDI+fBsGWCwLlar/MJIpNascuBSV3oI
 TNfgxLML0iNAimfO303evz3EFiZ0YbOZAMxvgJ/BFltNeYCJG9LjplusHi5B7H9Efff4pzLQjO7
 /ocgssqa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_04,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1011 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509190224

This change came from the discussion in [1]. It consists of two patches:

The first patch merges register_one_node() and register_node(), leaving a
single register_node() function.

The second patch merges unregister_one_node() and unregister_node(), leaving
a single unregister_node() function.

There is no functional change in these patches.

[1] https://lore.kernel.org/all/5512b1b6-31f8-4322-8a5f-add8d1e9b22f@redhat.com/

Donet Tom (2):
  drivers/base/node: merge register_one_node() and register_node() to a
    single function.
  drivers/base/node: merge unregister_one_node() and unregister_node()
    to a single function.

 arch/powerpc/platforms/pseries/pci_dlpar.c |  2 +-
 arch/x86/mm/numa.c                         |  4 +-
 drivers/base/node.c                        | 89 +++++++++-------------
 include/linux/node.h                       | 10 +--
 mm/memory_hotplug.c                        |  8 +-
 mm/mm_init.c                               |  2 +-
 6 files changed, 49 insertions(+), 66 deletions(-)

-- 
2.51.0


