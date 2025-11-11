Return-Path: <linux-kernel+bounces-895914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAFFC4F410
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE6954EB5B8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C81377E9E;
	Tue, 11 Nov 2025 17:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gqHSa2Da";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CLQ19KY7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ipx5z8bi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DZT8p5E2"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE78328244
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762882462; cv=none; b=hzw5jp6VpgKKC0CLafPTv3X1Eou3AtEkMl+0wlyde6BxQ73YDMYnWmQma3kWBGnwxmzyBsY6CpXnYyjcBQhYr9TunFdQV/WRt+IZ9X2zOi5oNjuGl3kullIujd5c+YdvcvF76Rh25YHfrzVSammW8bT1D3qUvT20eHmknvN0ZGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762882462; c=relaxed/simple;
	bh=HAX/bqf3b9TONupOaUirhSAkDc3jcOXLWNYRjwVlWDY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TlT4vP6UNDFp7QzK0PZZvWAACmtQkUaw0ow0eNxcvhBmXRys7nLTMT2QdW3qIWfrhdV5Xnuu979h8lL205S9Nq/PSE7+vxLOD2rN7rcIt+Z9E6ChNze6SH5/sfH0LjbCCG0I18EuI0mRo9JWvBEIuzvPWnDoJqMC1vFMcBBSAZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gqHSa2Da; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CLQ19KY7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ipx5z8bi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DZT8p5E2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1F8742127E;
	Tue, 11 Nov 2025 17:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762882458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F3/tqFUaAI1FSDSHta890x3Ayxz38ULlWQmPJtNMdys=;
	b=gqHSa2DaT7clhC++vQsKrklEUaz0xQNDy6GCnAK7lIMC186VsZhCbs1enVga6dVqsOZyfq
	ElzoGKGP90OTPAs+QJHikPl2LJKfzFPBGfp8ZyrzQBBdxEVXxdgeZZsRZY8gSpmXX+YEYh
	qTwAmbcgO4uC5CV68yXJqAalffucpOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762882458;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F3/tqFUaAI1FSDSHta890x3Ayxz38ULlWQmPJtNMdys=;
	b=CLQ19KY7edQfJHQFQbspliHBN0JqevBOqOOUXv8lG1h/n9x59JMnACYWrr+ersox0jeT/o
	nURn6N3gmV2lnaDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ipx5z8bi;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DZT8p5E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762882457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F3/tqFUaAI1FSDSHta890x3Ayxz38ULlWQmPJtNMdys=;
	b=ipx5z8bi5YFuwc8tlnbMgV2gEegGCVg18HwO+IWtqervMWYFIO+ojNVFw12xaoGD4KEh5K
	3gk8sLxovXlzhHShH/luRs1YD95jhr9zGH9Dr4PjIOQSN7xzmzvdUtXdZMYqcs4VPaFJXf
	0844iuTHUjuUELSBdfTSKALd2B6+VW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762882457;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F3/tqFUaAI1FSDSHta890x3Ayxz38ULlWQmPJtNMdys=;
	b=DZT8p5E2QsrX0sWzqPiynuPywYWJkm3DROxEcWkUJkEO9WFtVG4YYkoF6gAZZlaj6d435y
	WodvHTkkog1Is8Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7E6114A91;
	Tue, 11 Nov 2025 17:34:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xzIgN5hzE2mUVAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 11 Nov 2025 17:34:16 +0000
Date: Tue, 11 Nov 2025 18:34:16 +0100
Message-ID: <874ir0jwx3.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Haein Lee <lhi0729@kaist.ac.kr>
Cc: Takashi Iwai <tiwai@suse.de>,
	perex@perex.cz,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH v3] ALSA: usb-audio: Fix NULL pointer dereference in snd_usb_mixer_controls_badd
In-Reply-To: <vwhzmoba9j2f.vwhzmob9u9e2.g6@dooray.com>
References: <vwhzmoba9j2f.vwhzmob9u9e2.g6@dooray.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.1 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 1F8742127E
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid]
X-Spam-Score: -3.51

On Tue, 11 Nov 2025 16:37:54 +0100,
Haein Lee wrote:
> 
> In snd_usb_create_streams(), for UAC version 3 devices, the Interface
> Association Descriptor (IAD) is retrieved via usb_ifnum_to_if(). If this
> call fails, a fallback routine attempts to obtain the IAD from the next
> interface and sets a BADD profile. However, snd_usb_mixer_controls_badd()
> assumes that the IAD retrieved from usb_ifnum_to_if() is always valid,
> without performing a NULL check. This can lead to a NULL pointer
> dereference when usb_ifnum_to_if() fails to find the interface descriptor.
> 
> This patch adds a NULL pointer check after calling usb_ifnum_to_if() in
> snd_usb_mixer_controls_badd() to prevent the dereference.
> 
> This issue was discovered by syzkaller, which triggered the bug by sending
> a crafted USB device descriptor.
> 
> Signed-off-by: Haein Lee <lhi0729@kaist.ac.kr>

Applied now.  Thanks.


Takashi

