Return-Path: <linux-kernel+bounces-781448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C117B31292
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DF61A03781
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6131E230BC5;
	Fri, 22 Aug 2025 09:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="4eRYkddp"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04B52D7DC3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755853685; cv=none; b=ZOjIsd6RKvllm75wTrulRAliMOUv1YYgs5/WqVtAro4z34k0/wlZ6j9rHlIKJlTEGqXwIg63LRadFQyBegptu2zqHrQyelIkqSMt0dhXbOI0Q9ltu6ayq5Y1y8kH+GruQegriZGkobo6E+O+OEXzoV+qKeRiiSgt/68ZLWRJqTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755853685; c=relaxed/simple;
	bh=zNsikR9MK678/wLcnz+pzfRB+dtH0G9PMJUyWqEGx28=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rbXZiu3laIOaotMYwwfdIfCOn4O323sMcQa9cJTqqR+eBmwsbI+WRVzl89vZX4ws6UqE9beWo4XnqfR3lY23jzvcd2Qr2/yWcmVL2u7Dm36IguTAJ9JfPjLzma/vod4IyoyuPWCklW/spx/+SKClGXYvJRxfQISwdMYg1ZTGbqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=4eRYkddp; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p54921b16.dip0.t-ipconnect.de [84.146.27.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 69E165248F;
	Fri, 22 Aug 2025 11:08:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1755853682;
	bh=zNsikR9MK678/wLcnz+pzfRB+dtH0G9PMJUyWqEGx28=;
	h=Date:From:To:Cc:Subject:From;
	b=4eRYkddp4OyeRYccOsS8obmroCy2XtmVO07xi+7yKv0IpSv8BDcybPCr/c0vt/o7m
	 zjAsoYCiXNgmSYRjV5VXq6SEpa4IR3WHwNWfh9uW4PhJ8t3eX1BwgQJpzmLwgIEHKV
	 KQhByl3HgkDrsqFyrHVery5TXK1zV0gfydUc4CtgTN+ernx6nKDXS4TbxcnKxABBU3
	 2lAH1z+2rJ/gKJk4IAheUrmqaBm8sZRv93Vwkyr7zr6blolVQ8nWdqOyG4JHg01W5r
	 fKDlq/EHIBNrgSHrJp3jc1FTzwws9xdQI5aZiRhr90b8nLJ1tjluW/ESQD3BCOGaTV
	 zL05nAIH1eEgg==
Date: Fri, 22 Aug 2025 11:08:00 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.17-rc2
Message-ID: <aKgzcK1EldsksrPH@8bytes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.17-rc2

for you to fetch changes up to 99d4d1a070870aa08163af8ce0522992b7f35d8c:

  iommu/riscv: prevent NULL deref in iova_to_phys (2025-08-22 08:51:49 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.17-rc2:

Including:

	- AMD-Vi: Fix potential stack buffer overflow via command line.

	- NVidia-Tegra: Fix endianess sparse warning.

	- ARM-SMMU: Fix ATS-masters reference count issue.

	- Virtio-IOMMU: Fix race condition on instance lookup.

	- RISC-V IOMMU: Fix potential NULL-ptr dereference in
	  riscv_iommu_iova_to_phys().

----------------------------------------------------------------
Kees Cook (1):
      iommu/amd: Avoid stack buffer overflow from kernel cmdline

Nicolin Chen (2):
      iommu/tegra241-cmdqv: Fix missing cpu_to_le64 at lvcmdq_err_map
      iommu/arm-smmu-v3: Fix smmu_domain->nr_ats_masters decrement

Robin Murphy (1):
      iommu/virtio: Make instance lookup robust

XianLiang Huang (1):
      iommu/riscv: prevent NULL deref in iova_to_phys

 drivers/iommu/amd/init.c                       |  4 ++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c    |  2 +-
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c |  8 +++++---
 drivers/iommu/riscv/iommu.c                    |  2 +-
 drivers/iommu/virtio-iommu.c                   | 15 +++++++++------
 5 files changed, 18 insertions(+), 13 deletions(-)

Please pull.

Thanks,

	Joerg

