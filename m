Return-Path: <linux-kernel+bounces-834864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F90BA5AB0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 10:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2981BC6818
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 08:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1482D4816;
	Sat, 27 Sep 2025 08:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MNFu/ScS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uCy7wWPJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u7L9Asjw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Myo200mw"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5502D46DA
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 08:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758960876; cv=none; b=UAQ4xdyYZvTe/jISe3PWCTHRgeZpRcJOpJS3SACPHAUXLWRlKa/9u9xFUOV8coPeQDVpz8HDChoxfhlFIpJjSj/75lftDNbQOtOFiUZmYFUOQh7GhSNapSzJAbtpujwBfRnlcNhokr60SZe88HuSLwnh3hbOgkiZhH5tSV40YZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758960876; c=relaxed/simple;
	bh=u4i9cHF5YhFe8csy42Z21wHtNipJrezGkAGwJui6Gnw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ULfJkaGWedURQAyjxLRtM8DzZJqG4JjTo7TXzRD+zEgHo3FEvu5MiEMKGdbkaeIR4ohNCec73ec1o/opF087SUECd8jCc/r1qNwzrZ/RwRGtItk0XQrt7on7j56K8eEC4DOJKuc5Jr881WkaxXE86YcnbDWcMqBruZU+nXJsFjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MNFu/ScS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uCy7wWPJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u7L9Asjw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Myo200mw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C0893247DD;
	Sat, 27 Sep 2025 08:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758960871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y75e+5ePiVoUzqzr0M0vKrK0VUx24V9nUCpi7hcUUgI=;
	b=MNFu/ScSdxeCk0seQ7eSbCzyuDWyadXYTUbJjv1uH8uHwlXD9/CTyRIb4uxv8TLipwPj+Y
	RTB3U60xKmqDxgnCm7GVEAGa0jAin1Ysi2KUpVhBs+xKjTWl0gW5gRi9qducHktXSu2DWU
	zqWe4gXfO7Ade1VmDhy03DUJ9Fpahgo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758960871;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y75e+5ePiVoUzqzr0M0vKrK0VUx24V9nUCpi7hcUUgI=;
	b=uCy7wWPJaoQRFCUc7XZ3cSwjruxsYMFslVOjiZKEAlJW1H8uei0BUF+UdZaJyA41eyPht/
	nLC7LnBFyI8uJ5Bw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=u7L9Asjw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Myo200mw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758960869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y75e+5ePiVoUzqzr0M0vKrK0VUx24V9nUCpi7hcUUgI=;
	b=u7L9AsjwY6ZozkIHCdYXCSlpyq7Q4E+dXqoBemYlKnKnJ1RNu3POF6vY2kW71uAsUaLchN
	MQ517PbO4l1cIke+H4fpU0VKOhXu1EzFltSDpH2WfXeCTXlKbS6pjvo1JZe5SM6lB8KUjb
	YgQQx/i/bHHQvIK6bJrMIuEmbe7JQGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758960869;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y75e+5ePiVoUzqzr0M0vKrK0VUx24V9nUCpi7hcUUgI=;
	b=Myo200mw17dHz8+naivnl+U9AI0i3fgGxq5L+nJq1TfpciSh2duBkt3Ro85saltho0oq8g
	lK08wZC3UhSfJdBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7589813782;
	Sat, 27 Sep 2025 08:14:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id isvbGuWc12h8NgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 27 Sep 2025 08:14:29 +0000
Date: Sat, 27 Sep 2025 10:14:28 +0200
Message-ID: <87a52gb9cr.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Victor Krawiec <victor.krawiec@arturia.com>
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tiwai@suse.de,
	kees@kernel.org,
	abdul.rahim@myyahoo.com,
	jilliandonahue58@gmail.com,
	jkeeping@inmusicbrands.com
Subject: Re: [PATCH] usb: gadget: f_midi: allow customizing the USB MIDI interface string through configfs
In-Reply-To: <20250924154822.205703-1-victor.krawiec@arturia.com>
References: <20250924154822.205703-1-victor.krawiec@arturia.com>
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
X-Rspamd-Queue-Id: C0893247DD
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,suse.de,kernel.org,myyahoo.com,gmail.com,inmusicbrands.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid]
X-Spam-Score: -3.51

