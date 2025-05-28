Return-Path: <linux-kernel+bounces-665881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF1DAC6F30
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 19:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93F631C06912
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 17:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6735228ECE9;
	Wed, 28 May 2025 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T2U9svhS"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B54528ECE0
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 17:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748452735; cv=none; b=MjxIoHQbkMMgITm1bI3+aqnHgqCgZJ/njx6iEwTKFmRizYsKdSuadjSI0nE3nkxXq66uLvpqn4ZY6rcUVp/QJ17q5ojcdAErKNoe+NUPYFfKC/rg6zBgniPrC+3E2uSe6AzFvW7+DaAGvu8X7TDFlW0Js/jgj43FIw2d45OQvbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748452735; c=relaxed/simple;
	bh=mACmBIzqXKJOREyRDy7F2bdW7w04De0Ep/XAUKR23jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ID/8D1993mQ666rs7L7R1k65sxlz27vg9rpD34ldlKsNNZzSZVB+DpyP2Pr3CX4nuzbGHxupLCyA8ZbTuyvWpmpM7OmBQiO9LmQwuKrKAuxqgLwy73/7/oEHAWnA1bSYO6qmhpNa1qgKbI2dVQ38rxjygIn763HNdgn87g1Iuko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T2U9svhS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SE9aQQ017944;
	Wed, 28 May 2025 17:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+GzwQJBUnjTYoX8Jm
	ypLOVmrd71JtaR6C60VUecB4d0=; b=T2U9svhS2TAO8yKQiIQ3snmmRVH7kE2N9
	f+PJAUoH49yPeS3DRSOy30lSfJvvL3bWE7h80XWIxAmbsSIG+diXKCSfMt4KwK9M
	pxSIOco9t9+GQUaJeMBarfA/g/AGpWQ7lr/bxpJOq6lV4cx4Y4unkYnLM0sr1WBF
	L3NmOTu/nTP3ljPYS2xOtCYD7kHqZRBDsjDQ1/ZQhM7tadEtsMQk0A8CxjfPkm6Y
	c/ntaFtNqnNnqhYkhY8JUOhCDKrSlYBvnXUxPzfZgfb+2dpOtqYg2kPeVqSJxrBT
	aqZZyYR0U/bX2Is3pzJpPEZVSlG+proaA7IpH5OT0MNF4QgfN8/QA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40hh0xr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 17:18:29 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54SHITuo014429;
	Wed, 28 May 2025 17:18:29 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40hh0xa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 17:18:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54SF0SaK021349;
	Wed, 28 May 2025 17:18:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46utnmracg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 17:18:25 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54SHIM4Q59703638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 17:18:22 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6C7A20043;
	Wed, 28 May 2025 17:18:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 409AD20040;
	Wed, 28 May 2025 17:18:19 +0000 (GMT)
Received: from ltczz402-lp1.aus.stglabs.ibm.com (unknown [9.40.194.31])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 May 2025 17:18:19 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, Oscar Salvador <osalvador@suse.de>,
        Zi Yan <ziy@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Yury Norov <yury.norov@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nilay Shroff <nilay@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Donet Tom <donettom@linux.ibm.com>
Subject: [PATCH v7 4/5] drivers/base/node: Rename register_memory_blocks_under_node() and remove context argument
Date: Wed, 28 May 2025 12:18:03 -0500
Message-ID: <907c22292b0ee4975107876efc875c75c11badd9.1748452242.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <2a0a05c2dffc62a742bf1dd030098be4ce99be28.1748452241.git.donettom@linux.ibm.com>
References: <2a0a05c2dffc62a742bf1dd030098be4ce99be28.1748452241.git.donettom@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDE0OCBTYWx0ZWRfX31wtLZ2pXa/f 0S/u7o2otmMw+2W513wqF0P06Ey7XM/9nvxg3mAmpuviJxOxhv/PZBqKm6zIjLYB0MkfCpzdUUd 0bW0gaN4AH6wqWAQH4XLBxIW7lXMif54EhYYCTLwELimDbe9seM38VjZAMcuCOU+5iV9CyOvUQ7
 x+Uugt34QYXl1i7Z6eXoz0yENC7uuclKlrsZEKcTghlsv4kXBIH7jx29hHbWVNiIC10XiIQE7X5 icMFfDrexz5Ur1s413AVZGS09hVGNSm5mWYnELqGQIGaOYDlVwArURKYLoSLJPoZJN//27Kgaaf IhZQRi2eeQJ0x8grejvGsPi4NOe+AW5K7lyrjIGbNWuaFcFenauMhcLHZrd4N0g3eMTUa9A9iWn
 BxQ9AunfaipqEK3El8mJqmCLobbp/+e4SARO1h86u/aI0LpY3Nc2ydkOS7Dbo3XQdUzS7n8e
