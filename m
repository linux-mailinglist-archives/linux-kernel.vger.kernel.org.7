Return-Path: <linux-kernel+bounces-818498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A702AB5928B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B29B17ACD95
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7372E2BDC3E;
	Tue, 16 Sep 2025 09:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xxKerzyV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jDDO6q0d";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xxKerzyV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jDDO6q0d"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EF7275B1F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758015838; cv=none; b=IvQSnmuPSzXW02iJyaAA7eEwo/McDVhWLbmxUkBG2QpeahFsB/k0EhGbi8Ty9bkuM00Gq4mtuJmtms1+dgXTPugPZJRiXvkXwvdfQm7aLh8tqhV7CF3taF3DTg8QQWtKTyMAEmqguyQkgrDFXHJ//L0Xkveb5U4DwN+Bi0ykCkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758015838; c=relaxed/simple;
	bh=nOgOFMG6kWXVErahfNRvVKak1X2upwwwsaHyTW6VnS0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aY86KTkhj3/kRzsYCHUjt8P5HOgljZ1oj6pc7nvFOEKepBEm7GqVRy8wjpkfDNghb+0GtM+qhVPY70MPNnjf5lznem7ng4jzR+iu2AX1x+c/eD2WI2w3T5AFih3TafIUn3to8IrFcQYHM2H0oy3VtLoHlF0GNv4pPEKQK5+sXOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xxKerzyV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jDDO6q0d; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xxKerzyV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jDDO6q0d; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5DC37229B3;
	Tue, 16 Sep 2025 09:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758015834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=akaOTVYyh0Ddu+DqEPCPNFxtJ0eKfxf6fZjwTCOr3us=;
	b=xxKerzyVED7Xj44k+L9bt2937svcRLVAZHKZkEq6FumDwS/B0/iTy2f30qZi9TJ1+bSUJH
	gBWFtgh2DHMc6Q9srwySWw8bDIIljLKSWfzvavCVNiVphT13LrAhBHe55g857nii/fIcML
	jZ1jE444QCY0tS58DkLq1YpMAUoR3B8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758015834;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=akaOTVYyh0Ddu+DqEPCPNFxtJ0eKfxf6fZjwTCOr3us=;
	b=jDDO6q0dJgeffFyGhVfhtrvohxm2Pp6NxE+DCIovsnfp6a4xZwqV9K/eyXWPbBvpoJdd5v
	3Jdvz2c7fH43HZCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758015834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=akaOTVYyh0Ddu+DqEPCPNFxtJ0eKfxf6fZjwTCOr3us=;
	b=xxKerzyVED7Xj44k+L9bt2937svcRLVAZHKZkEq6FumDwS/B0/iTy2f30qZi9TJ1+bSUJH
	gBWFtgh2DHMc6Q9srwySWw8bDIIljLKSWfzvavCVNiVphT13LrAhBHe55g857nii/fIcML
	jZ1jE444QCY0tS58DkLq1YpMAUoR3B8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758015834;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=akaOTVYyh0Ddu+DqEPCPNFxtJ0eKfxf6fZjwTCOr3us=;
	b=jDDO6q0dJgeffFyGhVfhtrvohxm2Pp6NxE+DCIovsnfp6a4xZwqV9K/eyXWPbBvpoJdd5v
	3Jdvz2c7fH43HZCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F01D2139CB;
	Tue, 16 Sep 2025 09:43:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id blErOVkxyWjyPQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 16 Sep 2025 09:43:53 +0000
Date: Tue, 16 Sep 2025 11:43:53 +0200
Message-ID: <87v7li20me.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Takashi Iwai <tiwai@suse.de>,
	syzbot <syzbot+10b4363fb0f46527f3f3@syzkaller.appspotmail.com>,
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
Subject: Re: [PATCH] ALSA: pcm: Disable bottom softirqs as part of spin_lock_irq() on PREEMPT_RT
In-Reply-To: <20250915152851.-ATGMKhp@linutronix.de>
References: <68b1f3ab.a70a0220.f8cc2.00f0.GAE@google.com>
	<68b2406a.a00a0220.1337b0.001e.GAE@google.com>
	<20250904102056.YCByXJXj@linutronix.de>
	<878qiutsdu.wl-tiwai@suse.de>
	<20250915152851.-ATGMKhp@linutronix.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[10b4363fb0f46527f3f3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -1.80

On Mon, 15 Sep 2025 17:28:51 +0200,
Sebastian Andrzej Siewior wrote:
> 
> snd_pcm_group_lock_irq() acquires a spinlock_t and disables interrupts
> via spin_lock_irq(). This also implicitly disables the handling of
> softirqs such as TIMER_SOFTIRQ.
> On PREEMPT_RT softirqs are preemptible and spin_lock_irq() does not
> disable them. That means a timer can be invoked during spin_lock_irq()
> on the same CPU. Due to synchronisations reasons local_bh_disable() has
> a per-CPU lock named softirq_ctrl.lock which synchronizes individual
> softirq against each other.
> syz-bot managed to trigger a lockdep report where softirq_ctrl.lock is
> acquired in hrtimer_cancel() in addition to hrtimer_run_softirq(). This
> is a possible deadlock.
> 
> The softirq_ctrl.lock can not be made part of spin_lock_irq() as this
> would lead to too much synchronisation against individual threads on the
> system. To avoid the possible deadlock, softirqs must be manually
> disabled before the lock is acquired.
> 
> Disable softirqs before the lock is acquired on PREEMPT_RT.
> 
> Reported-by: syzbot+10b4363fb0f46527f3f3@syzkaller.appspotmail.com
> Fixes: d2d6422f8bd1 ("x86: Allow to enable PREEMPT_RT.")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> 
> I don't see a way around this given the report. I don't see how to
> address this within the softirq. Taking this lock as part of every
> spin_lock_irq() would be a mess and while testing I didn't even manage
> to boot the machine. So I probably missed a detail (but then I would
> only know how mad it really is).
> 
> This can be an intermediate solution until
> 	https://lore.kernel.org/all/20250901163811.963326-4-bigeasy@linutronix.de/
> 
> gets merged and the !PREEMPT_RT_NEEDS_BH_LOCK case the default (i.e. not
> a config option anymore).

I applied now to for-next branch for 6.18.
It's already at a late stage for 6.17 release, and the issue doesn't
seem like an urgent regression to be fixed.


Thanks!

Takashi

