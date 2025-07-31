Return-Path: <linux-kernel+bounces-751801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8E7B16DA2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 424877AE2C3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0981B29DB77;
	Thu, 31 Jul 2025 08:35:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB2C3597E
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753950922; cv=none; b=hWDoUI2KnLZBba25JApuNhmaLYenbB3QDCKfzWXnYroxvWmQ9e6P08lHJ+G3yaPgmm4jKoz4NmJ7olYGQ1jtOYTqBxM+wClZeDs8sK/0jwNl5p7c6eJvk7DMQ+SfSv+ctOqhqwy7HAhSvGejGYEBrVQKb07ayHvWred7HW9Giqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753950922; c=relaxed/simple;
	bh=9ZzfdDqkqPAnIGIP9V1bnNr9rTdSPGJsjPzr9hqHgQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wi8nS1qnVeDRfK4Ac6L0/YJ9YyCH9wa94bSOV6iLk2YIjUtfpownjWtcGzfCq/p4QRUQn4WVAKxWXUxSwKw9Y0qQihTJvYY/4O55jV2LMCDluImPgqfV6q1sG/pLV60XRWuFFsb7F/HJtLfpZ7l9yvz+EjUPn2461hFiPpdRJUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BAD0C4CEF7;
	Thu, 31 Jul 2025 08:35:19 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tomas Winkler <tomasw@gmail.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Raag Jadav <raag.jadav@intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>
Cc: linux-mtd@lists.infradead.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] mtd: MTD_INTEL_DG should depend on DRM_I915 or DRM_XE
Date: Thu, 31 Jul 2025 10:35:14 +0200
Message-ID: <def775b1d7afe43720d2a1778735e764a01cb017.1753950712.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel Discrete Graphics non-volatile memory is only present on Intel
discrete graphics devices, and its auxiliary device is instantiated by
the Intel i915 and Xe2 DRM drivers.  Hence add dependencies on DRM_I915
and DRM_XE, to prevent asking the user about this driver when
configuring a kernel without Intel graphics support.

Fixes: ceb5ab3cb6463795 ("mtd: add driver for intel graphics non-volatile memory device")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Use !=n as MTD_INTEL_DG can be built-in when DRM_I915 and DRM_XE are
    modular,
  - s/onlt/only/,
  - s/intel/Intel/.
---
 drivers/mtd/devices/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
index 46cebde79f34b0b7..e518dfeee654268a 100644
--- a/drivers/mtd/devices/Kconfig
+++ b/drivers/mtd/devices/Kconfig
@@ -185,8 +185,8 @@ config MTD_POWERNV_FLASH
 
 config MTD_INTEL_DG
 	tristate "Intel Discrete Graphics non-volatile memory driver"
-	depends on AUXILIARY_BUS
-	depends on MTD
+	depends on AUXILIARY_BUS && MTD
+	depends on DRM_I915!=n || DRM_XE!=n || COMPILE_TEST
 	help
 	  This provides an MTD device to access Intel Discrete Graphics
 	  non-volatile memory.
-- 
2.43.0


