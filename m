Return-Path: <linux-kernel+bounces-856104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5CABE317F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A0B58815A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD0B301482;
	Thu, 16 Oct 2025 11:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="BWk3T7by"
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227C4288D0
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614405; cv=none; b=H5yNtU1kKrxlZQuOvE38lW64TTCUp40fUzZ0ZxfO/MtLOvwo58pUStgFpAMWwAhQiqOMMeV9fO2cCtcrpsJ9CPMyhZzlPxTflFrJMxAjp+s6F1Q1aGeIrhWWvDebZ1WosSniBRfgi/bX+zuPZe3WTglMptCULETcz2cc9YDLmHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614405; c=relaxed/simple;
	bh=fivSAJPJsuW+aT7Tpj6jE6r8159ItaVXK1uRnhNuCvo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AgejGgG2W1EERfEEjKiwZ6ZW7u+cCQ/ezZJjyM7+dgOSH2Q5rBT3qmyZWaevao+jW7bRzCkkIoFmnHTqLJLtbj+KbGR4IltB43nNa77ESnjCBI5/mrP+xXvSVXxFOFf8oMpwHP34hP2zFziNrqywWcSFxBRxlmirWSWvSlcWHBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=BWk3T7by; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=0UKd0DgpGQsGYxSRnc1QTa5DFfPy1+JMKOudjICLDX4=;
	b=BWk3T7by4Gqj6OH9NWVZDbjq67GSZ67jdcwjlCLfysKIlZ6nT28rytCDkXZkicX7CT0rbn/tS
	lubE/MwlGBKZNPisd5GKxP+wJium1FsiwU5ziGQ+MxNI+PuBCfL6WcCFFVJ1Kv5X1ftct8FAuaS
	I+wpLZQc4YLs256mo1Ph1vc=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4cnQlw3KzPzcb4M;
	Thu, 16 Oct 2025 19:32:12 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id C1772140257;
	Thu, 16 Oct 2025 19:33:12 +0800 (CST)
Received: from huawei.com (10.50.87.63) by kwepemr500001.china.huawei.com
 (7.202.194.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 16 Oct
 2025 19:33:11 +0800
From: Yin Tirui <yintirui@huawei.com>
To: <akpm@linux-foundation.org>, <david@redhat.com>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>, <ziy@nvidia.com>,
	<baolin.wang@linux.alibaba.com>, <npache@redhat.com>, <ryan.roberts@arm.com>,
	<dev.jain@arm.com>, <baohua@kernel.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <anshuman.khandual@arm.com>,
	<yangyicong@hisilicon.com>, <ardb@kernel.org>, <willy@infradead.org>,
	<apopple@nvidia.com>, <samuel.holland@sifive.com>,
	<luxu.kernel@bytedance.com>, <abrestic@rivosinc.com>,
	<yongxuan.wang@sifive.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>
CC: <wangkefeng.wang@huawei.com>, <chenjun102@huawei.com>,
	<yintirui@huawei.com>
Subject: [PATCH RFC v2 0/2] mm: add huge pfnmap support for remap_pfn_range()
Date: Thu, 16 Oct 2025 19:27:02 +0800
Message-ID: <20251016112704.179280-1-yintirui@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr500001.china.huawei.com (7.202.194.229)

v2:
- remove "nohugepfnmap" boot option and "pfnmap_max_page_shift" variable.
- zap_deposited_table for non-special pmd.
- move set_pmd_at() inside pmd_lock.
- prevent PMD mapping creation when pgtable allocation fails.
- defer the refactor of pte_clrhuge() to a separate patch series. For now,
  add a TODO to track this.

v1: https://lore.kernel.org/linux-mm/20250923133104.926672-1-yintirui@huawei.com/

Overview
========
This patch series adds huge page support for remap_pfn_range(),
automatically creating huge mappings when prerequisites are satisfied
(size, alignment, architecture support, etc.) and falling back to
normal page mappings otherwise.

This work builds on Peter Xu's previous efforts on huge pfnmap
support [0].

TODO
====
- Add PUD-level huge page support. Currently, only PMD-level huge
pages are supported.
- Consider the logic related to vmap_page_range and extract
reusable common code.
- Refactor pte_clrhuge() and related functions.

Tests Done
==========
- Cross-build tests.
- Performance tests with custom device driver implementing mmap()
  with remap_pfn_range():
    - lat_mem_rd benchmark modified to use mmap(device_fd) instead of
      malloc() shows around 40% improvement in memory access latency with
      huge page support compared to normal page mappings.

      numactl -C 0 lat_mem_rd -t 4096M (stride=64)
      Memory Size (MB)    Without Huge Mapping With Huge Mapping Improvement
      ----------------    -----------------    --------------    -----------
      64.00               148.858 ns           100.780 ns        32.3%
      128.00              164.745 ns           103.537 ns        37.2%
      256.00              169.907 ns           103.179 ns        39.3%
      512.00              171.285 ns           103.072 ns        39.8%
      1024.00             173.054 ns           103.055 ns        40.4%
      2048.00             172.820 ns           103.091 ns        40.3%
      4096.00             172.877 ns           103.115 ns        40.4%

    - Custom memory copy operations on mmap(device_fd) show around 18% performance 
      improvement with huge page support compared to normal page mappings.

      numactl -C 0 memcpy_test (memory copy performance test)
      Memory Size (MB)    Without Huge Mapping With Huge Mapping Improvement
      ----------------    -----------------    --------------    -----------
      1024.00             95.76 ms             77.91 ms          18.6%
      2048.00             190.87 ms            155.64 ms         18.5%
      4096.00             380.84 ms            311.45 ms         18.2%

[0] https://lore.kernel.org/all/20240826204353.2228736-2-peterx@redhat.com/T/#u

Yin Tirui (2):
  pgtable: add pte_clrhuge() implementation for arm64 and riscv
  mm: add PMD-level huge page support for remap_pfn_range()

 arch/arm64/include/asm/pgtable.h |  8 +++++++
 arch/riscv/include/asm/pgtable.h |  5 ++++
 include/linux/pgtable.h          |  6 ++++-
 mm/huge_memory.c                 | 26 +++++++++++++++------
 mm/memory.c                      | 40 ++++++++++++++++++++++++++++++++
 5 files changed, 77 insertions(+), 8 deletions(-)

-- 
2.43.0


