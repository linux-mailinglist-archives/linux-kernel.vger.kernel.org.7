Return-Path: <linux-kernel+bounces-776518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A47AB2CE64
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 758F85C092D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C47326D73;
	Tue, 19 Aug 2025 21:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RY2r9xlY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D473112DB;
	Tue, 19 Aug 2025 21:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755637839; cv=none; b=Mi83mXXl6yF6QC02KY67QaDoeQblh6OzkpXxA8xvsuGzxingW3jNH/6D/c2C2cyzRjDlD9QbV3M2G5TjodXz3bdBLKH6RlVvBkxd4LogB/ohukB6DidGjieENq1JJIlkV3igaiKTn634FJ1Xp+YGDAT9/jXJ0EfhbBfi7CVcGqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755637839; c=relaxed/simple;
	bh=VN4bkzMpu1clQFH8rEbLMXRoo4O/NBMLbnsWOEwnKvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nDU/iv1ZaEruv0bmv5CDFjsRqJpBzr6RYj8AncfsQsApdDS/jkhMAlL608u3DCjsLLzLxDj/ugaNL5fDznv2J5CrA8buhO1Ovzp0D2UgxD/gD08/GpYrZZ4VG7hAOS68ohHvDY/LnzwmbojLgCSVPzfnRMuEPDIK9m5ZRABvF6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RY2r9xlY; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755637838; x=1787173838;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VN4bkzMpu1clQFH8rEbLMXRoo4O/NBMLbnsWOEwnKvU=;
  b=RY2r9xlYHAGe3dblxfcx+qxrQMg8opWsm6YeVIlZX96OE7M+0IwmJS8n
   RQL9XC0DtmJ22aJyIFHYFf0smfgeqBNxh1ERsNAxZe5j9NRw+X4WI8goZ
   3KsINtSqEX/ySfZ45vN9Y+nJzcB8+fj7fMnQvimAXZuYsNbkMHk5Ob/1a
   v698X1zzlpitZ1DU7FC8riLkwJ4LZy4PNuNWtllvy0bhpJZ+ZNQzftz8W
   H9OFsIrnNBa8m5spi87L3u+1hrV+6mV5aFqv3Jg6PIM7CzvBY801CYK2V
   kOzZA/woNyeNuDWopyPq0UbSKd3dm3+6a0MzaKjF+qufq3FcfplHU0Ksn
   g==;
X-CSE-ConnectionGUID: bC1htob0TrSchQQlVPt9Pg==
X-CSE-MsgGUID: XiWt+1BjRW2tp+BkoLjbWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="61529950"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="61529950"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 14:10:36 -0700
X-CSE-ConnectionGUID: mKoTqS/SRMiJda6PBg3UZA==
X-CSE-MsgGUID: zpjT5zGnRBmtzxoHmOMv/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="168203897"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by orviesa008.jf.intel.com with ESMTP; 19 Aug 2025 14:10:36 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] platform/x86/intel-uncore-freq: Fix warning in partitioned system
Date: Tue, 19 Aug 2025 14:10:34 -0700
Message-ID: <20250819211034.3776284-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A partitioned system configured with only one package and one compute
die, warning will be generated for duplicate sysfs entry. This typically
occurs during the platform bring-up phase.

Partitioned systems expose dies, equivalent to TPMI compute domains,
through the CPUID. Each partitioned system must contains at least one
compute die per partition, resulting in a minimum of two dies per
package. Hence the function topology_max_dies_per_package() returns at
least two, and the condition "topology_max_dies_per_package() > 1"
prevents the creation of a root domain.

In this case topology_max_dies_per_package() will return 1 and root
domain will be created for partition 0 and a duplicate sysfs warning
for partition 1 as both partitions have same package ID.

To address this also check for non zero partition in addition to
topology_max_dies_per_package() > 1.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---

Non urgent as there is no such production system at this time.

 .../platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
index 6df55c8e16b7..cb4905bad89b 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
@@ -633,7 +633,7 @@ static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_
 
 	auxiliary_set_drvdata(auxdev, tpmi_uncore);
 
-	if (topology_max_dies_per_package() > 1)
+	if (topology_max_dies_per_package() > 1 || plat_info->partition)
 		return 0;
 
 	tpmi_uncore->root_cluster.root_domain = true;
-- 
2.49.0


