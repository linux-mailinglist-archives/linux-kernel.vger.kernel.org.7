Return-Path: <linux-kernel+bounces-745845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D97B11F7B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC184E6664
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34A923A9BE;
	Fri, 25 Jul 2025 13:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RuUI6uY1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Eeau4gwv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RuUI6uY1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Eeau4gwv"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F0F1BF58
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 13:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753451086; cv=none; b=tG1trjd8oUDhWhjl13wJuT5IxhIrY/2KcbFXr9ijzvD/i0Dm2A/eUXbh+A9XbpNNrs+iSKYt0KSAxddPT8bXh3DUnFxHeH2pXUi/9FwFXVRxQFDR9Ti0JSxDX/N5WFF52Bsv4DzB3MDi0xzOY8n67uQiYzAgWn0aS1HpCvk9+dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753451086; c=relaxed/simple;
	bh=Vy+ybeREWDIyomUCnHVqau0iymvdAJs4kHXNa/+pP1I=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=ADL5isAjdT7/jkmJZJjGpyX7M0vgVseBpMPrtuTbYPumQA6g+qgBYsrA/TkCHyaEbIU9WIiOPhrf07u4fSCCSMoKenrbouAnsPwGatrJ8LN2qkdW53g6mbR2J7IDMw1FnUiKJwYnnJLPypqHEc7wPuKzj0V9I8YhXuRqmk+M+8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RuUI6uY1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Eeau4gwv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RuUI6uY1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Eeau4gwv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 13E871F842;
	Fri, 25 Jul 2025 13:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753451080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=8+WF9kXphWpn3Xr4AbODzyMRam82n6FS/m0bpQ2/HKc=;
	b=RuUI6uY1fTNhefJgd1Cb7o28itac0Y3JMsIKwgtmPZl/rtMAr3wYCW9Es9BP0vArOCHt2O
	xqRoyNQkVpexQRk00OtLVb8SgaGJ1dtHxPz8ztkbKOZZ5xeJvL9pi+Tnp5hvxkywJ1ZdlE
	OpPzqt+8G2BCIDtA4GhUwvsYhRV6lNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753451080;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=8+WF9kXphWpn3Xr4AbODzyMRam82n6FS/m0bpQ2/HKc=;
	b=Eeau4gwvDi8TiFjybWzy61VFF8e4J03cPDs/R78TxecLU57wmL2XPDCtBLCCTSD3iwvdpO
	VrizcILGY0QrCwDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753451080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=8+WF9kXphWpn3Xr4AbODzyMRam82n6FS/m0bpQ2/HKc=;
	b=RuUI6uY1fTNhefJgd1Cb7o28itac0Y3JMsIKwgtmPZl/rtMAr3wYCW9Es9BP0vArOCHt2O
	xqRoyNQkVpexQRk00OtLVb8SgaGJ1dtHxPz8ztkbKOZZ5xeJvL9pi+Tnp5hvxkywJ1ZdlE
	OpPzqt+8G2BCIDtA4GhUwvsYhRV6lNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753451080;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=8+WF9kXphWpn3Xr4AbODzyMRam82n6FS/m0bpQ2/HKc=;
	b=Eeau4gwvDi8TiFjybWzy61VFF8e4J03cPDs/R78TxecLU57wmL2XPDCtBLCCTSD3iwvdpO
	VrizcILGY0QrCwDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3A9B1373A;
	Fri, 25 Jul 2025 13:44:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id biF8MkeKg2i2RAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 25 Jul 2025 13:44:39 +0000
Date: Fri, 25 Jul 2025 15:44:39 +0200
Message-ID: <87ecu4idvc.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound updates for 6.17-rc1
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.30

Linus,

please pull sound updates for v6.17-rc1 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.17-rc1

The topmost commit is bca53a176f3d46fdab67f9e2fb1a185e0233d98d

----------------------------------------------------------------

sound updates for 6.17-rc1

This includes lots of file shuffling due to HD-audio code
reorganization and many trivial changes, but otherwise there shouldn't
be much surprise from the functionality POV.  The PR includes the PM
changes as prerequisite, too.  Some highlights below:

Core:
- Performance optimizations in PCM core code
- Refactoring of ASoC Kconfig menus to be hopefully more consistant
  and easier to navigate.
- Refactoring of ASoC DAPM code, mainly hiding functionality that
  doesn't need to be exposed to drivers

HD-audio reorganization:
- All code are moved under sound/hda with a bit more understandable
  tree structure, as well as file renames
- The huge Realtek driver code is split to several parts, a common
  helper module with driver modules per probe entry
- HDMI and Cirrus codec drivers also split

ASoC:
- Further work on the generic handling for SoundWire SDCA devices
- Support for AMD ACP7.2 and SoundWire on ACP 7.1, Fairphone 4 & 5,
  various Intel systems, Qualcomm QCS8275, Richtek RTQ9124 and TI
  TAS5753

HD-audio and USB-audio:
- TAS2781 driver cleanup and TAS2770 support
- EQ enablement in CA0132 driver
- USB audio quirk code cleanups

Others:
- Cleanups of PM autosuspend call patterns with the update from the PM
  tree
- Lots of strcpy() -> strscpy() conversions for fixed size arrays

----------------------------------------------------------------

Ai Chao (3):
      ASoC: renesas: Use helper function for_each_child_of_node_scoped()
      ASoC: meson: Use helper function for_each_child_of_node_scoped()
      ASoC: imx-card: Use helper function for_each_child_of_node_scoped()

Alexander Stein (1):
      ASoC: codec: tlv320aic32x4: Fix reset GPIO check

Alok Tiwari (1):
      ALSA: intel8x0: Fix incorrect codec index usage in mixer for ICH4

Arnd Bergmann (2):
      ASoC: ops: dynamically allocate struct snd_ctl_elem_value
      ASoC: SDCA: fix HID dependency

Balamurugan C (3):
      ASoC: Intel: soc-acpi: Add entry for sof_es8336 in PTL match table.
      ASoC: Intel: soc-acpi: Add entry for HDMI_In capture support in PTL match table
      ASoC: Intel: sof_rt5682: Add HDMI-In capture with rt5682 support for PTL.

Baojun Xu (4):
      ALSA: hda/tas2781: Add missed brace and hardware id re-order
      ALSA: hda/tas2781: Add compatible for hardware id TIAS2781 and TXNW2781
      ALSA: hda/tas2781: Add bus name in device name check
      ALSA: hda: Add TAS2770 support

Bard Liao (2):
      ASoC: sdw_utils: add component_name string to dai_info
      ASoC: sdw_utils: generate combined spk components string

Bram Vlerick (2):
      ASoC: tas571x: add support for tas5753
      ASoC: dt-bindings: tas57xx: add tas5753 compatibility

Brian Masney (6):
      ASoC: codecs: da7219: convert from round_rate() to determine_rate()
      ASoC: codecs: rt5682: convert from round_rate() to determine_rate()
      ASoC: codecs: rt5682s: convert from round_rate() to determine_rate()
      ASoC: qcom: qdsp6: q6dsp-lpass-clocks: convert from round_rate() to determine_rate()
      ASoC: stm: stm32_i2s: convert from round_rate() to determine_rate()
      ASoC: stm: stm32_sai_sub: convert from round_rate() to determine_rate()

Cezary Rojewski (2):
      ASoC: codecs: rt5640: Drop dummy register names
      ASoC: Intel: avs: Add rt5640 machine board

Charles Keepax (21):
      HID: core: Add bus define for SoundWire bus
      MAINTAINERS: Add SDCA maintainers entry
      ASoC: SDCA: Add missing default in switch in entity_pde_event()
      ASoC: SDCA: Fixup some kernel doc errors
      ASoC: SDCA: Minor selected/detected mode control fixups
      ASoC: SDCA: Add flag for unused IRQs
      ASoC: SDCA: Add some initial IRQ handlers
      ASoC: SDCA: Kconfig/Makefile fixups
      ASoC: SDCA: Pull HID and IRQ into the primary SDCA module
      ASoC: SDCA: Fix off by one error in IRQ bound check
      ASoC: SDCA: Avoid use of uninitialised local name variable
      ASoC: SDCA: Update memory allocations to zero initialise
      ASoC: SDCA: Allow read-only controls to be deferrable
      ASoC: SDCA: Remove overly chatty input pin list warning
      ASoC: SDCA: Move SDCA search functions and export
      ASoC: soc-dai: Add private data to snd_soc_dai
      ASoC: SDCA: Add helper to add DAI constraints
      ASoC: SDCA: Add a helper to get the SoundWire port number
      ASoC: SDCA: Add hw_params() helper function
      ASoC: SDCA: Shrink detected_mode_handler() stack frame
      ASoC: SDCA: Fix implicit cast from le16

Chen Ni (2):
      ALSA: usb-audio: Convert comma to semicolon
      ASoC: tegra: AHUB: Remove unneeded semicolon

Chen-Yu Tsai (9):
      ASoC: dt-bindings: Convert MT8173 AFE binding to dt-schema
      ASoC: dt-bindings: mt8173-afe-pcm: Add power domain
      ASoC: dt-bindings: mt8173-afe-pcm: Allow specifying reserved memory region
      ASoC: dt-bindings: mt8186-afe-pcm: Allow specifying reserved memory region
      ASoC: dt-bindings: mt8192-afe-pcm: Allow specifying reserved memory region
      ASoC: mediatek: use reserved memory or enable buffer pre-allocation
      ASoC: mediatek: mt8183-afe-pcm: Support >32 bit DMA addresses
      ASoC: mediatek: mt8173-afe-pcm: use local `dev` pointer in driver callbacks
      ASoC: mediatek: mt8183-afe-pcm: use local `dev` pointer in driver callbacks

ChiYuan Huang (2):
      ASoC: dt-bindings: rt9123: Append RTQ9124 description
      ASoC: codecs: Add support for Richtek RTQ9124

Christophe Leroy (5):
      ALSA: pcm: Rewrite recalculate_boundary() to avoid costly loop
      ALSA: pcm: refactor copy from/to user in SNDRV_PCM_IOCTL_SYNC_PTR
      ALSA: pcm: Convert SNDRV_PCM_IOCTL_SYNC_PTR to user_access_begin/user_access_end()
      ALSA: pcm: Replace [audio_]tstamp_[n]sec by struct __snd_timespec in struct snd_pcm_mmap_status32
      ALSA: pcm: Convert snd_pcm_sync_ptr() to user_access_begin/user_access_end()

