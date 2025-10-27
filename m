Return-Path: <linux-kernel+bounces-871177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21752C0C92F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C63E619A5718
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C642EFDB2;
	Mon, 27 Oct 2025 09:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KeAV5aDs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w0p1VHi2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KeAV5aDs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w0p1VHi2"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE772EDD78
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761555876; cv=none; b=jRgwJ/dnLC4z5Q9RmeCqdN2sF+xsv/drd5gcHH9vRPc2Uq1sxcz3alO9rKP4ObUNWA4Lswr8hcHi29zry4yhv9/r4uSbCZEIm0RI0xzSW5GjUVbsknzJdomco6xAfdh8/G5kuZ6OyenjFlFNFGZgqU5e4Yc1j+hx1J8vdgcPWrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761555876; c=relaxed/simple;
	bh=HmXPdLDM+WjVCR0PeizelVzh0lCkc7/TjHjTvpJJEDY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MoiOEa8xypU+hvfIRsbH0rhD8APuxaCtANC8o7AbbOzqOnVciKXd7oLPuhR9HeLZbsffJaLsDFOzgX1bPXlRcLljKlgNTC3qfCi75QDTHlBC/BalbwO69XfJHyDR+jP7XoYLBnX8XkATV+HzrH2VOGc8ZckhKUOM6zQ54qoqUVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KeAV5aDs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w0p1VHi2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KeAV5aDs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w0p1VHi2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 255D01F385;
	Mon, 27 Oct 2025 09:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761555873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LfKyD2oNxW8s6Irro51M4kEzZkyhIU8tcsHQKv8VM9A=;
	b=KeAV5aDsRSNcGVMUIlVztKC6e1QNPhP+Ec5w9eglInoxGX8+mLYo5F8Gp0R8KAxqrlaQFZ
	0WMaKM7ZjkfNwzVCG60RwUvekTDS20ymGM5OjVDhYTldebcanZf64mCL62+QjO1ENQLDX8
	oKYuDZRthszlFACwGb0KAJRSTkZkk6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761555873;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LfKyD2oNxW8s6Irro51M4kEzZkyhIU8tcsHQKv8VM9A=;
	b=w0p1VHi2uR4IV8tnU+X/aF+nwwPZ5GTRRvko6cvEZABd/Dzh1qZIfSUMkFsPHMN2cTproP
	vfmd0Um7cuoLt1Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761555873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LfKyD2oNxW8s6Irro51M4kEzZkyhIU8tcsHQKv8VM9A=;
	b=KeAV5aDsRSNcGVMUIlVztKC6e1QNPhP+Ec5w9eglInoxGX8+mLYo5F8Gp0R8KAxqrlaQFZ
	0WMaKM7ZjkfNwzVCG60RwUvekTDS20ymGM5OjVDhYTldebcanZf64mCL62+QjO1ENQLDX8
	oKYuDZRthszlFACwGb0KAJRSTkZkk6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761555873;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LfKyD2oNxW8s6Irro51M4kEzZkyhIU8tcsHQKv8VM9A=;
	b=w0p1VHi2uR4IV8tnU+X/aF+nwwPZ5GTRRvko6cvEZABd/Dzh1qZIfSUMkFsPHMN2cTproP
	vfmd0Um7cuoLt1Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E014F136CF;
	Mon, 27 Oct 2025 09:04:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2c93NaA1/2jVQwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 27 Oct 2025 09:04:32 +0000
Date: Mon, 27 Oct 2025 10:04:32 +0100
Message-ID: <87ikg03ecf.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: sound: Increase max size of components field
In-Reply-To: <318f2ed3-57e6-495c-a773-4a094a3784cb@perex.cz>
References: <20251023092754.84095-1-mstrozek@opensource.cirrus.com>
	<318f2ed3-57e6-495c-a773-4a094a3784cb@perex.cz>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

On Thu, 23 Oct 2025 13:56:26 +0200,
Jaroslav Kysela wrote:
> 
> On 10/23/25 11:27, Maciej Strozek wrote:
> > The components field of snd_card can run out of space in new systems which
> > use many audio devices, hence increase its size to 256 bytes.
> 
> > @@ -1069,7 +1069,7 @@ struct snd_ctl_card_info {
> >   	unsigned char longname[80];	/* name + info text about soundcard */
> >   	unsigned char reserved_[16];	/* reserved for future (was ID of mixer) */
> >   	unsigned char mixername[80];	/* visual mixer identification */
> > -	unsigned char components[128];	/* card components / fine identification, delimited with one space (AC97 etc..) */
> > +	unsigned char components[256];	/* card components / fine identification, delimited with one space (AC97 etc..) */
> Unfortunately, this change will introduce kABI breakage (ioctl number
> change - structure size).
> 
> You can probably define another struct snd_ctl_card_info and
> SNDRV_CTL_IOCTL_CARD_INFO and update alsa-lib to use it depending the
> protocol version.
> 
> Or, we may introduce a separate ioctl for the components string. The
> stripped components string in struct snd_ctl_card_info may have a
> special ASCII mark like '>' at the end of string specifying the
> availability of the complete string through another ioctl. I would
> prefer this solution.
> 
> Also, the components string may be dynamic in the kernel structure
> (pointer) to save some space. 256 bytes is not small number.

As Jaroslav suggested, we need a different solution to keep the
compatibility.

My gut feeling is for the option to provide a new ioctl as it can be
most straightforward, but we can discuss further which is the good
choice.


thanks,

Takashi

