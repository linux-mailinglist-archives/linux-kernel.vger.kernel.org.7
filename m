Return-Path: <linux-kernel+bounces-826011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B17B8D54D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 07:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92FA4189E691
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 05:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D75271456;
	Sun, 21 Sep 2025 05:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cl8tO/bR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A266422A4E8
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 05:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758433506; cv=none; b=uKnDXw1C8ZDBFzOvLfOs33ajyvcwEvCmbGNudZv9PAppDzT1cz1posVt2oElBu24tqGlRpNeIGztYj1jyZ4LZc8IBbrVtku0W1poOoP+tibBBt6wHIkx0HFPC4dwh/RjeU6U4yWAa9+1cm1snlXNEcHCFO6iNB7g4e8r7EfbF3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758433506; c=relaxed/simple;
	bh=nwWluE/HYzt54TgZr7bT7uoFJDOTM+N37KaOXrsGYlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eC4G/zTf71Nxf6XGUgznGkVL46CU4MroUmrNO1d0lBm/pcXk0N1NGthNwiiuwJhYb6TL1UuTyzBhyFK/iacNztABeSn9Erf6QaIqBOXfLNGQI51pKypPmWj2sZchDdFwxGw8r6RVBlaDDVR7FPS2KDcDKpO7IDmcjUQZyGj1CdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cl8tO/bR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA553C4CEE7;
	Sun, 21 Sep 2025 05:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758433506;
	bh=nwWluE/HYzt54TgZr7bT7uoFJDOTM+N37KaOXrsGYlQ=;
	h=From:To:Cc:Subject:Date:From;
	b=cl8tO/bRb/V9ewUSs4La8qYHpF4Z3+KoUTgHWBULmErJDhTF7Ix/56fjyZ5NbYHey
	 Yzzv4ucletwMmo+1u31sQpVt8TR4cPkcSaFdi6i3+UlzIFYCuNHoOkfYcZhA3YpH/5
	 BbbChUN7TmVGwECjW8b1FtMXzpt2PEbWepqoBSqCLctJleGlZcu3U1krwxKmx32cFm
	 E/A9FM2fVN+MK/GVLAlqOcSOSwPjMLVD4vTs9rJ1+vIh+oFqMrV0KvQprMriZcXnqS
	 JE03KZoBV7XjhxPmqc2RJtDfVItMEFhdO0cl2LUIYyWRII2eFJ7gW6mPIahoOwP6rC
	 I65J0fb9eQJRg==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Graf <graf@amazon.com>,
	Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Chris Li <chrisl@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/4] kho: add support for preserving vmalloc allocations
Date: Sun, 21 Sep 2025 08:44:54 +0300
Message-ID: <20250921054458.4043761-1-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Hi,

Following the discussion about preservation of memfd with LUO [1] these
patches add support for preserving vmalloc allocations.

Any KHO uses case presumes that there's a data structure that lists
physical addresses of preserved folios (and potentially some additional
metadata). Allowing vmalloc preservations with KHO allows scalable
preservation of such data structures.

For instance, instead of allocating array describing preserved folios in
the fdt, memfd preservation can use vmalloc:

        preserved_folios = vmalloc_array(nr_folios, sizeof(*preserved_folios));
        memfd_luo_preserve_folios(preserved_folios, folios, nr_folios);
        kho_preserve_vmalloc(preserved_folios, &folios_info);

[1] https://lore.kernel.org/all/20250807014442.3829950-30-pasha.tatashin@soleen.com

v5 changes:
* rebase on mm-new of September 17
* use kho_restore_pages() in kho_restore_vmalloc(). Required to resolve
  a conflict with "kho: make sure page being restored is actually from KHO"
* use more descriptive local variable names in kho_restore_vmalloc()

v4: https://lore.kernel.org/all/20250917174033.3810435-1-rppt@kernel.org 
* rebase on mm-stable
* use 'struct kho_vmalloc' as preservation metadata instead of storing it in the first chunk
* separate KHO flags from VM_ flags
* unreserve vmalloc pages on error
* add checks for under- and overflow of preserved metadata

v3: https://lore.kernel.org/all/20250908103528.2179934-1-rppt@kernel.org
* rebase on mm-unstable

v2: https://lore.kernel.org/all/20250905131302.3595582-1-rppt@kernel.org
* support preservation of vmalloc backed by large pages
* add check for supported vmalloc flags and preserve the flags to be
  able to identify incompatible preservations
* don't use kho_preserve_phys()
* add kernel-doc

v1: https://lore.kernel.org/all/20250903063018.3346652-1-rppt@kernel.org

Mike Rapoport (Microsoft) (4):
  kho: check if kho is finalized in __kho_preserve_order()
  kho: replace kho_preserve_phys() with kho_preserve_pages()
  kho: add support for preserving vmalloc allocations
  lib/test_kho: use kho_preserve_vmalloc instead of storing addresses in
    fdt

 include/linux/kexec_handover.h |  33 ++-
 kernel/kexec_handover.c        | 361 +++++++++++++++++++++++++++++----
 lib/test_kho.c                 |  41 ++--
 mm/memblock.c                  |   4 +-
 4 files changed, 381 insertions(+), 58 deletions(-)


base-commit: c565f9816932dc8d164bd8c69acf077840565ce7
-- 
2.50.1


