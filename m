Return-Path: <linux-kernel+bounces-725787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D86EEB003F4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3F80166F42
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B347026AA82;
	Thu, 10 Jul 2025 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i8csEbWs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C9D26A1AC
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154956; cv=none; b=bzKBoXunvO8THjZmlGCcd39nc9yq9dhFg3yo0BIgcvBnFOFBzm+fa39Q/Hw8UOv0fLqjwVydLlrhbMqPN2HEEFc1PCw6Wj36A7Ep2HzvqqworN2V0bf9m+WInGq56QTdyzRshKDcAyeH39lCnM19EPJeFtBOZivEyzArtGOsbJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154956; c=relaxed/simple;
	bh=QrHjcBEPSqtyHnm7bqouFTQBugkf7uG4RIpVyX8EUx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zb6vYodvEH0Z+wkQ30V+DcHvQ11n7MfSZ7JjgaqChzdyEoAe8mwbwkVet2MTyBBvIfN4u7KSD+OL+fyZ6Bd2+U1ez0QdktkPZZg5bO1PGTe23qrbSQbc/FqTdzUwZXSFhW2yRmI28wYoDGgusz0aH9HtODBvmXQR+sQuiZauesU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i8csEbWs; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752154954; x=1783690954;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QrHjcBEPSqtyHnm7bqouFTQBugkf7uG4RIpVyX8EUx0=;
  b=i8csEbWscKgm1DXes0J/UEIu/tD1dmpjaHRpgDwrh7g/nu/nA4jL2y5Q
   cIQppir27BMUPAEOg+v4ggcWt74hzYgvsQbkMwsX49khXCPIuGRxfsb1h
   RrUXQpFtlL56UKJJDBj45IPiBHnl5u/sE/5KrNLgQLPsya4aUnPpCF5Ph
   eraNJ001AFN2r61Ctv+i/n4zAKPSV0qzk39eJPInr4BvILMZrs+J7S2K8
   v64jHZHArDfn9Y8lHAJAMPr1ViWYyUXRLIYfZpki96zFcsqY4xuMUy7tg
   Jd15zjKarmevOfJjAuAqdDJ/kOdSh6uneVlO8kxcx43NaaGx/Z7eZwuBD
   g==;
X-CSE-ConnectionGUID: yHnO9tGWSeKBLu6/ib96fQ==
X-CSE-MsgGUID: hxk/p4D8RESH4MlUF/NaHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="65787666"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="65787666"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 06:42:33 -0700
X-CSE-ConnectionGUID: reV4IG/xR6Gw2h6DzgzikQ==
X-CSE-MsgGUID: KwwLF/aXTiyA0dqAe4ugMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="156809429"
Received: from gnrd8.igk.intel.com ([10.123.232.137])
  by fmviesa010.fm.intel.com with ESMTP; 10 Jul 2025 06:42:31 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Subject: [PATCH v1 0/4] Implement IOMMU SVA page fault processing error notifiers
Date: Thu, 10 Jul 2025 13:42:11 +0000
Message-ID: <20250710134215.97840-1-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces a facility of notifying endpoint device
drivers of failing IOMMU page faults occurring for specific
Requester IDs.

According to the PCIe spec chapter "Page Request Group Response Message",
in case of Page Request processing failure (e.g., detecting attempt to
access pages with insufficient permissions, like writing to RO pages)
the system responds to the requester with a message containing a non-zero
response code. The requester device is then supposed to process that
response in implementation dependent way.

However, some endpoint hardware supporting SVA does not provide insight
on failed IO page faults, being limited to generic error reporting
(via interrupts and/or few register bits).

These series contain changes that provide endpoint device drivers
with the ability to retrieve information about page fault processing
errors (the most relevant being PASID and IOVA PFN).

Endpoint device drivers are able to set a callback functions
which will be called when a failing page fault (such as accessing pages
with mismatching attributes - e.g. writing to RO pages) occurs.

Normal processing path (i.e., swapping in or allocating backing physical
memory for non-present pages) is unaffected by these changes.

The endpoint driver code can then take appropriate actions, such as
fault reporting and recovery, sending signals to affected processes etc,
using the fault context provided in the fault parameter structure.


Sergey Temerkhanov (4):
  iommu: Pass the Requester ID in the fault parameter structure
  iommu: Add rid_notifier array to the dev_iommu structure
  iommu: Implement iommu_set_rid_fault_notifier()
  iommu: Notify requesters of IOMMU fault failures

 drivers/iommu/intel/prq.c  |  1 +
 drivers/iommu/io-pgfault.c | 53 ++++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu-priv.h | 11 ++++++++
 drivers/iommu/iommu-sva.c  | 19 +++++++++++++-
 drivers/iommu/iommu.c      | 21 +++++++++++++++
 include/linux/iommu.h      | 19 ++++++++++++++
 6 files changed, 123 insertions(+), 1 deletion(-)

-- 
2.43.0


