Return-Path: <linux-kernel+bounces-756700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 422E2B1B7E9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4283F4E2980
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D6A27874A;
	Tue,  5 Aug 2025 16:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcqeZjdK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C70291C0C;
	Tue,  5 Aug 2025 16:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754409897; cv=none; b=OU/D6zjxMu0hyknxpGPoOo5afYlaWpBrYnYW7Hb5V4ZNgO9iT3oILSe57koucFNoCVSlPOCOTIC7QdSbHH08t8IeTAds3nUe8N9PJyoXey6N2aLkyUdSyRSHGPQssd9lYlpdBZh0+PdvRw3w5pa0u5z6PqNYuw/1gUsZBNqao20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754409897; c=relaxed/simple;
	bh=b3TbRMOZkj60Xb55rqh/NSOwa/A1AQIbjAYgyH1pTw4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nr5Bsga9y60KNpuwery+SIzn8xPxcoM4fdYXVqY6JqM58+b23OKTTOq2ZcuDFGnqq9Zv63ue1TpiMdtWSFFpYUUKNcHzlqHehmrpRiqfJta1VzETA+2W+F3KN8f/u02w5Otp0eKqdQ1MfAln0g/STpDxaEV2JcgegoTfqtzltng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcqeZjdK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA03C4CEF0;
	Tue,  5 Aug 2025 16:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754409897;
	bh=b3TbRMOZkj60Xb55rqh/NSOwa/A1AQIbjAYgyH1pTw4=;
	h=From:To:Cc:Subject:Date:From;
	b=XcqeZjdKb6T/qnppDyyPFTF4PPr3XwFfCH4663tfxFJUPjbapXJhaZ9qP3qZgtY74
	 F58o1q0tE5kRb9pf0aOUQfYV6A8GSMRglN01dGeP96I2tKm+qVVbQ2thfGc24fOard
	 5IlZtL4oda2iC5KOsl2c0AL622jon2+82ORHHvgEnvvnIf+pum7XYytU/S7icOWHCG
	 WlBs4/s1BQKcilh05rCf6vkyrB/mrdk+bglLEwQMEEvR47T2DRaHU3WzWYJaUzE0n/
	 mDXk/9tlIkOztsrP2W10vPAmSUp5xzL+cEk9kwiaPUm4f+1vQO9TL5iKO95/keo5U+
	 oRCrKLfHrzW4A==
From: Arnd Bergmann <arnd@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Vinod Koul <vkoul@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: SOF: Intel: hda-sdw-bpt: fix SND_SOF_SOF_HDA_SDW_BPT dependencies
Date: Tue,  5 Aug 2025 18:04:25 +0200
Message-Id: <20250805160451.4004602-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The hda-sdw-bpt code links against the soundwire driver, but that fails when
trying to link from built-in code into loadable module:

x86_64-linux-ld: vmlinux.o: in function `intel_ace2x_bpt_close_stream.isra.0':
intel_ace2x.c:(.text+0x137a531): undefined reference to `hda_sdw_bpt_close'
x86_64-linux-ld: vmlinux.o: in function `intel_ace2x_bpt_send_async':
intel_ace2x.c:(.text+0x137aa45): undefined reference to `hda_sdw_bpt_open'
x86_64-linux-ld: intel_ace2x.c:(.text+0x137ab67): undefined reference to `hda_sdw_bpt_close'
x86_64-linux-ld: intel_ace2x.c:(.text+0x137ac30): undefined reference to `hda_sdw_bpt_send_async'
x86_64-linux-ld: vmlinux.o: in function `intel_ace2x_bpt_wait':
intel_ace2x.c:(.text+0x137aced): undefined reference to `hda_sdw_bpt_wait'

Ensure that both SOUNDWIRE_INTEL and SND_SOF_SOF_HDA_SDW_BPT are selected
at the same time by SND_SOC_SOF_INTEL_LNL, and that this happens even if
SND_SOC_SOF_INTEL_SOUNDWIRE is a loadable module but SND_SOC_SOF_INTEL_LNL
is built-in.

This follows the same logic as commit c5a61db9bf89 ("ASoC: SOF: fix
intel-soundwire link failure").

Fixes: 5d5cb86fb46e ("ASoC: SOF: Intel: hda-sdw-bpt: add helpers for SoundWire BPT DMA")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/sof/intel/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
index 7e92aa2f7e39..9722ae43e87c 100644
--- a/sound/soc/sof/intel/Kconfig
+++ b/sound/soc/sof/intel/Kconfig
@@ -272,9 +272,10 @@ config SND_SOC_SOF_METEORLAKE
 
 config SND_SOC_SOF_INTEL_LNL
 	tristate
+	select SOUNDWIRE_INTEL if SND_SOC_SOF_INTEL_SOUNDWIRE != n
 	select SND_SOC_SOF_HDA_GENERIC
 	select SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE
-	select SND_SOF_SOF_HDA_SDW_BPT if SND_SOC_SOF_INTEL_SOUNDWIRE
+	select SND_SOF_SOF_HDA_SDW_BPT if SND_SOC_SOF_INTEL_SOUNDWIRE != n
 	select SND_SOC_SOF_IPC4
 	select SND_SOC_SOF_INTEL_MTL
 
-- 
2.39.5


