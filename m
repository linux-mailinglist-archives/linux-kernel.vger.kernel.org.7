Return-Path: <linux-kernel+bounces-596043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EBFA82628
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 15:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8658C4DEE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 13:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E230264611;
	Wed,  9 Apr 2025 13:16:44 +0000 (UTC)
Received: from weierstrass.telenet-ops.be (weierstrass.telenet-ops.be [195.130.137.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE5A4C80
	for <linux-kernel@vger.kernel.org>; Wed,  9 Apr 2025 13:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744204604; cv=none; b=BOheWVG327xELYG6DMnCMBjcDyvjuI/WzTmRzcxDDF9TxVmIHYgBCiW9xn0j4wORdwMIgETA/XcjvccYTpxc/zpeQTDL93ibAwW+781JzkyggaCfSU908Hv+OFJAHxz4HscIIfac5fXL+i1H2wG7EQvDoGtH3aGPGCCW3msn6lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744204604; c=relaxed/simple;
	bh=fNfs/oRPqDo6ajZ+Hk2Cy7Qm/2Gft469D9o4g4l5xXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tk/RtJBg3xECdDAKKmTJA8NAB5+O9Ht0495Yh3S00ZudLBFrXZUPzkALXMzhpHo6s98tEDI1CGo2F70ThzGpgBFTX7K4BjJ9S2igqjjnaSPiELgWx2CdNCvlbndwwC5lcYB//t75P9v5jWMVzo1bYFv/dZUpxXmy0AWYAtglikU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
	by weierstrass.telenet-ops.be (Postfix) with ESMTPS id 4ZXjsw3mhdz4x2w1
	for <linux-kernel@vger.kernel.org>; Wed, 09 Apr 2025 15:07:48 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:d6c1:79b5:9acd:4fad])
	by michel.telenet-ops.be with cmsmtp
	id b17g2E00N1LzlAN0617g3f; Wed, 09 Apr 2025 15:07:41 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1u2V9X-00000000DQa-2WGZ;
	Wed, 09 Apr 2025 15:07:40 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1u2Rcu-00000002xNn-2keI;
	Wed, 09 Apr 2025 11:21:44 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Kerem Karabay <kekrby@gmail.com>,
	Aditya Garg <gargaditya08@live.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] HID: HID_APPLETB_BL and HID_APPLETB_KBD should depend on X86
Date: Wed,  9 Apr 2025 11:21:42 +0200
Message-ID: <4b046ce1cae2170453037c7ea006c91c12383dab.1744190441.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Apple Touch Bar is only present on x86 MacBook Pros.  Hence add a
dependency on X86, to prevent asking the user about this driver when
configuring a kernel for a different architecture.

Fixes: 1fd41e5e3d7cc556 ("HID: hid-appletb-bl: add driver for the backlight of Apple Touch Bars")
Fixes: 93a0fc48948107e0 ("HID: hid-appletb-kbd: add support for automatic brightness control while using the touchbar")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/hid/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index a503252702b7b43c..43859fc757470caf 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -151,6 +151,7 @@ config HID_APPLEIR
 config HID_APPLETB_BL
 	tristate "Apple Touch Bar Backlight"
 	depends on BACKLIGHT_CLASS_DEVICE
+	depends on X86 || COMPILE_TEST
 	help
 	  Say Y here if you want support for the backlight of Touch Bars on x86
 	  MacBook Pros.
@@ -163,6 +164,7 @@ config HID_APPLETB_KBD
 	depends on USB_HID
 	depends on BACKLIGHT_CLASS_DEVICE
 	depends on INPUT
+	depends on X86 || COMPILE_TEST
 	select INPUT_SPARSEKMAP
 	select HID_APPLETB_BL
 	help
-- 
2.43.0


