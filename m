Return-Path: <linux-kernel+bounces-835241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3056FBA68F8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 08:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68F2C189BA91
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 06:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C03F29ACE5;
	Sun, 28 Sep 2025 06:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="q4NxVItG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gopsC9IK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TEvM++pd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ItAED/os"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B17C221554
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 06:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759040962; cv=none; b=qtK7A485OItSjw8vhSzpoDSXNypMk27JyHqNQ5XtSCSotjhGB5GEMzRwQ3ZjvHIKHLzRhvEiRfB78W6cVBgB83Jj3bYRKEIp4GIz8+8/Zckbzq6QUpbj0od/Fr9FlsFhFLO8Vciu7pkN0a99x3OO9vDVAtbzCRNatbkTHlFvWuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759040962; c=relaxed/simple;
	bh=Q0kSqx2RD66kEUb1EsQN0f7j2i7OKh54zm7op4xLdmI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nqOZATiP8JHpYpZuRcPw3JUffLOJBhPLvqOOJFi4OEE4dbqpggKjwxv0pyXMtQyr8dpUwCL1xGdDgmDwbWGslh5Wv/sFB8zRSGYdOeXlYKhI1mV1tMl3aiufvUaxUSkfi4OxS8EX22ksAqNKn/ZMH4+F2z09TlJRDaSF6WxvN5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=q4NxVItG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gopsC9IK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TEvM++pd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ItAED/os; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D46BA2563A;
	Sun, 28 Sep 2025 06:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759040959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ngrdxtMZBo1xK420PZQQilcWY5XFDxsEVChCdjz86kk=;
	b=q4NxVItGu7Ch952v8Ff5EgwyIWw5SxbGd4w+VyGB2SgpE0lPnKnm63Dz6/vRoSIJSaBBzi
	wRnn+lzbG7v+hter7J51BnYi8FrOsApPYJKkdB0FzuK50FN/l/knTfNZhLE58vwfxY/slX
	Nwxp5Ie53JZNVNJf4YSs0kitefuRNTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759040959;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ngrdxtMZBo1xK420PZQQilcWY5XFDxsEVChCdjz86kk=;
	b=gopsC9IKNjWBT3MXsbGGtMnbTEeENbx5fpngFczUSTQGDCT8NdVcpKUsltcJTAHVq+HQYf
	xdDBsq1fjnYGFJAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TEvM++pd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="ItAED/os"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759040958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ngrdxtMZBo1xK420PZQQilcWY5XFDxsEVChCdjz86kk=;
	b=TEvM++pdkF9mjdBSfSYkidEahgRIpQ9McTU3d19jNooc+CFWJ4HKCCRSj93mUHU7gAn3HL
	mRhqFBxG5If+mTwbuYZtonIfKoKVWBBiLzVZxEEbLO5DQsQDo2JPCoK5U8NEjLIkV0DybV
	4KjU55/+H0emiyEnDiXjF9x24JpP5oc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759040958;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ngrdxtMZBo1xK420PZQQilcWY5XFDxsEVChCdjz86kk=;
	b=ItAED/oslU9XVQ3tAenAat9JhQysNgyczmcQ3NqOj9sBLffdjuNkL3yEAKFdi+7oXmAfNl
	9bv18d8B5KOVi5BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 95C8C13A3F;
	Sun, 28 Sep 2025 06:29:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id He0iI77V2Gj7FwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 28 Sep 2025 06:29:18 +0000
Date: Sun, 28 Sep 2025 08:29:18 +0200
Message-ID: <878qhz9jk1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Alexey Klimov <alexey.klimov@linaro.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: compress: document 'chan_map' member in snd_dec_opus
In-Reply-To: <20250927142708.1097601-1-kriish.sharma2006@gmail.com>
References: <20250927142708.1097601-1-kriish.sharma2006@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,perex.cz,suse.com,gmail.com,linaro.org,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: D46BA2563A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.01

On Sat, 27 Sep 2025 16:27:08 +0200,
Kriish Sharma wrote:
> 
> When building kernel docs, the following warning appeared:
> 
>   WARNING: ./include/uapi/sound/compress_params.h:364
>   struct member 'chan_map' not described in 'snd_dec_opus'
> 
> The inline struct 'snd_dec_opus_ch_map' inside 'snd_dec_opus' was not
> properly documented. This patch documents the 'chan_map' member and its
> fields (stream_count, coupled_count, channel_map), resolving the warning.
> 
> Fixes: 5d36370f3431 ("ALSA: compress: add raw opus codec define and opus decoder structs")
> Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
> 
> v2:
>   - Use proper subject prefix ("ALSA: compress: ...")
>   - Add Fixes tag for the commit that introduced snd_dec_opus
>   - Add Suggested-by tag (Bagas Sanjaya)

Thanks, applied now.


Takashi

