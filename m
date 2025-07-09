Return-Path: <linux-kernel+bounces-723952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B82AFECF4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AFB45A3CBD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2227F2E610F;
	Wed,  9 Jul 2025 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6wdJKNC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3292E5B3E;
	Wed,  9 Jul 2025 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072994; cv=none; b=qNzVfTjmGLYsZpo3tJdrCWJg2KZ/Tnu1/FtAlTVcbOagSzPeWWi5K1s755L6PRuBoTw3MTeEvJZCA8TJn/24kZSSddyG1N0VK20O+id7cTz38lryxHn5Fue5qetLxTv8RtmlVlWjCvMh1iRFk7l1WzZgoawTaBHN9eEK9zvQEpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072994; c=relaxed/simple;
	bh=yNzG22T7Kt3gRzgf5HUAN78MIWBlmd8cxkO76zyRr8k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dLN/IJMwJccKPIxgVVuqzCYz1mPXmsVGFQchVXvuQliJQFXx6NjuNn8nxcZKpm0JBTJs9pu92EpAjWSH/UKSJdvwgiTrmP7w255nA37L6/FwYBCrnvvdX6JNsiGsWWbzkhy6Sy6hd3NcSxcDiwG2+zLSIsgtqrH0U1e8Dsg3xkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6wdJKNC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3DAC4CEEF;
	Wed,  9 Jul 2025 14:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752072993;
	bh=yNzG22T7Kt3gRzgf5HUAN78MIWBlmd8cxkO76zyRr8k=;
	h=From:To:Cc:Subject:Date:From;
	b=S6wdJKNCMKbnfOx+0Lk74iJixCb9zxotU9KjCEufyNdGO82huIWlKT/3U4Jh8GqE3
	 QjswoZh6a+BhcyXEIO5ENfBaApkSL9SdwmX1r20+d9qXStt+xmV5aqaSGTjtY0tPBx
	 VzbnM7kKpOjpM+W0U9GYTlqERd8dCeO9M1wZTbJTt4SdenC2orbf4S+K8FVYE1wpb/
	 Uz85jvMJfHSqMTaLrc8o/cqPLGOuIHd4jFntyF1EBCS3pvFeoQ3Yx8KZJZXTt6qArm
	 4BrnadE2LIfc3Awic83eu2X1fxlBSqt3hCe5TX+YQMg4MEELEDD7zUgOwU34PUb95y
	 3TgUfxSIeSD4Q==
From: Arnd Bergmann <arnd@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Brent Lu <brent.lu@intel.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Jack Yu <jack.yu@realtek.com>,
	Helen Koike <koike@igalia.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: Intel: fix SND_SOC_SOF dependencies
Date: Wed,  9 Jul 2025 16:56:07 +0200
Message-Id: <20250709145626.64125-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

It is currently possible to configure a kernel with all Intel SoC
configs as loadable modules, but the board config as built-in. This
causes a link failure in the reference to the snd_soc_sof.ko module:

x86_64-linux-ld: sound/soc/intel/boards/sof_rt5682.o: in function `sof_rt5682_hw_params':
sof_rt5682.c:(.text+0x1f9): undefined reference to `sof_dai_get_mclk'
x86_64-linux-ld: sof_rt5682.c:(.text+0x234): undefined reference to `sof_dai_get_bclk'
x86_64-linux-ld: sound/soc/intel/boards/sof_rt5682.o: in function `sof_rt5682_codec_init':
sof_rt5682.c:(.text+0x3e0): undefined reference to `sof_dai_get_mclk'
x86_64-linux-ld: sound/soc/intel/boards/sof_cs42l42.o: in function `sof_cs42l42_hw_params':
sof_cs42l42.c:(.text+0x2a): undefined reference to `sof_dai_get_bclk'
x86_64-linux-ld: sound/soc/intel/boards/sof_nau8825.o: in function `sof_nau8825_hw_params':
sof_nau8825.c:(.text+0x7f): undefined reference to `sof_dai_get_bclk'
x86_64-linux-ld: sound/soc/intel/boards/sof_da7219.o: in function `da7219_codec_init':
sof_da7219.c:(.text+0xbf): undefined reference to `sof_dai_get_mclk'
x86_64-linux-ld: sound/soc/intel/boards/sof_maxim_common.o: in function `max_98373_hw_params':
sof_maxim_common.c:(.text+0x6f9): undefined reference to `sof_dai_get_tdm_slots'
x86_64-linux-ld: sound/soc/intel/boards/sof_realtek_common.o: in function `rt1015_hw_params':
sof_realtek_common.c:(.text+0x54c): undefined reference to `sof_dai_get_bclk'
x86_64-linux-ld: sound/soc/intel/boards/sof_realtek_common.o: in function `rt1308_hw_params':
sof_realtek_common.c:(.text+0x702): undefined reference to `sof_dai_get_mclk'
x86_64-linux-ld: sound/soc/intel/boards/sof_cirrus_common.o: in function `cs35l41_hw_params':
sof_cirrus_common.c:(.text+0x2f): undefined reference to `sof_dai_get_bclk'

Add an optional dependency on SND_SOC_SOF_INTEL_COMMON, to ensure that whenever
the SOF support is in a loadable module, none of the board code can be built-in.

This may be be a little heavy-handed, but I also don't see a reason why one would
want the boards to be built-in but not the SoC, so it shouldn't actually cause
any usability problems.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/intel/boards/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 128b6876af83..c23fdb6aad4c 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -11,7 +11,7 @@ menuconfig SND_SOC_INTEL_MACH
 	 kernel: saying N will just cause the configurator to skip all
 	 the questions about Intel ASoC machine drivers.
 
-if SND_SOC_INTEL_MACH
+if SND_SOC_INTEL_MACH && (SND_SOC_SOF_INTEL_COMMON || !SND_SOC_SOF_INTEL_COMMON)
 
 config SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES
 	bool "Use more user friendly long card names"
-- 
2.39.5


