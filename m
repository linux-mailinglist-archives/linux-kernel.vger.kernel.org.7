Return-Path: <linux-kernel+bounces-850259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61869BD25D6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B300A189ACAB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047EC2FE061;
	Mon, 13 Oct 2025 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqeO8vsm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B96B239E63
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348926; cv=none; b=aERg0GTg4vPaytwdxdMte0VOuHrxdZf5tbKJ7TRgofpR5ElfP+wMhe64a8fY1oXfH61qmLoAekVR8YiugMP7K5Z0lD3OIllfUpODfkXA8dWXZpCw/tXOAlls2UtE/bcRicKSPq9wTC5HSFpsnQoIrWYYbx6qtUhCO7tcqW8aGPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348926; c=relaxed/simple;
	bh=mGSdfzT6rwLb4k5txv2A5zvmgU2jOD3PufNbVv80KuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnHzKiCCVp243JuXXNewipmB/IKNR/BhEdizES1orY9xFEQDYqx5PZVVhj/Ds2hZ2VR0HfyJV9oxW2u/tOkZZ50fo/W/JFP6A+q2bpXcj0NFGLe9JWXbZv+sUFF6wTfy7G4RNn7vM76xwdyVOL/faZ91Pl5lHOmnQMeaHmQzEDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqeO8vsm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0253C4CEF8;
	Mon, 13 Oct 2025 09:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760348926;
	bh=mGSdfzT6rwLb4k5txv2A5zvmgU2jOD3PufNbVv80KuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HqeO8vsmLlnVbBJ9G3pwRbIk+7XR1j8Z/EY9sWZPSa6MECcgeIoyX3AERyKQgCXHS
	 pEsDn+fZPsl254gpjolf0VUbP2SWgW8y8B8HrA3JuthcpQvLo+8a+dYRWi+9T9/VMm
	 Dd918+vK4tdpeXfTivxKGyfMGDi5JxL69pnSGAjw07QtgrtnpCSX0ufQqQka0GxEqq
	 DmeGQ2qm4pYHnpnT5ARp9UbhgWpqQIVZgj5IyshiyQnYKub3EtHE3irRZjp4wmI543
	 Gtv74QEfplznlWtHvHWh9DWi2jaJ2pD95QDe5TfH0ddKSDLPIJGRO/+X0EInBxLvdX
	 ELwWKNfVBQjCw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v8FAZ-0000000036K-2NMy;
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
Subject: [PATCH 01/11] irqchip/bcm2712-mip: Fix OF node reference imbalance
Date: Mon, 13 Oct 2025 11:46:01 +0200
Message-ID: <20251013094611.11745-2-johan@kernel.org>
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

The init callback must not decrement the reference count of the provided
irqchip OF node.

This should not cause any trouble currently, but if the driver ever
starts probe deferring it could lead to warnings about reference
underflow and saturation.

Fixes: 32c6c054661a ("irqchip: Add Broadcom BCM2712 MSI-X interrupt controller")
Cc: Stanimir Varbanov <svarbanov@suse.de>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/irqchip/irq-bcm2712-mip.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-bcm2712-mip.c b/drivers/irqchip/irq-bcm2712-mip.c
index 9bd7bc0bf6d5..256c2d59f717 100644
--- a/drivers/irqchip/irq-bcm2712-mip.c
+++ b/drivers/irqchip/irq-bcm2712-mip.c
@@ -239,7 +239,6 @@ static int __init mip_of_msi_init(struct device_node *node, struct device_node *
 	int ret;
 
 	pdev = of_find_device_by_node(node);
-	of_node_put(node);
 	if (!pdev)
 		return -EPROBE_DEFER;
 
-- 
2.49.1


