Return-Path: <linux-kernel+bounces-740413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BFAB0D3E9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD5663AA03B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075A028C5BF;
	Tue, 22 Jul 2025 07:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mqppA5sP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FD843151
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753170297; cv=none; b=UzgWVdRZKl3ZDP1yXU07QORnA92VzLauawv9XX8Dbd33qbvaDjTQUvQ0vhrbbvxmocyqO+lYpy75JvbJHQK8TcdtuWbhwIxSg9p6P0RL/hsZyh6RCMz+6odx8xBfPd45voj2oPkZDmN1FWxQ//QjHSlsaLsHd8N1Yz4BAHPymjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753170297; c=relaxed/simple;
	bh=hybErL7BSol/tOg3hNY1CBv8zAJJRAFrz0H/fn7vS3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DxFR3MRJOng0WYVorm6P6TLOTfC3KjFv+24pfGgi0Off6/7Ox/f68ndUg9Hs02A6rDoczyUjPNafOwtg3qKbv8Z42LHypY3lgz+3c7zt485V4sb51+sel7InkGkWaxsPl25Xw2SRGvqboOsochKmEVSVsTPrHPqG2XHvcABxtn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mqppA5sP; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753170295; x=1784706295;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hybErL7BSol/tOg3hNY1CBv8zAJJRAFrz0H/fn7vS3o=;
  b=mqppA5sPjJn7qJmMmCO/WD+iRaNcNxG6GzUtaowC7EGtL0f+ESSfe1eD
   UzvO0abRaAiGbPYUOSk1lFsaQE0ABqZBf1XMocSvkLOsTgRam6fKqvtRA
   SxFmZY8O2enM2gyx5Daj+lOdhu1S/uT9ncac2pdoCU121n3Vqfb8YHMQd
   MiukzIFWGldnijZDXoGpaCg0Ad7casXP477xZBrRq8c/N4bAz6uk7L29U
   LUnvgfTBV9cpbZpswwwvJoUPY8OIGPiLyEMtUdq8M9CqUAi3NBivOvUN/
   KAqGyjcqDB0Mbp3m/X3sWJiXC/rpUybv/evVoMpVldGE3iPQn010UUcvN
   w==;
X-CSE-ConnectionGUID: hugtByw2QjmJKcVFiiT5IQ==
X-CSE-MsgGUID: vg0Jm9J0ReKDyxY4fm2VoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="43027859"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="43027859"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 00:44:55 -0700
X-CSE-ConnectionGUID: fEP+uouKSsa0n1pwzSQW8A==
X-CSE-MsgGUID: gZi4O0xgQ3aRYwn1HBC/BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="158382122"
Received: from savramon-mobl1 (HELO wieczorr-mobl1.intel.com) ([10.245.244.147])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 00:44:53 -0700
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] x86: Clear LAM and FRED feature bits
Date: Tue, 22 Jul 2025 09:44:38 +0200
Message-ID: <20250722074439.4069992-1-maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If LAM (CONFIG_ADDRESS_MASKING) or FRED (CONFIG_X86_FRED) are disabled
during compile time, they still are enumerated in macros such as
cpu_has() or this_cpu_has() that use the x86_capability bitmask. The
features are also visible in /proc/cpuinfo even though they are not
enabled - which is contrary to what the documentation states about the
file.

The documentation for x86/cpuinfo.rst also states how to handle features
disabled at compile time:

	The kernel disabled support for it at compile-time
	--------------------------------------------------

	For example, if Linear Address Masking (LAM) is not enabled when
	building (i.e., CONFIG_ADDRESS_MASKING is not selected) the flag
	"lam" will not show up. Even though the feature will still be
	detected via CPUID, the kernel disables it by clearing via
	setup_clear_cpu_cap(X86_FEATURE_LAM).

Clear feature bits if they are present in the DISABLED_MASK.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 arch/x86/kernel/cpu/common.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 77afca95cced..1c5af795cedc 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1782,6 +1782,16 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 	if (!pgtable_l5_enabled())
 		setup_clear_cpu_cap(X86_FEATURE_LA57);
 
+	/*
+	 * If a feature is disabled during compile time clear its feature
+	 * bit to prevent it from showing up in the x86_capability bitmask.
+	 */
+	if (!cpu_feature_enabled(X86_FEATURE_LAM))
+		setup_clear_cpu_cap(X86_FEATURE_LAM);
+
+	if (!cpu_feature_enabled(X86_FEATURE_FRED))
+		setup_clear_cpu_cap(X86_FEATURE_FRED);
+
 	detect_nopl();
 }
 
-- 
2.49.0


