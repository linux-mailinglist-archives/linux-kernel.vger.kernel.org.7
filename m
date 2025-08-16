Return-Path: <linux-kernel+bounces-771784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0014B28B86
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 09:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440CB1C885DE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 07:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6AA227BA4;
	Sat, 16 Aug 2025 07:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="Ejc61UXZ"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB6A1DA21
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 07:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755330528; cv=pass; b=RmFHUGLzALKGrUm099m0BtMzv1nwz1UYxNHzQ/YaS0tfiQ0OS5mctYsB9XzD3bhOL70gFF41at+elh7r9norZq0Nh8Hyra3EEYbk50kTZxQGTjWntdvUPsqulaXcVUdQUr7zI9pVdf2WnKERomlvh89XtT0/PtSQH8w1i5no668=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755330528; c=relaxed/simple;
	bh=eDNERpSPdaw8ZkwiVSPWSANjsODskirV6nWXYY+p01U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pPstk8E9SGKiay/zUlNKIRRbzwlxB3lK8M1DDpX2Tz6mPj0FPAUL2xdN6xYL6PowYs1hOjRGjYLRwtzY4sfz3+QZGpZ+qveIX/pZvYLcUBNcDX6HOIsuCtBkQhhpBN63jsb2MkAXvTVtC4ZMaTINxrvPbwdSMgik2ldPcLyAJK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=Ejc61UXZ; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755330499; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=A3Z3+ERcLsXTZoUMsAKaue8d2lHMezKapHDW7CIAizHx7DFRfYlxDHl+oVMKxnmPZY92upxn8WP/kd4f+7bf+jsr1MnwPaJcr8/jIOcz3+GNX0aQ4IJ4fqVaxzRc3JfmxSBluUTF+yRkWlC0VTRHWhhUNjiGrObr/M4mTFUAnV4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755330499; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZvPMHxn9L7TiQAMN2zR904XCsjoFl4D3E0wwP1N3GjU=; 
	b=bIO4+m8a1j6drs3qvNV5RvzSKhP+SZUi8yeO98ZXPG+TBg5VKrHp/Njbb/5iI7gsCD65Q/zm6ocF7VE9SKPhyNhsMyAnJlyC5vqutdkj9BMITfuE/Cr50OYT3+MhtIATV6I/N+9MLyBLy2LEVM8PZVf9ox4t95At6GA1DtkLJWU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755330499;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ZvPMHxn9L7TiQAMN2zR904XCsjoFl4D3E0wwP1N3GjU=;
	b=Ejc61UXZtgJgtPUu0kbjrf9a3gMGZBwkNEp6GNXbaNY9cd5k5v4MN4OUPJjCST4P
	vJN8xP6j2quoP+UiX8rOPTDhpmQnuK7Ca4VoiCwf6BwMohPt4vXBZPMyL3+ugPn0b9i
	ATAD/sVL2HgXoQASdKdxOM9iCXCGoRJ2YVlrcA37+Otde/CsMDzREbQSi2+UMXaWEOu
	bc5y0Bxy7VrFu0J6Uh0IWJt84uFla/nVJOI0ZWnDF68SbRdbcf4rtTsUWqBsxdbUacv
	IPzTuUPVP9O4Da7Joos9Te4/Pvrpl4RUT0Z00JnjGCuQZZ7aQaQJxIi8PwtiVwQXa0M
	uk4u/S+V8Q==
Received: by mx.zohomail.com with SMTPS id 1755330497800252.9936948125818;
	Sat, 16 Aug 2025 00:48:17 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 0/7] drm/etnaviv: add support for GC620 on T-Head TH1520
Date: Sat, 16 Aug 2025 15:47:50 +0800
Message-ID: <20250816074757.2559055-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This patchset tries to add support for the GC620 2D accelerator, which
is a quirky thing -- it has quirks on both MMU and DEC.

The DEC quirk is bound to the model number and revision number
currently, and only involves writing to some DEC registers at specific
situation.

The MMU quirk is more weird -- it contains a broken implementation of
PTA, which blocks directly writing MTLB address to switch MMU context,
but loading page table IDs different to the initial one does not work
either. A shared context practice, like what's done for IOMMUv1, has to
be used instead.

The DT patch isn't ready because the VP (video processing) subsystem on
TH1520 does not have proper clock and reset driver yet, and the DT patch
included in this patchset uses fake clocks and ignore resets.

Tested by the etnaviv_2d_test program in libdrm tests.

Icenowy Zheng (7):
  drm/etnaviv: add HWDB entry for GC620 r5552 c20b
  drm/etnaviv: add handle for GPUs with only SECURITY_AHB flag
  drm/etnaviv: setup DEC400EX on GC620 r5552
  drm/etnaviv: protect whole iommuv2 ctx alloc func under global mutex
  drm/etnaviv: prepare for shared_context support for iommuv2
  drm/etnaviv: add shared context support for iommuv2
  [NOT FOR UPSTREAM] riscv: dts: thead: enable GC620 G2D on TH1520

 arch/riscv/boot/dts/thead/th1520.dtsi      | 19 +++++++++++++
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c      | 19 ++++++++++---
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c     | 31 ++++++++++++++++++++++
 drivers/gpu/drm/etnaviv/etnaviv_iommu.c    |  8 +++---
 drivers/gpu/drm/etnaviv/etnaviv_iommu_v2.c | 23 +++++++++++-----
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c      |  1 +
 drivers/gpu/drm/etnaviv/etnaviv_mmu.h      | 24 +++++++----------
 7 files changed, 96 insertions(+), 29 deletions(-)

-- 
2.50.1


