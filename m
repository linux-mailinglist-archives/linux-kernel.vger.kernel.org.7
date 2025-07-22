Return-Path: <linux-kernel+bounces-740493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE34B0D4E0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DFD06C61E5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EB42DAFBB;
	Tue, 22 Jul 2025 08:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NUPWCHsY"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948B72D660B;
	Tue, 22 Jul 2025 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753173846; cv=none; b=CJPLiDYHLCJ3ym6ATwktry1Ooqdv5ewLnjPc6lwCDO1tdjdZIHc554PZx9QHaZTKrAsjohv+sDr1/CyyPQlFYy6YLFvCtGauYT12G2zZFrYjojbXY/SAJkdn7CEZx/rpiLLs+9NBvi/P227WCy3zMug5Tc0EGACQ8HtC6D22zyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753173846; c=relaxed/simple;
	bh=w5pYDTDQsrlRxYtD/ZNpB9PKZQJrZAewxg8a183cb78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sJiDbGvjKeTTqTmsAeY7CSKpyfVwSPbWyTRlZWs2a8bu5+xiuZldOncYW/cbwcni7PE8GT5wL3VwRlGW8OzQekS2131p0QjLZbDVO5c9jmRUWlk6r0w9A/WRbQ1KiUNHUTmSwLNCV7DNXnOjIx0u1nloMJQV1gekzsll9TpTGL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NUPWCHsY; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0CAD2431FC;
	Tue, 22 Jul 2025 08:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753173836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lL0vBxv9N/cBdRGCto9TruzZjRh7DSP5woNWAvZPKD8=;
	b=NUPWCHsYkURdekhDUMdZwqGKFREk6+4V2tal/89Cg+5EABkccB+EcustxKaIbxe6RRaK3T
	81LsIvBcwO9uoSd+jS+5AwhkqkFrKVLYPnOVujqGc9w4Afl5EABBq2b3alD5dJvWTB2DA9
	z/d9lL0TydRL+SVxzqF+RhkAmXqds4bJZXcYJ7FyrFCPDMOnUhkPAkLaf3KNH6RyRdGzH2
	adVV/liPPzNq7ubSIZPsETYA6ScqpqS/+7DYLlBCNu5lpHHv/GD15tcnZ+RsxeGY2AMcZf
	t9xI66f+YJ1n6/jd5p0Uf0ktCzTfBiIzn5yqqN8pgwD+8qOTBKthwb37A9E9xA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 22 Jul 2025 10:43:44 +0200
Subject: [PATCH 2/2] phy: rockchip: inno-usb2: fix communication disruption
 in gadget mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-rk3308-fix-usb-gadget-phy-disconnect-v1-2-239872f05f17@bootlin.com>
References: <20250722-rk3308-fix-usb-gadget-phy-disconnect-v1-0-239872f05f17@bootlin.com>
In-Reply-To: <20250722-rk3308-fix-usb-gadget-phy-disconnect-v1-0-239872f05f17@bootlin.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, William Wu <wulf@rock-chips.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, 
 Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>, 
 Alan Stern <stern@rowland.harvard.edu>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejgeeggecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepheejgfdugedvudekgeevtdfgudduhedtgfetfeevgfehkeejhedviefhtdffhfeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghloheplgduledvrdduieekrddujeekrdejhegnpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudeipdhrtghpthhtohepvhhkohhulheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvvhgvrhdrhigrnhhgsehrohgtkhdqtghhihhpshdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgri
 iiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopefoihhnrghsrdfjrghruhhthihunhihrghnsehshihnohhpshihshdrtghomhdprhgtphhtthhopehhvghikhhosehsnhhtvggthhdruggvpdhrtghpthhtohepfihulhhfsehrohgtkhdqtghhihhpshdrtghomhdprhgtphhtthhopehkihhshhhonheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: luca.ceresoli@bootlin.com

When the OTG USB port is used to power to SoC, configured as peripheral and
used in gadget mode, communication stops without notice about 6 seconds
after the gadget is configured and enumerated.

The problem was observed on a Radxa Rock Pi S board, which can only be
powered by the only USB-C connector. That connector is the only one usable
in gadget mode. This implies the USB cable is connected from before boot
and never disconnects while the kernel runs.

The related code flow in the PHY driver code can be summarized as:

 * UDC start code (triggered via configfs at any time after boot)
   -> phy_init
       -> rockchip_usb2phy_init
           -> schedule_delayed_work(otg_sm_work [A], 6 sec)
   -> phy_power_on
       -> rockchip_usb2phy_power_on
           -> enable clock
           -> rockchip_usb2phy_reset

 * Now the gadget interface is up and running.

 * 6 seconds later otg_sm_work starts [A]
   -> rockchip_usb2phy_otg_sm_work():
       if (B_IDLE state && VBUS present && ...):
           schedule_delayed_work(&rport->chg_work [B], 0);

 * immediately the chg_detect_work starts [B]
   -> rockchip_chg_detect_work():
       if chg_state is UNDEFINED:
            property_enable(base, &rphy->phy_cfg->chg_det.opmode, false); [Y]

 * rockchip_chg_detect_work() changes state and re-triggers itself a few
   times until it reached the DETECTED state:
   -> rockchip_chg_detect_work():
       if chg_state is DETECTED:
            property_enable(base, &rphy->phy_cfg->chg_det.opmode, true); [Z]

At [Y] there is no disconnection and the USB device appears still present
to userspace, but all existing communications stop. E.g. using a CDC serial
gadget, the /dev/tty* devices are still present on both host and device,
but no data is transferred anymore. The later call with a 'true' argument
at [Z] does not restore it.

Due to the lack of documentation, what chg_det.opmode does exactly is not
clear, however by code inspection it seems reasonable that is disables
something needed to keep the communication working, and testing proves that
disabling these lines lefs gadget mode keep working. So prevent changes to
chg_det.opmode when there is a cable connected (VBUS present).

Fixes: 98898f3bc83c ("phy: rockchip-inno-usb2: support otg-port for rk3399")
Closes: https://lore.kernel.org/lkml/20250414185458.7767aabc@booty/
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 0106d7b7ae24ead91d9c996daaa56671de02a39a..e5efae7b013590f5b0bf65654008cdc167f52e3f 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -833,7 +833,8 @@ static void rockchip_chg_detect_work(struct work_struct *work)
 		if (!rport->suspended && !vbus_attach)
 			rockchip_usb2phy_power_off(rport->phy);
 		/* put the controller in non-driving mode */
-		property_enable(base, &rphy->phy_cfg->chg_det.opmode, false);
+		if (!vbus_attach)
+			property_enable(base, &rphy->phy_cfg->chg_det.opmode, false);
 		/* Start DCD processing stage 1 */
 		rockchip_chg_enable_dcd(rphy, true);
 		rphy->chg_state = USB_CHG_STATE_WAIT_FOR_DCD;
@@ -896,7 +897,8 @@ static void rockchip_chg_detect_work(struct work_struct *work)
 		fallthrough;
 	case USB_CHG_STATE_DETECTED:
 		/* put the controller in normal mode */
-		property_enable(base, &rphy->phy_cfg->chg_det.opmode, true);
+		if (!vbus_attach)
+			property_enable(base, &rphy->phy_cfg->chg_det.opmode, true);
 		rockchip_usb2phy_otg_sm_work(&rport->otg_sm_work.work);
 		dev_dbg(&rport->phy->dev, "charger = %s\n",
 			 chg_to_string(rphy->chg_type));

-- 
2.50.1


