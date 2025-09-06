Return-Path: <linux-kernel+bounces-804338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 042A2B47287
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 17:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C35916F54C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EEF2FF644;
	Sat,  6 Sep 2025 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjZXxOjv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA3B28C864;
	Sat,  6 Sep 2025 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757173420; cv=none; b=Syl6psxerNJT9E/3vu6v1ERC7PBx93ZvDDZWTSafLvmy1DVd6uBAItm4oMoEcltRLMnkR4KaiC8P4cgG3eUGRNJlfKMTztyCRiYkANvPSRRqtM1rlbEIKO5NRIidZu61T/qgIZp1m0nYf87qd0f/AX3gf9HO34wim7/50tURuuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757173420; c=relaxed/simple;
	bh=lo20hMZGHXyN8QQJOTqJCcsm2KhwrQXpkI5DiyZfPqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ieMP7TYGaNqyqiROSFMCunH0zWLHMPRNc50uJJfeOXTf5RopKQzWR2+oq4xlZNMurM9phVszHZVQmc3ZAtKy21mn3Weg91Qk/PgY0zjpAQ1ktn7jbofx9aG+kCIyv5esnSkVJXzEV1MRVjVOsqhN/NYBBu3mdLuaz7qJvCT6Czk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjZXxOjv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5C65C4CEFB;
	Sat,  6 Sep 2025 15:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757173419;
	bh=lo20hMZGHXyN8QQJOTqJCcsm2KhwrQXpkI5DiyZfPqE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JjZXxOjvF9FOKnuhGXKjTnp/kyKZnHpWQbWT3P6q4SUsW5bCZuVJG8bYkUupEXHeu
	 dtwAiEIewqfOKcT/syuVIXTTr5DEItsobOD3OkYoyXCg/VnTF7HyjepFo5zoxRsob1
	 tPAIQ38NpEwxRgS6Pm2Ju/LTFwGIX+exTTHh84HCZRCI3n8pSG8TWRNjp4oZoMftU6
	 JDDLMT7vA2J8Cu1nJitF4n/P8loxRk1N7j0uV3vvluBkIfTKDVnpTxWpa/LdfmWFM9
	 raUmk88FH40SMy8IS3z3VtZU8HiRAFvNRjRXZGUODg8LEzp0YomVeVXpm7fePY2juC
	 395jalVe5xNTg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE97CAC581;
	Sat,  6 Sep 2025 15:43:39 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Sat, 06 Sep 2025 15:43:22 +0000
Subject: [PATCH v2 09/22] usb: typec: tipd: Add cd321x struct with separate
 size
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250906-atcphy-6-17-v2-9-52c348623ef6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3570; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=lo20hMZGHXyN8QQJOTqJCcsm2KhwrQXpkI5DiyZfPqE=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8aesPmP7I6crGCrlj/I+yonfsWDsl02Lz4c/let3usn9
 TyQl/t1RykLgxgHg6yYIsv2/famTx6+EVy66dJ7mDmsTCBDGLg4BWAipzoYGd6+ZhH1XtWq15cu
 KPSSa7bynyMrfkceLDo6Qcqa7faOJ08Z/hlMPyfHOZHzzG92rl0v1Mu4dNbdW3vgj9F59tfiD66
 7LWcGAA==
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

We're about to add more fields to struct tps6598x which are only relevant
for Apple's CD321x and to ensure that we don't waste memory everywhere for
those add a separate struct for cd321x and prepare to allocate more space
inside probe.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Sven Peter <sven@kernel.org>
---
 drivers/usb/typec/tipd/core.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 19d713937870304e68325a441b0de63eb5db3b80..51b0f3be8b66a743ddc3ea96c1b25f597a1e8f6c 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -113,6 +113,7 @@ struct tps6598x;
 struct tipd_data {
 	irq_handler_t irq_handler;
 	u64 irq_mask1;
+	size_t tps_struct_size;
 	int (*register_port)(struct tps6598x *tps, struct fwnode_handle *node);
 	void (*trace_data_status)(u32 status);
 	void (*trace_power_status)(u16 status);
@@ -148,6 +149,10 @@ struct tps6598x {
 	const struct tipd_data *data;
 };
 
+struct cd321x {
+	struct tps6598x tps;
+};
+
 static enum power_supply_property tps6598x_psy_props[] = {
 	POWER_SUPPLY_PROP_USB_TYPE,
 	POWER_SUPPLY_PROP_ONLINE,
@@ -1297,18 +1302,24 @@ tps25750_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
 
 static int tps6598x_probe(struct i2c_client *client)
 {
+	const struct tipd_data *data;
 	struct tps6598x *tps;
 	struct fwnode_handle *fwnode;
 	u32 status;
 	u32 vid;
 	int ret;
 
-	tps = devm_kzalloc(&client->dev, sizeof(*tps), GFP_KERNEL);
+	data = i2c_get_match_data(client);
+	if (!data)
+		return -EINVAL;
+
+	tps = devm_kzalloc(&client->dev, data->tps_struct_size, GFP_KERNEL);
 	if (!tps)
 		return -ENOMEM;
 
 	mutex_init(&tps->lock);
 	tps->dev = &client->dev;
+	tps->data = data;
 
 	tps->reset = devm_gpiod_get_optional(tps->dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(tps->reset))
@@ -1334,10 +1345,6 @@ static int tps6598x_probe(struct i2c_client *client)
 	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		tps->i2c_protocol = true;
 
-	tps->data = i2c_get_match_data(client);
-	if (!tps->data)
-		return -EINVAL;
-
 	if (tps->data->switch_power_state) {
 		ret = tps->data->switch_power_state(tps, TPS_SYSTEM_POWER_STATE_S0);
 		if (ret)
@@ -1521,6 +1528,7 @@ static const struct tipd_data cd321x_data = {
 	.irq_mask1 = APPLE_CD_REG_INT_POWER_STATUS_UPDATE |
 		     APPLE_CD_REG_INT_DATA_STATUS_UPDATE |
 		     APPLE_CD_REG_INT_PLUG_EVENT,
+	.tps_struct_size = sizeof(struct cd321x),
 	.register_port = tps6598x_register_port,
 	.trace_data_status = trace_cd321x_data_status,
 	.trace_power_status = trace_tps6598x_power_status,
@@ -1535,6 +1543,7 @@ static const struct tipd_data tps6598x_data = {
 	.irq_mask1 = TPS_REG_INT_POWER_STATUS_UPDATE |
 		     TPS_REG_INT_DATA_STATUS_UPDATE |
 		     TPS_REG_INT_PLUG_EVENT,
+	.tps_struct_size = sizeof(struct tps6598x),
 	.register_port = tps6598x_register_port,
 	.trace_data_status = trace_tps6598x_data_status,
 	.trace_power_status = trace_tps6598x_power_status,
@@ -1549,6 +1558,7 @@ static const struct tipd_data tps25750_data = {
 	.irq_mask1 = TPS_REG_INT_POWER_STATUS_UPDATE |
 		     TPS_REG_INT_DATA_STATUS_UPDATE |
 		     TPS_REG_INT_PLUG_EVENT,
+	.tps_struct_size = sizeof(struct tps6598x),
 	.register_port = tps25750_register_port,
 	.trace_data_status = trace_tps6598x_data_status,
 	.trace_power_status = trace_tps25750_power_status,

-- 
2.34.1



