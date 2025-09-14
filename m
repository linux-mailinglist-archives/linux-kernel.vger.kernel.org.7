Return-Path: <linux-kernel+bounces-815525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDABB567B7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 12:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE84117367A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 10:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7A42153C1;
	Sun, 14 Sep 2025 10:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J1wlaOJi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="STBBzT4x";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J1wlaOJi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="STBBzT4x"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9E223ABA0
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 10:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757845079; cv=none; b=ildYsVlxD1FwxPrUL8BdRF5YglLulpOD8lFsuLRy2R3ey5qkOdvvgPbqOlbE1UPzmlERG8cRlSuqeBfxgwmGWJB2PkSo+MQWbECSz5lh4eEE7QaZxgVx1KerMBkG7KRmqVFZvmMrOCxDjvCmlEjZSTH7+OTW26xHrC7i75aNIvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757845079; c=relaxed/simple;
	bh=mGfpSpakfjPEZM1BQvEd3pakooWh3QXLhegsRctOleQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sHSLiHZyNTWiVR7gbMIA2CrbcDLHSwNamrNDeL1i9yEO9mb3FLuL1hpf4lD1SCzCzOIc42+syYZ1m7OZmdK/0vZQKyizB6ci2CvnCnXdQsKSZOrOOVcFBN8V9OUzvPhjMk8plgpUilKAOwp8AWCG9XqF0okG4ZRrXArBolZIcYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J1wlaOJi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=STBBzT4x; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J1wlaOJi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=STBBzT4x; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 660FD33A58;
	Sun, 14 Sep 2025 10:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757845075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QZRtmuuLJNY0eFn4o37DH75Nt0/UBeEFqflVBKia38Q=;
	b=J1wlaOJix2Ig8So0gj0kSc8+4/lHvegn8UM2LUNa6aOfQ4c8v7brcrBfj6s1lr2zyRzK19
	ZQb6m4WQej6HpAYHGPly/EZZzqchd4l75m/Is6cV3ZCb85QoxcfnX9KShsIjGMz11O6ffE
	J8F0WgPspgvoYQxiIQoa86WtyezLJF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757845075;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QZRtmuuLJNY0eFn4o37DH75Nt0/UBeEFqflVBKia38Q=;
	b=STBBzT4x8vrtEovhTjS/3q/VfqK/rGs3+AozZWBIYdzLD43yTVYb0NvgfWeyNMowM+Tqa5
	23UEfyyzvuzvkLBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757845075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QZRtmuuLJNY0eFn4o37DH75Nt0/UBeEFqflVBKia38Q=;
	b=J1wlaOJix2Ig8So0gj0kSc8+4/lHvegn8UM2LUNa6aOfQ4c8v7brcrBfj6s1lr2zyRzK19
	ZQb6m4WQej6HpAYHGPly/EZZzqchd4l75m/Is6cV3ZCb85QoxcfnX9KShsIjGMz11O6ffE
	J8F0WgPspgvoYQxiIQoa86WtyezLJF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757845075;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QZRtmuuLJNY0eFn4o37DH75Nt0/UBeEFqflVBKia38Q=;
	b=STBBzT4x8vrtEovhTjS/3q/VfqK/rGs3+AozZWBIYdzLD43yTVYb0NvgfWeyNMowM+Tqa5
	23UEfyyzvuzvkLBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29C3813419;
	Sun, 14 Sep 2025 10:17:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oZ5oCFOWxmhGIgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 14 Sep 2025 10:17:55 +0000
Date: Sun, 14 Sep 2025 12:17:54 +0200
Message-ID: <87ldmhpcbx.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Bou-Saan Che <yungmeat@inboxia.org>
Cc: perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH] ALSA: hda/realtek: Fix volume adjustment issue on Lenovo Thinkbook 13x Gen 4
In-Reply-To: <20250913225344.12822-1-yungmeat@inboxia.org>
References: <20250913225344.12822-1-yungmeat@inboxia.org>
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

On Sun, 14 Sep 2025 00:53:44 +0200,
Bou-Saan Che wrote:
> 
> This patch fixes the volume adjustment issue on this laptop by applying
> the necessary quirk configuration for the Realtek ALC287 codec.
> 
> The issue was caused by incorrect configuration in the driver,
> which prevented proper volume control on certain systems.
> 
> Signed-off-by: Bou-Saan Che <yungmeat@inboxia.org>

The HD-audio driver code was largely refactored since 6.17.  e.g. the
driver code is now found in sound/hda/codecs/realtek/alc269.c.
Could you rebase to the latest 6.17-rc kernel, verify that it's still
working and resubmit?


thanks,

Takashi

> ---
>  sound/pci/hda/patch_realtek.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 2627e2f49316..1981e3374b3e 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -11346,8 +11346,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x17aa, 0x38be, "Yoga S980-14.5 proX YC Dual", ALC287_FIXUP_TAS2781_I2C),
>  	SND_PCI_QUIRK(0x17aa, 0x38bf, "Yoga S980-14.5 proX LX Dual", ALC287_FIXUP_TAS2781_I2C),
>  	SND_PCI_QUIRK(0x17aa, 0x38c3, "Y980 DUAL", ALC287_FIXUP_TAS2781_I2C),
> -	SND_PCI_QUIRK(0x17aa, 0x38c7, "Thinkbook 13x Gen 4", ALC287_FIXUP_CS35L41_I2C_4),
> -	SND_PCI_QUIRK(0x17aa, 0x38c8, "Thinkbook 13x Gen 4", ALC287_FIXUP_CS35L41_I2C_4),
> +	SND_PCI_QUIRK(0x17aa, 0x38c7, "Thinkbook 13x Gen 4", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
> +	SND_PCI_QUIRK(0x17aa, 0x38c8, "Thinkbook 13x Gen 4", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
>  	SND_PCI_QUIRK(0x17aa, 0x38cb, "Y790 YG DUAL", ALC287_FIXUP_TAS2781_I2C),
>  	SND_PCI_QUIRK(0x17aa, 0x38cd, "Y790 VECO DUAL", ALC287_FIXUP_TAS2781_I2C),
>  	SND_PCI_QUIRK(0x17aa, 0x38d2, "Lenovo Yoga 9 14IMH9", ALC287_FIXUP_YOGA9_14IMH9_BASS_SPK_PIN),
> -- 
> 2.51.0
> 
> 

