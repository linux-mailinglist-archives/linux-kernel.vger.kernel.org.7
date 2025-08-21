Return-Path: <linux-kernel+bounces-779108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB411B2EF2B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E69F1C2283F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22A32C11E0;
	Thu, 21 Aug 2025 07:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qzQVGyZt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CKZi9mUi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qzQVGyZt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CKZi9mUi"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679F1279DC0
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755760423; cv=none; b=F7xwF/5LnhVnH9+HWhp7FrCvCv9d8vUloOHyjuggUAN6h2BkLTANuvOtKp3CjENFQfV7gDetxPReBjRJ2sVqkmK/wbRrmPyzaILRWsigmF55RFY+WZkYP4QURrnuLWu5hrVwhLvkesqUkye3CrybS9VDIEa2XxG5Cc9HJnI7th0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755760423; c=relaxed/simple;
	bh=6Ho901v7Yuv0giLjJQ9df2Slo/KdObDQP9ZDyeA78v4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CIPUthR0l8HM3pIFnznNSORIY8iog0IG+wnUdprgqsLOJf+g/tea3Ox7a4dlq0ZLr7sLAr2k94v652U64r36PC6EvO6V2jJZPko14jd2wNmoszoTgZJCmd90iSnl+su9eyRbDWQZJnewVw4ArMqVr78ucdrMIHyHB4yVioPXBzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qzQVGyZt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CKZi9mUi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qzQVGyZt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CKZi9mUi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1ED211F7C7;
	Thu, 21 Aug 2025 07:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755760414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AhNWJQZWsc7PSXphoLrI7blVNvFaUxzl3Hv0jDX/Gak=;
	b=qzQVGyZtK1fRyOAeLsQ2VS4ibk2BOapybh9EvUI8LdCnVrGMzFyzoEhXMrowX76wktEWLB
	8c9Z791bgCWLPJfur5+TSKUftplom306oKrotbsuWbNgR3Kccs8Ppz7TX+pMarGyb7dhXy
	kOhMFBJjY7K0p6f2KjMpRJo9mDrZoaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755760414;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AhNWJQZWsc7PSXphoLrI7blVNvFaUxzl3Hv0jDX/Gak=;
	b=CKZi9mUi/oOxuYX3a76H4g6X4v92EMfeWNmhUwqOwgjw6pDB+LamMoMU6rQgY0CQInIno0
	J5vXy2fX4oo4IkBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755760414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AhNWJQZWsc7PSXphoLrI7blVNvFaUxzl3Hv0jDX/Gak=;
	b=qzQVGyZtK1fRyOAeLsQ2VS4ibk2BOapybh9EvUI8LdCnVrGMzFyzoEhXMrowX76wktEWLB
	8c9Z791bgCWLPJfur5+TSKUftplom306oKrotbsuWbNgR3Kccs8Ppz7TX+pMarGyb7dhXy
	kOhMFBJjY7K0p6f2KjMpRJo9mDrZoaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755760414;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AhNWJQZWsc7PSXphoLrI7blVNvFaUxzl3Hv0jDX/Gak=;
	b=CKZi9mUi/oOxuYX3a76H4g6X4v92EMfeWNmhUwqOwgjw6pDB+LamMoMU6rQgY0CQInIno0
	J5vXy2fX4oo4IkBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3DFF13867;
	Thu, 21 Aug 2025 07:13:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D/xWNh3HpmjGfgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 21 Aug 2025 07:13:33 +0000
Date: Thu, 21 Aug 2025 09:13:33 +0200
Message-ID: <87ect56tb6.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Dewei Meng <mengdewei@cqsoftware.com.cn>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ivan.orlov0322@gmail.com
Subject: Re: [PATCH] ALSA: timer: fix ida_free call while not allocated
In-Reply-To: <20250821014317.40786-1-mengdewei@cqsoftware.com.cn>
References: <20250821014317.40786-1-mengdewei@cqsoftware.com.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,vger.kernel.org,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -1.80

On Thu, 21 Aug 2025 03:43:17 +0200,
Dewei Meng wrote:
> 
> In the snd_utimer_create() function, if the kasprintf() function return
> NULL, snd_utimer_put_id() will be called, finally use ida_free()
> to free the unallocated id 0.
> 
> the syzkaller reported the following information:
>   ------------[ cut here ]------------
>   ida_free called for id=0 which is not allocated.
>   WARNING: CPU: 1 PID: 1286 at lib/idr.c:592 ida_free+0x1fd/0x2f0 lib/idr.c:592
>   Modules linked in:
>   CPU: 1 UID: 0 PID: 1286 Comm: syz-executor164 Not tainted 6.15.8 #3 PREEMPT(lazy)
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-4.fc42 04/01/2014
>   RIP: 0010:ida_free+0x1fd/0x2f0 lib/idr.c:592
>   Code: f8 fc 41 83 fc 3e 76 69 e8 70 b2 f8 (...)
>   RSP: 0018:ffffc900007f79c8 EFLAGS: 00010282
>   RAX: 0000000000000000 RBX: 1ffff920000fef3b RCX: ffffffff872176a5
>   RDX: ffff88800369d200 RSI: 0000000000000000 RDI: ffff88800369d200
>   RBP: 0000000000000000 R08: ffffffff87ba60a5 R09: 0000000000000000
>   R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
>   R13: 0000000000000002 R14: 0000000000000000 R15: 0000000000000000
>   FS:  00007f6f1abc1740(0000) GS:ffff8880d76a0000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 00007f6f1ad7a784 CR3: 000000007a6e2000 CR4: 00000000000006f0
>   Call Trace:
>    <TASK>
>    snd_utimer_put_id sound/core/timer.c:2043 [inline] [snd_timer]
>    snd_utimer_create+0x59b/0x6a0 sound/core/timer.c:2184 [snd_timer]
>    snd_utimer_ioctl_create sound/core/timer.c:2202 [inline] [snd_timer]
>    __snd_timer_user_ioctl.isra.0+0x724/0x1340 sound/core/timer.c:2287 [snd_timer]
>    snd_timer_user_ioctl+0x75/0xc0 sound/core/timer.c:2298 [snd_timer]
>    vfs_ioctl fs/ioctl.c:51 [inline]
>    __do_sys_ioctl fs/ioctl.c:907 [inline]
>    __se_sys_ioctl fs/ioctl.c:893 [inline]
>    __x64_sys_ioctl+0x198/0x200 fs/ioctl.c:893
>    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>    do_syscall_64+0x7b/0x160 arch/x86/entry/syscall_64.c:94
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   [...]
> 
> The utimer->id should be set properly before the kasprintf() function,
> ensures the snd_utimer_put_id() function will free the allocated id.
> 
> Fixes: 37745918e0e75 ("ALSA: timer: Introduce virtual userspace-driven timers")
> Signed-off-by: Dewei Meng <mengdewei@cqsoftware.com.cn>

Applied now.  Thanks.


Takashi

