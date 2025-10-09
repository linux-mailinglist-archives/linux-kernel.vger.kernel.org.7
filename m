Return-Path: <linux-kernel+bounces-846303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7DCBC783C
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 08:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 744B44E389B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 06:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307EA293C44;
	Thu,  9 Oct 2025 06:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iHq41S/L"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BDA824BD
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 06:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759990460; cv=none; b=Hv2molI7j2wCUn3w9QV0BNI2JaEpEVgg4+4yS4UN7T+aaY4UIFLd/BdqqxaG5ZKLJcp2zWWqGWbRl7z744Cnr6WSqDGwSWfVO+NUEojjCzfO70eGZJ1ycHKsUoE/FOQml/HdZ7aQsiYLS8rgZBMI9LBWXooAleOc+HvjpIHupQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759990460; c=relaxed/simple;
	bh=qq9G6ptAeIxt70paYj9Z2BrgIzZl6U6KpvLzWgh1qdc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K+erYKpw5iJ7hookfjWcUAw7C4fSGLjG8r2q1rkCLZCWxklCq9NBWxZPd3ximIt+pyBRbSLWc7MO956TaTmUPeQqkUW9E90y53w0qFgwJEIcZFGUp2XdsAUHe+zKtDuU5fsOpeJTyGEXE/4Ns1O2PI7Ld6YIJxg1i2OFQPD+228=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iHq41S/L; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759990454; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=NXYc6/PKgby/hjSOUXr+j/JxsLAfBHlg+MJvQuL10CI=;
	b=iHq41S/LL7htdqbxBlvKPqQcPTkylJk5cKJsrzw7G+c/Fr//dj8NIQev8WnleLtanCB9+N9/vBswaBA1xcSusBZCgGPEJ6XnX5aR+mqaNi7fss3AOEaQK9ikcMlUX0UgI8yLNd15oywdA7HXKyLzvpk5HeeF87SntEihBk/D9Og=
Received: from L-G4162440-1116.localdomain(mailfrom:yadong.qi@linux.alibaba.com fp:SMTPD_---0WpjGzvk_1759990452 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 09 Oct 2025 14:14:13 +0800
From: Yadong Qi <yadong.qi@linux.alibaba.com>
To: akpm@linux-foundation.org,
	urezki@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ying.huang@linux.alibaba.com
Cc: Yadong Qi <yadong.qi@linux.alibaba.com>
Subject: [PATCH v2] mm: vmalloc: WARN_ON if mapping size is not PAGE_SIZE aligned
Date: Thu,  9 Oct 2025 14:14:10 +0800
Message-Id: <20251009061410.820-1-yadong.qi@linux.alibaba.com>
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
WARN_ON().

Signed-off-by: Yadong Qi <yadong.qi@linux.alibaba.com>
Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>
---
v1 -> v2:
  * Use WARN_ON instead of BUG_ON
---
 mm/vmalloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 5edd536ba9d2..2cad593e4677 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -100,6 +100,9 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	struct page *page;
 	unsigned long size = PAGE_SIZE;
 
+	if (WARN_ON(!PAGE_ALIGNED(end - addr)))
+		return -ENOMEM;
+
 	pfn = phys_addr >> PAGE_SHIFT;
 	pte = pte_alloc_kernel_track(pmd, addr, mask);
 	if (!pte)
-- 
2.43.5


