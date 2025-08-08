Return-Path: <linux-kernel+bounces-760198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AE9B1E7AF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08BEB189311C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77FE275B18;
	Fri,  8 Aug 2025 11:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bfWL5h0R";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DxCG3OlU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bfWL5h0R";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DxCG3OlU"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBD827585F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 11:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754653662; cv=none; b=K2IqIknxWrM7vpY8ywdsjTxrI44xbfz4cIqCbyeHmMHOARZQ4rB6TLwzos6cKXuU93lClivB4prg6Pd1C7/NtVFmb/CujOdX2tBC3j/3NcappUpVLa0Hblz2lg69t49gJ/EyXo78CwQwiufFmV6WpV/G2ShC6K5BDc8FQXqW05c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754653662; c=relaxed/simple;
	bh=OMs39cPXH3EsbEjYCGDQeZSreiy7G8uM9/UhBT/4ekY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXoROzySywg0qsZ6xD9R8V9Q/QQTyqOXpDxD7IoB0TcDlkd+xk13wzNku4hvFZmAoUwpjH+DqclLBcDwOy3r9+zwRcMxz+0kOaVcmAeWovzuZ37LdUUYtEBL6MNjRZ8wTHKyhB75Cn3isFL9Vh2JgHPxXMgZYn668jGdM8IqyLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bfWL5h0R; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DxCG3OlU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bfWL5h0R; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DxCG3OlU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 585D75BDDF;
	Fri,  8 Aug 2025 11:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754653658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=joXkF6ZQTX4Bw9+xPY1uO4UwL5P2K6IIXB7mOXl7enM=;
	b=bfWL5h0ReRJM3Os+zAYR2NNgdMd3W+9CXVPe6zu2bEP8uK0v3TADyizhW9Nicxoc8GU3Bo
	MAQXLVHFMBkyEg8QYZ8kxlah7XUeuB2W3xHfjruTQCqoqGHkOPFIT6G77gTwudpTEIQdhT
	huq4uZaS8lkEmdUfzQa69ahGSKUoH3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754653658;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=joXkF6ZQTX4Bw9+xPY1uO4UwL5P2K6IIXB7mOXl7enM=;
	b=DxCG3OlUYKjeIisqyfObPZD1Ker3MHHl+gZ/XtDioYo2d4lc+8Pmj/ubsNL/iH6LtvLs5n
	DSEKj6c6p2iCoiAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754653658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=joXkF6ZQTX4Bw9+xPY1uO4UwL5P2K6IIXB7mOXl7enM=;
	b=bfWL5h0ReRJM3Os+zAYR2NNgdMd3W+9CXVPe6zu2bEP8uK0v3TADyizhW9Nicxoc8GU3Bo
	MAQXLVHFMBkyEg8QYZ8kxlah7XUeuB2W3xHfjruTQCqoqGHkOPFIT6G77gTwudpTEIQdhT
	huq4uZaS8lkEmdUfzQa69ahGSKUoH3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754653658;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=joXkF6ZQTX4Bw9+xPY1uO4UwL5P2K6IIXB7mOXl7enM=;
	b=DxCG3OlUYKjeIisqyfObPZD1Ker3MHHl+gZ/XtDioYo2d4lc+8Pmj/ubsNL/iH6LtvLs5n
	DSEKj6c6p2iCoiAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5C311392A;
	Fri,  8 Aug 2025 11:47:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S7DdNtnjlWjVAwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 08 Aug 2025 11:47:37 +0000
Date: Fri, 08 Aug 2025 13:47:37 +0200
Message-ID: <878qjuyqzq.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-2?Q?=A9erif?= Rami <ramiserifpersia@gmail.com>
Cc: tiwai@suse.de,
	arnd@arndb.de,
	broonie@kernel.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	quic_wcheng@quicinc.com,
	tiwai@suse.com
Subject: Re: [PATCH v3] ALSA: usb-audio: Add support for TASCAM US-144MKII
In-Reply-To: <20250808111406.4074-1-ramiserifpersia@gmail.com>
References: <87jz3eywak.wl-tiwai@suse.de>
	<20250808111406.4074-1-ramiserifpersia@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

On Fri, 08 Aug 2025 13:14:06 +0200,
Šerif Rami wrote:
> 
> Hi Takashi,
> 
> Thank you for your reply and for taking the time to review my patch.
> 
> > - The sysfs file should be dropped as Greg suggested
> >
> > - Try to use guard() for spinlocks.  (I know other USB audio drivers
> >   don't do that yet, but I already have a bit patch set to convert
> >   those.)
> >
> >   Of course, there are cases where guard() and scoped_guard() don't
> >   fit well (e.g. the loop with temporary unlock/re-locking), but in
> >   most cases, you can use it well.  If it doesn't fit, it's a good
> >   chance to take a look at your code again and reconsider whether the
> >   code flow can be changed better.
> >
> > - Similarly, try to use __free(kfree) for temporary buffers.
> >
> > - snd_pcm_lib_preallocate_*() can be replaced with
> >   snd_pcm_set_managed_buffer().  Then you can drop
> >   snd_pcm_lib_malloc_pages() and snd_pcm_lib_free_pages() calls from
> >   hw_params and hw_free callbacks, too.
> >
> > - Most of enum info callbacks can be simplified with
> >   snd_ctl_enum_info() helper function.
> >
> > - It's a bit big code and it'd be great if you can split the patches
> >   in a logical manner.  But it'd be OK-ish to have a single patch if
> >   it's not easy, too.
> 
> I will implement the suggested changes.
> 
> Regarding patch splitting, since most of the driver code is new, the plan is to create two patches: one that removes the US-144MKII device binding from the existing `us122l` driver, and a second that adds the new driver files under `sound/usb/usx2y`. Please let me know if this sounds good or if you’d prefer a different approach.

I don't think this would bring so much -- the drop of the old driver
binding is just a few line of entry point, after all.
Rather splitting the new driver code in a few logical pieces might
help for reviewing.


thanks,

Takashi

