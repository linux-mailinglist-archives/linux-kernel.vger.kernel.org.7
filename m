Return-Path: <linux-kernel+bounces-815611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6919B568F2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37FE84E0215
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 12:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633342727ED;
	Sun, 14 Sep 2025 12:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKIriVvi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9803F1E7C18;
	Sun, 14 Sep 2025 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757854608; cv=none; b=R9MYeeFSgeXMSiH43RzZMKAWFNnaXk2Ypzb0K2vqlE297QDg+a0crsknHIPjnKI2eAkTTG0/PalCSSxib6OiVYfRdxq2p0osPoqhXOh4A2CZ+8vCdl78L2Lf9ZGxFwUXJ0kJ2mdJoxaM9zNy1Is8Dmgah2YmlWquQfwpIzF2ncU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757854608; c=relaxed/simple;
	bh=sUkw4q4IY9bSBtfRWTCcqxsVU/bRRgymfhNhDOYa7GM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tT71uMxQ8SP58gcVf2okM3GZww9wEdW/rEoaEutgc3RVf61EPEzcEhKAWSZqzRzsrVvNr6IcJC4H4BRLP7jAee5Mw3sMllK1kwfy1sjYOjQ34bFgPzd35Un74OzHmo8XjXXybMnENZoq0EtsGUPuG2hfd8unv66lHZr1mPGETDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKIriVvi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4765BC4CEFD;
	Sun, 14 Sep 2025 12:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757854608;
	bh=sUkw4q4IY9bSBtfRWTCcqxsVU/bRRgymfhNhDOYa7GM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UKIriVviyUhz8icNz7vYIZIyWaQo2Ume4+meCG3F82iYctnWeBsLBv04fHA1ORYFL
	 goUJuNn6iCYECVoe6zenmbb7Fn9CbXCHcLQAo1H6mRDRFWvBBrlRkaKhOEv5PeSOA/
	 67fm8/bvlcpFc4USAWcxW+SIIWPXJG7YjA3wrOumBcUu0j18BoAOFsTbmDpBX1dKzL
	 r+WU1Zv6373AO/YeyS8z5WnCaleljYvgq8vC6qnAwkgkR9KFf1ZhGV8niVZWmw67Yw
	 TX7ChdhBWhihjWcfUBZ0YBGZNLUn7SactmuwuQPnb5hn57ud0dwmaRjgGu7rCvRpGA
	 UFOHDaEUuGYnA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392A5CAC58F;
	Sun, 14 Sep 2025 12:56:48 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Sun, 14 Sep 2025 12:56:08 +0000
Subject: [PATCH 03/11] usb: typec: tipd: Move switch_power_state to
 tipd_data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250914-apple-usb3-tipd-v1-3-4e99c8649024@kernel.org>
References: <20250914-apple-usb3-tipd-v1-0-4e99c8649024@kernel.org>
In-Reply-To: <20250914-apple-usb3-tipd-v1-0-4e99c8649024@kernel.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Sven Peter <sven@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2365; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=sUkw4q4IY9bSBtfRWTCcqxsVU/bRRgymfhNhDOYa7GM=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8ax3dUsr4w3vX+QVSXGvMxFZcrDtVoXH5RLtggZ/rJZ/
 /2estWfjlIWBjEOBlkxRZbt++1Nnzx8I7h006X3MHNYmUCGMHBxCsBEOC4wMvx2C9vxyGm3uVL+
 22CjJTeOqO9RmHLXoSz7d4bkrAbP3JUMv9n1lYzm+l3In8Zg+X23Yu43lV3TPnLxqn08GaAu0HR
 UnBkA
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

When support for CD321x was originally added no other hardware variant
was supported and there was no need for struct tipd_data. Now that it
exists move the special case in there so that we can drop the
of_device_is_compatible_check entirely.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Sven Peter <sven@kernel.org>
---
 drivers/usb/typec/tipd/core.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 6d8bcbc9cad8a1394e066504d4c5ca570edd4e4f..4815c5c462837865a5f9d37bbc139249c82c2f75 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -118,6 +118,7 @@ struct tipd_data {
 	void (*trace_status)(u32 status);
 	int (*apply_patch)(struct tps6598x *tps);
 	int (*init)(struct tps6598x *tps);
+	int (*switch_power_state)(struct tps6598x *tps, u8 target_state);
 	int (*reset)(struct tps6598x *tps);
 };
 
@@ -1293,7 +1294,6 @@ tps25750_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
 
 static int tps6598x_probe(struct i2c_client *client)
 {
-	struct device_node *np = client->dev.of_node;
 	struct tps6598x *tps;
 	struct fwnode_handle *fwnode;
 	u32 status;
@@ -1331,18 +1331,16 @@ static int tps6598x_probe(struct i2c_client *client)
 	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		tps->i2c_protocol = true;
 
-	if (np && of_device_is_compatible(np, "apple,cd321x")) {
-		/* Switch CD321X chips to the correct system power state */
-		ret = cd321x_switch_power_state(tps, TPS_SYSTEM_POWER_STATE_S0);
-		if (ret)
-			return ret;
-
-	}
-
 	tps->data = i2c_get_match_data(client);
 	if (!tps->data)
 		return -EINVAL;
 
+	if (tps->data->switch_power_state) {
+		ret = tps->data->switch_power_state(tps, TPS_SYSTEM_POWER_STATE_S0);
+		if (ret)
+			return ret;
+	}
+
 	/* Make sure the controller has application firmware running */
 	ret = tps6598x_check_mode(tps);
 	if (ret < 0)
@@ -1525,6 +1523,7 @@ static const struct tipd_data cd321x_data = {
 	.trace_status = trace_tps6598x_status,
 	.init = cd321x_init,
 	.reset = cd321x_reset,
+	.switch_power_state = cd321x_switch_power_state,
 };
 
 static const struct tipd_data tps6598x_data = {

-- 
2.34.1



