Return-Path: <linux-kernel+bounces-751619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BDAB16B86
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B7271AA2955
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FC323F41A;
	Thu, 31 Jul 2025 05:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vh062AEK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="phv4Ttde";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vh062AEK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="phv4Ttde"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56C4BA2D
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 05:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753939838; cv=none; b=ATtghGW88aKHoxe0SxqASc0rrfxtQRJwHQf2qW3z6RMC3whISo+ZgnhNJ80Q1YEHQ6M8wEUcn5g0bgZEwbtT+pNfPPwfPWt4w5GKnDK5Tq2rQeXNS3rIlD2XlSTNCUoSYyyp8wTio5WnwpGb08ypXIIuHXqKdknX1oOf/x6WYO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753939838; c=relaxed/simple;
	bh=Cu5t6YZcZk5lAf+VgfszA5pX1dHFJSG+P7TJVPUldzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YUW1rZylxYAbuEcveTtF2Qprs9PS6oSIz4M/w6ySkh4tpLchyYr/aPUmJ1ax6SlqB07J4ezxovzFnKyEWTxoCBATgAShdkPXQLC0/WXF9e5JQ93th+vTYC7gL1AIbiRX458iVw5DcgHI9J2dcvH/RR0qigvdxrRsSl1VcXk0+t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vh062AEK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=phv4Ttde; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vh062AEK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=phv4Ttde; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B4FB31F893;
	Thu, 31 Jul 2025 05:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753939834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XXKHNIrDQ0CBoy0GqEZiamPh7M3IIt41WJXt06H2vrc=;
	b=vh062AEK12FoWQvMpiCA2uasJ0rP0Ib870SzzVPBCeCeiDFuWMwon935Ez+vDJ6anTmbPU
	rSuV2Y4GZE8AwkNlBcatD/mMENWOmJvZt8tFVo6gRNs+PUZr7/xf3IkP5nPqwQDB0wNUQ3
	YMWmkzI7DxfbHviteQ81m/63kkmy/mo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753939834;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XXKHNIrDQ0CBoy0GqEZiamPh7M3IIt41WJXt06H2vrc=;
	b=phv4TtdeYRIvUJ6faEy+gJZl5UB7jR77ouuNvInDj43rDQCx9nsEUtvF5VmfxBW6/35nPs
	E1T9kmY15CTeWIAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753939834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XXKHNIrDQ0CBoy0GqEZiamPh7M3IIt41WJXt06H2vrc=;
	b=vh062AEK12FoWQvMpiCA2uasJ0rP0Ib870SzzVPBCeCeiDFuWMwon935Ez+vDJ6anTmbPU
	rSuV2Y4GZE8AwkNlBcatD/mMENWOmJvZt8tFVo6gRNs+PUZr7/xf3IkP5nPqwQDB0wNUQ3
	YMWmkzI7DxfbHviteQ81m/63kkmy/mo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753939834;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XXKHNIrDQ0CBoy0GqEZiamPh7M3IIt41WJXt06H2vrc=;
	b=phv4TtdeYRIvUJ6faEy+gJZl5UB7jR77ouuNvInDj43rDQCx9nsEUtvF5VmfxBW6/35nPs
	E1T9kmY15CTeWIAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 922971378C;
	Thu, 31 Jul 2025 05:30:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 45aBInr/imhmTQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 31 Jul 2025 05:30:34 +0000
From: Takashi Iwai <tiwai@suse.de>
To: linux-sound@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda: Fix arch defconfigs
Date: Thu, 31 Jul 2025 07:30:30 +0200
Message-ID: <20250731053031.27121-1-tiwai@suse.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

The Realtek and HDMI HD-audio codec configs have been slightly updated
again since the previous change.  Follow the new kconfig changes for
arch defconfigs that contain CONFIG_SND_HDA_* items.

Fixes: 1d8dd982c409 ("ALSA: hda/realtek: Enable drivers as default")
Fixes: 81231ad173d8 ("ALSA: hda/hdmi: Enable drivers as default")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 arch/arm/configs/multi_v7_defconfig        | 3 ++-
 arch/arm/configs/tegra_defconfig           | 3 +++
 arch/loongarch/configs/loongson3_defconfig | 2 ++
 arch/mips/configs/loongson2k_defconfig     | 1 +
 arch/mips/configs/loongson3_defconfig      | 3 ++-
 5 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 02ddd7ce9e3e..7fb1f7dc8139 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -791,10 +791,11 @@ CONFIG_SND=m
 CONFIG_SND_HDA_TEGRA=m
 CONFIG_SND_HDA_INPUT_BEEP=y
 CONFIG_SND_HDA_PATCH_LOADER=y
