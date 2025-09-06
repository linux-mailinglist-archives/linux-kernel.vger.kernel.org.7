Return-Path: <linux-kernel+bounces-804335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07124B47282
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 17:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5BE31C211DF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C922FE575;
	Sat,  6 Sep 2025 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8GCzBCY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBBE289811;
	Sat,  6 Sep 2025 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757173420; cv=none; b=twVrm3wwEiJ7KCEFS8xyXP8FL96gc8FzOj3tNG0xjbnuzCR4yUTG2ok2ysUwWEP0iZ44K2p0JJ6MzushxtwatnHxs/Kcxl6MZzcikv0iY9dGw98yhzGOqsyGKsw8ijzfxT4bUBjsytTGljMJadT3h4qw7XygVxt/qtt5wyo+P+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757173420; c=relaxed/simple;
	bh=MXTlQV6o7leJfeFdeDCCrl77XRrADXKq1orvTlMWuSE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GlmFdpDwYAXZNPnYvJZCxbOqP4KiBK86ENx2YtyjuLrNMfH2Q01HocbWIuRLYi5KWC51WG8KWwHMNHEZgVGNLYoBtXG4GeukR3gKrQGl2bM4KXfaPcTgP2CMezQgzzCtY+EeNiP0WyYBZ8q38uDCj2t8TLp3TsbjoWxaZjAftFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8GCzBCY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8EF1C19423;
	Sat,  6 Sep 2025 15:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757173419;
	bh=MXTlQV6o7leJfeFdeDCCrl77XRrADXKq1orvTlMWuSE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X8GCzBCYW4oU9ibDevb0oMcDM0BkNM32sjnjq7oLsuPtnMTQqUMnTwtu2JjHY1VYk
	 pWhCje9yNi0ecX0KUtyZs5jqr4Yy27ujGMdh0vg5WDYgWYv0bEYmC2WEzFQYvIQeGK
	 7oMZrKsT9uioFIAXjGZcimUOI1elnPldoUcrPa3cgan+pE+G2eXnqOAE+l2taoCkFR
	 KfHo4hejVKWSEt49ooNMPngm1xHaGE/jnoDXuyXbBJkr/hvl9kCFNUbvNgkQ9eIGI8
	 uenzVPOZEssQZ9Tnr/d0MD34GLIbCk7sIStLTLFnxMfQNzbrfScEtOxOZSdNJZciUM
	 ertyBdrQ+sSoQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF913CAC582;
	Sat,  6 Sep 2025 15:43:39 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Sat, 06 Sep 2025 15:43:23 +0000
Subject: [PATCH v2 10/22] usb: typec: tipd: Read USB4, Thunderbolt and
 DisplayPort status for cd321x
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250906-atcphy-6-17-v2-10-52c348623ef6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5684; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=MXTlQV6o7leJfeFdeDCCrl77XRrADXKq1orvTlMWuSE=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8aesAWNRvvnRCyI3bSDP+VTBPvSx5P+3tUWT5ZQMlmqs
 nx+2lPLjlIWBjEOBlkxRZbt++1Nnzx8I7h006X3MHNYmUCGMHBxCsBEdixgZPhen/Y5wM8itrAl
 m/Wr6Z8DfqbHlkoGfzLzCKkTMvwhk8nIcOfQHysL9aIFd9RZv0wRX+n/cQNX1RlLxnLVxR2JPrK
 WTAA=
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

CD321x supports various alternate modes and stores information once
these are entered into separate status registers. Read those when they
are active when reading TPS_DATA_STATUS to prepare supporting these.

Signed-off-by: Sven Peter <sven@kernel.org>
---
 drivers/usb/typec/tipd/core.c | 80 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 76 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 51b0f3be8b66a743ddc3ea96c1b25f597a1e8f6c..afd11b3e1ae596c7f3283e4336aaa57874c9378d 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -35,14 +35,18 @@
 #define TPS_REG_INT_MASK2		0x17
 #define TPS_REG_INT_CLEAR1		0x18
 #define TPS_REG_INT_CLEAR2		0x19
-#define TPS_REG_SYSTEM_POWER_STATE	0x20
 #define TPS_REG_STATUS			0x1a
+#define TPS_REG_SYSTEM_POWER_STATE	0x20
+#define TPS_REG_USB4_STATUS		0x24
 #define TPS_REG_SYSTEM_CONF		0x28
 #define TPS_REG_CTRL_CONF		0x29
 #define TPS_REG_BOOT_STATUS		0x2D
 #define TPS_REG_POWER_STATUS		0x3f
 #define TPS_REG_PD_STATUS		0x40
 #define TPS_REG_RX_IDENTITY_SOP		0x48
+#define TPS_REG_CF_VID_STATUS		0x5e
+#define TPS_REG_DP_SID_STATUS		0x58
+#define TPS_REG_INTEL_VID_STATUS	0x59
 #define TPS_REG_DATA_STATUS		0x5f
 #define TPS_REG_SLEEP_CONF		0x70
 
@@ -85,6 +89,31 @@ struct tps6598x_rx_identity_reg {
 	struct usb_pd_identity identity;
 } __packed;
 
