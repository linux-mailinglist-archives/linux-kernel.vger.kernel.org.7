Return-Path: <linux-kernel+bounces-768799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F96B26596
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61F62B62B86
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EF52FCC1B;
	Thu, 14 Aug 2025 12:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qDtmmiXu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2W9qIQro";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qDtmmiXu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2W9qIQro"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61ED2FA0C9
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 12:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755175325; cv=none; b=MUeGLZF2QnbrlhroplSOOYJnnfGA1SCIKM5Eg5fI+QYsuRuo1FLDVpJ7iDLllMxTFj1KMhadUMvSTLiRp8MBM7S6gPSfX77eBZApieE8T8Sdp8rQ1Fb3TYN5DxvLdNfi655GLx25zlEVdrj/iPHWxYLOPoNAMVzHqdZKBYD/Hjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755175325; c=relaxed/simple;
	bh=YyHpFO0KSTpBx5gfTBmuvK8Xc7WiwGl96/DqEfPKsWw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Virs6kJ2LXwVYB8+9gf21q6nz1vd4MtGfGB+JIIk1zgmaylDmX8cHkp+ZkREPwyHR8C7hancm+8hOOS45CA6UvC2gIRKPr2xkDBZmo4/VzkPCI1n8vDascFazEt3T1fGweL/Mu3Z7Znl6N+gqo2FIZXlVs50lbQ738emQ8/8pEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qDtmmiXu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2W9qIQro; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qDtmmiXu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2W9qIQro; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1024C21A4A;
	Thu, 14 Aug 2025 12:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755175322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vEcbyebqz1LZffVHMdXFysP+zfMDXOhQZOjdpfvS5sw=;
	b=qDtmmiXuQpB40H8qChE4nCt352d2H6tPca2aiag82jDhQaxAogyhjKATOJNLwQQ2JAj1Pi
	8yKUJf0/JotYuTnAKlmf1pfL/9K4G0lCgwfUzf013mlzUHFklWK/ZQNHjMgAtVM70U+giN
	TbppjEsuTupbeD4EQ92RXJPfjCk7uY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755175322;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vEcbyebqz1LZffVHMdXFysP+zfMDXOhQZOjdpfvS5sw=;
	b=2W9qIQroT4k0H2+XSnLImvlvc+TyC7ocK0LG7omJ/g7pXNc7tSeW2LNQ3CCfOU8H6o6GAe
	uXLDc4jLa4Kp7ECQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755175322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vEcbyebqz1LZffVHMdXFysP+zfMDXOhQZOjdpfvS5sw=;
	b=qDtmmiXuQpB40H8qChE4nCt352d2H6tPca2aiag82jDhQaxAogyhjKATOJNLwQQ2JAj1Pi
	8yKUJf0/JotYuTnAKlmf1pfL/9K4G0lCgwfUzf013mlzUHFklWK/ZQNHjMgAtVM70U+giN
	TbppjEsuTupbeD4EQ92RXJPfjCk7uY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755175322;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vEcbyebqz1LZffVHMdXFysP+zfMDXOhQZOjdpfvS5sw=;
	b=2W9qIQroT4k0H2+XSnLImvlvc+TyC7ocK0LG7omJ/g7pXNc7tSeW2LNQ3CCfOU8H6o6GAe
	uXLDc4jLa4Kp7ECQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD6F91368C;
	Thu, 14 Aug 2025 12:42:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uZn6MJnZnWiRWgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 14 Aug 2025 12:42:01 +0000
Date: Thu, 14 Aug 2025 14:42:01 +0200
Message-ID: <87wm76t6qu.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Xu, Baojun" <baojun.xu@ti.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"Ding, Shenghao"
	<shenghao-ding@ti.com>,
	"13916275206@139.com" <13916275206@139.com>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH v1] ALSA: hda/tas2781: Normalize the volume kcontrol name
In-Reply-To: <871ppewgzx.wl-tiwai@suse.de>
References: <20250813100842.12224-1-baojun.xu@ti.com>
	<417f8e1c8a314ae4a77070f313d8af2c@ti.com>
	<871ppewgzx.wl-tiwai@suse.de>
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
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_ENVRCPT(0.00)[139.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,alsa-project.org,ti.com,139.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Thu, 14 Aug 2025 08:32:18 +0200,
Takashi Iwai wrote:
> 
> On Thu, 14 Aug 2025 04:29:10 +0200,
> Xu, Baojun wrote:
> > 
> > Hi,
> > 
> > Answer in line.
> > 
> > > ________________________________________
> > > From: Takashi Iwai <tiwai@suse.de>
> > > Sent: 13 August 2025 23:44
> > > To: Xu, Baojun
> > > Cc: broonie@kernel.org; andriy.shevchenko@linux.intel.com; alsa-devel@alsa-project.org; Ding, Shenghao; 13916275206@139.com; linux-sound@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Subject: [EXTERNAL] Re: [PATCH v1] ALSA: hda/tas2781: Normalize the volume kcontrol name
> > > 
> > > On Wed, 13 Aug 2025 12:08:42 +0200,
> > > Baojun Xu wrote:
> > > >
> > > > Change the name of the kcontrol from "Gain" to "Volume".
> > > 
> > > Could you describe "why this change is needed"?
> > > 
> > This name is in kcontrol, which is open to users.
> > Volume is more normalized and common.
> > Gain is a more professional term in smart amplifiers.
> 
> But did you realize that changing the control name may change the
> user-space behavior completely?
> e.g. alsa-lib implementation tries to group control elements per
> prefix and suffix, and "Volume" is one of the standard suffix.
> That is, with this change, it'll appear as "Speaker Analog" as a mixer
> element name where the former name is "Speaker Analog Gain".
> 
> I'm not against the proposed rename.  But please remember that control
> names aren't something you can change easily because you don't feel
> good; it's a thing to be more or less "fixed" once after defined in
> the release products.

Nevertheless I applied the patch now, as Mark already took for ASoC
side.


thanks,

Takashi