-CONFIG_SND_HDA_CODEC_REALTEK=y
+CONFIG_SND_HDA_CODEC_REALTEK=m
 CONFIG_SND_HDA_CODEC_REALTEK_LIB=m
 CONFIG_SND_HDA_CODEC_ALC269=m
 CONFIG_SND_HDA_CODEC_HDMI=m
+CONFIG_SND_HDA_CODEC_HDMI_GENERIC=m
 CONFIG_SND_HDA_CODEC_HDMI_TEGRA=m
 CONFIG_SND_USB_AUDIO=m
 CONFIG_SND_SOC=m
diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 3a9bda2bf422..63bd824e84a8 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -225,7 +225,10 @@ CONFIG_SND_HDA_TEGRA=y
 CONFIG_SND_HDA_INPUT_BEEP=y
 CONFIG_SND_HDA_PATCH_LOADER=y
 CONFIG_SND_HDA_CODEC_REALTEK=y
+CONFIG_SND_HDA_CODEC_ALC269=y
 CONFIG_SND_HDA_CODEC_HDMI=y
+CONFIG_SND_HDA_CODEC_HDMI_GENERIC=y
+CONFIG_SND_HDA_CODEC_HDMI_TEGRA=y
 # CONFIG_SND_ARM is not set
 # CONFIG_SND_SPI is not set
 # CONFIG_SND_USB is not set
diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
index 0d59af6007b7..ac00d815b478 100644
--- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -784,8 +784,10 @@ CONFIG_SND_HDA_HWDEP=y
 CONFIG_SND_HDA_INPUT_BEEP=y
 CONFIG_SND_HDA_PATCH_LOADER=y
 CONFIG_SND_HDA_CODEC_REALTEK=y
+CONFIG_SND_HDA_CODEC_ALC269=y
 CONFIG_SND_HDA_CODEC_SIGMATEL=y
 CONFIG_SND_HDA_CODEC_HDMI=y
+CONFIG_SND_HDA_CODEC_HDMI_GENERIC=y
 CONFIG_SND_HDA_CODEC_CONEXANT=y
 CONFIG_SND_USB_AUDIO=m
 CONFIG_SND_SOC=m
diff --git a/arch/mips/configs/loongson2k_defconfig b/arch/mips/configs/loongson2k_defconfig
index 4b7f914d01d0..b1b370a227dc 100644
--- a/arch/mips/configs/loongson2k_defconfig
+++ b/arch/mips/configs/loongson2k_defconfig
@@ -257,6 +257,7 @@ CONFIG_SND_HDA_INTEL=y
 CONFIG_SND_HDA_HWDEP=y
 CONFIG_SND_HDA_PATCH_LOADER=y
 CONFIG_SND_HDA_CODEC_REALTEK=y
+CONFIG_SND_HDA_CODEC_ALC269=y
 CONFIG_SND_HDA_CODEC_ANALOG=y
 CONFIG_SND_HDA_CODEC_SIGMATEL=y
 CONFIG_SND_HDA_CODEC_VIA=y
diff --git a/arch/mips/configs/loongson3_defconfig b/arch/mips/configs/loongson3_defconfig
index 5ff0c1554168..b5c18d847908 100644
--- a/arch/mips/configs/loongson3_defconfig
+++ b/arch/mips/configs/loongson3_defconfig
@@ -292,11 +292,12 @@ CONFIG_SND_SEQ_DUMMY=m
 # CONFIG_SND_ISA is not set
 CONFIG_SND_HDA_INTEL=m
 CONFIG_SND_HDA_PATCH_LOADER=y
-CONFIG_SND_HDA_CODEC_REALTEK=y
+CONFIG_SND_HDA_CODEC_REALTEK=m
 CONFIG_SND_HDA_CODEC_REALTEK_LIB=m
 CONFIG_SND_HDA_CODEC_ALC269=m
 CONFIG_SND_HDA_CODEC_SIGMATEL=m
 CONFIG_SND_HDA_CODEC_HDMI=m
+CONFIG_SND_HDA_CODEC_HDMI_GENERIC=m
 CONFIG_SND_HDA_CODEC_CONEXANT=m
 # CONFIG_SND_USB is not set
 CONFIG_HIDRAW=y
-- 
2.50.1


