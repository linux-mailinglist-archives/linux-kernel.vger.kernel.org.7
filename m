Return-Path: <linux-kernel+bounces-722774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C3CAFDEB0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 06:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230DA583B6C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 04:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811C125FA3B;
	Wed,  9 Jul 2025 04:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m3ddWr6d"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCAF5661
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 04:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752034257; cv=none; b=S5jx6SbSDrXLcKGVmhWNkZyENc5Zi4DmdX+rPHTA8GFJNjxNgWpvn3w47a4BogHJJqq9/phgGMB9XB4t/j2ve/ucXLy11qICvOgZq3IvoLgbOYPYEKn9pf5CGgwGyOOiUy6QezNKPl0JRzxVZCB/0D2g1eIcDXqKLaZsZWxDSj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752034257; c=relaxed/simple;
	bh=+kmxH/FTuHkm2pegLN9zKKbYIiitzR0AVrNOAoJtRu0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FtQRk9WOx2zrO4s5IvsV+pvIukNJpXYWfxjydgZq95dkoItxKdpGp56irXH55k+ZpZj3bsVTOsLNL1Xz5CkEQMi7QgKuN5lh5TerGu9f8YZy6PNgXwP8I3T7iddlwD20jTIrY5FQKr2h4R1J7konQkCHmUoiGpEzXJP/4mVCwIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m3ddWr6d; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752034255; x=1783570255;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+kmxH/FTuHkm2pegLN9zKKbYIiitzR0AVrNOAoJtRu0=;
  b=m3ddWr6dZhaallshHZzyBid9DhpwEgjWzuePCAHO5JW8NIRXQMAyEdq3
   5v89AumTeHs32gOPhK4LBt9CqVLotbVFYRSBfb1nwHL2C+BECFWNDRhyl
   8EzrsZBs/BK7RGW/cCpldCn6sSmM8Grn146GoqYpZz6yivM3xG+EXVkCB
   f2B0CBT3cZEY+9trs7lv7YXEIhSqVnwMXLgEQ3NVKaydQs7tWzL+oljRT
   GNuo6gYdHHgdjEyqzZjcieIdL5HPY5+xs2f/5vjKt7680Mf5GlFbEIeSp
   Thb8xDjq8J0lABtJJuGH57gWkj7yvjEjGUQuKsU6tb93NaDqS9WVBOisC
   w==;
X-CSE-ConnectionGUID: xCi/F9cBSMSo46f7+kVPTw==
X-CSE-MsgGUID: hkO/R9npQ2K/HuPr8Fo+mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="76831755"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="76831755"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 21:10:54 -0700
X-CSE-ConnectionGUID: sD3xLT5fQ8auVgk1ZrHqzA==
X-CSE-MsgGUID: dhB28f3kSzqxFnLH6C1SRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="192851558"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa001.jf.intel.com with ESMTP; 08 Jul 2025 21:10:51 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: jgg@nvidia.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	will@kernel.org,
	aneesh.kumar@kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	joro@8bytes.org,
	robin.murphy@arm.com,
	shuah@kernel.org,
	nicolinc@nvidia.com,
	aik@amd.com,
	dan.j.williams@intel.com,
	baolu.lu@linux.intel.com,
	yilun.xu@intel.com
Subject: [PATCH v4 0/7] iommufd: Destroy vdevice on device unbind
Date: Wed,  9 Jul 2025 12:02:27 +0800
Message-Id: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is to solve the lifecycle issue that vdevice may outlive idevice. It
is a prerequisite for TIO, to ensure extra secure configurations (e.g.
TSM Bind/Unbind) against vdevice could be rolled back on idevice unbind,
so that VFIO could still work on the physical device without surprise.

Changelog:
v4:
 - Rebase to iommufd for-next.
 - A new patch to roll back iommufd_object_alloc_ucmd() for vdevice.
 - Fix the mistake trying to xa_destroy ictx->groups on
   iommufd_fops_release().
 - Move 'empty' flag inside destroy loop for iommufd_fops_release().
 - Refactor vdev/idev destroy syncing.
   - Drop the iommufd_vdevice_abort() reentrant idea.
   - A new patch that adds pre_destroy() op.
   - Hold short term reference during the whole vdevice's lifecycle.
   - Wait on short term reference on idev's pre_destroy().
   - Add a 'destroying' flag for idev to prevent new reference after
     pre_destroy().
 - Rephrase/fix some comments.
 - Add review tags.

v3: https://lore.kernel.org/linux-iommu/20250627033809.1730752-1-yilun.xu@linux.intel.com/
 - No bother clean each tombstone in iommufd_fops_release().
 - Drop vdev->ictx initialization fix patch.
 - Optimize control flow in iommufd_device_remove_vdev().
 - Make iommufd_vdevice_abort() reentrant.
 - Call iommufd_vdevice_abort() directly instead of waiting for it.
 - Rephrase/fix some comments.
 - A new patch to remove vdev->dev.
 - A new patch to explicitly skip existing viommu tests for no_iommu.
 - Also skip vdevice tombstone test for no_iommu.
 - Allow me to add SoB from Aneesh.

v2: https://lore.kernel.org/linux-iommu/20250623094946.1714996-1-yilun.xu@linux.intel.com/

v1/rfc: https://lore.kernel.org/linux-iommu/20250610065146.1321816-1-aneesh.kumar@kernel.org/

The series is based on iommufd for-next


Xu Yilun (7):
  iommufd/viommu: Roll back to use iommufd_object_alloc() for vdevice
  iommufd: Add iommufd_object_tombstone_user() helper
  iommufd: Add a pre_destroy() op for objects
  iommufd: Destroy vdevice on idevice destroy
  iommufd/vdevice: Remove struct device reference from struct vdevice
  iommufd/selftest: Explicitly skip tests for inapplicable variant
  iommufd/selftest: Add coverage for vdevice tombstone

 drivers/iommu/iommufd/device.c          |  51 ++++
 drivers/iommu/iommufd/driver.c          |   4 +-
 drivers/iommu/iommufd/iommufd_private.h |  37 ++-
 drivers/iommu/iommufd/main.c            |  30 +-
 drivers/iommu/iommufd/viommu.c          |  64 +++-
 tools/testing/selftests/iommu/iommufd.c | 388 ++++++++++++------------
 6 files changed, 373 insertions(+), 201 deletions(-)


base-commit: 3e2a9811f6a9cefd310cc33cab73d5435b4a4caa
-- 
2.25.1


