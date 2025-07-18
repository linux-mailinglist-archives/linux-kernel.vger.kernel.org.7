Return-Path: <linux-kernel+bounces-736852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A59B0A415
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB91D1C81364
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DFD29CB40;
	Fri, 18 Jul 2025 12:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dy83Tus0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9eoW8PgP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dy83Tus0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9eoW8PgP"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BA21E49F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 12:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752841367; cv=none; b=MU/bE88+kSYQ+UjtkMKQcFM4lQU1WMK+EbbdjGfjEuyRgHg6diC42Ec8xi0C658hn2HnMKBiF1ZxEkSKaM9MJ12KudiKMMmWJbE6QBclTRuAguqKnVF0BqrDF9NzBcYd200BGs1EWa0swOwICefsDWbcHSSTGbrznUda/sn3acg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752841367; c=relaxed/simple;
	bh=3iGjbYQQ2GdaJ9EopYYbgLII6tXWKxeHcS6PXNVWj34=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=h3NMVptRyl+M11DK+2B3y6u5K9e1be2bNfIan4apAApRPAoeCAwNC4iWJCy24Nqnrqj9a6MChXVBUkrbebdnlaO5km8zRQnRA9xqu6B+Gvjf/C+yqdJIEJcsfKSmyH5YAsgFCZb0eFu9XMgY7+xaKP6YwnPjsfueMRNTKdD+6bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dy83Tus0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9eoW8PgP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dy83Tus0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9eoW8PgP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8D2511F394;
	Fri, 18 Jul 2025 12:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752841357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qFbShdh+j0OlrhPdEs8y5qlHRPOcyxF1EoUm+Ru5I38=;
	b=dy83Tus0F2G33s4/eoDM+ouPe+TCkVnRcNincTiR0eiU4n1/ubLijBXNbkffP8ch9ZxIcM
	C70oRXMpxkwpsZZRNSAdt2st25QxSlozFMQNL3XCyUsdxkI+QE5e8k6Yuvt/nFhEplZFHF
	V36vQ7c9XFfkv10jGWcU5fpGrux24oI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752841357;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qFbShdh+j0OlrhPdEs8y5qlHRPOcyxF1EoUm+Ru5I38=;
	b=9eoW8PgPKm0uIAAmsw+JaCT782iAlpAixP9x0Y5nne5o7apSLyPV3kcp/U+g5GocKmI/qJ
	hdjLYRsIyB7hhTAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dy83Tus0;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9eoW8PgP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752841357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qFbShdh+j0OlrhPdEs8y5qlHRPOcyxF1EoUm+Ru5I38=;
	b=dy83Tus0F2G33s4/eoDM+ouPe+TCkVnRcNincTiR0eiU4n1/ubLijBXNbkffP8ch9ZxIcM
	C70oRXMpxkwpsZZRNSAdt2st25QxSlozFMQNL3XCyUsdxkI+QE5e8k6Yuvt/nFhEplZFHF
	V36vQ7c9XFfkv10jGWcU5fpGrux24oI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752841357;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qFbShdh+j0OlrhPdEs8y5qlHRPOcyxF1EoUm+Ru5I38=;
	b=9eoW8PgPKm0uIAAmsw+JaCT782iAlpAixP9x0Y5nne5o7apSLyPV3kcp/U+g5GocKmI/qJ
	hdjLYRsIyB7hhTAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60FEF13A52;
	Fri, 18 Jul 2025 12:22:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OPZbFo08emj+EAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 18 Jul 2025 12:22:37 +0000
Date: Fri, 18 Jul 2025 14:22:36 +0200
Message-ID: <87seit7koj.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.16-rc7
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 8D2511F394
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.51

Linus,

please pull sound fixes for v6.16-rc7 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.16-rc7

The topmost commit is 348954f9b78e1515777708b6764c88f225457c40

----------------------------------------------------------------

sound fixes for 6.16-rc7

A collection of small fixes again.  The only change in the core is
about the handling of ALSA compress-offload ioctl numbers for avoiding
potential abusing the API (if any).  Other than that, all changes are
device-specific small fixes and quirks, which should be safe to apply.

----------------------------------------------------------------

Adam Queler (1):
      ASoC: amd: yc: Add DMI entries to support HP 15-fb1xxx

Alexandru Andries (1):
      ASoC: amd: yc: add DMI quirk for ASUS M6501RM

Amadeusz S³awiñski (1):
      ASoC: Intel: avs: Fix NULL ptr deref on rmmod

Arnd Bergmann (2):
      ALSA: compress_offload: tighten ioctl command number checks
      ASoC: Intel: fix SND_SOC_SOF dependencies

Bard Liao (1):
      ASoC: Intel: soc-acpi: add support for HP Omen14 ARL

Edip Hazuri (1):
      ALSA: hda/realtek - Fix mute LED for HP Victus 16-r0xxx

Jackie Dong (1):
      ALSA: hda/realtek: Support mute LED for Yoga with ALC287

Lane Odenbach (1):
      ASoC: amd: yc: Add DMI quirk for HP Laptop 17 cp-2033dx

Oder Chiou (1):
      ASoC: rt5660: Fix the dmic data source from GPIO2

Richard Fitzgerald (1):
      ALSA: hda/cs35l56: Workaround bad dev-index on Lenovo Yoga Book 9i GenX

Takashi Iwai (1):
      ALSA: hda/realtek: Add quirk for ASUS ROG Strix G712LWS

---
 sound/core/compress_offload.c                     |  48 ++++-----
 sound/pci/hda/cs35l56_hda.c                       | 114 ++++++++++++++++------
 sound/pci/hda/patch_realtek.c                     |   5 +
 sound/soc/amd/yc/acp6x-mach.c                     |  21 ++++
 sound/soc/codecs/rt5660.c                         |   7 +-
 sound/soc/intel/avs/pcm.c                         |   4 +-
 sound/soc/intel/boards/Kconfig                    |   2 +-
 sound/soc/intel/common/soc-acpi-intel-arl-match.c |  29 ++++++
 8 files changed, 172 insertions(+), 58 deletions(-)


