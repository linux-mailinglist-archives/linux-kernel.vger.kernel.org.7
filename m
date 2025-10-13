Return-Path: <linux-kernel+bounces-850214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 35464BD2401
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9FFF4EF40D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC71F2FD1C5;
	Mon, 13 Oct 2025 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="K7Dm17XO"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38142FD7B1
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760347296; cv=none; b=C2Ia8g07WwvzXisa/FkM7ugzb30ZguSfGT/vbC056xtZQTzWOKp9Z+TMGIF+BZztwURqKFqTTrVsu3QOYgQlSdLZOAxiPnCVDMmGWX+1AxPOJfdtXuQgO4LOlKLHgRhr5+YqSU5pSM3OPQWerK0+xhU0mBIXp5XH6fSwpsDNKps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760347296; c=relaxed/simple;
	bh=H6wowRT1+J+GbCh7C2Qhrsam12P+otN/GsvnEDaml0A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=azVviCLXKscY3VYXp8PFaBHclMxu11ZHzKf9We8HfMAMKESF1KXN3MxrA+S49hiUigvlTZmf7gSyiHyPSamK2x5XX0ABceLz2JbCUSIA08/Y9Eo9DXVGbghjps36vTz2retBXRApCOL127XeFb25ia9zinQ0rXEM1w6dnXU9JNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=K7Dm17XO; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760347286; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Y/97U6AgdiA5Dn3k47PnInPX3VlZycLa5fUP4muVjYE=;
	b=K7Dm17XOgoHRQYzScH9eDuZG43jkkOV+/EgjwNkkYFJqbqQKOGliumrarInaD8MJOdQdaQ+JwgHUR6BkWr5Gc4nW+BEn8jBUypF0M4AzJcH/YKIMg3sxXjyk8xOt/v5JmSg1R/26+8wU0Yv7kNVNkumvtPyIk66G9yt/nMjYDhs=
Received: from localhost.localdomain(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0Wq1niU9_1760347251 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 13 Oct 2025 17:21:24 +0800
From: Huang Ying <ying.huang@linux.alibaba.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>
Cc: Huang Ying <ying.huang@linux.alibaba.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	"Christoph Lameter (Ampere)" <cl@gentwo.org>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Yin Fengwei <fengwei_yin@linux.alibaba.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH -v2 0/2] arm, tlbflush: avoid TLBI broadcast if page reused in write fault
Date: Mon, 13 Oct 2025 17:20:36 +0800
Message-Id: <20251013092038.6963-1-ying.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is to optimize the system performance via avoiding TLBI
broadcast if page is reused in the write protect fault handler.  More
details of the background and the test results can be found in [2/2].

Changelog:

v2:

- Various code cleanup in [1/2], Thanks David's comments!
- Remove unnecessary __local_flush_tlb_page_nosync() in [2/2], Thanks Ryan's comments!
- Add missing contpte processing, Thanks Rayn and Catalin's comments!

Huang Ying (2):
  mm: add spurious fault fixing support for huge pmd
  arm64, tlbflush: don't TLBI broadcast if page reused in write fault

 arch/arm64/include/asm/pgtable.h  | 14 +++++---
 arch/arm64/include/asm/tlbflush.h | 56 +++++++++++++++++++++++++++++++
 arch/arm64/mm/contpte.c           |  3 +-
 arch/arm64/mm/fault.c             |  2 +-
 include/linux/pgtable.h           |  4 +++
 mm/huge_memory.c                  | 22 +++++++++---
 mm/internal.h                     |  4 +--
 7 files changed, 90 insertions(+), 15 deletions(-)

Best Regards,
Huang, Ying

