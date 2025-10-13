Return-Path: <linux-kernel+bounces-850268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2A4BD25EE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3447D189AE23
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5036E2FF643;
	Mon, 13 Oct 2025 09:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRCtgLUa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A0A2FE058
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348927; cv=none; b=f+/GUAK95zA99NzynoTZr8gJIftIHIFzw8UTICMdbiMW6VRKXjMz7g7frnT6n1WhnDRir5vk2SOl3NyS1wMlgADWyymiciQ0NKXfrin5ruQmOW1+lpC2BK8Q+LksG3UwpcQjVFrGBbIySxSyskI629cMSgtjKzvQQLtCD+hg1/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348927; c=relaxed/simple;
	bh=76QsU15dX0J7lKUp2UMl55B5U4WcErZ/uNwd28wkIns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wz1P6JddWbwmIBEW9ZdbZiEvrJ4mkWfZ6Ux+iVJFTYnHpKNKyquq8fxPNwx2HS4fSPzJi84vN9JGxeSZ8+MlFv4QLxMskyf0ZYbJw5L1fn9xnG0kHWLvMx4qZW6r1hLogfiHw9X4rnSADi4rFYAbkhQnhL8yXTaFUItXihkSOOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRCtgLUa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29A5C19425;
	Mon, 13 Oct 2025 09:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760348926;
	bh=76QsU15dX0J7lKUp2UMl55B5U4WcErZ/uNwd28wkIns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PRCtgLUaxBgSteC6+oZ0gsCr5lx4dpIZun3RfwLX72B2cXZuMbvrbm329uI93HBzc
	 H5yY1jnTN1WXPsY0zvPIs8JuXqI6bcmU5tYpftPay0JZodDnmmZPDicE4Kz4ek14lL
	 ZgGbKwvpK/jThqCOjJSQdH3Q7caP6Bpq6Do4Wm00sE6jKedX97hE7WWAK5qlD2BFCs
	 ENrzp3Pr85M1BkzL3VjrPGNarBfvjfROwtSddfAAsoO7YCdAoMEqUHMD7yr3qA7/gB
	 V26MoB/cCGBXmEaG6PY3MjnDjrt/rUDdmLHTwE6Ic63g+PYqKlMSmvJDD7AlkxOt7c
	 bmiojrUGOugbQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v8FAa-0000000036f-1HZx;
	Mon, 13 Oct 2025 11:48:44 +0200
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
Subject: [PATCH 09/11] irqchip/qcom-irq-combiner: Fix section mismatch
Date: Mon, 13 Oct 2025 11:46:09 +0200
Message-ID: <20251013094611.11745-10-johan@kernel.org>
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
discarded so the probe callback must not live in init.

Fixes: f20cc9b00c7b ("irqchip/qcom: Add IRQ combiner driver")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/irqchip/qcom-irq-combiner.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/qcom-irq-combiner.c b/drivers/irqchip/qcom-irq-combiner.c
index 18e696dc7f4d..9308088773be 100644
--- a/drivers/irqchip/qcom-irq-combiner.c
+++ b/drivers/irqchip/qcom-irq-combiner.c
@@ -222,7 +222,7 @@ static int get_registers(struct platform_device *pdev, struct combiner *comb)
 	return 0;
 }
 
-static int __init combiner_probe(struct platform_device *pdev)
+static int combiner_probe(struct platform_device *pdev)
 {
 	struct combiner *combiner;
 	int nregs;
-- 
2.49.1


