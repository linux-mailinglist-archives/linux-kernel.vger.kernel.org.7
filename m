Return-Path: <linux-kernel+bounces-769235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EE6B26BA6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6441CC0ECE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A1D23ABBD;
	Thu, 14 Aug 2025 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r6BoSd/i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4YM5/nyA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r6BoSd/i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4YM5/nyA"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD28233710
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186767; cv=none; b=WuOtS7+8TB1xyWEbxAiyYBmGstMpvPEAKq/GjXtl95WPUMnAEyr9QXP5z4QoV5tCEMunPTuHfqjw8vrG3XYJu5Ys21NKbg4dyb++2oTncdvwpQU2yuKlQZJ55xpgQVK9Dd1j9fvfYuA95tdf12oQM7yivaHdbJ606YRW/fJbtp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186767; c=relaxed/simple;
	bh=D9BAZfQfj/8Jj60PMYz/nteWrL2oqulBSi8nBIaDW7A=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PGQRuAeRxp3DclpwEu+ykVuxYiAhaoDZCwiKvdulUgw4jvXLCEj8zaaoWljnPQdsAQG7w/gv3kgMOJP+swtMUDduiGWtFO1d64IPhqpGcuMG+EWluw3Lfzblpm4ZLv6Xzrb+hB/iGBjkh0XE/cCyv11SO7rvUmchkIW4KuQv2WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r6BoSd/i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4YM5/nyA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r6BoSd/i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4YM5/nyA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0BFC61F7FB;
	Thu, 14 Aug 2025 15:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755186764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=386kt3Hv+qklrs1UI8sDZv0BUHbg3ttPVLVgmp76u+M=;
	b=r6BoSd/iOtYQDwyMe/LjmZE7td52Oxi6XHu/4nmbwt5QV8DBuP4X6jTqljfwB7J95Uegt+
	le0npKEQ/8giWEvkEvTq0G4PN6UAF/ihm6aXeGtA6Xn1Czlzlo6/YJMDm1vorss0y74If9
	f2KuHIPwine5PA0JSrA+cGLt/vnQbW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755186764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=386kt3Hv+qklrs1UI8sDZv0BUHbg3ttPVLVgmp76u+M=;
	b=4YM5/nyAeLVu4lo+o5aYOe2Ha8fQU+sxSWfFPwpieAp1xDH+AtaKWR5DEWLxbu28NZii+t
	FOd/fX/vUdZRO8Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="r6BoSd/i";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="4YM5/nyA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755186764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=386kt3Hv+qklrs1UI8sDZv0BUHbg3ttPVLVgmp76u+M=;
	b=r6BoSd/iOtYQDwyMe/LjmZE7td52Oxi6XHu/4nmbwt5QV8DBuP4X6jTqljfwB7J95Uegt+
	le0npKEQ/8giWEvkEvTq0G4PN6UAF/ihm6aXeGtA6Xn1Czlzlo6/YJMDm1vorss0y74If9
	f2KuHIPwine5PA0JSrA+cGLt/vnQbW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755186764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=386kt3Hv+qklrs1UI8sDZv0BUHbg3ttPVLVgmp76u+M=;
	b=4YM5/nyAeLVu4lo+o5aYOe2Ha8fQU+sxSWfFPwpieAp1xDH+AtaKWR5DEWLxbu28NZii+t
	FOd/fX/vUdZRO8Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D050D136AE;
	Thu, 14 Aug 2025 15:52:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EUfSMEsGnmgqFgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 14 Aug 2025 15:52:43 +0000
Date: Thu, 14 Aug 2025 17:52:43 +0200
Message-ID: <87qzxduchg.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-2?Q?=A9erif?= Rami <ramiserifpersia@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH v5 0/7] ALSA: usb-audio: Add driver for TASCAM US-144MKII
In-Reply-To: <20250814102534.34439-1-ramiserifpersia@gmail.com>
References: <20250814102534.34439-1-ramiserifpersia@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 0BFC61F7FB
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

On Thu, 14 Aug 2025 12:25:27 +0200,
©erif Rami wrote:
> 
> This is v5 of the patch series to add a new driver
> for the TASCAM US-144MKII USB audio interface.
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

Just cosmetic: the open brace of scoped_guard() should be in the same
line of scoped_guard() itself, i.e.

	scoped_guard(...) {
		...
	}

You seem to have put it in the next line, but better to align with the
standard.


thanks,

Takashi

