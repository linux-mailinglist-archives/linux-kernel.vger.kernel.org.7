Return-Path: <linux-kernel+bounces-760112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 883C5B1E696
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A193BABB2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6303F27467B;
	Fri,  8 Aug 2025 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lsVUEq9O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iMROzdO0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lsVUEq9O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iMROzdO0"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA392701A3
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754649623; cv=none; b=cYfVewV3EcBu7EHwT8tL+0+c3sMc1jIaMrHi++/xIQyIDlvO9gCSFp2CvkLQjLNhcoWXz+s19qkD7hgXMkkgxS9/HYmVluhUt5AdWhUBLKpuX2M/OKWdZ9y2SuSnTlTl/lnQb8b+RcnjclO08AMFHnWQ0ey/678YtIe6wXXhuFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754649623; c=relaxed/simple;
	bh=1drwLTxFsT63IfRrO01m4wtIKzoOH370Yc3Xqdwt4/4=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=fKmh/F3Bgj2AZpVhPnsJa1zQ0NXKJfqRaLN1Smus9VTneVJpHDWUV/JC1JGFCJKHytq72WR+F4j/7VNixbvvRTc01mnhGlpzYOjo5M6GvSNIjoiEeLmFu5QFWTcf4wbjZIMXinzC2//10N0h8ultDFSI1+xFiITgv2wSQrL2LL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lsVUEq9O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iMROzdO0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lsVUEq9O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iMROzdO0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1BD3033E26;
	Fri,  8 Aug 2025 10:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754649614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=uoE7MZRNhqz7I2FYlGOff0yqR78rvCLebF29Nou+1ag=;
	b=lsVUEq9OoUsvwAtjzBU6UTd+VfRnyNFWgGeTzHwco5QGsgJSztXM1L9yiXuMOuZHzhcMAH
	53gr1C3L4KGJ4RKWMo5DMeoSIqz151h/gCi2KP6Yjm5qatyeJz8VF8e/ZfPgha7Zls5rJp
	VKbWRWyPN3LmH6giQA2JJra0T376fdo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754649614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=uoE7MZRNhqz7I2FYlGOff0yqR78rvCLebF29Nou+1ag=;
	b=iMROzdO0L4leCBBtcM6vshEfIIlFckDqqDCzrHFGLrP6WZ1QqMzrJgMD5zrDoDXE1HA2Iv
	hCOKWVASX0OqILCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lsVUEq9O;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=iMROzdO0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754649614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=uoE7MZRNhqz7I2FYlGOff0yqR78rvCLebF29Nou+1ag=;
	b=lsVUEq9OoUsvwAtjzBU6UTd+VfRnyNFWgGeTzHwco5QGsgJSztXM1L9yiXuMOuZHzhcMAH
	53gr1C3L4KGJ4RKWMo5DMeoSIqz151h/gCi2KP6Yjm5qatyeJz8VF8e/ZfPgha7Zls5rJp
	VKbWRWyPN3LmH6giQA2JJra0T376fdo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754649614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=uoE7MZRNhqz7I2FYlGOff0yqR78rvCLebF29Nou+1ag=;
	b=iMROzdO0L4leCBBtcM6vshEfIIlFckDqqDCzrHFGLrP6WZ1QqMzrJgMD5zrDoDXE1HA2Iv
	hCOKWVASX0OqILCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3BDF13A7E;
	Fri,  8 Aug 2025 10:40:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XsFjNg3UlWgJbAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 08 Aug 2025 10:40:13 +0000
Date: Fri, 08 Aug 2025 12:40:13 +0200
Message-ID: <87cy96yu42.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.17-rc1
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 1BD3033E26
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

Linus,

please pull sound fixes for v6.17-rc1 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.17-rc1

The topmost commit is e8e4f3c242cc26de9d69bd8b3a678d1e50980abe

----------------------------------------------------------------

sound fixes for 6.17-rc1

A few more small fixes for 6.17-rc1.

- Support for ASoC AMD ACP 7.2 with new IDs
- ASoC Intel AVS and SOF fixes
- Yet more kconfig adjustments for HD-audio codecs
- TAS2781 codec fixes
- Fixes for longstanding (rather minor) bugs in Intel LPE audio
  and USB-audio drivers

