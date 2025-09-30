Return-Path: <linux-kernel+bounces-837643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D08BACD1B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 344EB16B2AF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E84122A4DB;
	Tue, 30 Sep 2025 12:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="L7E1AYdg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tWah9jhT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="L7E1AYdg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tWah9jhT"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5066F256C6F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235192; cv=none; b=mgtcyU0IfH4i+ai3tiwXfrHbxIgqz4prdDo6B+ebyH7uABN69DNltZAUHSQVTaSCRv7YyybL6XmDfcZPrvcS6671SHRF1vwgMfBNCrfC+xV5gGngY3gcGyQadkL6mc9regdTNAnut2M/ixi44sJjzG7o7cIPPgxnOBd8eSz27KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235192; c=relaxed/simple;
	bh=rWpkRuIWuYH5zuJ/VAFiBXnJoQv8B9r9r1XErxssum0=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=SGM/W1JS4DN9nWqdAT5fQ2MKlSlUBN7U83bmpD0xIC4H7kZizN7Vb7l27ZMnSnpkMXLGOUAf9A78bCOVQUkom3fCjq0nnNP2mCeLuVm6udoU3sAnyBsLZxvPMLveJP2+d17WfBDp+PTC1f8DbK6n5ANBBKkOQMg6iE+jC6BFwAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=L7E1AYdg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tWah9jhT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=L7E1AYdg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tWah9jhT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 00C8D3369D;
	Tue, 30 Sep 2025 12:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759235185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=77dfF39BZGibg+HNCZudKSzZo9JQwY7b2tt+e49NK5o=;
	b=L7E1AYdgg72Ghxc/YXDz0QoL4EQ2Mv7oUgfgRC0ZvW6wytG+tzhiPmjnqKmEnfQ0ISn0XR
	6GzYJvRfIim8YN5ItKKPZn4OF09HRgf6wh/uVvcV46GuJgN4BEepu4PZ+ncdrVQJfeuE/n
	PsWcrxzSYDtJBRcAcAoYNK+txAu3vtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759235185;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=77dfF39BZGibg+HNCZudKSzZo9JQwY7b2tt+e49NK5o=;
	b=tWah9jhTK07AxyHo+Jir22aboCSKAynIDk7gcl2PUos8rRo9F9KuleFochSmT/nqZ67Jlo
	ZSMjftAUsQttofCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=L7E1AYdg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tWah9jhT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759235185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=77dfF39BZGibg+HNCZudKSzZo9JQwY7b2tt+e49NK5o=;
	b=L7E1AYdgg72Ghxc/YXDz0QoL4EQ2Mv7oUgfgRC0ZvW6wytG+tzhiPmjnqKmEnfQ0ISn0XR
	6GzYJvRfIim8YN5ItKKPZn4OF09HRgf6wh/uVvcV46GuJgN4BEepu4PZ+ncdrVQJfeuE/n
	PsWcrxzSYDtJBRcAcAoYNK+txAu3vtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759235185;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=77dfF39BZGibg+HNCZudKSzZo9JQwY7b2tt+e49NK5o=;
	b=tWah9jhTK07AxyHo+Jir22aboCSKAynIDk7gcl2PUos8rRo9F9KuleFochSmT/nqZ67Jlo
	ZSMjftAUsQttofCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8FC713A3F;
	Tue, 30 Sep 2025 12:26:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QlltNG/M22g+MAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 30 Sep 2025 12:26:23 +0000
Date: Tue, 30 Sep 2025 14:26:23 +0200
Message-ID: <874iskktxs.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound updates for 6.18-rc1
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 00C8D3369D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

Linus,

please pull sound updates for v6.18-rc1 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.18-rc1

The topmost commit is f65dc3b1ab145c9b8b36301256d703c1dd153f71

----------------------------------------------------------------

sound updates for 6.18-rc1

It's been relatively calm in this cycle from the feature POV, but
there were lots of cleanup works in the wide-range of code for
converting with the auto-cleanup macros like guard().
The mostly user-visible changes are the support of a couple of new
compress-offload API extensions, and the support of new ASoC codec /
platform drivers as well as USB-audio quirks.

Here we go with some highlights:

Core:
 - Compress-offload API extension for 64bit timestamp support
 - Compress-offload API extension for OPUS codec support
 - Workaround for PCM locking issue with PREEMPT_RT and softirq
 - KCSAN warning fix for ALSA sequencer core

ASoC:
 - Continued cleanup works for ASoC core APIs
 - Lots of cleanups and conversions of DT bindings
 - Substantial maintainance work on the Intel AVS drivers
 - Support for Qualcomm Glymur and PM4125, Realtek RT1321, Shanghai
   FourSemi FS2104/5S, Texas Instruments PCM1754 and TAS2783A
 - Remove support for TI WL1273 for old Nokia systems

USB-audio:
 - Support for Tascam US-144mkII, Presonus S1824c support
 - More flexible quirk option handling
 - Fix for USB MIDI timer bug triggered by fuzzer

Others:
 - A large series of cleanups with guard() & co macros over (non-ASoC)
   sound drivers (PCI, ISA, HD-audio, USB-audio, drivers, etc)
 - TAS5825 HD-audio side-codec support

----------------------------------------------------------------

Alex Tran (3):
      ASoC: codecs: tlv320dac33: Remove unused struct tlv320dac33_platform_data and header file tlv320dac33-plat.h
      ASoC: codecs: tlv320dac33: Add default value for burst_bclkdiv
      ASoC: codecs: tlv320dac33: Convert to use gpiod api

Alexey Klimov (7):
      ASoC: codecs: add new pm4125 audio codec driver
      MAINTAINERS: add Qualcomm PM4125 audio codec to drivers list
      ASoC: dt-bindings: add bindings for pm4125 audio codec
      ASoC: qcom: sc8280xp: explicitly set S16LE format in sc8280xp_be_hw_params_fixup()
      ALSA: compress: add raw opus codec define and opus decoder structs
      ALSA: compress_offload: increase SNDRV_COMPRESS_VERSION minor version by 1
      ASoC: qcom: qdsp6/audioreach: add support for offloading raw opus playback

Alvin ©ipraga (1):
      ASoC: codecs: pcm1754: add pcm1754 dac driver

Andy Shevchenko (1):
      ASoC: amd: acp: Remove (explicitly) unused header

Arnd Bergmann (2):
      ASoC: add GPIOLIB_LEGACY dependency where needed
      ASoC: pxa: add GPIOLIB_LEGACY dependency

Bagas Sanjaya (1):
      ASoC: doc: Internally link to Writing an ALSA Driver docs

Baojun Xu (4):
      ALSA: hda: Add TAS5825 support
      ASoC: tas2781: Add tas2118, tas2x20, tas5825 support
      ASoC: tas2781: Add tas2118, tas2x20, tas5825 support
      ASoC: tas2781: Correct the wrong description and register address on tas2781

Bard Liao (3):
      ASoC: SOF: Intel: split codec mask detect and programming UNSOL
      ASoC: SOF: Intel: only detect codecs when HDA DSP probe
      ASoC: Intel: hda-sdw-bpt: set persistent_buffer false

Cezary Rojewski (28):
      ASoC: Intel: avs: Parse conditional path tuples
      ASoC: Intel: avs: Conditional-path support
      ASoC: Intel: avs: Separate debug symbols
      ASoC: Intel: avs: Drop pcm.h dependency for probes
      ASoC: Intel: avs: Do not share the name pointer between components
      ASoC: Intel: avs: Streamline register-component function names
      ASoC: Intel: avs: New board registration routines
      ASoC: Intel: avs: Cleanup duplicate members
      ASoC: Intel: avs: Simplify dmi_match_quirk()
      ASoC: Intel: avs: Simplify avs_get_i2s_boards()
      ASoC: Intel: avs: Allow i2s test and non-test boards to coexist
      ASoC: Intel: avs: hda: Adjust platform name
      ASoC: Intel: avs: da7219: Adjust platform name
      ASoC: Intel: avs: dmic: Refactor dai_link creation
      ASoC: Intel: avs: es8336: Adjust platform name
      ASoC: Intel: avs: i2stest: Adjust platform name
      ASoC: Intel: avs: max98357a: Adjust platform name
      ASoC: Intel: avs: max98373: Adjust platform name
      ASoC: Intel: avs: max98927: Adjust platform name
      ASoC: Intel: avs: nau8825: Adjust platform name
      ASoC: Intel: avs: probe: Refactor dai_link creation
      ASoC: Intel: avs: rt274: Adjust platform name
      ASoC: Intel: avs: rt286: Adjust platform name
      ASoC: Intel: avs: rt298: Adjust platform name
      ASoC: Intel: avs: rt5514: Adjust platform name
      ASoC: Intel: avs: rt5663: Adjust platform name
      ASoC: Intel: avs: rt5682: Adjust platform name
      ASoC: Intel: avs: ssm4567: Adjust platform name

Chancel Liu (1):
      ASoC: dmaengine_pcm: Add port_window_size to DAI dma data struct

Chandra Mohan Sundar (1):
      ALSA: cs4281: Send the PCM period elapsed notification properly

Charles Han (1):
      ASoC: codecs: fs210x: Add NULL check in fs210x_register_snd_component

Charles Keepax (4):
      ASoC: cs42l43: Rename system suspend callback and fix debug print
      ASoC: cs42l43: Store IRQ domain in codec private data
      ASoC: cs42l43: Disable IRQs in system suspend
      ASoC: cs42l43: Shutdown jack detection on suspend

Chen Ni (1):
      ASoc: tas2783A: Remove unneeded semicolon

Chen-Yu Tsai (1):
      ASoC: mediatek: common: Switch to for_each_available_child_of_node_scoped()

Christophe Leroy (4):
      soc: fsl: qmc: Only set completion interrupt when needed
      ASoC: fsl: fsl_qmc_audio: Ensure audio channels are ordered in TDM bus
      ASoC: fsl: fsl_qmc_audio: Only request completion on last channel
      ASoC: fsl: fsl_qmc_audio: Drop struct qmc_dai_chan

