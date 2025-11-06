Return-Path: <linux-kernel+bounces-888394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7E7C3AAC3
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B2FF4E5FE8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173F7313E38;
	Thu,  6 Nov 2025 11:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jvcy2Ycf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCAA2E0406
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429596; cv=none; b=OP1qk6SPj4ANV8g/753Pwe+mNZNxM9SeWJc5JckeEZbFaOAj/TUsEkxJ5Gz/KFxDVCX+gQAebxt/bXEHW//DXQHSc9T0Cu6xlW7I4gaAZQf8cr0NYpxBsOyE9kxFC0ieJISrdDfThfsZmc5m6FHmAy0wbRbIrsBfCitNU0EMClA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429596; c=relaxed/simple;
	bh=jtGVnAw7hGw7A86rWQx2BybPyMp2c9/oRFnEqktD72c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZMWItfzSU7WaguOTM6qKKacACOYJbAdYpgnFSM/DUzHBwGT7Rn8bimO+gArkO1aVI4igzROfAXzNK+7HdFis6tOKb9TiBhMGQFLPM+HHVUf6briTSoM84nDpjMEHNv9YcC98Nqj80NWsK42XjUu+dUj5hTXWqCnBAFRQ0yhIqYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jvcy2Ycf; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762429595; x=1793965595;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jtGVnAw7hGw7A86rWQx2BybPyMp2c9/oRFnEqktD72c=;
  b=Jvcy2YcfMrgN7Gi+uWVdJC6Qb0noJ+ovEV2Qv4nXOTN7XoFvigBzgaV0
   FDaJ2fL2uTaV5rYsw3UQXwgqVKCrd+tJmMJnPsG/ucs1EWAdj2HOMtlrn
   Xuo5N4otgkL47uwpntsjd4cnpafn0x6aIGMYeb8xMRAeSChWZAj2MpCid
   vjuiPgLpdVnHnemDGnau5qd+kL1/7GKktiQf1ePSDJaGg6D8JtawboPkF
   IfVOjE+jx+aTFB4yl78DebNvPHdvYmBkdC4ukRYfkciKpPxRKB+zpmfDi
   3dhZV4KGz79eysu8z8thwmomC5WSGQQYvjT0PCOI75oplsGdBMa5Bt64x
   Q==;
X-CSE-ConnectionGUID: hWnfSXnUT3KKLhq79wvZaQ==
X-CSE-MsgGUID: GN706/XEQOCrblEhHFUllQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="81966323"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="81966323"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 03:46:34 -0800
X-CSE-ConnectionGUID: tKM8SudVTDuHVuG6/mJYig==
X-CSE-MsgGUID: zeWtXRMXSAWMKcUokAYHCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="218400319"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 06 Nov 2025 03:46:33 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 45DCA95; Thu, 06 Nov 2025 12:46:32 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Joy Zou <joy.zou@nxp.com>,
	linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] regulator: pf9453: Fix kernel doc for mux_poll()
Date: Thu,  6 Nov 2025 12:46:28 +0100
Message-ID: <20251106114628.2302762-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The validator is not happy:

Warning: drivers/regulator/pf9453-regulator.c:303 This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Update the kernel-doc accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/regulator/pf9453-regulator.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/pf9453-regulator.c b/drivers/regulator/pf9453-regulator.c
index 4cd7a9068836..cdb80f9d1bd7 100644
--- a/drivers/regulator/pf9453-regulator.c
+++ b/drivers/regulator/pf9453-regulator.c
@@ -289,13 +289,15 @@ static int pf9453_pmic_write(struct pf9453 *pf9453, unsigned int reg, u8 mask, u
 }
 
 /**
- * pf9453_regulator_enable_regmap for regmap users
+ * pf9453_regulator_enable_regmap - enable regulator for regmap users
  *
  * @rdev: regulator to operate on
  *
  * Regulators that use regmap for their register I/O can set the
  * enable_reg and enable_mask fields in their descriptor and then use
  * this as their enable() operation, saving some code.
+ *
+ * Return: %0 on success, or negative errno.
  */
 static int pf9453_regulator_enable_regmap(struct regulator_dev *rdev)
 {
@@ -314,13 +316,15 @@ static int pf9453_regulator_enable_regmap(struct regulator_dev *rdev)
 }
 
 /**
- * pf9453_regulator_disable_regmap for regmap users
+ * pf9453_regulator_disable_regmap - disable regulator for regmap users
  *
  * @rdev: regulator to operate on
  *
  * Regulators that use regmap for their register I/O can set the
  * enable_reg and enable_mask fields in their descriptor and then use
  * this as their disable() operation, saving some code.
+ *
+ * Return: %0 on success, or negative errno.
  */
 static int pf9453_regulator_disable_regmap(struct regulator_dev *rdev)
 {
@@ -339,7 +343,7 @@ static int pf9453_regulator_disable_regmap(struct regulator_dev *rdev)
 }
 
 /**
- * pf9453_regulator_set_voltage_sel_regmap for regmap users
+ * pf9453_regulator_set_voltage_sel_regmap - set voltage for regmap users
  *
  * @rdev: regulator to operate on
  * @sel: Selector to set
@@ -347,6 +351,8 @@ static int pf9453_regulator_disable_regmap(struct regulator_dev *rdev)
  * Regulators that use regmap for their register I/O can set the
  * vsel_reg and vsel_mask fields in their descriptor and then use this
  * as their set_voltage_vsel operation, saving some code.
+ *
+ * Return: %0 on success, or negative errno.
  */
 static int pf9453_regulator_set_voltage_sel_regmap(struct regulator_dev *rdev, unsigned int sel)
 {
@@ -397,7 +403,7 @@ static int find_closest_bigger(unsigned int target, const unsigned int *table,
 }
 
 /**
- * pf9453_regulator_set_ramp_delay_regmap
+ * pf9453_regulator_set_ramp_delay_regmap - set ramp delay for regmap users
  *
  * @rdev: regulator to operate on
  * @ramp_delay: desired ramp delay value in microseconds
@@ -405,6 +411,8 @@ static int find_closest_bigger(unsigned int target, const unsigned int *table,
  * Regulators that use regmap for their register I/O can set the ramp_reg
  * and ramp_mask fields in their descriptor and then use this as their
  * set_ramp_delay operation, saving some code.
+ *
+ * Return: %0 on success, or negative errno.
  */
 static int pf9453_regulator_set_ramp_delay_regmap(struct regulator_dev *rdev, int ramp_delay)
 {
-- 
2.50.1


