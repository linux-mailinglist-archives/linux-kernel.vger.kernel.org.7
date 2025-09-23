Return-Path: <linux-kernel+bounces-828519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B830B94C7A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670671902C61
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D33314A90;
	Tue, 23 Sep 2025 07:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dq5ML0cC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12109274B55
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758612428; cv=none; b=HeBfzrqNNKyqnkVzgqlORL5nwWNTiL6NCWgYb2ucto9mN9RjKSC8o9gIb5o53Oyd7RVN7SXloInUokQOB7W/1QKZOfcFjvBjyUSCZNwPr41/F37wyZHItgB1zKEEaaYTS9yQayWc6VLkgwFPe0Wq4zwI6Rz5UD5gkI26inp19Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758612428; c=relaxed/simple;
	bh=6myFlC1CK6w1rVehQpcoGacR5EUWCcwDBd9TkNQbhus=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z58Mz7fc21Z1nSxG/rHodxQpby2gmwzBqwxv64aSWr4LEpepev159gt3sIOxCHbS/9FQ6iixbTx+gchhS3NHZPIiinEmaIptkzzLpXp8TNA2dvdxMSHZASEnKHkEmKoAyq4IxmSVYDdyG/KCC3EoVMXpl4lPgul4hDkwP5zD+uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dq5ML0cC; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758612427; x=1790148427;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6myFlC1CK6w1rVehQpcoGacR5EUWCcwDBd9TkNQbhus=;
  b=Dq5ML0cCzbRRuAndI54EfSgYj9DaQe6fHtobgz2Gkc5Ng+8uBSw4Lviy
   PhDY51ejoo2Ukho3e8iTe9Qse8o2LpZ3gWht2wDqrF12l9gnMRvv6fArl
   sLw17FomZBOYywBmgssDWBTjni4wJud9fcVCyJTbJTsEZUIgjVIYIVA4U
   30eetOCvaFh+4EABEo5Lu1ZOUcZwqtAoF8a10Pe6uQhjFzfs9RKyI1l5n
   zUp6BfcsLZtfWCaiyT/lsXqZJzzAPEBCktT9YzP0UstAmIDs8OQPAunTv
   CyDD0f5nuEA0VETFLNWhWL5bklI+lJoQfpbN4oYAn0Wx7R1gmUScLdub7
   w==;
X-CSE-ConnectionGUID: YxIhMTbqRs2BV2gbPfvPsQ==
X-CSE-MsgGUID: rG7LRlRRRjC2vbGnBgZ0LA==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="71991837"
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="71991837"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 00:27:06 -0700
X-CSE-ConnectionGUID: xuskoAyzTZe102L7dBR3Jw==
X-CSE-MsgGUID: O6jacqblRMCz9D5ujGmtpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="177063907"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa008.fm.intel.com with ESMTP; 23 Sep 2025 00:27:03 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: sudeep.holla@arm.com,
	gregkh@linuxfoundation.org,
	dakr@kernel.org,
	rafael@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] arch_topology: Fix incorrect error check in topology_parse_cpu_capacity()
Date: Tue, 23 Sep 2025 12:55:20 +0530
Message-Id: <20250923072520.3964688-1-kaushlendra.kumar@intel.com>
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

PTR_ERR_OR_ZERO(cpu_clk) returns:
- 0 if cpu_clk is a valid pointer or NULL
- error code if cpu_clk is an error pointer

Therefore !PTR_ERR_OR_ZERO(cpu_clk) is true for both valid pointers and
NULL, causing the code to call clk_get_rate(NULL) when of_clk_get()
returns NULL. Replace with IS_ERR_OR_NULL() which correctly identifies
only valid pointers, ensuring clk_get_rate() is called only with valid
clock objects.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
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


