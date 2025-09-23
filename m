Return-Path: <linux-kernel+bounces-828634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC88CB950F5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11CE319022BE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354A231D723;
	Tue, 23 Sep 2025 08:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F5M8C8MF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1270F313536
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758617276; cv=none; b=oVscs6BXhCJ/hwuNLSRSeomuUC4spdeqcXR/SztHH+10geFyrDZjV88h+iNGfncO0KdyWfcBpmy3djsbRXL7GMTEaOzqM0s+fyrXtpEFEzjCEn34cxsnhcjxGZKdYkpCTt4PNWN6V6hXDYoUF336xuXIDfl2g+iaNc7HlGtp+TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758617276; c=relaxed/simple;
	bh=EV1zd4AkkdxOI/08ptzWcjypgJi6CVByLQ/Rsmtx2e0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R1xgXivxDSMZBhVOc/ps8CKD6baeLr9aXE1b5E/MS9QP4sMilx9V3mysnRJEGSaV2A0OS93vUvZXELuzc3OSKNAvKNbROoDZsq9Bii4cxUTiPeNzDKePJQBBzZaPwfyzNDxRhFXwO6JgLrX/+MLu9Ex0cNMFJbD/BhivGYBlf14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F5M8C8MF; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758617276; x=1790153276;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EV1zd4AkkdxOI/08ptzWcjypgJi6CVByLQ/Rsmtx2e0=;
  b=F5M8C8MFsMY3Qk96jqMJzZGO5eYoGs0pqXTueuGFlwfkECeHF9d1Rf8Z
   zLYURSMdpLbC+uJjFMla5y+8BNrvERUWliP+5vANRsxSl7RgPivvcWCRo
   pckuFJZFyYg5JSuQ+Q1AcJUQqDryqrNIJyybbIxprPT6bw1kAzDrF1bUT
   e5jZLj8V56UrBJXuj0u9upIT+uP2Fz+UKt3icqOdgdmEFvGMLYSPZlHnS
   6LFAppRlVszwQOf5wRnRujeycFvau8g+YXAmV0xiuSdavHOLC/SPZZh4h
   Qh3rpnNqXBP8dMvrLmgldmGAAy/lXKFVdDqCTO4oYElMWJLCCpGQmKdSW
   w==;
X-CSE-ConnectionGUID: QX/iA2ULQomBEcTlH/VjmQ==
X-CSE-MsgGUID: ppBopSgbTd6PEqHNUSmf+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="60591199"
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="60591199"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 01:47:55 -0700
X-CSE-ConnectionGUID: 7dlSf7j7T2GKgf5agGGDxw==
X-CSE-MsgGUID: qabyeYXFTuiYYM1YSmOK8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="207463645"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa002.jf.intel.com with ESMTP; 23 Sep 2025 01:47:52 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: sudeep.holla@arm.com,
	gregkh@linuxfoundation.org,
	dakr@kernel.org,
	rafael@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH v2] arch_topology: Fix incorrect error check in topology_parse_cpu_capacity()
Date: Tue, 23 Sep 2025 14:16:10 +0530
Message-Id: <20250923084610.3995594-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix incorrect use of PTR_ERR_OR_ZERO() in topology_parse_cpu_capacity()
which causes the code to proceed with NULL clock pointers. The current
logic uses !PTR_ERR_OR_ZERO(cpu_clk) which evaluates to true for both
valid pointers and NULL, leading to potential NULL pointer dereference
in clk_get_rate().

Per include/linux/err.h documentation, PTR_ERR_OR_ZERO(ptr) returns:
"The error code within @ptr if it is an error pointer; 0 otherwise."

This means PTR_ERR_OR_ZERO() returns 0 for both valid pointers AND NULL
pointers. Therefore !PTR_ERR_OR_ZERO(cpu_clk) evaluates to true (proceed)
when cpu_clk is either valid or NULL, causing clk_get_rate(NULL) to be
called when of_clk_get() returns NULL.

Replace with !IS_ERR_OR_NULL(cpu_clk) which only proceeds for valid
pointers, preventing potential NULL pointer dereference in clk_get_rate().

Fixes: b8fe128dad8f ("arch_topology: Adjust initial CPU capacities with current freq")

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
Changes in v2:
- Refined description based on documented macro properties (suggested by Markus Elfring)
- Added proper Fixes
---
 drivers/base/arch_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 1037169abb45..e1eff05bea4a 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -292,7 +292,7 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 		 * frequency (by keeping the initial capacity_freq_ref value).
 		 */
 		cpu_clk = of_clk_get(cpu_node, 0);
-		if (!PTR_ERR_OR_ZERO(cpu_clk)) {
+		if (!IS_ERR_OR_NULL(cpu_clk)) {
 			per_cpu(capacity_freq_ref, cpu) =
 				clk_get_rate(cpu_clk) / HZ_PER_KHZ;
 			clk_put(cpu_clk);
-- 
2.34.1


