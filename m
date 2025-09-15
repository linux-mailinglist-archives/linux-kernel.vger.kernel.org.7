Return-Path: <linux-kernel+bounces-816336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2E4B5728C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76E76162BD7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8E52EAB93;
	Mon, 15 Sep 2025 08:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hjLnS2zz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q/9Yk1kt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hjLnS2zz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q/9Yk1kt"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6102EA46F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923699; cv=none; b=WDYQPnCeQ+Y5GOg1Ns+8LJ4hgsKlS26VxLhS/++BZDRI4Vbl5FqjIGYON5GHhVB45rJzLeamBM2vjfp5Wf3HUVG6qXrU/Ar2wSx0N26Z7UszE515y5pkY3jJSCHUsyC4zdoGdsry6yJNHkobjB2TdZiwaWUZnu5WA2khcDM91XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923699; c=relaxed/simple;
	bh=nZCLcCQFq2IJeLgrRSkd8ZecKWJX4Xujz9WUpsDZapw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TF1xpZvC64AAJehwlHEu12buqE26YDlNsFh2JC4ivyKWwVnWbnPID0m91Eio8XwahBZ6m2+WqU7V9q9RODmOKpsMiZSWXpZYt3zm2+CW3GH6zMplNMp2rJrHnaqjUlS+3+cvTmlFqOF5MwnismsEM4vVdTahjTmBpqw8qh2ghqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hjLnS2zz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q/9Yk1kt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hjLnS2zz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q/9Yk1kt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6DCDC1F7EC;
	Mon, 15 Sep 2025 08:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757923695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bHErkFNgVoEXeacOUH5sYxdbGPnKlzShAmrSQM7XABw=;
	b=hjLnS2zzvGcP8PolHl3YSpvI7jZpoAP9UqQwgB7BMv34Nszqgzt623JQT+rg0ZaSoIbrPv
	fKgFDaKFB4qIthsasZvBJRmJivWe4SsGYjlQFfs0WL/HvmEak4j7F2PBumb1oNTKYvoggb
	yxkh2aXMFGmVp0EGRkF0cQ/tK99P0Y8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757923695;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bHErkFNgVoEXeacOUH5sYxdbGPnKlzShAmrSQM7XABw=;
	b=q/9Yk1ktZiQ5A2FORrPczJdkCTESVMZSyteeSr70fKEyR3UXvkjtNvKLt2yLKW484yN9Yo
	v1Qf6OExZ5G1o9DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757923695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bHErkFNgVoEXeacOUH5sYxdbGPnKlzShAmrSQM7XABw=;
	b=hjLnS2zzvGcP8PolHl3YSpvI7jZpoAP9UqQwgB7BMv34Nszqgzt623JQT+rg0ZaSoIbrPv
	fKgFDaKFB4qIthsasZvBJRmJivWe4SsGYjlQFfs0WL/HvmEak4j7F2PBumb1oNTKYvoggb
	yxkh2aXMFGmVp0EGRkF0cQ/tK99P0Y8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757923695;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bHErkFNgVoEXeacOUH5sYxdbGPnKlzShAmrSQM7XABw=;
	b=q/9Yk1ktZiQ5A2FORrPczJdkCTESVMZSyteeSr70fKEyR3UXvkjtNvKLt2yLKW484yN9Yo
	v1Qf6OExZ5G1o9DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDAEE1368D;
	Mon, 15 Sep 2025 08:08:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aQOgOG7Jx2ggYQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 15 Sep 2025 08:08:14 +0000
Date: Mon, 15 Sep 2025 10:08:14 +0200
Message-ID: <877by0p28h.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Cryolitia PukNgae <cryolitia@uniontech.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Nie Cheng <niecheng1@uniontech.com>,
	Zhan Jun <zhanjun@uniontech.com>,
	Feng Yuan <fengyuan@uniontech.com>,
	qaqland <anguoli@uniontech.com>,
	kernel@uniontech.com
Subject: Re: [PATCH v2 0/3] ALSA: usb-audio: add module param device_quirk_flags
In-Reply-To: <408B48A84E5811C4+555ae002-5b34-4f90-9452-a3458a11f10f@uniontech.com>
References: <20250912-sound-v2-0-01ea3d279f4b@uniontech.com>
	<87a52zr9kq.wl-tiwai@suse.de>
	<408B48A84E5811C4+555ae002-5b34-4f90-9452-a3458a11f10f@uniontech.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Mon, 15 Sep 2025 09:43:05 +0200,
