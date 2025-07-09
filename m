Return-Path: <linux-kernel+bounces-723832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7003AFEB36
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 862BF7BF953
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3172E5403;
	Wed,  9 Jul 2025 14:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Rp7Zp+wv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aVb+cPFe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Rp7Zp+wv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aVb+cPFe"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145522DFA39
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069917; cv=none; b=jowrm8wpDimE6vmVp9HoihaAVu93wrw/tzchbf7wLP8XcN2mH8M4yBCskpTcMeM8VeLDpA0q3DkpIY5buioN2ZhsAe+6pZkre4Lrq598CWxnBm6jh9E1vlqBwwWjBRIQi48TcYJt/XhNbhqXy5e1v2JHBoV08Dh5t5uil1sP/OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069917; c=relaxed/simple;
	bh=KGfAJ6S8DkYLAgFRf6mFgbIsxJFtjm/pPjbrTp+6KWk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hx3A7tYNymvJijfap9FUZqt94q0QeYurNWXg1dkSzt/9YkFNfmF8NVF6taCEkWeOpxsl3/jvmSIMxMibsK4GA6McI0BRoqKLA/HCpssI19tRFWWT1h64IpA69RoH7NYBvYxecVZQTHYPOl88NzgJNI7ECFkv0yqeWxhMHkyYHDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Rp7Zp+wv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aVb+cPFe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Rp7Zp+wv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aVb+cPFe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4B0D421180;
	Wed,  9 Jul 2025 14:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752069913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YFCuDeXH9gcgXKY5utV2N3tM4+McLOz1DbiaNH9BzMk=;
	b=Rp7Zp+wvMsijbHfQWt68vw+I5GpAFty4/x++jee4BV/H4KGTOGqbSHTKayPfeyIjRuVZHH
	58yFJcK19Di4OuUw6ECiPh7EKaRlQrDf9+hAg2nH8TjEL66EmgWvoE65wIMD7V/AMhtzLp
	KpaMAQtI7TASb9x3OJ5P2zeFxzKrleI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752069913;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YFCuDeXH9gcgXKY5utV2N3tM4+McLOz1DbiaNH9BzMk=;
	b=aVb+cPFeXa13ZWyDs511JdDNy4M+m8jQmbGqXqgNchhkdLYOe2jkUdEXg80XqX3HrYENnj
	oOP+zrqMZGfLMcDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752069913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YFCuDeXH9gcgXKY5utV2N3tM4+McLOz1DbiaNH9BzMk=;
	b=Rp7Zp+wvMsijbHfQWt68vw+I5GpAFty4/x++jee4BV/H4KGTOGqbSHTKayPfeyIjRuVZHH
	58yFJcK19Di4OuUw6ECiPh7EKaRlQrDf9+hAg2nH8TjEL66EmgWvoE65wIMD7V/AMhtzLp
	KpaMAQtI7TASb9x3OJ5P2zeFxzKrleI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752069913;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YFCuDeXH9gcgXKY5utV2N3tM4+McLOz1DbiaNH9BzMk=;
	b=aVb+cPFeXa13ZWyDs511JdDNy4M+m8jQmbGqXqgNchhkdLYOe2jkUdEXg80XqX3HrYENnj
	oOP+zrqMZGfLMcDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CA68136DC;
	Wed,  9 Jul 2025 14:05:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RqjOARl3bmgPZwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 09 Jul 2025 14:05:13 +0000
Date: Wed, 09 Jul 2025 16:05:12 +0200
Message-ID: <87bjptzch3.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Philipp Stanner <phasta@kernel.org>,
	Andres Urian Florez <andres.emb.sys@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: echoaudio: Replace deprecated strcpy() with strscpy()
In-Reply-To: <20250709124655.1195-1-thorsten.blum@linux.dev>
References: <20250709124655.1195-1-thorsten.blum@linux.dev>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,linux.intel.com,kernel.org,gmail.com,suse.de,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,linux.dev:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -1.80

On Wed, 09 Jul 2025 14:46:52 +0200,
Thorsten Blum wrote:
> 
> strcpy() is deprecated; use strscpy() instead.
> 
> No functional changes intended.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Thanks, applied now.

And now I'm going to convert all the rest of such trivial stuff
(strcpy() with card->driver, shortname, mixername, longname, as well
as pcm->name, and else) in sound/* for 6.17.


Takashi

