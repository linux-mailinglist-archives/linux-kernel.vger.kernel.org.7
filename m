Return-Path: <linux-kernel+bounces-845552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9980ABC5581
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 16:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E3353E33B3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 14:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E35628CF66;
	Wed,  8 Oct 2025 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="FRYDrsor"
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9964528C039;
	Wed,  8 Oct 2025 14:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759932165; cv=none; b=qt8/xs8EdCsXdFdSyYBGWsu//jTk4Z+AvUCmNRYQy2glkTudRQbLJIlF+vEkItqxrCsZTHU1I/6K3RkK+ZvVOi0M+TlcukTXU/y0Z9YV3HE+KBexsBEqSwpa8J3Fka6okpGO4Sm71LffGwIOvsxQ4TQPAP+4agNPx9tR8/ACkS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759932165; c=relaxed/simple;
	bh=9Ftb8HT4U+94l+yfcnsxrP/I1TAJoIq3MmSp5vchlh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=coY0SRtnpFlbjSy/ktAiinDiFU65KlvlK4WBjJ0tm2STqN0a3iGcPTZvxST111m1SqFpPuISO5PMg8bCWYvalL26faP5dFOU203YuDdIa/9VbzPi8XFN+52j8lT5nBXW69OpPhH2RgWIe6xutp8LrGbXP6znH9+UF06LoO/VGv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=FRYDrsor; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 9C576BDC78;
	Wed,  8 Oct 2025 16:53:03 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id C44B3BD728;
	Wed,  8 Oct 2025 16:53:02 +0300 (EEST)
Received: from antheas-z13 (x5996a8de.customers.hiper-net.dk [89.150.168.222])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 97A43200AFF;
	Wed,  8 Oct 2025 16:53:00 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1759931582;
	bh=HF3GdUDqna0JtovzbxEWdz+Sil8SitjVp0gD5Y9pl0w=; h=From:To:Subject;
	b=FRYDrsorGBLIH59iqyuWuZ8efMZTRc+4l2OAHhrOLi3uK6yUeNW5+r8ndfJRrMBiV
	 VveXc8ehmK1wI2GrQ8NCeUxef9hZVxgx0ZLSHT+9QtLHvE6sayj71PJqNw8AXngy98
	 i2drsw5pFKASUs/YDPa9kDK0XewhCzBMTF1iP0xJ1kn0mR+ZMsK5VLWExGFrptlSVX
	 KWX2C7zzOP11ttAJyLWkjtEvyyc4SLRPSoJK6BPwVerMgd+CMlSOrsJ2F/cwAmiW0L
	 AynNgrqOnUjsThHDrsh8hgNhmHawDFoC4A0uC2sftAyrfBDrotSqJFLzXoJgmZVXD9
	 /eYPjCwXjSL0A==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 89.150.168.222) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: Mario Limonciello <mario.limonciello@amd.com>,
	Shyam-sundar.S-k@amd.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v1] platform/x86/amd: pmc: Add Lenovo Legion Go 2 to pmc quirk
 list
Date: Wed,  8 Oct 2025 15:50:57 +0200
Message-ID: <20251008135057.731928-1-lkml@antheas.dev>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <175993158218.2390865.6573007729673899082@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

The Lenovo Legion Go 2 takes a long time to resume from suspend.
This is due to it having an nvme resume handler that interferes
with IOMMU mappings. It is a common issue with older Lenovo
laptops. Adding it to that quirk list fixes this issue.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4618
Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/amd/pmc/pmc-quirks.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86/amd/pmc/pmc-quirks.c
index d63aaad7ef59..0fadcf5f288a 100644
--- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
+++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
@@ -204,6 +204,23 @@ static const struct dmi_system_id fwbug_list[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "82ND"),
 		}
 	},
+	/* https://gitlab.freedesktop.org/drm/amd/-/issues/4618 */
+	{
+		.ident = "Lenovo Legion Go 2",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83N0"),
+		}
+	},
+	{
+		.ident = "Lenovo Legion Go 2",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83N1"),
+		}
+	},
 	/* https://gitlab.freedesktop.org/drm/amd/-/issues/2684 */
 	{
 		.ident = "HP Laptop 15s-eq2xxx",

base-commit: a8cdf51cda30f7461a98af821e8a28c5cb5f8878
-- 
2.51.0



