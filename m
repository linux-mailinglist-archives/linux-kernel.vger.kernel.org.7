Return-Path: <linux-kernel+bounces-768099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0A7B25CF8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4A69E1423
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA9626C399;
	Thu, 14 Aug 2025 07:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="APG3FsgB"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4E53D69
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755155923; cv=none; b=Xh5AB7o5tedEa2gDQ8K15SoLFSjSugmVGW8cfJdWvPvG/HK5P7mBlfHYYDuaAAzxQx2NgObB+V42I+a0bKJlOD2esC0Jx9nD+9mFIig36SF6MKXcnjD/tpmfk4Cbnu2DR01AVmV1WcUSGVF/bS+wCK6nTLX4k2d8pB3yRFbac1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755155923; c=relaxed/simple;
	bh=8N8Kyxc7BQ2dx9NG3VMObwx21ss7J8sURN7UjXcPnwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pua17IaJfL5TxB8a/rOOtJnDFs5P7+IE6m1Ywok4LOz0iboQRG4IFwJV68X81N5vmhjKDhVDghmKYpOL7Idkl/nYzfV6HguKUBAW8YdYRh7iDtY577cUtG8TvM8heVUdYzVSnOgo5LkpUDZ1v9gx8hsvHhXPwrBN9op/3cEyz0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=APG3FsgB; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755155917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OVOlDlbXHrc0qK8WmHZtAp5nrF5N5O0JhEqs8GoP2r0=;
	b=APG3FsgB0a+RYjpSJGO4c1LihqXy9QGPmiooaO7F924zT12UIEihe5lAkUpI3C5qKlMr1D
	Tat7tkAgarpNYBo1Fu43jewCfW+bu97m6ujIgpHpM9FdKtC0FbFlgifGyi8sx/D+0zv+Yc
	Y+F9pBg+ctgE+m9e7DpbHUgoZqe0EfI=
From: Ye Liu <ye.liu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: Ye Liu <liuye@kylinos.cn>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/page_alloc: Remove redundant pcp->free_count initialization in per_cpu_pages_init()
Date: Thu, 14 Aug 2025 15:18:28 +0800
Message-ID: <20250814071828.12036-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Ye Liu <liuye@kylinos.cn>

In per_cpu_pages_init(), pcp->free_count is explicitly initialized to 0,
but this is redundant because the entire struct is already zeroed by
memset(pcp, 0, sizeof(*pcp)).

Signed-off-by: Ye Liu <liuye@kylinos.cn>
---
 mm/page_alloc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d1d037f97c5f..64872214bc7d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5946,7 +5946,6 @@ static void per_cpu_pages_init(struct per_cpu_pages *pcp, struct per_cpu_zonesta
 	pcp->high_min = BOOT_PAGESET_HIGH;
 	pcp->high_max = BOOT_PAGESET_HIGH;
 	pcp->batch = BOOT_PAGESET_BATCH;
-	pcp->free_count = 0;
 }
 
 static void __zone_set_pageset_high_and_batch(struct zone *zone, unsigned long high_min,
-- 
2.43.0


