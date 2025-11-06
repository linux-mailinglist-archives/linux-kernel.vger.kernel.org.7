Return-Path: <linux-kernel+bounces-888148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0798DC39F7E
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 10:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF0BD5017BB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 09:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390CC30DD2F;
	Thu,  6 Nov 2025 09:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G3gR+uka";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="heOWFfHY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G3gR+uka";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="heOWFfHY"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD9530C63E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762422792; cv=none; b=srPTOayqsCDR6PDZqY0Iw5yGutWQZpTbljzYGhRpsGGli+DDHRQHV+izuS3dBOvkRp0iBd9dNjQdO1YAbZvI5Q3rm2T2qa21KZlI+mE6vHfmxMf5w7NSAq4tcR6/vx3rzEuRcPRrfMXNG81RHQBtV3E23or0MqxFdSLxluskxBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762422792; c=relaxed/simple;
	bh=u7HIonzKxf8nGwH18kJ+5jzY/8OWOQXBy0/uDKNrSwQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BWVAS4uhZXvQWKUS1XCpmAMGrHXHm5U4x5G7kz2nvurqKYFMfh7nRQN9/uDZEcL/8klkO1aJnK4zQX5jmGSf1evoUTkOgGkIz7bIbXsAFT05CYDYXnO9wFiEd+c0igSP7TeRQojBj9f2ujUHGvQ7QThk8dQX0lvsJJOuL6650EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G3gR+uka; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=heOWFfHY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G3gR+uka; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=heOWFfHY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0CB66211C7;
	Thu,  6 Nov 2025 09:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762422788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hObY591i2ebOpMV8hl1z0D2XaECt5kd5s+CmGONLt8M=;
	b=G3gR+ukaif2w7MDKkzIQ7f1CCle0XcTi88PZgQirro0i5p1shT7wp5SlHkEs5+BVSwhN61
	9aYUiG62BzZmJ7MqxqsQyLYLx+5ihbdLPnAse4nd40wlCOcyZuLa46d2rp03WljJMowCFc
	9KmoaeH9YmwVog8dw/6A/YR1PUkqKcU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762422788;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hObY591i2ebOpMV8hl1z0D2XaECt5kd5s+CmGONLt8M=;
	b=heOWFfHYT4zcdqwvhlPoCUjErZLyHR9n12trLg4YAYrlfCq27x4XftLgijhZfqbVSI3dcA
	HbCas74ALrilsQAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=G3gR+uka;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=heOWFfHY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762422788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hObY591i2ebOpMV8hl1z0D2XaECt5kd5s+CmGONLt8M=;
	b=G3gR+ukaif2w7MDKkzIQ7f1CCle0XcTi88PZgQirro0i5p1shT7wp5SlHkEs5+BVSwhN61
	9aYUiG62BzZmJ7MqxqsQyLYLx+5ihbdLPnAse4nd40wlCOcyZuLa46d2rp03WljJMowCFc
	9KmoaeH9YmwVog8dw/6A/YR1PUkqKcU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762422788;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hObY591i2ebOpMV8hl1z0D2XaECt5kd5s+CmGONLt8M=;
	b=heOWFfHYT4zcdqwvhlPoCUjErZLyHR9n12trLg4YAYrlfCq27x4XftLgijhZfqbVSI3dcA
	HbCas74ALrilsQAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5FF0139A9;
	Thu,  6 Nov 2025 09:53:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ltP/LgNwDGk7LgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 06 Nov 2025 09:53:07 +0000
Date: Thu, 06 Nov 2025 10:53:07 +0100
Message-ID: <87bjlfh4ho.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: hariconscious@gmail.com
Cc: perex@perex.cz,
	tiwai@suse.com,
	khalid@kernel.org,
	shuah@kernel.org,
	david.hunter.linux@gmail.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: ac97: Fix kernel-doc warning for snd_ac97_reset
In-Reply-To: <20251105105229.112172-2-hariconscious@gmail.com>
References: <20251105105229.112172-2-hariconscious@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 0CB66211C7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,kernel.org,gmail.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.01
X-Spam-Level: 

On Wed, 05 Nov 2025 11:52:30 +0100,
hariconscious@gmail.com wrote:
> 
> From: HariKrishna Sagala <hariconscious@gmail.com>
> 
> kernel-doc populated the below warning for the non
> static function "snd_ac97_reset".
> "Warning: ./sound/ac97_bus.c:56 No description found
> for return value of 'snd_ac97_reset'".
> Added the return values as per the kernel-doc format.
> 
> Signed-off-by: HariKrishna Sagala <hariconscious@gmail.com>

Applied now to for-next branch.


thanks,

Takashi

