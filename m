Return-Path: <linux-kernel+bounces-600500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F37A860A6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 16:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0BBE1B6366B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 14:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F8A1F3BA5;
	Fri, 11 Apr 2025 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Eqfq7KUF"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1881F3BAA
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744381884; cv=none; b=FvdE10N3n5/vdPcavGd71yuBuApmIYBbIODXDiNt2EbnDgE5+2vfb8GTvAaz+5FuGvaArHl3gK6sJUryAzKdwYPqAvfvuSGgCZcTkey+AtLaZqiA5R3bm/3ewCxfP48ywZuKFxd4hCs4ywEhD7PqxjfH353AQYeFglXoyAXULe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744381884; c=relaxed/simple;
	bh=cR0MT7SIQsZS0BIRcyRHwHriDkdMJJMU+eMrzLmaREU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PhdmD0s6MTfFqehFeZoR8Uy+9z3ZdMFqFI1eCNJGAJw+AkkFFV7UKbzL9tFdHFkgVMfZPWBabXMrQfmI5N2CY4WqiM5yNW6PYdjeoO6NZRVpu8aKh3UK92v/0+BQOJzW337D12s4wmNE0SKH7hJMKt/JPelbDoL7J2mwoYfBhkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=Eqfq7KUF; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 123A347F1E;
	Fri, 11 Apr 2025 16:31:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1744381880;
	bh=cR0MT7SIQsZS0BIRcyRHwHriDkdMJJMU+eMrzLmaREU=;
	h=Date:From:To:Cc:Subject:From;
	b=Eqfq7KUF1hdvzAztdS6DA1TZugK0wED97mI9mkRTLOmxyBmaOIPZ1TgunhBlufqvm
	 pu9YSTdeA3LQMhkNVCIAjP9XETen2jA0Im2KV53GsDVS8tpj9bnxdcDWrjani9Y0qW
	 KrlO0xD2AhoRoohidRsoRUKY8GAv62DOXeGDTf2qHEt0YWlZxoWO/8Jdi22kuvQ1+v
	 rRWsVUdTks5lLoMfijHuJaIShaejjFoEgXjReWdxO+/NfMA10EjP696kSK2MiyogXw
	 GPU4OpFx1ELrszlsWiQxSQQuucmL2J2T4zR4pXLOrH6+IyNnptuYJwdWA95JHYxPkk
	 Xj03A0G/j61pA==
Date: Fri, 11 Apr 2025 16:31:18 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.15-rc1
Message-ID: <Z_kntkZxksOfGwpt@8bytes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.15-rc1

for you to fetch changes up to 767e22001dfce64cc03b7def1562338591ab6031:

  iommu/tegra241-cmdqv: Fix warnings due to dmam_free_coherent() (2025-04-11 12:44:27 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.15-rc1

Including:

	- Fix two crashes, one in core code and a NULL-ptr dereference in the
	  Mediatek IOMMU driver.

	- Dma_ops cleanup fix for core code.

	- Two fixes for Intel VT-d driver:
	  - Fix posted MSI issue when users change cpu affinity.
	  - Remove invalid set_dma_ops() call in the iommu driver.

	- Warning fix for Tegra IOMMU driver.

	- Suspend/Resume fix for Exynos IOMMU driver.

	- Probe failure fix for Renesas IOMMU driver

	- Cosmetic fix

----------------------------------------------------------------
Fedor Pchelkin (1):
      iommu: Fix crash in report_iommu_fault()

Louis-Alexis Eyraud (1):
      iommu/mediatek: Fix NULL pointer deference in mtk_iommu_device_group

Marek Szyprowski (1):
      iommu/exynos: Fix suspend/resume with IDENTITY domain

Nicolin Chen (1):
      iommu/tegra241-cmdqv: Fix warnings due to dmam_free_coherent()

Pei Xiao (1):
      iommu: remove unneeded semicolon

Petr Tesarik (1):
      iommu/vt-d: Remove an unnecessary call set_dma_ops()

Robin Murphy (2):
      iommu: Clear iommu-dma ops on cleanup
      iommu/ipmmu-vmsa: Register in a sensible order

Sean Christopherson (1):
      iommu/vt-d: Wire up irq_ack() to irq_move_irq() for posted MSIs

 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 32 ++++----------------------
 drivers/iommu/dma-iommu.c                      |  4 ++--
 drivers/iommu/exynos-iommu.c                   |  4 ++--
 drivers/iommu/intel/iommu.c                    |  1 -
 drivers/iommu/intel/irq_remapping.c            | 29 ++++++++++++-----------
 drivers/iommu/iommu.c                          |  6 ++++-
 drivers/iommu/ipmmu-vmsa.c                     | 27 ++++++++--------------
 drivers/iommu/mtk_iommu.c                      | 26 ++++++++++-----------
 8 files changed, 52 insertions(+), 77 deletions(-)

Please pull.

Thanks,

	Joerg

