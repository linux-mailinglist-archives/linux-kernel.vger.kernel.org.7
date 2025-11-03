Return-Path: <linux-kernel+bounces-882422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57843C2A6EF
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 08:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D959C3B56EA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 07:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1B12C11D5;
	Mon,  3 Nov 2025 07:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="Z2OMwlnr"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACD22C0277
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 07:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762156384; cv=none; b=FQaBraYEfRsTwfReRtlioGAfo+xRluq7o4Voz8gxeMR1p57XsSbUTKW/pYRAs5I9krgVL5vPHg1S2GszITkhKzu9UKN5yIO49rcm4fE0x0MGRMwScAgYMryqbFhQ3h/4dN4SELXg4FNvItGx4gNyCieUjEEzf5LWLxhk8UWpP2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762156384; c=relaxed/simple;
	bh=e7ed8ZmJa/kqjlXsP+aE5zpUgSJSjGTZ/K4MPhvN53A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ioMoqEpLKwn7bnac56werBs/3adL/DvomBflwAPT670zdScTi1KN3WpXYl/lhlJZ0xERsTgGm3E8QUabfd4rP2l7+wubkkfl9sNxZrmVyjPVNEPQsnzm6DSrvlNZ0m/gYPEm8w6fHlPRiIYq02RNBpwb0ImNAE3ygXx3Ph9vnSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=Z2OMwlnr; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-340e525487eso822279a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 23:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1762156380; x=1762761180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBJR74pL2UFLaHc8oAOxpJBTbxd/tOOTfgjPB+YfL2o=;
        b=Z2OMwlnrFpZPu1TtMLiVLFV8hnFN2kG30WbYGRbsESze970Nj7BxW0bhRs6j+6j3dX
         s7SAHDc/dy4Rv727nu5GHILrJbG1vxqPBu9eDJgt0k9iRvA6g0Fi5Qyved3MrPZ2GiFM
         FDUQ/q6QGjvOnMnH9RPTLD/j1s31ksoe5JgoQj0gCw82Ar2o6WnGSyuHchQkJuuyoYZX
         FPZPW1onvsN0zgphUJJLTGk1bAtxoyGI72yZgX7Ym1yWB4f3Kg3OMLpdNWKpmufdTnOn
         xOlzz0zm7VvQu1BBuqM0dquF2gk9nNXLOBhg7S3jfSquQXey0S4vrWSgMo+9ZRnpCOF7
         rd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762156380; x=1762761180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBJR74pL2UFLaHc8oAOxpJBTbxd/tOOTfgjPB+YfL2o=;
        b=Xr05efuo1loQAh7L5NjGjYRLp/Mzx87lNDGZttFxJdbelgdbpPnLFPcOZvN/TI4IMb
         3yfuJX0sFPinJxerZM6B0e5ZfhEyC28BomBPtPMFze04oEL3LfkcOC+8nVqp9sYtGd0b
         yqIbzGbNpx1WjNd30W8FYfqxfrm/gpLKKHgrxqXm9YcAdiqKuN1h+KQ1CcsLJ4MvfNrr
         exmtoVcmHKl65pYLQImoW48vnX0bu5+r5vI0fh7BTJ1Bz2lEZHXUgA9yWNrCrkOi5MXQ
         MaWcvcIqBA6mxtrX2Jv3OUXUoadKFAKGgkNPSKdJHHp7cTYQ1dtgdmq26FdEXpLbNDQo
         cEKA==
X-Forwarded-Encrypted: i=1; AJvYcCVPx6uY+bbXJkIrgRdtVE0R3BwWQHi6pgw+b7L1Y/xVkwRmIggvJ2fB5DmlG9s4FipPycyK2tyL3ZZGTCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd5pqYOqNzNviauurWCLZnKISQPiIrZ3C9wg8VNm8vprivvUi2
	8r6LegFeXLxZPybjzlO2o+C5kErD3EKjGxc6QmNNhFsHVOTaavBj2rvYAFMA6fqkTNc=
X-Gm-Gg: ASbGncuYn7dr9FHNtWBpjE0MklD00MlisNKCfVVYfr/XznHM5OA1/4aXT8DZLTAPaJW
	WFpAXH1xU7Eo38aEDDlg1QG6vp1DHAFdsiot0baA7EWk8TFidli/412s8a7L8aZEIYB/gjC2OyE
	CcgxoS2B8J/vRKlsXDd9ySQ0Kjh8ZDYVUKAYSH2moK6Qv5OZCO3HvFafrl4gcmrErCw+s3lc/i0
	fNGJYM3X/KHmJor6EqeC+EA1+b/Zyl3wFH4LNNNDBxbkJUAZ51hzNkyRT6n+XlzOaXWsdMVHM+V
	N8hyZoJn3Smy7ygZ9ZdskQsWS9aQ6x3B49PadmTycb37NvwrFQByauoPIezRcPZpClGDdJ/L0Sr
	XeLLXI/rpnQXawIR0u1YQTQ1m2OfU9GgcdjYztDARTqwfCwDQTvoEIJI4Bv7WI+FBCawONwExkM
	O2esQ0u8Jp5pNlhGbP+W3hma7t
