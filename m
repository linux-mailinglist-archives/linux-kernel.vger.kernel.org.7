Return-Path: <linux-kernel+bounces-860977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD42BF17FE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B37824F498C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C502F83B5;
	Mon, 20 Oct 2025 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="sBoDEBcN"
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D64BA3F
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760966230; cv=none; b=nFDeoIGFsSYDzoap9FL68Of4UB1dloZOrQx32hWa0XbPBPc98AuvLtMMLo0l2mn8LtVKYN/Fh7jytC4HC24DCztM5ZFTTg34qiD+WoKsSx/zeA2t6FQwoK4EtRBONkgdaLcU/rqtN6uhBy9hgIvaML1WDi2IukjlWL9GrD6X9Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760966230; c=relaxed/simple;
	bh=giL7ugC8LhkM3cgdx95BqZg4mS5Q2TRYU55glzIE/NU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r12FLmSAdwl1xLkyivCWgLcR2qHSNtVbB2pOQN8D+Sg76wQOHsqF0cV6vPoGzFd98Ag200PcGX79ontTl4eml4Sd0xAhTQHYT47CFg7XF/h7YffgqjTBEFgv7oqvc0TQ0IwnPoi66K4BE5/xKRUM+4M3zZcQrYMnPYbnwR7+aqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=sBoDEBcN; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=NqM/TU8fgmRhRSb4lgSilTbi4JKDDbvpivBHoO1W22c=;
	b=sBoDEBcNPEuwU+GcqRWnWLh2o2f72PRe9xkyN0FBAgrnB+6wFSXybovQ/lOUnWmf489crlSbA
	6ZdSnVTL7mJ4T38HOdYzgoR1+Og0dvNymYHtLQk1JPQeaXKrhDAlGasZa7y0A9tjOOJDtdcYv/1
	1gYFG52Qe/Vn/W/lC+CHm7o=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4cqwsk2vMBzcZyT;
	Mon, 20 Oct 2025 21:15:54 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 2C521180488;
	Mon, 20 Oct 2025 21:17:02 +0800 (CST)
Received: from huawei.com (10.50.85.135) by dggpemf200018.china.huawei.com
 (7.185.36.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 20 Oct
 2025 21:17:01 +0800
From: Quanmin Yan <yanquanmin1@huawei.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yanquanmin1@huawei.com>, <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
Subject: [PATCH v2 0/2] mm/damon: fixes for address alignment issues in DAMON_LRU_SORT and DAMON_RECLAIM
Date: Mon, 20 Oct 2025 21:01:23 +0800
Message-ID: <20251020130125.2875164-1-yanquanmin1@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf200018.china.huawei.com (7.185.36.31)

In DAMON_LRU_SORT and DAMON_RECLAIM, damon_set_regions() will apply
DAMON_MIN_REGION as the core address alignment, and the monitoring
target address ranges would be aligned on DAMON_MIN_REGION * addr_unit.
When users 1) set addr_unit to a value larger than 1, and 2) set the
monitoring target address range as not aligned on DAMON_MIN_REGION *
addr_unit, it will cause DAMON_LRU_SORT and DAMON_RECLAIM to operate
on unexpectedly large physical address ranges.

For example, if the user sets the monitoring target address range to
[4, 8) and addr_unit as 1024, the aimed monitoring target address range
is [4 KiB, 8 KiB). Assuming DAMON_MIN_REGION is 4096, so resulting
target address range will be [0, 4096) in the DAMON core layer address
system, and [0, 4 MiB) in the physical address space, which is an
unexpected range.

To fix the issue, add a min_sz_region parameter to
damon_set_region_biggest_system_ram_default() and use it when calling
damon_set_regions(), replacing the direct use of DAMON_MIN_REGION.

Changes from v1
(https://lore.kernel.org/all/20251016104717.2194909-1-yanquanmin1@huawei.com/)
- Added more issue description in the commit message.
- Split the original fix patch into two separate patches.

Quanmin Yan (2):
  mm/damon: add a min_sz_region parameter to
    damon_set_region_biggest_system_ram_default()
  mm/damon/reclaim: use min_sz_region for core address alignment when
    setting regions

 include/linux/damon.h | 3 ++-
 mm/damon/core.c       | 6 ++++--
 mm/damon/lru_sort.c   | 3 ++-
 mm/damon/reclaim.c    | 3 ++-
 mm/damon/stat.c       | 3 ++-
 5 files changed, 12 insertions(+), 6 deletions(-)

-- 
2.43.0