Colin Ian King (3):
      ALSA: hda: Fix spelling mistake "dismatch" -> "mismatch"
      ASoC: SOF: ipc4-topology: Fix a less than zero check on a u32
      ASoc: tas2783A: Fix spelling mistake "Perifpheral" -> "Peripheral"

Cryolitia PukNgae (8):
      ALSA: usb-audio: rename QUIRK_FLAG_MIXER_MIN_MUTE to QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE
      ALSA: usb-audio: add quirk QUIRK_FLAG_MIXER_CAPTURE_MIN_MUTE
      ALSA: usb-audio: apply "mixer_min_mute" quirks on some devices
      ALSA: usb-audio: apply quirk for MOONDROP Quark2
      ALSA: usb-audio: add two-way convert between name and bit for QUIRK_FLAG_*
      ALSA: usb-audio: improve module param quirk_flags
      ALSA: usb-audio: make param quirk_flags change-able in runtime
      ALSA: doc: improved docs about quirk_flags in snd-usb-audio

Dan Carpenter (3):
      ALSA: rme32: Fix serialization in snd_rme32_capture_adat_open()
      ASoC: codecs: wcd-common: fix signedness bug in wcd_dt_parse_micbias_info()
      ASoc: tas2783A: Fix an error code in probe()

Dmitry Baryshkov (2):
      regulator: dt-bindings: qcom,sdm845-refgen-regulator: document more platforms
      ASoC: qcom: sc8280xp: use sa8775p/ subdir for QCS9100 / QCS9075

Dr. David Alan Gilbert (1):
      ASoC: wl1273: Remove

Geert Uytterhoeven (1):
      ASoC: da7213: Convert to DEFINE_RUNTIME_DEV_PM_OPS()

Geoffrey D. Bennett (1):
      ALSA: scarlett2: Add Vocaster speaker/headphone mute controls

Jeongjun Park (1):
      ALSA: usb-audio: fix race condition to UAF in snd_usbmidi_free

Jihed Chaibi (6):
      ASoC: dt-bindings: ti,twl4030-audio: convert to DT schema
      ASoC: dt-bindings: omap-twl4030: convert to DT schema
      ASoC: dt-bindings: everest,es8316: Document routing strings
      ASoC: dt-bindings: nuvoton,nau8825: Document routing strings
      ASoC: dt-bindings: wlf,wm8960: Document routing strings (pin names)
      ALSA: asihpi: Simplify error handling in PCM substream setup

John Keeping (1):
      ALSA: serial-generic: remove shared static buffer

Jonas Rebmann (1):
      ASoC: dt-bindings: asahi-kasei,ak4458: Reference common DAI properties

Joris Verhaegen (3):
      ALSA: compress_offload: Add 64-bit safe timestamp infrastructure
      ALSA: compress_offload: Add SNDRV_COMPRESS_TSTAMP64 ioctl
      ALSA: compress_offload: Add SNDRV_COMPRESS_AVAIL64 ioctl

Julien Massot (3):
      ASoC: dt-binding: Convert mt8183-afe-pcm to dt-schema
      ASoC: Convert MT8183 DA7219 sound card to DT schema
      ASoC: dt-binding: Convert MediaTek mt8183-mt6358 to DT schema

Jyri Sarha (6):
      ASoC: SOF: sof-client-probes-ipc4: Implement ipc4_probes_points_info
      ASoC: SOF: IPC4: Add GET macros for module id and module instance id
      ASoC: SOF: sof-client: Add sof_client_ipc4_find_swidget_by_id()
      ASoC: SOF: sof-client-probes-ipc4: Human readable debugfs "probe_points"
      ASoC: SOF: sof-client-probes: Add available points_info(), IPC4 only
      ASoC: sof: ipc4-topology: Add support to sched_domain attribute

Kriish Sharma (1):
      ALSA: compress: document 'chan_map' member in snd_dec_opus

Krzysztof Kozlowski (1):
      ASoC: dt-bindings: Minor whitespace cleanup in example

Kuninori Morimoto (35):
      ASoC: soc-dapm: move snd_soc_dapm_get_bias_level() to soc-dpcm
      ASoC: soc-dapm: move snd_soc_dapm_init_bias_level() to soc-dpcm
      ASoC: soc-component: unpack snd_soc_component_force_bias_level()
      ASoC: soc-component: unpack snd_soc_component_get_bias_level()
      ASoC: soc-component: unpack snd_soc_component_init_bias_level()
      ASoC: renesas: msiof: msiof_update_and_wait() checks whether reg was updated
      ASoC: renesas: msiof: tidyup error message
      ASoC: renesas: msiof: cleanup status clear method
      ASoC: renesas: msiof: start DMAC first
      ASoC: soc-dapm: rename snd_soc_dapm_kcontrol_widget() to snd_soc_dapm_kcontrol_to_widget()
      ASoC: soc-dapm: rename snd_soc_dapm_kcontrol_dapm() to snd_soc_dapm_kcontrol_to_dapm()
      ASoC: soc-dapm: rename dapm_kcontrol_get_value() to snd_soc_dapm_kcontrol_get_value()
      ASoC: soc-dapm: rename snd_soc_kcontrol_component() to snd_soc_kcontrol_to_component()
      ASoC: renesas: msiof: Use guard() for spin locks
      ASoC: renesas: rsnd: Use guard() for spin locks
      ASoC: renesas: fsi: Use guard() for spin locks
      ASoC: renesas: rz-ssi: Use guard() for spin locks
      ASoC: soc-dapm: add snd_soc_dapm_to_dev()
      ASoC: soc-dapm: add snd_soc_dapm_to_card()
      ASoC: soc-dapm: use dapm->component instead of container_of()
      ASoC: soc-component: add snd_soc_component_to_dapm()
      ASoC: soc-card: add snd_soc_card_to_dapm()
      ASoC: soc-dapm: remove suspend_bias_off from snd_soc_dapm_context
      ASoC: soc-dapm: tidyup idle_bias handling - step1
      ASoC: soc-dapm: tidyup idle_bias handling - step2
      ASoC: soc-dapm: add snd_soc_dapm_get_bias_level()
      ASoC: soc-dapm: add snd_soc_dapm_set_idle_bias()
      ASoC: renesas: msiof: add unique NOTE name
      ASoC: renesas: msiof: use reset controller
      ASoC: renesas: msiof: set SIFCTR register
      ASoC: renesas: msiof: add .symmetric_xxx on snd_soc_dai_driver
      ASoC: renesas: msiof: tidyup DMAC stop timing
      ASoC: renesas: msiof: setup both (Playback/Capture) in the same time
      ASoC: renesas: msiof: Add note for The possibility of R/L opposite Capture
      ASoC: renesas: msiof: ignore 1st FSERR

Liao Yuanhong (1):
      ASoC: Intel: sst: Remove redundant semicolons

Ma Ke (1):
      ASoC: wcd934x: fix error handling in wcd934x_codec_parse_data()

Mahdi Khosravi (1):
      ASoC: dt-bindings: realtek,alc5623: convert to DT schema

Marco Crivellari (1):
      ASoC: replace use of system_unbound_wq with system_dfl_wq

Matthias Schiffer (1):
      ASoC: tlv320aic32x4: use dev_err_probe() for regulators

Mohammad Rafi Shaik (3):
      ASoC: dt-bindings: qcom,wsa8830: Add reset-gpios for shared line
      ASoC: codecs: wsa883x: Handle shared reset GPIO for WSA883x speakers
      ASoC: dt-bindings: qcom,lpass-va-macro: Update bindings for clocks to support ADSP

Nick Li (5):
      dt-bindings: vendor-prefixes: Add Shanghai FourSemi Semiconductor Co.,Ltd
      ASoC: dt-bindings: Add FS2104/5S audio amplifiers
      ASoC: codecs: Add library for FourSemi audio amplifiers
      ASoC: codecs: Add FourSemi FS2104/5S audio amplifier driver
      MAINTAINERS: Add entry for FourSemi audio amplifiers

Nikola Z. Ivanov (1):
      selftests/alsa: remove 0/NULL global variable assignment

Niranjan H Y (5):
      ASoC: ops: improve snd_soc_get_volsw
      ASoc: tas2783A: Add soundwire based codec driver
      ASoc: tas2783A: machine driver amp utility for TI devices
      ASoc: tas2783A: add machine driver changes
      tas2783A: Add acpi match changes for Intel MTL

Olivier Moysan (1):
      ASoC: stm32: sai: manage context in set_sysclk callback

Peter Ujfalusi (3):
      ASoC: SOF: ipc4-pcm: Add fixup for channels
      ASoC: SOF: sof-client: Convert sof_client_dev_to_sof_dev into function
      ASoC: SOF: sof-client: Introduce sof_client_dev_entry structure

Primoz Fiser (1):
      ASoC: tlv320aic3x: Fix class-D initialization for tlv320aic3007

Qianfeng Rong (7):
      ASoC: codecs: Use kcalloc() instead of kzalloc()
      ASoC: fsl: Use kcalloc() instead of kzalloc()
      ASoC: test-component: Use kcalloc() instead of kzalloc()
      ALSA: lx_core: use int type to store negative error codes
      ASoC: amd: use int type to store negative error codes
      ASoC: adau1977: use int type to store negative error codes
      ASoC: qcom: use int type to store negative error codes

Richard Fitzgerald (10):
      ASoC: cs-amp-lib: Rename defines for Cirrus Logic EFI
      ASoC: cs-amp-lib: Add handling for Lenovo and HP UEFI speaker ID
      ASoC: cs35l56: Check for vendor-specific speaker ID value
      ASoC: cs-amp-lib-test: Add tests for cs_amp_get_vendor_spkid()
      ASoC: cs-amp-lib: Add HP-specific EFI variable for calibration data
      ASoC: cs-amp-lib-test: Add test for getting cal data from HP EFI
      ASoC: SOF: ipc4-pcm: Fix incorrect comparison with number of tdm_slots
      ASoC: Intel: sof_sdw: Prevent jump to NULL add_sidecar callback
      ASoC: cs35l56: Set fw_regs table after getting REVID
      ASoC: cs35l56: Add support for CS35L56 B2 silicon

Rob Herring (Arm) (3):
      ASoC: dt-bindings: Drop imx-audio-sgtl5000.txt
      ASoC: dt-bindings: Convert brcm,bcm2835-i2s to DT schema
      ASoC: dt-bindings: linux,spdif: Add "port" node

