Return-Path: <linux-kernel+bounces-865897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADBEBFE482
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 23:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7A81A074B0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 21:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658F430216F;
	Wed, 22 Oct 2025 21:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jttfmhjh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946562F0698;
	Wed, 22 Oct 2025 21:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761167863; cv=none; b=VI/5/fVu570AnGgxcUoAu8Px5cbaqD9nUL5YHx4fBsOqqeYH3IzSvWyNGgJ6eypbQojyms2OASEyFePqw9iIRip0J/cm486BskUTCNznfATjvEExRGuYAz0tR8YszmJK3KVBFKGobn5tgubPm+dwh8IhgXW1ljWpyGDS/8ABUPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761167863; c=relaxed/simple;
	bh=sclpuT7WvkjmnRQlVfG9mH4zGbkipTjnUhVQVYvaZM8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bjjl8ksvDpZvR9RDwsWIqqD+X7+KcOjmPKpLktoLR55Q04Hwv37SZv5/AKEEbMSojwAGZMYgh+R6yJMia1VqCcbkuF+UYhxRhCiFIWXsUw0JYQyK1oUaSvYLNRe2pfZ1EtiLHHnkg2CL1MI5BJ86oFLNW/BKL0o5xUCYHDR12yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jttfmhjh; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761167861; x=1792703861;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sclpuT7WvkjmnRQlVfG9mH4zGbkipTjnUhVQVYvaZM8=;
  b=JttfmhjhbvhtQ0rNDbztckGwnX4vNDit5rJcmnjCYaJIaUn3C8NMTLIh
   dwn6R3PlvG12FF5mgq792E74yiwE9c5Aoompq9tEfCkrfrK/2i0eYXfpR
   dZp544QZJ/jO6BNpbEf2H0jgNHaush147LurSDQD2LOlA0Nbi2gsf+YZd
   JZ59Udg362FhJEfsml++4y0MzrrymCIRGwAJs6KGI3obBhaUSL/1vBg5R
   m0TrM7wm7q5Mx3GztiKUQmPANgPKnab2qh5KYXh2g0rnJiI2q3Cto8Hz/
   nr/khI221vug1L6L4zSQK4zr/cTFA5wv7V6mtodVxxtYykGAsfLm0Xzzf
   w==;
X-CSE-ConnectionGUID: hVB8DH9rTQirMPMzayL3eQ==
X-CSE-MsgGUID: 2sD/tOMkRLqfn3oCYvayWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63367766"
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="63367766"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 14:17:41 -0700
X-CSE-ConnectionGUID: nKgXXpXgTlSX9pda04+DDw==
X-CSE-MsgGUID: lUJw4KBDTGS5sUg4t7p7Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="184461936"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 14:17:40 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] platform/x86: intel-uncore-freq: Add additional client processors
Date: Wed, 22 Oct 2025 14:17:33 -0700
Message-ID: <20251022211733.3565526-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Intel uncore frequency driver support for Pantherlake, Wildcatlake
and Novalake processors.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 .../platform/x86/intel/uncore-frequency/uncore-frequency.c    | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
index 2a6897035150..0dfc552b2802 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
@@ -256,6 +256,10 @@ static const struct x86_cpu_id intel_uncore_cpu_ids[] = {
 	X86_MATCH_VFM(INTEL_ARROWLAKE, NULL),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_H, NULL),
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M, NULL),
+	X86_MATCH_VFM(INTEL_PANTHERLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_WILDCATLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_NOVALAKE, NULL),
+	X86_MATCH_VFM(INTEL_NOVALAKE_L, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_uncore_cpu_ids);
-- 
2.43.0


