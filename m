Return-Path: <linux-kernel+bounces-751848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AF5B16E31
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C0813A2475
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F243F299928;
	Thu, 31 Jul 2025 09:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dXL+lyNW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Qo6ePip2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dXL+lyNW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Qo6ePip2"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EA628F937
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753953082; cv=none; b=l6laGYIJrtzFwk6DgsVJrVDZVRmbwmv34P/aSinXkLzn0Sy8T+1GAq9Wk1atzwDd/gc4pUB4R1kKSxykavE5JVyEMnb6zQBp30JHSaYsldZTpGxT7wc8kC+njLwQ/RAEivWvAn7al+PP5bp6ymTM7DcmsiPNyMFU0/faEI0Z3y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753953082; c=relaxed/simple;
	bh=/y0c3e1itZic7MjNtqoFeeh9H2EncFzg0Eq20HBVse0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6b3QD7KNyoWA7VPra1WRyzIX2vnG+WE0rIwNiNJnnve4iBY0f6yduL+vVxstjPjgLX6BfQcXnGiOLis/UDzkMXOjyv4SfR6m1Rf6/DimiGjtQN68W9eRIY3PP+7VUiOmdsfcDYjWZoiPHYAEvIeZgYpWoOW+mHRez25p39qJ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dXL+lyNW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Qo6ePip2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dXL+lyNW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Qo6ePip2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5097321AE0;
	Thu, 31 Jul 2025 09:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753953072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VAD/KGVn5h5c7GNlvaYOuA5p1aDI2Szsxbl5D9KYwXo=;
	b=dXL+lyNWW1osO8Y6vPbcoS/6Gnq4h7vUtenj7v7kJ+jPYw++GpVAdP0mp/9geuji9RAp2E
	610YgPHNiY2VmhLhMsd0SJeu7OLYBUEDBqYZIgMZ/5D6O56/L/Vk0hyBXeH7f25MS4Yj1s
	ybFzkdVmRbyCQ9tro43PMGoZr10Nzqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753953072;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VAD/KGVn5h5c7GNlvaYOuA5p1aDI2Szsxbl5D9KYwXo=;
	b=Qo6ePip2FjgNeG6NmxeAh6i4UM1HwWTsPAn662Wiuiow8vzefu07KpLxcuO9ZlWzvhba8C
	Sxo6SQoBwAMeCoCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dXL+lyNW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Qo6ePip2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753953072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VAD/KGVn5h5c7GNlvaYOuA5p1aDI2Szsxbl5D9KYwXo=;
	b=dXL+lyNWW1osO8Y6vPbcoS/6Gnq4h7vUtenj7v7kJ+jPYw++GpVAdP0mp/9geuji9RAp2E
	610YgPHNiY2VmhLhMsd0SJeu7OLYBUEDBqYZIgMZ/5D6O56/L/Vk0hyBXeH7f25MS4Yj1s
	ybFzkdVmRbyCQ9tro43PMGoZr10Nzqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753953072;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VAD/KGVn5h5c7GNlvaYOuA5p1aDI2Szsxbl5D9KYwXo=;
	b=Qo6ePip2FjgNeG6NmxeAh6i4UM1HwWTsPAn662Wiuiow8vzefu07KpLxcuO9ZlWzvhba8C
	Sxo6SQoBwAMeCoCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25F4513876;
	Thu, 31 Jul 2025 09:11:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KMYdCDAzi2j6FQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 31 Jul 2025 09:11:12 +0000
From: Takashi Iwai <tiwai@suse.de>
To: linux-sound@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: [PATCH v2 2/3] LoongArch: Update HD-audio codec configs
Date: Thu, 31 Jul 2025 11:11:06 +0200
Message-ID: <20250731091109.16901-3-tiwai@suse.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250731091109.16901-1-tiwai@suse.de>
References: <20250731091109.16901-1-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_NONE(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 5097321AE0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

The HD-audio codec driver configs have been updated again the drivers
got split with different kconfigs.

Enable all Realtek HD-audio codecs and HDMI codecs (except for
NVIDIA_MCP and TEGRA) per request.

Fixes: 1d8dd982c409 ("ALSA: hda/realtek: Enable drivers as default")
Fixes: 81231ad173d8 ("ALSA: hda/hdmi: Enable drivers as default")
Cc: loongarch@lists.linux.dev
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
v1->v2: enable all Realtek codecs and most of HDMI codecs

The changes are only in sound.git tree, so I'll pick up this there, too

 arch/loongarch/configs/loongson3_defconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
index 0d59af6007b7..7993020ffebb 100644
--- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -784,8 +784,23 @@ CONFIG_SND_HDA_HWDEP=y
 CONFIG_SND_HDA_INPUT_BEEP=y
 CONFIG_SND_HDA_PATCH_LOADER=y
 CONFIG_SND_HDA_CODEC_REALTEK=y
+CONFIG_SND_HDA_CODEC_REALTEK_LIB=y
+CONFIG_SND_HDA_CODEC_ALC260=y
+CONFIG_SND_HDA_CODEC_ALC262=y
+CONFIG_SND_HDA_CODEC_ALC268=y
+CONFIG_SND_HDA_CODEC_ALC269=y
+CONFIG_SND_HDA_CODEC_ALC662=y
+CONFIG_SND_HDA_CODEC_ALC680=y
+CONFIG_SND_HDA_CODEC_ALC861=y
+CONFIG_SND_HDA_CODEC_ALC861VD=y
+CONFIG_SND_HDA_CODEC_ALC880=y
+CONFIG_SND_HDA_CODEC_ALC882=y
 CONFIG_SND_HDA_CODEC_SIGMATEL=y
 CONFIG_SND_HDA_CODEC_HDMI=y
+CONFIG_SND_HDA_CODEC_HDMI_GENERIC=y
+CONFIG_SND_HDA_CODEC_HDMI_INTEL=y
+CONFIG_SND_HDA_CODEC_HDMI_ATI=y
+CONFIG_SND_HDA_CODEC_HDMI_NVIDIA=y
 CONFIG_SND_HDA_CODEC_CONEXANT=y
 CONFIG_SND_USB_AUDIO=m
 CONFIG_SND_SOC=m
-- 
2.50.1


