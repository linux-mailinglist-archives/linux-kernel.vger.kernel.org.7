Return-Path: <linux-kernel+bounces-724020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA93AFEDA4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B98443BC2D9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A493E2E6D3D;
	Wed,  9 Jul 2025 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxmToEa3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5A81E521A;
	Wed,  9 Jul 2025 15:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074677; cv=none; b=Va6YSmilEIyyucr3Q5PbFMerH8Vqfs4JzhwD18ox0bZ2d7eQL/wed0ZC3aFPlvONney1giJa+D823VHh0Ec9ZA1Hr68Z0xs6pWVffXqTxhY1TMROCHla+h41Xw4prMZnBa4ozC4BB5GHGyHWnkDl1HJ3YVnqQBtoieSGM+qKhxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074677; c=relaxed/simple;
	bh=wMH1EIntjFee94D4nTY6RgYze7w69rlY7R0wWT9VB90=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RU8eyjVlFes6Zj4FE8gAJ+Ot2uRdbm0mlnbwaZLEB1jaEWEL/9EtQqc9vuXFg4/jkp6CLMtfLGJ5r48n7gDUeEMikSKMC8f80zydklE6F1RoTcvy4cCZ3SSP/tMxFhWTHjWCWOMzQKrlswiBFy25bNzRA24oXa9Y8VrD6o9opX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxmToEa3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE55C4CEEF;
	Wed,  9 Jul 2025 15:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752074675;
	bh=wMH1EIntjFee94D4nTY6RgYze7w69rlY7R0wWT9VB90=;
	h=From:To:Cc:Subject:Date:From;
	b=FxmToEa34iJWO2EVV6XuPVUybg+S5mXY54jM856l1ta6PyGdh5rgXbEH0/O0Ukyek
	 X3YHtIYZe0psWVHSeerNFd3fedXcuwkSM9IxYylgpVLLHT4hLbQixW1x1+DrTI7Cvj
	 /1O0lfNGZ1Z2NhuEbyj37MvWc9UCGPhVE/BRoXlganJkS58gbqDACNmQq5z+NyMnwA
	 gHOB0ju6NmaOpcvyA2osPC6WDuzpO+xkHnu0YDApAWa8nFi/ui7cwTPcfSZJTnROJI
	 /edqoWV/Q0Rq1YVcwRMqejYekMh/I/uVNi1B+OnejkY/bgylBY2TE4hIAiwnBtoyb6
	 yl19DlcAzYxYA==
From: Arnd Bergmann <arnd@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>,
	Maciej Strozek <mstrozek@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Shuming Fan <shumingf@realtek.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] ASoC: SDCA: fix HID dependency
Date: Wed,  9 Jul 2025 17:24:17 +0200
Message-Id: <20250709152430.1498427-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

It is not possible to enable SND_SOC_SDCA_HID when SND_SOC_SDCA is built-in
but HID is in a loadable module, as that results in a link failure:

x86_64-linux-ld: sound/soc/sdca/sdca_functions.o: in function `find_sdca_entity_hide':
sdca_functions.c:(.text+0x25b): undefined reference to `sdca_add_hid_device'

Change SND_SOC_SDCA_HID into a 'bool' option that can only be enabled
if this results in a working build, and change the Makefile so this driver
is a loadable module if possible.

Fixes: ac558015dfd8 ("ASoC: SDCA: add a HID device for HIDE entity")
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: small simplification suggested by Charles
---
 sound/soc/sdca/Kconfig  | 5 +++--
 sound/soc/sdca/Makefile | 4 +++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sdca/Kconfig b/sound/soc/sdca/Kconfig
index 53f6926255ae..2253a300dcc3 100644
--- a/sound/soc/sdca/Kconfig
+++ b/sound/soc/sdca/Kconfig
@@ -12,8 +12,9 @@ config SND_SOC_SDCA_OPTIONAL
 	def_tristate SND_SOC_SDCA || !SND_SOC_SDCA
 
 config SND_SOC_SDCA_HID
-	tristate "SDCA HID support"
-	depends on SND_SOC_SDCA && HID
+	bool "SDCA HID support"
+	depends on SND_SOC_SDCA
+	depends on HID=y || HID=SND_SOC_SDCA
 
 config SND_SOC_SDCA_IRQ
 	tristate
diff --git a/sound/soc/sdca/Makefile b/sound/soc/sdca/Makefile
index 2a3938d11ca9..1efc869c6cbc 100644
--- a/sound/soc/sdca/Makefile
+++ b/sound/soc/sdca/Makefile
@@ -5,5 +5,7 @@ snd-soc-sdca-hid-y := sdca_hid.o
 snd-soc-sdca-irq-y := sdca_interrupts.o
 
 obj-$(CONFIG_SND_SOC_SDCA)	+= snd-soc-sdca.o
-obj-$(CONFIG_SND_SOC_SDCA_HID)	+= snd-soc-sdca-hid.o
+ifdef CONFIG_SND_SOC_SDCA_HID
+obj-$(CONFIG_SND_SOC_SDCA)	+= snd-soc-sdca-hid.o
+endif
 obj-$(CONFIG_SND_SOC_SDCA_IRQ)	+= snd-soc-sdca-irq.o
-- 
2.39.5


