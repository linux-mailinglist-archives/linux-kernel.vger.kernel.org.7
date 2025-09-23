Return-Path: <linux-kernel+bounces-828735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA55B954F0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 949252E0EA7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC08320394;
	Tue, 23 Sep 2025 09:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PoPoRjrp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DB21946DF;
	Tue, 23 Sep 2025 09:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620819; cv=none; b=XpmPU2mVEPUKGV7jnBI3caFymHzZkCqrrwYY2FwEAjhk9wufYufUSk5jMfmlmLMZMZuPgSw7+vJkb3rV1TqHRVHbfXr5HGwZMzZZ1omQNrPsyJJLXkDipTePNxRDgL7QvAFuYYIofLw/ajVvWXW5pXpse41TeOnqZtiryeg5lBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620819; c=relaxed/simple;
	bh=fu5vlPK/9xyLPBBcQzFmCAfW3OHTqXZK2tVrCCEANp4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nEFIRX8i6Y9IfMbaSGe67sIdJOM1t7ZpLyFos8olxVlKXyLZlhCYeySoBL0FgMx56irvn2qkv9gmrmACiduxflKhtWfxQ4r/XnS+kGoE0EBcsH5Qel0ARQ/N+p62tffAX8YQ4exgUqum5u2ubJOv9q7/eNnoQMjmW02kn2YSwOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PoPoRjrp; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758620819; x=1790156819;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fu5vlPK/9xyLPBBcQzFmCAfW3OHTqXZK2tVrCCEANp4=;
  b=PoPoRjrpeFZzjXfnsYVCZ0Z1r/BxcGy9IadbmcRXYwj4jbKFfgMTuF+G
   u5WIpW5haEPxxiquDFDN0rKlLtM78nzqTaF4a02KOm6ITF61VABclBb51
   7tqqcLMZwr9KBrV9G8OnOu7u6soMFdlKE7hpPQD9CkGJB7uUoi9tWBa5d
   7e4mx7HSgaly/K3GbSew7RaqN6XuDMy6TX3vHYOi9YXfcWiLKgkxeISVN
   dQ2PqS+6I+G5MqQ6SuZEbHKUvZGggL6Jz+f0HKgkEY4lNheP3gusLeg6O
   hya5cpmO3kvtwdIb4zCbEJ/5LZ9gLQaYlQKNOutSYwZjBu/xlIIOspKxD
   Q==;
X-CSE-ConnectionGUID: tcC2BvokQdyKCRlDD+TbuA==
X-CSE-MsgGUID: b0jEbkNAQDe5XTiNozpMVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="83500070"
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="83500070"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 02:46:58 -0700
X-CSE-ConnectionGUID: oO7Lgmy9RFuz4ouTggJVGQ==
X-CSE-MsgGUID: z7q0qx8FRd2rpU5oPKwAYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="207474935"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa002.jf.intel.com with ESMTP; 23 Sep 2025 02:46:55 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: sudeep.holla@arm.com,
	gregkh@linuxfoundation.org,
	dakr@kernel.org,
	rafael@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] arch_topology: Fix incorrect error check in topology_parse_cpu_capacity()
Date: Tue, 23 Sep 2025 15:15:14 +0530
Message-Id: <20250923094514.4068326-1-kaushlendra.kumar@intel.com>
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
Cc: stable@vger.kernel.org

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
Changes in v3:
- Used accurate "function call properties" terminology in commit description
  (suggested by Markus Elfring)
- Added stable backport justification
- Removed duplicate marker line per kernel documentation

Changes in v2:
- Refined description based on documented macro properties (suggested by Markus Elfring)
- Added proper Fixes

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