Cristian Ciocaltea (9):
      ALSA: usb-audio: Fix code alignment in mixer_quirks
      ALSA: usb-audio: Fix whitespace & blank line issues in mixer_quirks
      ALSA: usb-audio: Avoid precedence issues in mixer_quirks macros
      ALSA: usb-audio: Fix block comments in mixer_quirks
      ALSA: usb-audio: Drop unnecessary parentheses in mixer_quirks
      ALSA: usb-audio: Avoid multiple assignments in mixer_quirks
      ALSA: usb-audio: Simplify NULL comparison in mixer_quirks
      ALSA: usb-audio: Remove unneeded wmb() in mixer_quirks
      ALSA: usb-audio: Add mixer quirk for Sony DualSense PS5

Frank Li (1):
      ASoC: dt-bindings: covert mxs-audio-sgtl5000.txt to yaml format

GalaxySnail (1):
      ALSA: hda: add MODULE_FIRMWARE for cs35l41/cs35l56

Geert Uytterhoeven (2):
      ASoC: renesas: msiof: Convert to <linux/spi/sh_msiof.h>
      ASoC: img: Imagination Technologies sound should depend on MIPS

Jyri Sarha (3):
      ASoC: SOF: ipc4: Add sof_ipc4_pipeline_state_str() for debugging
      ASoC: SOF: ipc4-pcm: Pipe instances to dev_dbg in multi_pipeline_state()
      ASoC: SOF: ipc4-pcm: Harmonize sof_ipc4_set_pipeline_state() dbg print

Krzysztof Kozlowski (20):
      ASoC: codecs: Constify regmap configuration static variables
      ASoC: fsl: Constify reg_default array
      ASoC: codecs: wcd9335: Drop unused sido_input_src field
      ASoC: codecs: wcd934x: Drop unused num_rx_port/num_tx_port fields
      ASoC: codecs: wcd937x: Drop unused 'struct wcd937x_priv' fields
      ASoC: codecs: wcd938x: Drop unused 'struct wcd938x_priv' fields
      ASoC: codecs: wcd938x: Drop unused variant field
      ASoC: codecs: wcd939x: Drop unused 'struct wcd939x_priv' fields
      ASoC: codecs: wcd937x: Simplify with devm_regulator_bulk_get_enable()
      ASoC: codecs: wcd938x: Simplify with devm_regulator_bulk_get_enable()
      ASoC: codecs: wcd939x: Simplify with devm_regulator_bulk_get_enable()
      ASoC: codecs: wcd939x: Simplify return from devm_gpiod_get() error
      ASoC: dt-bindings: qcom,wcd939x: Document missing VDD_PX supply
      ASoC: codecs: wcd939x: Add VDD_PX supply
      ASoC: codecs: lpass: Drop unused AIF_INVALID first DAI identifier
      ASoC: codecs: wcd937x: Use simple defines for chipid register value
      ASoC: codecs: wcd938x: Use simple defines for chipid register value
      ASoC: codecs: wcd939x: Use simple defines for chipid register value
      ASoC: codecs: wcd939x: Add defines for major/minor version decoding
      ASoC: dt-bindings: qcom,lpass-va-macro: Define clock-names in top-level

Kuninori Morimoto (62):
      ASoC: soc-core: save ID if param was set in fmt_single_name()
      ASoC: remove component->id
      ASoC: hdac_hdmi: remove hdac_hdmi_jack[_port]_init()
      ASoC: soc-dai: tidyup return value of snd_soc_xlate_tdm_slot_mask()
      ASoC: soc-ops-test: dynamically allocate struct snd_ctl_elem_value
      ASoC: ti: Standardize ASoC menu
      ASoC: adi: Standardize ASoC menu
      ASoC: amd: Standardize ASoC menu
      ASoC: bcm: Standardize ASoC menu
      ASoC: dwc: Standardize ASoC menu
      ASoC: fsl: Standardize ASoC menu
      ASoC: img: Standardize ASoC menu
      ASoC: mxs: Standardize ASoC menu
      ASoC: pxa: Standardize ASoC menu
      ASoC: sti: Standardize ASoC menu
      ASoC: stm: Standardize ASoC menu
      ASoC: sof: Standardize ASoC menu
      ASoC: au1x: Standardize ASoC menu
      ASoC: sdca: Standardize ASoC menu
      ASoC: sprd: Standardize ASoC menu
      ASoC: qcom: Standardize ASoC menu
      ASoC: meson: Standardize ASoC menu
      ASoC: apple: Standardize ASoC menu
      ASoC: atmel: Standardize ASoC menu
      ASoC: intel: Standardize ASoC menu
      ASoC: spear: Standardize ASoC menu
      ASoC: sunxi: Standardize ASoC menu
      ASoC: tegra: Standardize ASoC menu
      ASoC: ux500: Standardize ASoC menu
      ASoC: cirrus: Standardize ASoC menu
      ASoC: google: Standardize ASoC menu
      ASoC: jz4740: Standardize ASoC menu
      ASoC: xilinx: Standardize ASoC menu
      ASoC: xtensa: Standardize ASoC menu
      ASoC: renesas: Standardize ASoC menu
      ASoC: generic: Standardize ASoC menu
      ASoC: samsung: Standardize ASoC menu
      ASoC: kirkwood: Standardize ASoC menu
      ASoC: loongson: Standardize ASoC menu
      ASoC: mediatek: Standardize ASoC menu
      ASoC: rockchip: Standardize ASoC menu
      ASoC: starfive: Standardize ASoC menu
      ASoC: uniphier: Standardize ASoC menu
      ASoC: hisilicon: Standardize ASoC menu
      ASoC: soc-dapm: remove unnecessary definition
      ASoC: soc-dapm: remove EXPORT_SYMBOL_GPL() for snd_soc_dapm_free()
      ASoC: soc-dapm: remove snd_soc_dapm_nc_pin[_unlocked]()
      ASoC: soc-dapm: remove snd_soc_dapm_weak_routes()
      ASoC: soc-dapm: reordering function definitions
      ASoC: soc-dapm: reordering header definitions
      ASoC: soc-dapm: use component instead of cmpnt
      ASoC: soc-dapm: use common name for dapm
      ASoC: soc-dapm: add prefix on dapm_mark_endpoints_dirty()
      ASoC: soc-dapm: add prefix on dapm_xxx_event()
      ASoC: soc-dapm: add prefix on soc_dapm_dev_attrs
      ASoC: rt700: don't set dapm->bias_level
      ASoC: rt715: don't set dapm->bias_level
      ASoC: soc-dapm: set bias_level if snd_soc_dapm_set_bias_level() was successed
      ASoC: samsung: bell: don't set dapm->bias_level directly
      ASoC: samsung: speyside: don't set dapm->bias_level directly
      ASoC: samsung: tobermory: don't set dapm->bias_level directly
      ASoC: samsung: littlemill: don't set dapm->bias_level directly

Laurentiu Mihalcea (1):
      ASoC: dt-bindings: cirrus,cs42xx8: add 'port' property

Luca Weiss (6):
      ASoC: qcom: sm8250: set card driver name from match data
      ASoC: qcom: sm8250: add DisplayPort Jack support
      ASoC: qcom: sm8250: Add Fairphone 5 soundcard compatible
      ASoC: dt-bindings: qcom,q6afe: Document q6usb subnode
      ASoC: dt-bindings: qcom,sm8250: Add Fairphone 4 sound card
      ASoC: qcom: sm8250: Add Fairphone 4 soundcard compatible

Lucy Thrun (3):
      ALSA: hda/ca0132: Enable hardware band EQ for Sound Blaster Core3D
      ALSA: hda/ca0132: Fix using plain integer as NULL pointer in add_tuning_control
      ALSA: hda/ca0132: Fix buffer overflow in add_tuning_control

Mac Chiang (2):
      ASoC: Intel: soc-acpi-intel-ptl-match: add support ptl-rt721-l0
      ASoC: Intel: soc-acpi-intel-lnl-match: add rt1320_l12_rt714_l0 support

Maciej Strozek (1):
      ASoC: SDCA: Generic interrupt support

Mark Brown (1):
      ASoC: hdac_hdmi: Rate limit logging on connection and disconnection

Pei Xiao (2):
      ASOC: rockchip: fix capture stream handling in rockchip_sai_xfer_stop
      ASOC: rockchip: Use helper function devm_clk_get_enabled()

Peng Fan (4):
      ASoC: codec: rockchip_sai: Remove including of_gpio.h
      ASoC: codec: tlv320aic32x4: Drop aic32x4_pdata usage
      ASoC: codec: tlv320aic32x4: Sort headers alphabetically
      ASoC: codec: tlv320aic32x4: Convert to GPIO descriptors

Peter Ujfalusi (13):
      ASoC: topology: Do not call snd_soc_remove_pcm_runtime() for ignored links
      ASoC: core: Check for rtd == NULL in snd_soc_remove_pcm_runtime()
      ASoC: Intel: skl_hda_dsp_generic: Implement add_dai_link to filter HDMI PCMs
      ASoC: Intel: sof_sdw: Implement add_dai_link to filter HDMI PCMs
      ASoC: SOF: ipc4-priv: Add kernel doc for fw_context_save of sof_ipc4_fw_data
      ASoC: SOF: ipc4/Intel: Add support for library restore firmware functionality
      ASoC: SOF: ipc4-pcm: Look for best matching hw_config for SSP
      ASoC: SOF: pcm: Remove local create_page_table() wrapper function
      ASoC: SOF: topology: Parse the dapm_widget_tokens in case of DSPless mode
      ASoC: SOF: pcm: Reverse check for prepared stream in sof_pcm_hw_params()
      ASoC: SOF: Intel: hda: Do not probe Soundwire in nocodec mode
      ASoC: SOF: ipc4-pcm: Enable delay reporting for ChainDMA streams
      ASoC: sdw_utils: Add missed component_name strings for speaker amps

Prasad Kumpatla (2):
      ASoC: dt-bindings: qcom,sm8250: Add QCS8275 sound card
      ASoC: qcom: sc8280xp: Add support for QCS8275

Richard Fitzgerald (1):
      firmware: cs_dsp: Remove unused struct list_head from cs_dsp_coeff_ctl

Rob Herring (Arm) (1):
      ASoC: Use of_reserved_mem_region_to_resource() for "memory-region"

Sachin Mokashi (1):
      ASoC: Intel: Replace deprecated strcpy() with strscpy()

