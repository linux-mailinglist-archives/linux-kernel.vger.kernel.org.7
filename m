Return-Path: <linux-kernel+bounces-750563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AECB15E11
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2ADB18A3A2F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8233279DAD;
	Wed, 30 Jul 2025 10:21:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EB12A1CA
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753870915; cv=none; b=GX5cFHB6JIII+Fc9K3aWJpUyTwLst8Fu8GqSvrnMky8QuNR2Nz2ex30PIE3JYIcsB14BdswC1Yo+VHVY9jiYXu1G5G2+lWAgm0hJ+0VdPbPomrYHR5m+irLhhBnFe8XjnLnfpIr/Td5Pw6F8ZAShZA5iRifak8Eo0i9xwTyhYtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753870915; c=relaxed/simple;
	bh=W/7n3o7GVkJs3OJAfBCRoKTaULE4EaG4Ub0pJyjpHv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uxld5l2LLTUqCmq6Zj/pnuzILDBEc7RBtcr6zHXqmXqHS4TAAfsWq4V6RMt/zRCt0eJmqerr2GG3AFDZgaSjxMJ8TJ+C1zK6MqImYneoy95fbObD7Twmr2rDiunvuCIATy9YmwggoOJqqz3NS2vyMsXaPdPkw+jGHaO5K6hwdJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40F0C4CEE7;
	Wed, 30 Jul 2025 10:21:52 +0000 (UTC)
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
Subject: [PATCH] mtd: MTD_INTEL_DG should depend on DRM_I915 or DRM_XE
Date: Wed, 30 Jul 2025 12:21:49 +0200
Message-ID: <07f67ab8ee78f6bf2559131e193381aafff7479a.1753870424.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel Discrete Graphics non-volatile memory is onlt present on intel
discrete graphics devices, and its auxiliary device is instantiated by
the Intel i915 and Xe2 DRM drivers.  Hence add dependencies on DRM_I915
and DRM_XE, to prevent asking the user about this driver when
configuring a kernel without Intel graphics support.

Fixes: ceb5ab3cb6463795 ("mtd: add driver for intel graphics non-volatile memory device")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/mtd/devices/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
index 46cebde79f34b0b7..f0ab74d695347117 100644
--- a/drivers/mtd/devices/Kconfig
+++ b/drivers/mtd/devices/Kconfig
@@ -185,8 +185,8 @@ config MTD_POWERNV_FLASH
 
 config MTD_INTEL_DG
 	tristate "Intel Discrete Graphics non-volatile memory driver"
-	depends on AUXILIARY_BUS
-	depends on MTD
+	depends on AUXILIARY_BUS && MTD
+	depends on DRM_I915 || DRM_XE || COMPILE_TEST
 	help
 	  This provides an MTD device to access Intel Discrete Graphics
 	  non-volatile memory.
-- 
2.43.0