X-Google-Smtp-Source: AGHT+IHCeuWblU4UX1TsHgam4EVLA+G+yYi1frynG5wZVaDx/qokn9yyEJcHgqKW4FWQHlMPmkrGgA==
X-Received: by 2002:a17:90a:d450:b0:340:a961:80c5 with SMTP id 98e67ed59e1d1-340a961873emr10029797a91.32.1762156380212;
        Sun, 02 Nov 2025 23:53:00 -0800 (PST)
Received: from .shopee.com ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34159a16652sm34552a91.20.2025.11.02.23.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 23:52:59 -0800 (PST)
From: Leon Huang Fu <leon.huangfu@shopee.com>
To: stable@vger.kernel.org,
	greg@kroah.com
Cc: tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	corbet@lwn.net,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeelb@google.com,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	sjenning@redhat.com,
	ddstreet@ieee.org,
	vitaly.wool@konsulko.com,
	lance.yang@linux.dev,
	leon.huangfu@shopee.com,
	shy828301@gmail.com,
	yosryahmed@google.com,
	sashal@kernel.org,
	vishal.moola@gmail.com,
	cerasuolodomenico@gmail.com,
	nphamcs@gmail.com,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Xin Hao <vernhao@tencent.com>,
	Michal Hocko <mhocko@suse.com>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 6.6.y 1/7] mm: memcg: add THP swap out info for anonymous reclaim
Date: Mon,  3 Nov 2025 15:51:29 +0800
Message-ID: <20251103075135.20254-2-leon.huangfu@shopee.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103075135.20254-1-leon.huangfu@shopee.com>
References: <20251103075135.20254-1-leon.huangfu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xin Hao <vernhao@tencent.com>

[ Upstream commit 811244a501b967b00fecb1ae906d5dc6329c91e0 ]

At present, we support per-memcg reclaim strategy, however we do not know
the number of transparent huge pages being reclaimed, as we know the
transparent huge pages need to be splited before reclaim them, and they
will bring some performance bottleneck effect.  for example, when two
memcg (A & B) are doing reclaim for anonymous pages at same time, and 'A'
memcg is reclaiming a large number of transparent huge pages, we can
better analyze that the performance bottleneck will be caused by 'A'
memcg.  therefore, in order to better analyze such problems, there add THP
swap out info for per-memcg.

[akpm@linux-foundation.orgL fix swap_writepage_fs(), per Johannes]
  Link: https://lkml.kernel.org/r/20230913213343.GB48476@cmpxchg.org
Link: https://lkml.kernel.org/r/20230913164938.16918-1-vernhao@tencent.com
Signed-off-by: Xin Hao <vernhao@tencent.com>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Leon Huang Fu <leon.huangfu@shopee.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 9 +++++++++
 mm/memcontrol.c                         | 2 ++
 mm/page_io.c                            | 8 ++++----
 mm/vmscan.c                             | 1 +
 4 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index b26b5274eaaf..622a7f28db1f 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1532,6 +1532,15 @@ PAGE_SIZE multiple when read back.
 		collapsing an existing range of pages. This counter is not
 		present when CONFIG_TRANSPARENT_HUGEPAGE is not set.

+	  thp_swpout (npn)
+		Number of transparent hugepages which are swapout in one piece
+		without splitting.
+
+	  thp_swpout_fallback (npn)
+		Number of transparent hugepages which were split before swapout.
+		Usually because failed to allocate some continuous swap space
+		for the huge page.
+
   memory.numa_stat
 	A read-only nested-keyed file which exists on non-root cgroups.

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2d2cada8a8a4..c61c90ea72a4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -704,6 +704,8 @@ static const unsigned int memcg_vm_event_stat[] = {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	THP_FAULT_ALLOC,
 	THP_COLLAPSE_ALLOC,
+	THP_SWPOUT,
+	THP_SWPOUT_FALLBACK,
 #endif
 };

diff --git a/mm/page_io.c b/mm/page_io.c
index fe4c21af23f2..cb559ae324c6 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -208,8 +208,10 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 static inline void count_swpout_vm_event(struct folio *folio)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (unlikely(folio_test_pmd_mappable(folio)))
+	if (unlikely(folio_test_pmd_mappable(folio))) {
+		count_memcg_folio_events(folio, THP_SWPOUT, 1);
 		count_vm_event(THP_SWPOUT);
+	}
 #endif
 	count_vm_events(PSWPOUT, folio_nr_pages(folio));
 }
@@ -278,9 +280,6 @@ static void sio_write_complete(struct kiocb *iocb, long ret)
 			set_page_dirty(page);
 			ClearPageReclaim(page);
 		}
-	} else {
-		for (p = 0; p < sio->pages; p++)
-			count_swpout_vm_event(page_folio(sio->bvec[p].bv_page));
 	}

 	for (p = 0; p < sio->pages; p++)
@@ -296,6 +295,7 @@ static void swap_writepage_fs(struct page *page, struct writeback_control *wbc)
 	struct file *swap_file = sis->swap_file;
 	loff_t pos = page_file_offset(page);

+	count_swpout_vm_event(page_folio(page));
 	set_page_writeback(page);
 	unlock_page(page);
 	if (wbc->swap_plug)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 258f5472f1e9..774bae2f54d7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1922,6 +1922,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 								folio_list))
 						goto activate_locked;
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
+					count_memcg_folio_events(folio, THP_SWPOUT_FALLBACK, 1);
 					count_vm_event(THP_SWPOUT_FALLBACK);
 #endif
 					if (!add_to_swap(folio))
--
2.50.1