X-Proofpoint-GUID: N_e6xefmMaCjPglJD5ZKVs0Q5N8UgZqo
X-Authority-Analysis: v=2.4 cv=WOd/XmsR c=1 sm=1 tr=0 ts=68374565 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=Ikd4Dj_1AAAA:8 a=xjaU-GFjuEzJSOh1rDoA:9
X-Proofpoint-ORIG-GUID: BpJoUUUSieyJdVlgPDQjlvTCb1_9MZ-1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_08,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 impostorscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280148

The function register_memory_blocks_under_node() is now only called from
the memory hotplug path, as register_memory_blocks_under_node_early()
handles registration during early boot. Therefore, the context argument
used to differentiate between early boot and hotplug is no longer needed
and was removed.

Since the function is only called from the hotplug path, we renamed
register_memory_blocks_under_node() to
register_memory_blocks_under_node_hotplug()

Acked-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>

---
v6 -> v7

No change

v6 - https://lore.kernel.org/all/bc754a238aa91fa36be463985ccde66aac7055e7.1748270306.git.donettom@linux.ibm.com/
v5 - https://lore.kernel.org/all/d2490e807b2c13950bc1d4199f22ec078cc4c56a.1747904868.git.donettom@linux.ibm.com/
v4 - https://lore.kernel.org/all/f94685be9cdc931a026999d236d7e92de29725c7.1747376551.git.donettom@linux.ibm.com/
v3 - https://lore.kernel.org/all/b49ed289096643ff5b5fbedcf1d1c1be42845a74.1746250339.git.donettom@linux.ibm.com/
v2 - https://lore.kernel.org/all/fbe1e0c7d91bf3fa9a64ff5d84b53ded1d0d5ac7.1745852397.git.donettom@linux.ibm.com/
v1 - https://lore.kernel.org/all/50142a29010463f436dc5c4feb540e5de3bb09df.1744175097.git.donettom@linux.ibm.com/
---
---
 drivers/base/node.c  |  5 ++---
 include/linux/node.h | 11 +++++------
 mm/memory_hotplug.c  |  5 ++---
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 16ad99abeea6..973b7a89a37e 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -830,9 +830,8 @@ static void register_memory_blocks_under_nodes(void)
 	}
 }
 
-void register_memory_blocks_under_node(int nid, unsigned long start_pfn,
-				       unsigned long end_pfn,
-				       enum meminit_context context)
+void register_memory_blocks_under_node_hotplug(int nid, unsigned long start_pfn,
+					       unsigned long end_pfn)
 {
 	walk_memory_blocks(PFN_PHYS(start_pfn), PFN_PHYS(end_pfn - start_pfn),
 			   (void *)&nid, register_mem_block_under_node_hotplug);
diff --git a/include/linux/node.h b/include/linux/node.h
index b15de78e0408..75b036a100d2 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -111,13 +111,12 @@ struct memory_block;
 extern struct node *node_devices[];
 
 #if defined(CONFIG_MEMORY_HOTPLUG) && defined(CONFIG_NUMA)
-void register_memory_blocks_under_node(int nid, unsigned long start_pfn,
-				       unsigned long end_pfn,
-				       enum meminit_context context);
+void register_memory_blocks_under_node_hotplug(int nid, unsigned long start_pfn,
+					       unsigned long end_pfn);
 #else
-static inline void register_memory_blocks_under_node(int nid, unsigned long start_pfn,
-						     unsigned long end_pfn,
-						     enum meminit_context context)
+static inline void register_memory_blocks_under_node_hotplug(int nid,
+							     unsigned long start_pfn,
+							     unsigned long end_pfn)
 {
 }
 static inline void register_memory_blocks_under_nodes(void)
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 8305483de38b..f734cc924b51 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1575,9 +1575,8 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 		BUG_ON(ret);
 	}
 
-	register_memory_blocks_under_node(nid, PFN_DOWN(start),
-					  PFN_UP(start + size - 1),
-					  MEMINIT_HOTPLUG);
+	register_memory_blocks_under_node_hotplug(nid, PFN_DOWN(start),
+					  PFN_UP(start + size - 1));
 
 	/* create new memmap entry */
 	if (!strcmp(res->name, "System RAM"))
-- 
2.43.5


