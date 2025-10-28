Return-Path: <linux-kernel+bounces-874378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB57C16289
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AB7C1C240AC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76C734CFC5;
	Tue, 28 Oct 2025 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EX1hy+K2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9A334CFC0
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761672597; cv=none; b=V9TsmYY5P9jJxCGoYxV15URPNvlUStXo3BAjBOcE0VpombjSI1ydW9cMACS2mrWraDluLtN0lYSMqCLeRQcyCMd5CMQwFc8Ol19P+wV8iSxL5Uhmqp6pCFrryD4IB0FfIa/tYnCw4Ogd43ZsizAAZjrLgAjQFg9Q+p6r7DXdSkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761672597; c=relaxed/simple;
	bh=pnJd+dGJHFKo9OXgAh2QSi15TVzeMPfUieMjDclcuRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tvqHb4I0ALXeXmu1klfzyG1jDg4HD0HsUuCN9YVLvJ77mOjn9XlEhwbf62TpuCJX0+7HAKu6QCOmn+dEtvzSleM8Nnjkio8ET1MOMnH5FtSb+1kSw2oTqYtgT+qo86zQenippvJ3GYPVBGQfbih6Nsw60+ngI9QuTylokj0gsj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EX1hy+K2; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761672595; x=1793208595;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pnJd+dGJHFKo9OXgAh2QSi15TVzeMPfUieMjDclcuRY=;
  b=EX1hy+K2PMMwTXw8oMbzFyyfu4juSVD11znz2DLIwDu2c4AplEkAec3s
   6v7aEjNmLgZOO4zHjXStV6Q+nKbtbFnUVE/ukUZ1MbDrVu11FxPGWBg3D
   MgKBPkHTx8dy2lo5ottDI27zjBxrZUhGlrrMNp38ecpN4C2dThpEEz3vf
   E8+GrE5wj+xdC8LpNzsTnAbGNmPvm/EEVJLKE/qAkJLY1wjb4/UngqZPI
   ld9Wqfs+XaJPYHBXgZ/+wl6v2XKDqkZt19dbLCLCWDPoQmg5Hm0uELEQ5
   ZTo9Q4oZDtZr+LbKTAl85z9nW97FFDJTea07fazOQEV2wxCPfL/D9ufmC
   w==;
X-CSE-ConnectionGUID: G+Xdwf5IQRq8EJlbxxlpfQ==
X-CSE-MsgGUID: GMjQNAIJSYupkzTd117i8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74071156"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="74071156"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 10:29:55 -0700
X-CSE-ConnectionGUID: h99O2UVXSfOsMUuMzF2vDA==
X-CSE-MsgGUID: tnO9XV1TQm+WLUc3UF+gVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="185497684"
Received: from tjmaciei-mobl5.ger.corp.intel.com (HELO agluck-desk3.home.arpa) ([10.124.223.37])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 10:29:55 -0700
From: Tony Luck <tony.luck@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH] x86/cpu: Add/fix core comments for {Panther,Nova} Lake
Date: Tue, 28 Oct 2025 10:29:48 -0700
Message-ID: <20251028172948.6721-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The E-core in Panther Lake is Darkmont, not Crestmont.

Nova Lake is built from Coyote Cove (P-core) and Arctic Wolf (E-core).

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/intel-family.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index f32a0eca2ae5..950bfd006905 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -150,12 +150,12 @@
 
 #define INTEL_LUNARLAKE_M		IFM(6, 0xBD) /* Lion Cove / Skymont */
 
-#define INTEL_PANTHERLAKE_L		IFM(6, 0xCC) /* Cougar Cove / Crestmont */
+#define INTEL_PANTHERLAKE_L		IFM(6, 0xCC) /* Cougar Cove / Darkmont */
 
 #define INTEL_WILDCATLAKE_L		IFM(6, 0xD5)
 
-#define INTEL_NOVALAKE			IFM(18, 0x01)
-#define INTEL_NOVALAKE_L		IFM(18, 0x03)
+#define INTEL_NOVALAKE			IFM(18, 0x01) /* Coyote Cove / Arctic Wolf */
+#define INTEL_NOVALAKE_L		IFM(18, 0x03) /* Coyote Cove / Arctic Wolf */
 
 /* "Small Core" Processors (Atom/E-Core) */
 
-- 
2.51.0