On Wed, 24 Sep 2025 17:48:21 +0200,
Victor Krawiec wrote:
> 
> When using f_midi from configfs the USB MIDI interface string is hardcoded
> to 'MIDI function'.
> 
> This USB string descriptor is used by some third-party OS or software to
> display the name of the MIDI device
> 
> Since we add an additional string option a new macro block was created to
> factorize declarations
> 
> Signed-off-by: Victor Krawiec <victor.krawiec@arturia.com>
> ---
>  drivers/usb/gadget/function/f_midi.c | 108 +++++++++++++++------------
>  drivers/usb/gadget/function/u_midi.h |   8 +-
>  2 files changed, 66 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
> index da82598fcef8..0a8af7d507d9 100644
> --- a/drivers/usb/gadget/function/f_midi.c
> +++ b/drivers/usb/gadget/function/f_midi.c
> @@ -875,6 +875,7 @@ static int f_midi_bind(struct usb_configuration *c, struct usb_function *f)
>  	struct usb_composite_dev *cdev = c->cdev;
>  	struct f_midi *midi = func_to_midi(f);
>  	struct usb_string *us;
> +	struct f_midi_opts *opts;
>  	int status, n, jack = 1, i = 0, endpoint_descriptor_index = 0;
>  
>  	midi->gadget = cdev->gadget;
> @@ -883,6 +884,10 @@ static int f_midi_bind(struct usb_configuration *c, struct usb_function *f)
>  	if (status < 0)
>  		goto fail_register;
>  
> +	opts = container_of(f->fi, struct f_midi_opts, func_inst);
> +	if (opts->interface_string_allocated && opts->interface_string)
> +		midi_string_defs[STRING_FUNC_IDX].s = opts->interface_string;
> +
>  	/* maybe allocate device-global string ID */
>  	us = usb_gstrings_attach(c->cdev, midi_strings,
>  				 ARRAY_SIZE(midi_string_defs));
> @@ -1178,59 +1183,62 @@ end:									\
>  									\
>  CONFIGFS_ATTR(f_midi_opts_, name);
>  
> +#define F_MIDI_OPT_STRING(name)						\
> +static ssize_t f_midi_opts_##name##_show(struct config_item *item, char *page) \
> +{									\
> +	struct f_midi_opts *opts = to_f_midi_opts(item);		\
> +	ssize_t result;							\
> +									\
> +	mutex_lock(&opts->lock);					\
> +	if (opts->name) {						\
> +		result = strscpy(page, opts->name, PAGE_SIZE);		\
> +	} else {							\
> +		page[0] = 0;						\
> +		result = 0;						\
> +	}								\
> +									\
> +	mutex_unlock(&opts->lock);					\
> +									\
> +	return result;							\
> +}									\
> +									\
> +static ssize_t f_midi_opts_##name##_store(struct config_item *item,	\
> +					 const char *page, size_t len)	\
> +{									\
> +	struct f_midi_opts *opts = to_f_midi_opts(item);		\
> +	int ret;							\
> +	char *c;							\
> +									\
> +	mutex_lock(&opts->lock);					\
> +	if (opts->refcnt > 1) {						\
> +		ret = -EBUSY;						\
> +		goto end;						\
> +	}								\
> +									\
> +	c = kstrndup(page, len, GFP_KERNEL);				\
> +	if (!c) {							\
> +		ret = -ENOMEM;						\
> +		goto end;						\
> +	}								\
> +	if (opts->name##_allocated)					\
> +		kfree(opts->name);					\
> +	opts->name = c;							\
> +	opts->name##_allocated = true;					\
> +	ret = len;							\
> +end:									\
> +	mutex_unlock(&opts->lock);					\
> +	return ret;							\
> +}									\
> +									\
> +CONFIGFS_ATTR(f_midi_opts_, name);
> +
>  F_MIDI_OPT_SIGNED(index, true, SNDRV_CARDS);
>  F_MIDI_OPT(buflen, false, 0);
>  F_MIDI_OPT(qlen, false, 0);
>  F_MIDI_OPT(in_ports, true, MAX_PORTS);
>  F_MIDI_OPT(out_ports, true, MAX_PORTS);
> -
> -static ssize_t f_midi_opts_id_show(struct config_item *item, char *page)
> -{
> -	struct f_midi_opts *opts = to_f_midi_opts(item);
> -	ssize_t result;
> -
> -	mutex_lock(&opts->lock);
> -	if (opts->id) {
> -		result = strscpy(page, opts->id, PAGE_SIZE);
> -	} else {
> -		page[0] = 0;
> -		result = 0;
> -	}
> -
> -	mutex_unlock(&opts->lock);
> -
> -	return result;
> -}
> -
> -static ssize_t f_midi_opts_id_store(struct config_item *item,
> -				    const char *page, size_t len)
> -{
> -	struct f_midi_opts *opts = to_f_midi_opts(item);
> -	int ret;
> -	char *c;
> -
> -	mutex_lock(&opts->lock);
> -	if (opts->refcnt > 1) {
> -		ret = -EBUSY;
> -		goto end;
> -	}
> -
> -	c = kstrndup(page, len, GFP_KERNEL);
> -	if (!c) {
> -		ret = -ENOMEM;
> -		goto end;
> -	}
> -	if (opts->id_allocated)
> -		kfree(opts->id);
> -	opts->id = c;
> -	opts->id_allocated = true;
> -	ret = len;
> -end:
> -	mutex_unlock(&opts->lock);
> -	return ret;
> -}
> -
> -CONFIGFS_ATTR(f_midi_opts_, id);
> +F_MIDI_OPT_STRING(id);
> +F_MIDI_OPT_STRING(interface_string);
>  
>  static struct configfs_attribute *midi_attrs[] = {
>  	&f_midi_opts_attr_index,
> @@ -1239,6 +1247,7 @@ static struct configfs_attribute *midi_attrs[] = {
>  	&f_midi_opts_attr_in_ports,
>  	&f_midi_opts_attr_out_ports,
>  	&f_midi_opts_attr_id,
> +	&f_midi_opts_attr_interface_string,
>  	NULL,
>  };
>  
> @@ -1264,6 +1273,8 @@ static void f_midi_free_inst(struct usb_function_instance *f)
>  	if (free) {
>  		if (opts->id_allocated)
>  			kfree(opts->id);
> +		if (opts->interface_string_allocated)
> +			kfree(opts->interface_string);
>  		kfree(opts);
>  	}
>  }
> @@ -1280,6 +1291,7 @@ static struct usb_function_instance *f_midi_alloc_inst(void)
>  	opts->func_inst.free_func_inst = f_midi_free_inst;
>  	opts->index = SNDRV_DEFAULT_IDX1;
>  	opts->id = SNDRV_DEFAULT_STR1;
> +	opts->interface_string = SNDRV_DEFAULT_STR1;

SNDRV_DEFAULT_STR1 is NULL, and this fact can simplify things a lot.

So, it's better to initialize explicitly with NULL instead of
SNDRV_DEFAULT_STR1, then you can just do NULL-check of the pointer
without the use of *_allocated field (that can be dropped).

Other than that, the code change looks good.


thanks,

Takashi

