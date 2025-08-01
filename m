Return-Path: <linux-kernel+bounces-753360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEB0B181E5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C428D3B00EF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 12:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18F9247299;
	Fri,  1 Aug 2025 12:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YO2lXX+D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ybjNLCk+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YO2lXX+D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ybjNLCk+"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9197F2459F2
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 12:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754051752; cv=none; b=LjmuHcHs9gPMZritHYyCilcXo+ovht1r52ZrjFMH8/yIF4V4l+EHkr8NFIGHZEJmIpBM7zaurYRVAT1wwp00x/XXO450edrz44rRnlJjVy9Ee2z3frr+ZpncbHZgyq/y4NodMabyVoYD3j+UKJfoFpuSqFdBIZVjdqS7IKQKcC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754051752; c=relaxed/simple;
	bh=D9ObvILp+lUIkx0Bq91VOHnROC18qHlTNJqML3UgNpo=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=VEiKOsigad+KvShIP8DH4/RxTKLTt6n1awR/Qg8jAJHHQHdqKmmJ7G/atpsgJZNthRargiiW+GUpX8cNaXb/uowu/96N5pCBt9gsm0A583dVXc2IHvu+/T0uz/04MIgLfR9EC4CR6T/lQpKsUFNVq0VaYuYXjVn3/QEOxAv0WqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YO2lXX+D; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ybjNLCk+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YO2lXX+D; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ybjNLCk+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B018F1F810;
	Fri,  1 Aug 2025 12:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754051748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=J7RdfBtVvCGFmCY5ns7Z16s6Nfl0x+XqAwobjvZDI9w=;
	b=YO2lXX+DcTJl/6Pgeran5DxQk6OvG7h40o7fbYuVHeKrCjCzn+PXegqYnzijys5e1168N8
	GEsKsPUsaZp+HT27yLTRlNo1sQLdgslloe3Q05omtPVEHd/lhBpF4apZHs70O+ijW6ep2d
	bEaprRZMbidPGAaNrmFf8eh1X+nmnZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754051748;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=J7RdfBtVvCGFmCY5ns7Z16s6Nfl0x+XqAwobjvZDI9w=;
	b=ybjNLCk+fMGTlu2GTtDa6YhuQG4Gu+yD4jG09ii+lEkj43G56+L3UtRNndrKZCeoJMslc1
	iALOEVHbiQlpMgBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YO2lXX+D;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ybjNLCk+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754051748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=J7RdfBtVvCGFmCY5ns7Z16s6Nfl0x+XqAwobjvZDI9w=;
	b=YO2lXX+DcTJl/6Pgeran5DxQk6OvG7h40o7fbYuVHeKrCjCzn+PXegqYnzijys5e1168N8
	GEsKsPUsaZp+HT27yLTRlNo1sQLdgslloe3Q05omtPVEHd/lhBpF4apZHs70O+ijW6ep2d
	bEaprRZMbidPGAaNrmFf8eh1X+nmnZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754051748;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=J7RdfBtVvCGFmCY5ns7Z16s6Nfl0x+XqAwobjvZDI9w=;
	b=ybjNLCk+fMGTlu2GTtDa6YhuQG4Gu+yD4jG09ii+lEkj43G56+L3UtRNndrKZCeoJMslc1
	iALOEVHbiQlpMgBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8518B138A5;
	Fri,  1 Aug 2025 12:35:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n9TAHqS0jGhqdgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 01 Aug 2025 12:35:48 +0000
Date: Fri, 01 Aug 2025 14:35:48 +0200
Message-ID: <87qzxv2p97.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound updates #2 for 6.17-rc1
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: B018F1F810
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

Linus,

please pull another sound updates for v6.17-rc1 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.17-rc1-2

The topmost commit is df485a4b2b3ee5b35c80f990beb554e38a8a5fb1

----------------------------------------------------------------

sound updates #2 for 6.17-rc1

For catching up the remaining stuff for 6.17: only small updates
and the rest are mostly small fixes.

- Fixes in HD-audio codec driver Kconfig, so that configurations
  can be more easily/safely carried between different versions
- Fixes in ASoC SDCA, FSL xcvr, AW88399
- ASoC IMX WM8524 support
- HD-audio and USB-audio quirks and fixes
- A minor selftest fix

----------------------------------------------------------------

Baojun Xu (1):
      ALSA: hda: Fix the wrong register was used for DVC of TAS2770

Chancel Liu (1):
      ASoC: imx-card: Add WM8524 support

Charles Keepax (2):
      ASoC: SDCA: Fix some holes in the regmap readable/writeable helpers
      ASoC: SDCA: Add support for -cn- value properties

Edip Hazuri (3):
      ALSA: hda/realtek - Fix mute LED for HP Victus 16-r1xxx
      ALSA: hda/realtek - Fix mute LED for HP Victus 16-s0xxx
      ALSA: hda/realtek - Fix mute LED for HP Victus 16-d1xxx (MB 8A26)

Geoffrey D. Bennett (1):
      ALSA: scarlett2: Add retry on -EPROTO from scarlett2_usb_tx()

Shengjiu Wang (2):
      ASoC: fsl_xcvr: get channel status data when PHY is not exists
      ASoC: fsl_xcvr: get channel status data with firmware exists

Takashi Iwai (7):
      ALSA: hda/realtek: Enable drivers as default
      ALSA: hda/cirrus: Enable drivers as default
      ALSA: hda/hdmi: Enable drivers as default
      arm: Update HD-audio configs again
      LoongArch: Update HD-audio codec configs
      mips: Update HD-audio configs again
      ALSA: usb: scarlett2: Fix missing NULL check

Varshini Rajendran (1):
      ASoC: dt-bindings: atmel,at91-ssc: add microchip,sam9x7-ssc

WangYuli (1):
      selftests: ALSA: fix memory leak in utimer test

Weidong Wang (1):
      ASoC: codecs: Add acpi_match_table for aw88399 driver

noble.yang (1):
      ALSA: usb-audio: Add DSD support for Comtrue USB Audio device

---
 .../devicetree/bindings/sound/atmel,at91-ssc.yaml  | 11 ++-
 arch/arm/configs/multi_v7_defconfig                |  4 +-
 arch/arm/configs/tegra_defconfig                   |  5 ++
 arch/loongarch/configs/loongson3_defconfig         | 15 ++++
 arch/mips/configs/loongson2k_defconfig             | 11 +++
 arch/mips/configs/loongson3_defconfig              | 15 +++-
 include/sound/sdca_function.h                      | 14 +--
 include/sound/tas2770-tlv.h                        |  4 +-
 sound/hda/codecs/cirrus/Kconfig                    |  9 ++
 sound/hda/codecs/hdmi/Kconfig                      | 24 ++++--
 sound/hda/codecs/hdmi/Makefile                     |  2 +-
 sound/hda/codecs/realtek/Kconfig                   | 12 ++-
 sound/hda/codecs/realtek/alc269.c                  |  3 +
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c     |  2 +-
 sound/soc/codecs/aw88399.c                         |  9 ++
 sound/soc/fsl/fsl_xcvr.c                           | 25 +++++-
 sound/soc/fsl/imx-card.c                           | 40 +++++++++
 sound/soc/sdca/sdca_functions.c                    | 99 ++++++++++++++--------
 sound/soc/sdca/sdca_regmap.c                       | 29 +++++--
 sound/usb/mixer_scarlett2.c                        | 14 ++-
 sound/usb/quirks.c                                 |  2 +
 tools/testing/selftests/alsa/utimer-test.c         |  1 +
 22 files changed, 282 insertions(+), 68 deletions(-)


