Return-Path: <linux-kernel+bounces-770728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5792DB27E48
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6611D1D05077
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D052FF657;
	Fri, 15 Aug 2025 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GkNmD9tc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BL/l6xUX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GkNmD9tc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BL/l6xUX"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929222FD7CB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755253829; cv=none; b=gJDzLH7/SF3pC8yBn5miH5ItbH/GsKCclfrLtVY0eI6xf1iPL9iRIRPgdif1jaF6BV8xoNcvX9vRfS2pwwAS5jf7ANfpb6Zw5Vx/kjCisK9V40Bukn9GCaegY3Dm2/tpNs2FhQsOMc0GazpyLIqU9gZDvs4BkDbhimnz5GvGjSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755253829; c=relaxed/simple;
	bh=UOCRw2WKItyLa/IG6PBz1/NN08tPiqLkSnqWg/d64pE=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=T4zVIrypdsQ4VMDa0pViUcksiwa7SjdepmTy1LMf4un/zb9JsTr22NLNvICLGKvtBsiCqAeNzHanbcIrEbmRR5nDf0MbvVT6KUbCdZMP3T4DE2dBEesoFnPzLXs80aQ/jYlm8aVRd4Fy/HfHfJdszhzdPr8TwTwCVEAQBOUm71I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GkNmD9tc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BL/l6xUX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GkNmD9tc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BL/l6xUX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B752C2188B;
	Fri, 15 Aug 2025 10:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755253825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ghmMkFo3QvAYeAvB3P6z4pmIIkT6+ltUDkCjOy0gp+4=;
	b=GkNmD9tcEOybCh3eitFfxjmuYursB5BHHvQ5m9U+d0aOmDcO9PA2PKmqN7zplAq9fbOBj7
	4ddvVF7sORuJNJYY2JE1oo97cIJBvvfKEcWiwuxac4xq2nNDwsF36EJ95bSu8e+sfaJE7r
	RV2dttJJJwvewCF+yq7qxngi8JmpC/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755253825;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ghmMkFo3QvAYeAvB3P6z4pmIIkT6+ltUDkCjOy0gp+4=;
	b=BL/l6xUXBXxxnkV1w2pDv3Y1i6szozZ51iR1jOkoIRUP9If5YompJUehx2Hlc5mI5QRw05
	KLJ8weBPf8WDQmBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755253825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ghmMkFo3QvAYeAvB3P6z4pmIIkT6+ltUDkCjOy0gp+4=;
	b=GkNmD9tcEOybCh3eitFfxjmuYursB5BHHvQ5m9U+d0aOmDcO9PA2PKmqN7zplAq9fbOBj7
	4ddvVF7sORuJNJYY2JE1oo97cIJBvvfKEcWiwuxac4xq2nNDwsF36EJ95bSu8e+sfaJE7r
	RV2dttJJJwvewCF+yq7qxngi8JmpC/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755253825;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ghmMkFo3QvAYeAvB3P6z4pmIIkT6+ltUDkCjOy0gp+4=;
	b=BL/l6xUXBXxxnkV1w2pDv3Y1i6szozZ51iR1jOkoIRUP9If5YompJUehx2Hlc5mI5QRw05
	KLJ8weBPf8WDQmBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8CB0C13876;
	Fri, 15 Aug 2025 10:30:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a9YSIUEMn2hfPgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 15 Aug 2025 10:30:25 +0000
Date: Fri, 15 Aug 2025 12:30:25 +0200
Message-ID: <877bz4ubb2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.17-rc2
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.30

Linus,

please pull sound fixes for v6.17-rc2 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.17-rc2

The topmost commit is c345102d1feed3de8aa9b9ec7d18b3fbba62deb7

----------------------------------------------------------------

sound fixes for 6.17-rc2

A collection of small fixes.

- Potential OOB access fixes in USB-audio driver
- ASoC kconfig menu fix for improving the generic drivers
- HD-audio quirks and a fix revert
- Codec and platform-specific small fixes for ASoC

----------------------------------------------------------------

Alexey Klimov (1):
      ASoC: codecs: tx-macro: correct tx_macro_component_drv name

Baojun Xu (2):
      ASoC: tas2781: Normalize the volume kcontrol name
      ALSA: hda/tas2781: Normalize the volume kcontrol name

Christopher Eby (1):
      ALSA: hda/realtek: Add Framework Laptop 13 (AMD Ryzen AI 300) to quirks

Colin Ian King (2):
      ASoC: codec: sma1307: replace spelling mistake with new error message
      ASoC: tas2781: Fix spelling mistake "dismatch" -> "mismatch"

Kuninori Morimoto (1):
      ASoC: generic: tidyup standardized ASoC menu for generic

Mario Limonciello (AMD) (1):
      Revert "ALSA: hda: Add ASRock X670E Taichi to denylist"

Sergio Perez Gonzalez (1):
      ASoC: stm: stm32_i2s: Fix calc_clk_div() error handling in determine_rate()

Shengjiu Wang (1):
      ASoC: fsl_sai: replace regmap_write with regmap_update_bits

Shuming Fan (2):
      ASoC: rt721: fix FU33 Boost Volume control not working
      ASoC: rt1320: fix random cycle mute issue

Takashi Iwai (3):
      ALSA: azt3328: Put __maybe_unused for inline functions for gameport
      ALSA: usb-audio: Validate UAC3 power domain descriptors, too
      ALSA: usb-audio: Validate UAC3 cluster segment descriptors

Thorsten Blum (1):
      ASoC: codecs: Call strscpy() with correct size argument

Vasiliy Kovalev (1):
      ALSA: hda/realtek: Fix headset mic on HONOR BRB-X

---
 sound/hda/codecs/realtek/alc269.c              |  2 ++
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c |  2 +-
 sound/hda/controllers/intel.c                  |  1 -
 sound/pci/azt3328.c                            |  8 ++++----
 sound/soc/Kconfig                              |  4 +++-
 sound/soc/codecs/aw87390.c                     |  8 +++-----
 sound/soc/codecs/aw88081.c                     |  5 ++---
 sound/soc/codecs/aw88166.c                     |  8 +++-----
 sound/soc/codecs/aw88261.c                     |  8 +++-----
 sound/soc/codecs/aw88395/aw88395.c             |  8 +++-----
 sound/soc/codecs/aw88399.c                     |  8 +++-----
 sound/soc/codecs/lpass-tx-macro.c              |  2 +-
 sound/soc/codecs/rt1320-sdw.c                  |  3 ++-
 sound/soc/codecs/rt721-sdca.c                  |  2 ++
 sound/soc/codecs/rt721-sdca.h                  |  4 ++++
 sound/soc/codecs/sma1307.c                     |  2 +-
 sound/soc/codecs/tas2781-i2c.c                 |  6 +++---
 sound/soc/fsl/fsl_sai.c                        | 20 ++++++++++----------
 sound/soc/stm/stm32_i2s.c                      |  7 ++-----
 sound/usb/stream.c                             | 25 ++++++++++++++++++++++---
 sound/usb/validate.c                           | 12 ++++++++++++
 21 files changed, 86 insertions(+), 59 deletions(-)