+/* TPS_REG_USB4_STATUS */
+struct tps6598x_usb4_status_reg {
+	u8 mode_status;
+	__le32 eudo;
+	__le32 unknown;
+} __packed;
+
+/* TPS_REG_DP_SID_STATUS */
+struct tps6598x_dp_sid_status_reg {
+	u8 mode_status;
+	__le32 status_tx;
+	__le32 status_rx;
+	__le32 configure;
+	__le32 mode_data;
+} __packed;
+
+/* TPS_REG_INTEL_VID_STATUS */
+struct tps6598x_intel_vid_status_reg {
+	u8 mode_status;
+	__le32 attention_vdo;
+	__le16 enter_vdo;
+	__le16 device_mode;
+	__le16 cable_mode;
+} __packed;
+
 /* Standard Task return codes */
 #define TPS_TASK_TIMEOUT		1
 #define TPS_TASK_REJECTED		3
@@ -121,6 +150,7 @@ struct tipd_data {
 	int (*apply_patch)(struct tps6598x *tps);
 	int (*init)(struct tps6598x *tps);
 	int (*switch_power_state)(struct tps6598x *tps, u8 target_state);
+	bool (*read_data_status)(struct tps6598x *tps);
 	int (*reset)(struct tps6598x *tps);
 };
 
@@ -151,6 +181,10 @@ struct tps6598x {
 
 struct cd321x {
 	struct tps6598x tps;
+
+	struct tps6598x_dp_sid_status_reg dp_sid_status;
+	struct tps6598x_intel_vid_status_reg intel_vid_status;
+	struct tps6598x_usb4_status_reg usb4_status;
 };
 
 static enum power_supply_property tps6598x_psy_props[] = {
@@ -505,6 +539,41 @@ static bool tps6598x_read_data_status(struct tps6598x *tps)
 	return true;
 }
 
+static bool cd321x_read_data_status(struct tps6598x *tps)
+{
+	struct cd321x *cd321x = container_of(tps, struct cd321x, tps);
+	int ret;
+
+	ret = tps6598x_read_data_status(tps);
+	if (ret < 0)
+		return false;
+
+	if (tps->data_status & TPS_DATA_STATUS_DP_CONNECTION) {
+		ret = tps6598x_block_read(tps, TPS_REG_DP_SID_STATUS,
+				&cd321x->dp_sid_status, sizeof(cd321x->dp_sid_status));
+		if (ret)
+			dev_err(tps->dev, "Failed to read DP SID Status: %d\n",
+				ret);
+	}
+
+	if (tps->data_status & TPS_DATA_STATUS_TBT_CONNECTION) {
+		ret = tps6598x_block_read(tps, TPS_REG_INTEL_VID_STATUS,
+				&cd321x->intel_vid_status, sizeof(cd321x->intel_vid_status));
+		if (ret)
+			dev_err(tps->dev, "Failed to read Intel VID Status: %d\n", ret);
+	}
+
+	if (tps->data_status & CD321X_DATA_STATUS_USB4_CONNECTION) {
+		ret = tps6598x_block_read(tps, TPS_REG_USB4_STATUS,
+				&cd321x->usb4_status, sizeof(cd321x->usb4_status));
+		if (ret)
+			dev_err(tps->dev,
+				"Failed to read USB4 Status: %d\n", ret);
+	}
+
+	return true;
+}
+
 static bool tps6598x_read_power_status(struct tps6598x *tps)
 {
 	u16 pwr_status;
@@ -565,7 +634,7 @@ static irqreturn_t cd321x_interrupt(int irq, void *data)
 			goto err_unlock;
 
 	if (event & APPLE_CD_REG_INT_DATA_STATUS_UPDATE)
-		if (!tps6598x_read_data_status(tps))
+		if (!tps->data->read_data_status(tps))
 			goto err_unlock;
 
 	/* Handle plug insert or removal */
@@ -614,7 +683,7 @@ static irqreturn_t tps25750_interrupt(int irq, void *data)
 			goto err_clear_ints;
 
 	if (event[0] & TPS_REG_INT_DATA_STATUS_UPDATE)
-		if (!tps6598x_read_data_status(tps))
+		if (!tps->data->read_data_status(tps))
 			goto err_clear_ints;
 
 	/*
@@ -688,7 +757,7 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
 			goto err_unlock;
 
 	if ((event1[0] | event2[0]) & TPS_REG_INT_DATA_STATUS_UPDATE)
-		if (!tps6598x_read_data_status(tps))
+		if (!tps->data->read_data_status(tps))
 			goto err_unlock;
 
 	/* Handle plug insert or removal */
@@ -1534,6 +1603,7 @@ static const struct tipd_data cd321x_data = {
 	.trace_power_status = trace_tps6598x_power_status,
 	.trace_status = trace_tps6598x_status,
 	.init = cd321x_init,
+	.read_data_status = cd321x_read_data_status,
 	.reset = cd321x_reset,
 	.switch_power_state = cd321x_switch_power_state,
 };
@@ -1550,6 +1620,7 @@ static const struct tipd_data tps6598x_data = {
 	.trace_status = trace_tps6598x_status,
 	.apply_patch = tps6598x_apply_patch,
 	.init = tps6598x_init,
+	.read_data_status = tps6598x_read_data_status,
 	.reset = tps6598x_reset,
 };
 
@@ -1565,6 +1636,7 @@ static const struct tipd_data tps25750_data = {
 	.trace_status = trace_tps25750_status,
 	.apply_patch = tps25750_apply_patch,
 	.init = tps25750_init,
+	.read_data_status = tps6598x_read_data_status,
 	.reset = tps25750_reset,
 };
 

-- 
2.34.1



