Return-Path: <linux-kernel+bounces-880112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2975FC24E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C7DF405FE7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D1A34405D;
	Fri, 31 Oct 2025 12:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gQqtwMNn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="D6l/0Lt3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gQqtwMNn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="D6l/0Lt3"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A4133E352
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761912043; cv=none; b=NSJNJ8SRBpl+QoCVOPJAl455EUSKKekn6QY+ssOoPhdupoX71eVNUFiLDpSBfqbaUSGjTvSNFov1mOzLNw3v161bd+KlU0q1udjxUN4MKIGW8qjjdeuYitJ1rjR0eoceCkgVnG7plat97ns8UfuhUxnxpzTAUu7I4obS2Bwt+E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761912043; c=relaxed/simple;
	bh=DI9Jx92FWZxkx5go574zDm9Nr9F05CIE39esmi7BdGM=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=Hp/RIi5yfBSME5o2CYEh4VyVQVLty5cJ0qOrxIDE0g/yJaz51LLmJLgncYgQ60HYUtuboG3x5nSvt+RfScpfwbxn0czwVx8poRvKMUPppzPTypZtXnxs3dL2E49AfzPElTO5xjtPKlvRsxDYZ36pwgb1RGxynREOp+jTEi/7srY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gQqtwMNn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=D6l/0Lt3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gQqtwMNn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=D6l/0Lt3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 374D021E4E;
	Fri, 31 Oct 2025 12:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761912040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=sjAOKbLAimuRiSFVdeMAVgwUbhjuUHxTCegPKmyu1/U=;
	b=gQqtwMNnd3BbJuJ0r3Z4BI5DFS15zMNAoU3srhiOmzkSxIkLK0o8LXIYVxAb0UjpuYMPdK
	W8eh/Q/QCTVexKvzz2lhbChFbNLVC+CkLuu5SGmOHaH43WYvsgUjDJ9J4Zk99MsDwtY7Dj
	kxokpZJWK5tlDQiH0sW7V4h8etDyKkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761912040;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=sjAOKbLAimuRiSFVdeMAVgwUbhjuUHxTCegPKmyu1/U=;
	b=D6l/0Lt3FQVQKD6z8+gzakiWSyOyzLeY7eIfnxfTR7l4F2UYVm+5Y6uS39J7bfOPPnkfN0
	H2Q/wKfHpt4GDZBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761912040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=sjAOKbLAimuRiSFVdeMAVgwUbhjuUHxTCegPKmyu1/U=;
	b=gQqtwMNnd3BbJuJ0r3Z4BI5DFS15zMNAoU3srhiOmzkSxIkLK0o8LXIYVxAb0UjpuYMPdK
	W8eh/Q/QCTVexKvzz2lhbChFbNLVC+CkLuu5SGmOHaH43WYvsgUjDJ9J4Zk99MsDwtY7Dj
	kxokpZJWK5tlDQiH0sW7V4h8etDyKkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761912040;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=sjAOKbLAimuRiSFVdeMAVgwUbhjuUHxTCegPKmyu1/U=;
	b=D6l/0Lt3FQVQKD6z8+gzakiWSyOyzLeY7eIfnxfTR7l4F2UYVm+5Y6uS39J7bfOPPnkfN0
	H2Q/wKfHpt4GDZBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AA9E13991;
	Fri, 31 Oct 2025 12:00:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vNIrAeikBGmCcQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 31 Oct 2025 12:00:40 +0000
Date: Fri, 31 Oct 2025 13:00:39 +0100
Message-ID: <87frazjn6g.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.18-rc4
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

Linus,

please pull sound fixes for v6.18-rc4 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.18-rc4

The topmost commit is 390db60f8e2bd21fae544917eb3a8618265c058c

----------------------------------------------------------------

sound fixes for 6.18-rc4

A collection of small fixes.  It became slightly bigger than usual
due to timing issues (holidays, etc), but all changes are rather
device-specific fixes, so not really worrisome.

