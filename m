Return-Path: <linux-kernel+bounces-850281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 59885BD2643
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A4444EFC2D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4213C2FE07E;
	Mon, 13 Oct 2025 09:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+miS2x2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7D12FB632
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760349293; cv=none; b=oo2U/gut/ZehNHAJNNyZHV2GRy5YlZHEgtUkxI5U1tXGHv6nsmTojlQ8IVwSm+3ERmVPPN9oI88Qop9Wo0NMdgV6JimdfeH4B1Zqg5GOjKKT84BdneqCpbwRWnA1Z9hy/3VEHZ973TucdsAH0/WypDcZFk7nRVM1QmlOwkCSEIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760349293; c=relaxed/simple;
	bh=GnB//JkGnD4NVxrCrNoPTp+sLW/nub8f8TJ/O86fh7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jtU+tnH1LmyJBH7UWTuArn1yfnhM69rhimXF8+1sthKydDCYwP4TRZ0gHrDe26X5GVQ+YvpOJtXwJc7n6Qa4QCno+b4FYElQ2e/DsCZAw3mLhrzVxvhA3AyRDvBeKCtK9br9RxLHAkIs5P5ylrzxyubfQmbRPVXtgzll9QxoeUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+miS2x2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A65CC4CEE7;
	Mon, 13 Oct 2025 09:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760349293;
	bh=GnB//JkGnD4NVxrCrNoPTp+sLW/nub8f8TJ/O86fh7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E+miS2x2LQF1bkOPm6BxJzjU0UstR+Bv6Spf6rEGK3NO02kw4QxD0xyvoxZ+tOFMs
	 pedpYwo/JTPp32WPCgnRT98kl6UopcaLptfXdsCpmlQOrogygFSBZusddIq8kmgDV+
	 qwHvyH7bpa5ipac05e20O5yQzKfTYzq/l7mC/CfZN/6KGQe4mtploC9tEWFdsk2528
	 avSKyY33HFeQ2QjtvH6IwRMsbZytQZVTAU9jMSlXTifdgw8M5kGb/Ntd9kKMA/u2+C
	 1jsbSsjVqMWjtzaL/7LfULfluFTT4OfCKjKX+rJs0FFzPlgExshTAxhE7O2EmmoVqW
	 +RWuAvDj3+09g==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v8FGV-000000003E2-0PdE;
	Mon, 13 Oct 2025 11:54:51 +0200
From: Johan Hovold <johan@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/3] irqchip/meson-gpio: Drop unused module alias
Date: Mon, 13 Oct 2025 11:54:26 +0200
Message-ID: <20251013095428.12369-2-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251013095428.12369-1-johan@kernel.org>
References: <20251013095428.12369-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver has never supported anything but OF probing so drop the
unused platform alias that was erroneously added by commit a947aa00edd4
("irqchip/meson-gpio: Make it possible to build as a module").

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/irqchip/irq-meson-gpio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index 7d177626d64b..8e84724e8d28 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -636,4 +636,3 @@ IRQCHIP_PLATFORM_DRIVER_END(meson_gpio_intc)
 MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
 MODULE_DESCRIPTION("Meson GPIO Interrupt Multiplexer driver");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:meson-gpio-intc");
-- 
2.49.1


