Return-Path: <linux-kernel+bounces-780218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF21B2FF27
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C867B01895
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BFE3451C8;
	Thu, 21 Aug 2025 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9FJ8fMI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2612E03F1;
	Thu, 21 Aug 2025 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755790804; cv=none; b=azdurM9CnyZlKqb6kJCNUQEBU78JUfaD6nW85OiJMKDb20KBB9VI/KVFaQZ0geMEExtApODwR9FTZPFXu7xNlAm3g2jCMCnUoKBoD1Vk7NMy0QsVvhu5lUEoid9XjQrQmOOnbFjOG3Scj5eyDCPzp8tZhtPyn2GFxPCaLoDWGAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755790804; c=relaxed/simple;
	bh=JpvVGxBU6VJFwCo6sQ3bdFMMfZ4sHXsnoW4iOc433dI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R1zIXd/Y04K6+wO7Me8KxNVAlWjfpSr3XmgmSphLG4f1IAeJ/huuZ73dv1RldFsbJtKr2+Vu3CK/aFBURDlS2xpuIQ/4zjejzUQhoqFP9eFZmSgRWAwSQKKnNckRUIiQasBDeNBNjS4LmhKPWEseoy1VHI9LNJGvnmyINnbBf/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9FJ8fMI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03347C2BCC9;
	Thu, 21 Aug 2025 15:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755790804;
	bh=JpvVGxBU6VJFwCo6sQ3bdFMMfZ4sHXsnoW4iOc433dI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L9FJ8fMIWsSov5P/KMDu/sSBGHrs73BU2rqNdh201zQwpXEeViQy3Zn8IkLlzLePC
	 4AJVwr1n0SSiEDbjb48J3nO3tERpBpyN7P6IAmBeIVTleNLozYjzryJEgbY6wkGVnu
	 bhbZWPAcfENsc4H0zoMqxN1Ktc8kC2lT16VRIHqTpx00MMjAdk0wbQ7bPXf4j6PFds
	 Ew/CfVxYz/+uR/Zo2dRmAavx2GhMUmSl8EINYObR4fmRnSBRzNLyqgLV++kbuzlbf5
	 u1PgHizmxUk1MOtKdDkD8+/L6tuVAlsxX7K0YlyuOCqGFRng7Pc6lUk/F2J3Q2y7tN
	 YaACKAlSg3OkA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EE8CA0FE8;
	Thu, 21 Aug 2025 15:40:03 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Thu, 21 Aug 2025 15:39:08 +0000
Subject: [PATCH RFC 16/22] usb: typec: tipd: Use read_power_status function
 in probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-atcphy-6-17-v1-16-172beda182b8@kernel.org>
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
 Sven Peter <sven@kernel.org>, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1231; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=y56aSt+8+GGBv7M4CTBesZmBIVzkBqBitGUe5JAi5T0=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8Zy2237661DTmzwOHm3mbPDcmX2qgs3eK6999ObE5S38
 /LNpg8xHaUsDGIcDLJiiizb99ubPnn4RnDppkvvYeawMoEMYeDiFICJOGQyMlyaPP+BF4fSZaXg
 QtsbrLFT1izcynz27/T9fp5b1A49TbFi+MMz6W6tkv3fle2n4u5t9l4jtl71vu/lBo8+Ye2uw+x
 +s9kA
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

From: Hector Martin <marcan@marcan.st>

We need the initial power status to be able to reliably detect connector
changes once we introduce de-bouncing for CD321x next. read_power_status
takes care of this and also forwards the status to the trace subsystem
so let's use that instead of open-coding it inside probe.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Sven Peter <sven@kernel.org>
---
 drivers/usb/typec/tipd/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index b0fdd4dddd3a490dbc2a8ced21ea0803658f36a7..2b7c5017a347d153b50383b34123a2ecc424eb68 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -1552,11 +1552,8 @@ static int tps6598x_probe(struct i2c_client *client)
 		goto err_role_put;
 
 	if (status & TPS_STATUS_PLUG_PRESENT) {
-		ret = tps6598x_read16(tps, TPS_REG_POWER_STATUS, &tps->pwr_status);
-		if (ret < 0) {
-			dev_err(tps->dev, "failed to read power status: %d\n", ret);
+		if (!tps6598x_read_power_status(tps))
 			goto err_unregister_port;
-		}
 		ret = tps6598x_connect(tps, status);
 		if (ret)
 			dev_err(&client->dev, "failed to register partner\n");

-- 
2.34.1



