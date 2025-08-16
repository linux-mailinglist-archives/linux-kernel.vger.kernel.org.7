Return-Path: <linux-kernel+bounces-772142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EABDB28F36
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 17:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489661C25547
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 15:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170831A317D;
	Sat, 16 Aug 2025 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="iCV2G5ph"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ADA13C3F6
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755358502; cv=none; b=pH7KTlI9OW8OgiOXta8V3ZOn1893AQJkdXxSuMK6DQU/pIZutCTWP9Om0GZo8IjtWIvI88IUfNYi49Rz136dBmN943IBm6EKKIIo0H1p3VuURCw8rq/B5/rsnn2WRdmtk6FszL1gYZsHPg+6beQaiQE5sOhoVFaXwkV/0tkHhII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755358502; c=relaxed/simple;
	bh=gUCmvxT1+6H9HHpzyrJbkBUZeZ+q2k9d8IA5OolinHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkOrW0XLEgPo6dITNnxCryiOlboOoarqyt6+T/lWrmHMzA1VfqYa6mvgkxn2pB83frWod55+eQJEYdbdavsQwab3at9t1TnfcAPJeWXh42yWDusamGpAe0hGPY2w5p6HFGvAO1aEdMHGjPs0OuMofbXgp1kNubmmXlNqRU+ObVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=iCV2G5ph; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 4C9A920468;
	Sat, 16 Aug 2025 17:34:52 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E4_sDYxaye6b; Sat, 16 Aug 2025 17:34:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1755358491; bh=gUCmvxT1+6H9HHpzyrJbkBUZeZ+q2k9d8IA5OolinHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iCV2G5phaOkKAVgTRG5MZmxXi3HDdurOjrArYMFgjTUHb05pEWV4DBQwwRCXp6aSR
	 Z0/6A8BQ3/3BeQ0tiNK/G+KuSiSdr6EoSP2/PerazNT6dsAUlUSvcvFUp43PAklYhW
	 zIigwlbaMI4DCF0R2u28S0KfEf99fUT/d7c7I6IYfDqNWC4ZfIPbul/3e2bpudGyGF
	 IYg28exNXh8is6y7fa8S1nurXPbQLkddSDuzWSTTSCrmYeeTHXkErmkSfBy5UcMn4R
	 hmWgzl7yV5mKVva5U00n085xFXTTuZHStYTYeG6M+bkXsKz6q6TYGhJ0LG8aUJdzvW
	 sutEXkeD3cpxQ==
From: Yao Zi <ziyao@disroot.org>
To: Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH 2/2] drm/efidrm: Match framebuffer device by id instead of driver name
Date: Sat, 16 Aug 2025 15:34:30 +0000
Message-ID: <20250816153430.51235-2-ziyao@disroot.org>
In-Reply-To: <20250816153430.51235-1-ziyao@disroot.org>
References: <20250816153430.51235-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the driver matches the platform framebuffer device registered
by sysfb through driver name, "efi-framebuffer", this is a little
confusing since this driver registers a DRM device, instead of a
framebuffer.

Moreover, we have a driver with the same name, enabled by CONFIG_FB_EFI,
that acts as a consumer of efi-framebuffer as well. They cannot be both
loaded into the kernel.

Making these two drivers coexist is sometimes useful, e.g., a
distribution may want to build fbcon into the kernel image for debugging
purpose, but keep the whole DRM subsystem enabled as module. In such
case efidrm could serve as a solution for running DRM-specific userspace
programs on platforms with only UEFI framebuffer supplied.

Let's rename the driver as "efi-display" to avoid possible confusion.
A platform_device_id table is introduced to match "efi-framebuffer"
devices.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/gpu/drm/sysfb/efidrm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sysfb/efidrm.c b/drivers/gpu/drm/sysfb/efidrm.c
index 1883c4a8604c..7f76e8961788 100644
--- a/drivers/gpu/drm/sysfb/efidrm.c
+++ b/drivers/gpu/drm/sysfb/efidrm.c
@@ -3,6 +3,7 @@
 #include <linux/aperture.h>
 #include <linux/efi.h>
 #include <linux/limits.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/screen_info.h>
 
@@ -375,10 +376,17 @@ static void efidrm_remove(struct platform_device *pdev)
 	drm_dev_unplug(dev);
 }
 
+static const struct platform_device_id efidrm_platform_id[] = {
+	{ "efi-framebuffer" },
+	{ },
+};
+MODULE_DEVICE_TABLE(platform, efidrm_platform_id);
+
 static struct platform_driver efidrm_platform_driver = {
 	.driver = {
-		.name = "efi-framebuffer",
+		.name = "efi-display",
 	},
+	.id_table = efidrm_platform_id,
 	.probe = efidrm_probe,
 	.remove = efidrm_remove,
 };
-- 
2.50.1


