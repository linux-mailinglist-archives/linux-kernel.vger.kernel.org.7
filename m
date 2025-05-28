Return-Path: <linux-kernel+bounces-665597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED05AC6B58
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 16:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C473F4E4468
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 14:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275D1288CA8;
	Wed, 28 May 2025 14:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="islx2qSV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AC028A70C
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 14:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748441150; cv=none; b=A1CxR1iUalyAVQHYwNKGnoCbLZGMpiGfENJbifxzLsdK6uMT9Zoj5dFDkFhrg3/GQ3AVZsFUzgDeSXPSMUASHkQdZE5X+JdR7UCZHSP09czAD6TzeoOu1z7zuXmXWBEiRffCfS/l52uy96GhT/KLRSYA2mOPxc7QnkFHzqTZBsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748441150; c=relaxed/simple;
	bh=brHnIOdScb0KxCyYh6StjKNndkZEaHPzreNgxMkxZxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QyQzTL9JTCO+EIuNaRfL7X0GCg3Lj6KVij/90vjnhsnQMXy51do/XqoEjEgTJNWnzcU8igfcLl3+lME1SexWyVEinWOxtAAykin73xWBIHbQslCguQmWlom8yCjgUbvCgTB3jtanPsrxxYXvWSz63er/fvDrhj8VmUeGmMZTn2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=islx2qSV; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748441149; x=1779977149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=brHnIOdScb0KxCyYh6StjKNndkZEaHPzreNgxMkxZxU=;
  b=islx2qSVno8YcvcRs54gjUr2Cis2TjQq8e2T1K3Ni7hGIA3gV2tu68BV
   T5FwYRXeboNC1WrdXuQ3dy0mrW8U+HINXC8Fp0TRinmKBpuGPV6mK4xLM
   T2xMe4677Sqdt2EHtdeF9/7UOhrIlB5UOEfZvu4PzMUG0LZ78yJ4e4QEY
   Bs/h9SZHu4B2956O6N+/hcrfwcipLHUGoukKkoY1kgpV7vcWB+GaQz85l
   pAZQQkJdHrEuqxM0RVE7WI6c+dLq+VRa1eRZ6o/rtXShJEMquHKjjchh8
   6oNR8PEIvOn4/kLvtr7KXYBAUYkbMxi06br6g4GLFRXis+j/djDkzG8WY
   w==;
X-CSE-ConnectionGUID: UqM9+zbLQTaOy+4YhKurwQ==
X-CSE-MsgGUID: /cm7mwk/TxmrEc7QBBqU+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="61525118"
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="61525118"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 07:05:49 -0700
X-CSE-ConnectionGUID: kpI1v/bwQx6zKE3xrzpgNQ==
X-CSE-MsgGUID: D/YINYFmRDW52AGrLXEWBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="143239097"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 07:05:42 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Karthik Poosa <karthik.poosa@intel.com>,
	Raag Jadav <raag.jadav@intel.com>
Cc: Reuven Abliyev <reuven.abliyev@intel.com>,
	Oren Weil <oren.jer.weil@intel.com>,
	linux-mtd@lists.infradead.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Alexander Usyskin <alexander.usyskin@intel.com>
Subject: [PATCH v11 07/10] drm/i915/nvm: add support for access mode
Date: Wed, 28 May 2025 16:51:12 +0300
Message-ID: <20250528135115.2512429-8-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528135115.2512429-1-alexander.usyskin@intel.com>
References: <20250528135115.2512429-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check NVM access mode from GSC FW status registers
and overwrite access status read from SPI descriptor, if needed.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/gpu/drm/i915/intel_nvm.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/intel_nvm.c b/drivers/gpu/drm/i915/intel_nvm.c
index ae7f9f2c01bf..4624cba26fa7 100644
--- a/drivers/gpu/drm/i915/intel_nvm.c
+++ b/drivers/gpu/drm/i915/intel_nvm.c
@@ -11,6 +11,7 @@
 #include "intel_nvm.h"
 
 #define GEN12_GUNIT_NVM_SIZE 0x80
+#define HECI_FW_STATUS_2_NVM_ACCESS_MODE BIT(3)
 
 static const struct intel_dg_nvm_region regions[INTEL_DG_NVM_REGIONS] = {
 	[0] = { .name = "DESCRIPTOR", },
@@ -23,6 +24,28 @@ static void i915_nvm_release_dev(struct device *dev)
 {
 }
 
+static bool i915_nvm_writable_override(struct drm_i915_private *i915)
+{
+	bool writable_override;
+	resource_size_t base;
+
+	if (IS_DG1(i915)) {
+		base = DG1_GSC_HECI2_BASE;
+	} else if (IS_DG2(i915)) {
+		base = DG2_GSC_HECI2_BASE;
+	} else {
+		drm_err(&i915->drm, "Unknown platform\n");
+		return true;
+	}
+
+	writable_override =
+		!(intel_uncore_read(&i915->uncore, HECI_FWSTS(base, 2)) &
+		  HECI_FW_STATUS_2_NVM_ACCESS_MODE);
+	if (writable_override)
+		drm_info(&i915->drm, "NVM access overridden by jumper\n");
+	return writable_override;
+}
+
 int intel_nvm_init(struct drm_i915_private *i915)
 {
 	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
@@ -44,7 +67,7 @@ int intel_nvm_init(struct drm_i915_private *i915)
 
 	nvm = i915->nvm;
 
-	nvm->writable_override = true;
+	nvm->writable_override = i915_nvm_writable_override(i915);
 	nvm->bar.parent = &pdev->resource[0];
 	nvm->bar.start = GEN12_GUNIT_NVM_BASE + pdev->resource[0].start;
 	nvm->bar.end = nvm->bar.start + GEN12_GUNIT_NVM_SIZE - 1;
-- 
2.43.0


