Return-Path: <linux-kernel+bounces-837609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54945BACBC9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A003B4179
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A60F29B766;
	Tue, 30 Sep 2025 11:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qb3jH0OU"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A24623D288
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 11:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759233427; cv=none; b=rMISTwKQTJ9t0ODdlI+W6PK50dxw15f6xwiCGL38ALYmm0xAvxPNhHKroPy+csA0ntQu4Epb1arXu+Ksd1PikqGOedpqiacWVJWNtnNWXwYjxyHbG3/GCPulAql3fOTT8/v295mIes3h989iMVgmqzDC7BIbjSDbKIUg3sf45L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759233427; c=relaxed/simple;
	bh=3n/7D4qRZeMwh8IF+tyYUkSvBkXRCom/JxiPmgZyoN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HaSqfkI9qtLpGpwmKXaXy1AyrgGcud58OOcpNKaFhoyHgaVr5NhGRbREsTzr6Xo/Td1RnJEykI5PRs0D2J07kfiuiufkcRPiQDDubb6mmDkyTmIxMmoC83vwCCpVVfFl/0FP5llTzklBC568Y420/IppIKrBj3RldFCNI1yp9kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qb3jH0OU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U6FWuC023184;
	Tue, 30 Sep 2025 11:56:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=uLYdFPrLnyCJeuiXqE24UjB9h+DlRVVlfV6Wh3gln
	dE=; b=qb3jH0OUJthQPcD8UO1wym+j4CX6QJ63WUHSi15+9SMnlo5QwEUFrkqGH
	d4dTzFEIPEx4+6gid3cfPiuBewotnep4cHco0eDNBCdnO3aCfKBpaOH1K72kTabV
	mXUagZyAphm5z5NSfyausoImH4MEaL6e14xw9MICbpDUBClVV789bkhhaFwjkb0I
	t/yYV7s3BjX7dvGzOR8zpCGhd2D0FMr3l64IYprXxiOsOOKgsXOnVIExND00o7N0
	6bYEs2E1jZyWInu0iOd/QU3lM6jZ9TkKIg/PZ2koW4zBoejHPZLglGz6vctiwNTx
	XGpYi95maSdsSaaMvOQ7IqIZuMcGQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7ku8npe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 11:56:58 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58UBspmK026015;
	Tue, 30 Sep 2025 11:56:57 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7ku8npc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 11:56:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58UA5hWh024110;
	Tue, 30 Sep 2025 11:56:56 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49evy12vjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 11:56:56 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58UBur5x44237072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 11:56:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D7C320043;
	Tue, 30 Sep 2025 11:56:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFA8120040;
	Tue, 30 Sep 2025 11:56:52 +0000 (GMT)
Received: from li-26e6d1cc-3485-11b2-a85c-83dbc1845c5e.boeblingen.de.ibm.com (unknown [9.155.211.236])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Sep 2025 11:56:52 +0000 (GMT)
From: Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>
To: Alexander Potapenko <glider@google.com>
Cc: Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>
Subject: [PATCH] mm/kmsan: Fix kmsan kmalloc hook when no stack depots are allocated yet
Date: Tue, 30 Sep 2025 13:56:01 +0200
Message-ID: <20250930115600.709776-2-aleksei.nikiforov@linux.ibm.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=T7WBjvKQ c=1 sm=1 tr=0 ts=68dbc58a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=8O52IJZf9AqgYq1AvSwA:9
X-Proofpoint-GUID: 2MlcIaOIPNuSYhLYF18xUsDti4D8uZw8
X-Proofpoint-ORIG-GUID: r2AQStiL2pyVn3dzbFpUjF4YW448Tcuo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX7QSBso6vH+ZV
 XAfmtLz8OQ/2I8tdOrQn3yK5c99+12X9I71rcuJjgvhqo8+S0YHJHGkZz88TqHi0usYR85tP03Z
 VNFnCQ41hhvy/yviYH7OYZXZWJ/fmmItE7cqYYlPNsg/IbX+d+7SS1/KiMvRZWqIphB3bUIE/jk
 eEzO8gBeZMcC7jBb6zXvRv3s50do6/UnrmHUc2jI8bexjGnPw7f0je5hhgdpvg1Nt2w9vMhjOab
 2JVBhlpCHz0RlNkDxICdJFjghcUusdwmi9zD/I+6FHC99ZqZJmp5j2+nehc7TrqxPxWQuBytgTd
 wVCDqYmtmY1ag/L7jIUmnoALaIGtpWcD7pAdeujJh/8Gtd+1F5E2VBvDDQ3Eb+k3rHxf/r3FZgK
 Kram9+fp0Jq8UcFfSZuMteDhJb6LGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025

