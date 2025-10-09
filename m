Return-Path: <linux-kernel+bounces-846238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AF0BC758C
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 06:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65DC19E516A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 04:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2F423E340;
	Thu,  9 Oct 2025 04:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mAuNQ3U1"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305BF16DEB1
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 04:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759982729; cv=none; b=sm/vhIYeB+ZyMPLH2DNKxvGY+bgwaFixVJ5W0aTnoFStE1XVdK8UT3gjQ9QXIlJd1Re96mhcad5VzAjPf0ZZWRorCdcjZFyv2mTHKXT7J5wH2zMlXL6yoVPaiowU/4BtNwTOH6cV6PjA9TTF78jD31kT9vwHGlgWUdP1maPAhFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759982729; c=relaxed/simple;
	bh=xjlXyNzweTphr53X5O8tkUBaWVB6foeIAr0SK4gcz8M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rBsZ4Df0YuuqkEArHBdXZ3+vPp1IOSE8/sdIgXHTksfplJRHrQ71eDAVR6L+RmSWbKtE5cqCCiY0PruCmA5BPCUh1CRHO9bflk0E2aEiehyJwn0ff6COZWy/Vk9t3ZQ7+jwcDPG5O1HW5GzAoFWSe0Zyxy7fexErGPH+Xxk4D9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mAuNQ3U1; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759982723; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=iOOytkRlRyd08DE1xcHe9XEAQpgq3PU8oBwXXY1s9+g=;
	b=mAuNQ3U13XBzldjZLMhlQwhA85nL6Xvr/lppXliO7bOevwn9/YsRuJsaQz152LpUMmIEf3lcl/+TsxCWNj8nvZNjoum0ssE/tsqD3xvEVlbHSo2P4uYpJm+ciX4Vb8/PVwgmZat0wwNgztQQjfPTXrxJ8G/CoXe60FqJSrV1GmE=
Received: from L-G4162440-1116.localdomain(mailfrom:yadong.qi@linux.alibaba.com fp:SMTPD_---0WphgtMN_1759982404 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 09 Oct 2025 12:00:06 +0800
From: Yadong Qi <yadong.qi@linux.alibaba.com>
To: akpm@linux-foundation.org,
	urezki@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ying.huang@linux.alibaba.com
Cc: Yadong Qi <yadong.qi@linux.alibaba.com>
Subject: [PATCH] mm: vmalloc: BUG_ON if mapping size is not PAGE_SIZE aligned
Date: Thu,  9 Oct 2025 11:59:43 +0800
Message-Id: <20251009035943.526-1-yadong.qi@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mm/vmalloc.c, the function vmap_pte_range() assumes that the
mapping size is aligned to PAGE_SIZE. If this assumption is
violated, the loop will become infinite because the termination
condition (`addr != end`) will never be met. This can lead to
overwriting other VA ranges and/or random pages physically follow
the page table.

It's the caller's responsibility to ensure that the mapping size
is aligned to PAGE_SIZE. However, the memory corruption is hard
to root cause. To identify the programming error in the caller
easier, check whether the mapping size is PAGE_SIZE aligned with
BUG_ON().

Signed-off-by: Yadong Qi <yadong.qi@linux.alibaba.com>
Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>
---
 mm/vmalloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 5edd536ba9d2..b54d3ee6b202 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -100,6 +100,8 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	struct page *page;
 	unsigned long size = PAGE_SIZE;
 
+	BUG_ON(!PAGE_ALIGNED(end - addr));
+
 	pfn = phys_addr >> PAGE_SHIFT;
 	pte = pte_alloc_kernel_track(pmd, addr, mask);
 	if (!pte)
-- 
2.43.5


