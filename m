Return-Path: <linux-kernel+bounces-781693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DF5B31592
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32EC1BA5C69
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3432F5483;
	Fri, 22 Aug 2025 10:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c4TVsuQy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Eu4aSXkw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c4TVsuQy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Eu4aSXkw"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F40219A81
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755859078; cv=none; b=LGA+abhhpVITklXXjlpicuYfAscAd5QrO7FxOisL1pont5ffq+bgIF+ipDdo+/cDDaq7Z/bGCQFPSYBGtEMOBZM2wKpeMKoDSJQMVfeU/AgCaIDCm9wbWNx3M1VDCX7eWWfoR+tFzWQTcT+Ivz2OT90WEsZziJPU7dFenQiMjAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755859078; c=relaxed/simple;
	bh=pHVbu1zawc1+XKyzYxBMKZwzP0Lj74IQ8rz4jxqwTek=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=aaxYvZA9XpZ8QXtHaouFthMR4MM62rwSNwzzU5kay3OgzrIOMf6hIMB5/danK2A1RdsVXvGMyNHwB8B+SgcCO9SSLFIdA1lDkAt++izMFvTOQ4mB4tqR3eNIaPU157QnT3BmAFIkaZc0GQ5mAFqXsourijz5LSLdnRPOHjqhE5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c4TVsuQy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Eu4aSXkw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c4TVsuQy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Eu4aSXkw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 47F941F7DD;
	Fri, 22 Aug 2025 10:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755859075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=SNnS58n1IEvRTS6Y4zEPIKJBPbrLmqSdeBq1nutGYOw=;
	b=c4TVsuQynH3h1H0BYAXGKBZXvWu4gGM7H78EwVmF3N65GJtNiZJSGoZlivIIGx+UhZJau7
	tQctko4ISg6vD4s4SobuVqxlKxvTBiKtNj6IDJsD+F2nUZysPtDsq+k6dGcqS1RgP8/gDs
	cNVV6oat26/lOjEow1WP5zGQdYVtuUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755859075;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=SNnS58n1IEvRTS6Y4zEPIKJBPbrLmqSdeBq1nutGYOw=;
	b=Eu4aSXkwXSppDPiUDfvEC6hkF2ihV2h4yTJ2l9BghSDe+xLziHFbqge+F/xo1zv/T4jD0H
	lJ0EvdJSlkk5SxDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755859075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=SNnS58n1IEvRTS6Y4zEPIKJBPbrLmqSdeBq1nutGYOw=;
	b=c4TVsuQynH3h1H0BYAXGKBZXvWu4gGM7H78EwVmF3N65GJtNiZJSGoZlivIIGx+UhZJau7
	tQctko4ISg6vD4s4SobuVqxlKxvTBiKtNj6IDJsD+F2nUZysPtDsq+k6dGcqS1RgP8/gDs
	cNVV6oat26/lOjEow1WP5zGQdYVtuUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755859075;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=SNnS58n1IEvRTS6Y4zEPIKJBPbrLmqSdeBq1nutGYOw=;
	b=Eu4aSXkwXSppDPiUDfvEC6hkF2ihV2h4yTJ2l9BghSDe+xLziHFbqge+F/xo1zv/T4jD0H
	lJ0EvdJSlkk5SxDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19F4B13931;
	Fri, 22 Aug 2025 10:37:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MfM8BINIqGgIRAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 22 Aug 2025 10:37:55 +0000
Date: Fri, 22 Aug 2025 12:37:54 +0200
Message-ID: <87ms7r4p6l.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.17-rc3
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

please pull sound fixes for v6.17-rc3 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.17-rc3

The topmost commit is 8410fe81093ff231e964891e215b624dabb734b0

----------------------------------------------------------------

sound fixes for 6.17-rc3

Only small fixes.

- ASoC Cirrus codec fixes
- A regression fix for the recent TAS2781 codec refactoring
- A fix for user-timer error handling
- Fixes for USB-audio descriptor validators
- Usual HD-audio and ASoC device-specific quirks

----------------------------------------------------------------

Dan Carpenter (1):
      ALSA: usb-audio: Fix size validation in convert_chmap_v3()

Dewei Meng (1):
      ALSA: timer: fix ida_free call while not allocated

Evgeniy Harchenko (1):
      ALSA: hda/realtek: Add support for HP EliteBook x360 830 G6 and EliteBook 830 G6

Kailang Yang (1):
      ALSA: hda/realtek: Audio disappears on HP 15-fc000 after warm boot again

Richard Fitzgerald (1):
      ASoC: cs35l56: Handle new algorithms IDs for CS35L63

Shenghao Ding (1):
      ALSA: hda/tas2781: Add name prefix tas2781 for tas2781's dvc_tlv and amp_vol_tlv

Stefan Binding (2):
      ASoC: cs35l56: Update Firmware Addresses for CS35L63 for production silicon
      ASoC: cs35l56: Remove SoundWire Clock Divider workaround for CS35L63

Takashi Iwai (2):
      ALSA: hda: tas2781: Fix wrong reference of tasdevice_priv
      ALSA: usb-audio: Use correct sub-type for UAC3 feature unit validation

Vasiliy Kovalev (1):
      ALSA: hda/realtek: Fix headset mic on ASUS Zenbook 14

Zhang Yi (1):
      ASoC: codecs: ES9389: Modify the standby configuration

---
 include/sound/cs35l56.h                        |  5 +-
 include/sound/tas2781-tlv.h                    |  6 +--
 sound/core/timer.c                             |  4 +-
 sound/hda/codecs/realtek/alc269.c              | 31 ++++++++----
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c |  4 +-
 sound/hda/codecs/side-codecs/tas2781_hda_spi.c |  6 ++-
 sound/soc/codecs/cs35l56-sdw.c                 | 69 --------------------------
 sound/soc/codecs/cs35l56-shared.c              | 29 +++++++++--
 sound/soc/codecs/cs35l56.c                     |  2 +-
 sound/soc/codecs/cs35l56.h                     |  3 --
 sound/soc/codecs/es8389.c                      |  2 +-
 sound/soc/codecs/tas2781-i2c.c                 |  4 +-
 sound/usb/stream.c                             |  2 +-
 sound/usb/validate.c                           |  2 +-
 14 files changed, 68 insertions(+), 101 deletions(-)


