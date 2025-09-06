Return-Path: <linux-kernel+bounces-804336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5526B47284
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 17:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1922176942
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDABF2FE074;
	Sat,  6 Sep 2025 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXSU2X0y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E61C289E07;
	Sat,  6 Sep 2025 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757173420; cv=none; b=UIMi6cMeTvfYD753yOnPB9a7e+ycai0BtgnLgpD7xbvOQYYj13eVqnNKW/Ls5sEMn8qbhCqy91f5NKaCn6dHH7MOJcjVYXFJ7n6vDUOa57kEHyKVJpgv1tneFoVcLMxT4rTDzoBuCHYidLMP21BTAkaINfON/3iboHxKqL6jEL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757173420; c=relaxed/simple;
	bh=W4i17xp3u3JigmcFedI8/zdpo2DC0szFJNzKL3OP7zQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ez8weMInI/0h6lG8tnXvt81XjLuXKXKR/WgVF91PX6H9oxpEAg2C2xp1nKQH5kM8gHQplhwywTmjtrp616OglviRgKEqwNyJZD/45tFRq2n4cGrkVYCP0AgmrdloBG0gJOzsE1QuP0zKHy+2qOPpukdrAeOAWoh0kIas2o4FAsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXSU2X0y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97278C2BC87;
	Sat,  6 Sep 2025 15:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757173419;
	bh=W4i17xp3u3JigmcFedI8/zdpo2DC0szFJNzKL3OP7zQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GXSU2X0yuqEqcgIXw4++1duW1AvkYDAuvZmLpnXa3GR1D+aKkDBBH0Jg2Op16r6Oc
	 AJNOGu7drmRw9QBs2nAMlKtNwNU15Y6v5/JuI8X8ssTJR2cM1EmTOSYqU9a4ce5IVV
	 hmG+i5lBW2eJbtSqZNjI5nLyuL5LcuAg/bA6IHppw+T53nh9QAkpaAi3Ogbz2cwRQc
	 3aDJyBeV2IS/zhnJfhxgr4exY0YAt3BTf5Zz66d9Zn5/Ro0hHBF9UgQXx0hk5hYB/F
	 OHCpOgPSR3+IMKshLhjJlh2Z0N3w2ui5N5qsi9obeFup+aq4MCL2NskWFA8gnx1kpx
	 N36nLmCec72gQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0C9CA1002;
	Sat,  6 Sep 2025 15:43:39 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Sat, 06 Sep 2025 15:43:20 +0000
Subject: [PATCH v2 07/22] usb: typec: tipd: Move switch_power_state to
 tipd_data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250906-atcphy-6-17-v2-7-52c348623ef6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2323; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=W4i17xp3u3JigmcFedI8/zdpo2DC0szFJNzKL3OP7zQ=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8aesHlWOivDd/tkmESs+yyWuFftTt0avnk3Xc+7scton
 voS7veuo5SFQYyDQVZMkWX7fnvTJw/fCC7ddOk9zBxWJpAhDFycAjCR5+mMDOcMTYXn9vFtStKY
 wZMepSfj5MT6dubPbw+7SuoWxpzuPsrwP/ZkmxbPp/NbvU7MOah9UEB8oueR+Pv32i9KMbTyvNY
 5xwkA
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

When support for CD321x was originally added no other hardware variant
was supported and there was no need for struct tipd_data. Now that it
exists move the special case in there so that we can drop the
of_device_is_compatible_check entirely.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
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



