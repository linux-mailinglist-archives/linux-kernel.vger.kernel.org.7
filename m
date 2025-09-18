Return-Path: <linux-kernel+bounces-822045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59759B82EDA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CB92467C79
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1A134BA43;
	Thu, 18 Sep 2025 05:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JqLURHkG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB0B2749EA
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758171845; cv=none; b=ikt+bpWsfgONt5938+pLcOsKt4Ylvc0RNBjxTe0wHg2gPnGq/ewAnVHLP6YPjEcGgDGlW475MCVXlPDbhPq1V0xNG3QJ/HORqVoZrlLVYr7z2v3bepKVLFZh9Gb3aaEtEwPoEBrIkq2NpqRydsZqIR3Wbh+3RnYMSX74CuUtA4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758171845; c=relaxed/simple;
	bh=D+gaT+p75XA8ID4lzHKoK3KHkioDEmDwxDXB3G5F7Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EileGwhvxSNdldun2GJm6YN42MzMuA7tPDsBPrtsjTNS6PzraHPl7R2lUQwxqqdE47JXTYb0ouwpiEBVfYzvGAQUqLMBNADXEq22IF/KTw+oUiJymtBQCoKQptUSF32oxJB3vUgdxbco5+dQJIR/LVx+70qb83f4/AejtjDP78o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JqLURHkG; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758171843; x=1789707843;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D+gaT+p75XA8ID4lzHKoK3KHkioDEmDwxDXB3G5F7Lg=;
  b=JqLURHkGsYQdwNCNfJwJaY3Dqi37e9nDLLAsE7TeiD0kDqEbbVfJraC+
   zYShsZNK6SDcovIGRtXzeRCjakGW3WnvNbwOR/pJ3ppnY2ebaN1OBzfuG
   Pk6gZ0/Cxnn9gq3sfPVbYhpObPKtK9mi+xKT4H4pck4Qbvs1h+ZeHOlOe
   nf+n/EaEDAI3nzxx1fCZM5WtHqKD1NqNUnETML6NiAEPmYa1AY9SPorUd
   DIPUlX4IEyv+B0frGWjRXomeup8lwtTQDnDCETUBcGDN7p7TqgmZE4S0y
   SuesLp7N7Y6de3tke/Hz6Jk+xgpPtYhZSc4o9OZA8kQzJawM/pZow3Z8n
   Q==;
X-CSE-ConnectionGUID: ckNTW4yBQK61HZKXGZZfRA==
X-CSE-MsgGUID: gCM3x1vNT1W4pmpaspQtKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="60182248"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="60182248"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 22:04:02 -0700
X-CSE-ConnectionGUID: uFFcRAqDRoOuxLdI1rA6Kw==
X-CSE-MsgGUID: xCLyoUrlRly39sVd68Gojw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="175353397"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa006.fm.intel.com with ESMTP; 17 Sep 2025 22:04:01 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] [PULL REQUEST] Intel IOMMU updates for v6.18
Date: Thu, 18 Sep 2025 13:01:57 +0800
Message-ID: <20250918050204.359508-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

The following changes have been queued for v6.18-rc1. They are about new
features and code refactoring, including:

 - IOMMU driver updated to the latest VT-d specification
 - Don't enable PRS if PDS isn't supported
 - Replace snprintf with scnprintf
 - Fix legacy mode page table dump through debugfs
 - Miscellaneous cleanups

These patches are based on v6.17-rc6. Please consider them for the
iommu/vt-d branch.

Best regards,
baolu

Lu Baolu (4):
  iommu/vt-d: Remove LPIG from page group response descriptor
  iommu/vt-d: PRS isn't usable if PDS isn't supported
  iommu/vt-d: Removal of Advanced Fault Logging
  iommu/vt-d: debugfs: Avoid dumping context command register

Seyediman Seyedarab (1):
  iommu/vt-d: Replace snprintf with scnprintf in dmar_latency_snapshot()

Vineeth Pillai (Google) (1):
  iommu/vt-d: debugfs: Fix legacy mode page table dump logic

Yury Norov (NVIDIA) (1):
  iommu/vt-d: Drop unused cap_super_offset()

 drivers/iommu/intel/debugfs.c | 29 +++++++++++++++++------------
 drivers/iommu/intel/iommu.c   |  2 +-
 drivers/iommu/intel/iommu.h   |  4 ----
 drivers/iommu/intel/perf.c    | 10 ++++------
 drivers/iommu/intel/perf.h    |  5 ++---
 drivers/iommu/intel/prq.c     |  7 ++-----
 6 files changed, 26 insertions(+), 31 deletions(-)

-- 
2.43.0


