Return-Path: <linux-kernel+bounces-854013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3663DBDD57E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B12D7353DFA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9FA2D7DC6;
	Wed, 15 Oct 2025 08:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hyiMesVe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7wU/GNB4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iHkB+zIg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rexAMODu"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F6B2D2394
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760516335; cv=none; b=OOQDiEnsMN2pEi3G3L6NyHNUTErgM/mTDzS2LbjL20xonUE2UbwdaRkOnHYI1M/mZrRgphRorLvJXkKp8MM9ZVtMdKDAwaE3GMiWR1nera735yE/H9YosBYx4Ckr6jSHobFLZCYaX0Fgx0X4uu1MLOc1oyeyntnad3du3k315KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760516335; c=relaxed/simple;
	bh=5291ZGZEkJ8j+kcZ4/BVAOpJCPTOlPPieiL67Ugd4Sg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WnLIJgdXF5g2btiNWtE/aCg9FZ8AVQORd4k7xcfnCMtd6kv9U4Y3kTI79/K6BqHYGHLRa7M7KWtoQc3ObsOGIM5U0ZKCJJwUCMQKOm/NQRiztN0T6Wtq4CqmvehpNOpy2ReLRzgI+TYTPfbvj+fPmAjJG0AGQCVkMCNe6d6o9VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hyiMesVe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7wU/GNB4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iHkB+zIg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rexAMODu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F17DF203E2;
	Wed, 15 Oct 2025 08:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760516332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nd4W3sVFNv6jisALZXYLHsYCeA0aJkVPrhVN0wxBnLw=;
	b=hyiMesVeVFJZa2TF+K46wlTar0TcqcYk1V0LeMpg4Q5T40f+NqW7QH3XBW1u8M9tou0DHa
	xDANBpK6n5JQmxMBBFOJShoLr7F8VABCJaG6JHzM9ue6CmB5IXsX8IJBY1SVxCvSmcU6NI
	pLkK99S3OtEJBKXSYGIog+XA6/OJSC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760516332;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nd4W3sVFNv6jisALZXYLHsYCeA0aJkVPrhVN0wxBnLw=;
	b=7wU/GNB44EYraD8sH3+QQVjNAJIN72M33vhoRepVRxsdwjmcdffasFgYp8piS85vepkIZ7
	DGbSErHt760oi5Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iHkB+zIg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rexAMODu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760516330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nd4W3sVFNv6jisALZXYLHsYCeA0aJkVPrhVN0wxBnLw=;
	b=iHkB+zIgFX7NspZAxZwlTX3BiE3NGHjlk/rFKZRTS+A36p4Wpye3+sOQsG0bkXWIbhUGDI
	b4LuXOxaFJ5vPhRuMn6yh8MIe/st+4yrnQUL1wSkyMbh0+3/MtUN5ed+5ng+x/UQUCC7yb
	UtG05pRQyeEhBrCmzYw/oGTOkpvDNrY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760516330;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nd4W3sVFNv6jisALZXYLHsYCeA0aJkVPrhVN0wxBnLw=;
	b=rexAMODuUrvJQ5Phhw/9nG+FonHSKTaYH4x1pJGEUoTXDCJgZNovTfK4cTW9zkScKmK7pf
	Gs02ceTZlE08xwCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 936DF13A42;
	Wed, 15 Oct 2025 08:18:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IseFIupY72jSagAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 15 Oct 2025 08:18:50 +0000
Date: Wed, 15 Oct 2025 10:18:50 +0200
Message-ID: <87sefk60id.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jiaming Zhang <r772577952@gmail.com>
Cc: tiwai@suse.de,
	gregkh@linuxfoundation.org,
	broonie@kernel.org,
	cryolitia@uniontech.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	pierre-louis.bossart@linux.dev,
	quic_wcheng@quicinc.com,
	syzkaller@googlegroups.com,
	tiwai@suse.com
Subject: Re: [PATCH v2 1/1] ALSA: usb-audio: Fix NULL pointer deference in try_to_register_card
In-Reply-To: <20251015051645.519470-2-r772577952@gmail.com>
References: <877bwy81wi.wl-tiwai@suse.de>
	<20251015051645.519470-1-r772577952@gmail.com>
	<20251015051645.519470-2-r772577952@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: F17DF203E2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 

On Wed, 15 Oct 2025 07:16:45 +0200,
Jiaming Zhang wrote:
> 
> In try_to_register_card(), the return value of usb_ifnum_to_if() is
> passed directly to usb_interface_claimed() without a NULL check, which
> will lead to a NULL pointer dereference when creating an invalid
> USB audio device. Fix this by adding a check to ensure the interface
> pointer is valid before passing it to usb_interface_claimed().
> 
> Fixes: 39efc9c ("ALSA: usb-audio: Fix last interface check for registration")
> Closes: https://lore.kernel.org/all/CANypQFYtQxHL5ghREs-BujZG413RPJGnO5TH=xjFBKpPts33tA@mail.gmail.com/
> Signed-off-by: Jiaming Zhang <r772577952@gmail.com>

Thanks, applied now.
The Fixes tag should have 12 letter IDs, and I corrected it.


Takashi

