Return-Path: <linux-kernel+bounces-796014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F86B3FAEE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832221A86ACB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67FC2EC0AD;
	Tue,  2 Sep 2025 09:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IotGm6UW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vLOhaLTm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IotGm6UW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vLOhaLTm"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EDE2EC092
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806187; cv=none; b=FpfzshyKllvBQVGIN/Bt5CJI4L+MQ3eE4sPmHY5A2SVCM43A/Z1CcEZ01+HrDfWiwju/6En3eoar8/mGstjxRfYx6S1DL5ZZjj2IuwLmTG9Nt5FykbvjA9Czpkg03GFxEK56sU2y9gfu8SX2U4UGsqCg1r6h5T3lv6fHwzSuLj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806187; c=relaxed/simple;
	bh=+r79dL1gqrDNxRtTgrXMjVpAsgnr0cYz/E5/fOUW5xE=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=e5xvFxhiXUZbuZRiO5LkXEuHSs0XeGt3n5TeKI/yDpwA1GVS9214t+5F05ZdYbZHnhd8gzNEyZZeYKkY7liHUBCgQGWU1unXix2mWxL8KlGfunpcosRog1ZwQABUEZCdyAzVxfxGLB0juMP3u+fLO68KbxIAUyxZKJEn/yoV4UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IotGm6UW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vLOhaLTm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IotGm6UW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vLOhaLTm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B05361F44F;
	Tue,  2 Sep 2025 09:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756806183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=WLH6zNDi4TZ5ZXN34xoFWURtIQIyMoaxKpZcKw32eqA=;
	b=IotGm6UWQmbdIdtnTsNMyyONacJWiXk8/xip7rMVHNt3+XJbwO+scDjWr/e4XjB/Wvy6jM
	JYNd4gF2jeD6+AupycJXcUYAeawMib1zM6+575bWQJ5avbSuDTsI1SXGxxVCFSPlQOMbSb
	XRynu1maG2it0YwmSGHC1wVqMBjA4CM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756806183;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=WLH6zNDi4TZ5ZXN34xoFWURtIQIyMoaxKpZcKw32eqA=;
	b=vLOhaLTmo0EjHZv1e3HMdZqJggNIXV2GO6bHqBUJDziIElI9zJ4qBmqau/ZWM+a/o8gj2k
	3YIC5OQrruLdldBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756806183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=WLH6zNDi4TZ5ZXN34xoFWURtIQIyMoaxKpZcKw32eqA=;
	b=IotGm6UWQmbdIdtnTsNMyyONacJWiXk8/xip7rMVHNt3+XJbwO+scDjWr/e4XjB/Wvy6jM
	JYNd4gF2jeD6+AupycJXcUYAeawMib1zM6+575bWQJ5avbSuDTsI1SXGxxVCFSPlQOMbSb
	XRynu1maG2it0YwmSGHC1wVqMBjA4CM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756806183;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=WLH6zNDi4TZ5ZXN34xoFWURtIQIyMoaxKpZcKw32eqA=;
	b=vLOhaLTmo0EjHZv1e3HMdZqJggNIXV2GO6bHqBUJDziIElI9zJ4qBmqau/ZWM+a/o8gj2k
	3YIC5OQrruLdldBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9895313882;
	Tue,  2 Sep 2025 09:43:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qpl3JCe8tmj5EAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 02 Sep 2025 09:43:03 +0000
Date: Tue, 02 Sep 2025 11:42:55 +0200
Message-ID: <87frd59om8.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.17-rc5
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.30

Linus,

please pull sound fixes for v6.17-rc5 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.17-rc5

The topmost commit is bcd6659d4911c528381531472a0cefbd4003e29e

----------------------------------------------------------------

sound fixes for 6.17-rc5

A collection of small changes including a few regression fixes.

- Regression fix for Intel SKL/KBL HD-audio bindings
- Regression fix for missing Nvidia HDMI codec entries after the
  recent code reorganization
- A few TAS2781 codec regression fixes
- Fix for ASoC component lookup breakage
- Usual HD-audio, USB-audio and SOF quirk entries

----------------------------------------------------------------

Aaron Erhardt (1):
      ALSA: hda/realtek: Fix headset mic for TongFang X6[AF]R5xxY

Ajye Huang (1):
      ASoC: SOF: Intel: WCL: Add the sdw_process_wakeen op

Brady Norander (1):
      ALSA: hda: intel-dsp-config: Select SOF driver on MTL Chromebooks

Cryolitia PukNgae (4):
      ALSA: usb-audio: Add mute TLV for playback volumes on some devices
      ASoC: codecs: idt821034: fix wrong log in idt821034_chip_direction_output()
      ALSA: usb-audio: move mixer_quirks' min_mute into common quirk
      ALSA: docs: Add documents for recently changes in snd-usb-audio

Daniel Dadap (1):
      ALSA: hda/hdmi: Restore missing HDMI codec entries

Gergo Koteles (2):
      ALSA: hda: tas2781: fix tas2563 EFI data endianness
      ALSA: hda: tas2781: reorder tas2563 calibration variables

Kuninori Morimoto (3):
      ASoC: soc-core: care NULL dirver name on snd_soc_lookup_component_nolocked()
      ASoC: soc-core: tidyup snd_soc_lookup_component_nolocked()
      ASoC: rsnd: tidyup direction name on rsnd_dai_connect()

Shenghao Ding (1):
      ALSA: hda/tas2781: Fix EFI name for calibration beginning with 1 instead of 0

Takashi Iwai (2):
      ALSA: hda: Avoid binding with SOF for SKL/KBL platforms
      ALSA: hda/hdmi: Add pin fix for another HP EliteDesk 800 G4 model

Takashi Sakamoto (1):
      ALSA: firewire-motu: drop EPOLLOUT from poll return values as write is not supported

Tina Wuest (1):
      ALSA: usb-audio: Allow Focusrite devices to use low samplerates

qaqland (1):
      ALSA: usb-audio: Add mute TLV for playback volumes on more devices

---
 Documentation/sound/alsa-configuration.rst     | 29 ++++++++++++++++++++++----
 sound/firewire/motu/motu-hwdep.c               |  2 +-
 sound/hda/codecs/hdmi/hdmi.c                   |  1 +
 sound/hda/codecs/hdmi/nvhdmi.c                 | 17 +++++++++++++++
 sound/hda/codecs/hdmi/tegrahdmi.c              |  2 ++
 sound/hda/codecs/realtek/alc269.c              |  2 ++
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c |  9 +++++---
 sound/hda/core/intel-dsp-config.c              | 26 ++++++++++++++++++++---
 sound/soc/codecs/idt821034.c                   |  2 +-
 sound/soc/renesas/rcar/core.c                  |  2 +-
 sound/soc/soc-core.c                           | 25 +++++++++++++---------
 sound/soc/sof/intel/ptl.c                      |  1 +
 sound/usb/format.c                             | 12 +++++++----
 sound/usb/mixer_quirks.c                       |  8 +++----
 sound/usb/quirks.c                             | 22 +++++++++++++++++--
 sound/usb/usbaudio.h                           |  4 ++++
 16 files changed, 130 insertions(+), 34 deletions(-)


