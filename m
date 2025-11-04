Return-Path: <linux-kernel+bounces-884970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E31AC319F0
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C6314F9872
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7D6330319;
	Tue,  4 Nov 2025 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="DjjSxPdz"
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCEC230BD5
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762267707; cv=none; b=m80omoopjQnNfwrrTvte02dfoOVxMKxJEJUGzz87b31KhulTBfiFGXeJ9NXoI2UTJ5O2qVuTn/jZ6QI9T64wr6USV0Ythhv3zl+RGbyb344SmcE7vuNcBmF6yBC/intARLkLHlOBddz8eL9TTtkLCBQtIFO4cRFHHcVo1gqcMZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762267707; c=relaxed/simple;
	bh=MsDud96uYbv/TfasS4+S0MPyoqpc9yVMWQVuAaCpIaA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=PoU99MXT4Nc/5jEWNAxdYHckYEBsTwMLinMjVBOyfLmCZYlNNSjY5Bk4B1xbUiU3lldZQ+s1k5dRbat+pPsMHp5j7UJKd9/LB4hS+lEnlPl60b5BC+KVYORhqqE88n89UJCV784ibL/JYrh2m+JLRHrdOLQfMcdTaG2wk+Ui6A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=DjjSxPdz; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1762267694; x=1762526894;
	bh=My0lcXrG8cShyz59I5w5UE8WjsZYKZx5nmyqC76eTx4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=DjjSxPdz8f9+6EQiHOdfGc9ntzSl9Ub+pKG2MllZ8PxNEbtJpEFqPHOgGG+O0ekXd
	 SpX8uhzxckJHe4ZN+MUIg4tW3wLywA+0yuZySC2uG24FfAV6vTkSSskNFdTa6KmDJB
	 tPMNhEysZkFtgwJGI3maZo2FQxMCazYHOnry5shRcpbIwn2r67aNgAxqr+WAS5Dg6k
	 NgDg3q4u6evkq/ckpDH10xJH6bgx/WOFAdRPij6g6STaVsOAKAl/M8XMOE7EkZuTXi
	 LigYtBppxumrSaPlquWUZA4SQPDeRDeRe7jd7AfflY6to+oMm4pvv33KhEg2GXNtDk
	 9hr2LvbGsWRYQ==
Date: Tue, 04 Nov 2025 14:48:07 +0000
To: andreyknvl@gmail.com, akpm@linux-foundation.org, ryabinin.a.a@gmail.com, elver@google.com, dvyukov@google.com, vincenzo.frascino@arm.com, urezki@gmail.com, glider@google.com
From: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, m.wieczorretman@pm.me
Subject: [PATCH v1 0/2] kasan: vmalloc: Fix incorrect tag assignment with multiple vm_structs
Message-ID: <cover.1762267022.git.m.wieczorretman@pm.me>
Feedback-ID: 164464600:user:proton
X-Pm-Message-ID: 6755a8c21333141e5fc9d41deffd2e258c429b93
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

A KASAN tag mismatch, possibly resulting in a kernel panic, can be
observed on systems with a tag-based KASAN enabled and with multiple
NUMA nodes. Initially it was only noticed on x86 [1] but later a similar
issue was also reported on arm64 [2].

Specifically the problem is related to how vm_structs interact with
pcpu_chunks - both when they are allocated, assigned and when pcpu_chunk
addresses are derived.

When vm_structs are allocated they are tagged if vmalloc support is
enabled along the KASAN mode. Later when first pcpu chunk is allocated
it gets its 'base_addr' field set to the first allocated vm_struct.
With that it inherits that vm_struct's tag.

When pcpu_chunk addresses are later derived (by pcpu_chunk_addr(), for
example in pcpu_alloc_noprof()) the base_addr field is used and offsets
are added to it. If the initial conditions are satisfied then some of
the offsets will point into memory allocated with a different vm_struct.
So while the lower bits will get accurately derived the tag bits in the
top of the pointer won't match the shadow memory contents.

The solution (proposed at v2 of the x86 KASAN series [3]) is to tag the
vm_structs the same when allocating them for the per cpu allocator (in
pcpu_get_vm_areas()).

Originally these patches were part of the x86 KASAN series [4].

The series is based on 6.18-rc4.

[1] https://lore.kernel.org/all/e7e04692866d02e6d3b32bb43b998e5d17092ba4.17=
38686764.git.maciej.wieczor-retman@intel.com/
[2] https://lore.kernel.org/all/aMUrW1Znp1GEj7St@MiWiFi-R3L-srv/
[3] https://lore.kernel.org/all/CAPAsAGxDRv_uFeMYu9TwhBVWHCCtkSxoWY4xmFB_vo=
wMbi8raw@mail.gmail.com/
[4] https://lore.kernel.org/all/cover.1761763681.git.m.wieczorretman@pm.me/

Maciej Wieczor-Retman (2):
  kasan: Unpoison pcpu chunks with base address tag
  kasan: Unpoison vms[area] addresses with a common tag

 include/linux/kasan.h | 10 ++++++++++
 mm/kasan/common.c     | 19 +++++++++++++++++++
 mm/vmalloc.c          |  4 +---
 3 files changed, 30 insertions(+), 3 deletions(-)

--=20
2.51.0



