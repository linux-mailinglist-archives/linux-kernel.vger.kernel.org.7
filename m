Return-Path: <linux-kernel+bounces-779534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C3FB2F559
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4243B4A9B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC402FB97B;
	Thu, 21 Aug 2025 10:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b="AxvdEdXq"
Received: from smtpout2.mo534.mail-out.ovh.net (smtpout2.mo534.mail-out.ovh.net [51.210.94.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C5F2FABEC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.210.94.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755772069; cv=none; b=Z1RYkz7FTABeLHu741/3UcSmV3hez8rU40EEfcLfuq4e/qscK9Wig4I0GsK27o7PlrHT0Dko6yx1diTnDi+OlTLS/2P5infawsSTyfKqPC8ZxlUYP9iRC9k0qvI7guuN9YFlvHDg9GdhanF37H/hx4shFxV2sY71buCWRhIxhH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755772069; c=relaxed/simple;
	bh=eref6ByY572qjZCGOScxzbw7tucOi1s0NHnKAHD1+cQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GQPWx8Ju2ZnB2ySZZ4a5mdVryTFijBodPTcHn4Egjaka+KR4sI6YtN2jv79zrtVw2t5bOTrCE2yX7MxGYYlYCXOZrjj4jlbzP4ydur7BGjk/kY80pvFkB4SRpxv6+o1KUdhJhR/fgVp1vi82zVW0cb/GP1nTv0NIexM4o16jzp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b=AxvdEdXq; arc=none smtp.client-ip=51.210.94.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net [152.228.215.222])
	by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4c6zns5kwmz68YG;
	Thu, 21 Aug 2025 10:19:29 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net. [127.0.0.1])
        by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <brgl@bgdev.pl>; Thu, 21 Aug 2025 10:19:29 +0000 (UTC)
Received: from mta7.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.109.249.147])
	by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4c6zns4FxHz5wDg;
	Thu, 21 Aug 2025 10:19:29 +0000 (UTC)
Received: from orca.pet (unknown [10.1.6.9])
	by mta7.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 353BDB832CD;
	Thu, 21 Aug 2025 10:19:28 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-97G002d21e2e92-e478-449c-be15-b81d5d0ce33e,
                    684E78C7C579463DAB27E2CA1F9C4E28A39E1181) smtp.auth=marcos@orca.pet
X-OVh-ClientIp:147.156.42.5
From: Marcos Del Sol Vives <marcos@orca.pet>
To: linux-kernel@vger.kernel.org
Cc: Marcos Del Sol Vives <marcos@orca.pet>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Michael Walle <mwalle@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-gpio@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 0/3] Introduce support for Vortex GPIO pins
Date: Thu, 21 Aug 2025 12:18:56 +0200
Message-Id: <20250821101902.626329-1-marcos@orca.pet>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17487758829186930278
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepofgrrhgtohhsucffvghlucfuohhlucggihhvvghsuceomhgrrhgtohhssehorhgtrgdrphgvtheqnecuggftrfgrthhtvghrnhepgffhgfefvefghfetveevgffhleffjedvjeekieejgeeiuddvffetieejjeejgfegnecukfhppeduvdejrddtrddtrddupddugeejrdduheeirdegvddrheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepmhgrrhgtohhssehorhgtrgdrphgvthdpnhgspghrtghpthhtohepledprhgtphhtthhopegsrhhglhessghguggvvhdrphhlpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmfigrlhhlvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtohepmhgrrhgtohhssehorhgtrgdrphgvthdprhgtphhtthhopehlihhnuhigqdhgphhiohesvhhgvghrrdhkvghrnhgvlhdrohhrgh
 dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhg
DKIM-Signature: a=rsa-sha256; bh=+QxckdVwic+8yzAxhOHqkLVteyChvAdbEUUs0+d9kek=;
 c=relaxed/relaxed; d=orca.pet; h=From; s=ovhmo-selector-1; t=1755771569;
 v=1;
 b=AxvdEdXqMVwLtMJhi6jOy7ehSdcR3/yQ7W7ccatuoMg4CF34HeBuJV79X0cgHWsYFTndlQpR
 haXSzYTpUjqLuzKbVVW44tfNiKa+ti80Bz0LLTcc/U/e/Byq4gAznVxRfGs1siYgTtkcGPcbB9Z
 kwy1N1UKsYaA36rg6nU7g86MkdTmIxpjTFwqZrCMH1ReMka3GgrRbz4djKu9E4meY8H3348RuzN
 KjdWPHQ7FdkRDrrktyj3xB3NKraZMKrD0/ydoqzRdmZzUhEQ5PFrme7fSWhdm8L8JeOgXq6EbgP
 iCHToPl+w/3hJTM7IOdGIGW2L/yTaR/MPcn5F2wcC5TCw==

This series of patches add support for the GPIO pins exposed on the
southbridge of DM&P's Vortex86 line of SoCs, using a new GPIO driver
plus a MFD driver to automatically load the driver in supported platforms.

Marcos Del Sol Vives (3):
  gpio: gpio-regmap: add flags to control some behaviour
  gpio: vortex: add new GPIO device driver
  mfd: vortex: implement new driver for Vortex southbridges

 MAINTAINERS                 |   6 ++
 drivers/gpio/Kconfig        |  11 ++++
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/gpio-regmap.c  |  17 +++++-
 drivers/gpio/gpio-vortex.c  | 110 ++++++++++++++++++++++++++++++++++++
 drivers/mfd/Kconfig         |   9 +++
 drivers/mfd/Makefile        |   1 +
 drivers/mfd/vortex-sb.c     |  81 ++++++++++++++++++++++++++
 include/linux/gpio/regmap.h |  17 ++++++
 include/linux/pci_ids.h     |   1 +
 10 files changed, 253 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpio/gpio-vortex.c
 create mode 100644 drivers/mfd/vortex-sb.c

-- 
2.34.1