Roy Vegard Ovesen (4):
      ALSA: usb-audio: don't apply interface quirk to Presonus S1824c
      ALSA: usb-audio: add mono main switch to Presonus S1824c
      ALSA: usb-audio: add the initial mix for Presonus Studio 1824c
      ALSA: usb-audio: don't hardcode gain for output channel of Presonus Studio

Samasth Norway Ananda (1):
      ASoC: SOF: ipc3-dtrace: fix potential integer overflow in allocation

Sebastian Andrzej Siewior (1):
      ALSA: pcm: Disable bottom softirqs as part of spin_lock_irq() on PREEMPT_RT

Seppo Ingalsuo (2):
      ASoC: SOF: ipc4-topology: Add support for 8-bit formats
      ASoC: SOF: ipc4-topology: Add support for float sample type

Shenghao Ding (1):
      ASoC: tas2781: Add keyword "init" in profile section

Shengjiu Wang (1):
      ASoC: imx-hdmi: remove cpu_pdev related code

Shimrra Shai (4):
      ASoC: es8323: enable DAPM power widgets for playback DAC and output
      ASoC: es8323: remove DAC enablement write from es8323_probe
      ASoC: es8323: add proper left/right mixer controls via DAPM
      ASoC: es8323: enable DAPM power widgets for playback DAC

Shuming Fan (2):
      ASoC: rt721: add some vendor registers
      ASoC: rt1321: Add RT1321 amplifier support

Srinivas Kandagatla (28):
      ASoC: qcom: audioreach: deprecate AR_TKN_U32_MODULE_[IN/OUT]_PORTS
      ASoC: qcom: audioreach: add documentation for i2s interface type
      ASoC: qcom: audioreach: add support for static calibration
      ASoC: qcom: audioreach: fix typos in I2S_INTF_TYPE
      ASoC: qcom: audioreach: sort modules based on hex ids
      ASoC: qcom: audioreach: add support for SMECNS module
      ASoC: qcom: audioreach: fix potential null pointer dereference
      ASoC: qcom: topology: convert to cpu endainess type before accessing
      ASoC: qcom: audioreach: convert to cpu endainess type before accessing
      ASoC: qcom: x1e80100: set card driver name from match data
      ASoC: dt-bindings: qcom,sm8250: Add glymur sound card
      ASoC: qcom: x1e80100: add compatible for glymur SoC
      ASoC: dt-bindings: qcom: Add Glymur LPASS wsa and va macro codecs
      ASoC: codecs: lpass-macro: add Codec version 2.9
      ASoC: codecs: lpass-wsa-macro: add Codev version 2.9
      ASoC: codecs: wcd937x: set the comp soundwire port correctly
      ASoC: codecs: wcd937x: make stub functions inline
      soundwire: bus: add of_sdw_find_device_by_node helper
      soundwire: bus: add sdw_slave_get_current_bank helper
      ASoC: codecs: wcdxxxx: use of_sdw_find_device_by_node helper
      ASoC: codecs: wcdxxxx: use sdw_slave_get_current_bank helper
      ASoC: codecs: wcd: add common helper for wcd codecs
      ASoC: codecs: wcd-common: move WCD_SDW_CH to common
      ASoC: codecs: wcd-common: move component ops to common
      ASoC: codecs: wcd939x: get regmap directly
      ASoC: codecs: wcd-common: move status_update callback to common
      ASoC: codecs: wcd938x: get regmap directly
      ASoC: codecs: wcd937x: get regmap directly

Stefan Binding (2):
      ASoC: dt-bindings: cirrus,cs35l41: Document the cirrus,subsystem-id property
      ASoC: cs35l41: Fallback to reading Subsystem ID property if not ACPI

Stefan Kerkmann (1):
      ASoC: dt-bindings: ti,pcm1754: add binding documentation

Takashi Iwai (202):
      ALSA: usb: scarlett2: Clean ups with guard() and __free()
      ALSA: 6fire: Clean ups with guard()
      ALSA: usb-audio: Replace manual mutex/spinlock with guard()
      ALSA: usb-audio: Use auto-cleanup for shutdown locks
      ALSA: usb-audio: Add validation of UAC2/UAC3 effect units
      ALSA: pcm: oss: Use guard() for spin locks
      ALSA: hda: Introduce auto cleanup macros for PM
      ALSA: hda/ca0132: Use cleanup macros for PM controls
      ALSA: hda/hdmi: Use cleanup macros for PM controls
      ALSA: hda/realtek: Use cleanup macros for PM controls
      ALSA: hda/common: Use cleanup macros for PM controls
      ALSA: hda: Use auto cleanup macros for DSP loader locks
      ALSA: hda/common: Use guard() for mutex locks
      ALSA: hda/core: Use guard() for mutex locks
      ALSA: hda/ca0132: Use guard() for mutex locks
      ALSA: hda/hdmi: Use guard() for mutex locks
      ALSA: hda/realtek: Use guard() for mutex locks and COEF locks
      ALSA: hda/cs35l41: Use guard() for mutex locks
      ALSA: hda/tas2781: Use guard() for mutex locks
      ALSA: hda/cs8409: Use guard() for mutex locks
      ALSA: hda/component: Use guard() for mutex locks
      ALSA: hda/generic: Use guard() for mutex locks
      ALSA: hda/analog: Use guard() for mutex locks
      ALSA: hda/intel: Use guard() for mutex locks
      ALSA: hda/common: Use auto cleanup for temporary buffers
      ALSA: hda/realtek: Use auto cleanup for temporary buffers
      ALSA: hda/generic: Use auto cleanup for temporary buffers
      ALSA: hda/ext: Use guard() for spinlocks
      ALSA: hda/core: Use guard() for spinlocks
      ALSA: hda/common: Use guard() for spinlocks
      ALSA: hda/intel: Use guard() for spinlocks
      ALSA: seq: Simplify internal command operation from OSS layer
      ALSA: seq: Clean up spin lock with guard()
      ALSA: seq: Use guard() for mutex and rwsem locks
      ALSA: seq: Use auto-cleanup for client refcounting
      ALSA: seq: Clean up port locking with auto cleanup
      ALSA: seq: Clean up queue locking with auto cleanup
      ALSA: seq: Clean up fifo locking with guard
      ALSA: seq: oss: Clean up core code with guard()
      ALSA: seq: oss/midi: Cleanup with guard and auto-cleanup
      ALSA: seq: oss/synth: Clean up with guard and auto cleanup
      ALSA: seq: oss/rw: Cleanup with guard
      ALSA: firewire: bebob: Use guard() for mutex locks
      ALSA: firewire: dice: Use guard() for mutex locks
      ALSA: firewire: digi00x: Use guard() for mutex locks
      ALSA: firewire: fireworks: Use guard() for mutex locks
      ALSA: firewire: motu: Use guard() for mutex locks
      ALSA: firewire: oxfw: Use guard() for mutex locks
      ALSA: firewire: tascam: Use guard() for mutex locks
      ALSA: firewire: fireface: Use guard() for mutex locks
      ALSA: firewire: isight: Use guard() for mutex locks
      ALSA: firewire: lib: Use guard() for mutex locks
      ALSA: firewire: bebob: Use guard() for spin locks
      ALSA: firewire: dice: Use guard() for spin locks
      ALSA: firewire: digi00x: Use guard() for spin locks
      ALSA: firewire: fireface: Use guard() for spin locks
      ALSA: firewire: fireworks: Use guard() for spin locks
      ALSA: firewire: oxfw: Use guard() for spin locks
      ALSA: firewire: tascam: Use guard() for spin locks
      ALSA: firewire: lib: Use guard() for spin locks
      ALSA: firewire: motu: Use guard() for spin locks
      ALSA: ac97: Use guard() for mutex locks
      ALSA: ac97: Use guard() for spin locks
      ALSA: ali5451: Use guard() for spin locks
      ALSA: azt3328: Use guard() for spin locks
      ALSA: ens137x: Use guard() for mutex locks
      ALSA: ens137x: Use guard() for spin locks
      ALSA: als300: Use guard() for spin locks
      ALSA: als4000: Use guard() for spin locks
      ALSA: ad1889: Use guard() for spin locks
      ALSA: atiixp: Use guard() for mutex locks
      ALSA: atiixp: Use guard() for spin locks
      ALSA: aw2: Use guard() for mutex locks
      ALSA: aw2: Use guard() for spin locks
      ALSA: bt87x: Use guard() for spin locks
      ALSA: ca0106: Use guard() for spin locks
      ALSA: cmipci: Use guard() for mutex locks
      ALSA: cmipci: Use guard() for spin locks
      ALSA: cs4281: Use guard() for spin locks
      ALSA: cs46xx: Use guard() for mutex locks
      ALSA: cs46xx: Use guard() for spin locks
      ALSA: cs5535audio: Use guard() for spin locks
      ALSA: ctxfi: Use guard() for mutex locks
      ALSA: ctxfi: Use guard() for spin locks
      ALSA: echoaudio: Use guard() for mutex locks
      ALSA: echoaudio: Use guard() for spin locks
      ALSA: emu10k1: Use guard() for mutex locks
      ALSA: emu10k1: Use guard() for emu1010 FPGA locking
      ALSA: emu10k1: Use guard() for spin locks
      ALSA: emu10k1x: Use guard() for spin locks
      ALSA: es1938: Use guard() for spin locks
      ALSA: es1968: Use guard() for mutex locks
      ALSA: es1968: Use guard() for spin locks
      ALSA: fm801: Use guard() for spin locks
      ALSA: ice1712: Use guard() for mutex locks
      ALSA: ice1712: Use guard() for spin locks
      ALSA: intel8x0: Use guard() for spin locks
      ALSA: korg1212: Use guard() for mutex locks
      ALSA: korg1212: Use guard() for spin locks
      ALSA: lola: Use guard() for mutex locks
      ALSA: lola: Use guard() for spin locks
      ALSA: lx6464es: Use guard() for mutex locks
      ALSA: maestro3: Use guard() for spin locks
      ALSA: mixart: Use guard() for mutex locks
      ALSA: nm256: Use guard() for mutex locks
      ALSA: nm256: Use guard() for spin locks
      ALSA: oxygen: Use guard() for mutex locks
      ALSA: oxygen: Use guard() for spin locks
      ALSA: pcxhr: Use guard() for mutex locks
      ALSA: rme32: Use guard() for spin locks
      ALSA: rme96: Use guard() for spin locks
      ALSA: hdsp: Use guard() for spin locks
      ALSA: hdspm: Use guard() for spin locks
      ALSA: rme9652: Use guard() for spin locks
      ALSA: sis7019: Use guard() for mutex locks
      ALSA: sis7019: Use guard() for spin locks
      ALSA: sonicvibes: Use guard() for spin locks
      ALSA: trident: Use guard() for mutex locks
      ALSA: trident: Use guard() for spin locks
      ALSA: via82xx: Use guard() for spin locks
      ALSA: vx222: Use guard() for mutex locks
      ALSA: ymfpci: Use guard() for spin locks
      ALSA: ad1816a: Use guard() for spin locks
      ALSA: cmi8330: Use guard() for spin locks
      ALSA: cs423x: Use guard() for mutex locks
      ALSA: cs423x: Use guard() for spin locks
      ALSA: es1688: Use guard() for spin locks
      ALSA: es18xx: Use guard() for spin locks
      ALSA: gus: Use guard() for mutex locks
      ALSA: gus: Use guard() for spin locks
      ALSA: msnd: Use guard() for spin locks
      ALSA: opl3sa2: Use guard() for spin locks
      ALSA: opti9xx: Use guard() for spin locks
      ALSA: sb: Use guard() for mutex locks
      ALSA: sb: Use guard() for spin locks
      ALSA: emu8000: Use guard() for spin locks
      ALSA: sscape: Use guard() for spin locks
      ALSA: wss: Use guard() for mutex locks
      ALSA: wss: Use guard() for spin locks
      ALSA: wavefront: Use guard() for spin locks
      ALSA: aloop: Use guard() for mutex locks
      ALSA: aloop: Use guard() for spin locks
      ALSA: opl3: Use guard() for mutex locks
      ALSA: opl3: Use guard() for spin locks
      ALSA: opl4: Use guard() for mutex locks
      ALSA: opl4: Use guard() for spin locks
      ALSA: vx: Use guard() for mutex locks
      ALSA: dummy: Use guard() for spin locks
      ALSA: mpu401: Use guard() for spin locks
      ALSA: mtpav: Use guard() for spin locks
      ALSA: mts64: Use guard() for spin locks
      ALSA: portman2x4: Use guard() for spin locks
      ALSA: serial-u16550: Use guard() for spin locks
      ALSA: ua101: Use guard() for mutex locks
      ALSA: ua101: Use guard() for spin locks
      ALSA: usx2y: Use guard() for mutex locks
      ALSA: hiface: Use guard() for mutex locks
      ALSA: hiface: Use guard() for spin locks
      ALSA: line6: Use guard() for mutex locks
      ALSA: usb: qcom: Use guard() for mutex locks
      ALSA: bcd2000: Use guard() for mutex locks
      ALSA: caiaq: Use guard() for spin locks
      ALSA: i2c: Use guard() for mutex locks
      ALSA: i2c: Use guard() for spin locks
      ALSA: synth: Use guard() for mutex locks
      ALSA: synth: Use guard() for spin locks
      ALSA: synth: Use guard() for preset locks
      ALSA: x86: Use guard() for mutex locks
      ALSA: x86: Use guard() for spin locks
      ALSA: xen: Use guard() for mutex locks
      ALSA: at73c213: Use guard() for mutex locks
      ALSA: pdaudiocf: Use guard() for mutex locks
      ALSA: vxpocket: Use guard() for mutex locks
      ALSA: sparc: Use guard() for mutex locks
      ALSA: aoa: Use guard() for mutex locks
      ALSA: aaci: Use guard() for mutex locks
      ALSA: pxa2xx: Use guard() for mutex locks
      ALSA: atmel: Use guard() for mutex locks
      ALSA: ac97bus: Use guard() for mutex locks
      ALSA: virtio: Use guard() for spin locks
      ALSA: misc: Use guard() for spin locks
      ALSA: hda/realtek: Use is_s4_resume() macro
      ASoC: Intel: bytcht_es8316: Fix invalid quirk input mapping
      ASoC: Intel: bytcr_rt5640: Fix invalid quirk input mapping
      ASoC: Intel: bytcr_rt5651: Fix invalid quirk input mapping
      ALSA: aoa: Use guard() for spin locks
      ALSA: aoa: Don't split string across lines
      ALSA: arm: Use guard() for spin locks
      ALSA: sgio2audio: Use guard() for spin locks
      ALSA: snd-n64: Use guard() for spin locks
      ALSA: parisc: Use guard() for spin locks
      ALSA: snd_ps3: Use guard() for spin locks
      ALSA: ppc: Use guard() for spin locks
      ALSA: line6: Use guard() for spin locks
      ALSA: usb: fcp: Use guard() for spin locks
      ALSA: usb-audio: Use guard() for spin locks
      ALSA: sparc/amd7930: Use guard() for spin locks
      ALSA: sparc/cs4231: Use guard() for spin locks
      ALSA: sparc/dbri: Use guard() for spin locks
      ALSA: spi/at73c213: Use guard() for spin locks
      ALSA: seq: Fix KCSAN data-race warning at snd_seq_fifo_poll_wait()
      ALSA: hda/realtek: Add quirk for HP Spectre 14t-ea100

