Return-Path: <linux-kernel+bounces-896865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3619C516D4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8FB6421274
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE342264B8;
	Wed, 12 Nov 2025 09:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="f8yHfq0J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/g/2+Eum";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="f8yHfq0J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/g/2+Eum"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE092274B55
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940106; cv=none; b=hj8w6j+I12+CPXisGtIOsd6bLydaLXIdmvZmLi4gVXAjzT4YhhD3QJh0tPZbGx+68LRBhpt9yYuGtjQ8wXyd6InJYJsMnKXayEla9k6bwDlZ7yekZChGCals5FGKZIZIYqo1GMDodOUS5qGrNOQ7h28HwwlmMclEweCvimQJByE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940106; c=relaxed/simple;
	bh=tMP3K24WKi3enSnKfjQUg+Ty83Oo/ke+ztiILFsoJug=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ekI48M/KeVZcfD14L8dshrQMrhjunUW66Zhs7LymQ3AsNR0MTwMMb46Y1Bhl35cp0UWSKU++HRoa23s2Fp2pQ883xCgyXuwZbF8yuakAu+UJrg4yrMUz1BizjkYMzwwo7nSvZgFOmh6870DmHJbxy3muP0Hn/YNphe/Y+dFBYlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=f8yHfq0J; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/g/2+Eum; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=f8yHfq0J; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/g/2+Eum; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1AF341F45E;
	Wed, 12 Nov 2025 09:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762940103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NRz7yHeIJLTEpAjNXPmhe7j3wA+843y/brep2u7GA4A=;
	b=f8yHfq0J04x87KTeJ7cIy4T8NPFCdaZhMnbdHqrLlWwvgpNZdy0WWBQXVaYDUPlDJG1Tk4
	OsSCKlq/zbd4LmzRjyVAX/zPkrOd5POpMiY9SDKZheRNcm/sD/Hbo0HVD/oTVRFAjOcz8c
	0Cy9Lmklus2JeIYBzCGGwBhMZ3SJVg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762940103;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NRz7yHeIJLTEpAjNXPmhe7j3wA+843y/brep2u7GA4A=;
	b=/g/2+EumBqH/tgtCXMTAQpOnl/ewRNIhuvVbdf5arqwHbAAExUB9uvy7imbBOVzfwQkRtT
	AcRKenlFGQmPrsCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=f8yHfq0J;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/g/2+Eum"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762940103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NRz7yHeIJLTEpAjNXPmhe7j3wA+843y/brep2u7GA4A=;
	b=f8yHfq0J04x87KTeJ7cIy4T8NPFCdaZhMnbdHqrLlWwvgpNZdy0WWBQXVaYDUPlDJG1Tk4
	OsSCKlq/zbd4LmzRjyVAX/zPkrOd5POpMiY9SDKZheRNcm/sD/Hbo0HVD/oTVRFAjOcz8c
	0Cy9Lmklus2JeIYBzCGGwBhMZ3SJVg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762940103;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NRz7yHeIJLTEpAjNXPmhe7j3wA+843y/brep2u7GA4A=;
	b=/g/2+EumBqH/tgtCXMTAQpOnl/ewRNIhuvVbdf5arqwHbAAExUB9uvy7imbBOVzfwQkRtT
	AcRKenlFGQmPrsCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1E963EA61;
	Wed, 12 Nov 2025 09:35:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mSDwNcZUFGk2BwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 12 Nov 2025 09:35:02 +0000
Date: Wed, 12 Nov 2025 10:35:02 +0100
Message-ID: <87y0obioft.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: <perex@perex.cz>,
	<tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] ALSA: gus: Remove unused declarations
In-Reply-To: <20251112092007.3546539-1-yuehaibing@huawei.com>
References: <20251112092007.3546539-1-yuehaibing@huawei.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.1 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 1AF341F45E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 

On Wed, 12 Nov 2025 10:20:07 +0100,
Yue Haibing wrote:
> 
> snd_gf1_synth_init() and snd_gf1_synth_done() were declared but never
> implenmented and used since the beginning of kernel git history.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Thanks, applied now to for-next branch.


Takashi

