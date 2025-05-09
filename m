Return-Path: <linux-kernel+bounces-640870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCC0AB0A55
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 08:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAF171C00D58
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 06:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6F926A0E7;
	Fri,  9 May 2025 06:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U3vS7UOz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F54A26A0E5
	for <linux-kernel@vger.kernel.org>; Fri,  9 May 2025 06:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746771140; cv=none; b=WsG9wfjFX4oPfwdQXqzDi28uMLsqb1AkgTK0LzHs8wheVi+WHT13vEbYxzQjnMmLOScbBAiCuOoc8igAPWs1BRN0uNTruYKAqGywlan8OMIzvo+LCLVi7yOmSpxDIwj51mUu4LNq8eOlBBkMpfZ6OYjehkrs5/eZkipDeJAc6nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746771140; c=relaxed/simple;
	bh=HwsKU7b04B/wi+ZsRgWfvBVByBoELx7B74qb4IuA3PA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AigBN3EWMXWqICtrzIsTg6t6+pQstbeU76qXh8Hw8yT8V5DRlVwtK43Xi2LbV2uSr9XTVFmuRBVWOBpujL6aiiAqcH2HXxyOn+MNdIFlJ/JjT4o0QR0bzfvco5vu11lKOi/+v2nMSOYIeoZ7H3DFcdJAuDAebcNJlVUX5a2ybYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U3vS7UOz; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746771139; x=1778307139;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HwsKU7b04B/wi+ZsRgWfvBVByBoELx7B74qb4IuA3PA=;
  b=U3vS7UOz9l7scC0FvKsmrAPOV12o5l+7R20LvOnEQvCLpDjTJcSNcyib
   +gGPpl0gspfyGRU5oaGi4NuyFwMM8bbMSGavDqpmzsD0ttwGvkJMcFgOI
   iboP0TjfTXi9akFGaseJgL3DEdcfnhFuOB1g8D+DqP6kgPpMPrHJPgshd
   zLG0OMyjqxyMFvv91GrD4yXS/Xf2/RIPBGm1nwhjOOOhmASghxQZgr+vB
   JQrOFoIzXiPpfmUgSwULFc7tCfOd0ASRJI3rnnjN7eYYMJyIoxoYWEla5
   cwsPqUsn+XaE7DyeeRBmGSN+JGWPKYNiszPl1Qlp97OPdAiffBXYN2Z82
   g==;
X-CSE-ConnectionGUID: 4Hg6VKJISf6n0OWkSI9O6w==
X-CSE-MsgGUID: m+IynCe4SmuYUHOuc1NFjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59927980"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="59927980"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 23:12:18 -0700
X-CSE-ConnectionGUID: 4USAJGyUTAi5RMMFQXmRug==
X-CSE-MsgGUID: OlngyNWITyWJjCdaOUS6lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="136447516"
Received: from ww-dev.sh.intel.com ([10.239.48.95])
  by fmviesa006.fm.intel.com with ESMTP; 08 May 2025 23:12:16 -0700
From: Wei Wang <wei.w.wang@intel.com>
To: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	kevin.tian@intel.com,
	yi.l.liu@intel.com,
	jroedel@suse.de,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v1 1/3] iommu/vt-d: Eliminate pci_physfn() in dmar_find_matched_satc_unit()
Date: Fri,  9 May 2025 22:00:19 +0800
Message-ID: <20250509140021.4029303-2-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509140021.4029303-1-wei.w.wang@intel.com>
References: <20250509140021.4029303-1-wei.w.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function dmar_find_matched_satc_unit() contains a duplicate call to
pci_physfn(). This call is unnecessary as pci_physfn() has already been
invoked by the caller. Removing the redundant call simplifies the code
and improves efficiency a bit.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 drivers/iommu/intel/iommu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cb0b993bebb4..d8aa71305509 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2744,7 +2744,6 @@ static struct dmar_satc_unit *dmar_find_matched_satc_unit(struct pci_dev *dev)
 	struct device *tmp;
 	int i;
 
-	dev = pci_physfn(dev);
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(satcu, &dmar_satc_units, list) {
-- 
2.43.0


