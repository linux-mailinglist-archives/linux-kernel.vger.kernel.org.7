Return-Path: <linux-kernel+bounces-764139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB976B21E80
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C22D94E25D3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 06:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705742D3A85;
	Tue, 12 Aug 2025 06:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zj8Yyewc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8WZUIzRO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zj8Yyewc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8WZUIzRO"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861BA26A09B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754980871; cv=none; b=kNkdJRKXJKdsgHfJdxrxSOOhrjyXGG9RsIuV60HMQMNcd620Xd9/vVE3br7vfA0pwPp51EXnQygY8UcCU0UDYa60HJDPpexol9w8em6+4I54jkKV6p9aowTd1fHWMc+SZZCcUpLPxKR53M3Yh//8wiTbSitZ5dxHKSZmcTEJcBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754980871; c=relaxed/simple;
	bh=I452LBtT1Qe4JxZrPrNKgAnpwCY+ZA0DknK7i7wM88E=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s/Q0xcWmYle/y+9Aj/a9/rF1NLQno362r5/NZGr5hfCqykcBrtQ5TThAaZidIzcBSUWprMWLPJT7zmj27QZpiBAClJslWqKBXfV94u4dLYCEw1gB16pGsXkLZLM2/hfzuYgLqY1zHaofr6XntSu46w4nTKd0g4X7/eIhbDtTsN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zj8Yyewc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8WZUIzRO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zj8Yyewc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8WZUIzRO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8EED51F452;
	Tue, 12 Aug 2025 06:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754980862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LGqzfctgmqsb8NWyo8u5Cq9WskDZx8TSmMNEE3j6+Kc=;
	b=zj8Yyewct31qgWksPczlQ/pDv3jqdiwN9Mtekx0HcPHPnsdkkosCVst4P7KhC/6YpFwAQi
	vFC0k0GoSiwzBEPFwnrek09Qb34qYAWypaZF+oX5CjtrOIzsEe8RhmyRbgotaisQqsGGTJ
	C4ki9VUVn4Yyw9Pmuq7ADX+ovBkDduI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754980862;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LGqzfctgmqsb8NWyo8u5Cq9WskDZx8TSmMNEE3j6+Kc=;
	b=8WZUIzROEBgO/EPvd5/KiWyPoYLEWuN3K/Z7tpMFbRJMC8VbbnwtyoS4+hL9e0OsYAVMwN
	I09NycUN9SnwYbAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754980862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LGqzfctgmqsb8NWyo8u5Cq9WskDZx8TSmMNEE3j6+Kc=;
	b=zj8Yyewct31qgWksPczlQ/pDv3jqdiwN9Mtekx0HcPHPnsdkkosCVst4P7KhC/6YpFwAQi
	vFC0k0GoSiwzBEPFwnrek09Qb34qYAWypaZF+oX5CjtrOIzsEe8RhmyRbgotaisQqsGGTJ
	C4ki9VUVn4Yyw9Pmuq7ADX+ovBkDduI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754980862;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LGqzfctgmqsb8NWyo8u5Cq9WskDZx8TSmMNEE3j6+Kc=;
	b=8WZUIzROEBgO/EPvd5/KiWyPoYLEWuN3K/Z7tpMFbRJMC8VbbnwtyoS4+hL9e0OsYAVMwN
	I09NycUN9SnwYbAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FB7B1351A;
	Tue, 12 Aug 2025 06:41:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5mesFf7hmmggSgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 12 Aug 2025 06:41:02 +0000
Date: Tue, 12 Aug 2025 08:41:01 +0200
Message-ID: <87v7mtyrcy.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-2?Q?=A9erif?= Rami <ramiserifpersia@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] ALSA: usb-audio: Add initial driver for TASCAM US-144MKII
In-Reply-To: <20250810124958.25309-2-ramiserifpersia@gmail.com>
References: <20250810124958.25309-1-ramiserifpersia@gmail.com>
	<20250810124958.25309-2-ramiserifpersia@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

On Sun, 10 Aug 2025 14:49:52 +0200,
©erif Rami wrote:
> 
> +static int tascam_probe(struct usb_interface *intf,
> +			const struct usb_device_id *usb_id)
> +{
> +	struct usb_device *dev = interface_to_usbdev(intf);
> +	struct snd_card *card;
> +	struct tascam_card *tascam;
> +	int err;
> +

Please drop a blank line.

> +	char *handshake_buf __free(kfree);

For the __free(kfree), you'd always need to initialize the variable to
NULL, i.e.
	char *handshake_buf __free(kfree) = NULL;

> +/**
> + * struct tascam_card - Driver data structure for TASCAM US-144MKII.
> + * @dev: Pointer to the USB device.
> + * @iface0: Pointer to USB interface 0 (audio).
> + * @iface1: Pointer to USB interface 1 (MIDI).
> + * @card: Pointer to the ALSA sound card instance.
> + */
> +struct tascam_card {
> +struct usb_device *dev;
> +struct usb_interface *iface0;
> +struct usb_interface *iface1;
> +struct snd_card *card;
> +};

I see you fix the indentation in a later patch, but better to have the
right indentation from the beginning.


thanks,

Takashi

