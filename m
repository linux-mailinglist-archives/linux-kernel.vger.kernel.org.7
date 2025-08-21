Return-Path: <linux-kernel+bounces-780212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 953BFB2FF1C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0879BB01548
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D39343216;
	Thu, 21 Aug 2025 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+5bPyid"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595BE2D3EE6;
	Thu, 21 Aug 2025 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755790804; cv=none; b=C7akRuu5pa+cyXseyN95QWA2O06Od/O90V6gMv5T5kBKOEmLMvzkh+zmR71uanWg5DmfEn9cqjC471YqdQkQaBUbCXZgUCUaLcpasX/LafOqAs8VWFRSKaYUSrKR0TH6Us34lxcZRiVq6Kx/w3pPyYkiu9UXjWBicI5En3HMHTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755790804; c=relaxed/simple;
	bh=9b0UWJfjrXCs7KOiQdQ75i5y2gJdq9gUxiVJvcVeHXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h306I48CebnSKvCPV+1fyuPltycZ4EJanDePUEnIjO3sxJMtp1TgU9fVVm4WySPpqlOpO4F1zxRt+dvdUmMrrUdZfKgj4OyErB53k9F9duatmuJ57Qp0VcySyNmRLKDA+M+3Xlfx0kTBICuBEjLA7qVAIuASsjMri7CTbsrBeHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+5bPyid; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1069C2BCFB;
	Thu, 21 Aug 2025 15:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755790803;
	bh=9b0UWJfjrXCs7KOiQdQ75i5y2gJdq9gUxiVJvcVeHXA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H+5bPyidn8Qqa5k6hTahJscGN05bCasClF5mMHGbvV+Xq26Wmgkc3apYClcrHpJ4P
	 Cu0Zrx8jpjF3DGEcp+wqrbNeNgKXlgPPya3URsuDIStuo03N9OvwLnjV6t1CqoSwwu
	 kj2807naqNOCzk7Q+HvRS6SE5PJgbjrELEgOqLGsXAXci4qnxjYNVPtHk3KznyfMvD
	 CgqCW00e1YkcO4glzQJqSOVCpuj6oBrIgbSgaO0zODlG43+I4oPaiMncGeN9j89bVz
	 0XeGmDdo8UvEvY29KpkwfA3zqRX6cEM6MoQ9fg0HnuCda5f/gqo++v91ErIy1qSv1C
	 2NBLiUosMn3+Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BAFCA0FE6;
	Thu, 21 Aug 2025 15:40:03 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Thu, 21 Aug 2025 15:39:02 +0000
Subject: [PATCH RFC 10/22] usb: typec: tipd: Move switch_power_state to
 tipd_data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-atcphy-6-17-v1-10-172beda182b8@kernel.org>
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
 Sven Peter <sven@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2259; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=9b0UWJfjrXCs7KOiQdQ75i5y2gJdq9gUxiVJvcVeHXA=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8Zy27W+3KLP8xdIeDa8kpZbUayuzJoSnrLN0f1fYRDH8
 62961o6SlkYxDgYZMUUWbbvtzd98vCN4NJNl97DzGFlAhnCwMUpABPZ9oOR4UlB5tX3MRybrvXl
 ndq4Imr1Z6PwqRL7b7t+aUw5qcr23YWRYfu2uOn3d3IGnNP+8WPm08c9HgZ+l3e933Ikvaev01z
 pLT8A
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

When support for CD321x was originally added no other hardware variant
was supported and there was no need for struct tipd_data. Now that it
exists move the special case in there so that we can drop the
of_device_is_compatible_check entirely.

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



