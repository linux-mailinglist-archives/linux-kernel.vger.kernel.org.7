Return-Path: <linux-kernel+bounces-853874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD24BDCCE5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E048B192858E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A823C3128DD;
	Wed, 15 Oct 2025 06:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0wHAfwA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4FF21A447;
	Wed, 15 Oct 2025 06:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760510887; cv=none; b=qajwLWqKC64+VGtnI/mL/nSSbQgqIjfjHD/uJf/jKGxFFYdK9NcmQofq8xui/H5FzKikz3JJLm2r3HwXY9UICbL4dgjWHyuOisNNeFSxQcdNPkhFjjOPl1vNotLchiESmGKJXGHlFOGpTwJZ0OyGQxu8TcmOYpttT2tyx9oJ56g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760510887; c=relaxed/simple;
	bh=KsS5xOABSmfYlcnL3VQZQMNjTjI7cwu4YVwYjCn92OA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AT29Xvjnpwn7dOKLMpNslrrPq6fXdY50IlOFWfFVJEmM9h67xc7g5tR22Dm3o/I31s6zx1/yOx6GXUFwWSgnE6zBb8pZ59ol8ffkRhA/keoKLQ3m/thNg8EexHGgZytMQepWa7ceS9wBwAlg1xvCiaeqpw6CYYeEFZaSDymZICw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0wHAfwA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969C8C4CEF8;
	Wed, 15 Oct 2025 06:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760510885;
	bh=KsS5xOABSmfYlcnL3VQZQMNjTjI7cwu4YVwYjCn92OA=;
	h=From:To:Cc:Subject:Date:From;
	b=H0wHAfwAl2ndFvoBLhKGlFMfpkrM0jMYEW5g6hug4b7UZJbAHauYJRwrfPcY5jOFJ
	 /DJ3t2/dzM513Acoa8EuBLs+FuWhRHliZhdkVDs4wPnL7YT+RztWqHA2E44RCkciHV
	 fs5T6YQ5K60utS5sKl/KT/TANSZXTjt4GSKKHh5N49NtIMKCm4J8GESHv+OtJxoppn
	 iK62a9DQbOT4djJb3Jt/wvP/vlxRGkMOXuUyH/+DBgYoU7A1eRRr9GKB5Uw/RvQaBo
	 h9/jbmb4iLWjVUolQ3zmcoPMI5+xRCgvKtr2CLjm8JxRpt/DTiYTQ+9jb18aewwMWi
	 a3bvG+mV0ceMw==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Guo Ren <guoren@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	linux-csky@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] csky/mm: fix build errors cause by folio flags changes
Date: Wed, 15 Oct 2025 09:47:59 +0300
Message-ID: <20251015064759.2993842-1-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Kernel compilation on csky fails because csky was not updated during
conversion of folio flags to memdesc_flags_t:

arch/csky/abiv2/inc/abi/cacheflush.h: In function 'flush_dcache_folio':
arch/csky/abiv2/inc/abi/cacheflush.h:23:39: error: passing argument 2 of 'const_test_bit' from incompatible pointer type [-Werror=incompatible-pointer-types]
   23 |         if (test_bit(PG_dcache_clean, &folio->flags))
      |                                       ^~~~~~~~~~~~~
      |                                       |
      |                                       memdesc_flags_t *
include/linux/bitops.h:47:24: note: in definition of macro 'bitop'
   47 |          const##op(nr, addr) : op(nr, addr))
      |                        ^~~~
arch/csky/abiv2/inc/abi/cacheflush.h:23:13: note: in expansion of macro 'test_bit'
   23 |         if (test_bit(PG_dcache_clean, &folio->flags))
      |             ^~~~~~~~

Update references of folio->flags in arch/csky.

Fixes: 53fbef56e07d ("mm: introduce memdesc_flags_t")
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/csky/abiv2/cacheflush.c         | 2 +-
 arch/csky/abiv2/inc/abi/cacheflush.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/csky/abiv2/cacheflush.c b/arch/csky/abiv2/cacheflush.c
index 876028b1083f..064b0f0f95ca 100644
--- a/arch/csky/abiv2/cacheflush.c
+++ b/arch/csky/abiv2/cacheflush.c
@@ -21,7 +21,7 @@ void update_mmu_cache_range(struct vm_fault *vmf, struct vm_area_struct *vma,
 
 	folio = page_folio(pfn_to_page(pfn));
 
-	if (test_and_set_bit(PG_dcache_clean, &folio->flags))
+	if (test_and_set_bit(PG_dcache_clean, &folio->flags.f))
 		return;
 
 	icache_inv_range(address, address + nr*PAGE_SIZE);
diff --git a/arch/csky/abiv2/inc/abi/cacheflush.h b/arch/csky/abiv2/inc/abi/cacheflush.h
index 6513ac5d2578..da51a0f02391 100644
--- a/arch/csky/abiv2/inc/abi/cacheflush.h
+++ b/arch/csky/abiv2/inc/abi/cacheflush.h
@@ -20,8 +20,8 @@
 
 static inline void flush_dcache_folio(struct folio *folio)
 {
-	if (test_bit(PG_dcache_clean, &folio->flags))
-		clear_bit(PG_dcache_clean, &folio->flags);
+	if (test_bit(PG_dcache_clean, &folio->flags.f))
+		clear_bit(PG_dcache_clean, &folio->flags.f);
 }
 #define flush_dcache_folio flush_dcache_folio
 

base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.50.1


