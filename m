Return-Path: <linux-kernel+bounces-760047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F01EB1E5F7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 313E24E3ED4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4125B2737E4;
	Fri,  8 Aug 2025 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CW9e9eGi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="S0htzyiU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CW9e9eGi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="S0htzyiU"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC34A271461
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754646791; cv=none; b=SFU4ztt+xeNdY5nyOcxgQvz0iqnYNBXYZsqoTylt4rPyb5iJ9k484nPN3AND2YnNtO90oaoXA9LFu7gZONniKehQ6qXw6dhKsF8MZfkXlXHQ6B6n7JyOEKEOmelYhAOHE+9j2THsbE3bRDyWlCl9ks/mCe2GOnp+qoD6gmMIZZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754646791; c=relaxed/simple;
	bh=mRBQhyAKgwd0SyR78LSg9dYwtNTpOoLNvJ2ECVnsbWM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rJdGKM6+RvLHS3DT8vZbaU9EYktEyMXkLd99dwc17PG56s5KvaXRN0lMEaFUs9xtpnKo2l0bTVR8OdXzcWlqPSl2rYirwFscKSRYfggXcqDUEh/jq8HyDEThYtJJ1PKMiqflNCVYOPVXg9w+foOEP5w55kkKtNCyBhG3yiaMLMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CW9e9eGi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=S0htzyiU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CW9e9eGi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=S0htzyiU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 20E5522D9B;
	Fri,  8 Aug 2025 09:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754646788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dwaaYyMDev0NGtjYWn+qdV4V8O7PjKtAlVYBTh0QrVA=;
	b=CW9e9eGirwcjKQklfiuFpy7jH9yFxRbEO9vlkslResmt1JhU4TWswAavFwQgRnsLjw5VOA
	EEdh4QA9VVJ/DYN8I/YDAhWFLS/fowekLKQUCyOHSxXVJRs/vjDE3iUlNknnmJkncSq+NF
	CPYy4vZCpm4u2qKgJaAQobPQyE0pjaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754646788;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dwaaYyMDev0NGtjYWn+qdV4V8O7PjKtAlVYBTh0QrVA=;
	b=S0htzyiUNuFbtBJazZ0ljT0E1uPoeEy/zE0cBGBTMevpYD6C+s9bCpEjLl9mhUcxyoWDLI
	e76gr9d6p7rwY9AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CW9e9eGi;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=S0htzyiU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754646788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dwaaYyMDev0NGtjYWn+qdV4V8O7PjKtAlVYBTh0QrVA=;
	b=CW9e9eGirwcjKQklfiuFpy7jH9yFxRbEO9vlkslResmt1JhU4TWswAavFwQgRnsLjw5VOA
	EEdh4QA9VVJ/DYN8I/YDAhWFLS/fowekLKQUCyOHSxXVJRs/vjDE3iUlNknnmJkncSq+NF
	CPYy4vZCpm4u2qKgJaAQobPQyE0pjaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754646788;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dwaaYyMDev0NGtjYWn+qdV4V8O7PjKtAlVYBTh0QrVA=;
	b=S0htzyiUNuFbtBJazZ0ljT0E1uPoeEy/zE0cBGBTMevpYD6C+s9bCpEjLl9mhUcxyoWDLI
	e76gr9d6p7rwY9AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE4411392A;
	Fri,  8 Aug 2025 09:53:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ddn+MAPJlWhnXAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 08 Aug 2025 09:53:07 +0000
Date: Fri, 08 Aug 2025 11:53:07 +0200
Message-ID: <87jz3eywak.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-2?Q?=A9erif?= Rami <ramiserifpersia@gmail.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Wesley Cheng <quic_wcheng@quicinc.com>
Subject: Re: [RFC PATCH v3] ALSA: usb-audio: Add support for TASCAM US-144MKII
In-Reply-To: <20250803203409.17005-1-ramiserifpersia@gmail.com>
References: <20250803203409.17005-1-ramiserifpersia@gmail.com>
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
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 20E5522D9B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

On Sun, 03 Aug 2025 22:34:09 +0200,
©erif Rami wrote:
> 
> Hi,
> 
> Apologies for the invalid patches and the noise from my earlier attempts.
> I have corrected my workflow and am now submitting this properly.
> 
> This patch introduces a new, dedicated driver for the TASCAM US-144MKII.
> It replaces the partial support that previously existed
> in the `us122l` driver, which now no longer targets this device.
> The new driver implements ALSA compatible duplex and RawMIDI implementation of proprietary MIDI protocol.
> 
> This v3 patch has been tested as follows:
> The code has been checked against the kernel's coding style guidelines.
> It compiles cleanly without any warnings or errors.
> I have performed a full kernel build against the latest master branch, installed it, and successfully verified that the module loads and functions correctly with the hardware.
> 
> Any feedback is greatly appreciated.

Thanks for the patch.  The code looks almost good and you can submit
as a proper patch at the next submission.
A few points from my side:

- The sysfs file should be dropped as Greg suggested

- Try to use guard() for spinlocks.  (I know other USB audio drivers
  don't do that yet, but I already have a bit patch set to convert
  those.)

  Of course, there are cases where guard() and scoped_guard() don't
  fit well (e.g. the loop with temporary unlock/re-locking), but in
  most cases, you can use it well.  If it doesn't fit, it's a good
  chance to take a look at your code again and reconsider whether the
  code flow can be changed better.

- Similarly, try to use __free(kfree) for temporary buffers.

- snd_pcm_lib_preallocate_*() can be replaced with
  snd_pcm_set_managed_buffer().  Then you can drop
  snd_pcm_lib_malloc_pages() and snd_pcm_lib_free_pages() calls from
  hw_params and hw_free callbacks, too.

- Most of enum info callbacks can be simplified with
  snd_ctl_enum_info() helper function.

- It's a bit big code and it'd be great if you can split the patches
  in a logical manner.  But it'd be OK-ish to have a single patch if
  it's not easy, too.


thanks,

Takashi

