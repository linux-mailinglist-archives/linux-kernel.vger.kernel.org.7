Return-Path: <linux-kernel+bounces-888934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573F4C3C548
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A868561275
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D1934C80D;
	Thu,  6 Nov 2025 16:09:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526372BDC33
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445397; cv=none; b=af95+NfqtM0WqESG5xb1JTlyITncWqrO/Hh0bdv4tyrlfI/SsA9Ws1Jns2F/CCdegnbbILmDu33aswOWpVdGUmqkjSAxeReTv3HKdNaijIccLTFKM8srGO8YdfF+aOOcv1xJhuN8D6qDCvPi4Vy6FE+6hxEuqshNJzqfufYwkd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445397; c=relaxed/simple;
	bh=x0JpCqPA8G2fStCRWVP+nZ28qUGJQq7jd6SYVXE2KkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EZ0TvztFPefFt8aO0hvm3Lb7Afbu7/I0WVTQeJgAi3iD7tiVtIxQBgSzAQ/7JAVVFea9BLYDh+R4Q2tpB2jaT/PTAWXyMP2l4J9PszbyKSVa9y82eCiAjzPPbLEa7PYAJiT+0me1KLJY8XCgsW/QUjChtsN6721IL2PPBTu7J2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5E2F15A1;
	Thu,  6 Nov 2025 08:09:47 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35BA33F66E;
	Thu,  6 Nov 2025 08:09:54 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	yang@os.amperecomputing.com,
	david@redhat.com,
	ardb@kernel.org,
	dev.jain@arm.com,
	scott@os.amperecomputing.com,
	cl@gentwo.org
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Don't sleep in split_kernel_leaf_mapping() when in atomic context
Date: Thu,  6 Nov 2025 16:09:40 +0000
Message-ID: <20251106160945.3182799-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Will,

This is v2 of the fix for split_kernel_leaf_mapping(). I've expanded it into 3
patches based on feedback from v1 [1].

Once happy with the content, patch 1 is needed urgently for next -rc to fix
regression since 6.18-rc1. The other patches could wait until 6.19, but I'd
prefer they all go together into 6.18.

Changes since v1 [1]
====================

Patch 1: The fix
  - Removed arch_kfence_init_pool() declaration for !KFENCE case (per Will)
  - Removed lazy mode mmu optimization (now separate patch) (per Will)
  - Simplified arch_kfence_init_pool() return expression (per Will)
  - Added comment about not needing tlbi
  - Generalized comment softirq -> atomic (per Yang Shi)
Patch 2: lazy mode mmu optimization (per Will)
Patch 3: force_pte_mapping() tidy ups (per David)

[1] https://lore.kernel.org/linux-arm-kernel/20251103125738.3073566-1-ryan.roberts@arm.com/

Thanks,
Ryan


Ryan Roberts (3):
  arm64: mm: Don't sleep in split_kernel_leaf_mapping() when in atomic
    context
  arm64: mm: Optimize range_split_to_ptes()
  arm64: mm: Tidy up force_pte_mapping()

 arch/arm64/include/asm/kfence.h |   3 +-
 arch/arm64/mm/mmu.c             | 111 +++++++++++++++++++++++---------
 2 files changed, 81 insertions(+), 33 deletions(-)

--
2.43.0


