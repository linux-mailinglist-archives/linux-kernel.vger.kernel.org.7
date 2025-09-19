Return-Path: <linux-kernel+bounces-824222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D443B886D7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B28B13BE885
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE1B2E62D8;
	Fri, 19 Sep 2025 08:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ih/L3o7v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fApwjesb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ih/L3o7v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fApwjesb"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46B21DF26B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758270684; cv=none; b=a6N47TEbGvvIqo2A2BSBushnNUZRAACLtRro6WofYkY6HCj31YHI6ha3KQcKX8v0eazT3laUEGZ7V2rxP2Iqzm390vycBigmndSGgNX/hwHrh7LMa8moaeSHlYJrcd3+vKfDH1pLhv/qCZVA5Vi798rZtdaHy+H3O6Jjuexo1tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758270684; c=relaxed/simple;
	bh=JPFjF49Azw9DmwI8SGWbldq4exwf3CK+81zKHgbI9QE=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=DZ1KOiN9qFLMQTbHn4h7KA+pd/CvfzeWJ8LVuc6W1HHP0pIFOEf84bhMjt9aoM33jbWDW6uRfduJNpF7QUL8PvdcTvk+qOxPy5kImoXf4gbq856cqd4+R+UadSGlX92K/gskh3DW2tFG6KhAr6jX3XrlFmcwJI04Hwl93PWIN94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ih/L3o7v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fApwjesb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ih/L3o7v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fApwjesb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DC58333706;
	Fri, 19 Sep 2025 08:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758270680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ekDLuWtVj0BlZsMY5haA0GKjXLHw3jXZSB4apDl6evU=;
	b=ih/L3o7vHRqatLvHJ4VhHb/hvZHr78qe6LNIlvkyGQsFddS3uDdM4WQzmRrQ8KlbW6Z5WX
	ve+EytA93guzd2ujscAH8iySerHKLcH09o8SUYsyfRPiZvzKrJsqcsagujqVXzeS8LHQiN
	tq2pykr9hKAunvu5PinEb1szm/1fhEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758270680;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ekDLuWtVj0BlZsMY5haA0GKjXLHw3jXZSB4apDl6evU=;
	b=fApwjesbN7jXzEU2hY2rH0zfg+baevOuJVMAIa7w9C8AifFy5IHh4Q72q9X5Zkd3lGkBWq
	wQsQ515e6zH6YNCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758270680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ekDLuWtVj0BlZsMY5haA0GKjXLHw3jXZSB4apDl6evU=;
	b=ih/L3o7vHRqatLvHJ4VhHb/hvZHr78qe6LNIlvkyGQsFddS3uDdM4WQzmRrQ8KlbW6Z5WX
	ve+EytA93guzd2ujscAH8iySerHKLcH09o8SUYsyfRPiZvzKrJsqcsagujqVXzeS8LHQiN
	tq2pykr9hKAunvu5PinEb1szm/1fhEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758270680;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ekDLuWtVj0BlZsMY5haA0GKjXLHw3jXZSB4apDl6evU=;
	b=fApwjesbN7jXzEU2hY2rH0zfg+baevOuJVMAIa7w9C8AifFy5IHh4Q72q9X5Zkd3lGkBWq
	wQsQ515e6zH6YNCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ADF9B13A39;
	Fri, 19 Sep 2025 08:31:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aZbuKNgUzWhYJgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 19 Sep 2025 08:31:20 +0000
Date: Fri, 19 Sep 2025 10:31:20 +0200
Message-ID: <878qiaalnr.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.17-rc7
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

Linus,

please pull sound fixes for v6.17-rc7 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.17-rc7

The topmost commit is d33c3471047fc54966621d19329e6a23ebc8ec50

----------------------------------------------------------------

sound fixes for 6.17-rc7

A collection of small fixes.  The volume became higher than wished,
but nothing really stands out -- all small, nice and smooth.
A slightly large change is found in qcom USB-audio offload stuff, but
this is a regression fix specific to this device, hence it should be
safe to apply at this late stage.

- Various small fixes for ASoC Cirrus, Realtek, lpass, Intel and
  Qualcomm drivers
- ASoC SoundWire fixes
- A few TAS2781 HD-audio side-codec driver fixes
- A fix for Qualcomm USB-audio offload breakage
- Usual a few HD-audio quirks

----------------------------------------------------------------

Amadeusz S³awiñski (1):
      ASoC: Intel: catpt: Expose correct bit depth to userspace

Balamurugan C (1):
      ASoC: Intel: PTL: Add entry for HDMI-In capture support to non-I2S codec boards.

Bou-Saan Che (3):
      ALSA: hda: cs35l41: Support Lenovo Thinkbook 13x Gen 5
      ALSA: hda/realtek: Support Lenovo Thinkbook 13x Gen 5
      ALSA: hda/realtek: Fix volume control on Lenovo Thinkbook 13x Gen 4

Charles Keepax (6):
      ASoC: wm8940: Correct PLL rate rounding
      ASoC: wm8940: Correct typo in control name
      ASoC: wm8974: Correct PLL rate rounding
      ASoC: SDCA: Fix return value in sdca_regmap_mbq_size()
      ASoC: SDCA: Fix return value in detected_mode_handler()
      ASoC: SDCA: Reorder members of hide struct to remove holes

