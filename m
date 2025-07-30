Return-Path: <linux-kernel+bounces-751179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4332FB16618
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89ED5188D6AC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD19F2DECD8;
	Wed, 30 Jul 2025 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2DjpRlep";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E1ZntiKK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2DjpRlep";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E1ZntiKK"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8285A1EEA47
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 18:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753899284; cv=none; b=nW2D+qFd6dGYYykGabP51AamRpLEa9x5Q4J9o/H1fyuZ7/Ft28lp1xY3XeEqfWsDVmYuw6zDtP7FwaUMuaZclJtSMUcsstLSt5wp2UoHJwkdWHj0lPJ6OawcLVGQ+cS7XIxlP0AD1iRyu3JtgVNECduyixA6Fx9Q2y6iwkm3uwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753899284; c=relaxed/simple;
	bh=wL6pCY37azJyE3GNWT41spFWa6KKjSGXWeAXxtJM3XY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sv6zoO92ekDGfG3BI7GgoiR+KKkzErhS3/Uk3S00OFgZ0oUg7mU67OwZ8VTw+A/Wf+oVv6+LWTk/eEw2P23t1N+qCPg6uhYdIeJ61Bhd6q7oKEQW6fQYx512rvCM4PE6NPPooWnm7PPmI6QrlNN3DvCi3RO0LRvqTGv9XqzSI5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2DjpRlep; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E1ZntiKK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2DjpRlep; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E1ZntiKK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 934621F385;
	Wed, 30 Jul 2025 18:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753899280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w6yR3mNb4MNYcZB/5rxWhO6pTt72ztNnb4PkNZlcVnM=;
	b=2DjpRlep2/zJW/0EaE2th4Hg5Cv+lAv5XXMljtm/ZpGtqW3K1BXdTXGkDh4xD5b4V3Dweq
	rX3sXXmnKMAMb4cYvNnjYD8LwaXzw/vxKoPNmby0Q9DSgug+1gBfqhil81bLKc1WVdJP9k
	bIOgeIK9YYmRKYAkH9VtI97XAvZuGmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753899280;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w6yR3mNb4MNYcZB/5rxWhO6pTt72ztNnb4PkNZlcVnM=;
	b=E1ZntiKKcFILEezmALxbats7GTPJJIMyFyKJUFXDSL6Glew8ez3Xq+qiIkA9yhP3OVx+2w
	hRotEgRk2RhF3dAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=2DjpRlep;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=E1ZntiKK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753899280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w6yR3mNb4MNYcZB/5rxWhO6pTt72ztNnb4PkNZlcVnM=;
	b=2DjpRlep2/zJW/0EaE2th4Hg5Cv+lAv5XXMljtm/ZpGtqW3K1BXdTXGkDh4xD5b4V3Dweq
	rX3sXXmnKMAMb4cYvNnjYD8LwaXzw/vxKoPNmby0Q9DSgug+1gBfqhil81bLKc1WVdJP9k
	bIOgeIK9YYmRKYAkH9VtI97XAvZuGmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753899280;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w6yR3mNb4MNYcZB/5rxWhO6pTt72ztNnb4PkNZlcVnM=;
	b=E1ZntiKKcFILEezmALxbats7GTPJJIMyFyKJUFXDSL6Glew8ez3Xq+qiIkA9yhP3OVx+2w
	hRotEgRk2RhF3dAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 602361388B;
	Wed, 30 Jul 2025 18:14:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MaW0FRBhimiMFAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 30 Jul 2025 18:14:40 +0000