Sakari Ailus (13):
      PM: runtime: Document return values of suspend-related API functions
      PM: runtime: Mark last busy stamp in pm_runtime_put_autosuspend()
      PM: runtime: Mark last busy stamp in pm_runtime_put_sync_autosuspend()
      PM: runtime: Mark last busy stamp in pm_runtime_autosuspend()
      PM: runtime: Mark last busy stamp in pm_request_autosuspend()
      Documentation: PM: *_autosuspend() functions update last busy time
      ASoC: atmel: Remove redundant pm_runtime_mark_last_busy() calls
      ASoC: codecs: Remove redundant pm_runtime_mark_last_busy() calls
      ASoC: Intel: Remove redundant pm_runtime_mark_last_busy() calls
      ASoC: component: Remove redundant pm_runtime_mark_last_busy() calls
      ASoC: SOF: Remove redundant pm_runtime_mark_last_busy() calls
      ALSA: intel_hdmi: Remove redundant pm_runtime_mark_last_busy() calls
      ALSA: hda: Remove redundant pm_runtime_mark_last_busy() calls

Seppo Ingalsuo (1):
      ASoC: SOF: ipc4-topology: Add load of ASRC component

Shenghao Ding (2):
      ASoC: tas2781: Drop the unnecessary symbol imply
      ASoC: tas2781: Move the "include linux/debugfs.h" into tas2781.h

Shengjiu Wang (4):
      ASoC: wm8524: enable constraints when sysclk is configured.
      ASoC: fsl_mqs: Distinguish different modules by system manager indices
      ASoC: fsl_mqs: rename system manager indices for i.MX95
      ASoC: fsl-asoc-card: add sysclk_ratio for calculate sysclk frequency

Shuming Fan (3):
      ASoC: SDCA: add support for HIDE entity properties and HID descriptor/report
      ASoC: SDCA: add a HID device for HIDE entity
      ASoC: SDCA: add route by the number of input pins in MU entity

Srinivas Kandagatla (1):
      ASoC: qcom: use drvdata instead of component to keep id

Stefan Binding (3):
      ALSA: hda: cs35l41: Add support for center channel in CS35L41 HDA
      ALSA: hda/realtek: Add support for ASUS NUC using CS35L41 HDA
      ALSA: hda/realtek: Add support for ASUS Commercial laptops using CS35L41 HDA

Stephen Rothwell (1):
      ASoC: SDCA: Check devm_mutex_init() return value

Takashi Iwai (139):
      ALSA: hda/ca0132: Use const char * for strings
      ALSA: usb-audio: Fix build with CONFIG_INPUT=n
      ALSA: hda: Disable jack polling at shutdown
      ALSA: hda: Disable codec runtime PM when jack polling is enabled
      ALSA: hda: Handle the jack polling always via a work
      ALSA: hda: Add device entry for QEMU
      ALSA: control: Use safer strscpy() instead of strcpy()
      ALSA: rawmidi: Use safer strscpy() instead of strcpy()
      ALSA: seq: Use safer strscpy() instead of strcpy()
      ALSA: mpu401: Use safer strscpy() instead of strcpy()
      ALSA: opl3: Use safer strscpy() instead of strcpy()
      ALSA: opl4: Use safer strscpy() instead of strcpy()
      ALSA: pcsp: Use safer strscpy() instead of strcpy()
      ALSA: portman2x4: Use safer strscpy() instead of strcpy()
      ALSA: serial-generic: Use safer strscpy() instead of strcpy()
      ALSA: serial-u16550: Use safer strscpy() instead of strcpy()
      ALSA: virmidi: Use safer strscpy() instead of strcpy()
      ALSA: vx: Use safer strscpy() instead of strcpy()
      ALSA: firewire: bebob: Use safer strscpy() instead of strcpy()
      ALSA: firewire: dice: Use safer strscpy() instead of strcpy()
      ALSA: firewire: digi00x: Use safer strscpy() instead of strcpy()
      ALSA: firewire: fireface: Use safer strscpy() instead of strcpy()
      ALSA: firewire: fireworks: Use safer strscpy() instead of strcpy()
      ALSA: firewire: isight: Use safer strscpy() instead of strcpy()
      ALSA: firewire: motu: Use safer strscpy() instead of strcpy()
      ALSA: firewire: oxfw: Use safer strscpy() instead of strcpy()
      ALSA: firewire: tascam: Use safer strscpy() instead of strcpy()
      ALSA: ad1816a: Use safer strscpy() instead of strcpy()
      ALSA: adlib: Use safer strscpy() instead of strcpy()
      ALSA: als100: Use safer strscpy() instead of strcpy()
      ALSA: cmi8328: Use safer strscpy() instead of strcpy()
      ALSA: cmi8330: Use safer strscpy() instead of strcpy()
      ALSA: cs423x: Use safer strscpy() instead of strcpy()
      ALSA: es1688: Use safer strscpy() instead of strcpy()
      ALSA: es18xx: Use safer strscpy() instead of strcpy()
      ALSA: galaxy: Use safer strscpy() instead of strcpy()
      ALSA: gus: Use safer strscpy() instead of strcpy()
      ALSA: msnd: Use safer strscpy() instead of strcpy()
      ALSA: opl3sa2: Use safer strscpy() instead of strcpy()
      ALSA: opti9xx: Use safer strscpy() instead of strcpy()
      ALSA: sc6000: Use safer strscpy() instead of strcpy()
      ALSA: sscape: Use safer strscpy() instead of strcpy()
      ALSA: wavefront: Use safer strscpy() instead of strcpy()
      ALSA: wss: Use safer strscpy() instead of strcpy()
      ALSA: mips: Use safer strscpy() instead of strcpy()
      ALSA: parisc: Use safer strscpy() instead of strcpy()
      ALSA: ac97: Use safer strscpy() instead of strcpy()
      ALSA: ad1889: Use safer strscpy() instead of strcpy()
      ALSA: ak4531: Use safer strscpy() instead of strcpy()
      ALSA: ali5451: Use safer strscpy() instead of strcpy()
      ALSA: als300: Use safer strscpy() instead of strcpy()
      ALSA: als4000: Use safer strscpy() instead of strcpy()
      ALSA: asihpi: Use safer strscpy() instead of strcpy()
      ALSA: atiixp: Use safer strscpy() instead of strcpy()
      ALSA: au88x0: Use safer strscpy() instead of strcpy()
      ALSA: aw2: Use safer strscpy() instead of strcpy()
      ALSA: azt3328: Use safer strscpy() instead of strcpy()
      ALSA: bt87x: Use safer strscpy() instead of strcpy()
      ALSA: ca0106: Use safer strscpy() instead of strcpy()
      ALSA: cmipci: Use safer strscpy() instead of strcpy()
      ALSA: cs4281: Use safer strscpy() instead of strcpy()
      ALSA: cs46xx: Use safer strscpy() instead of strcpy()
      ALSA: cs5530: Use safer strscpy() instead of strcpy()
      ALSA: cs5535audio: Use safer strscpy() instead of strcpy()
      ALSA: ctxfi: Use safer strscpy() instead of strcpy()
      ALSA: echoaudio: Use safer strscpy() instead of strcpy()
      ALSA: emu10k1: Use safer strscpy() instead of strcpy()
      ALSA: ens1370: Use safer strscpy() instead of strcpy()
      ALSA: es1938: Use safer strscpy() instead of strcpy()
      ALSA: es1968: Use safer strscpy() instead of strcpy()
      ALSA: fm801: Use safer strscpy() instead of strcpy()
      ALSA: ice1712: Use safer strscpy() instead of strcpy()
      ALSA: ice1724: Use safer strscpy() instead of strcpy()
      ALSA: intel8x0: Use safer strscpy() instead of strcpy()
      ALSA: korg1212: Use safer strscpy() instead of strcpy()
      ALSA: lola: Use safer strscpy() instead of strcpy()
      ALSA: lx6464es: Use safer strscpy() instead of strcpy()
      ALSA: maestro3: Use safer strscpy() instead of strcpy()
      ALSA: mixart: Use safer strscpy() instead of strcpy()
      ALSA: nm256: Use safer strscpy() instead of strcpy()
      ALSA: oxygen: Use safer strscpy() instead of strcpy()
      ALSA: pcxhr: Use safer strscpy() instead of strcpy()
      ALSA: riptide: Use safer strscpy() instead of strcpy()
      ALSA: rme32: Use safer strscpy() instead of strcpy()
      ALSA: rme96: Use safer strscpy() instead of strcpy()
      ALSA: hdsp: Use safer strscpy() instead of strcpy()
      ALSA: hdspm: Use safer strscpy() instead of strcpy()
      ALSA: rme9652: Use safer strscpy() instead of strcpy()
      ALSA: sis7019: Use safer strscpy() instead of strcpy()
      ALSA: sonicvibes: Use safer strscpy() instead of strcpy()
      ALSA: trident: Use safer strscpy() instead of strcpy()
      ALSA: via82xx: Use safer strscpy() instead of strcpy()
      ALSA: ymfpci: Use safer strscpy() instead of strcpy()
      ALSA: pdaudiocf: Use safer strscpy() instead of strcpy()
      ALSA: vxpocket: Use safer strscpy() instead of strcpy()
      ALSA: ppc: Use safer strscpy() instead of strcpy()
      ALSA: sh: Use safer strscpy() instead of strcpy()
      ALSA: sparc: Use safer strscpy() instead of strcpy()
      ALSA: spi: Use safer strscpy() instead of strcpy()
      ALSA: synth: Use safer strscpy() instead of strcpy()
      ALSA: 6fire: Use safer strscpy() instead of strcpy()
      ALSA: line6: Use safer strscpy() instead of strcpy()
      ALSA: usx2y: Use safer strscpy() instead of strcpy()
      ALSA: ua101: Use safer strscpy() instead of strcpy()
      ALSA: usb-audio: Use safer strscpy() instead of strcpy()
      ALSA: ac97: Copy string more safely
      ALSA: cmipci: Copy string more safely
      ALSA: usb-audio: Copy string more safely
      ALSA: core: Copy string more safely
      ALSA: hda: Move widget capability macros into hdaudio.h
      ALSA: hda: Move HD-audio core stuff into sound/hda/core
      ALSA: hda: Move common codec driver into sound/hda/common directory
      ALSA: hda: Move CONFIG_SND_HDA_PREALLOC_SIZE into sound/hda/common
      ALSA: hda: Move controller drivers into sound/hda/controllers directory
      ALSA: hda: Move codec drivers into sound/hda/codecs directory
      ALSA: hda: Split Realtek HD-audio codec driver
      ALSA: hda/hdmi: Split vendor codec drivers
      ALSA: hda: Introduce hda_codec_driver ops
      ALSA: hda/generic: Rewrite to new probe method
      ALSA: hda/realtek: Rewrite to new probe method
      ALSA: hda/cmedia: Rewrite to new probe method
      ALSA: hda/analog: Rewrite to new probe method
      ALSA: hda/ca0110: Rewrite to new probe method
      ALSA: hda/cirrus: Split to cs420x and cs421x drivers
      ALSA: hda/cs8409: Rewrite to new probe method
      ALSA: hda/conexant: Rewrite to new probe method
      ALSA: hda/senary: Rewrite to new probe method
      ALSA: hda/si3054: Rewrite to new probe method
      ALSA: hda/via: Rewrite to new probe method
      ALSA: hda/sigmatel: Rewrite to new probe method
      ALSA: hda/ca0132: Rewrite to new probe method
      ALSA: hda/hdmi: Rewrite to new probe method
      ALSA: hda: Drop old codec binding method
      ALSA: hda: Drop superfluous driver->ops NULL checks
      MAINTAINERS: Adjust to the new HD-audio driver paths
      ALSA: hda: Return the codec init error properly at snd_hda_codec_build_controls()
      ALSA: hda: Use safer strscpy() instead of strcpy()
      arm: multi_v7_defconfig: Update HD-audio configs
      mips: loongson3_defconfig: Update HD-audio configs

