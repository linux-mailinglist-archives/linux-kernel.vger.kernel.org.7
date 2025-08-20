Return-Path: <linux-kernel+bounces-776959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0130B2D37D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9F6217F2C2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 05:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFED829B228;
	Wed, 20 Aug 2025 05:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="seQA/Owk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C3meaJvE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LI9eejD7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k9Q0681n"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6437D1EB5FE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755668007; cv=none; b=SQNn2UXBaIG6DBnUWM6I0BU9aasyN/fw3EmCWfkrVAW/p+NMz5KgZiLrs059W7CuJpNyT8lmJS04d0vS6DmMU6XmFkIi786yfi+BUCmTEEf/s6acs6c53Akec1na5QjroLGPi8vNbuZEYXfN5GkL26eJjY/96Q8srDEXETpr+NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755668007; c=relaxed/simple;
	bh=SU6Y5KT2p9HGDdKOWBXFhBuctKiSPENI8bwlRvYH+ew=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fTpTZe6zvN9dGgbNCM9o9rW+DG+Rowi7lE+ZUhO6o9FvjJ2AjQAtytvNxBwEnm/BMXGp7NgYJCRgP81zwQJS4QQ6vlaEojLNJmxkFX2ZG+uoskhjSg09rot5vDuqBY37yrB2Q9wbohaAPzo1q1og6UuCML9xNMFRmxbdcEqmPkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=seQA/Owk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=C3meaJvE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LI9eejD7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=k9Q0681n; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 788BE2121D;
	Wed, 20 Aug 2025 05:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755668003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=on36+hu45j9cFXKrBGVlTwBSePKEvV/BGbUwTqOQ0Zs=;
	b=seQA/OwkPM43005W2KCdQwOy7c9YrhNJTTbIj4LB0cbLVvyrNM3Rzl17SL1qLWrWEwyEC+
	wr0Fw8hGLqpRlm7b2S8f8hQyiA2TSBbEvkBV6Lp0htENwmcjnYwXbi8KXNjK84ok3tfyFC
	Tzqw7cdHJJzUOHamNQ7xtG8oBS5qG0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755668003;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=on36+hu45j9cFXKrBGVlTwBSePKEvV/BGbUwTqOQ0Zs=;
	b=C3meaJvEA/moAT2aXZHKueo/srDy8EtdvEyTcT0aGCM7TGoHn0aS28kOPMHXa3HZ+pxSSy
	sgKuvmGjFvrFY6CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755668002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=on36+hu45j9cFXKrBGVlTwBSePKEvV/BGbUwTqOQ0Zs=;
	b=LI9eejD7toy/DNNT9FhXdDs+h/Ix7y8eADWbIfWN5KM+3L+2VsXWDMnNCwaoaT7INLTy0G
	7lFZPINtJfyk8Pt612FMC2ib6bUeQiknfqM/kAv2fysP73JQ0qhT1p9wLfG+wCyO8P8BE6
	f0GX/Ov3NBU9+izXJz2owQq/Uj85SnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755668002;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=on36+hu45j9cFXKrBGVlTwBSePKEvV/BGbUwTqOQ0Zs=;
	b=k9Q0681nVPuqCM9pNztCJa/Se/9f9tn8kAR0bdLDU4U4TJZtZnMoyX5EuTcHVrh4lZKcsQ
	FdJpZ2mkDK2A3xBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39C9F1378C;
	Wed, 20 Aug 2025 05:33:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8qU9DCJepWi5NgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 20 Aug 2025 05:33:22 +0000
Date: Wed, 20 Aug 2025 07:33:21 +0200
Message-ID: <87frdm8sm6.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-2?Q?=A9erif?= Rami <ramiserifpersia@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	lkp@intel.com
Subject: Re: [PATCH v2] ALSA: usb-audio: us144mkii: Fix null-deref in tascam_midi_in_urb_complete()
In-Reply-To: <20250819185133.10464-1-ramiserifpersia@gmail.com>
References: <20250819185133.10464-1-ramiserifpersia@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Tue, 19 Aug 2025 20:51:33 +0200,
©erif Rami wrote:
> 
> Changes in v2:
>  - Removed duplicate call to usb_put_urb() on submission failure.
>  - Removed extra blank line after the function.
>  
> The smatch tool reported a potential null pointer dereference in
> tascam_midi_in_urb_complete(). The 'tascam' variable, derived from
> 'urb->context', was checked for nullity in one place, but dereferenced
> without a check in several other places.
> 
> This patch fixes the issue by adding a null check at the beginning of
> the function. If 'tascam' is null, the function now safely exits.
> This prevents any potential crashes from null pointer dereferences.
> 
> It also fixes a latent bug where 'usb_put_urb()' could
> be called twice for the same URB on submission failure, which would
> lead to a use-after-free error.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202508192109.lcMrINK1-lkp@intel.com/
> Signed-off-by: ©erif Rami <ramiserifpersia@gmail.com>

Applied now.  Thanks.


Takashi