Date: Wed, 30 Jul 2025 20:14:39 +0200
Message-ID: <87jz3ptuk0.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Linux Sound Mailing List <linux-sound@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] sound updates for 6.17-rc1
In-Reply-To: <CAHk-=wjwR=hNLA7SzdnM5BvaBAwm2cVeZRR7uEo+3625SaiOjg@mail.gmail.com>
References: <87ecu4idvc.wl-tiwai@suse.de>
	<CAHk-=wjj9DvOZtmTkoLtyfHmy5mNKy6q_96d9=4FUEDXre=cww@mail.gmail.com>
	<CAHk-=whvoZuw-Cv2Bx2ip8Kq4j9jw0meLBg0xz8GbxzFmQK7QA@mail.gmail.com>
	<8734aeteef.wl-tiwai@suse.de>
	<CAHk-=wgO0Rx2LcYT4f75Xs46orbJ4JxO2jbAFQnVKDYAjV5HeQ@mail.gmail.com>
	<CAHk-=wjwR=hNLA7SzdnM5BvaBAwm2cVeZRR7uEo+3625SaiOjg@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,kernel.org,gmail.com,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,linux-foundation.org:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 934621F385
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

On Wed, 30 Jul 2025 19:21:25 +0200,
Linus Torvalds wrote:
> 
> On Wed, 30 Jul 2025 at 09:50, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > And no, the answer is *not* "make everything enabled by default".  If
> > somebody has a working configuration for their setup, new subdrivers
> > shouldn't be enabled by "make oldconfig", because clearly those new
> > drivers aren't relevant.
> >
> > So no - not "default y".
> 
> Ahh. I looked closed - I should have done that earlier. It looks like
> this was just a split, not a rename like I thought earlier.
> 
> But a plain 'default y' is still the wrong thing to do because you do
> *not* want to enable this if people didn't have CODEC_HDMI enabled
> originally. So it would have to be a
> 
>         depends on SND_HDA_CODEC_HDMI
>         default y
> 
> But then you couldn't disable the generic code.
> 
> What *might* work is having both
> 
>         default SND_HDA_CODEC_HDMI
>         select SND_HDA_CODEC_HDMI
> 
> which looks confusing, but should mean that if SND_HDA_CODEC_HDMI was
> selected, the sub-option is on by default
> 
> It looks pretty iffy, honestly, but I _think_ i tworks.

Hm, it's also what I thought of, but rather avoided because it looks
too tricky.

But, if this is acceptable and preferred over default y, I can take
this approach, too.

> I do think that the right model is to keep the old name for the old
> functionality, and have a structure something like
> 
>   config SND_HDA_CODEC_HDMI
>         tristate "Enable all HD-audio HDMI drivers"
>         select SND_HDA_CODEC_HDMI_INTEL
>         select SND_HDA_CODEC_HDMI_...
> 
> And then the new common hdmi code should have a mew and *different*
> Kconfig option name that the sub-drivers select (so
> "SND_HDA_CODEC_HDMI_COMMON" or whatever).
> 
> on't re-use an old name for some new fucntionality, unless you've
> waited at least a full release or two for peoples kernel configs to
> have been refreshed to the new setup.
> 
> With *that* kind of structure, you get
> 
>  - people who didn't use to have this enabled still don't have it
> enabled by default, so "make oldconfig" does the right thing
> 
>  - people who did have  SND_HDA_CODEC_HDMI enabled see no difference:
> they still get all versions
> 
>  - you can now decide to disable SND_HDA_CODEC_HDMI, and then enable
> the sub-drivers individually
> 
> so that would seem to have full functionality, and avoids the
> confusion of having the that combination of "select" and "default".

Yeah, we had another splits in HDMI codecs and this was even more
incompatible with the previous kconfig.  I noticed too late and the
patch set I posted today tries to address it in addition to Realtek
codecs.

So, in the posted patch set (you're on Cc):

- CONFIG_SND_HDA_CODEC_REALTEK and CONFIG_SND_HDA_CODEC_HDMI are the
  top-level config to enable Realtek and HDMI codecs, and those can be
  carried from the previous config as is.

- Kconfigs for the new split drivers CONFIG_SND_HDA_CODEC_ALC* and
  CONFIG_SND_HDA_CODEC_HDMI_* are with default=y, so that they are
  picked up when *_REAKTEK or *_HDMI is chosen from the previous
  kconfig.  User may still disable each item individually.

At least, this will give equivalent functionalities when carrying from
the 6.16 kernel config on the 6.17 kernel.  The rest optimization is
left to users.

I'm fine to change in other way if there can be more reasonable way,
of course.  Let me know what you think.


Thanks!

Takashi

