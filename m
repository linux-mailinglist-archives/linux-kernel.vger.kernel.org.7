Return-Path: <linux-kernel+bounces-722225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B23AFD6A2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2B381BC7177
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7133A221F13;
	Tue,  8 Jul 2025 18:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjcL8iLk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B066121A928;
	Tue,  8 Jul 2025 18:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752000383; cv=none; b=aFsbsVAaAoiF7zQwRFeT4/dJCnq/o2+4tM7c6gLbwmWqp0LySZ6t9VIDgdsH8d4LyteV3E9+E5hBAMJQ/YkrXKhMWx1nSyuBx3/VwQHLXViW2C7uoyhkcica/vRmyOduai1j/9wV9n66sT6f13Gt6V+6Z1jg7JBFdeI74iQceLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752000383; c=relaxed/simple;
	bh=/+CPrjLMQh0s5cyqHNAolf1U7ifkt8a0HKjp92l+1Mw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QrifqNCdQVEmpIY6czjpcfCf5jr3uDU3NP0VOm/j+jBLW+lGo2Y7UKNcRJ3Z8SVF7XoJS5oSwzo8fcFJY49pSTSYkHMp7/iMi7o2lGNRFQZ8QxMJYCSQ3zIX28iY6EJkmjd2Wq/MC8bEWMIZJlbps9GaHGbY9RB6zVGrS3FQuHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjcL8iLk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72750C4CEED;
	Tue,  8 Jul 2025 18:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752000383;
	bh=/+CPrjLMQh0s5cyqHNAolf1U7ifkt8a0HKjp92l+1Mw=;
	h=From:To:Cc:Subject:Date:From;
	b=RjcL8iLkgtX//+3PhFZhrK5e1wQf2aHsOoBrC7oX2dVVmU0XxlHKEHaAaqR89eH2A
	 PxNf2s5EeR/VeSzZXh/Axs1+V2Rj/YAKgzBfGUWW/A2frFJwY+PmNf+ZSWzga6GFnS
	 lGj/21pnk5Xv4NzoOgLewE8SYs2LllvHpy3fp1p19XJGRTsrtqPh7ihPCps2bvCK8S
	 oBDD4+uWBVGU8IgQdT4KaE5rirXbd5ReR0pZ23XxJyjQoEzgsdH5p37DbXltHz+Scv
	 3+grrbwd00BGMrhJCnA18yrt7bTHBzR3b889fOwQZIXZWBye82SY9eZtv51uHQ2SzH
	 YGij8uXHJ0hRA==
From: Arnd Bergmann <arnd@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>,
	Maciej Strozek <mstrozek@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shuming Fan <shumingf@realtek.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: SDCA: fix HID dependency
Date: Tue,  8 Jul 2025 20:46:06 +0200
Message-Id: <20250708184618.3585473-1-arnd@kernel.org>
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
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/sdca/Kconfig  | 3 ++-
 sound/soc/sdca/Makefile | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sdca/Kconfig b/sound/soc/sdca/Kconfig
index 53f6926255ae..36c2fed54dad 100644
--- a/sound/soc/sdca/Kconfig
+++ b/sound/soc/sdca/Kconfig
@@ -12,8 +12,9 @@ config SND_SOC_SDCA_OPTIONAL
 	def_tristate SND_SOC_SDCA || !SND_SOC_SDCA
 
 config SND_SOC_SDCA_HID
-	tristate "SDCA HID support"
+	bool "SDCA HID support"
 	depends on SND_SOC_SDCA && HID
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


