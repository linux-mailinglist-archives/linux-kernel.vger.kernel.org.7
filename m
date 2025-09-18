Return-Path: <linux-kernel+bounces-807286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6420CB4A288
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24B63447178
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E80E303CB6;
	Tue,  9 Sep 2025 06:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u4wnmX49";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uF9qbEas";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u4wnmX49";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uF9qbEas"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C192E0B48
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 06:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757400290; cv=none; b=ETsSUD0AZXLMCLrWvHYESR+YUUOa5jDXO8X/Yp97MeHBhwfHknJZWkveFcxG+TfvAk1hNgraloknOBivHvKgDMEfF7Nanf8X9UpgNdHdYXiBCrZEFxasUn+4NBDgTvvIiBk6u94h40H0hax4ozM1JyCVbK6S2f5R5zk3YRGojVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757400290; c=relaxed/simple;
	bh=jVCpJzsjf8+S0B5AlwPEoB+d8OEeIB1jqVGaP+9eyUQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gd3vPKSFYSH8mFyrtX7PocJsdnna3PZQJOaTrlU5HCOEqHFEs2S9XCfkxFTibJ7sf5FD+iCPYf+r4rKeJ1+UtQ/1Q5LzHSWrPjbywgptbTQLrMCCoL7ITX/y/4+uvgaXgFAs0w3pLbskKiUdFC79vYxZ/IAYcfAMPJ0iW/BMENY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u4wnmX49; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uF9qbEas; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u4wnmX49; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uF9qbEas; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1F8E361422;
	Tue,  9 Sep 2025 06:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757400286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gnWh4Y7GIm/Whnq/U7nkCyGlvFLb9Nd0Od8KNO7fMFQ=;
	b=u4wnmX49iWBKFzKlIWxQ3AdECrXPNG1T2xXTIkol6ECx1KR3J89jgNr0oyBfi8ATC66jXk
	/o/Xgpo4ihuWG6+Q8NXhqdeHgq37fknwcCZgTxVZ/FuW4SY/PbX7REASUeJf4IW6ASTBgO
	kdFizGqYPY6O4GSntuwlwiEDJSsVvFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757400286;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gnWh4Y7GIm/Whnq/U7nkCyGlvFLb9Nd0Od8KNO7fMFQ=;
	b=uF9qbEasJQeumW1hdRaPhLVsG3yj+fr17TFk3b2FFcYTQnReIGy/JRcyeMWZjOiB9aZKlm
	k8dVYN3947Dd73CA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=u4wnmX49;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uF9qbEas
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757400286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gnWh4Y7GIm/Whnq/U7nkCyGlvFLb9Nd0Od8KNO7fMFQ=;
	b=u4wnmX49iWBKFzKlIWxQ3AdECrXPNG1T2xXTIkol6ECx1KR3J89jgNr0oyBfi8ATC66jXk
	/o/Xgpo4ihuWG6+Q8NXhqdeHgq37fknwcCZgTxVZ/FuW4SY/PbX7REASUeJf4IW6ASTBgO
	kdFizGqYPY6O4GSntuwlwiEDJSsVvFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757400286;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gnWh4Y7GIm/Whnq/U7nkCyGlvFLb9Nd0Od8KNO7fMFQ=;
	b=uF9qbEasJQeumW1hdRaPhLVsG3yj+fr17TFk3b2FFcYTQnReIGy/JRcyeMWZjOiB9aZKlm
	k8dVYN3947Dd73CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E333E1388C;
	Tue,  9 Sep 2025 06:44:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DOcmNt3Mv2g8VgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 09 Sep 2025 06:44:45 +0000
Date: Tue, 09 Sep 2025 08:44:45 +0200
Message-ID: <87bjnkxgyq.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Erick Karanja <karanja99erick@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Julia Lawall <julia.lawall@inria.fr>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: spi: Replace lock/unlock patterns with guard
In-Reply-To: <20250909061702.350164-1-karanja99erick@gmail.com>
References: <20250909061702.350164-1-karanja99erick@gmail.com>
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
X-Rspamd-Queue-Id: 1F8E361422
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
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.51

On Tue, 09 Sep 2025 08:17:02 +0200,
Erick Karanja wrote:
> 
> Replace lock/unlock patterns with guard.This simplifies control
> flow especially with conditional jumps and improves code readability.
> 
> Generated-by: Coccinelle SmPL
> 
> Signed-off-by: Erick Karanja <karanja99erick@gmail.com>

The mutex locks have been already converted with guard().
Please rebase your patch to linux-next or sound.git tree for-next
branch, and resubmit.


thanks,

Takashi

