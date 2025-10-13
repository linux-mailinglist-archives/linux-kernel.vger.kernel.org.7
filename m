Return-Path: <linux-kernel+bounces-850112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6196DBD1E95
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 029BE4ED127
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5284F2EB85B;
	Mon, 13 Oct 2025 08:03:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0772EB5CF
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760342584; cv=none; b=QfpRbrTFQE9UpE+U7WKFmassCCltXfTE0UrE1kRtleqQUtIL1MfdoLR3Xef/HDafuTBvZHrVOvBi/05EfBnZy7b1Sst3adOXOoK8NWLrHUohlq2hyBehNk3kMvZ2z/9mI3JioY72C5/6PUnlZQ//kUldpjZRII1J7RTCdyzK2Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760342584; c=relaxed/simple;
	bh=gnGSvgyDLVQuEFjMaO53vFu4pCihGel2u56YRK8b2ho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OSwBhyEhhtxVFQjRqN2fZ9RsnC393+AZMuqx8h/pWgsVXUD5kb4g6+qL0nu66mf7uwITswGt6fHVWC/0aBrnHvMMIQLsHLDKXG/P7l9+gDcyommobNJhCe5n040T9yjxpHa5Vc+zpdbuPu8FGrZGA6lZ2uNAeDYNDTiqAwYlmxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7E9712FC;
	Mon, 13 Oct 2025 01:02:51 -0700 (PDT)
Received: from a079125.blr.arm.com (a079125.arm.com [10.164.21.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 93C713F738;
	Mon, 13 Oct 2025 01:02:55 -0700 (PDT)
From: Linu Cherian <linu.cherian@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Zhenhua Huang <quic_zhenhuah@quicinc.com>,
	Dev Jain <dev.jain@arm.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Linu Cherian <linu.cherian@arm.com>
Subject: [PATCH v2 0/2] arm64/mm: prevent panic on -ENOMEM in arch_add_memory()
Date: Mon, 13 Oct 2025 13:32:18 +0530
Message-ID: <20251013080220.2027757-1-linu.cherian@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch_add_memory() acts as a means to hotplug memory into a system. It
invokes __create_pgd_mapping() which further unwinds to call
pgtable_alloc(). Initially, this path was only invoked during early boot
and therefore it made sense to BUG_ON() in case pgtable_alloc() failed.
Now however, we risk running into a kernel crash if we try to hotplug
memory into a system that is already extremely tight on available
memory. This is undesirable and hence __create_pgd_mapping() and it's
helpers are reworked to be able to propagate the error from
pgtable_alloc() allowing the system to fail gracefully.

Keeping in mind that it is still essential to BUG_ON()/panic if
pgtable_alloc() encounters failure at the time of boot, a wrapper is
created around __create_pgd_mapping() which is designed to panic() if
it encounters a non-zero return value. This wrapper is then invoked from
the init functions instead of __create_pgd_mapping(), thereby keeping the
original functionality intact.

This theoretical bug was identified by Ryan Roberts<ryan.roberts@arm.com>
as a part of code review of the following series[1].

[1] https://lore.kernel.org/linux-arm-kernel/20250304222018.615808-4-yang@os.amperecomputing.com/


Changelog

v2:
* With cleanup merged as part of, "arm64: mm: Move KPTI helpers to mmu.c"
  changes in patch 2(v1) got much simplified and squashed to patch 1 itself.
* Patch 2 now does a trivial renaming for better readability 
* Make use of INVALID_PHYS_ADDR for error checks instead of 0.  
* Do early function return where we do not have any
  common cleanup in return path
* Remove redundant variable initialization
* Changed BUG_ON to panic
* Renamed ___create_pgd_mapping to early_create_pgd_mapping  

This series is now rebased to linux-6.18-rc1.

I will be taking the stewardship for this patch series, as Chaitanya
has left Arm.

Thanks,
Linu Cherian.

Chaitanya S Prakash (1):
  arm64/mm: Allow __create_pgd_mapping() to propagate pgtable_alloc()
    errors

Linu Cherian (1):
  arm64/mm: Rename try_pgd_pgtable_alloc_init_mm

 arch/arm64/mm/mmu.c | 208 ++++++++++++++++++++++++++++----------------
 1 file changed, 132 insertions(+), 76 deletions(-)

-- 
2.43.0