Cryolitia PukNgae wrote:
> 
> 
> 
> On 12/09/2025 23.09, Takashi Iwai wrote:
> > On Fri, 12 Sep 2025 08:48:57 +0200,
> > Cryolitia PukNgae via B4 Relay wrote:
> >>
> >> As an implementation of what has been discussed previously[1].
> >>
> >>> An open question is whether we may want yet a new module option or
> >>> rather extend the existing quirk option to accept the strings
> >>> instead.  Basically, when the given argument has a colon, it's a new
> >>> syntax.  If it's only a number, it's an old syntax, and parse like
> >>> before.  But, I'm open for either way (a new option or extend the
> >>> existing one).
> >>
> >> I would like to add a new param. The existed param
> >> `static unsigned int quirk_flags[SNDRV_CARDS]` seems to related to
> >> some sequence the card probed. To be honest, I havn't fully understood
> >> it. And it seems hard to improve it while keeping compatibility.
> >>
> >> 1. https://lore.kernel.org/all/87h5xm5g7f.wl-tiwai@suse.de/
> >>
> >> Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
> >> ---
> >> Changes in v2:
> >> - Cleaned up some internal rebase confusion, sorry for that
> >> - Link to v1: https://lore.kernel.org/r/20250912-sound-v1-0-cc9cfd9f2d01@uniontech.com
> >>
> >> ---
> >> Cryolitia PukNgae (3):
> >>       ALSA: usb-audio: add two-way convert between name and bit for QUIRK_FLAG_*
> >>       ALSA: usb-audio: add module param device_quirk_flags
> >>       ALSA: doc: add docs about device_device_quirk_flags in snd-usb-audio
> > 
> > Well, what I had in mind is something like:
> > 
> > --- a/sound/usb/card.c
> > +++ b/sound/usb/card.c
> > @@ -73,7 +73,7 @@ static bool lowlatency = true;
> >  static char *quirk_alias[SNDRV_CARDS];
> >  static char *delayed_register[SNDRV_CARDS];
> >  static bool implicit_fb[SNDRV_CARDS];
> > -static unsigned int quirk_flags[SNDRV_CARDS];
> > +static char *quirk_flags[SNDRV_CARDS];
> >  
> >  bool snd_usb_use_vmalloc = true;
> >  bool snd_usb_skip_validation;
> > @@ -103,8 +103,8 @@ module_param_array(delayed_register, charp, NULL, 0444);
> >  MODULE_PARM_DESC(delayed_register, "Quirk for delayed registration, given by id:iface, e.g. 0123abcd:4.");
> >  module_param_array(implicit_fb, bool, NULL, 0444);
> >  MODULE_PARM_DESC(implicit_fb, "Apply generic implicit feedback sync mode.");
> > -module_param_array(quirk_flags, uint, NULL, 0444);
> > -MODULE_PARM_DESC(quirk_flags, "Driver quirk bit flags.");
> > +module_param_array(quirk_flags, charp, NULL, 0444);
> > +MODULE_PARM_DESC(quirk_flags, "Driver quirk overrides.");
> >  module_param_named(use_vmalloc, snd_usb_use_vmalloc, bool, 0444);
> >  MODULE_PARM_DESC(use_vmalloc, "Use vmalloc for PCM intermediate buffers (default: yes).");
> >  module_param_named(skip_validation, snd_usb_skip_validation, bool, 0444);
> > @@ -692,6 +692,22 @@ static void usb_audio_make_longname(struct usb_device *dev,
> >  	}
> >  }
> >  
> > +static void set_quirk_flags(struct snd_usb_audio *chip, int idx)
> > +{
> > +	int i;
> > +
> > +	/* old style option found: the position-based integer value */
> > +	if (quirk_flags[idx] &&
> > +	    !kstrtou32(quirk_flags[idx], 0, &chip->quirk_flags))
> > +		return;
> > +
> > +	/* take the default quirk from the quirk table */
> > +	snd_usb_init_quirk_flags(chip);
> > +	/* add or correct quirk bits from options */
> > +	for (i = 0; i < ARRAY_SIZE(quirk_flags); i++)
> > +		snd_usb_apply_quirk_option(chip, quirk_flags[i]);
> > +}
> > +
> >  /*
> >   * create a chip instance and set its names.
> >   */
> > @@ -750,10 +766,7 @@ static int snd_usb_audio_create(struct usb_interface *intf,
> >  	INIT_LIST_HEAD(&chip->midi_v2_list);
> >  	INIT_LIST_HEAD(&chip->mixer_list);
> >  
> > -	if (quirk_flags[idx])
> > -		chip->quirk_flags = quirk_flags[idx];
> > -	else
> > -		snd_usb_init_quirk_flags(chip);
> > +	set_quirk_flags(chip, idx);
> >  
> >  	card->private_free = snd_usb_audio_free;
> >  
> > .... and snd_usb_apply_quirk_option() adds or corrects the quirk bits
> > based on the string value if it matches with the probed device.
> > This function will be similar like your parser.
> > 
> > In that way, the old quirk_flags options work as-is, while you can use
> > a new style by passing values with "X:Y:Z" style.
> > 
> 
> Thanks for your review. To be honest, I haven't understand how
> `static unsigned int quirk_flags[SNDRV_CARDS]` works. e.g., based on the
> current array form, how to pass a flag, and what does the index of the
> array means.
> 
> Could you please explain it for me. thx.

That option works just like other options of the card arrays -- each
value is passed sequentially to the device of the given probe slot.
That is, the first probed device takes quirk_flags[0], the second
probed device takes quirk_flats[1], and so on.
Admittedly, although this works fine for the static probe
configuration like PCI devices or such, it's not ideal with
USB-audio.  So the new format is requested.


Takashi

