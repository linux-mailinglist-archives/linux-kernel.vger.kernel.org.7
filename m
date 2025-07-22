Return-Path: <linux-kernel+bounces-740491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 248D1B0D4DC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1353616E106
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF842D8784;
	Tue, 22 Jul 2025 08:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DOeDTaxw"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052492C1581;
	Tue, 22 Jul 2025 08:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753173843; cv=none; b=XZuLrLVAqiHoLcMjFcZIJsYHPPiKVKX/lpTqQyKTIFmRWtCTH0gfqO1JTcmwMHLA38+2I5Flx0pQ54DBC6B0NjJm7eMkFFkc61H9f7APBVQdH2WMDyAMMbm+wxhfQrd+QlioULL70tLIrczy0UpRijUq++kM0doWR+6+ql30+4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753173843; c=relaxed/simple;
	bh=OZKDViYK6aLsCsmNlMIa2y+lso/6tU5vrZKSKwL6Ocw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pFMW6YE7+2cD06N4DOiUH6bUNlAf2DTBTx9MeBSI741YuhhRxCwI3Nt4VVeuKmkEZRNYpci3EURUAvG00GFY6YCv5w5Hdx5RInwxloLWFiv+yKI15LHwdA7MU9tgrq4V1yiRKV5pEZZc+z6CpebTsH+7ZjM0tZEiuQqykUlIZIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DOeDTaxw; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B0ACA431F6;
	Tue, 22 Jul 2025 08:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753173833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+cxsUj0Y5gyKrSSgcqbSIsRn5/3YWg5fh9lkz0I+ON0=;
	b=DOeDTaxwDRa5w94xOL7msLEtOmiCPzSv27A298ZuvkvgcBl2j+vjF7X+/ELjEq/K4kPFCF
	IUxaNrjszfyaNyrbwmFWFkUDqPrVfmZFx/9j40aj8yq/7RX0aGBZOI40pv5LYd7+r+iADT
	iyZ95gu90RA9DmxJmzSX3bcgLREFM5n4Zw/xhYUVOm/q8UVIktyWMuWXPc6b3n7NqalYpc
	ktwQvV8Qxvq4Pk7lZ2HZYyiKXPlzHd82SFHibRC47/AMJlo8pBVHfvnycq3zD9m1GbaPvh
	uhaLbi8NZVUy0s6aLI28Qv+7caMfYQxDYXE5fc+524ul/ZJXQtKunLbKKG3FKQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 0/2] phy: rockchip: inno-usb2: fix gadget mode
 disconnection after 6 seconds
Date: Tue, 22 Jul 2025 10:43:42 +0200
Message-Id: <20250722-rk3308-fix-usb-gadget-phy-disconnect-v1-0-239872f05f17@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD5Pf2gC/x2NQQqDMBAAvyJ77kISWxL6ldKDya5xKUTJaqmIf
 zf0OIeZOUC5Cis8uwMqf0VlLg3srYM0DSUzCjUGZ9zDeBuwfvreBBzlh5tGzANlXnGZdiTRNJf
 CaUXyxN6O0YV4h5ZaKjfhv3m9z/MC6Z5r7XYAAAA=
X-Change-ID: 20250718-rk3308-fix-usb-gadget-phy-disconnect-d7de71fb28b4
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejgeeggecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfeiteekkefgtdduveeuffeuffevkeehieduhfefvdfhueekuefhhfdttddvkeefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghloheplgduledvrdduieekrddujeekrdejhegnpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudeipdhrtghpthhtohepvhhkohhulheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvvhgvrhdrhigrnhhgsehrohgtkhdqtghhihhpshdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiio
 hhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopefoihhnrghsrdfjrghruhhthihunhihrghnsehshihnohhpshihshdrtghomhdprhgtphhtthhopehhvghikhhosehsnhhtvggthhdruggvpdhrtghpthhtohepfihulhhfsehrohgtkhdqtghhihhpshdrtghomhdprhgtphhtthhopehkihhshhhonheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: luca.ceresoli@bootlin.com

The USB OTG port of the RK3308 exibits a bug when:

 - configured as peripheral, and
 - used in gadget mode, and
 - the USB cable is connected since before booting

The symptom is: about 6 seconds after configuring gadget mode the device is
disconnected and then re-enumerated. This happens only once per boot.

Investigation showed that in this configuration the charger detection code
turns off the PHY after 6 seconds. Patch 1 avoids this when a cable is
connected (VBUS present).

After patch 1 the connection is stable but communication stops after 6
seconds. this is addressed by patch 2.

The topic had been discussed in [0]. Thanks Alan and Minas for the
discussion and Louis for having found the 1st issue, leading to patch 1.

[0] https://lore.kernel.org/lkml/20250414185458.7767aabc@booty/

Luca

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Louis Chauvet (1):
      phy: rockchip: inno-usb2: fix disconnection in gadget mode

Luca Ceresoli (1):
      phy: rockchip: inno-usb2: fix communication disruption in gadget mode

 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)
---
base-commit: 15240745d6cd14183d112249a9fff87fb968b859
change-id: 20250718-rk3308-fix-usb-gadget-phy-disconnect-d7de71fb28b4

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


