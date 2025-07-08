Return-Path: <linux-kernel+bounces-721666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2110AFCC34
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62FCB4A2844
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620BC2DEA96;
	Tue,  8 Jul 2025 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ySDIL6M+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WRnJ9kUd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ySDIL6M+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WRnJ9kUd"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085202DEA87
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751981409; cv=none; b=oP9GdT445XhFjb+XdiT/ODHsjR2XyEb6jHFHHbw0YdFkUyCy7fJcZmEo9zkwkMJB8k9ZxEhbbRUBxWQIaBy2F1Z5bQux/IThxBmUN/QnSJ4EpPZMvjblJZRanCZ/W39b+QntBSVmfI5USoX5NuyAShlYI6350+njeANZRSfZwP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751981409; c=relaxed/simple;
	bh=NVZvl7WHp/9NIMoUnSDfC/VS+77NPSF3zzdlEXkoEn8=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=Tmo21G1Xq1047o58CUn/O5wb99HDJ/Wy2ixE8SXvAZD1gX0Rn5ZSLVRGa15aKnZgVY7um8CnLkGzxymWqPftP7wzUvR2+1bBU5ZrJESUlfmjJP9hbanHoEhu5brrdZItSA9+hWks2XCawpPq9jbvqL7/FKCqWYmBc01m70IYLUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ySDIL6M+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WRnJ9kUd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ySDIL6M+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WRnJ9kUd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 219861F45E;
	Tue,  8 Jul 2025 13:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751981405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=6kxLe6D5dx1SFFBze2VbjxGktZNC8moKxEYM93616JY=;
	b=ySDIL6M+xOft3uqoSdX7rlKKib1fOhg2okXyNbaS7ZhVJPGeqsh2PBsLbroZ9wWp+YaU/y
	vqQ9tgvA8agS7vf0t9mvtpxFy5H4cSOhupWDCcSVlupvzjQx2/NxZzcbR/a94PmOt1QJs/
	FfRiSWGRfLWufAwwKqcZhMlp4vBzVKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751981405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=6kxLe6D5dx1SFFBze2VbjxGktZNC8moKxEYM93616JY=;
	b=WRnJ9kUdKHmyqwEzEoPbV7PZYRXCr8IkRq+s+BaUb1VrUgAAzzNw2ggZICagwvksUtlWcm
	oPKZWI8CFLkAQ3Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ySDIL6M+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WRnJ9kUd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751981405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=6kxLe6D5dx1SFFBze2VbjxGktZNC8moKxEYM93616JY=;
	b=ySDIL6M+xOft3uqoSdX7rlKKib1fOhg2okXyNbaS7ZhVJPGeqsh2PBsLbroZ9wWp+YaU/y
	vqQ9tgvA8agS7vf0t9mvtpxFy5H4cSOhupWDCcSVlupvzjQx2/NxZzcbR/a94PmOt1QJs/
	FfRiSWGRfLWufAwwKqcZhMlp4vBzVKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751981405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=6kxLe6D5dx1SFFBze2VbjxGktZNC8moKxEYM93616JY=;
	b=WRnJ9kUdKHmyqwEzEoPbV7PZYRXCr8IkRq+s+BaUb1VrUgAAzzNw2ggZICagwvksUtlWcm
	oPKZWI8CFLkAQ3Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B89813A54;
	Tue,  8 Jul 2025 13:30:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QBJnAV0dbWhkNwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 08 Jul 2025 13:30:05 +0000
Date: Tue, 08 Jul 2025 15:30:04 +0200
Message-ID: <871pqq3j4z.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.16-rc6
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 219861F45E
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.51

Linus,

please pull sound fixes for v6.16-rc6 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.16-rc6

The topmost commit is d78f76457d70d30e80b5d2e067d45de7a0505fc0

----------------------------------------------------------------

sound fixes for 6.16-rc6

Here are device-specific small fixes, including HD-audio, USB-audio
and ASoC Intel quirks, as well as ASoC fsl, Cirrus codec and the
legacy AD driver fixes.  All look safe and easy.

----------------------------------------------------------------

Alexander Tsoy (1):
      ALSA: usb-audio: Improve filtering of sample rates on Focusrite devices

Arun Raghavan (1):
      ASoC: fsl_sai: Force a software reset when starting in consumer mode

Baojun Xu (1):
      ALSA: hda/tas2781: Fix calibration data parser issue

Bard Liao (1):
      ASoC: Intel: SND_SOC_INTEL_SOF_BOARD_HELPERS select SND_SOC_ACPI_INTEL_MATCH

Charles Keepax (1):
      ASoC: Intel: soc-acpi: arl: Correct order of cs42l43 matches

Daniel Dadap (1):
      ALSA: hda: Add missing NVIDIA HDA codec IDs

Edip Hazuri (1):
      ALSA: hda/realtek - Add mute LED support for HP Victus 15-fb2xxx

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Enable headset Mic on Positivo K116J

Peter Ujfalusi (1):
      ALSA: hda/realtek: Add quirk for ASUS ExpertBook B9403CVAR

Richard Fitzgerald (1):
      ASoC: cs35l56: probe() should fail if the device ID is not recognized

Shengjiu Wang (1):
      ASoC: fsl_asrc: use internal measured ratio for non-ideal ratio mode

Simon Trimmer (1):
      ASoC: Intel: sof_sdw: Add quirks for Lenovo P1 and P16

Srinivas Kandagatla (1):
      MAINTAINERS: update Qualcomm audio codec drivers list

Thorsten Blum (1):
      ALSA: ad1816a: Fix potential NULL pointer deref in snd_card_ad1816a_pnp()

---
 MAINTAINERS                                       | 16 +++++-----------
 sound/isa/ad1816a/ad1816a.c                       |  2 +-
 sound/pci/hda/patch_hdmi.c                        | 19 +++++++++++++++++++
 sound/pci/hda/patch_realtek.c                     |  3 +++
 sound/pci/hda/tas2781_hda.c                       |  8 +++++---
 sound/soc/codecs/cs35l56-shared.c                 |  2 +-
 sound/soc/fsl/fsl_asrc.c                          |  3 ++-
 sound/soc/fsl/fsl_sai.c                           | 14 ++++++++------
 sound/soc/intel/boards/Kconfig                    |  1 +
 sound/soc/intel/boards/sof_sdw.c                  |  3 +++
 sound/soc/intel/common/soc-acpi-intel-arl-match.c | 14 +++++++-------
 sound/usb/format.c                                | 22 ++++++++++------------
 12 files changed, 65 insertions(+), 42 deletions(-)