Terry Cheong (1):
      ASoC: mediatek: Use SND_JACK_AVOUT for HDMI/DP jacks

Thorsten Blum (5):
      ALSA: hda: Improve local variable data type in snd_hda_get_num_devices()
      ALSA: hda: Use min() to simplify snd_hda_get_devices()
      ALSA: hda: Improve local variable data type in print_device_list()
      ALSA: hda/conexant: Fix typos in comments
      ALSA: aoa: Remove redundant size arguments from strscpy()

Waqar Hameed (1):
      ASoC: SOF: imx: Remove error print for devm_add_action_or_reset()

Wolfram Sang (1):
      ASoC: remove unneeded 'fast_io' parameter in regmap_config

Xichao Zhao (3):
      ASoC: cs48l32: Use PTR_ERR_OR_ZERO() to simplify code
      ASoC: fix "dependant"->"dependent"
      ASoC: SOF: imx: Remove the use of dev_err_probe()

©erif Rami (10):
      ALSA: usb-audio: Add initial driver for TASCAM US-144MKII
      ALSA: usb-audio: us144mkii: Add PCM core infrastructure
      ALSA: usb-audio: us144mkii: Implement audio playback and feedback
      ALSA: usb-audio: us144mkii: Implement audio capture and decoding
      ALSA: usb-audio: us144mkii: Add MIDI support and mixer controls
      ALSA: usb-audio: us144mkii: Add deep sleep command
      ALSA: usb-audio: Add infrastructure for TASCAM US-144MKII
      ALSA: usb-audio: us144mkii: Use le16_to_cpu() for product ID comparison
      ALSA: usb-audio: us144mkii: Fix null-deref in tascam_midi_in_urb_complete()
      ALSA: usb-audio: us144mkii: Fixes for handshake, MIDI out and cleanup

