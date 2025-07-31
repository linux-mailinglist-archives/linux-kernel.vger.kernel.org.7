Return-Path: <linux-kernel+bounces-751673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E29B16C2B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5593E1AA32D9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 06:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072BA28D8DE;
	Thu, 31 Jul 2025 06:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wtCuthpI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ISzverYE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="is43YfsT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XLUrPoQ7"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D23239E88
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 06:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753944540; cv=none; b=W00LdA2MDUg3KK7E3R866GFyp/3Tf+r3AdcCGSFoq/K3NT02oRfOS9UtLnD9SHzrnGQ1soNGqTIgZLJqEJBXJPKiKV1uXgyblyhgLcAXNsT6aCSDcB46XfqiGyxU/5FGtbITKIiVpCYC9H/3228DLFwTKao0te7+GdMHImTIjgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753944540; c=relaxed/simple;
	bh=GwSP7Wn/Z1dpeCdFruWUCIV1DZzxh4VvTnqHvttlJys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMAur7PgGbEmi2h65u07wY7TiH+K1f32zPmLqVTJmWQgT+AWxTV8KVTor7hUcqvG71UYdHIuqJzZYFo64JvHvbzEEWrlCfM0fQyjBmtoAkdneXVSSywxCW8PL+MHEk/eYvOOPTzvmr/peaQScwEACkevBn0HscsaQrZeK58rLt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wtCuthpI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ISzverYE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=is43YfsT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XLUrPoQ7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5846E1FB87;
	Thu, 31 Jul 2025 06:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753944537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U1MDLbtDdHr7IDr7gwYAL6nI4k657u0+xxok1YsY9e4=;
	b=wtCuthpI9Pd1MwUyTR+E+DxKWpnL2DBn76Pz67UGciWTDVTPT8BuVTnru+bl49xvtFwPMu
	CF5EnMEFigCeWEJoDUBGFYI1yZcU6h51Oqp9P9iTzElOLwP1UlM/9vqqk/0kQlfCLxc1vG
	g7mbwOmuxqJdZHqz0nZznS/A8gnqmmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753944537;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U1MDLbtDdHr7IDr7gwYAL6nI4k657u0+xxok1YsY9e4=;
	b=ISzverYEzpXdgR3EQPrBBhw/1z3r+nutGWmyPa6Q9Y+LmA3iSYnWA8w8kQ09xfbFEs1Ytu
	4drFQZVYGvkhSXCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=is43YfsT;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XLUrPoQ7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753944536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U1MDLbtDdHr7IDr7gwYAL6nI4k657u0+xxok1YsY9e4=;
	b=is43YfsTSigRGtQFW7EovF22a5xhIIVMjNtaLDlaqTzFIafPOqlA2Vmcjc8R2Uxgnxt6LC
	+yaqediWA1r5v2EOF0nxUbMTOZruc7GZbjYqZBmiWquoInNJZjAohn6MahPTCY/g0UucFF
	iJtkQqtS6dNhJOpdmxsOPlFhw96yhIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753944536;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U1MDLbtDdHr7IDr7gwYAL6nI4k657u0+xxok1YsY9e4=;
	b=XLUrPoQ76IlT3m+vbfE9ylslbQ55YpaCO7kE5zJLZsvqKM6qYIuGPmYN6ToKcjPAbGRnrQ
	gQVUmSKxOdyvu9Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E10B13AA9;
	Thu, 31 Jul 2025 06:48:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4Fv7CdgRi2hnZAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 31 Jul 2025 06:48:56 +0000
From: Takashi Iwai <tiwai@suse.de>
To: linux-sound@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: [PATCH 2/3] LoongArch: Update HD-audio codec configs
Date: Thu, 31 Jul 2025 08:48:08 +0200
Message-ID: <20250731064813.1622-3-tiwai@suse.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250731064813.1622-1-tiwai@suse.de>
References: <20250731064813.1622-1-tiwai@suse.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 5846E1FB87
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

The HD-audio codec driver configs have been updated again the drivers
got split with different kconfigs.  Add the missing items.

Fixes: 1d8dd982c409 ("ALSA: hda/realtek: Enable drivers as default")
Fixes: 81231ad173d8 ("ALSA: hda/hdmi: Enable drivers as default")
Cc: loongarch@lists.linux.dev
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

The changes are only in sound.git tree, so I'll pick up this there, too

 arch/loongarch/configs/loongson3_defconfig | 2 ++
 1 file changed, 2 insertions(+)

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
-- 
2.50.1


