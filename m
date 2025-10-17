Return-Path: <linux-kernel+bounces-857275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C006FBE6624
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A97F353572
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 05:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3A130C635;
	Fri, 17 Oct 2025 05:14:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3769A10F2
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760678097; cv=none; b=Dkp33C0J5GYlhqylq66WhMws2X8p2w1+7qsU/WlqH4pmm8NjPtu/mZk241rQ6ORB3Tbe33ajg9Ip++TGy7G5VgR/II1mA8ki1Hoj7xZZflBKA/rObTr44NQIYGkLIGLi2TAw8XZ2MS1Y/OZSVYz2d1gdhTcxRxDIKcuuVAaaavY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760678097; c=relaxed/simple;
	bh=STw4I+HPXnnAx2cIqNYi3Pw9RTxFxwI7kuSkltaJtns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OS7f7XgkqU/jaSSqXeTR8EDYybpUcZzx2usqfu6eFauilpeg1jwj5yv8G1GJAF4RgPOz/ki+KeAaQYt+YC/Fq+cibafh+h5WZZeWyxXFQYI3KP2rCVcyFDVnwWzpHH1T5sDc+W7kMPSqq/TUKREHvCWDfzcBnIVZXVng7wL0wyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 391D0153B;
	Thu, 16 Oct 2025 22:14:46 -0700 (PDT)
Received: from a079125.blr.arm.com (a079125.arm.com [10.164.21.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 092BE3F66E;
	Thu, 16 Oct 2025 22:14:49 -0700 (PDT)
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
Subject: [PATCH v4 0/2] arm64/mm: prevent panic on -ENOMEM in arch_add_memory()
Date: Fri, 17 Oct 2025 10:44:35 +0530
Message-ID: <20251017051437.2836080-1-linu.cherian@arm.com>
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

v4:
Few trivial code readability improvements 

v3:
* Added a Fixes tag to patch 1 and CCed to stable
* Fixed a maybe-uninitialized case in alloc_init_pud
* Update  pgd_pgtable_alloc_init_mm to make use of
  pgd_pgtable_alloc_init_mm_gfp
  * Few other trivial cleanups

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



Chaitanya S Prakash (1):
  arm64/mm: Allow __create_pgd_mapping() to propagate pgtable_alloc()
    errors

Linu Cherian (1):
  arm64/mm: Rename try_pgd_pgtable_alloc_init_mm

 arch/arm64/mm/mmu.c | 220 ++++++++++++++++++++++++++++----------------
 1 file changed, 139 insertions(+), 81 deletions(-)

-- 
2.43.0


