Return-Path: <linux-kernel+bounces-815527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F555B567B9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 12:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11BC6173D36
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 10:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1A2242D78;
	Sun, 14 Sep 2025 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wG1+u48x";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="l1KdJjFP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wG1+u48x";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="l1KdJjFP"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656357494
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757845133; cv=none; b=H4gURNVecOJP3JZ3UVBfH9iQHGW2XHAl5dObQgddNusRvEItQ/EvhiuJ9AtPb3BNtipp7Tyx/jhevtXH9642dW92On/1nNg7LUKlM+u8VqI1r+lZJZQZ+yV42egX8DnSJJmzePEO2idh5GSdaUNpjMxnIUMEaGpptlR0tiUuplA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757845133; c=relaxed/simple;
	bh=YsXdjPEu66+hOwttY4dS6ZDKoQIvSg5qD1PQ2mD9SMA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A6s2B5Ye6yxYyXcqxhN7O6U6lFwNC3i0Le7GXAi6jMcRAbFGfenSD7bsygl4TDg17S6zeyM4pw2shxIhp4xDrz4U7aitie573180ACGYH2utqxDvl6FfwubNKZMAnZRJcR82ju/uy4kvJQ/tv/Q02RFKXyX4hamm7o9f9v0FOto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wG1+u48x; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=l1KdJjFP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wG1+u48x; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=l1KdJjFP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 99D291FB41;
	Sun, 14 Sep 2025 10:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757845129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qdYMhB1ezhTpqG+xcgrzsoO3g51NHGjcmCroRq2tIL4=;
	b=wG1+u48xoblAS8EdH/esCVqz0jOgR1Lna6GvjT/nlzBeN60Aol2CPQmrQsZbpa6lwVnmfH
	kM+bXEh1KcZihZS6hBmdOf86PYG8OXJxT9RCRAaEnhN7C7RvL0+Nfm8Y1aA7k/ok1UW9sW
	uMooaE9D8T25uSIa92hFuhotAGLqarY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757845129;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qdYMhB1ezhTpqG+xcgrzsoO3g51NHGjcmCroRq2tIL4=;
	b=l1KdJjFPMOJQw27fZDEG6klG4wUkKwqXpFYZY0OjGUVsClriMCov+/LO8VMyn+Ldc/DMcg
	MrQwvw9nosDapTCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757845129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qdYMhB1ezhTpqG+xcgrzsoO3g51NHGjcmCroRq2tIL4=;
	b=wG1+u48xoblAS8EdH/esCVqz0jOgR1Lna6GvjT/nlzBeN60Aol2CPQmrQsZbpa6lwVnmfH
	kM+bXEh1KcZihZS6hBmdOf86PYG8OXJxT9RCRAaEnhN7C7RvL0+Nfm8Y1aA7k/ok1UW9sW
	uMooaE9D8T25uSIa92hFuhotAGLqarY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757845129;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qdYMhB1ezhTpqG+xcgrzsoO3g51NHGjcmCroRq2tIL4=;
	b=l1KdJjFPMOJQw27fZDEG6klG4wUkKwqXpFYZY0OjGUVsClriMCov+/LO8VMyn+Ldc/DMcg
	MrQwvw9nosDapTCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64C4C13419;
	Sun, 14 Sep 2025 10:18:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tCGAF4mWxmiJIgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 14 Sep 2025 10:18:49 +0000
Date: Sun, 14 Sep 2025 12:18:48 +0200
Message-ID: <87jz21pcaf.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Bou-Saan Che <yungmeat@inboxia.org>
Cc: perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH 2/2] ALSA: hda/realtek: Support Lenovo Thinkbook 13x Gen 5
In-Reply-To: <20250913223825.9264-1-yungmeat@inboxia.org>
References: <20250913223825.9264-1-yungmeat@inboxia.org>
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

On Sun, 14 Sep 2025 00:38:25 +0200,
Bou-Saan Che wrote:
> 
> The laptop does not contain valid _DSD for these amps, so requires
> entries into the CS35L41 configuration table to function correctly.
> 
> Signed-off-by: Bou-Saan Che <yungmeat@inboxia.org>

As requested in your another patch, could you try to rebase to the
latest 6.17-rc, verify the patch still working and resubmit?


thanks,

Takashi

> ---
>  sound/pci/hda/patch_realtek.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 2627e2f49316..36dc0389c9bd 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -11368,6 +11368,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x17aa, 0x3913, "Lenovo 145", ALC236_FIXUP_LENOVO_INV_DMIC),
>  	SND_PCI_QUIRK(0x17aa, 0x391f, "Yoga S990-16 pro Quad YC Quad", ALC287_FIXUP_TAS2781_I2C),
>  	SND_PCI_QUIRK(0x17aa, 0x3920, "Yoga S990-16 pro Quad VECO Quad", ALC287_FIXUP_TAS2781_I2C),
> +	SND_PCI_QUIRK(0x17aa, 0x3929, "Thinkbook 13x Gen 5", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
> +	SND_PCI_QUIRK(0x17aa, 0x392b, "Thinkbook 13x Gen 5", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
>  	SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210", ALC283_FIXUP_INT_MIC),
>  	SND_PCI_QUIRK(0x17aa, 0x3978, "Lenovo B50-70", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
>  	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
> -- 
> 2.51.0
> 
> 

