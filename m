Return-Path: <linux-kernel+bounces-727081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3695B014C5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5DBF1AA765A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672871EEA47;
	Fri, 11 Jul 2025 07:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="n7/INw+P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mFMKR57x";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="n7/INw+P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mFMKR57x"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206E71EC018
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 07:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752219267; cv=none; b=nOM2wWiOYOs2aiNEH8Nx7oNa2BzgkRGF1Z3QQZMZ0IOrB1LPwVhCVr8MQnqQmAwBgx/ZLxP3lbgEa27Nkftqr+u+wOyFAQ90jSh91GamywhEb59qzzRgKjy4zWzTs5+eKyCP11Pfu+3kYjwLM1SKCQDg0+Ip/JDggTTfJaG0Grw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752219267; c=relaxed/simple;
	bh=3oXcY7Bj3JfUZWL0WQZywcpkLheBt/vaxkQw0bhq348=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FzlPNeX6HJhN+JJ/BBUYlPL+b2JZiQf0nEedjO62GRv8qr0q8jpIpbFd/f99JWpBGLjMiN3/A/EugZB9NP5Gy6az36adfoO8rNgOiFsHOwMgcOsHO+X3jeSOFrlcJNp4Jf3xka/uAXL7OZ3P423SzqNhnnetsAfrX4BLyr3X8ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=n7/INw+P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mFMKR57x; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=n7/INw+P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mFMKR57x; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 33CAE1F451;
	Fri, 11 Jul 2025 07:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752219264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9bTafDq8cSF/N3g5v9eGanZVqTC2LdNrQ0wFaEVhlLs=;
	b=n7/INw+PUN44EbIwoZWieIKzMdA9ek1qB4gMEKneJf+k/n3gQj9NFeZrgGzrB8LkGVqgoo
	4GUpwqj40m2VQjX8JlyJA2uolAfxLepf2VEgez/eXLqQpM8AoooYamFaRRsxiw+FzQliJX
	Jy/Vozwf7d3BsL/KWXOJExJHVYW7bRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752219264;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9bTafDq8cSF/N3g5v9eGanZVqTC2LdNrQ0wFaEVhlLs=;
	b=mFMKR57xv/jATjxGVGRgq58LnD5TwSBnh0c2Q4cLyVPa/b4744QLNo8Ms2eJkVie9Ay1Po
	ZPPYpKT2l0M8b7Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="n7/INw+P";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mFMKR57x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752219264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9bTafDq8cSF/N3g5v9eGanZVqTC2LdNrQ0wFaEVhlLs=;
	b=n7/INw+PUN44EbIwoZWieIKzMdA9ek1qB4gMEKneJf+k/n3gQj9NFeZrgGzrB8LkGVqgoo
	4GUpwqj40m2VQjX8JlyJA2uolAfxLepf2VEgez/eXLqQpM8AoooYamFaRRsxiw+FzQliJX
	Jy/Vozwf7d3BsL/KWXOJExJHVYW7bRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752219264;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9bTafDq8cSF/N3g5v9eGanZVqTC2LdNrQ0wFaEVhlLs=;
	b=mFMKR57xv/jATjxGVGRgq58LnD5TwSBnh0c2Q4cLyVPa/b4744QLNo8Ms2eJkVie9Ay1Po
	ZPPYpKT2l0M8b7Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F38F513918;
	Fri, 11 Jul 2025 07:34:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +W8vOn++cGh4RAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 11 Jul 2025 07:34:23 +0000
Date: Fri, 11 Jul 2025 09:34:23 +0200
Message-ID: <87frf3gozk.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Sharan Kumar Muthu Saravanan <sharweshraajan@gmail.com>
Cc: tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Enable Mute LED on HP OMEN 16 Laptop xd000xx
In-Reply-To: <CAGo=CcKZOz=HHWQtM+GQEeyqGVEo+4EgWSET5FJzKTMEMtJDew@mail.gmail.com>
References: <CAGo=CcKZOz=HHWQtM+GQEeyqGVEo+4EgWSET5FJzKTMEMtJDew@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 33CAE1F451
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid]
X-Spam-Score: -3.51

On Fri, 11 Jul 2025 08:23:09 +0200,
Sharan Kumar Muthu Saravanan wrote:
> 
> this patch makes the mute led brighter since the previous patch i
> submitted was dim
> 
> Tested on 6.15.5-arch1-1
> 
> Signed-off-by: Sharan Kumar M <sharweshraajan@gmail.com>
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 060db37eab83..062d439e753d 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -4753,7 +4753,7 @@ static void
> alc245_fixup_hp_mute_led_v1_coefbit(struct hda_codec *codec,
>         if (action == HDA_FIXUP_ACT_PRE_PROBE) {
>                 spec->mute_led_polarity = 0;
>                 spec->mute_led_coef.idx = 0x0b;
> -               spec->mute_led_coef.mask = 1 << 3;
> +               spec->mute_led_coef.mask = 3 << 2;
>                 spec->mute_led_coef.on = 1 << 3;
>                 spec->mute_led_coef.off = 0;
>                 snd_hda_gen_add_mute_led_cdev(codec, coef_mute_led_set);
> ---

The patch isn't applicable cleanly at all.
Please try to submit in a proper format.  At best, test by yourself
whether you can apply the patch locally before the next submission.

Also, the patch description is too ambiguous.  Please describe more
exactly what was wrong and what you changed.

Last but not least, please add Fixes tag pointing to your previous fix
mentioned in the patch.


thanks,

Takashi