If no stack depot is allocated yet,
due to masking out __GFP_RECLAIM flags
kmsan called from kmalloc cannot allocate stack depot.
kmsan fails to record origin and report issues.

Reusing flags from kmalloc without modifying them should be safe for kmsan.
For example, such chain of calls is possible:
test_uninit_kmalloc -> kmalloc -> __kmalloc_cache_noprof ->
slab_alloc_node -> slab_post_alloc_hook ->
kmsan_slab_alloc -> kmsan_internal_poison_memory.

Only when it is called in a context without flags present
should __GFP_RECLAIM flags be masked.

With this change all kmsan tests start working reliably.

Signed-off-by: Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>
---
 mm/kmsan/core.c   | 3 ---
 mm/kmsan/hooks.c  | 6 ++++--
 mm/kmsan/shadow.c | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/kmsan/core.c b/mm/kmsan/core.c
index 1ea711786c52..4d3042c1269c 100644
--- a/mm/kmsan/core.c
+++ b/mm/kmsan/core.c
@@ -72,9 +72,6 @@ depot_stack_handle_t kmsan_save_stack_with_flags(gfp_t flags,
 
 	nr_entries = stack_trace_save(entries, KMSAN_STACK_DEPTH, 0);
 
-	/* Don't sleep. */
-	flags &= ~(__GFP_DIRECT_RECLAIM | __GFP_KSWAPD_RECLAIM);
-
 	handle = stack_depot_save(entries, nr_entries, flags);
 	return stack_depot_set_extra_bits(handle, extra);
 }
diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index 97de3d6194f0..92ebc0f557d0 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -84,7 +84,8 @@ void kmsan_slab_free(struct kmem_cache *s, void *object)
 	if (s->ctor)
 		return;
 	kmsan_enter_runtime();
-	kmsan_internal_poison_memory(object, s->object_size, GFP_KERNEL,
+	kmsan_internal_poison_memory(object, s->object_size,
+				     GFP_KERNEL & ~(__GFP_RECLAIM),
 				     KMSAN_POISON_CHECK | KMSAN_POISON_FREE);
 	kmsan_leave_runtime();
 }
@@ -114,7 +115,8 @@ void kmsan_kfree_large(const void *ptr)
 	kmsan_enter_runtime();
 	page = virt_to_head_page((void *)ptr);
 	KMSAN_WARN_ON(ptr != page_address(page));
-	kmsan_internal_poison_memory((void *)ptr, page_size(page), GFP_KERNEL,
+	kmsan_internal_poison_memory((void *)ptr, page_size(page),
+				     GFP_KERNEL & ~(__GFP_RECLAIM),
 				     KMSAN_POISON_CHECK | KMSAN_POISON_FREE);
 	kmsan_leave_runtime();
 }
diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
index 54f3c3c962f0..55fdea199aaf 100644
--- a/mm/kmsan/shadow.c
+++ b/mm/kmsan/shadow.c
@@ -208,7 +208,7 @@ void kmsan_free_page(struct page *page, unsigned int order)
 		return;
 	kmsan_enter_runtime();
 	kmsan_internal_poison_memory(page_address(page), page_size(page),
-				     GFP_KERNEL,
+				     GFP_KERNEL & ~(__GFP_RECLAIM),
 				     KMSAN_POISON_CHECK | KMSAN_POISON_FREE);
 	kmsan_leave_runtime();
 }
-- 
2.43.7


