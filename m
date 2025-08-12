Return-Path: <linux-kernel+bounces-764158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 441A6B21EAF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 264957B3238
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921DC2D4809;
	Tue, 12 Aug 2025 07:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DOQ1CWDK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rY4n/pUr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DOQ1CWDK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rY4n/pUr"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8555028A72F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754982115; cv=none; b=HHyFyz54ocioXmWekangjvudHAHhLI7/VdLK0PjgNloucjv7pwjqqxWgsoEOkxnqa4KgAiOL11fE34nq5VGyEmN/BjHAH0LRQIN6WXFV9Nwta2Mnwsm/yKQuTaSVG9FtYqRqbYC471U582wtJmDAh5sRZ62K43qhUas6Bvi5P7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754982115; c=relaxed/simple;
	bh=fxk7ZvCgGJ7FcvGq11Qw8ox2RenPJmtB3BA5xDquLK0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bnCwYCabFBY9CEUn8sD5D5abqTu3TrwhgZGQVdgaP9M2pUqCRmk/a0DwkOzCH+bHdVX7QlX9Mj8RzlMYYLIu3IyjWvuJzf1/LXH4v3AigXaJY41Sf4RJuIWHUehtxUpWly751tUKd9KJVkNaISJC8TZdvJFnlpFOtAkNmJs3jf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DOQ1CWDK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rY4n/pUr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DOQ1CWDK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rY4n/pUr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BA9E521C14;
	Tue, 12 Aug 2025 07:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754982110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mIuXacPJunB51SFFMyrVjrYJBnMzGcvIHqSEYD8obz4=;
	b=DOQ1CWDK/UZxuvk2IQ/IbawVHkKa6q6prAhCuFhlYyLd+muT6Dj+CkLDSwHDo+fZV6VZjx
	9ZLGbRz8n3Phjx8zPPRDOfFZy3VVcAmMTTvW+mpDv9lR3rWzDYa0hGi24s9C8xoC540zqW
	5tMBDDjGLyJnGjmJkFN/Oe9L0W0yZlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754982110;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mIuXacPJunB51SFFMyrVjrYJBnMzGcvIHqSEYD8obz4=;
	b=rY4n/pUr7I1snaOsEaA3aXHAsiBh/kBihj9c81v5sm32KlXkJx5RwU+p97EjEcRXCq2g1H
	t4t9c9tZn119ZEBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754982110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mIuXacPJunB51SFFMyrVjrYJBnMzGcvIHqSEYD8obz4=;
	b=DOQ1CWDK/UZxuvk2IQ/IbawVHkKa6q6prAhCuFhlYyLd+muT6Dj+CkLDSwHDo+fZV6VZjx
	9ZLGbRz8n3Phjx8zPPRDOfFZy3VVcAmMTTvW+mpDv9lR3rWzDYa0hGi24s9C8xoC540zqW
	5tMBDDjGLyJnGjmJkFN/Oe9L0W0yZlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754982110;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mIuXacPJunB51SFFMyrVjrYJBnMzGcvIHqSEYD8obz4=;
	b=rY4n/pUr7I1snaOsEaA3aXHAsiBh/kBihj9c81v5sm32KlXkJx5RwU+p97EjEcRXCq2g1H
	t4t9c9tZn119ZEBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EF7E1351A;
	Tue, 12 Aug 2025 07:01:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HdqrId7mmmhdTwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 12 Aug 2025 07:01:50 +0000
Date: Tue, 12 Aug 2025 09:01:50 +0200
Message-ID: <87o6slyqe9.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-2?Q?=A9erif?= Rami <ramiserifpersia@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] ALSA: usb-audio: Add driver for TASCAM US-144MKII
In-Reply-To: <20250810124958.25309-1-ramiserifpersia@gmail.com>
References: <20250810124958.25309-1-ramiserifpersia@gmail.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

On Sun, 10 Aug 2025 14:49:51 +0200,
©erif Rami wrote:
> 
> This patch series introduces a new driver for the TASCAM US-144MKII USB audio interface.
> This device is an entry-level audio interface, and adding
> support will benefit users who want to use and fully utilize it under the linux kernel.
> 
> The series is structured as follows:
> - Patch 1: Add initial driver for TASCAM US-144MKII.
> - Patch 2: Adds the core PCM infrastructure.
> - Patch 3: Implements audio playback functionality.
> - Patch 4: Implements audio capture functionality.
> - Patch 5: Adds MIDI support and mixer controls.
> - Patch 6: Adds deep sleep and code style alignments
> - Patch 7: Integrates the driver into the ALSA USB audio subsystem.
> 
> The driver has been tested on a TASCAM US-144MKII device,
> verifying playback, recording, and MIDI functionality.
> 
> This driver was written for the TASCAM US-144MKII.
> However, it is possible that it may also work for the original TASCAM US-144.
> 
> ©erif Rami (7):
>   ALSA: usb-audio: Add initial driver for TASCAM US-144MKII
>   ALSA: usb-audio: us144mkii: Add PCM core infrastructure
>   ALSA: usb-audio: us144mkii: Implement audio playback and feedback
>   ALSA: usb-audio: us144mkii: Implement audio capture and decoding
>   ALSA: usb-audio: us144mkii: Add MIDI support and mixer controls
>   ALSA: usb-audio: us144mkii: Add deep sleep and code style alignments
>   ALSA: usb-audio: Add infrastructure for TASCAM US-144MKII

Thanks for splitting, now it's much easier to review.
I commented on each patch.


Takashi

