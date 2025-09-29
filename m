Return-Path: <linux-kernel+bounces-836473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E78DBA9C7F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4758B1707D4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC051E6DC5;
	Mon, 29 Sep 2025 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Gag0Ve2u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YHsf/9PX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WNULkeGz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0rsYj6ON"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D531EF09D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759159265; cv=none; b=hCijxJIQ2yDtiNsaT6oOsB9MDanQnQYFVzOuN/2qoAY912RELpig8eXgxFWX163ATZju4w4fLgJb6G2XllIktBkO4G5LWXWC4nKjziktKnXq63T5uVcNsYo8JxNm1mWZDQHiT/mFRylIrvIQNDetLUCTuGx7fieFPrNXTitIenE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759159265; c=relaxed/simple;
	bh=3v2TfQCJs4o8QZ4YGTpw90iCi6ifi5act371SIi5GZo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iDR7nahSxw7pFm0GdbcVJZsLaKhhBLoctXPsUd4xdijFBgqZHUehg4Ux4VzsAiRahNgyWCG+rxYG6qwOG05UWEJttBxHwsQIZALzrdp9KP47/XzeNkVXuUPHCgtfXqlxJQSQKWj6YWgPTUS72QJQZKOr0nDJUAeyjOLq2zB8D1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Gag0Ve2u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YHsf/9PX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WNULkeGz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0rsYj6ON; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E88E420C45;
	Mon, 29 Sep 2025 15:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759159260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bkFOkUQfgJ3u/LgPG0CsD5LhVnnA9iYZ7lpjnBre5Z4=;
	b=Gag0Ve2uKGXAcEmv0TyeilNtipaNFyAtB0zCFPUcAyV/j/8jHZVZRWC8pks5SFX9rFkSkY
	yP9UppphiSL0Qks10G6/GkBUebUZd32hgOinECnalDLnT0441GoVPjY0tD5zuUTzb3YBfY
	lWsJhwy0z97gDfAwDZdUkFXw6jKPTgk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759159260;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bkFOkUQfgJ3u/LgPG0CsD5LhVnnA9iYZ7lpjnBre5Z4=;
	b=YHsf/9PXV2ftfXJiCTevlHIjNWiysYfpEFKYS5IBSCF+BEURPwKYIMJQNNmD9jxeSmcP7f
	48IUjRh2tDS6J3DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WNULkeGz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0rsYj6ON
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759159259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bkFOkUQfgJ3u/LgPG0CsD5LhVnnA9iYZ7lpjnBre5Z4=;
	b=WNULkeGzTnhSFqTLzvjWlKn5ZlmChhTG878rlmngUHQWBdgChaA9mEqt5OsvX2NS46R36R
	bitYBmjS3QcYwafrTRWO2aX//0W/sW93sNpwLstFtAz0/vZ9jcrNZkisdvv5JxOWfokCTo
	9tY6xBKNqCPJ1o2NbLRu+VSiCyf1BvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759159259;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bkFOkUQfgJ3u/LgPG0CsD5LhVnnA9iYZ7lpjnBre5Z4=;
	b=0rsYj6ONHkqFXdcWP4spX2QPuqbBk1nDTwtjVewv86uZfP5g3ZDZrR26U7s+1ZYpcNcaJV
	5eH/WjwWUr2u4CAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD8B213782;
	Mon, 29 Sep 2025 15:20:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id i/L8KNuj2mhsQgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 29 Sep 2025 15:20:59 +0000
Date: Mon, 29 Sep 2025 17:20:59 +0200
Message-ID: <87bjmtmgis.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Sidharth Seela <sidharthseela@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	zhujun2@cmss.chinamobile.com,
	kuninori.morimoto.gx@renesas.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC]sound:usb:mixer.c: Solving 'Generic AB13X USB Audio' Unlikely volume range.
In-Reply-To: <20250929133752.31847-1-sidharthseela@gmail.com>
References: <20250929133752.31847-1-sidharthseela@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: E88E420C45
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

On Mon, 29 Sep 2025 15:37:52 +0200,
Sidharth Seela wrote:
> 
> Dear Maintainers,
> I am using a generic "boat" make earphones, which are too loud across
> different systems with eg: iOS, macOS, Debian Linux. And hence I believe
> the issue is not with a driver but the headphones.
> 
> After connecting this device to laptop I get the following in dmesg logs:
> 	usb 1-5: New USB device found, idVendor=001f, idProduct=0b21, bcdDevice= 1.00
> 	usb 1-5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> 	usb 1-5: Product: AB13X USB Audio
> 	usb 1-5: Manufacturer: Generic
> 	usb 1-5: SerialNumber: 20210726905926
> 	usb 1-5: Warning! Unlikely big volume range (=11520), cval->res is probably wrong.
> 	usb 1-5: [2] FU [PCM Playback Volume] ch = 2, val = -11520/0/1
> 	usb 1-5: Warning! Unlikely big volume range (=8191), cval->res is probably wrong.
> 	usb 1-5: [5] FU [Mic Capture Volume] ch = 1, val = 0/8191/1
> 
> By using pavucontrol, I am able to get fair sound, after reducing 17dB in
> Analog Stereo Output and reducing 6dB in Digital Stereo Output.
> 
> I believe this issue could be solved by adding a quirk patch to
> sound/usb/mixer.c:1096 (/* volume control quriks */).

An oft-seen firmware bug is that it provides the wrong mixer range
that confuses the driver.  USB audio firmware should provide the above
volume range in 1/256 dB level.

Try to figure out the volume level and you'd need to hard-code the
actual volume range there for your device.


Takashi

