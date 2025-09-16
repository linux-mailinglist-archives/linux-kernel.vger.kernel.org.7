Return-Path: <linux-kernel+bounces-818790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0D7B5967B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D400321C10
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7CC14BFA2;
	Tue, 16 Sep 2025 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bCfO6Z5U"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC872625;
	Tue, 16 Sep 2025 12:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758026756; cv=none; b=CuqObbTecWq/ddC/MGIcnhOHB65ac0L1dHosHlAC5VrQ1+0NQfMDwjOxGoUKkNKJxxjUb4Sz2764hNPtM3TZOyZF64pShC6p/AmH2vvWC8EutmxqDwEN3QAM08O78W+Aa19iQ9X9LpRj+J0XRBZH9pr8+jLC9u4NxotGp6EBGew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758026756; c=relaxed/simple;
	bh=lHY9jqqaClmpApWz/enuCHVhXRLEnKRw/EDHayVYsSM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sDW9DvF7aDOZNX2hrUibaningDQY6afeDW3uWBbSqj/KFZ5USO6l7IvmeP2p9ivVMTDkDLFyLo56V9QT3MHRtFIqBcdfL3QYiy5uTr34ROO18+9+OILgd7VU7l+Q+lJQIWEqyUBOlMR97+p8kR/lWdcUTnHk2KNGufDxuWQUhW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bCfO6Z5U; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758026755; x=1789562755;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lHY9jqqaClmpApWz/enuCHVhXRLEnKRw/EDHayVYsSM=;
  b=bCfO6Z5UAZ/buvbYmJPrf5l61olNss7NugzBl6EJkcYZrqZ9J7NreOgX
   F91hYPJGgHK5FAkIOCsRBGfY4WMsjC7KDPJdBeh0iR6CHpM+S093Bxcb0
   exAnOrAWvcZgxmUFn73w5S3VH2VF7EGnb8YQJxgRXWW5hohq6I8HAoloK
   kn+83qKtffOx/rUvqCxtItcUq8WBiTpEh/HWrlTxE6/E4Y4R0/g9gES+g
   GHotlCRrcSJImDByfewbiEMUXMfNtKG6UXitFKuCxxV2t3uYV2t9yE+qy
   PmuwH+p9boaZiDoUaIb16Ko2bEwm4AT/06+D9gRwnrriXMrr/7VWHK38a
   w==;
X-CSE-ConnectionGUID: s/JbbcftQbq6Qy1X/g+xgw==
X-CSE-MsgGUID: aS59DxxRS2uAncU8r4Z7tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="77743983"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="77743983"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 05:45:55 -0700
X-CSE-ConnectionGUID: qJ9xvSQCTxK/wn+l14St7Q==
X-CSE-MsgGUID: UJiB/hK/T0qXoRQCcymPBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="175356195"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa009.fm.intel.com with ESMTP; 16 Sep 2025 05:45:51 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: nm@ti.com,
	kristo@kernel.org,
	ssantosh@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	andriy.shevchenko@linux.intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1] clk: keystone: sci-clk: use devm_kmemdup_array()
Date: Tue, 16 Sep 2025 18:15:18 +0530
Message-Id: <20250916124518.2857524-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to use devm_kmemdup_array() which is more robust.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/clk/keystone/sci-clk.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
index c5894fc9395e..a4b42811de55 100644
--- a/drivers/clk/keystone/sci-clk.c
+++ b/drivers/clk/keystone/sci-clk.c
@@ -480,13 +480,10 @@ static int ti_sci_scan_clocks_from_fw(struct sci_clk_provider *provider)
 		num_clks++;
 	}
 
-	provider->clocks = devm_kmalloc_array(dev, num_clks, sizeof(sci_clk),
-					      GFP_KERNEL);
+	provider->clocks = devm_kmemdup_array(dev, clks, num_clks, sizeof(sci_clk), GFP_KERNEL);
 	if (!provider->clocks)
 		return -ENOMEM;
 
-	memcpy(provider->clocks, clks, num_clks * sizeof(sci_clk));
-
 	provider->num_clocks = num_clks;
 
 	devm_kfree(dev, clks);
-- 
2.34.1


