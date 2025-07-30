Return-Path: <linux-kernel+bounces-750205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA39B15892
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 07:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 606F67A8EC9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 05:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6424F1DF98F;
	Wed, 30 Jul 2025 05:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NCflYRSD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hpgqwG4O";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NCflYRSD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hpgqwG4O"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4E81D88D7
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 05:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753854684; cv=none; b=B8PjyG1G6bs76OQwwaTT1GENIJc2ZZ2SiLI7cJWLIJOrlsBBUcl9BeHnFz7f31ko30QpiGVfLOOVD7WOHC0TthP5KoZG1hbUzFQwHO2A8Ig3KLGG0DyDTXif5mDspLw6NWo5jAF+FmtypQaA5jV9S2cqFl40dyQBb9imepK+fm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753854684; c=relaxed/simple;
	bh=J4/IkaYaG6stL4lwmzCakG80AjOE/JfKtdTmXLcEmwA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cvO5P0p1JbezHmQxOfD5xSKqNL+cSrrJhNEap0EBGGRyLk8bTm5SwbWICu3AqLahVm9kWybwVJlAQin2ICMTFWe0Ul4r/Xt1IPFEH3gAnx4Tur6IxRlJjGOZjpZZOalgV5hdMBqZI9eG6LV9gC/HDzIKztDlstoya2/wB7MXs4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NCflYRSD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hpgqwG4O; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NCflYRSD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hpgqwG4O; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5363E1F801;
	Wed, 30 Jul 2025 05:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753854681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ftgbdj+tRgnyXeiU8fYwMiTHN5BncScmTxtP5sjAI/Q=;
	b=NCflYRSD0qDXSqsFZxnm6z0hEAi/1TLgyP/6cboVXShAIIuO6zrOsj6ycHljapBrZr72tp
	MSl87yAuRKCM56Kjr3tC04fzE5APABUE0TA2jGL7zV7l2F2L8HNuzGBjLPt1zMmC1zIk6A
	6zA3H+yNDRj1YAmpAfFfvYTavmOH9eE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753854681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ftgbdj+tRgnyXeiU8fYwMiTHN5BncScmTxtP5sjAI/Q=;
	b=hpgqwG4OK1fy76OaL9qwITCHHBN5hMSmJcooJu2bK/QwqkxIdoUwnRXqNQSi0HIhVDs6n3
	deuQf36kNq3Jx3DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753854681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ftgbdj+tRgnyXeiU8fYwMiTHN5BncScmTxtP5sjAI/Q=;
	b=NCflYRSD0qDXSqsFZxnm6z0hEAi/1TLgyP/6cboVXShAIIuO6zrOsj6ycHljapBrZr72tp
	MSl87yAuRKCM56Kjr3tC04fzE5APABUE0TA2jGL7zV7l2F2L8HNuzGBjLPt1zMmC1zIk6A
	6zA3H+yNDRj1YAmpAfFfvYTavmOH9eE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753854681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ftgbdj+tRgnyXeiU8fYwMiTHN5BncScmTxtP5sjAI/Q=;
	b=hpgqwG4OK1fy76OaL9qwITCHHBN5hMSmJcooJu2bK/QwqkxIdoUwnRXqNQSi0HIhVDs6n3
	deuQf36kNq3Jx3DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2797A13479;
	Wed, 30 Jul 2025 05:51:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R8KRCNmyiWi4KgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 30 Jul 2025 05:51:21 +0000
Date: Wed, 30 Jul 2025 07:51:20 +0200
Message-ID: <8734aeteef.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Linux Sound Mailing List <linux-sound@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] sound updates for 6.17-rc1
In-Reply-To: <CAHk-=whvoZuw-Cv2Bx2ip8Kq4j9jw0meLBg0xz8GbxzFmQK7QA@mail.gmail.com>
References: <87ecu4idvc.wl-tiwai@suse.de>
	<CAHk-=wjj9DvOZtmTkoLtyfHmy5mNKy6q_96d9=4FUEDXre=cww@mail.gmail.com>
	<CAHk-=whvoZuw-Cv2Bx2ip8Kq4j9jw0meLBg0xz8GbxzFmQK7QA@mail.gmail.com>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,kernel.org,gmail.com,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

On Wed, 30 Jul 2025 06:45:35 +0200,
Linus Torvalds wrote:
> 
> On Tue, 29 Jul 2025 at 21:21, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I think that's realtek, but when I enable it, I get this mess of
> > "which realtek", which I have no idea because the ALC3271 that the
> > kernel used to print out is not mentioned.
> 
> Enabling them all makes the kernel recognize it as a ALC3271 again,
> and it appears to have loaded the alc269 one.
> 
> But sound is still gone, so there's something else still missing. But
> I'm heading off for the night now...

It's a dilemma of the default kconfig enablement.  In general we want
to keep the default disabled for leaf drivers.

CONFIG_SND_HDA_CODEC_REALTEK is still present but now it's a
menuconfig, so this is taken over from the previous config.  The
remaining CONFIG_SND_HDA_CODEC_ALC* are the missing stuff.
Maybe we should set CONFIG_SND_HDA_CODEC_ALC*=y as default as an
exception for smooth upgrade?

I guess the same applies to the HDMI audio stuff, too.


Takashi

