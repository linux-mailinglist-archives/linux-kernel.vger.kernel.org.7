Return-Path: <linux-kernel+bounces-771144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AC6B28364
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C3E2B0702D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4246308F21;
	Fri, 15 Aug 2025 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ogEKvDQB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4ZuZc74Z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BfNHCuBj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9Uyat2ol"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E0E2FD7AB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755273354; cv=none; b=iUJIZnwo2BtLPggw25fcyMBeh45X21K6X10BpNExFgDPz0f93Y71l+Zo1HTG8y/nxGdpi0kazFdD+MKZATXv5gOl8bemD3IIJMit1fGHkUoGmlVKaqP6YXBMTzfFX41aQzH5ZH3pHNHjbJ6EOfyD2HQUhu6iOSFz+piA2AE51gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755273354; c=relaxed/simple;
	bh=J5oKgpvRn/94nkWyX7phvTMJoMrn/schi9Jn0SGhV60=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CJXCcHljPX6v51C6w/2KTKk+0h8rLiDi06722lfHePMkC3m6+hxsB0vevrW2gNlx5yZfL3BwPF2sA6R284cV/WAzm9zACQm6k2/GuyzkeHNll5w+rIFtSxwcWCUQzze3HVzB4j0ptymEaz7MQz30lzX8/NnsPd1QPwM6q/I5JHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ogEKvDQB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4ZuZc74Z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BfNHCuBj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9Uyat2ol; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6B8CF1F83C;
	Fri, 15 Aug 2025 15:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755273350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3F1ZroqL4T8UkyyBbggu0UpCRU/HIkPobcHst4awPYc=;
	b=ogEKvDQBN/iqrJ6njBJqEZX1wTrFj2yuSBK+K4fi17ziSDHh9++YRgZSgig918PjwJxHtS
	bW0pfFK+zr2idXcXxwzizX9QtulME048xxfQ7cCjd1qsbztTLsLqGveiXOpYB90URm9amL
	bWQSX9E7qm8YCGourcysY6ZrHuU/WnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755273350;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3F1ZroqL4T8UkyyBbggu0UpCRU/HIkPobcHst4awPYc=;
	b=4ZuZc74ZCCFKqykvo9oe0iTWrehl6IaOahmjFWS5DjvvlLHh2JtctGuXgRnTR+SKKMxWsA
	plfUDC6SJff7hqBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755273349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3F1ZroqL4T8UkyyBbggu0UpCRU/HIkPobcHst4awPYc=;
	b=BfNHCuBjGA/KRTHwvkZ3sZ3qON/+QppEvSciQAM9ejPZFtL+6HD8+kaJoBh9WqnWu3NyJL
	4Hikj1F9JrXNeBQAIvf+lqm/zSqVefZA+9MKunodn2dlHoXfinpuPjhAGLCGNrHiafYktt
	F3lxyGazMJNGSBtRAtMpsNF/S4lTJxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755273349;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3F1ZroqL4T8UkyyBbggu0UpCRU/HIkPobcHst4awPYc=;
	b=9Uyat2olfi00RQBQORXB5AHrsMCLbU0HLcdLzeV0pkikVCQ3/bysjotazoDBlmwCPaJ0Jj
	aSaHqK7n2/ngzKBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C4C213876;
	Fri, 15 Aug 2025 15:55:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eQGsDIVYn2j6HwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 15 Aug 2025 15:55:49 +0000
Date: Fri, 15 Aug 2025 17:55:48 +0200
Message-ID: <87plcwshob.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-2?Q?=A9erif?= Rami <ramiserifpersia@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH v6 0/7] ALSA: usb-audio: Add driver for TASCAM US-144MKII
In-Reply-To: <20250814172222.9448-1-ramiserifpersia@gmail.com>
References: <20250814172222.9448-1-ramiserifpersia@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

On Thu, 14 Aug 2025 19:22:15 +0200,
©erif Rami wrote:
> 
> This is v6 of the patch series to add a new driver
> for the TASCAM US-144MKII USB audio interface.
> 
> Changes in v6:
>   - Addressed open brace cosmetic standards for scoped_guard() calls.
>   - Added lost default values for digital in/out kcontrols.
> 
> Changes in v5:
>   - Addressed u64 remainder in Patch 2/7.
>   - Refactored guard() calls for spinlocks to scoped_guard() for ones
>     that got missed(hopefully all).
> 
> Changes in v4:
>   - Removing leading spaces from #defines as requested.
>   - Renaming fpoInitPattern to fpo_init_pattern.
>   - Removing unnecessary kfree() calls.
>   - Replacing manual lock/unlock patterns with scoped_guard().
> 
> Changes in v3
>   - Corrected v2 invalid patches order
>   The v2 submission included mix of patches for v2 that were unusable.
>   These new patches are valid now.
> 
> Changes in v2:
>   - Patch 1: Dropped blank line, initialized `__free(kfree)` variable to
>      NULL, and fixed `struct tascam_card` indentation.
>   - Patch 2: Corrected indentation in `us144mkii.h`.
>   - Patch 3: Changed `fpoInitPattern` to `fpo_init_pattern` (snake_case),
>      initialized `__free(kfree)` variable, and replaced
>      `guard(spinlock_irqsave)` with `scoped_guard()`.
>   - Patch 5: Updated control names to standard "Playback Source" and
>      "Capture Source" formats, and initialized `__free(kfree)` variable to NULL.
>   - Patch 6: Re-organized code style alignments into previous patches.
>   - Patch 7: Fixed trailing whitespace warning.
> 
> ©erif Rami (7):
>   ALSA: usb-audio: Add initial driver for TASCAM US-144MKII
>   ALSA: usb-audio: us144mkii: Add PCM core infrastructure
>   ALSA: usb-audio: us144mkii: Implement audio playback and feedback
>   ALSA: usb-audio: us144mkii: Implement audio capture and decoding
>   ALSA: usb-audio: us144mkii: Add MIDI support and mixer controls
>   ALSA: usb-audio: us144mkii: Add deep sleep command
>   ALSA: usb-audio: Add infrastructure for TASCAM US-144MKII

Applied to for-next branch now.


thanks,

Takashi

