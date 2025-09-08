Return-Path: <linux-kernel+bounces-805566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D50D9B48A44
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D5A24E1660
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44572F4A12;
	Mon,  8 Sep 2025 10:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p44JO1TS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD78215F7D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 10:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757327743; cv=none; b=APoOiE09M2Sdzk8Pxqrr2ohVyAlzbpZyLQxAJmdLsBELvDCRuhXeYD/BUVTtsaDxLKler+NAIC8I/zvQ6InoFMr8CUky6oW8xT3GfHsUffgOsdIGb9a1TEknrFrTn3X+QOU7Wm1ozBvEcVjApRpF34X+oa9DOChIFV1J8Ay7dn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757327743; c=relaxed/simple;
	bh=Y+6NT7qGhfiYpIQPVV4I0mtOFqnghk5yu59oPQEuT2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PdvvBS5CsqbUgojK0Vz0JsgifKDM+43OCiHo2FRnGuNxAeBN7dldbQJ7Yhxacvh0mpyd6M/rvdNRFSn20z9qlfMPYzgb5JRsHdaOio6R+BiQNxDjMdgaHobriu83GtGep7UjiydmWLNdM/NVD8eFi7Q6pBBEuMAYr58Y3pA8aw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p44JO1TS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55DBC4CEF1;
	Mon,  8 Sep 2025 10:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757327742;
	bh=Y+6NT7qGhfiYpIQPVV4I0mtOFqnghk5yu59oPQEuT2I=;
	h=From:To:Cc:Subject:Date:From;
	b=p44JO1TSX342echla4JuExSua0T7EzB6vp6j6Kh5CjErmbLMjkm2x/e2lrPzDDv0S
	 kdbLO12BAAf5rMEqTX6Ucz9KLEGP7l3xb9Jq172uruMlKx0uJuuGUGXO774e1GOeuy
	 bPRaFS5AHdICB0FuSMuBBYbcWuxG8f1PCmraAAKhdNANdTZcTDAlIc/2olU2cpoD9d
	 qGrZeggsIMXg6A220VwyyXRBJJFrN4/asEYEj1y3l7S9v6zjqxS8xF4BsL+9psPGP5
	 wDUL7IVuAY2bNYB6tsFyLLKpQr/N63XArOFc8MpPDfHpUQ9tnkK0P9Mv3cxZmyBQah
	 v5jQDBQvP1Amw==
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
Subject: [PATCH v3 0/2] kho: add support for preserving vmalloc allocations
Date: Mon,  8 Sep 2025 13:35:26 +0300
Message-ID: <20250908103528.2179934-1-rppt@kernel.org>
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

v3 changes:
* rebase on mm-unstable

v2: https://lore.kernel.org/all/20250905131302.3595582-1-rppt@kernel.org
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
 lib/test_kho.c                 |  41 +++++--
 3 files changed, 241 insertions(+), 12 deletions(-)


base-commit: b024763926d2726978dff6588b81877d000159c1
-- 
2.50.1


