Return-Path: <linux-kernel+bounces-729350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C794DB03556
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 06:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5879A177E90
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 04:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A47211A35;
	Mon, 14 Jul 2025 04:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f2osqrn/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4319820AF9A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 04:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752468775; cv=none; b=ig9OjMsXtcjsaPfRwZXBH4afMistIpEukqFeI3cxy0cnqJVyYtIRy+090aJf53P2Tya9WQiAPEFDcaNcPQZ30JFPB2Inpcu0cGhwOQqvRFUwSLzUexzbbf8/ltg8874z/TVws/+QR/OngRx3LUZggNXWhQMAqwMwljgngzussf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752468775; c=relaxed/simple;
	bh=uAR7aJXKMAUUzYnjgFC0oh/4Ts6cvw1XnZBBjFHogEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K70IdjyHFFCpDQWsXClp2W74maP7OOIy9anOisPwTPBo8wJzOAwd5mAjKaxxPs1tGnlIaWA2ykaHXthUfFaPVZLSEbShNF75vHMpsY/4k3ObWkNILPp52v4uTVa0nFHHy77ybqFXvUqEAp/Q11EpwtFGMmE9nOGFWRPjfvttW78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f2osqrn/; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752468774; x=1784004774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uAR7aJXKMAUUzYnjgFC0oh/4Ts6cvw1XnZBBjFHogEU=;
  b=f2osqrn/vUo4Q4Py6cmKo0HEsLPVONKtflNG0+jLCNGOyXLFUd/zn3tg
   I49Lsv0//KqRHS6Me7ijXAbQYXxcnIyxqPt44qV4zFDkpYt4++8eZuLCX
   C/qBgFJ1FMva6dQlIbqfsVOe40RHJLZEdrLQL/ljQCp2U4VIXbpaEgf/o
   XsJ36EPQ/4CQyLr7CwjYnC2VxxH3sHiL5JeOCIpEnrI2vmGwnwcogCvvN
   0KqBcdI4cm83MUFfOTU8736vH/AP10ibimNjTJp+FjzdR4pnbbwEUOWKh
   286Nz4oRAS6LA6VbypZT6qeHRGinNyZB66Gsq8YHGuvmGGjCwKRzo9JfY
   A==;
X-CSE-ConnectionGUID: Gq6Wz+Y4SkCIgK4Rmt+C9w==
X-CSE-MsgGUID: UxU5eyRMTuypoHJn64Vr3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53765052"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="53765052"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 21:52:53 -0700
X-CSE-ConnectionGUID: C5MQhJVvRwK2Uia7V1fJ1g==
X-CSE-MsgGUID: xTBFJSpyQbaI0L8WKSK7uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="161166166"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa003.jf.intel.com with ESMTP; 13 Jul 2025 21:52:53 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] iommu/vt-d: Do not wipe out the page table NID when devices detach
Date: Mon, 14 Jul 2025 12:50:22 +0800
Message-ID: <20250714045028.958850-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714045028.958850-1-baolu.lu@linux.intel.com>
References: <20250714045028.958850-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@nvidia.com>

The NID is used to control which NUMA node memory for the page table is
allocated it from. It should be a permanent property of the page table
when it was allocated and not change during attach/detach of devices.

Reviewed-by: Wei Wang <wei.w.wang@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/3-v3-dbbe6f7e7ae3+124ffe-vtd_prep_jgg@nvidia.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5c798f30dbc4..55e0ba4d20ae 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1391,7 +1391,6 @@ void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 	if (--info->refcnt == 0) {
 		ida_free(&iommu->domain_ida, info->did);
 		xa_erase(&domain->iommu_array, iommu->seq_id);
-		domain->nid = NUMA_NO_NODE;
 		kfree(info);
 	}
 }
-- 
2.43.0


