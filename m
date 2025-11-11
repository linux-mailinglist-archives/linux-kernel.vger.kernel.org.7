Return-Path: <linux-kernel+bounces-895733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8FBC4EC88
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 02D9334CC72
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14A03659E9;
	Tue, 11 Nov 2025 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iRm1X3KL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hDd2+SIj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iRm1X3KL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hDd2+SIj"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB09359FB8
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762874964; cv=none; b=tiBHV6mphM7g5BXemSfcDaQIKBd5MqBZlGv+1YBibyzyXB1+EIrai7w6CZ9rpJ4kwagesJ5jAnfEnEHFiQkNsnSwyA+N8dJvb8FOL+ZQJ/gCpwy051U6nia9DJyxfezcUY5EVnApjP44Q4vXnZ6oQ7V7gP3Di9dXD+IEA+IH5pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762874964; c=relaxed/simple;
	bh=RBEqT8TLv2nUSl8rhSU8ach4I5d5MlMLDf5lwXnpAuk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TqD64/CIUGidp/NK/DX5biWR280jMPtn4A3IO2Uy5x9ji65UAAInW1GVmSGfCellXF+NajdYusZyOFniDA10foWu688sG08vgy4WvR4Bms7vJ+ArICFoJu82FzkCpyU3t22sBx2IFYPVfKmQZuHqtzXZqwPbqmLII/0U6LtOR9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iRm1X3KL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hDd2+SIj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iRm1X3KL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hDd2+SIj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 72D132191C;
	Tue, 11 Nov 2025 15:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762874960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2tVplv7/CD6HPjxvcjJ2gXjYAgQwqNemyVrBgR5GIp0=;
	b=iRm1X3KLVbMuqIEuQRyUiLZp8N+vuwQREuZC/h++GivivuH7lth6AQB5fMNoMr4cbxk2cC
	Xg9YuSOEFYuT3EkMwDyM62S7edSMTDYVr5FbKbsxL4Q7er4ClgPt+VjAayguLgoyrEsjUu
	QQ8+LNq3D6Schr4QyBmfEwFPGIx7TBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762874960;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2tVplv7/CD6HPjxvcjJ2gXjYAgQwqNemyVrBgR5GIp0=;
	b=hDd2+SIj1Dz7TBkji7GolO0dEI8xttLFKmDuVW7EWKe8gJNqMj87caEYcorP97vc+FhReN
	iSz1esIfln2L3ZDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iRm1X3KL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hDd2+SIj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762874960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2tVplv7/CD6HPjxvcjJ2gXjYAgQwqNemyVrBgR5GIp0=;
	b=iRm1X3KLVbMuqIEuQRyUiLZp8N+vuwQREuZC/h++GivivuH7lth6AQB5fMNoMr4cbxk2cC
	Xg9YuSOEFYuT3EkMwDyM62S7edSMTDYVr5FbKbsxL4Q7er4ClgPt+VjAayguLgoyrEsjUu
	QQ8+LNq3D6Schr4QyBmfEwFPGIx7TBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762874960;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2tVplv7/CD6HPjxvcjJ2gXjYAgQwqNemyVrBgR5GIp0=;
	b=hDd2+SIj1Dz7TBkji7GolO0dEI8xttLFKmDuVW7EWKe8gJNqMj87caEYcorP97vc+FhReN
	iSz1esIfln2L3ZDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E36A149D9;
	Tue, 11 Nov 2025 15:29:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MMViFlBWE2k2WQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 11 Nov 2025 15:29:20 +0000
Date: Tue, 11 Nov 2025 16:29:20 +0100
Message-ID: <87cy5ok2pb.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Haein Lee <lhi0729@kaist.ac.kr>
Cc: perex@perex.cz,
	Takashi Iwai <tiwai@suse.de>,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: usb-audio: Fix NULL pointer dereference in snd_usb_mixer_controls_badd
In-Reply-To: <vwhdiz65lpej.vwhdiz62bsc0.g5@dooray.com>
References: <vwhdiz65lpej.vwhdiz62bsc0.g5@dooray.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.1 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 72D132191C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 

On Tue, 11 Nov 2025 14:35:22 +0100,
Haein Lee wrote:
> 
> In snd_usb_create_streams(), for UAC version 3 devices, the Interface
> Association Descriptor (IAD) is retrieved via usb_ifnum_to_if(). If this
> call fails, a fallback routine attempts to obtain the IAD from the next
> interface and sets a BADD profile. However, snd_usb_mixer_controls_badd()
> assumes that the IAD retrieved from usb_ifnum_to_if() is always valid,
> without performing a NULL check. This can lead to a NULL pointer
> dereference when usb_ifnum_to_if() fails to find the interface descriptor.
> 
> This patch adds a NULL pointer check after calling usb_ifnum_to_if() in
> snd_usb_mixer_controls_badd() to prevent the dereference.
> 
> This issue was discovered by syzkaller, which triggered the bug by sending
> a crafted USB device descriptor.
> ---

You seem to have forgotten your Signed-off-by tag?
Please resubmit with it.


thanks,

Takashi