- ASoC Cirrus codec fixes for AMD
- Various fixes for ASoC Intel AVS, Qualcomm, SoundWire, FSL,
  Mediatek, Renesas,
- A few HD-audio quirks, and USB-audio regression fixes for Presonus

----------------------------------------------------------------

Bard Liao (1):
      ASoC: soc_sdw_utils: remove cs42l43 component_name

Cezary Rojewski (3):
      ASoC: Intel: avs: Unprepare a stream when XRUN occurs
      ASoC: Intel: avs: Disable periods-elapsed work when closing PCM
      ASoC: Intel: avs: Use snd_codec format when initializing probe

Claudiu Beznea (1):
      ASoC: renesas: rz-ssi: Use proper dma_buffer_pos after resume

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Enable mic on Vaio RPL

Eren Demir (1):
      ALSA: hda/realtek: Fix mute led for HP Victus 15-fa1xxx (MB 8C2D)

Haotian Zhang (1):
      ASoC: mediatek: Fix double pm_runtime_disable in remove functions

J-Donald Tournier (1):
      ALSA: hda/realtek: Add quirk for Lenovo Yoga 7 2-in-1 14AKP10

Maarten Zanders (1):
      ASoC: fsl_sai: Fix sync error in consumer mode

Mark Brown (1):
      ASoC: Fix build for sdw_utils

Richard Fitzgerald (1):
      ASoC: cs-amp-lib-test: Fix missing include of kunit/test-bug.h

Roy Vegard Ovesen (2):
      ALSA: usb-audio: fix control pipe direction
      ALSA: usb-audio: don't log messages meant for 1810c when initializing 1824c

Sharique Mohammad (1):
      ASOC: max98090/91: fix for filter configuration: AHPF removed DMIC2_HPF added

Shengjiu Wang (2):
      ASoC: fsl_sai: fix bit order for DSD format
      ASoC: fsl_micfil: correct the endian format for DSD

Shuming Fan (2):
      ASoC: sdw_utils: add name_prefix for rt1321 part id
      ASoC: rt721: fix prepare clock stop failed

Simon Trimmer (3):
      ASoC: cs530x: Correct log message with expected variable
      ASoC: amd: acp: Add ACP7.0 match entries for cs35l56 and cs42l43
      ASoC: Intel: soc-acpi-intel-ptl-match: Remove cs42l43 match from sdw link3

Srinivas Kandagatla (2):
      ASoC: qdsp6: q6asm: do not sleep while atomic
      ASoC: dt-bindings: pm4125-sdw: correct number of soundwire ports

---
 .../devicetree/bindings/sound/qcom,pm4125-sdw.yaml |   4 +-
 sound/hda/codecs/realtek/alc269.c                  |  14 ++
 sound/soc/amd/acp/amd-acp70-acpi-match.c           | 157 +++++++++++++++++++++
 sound/soc/codecs/cs-amp-lib-test.c                 |   1 +
 sound/soc/codecs/cs530x.c                          |   2 +-
 sound/soc/codecs/max98090.c                        |   6 +-
 sound/soc/codecs/rt721-sdca.c                      |   4 +
 sound/soc/codecs/rt721-sdca.h                      |   1 +
 sound/soc/fsl/fsl_micfil.c                         |   4 +-
 sound/soc/fsl/fsl_sai.c                            |  11 +-
 sound/soc/intel/avs/pcm.c                          |   3 +
 sound/soc/intel/avs/probes.c                       |  18 +--
 sound/soc/intel/common/soc-acpi-intel-ptl-match.c  |  52 -------
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c         |   1 -
 sound/soc/mediatek/mt8365/mt8365-afe-pcm.c         |   1 -
 sound/soc/qcom/qdsp6/q6asm.c                       |   2 +-
 sound/soc/renesas/rz-ssi.c                         |  25 ++--
 sound/soc/sdw_utils/soc_sdw_utils.c                |   1 -
 sound/usb/mixer_s1810c.c                           |  37 ++---
 19 files changed, 237 insertions(+), 107 deletions(-)


