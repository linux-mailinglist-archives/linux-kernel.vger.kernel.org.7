Return-Path: <linux-kernel+bounces-850636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9896BD357E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F20431886FB2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41142EA164;
	Mon, 13 Oct 2025 14:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dslZM7Jt"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79C0255F5E
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364368; cv=none; b=f4JbCb7MEAlVMP2X4z66QEAu5S74l1D8vfGwOxq35oAxKD6YzAUztQWj6V2VXACw6d4D/2QHLyO3GrO/L9AJKrAe34SBPHOtpz/Qa00+Akcd/VZdxl6A58q8YkGtn0jkV+ojWPnnsKDs2ucEZJSSKNS1lqqhrd2bVOpXp6eMM7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364368; c=relaxed/simple;
	bh=RXiNSsaLBFvnwtGUyw4I9dI1476goIIzvGRvfaz60TY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YP1l2/ABtz9MeYrcmZ23OHMZww2YnUvKZGaoF3MIPir0sSqCymq8TGV7tF5iEC8vodDJy9VjHHXRRjT2+8Pv8a2BF0qia4Lmjpxx2R79qOTnXhF5wtC8sA5uF13LLbObdLumZnb1pERm2qfUXuv64zaQ4iEU9zqY+QIgkkigRNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dslZM7Jt; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2F3764E4106D;
	Mon, 13 Oct 2025 14:06:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 05FE7606C6;
	Mon, 13 Oct 2025 14:06:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 226F5102F226C;
	Mon, 13 Oct 2025 16:06:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760364364; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IAlSFBW3wt+5q5wx1Fjlx3+q6drrWVIVS7BvJiZpmkM=;
	b=dslZM7Jtcup6liLgBz8gGb//d6JIfevUXzkVaHDshosSxLehuvZVGdAZCp7X1eUtMnfO9T
	K8cOfsWVdSzIqEXZif7AGJ8G0h6uaFN58FTpUakuFAC6F6n7MkGgv9EUZkMDSiguVJn+6b
	BU/ftJwksrZVTd97hybzAM7yuOLMx+mYRsfStDFLvfOaMAww/G1z95YwwJA+OHAw+idu1p
	M5buwSFSnye1c7/tEYpWjNw0gh3XaRuMK6ZTW0xbWn1C9u+FaCHtFyp4QGdalHvZaHhoN8
	XCUxiJw/OwF/00RZU/a8uZ4nlyYYiimW0FsE5dFU8Oo6gGOkpOsLfXf9SP3gaA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Mon, 13 Oct 2025 16:05:33 +0200
Subject: [PATCH net-next v2 3/3] net: pse-pd: pd692x0: Preserve PSE
 configuration across reboots
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-feature_pd692x0_reboot_keep_conf-v2-3-68ab082a93dd@bootlin.com>
References: <20251013-feature_pd692x0_reboot_keep_conf-v2-0-68ab082a93dd@bootlin.com>
In-Reply-To: <20251013-feature_pd692x0_reboot_keep_conf-v2-0-68ab082a93dd@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, kernel@pengutronix.de, 
 Dent Project <dentproject@linuxfoundation.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-Last-TLS-Session-Version: TLSv1.3

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Detect when PSE hardware is already configured (user byte == 42) and
skip hardware initialization to prevent power interruption to connected
devices during system reboots.

Previously, the driver would always reconfigure the PSE hardware on
probe, causing a port matrix reflash that resulted in temporary power
loss to all connected devices. This change maintains power continuity
by preserving existing configuration when the PSE has been previously
initialized.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/pd692x0.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index 782b1abf94cb..134435e90073 100644
--- a/drivers/net/pse-pd/pd692x0.c
+++ b/drivers/net/pse-pd/pd692x0.c
@@ -30,6 +30,8 @@
 #define PD692X0_FW_MIN_VER	5
 #define PD692X0_FW_PATCH_VER	5
 
+#define PD692X0_USER_BYTE	42
+
 enum pd692x0_fw_state {
 	PD692X0_FW_UNKNOWN,
 	PD692X0_FW_OK,
@@ -80,6 +82,7 @@ enum {
 	PD692X0_MSG_GET_PORT_PARAM,
 	PD692X0_MSG_GET_POWER_BANK,
 	PD692X0_MSG_SET_POWER_BANK,
+	PD692X0_MSG_SET_USER_BYTE,
 
 	/* add new message above here */
 	PD692X0_MSG_CNT
@@ -103,6 +106,7 @@ struct pd692x0_priv {
 	bool last_cmd_key;
 	unsigned long last_cmd_key_time;
 
+	bool cfg_saved;
 	enum ethtool_c33_pse_admin_state admin_state[PD692X0_MAX_PIS];
 	struct regulator_dev *manager_reg[PD692X0_MAX_MANAGERS];
 	int manager_pw_budget[PD692X0_MAX_MANAGERS];
@@ -193,6 +197,12 @@ static const struct pd692x0_msg pd692x0_msg_template_list[PD692X0_MSG_CNT] = {
 		.key = PD692X0_KEY_CMD,
 		.sub = {0x07, 0x0b, 0x57},
 	},
+	[PD692X0_MSG_SET_USER_BYTE] = {
+		.key = PD692X0_KEY_PRG,
+		.sub = {0x41, PD692X0_USER_BYTE},
+		.data = {0x4e, 0x4e, 0x4e, 0x4e,
+			 0x4e, 0x4e, 0x4e, 0x4e},
+	},
 };
 
 static u8 pd692x0_build_msg(struct pd692x0_msg *msg, u8 echo)
@@ -1233,6 +1243,15 @@ static void pd692x0_managers_free_pw_budget(struct pd692x0_priv *priv)
 	}
 }
 
+static int
+pd692x0_save_user_byte(struct pd692x0_priv *priv)
+{
+	struct pd692x0_msg msg, buf;
+
+	msg = pd692x0_msg_template_list[PD692X0_MSG_SET_USER_BYTE];
+	return pd692x0_sendrecv_msg(priv, &msg, &buf);
+}
+
 static int pd692x0_setup_pi_matrix(struct pse_controller_dev *pcdev)
 {
 	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
@@ -1268,9 +1287,16 @@ static int pd692x0_setup_pi_matrix(struct pse_controller_dev *pcdev)
 	if (ret)
 		goto err_managers_req_pw;
 
-	ret = pd692x0_hw_conf_init(priv);
-	if (ret)
-		goto err_managers_req_pw;
+	/* Do not init the conf if it is already saved */
+	if (!priv->cfg_saved) {
+		ret = pd692x0_hw_conf_init(priv);
+		if (ret)
+			goto err_managers_req_pw;
+
+		ret = pd692x0_save_user_byte(priv);
+		if (ret)
+			goto err_managers_req_pw;
+	}
 
 	pd692x0_of_put_managers(priv, manager);
 	kfree(manager);
@@ -1793,6 +1819,9 @@ static int pd692x0_i2c_probe(struct i2c_client *client)
 		}
 	}
 
+	if (buf.data[2] == PD692X0_USER_BYTE)
+		priv->cfg_saved = true;
+
 	priv->np = dev->of_node;
 	priv->pcdev.nr_lines = PD692X0_MAX_PIS;
 	priv->pcdev.owner = THIS_MODULE;

-- 
2.43.0


