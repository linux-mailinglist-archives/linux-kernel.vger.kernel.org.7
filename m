Return-Path: <linux-kernel+bounces-833599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCE2BA2626
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 06:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D116241B4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 04:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1440526A087;
	Fri, 26 Sep 2025 04:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iLaB8C/o"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B41F149E17
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 04:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758860722; cv=none; b=a1KJcP9h3tBIVjWAYYTBtWMTkmJf2oiV+bwMafP5i9Od4zS63n3k2HoncaohXcj2ZjlxHZM4YPfoHwxpMVKIvi6hkF5Ah1HFswc3SGBlGqB6UMRohL7YRgM5Id7tY18owHDcvq1BDiIpBIKgbOHMhzSLQkON/A96JbjbMmz+rCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758860722; c=relaxed/simple;
	bh=uldjigRkWG2Q+BGXcfhiSs1Fxgay83W5sxr5mCrJEDM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kovN+9aJRm+98XgqzFxyU5xL+A1hX5H89UFiPvB2SFxoD1uH+0JpFa2fbtMaXkEpWiL93TjXRpw/Bh5FPqZ+ywPsA9NnfzZ/PThFeB5bRvGejywILBacWEptxHfOPz+m9Px6OjcCKA1EcMUaDECVddOG6XEjIBe7LuFx8d5r8hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iLaB8C/o; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758860720; x=1790396720;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uldjigRkWG2Q+BGXcfhiSs1Fxgay83W5sxr5mCrJEDM=;
  b=iLaB8C/oxKMqfMiN9ZKezdxqE2sdzoG7fwtCwVO1rcxt6hInVM28ORLF
   7EVNEFSy9oPGTTwvuiq0AMr6FXEJnPt1Es6jiBrmo/Gg/TKu7yq8L6wCf
   5G+GZz85Rm34w+Ne5nH8TfYfoWe5dsQOpjorsRw9brXzeWjb1Sj00L3Jf
   7/u7OSlg9PxKpjwTqRJWxChcOP5uJj8clQbMpHMmz9NE+ARWbVpRYt2OZ
   +PwrRyChQ1y1Exn1Dd54uyysNy+rke648Cn1KcZNFf6Lg+SMpDaeXrXXR
   w95FGifUzwwhkE22VsyfBj+gfHezL8eqvmNgfn0SH9hn6eGtNiaImIaIY
   w==;
X-CSE-ConnectionGUID: 6i5z0XMYTPG/YQpcmj3JzA==
X-CSE-MsgGUID: qxLwrPX6S2az4HKqyy9kqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="86633403"
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; 
   d="scan'208";a="86633403"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 21:25:19 -0700
X-CSE-ConnectionGUID: Cg34d+6kQXe90r+NNcvY0A==
X-CSE-MsgGUID: B1yX1PnfReORPBCY0EWF4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; 
   d="scan'208";a="201185120"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by fmviesa002.fm.intel.com with ESMTP; 25 Sep 2025 21:25:17 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>
Cc: Fenghua Yu <fenghuay@nvidia.com>,
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
	"Peter Newman" <peternewman@google.com>,
	"James Morse" <james.morse@arm.com>,
	"Babu Moger" <babu.moger@amd.com>,
	"Drew Fustini" <dfustini@baylibre.com>,
	"Dave Martin" <Dave.Martin@arm.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH] x86/resctrl: Support Sub-NUMA Cluster (SNC) mode on Clearwater Forest
Date: Fri, 26 Sep 2025 12:17:22 +0800
Message-Id: <20250926041722.510371-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clearwater Forest supports SNC mode. Add it to the snc_cpu_ids[] table.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index c261558276cd..6691b6937240 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -285,6 +285,7 @@ static const struct x86_cpu_id snc_cpu_ids[] __initconst = {
 	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X, 0),
 	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X, 0),
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X, 0),
+	X86_MATCH_VFM(INTEL_ATOM_DARKMONT_X, 0),
 	{}
 };
 
-- 
2.25.1


