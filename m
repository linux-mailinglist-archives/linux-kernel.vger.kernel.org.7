Return-Path: <linux-kernel+bounces-818656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAFFB594BC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79E4F320892
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E6A29B8CF;
	Tue, 16 Sep 2025 11:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0IudwxDP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/pCf9BOv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i1hG1qLs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vYA8IU4j"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8E229B237
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758020710; cv=none; b=UanVPQPM3n2SODvYQCXX1Vvy9qVN+59JMaEEATMmXWv7ZKuSAj/COdwTjJNitdpDDN+iyDXkNgn1DIq413xcRCj4xfM7Qltabiupeq94pb8gwJkWUWSvl3P0bcGBQkzhq7vyJQH7JQD/+YJjlpe7LogtEwgJRo1/hZUU9vAjImU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758020710; c=relaxed/simple;
	bh=vFKm95yvy2d/TS1Th38odrtuApc5Hd4H/vpcgg5VKlc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uy+MxeMZ6tqaIB6WNZroH2/qRCEZv41MLCpllaxHHCi1jB34JW2Apaq03NYEPNDQuklNdY2UmyP1SSE0LoiLorLBL7KlffONoeH89ddhlgm3vjkRIPTbplsH6yhth2CdBfjqKcxlLdAgP1BRU+Vok3oSBG0hIld2W/D9x2vYAVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0IudwxDP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/pCf9BOv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i1hG1qLs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vYA8IU4j; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C7532225DE;
	Tue, 16 Sep 2025 11:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758020707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bSA/1dfhCMRCbUQX8xLJ12Hvcc7BJ1H69XxJaJSq4+0=;
	b=0IudwxDPKZqe1FXfo9UXVNVWlO2ay5MtuX+q7pF0ZBsA6kNaTlMDVJAKnTvgNEMr3Zr4er
	kKpCwxJ07dMArSoIMW9rMb0oE2Nxqh0w0cQheSv0NygM2B8MkZhVZiMnSOLN8vF4irpiHx
	ZmCejx3/wdMi9y2H/C60IRC6TiQHID4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758020707;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bSA/1dfhCMRCbUQX8xLJ12Hvcc7BJ1H69XxJaJSq4+0=;
	b=/pCf9BOvYNqnuLwO7Wx6EBZbebvuvGYGXC/gmCfZhUojItp4jfoWj+E3Z/RSgPZOzaLa3E
	xy56gV4E+ESF13CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=i1hG1qLs;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vYA8IU4j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758020706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bSA/1dfhCMRCbUQX8xLJ12Hvcc7BJ1H69XxJaJSq4+0=;
	b=i1hG1qLsiuD/7kYXwWv7HG9sBAAeArpUc6xbFDUmVihcbQ+ogrW+p/bB21EH1r2TndERiI
	RaL85qrD/kW9qpUNqNpbjE28g2XUIE/MqA26bCfS2nbtq95VS/vzx/wlbOFupyVD32qAEl
	0bP0eLQI6mzmd+28F/8WY93YruoA2h4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758020706;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bSA/1dfhCMRCbUQX8xLJ12Hvcc7BJ1H69XxJaJSq4+0=;
	b=vYA8IU4jQQq8GBuZqyWFTeGaxtaDNHjF63puCwOawl84pMT+rj/nnYtPkCaL9YG3qlfQ2r
	uh8N4royRj2sCDAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E41E139CB;
	Tue, 16 Sep 2025 11:05:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kDSAHWJEyWjBWwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 16 Sep 2025 11:05:06 +0000
Date: Tue, 16 Sep 2025 13:05:06 +0200
Message-ID: <87h5x21wv1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: hariconscious@gmail.com
Cc: shuah@kernel.org,
	syzbot+c3dbc239259940ededba@syzkaller.appspotmail.com,
	linux-kernel-mentees@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Subject: Re: [PATCH] sound/core/seq : fix data-race in snd_seq_fifo_cell_out/snd_seq_fifo_poll_wait
In-Reply-To: <20250916104547.27599-2-hariconscious@gmail.com>
References: <20250916104547.27599-2-hariconscious@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[c3dbc239259940ededba];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: C7532225DE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.01

On Tue, 16 Sep 2025 12:45:48 +0200,
hariconscious@gmail.com wrote:
> 
> From: HariKrishna Sagala <hariconscious@gmail.com>
> 
> data race in both the functions, snd_seq_fifo_cell_out &
> snd_seq_fifo_poll_wait is protected with guards

Please don't, this will lead obviously to a deadlock!
fifo_cell_out() is already protected by f->lock spinlock.
You can at most protect the f->cells reference in
snd_seq_fifo_poll_wait().  Or change f->celss to atomic_t.

But, practically seen, it won't fix any real issue.  The evaluation
there can be racy in anyway.

Also the patch doesn't follow the coding style.
I sincerely hope you verify your patch whether it really works before
submitting at the next time.


thanks,

Takashi

> 
> Reported-by: syzbot+c3dbc239259940ededba@syzkaller.appspotmail.com
> Fixes: https://syzkaller.appspot.com/bug?extid=c3dbc239259940ededba
> Signed-off-by: HariKrishna Sagala <hariconscious@gmail.com>
> ---
>  sound/core/seq/seq_fifo.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/sound/core/seq/seq_fifo.c b/sound/core/seq/seq_fifo.c
> index f23c6b7ae240..65e28ebb0eb1 100644
> --- a/sound/core/seq/seq_fifo.c
> +++ b/sound/core/seq/seq_fifo.c
> @@ -138,16 +138,18 @@ static struct snd_seq_event_cell *fifo_cell_out(struct snd_seq_fifo *f)
>  {
>  	struct snd_seq_event_cell *cell;
>  
> -	cell = f->head;
> -	if (cell) {
> -		f->head = cell->next;
> +	scoped_guard(spinlock_irqsave, &f->lock) {
> +		cell = f->head;
> +		if (cell) {
> +			f->head = cell->next;
>  
> -		/* reset tail if this was the last element */
> -		if (f->tail == cell)
> -			f->tail = NULL;
> +			/* reset tail if this was the last element */
> +			if (f->tail == cell)
> +				f->tail = NULL;
>  
> -		cell->next = NULL;
> -		f->cells--;
> +			cell->next = NULL;
> +			f->cells--;
> +		}
>  	}
>  
>  	return cell;
> @@ -210,7 +212,9 @@ int snd_seq_fifo_poll_wait(struct snd_seq_fifo *f, struct file *file,
>  			   poll_table *wait)
>  {
>  	poll_wait(file, &f->input_sleep, wait);
> -	return (f->cells > 0);
> +	guard(spinlock_irqsave)(&f->lock);
> +	int isNonzero = (f->cells > 0);
> +	return isNonzero;
>  }
>  
>  /* change the size of pool; all old events are removed */
> -- 
> 2.43.0
> 

