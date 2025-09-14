Return-Path: <linux-kernel+bounces-815617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D829BB56902
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53AEC1898A1B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 12:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28AD27A476;
	Sun, 14 Sep 2025 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIECAbE+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD08A26CE23;
	Sun, 14 Sep 2025 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757854609; cv=none; b=UMeBvAGqF4YkWxjfcWAp8Seccs/0XaCVMu4gB1bA697KwrR814W8NkNhmPpyTqnjyPoMsOtYd3YqUocPY7npH5TcpG7eChjbH8ZHFb+LKf9lIIvpw784J2CJ7pmeX7W7IR6Ek+PHOIOt9soXUG9i42ZT+YM3K0YKLvenpavSpWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757854609; c=relaxed/simple;
	bh=nZk44p+QqpioWkfSX5+bKeVart8pQqEx9xjGIa/iQGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VemlHlZ+SCsGdA3oY6sfE3JyJkrfNtdSxV/Rsj9SWjXIy3lxgWKtaOFmy3ajDibH+kyYCU16Xic84m169C2f8kX9YM985A/jZS4thGZue45rZ4kVZKldlcOJVZDMJa4ukAajte2FsxCdPOsENlMcmgobJbhiM9HLSuSjAy8qE9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIECAbE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59F23C4CEFF;
	Sun, 14 Sep 2025 12:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757854608;
	bh=nZk44p+QqpioWkfSX5+bKeVart8pQqEx9xjGIa/iQGY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aIECAbE+E4sSQUK65ku7nSLVgiur9eEdHaThjB7yOF3HNhn2gVJccPdKe7pjxmccE
	 3zovb7PO3l6y3N6WPhmLeJNiODZ9mPPb45lT07+6rN2K9iyHGUSdLEviS3lCwjyd54
	 7bcMJcOFabkfQ3bGYLlFz4efVIQJIZmVeopF2HYV6IU+fJPi0Z9iwWyYNUEvcfJBNx
	 oWWR9mSRTXhtTk+y7FfMGPKaQAe9hCvfnuqemjkW+17WBNzsvvFWUdd8E6vwHCI1ax
	 9gw9CoS0tq5qLsHIvmGOb0xy7KqKfhz5UU0K38eVfdmMi4NKtgj7GoQfIHNFc4XQNK
	 Gq/KsEjk8PMDw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537B1CAC597;
	Sun, 14 Sep 2025 12:56:48 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Sun, 14 Sep 2025 12:56:10 +0000
Subject: [PATCH 05/11] usb: typec: tipd: Add cd321x struct with separate
 size
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250914-apple-usb3-tipd-v1-5-4e99c8649024@kernel.org>
References: <20250914-apple-usb3-tipd-v1-0-4e99c8649024@kernel.org>
In-Reply-To: <20250914-apple-usb3-tipd-v1-0-4e99c8649024@kernel.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Sven Peter <sven@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3612; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=nZk44p+QqpioWkfSX5+bKeVart8pQqEx9xjGIa/iQGY=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8ax3XXXeGo/cS64FZzr0VBfuOOJ08LZDfe2sJjYfhDU9
 njHybm6o5SFQYyDQVZMkWX7fnvTJw/fCC7ddOk9zBxWJpAhDFycAjAR3zhGhsd/r5yxm+Z99z6j
 gcqcsPxq32Xli15WKzfe9/nVo1ySO4eR4dzc/72zq9otPnX/aZghd2uby8rJeqli7+7//bS8euH
 JD+wA
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

We're about to add more fields to struct tps6598x which are only relevant
for Apple's CD321x and to ensure that we don't waste memory everywhere for
those add a separate struct for cd321x and prepare to allocate more space
inside probe.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Neal Gompa <neal@gompa.dev>
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



