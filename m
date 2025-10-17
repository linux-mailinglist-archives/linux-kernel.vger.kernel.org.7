Return-Path: <linux-kernel+bounces-858244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4D6BE95DA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A23D188BA52
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BB61F3B8A;
	Fri, 17 Oct 2025 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JZydLYRh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PGrVVqWQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JZydLYRh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PGrVVqWQ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E67337100
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713028; cv=none; b=awoULwZrELYXp137PoJlU6nYZ11rO4eFxCh4cySW2jq5Sgx95pNZlE9SGZvTq+N9HDaaE9Whed0VGytHdcOyE/f514csjNWkpyljZu40RkhwEIXzvlqrsOosYuM6sM9I3udDF7KYQPywV6SPo0f0V/iglrAVl5+0HT8NXXt+Pws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713028; c=relaxed/simple;
	bh=mFJ63TMcpI15J5SsDsAll190FmFL2DnbPN8YowOCi1s=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=IQ4CJax9+3ah9UzttG1mCgSZd2sVK5qA+XKwdpveM/g7FtSKmbtDem+P6cRp15RUeaufOWaJjfPdN5xT1MPe6h+UTFK0CBJhdmGM4oZBQIMp/M76aE0ZxF/kZ35ESSUSOENH1ifb4IGenYjvkOW0giUhz9TkoZEOB5vSkFWEaM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JZydLYRh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PGrVVqWQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JZydLYRh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PGrVVqWQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A550A21D49;
	Fri, 17 Oct 2025 14:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760713024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=sMKMh/beb67Xb5bKYH/wVt3lfHdlvz+S3/3zC2ViDJ8=;
	b=JZydLYRhnlx395jiJiaHadyU4NP8R7QEVO+PAN0LRtJToFa+gobfxbEcHE/lHqJdgFTIli
	gLyD7jbh8dnaIMG7iZ0qON0GIc6ffhJEueZvf0S5/1iYJ9jmX+dL5CWU9y9FS+3usqfGeg
	bSBCfTMI2Xnq9aksLUB5phkqj9lbPjo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760713024;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=sMKMh/beb67Xb5bKYH/wVt3lfHdlvz+S3/3zC2ViDJ8=;
	b=PGrVVqWQZCzSycFs0haRVnzm4zpVmoS9Zqr7Y3WVSCQEmmcRdNgAuxTfY7eljfnQ+8RIRo
	eB5df0QeSgraKUCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760713024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=sMKMh/beb67Xb5bKYH/wVt3lfHdlvz+S3/3zC2ViDJ8=;
	b=JZydLYRhnlx395jiJiaHadyU4NP8R7QEVO+PAN0LRtJToFa+gobfxbEcHE/lHqJdgFTIli
	gLyD7jbh8dnaIMG7iZ0qON0GIc6ffhJEueZvf0S5/1iYJ9jmX+dL5CWU9y9FS+3usqfGeg
	bSBCfTMI2Xnq9aksLUB5phkqj9lbPjo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760713024;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=sMKMh/beb67Xb5bKYH/wVt3lfHdlvz+S3/3zC2ViDJ8=;
	b=PGrVVqWQZCzSycFs0haRVnzm4zpVmoS9Zqr7Y3WVSCQEmmcRdNgAuxTfY7eljfnQ+8RIRo
	eB5df0QeSgraKUCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B1E413A71;
	Fri, 17 Oct 2025 14:57:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eRTOGEBZ8miUdAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 17 Oct 2025 14:57:04 +0000
Date: Fri, 17 Oct 2025 16:57:04 +0200
Message-ID: <87a51p60fz.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.18-rc2
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

Linus,

please pull sound fixes for v6.18-rc2 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.18-rc2

The topmost commit is 2a786348004b34c5f61235d51c40c1c718b1f8f9

----------------------------------------------------------------

sound fixes for 6.18-rc2

A collection of small fixes.  All changes are rather boring
device-specific fixes and quirks.

- A few fixes for missing NULL checks
- ASoC NAU8821 fixes for jack and irq handling
- Various fixes for ASoC TAS2781, IDT821034, sc8280xp, max9809x,
  wcd938x, and SoundWire
- Usual HD-audio and USB-audio quirks

----------------------------------------------------------------