Terry Cheong (1):
      ASoC: hdmi-codec: use SND_JACK_AVOUT as jack status

Thorsten Blum (12):
      ALSA: mips/sgio2audio: Replace deprecated strcpy() with strscpy()
      ALSA: emu10k1: Replace deprecated strcpy() with strscpy()
      ALSA: aloop: Replace deprecated strcpy() with strscpy()
      ALSA: mixer_oss: Remove deprecated strcpy() function calls
      ALSA: timer: Replace deprecated strcpy() with strscpy()
      ALSA: hrtimer: Replace deprecated strcpy() with strscpy()
      ALSA: dummy: Replace deprecated strcpy() with strscpy()
      ALSA: pcmtest: Replace deprecated strcpy() with strscpy()
      ALSA: mtpav: Replace deprecated strcpy() with strscpy()
      ALSA: hda: Remove old commented out sanity check
      ALSA: mts64: Replace deprecated strcpy() with strscpy()
      ALSA: echoaudio: Replace deprecated strcpy() with strscpy()

Venkata Prasad Potturu (4):
      ASoC: amd: acp: Fix pointer assignments for snd_soc_acpi_mach structures
      ASoC: amd: acp: Add legacy driver support acp7.2 based platforms
      ASoC: amd: acp: Enable I2S support for acp7.2 based platforms
      ASoC: amd: acp: Enable acp7.2 platform based DMIC support in machine driver

Vijendar Mukunda (2):
      ASoC: amd: acp: add soundwire machine for ACP7.0 and ACP7.1 sof stack
      ASoC: SOF: amd: add alternate machines for ACP7.0 and ACP7.1 platforms

Weidong Wang (1):
      ASoC: codecs: Add calibration function to aw88399 chip

Xinxin Wan (1):
      ASoC: codecs: rt5640: Retry DEVICE_ID verification

wangdicheng (2):
      ALSA: hda/conexant: Renaming the codec with device ID 0x1f86 and 0x1f87
      ALSA: hda/realtek: Fixup ft alc257 rename alc3328

