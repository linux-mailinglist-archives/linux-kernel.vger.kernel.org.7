Return-Path: <linux-kernel+bounces-892965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 818CCC463AB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CB324EB51B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FCB3090CD;
	Mon, 10 Nov 2025 11:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAA72F0R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78552309DA0;
	Mon, 10 Nov 2025 11:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773856; cv=none; b=Cf+uCQwXcwul60DinKWqR3DD/jVlljkQTiO9jdCIKbWVJAX6Lv50fAtzzFFE0xL1rz2frYFTUkE0nH8wMao0/rYo52yCgX1ipypHfN6HbBCWhp4cOI7P5bfxrjD4Tn7kx7aOJ28aS8KXHRJV5MCfBLEbmaTjMb2c/4lUkilOvx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773856; c=relaxed/simple;
	bh=E43Z5Y8tSJqRgamwuiELwt0g0OSF4ium8fxWSOTU1R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VD9B1okLuQ+1tJV7cq83F8PRSGqnlY2NrHUWbyIKsbOlntoOgXNk/k17pBR4X4hW1Zjr/6kY0cv7f5G/y0oFBuzBI7hIm9OYbgWwRXEJF5SvaIJIidCT7eqyJXVkKt4x5gnvqIFiLpaZmn1rsBnhiHtepDe2VugEAvIPTcW3Npg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAA72F0R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35921C116D0;
	Mon, 10 Nov 2025 11:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762773856;
	bh=E43Z5Y8tSJqRgamwuiELwt0g0OSF4ium8fxWSOTU1R0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mAA72F0Rq4I2u6jvTdEFPVqAmJ7fTvOkaDGoyA/T7bzy/+LP2SlPPIPQ9a0yDj04s
	 kdMhf90x5TnvmpJRA93dQRQY1IGTHDzwpY5qhYkX+YbVCQvxgOCumd9t+tqUtKmTZu
	 b1PyelrqW3CmiYorwAMIyl0FZKMxGuMX/Ow75V1KWvpLRPYhORymNlhVfTXWW9ju3j
	 FHgYaJ1bOHxF+iyju63WO/R9ciqfNZBxu8VP/Pr5DB0YBE2CFIE9jWTjGzMWS6w11L
	 USyZUa+6+1nsEb+2mX2sxkY83iJjvQAwpqfFAm5IQ8e5Dl6BfKSXxmS/xEvw2BVufL
	 WPpOiSzjE13Uw==
From: Conor Dooley <conor@kernel.org>
To: claudiu.beznea@tuxon.dev
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/5] MAINTAINERS: add new soc drivers to Microchip RISC-V entry
Date: Mon, 10 Nov 2025 11:23:53 +0000
Message-ID: <20251110-creature-spousal-213edfea02ce@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110-zookeeper-femur-68a0ae346397@spud>
References: <20251110-zookeeper-femur-68a0ae346397@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=733; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=gmAo0f4txEXEqIJYVzrDbfZIGVrUbtgonOlTrrMh7lQ=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJmCpz3O3zCWCLXNS8qzqw1exiS5dfOJP57dfbHNTYF8/ Eau+1Q7SlkYxLgYZMUUWRJv97VIrf/jssO55y3MHFYmkCEMXJwCMJEtKxj+mZvsF6rd3xnnrcAj sf3ZZvZ1goV63F6s//rs203dWhh+MPzPrT/Fbbdj4/u0YreLy5duf77+8abHN99YfP7Y/TP8/5Z IdgA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Add the two new syscon drivers to the RISC-V entry for Microchip
platforms.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 46126ce2f968..a28740a7d87a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22105,6 +22105,8 @@ F:	drivers/pci/controller/plda/pcie-microchip-host.c
 F:	drivers/pwm/pwm-microchip-core.c
 F:	drivers/reset/reset-mpfs.c
 F:	drivers/rtc/rtc-mpfs.c
+F:	drivers/soc/microchip/mpfs-control-scb.c
+F:	drivers/soc/microchip/mpfs-mss-top-sysreg.c
 F:	drivers/soc/microchip/mpfs-sys-controller.c
 F:	drivers/spi/spi-microchip-core-qspi.c
 F:	drivers/spi/spi-microchip-core.c
-- 
2.51.0


