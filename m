Return-Path: <linux-kernel+bounces-862700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A25DFBF5EEC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BE7818C8132
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575F32F360E;
	Tue, 21 Oct 2025 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VdQqBiPh"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB47B2F2915
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761044428; cv=none; b=UgCUFlUgZ/71uE8skGMvbRz9fdzpR7ZfJv2xQwQFUQyNEA+fklofMHUZG6wEbC04oqAFA8t7kBMtVskSjAMcXNBRmfejSLRIVTgmN+V44iht1rk5puKDN5/pZfuzvl/pT7fxd25J6lwhcFIdCOLIg6sH8H2GzsLraffC39GeZ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761044428; c=relaxed/simple;
	bh=a96RncrGsQGPry1Utmfhfl7siLipRtGqmUUIhggTc8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o4nY8IxbYXCEKs7EdIp0RB8NblRkugGaaOOnkEIXUzZprqcqONaI009mWURyOKIvUnGez+B0qJ2Kj5jLJSGVJiZRmn6qykYZ5sT8RL2Dj4XO1a02tgf5/kDECX5lSCiPxmVKB5Wf1DAd+RQ/3R1Ya3cCxoeDRO9kUkDRC75u9ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VdQqBiPh; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L7uWIf005851;
	Tue, 21 Oct 2025 11:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=NMjd1uZ/QscBSveIYXes2vB4VJaUB
	jLGGLvhK0f1mz0=; b=VdQqBiPhpaNd90JEgDKdpo3BejXa27bZ/U1yD4wx+YtHQ
	3SAe4TVT0ANRjNANmMGiHjDXgCU95rADrALLs2nErJd9KyWwbMRVr9G+iBMk3Bn+
	++7nfnNQpHBswPvQfnYuXiaLK3+Q0yt0kZrGNvDw6M8b7QMtLwFhc0kRZWGLGneI
	m+TvLZmxJVK2zPM10vYI6qk8woo91d9mG+fHIqVShO8I/0k9ElZV7Y62K9lg8cZv
	r52VH7MtBB843Rz1OgA7xhji4b2Rk59/scBz8bsGAZihMlJiePyz9DHesA3qKUbs
	iv7mHgnOIVlXfO4Dadjmu3NhfHrfPIlen6JMHieiA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2ypvr8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 11:00:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59LA0uPH004361;
	Tue, 21 Oct 2025 11:00:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bbyf7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 11:00:06 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59LB05Ff004240;
	Tue, 21 Oct 2025 11:00:05 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 49v1bbyf6e-1;
	Tue, 21 Oct 2025 11:00:05 +0000
From: William Kucharski <william.kucharski@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Harry Yoo <harry.yoo@oracle.com>, Paul Mundt <lethal@linux-sh.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: william.kucharski@oracle.com
Subject: [PATCH] mm: Remove reference to destructor in comment in calculate_sizes()
Date: Tue, 21 Oct 2025 05:00:04 -0600
Message-ID: <20251021110004.2209008-1-william.kucharski@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510210086
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfXwGhD0rOetU5l
 g8FyW9/hkUQF6B1TgUPBGixhzLUhRplc/kRzvYZZksPrX9Mo2Sr572zbtbNb6vfrFbFVWhRH2EJ
 ZmaxUdyLuFm9Nm3d/lHVHFsTqR+AodJeWqu8i3XWQyCqydOcCmNVSOqEykGPg8eY9dGh6ryC6Tz
 6bq/SN0J83Whu+VzATlMSDWJmu/8piWfVDXtGH7PpORvoPNkPT3dEqzC+rNErwAfXJNAkQkGbDj
 Q/rEEv3Wx/nT5+FSgnQvW7lxPatrV+DbWJQWeXmDnDtynRZZBBzANEblxzMZwGs5QxN+jmzMUgo
 xN2XfasTrfeMFMQcJlqxZZS94kFYVhzMIG8p48gBbaEKwqy9/d7WV5Ku9yOrt4OC3GqQYf0wHNP
 5cPsxCtZnOObCu6754GMS+Tl6SzWIQ==
X-Proofpoint-GUID: dFPMblz8YaKD2z-LSrm_GqZZgoWl08hP
X-Authority-Analysis: v=2.4 cv=Db8aa/tW c=1 sm=1 tr=0 ts=68f767b7 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=U8uE9Md__1QdxW6YSgIA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: dFPMblz8YaKD2z-LSrm_GqZZgoWl08hP

The commit that removed support for destructors from kmem_cache_alloc()
never removed the comment regarding destructors in the explanation
of the possible relocation of the free pointer in calculate_sizes().

Fixes: 20c2df83d25c ("mm: Remove slab destructors from kmem_cache_create().")
Signed-off-by: William Kucharski <william.kucharski@oracle.com>
---
 mm/slub.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index a8fcc7e6f25a..09cbbe923a05 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -7875,11 +7875,11 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 		 * permitted to overwrite the first word of the object on
 		 * kmem_cache_free.
 		 *
-		 * This is the case if we do RCU, have a constructor or
-		 * destructor, are poisoning the objects, or are
-		 * redzoning an object smaller than sizeof(void *) or are
-		 * redzoning an object with slub_debug_orig_size() enabled,
-		 * in which case the right redzone may be extended.
+		 * This is the case if we do RCU, have a constructor, are
+		 * poisoning the objects, or are redzoning an object smaller
+		 * than sizeof(void *) or are redzoning an object with
+		 * slub_debug_orig_size() enabled, in which case the right
+		 * redzone may be extended.
 		 *
 		 * The assumption that s->offset >= s->inuse means free
 		 * pointer is outside of the object is used in the
-- 
2.51.0