---
 .../devicetree/bindings/sound/cirrus,cs42xx8.yaml  |    4 +
 .../bindings/sound/fsl,mxs-audio-sgtl5000.yaml     |   81 +
 .../bindings/sound/mediatek,mt8173-afe-pcm.yaml    |   98 +
 .../devicetree/bindings/sound/mt8186-afe-pcm.yaml  |    5 +
 .../devicetree/bindings/sound/mt8192-afe-pcm.yaml  |    5 +
 .../devicetree/bindings/sound/mtk-afe-pcm.txt      |   45 -
 .../bindings/sound/mxs-audio-sgtl5000.txt          |   42 -
 .../bindings/sound/qcom,lpass-va-macro.yaml        |   28 +-
 .../devicetree/bindings/sound/qcom,q6afe.yaml      |   13 +
 .../devicetree/bindings/sound/qcom,sm8250.yaml     |    2 +
 .../devicetree/bindings/sound/qcom,wcd939x.yaml    |    3 +
 .../devicetree/bindings/sound/richtek,rt9123.yaml  |    9 +-
 .../devicetree/bindings/sound/ti,tas57xx.yaml      |    2 +
 Documentation/power/runtime_pm.rst                 |   50 +-
 MAINTAINERS                                        |   21 +-
 arch/arm/configs/multi_v7_defconfig                |    5 +-
 arch/mips/configs/generic/board-marduk.config      |    1 -
 arch/mips/configs/loongson3_defconfig              |    4 +-
 drivers/firmware/cirrus/cs_dsp.c                   |   45 +-
 drivers/hid/hid-core.c                             |    3 +
 include/linux/firmware/cirrus/cs_dsp.h             |    2 -
 include/linux/firmware/imx/sm.h                    |   20 +-
 include/linux/pm_runtime.h                         |  187 +-
 include/sound/cs35l41.h                            |   12 +
 include/sound/hda_codec.h                          |   40 +-
 include/sound/hdaudio.h                            |   24 +
 include/sound/sdca_asoc.h                          |   19 +
 include/sound/sdca_function.h                      |   71 +
 include/sound/sdca_hid.h                           |   25 +
 include/sound/sdca_interrupts.h                    |   78 +
 include/sound/soc-component.h                      |    1 -
 include/sound/soc-dai.h                            |    3 +
 include/sound/soc-dapm.h                           |  236 +-
 include/sound/soc_sdw_utils.h                      |    1 +
 include/sound/sof/ipc4/header.h                    |    2 +
 include/sound/tas2770-tlv.h                        |   23 +
 include/sound/tas2781.h                            |    4 +
 include/sound/tlv320aic32x4.h                      |    9 -
 include/uapi/linux/input.h                         |    1 +
 sound/core/control.c                               |    2 +-
 sound/core/hrtimer.c                               |    3 +-
 sound/core/init.c                                  |   16 +-
 sound/core/oss/mixer_oss.c                         |   10 +-
 sound/core/pcm_compat.c                            |   20 +-
 sound/core/pcm_native.c                            |  117 +-
 sound/core/rawmidi.c                               |    6 +-
 sound/core/seq/oss/seq_oss_init.c                  |    4 +-
 sound/core/seq/seq_clientmgr.c                     |    2 +-
 sound/core/seq/seq_midi.c                          |    2 +-
 sound/core/seq/seq_system.c                        |    4 +-
 sound/core/seq/seq_ump_client.c                    |    2 +-
 sound/core/seq/seq_virmidi.c                       |    2 +-
 sound/core/timer.c                                 |    2 +-
 sound/drivers/aloop.c                              |    9 +-
 sound/drivers/dummy.c                              |    9 +-
 sound/drivers/mpu401/mpu401.c                      |    4 +-
 sound/drivers/mtpav.c                              |   11 +-
 sound/drivers/mts64.c                              |    9 +-
 sound/drivers/opl3/opl3_lib.c                      |   14 +-
 sound/drivers/opl4/opl4_lib.c                      |    2 +-
 sound/drivers/pcmtest.c                            |    9 +-
 sound/drivers/pcsp/pcsp.c                          |    4 +-
 sound/drivers/pcsp/pcsp_lib.c                      |    2 +-
 sound/drivers/pcsp/pcsp_mixer.c                    |    2 +-
 sound/drivers/portman2x4.c                         |    6 +-
 sound/drivers/serial-generic.c                     |    4 +-
 sound/drivers/serial-u16550.c                      |    6 +-
 sound/drivers/virmidi.c                            |    6 +-
 sound/drivers/vx/vx_core.c                         |    2 +-
 sound/drivers/vx/vx_mixer.c                        |    2 +-
 sound/drivers/vx/vx_pcm.c                          |    2 +-
 sound/firewire/bebob/bebob.c                       |    6 +-
 sound/firewire/bebob/bebob_hwdep.c                 |    2 +-
 sound/firewire/dice/dice-hwdep.c                   |    2 +-
 sound/firewire/dice/dice-pcm.c                     |    2 +-
 sound/firewire/dice/dice.c                         |   10 +-
 sound/firewire/digi00x/digi00x-hwdep.c             |    2 +-
 sound/firewire/digi00x/digi00x.c                   |    6 +-
 sound/firewire/fireface/ff-hwdep.c                 |    2 +-
 sound/firewire/fireface/ff.c                       |    6 +-
 sound/firewire/fireworks/fireworks.c               |    6 +-
 sound/firewire/fireworks/fireworks_hwdep.c         |    2 +-
 sound/firewire/isight.c                            |    8 +-
 sound/firewire/motu/motu-hwdep.c                   |    2 +-
 sound/firewire/motu/motu-pcm.c                     |    2 +-
 sound/firewire/motu/motu.c                         |    6 +-
 sound/firewire/oxfw/oxfw-hwdep.c                   |    2 +-
 sound/firewire/oxfw/oxfw-pcm.c                     |    2 +-
 sound/firewire/oxfw/oxfw.c                         |    6 +-
 sound/firewire/tascam/tascam-hwdep.c               |    2 +-
 sound/firewire/tascam/tascam.c                     |    6 +-
 sound/hda/Kconfig                                  |   70 +-
 sound/hda/Makefile                                 |   28 +-
 sound/hda/codecs/Kconfig                           |  137 +
 sound/hda/codecs/Makefile                          |   34 +
 .../hda/patch_analog.c => hda/codecs/analog.c}     |  223 +-
 .../hda/patch_ca0110.c => hda/codecs/ca0110.c}     |   37 +-
 .../hda/patch_ca0132.c => hda/codecs/ca0132.c}     |  153 +-
 sound/{pci/hda => hda/codecs}/ca0132_regs.h        |    2 +-
 sound/hda/codecs/cirrus/Kconfig                    |   31 +
 sound/hda/codecs/cirrus/Makefile                   |   10 +
 .../patch_cirrus.c => hda/codecs/cirrus/cs420x.c}  |  528 +-
 sound/hda/codecs/cirrus/cs421x.c                   |  590 ++
 .../codecs/cirrus/cs8409-tables.c}                 |    4 +-
 .../patch_cs8409.c => hda/codecs/cirrus/cs8409.c}  |   57 +-
 .../patch_cs8409.h => hda/codecs/cirrus/cs8409.h}  |    6 +-
 .../hda/patch_cmedia.c => hda/codecs/cm9825.c}     |  140 +-
 sound/hda/codecs/cmedia.c                          |  106 +
 .../hda/patch_conexant.c => hda/codecs/conexant.c} |  120 +-
 .../hda/hda_generic.c => hda/codecs/generic.c}     |   60 +-
 .../hda/hda_generic.h => hda/codecs/generic.h}     |    2 +-
 sound/hda/codecs/hdmi/Kconfig                      |   68 +
 sound/hda/codecs/hdmi/Makefile                     |   18 +
 sound/hda/codecs/hdmi/atihdmi.c                    |  615 ++
 sound/{pci/hda/hda_eld.c => hda/codecs/hdmi/eld.c} |  172 -
 sound/hda/codecs/hdmi/hdmi.c                       | 2416 ++++++++
 sound/hda/codecs/hdmi/hdmi_local.h                 |  302 +
 sound/hda/codecs/hdmi/intelhdmi.c                  |  811 +++
 sound/hda/codecs/hdmi/nvhdmi-mcp.c                 |  384 ++
 sound/hda/codecs/hdmi/nvhdmi.c                     |  223 +
 sound/hda/codecs/hdmi/simplehdmi.c                 |  251 +
 sound/hda/codecs/hdmi/tegrahdmi.c                  |  316 ++
 .../codecs/helpers/hp_x360.c}                      |    0
 .../codecs/helpers/ideapad_hotkey_led.c}           |    0
 .../codecs/helpers/ideapad_s740.c}                 |    0
 .../codecs/helpers/thinkpad.c}                     |    0
 sound/hda/codecs/realtek/Kconfig                   |   90 +
 sound/hda/codecs/realtek/Makefile                  |   26 +
 sound/hda/codecs/realtek/alc260.c                  |  290 +
 sound/hda/codecs/realtek/alc262.c                  |  213 +
 sound/hda/codecs/realtek/alc268.c                  |  190 +
 .../codecs/realtek/alc269.c}                       | 5861 +-------------------
 sound/hda/codecs/realtek/alc662.c                  | 1116 ++++
 sound/hda/codecs/realtek/alc680.c                  |   67 +
 sound/hda/codecs/realtek/alc861.c                  |  163 +
 sound/hda/codecs/realtek/alc861vd.c                |  137 +
 sound/hda/codecs/realtek/alc880.c                  |  509 ++
 sound/hda/codecs/realtek/alc882.c                  |  861 +++
 sound/hda/codecs/realtek/realtek.c                 | 2299 ++++++++
 sound/hda/codecs/realtek/realtek.h                 |  298 +
 .../patch_senarytech.c => hda/codecs/senarytech.c} |   50 +-
 .../hda/patch_si3054.c => hda/codecs/si3054.c}     |   53 +-
 sound/hda/codecs/side-codecs/Kconfig               |  128 +
 sound/hda/codecs/side-codecs/Makefile              |   28 +
 .../hda => hda/codecs/side-codecs}/cirrus_scodec.c |    0
 .../hda => hda/codecs/side-codecs}/cirrus_scodec.h |    0
 .../codecs/side-codecs}/cirrus_scodec_test.c       |    0
 .../hda => hda/codecs/side-codecs}/cs35l41_hda.c   |  111 +-
 .../hda => hda/codecs/side-codecs}/cs35l41_hda.h   |    1 +
 .../codecs/side-codecs}/cs35l41_hda_i2c.c          |    0
 .../codecs/side-codecs}/cs35l41_hda_property.c     |    0
 .../codecs/side-codecs}/cs35l41_hda_property.h     |    0
 .../codecs/side-codecs}/cs35l41_hda_spi.c          |    0
 .../hda => hda/codecs/side-codecs}/cs35l56_hda.c   |    7 +-
 .../hda => hda/codecs/side-codecs}/cs35l56_hda.h   |    0
 .../codecs/side-codecs}/cs35l56_hda_i2c.c          |    0
 .../codecs/side-codecs}/cs35l56_hda_spi.c          |    0
 .../hda => hda/codecs/side-codecs}/hda_component.c |    0
 .../hda => hda/codecs/side-codecs}/hda_component.h |    0
 .../hda => hda/codecs/side-codecs}/tas2781_hda.c   |    0
 .../hda => hda/codecs/side-codecs}/tas2781_hda.h   |    0
 .../codecs/side-codecs}/tas2781_hda_i2c.c          |  177 +-
 .../codecs/side-codecs}/tas2781_hda_spi.c          |    6 +-
 .../hda/patch_sigmatel.c => hda/codecs/sigmatel.c} |  402 +-
 sound/{pci/hda/patch_via.c => hda/codecs/via.c}    |  447 +-
 sound/hda/common/Kconfig                           |   97 +
 sound/hda/common/Makefile                          |   13 +
 .../hda_auto_parser.c => hda/common/auto_parser.c} |    0
 sound/{pci/hda/hda_beep.c => hda/common/beep.c}    |    0
 sound/{pci/hda/hda_bind.c => hda/common/bind.c}    |   29 +-
 sound/{pci/hda/hda_codec.c => hda/common/codec.c}  |  126 +-
 .../hda_controller.c => hda/common/controller.c}   |    2 +-
 .../common/controller_trace.h}                     |    2 +-
 sound/{pci/hda => hda/common}/hda_auto_parser.h    |    0
 sound/{pci/hda => hda/common}/hda_beep.h           |    0
 sound/{pci/hda => hda/common}/hda_controller.h     |    0
 sound/{pci/hda => hda/common}/hda_jack.h           |    0
 sound/{pci/hda => hda/common}/hda_local.h          |   13 +-
 sound/{pci/hda/hda_hwdep.c => hda/common/hwdep.c}  |    0
 sound/{pci/hda/hda_jack.c => hda/common/jack.c}    |    0
 sound/{pci/hda/hda_proc.c => hda/common/proc.c}    |    0
 sound/{pci/hda/hda_sysfs.c => hda/common/sysfs.c}  |    0
 sound/hda/controllers/Kconfig                      |   42 +
 sound/hda/controllers/Makefile                     |   13 +
 .../{pci/hda/hda_acpi.c => hda/controllers/acpi.c} |    0
 .../hda/hda_intel.c => hda/controllers/intel.c}    |    7 +-
 .../hda/hda_intel.h => hda/controllers/intel.h}    |    0
 .../controllers/intel_trace.h}                     |    2 +-
 .../hda/hda_tegra.c => hda/controllers/tegra.c}    |    0
 sound/hda/core/Kconfig                             |   51 +
 sound/hda/core/Makefile                            |   22 +
 sound/hda/{ => core}/array.c                       |    0
 sound/hda/{hdac_bus.c => core/bus.c}               |    0
 sound/hda/{hdac_component.c => core/component.c}   |    0
 sound/hda/{hdac_controller.c => core/controller.c} |    0
 sound/hda/{hdac_device.c => core/device.c}         |    9 +-
 sound/hda/{ => core}/ext/Makefile                  |    2 +-
 sound/hda/{ext/hdac_ext_bus.c => core/ext/bus.c}   |    0
 .../ext/controller.c}                              |    0
 .../{ext/hdac_ext_stream.c => core/ext/stream.c}   |    0
 sound/hda/{ => core}/hda_bus_type.c                |    0
 sound/hda/{ => core}/hdmi_chmap.c                  |    0
 sound/hda/{hdac_i915.c => core/i915.c}             |    0
 sound/hda/{ => core}/intel-dsp-config.c            |    0
 sound/hda/{ => core}/intel-nhlt.c                  |    0
 sound/hda/{ => core}/intel-sdw-acpi.c              |    0
 sound/hda/{ => core}/local.h                       |   21 -
 sound/hda/{hdac_regmap.c => core/regmap.c}         |    0
 sound/hda/{hdac_stream.c => core/stream.c}         |    0
 sound/hda/{hdac_sysfs.c => core/sysfs.c}           |   14 +-
 sound/hda/{ => core}/trace.c                       |    0
 sound/hda/{ => core}/trace.h                       |    0
 sound/isa/ad1816a/ad1816a.c                        |    4 +-
 sound/isa/ad1816a/ad1816a_lib.c                    |    6 +-
 sound/isa/adlib.c                                  |    4 +-
 sound/isa/als100.c                                 |    8 +-
 sound/isa/cmi8328.c                                |   20 +-
 sound/isa/cmi8330.c                                |    8 +-
 sound/isa/cs423x/cs4236.c                          |    2 +-
 sound/isa/cs423x/cs4236_lib.c                      |    2 +-
 sound/isa/es1688/es1688_lib.c                      |    4 +-
 sound/isa/es18xx.c                                 |    2 +-
 sound/isa/galaxy/galaxy.c                          |    4 +-
 sound/isa/gus/gus_main.c                           |   16 +-
 sound/isa/gus/gus_mixer.c                          |    2 +-
 sound/isa/gus/gus_pcm.c                            |    2 +-
 sound/isa/gus/gus_timer.c                          |    4 +-
 sound/isa/gus/gus_uart.c                           |    2 +-
 sound/isa/gus/gusextreme.c                         |    8 +-
 sound/isa/gus/gusmax.c                             |   16 +-
 sound/isa/gus/interwave.c                          |   34 +-
 sound/isa/msnd/msnd.c                              |    2 +-
 sound/isa/msnd/msnd_pinnacle.c                     |   22 +-
 sound/isa/msnd/msnd_pinnacle_mixer.c               |    2 +-
 sound/isa/opl3sa2.c                                |   20 +-
 sound/isa/opti9xx/miro.c                           |    8 +-
 sound/isa/opti9xx/opti92x-ad1848.c                 |   18 +-
 sound/isa/sc6000.c                                 |   20 +-
 sound/isa/sscape.c                                 |    4 +-
 sound/isa/wavefront/wavefront.c                    |   16 +-
 sound/isa/wss/wss_lib.c                            |    6 +-
 sound/mips/hal2.c                                  |    6 +-
 sound/mips/sgio2audio.c                            |    9 +-
 sound/parisc/harmony.c                             |    8 +-
 sound/pci/Kconfig                                  |    2 -
 sound/pci/Makefile                                 |    1 -
 sound/pci/ac97/ac97_codec.c                        |   23 +-
 sound/pci/ac97/ac97_local.h                        |    2 +-
 sound/pci/ac97/ac97_patch.c                        |    8 +-
 sound/pci/ac97/ac97_proc.c                         |    2 +-
 sound/pci/ad1889.c                                 |    6 +-
 sound/pci/ak4531_codec.c                           |    2 +-
 sound/pci/ali5451/ali5451.c                        |    6 +-
 sound/pci/als300.c                                 |    4 +-
 sound/pci/als4000.c                                |    4 +-
 sound/pci/asihpi/asihpi.c                          |   10 +-
 sound/pci/asihpi/hpi6000.c                         |    2 +-
 sound/pci/atiixp.c                                 |   10 +-
 sound/pci/atiixp_modem.c                           |    6 +-
 sound/pci/au88x0/au88x0.c                          |    4 +-
 sound/pci/au88x0/au88x0_mixer.c                    |    2 +-
 sound/pci/aw2/aw2-alsa.c                           |   10 +-
 sound/pci/azt3328.c                                |   12 +-
 sound/pci/bt87x.c                                  |    6 +-
 sound/pci/ca0106/ca0106_main.c                     |    6 +-
 sound/pci/ca0106/ca0106_mixer.c                    |    4 +-
 sound/pci/ca0106/ca_midi.c                         |    2 +-
 sound/pci/cmipci.c                                 |   25 +-
 sound/pci/cs4281.c                                 |    8 +-
 sound/pci/cs46xx/cs46xx.c                          |    4 +-
 sound/pci/cs46xx/cs46xx_lib.c                      |   20 +-
 sound/pci/cs46xx/dsp_spos.c                        |    8 +-
 sound/pci/cs5530.c                                 |    4 +-
 sound/pci/cs5535audio/cs5535audio.c                |    4 +-
 sound/pci/cs5535audio/cs5535audio_pcm.c            |    2 +-
 sound/pci/ctxfi/ctmixer.c                          |    2 +-
 sound/pci/echoaudio/echoaudio.c                    |   13 +-
 sound/pci/echoaudio/midi.c                         |    2 +-
 sound/pci/emu10k1/emu10k1.c                        |    3 +-
 sound/pci/emu10k1/emu10k1x.c                       |   13 +-
 sound/pci/emu10k1/emufx.c                          |   23 +-
 sound/pci/emu10k1/emumixer.c                       |    9 +-
 sound/pci/emu10k1/emumpu401.c                      |    2 +-
 sound/pci/emu10k1/emupcm.c                         |   10 +-
 sound/pci/emu10k1/p16v.c                           |    2 +-
 sound/pci/emu10k1/timer.c                          |    2 +-
 sound/pci/ens1370.c                                |   10 +-
 sound/pci/es1938.c                                 |    8 +-
 sound/pci/es1968.c                                 |   14 +-
 sound/pci/fm801.c                                  |    6 +-
 sound/pci/hda/Kconfig                              |  436 --
 sound/pci/hda/Makefile                             |   84 -
 sound/pci/hda/patch_hdmi.c                         | 4695 ----------------
 sound/pci/ice1712/ice1712.c                        |   14 +-
 sound/pci/ice1712/ice1724.c                        |   18 +-
 sound/pci/intel8x0.c                               |   16 +-
 sound/pci/intel8x0m.c                              |   10 +-
 sound/pci/korg1212/korg1212.c                      |    6 +-
 sound/pci/lola/lola.c                              |    4 +-
 sound/pci/lx6464es/lx6464es.c                      |    4 +-
 sound/pci/maestro3.c                               |    8 +-
 sound/pci/mixart/mixart.c                          |    6 +-
 sound/pci/nm256/nm256.c                            |    6 +-
 sound/pci/oxygen/oxygen_lib.c                      |    6 +-
 sound/pci/oxygen/oxygen_pcm.c                      |    8 +-
 sound/pci/pcxhr/pcxhr.c                            |    4 +-
 sound/pci/riptide/riptide.c                        |    6 +-
 sound/pci/rme32.c                                  |   12 +-
 sound/pci/rme96.c                                  |   16 +-
 sound/pci/rme9652/hdsp.c                           |   12 +-
 sound/pci/rme9652/hdspm.c                          |    8 +-
 sound/pci/rme9652/rme9652.c                        |   12 +-
 sound/pci/sis7019.c                                |    6 +-
 sound/pci/sonicvibes.c                             |    8 +-
 sound/pci/trident/trident.c                        |    6 +-
 sound/pci/trident/trident_main.c                   |   14 +-
 sound/pci/via82xx.c                                |   20 +-
 sound/pci/via82xx_modem.c                          |    4 +-
 sound/pci/ymfpci/ymfpci.c                          |    2 +-
 sound/pci/ymfpci/ymfpci_main.c                     |    8 +-
 sound/pcmcia/pdaudiocf/pdaudiocf.c                 |    2 +-
 sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c             |    2 +-
 sound/pcmcia/vx/vxpocket.c                         |    2 +-
 sound/ppc/awacs.c                                  |    2 +-
 sound/ppc/burgundy.c                               |    2 +-
 sound/ppc/daca.c                                   |    2 +-
 sound/ppc/pmac.c                                   |    2 +-
 sound/ppc/powermac.c                               |    8 +-
 sound/ppc/snd_ps3.c                                |    8 +-
 sound/sh/aica.c                                    |    8 +-
 sound/sh/sh_dac_audio.c                            |    6 +-
 sound/soc/Kconfig                                  |    8 +-
 sound/soc/adi/Kconfig                              |    9 +-
 sound/soc/amd/Kconfig                              |    3 +
 sound/soc/amd/acp/Kconfig                          |    1 +
 sound/soc/amd/acp/acp-i2s.c                        |    3 +
 sound/soc/amd/acp/acp-legacy-common.c              |    2 +
 sound/soc/amd/acp/acp-mach-common.c                |    1 +
 sound/soc/amd/acp/acp-pci.c                        |    9 +-
 sound/soc/amd/acp/acp-platform.c                   |    2 +
 sound/soc/amd/acp/acp70.c                          |    1 +
 sound/soc/amd/acp/acp_common.h                     |    1 +
 sound/soc/amd/acp/amd-acp70-acpi-match.c           |   12 +
 sound/soc/amd/acp/amd-acpi-mach.c                  |    4 +-
 sound/soc/amd/acp/amd.h                            |    8 +-
 sound/soc/amd/mach-config.h                        |    1 +
 sound/soc/apple/Kconfig                            |    4 +
 sound/soc/atmel/Kconfig                            |   11 +-
 sound/soc/atmel/mchp-spdifrx.c                     |    6 -
 sound/soc/au1x/Kconfig                             |    4 +
 sound/soc/bcm/Kconfig                              |    4 +
 sound/soc/cirrus/Kconfig                           |    3 +
 sound/soc/codecs/Kconfig                           |   12 +-
 sound/soc/codecs/Makefile                          |    4 +-
 sound/soc/codecs/arizona-jack.c                    |    2 -
 sound/soc/codecs/aw88395/aw88395_device.h          |   21 +
 sound/soc/codecs/aw88399.c                         |  440 +-
 sound/soc/codecs/aw88399.h                         |   34 +
 sound/soc/codecs/cros_ec_codec.c                   |   28 +-
 sound/soc/codecs/cs35l36.c                         |    2 +-
 sound/soc/codecs/cs35l41.c                         |    2 -
 sound/soc/codecs/cs35l45.c                         |    1 -
 sound/soc/codecs/cs35l56-sdw.c                     |    1 -
 sound/soc/codecs/cs35l56.c                         |    1 -
 sound/soc/codecs/cs42l42.c                         |    1 -
 sound/soc/codecs/cs42l43-jack.c                    |    5 -
 sound/soc/codecs/cs42l43.c                         |    2 -
 sound/soc/codecs/cs48l32.c                         |    1 -
 sound/soc/codecs/da7218.c                          |    2 +-
 sound/soc/codecs/da7219.c                          |   68 +-
 sound/soc/codecs/es8375.c                          |    2 +-
 sound/soc/codecs/hda.c                             |   20 +-
 sound/soc/codecs/hdac_hda.c                        |   29 +-
 sound/soc/codecs/hdac_hdmi.c                       |  328 +-
 sound/soc/codecs/hdac_hdmi.h                       |   10 -
 sound/soc/codecs/hdmi-codec.c                      |    6 +-
 sound/soc/codecs/lpass-rx-macro.c                  |    1 -
 sound/soc/codecs/lpass-tx-macro.c                  |    1 -
 sound/soc/codecs/lpass-va-macro.c                  |    1 -
 sound/soc/codecs/lpass-wsa-macro.c                 |    1 -
 sound/soc/codecs/max98363.c                        |    3 +-
 sound/soc/codecs/max98373-i2c.c                    |    2 +-
 sound/soc/codecs/max98373-sdw.c                    |    3 +-
 sound/soc/codecs/max98388.c                        |    2 +-
 sound/soc/codecs/max98390.c                        |    2 +-
 sound/soc/codecs/max98396.c                        |    4 +-
 sound/soc/codecs/max98504.c                        |    2 +-
 sound/soc/codecs/max98520.c                        |    2 +-
 sound/soc/codecs/max98927.c                        |    2 +-
 sound/soc/codecs/rt1017-sdca-sdw.c                 |    1 -
 sound/soc/codecs/rt1308-sdw.c                      |    1 -
 sound/soc/codecs/rt1316-sdw.c                      |    1 -
 sound/soc/codecs/rt1318-sdw.c                      |    1 -
 sound/soc/codecs/rt1320-sdw.c                      |    1 -
 sound/soc/codecs/rt5640.c                          |   43 +-
 sound/soc/codecs/rt5640.h                          |    6 +-
 sound/soc/codecs/rt5682-sdw.c                      |    1 -
 sound/soc/codecs/rt5682.c                          |   26 +-
 sound/soc/codecs/rt5682s.c                         |   26 +-
 sound/soc/codecs/rt700.c                           |    4 +-
 sound/soc/codecs/rt711-sdca.c                      |    2 -
 sound/soc/codecs/rt711.c                           |    2 -
 sound/soc/codecs/rt712-sdca-dmic.c                 |    1 -
 sound/soc/codecs/rt712-sdca.c                      |    2 -
 sound/soc/codecs/rt715-sdca.c                      |    1 -
 sound/soc/codecs/rt715.c                           |    3 +-
 sound/soc/codecs/rt721-sdca.c                      |    2 -
 sound/soc/codecs/rt722-sdca-sdw.c                  |    2 +-
 sound/soc/codecs/rt722-sdca.c                      |    2 -
 sound/soc/codecs/rt9123.c                          |    3 -
 sound/soc/codecs/rtq9124.c                         |  543 ++
 sound/soc/codecs/tas2552.c                         |    1 -
 sound/soc/codecs/tas2781-i2c.c                     |    3 -
 sound/soc/codecs/tas571x.c                         |   52 +
 sound/soc/codecs/tlv320aic32x4.c                   |   53 +-
 sound/soc/codecs/wcd-mbhc-v2.c                     |    2 -
 sound/soc/codecs/wcd9335.c                         |    5 -
 sound/soc/codecs/wcd934x.c                         |    4 -
 sound/soc/codecs/wcd937x.c                         |   38 +-
 sound/soc/codecs/wcd937x.h                         |    1 -
 sound/soc/codecs/wcd938x.c                         |   64 +-
 sound/soc/codecs/wcd939x.c                         |   69 +-
 sound/soc/codecs/wm8524.c                          |   57 +-
 sound/soc/codecs/wsa881x.c                         |    5 +-
 sound/soc/codecs/wsa883x.c                         |    3 +-
 sound/soc/codecs/wsa884x.c                         |    3 +-
 sound/soc/dwc/Kconfig                              |    3 +
 sound/soc/fsl/Kconfig                              |    2 +-
 sound/soc/fsl/fsl-asoc-card.c                      |   13 +-
 sound/soc/fsl/fsl_asrc.c                           |    2 +-
 sound/soc/fsl/fsl_mqs.c                            |   11 +-
 sound/soc/fsl/fsl_sai.c                            |    4 +-
 sound/soc/fsl/imx-card.c                           |   13 +-
 sound/soc/generic/Kconfig                          |    4 +
 sound/soc/google/Kconfig                           |    3 +
 sound/soc/hisilicon/Kconfig                        |    4 +
 sound/soc/img/Kconfig                              |   14 +-
 sound/soc/intel/Kconfig                            |    4 +
 sound/soc/intel/atom/sst/sst_pvt.c                 |    1 -
 sound/soc/intel/avs/board_selection.c              |   27 +
 sound/soc/intel/avs/boards/Kconfig                 |   12 +
 sound/soc/intel/avs/boards/Makefile                |    2 +
 sound/soc/intel/avs/boards/rt5640.c                |  270 +
 sound/soc/intel/avs/core.c                         |    1 -
 sound/soc/intel/avs/debugfs.c                      |    2 -
 sound/soc/intel/avs/ipc.c                          |    1 -
 sound/soc/intel/avs/pcm.c                          |    1 -
 sound/soc/intel/boards/cht_bsw_rt5672.c            |    3 +-
 sound/soc/intel/boards/skl_hda_dsp_generic.c       |   13 +
 sound/soc/intel/boards/sof_es8336.c                |   10 +
 sound/soc/intel/boards/sof_rt5682.c                |    7 +
 sound/soc/intel/boards/sof_sdw.c                   |   14 +
 sound/soc/intel/catpt/pcm.c                        |    6 -
 sound/soc/intel/catpt/sysfs.c                      |    1 -
 sound/soc/intel/common/soc-acpi-intel-lnl-match.c  |   34 +
 sound/soc/intel/common/soc-acpi-intel-ptl-match.c  |   57 +
 sound/soc/jz4740/Kconfig                           |    4 +
 sound/soc/kirkwood/Kconfig                         |    3 +
 sound/soc/loongson/Kconfig                         |    2 +-
 sound/soc/mediatek/Kconfig                         |    4 +
 .../soc/mediatek/common/mtk-afe-platform-driver.c  |    4 +-
 sound/soc/mediatek/common/mtk-base-afe.h           |    1 +
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c         |   66 +-
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c         |   56 +-
 sound/soc/mediatek/mt8186/mt8186-afe-pcm.c         |    7 +
 sound/soc/mediatek/mt8188/mt8188-mt6359.c          |    4 +-
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c         |    7 +
 sound/soc/meson/Kconfig                            |    2 +-
 sound/soc/meson/axg-card.c                         |    3 +-
 sound/soc/meson/meson-card-utils.c                 |   16 +-
 sound/soc/mxs/Kconfig                              |    2 +-
 sound/soc/pxa/Kconfig                              |    4 +
 sound/soc/qcom/Kconfig                             |    2 +-
 sound/soc/qcom/lpass-platform.c                    |   27 +-
 sound/soc/qcom/qdsp6/q6dsp-lpass-clocks.c          |    8 +-
 sound/soc/qcom/sc8280xp.c                          |    1 +
 sound/soc/qcom/sm8250.c                            |   28 +-
 sound/soc/renesas/Kconfig                          |    2 +-
 sound/soc/renesas/rcar/core.c                      |   35 +-
 sound/soc/renesas/rcar/ctu.c                       |    8 +-
 sound/soc/renesas/rcar/dma.c                       |    4 +-
 sound/soc/renesas/rcar/dvc.c                       |    8 +-
 sound/soc/renesas/rcar/mix.c                       |    8 +-
 sound/soc/renesas/rcar/msiof.c                     |   94 +-
 sound/soc/renesas/rcar/src.c                       |   10 +-
 sound/soc/renesas/rcar/ssi.c                       |   18 +-
 sound/soc/renesas/rcar/ssiu.c                      |    7 +-
 sound/soc/rockchip/Kconfig                         |   23 +-
 sound/soc/rockchip/rockchip_sai.c                  |   52 +-
 sound/soc/samsung/Kconfig                          |    2 +-
 sound/soc/samsung/bells.c                          |    2 -
 sound/soc/samsung/littlemill.c                     |    2 -
 sound/soc/samsung/speyside.c                       |    2 -
 sound/soc/samsung/tobermory.c                      |    2 -
 sound/soc/sdca/Kconfig                             |   20 +
 sound/soc/sdca/Makefile                            |    6 +-
 sound/soc/sdca/sdca_asoc.c                         |  469 +-
 sound/soc/sdca/sdca_functions.c                    |  165 +-
 sound/soc/sdca/sdca_hid.c                          |  127 +
 sound/soc/sdca/sdca_interrupts.c                   |  444 ++
 sound/soc/sdw_utils/soc_sdw_cs_amp.c               |   10 -
 sound/soc/sdw_utils/soc_sdw_maxim.c                |    9 -
 sound/soc/sdw_utils/soc_sdw_rt_amp.c               |    6 -
 sound/soc/sdw_utils/soc_sdw_rt_mf_sdca.c           |    7 -
 sound/soc/sdw_utils/soc_sdw_utils.c                |   38 +
 sound/soc/soc-component.c                          |    1 -
 sound/soc/soc-core.c                               |   25 +-
 sound/soc/soc-dai.c                                |   16 +-
 sound/soc/soc-dapm.c                               |  882 ++-
 sound/soc/soc-ops-test.c                           |   29 +-
 sound/soc/soc-ops.c                                |   28 +-
 sound/soc/soc-topology.c                           |    7 +-
 sound/soc/sof/Kconfig                              |    2 +-
 sound/soc/sof/amd/pci-acp70.c                      |    1 +
 sound/soc/sof/control.c                            |    1 -
 sound/soc/sof/debug.c                              |    1 -
 sound/soc/sof/imx/imx-common.c                     |   36 +-
 sound/soc/sof/intel/hda-loader.c                   |    7 +-
 sound/soc/sof/intel/hda.c                          |    5 +
 sound/soc/sof/ipc3-dtrace.c                        |    1 -
 sound/soc/sof/ipc4-loader.c                        |    7 +-
 sound/soc/sof/ipc4-pcm.c                           |  137 +-
 sound/soc/sof/ipc4-priv.h                          |    6 +
 sound/soc/sof/ipc4-topology.c                      |   94 +-
 sound/soc/sof/ipc4-topology.h                      |   25 +
 sound/soc/sof/ipc4.c                               |   39 +-
 sound/soc/sof/mediatek/mt8186/mt8186.c             |   11 +-
 sound/soc/sof/mediatek/mt8195/mt8195.c             |   11 +-
 sound/soc/sof/pcm.c                                |   27 +-
 sound/soc/sof/sof-client-ipc-flood-test.c          |    1 -
 sound/soc/sof/sof-client-ipc-kernel-injector.c     |    1 -
 sound/soc/sof/sof-client-ipc-msg-injector.c        |    1 -
 sound/soc/sof/sof-client-probes.c                  |    3 -
 sound/soc/sof/topology.c                           |   15 +-
 sound/soc/spear/Kconfig                            |    4 +
 sound/soc/sprd/Kconfig                             |    4 +
 sound/soc/starfive/Kconfig                         |   12 +-
 sound/soc/sti/Kconfig                              |    2 +-
 sound/soc/stm/Kconfig                              |    2 +-
 sound/soc/stm/stm32_i2s.c                          |   21 +-
 sound/soc/stm/stm32_sai_sub.c                      |   14 +-
 sound/soc/sunxi/Kconfig                            |    2 +-
 sound/soc/tegra/Kconfig                            |    4 +
 sound/soc/tegra/tegra210_ahub.c                    |    2 +-
 sound/soc/ti/Kconfig                               |    2 +-
 sound/soc/uniphier/Kconfig                         |   14 +-
 sound/soc/ux500/Kconfig                            |    2 +-
 sound/soc/xilinx/Kconfig                           |    4 +
 sound/soc/xtensa/Kconfig                           |    4 +
 sound/sparc/cs4231.c                               |   14 +-
 sound/spi/at73c213.c                               |    8 +-
 sound/synth/emux/emux_hwdep.c                      |    2 +-
 sound/synth/emux/emux_oss.c                        |    2 +-
 sound/usb/6fire/chip.c                             |    4 +-
 sound/usb/6fire/midi.c                             |    2 +-
 sound/usb/6fire/pcm.c                              |    2 +-
 sound/usb/card.c                                   |   13 +-
 sound/usb/line6/driver.c                           |    8 +-
 sound/usb/line6/midi.c                             |    4 +-
 sound/usb/line6/pcm.c                              |    2 +-
 sound/usb/line6/toneport.c                         |    2 +-
 sound/usb/midi.c                                   |    2 +-
 sound/usb/midi2.c                                  |    3 +-
 sound/usb/misc/ua101.c                             |    6 +-
 sound/usb/mixer.c                                  |   24 +-
 sound/usb/mixer_quirks.c                           |  575 +-
 sound/usb/mixer_scarlett.c                         |   31 +-
 sound/usb/mixer_scarlett2.c                        |   14 +-
 sound/usb/proc.c                                   |    2 +-
 sound/usb/stream.c                                 |    5 +-
 sound/usb/usx2y/us122l.c                           |    2 +-
 sound/usb/usx2y/usX2Yhwdep.c                       |    2 +-
 sound/usb/usx2y/usbusx2y.c                         |    2 +-
 sound/x86/intel_hdmi_audio.c                       |    3 -
 574 files changed, 20471 insertions(+), 15955 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,mxs-audio-sgtl5000.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt8173-afe-pcm.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/mtk-afe-pcm.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/mxs-audio-sgtl5000.txt
 create mode 100644 include/sound/sdca_hid.h
 create mode 100644 include/sound/sdca_interrupts.h
 create mode 100644 include/sound/tas2770-tlv.h
 create mode 100644 sound/hda/codecs/Kconfig
 create mode 100644 sound/hda/codecs/Makefile
 rename sound/{pci/hda/patch_analog.c => hda/codecs/analog.c} (90%)
 rename sound/{pci/hda/patch_ca0110.c => hda/codecs/ca0110.c} (75%)
 rename sound/{pci/hda/patch_ca0132.c => hda/codecs/ca0132.c} (99%)
 rename sound/{pci/hda => hda/codecs}/ca0132_regs.h (99%)
 create mode 100644 sound/hda/codecs/cirrus/Kconfig
 create mode 100644 sound/hda/codecs/cirrus/Makefile
 rename sound/{pci/hda/patch_cirrus.c => hda/codecs/cirrus/cs420x.c} (61%)
 create mode 100644 sound/hda/codecs/cirrus/cs421x.c
 rename sound/{pci/hda/patch_cs8409-tables.c => hda/codecs/cirrus/cs8409-tables.c} (99%)
 rename sound/{pci/hda/patch_cs8409.c => hda/codecs/cirrus/cs8409.c} (98%)
 rename sound/{pci/hda/patch_cs8409.h => hda/codecs/cirrus/cs8409.h} (98%)
 rename sound/{pci/hda/patch_cmedia.c => hda/codecs/cm9825.c} (73%)
 create mode 100644 sound/hda/codecs/cmedia.c
 rename sound/{pci/hda/patch_conexant.c => hda/codecs/conexant.c} (92%)
 rename sound/{pci/hda/hda_generic.c => hda/codecs/generic.c} (99%)
 rename sound/{pci/hda/hda_generic.h => hda/codecs/generic.h} (99%)
 create mode 100644 sound/hda/codecs/hdmi/Kconfig
 create mode 100644 sound/hda/codecs/hdmi/Makefile
 create mode 100644 sound/hda/codecs/hdmi/atihdmi.c
 rename sound/{pci/hda/hda_eld.c => hda/codecs/hdmi/eld.c} (51%)
 create mode 100644 sound/hda/codecs/hdmi/hdmi.c
 create mode 100644 sound/hda/codecs/hdmi/hdmi_local.h
 create mode 100644 sound/hda/codecs/hdmi/intelhdmi.c
 create mode 100644 sound/hda/codecs/hdmi/nvhdmi-mcp.c
 create mode 100644 sound/hda/codecs/hdmi/nvhdmi.c
 create mode 100644 sound/hda/codecs/hdmi/simplehdmi.c
 create mode 100644 sound/hda/codecs/hdmi/tegrahdmi.c
 rename sound/{pci/hda/hp_x360_helper.c => hda/codecs/helpers/hp_x360.c} (100%)
 rename sound/{pci/hda/ideapad_hotkey_led_helper.c => hda/codecs/helpers/ideapad_hotkey_led.c} (100%)
 rename sound/{pci/hda/ideapad_s740_helper.c => hda/codecs/helpers/ideapad_s740.c} (100%)
 rename sound/{pci/hda/thinkpad_helper.c => hda/codecs/helpers/thinkpad.c} (100%)
 create mode 100644 sound/hda/codecs/realtek/Kconfig
 create mode 100644 sound/hda/codecs/realtek/Makefile
 create mode 100644 sound/hda/codecs/realtek/alc260.c
 create mode 100644 sound/hda/codecs/realtek/alc262.c
 create mode 100644 sound/hda/codecs/realtek/alc268.c
 rename sound/{pci/hda/patch_realtek.c => hda/codecs/realtek/alc269.c} (63%)
 create mode 100644 sound/hda/codecs/realtek/alc662.c
 create mode 100644 sound/hda/codecs/realtek/alc680.c
 create mode 100644 sound/hda/codecs/realtek/alc861.c
 create mode 100644 sound/hda/codecs/realtek/alc861vd.c
 create mode 100644 sound/hda/codecs/realtek/alc880.c
 create mode 100644 sound/hda/codecs/realtek/alc882.c
 create mode 100644 sound/hda/codecs/realtek/realtek.c
 create mode 100644 sound/hda/codecs/realtek/realtek.h
 rename sound/{pci/hda/patch_senarytech.c => hda/codecs/senarytech.c} (87%)
 rename sound/{pci/hda/patch_si3054.c => hda/codecs/si3054.c} (88%)
 create mode 100644 sound/hda/codecs/side-codecs/Kconfig
 create mode 100644 sound/hda/codecs/side-codecs/Makefile
 rename sound/{pci/hda => hda/codecs/side-codecs}/cirrus_scodec.c (100%)
 rename sound/{pci/hda => hda/codecs/side-codecs}/cirrus_scodec.h (100%)
 rename sound/{pci/hda => hda/codecs/side-codecs}/cirrus_scodec_test.c (100%)
 rename sound/{pci/hda => hda/codecs/side-codecs}/cs35l41_hda.c (96%)
 rename sound/{pci/hda => hda/codecs/side-codecs}/cs35l41_hda.h (99%)
 rename sound/{pci/hda => hda/codecs/side-codecs}/cs35l41_hda_i2c.c (100%)
 rename sound/{pci/hda => hda/codecs/side-codecs}/cs35l41_hda_property.c (100%)
 rename sound/{pci/hda => hda/codecs/side-codecs}/cs35l41_hda_property.h (100%)
 rename sound/{pci/hda => hda/codecs/side-codecs}/cs35l41_hda_spi.c (100%)
 rename sound/{pci/hda => hda/codecs/side-codecs}/cs35l56_hda.c (99%)
 rename sound/{pci/hda => hda/codecs/side-codecs}/cs35l56_hda.h (100%)
 rename sound/{pci/hda => hda/codecs/side-codecs}/cs35l56_hda_i2c.c (100%)
 rename sound/{pci/hda => hda/codecs/side-codecs}/cs35l56_hda_spi.c (100%)
 rename sound/{pci/hda => hda/codecs/side-codecs}/hda_component.c (100%)
 rename sound/{pci/hda => hda/codecs/side-codecs}/hda_component.h (100%)
 rename sound/{pci/hda => hda/codecs/side-codecs}/tas2781_hda.c (100%)
 rename sound/{pci/hda => hda/codecs/side-codecs}/tas2781_hda.h (100%)
 rename sound/{pci/hda => hda/codecs/side-codecs}/tas2781_hda_i2c.c (86%)
 rename sound/{pci/hda => hda/codecs/side-codecs}/tas2781_hda_spi.c (99%)
 rename sound/{pci/hda/patch_sigmatel.c => hda/codecs/sigmatel.c} (94%)
 rename sound/{pci/hda/patch_via.c => hda/codecs/via.c} (78%)
 create mode 100644 sound/hda/common/Kconfig
 create mode 100644 sound/hda/common/Makefile
 rename sound/{pci/hda/hda_auto_parser.c => hda/common/auto_parser.c} (100%)
 rename sound/{pci/hda/hda_beep.c => hda/common/beep.c} (100%)
 rename sound/{pci/hda/hda_bind.c => hda/common/bind.c} (93%)
 rename sound/{pci/hda/hda_codec.c => hda/common/codec.c} (98%)
 rename sound/{pci/hda/hda_controller.c => hda/common/controller.c} (99%)
 rename sound/{pci/hda/hda_controller_trace.h => hda/common/controller_trace.h} (97%)
 rename sound/{pci/hda => hda/common}/hda_auto_parser.h (100%)
 rename sound/{pci/hda => hda/common}/hda_beep.h (100%)
 rename sound/{pci/hda => hda/common}/hda_controller.h (100%)
 rename sound/{pci/hda => hda/common}/hda_jack.h (100%)
 rename sound/{pci/hda => hda/common}/hda_local.h (99%)
 rename sound/{pci/hda/hda_hwdep.c => hda/common/hwdep.c} (100%)
 rename sound/{pci/hda/hda_jack.c => hda/common/jack.c} (100%)
 rename sound/{pci/hda/hda_proc.c => hda/common/proc.c} (100%)
 rename sound/{pci/hda/hda_sysfs.c => hda/common/sysfs.c} (100%)
 create mode 100644 sound/hda/controllers/Kconfig
 create mode 100644 sound/hda/controllers/Makefile
 rename sound/{pci/hda/hda_acpi.c => hda/controllers/acpi.c} (100%)
 rename sound/{pci/hda/hda_intel.c => hda/controllers/intel.c} (99%)
 rename sound/{pci/hda/hda_intel.h => hda/controllers/intel.h} (100%)
 rename sound/{pci/hda/hda_intel_trace.h => hda/controllers/intel_trace.h} (95%)
 rename sound/{pci/hda/hda_tegra.c => hda/controllers/tegra.c} (100%)
 create mode 100644 sound/hda/core/Kconfig
 create mode 100644 sound/hda/core/Makefile
 rename sound/hda/{ => core}/array.c (100%)
 rename sound/hda/{hdac_bus.c => core/bus.c} (100%)
 rename sound/hda/{hdac_component.c => core/component.c} (100%)
 rename sound/hda/{hdac_controller.c => core/controller.c} (100%)
 rename sound/hda/{hdac_device.c => core/device.c} (99%)
 rename sound/hda/{ => core}/ext/Makefile (54%)
 rename sound/hda/{ext/hdac_ext_bus.c => core/ext/bus.c} (100%)
 rename sound/hda/{ext/hdac_ext_controller.c => core/ext/controller.c} (100%)
 rename sound/hda/{ext/hdac_ext_stream.c => core/ext/stream.c} (100%)
 rename sound/hda/{ => core}/hda_bus_type.c (100%)
 rename sound/hda/{ => core}/hdmi_chmap.c (100%)
 rename sound/hda/{hdac_i915.c => core/i915.c} (100%)
 rename sound/hda/{ => core}/intel-dsp-config.c (100%)
 rename sound/hda/{ => core}/intel-nhlt.c (100%)
 rename sound/hda/{ => core}/intel-sdw-acpi.c (100%)
 rename sound/hda/{ => core}/local.h (66%)
 rename sound/hda/{hdac_regmap.c => core/regmap.c} (100%)
 rename sound/hda/{hdac_stream.c => core/stream.c} (100%)
 rename sound/hda/{hdac_sysfs.c => core/sysfs.c} (95%)
 rename sound/hda/{ => core}/trace.c (100%)
 rename sound/hda/{ => core}/trace.h (100%)
 delete mode 100644 sound/pci/hda/Kconfig
 delete mode 100644 sound/pci/hda/Makefile
 delete mode 100644 sound/pci/hda/patch_hdmi.c
 delete mode 100644 sound/soc/codecs/hdac_hdmi.h
 create mode 100644 sound/soc/codecs/rtq9124.c
 create mode 100644 sound/soc/intel/avs/boards/rt5640.c
 create mode 100644 sound/soc/sdca/sdca_hid.c
 create mode 100644 sound/soc/sdca/sdca_interrupts.c


