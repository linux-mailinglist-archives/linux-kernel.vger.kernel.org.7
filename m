Return-Path: <linux-kernel+bounces-804332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2A2B4727A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 17:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C1A580D4A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8C52FD7CE;
	Sat,  6 Sep 2025 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPm3/xx3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0868D2868B3;
	Sat,  6 Sep 2025 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757173420; cv=none; b=CNcd9Ey31/GByniRrDhvIzFt8+LAw6kSKIXdabzDNQ1gBQ+sdSjuFtxYA94ybZETElOsinsQPmUE+TLEXWoDmFsOBgCEDXm2PjZHpAOsEPzPbTlipSeStSrgSl7d+E9hbBR8GDK/o9D/JFerEUsabO+4tWkS+5NpqoS91BR1ey8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757173420; c=relaxed/simple;
	bh=4iyRo+oPyIYx/la+0wXxRCeKpjuTn6CQPw93KZYaon8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e9RV336L4Oh1w3R1aihoOFQ3v81+Qnz89R4Z9haQvrRwlCHIZhLBIBRNA/UNZKvPmbDa82Vksato9QtOqwtaS1UkdvdYY9+p/tK5thOKC0bd7CMvZlKQW3CokctJOZM5dSz4g9u0P4jXyf9MAf2RfXECOtu54hVvjOb/buHbZo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPm3/xx3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8907FC4CEFA;
	Sat,  6 Sep 2025 15:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757173419;
	bh=4iyRo+oPyIYx/la+0wXxRCeKpjuTn6CQPw93KZYaon8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FPm3/xx3GGdyCTrGbBSXlCUKuJYpd9ECMDpiLytrUb0z6vOyBT7JImdksXtMAF33o
	 0sPs0yHw+jzZXnat/I6RK21pa1YkePVBNMkr2l8Zh8IIqeI9mS4SQrMWlgaufE7XNS
	 eKPB0N+I9WTeKvQ5k/VCwx9JeupkZY/Kzg4uub1+d2IhigoLL7GB9mVfYufa6maJJ/
	 CAuZ90JUc5rdr2Wet978L1CTf//BeULSbRIoAUJ64BO616BY8kQnYdttFEMqEuJ4M5
	 CvfSaW2yANLpMSBHJoKEi2uBUirvrsI9eid6KYEzojcg3XZ5VVlp5LRQcNpMARwZYw
	 RJg9lO2wEAJQA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0FCCA0FED;
	Sat,  6 Sep 2025 15:43:39 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Sat, 06 Sep 2025 15:43:19 +0000
Subject: [PATCH v2 06/22] usb: typec: tipd: Move initial irq mask to
 tipd_data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250906-atcphy-6-17-v2-6-52c348623ef6@kernel.org>
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
 Sven Peter <sven@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3232; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=4iyRo+oPyIYx/la+0wXxRCeKpjuTn6CQPw93KZYaon8=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8aesHlJ0w2m5jeHz80z3hT8JuZkV8RBRRb+//Xz0n1WW
 omKv7zfUcrCIMbBICumyLJ9v73pk4dvBJduuvQeZg4rE8gQBi5OAZjI8v+MDEdOn/xkeqI/buId
 g2Lh1ZEbuF+U50lubTWO3bVAZllIUCbD/+Rbt662Snxb+kqfOe5MwaQz9YeSJ/15mfBq9Y6ZkSy
 HnBkA
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

Since the irq mask was originally added more tipd variants have been
introduced and there's now struct tipd_data. Move the initial mask in
there.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Sven Peter <sven@kernel.org>
---
 drivers/usb/typec/tipd/core.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 1c80296c3b273e24ceacb3feff432c4f6e6835cc..6d8bcbc9cad8a1394e066504d4c5ca570edd4e4f 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -112,6 +112,7 @@ struct tps6598x;
 
 struct tipd_data {
 	irq_handler_t irq_handler;
+	u64 irq_mask1;
 	int (*register_port)(struct tps6598x *tps, struct fwnode_handle *node);
 	void (*trace_power_status)(u16 status);
 	void (*trace_status)(u32 status);
@@ -1298,7 +1299,6 @@ static int tps6598x_probe(struct i2c_client *client)
 	u32 status;
 	u32 vid;
 	int ret;
-	u64 mask1;
 
 	tps = devm_kzalloc(&client->dev, sizeof(*tps), GFP_KERNEL);
 	if (!tps)
@@ -1337,16 +1337,6 @@ static int tps6598x_probe(struct i2c_client *client)
 		if (ret)
 			return ret;
 
-		/* CD321X chips have all interrupts masked initially */
-		mask1 = APPLE_CD_REG_INT_POWER_STATUS_UPDATE |
-			APPLE_CD_REG_INT_DATA_STATUS_UPDATE |
-			APPLE_CD_REG_INT_PLUG_EVENT;
-
-	} else {
-		/* Enable power status, data status and plug event interrupts */
-		mask1 = TPS_REG_INT_POWER_STATUS_UPDATE |
-			TPS_REG_INT_DATA_STATUS_UPDATE |
-			TPS_REG_INT_PLUG_EVENT;
 	}
 
 	tps->data = i2c_get_match_data(client);
@@ -1364,7 +1354,7 @@ static int tps6598x_probe(struct i2c_client *client)
 			return ret;
 	}
 
-	ret = tps6598x_write64(tps, TPS_REG_INT_MASK1, mask1);
+	ret = tps6598x_write64(tps, TPS_REG_INT_MASK1, tps->data->irq_mask1);
 	if (ret)
 		goto err_reset_controller;
 
@@ -1527,6 +1517,9 @@ static const struct dev_pm_ops tps6598x_pm_ops = {
 
 static const struct tipd_data cd321x_data = {
 	.irq_handler = cd321x_interrupt,
+	.irq_mask1 = APPLE_CD_REG_INT_POWER_STATUS_UPDATE |
+		     APPLE_CD_REG_INT_DATA_STATUS_UPDATE |
+		     APPLE_CD_REG_INT_PLUG_EVENT,
 	.register_port = tps6598x_register_port,
 	.trace_power_status = trace_tps6598x_power_status,
 	.trace_status = trace_tps6598x_status,
@@ -1536,6 +1529,9 @@ static const struct tipd_data cd321x_data = {
 
 static const struct tipd_data tps6598x_data = {
 	.irq_handler = tps6598x_interrupt,
+	.irq_mask1 = TPS_REG_INT_POWER_STATUS_UPDATE |
+		     TPS_REG_INT_DATA_STATUS_UPDATE |
+		     TPS_REG_INT_PLUG_EVENT,
 	.register_port = tps6598x_register_port,
 	.trace_power_status = trace_tps6598x_power_status,
 	.trace_status = trace_tps6598x_status,
@@ -1546,6 +1542,9 @@ static const struct tipd_data tps6598x_data = {
 
 static const struct tipd_data tps25750_data = {
 	.irq_handler = tps25750_interrupt,
+	.irq_mask1 = TPS_REG_INT_POWER_STATUS_UPDATE |
+		     TPS_REG_INT_DATA_STATUS_UPDATE |
+		     TPS_REG_INT_PLUG_EVENT,
 	.register_port = tps25750_register_port,
 	.trace_power_status = trace_tps25750_power_status,
 	.trace_status = trace_tps25750_status,

-- 
2.34.1



