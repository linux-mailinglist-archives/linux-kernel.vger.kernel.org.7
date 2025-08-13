Return-Path: <linux-kernel+bounces-766919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A89B24CC4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7867488825B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528EF2F83AA;
	Wed, 13 Aug 2025 14:56:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5F42EBDC6
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096980; cv=none; b=kXNtmfxVe83GHNxoD8WwW3XpwqFtm3p9Fenvr5cv20eDGgOlE1x5rTx+zFTSibWVZHvildzscAtsCobXBmRZ+54fV3ln1I7G5QMc6mC/o+B6bQGkSedvEUeiTAbDTAP+HSCPaOzQyfzigu9jIxKx+HkAjRaQMreStrjtbuD0KkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096980; c=relaxed/simple;
	bh=2lX+zeEeJrMEYKEPd43hsNwJ0msI2G7KNic7rXF5lwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ba4nOoF6X1uJh8E0U/TI/5RUQHnc1u6bIJXbR6e5h6TExAzzlvTiibPptsFBlGEAd6CzyxUJS77qZMPNYgQq+MIVHkhTdlFvkJMbe3jMjglRBtraCz0a+RexzRcmzeiNOF3t11XCbyvfRBIhD7aG5DYGYS8nbMZWefLqbNdOpnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE2FE19F0;
	Wed, 13 Aug 2025 07:56:09 -0700 (PDT)
Received: from a079125.blr.arm.com (a079125.arm.com [10.164.21.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3B0EC3F738;
	Wed, 13 Aug 2025 07:56:13 -0700 (PDT)
From: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zhenhua Huang <quic_zhenhuah@quicinc.com>,
	Joey Gouly <joey.gouly@arm.com>
Subject: [PATCH 0/2] arm64/mm: prevent panic on -ENOMEM in arch_add_memory() 
Date: Wed, 13 Aug 2025 20:26:05 +0530
Message-Id: <20250813145607.1612234-1-chaitanyas.prakash@arm.com>
X-Mailer: git-send-email 2.34.1
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

Keeping in mind that it is still essential to BUG_ON() if
pgtable_alloc() encounters failure at the time of boot, a wrapper is
created around __create_pgd_mapping() which is designed to BUG_ON() if
it encounters a non-zero return value. This wrapper is then invoked from
the init functions instead of __create_pgd_mapping(), thereby keeping the
original functionality intact.

Lastly, create_kpti_ng_temp_pgd() which originally acted as an alias for
the void returning __create_pgd_mapping_locked() has now been updated
accordingly to handle the return value and BUG_ON() if needed.

This theoretical bug was identified by Ryan Roberts<ryan.roberts@arm.com>
as a part of code review of the following series[1].

[1] https://lore.kernel.org/linux-arm-kernel/20250304222018.615808-4-yang@os.amperecomputing.com/

Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Kevin Brodsky <kevin.brodsky@arm.com> 
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
Cc: linux-arm-kernel@lists.infradead.org 
Cc: linux-kernel@vger.kernel.org

Chaitanya S Prakash (2):
  arm64/mm: Allow __create_pgd_mapping() to propagate pgtable_alloc()
    errors
  arm64/mm: Update create_kpti_ng_temp_pgd() to handle pgtable_alloc
    failure

 arch/arm64/mm/mmu.c | 174 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 133 insertions(+), 41 deletions(-)

-- 
2.34.1