----------------------------------------------------------------

Arnd Bergmann (1):
      ASoC: SOF: Intel: hda-sdw-bpt: fix SND_SOF_SOF_HDA_SDW_BPT dependencies

Baojun Xu (1):
      ASoC: tas2781: Fix the wrong step for TLV on tas2781

Cezary Rojewski (1):
      ASoC: Intel: avs: Fix uninitialized pointer error in probe()

Muhammad Usama Anjum (1):
      ASoC: SOF: amd: acp-loader: Use GFP_KERNEL for DMA allocations in resume context

Peter Jakubek (1):
      ASoC: Intel: sof_sdw: Add quirk for Alienware Area 51 (2025) 0CCC SKU

Sean Anderson (1):
      ALSA: usb-audio: Don't use printk_ratelimit for debug prints

Shenghao Ding (1):
      ALSA: hda/tas2781: Support L"SmartAmpCalibrationData" to save calibrated data

Shengjiu Wang (1):
      ASoC: wm8962: Clear master mode when enter runtime suspend

Takashi Iwai (4):
      ALSA: hda/ca0132: Fix missing error handling in ca0132_alt_select_out()
      ALSA: hda/realtek: Restrict prompt only for CONFIG_EXPERT
      ALSA: hda/hdmi: Restrict prompt only for CONFIG_EXPERT
      ALSA: hda/cirrus: Restrict prompt only for CONFIG_EXPERT

Thomas Croft (1):
      ALSA: hda/realtek: add LG gram 16Z90R-A to alc269 fixup table

Thorsten Blum (1):
      ALSA: intel_hdmi: Fix off-by-one error in __hdmi_lpe_audio_probe()

Venkata Prasad Potturu (4):
      ASoC: SOF: amd: Add sof audio support for acp7.2 platform
      ASoC: amd: ps: Add SoundWire pci and dma driver support for acp7.2 platform
      ASoC: amd: acp: Add SoundWire legacy machine driver support for acp7.2 platform
      ASoC: amd: acp: Add SoundWire SOF machine driver support for acp7.2 platform

---
 include/sound/tas2781-tlv.h                |  2 +-
 sound/hda/codecs/ca0132.c                  |  5 +++-
 sound/hda/codecs/cirrus/Kconfig            | 20 ++++++++-----
 sound/hda/codecs/hdmi/Kconfig              | 20 ++++++++-----
 sound/hda/codecs/realtek/Kconfig           | 28 ++++++++++--------
 sound/hda/codecs/realtek/alc269.c          |  1 +
 sound/hda/codecs/side-codecs/tas2781_hda.c | 47 ++++++++++++++++++++----------
 sound/hda/codecs/side-codecs/tas2781_hda.h |  2 +-
 sound/soc/amd/acp/acp-sdw-legacy-mach.c    |  3 ++
 sound/soc/amd/acp/acp-sdw-sof-mach.c       |  1 +
 sound/soc/amd/acp/soc_amd_sdw_common.h     |  2 ++
 sound/soc/amd/ps/acp63.h                   |  1 +
 sound/soc/amd/ps/pci-ps.c                  |  4 +++
 sound/soc/amd/ps/ps-sdw-dma.c              |  5 ++++
 sound/soc/codecs/wm8962.c                  | 11 +++++++
 sound/soc/intel/avs/core.c                 |  3 +-
 sound/soc/intel/boards/sof_sdw.c           |  8 +++++
 sound/soc/sof/amd/acp-loader.c             |  6 ++--
 sound/soc/sof/amd/acp.c                    |  8 +++++
 sound/soc/sof/amd/acp.h                    |  1 +
 sound/soc/sof/amd/pci-acp70.c              |  1 +
 sound/soc/sof/intel/Kconfig                |  3 +-
 sound/usb/pcm.c                            |  9 +++---
 sound/x86/intel_hdmi_audio.c               |  2 +-
 24 files changed, 137 insertions(+), 56 deletions(-)


