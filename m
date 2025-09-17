Return-Path: <linux-kernel+bounces-821420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B93BB8135B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9F581B27A0F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC482FF149;
	Wed, 17 Sep 2025 17:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kS1MQwyX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3A227E040
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 17:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758130841; cv=none; b=S8F8EjqYvGFWiB+oc0IDRVD5X/32VZ7rzw+w62C1n0+GU09//aj5URRBhoth9DuiW/vRGR/TzUkGiuDe9ZA6a7qfp52YNAGrt2ajkwEjx16edWlxaH+pOJVk9rvZHwhpbNzOgRJG8pVGgT4fgToPiba5ct/a6s2q3MBGoaQ/4S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758130841; c=relaxed/simple;
	bh=jOruTg3z11MGvKG41cspL9TY7zrdRzOtbVcIJxlzOvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PdDCd/jTjptLvBgycZRPeiv2zOwaj7b+r4JKky+duOFf/xnJ3dQB69/FHwSbJ/2qFtTI3Rhe6XhJotBVt8LDufrxICLVhjzg9EsdwkYIaLM8VcoLshPVLt3bLHc2bM0ZJY6+At3ynMwiEmVYHupY0YOGPyjyKm5DmIkOBrOyJ5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kS1MQwyX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D8AC4CEE7;
	Wed, 17 Sep 2025 17:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758130840;
	bh=jOruTg3z11MGvKG41cspL9TY7zrdRzOtbVcIJxlzOvE=;
	h=From:To:Cc:Subject:Date:From;
	b=kS1MQwyXK7ySaTIUsclw5N1elKou9v0wFY5bhhXUVm1Ppb+EMluIWv5yDaqpDvGlT
	 /9LbI/nX0xndD+WNdENmR/l5Y+gPjyyESTsaItA/5EVRpcsUfrKv5XtxBiyaukEERO
	 InKwMtgCmTeJGlM3ExTuc5QRvEa95Bc+qmhOGdmMicogyLGKlW9gvdOGDG/seW2yLK
	 bJ3Xn5D6S9b9FPUpDxD9YohNab25q5l0hHAJwgmfEwcGJdwmSlwkHvt6SNO5ODGrjx
	 MgIQoRHBpgLTe885aJf8G/+8WDdjkRjfmPSX4uBU7YEQa9QNhZ22RXJqoY8aTREM5y
	 HmZKP7Ifjgs7w==
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
Subject: [PATCH v4 0/4] kho: add support for preserving vmalloc allocations
Date: Wed, 17 Sep 2025 20:40:29 +0300
Message-ID: <20250917174033.3810435-1-rppt@kernel.org>
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

v4 changes:
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
  lib/test_kho: use kho_preserve_vmalloc instead of storing addresses in fdt

 include/linux/kexec_handover.h |  26 ++-
 kernel/kexec_handover.c        | 324 ++++++++++++++++++++++++++++-----
 lib/test_kho.c                 |  41 +++--
 mm/memblock.c                  |   4 +-
 4 files changed, 337 insertions(+), 58 deletions(-)


base-commit: 103e90626d3a4032d22e8b09ff14600e71cda59c
--
2.50.1

