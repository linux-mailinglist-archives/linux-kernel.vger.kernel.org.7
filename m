Return-Path: <linux-kernel+bounces-822419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9110BB83D2F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F01C11B2359D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5192213237;
	Thu, 18 Sep 2025 09:35:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC8F2582
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758188111; cv=none; b=m5Fg8Wche4TmFW0maCf190XpW4CP9d14NYAEVO8/8yKfdTJkwEgk09T71XNmMycHHfkVRcF8T18+ApmhB9tubqyS+hDeOYaHn4tHfF7eWpx+7GOr10Soh+MT/HxWS2WCn2jllA5ENm+Pe8sqrvrEtp5fwsZ4Fww5fyn0hlAiFnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758188111; c=relaxed/simple;
	bh=lfgNhsozgwxxE7MtLz4AFbDINaLpcnrIVipBRyVeSX4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q06hMGwVYDzXyfr43J84vr7ehBm2kLtggnK8PWKhIm7kXrGh191C9az3vMwU0z4zOqMmSYS4NNmP5uVlaBtBe2cwmWx+LrpyJxTfxd0bNc2vhAAP0trsBYXUUx2dZV+M1QuHpP37uHzz/yXX/aphMLwqU//vz2NOd7tY84LhcYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25DEF1A32;
	Thu, 18 Sep 2025 02:34:55 -0700 (PDT)
Received: from MacBook-Pro.blr.arm.com (MacBook-Pro.blr.arm.com [10.164.18.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2D2033F66E;
	Thu, 18 Sep 2025 02:35:00 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org
Cc: rppt@kernel.org,
	ryan.roberts@arm.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH] mm: Remove PMD alignment constraint in execmem_vmalloc()
Date: Thu, 18 Sep 2025 15:04:53 +0530
Message-Id: <20250918093453.75676-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using vmalloc with VM_ALLOW_HUGE_VMAP flag, it will set the alignment
to PMD_SIZE internally, if it deems huge mappings to be eligible.
Therefore, setting the alignment in execmem_vmalloc is redundant. Apart
from this, it also reduces the probability of allocation in case vmalloc
fails to allocate hugepages - in the fallback case, vmalloc tries to use
the original alignment and allocate basepages, which unfortunately will
again be PMD_SIZE passed over from execmem_vmalloc, thus constraining
the search for a free space in vmalloc region.

Therefore, remove this constraint.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
mm-selftests pass, but I am not sure if they touch execmem code, and I
have no experience with this code.

 mm/execmem.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/execmem.c b/mm/execmem.c
index 0822305413ec..810a4ba9c924 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -38,9 +38,6 @@ static void *execmem_vmalloc(struct execmem_range *range, size_t size,
 	if (kasan)
 		vm_flags |= VM_DEFER_KMEMLEAK;
 
-	if (vm_flags & VM_ALLOW_HUGE_VMAP)
-		align = PMD_SIZE;
-
 	p = __vmalloc_node_range(size, align, start, end, gfp_flags,
 				 pgprot, vm_flags, NUMA_NO_NODE,
 				 __builtin_return_address(0));
-- 
2.30.2


