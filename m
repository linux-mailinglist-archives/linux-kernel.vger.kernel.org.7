Return-Path: <linux-kernel+bounces-800148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71ED8B43404
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24D3E1C262B9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5071429B8EF;
	Thu,  4 Sep 2025 07:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="fJmEpBPV"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D5926E717
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971165; cv=pass; b=qZblUFutWuB9RyJ6b8ESgGAIN6TSTWsemYEYjjotApWrGY62JeoWndmQqsDXqe15UBP7RGE+CKb1WJszBsK5VnIe8G6t3NvfFFVjB4SrWuMBsHm3YFM3XuNWhE4RDEVcVP3zt9lWkedGwILp9fIQFAiAat20jA0E6ckeUScBg9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971165; c=relaxed/simple;
	bh=xRd7DfsUyLma8Rb/FqjUZEBnSro8pkBd+KEIWUTx8DU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gMzoXKWwpzpPOcBCon0aFwqbNwUSy0xnagtms5IRMw4GLNX01kCstUei00oM5FmxIPgI6zfMM82S4VdA4FXAEg+vXxMHvYWgOVanXlyol0x6fP1bvUvcCbBSMBZP4C4sQCd52J+iEYic4DM22DjQaT3HKfcZVpZPOkHXIstLnvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=fJmEpBPV; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1756971141; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DohdtRdsnWm+FTyceYTJ1ADB2Cu4BDb1acLuTd4SkmAWJE7xnDdnSJc2Mwa+DXakk4L+tYo3jZ3vfJPtoGaY/ES6YnB3yk4Qf3gfhZXM50Z+xWAl7tk7CFwx+yCY5Q2dmf/VMXmBQJpcZ07zN7gMhyTmZdM2fC6kW6/6qvOgOZM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756971141; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aTE4qhWLj97cE91FZu0gKB2lFf3oxunWOUcVgs6SaiY=; 
	b=CQzsD7s5mdKui9tWAxYTf59KjgQCG5QxG2pn9Ckh63Yd98snZqpAptfhid9wB0u2s5C65F9dFa21Dhq9yPAsaHWw+8tr9VRM7ESoPLOhx1Jirx6VWSpzaXNl4dEDpLxrBfRyqUWzTpEudyabVcLUgzn87UfRImIOpsgNVRk46vs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756971141;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=aTE4qhWLj97cE91FZu0gKB2lFf3oxunWOUcVgs6SaiY=;
	b=fJmEpBPVk/LMbZ5euOWMiJw4miTmtW7Msgj9kucoLU6iL98BN14/ytbyQZ/ZvNbL
	LjS1jBL+WRG0CEKWrk43+v8W2dssyyHb6zeDjdSbotNJft1JcVZEp8IfZYk0Bpf9dsf
	CUbmT7MX4vKA+iUTtH8fcsc5n0y5CceQjn5MlTeFIpJy2mySjx+c3UXhOAGTZWpgypa
	srIc2bzCiqvi7BAC9vkfaAS2j85E0P1cn2IYboFcgjkzcXavYuIYlfAR6AMEll0Z5x5
	cLcsWgrO0L7jbhILOL8a0HGVB0sxOKlSN7Tkxnizc2IMskk2B8kuOAzMuzYNZdKBT8Q
	9Lw+h2YHwA==
Received: by mx.zohomail.com with SMTPS id 1756971139231102.77951280999105;
	Thu, 4 Sep 2025 00:32:19 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Han Gao <rabenda.cn@gmail.com>,
	linux-riscv@lists.infradead.org,
	etnaviv@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v2 0/7] drm/etnaviv: add support for GC620 on T-Head TH1520
Date: Thu,  4 Sep 2025 15:31:44 +0800
Message-ID: <20250904073151.686227-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.51.0
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

Tested by both the etnaviv_2d_test program in libdrm tests and
xf86-video-thead 2D-accelerated DDX.

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
 drivers/gpu/drm/etnaviv/etnaviv_iommu_v2.c | 26 +++++++++++++-----
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c      |  1 +
 drivers/gpu/drm/etnaviv/etnaviv_mmu.h      | 24 +++++++----------
 7 files changed, 99 insertions(+), 29 deletions(-)

-- 
2.51.0


