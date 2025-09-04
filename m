Return-Path: <linux-kernel+bounces-800533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B46BEB438EC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552C71889472
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712032EC0A7;
	Thu,  4 Sep 2025 10:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C5KBTlMo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rYzdZRGQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rQ3/syLW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oVQyoGe+"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176AA7081F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 10:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756982290; cv=none; b=Ynxczk53Wp8RwAocauBayBNEPGAqbFYVqzxHdtwzPapE1N1n7xPuy2UE6dNClAHZRHXi0BqrLeS6lUyjYulKA4dOms44B2YnZmjNWSu4yZ+HumQHYlqYPyiFjFc417SRKFOZdwCZXUT0RtbgeHpAjXsa/z3UrVyEzYfgx61YicE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756982290; c=relaxed/simple;
	bh=zFCZNR0/Oeq4eFVi6ZSGlqzw+Q5YIQwiZXjHXrX0gHs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g0NHupxx4yflnzz5pQx3yRQGNJEdL4ED7Visa3cL95v8WawV+DZMTxcGkKpaU8Aiw0GBfUAV66TtmSbt6SoFh7+iOD3jFbGJ+l++NX6NFj0WHJtdoRP8pdmmaxcIsVMUOFos9cD64ZT7j1yGBMO1dtLW2CPX0jqRGJ1o7/NchNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C5KBTlMo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rYzdZRGQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rQ3/syLW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oVQyoGe+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D6D5E345EC;
	Thu,  4 Sep 2025 10:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756982287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+InWK3Nnj7T4EtajtVLj1+qSvSr8bKWoN+ZdTos14s0=;
	b=C5KBTlMo9rJ1n8ZMCPiYMWZlE6G12nKvVnAiny0FmHNax9WMA0Uf10lScgfox6BGOtTjmC
	dYJyt08raElEl1EJYm8cULL+VpyaHYbn+NJa8Je2hJqQMx2KiXahEa8vR3EV4Ylrg8HoY5
	9ypEG1s/P95ykKe5UUYKfuJCuuVMvOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756982287;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+InWK3Nnj7T4EtajtVLj1+qSvSr8bKWoN+ZdTos14s0=;
	b=rYzdZRGQbIKQyr24VqIlhFkSou7mMxLUyPTQ8+ms6YVhr6+6Eq9tuNUk/o8VVpdPLRgUOl
	CVG7foXi3fJWVRDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="rQ3/syLW";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=oVQyoGe+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756982285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+InWK3Nnj7T4EtajtVLj1+qSvSr8bKWoN+ZdTos14s0=;
	b=rQ3/syLWAem0gPtH3oJsso2xmzHRm3yT68kxNERSnzs0k+m6wv1gQJvppgggMup755lbPh
	WoTi4DVmEaPtft6CQYgebnVt4U9wNkYfUA+yVKkQ2EARIjNEroGgfGQiVT3l0uVC8FuWI0
	hP0Axz2l3VU7OrER+Xro2z48I3QJWVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756982285;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+InWK3Nnj7T4EtajtVLj1+qSvSr8bKWoN+ZdTos14s0=;
	b=oVQyoGe+BAnuazjPADKf84Zrx+1V79lBEojAN3AtclWwX8j0JE49ZgUzTzFgq0IlMcqDmC
	Rrb+PqvlupzrNDDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C96B13675;
	Thu,  4 Sep 2025 10:38:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Vz4jHQ1suWiHMQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 04 Sep 2025 10:38:05 +0000
Date: Thu, 04 Sep 2025 12:38:05 +0200
Message-ID: <878qiutsdu.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: syzbot <syzbot+10b4363fb0f46527f3f3@syzkaller.appspotmail.com>,
	tglx@linutronix.de,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	mingo@redhat.com,
	perex@perex.cz,
	syzkaller-bugs@googlegroups.com,
	tiwai@suse.com,
	x86@kernel.org
