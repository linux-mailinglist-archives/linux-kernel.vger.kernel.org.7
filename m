Return-Path: <linux-kernel+bounces-784163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D85B33772
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDF84203909
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 07:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C292874E6;
	Mon, 25 Aug 2025 07:05:36 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47604288C89
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756105535; cv=none; b=mHea2dPAKmXhmYm6EFrcXOaDg1bmek0btXBQ37FQJajnD/QfrBf9eC6f5LXhxUuNLWKUBqmmE0Al5P16DLtvg2kIa/wO0Dzh5RIneKwaSGQdKHed8srUuA7O6w6KQIHOB70/WJIL+mI4YL2bpyD6B+GyNohHDZdKiLABbXjR4nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756105535; c=relaxed/simple;
	bh=q5dvAtNat6PYB+QfG0PQ4Kr/P3/RJcRLnB37xVypb7s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Id0ssSb1jKymAlx1SO3E+ZH+hz/Vpg9PU587ShZsXktG+Drhcx+k9uza+k3RB2SuO5OK4gosDEO/6I8R2wuVS7tbOIfjeVTJrGRGlbyKtvDJyysZibsy7MFbcExJpz4yg9llhkxOSiLdZkwaMI9Fwh3V7beOCN8OgDM4hjCrytc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e081920c818111f0b29709d653e92f7d-20250825
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:7d8eca56-ff57-4f03-8ded-6c0353a63a2f,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:7d8eca56-ff57-4f03-8ded-6c0353a63a2f,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:9ff914008b892f7ca5abcadc87568ea8,BulkI
	D:250818030025RUDYOSC2,BulkQuantity:5,Recheck:0,SF:17|19|24|44|66|78|80|83
	|102|841|850,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:99|1,File:nil,RT:nil,Bul
	k:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,
	BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULS
X-UUID: e081920c818111f0b29709d653e92f7d-20250825
X-User: liuqiqi@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <liuqiqi@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1051094516; Mon, 25 Aug 2025 15:05:26 +0800
From: liuqiqi@kylinos.cn
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm:fix duplicate accounting of free pages in should_reclaim_retry()
Date: Mon, 25 Aug 2025 15:05:05 +0800
Message-Id: <20250825070505.407367-1-liuqiqi@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Duplicate accounting of free pages in should_reclaim_retry() effects:
The number of retry in the __alloc_pages_slowpath() function has increased.
The execution time of the kswapd process has increased.

static inline struct page * 
__alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
                                                struct alloc_context *ac)
{
	......
retry:
	/*
	 * Deal with possible cpuset update races or zonelist updates to avoid
	 * infinite retries.
	 */
	......
        if (should_reclaim_retry(gfp_mask, order, ac, alloc_flags,
                                 did_some_progress > 0, &no_progress_loops))
                goto retry;

The test program: continuously allocates 1k-sized memory through kmalloc(); 
counts the number of retry and the execution time of the kswapd process;
the test results also confirm this.

> Thanks. Does this have any significant runtime effects?

> In the zone_reclaimable_pages() function, if the page counts for
> NR_ZONE_INACTIVE_FILE, NR_ZONE_ACTIVE_FILE, NR_ZONE_INACTIVE_ANON,
> and NR_ZONE_ACTIVE_ANON are all zero,
> the function returns the number of free pages as the result.
>
> In this case, when should_reclaim_retry() calculates reclaimable pages,
> it will inadvertently double-count the free pages in its accounting.
>
> static inline bool
> should_reclaim_retry(gfp_t gfp_mask, unsigned order,
>                      struct alloc_context *ac, int alloc_flags,
>                      bool did_some_progress, int *no_progress_loops)
> {
>         ...
>                 available = reclaimable = zone_reclaimable_pages(zone);
>                 available += zone_page_state_snapshot(zone, NR_FREE_PAGES);

https://lore.kernel.org/all/20250817120016.8dcc091c5b7114d6993a29ae@linux-foundation.org/

---
Best Regards

