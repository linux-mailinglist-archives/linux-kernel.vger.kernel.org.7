Return-Path: <linux-kernel+bounces-815608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2774B568F3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AD953BFD9A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 12:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671CC2727F3;
	Sun, 14 Sep 2025 12:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrK7XiSk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917FE155A4E;
	Sun, 14 Sep 2025 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757854608; cv=none; b=EZtSvYdnPKGU93qe+3BrwnmRpvikK78JwsA8y5dkG7kTjGCdrBAURDwHUysFr3qa8yWNZM3PelfcLU1/aE0pp6y7DAzRQZGGwvft7WFhsO/7wW7Sre8msGd51qC9HHe/TV3ihBXfFG2tAxBm9+yas3evDl/aartfeK/brYIqhZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757854608; c=relaxed/simple;
	bh=PWktnbKRR/csBSa+TtAeLTOjYJ8uGFc3oo299yXS8Bk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MTKUZ53tCvEfGVNQSf7+TP7Am+o7eNkEiqmOuU/HW+3/6oX+9CkPhPbmyQM7iSrZ3drlmTdxJSYG4/16WC7K/ZiGqWDXreCTxzRT2PbSeXhg8M45TNcg5+7NiOJ3o2qyTAlSaROZuFrvM4U9c/rjyTzW3UF4jtuSdubijs2USOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrK7XiSk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3ADC8C4CEF5;
	Sun, 14 Sep 2025 12:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757854608;
	bh=PWktnbKRR/csBSa+TtAeLTOjYJ8uGFc3oo299yXS8Bk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MrK7XiSkUkQbBf8PHxjrdsNy3szbKC63xIH73M2Mmpg1PBjnxS8dC0YToYh9ImGWC
	 qmY1KAQTgBxq0rUWJ0mLZqxDMjOfoiIQPCDp4c8Z60wGTj81PmAcYDh/86zgHmRz57
	 5n46ANLsDVujUgRGzXBS/itJSaapbCMrFjYdgJk3+87GKep5XUIIIKtmg4x0wJm9Hd
	 pLugNsI2REuPZwg5EDYCylVnKzgCJLvbK6rclrdbrbf3QX+hB0VwjhfgkzxN3MEgTg
	 4qfma2vWthjCF/G6EtjsaT2DDa5pW5RSeYwpd91Q0rrMgJtaculv1ikIPJVmt/NGto
	 YizflX96D2Nag==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA69CAC594;
	Sun, 14 Sep 2025 12:56:48 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Sun, 14 Sep 2025 12:56:07 +0000
Subject: [PATCH 02/11] usb: typec: tipd: Move initial irq mask to tipd_data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250914-apple-usb3-tipd-v1-2-4e99c8649024@kernel.org>
References: <20250914-apple-usb3-tipd-v1-0-4e99c8649024@kernel.org>
In-Reply-To: <20250914-apple-usb3-tipd-v1-0-4e99c8649024@kernel.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Sven Peter <sven@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3274; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=PWktnbKRR/csBSa+TtAeLTOjYJ8uGFc3oo299yXS8Bk=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8ax3ZWnNi1l1+uPmrJ70m6BRIn6Tff6bR4bhm6v+qTrE
 bNiYp1kRykLgxgHg6yYIsv2/famTx6+EVy66dJ7mDmsTCBDGLg4BWAi+VqMDFe454eVH1vL+FtT
 ZP3SBak+XzJeTmp58mp7QNv8pdYiNQYM/2vfndrw/hFb/937Ex83TLR8p26723Lp4pM5iZNcvu5
 u38oOAA==
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

Since the irq mask was originally added more tipd variants have been
introduced and there's now struct tipd_data. Move the initial mask in
there.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Neal Gompa <neal@gompa.dev>
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



