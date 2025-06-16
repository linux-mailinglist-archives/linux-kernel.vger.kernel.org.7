Return-Path: <linux-kernel+bounces-687844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB7AADA9EA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 09:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BCDC3A8394
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 07:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E4420E710;
	Mon, 16 Jun 2025 07:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jA8Tl/bc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L/xo79Zs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jA8Tl/bc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L/xo79Zs"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1EB1F4CA9
	for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750060412; cv=none; b=WDwg2zkTPLOWzRj1rXUAoziv7lbECSN9vQvofiGa+7/eTKcBBwkDTcGvj4nkLcjCupL8Vz+zwPksKT3bNZIugMPUOG1rrWd87NAUJX9sTcY+F+aeO19ku88HONEp0CLK4V2PgfarKOWG6ZOiBzi/2gAKh9glu8hXRPM9FZ0bvGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750060412; c=relaxed/simple;
	bh=ebymilIdH2RPN1vU7186PFlWF+PCkIs7nw3lXShNXgU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+t0yVAPE0ZraNhZXSqbcx3e5L3gjMtaYfek7PhIinTjtr9aS3wF76wP0NTXEghxXegUHVm5rln8USHKWPR2hJxduvXWHnpux9EnIXAbqIzUUmjlRhsg/KHXOofUHu/XBAhy7Iu1AeLcodPsF/x8Q7zwxFGkUTFZpTsYeOXsl3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jA8Tl/bc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L/xo79Zs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jA8Tl/bc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L/xo79Zs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C0A6E211FE;
	Mon, 16 Jun 2025 07:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750060408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LB1res4W8p6ly24QgM7h7EjascWL4QS0qJXjRzw05QM=;
	b=jA8Tl/bcm1QKccJM+Lx2zE+F5jR85TlQ7FlI5b6T4IhRFkWvzUAoAwMupyjFDtYatgK8Oj
	pSpp4V10oPOstwTxwjNwXYhunLVkn7ekDvT+vTY/CyDashEJUomAyGD2xY3jebA+KqM6Hg
	xspwxd6gLYkK6VrIo61aIJuIio+Qxl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750060408;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LB1res4W8p6ly24QgM7h7EjascWL4QS0qJXjRzw05QM=;
	b=L/xo79ZsURSH2a98r12zuA0hZPl/AeTJLT0eHDdrkAUHOP/wOvVojpKQ9GuHz5tHIxgb/f
	cq/qpmhyLeJr3ACg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750060408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LB1res4W8p6ly24QgM7h7EjascWL4QS0qJXjRzw05QM=;
	b=jA8Tl/bcm1QKccJM+Lx2zE+F5jR85TlQ7FlI5b6T4IhRFkWvzUAoAwMupyjFDtYatgK8Oj
	pSpp4V10oPOstwTxwjNwXYhunLVkn7ekDvT+vTY/CyDashEJUomAyGD2xY3jebA+KqM6Hg
	xspwxd6gLYkK6VrIo61aIJuIio+Qxl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750060408;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LB1res4W8p6ly24QgM7h7EjascWL4QS0qJXjRzw05QM=;
	b=L/xo79ZsURSH2a98r12zuA0hZPl/AeTJLT0eHDdrkAUHOP/wOvVojpKQ9GuHz5tHIxgb/f
	cq/qpmhyLeJr3ACg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78F8E13A6B;
	Mon, 16 Jun 2025 07:53:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7fARHHjNT2ieLAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 16 Jun 2025 07:53:28 +0000
Date: Mon, 16 Jun 2025 09:53:28 +0200
Message-ID: <87frg0p1fr.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: wangdicheng <wangdich9700@163.com>
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-arm-kernel@lists.infradead.org,
	wangdicheng <wangdicheng@kylinos.cn>
Subject: Re: [PATCH] ALSA: hda/realtek: Fixup ft alc257 rename alc3328
In-Reply-To: <20250616074520.582138-1-wangdich9700@163.com>
References: <20250616074520.582138-1-wangdich9700@163.com>
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[163.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,perex.cz,suse.com,vger.kernel.org,alsa-project.org,lists.infradead.org,kylinos.cn];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Mon, 16 Jun 2025 09:45:20 +0200,
wangdicheng wrote:
> 
> Audio ALC3328 recognized as ALC257, updated PCI ID0x10EC12F0 to rename it to 3328
> 
> Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>

Try to fix up via either rename_tbl[] or rename_pci_tbl[] instead.


thanks,

Takashi

> ---
>  sound/pci/hda/patch_realtek.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index d3c9ed963588..e18b2a2acba8 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -6712,6 +6712,13 @@ static void alc_fixup_disable_mic_vref(struct hda_codec *codec,
>  		snd_hda_codec_set_pin_target(codec, 0x19, PIN_VREFHIZ);
>  }
>  
> +static void alc_fixup_ft_alc257_rename(struct hda_codec *codec,
> +                                 const struct hda_fixup *fix, int action)
> +{
> +       int err;
> +       if (action == HDA_FIXUP_ACT_PRE_PROBE)
> +               err = alc_codec_rename(codec, "ALC3328");
> +}
>  
>  static void alc294_gx502_toggle_output(struct hda_codec *codec,
>  					struct hda_jack_callback *cb)
> @@ -7799,6 +7806,7 @@ enum {
>  	ALC269_FIXUP_VAIO_VJFH52_MIC_NO_PRESENCE,
>  	ALC233_FIXUP_MEDION_MTL_SPK,
>  	ALC294_FIXUP_BASS_SPEAKER_15,
> +	ALC257_FIXUP_FT_RENAME,
>  };
>  
>  /* A special fixup for Lenovo C940 and Yoga Duet 7;
> @@ -10143,6 +10151,10 @@ static const struct hda_fixup alc269_fixups[] = {
>  		.type = HDA_FIXUP_FUNC,
>  		.v.func = alc294_fixup_bass_speaker_15,
>  	},
> +	[ALC257_FIXUP_FT_RENAME] = {
> +		.type = HDA_FIXUP_FUNC,
> +		.v.func = alc_fixup_ft_alc257_rename,
> +	},
>  };
>  
>  static const struct hda_quirk alc269_fixup_tbl[] = {
> @@ -10715,6 +10727,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x10cf, 0x1757, "Lifebook E752", ALC269_FIXUP_LIFEBOOK_HP_PIN),
>  	SND_PCI_QUIRK(0x10cf, 0x1845, "Lifebook U904", ALC269_FIXUP_LIFEBOOK_EXTMIC),
>  	SND_PCI_QUIRK(0x10ec, 0x10f2, "Intel Reference board", ALC700_FIXUP_INTEL_REFERENCE),
> +	SND_PCI_QUIRK(0x10ec, 0x12f0, "BXC NF271B FT board", ALC257_FIXUP_FT_RENAME),
>  	SND_PCI_QUIRK(0x10ec, 0x118c, "Medion EE4254 MD62100", ALC256_FIXUP_MEDION_HEADSET_NO_PRESENCE),
>  	SND_PCI_QUIRK(0x10ec, 0x119e, "Positivo SU C1400", ALC269_FIXUP_ASPIRE_HEADSET_MIC),
>  	SND_PCI_QUIRK(0x10ec, 0x11bc, "VAIO VJFE-IL", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
> -- 
> 2.25.1
> 

