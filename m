Return-Path: <linux-kernel+bounces-780214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE20B2FF20
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D35B0162E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E12633A01D;
	Thu, 21 Aug 2025 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bV3tjymF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FD52D46B7;
	Thu, 21 Aug 2025 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755790804; cv=none; b=HX4fAU4h4k1DTzLoRtxi1X/k7nJw/D0h8O9hcKGLZ3oi1XUR8+HhK7QZDWuhYkdRs7NWtawaEA8cdZKIRUTsy3U1AfNKpV7WyAZbVbRcBCFS8qjSfPBIXBUhvJfAEA+VF8SKjvnfOOm8RXycUtxo03dvguj4SA8M3FXlXel/+Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755790804; c=relaxed/simple;
	bh=C86MXQmNc7kleels4/FwPfEBEO3GlObgdaJqsVfJRGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nqm3y4eHiu6LpHTeDud1eRraaJyroNA0z5m6qhpujngANFO+f0bvdr2pnyhzmKiTufxaXqW9y7na4Ev3KvKL4RDlzsVbv26E1bp2QtBxEntkvhgYCmg3YMY2yYBplgc6Na5kl9OWpIegn8hYfhyPeRBGtBIUE2C0BKjImYE/c9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bV3tjymF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4AF2C4AF64;
	Thu, 21 Aug 2025 15:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755790804;
	bh=C86MXQmNc7kleels4/FwPfEBEO3GlObgdaJqsVfJRGQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bV3tjymFqK1wFff8Nim+X7fmIih1Dg6TJqGO9p/YanfNVjcFeYO3RZR3I0nzFbixU
	 CvfzvWrcyPBBwZpATBHg0D6gHiOIdd/p8IyDygI00+7jkKG8ki2PXwZ+H45+H+VYZ7
	 khgKXJGmXnX0alb/DVJPAFpUAl6aSLkAYDBNG4Kr3Gww2m8kgT12ze+UuOcAtaaSIV
	 NGetzUl8a5fd7J3CdUzHdgytM/HIndgveC2T9w0uQ2L1Uzv+XQJYhJfAureFUotGW+
	 EM5wh6WbIZWrSGLbhLEE1qPlSaBk4FB/Qn5bIOQJfGghjAawUCygUPV7vW7b7mCama
	 EiT4zFGLgp9rw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D964DCA0EFC;
	Thu, 21 Aug 2025 15:40:03 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Thu, 21 Aug 2025 15:39:07 +0000
Subject: [PATCH RFC 15/22] usb: typec: tipd: Update partner identity when
 power status was updated
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-atcphy-6-17-v1-15-172beda182b8@kernel.org>
References: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
In-Reply-To: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>, 
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, 
 Sven Peter <sven@kernel.org>, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1322; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=SCOtQQKEz98UryM3qGwaYKjximp44wDd7gohi1eJ+XI=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8Zy2y1nI2M8brztf9gRnfXv6vJgse5PZRwtubOYgw41h
 oScnfOlo5SFQYyDQVZMkWX7fnvTJw/fCC7ddOk9zBxWJpAhDFycAjCRc86MDPP2tJ9zlfv9ybJS
 vKlCUTHQxbaVqX5mHIe82ttXgfMXWTD8r9i2tXa3s2bd4rW+WeHaYVc/X5kvvTi6q9yHU/70pKe
 mPAA=
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

From: Hector Martin <marcan@marcan.st>

Whenever the power status is changed make sure to also update the
partner identity to be able to detect changes once de-bouncing and mode
changes arre added for CD321x.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Sven Peter <sven@kernel.org>
---
 drivers/usb/typec/tipd/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index e369897bfa017ca96e559a8bd70da11207d4513a..b0fdd4dddd3a490dbc2a8ced21ea0803658f36a7 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -636,9 +636,16 @@ static irqreturn_t cd321x_interrupt(int irq, void *data)
 	if (!tps6598x_read_status(tps, &status))
 		goto err_unlock;
 
-	if (event & APPLE_CD_REG_INT_POWER_STATUS_UPDATE)
+	if (event & APPLE_CD_REG_INT_POWER_STATUS_UPDATE) {
 		if (!tps6598x_read_power_status(tps))
 			goto err_unlock;
+		if (TPS_POWER_STATUS_PWROPMODE(tps->pwr_status) == TYPEC_PWR_MODE_PD) {
+			if (tps6598x_read_partner_identity(tps)) {
+				dev_err(tps->dev, "%s: failed to partner identity\n", __func__);
+				tps->partner_identity = (struct usb_pd_identity) {0};
+			}
+		}
+	}
 
 	if (event & APPLE_CD_REG_INT_DATA_STATUS_UPDATE)
 		if (!tps->data->read_data_status(tps))

-- 
2.34.1