---
 .../devicetree/bindings/mfd/twl4030-audio.txt      |   46 -
 .../regulator/qcom,sdm845-refgen-regulator.yaml    |    3 +
 .../devicetree/bindings/sound/alc5623.txt          |   25 -
 .../bindings/sound/asahi-kasei,ak4458.yaml         |    4 +
 .../devicetree/bindings/sound/brcm,bcm2835-i2s.txt |   24 -
 .../bindings/sound/brcm,bcm2835-i2s.yaml           |   51 +
 .../devicetree/bindings/sound/cirrus,cs35l41.yaml  |    6 +
 .../devicetree/bindings/sound/everest,es8316.yaml  |   16 +
 .../bindings/sound/foursemi,fs2105s.yaml           |  101 ++
 .../devicetree/bindings/sound/fsl,easrc.yaml       |    2 +-
 .../devicetree/bindings/sound/fsl,imx-asrc.yaml    |    2 +-
 .../bindings/sound/imx-audio-sgtl5000.txt          |   56 -
 .../devicetree/bindings/sound/linux,spdif.yaml     |    3 +
 .../bindings/sound/mediatek,mt8183-audio.yaml      |  228 +++
 .../bindings/sound/mediatek,mt8183_da7219.yaml     |   49 +
 .../sound/mediatek,mt8183_mt6358_ts3a227.yaml      |   59 +
 .../devicetree/bindings/sound/mt8183-afe-pcm.txt   |   42 -
 .../bindings/sound/mt8183-da7219-max98357.txt      |   21 -
 .../sound/mt8183-mt6358-ts3a227-max98357.txt       |   25 -
 .../devicetree/bindings/sound/nuvoton,nau8825.yaml |   14 +
 .../devicetree/bindings/sound/omap-twl4030.txt     |   62 -
 .../bindings/sound/qcom,lpass-va-macro.yaml        |   24 +-
 .../bindings/sound/qcom,lpass-wsa-macro.yaml       |    1 +
 .../bindings/sound/qcom,pm4125-codec.yaml          |  134 ++
 .../devicetree/bindings/sound/qcom,pm4125-sdw.yaml |   79 +
 .../devicetree/bindings/sound/qcom,sm8250.yaml     |    1 +
 .../devicetree/bindings/sound/qcom,wsa883x.yaml    |   11 +-
 .../devicetree/bindings/sound/realtek,alc5623.yaml |   54 +
 .../devicetree/bindings/sound/ti,omap-twl4030.yaml |   98 ++
 .../devicetree/bindings/sound/ti,pcm1754.yaml      |   55 +
 .../devicetree/bindings/sound/ti,tas2781.yaml      |   96 +-
 .../bindings/sound/ti,twl4030-audio.yaml           |   90 +
 .../devicetree/bindings/sound/wlf,wm8960.yaml      |   22 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 Documentation/sound/alsa-configuration.rst         |  105 +-
 Documentation/sound/soc/codec.rst                  |    4 +-
 Documentation/sound/soc/platform.rst               |    4 +-
 MAINTAINERS                                        |   10 +
 drivers/soc/fsl/qe/qmc.c                           |   44 +-
 drivers/soundwire/bus.c                            |   12 +
 drivers/soundwire/slave.c                          |    6 +
 include/linux/soundwire/sdw.h                      |   17 +
 include/sound/compress_driver.h                    |    2 +-
 include/sound/cs-amp-lib.h                         |    1 +
 include/sound/cs35l56.h                            |    5 +-
 include/sound/dmaengine_pcm.h                      |    5 +
 include/sound/emu10k1.h                            |    3 +-
 include/sound/gus.h                                |    1 -
 include/sound/hda_codec.h                          |   34 +-
 include/sound/hdaudio.h                            |    1 +
 include/sound/soc-component.h                      |   83 +-
 include/sound/soc-dai.h                            |    7 +-
 include/sound/soc-dapm.h                           |   61 +-
 include/sound/soc.h                                |    5 +
 include/sound/soc_sdw_utils.h                      |    8 +
 include/sound/sof/ipc4/header.h                    |    4 +
 include/sound/soundfont.h                          |   18 +
 include/sound/tas2781-dsp.h                        |   11 +
 include/sound/tas2781.h                            |   14 +-
 include/sound/tas2x20-tlv.h                        |  259 +++
 include/sound/tas5825-tlv.h                        |   24 +
 include/sound/tlv320dac33-plat.h                   |   21 -
 include/uapi/sound/compress_offload.h              |   35 +-
 include/uapi/sound/compress_params.h               |   41 +-
 include/uapi/sound/intel/avs/tokens.h              |   15 +
 include/uapi/sound/snd_ar_tokens.h                 |   20 +-
 include/uapi/sound/sof/tokens.h                    |    2 +
 sound/ac97/bus.c                                   |   22 +-
 sound/aoa/codecs/onyx.c                            |  106 +-
 sound/aoa/codecs/tas.c                             |  115 +-
 sound/aoa/codecs/toonie.c                          |    2 +-
 sound/aoa/core/alsa.c                              |    8 +-
 sound/aoa/core/gpio-feature.c                      |   20 +-
 sound/aoa/core/gpio-pmf.c                          |   26 +-
 sound/aoa/fabrics/layout.c                         |    9 +-
 sound/aoa/soundbus/i2sbus/core.c                   |    4 +-
 sound/aoa/soundbus/i2sbus/pcm.c                    |  206 +--
 sound/arm/aaci.c                                   |  168 +-
 sound/arm/pxa2xx-ac97-lib.c                        |   12 +-
 sound/atmel/ac97c.c                                |   18 +-
 sound/core/compress_offload.c                      |   98 +-
 sound/core/misc.c                                  |   25 +-
 sound/core/oss/pcm_oss.c                           |    3 +-
 sound/core/pcm_dmaengine.c                         |    2 +
 sound/core/pcm_native.c                            |   21 +-
 sound/core/seq/oss/seq_oss.c                       |   24 +-
 sound/core/seq/oss/seq_oss_device.h                |    7 +-
 sound/core/seq/oss/seq_oss_midi.c                  |  116 +-
 sound/core/seq/oss/seq_oss_readq.c                 |   10 +-
 sound/core/seq/oss/seq_oss_synth.c                 |  125 +-
 sound/core/seq/oss/seq_oss_writeq.c                |    5 +-
 sound/core/seq/seq_clientmgr.c                     |  759 ++++-----
 sound/core/seq/seq_clientmgr.h                     |   17 +-
 sound/core/seq/seq_fifo.c                          |   16 +-
 sound/core/seq/seq_fifo.h                          |    1 +
 sound/core/seq/seq_ports.c                         |   19 +-
 sound/core/seq/seq_ports.h                         |    2 +
 sound/core/seq/seq_queue.c                         |   76 +-
 sound/core/seq/seq_queue.h                         |    2 +
 sound/core/seq/seq_timer.c                         |    5 +-
 sound/drivers/aloop.c                              |  276 ++-
 sound/drivers/dummy.c                              |   40 +-
 sound/drivers/mpu401/mpu401_uart.c                 |   41 +-
 sound/drivers/mtpav.c                              |   59 +-
 sound/drivers/mts64.c                              |   57 +-
 sound/drivers/opl3/opl3_lib.c                      |   26 +-
 sound/drivers/opl3/opl3_midi.c                     |   51 +-
 sound/drivers/opl3/opl3_seq.c                      |   27 +-
 sound/drivers/opl4/opl4_lib.c                      |   10 +-
 sound/drivers/opl4/opl4_mixer.c                    |    8 +-
 sound/drivers/opl4/opl4_proc.c                     |   10 +-
 sound/drivers/opl4/opl4_seq.c                      |   28 +-
 sound/drivers/opl4/opl4_synth.c                    |   81 +-
 sound/drivers/portman2x4.c                         |   12 +-
 sound/drivers/serial-generic.c                     |   12 +-
 sound/drivers/serial-u16550.c                      |   48 +-
 sound/drivers/vx/vx_core.c                         |   19 +-
 sound/drivers/vx/vx_mixer.c                        |   57 +-
 sound/drivers/vx/vx_pcm.c                          |    3 +-
 sound/drivers/vx/vx_uer.c                          |   17 +-
 sound/firewire/amdtp-stream.c                      |   28 +-
 sound/firewire/bebob/bebob.c                       |   36 +-
 sound/firewire/bebob/bebob_hwdep.c                 |   37 +-
 sound/firewire/bebob/bebob_maudio.c                |   42 +-
 sound/firewire/bebob/bebob_midi.c                  |   34 +-
 sound/firewire/bebob/bebob_pcm.c                   |   68 +-
 sound/firewire/bebob/bebob_stream.c                |   21 +-
 sound/firewire/cmp.c                               |   37 +-
 sound/firewire/dice/dice-hwdep.c                   |   37 +-
 sound/firewire/dice/dice-midi.c                    |   38 +-
 sound/firewire/dice/dice-pcm.c                     |   91 +-
 sound/firewire/dice/dice-stream.c                  |   21 +-
 sound/firewire/dice/dice-transaction.c             |    7 +-
 sound/firewire/dice/dice.c                         |    3 +-
 sound/firewire/digi00x/digi00x-hwdep.c             |   37 +-
 sound/firewire/digi00x/digi00x-midi.c              |   34 +-
 sound/firewire/digi00x/digi00x-pcm.c               |   73 +-
 sound/firewire/digi00x/digi00x-stream.c            |   21 +-
 sound/firewire/digi00x/digi00x-transaction.c       |    8 +-
 sound/firewire/digi00x/digi00x.c                   |    3 +-
 sound/firewire/fcp.c                               |   19 +-
 sound/firewire/fireface/ff-hwdep.c                 |   37 +-
 sound/firewire/fireface/ff-midi.c                  |   10 +-
 sound/firewire/fireface/ff-pcm.c                   |   92 +-
 sound/firewire/fireface/ff-stream.c                |   21 +-
 sound/firewire/fireface/ff-transaction.c           |    4 +-
 sound/firewire/fireworks/fireworks.c               |   39 +-
 sound/firewire/fireworks/fireworks_command.c       |   16 +-
 sound/firewire/fireworks/fireworks_hwdep.c         |   41 +-
 sound/firewire/fireworks/fireworks_midi.c          |   37 +-
 sound/firewire/fireworks/fireworks_pcm.c           |   65 +-
 sound/firewire/fireworks/fireworks_stream.c        |   21 +-
 sound/firewire/fireworks/fireworks_transaction.c   |   39 +-
 sound/firewire/isight.c                            |   20 +-
 sound/firewire/iso-resources.c                     |   66 +-
 .../motu/motu-command-dsp-message-parser.c         |    9 +-
 sound/firewire/motu/motu-hwdep.c                   |   37 +-
 sound/firewire/motu/motu-midi.c                    |   38 +-
 sound/firewire/motu/motu-pcm.c                     |   94 +-
 .../motu/motu-register-dsp-message-parser.c        |   18 +-
 sound/firewire/motu/motu-stream.c                  |   21 +-
 sound/firewire/motu/motu-transaction.c             |    7 +-
 sound/firewire/oxfw/oxfw-hwdep.c                   |   37 +-
 sound/firewire/oxfw/oxfw-midi.c                    |   62 +-
 sound/firewire/oxfw/oxfw-pcm.c                     |   90 +-
 sound/firewire/oxfw/oxfw-stream.c                  |   21 +-
 sound/firewire/oxfw/oxfw.c                         |    3 +-
 sound/firewire/tascam/amdtp-tascam.c               |   15 +-
 sound/firewire/tascam/tascam-hwdep.c               |   37 +-
 sound/firewire/tascam/tascam-midi.c                |   10 +-
 sound/firewire/tascam/tascam-pcm.c                 |   69 +-
 sound/firewire/tascam/tascam-stream.c              |   21 +-
 sound/firewire/tascam/tascam.c                     |    3 +-
 sound/hda/codecs/analog.c                          |    3 +-
 sound/hda/codecs/ca0132.c                          |  295 ++--
 sound/hda/codecs/cirrus/cs8409.c                   |   22 +-
 sound/hda/codecs/conexant.c                        |    4 +-
 sound/hda/codecs/generic.c                         |   76 +-
 sound/hda/codecs/hdmi/hdmi.c                       |  199 +--
 sound/hda/codecs/hdmi/nvhdmi-mcp.c                 |    3 +-
 sound/hda/codecs/realtek/alc268.c                  |    3 +-
 sound/hda/codecs/realtek/alc269.c                  |    7 +-
 sound/hda/codecs/realtek/realtek.c                 |   40 +-
 sound/hda/codecs/realtek/realtek.h                 |   21 +
 sound/hda/codecs/side-codecs/cs35l41_hda.c         |  110 +-
 sound/hda/codecs/side-codecs/cs35l56_hda.c         |    1 +
 sound/hda/codecs/side-codecs/cs35l56_hda_i2c.c     |    2 -
 sound/hda/codecs/side-codecs/cs35l56_hda_spi.c     |    2 -
 sound/hda/codecs/side-codecs/hda_component.c       |   15 +-
 sound/hda/codecs/side-codecs/hda_component.h       |    3 +-
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c     |   83 +-
 sound/hda/common/codec.c                           |  142 +-
 sound/hda/common/controller.c                      |  124 +-
 sound/hda/common/proc.c                            |   13 +-
 sound/hda/common/sysfs.c                           |  110 +-
 sound/hda/controllers/intel.c                      |   14 +-
 sound/hda/core/bus.c                               |    8 +-
 sound/hda/core/component.c                         |    6 +-
 sound/hda/core/controller.c                        |   58 +-
 sound/hda/core/device.c                            |   23 +-
 sound/hda/core/ext/controller.c                    |    6 +-
 sound/hda/core/ext/stream.c                        |   38 +-
 sound/hda/core/regmap.c                            |   35 +-
 sound/hda/core/stream.c                            |   34 +-
 sound/i2c/other/ak4113.c                           |   54 +-
 sound/i2c/other/ak4114.c                           |   39 +-
 sound/i2c/other/ak4117.c                           |   40 +-
 sound/isa/ad1816a/ad1816a_lib.c                    |  117 +-
 sound/isa/cmi8330.c                                |   15 +-
 sound/isa/cs423x/cs4236_lib.c                      |  133 +-
 sound/isa/es1688/es1688_lib.c                      |  276 ++-
 sound/isa/es18xx.c                                 |   58 +-
 sound/isa/gus/gus_dma.c                            |   88 +-
 sound/isa/gus/gus_dram.c                           |    8 +-
 sound/isa/gus/gus_io.c                             |   65 +-
 sound/isa/gus/gus_main.c                           |   65 +-
 sound/isa/gus/gus_mem.c                            |   33 +-
 sound/isa/gus/gus_mixer.c                          |   12 +-
 sound/isa/gus/gus_pcm.c                            |  177 +-
 sound/isa/gus/gus_reset.c                          |   66 +-
 sound/isa/gus/gus_timer.c                          |   16 +-
 sound/isa/gus/gus_uart.c                           |   24 +-
 sound/isa/gus/gusextreme.c                         |   21 +-
 sound/isa/gus/interwave.c                          |   33 +-
 sound/isa/msnd/msnd.c                              |   29 +-
 sound/isa/msnd/msnd_pinnacle.c                     |   11 +-
 sound/isa/msnd/msnd_pinnacle_mixer.c               |    8 +-
 sound/isa/opl3sa2.c                                |   29 +-
 sound/isa/opti9xx/miro.c                           |   17 +-
 sound/isa/opti9xx/opti92x-ad1848.c                 |   21 +-
 sound/isa/sb/emu8000.c                             |   94 +-
 sound/isa/sb/emu8000_pcm.c                         |   46 +-
 sound/isa/sb/sb16.c                                |   11 +-
 sound/isa/sb/sb16_csp.c                            |  225 ++-
 sound/isa/sb/sb16_main.c                           |  123 +-
 sound/isa/sb/sb8_main.c                            |  168 +-
 sound/isa/sb/sb8_midi.c                            |  121 +-
 sound/isa/sb/sb_common.c                           |   17 +-
 sound/isa/sb/sb_mixer.c                            |   61 +-
 sound/isa/sscape.c                                 |  184 +-
 sound/isa/wavefront/wavefront_midi.c               |  129 +-
 sound/isa/wavefront/wavefront_synth.c              |   18 +-
 sound/isa/wss/wss_lib.c                            |  285 ++--
 sound/mips/sgio2audio.c                            |   20 +-
 sound/mips/snd-n64.c                               |   17 +-
 sound/parisc/harmony.c                             |   99 +-
 sound/pci/ac97/ac97_codec.c                        |   32 +-
 sound/pci/ac97/ac97_patch.c                        |    9 +-
 sound/pci/ac97/ac97_pcm.c                          |   50 +-
 sound/pci/ac97/ac97_proc.c                         |   10 +-
 sound/pci/ad1889.c                                 |   12 +-
 sound/pci/ak4531_codec.c                           |   18 +-
 sound/pci/ali5451/ali5451.c                        |   92 +-
 sound/pci/als300.c                                 |   21 +-
 sound/pci/als4000.c                                |   68 +-
 sound/pci/asihpi/asihpi.c                          |   16 +-
 sound/pci/atiixp.c                                 |   69 +-
 sound/pci/atiixp_modem.c                           |   49 +-
 sound/pci/aw2/aw2-alsa.c                           |   26 +-
 sound/pci/azt3328.c                                |  143 +-
 sound/pci/bt87x.c                                  |   26 +-
 sound/pci/ca0106/ca0106_main.c                     |   33 +-
 sound/pci/ca0106/ca0106_proc.c                     |   28 +-
 sound/pci/ca0106/ca_midi.c                         |  169 +-
 sound/pci/cmipci.c                                 |  185 +-
 sound/pci/cs4281.c                                 |   54 +-
 sound/pci/cs46xx/cs46xx_lib.c                      |  200 +--
 sound/pci/cs46xx/dsp_spos.c                        |   70 +-
 sound/pci/cs46xx/dsp_spos_scb_lib.c                |   63 +-
 sound/pci/cs5535audio/cs5535audio.c                |   14 +-
 sound/pci/cs5535audio/cs5535audio_pcm.c            |   12 +-
 sound/pci/ctxfi/ctamixer.c                         |   67 +-
 sound/pci/ctxfi/ctatc.c                            |   28 +-
 sound/pci/ctxfi/ctdaio.c                           |   42 +-
 sound/pci/ctxfi/cthw20k1.c                         |   39 +-
 sound/pci/ctxfi/ctsrc.c                            |  101 +-
 sound/pci/ctxfi/cttimer.c                          |   63 +-
 sound/pci/ctxfi/ctvmem.c                           |   16 +-
 sound/pci/echoaudio/echoaudio.c                    |  128 +-
 sound/pci/echoaudio/echoaudio_3g.c                 |    6 +-
 sound/pci/echoaudio/gina24_dsp.c                   |    3 +-
 sound/pci/echoaudio/layla24_dsp.c                  |    6 +-
 sound/pci/echoaudio/midi.c                         |   41 +-
 sound/pci/echoaudio/mona_dsp.c                     |    3 +-
 sound/pci/emu10k1/emu10k1_main.c                   |   27 +-
 sound/pci/emu10k1/emu10k1_synth.c                  |   11 +-
 sound/pci/emu10k1/emu10k1x.c                       |  221 +--
 sound/pci/emu10k1/emufx.c                          |   81 +-
 sound/pci/emu10k1/emumixer.c                       |   71 +-
 sound/pci/emu10k1/emumpu401.c                      |  173 +-
 sound/pci/emu10k1/emupcm.c                         |   58 +-
 sound/pci/emu10k1/emuproc.c                        |   19 +-
 sound/pci/emu10k1/io.c                             |  123 +-
 sound/pci/emu10k1/memory.c                         |   34 +-
 sound/pci/emu10k1/p16v.c                           |    8 +-
 sound/pci/emu10k1/voice.c                          |    8 +-
 sound/pci/ens1370.c                                |  316 ++--
 sound/pci/es1938.c                                 |   28 +-
 sound/pci/es1968.c                                 |  160 +-
 sound/pci/fm801.c                                  |   71 +-
 sound/pci/ice1712/aureon.c                         |   27 +-
 sound/pci/ice1712/delta.c                          |   83 +-
 sound/pci/ice1712/ews.c                            |   53 +-
 sound/pci/ice1712/hoontech.c                       |   24 +-
 sound/pci/ice1712/ice1712.c                        |  186 +-
 sound/pci/ice1712/ice1724.c                        |  314 ++--
 sound/pci/ice1712/maya44.c                         |   18 +-
 sound/pci/ice1712/phase.c                          |    6 +-
 sound/pci/ice1712/pontis.c                         |   70 +-
 sound/pci/ice1712/prodigy192.c                     |   11 +-
 sound/pci/ice1712/prodigy_hifi.c                   |   56 +-
 sound/pci/ice1712/quartet.c                        |    3 +-
 sound/pci/ice1712/wtm.c                            |    6 +-
 sound/pci/intel8x0.c                               |  178 +-
 sound/pci/intel8x0m.c                              |    8 +-
 sound/pci/korg1212/korg1212.c                      |  182 +-
 sound/pci/lola/lola.c                              |    4 +-
 sound/pci/lola/lola_pcm.c                          |   36 +-
 sound/pci/lx6464es/lx6464es.c                      |   49 +-
 sound/pci/lx6464es/lx_core.c                       |  111 +-
 sound/pci/maestro3.c                               |   23 +-
 sound/pci/mixart/mixart.c                          |   48 +-
 sound/pci/mixart/mixart_core.c                     |   71 +-
 sound/pci/mixart/mixart_mixer.c                    |   46 +-
 sound/pci/nm256/nm256.c                            |   37 +-
 sound/pci/oxygen/oxygen.c                          |   12 +-
 sound/pci/oxygen/oxygen_lib.c                      |  132 +-
 sound/pci/oxygen/oxygen_mixer.c                    |   66 +-
 sound/pci/oxygen/oxygen_pcm.c                      |  165 +-
 sound/pci/oxygen/xonar_cs43xx.c                    |    6 +-
 sound/pci/oxygen/xonar_dg_mixer.c                  |   33 +-
 sound/pci/oxygen/xonar_lib.c                       |    3 +-
 sound/pci/oxygen/xonar_pcm179x.c                   |   21 +-
 sound/pci/oxygen/xonar_wm87x6.c                    |   31 +-
 sound/pci/pcxhr/pcxhr.c                            |   35 +-
 sound/pci/pcxhr/pcxhr_core.c                       |   15 +-
 sound/pci/pcxhr/pcxhr_mix22.c                      |   23 +-
 sound/pci/pcxhr/pcxhr_mixer.c                      |   58 +-
 sound/pci/rme32.c                                  |  152 +-
 sound/pci/rme96.c                                  |  211 +--
 sound/pci/rme9652/hdsp.c                           |  309 ++--
 sound/pci/rme9652/hdspm.c                          |  303 ++--
 sound/pci/rme9652/rme9652.c                        |  203 +--
 sound/pci/sis7019.c                                |   43 +-
 sound/pci/sonicvibes.c                             |  113 +-
 sound/pci/trident/trident_main.c                   |  324 ++--
 sound/pci/trident/trident_memory.c                 |   19 +-
 sound/pci/via82xx.c                                |   80 +-
 sound/pci/via82xx_modem.c                          |    6 +-
 sound/pci/vx222/vx222_ops.c                        |   12 +-
 sound/pci/ymfpci/ymfpci_main.c                     |  248 ++-
 sound/pcmcia/pdaudiocf/pdaudiocf_core.c            |    3 +-
 sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c             |   25 +-
 sound/pcmcia/vx/vxp_mixer.c                        |    9 +-
 sound/pcmcia/vx/vxp_ops.c                          |    6 +-
 sound/ppc/awacs.c                                  |   24 +-
 sound/ppc/beep.c                                   |   17 +-
 sound/ppc/burgundy.c                               |   10 +-
 sound/ppc/pmac.c                                   |   88 +-
 sound/ppc/snd_ps3.c                                |   21 +-
 sound/soc/amd/acp/acp-rembrandt.c                  |    2 +-
 sound/soc/amd/acp/amd-sdw-acpi.c                   |    2 +-
 sound/soc/amd/raven/acp3x-i2s.c                    |    3 +-
 sound/soc/amd/vangogh/acp5x-i2s.c                  |    3 +-
 sound/soc/codecs/Kconfig                           |   67 +-
 sound/soc/codecs/Makefile                          |   20 +-
 sound/soc/codecs/adau1977.c                        |    2 +-
 sound/soc/codecs/cs-amp-lib-test.c                 |  252 ++-
 sound/soc/codecs/cs-amp-lib.c                      |  139 +-
 sound/soc/codecs/cs35l41.c                         |   75 +-
 sound/soc/codecs/cs35l56-i2c.c                     |    4 +-
 sound/soc/codecs/cs35l56-sdw.c                     |    4 +-
 sound/soc/codecs/cs35l56-shared.c                  |  109 +-
 sound/soc/codecs/cs35l56-spi.c                     |    2 +-
 sound/soc/codecs/cs42l43-jack.c                    |    8 +-
 sound/soc/codecs/cs42l43.c                         |  109 +-
 sound/soc/codecs/cs42l43.h                         |    3 +
 sound/soc/codecs/cs48l32-tables.c                  |    4 +-
 sound/soc/codecs/da7213.c                          |    6 +-
 sound/soc/codecs/es8323.c                          |   17 +-
 sound/soc/codecs/fs-amp-lib.c                      |  265 +++
 sound/soc/codecs/fs-amp-lib.h                      |  150 ++
 sound/soc/codecs/fs210x.c                          | 1586 +++++++++++++++++
 sound/soc/codecs/fs210x.h                          |   75 +
 sound/soc/codecs/lpass-macro-common.h              |    1 +
 sound/soc/codecs/lpass-va-macro.c                  |    2 +
 sound/soc/codecs/lpass-wsa-macro.c                 |    2 +
 sound/soc/codecs/pcm1754.c                         |  185 ++
 sound/soc/codecs/pcm6240.c                         |    4 +-
 sound/soc/codecs/pm4125-sdw.c                      |  545 ++++++
 sound/soc/codecs/pm4125.c                          | 1780 ++++++++++++++++++++
 sound/soc/codecs/pm4125.h                          |  307 ++++
 sound/soc/codecs/rt1320-sdw.c                      |  380 ++++-
 sound/soc/codecs/rt1320-sdw.h                      |   10 +
 sound/soc/codecs/rt721-sdca-sdw.c                  |   10 +-
 sound/soc/codecs/tas2781-comlib-i2c.c              |    2 +
 sound/soc/codecs/tas2781-fmwlib.c                  |   79 +-
 sound/soc/codecs/tas2781-i2c.c                     |  190 ++-
 sound/soc/codecs/tas2783-sdw.c                     | 1331 +++++++++++++++
 sound/soc/codecs/tas2783.h                         |  110 ++
 sound/soc/codecs/tlv320aic32x4.c                   |   18 +-
 sound/soc/codecs/tlv320aic3x.c                     |   32 +-
 sound/soc/codecs/tlv320dac33.c                     |   69 +-
 sound/soc/codecs/wcd-common.c                      |  144 ++
 sound/soc/codecs/wcd-common.h                      |   46 +
 sound/soc/codecs/wcd934x.c                         |   99 +-
 sound/soc/codecs/wcd937x-sdw.c                     |   67 +-
 sound/soc/codecs/wcd937x.c                         |   93 +-
 sound/soc/codecs/wcd937x.h                         |   24 +-
 sound/soc/codecs/wcd938x-sdw.c                     |   83 +-
 sound/soc/codecs/wcd938x.c                         |   99 +-
 sound/soc/codecs/wcd938x.h                         |   26 +-
 sound/soc/codecs/wcd939x-sdw.c                     |   98 +-
 sound/soc/codecs/wcd939x.c                         |  104 +-
 sound/soc/codecs/wcd939x.h                         |   32 +-
 sound/soc/codecs/wl1273.c                          |  500 ------
 sound/soc/codecs/wl1273.h                          |   16 -
 sound/soc/codecs/wm8993.c                          |    2 +-
 sound/soc/codecs/wm8994.c                          |    6 +-
 sound/soc/codecs/wm8994.h                          |   12 +-
 sound/soc/codecs/wm8996.c                          |    2 +-
 sound/soc/codecs/wm_adsp.c                         |    6 +-
 sound/soc/codecs/wm_adsp.h                         |    2 +-
 sound/soc/codecs/wsa883x.c                         |   57 +-
 sound/soc/fsl/fsl_qmc_audio.c                      |  125 +-
 sound/soc/fsl/fsl_sai.c                            |    3 +-
 sound/soc/fsl/imx-audmux.c                         |    2 +-
 sound/soc/fsl/imx-hdmi.c                           |   13 +-
 sound/soc/generic/test-component.c                 |    4 +-
 sound/soc/intel/atom/sst-mfld-platform-compress.c  |   12 +-
 sound/soc/intel/atom/sst-mfld-platform.h           |    2 +-
 sound/soc/intel/atom/sst/sst.c                     |    2 +-
 sound/soc/intel/atom/sst/sst_drv_interface.c       |    9 +-
 sound/soc/intel/avs/apl.c                          |    1 +
 sound/soc/intel/avs/avs.h                          |   90 +-
 sound/soc/intel/avs/board_selection.c              |  321 ++--
 sound/soc/intel/avs/boards/da7219.c                |   15 +-
 sound/soc/intel/avs/boards/dmic.c                  |   80 +-
 sound/soc/intel/avs/boards/es8336.c                |   18 +-
 sound/soc/intel/avs/boards/hdaudio.c               |   13 +-
 sound/soc/intel/avs/boards/i2s_test.c              |   15 +-
 sound/soc/intel/avs/boards/max98357a.c             |   15 +-
 sound/soc/intel/avs/boards/max98373.c              |   15 +-
 sound/soc/intel/avs/boards/max98927.c              |   15 +-
 sound/soc/intel/avs/boards/nau8825.c               |   15 +-
 sound/soc/intel/avs/boards/probe.c                 |   49 +-
 sound/soc/intel/avs/boards/rt274.c                 |   17 +-
 sound/soc/intel/avs/boards/rt286.c                 |   15 +-
 sound/soc/intel/avs/boards/rt298.c                 |   15 +-
 sound/soc/intel/avs/boards/rt5514.c                |   15 +-
 sound/soc/intel/avs/boards/rt5640.c                |    2 +-
 sound/soc/intel/avs/boards/rt5663.c                |   15 +-
 sound/soc/intel/avs/boards/rt5682.c                |   15 +-
 sound/soc/intel/avs/boards/ssm4567.c               |   15 +-
 sound/soc/intel/avs/cnl.c                          |    1 +
 sound/soc/intel/avs/core.c                         |    1 +
 sound/soc/intel/avs/debug.h                        |   91 +
 sound/soc/intel/avs/debugfs.c                      |    1 +
 sound/soc/intel/avs/icl.c                          |    1 +
 sound/soc/intel/avs/ipc.c                          |    1 +
 sound/soc/intel/avs/lnl.c                          |    1 +
 sound/soc/intel/avs/mtl.c                          |    1 +
 sound/soc/intel/avs/path.c                         |  267 +++
 sound/soc/intel/avs/path.h                         |   13 +
 sound/soc/intel/avs/pcm.c                          |   35 +-
 sound/soc/intel/avs/probes.c                       |   25 +-
 sound/soc/intel/avs/ptl.c                          |    1 +
 sound/soc/intel/avs/skl.c                          |    1 +
 sound/soc/intel/avs/tgl.c                          |    1 +
 sound/soc/intel/avs/topology.c                     |  110 ++
 sound/soc/intel/avs/topology.h                     |    8 +
 sound/soc/intel/boards/bytcht_cx2072x.c            |    2 +-
 sound/soc/intel/boards/bytcht_es8316.c             |   22 +-
 sound/soc/intel/boards/bytcr_rt5640.c              |    9 +-
 sound/soc/intel/boards/bytcr_rt5651.c              |   28 +-
 sound/soc/intel/boards/bytcr_wm5102.c              |    2 +-
 sound/soc/intel/boards/sof_es8336.c                |    2 +-
 sound/soc/intel/boards/sof_sdw.c                   |    2 +-
 sound/soc/intel/common/soc-acpi-intel-mtl-match.c  |   30 +
 sound/soc/mediatek/common/mtk-soundcard-driver.c   |   19 +-
 sound/soc/mediatek/mt8173/mt8173-rt5650.c          |    2 +-
 sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c |    2 +-
 .../mt8183/mt8183-mt6358-ts3a227-max98357.c        |    2 +-
 sound/soc/mediatek/mt8186/mt8186-mt6366.c          |    2 +-
 sound/soc/mediatek/mt8188/mt8188-mt6359.c          |    8 +-
 .../mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c  |    2 +-
 sound/soc/mediatek/mt8195/mt8195-mt6359.c          |    4 +-
 sound/soc/pxa/Kconfig                              |    4 +-
 sound/soc/qcom/lpass-cdc-dma.c                     |    3 +-
 sound/soc/qcom/lpass-hdmi.c                        |    2 +-
 sound/soc/qcom/qdsp6/audioreach.c                  |   54 +
 sound/soc/qcom/qdsp6/audioreach.h                  |   35 +-
 sound/soc/qcom/qdsp6/q6apm-dai.c                   |   29 +-
 sound/soc/qcom/qdsp6/q6apm.c                       |    3 +
 sound/soc/qcom/qdsp6/q6asm-dai.c                   |   26 +-
 sound/soc/qcom/qdsp6/topology.c                    |   45 +-
 sound/soc/qcom/sc8280xp.c                          |    7 +-
 sound/soc/qcom/x1e80100.c                          |    5 +-
 sound/soc/renesas/fsi.c                            |   30 +-
 sound/soc/renesas/rcar/core.c                      |   18 +-
 sound/soc/renesas/rcar/msiof.c                     |  221 ++-
 sound/soc/renesas/rcar/src.c                       |   19 +-
 sound/soc/renesas/rcar/ssi.c                       |   37 +-
 sound/soc/renesas/rz-ssi.c                         |   14 +-
 sound/soc/sdw_utils/Makefile                       |    3 +-
 sound/soc/sdw_utils/soc_sdw_ti_amp.c               |   92 +
 sound/soc/sdw_utils/soc_sdw_utils.c                |   38 +-
 sound/soc/soc-component.c                          |    2 +-
 sound/soc/soc-compress.c                           |    2 +-
 sound/soc/soc-core.c                               |    4 +-
 sound/soc/soc-dai.c                                |    2 +-
 sound/soc/soc-dapm.c                               |  121 +-
 sound/soc/soc-ops.c                                |    1 +
 sound/soc/sof/amd/acp-probes.c                     |    2 +-
 sound/soc/sof/compress.c                           |    2 +-
 sound/soc/sof/imx/imx-common.c                     |    6 +-
 sound/soc/sof/imx/imx8.c                           |    3 +-
 sound/soc/sof/intel/hda-codec.c                    |    3 -
 sound/soc/sof/intel/hda-ctrl.c                     |    8 +-
 sound/soc/sof/intel/hda-dsp.c                      |    2 +-
 sound/soc/sof/intel/hda-probes.c                   |    2 +-
 sound/soc/sof/intel/hda-sdw-bpt.c                  |    2 +-
 sound/soc/sof/intel/hda.c                          |    2 +-
 sound/soc/sof/intel/hda.h                          |    2 +-
 sound/soc/sof/ipc3-dtrace.c                        |    2 +-
 sound/soc/sof/ipc4-pcm.c                           |   60 +-
 sound/soc/sof/ipc4-topology.c                      |  187 +-
 sound/soc/sof/ipc4-topology.h                      |   16 +
 sound/soc/sof/sof-audio.h                          |    3 +
 sound/soc/sof/sof-client-probes-ipc3.c             |   25 +-
 sound/soc/sof/sof-client-probes-ipc4.c             |  134 +-
 sound/soc/sof/sof-client-probes.c                  |   62 +-
 sound/soc/sof/sof-client-probes.h                  |   13 +-
 sound/soc/sof/sof-client.c                         |  118 +-
 sound/soc/sof/sof-client.h                         |    8 +-
 sound/soc/sof/sof-priv.h                           |    9 +
 sound/soc/sprd/sprd-pcm-compress.c                 |    6 +-
 sound/soc/sprd/sprd-pcm-dma.h                      |    4 +-
 sound/soc/stm/stm32_sai_sub.c                      |    8 +
 sound/soc/uniphier/aio-compress.c                  |    2 +-
 sound/sparc/amd7930.c                              |  110 +-
 sound/sparc/cs4231.c                               |  225 +--
 sound/sparc/dbri.c                                 |  228 ++-
 sound/spi/at73c213.c                               |   85 +-
 sound/synth/emux/emux_effect.c                     |   29 +-
 sound/synth/emux/emux_proc.c                       |    6 +-
 sound/synth/emux/emux_seq.c                        |   17 +-
 sound/synth/emux/emux_synth.c                      |   54 +-
 sound/synth/emux/soundfont.c                       |  115 +-
 sound/synth/util_mem.c                             |   17 +-
 sound/usb/6fire/chip.c                             |   40 +-
 sound/usb/6fire/midi.c                             |   21 +-
 sound/usb/6fire/pcm.c                              |   83 +-
 sound/usb/Kconfig                                  |   12 +
 sound/usb/bcd2000/bcd2000.c                        |   16 +-
 sound/usb/caiaq/audio.c                            |   39 +-
 sound/usb/card.c                                   |   94 +-
 sound/usb/endpoint.c                               |  124 +-
 sound/usb/fcp.c                                    |   17 +-
 sound/usb/hiface/chip.c                            |   11 +-
 sound/usb/hiface/pcm.c                             |   60 +-
 sound/usb/line6/capture.c                          |    6 +-
 sound/usb/line6/driver.c                           |   37 +-
 sound/usb/line6/midi.c                             |   10 +-
 sound/usb/line6/pcm.c                              |   85 +-
 sound/usb/media.c                                  |    6 +-
 sound/usb/midi.c                                   |   75 +-
 sound/usb/midi2.c                                  |   16 +-
 sound/usb/misc/ua101.c                             |  250 ++-
 sound/usb/mixer.c                                  |   66 +-
 sound/usb/mixer_quirks.c                           |  362 ++--
 sound/usb/mixer_s1810c.c                           |  303 ++--
 sound/usb/mixer_scarlett2.c                        | 1414 ++++++----------
 sound/usb/mixer_us16x08.c                          |    3 +-
 sound/usb/pcm.c                                    |  309 ++--
 sound/usb/proc.c                                   |    3 +-
 sound/usb/qcom/qc_audio_offload.c                  |   84 +-
 sound/usb/quirks.c                                 |  200 ++-
 sound/usb/quirks.h                                 |   11 +-
 sound/usb/usbaudio.h                               |  110 +-
 sound/usb/usx2y/Makefile                           |    2 +
 sound/usb/usx2y/us122l.c                           |   50 +-
 sound/usb/usx2y/us144mkii.c                        |  620 +++++++
 sound/usb/usx2y/us144mkii.h                        |  367 ++++
 sound/usb/usx2y/us144mkii_capture.c                |  319 ++++
 sound/usb/usx2y/us144mkii_controls.c               |  444 +++++
 sound/usb/usx2y/us144mkii_midi.c                   |  403 +++++
 sound/usb/usx2y/us144mkii_pcm.c                    |  370 ++++
 sound/usb/usx2y/us144mkii_pcm.h                    |  165 ++
 sound/usb/usx2y/us144mkii_playback.c               |  456 +++++
 sound/usb/usx2y/usbusx2yaudio.c                    |   23 +-
 sound/usb/usx2y/usx2yhwdeppcm.c                    |   33 +-
 sound/usb/validate.c                               |    9 +-
 sound/virtio/virtio_card.c                         |    8 +-
 sound/virtio/virtio_ctl_msg.c                      |   23 +-
 sound/virtio/virtio_pcm.c                          |    8 +-
 sound/virtio/virtio_pcm_msg.c                      |   17 +-
 sound/virtio/virtio_pcm_ops.c                      |   56 +-
 sound/x86/intel_hdmi_audio.c                       |  109 +-
 sound/xen/xen_snd_front.c                          |   80 +-
 sound/xen/xen_snd_front_evtchnl.c                  |   33 +-
 tools/testing/selftests/alsa/mixer-test.c          |    8 +-
 tools/testing/selftests/alsa/pcm-test.c            |    8 +-
 603 files changed, 24386 insertions(+), 16192 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/twl4030-audio.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/alc5623.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/foursemi,fs2105s.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt8183-audio.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt8183_da7219.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt8183_mt6358_ts3a227.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/mt8183-afe-pcm.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/mt8183-da7219-max98357.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/mt8183-mt6358-ts3a227-max98357.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/omap-twl4030.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,pm4125-codec.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,pm4125-sdw.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/realtek,alc5623.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/ti,omap-twl4030.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/ti,pcm1754.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/ti,twl4030-audio.yaml
 create mode 100644 include/sound/tas2x20-tlv.h
 create mode 100644 include/sound/tas5825-tlv.h
 delete mode 100644 include/sound/tlv320dac33-plat.h
 create mode 100644 sound/soc/codecs/fs-amp-lib.c
 create mode 100644 sound/soc/codecs/fs-amp-lib.h
 create mode 100644 sound/soc/codecs/fs210x.c
 create mode 100644 sound/soc/codecs/fs210x.h
 create mode 100644 sound/soc/codecs/pcm1754.c
 create mode 100644 sound/soc/codecs/pm4125-sdw.c
 create mode 100644 sound/soc/codecs/pm4125.c
 create mode 100644 sound/soc/codecs/pm4125.h
 create mode 100644 sound/soc/codecs/tas2783-sdw.c
 create mode 100644 sound/soc/codecs/tas2783.h
 create mode 100644 sound/soc/codecs/wcd-common.c
 create mode 100644 sound/soc/codecs/wcd-common.h
 delete mode 100644 sound/soc/codecs/wl1273.c
 delete mode 100644 sound/soc/codecs/wl1273.h
 create mode 100644 sound/soc/intel/avs/debug.h
 create mode 100644 sound/soc/sdw_utils/soc_sdw_ti_amp.c
 create mode 100644 sound/usb/usx2y/us144mkii.c
 create mode 100644 sound/usb/usx2y/us144mkii.h
 create mode 100644 sound/usb/usx2y/us144mkii_capture.c
 create mode 100644 sound/usb/usx2y/us144mkii_controls.c
 create mode 100644 sound/usb/usx2y/us144mkii_midi.c
 create mode 100644 sound/usb/usx2y/us144mkii_pcm.c
 create mode 100644 sound/usb/usx2y/us144mkii_pcm.h
 create mode 100644 sound/usb/usx2y/us144mkii_playback.c