Baojun Xu (2):
      ASoC: tas2781: Support more newly-released amplifiers tas58xx in the driver
      ASoC: tas2781: Update ti,tas2781.yaml for adding tas58xx

Christophe Leroy (1):
      ASoC: codecs: Fix gain setting ranges for Renesas IDT821034 codec

Cristian Ciocaltea (5):
      ASoC: nau8821: Cancel jdet_work before handling jack ejection
      ASoC: nau8821: Generalize helper to clear IRQ status
      ASoC: nau8821: Consistently clear interrupts before unmasking
      ASoC: nau8821: Add DMI quirk to bypass jack debounce circuit
      ASoC: nau8821: Avoid unnecessary blocking in IRQ handler

Cryolitia PukNgae (1):
      ALSA: usb-audio: apply quirk for Huawei Technologies Co., Ltd. CM-Q3

Dawn Gardner (1):
      ALSA: hda/realtek: Fix mute led for HP Omen 17-cb0xxx

Denis Arefev (2):
      ALSA: hda: cs35l41: Fix NULL pointer dereference in cs35l41_get_acpi_mute_state()
      ALSA: hda: Fix missing pointer check in hda_component_manager_init function

Frank Li (1):
      ASoC: dt-bindings: Add compatible string fsl,imx-audio-tlv320

Jiaming Zhang (1):
      ALSA: usb-audio: Fix NULL pointer deference in try_to_register_card

Le Qi (2):
      ASoC: dt-bindings: qcom,sm8250: Add QCS615 sound card
      ASoC: qcom: sc8280xp: Add support for QCS615

Li Qiang (1):
      ASoC: amd/sdw_utils: avoid NULL deref when devm_kasprintf() fails

Pauli Virtanen (3):
      ALSA: usb-audio: add mixer_playback_min_mute quirk for Logitech H390
      ALSA: usb-audio: add volume quirks for MS LifeChat LX-3000
      ALSA: usb-audio: fix vendor quirk for Logitech H390

Randy Dunlap (1):
      ALSA: firewire: amdtp-stream: fix enum kernel-doc warnings

Sharique Mohammad (1):
      ASoC: max98090/91: fixed max98091 ALSA widget powering up/down

Shenghao Ding (1):
      ALSA: hda/tas2781: Set tas2781_hda::tasdevice_priv::chip_id as TAS5825 in case of tas5825

Shuming Fan (1):
      ASoC: sdw_utils: add rt1321 part id to codec_info_list

Srinivas Kandagatla (1):
      ASoC: codecs: wcd938x-sdw: remove redundant runtime pm calls

Stuart Hayhurst (1):
      ALSA: hda/intel: Add MSI X870E Tomahawk to denylist

Takashi Iwai (1):
      ALSA: hda/realtek: Add quirk entry for HP ZBook 17 G6

---
 .../devicetree/bindings/sound/fsl-asoc-card.yaml   |   1 +
 .../devicetree/bindings/sound/qcom,sm8250.yaml     |   1 +
 .../devicetree/bindings/sound/ti,tas2781.yaml      |  43 ++++++-
 include/sound/tas2781.h                            |   3 +
 sound/firewire/amdtp-stream.h                      |   2 +-
 sound/hda/codecs/realtek/alc269.c                  |   2 +
 sound/hda/codecs/side-codecs/cs35l41_hda.c         |   2 +
 sound/hda/codecs/side-codecs/hda_component.c       |   4 +
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c     |   1 +
 sound/hda/controllers/intel.c                      |   1 +
 sound/soc/amd/acp/acp-sdw-sof-mach.c               |   2 +-
 sound/soc/codecs/idt821034.c                       |  12 +-
 sound/soc/codecs/max98090.c                        |   6 +-
 sound/soc/codecs/nau8821.c                         | 133 +++++++++++++--------
 sound/soc/codecs/nau8821.h                         |   2 +-
 sound/soc/codecs/tas2781-i2c.c                     |  21 +++-
 sound/soc/codecs/wcd938x-sdw.c                     |  22 +---
 sound/soc/qcom/sc8280xp.c                          |   1 +
 sound/soc/sdw_utils/soc_sdw_utils.c                |  20 ++++
 sound/usb/card.c                                   |  10 +-
 sound/usb/mixer.c                                  |  15 +++
 sound/usb/quirks.c                                 |   5 +
 22 files changed, 219 insertions(+), 90 deletions(-)


