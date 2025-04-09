Return-Path: <linux-kernel+bounces-596042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AB0A82625
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 15:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20A08C78CF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 13:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459CE2641C6;
	Wed,  9 Apr 2025 13:16:43 +0000 (UTC)
Received: from weierstrass.telenet-ops.be (weierstrass.telenet-ops.be [195.130.137.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109F529A0
	for <linux-kernel@vger.kernel.org>; Wed,  9 Apr 2025 13:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744204602; cv=none; b=idBx3UH/4RWLuQFGqcbhUcw3FfHxcJFnxQkc+Sd+uGsxkt0SU2yyZcRMk6DGTVVxuNTDuxRGRld7q6qTJN0cSIeL3suQbSFkO956c3UPuxWeNkuTAGhY/27JGmLjSCUDh2C90VRKW5+VKSyVdxXtN5WVGHDKkjkgcDYtP8uhZy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744204602; c=relaxed/simple;
	bh=AgR2NJ1i6IkFYhAepi/wcBw7sVFp4/vtZB2JgbedQ/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J4ufdqFmlnqHmt53zmVcV4IvCIki3PB76WjzzcHkP1rm5TOd+OaVHNnO4SSixaaQvm/oFMn1bLsjbYpzCjU2pnPBhvTBQmVfBAESRc6GKmlgA6Ocf7KcMh1Pbf6iC+53NdcXfJDlPCOByd9e7QQpAdYBwHu5gQILPu5X4XIm2eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
	by weierstrass.telenet-ops.be (Postfix) with ESMTPS id 4ZXjsw3S3xz4x1rR
	for <linux-kernel@vger.kernel.org>; Wed, 09 Apr 2025 15:07:48 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:d6c1:79b5:9acd:4fad])
	by laurent.telenet-ops.be with cmsmtp
	id b17g2E00G1LzlAN0117gX0; Wed, 09 Apr 2025 15:07:41 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1u2V9X-00000000DQW-2Bw7;
	Wed, 09 Apr 2025 15:07:40 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1u2Rdk-00000002xPc-0RiY;
	Wed, 09 Apr 2025 11:22:36 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] gpio: GPIO_BLZP1600 should depend on ARCH_BLAIZE
Date: Wed,  9 Apr 2025 11:22:35 +0200
Message-ID: <a75af4b623579a193b4a59350c063969aabb5b71.1744190524.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Blaize BLZP1600 GPIO controller is only present on BLaize BLZP1600
SoCs.  Hence add a dependency on ARCH_BLAIZE, to prevent asking the user
about this driver when configuring a kernel without Blaize platform
support.

Fixes: 602ae04f56542d8e ("gpio: Enable Blaize BLZP1600 GPIO support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpio/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index ae458fdb9da7dd8a..5f8cd5445c7121ae 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -216,6 +216,7 @@ config GPIO_BCM_XGS_IPROC
 config GPIO_BLZP1600
 	tristate "Blaize BLZP1600 GPIO support"
 	default y if ARCH_BLAIZE
+	depends on ARCH_BLAIZE || COMPILE_TEST
 	depends on OF_GPIO
 	select GPIO_GENERIC
 	select GPIOLIB_IRQCHIP
-- 
2.43.0


