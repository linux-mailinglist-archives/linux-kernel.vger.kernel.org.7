Return-Path: <linux-kernel+bounces-802927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20260B45880
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75201C266F8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767571AC43A;
	Fri,  5 Sep 2025 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qqjp4fTG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D266719CCEC
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757077989; cv=none; b=tmFNinHMJ58h1QOi5REXaoz6bzABjV+m9MG6rfFBim362OZYuSxuZb23G82H84EZdbLtdOYwvkhgeLEQUpgS8Vw5VHM+8YdYa8ihQ8B5pRNaNm5N8M69x/a4fpqw0z4mXtiVwEX9XFzT3Xx1E71RIGFk2o+3sOe+JRkE9986KiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757077989; c=relaxed/simple;
	bh=lAKGsfnUG4rgDzqjzr2gwTb62JFdmQhbLIaqo8Ydwj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UkF6lX8luBYMrEJCo29Uatdy3fsnZxHqb48nA7MYQEIc8lCNM5l16fOBKqVMyLljsPfU+FWRGm6IHRTznfXeGKjCWwN0BIA+7/kiuUY6UcooJxlnBqNZKa0cbjIkRiJp5vUu4AYTvi+ozslqakg+pAGgpveT8Z8BmXKYYXqF/28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qqjp4fTG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FB4C4CEF1;
	Fri,  5 Sep 2025 13:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757077989;
	bh=lAKGsfnUG4rgDzqjzr2gwTb62JFdmQhbLIaqo8Ydwj8=;
	h=From:To:Cc:Subject:Date:From;
	b=Qqjp4fTGmt1agJ5gkKDXDVoyGrBWy/+xs1oMAD+t8nIH8Wne+DsxUYs4uLh71rW4o
	 CkzGfZ+CFJZFEAjsuwqMOYzhZtYtjxTz3V0LXTgzxpipASA3L6qCJzPPSxuBCZFgnA
	 FH2NCGEyCRERVJ1wUthH9fmpESPTPQu/YHMIO6nGfxlWN0Ffxo3lTx2jWyoMlcQ/H3
	 oY1UkN6LddelAKES3d2dDxpEudIpgymD11FGtElL1NPFBYlLdF3KUEoui5ebcDzTe+
	 Sur1SvJ7GpsshAC5gaIuKSJ0HAN4lz374eMfLPyRfQ9HeI4sdzSJQ53f4aVUac6dPz
	 E2ydBOL4tqx3g==
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
Subject: [PATCH v2 0/2] kho: add support for preserving vmalloc allocations
Date: Fri,  5 Sep 2025 16:13:00 +0300
Message-ID: <20250905131302.3595582-1-rppt@kernel.org>
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

v2 changes:
* support preservation of vmalloc backed by large pages
* add check for supported vmalloc flags and preserve the flags to be
  able to identify incompatible preservations
* don't use kho_preserve_phys()
* add kernel-doc

v1: https://lore.kernel.org/all/20250903063018.3346652-1-rppt@kernel.org

Mike Rapoport (Microsoft) (2):
  kho: add support for preserving vmalloc allocations
  lib/test_kho: use kho_preserve_vmalloc instead of storing addresses in fdt

 include/linux/kexec_handover.h |  12 ++
 kernel/kexec_handover.c        | 200 +++++++++++++++++++++++++++++++++
 lib/test_kho.c                 |  30 +++--
 3 files changed, 235 insertions(+), 7 deletions(-)


base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
-- 
2.50.1


