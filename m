Return-Path: <linux-kernel+bounces-838371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F35BAF08F
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70E2D4E1CD1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F24C2882CA;
	Wed,  1 Oct 2025 02:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kezXtYn/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D495327B33A
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 02:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759287316; cv=none; b=WItGSucDU+LmtZ9YtQkya6X33whWy3cnSJFvKyjtf0MZ4ZKbwV60d63brb6BH67wXY6i5DC/xgrPUp1hGIWowibP7yC5m7LnMXmLx9BYMxILvGhwwwXRu8gfNY/rxAHu2JFXlKejJo7NYzJnIinLTVWpn4AsT7bfFm8W9lwqi8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759287316; c=relaxed/simple;
	bh=fpi5/RPbm05HDWO4cAa6H+2kjOpG/E/N/ORvroo4F8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MbhcTpzeLpGcrw02Op0oPzSM1ss4zA0wLRW5pium34JgjzUixLb5R3rEMm+ZugZDsVKFYGPkuPm4K6nsoHK10m2anoSE/bYhnZA6vhrJ2NkmRxHvuxOKvogEFtCSbkDM+HTMFZiBywZ+o2FQNk+IRAiAw22+qJaSwc6WySJeZUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kezXtYn/; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759287315; x=1790823315;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fpi5/RPbm05HDWO4cAa6H+2kjOpG/E/N/ORvroo4F8Q=;
  b=kezXtYn/i7ZLV9/fVwyVETPT3Eb+OZ7N5cpb5MlL+QfDpdWZec/E1B/9
   Lo3hCJVxDKs5PrRv5txyhmb1SU4T1S26vN/p4jW3IHguBe3SY9tTiq9pu
   cUNqfidPZpxcMn+mzn6ERTvcgt08+kcJ0/xIbqhPqH8t4GEJBwXEtlGzF
   cppfYNwUGvrLi0LKoIUJ/MmGrWe371qZArnTMdysG5Cf9tno2+iCC13Ez
   4ChtctNHSLPiYW5fJTLnHJmx8VRbyDeGRZBj2Tc8Pv4LTzuVkAIm3bBNS
   VL7JXCHsIcdF3fdXDo0fwY5CNGbrbkyKXiVcSf8moxbFPmY1RGM8LXq6G
   w==;
X-CSE-ConnectionGUID: eVg7R3zsS5WD3ntDeejiLw==
X-CSE-MsgGUID: MJwYehWVQpu17mKrZt9K6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61662300"
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="61662300"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:55:12 -0700
X-CSE-ConnectionGUID: lb3XwFedSMG2rJH2iztJLg==
X-CSE-MsgGUID: iYEM/Dp8RSOFpX5bUNUltw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="178629166"
Received: from 984fee019967.jf.intel.com ([10.165.54.94])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:55:11 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	reinette.chatre@intel.com,
	ira.weiny@intel.com,
	kai.huang@intel.com,
	dan.j.williams@intel.com,
	yilun.xu@linux.intel.com,
	sagis@google.com,
	vannapurve@google.com,
	paulmck@kernel.org,
	nik.borisov@suse.com
Cc: Chao Gao <chao.gao@intel.com>,
	"Kirill A. Shutemov" <kas@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 09/21] x86/virt/seamldr: Block TDX Module updates if any CPU is offline
Date: Tue, 30 Sep 2025 19:52:53 -0700
Message-ID: <20251001025442.427697-10-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251001025442.427697-1-chao.gao@intel.com>
References: <20251001025442.427697-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

P-SEAMLDR requires every CPU to call the SEAMLDR.INSTALL SEAMCALL during
updates.  So, every CPU should be online.

Check if all CPUs are online and abort the update if any CPU is offline at
the very beginning. Without this check, P-SEAMLDR will report failure at a
later phase where the old TDX module is gone and TDs have to be killed.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 arch/x86/virt/vmx/tdx/seamldr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index 69c059194c61..b9e025d0f0bc 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -6,6 +6,8 @@
  */
 #define pr_fmt(fmt)	"seamldr: " fmt
 
+#include <linux/cpuhplock.h>
+#include <linux/cpumask.h>
 #include <linux/irqflags.h>
 #include <linux/types.h>
 
@@ -72,6 +74,12 @@ EXPORT_SYMBOL_GPL_FOR_MODULES(seamldr_get_info, "tdx-host");
 
 int seamldr_install_module(const u8 *data, u32 size)
 {
+	guard(cpus_read_lock)();
+	if (!cpumask_equal(cpu_online_mask, cpu_present_mask)) {
+		pr_err("Cannot update TDX module if any CPU is offline\n");
+		return -EBUSY;
+	}
+
 	/* TODO: Update TDX Module here */
 	return 0;
 }
-- 
2.47.3


