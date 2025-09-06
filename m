Return-Path: <linux-kernel+bounces-804340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF2CB4728F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 17:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59BBD4E035A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD503002B4;
	Sat,  6 Sep 2025 15:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWijnsA5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AAE2ED871;
	Sat,  6 Sep 2025 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757173420; cv=none; b=odcVBvBpdq4sXOGRtWdhPgOwr7kvyk+vepz3nmIuPLHBmkAQKG7vy9yr6IPjcLOlPvPUPH5i7vjhWtxsDMQWgOCyWtKvwUoWoFKVbjBNY9kxG8911uZ3xEZFDdSZlgkFgLSewqfeFOFiJojGfzXHS3oKrEhzfNUyJPuhE6qlBeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757173420; c=relaxed/simple;
	bh=jQdetY7GRNst+fAdMazOXWq4v9pFdWCONcHGsoymkA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F3KoMIMeZ+vLIXgaGF47hnOfyJl8jYs/fBNGcIsW4wTLnMitZtOsEnOwCl3JnHWCw1Do+Ig5VRUKYs6B44/XeB4ZJkT6PQi5ldosT6zxR0V4/7oiMiH8KVDII/38ccWtMirEDQBS9/LSSWwzxLCaHDiHoQM95bElZkn9TuFRDBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWijnsA5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8983C116C6;
	Sat,  6 Sep 2025 15:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757173420;
	bh=jQdetY7GRNst+fAdMazOXWq4v9pFdWCONcHGsoymkA0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mWijnsA5JVbBpy0d9QBMQ9/UBtnQDmpAWh6oGiyY9FfhojNgqlmqOIycsiIgbSAKs
	 5Ntt8lMAJRjUWPbXz0TJrvebmLuZNaicpiBxHgyqOgphUx1MZ1iTrg14KUxGbYI465
	 mtiNcAOApb3OMh6d1kSqEnASIKU7P5ij/DOqmRQOjA2Ymwim/9IOQgA0qblZQchzDg
	 N911DYDdIYW9cfKt4ddksMteuTXtqJs8pCGTcm+b1URs6AWEaQ8ufbNpIADyITINcD
	 fSgt+Nt458I+lRLLEi0dV3Zh7URm37oLm2W6XPoxTvpmXIOlTQe32nBh9Tjal6Rtih
	 2KaSVgebyUmIA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCE4CA1002;
	Sat,  6 Sep 2025 15:43:39 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Sat, 06 Sep 2025 15:43:25 +0000
Subject: [PATCH v2 12/22] usb: typec: tipd: Update partner identity when
 power status was updated
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250906-atcphy-6-17-v2-12-52c348623ef6@kernel.org>
References: <20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org>
In-Reply-To: <20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>, 
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
 Ran Wang <ran.wang_1@nxp.com>, Peter Chen <peter.chen@nxp.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, 
 Sven Peter <sven@kernel.org>, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1307; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=QDhuS+HKxdzHgchZ8cpnBXq7l32Qnci0SI3jtXHi3pQ=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8aesIUHfP/51Dx+HjI3fP1Hv+ZfgQwqE5nKfC9U7fw/e
 arHnF/vO0pZGMQ4GGTFFFm277c3ffLwjeDSTZfew8xhZQIZwsDFKQAT0T/H8JNRIG1pgkTFy6vB
 XlWOy2dUiNh+v/ZrXryi7/v1nHEstfMZ/hltPOX0rJLl0ONzDFv1f/kn9zfYOJj/l9N8LcircKb
 nAzsA
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

From: Hector Martin <marcan@marcan.st>

Whenever the power status is changed make sure to also update the
partner identity to be able to detect changes once de-bouncing and mode
changes are added for CD321x.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Sven Peter <sven@kernel.org>
---
 drivers/usb/typec/tipd/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index c7cf936e5a61a331271c05b68ff1b77b89c0f643..cd427eecd8a594b7e609a20de27a9722055307d8 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -635,9 +635,16 @@ static irqreturn_t cd321x_interrupt(int irq, void *data)
 	if (!tps6598x_read_status(tps, &status))
 		goto err_unlock;
 
-	if (event & APPLE_CD_REG_INT_POWER_STATUS_UPDATE)
+	if (event & APPLE_CD_REG_INT_POWER_STATUS_UPDATE) {
 		if (!tps6598x_read_power_status(tps))
 			goto err_unlock;
+		if (TPS_POWER_STATUS_PWROPMODE(tps->pwr_status) == TYPEC_PWR_MODE_PD) {
+			if (tps6598x_read_partner_identity(tps)) {
+				dev_err(tps->dev, "failed to partner identity\n");
+				tps->partner_identity = (struct usb_pd_identity) {0};
+			}
+		}
+	}
 
 	if (event & APPLE_CD_REG_INT_DATA_STATUS_UPDATE)
 		if (!tps->data->read_data_status(tps))

-- 
2.34.1