Subject: Re: [syzbot] [sound?] possible deadlock in __snd_pcm_lib_xfer (2)
In-Reply-To: <20250904102056.YCByXJXj@linutronix.de>
References: <68b1f3ab.a70a0220.f8cc2.00f0.GAE@google.com>
	<68b2406a.a00a0220.1337b0.001e.GAE@google.com>
	<20250904102056.YCByXJXj@linutronix.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-1.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,suse.de:mid,suse.de:dkim];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[10b4363fb0f46527f3f3];
	DKIM_TRACE(0.00)[suse.de:+];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: D6D5E345EC
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -1.01

On Thu, 04 Sep 2025 12:20:56 +0200,
Sebastian Andrzej Siewior wrote:
> 
> On 2025-08-29 17:06:02 [-0700], syzbot wrote:
> > syzbot has bisected this issue to:
> > 
> > commit d2d6422f8bd17c6bb205133e290625a564194496
> > Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Date:   Fri Sep 6 10:59:04 2024 +0000
> > 
> >     x86: Allow to enable PREEMPT_RT.
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12db5634580000
> > start commit:   07d9df80082b Merge tag 'perf-tools-fixes-for-v6.17-2025-08..
> > git tree:       upstream
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=11db5634580000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16db5634580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
> > dashboard link: https://syzkaller.appspot.com/bug?extid=10b4363fb0f46527f3f3
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10307262580000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17110242580000
> > 
> > Reported-by: syzbot+10b4363fb0f46527f3f3@syzkaller.appspotmail.com
> > Fixes: d2d6422f8bd1 ("x86: Allow to enable PREEMPT_RT.")
> 
> This is unfortunate. There is nothing that sound did wrong, it is rather
> special softirq handling in this case. We don't see this often because
> it requires that a timer is cancelled at the time it is running.
> The assumption made by sound is that spin_lock_irq() also disables
> softirqs. This is not the case on PREEMPT_RT.
> 
> The hunk below avoids the splat. Adding local_bh_disable() to
> spin_lock_irq() would cure it, too. It would also result in random
> synchronisation points across the kernel leading to something less
> usable.
> The imho best solution would to get rid of softirq_ctrl.lock which has
> been proposed
> 	https://lore.kernel.org/all/20250901163811.963326-4-bigeasy@linutronix.de/
> 
> Comments?

Thank you for the detailed analysis!  It enlightened me.

It'd be appreciated if this gets fixed in the softirq core side.
If nothing else flies, we can take your workaround, sure...


Takashi

> 
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -84,19 +84,24 @@ void snd_pcm_group_init(struct snd_pcm_group *group)
>  }
>  
>  /* define group lock helpers */
> -#define DEFINE_PCM_GROUP_LOCK(action, mutex_action) \
> +#define DEFINE_PCM_GROUP_LOCK(action, bh_lock, bh_unlock, mutex_action) \
>  static void snd_pcm_group_ ## action(struct snd_pcm_group *group, bool nonatomic) \
>  { \
> -	if (nonatomic) \
> +	if (nonatomic) { \
>  		mutex_ ## mutex_action(&group->mutex); \
> -	else \
> -		spin_ ## action(&group->lock); \
> +	} else { \
> +		if (IS_ENABLED(CONFIG_PREEMPT_RT) && bh_lock)	\
> +			local_bh_disable();			\
> +		spin_ ## action(&group->lock);			\
> +		if (IS_ENABLED(CONFIG_PREEMPT_RT) && bh_unlock)	\
> +			local_bh_enable();			\
> +	}							\
>  }
>  
> -DEFINE_PCM_GROUP_LOCK(lock, lock);
> -DEFINE_PCM_GROUP_LOCK(unlock, unlock);
> -DEFINE_PCM_GROUP_LOCK(lock_irq, lock);
> -DEFINE_PCM_GROUP_LOCK(unlock_irq, unlock);
> +DEFINE_PCM_GROUP_LOCK(lock, 0, 0, lock);
> +DEFINE_PCM_GROUP_LOCK(unlock, 0, 0, unlock);
> +DEFINE_PCM_GROUP_LOCK(lock_irq, 1, 0, lock);
> +DEFINE_PCM_GROUP_LOCK(unlock_irq, 0, 1, unlock);
>  
>  /**
>   * snd_pcm_stream_lock - Lock the PCM stream
> 
> 
> Sebastian

