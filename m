Return-Path: <linux-kernel+bounces-850261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B5558BD25D9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B38E64EFBC8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B47924469B;
	Mon, 13 Oct 2025 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVj8hXqK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7A02F5A37
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348926; cv=none; b=qz/si2qNfrQRiNa130Qp5eJLLo3ipcxwNdBRmIYabhOCpxG8JN/dQzcbyB7fkYArP80qbHF0Z5WurufIf6LiR54YCxCNOtK0fUFjN8EYg0AGOMiPPSROwDHz/qDxUuxK3eZHHaGUnnzPmxGbDSyZeLtlzuQfxVb7IBfts6lRvN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348926; c=relaxed/simple;
	bh=WjGMo4ebNiuDIVIcaRsO8MiAUno93QhyR1S9i2wJ3e0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6qxVjSWWUkj7i/SZPEomhhrwxuEYS10+i015UfiWqN3ctkX2iFr1uq1/O3PsZfBZCB+JWNAf/I2dzYmaOTzzSoNj8F5fgQrkeHgQy4OclmeRw3JbgCPQelOlMsDXEvRNhTOSCildAD98EEXFPkgWc7ragzJWUTVyB1vW5afgbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVj8hXqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A034C4CEFE;
	Mon, 13 Oct 2025 09:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760348926;
	bh=WjGMo4ebNiuDIVIcaRsO8MiAUno93QhyR1S9i2wJ3e0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oVj8hXqKKbxZ6CU8Ydj7biKlWOSBYBjMpagEasi1IEQnXpO1y/byV+kJXsSX4kUzS
	 1cJ0Pj1khrNJ6MGTZhZksF3xkU0FHfbV50nX8Y0YSu/umX/w1N9ycagFmpCECsfAwg
	 f+0epLSRcH8bAEPqcchJ3qaXd/ZDXV6oEYy5DKDByHvjbUP4l6G+04BKWYoCR/t+gS
	 UvlvV7UNx8AAYYza6oH5X+cjsktPTbjKXXHYxWflY3/C4DS+ZAWiiKtKLd6wXHJRzZ
	 fmVD5KjR5ipEVA9/audg7+Pj05jXqaLSKDT2ByqIFONxeaLoJcsxXAQA3bmBS1jPkM
	 IMovyNBa1E5Mw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v8FAZ-0000000036M-2nUA;
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
	Johan Hovold <johan@kernel.org>,
	Stanimir Varbanov <svarbanov@suse.de>
Subject: [PATCH 02/11] irqchip/bcm2712-mip: Fix section mismatch
Date: Mon, 13 Oct 2025 11:46:02 +0200
Message-ID: <20251013094611.11745-3-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251013094611.11745-1-johan@kernel.org>
References: <20251013094611.11745-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Platform drivers can be probed after their init sections have been
discarded so the irqchip init callback must not live in init.

Fixes: 32c6c054661a ("irqchip: Add Broadcom BCM2712 MSI-X interrupt controller")
Cc: Stanimir Varbanov <svarbanov@suse.de>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/irqchip/irq-bcm2712-mip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-bcm2712-mip.c b/drivers/irqchip/irq-bcm2712-mip.c
index 256c2d59f717..8466646e5a2d 100644
--- a/drivers/irqchip/irq-bcm2712-mip.c
+++ b/drivers/irqchip/irq-bcm2712-mip.c
@@ -232,7 +232,7 @@ static int mip_parse_dt(struct mip_priv *mip, struct device_node *np)
 	return ret;
 }
 
-static int __init mip_of_msi_init(struct device_node *node, struct device_node *parent)
+static int mip_of_msi_init(struct device_node *node, struct device_node *parent)
 {
 	struct platform_device *pdev;
 	struct mip_priv *mip;
-- 
2.49.1


