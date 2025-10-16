Return-Path: <linux-kernel+bounces-855793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE35BE257B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C51FA4E676C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE20314D37;
	Thu, 16 Oct 2025 09:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WS3VFXc3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Lxpn8N3R";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ti3nuT+X";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rrIWUdC/"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B2430100A
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760606494; cv=none; b=l9IolrHhhNsA58d6Hi2qeRH1Gbdf+D73+KrQR3pmFx82UWHjJDjWt65l+TLsUGTiBkd8/d7rQAw/BZsGz3/oDr9obs25ne3CzFTV2PE7AXPZCluoTKq6GAWB/N42XxX6nrw1MXycggrQ92UuEZileang7AqGLbTR6EcNux2lbpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760606494; c=relaxed/simple;
	bh=VMtHXk2vqy1D1teO3YuBkDZ1i/n7dlltZH5+AONsR/o=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxjQJbwqGWThbBjCMLAWwOkEr0HwIIDIKv2873e5m6qC3LNHBaKXPw4vlCfs0cY9PVfjgxaIZd1haclxXpp8sFBwLkwGyjLH2HLFQMg3TmNd/2lMPHxe6CbFGpTb69lssuXgqoKhvxCZn0+X0BiXpHdO5ePO2e9w0YqEm1SQ6AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WS3VFXc3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Lxpn8N3R; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ti3nuT+X; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rrIWUdC/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AD7F71F391;
	Thu, 16 Oct 2025 09:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760606490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Y/64VoVA3zCaslYQ1R/AMtzHtj2wgrG+WqEeheO2k0=;
	b=WS3VFXc39/bzB3QqVhu9HrQjUNr+CRq5dtAS1Y2vtbBrgL9RGEe0BQistR6VGGr55PDl0X
	ON9xzI4eVkrzRPcEdNGuUai3GifTuKhKMm13bVn0wqwmdoT92EJ8YLpVjxpDasSZ6h929Y
	jMFwSI3LtXeTiNe8fYf4u1hPmWvS3zo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760606490;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Y/64VoVA3zCaslYQ1R/AMtzHtj2wgrG+WqEeheO2k0=;
	b=Lxpn8N3RhLlvKEcx6JYmfoXg+VG+dtzvcABMBI6vF3YJFpseKS8+D6bIApUOZRrU9kzxaj
	aXpPftq6XdindmCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ti3nuT+X;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="rrIWUdC/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760606489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Y/64VoVA3zCaslYQ1R/AMtzHtj2wgrG+WqEeheO2k0=;
	b=ti3nuT+XQAf4IS2BEYfP/9VIRn3yfeOfo2zGjpGKIbMLYuTnRc9OLvJqZ+BphKvjCU2GhL
	ocDYOhBhpgJimuTs2AbcubPeJlBqGHScDMqhzIVmeJTdFjtF2I88EVY10b8nj4jIxHCoHd
	03HAZDZC2nzCMbghyawdwrp8dwvlIjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760606489;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Y/64VoVA3zCaslYQ1R/AMtzHtj2wgrG+WqEeheO2k0=;
	b=rrIWUdC/XqxWtgamCc/hjZP8zQGBr0vEZBGd2UcnSR38q1cY02VIrAcDGuUeauc3OqhSXV
	Jryq1/jbkwiYcQBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8292213B03;
	Thu, 16 Oct 2025 09:21:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id itCQHhm58GinSwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 16 Oct 2025 09:21:29 +0000
Date: Thu, 16 Oct 2025 11:21:29 +0200
Message-ID: <87h5vz8ana.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-sound@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: add volume quirks for MS LifeChat LX-3000
In-Reply-To: <c6e6991fd3f1099f5919593a68a4e7819c204068.1760557349.git.pav@iki.fi>
References: <c6e6991fd3f1099f5919593a68a4e7819c204068.1760557349.git.pav@iki.fi>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: AD7F71F391
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.51

On Wed, 15 Oct 2025 21:47:10 +0200,
Pauli Virtanen wrote:
> 
> ID 045e:070f Microsoft Corp. LifeChat LX-3000 Headset
> has muted minimum Speaker Playback Volume, and 4 amixer steps were
> observed to produce 1 actual volume step.
> 
> Apply min_mute quirk and correct res=48 -> 4*48.
> Tested with the device.
> 
> Signed-off-by: Pauli Virtanen <pav@iki.fi>

Thanks, applied now.


Takashi

