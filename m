Return-Path: <linux-kernel+bounces-850260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C194FBD25D3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29D12189ACB0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0471B2FE060;
	Mon, 13 Oct 2025 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGq/fzRi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B90622F14C
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348926; cv=none; b=WAgpQZyhfwbtMCXFK7DdYQuDADvQxkSNzYgvwt5R+Lw9/Hbr63XtNtsRqtyjwWAXADr004RhtMPtUYDzHf4RfuhHC/C00BYwIp0SFVyjWbFcoFKY3Om0cDD74HypcmqdKXW8+nXxmGlsS2Vt75OLMhTUAEqLXueJIFFNzAQbhvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348926; c=relaxed/simple;
	bh=35qJhYCZTUt5EMUt2+xEg88n/H7E3xgnlAC3Pkam2ac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MVdgDdz89p+nicMen+cSSTzXn56RXTcSOiKzseatyijDezpCvxBOJbP/YK/6k7+l8HkvtBd7S0qsJgDHtW9R6aY/tmLn3WOPLg3dOx0pTchZG+aZabKubbawQ1YMDXF2xK5zQAUIEa+8GuoUjFyE54iARdwQuWFAh8rH6n9mKsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGq/fzRi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE88C4CEE7;
	Mon, 13 Oct 2025 09:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760348926;
	bh=35qJhYCZTUt5EMUt2+xEg88n/H7E3xgnlAC3Pkam2ac=;
	h=From:To:Cc:Subject:Date:From;
	b=WGq/fzRiruA8YHVHvWA7WPuYlPyhW3NziwDkv+BVWAmQ8LsViBTPoGEmv2np/wBqF
	 66cSyb5b7nEcbWZLw9VqTf8T5szGogp3VKDu2SZiGDeMVOVdwutK4XjYsH71pxNhtr
	 8AiZ1eDA5MC4qoZ+H7OiO0AtFgGRSFUmQvt0jhpj7s4KIEUFVwJDTvc+E/GbpaXjoo
	 yYGgXxlhYKxQs4lOG5qV7NpVmD+pHmBoD1FCT5FrOm69/ztDJJaxbInbZXuDNgkDv+
	 mqnPshtxqjCpY+06Umm8PQ2MZkNKesitOWttSwDkDyjm5YWN7qecmmdlUIkZ7Nk0Cm
	 u/EcEKBzvRENQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v8FAY-0000000036I-3GHr;
	Mon, 13 Oct 2025 11:48:43 +0200
From: Johan Hovold <johan@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 00/11] irqchip: Pass platform device to platform drivers
Date: Mon, 13 Oct 2025 11:46:00 +0200
Message-ID: <20251013094611.11745-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IRQCHIP_PLATFORM_DRIVER macros can be used to convert OF irqchip
drivers to platform drivers but currently reuse the OF init callback
prototype that only takes OF nodes as arguments. This forces drivers to
do reverse lookups of their struct devices during probe if they need
them for things like dev_printk() and device managed resources.

Half of the drivers doing reverse lookups also currently fail to release
the additional reference taken during the lookup, while other drivers
have had the reference leak plugged in various ways (e.g. using
non-intuitive cleanup constructs which still confuse static checkers).

Switch to using a probe callback that takes a platform device as its
first argument to simplify drivers and plug the remaining (mostly
benign) reference leaks.

Included are also some related preparatory fixes for an OF node
reference imbalance and section mismatches due to misplaced __init
markers (in some cases left over from platform driver conversions).

Johan


Johan Hovold (11):
  irqchip/bcm2712-mip: Fix OF node reference imbalance
  irqchip/bcm2712-mip: Fix section mismatch
  irqchip/irq-bcm7038-l1: Fix section mismatch
  irqchip/irq-bcm7120-l2: Fix section mismatch
  irqchip/irq-brcmstb-l2: Fix section mismatch
  irqchip/imx-mu-msi: Fix section mismatch
  irqchip/renesas-rzg2l: Fix section mismatch
  irqchip/starfive-jh8100: Fix section mismatch
  irqchip/qcom-irq-combiner: Fix section mismatch
  irqchip: Drop leftover brackets
  irqchip: Pass platform device to platform drivers

 drivers/irqchip/irq-bcm2712-mip.c          | 11 ++-----
 drivers/irqchip/irq-bcm7038-l1.c           | 12 +++----
 drivers/irqchip/irq-bcm7120-l2.c           | 28 +++++-----------
 drivers/irqchip/irq-brcmstb-l2.c           | 25 +++++++--------
 drivers/irqchip/irq-imx-mu-msi.c           | 28 +++++++---------
 drivers/irqchip/irq-mchp-eic.c             |  5 +--
 drivers/irqchip/irq-meson-gpio.c           |  5 +--
 drivers/irqchip/irq-qcom-mpm.c             |  6 ++--
 drivers/irqchip/irq-renesas-rzg2l.c        | 37 ++++++----------------
 drivers/irqchip/irq-renesas-rzv2h.c        | 32 ++++++-------------
 drivers/irqchip/irq-starfive-jh8100-intc.c |  6 ++--
 drivers/irqchip/irqchip.c                  | 10 +++---
 drivers/irqchip/qcom-irq-combiner.c        |  2 +-
 drivers/irqchip/qcom-pdc.c                 |  5 +--
 include/linux/irqchip.h                    |  8 ++++-
 15 files changed, 85 insertions(+), 135 deletions(-)

-- 
2.49.1


