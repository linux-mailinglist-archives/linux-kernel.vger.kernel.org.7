Return-Path: <linux-kernel+bounces-812100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F24B532F0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 420ACA810D4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023EE322DC4;
	Thu, 11 Sep 2025 12:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqCQp3CJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E7532038B;
	Thu, 11 Sep 2025 12:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757595529; cv=none; b=VAKb2guPQ2VMD8R01sn+NAsrLklQ0RNGKS2yzEB2G1eTZxVwF1/TSe4otL3C965L6w6cJTbbTZnvKdymCwh9jwMEOY4hjdd7EbWco6HEIvggIyyGyfQEgGYCY4thSecgDUzKyLErSFty7LThy5qE3s+G/zV7lQSl9+tZB3X/jMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757595529; c=relaxed/simple;
	bh=ZyjDRlaUljAfi8q455xMtlrqhLM1yrweMT6baGuF55E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QpbWwC5v6z3xtaUfzSZrRreSdN2UsnodyI/EH20M6P38aDMuJhQYR9SAt5i1wefxwHYbtR4XcHvbyzSijFvhfsaOQE4yupJIqqatMx0T0uDTfUO73fLkiYPN+btcQfA7tKo/2C2gZ7+5w8eQVA1vE3CAwAgHATMGUvSPuMIc2P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqCQp3CJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11B65C4CEF8;
	Thu, 11 Sep 2025 12:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757595529;
	bh=ZyjDRlaUljAfi8q455xMtlrqhLM1yrweMT6baGuF55E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HqCQp3CJypCwELybQjSTPts4AKueA2R9HH1g53LtKtTWM8r7S0QEqGWDrsuERus3o
	 UL9uhOS+mCQEYhy0bM3lqDZXk8eL5aK2AO57SvBwXuuEgqLFKluODeNWfthohzyuHe
	 KQ5cDAdHjZnRSxv1dNsSBfTCUl8Sc3zSNs5uoOMl7sFw51Dszapjg6Np1N8AE68uQD
	 VgjHzgsxbIbRswlI5AzSF/MTlmqOddFRyCTz6ogxEo1b+20qpOWCn1l58CSkeYkTGr
	 gJxuB1Sc7Wc2YQ6n5U9vHDWtcj4MUdusI/BiR0+ZPtKRLNIKK6o5thlbNrHqMrBb4C
	 iI0+rv+GrVW0g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F02CAC594;
	Thu, 11 Sep 2025 12:58:49 +0000 (UTC)
From: Alejandro Enrique via B4 Relay <devnull+alejandroe1.geotab.com@kernel.org>
Date: Thu, 11 Sep 2025 14:58:29 +0200
Subject: [PATCH v3 2/2] gnss: ubx: add support for the safeboot gpio
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-ubx-safeboot-v3-2-32fe6b882a3c@geotab.com>
References: <20250911-ubx-safeboot-v3-0-32fe6b882a3c@geotab.com>
In-Reply-To: <20250911-ubx-safeboot-v3-0-32fe6b882a3c@geotab.com>
To: Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alejandro Enrique <alejandroe1@geotab.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757595528; l=1402;
 i=alejandroe1@geotab.com; s=20250514; h=from:subject:message-id;
 bh=5q+UP/BRI1cuC24cDBux+9AkjID15/gPXOINM1Yuf4o=;
 b=rRCMSESk1rEYlgXKUteE+7c0xEi3bqDkte0d+THCuBDLnkdbs7IHbt0XPyswev8+71HIKDGC6
 5QIVoYII0w7AwcEVKlAmjWgVtOQcMtx3h0PB1Ed+QqwkjtWGE6UVZjY
X-Developer-Key: i=alejandroe1@geotab.com; a=ed25519;
 pk=xzHMPbqczL/tMsjXr26iLoHwIzLveHVnT+GIU4p1k38=
X-Endpoint-Received: by B4 Relay for alejandroe1@geotab.com/20250514 with
 auth_id=404
X-Original-From: Alejandro Enrique <alejandroe1@geotab.com>
Reply-To: alejandroe1@geotab.com

From: Alejandro Enrique <alejandroe1@geotab.com>

U-Blox 8/M8/M9 chip have a pin to start it in safeboot mode, to be
used to recover from situations where the flash content has become
corrupted and needs to be restored. If this pin is asserted at power
up/reset, the receiver starts in safeboot mode and GNSS operation is
disabled.

Deassert the safeboot pin when probing this driver.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Alejandro Enrique <alejandroe1@geotab.com>
---
 drivers/gnss/ubx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gnss/ubx.c b/drivers/gnss/ubx.c
index 92402f6082c415c7b9051338eef5406b09e09455..1d6acace84f76f8d5d2eacdbbf5ab7a934b33486 100644
--- a/drivers/gnss/ubx.c
+++ b/drivers/gnss/ubx.c
@@ -67,6 +67,7 @@ static int ubx_probe(struct serdev_device *serdev)
 {
 	struct gnss_serial *gserial;
 	struct gpio_desc *reset;
+	struct gpio_desc *safeboot;
 	struct ubx_data *data;
 	int ret;
 
@@ -82,6 +83,13 @@ static int ubx_probe(struct serdev_device *serdev)
 
 	data = gnss_serial_get_drvdata(gserial);
 
+	/* Deassert safeboot */
+	safeboot = devm_gpiod_get_optional(&serdev->dev, "safeboot", GPIOD_OUT_LOW);
+	if (IS_ERR(safeboot)) {
+		ret = PTR_ERR(safeboot);
+		goto err_free_gserial;
+	}
+
 	data->vcc = devm_regulator_get(&serdev->dev, "vcc");
 	if (IS_ERR(data->vcc)) {
 		ret = PTR_ERR(data->vcc);

-- 
2.34.1