Colin Ian King (1):
      ASoC: SOF: Intel: hda-stream: Fix incorrect variable used in error message

Dan Carpenter (1):
      ASoC: codec: sma1307: Fix memory corruption in sma1307_setting_loaded()

Daniel Baluta (1):
      ASoC: SOF: imx: Fix devm_ioremap_resource check

Donald Menig (1):
      ALSA: hda/realtek: Add ALC295 Dell TAS2781 I2C fixup

Jack Yu (1):
      ASoC: rt5682s: Adjust SAR ADC button mode to fix noise issue

Krzysztof Kozlowski (3):
      ASoC: qcom: q6apm-lpass-dais: Fix NULL pointer dereference if source graph failed
      ASoC: codecs: lpass-rx-macro: Fix playback quality distortion
      ASoC: codecs: lpass-wsa-macro: Fix speaker quality distortion

Mac Chiang (1):
      ASoC: Intel: sof_sdw: use PRODUCT_FAMILY for Fatcat series

Maciej Strozek (1):
      ASoC: SDCA: Add quirk for incorrect function types for 3 systems

Mohammad Rafi Shaik (4):
      ASoC: qcom: audioreach: Fix lpaif_type configuration for the I2S interface
      ASoC: qcom: q6apm-lpass-dais: Fix missing set_fmt DAI op for I2S
      ASoC: qcom: sc8280xp: Enable DAI format configuration for MI2S interfaces
      ASoC: qcom: sc8280xp: Fix sound card driver name match data for QCS8275

Paul Menzel (1):
      ALSA: docs: Remove 3rd person singular s in *to indicate*

Praful Adiga (1):
      ALSA: hda/realtek: Fix mute led for HP Laptop 15-dw4xx

Richard Fitzgerald (1):
      ALSA: hda: intel-dsp-config: Prevent SEGFAULT if ACPI_HANDLE() is NULL

Shenghao Ding (2):
      ALSA: hda/tas2781: Fix the order of TAS2781 calibrated-data
      ALSA: hda/tas2781: Fix a potential race condition that causes a NULL pointer in case no efi.get_variable exsits

Shuming Fan (1):
      ASoC: rt712: avoid skipping the blind write

Syed Saba Kareem (1):
      ASoC: amd: amd_sdw: Add quirks for some new Dell laptops

Takashi Iwai (1):
      ALSA: usb: qcom: Fix false-positive address space check

Venkata Prasad Potturu (2):
      ASoC: amd: acp: Adjust pdm gain value
      ASoC: amd: acp: Fix incorrect retrival of acp_chip_info

---
 Documentation/sound/alsa-configuration.rst         |  2 +-
 include/sound/sdca.h                               |  1 +
 include/sound/sdca_function.h                      | 21 ++---
 sound/hda/codecs/realtek/alc269.c                  | 18 ++++-
 .../hda/codecs/side-codecs/cs35l41_hda_property.c  |  4 +
 sound/hda/codecs/side-codecs/tas2781_hda.c         | 30 +++++--
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c     |  5 ++
 sound/hda/core/intel-dsp-config.c                  |  2 +
 sound/soc/amd/acp/acp-i2s.c                        | 11 ++-
 sound/soc/amd/acp/acp-sdw-legacy-mach.c            | 16 ++++
 sound/soc/amd/acp/amd.h                            |  2 +-
 sound/soc/codecs/lpass-rx-macro.c                  | 22 ++++--
 sound/soc/codecs/lpass-wsa-macro.c                 | 22 ++++--
 sound/soc/codecs/rt5682s.c                         | 17 ++--
 sound/soc/codecs/rt712-sdca.c                      |  6 +-
 sound/soc/codecs/sma1307.c                         |  7 +-
 sound/soc/codecs/wm8940.c                          |  9 ++-
 sound/soc/codecs/wm8974.c                          |  8 +-
 sound/soc/intel/boards/sof_sdw.c                   |  2 +-
 sound/soc/intel/boards/sof_ssp_amp.c               |  6 ++
 sound/soc/intel/catpt/pcm.c                        | 23 ++++--
 sound/soc/intel/common/soc-acpi-intel-ptl-match.c  |  6 ++
 sound/soc/qcom/qdsp6/audioreach.c                  |  1 +
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c            |  7 +-
 sound/soc/qcom/sc8280xp.c                          |  6 +-
 sound/soc/sdca/sdca_device.c                       | 20 +++++
 sound/soc/sdca/sdca_functions.c                    | 13 +--
 sound/soc/sdca/sdca_interrupts.c                   |  2 +-
 sound/soc/sdca/sdca_regmap.c                       |  2 +-
 sound/soc/sof/imx/imx-common.c                     |  4 +-
 sound/soc/sof/intel/hda-stream.c                   |  2 +-
 sound/usb/qcom/qc_audio_offload.c                  | 92 +++++++++++-----------
 32 files changed, 266 insertions(+), 123 deletions(-)


