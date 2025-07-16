Return-Path: <linux-kernel+bounces-733490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A39B07556
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4061F1893673
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E8D2F508C;
	Wed, 16 Jul 2025 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hOIZnrXz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HB9OuTQK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hOIZnrXz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HB9OuTQK"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0342F49EE
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752667842; cv=none; b=jL/kGoSmxuaB3zO8TEdrUHKeOwamfEDr5ynufUgrB8nBI4AZrXNbHdytLLJhFGKJ6q8LX67UqW0jfNqE5vMCjy1VnZ1927Z8a4WisAvsYAbD9gAHYxqGsiGNateS0dapT1G6syTn+b94AAzUuJ6yz42YwamjCOqNXLcF+uvkc5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752667842; c=relaxed/simple;
	bh=+DQSWx3yVyCtQC6RXEyoICfnEwzSiuB0gZtQFWEjymo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hwO1DGt2FM/sKwRbRy8XXdrx7azzRkmtMzHoFT6JKmD8id9vMUnJFLpGCv9VU+3TaovqxvGnFD1DlmSb7JpJ0CjqRWTTpZQOeY9f47jVZRpoM7qLFFcD4wsCqnvJLSCmtU1Q+8UNu/QXh/r0T2jGGqiIiFFQn2UTW3ujUqxsRmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hOIZnrXz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HB9OuTQK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hOIZnrXz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HB9OuTQK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 97AB9211D2;
	Wed, 16 Jul 2025 12:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752667838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ILZQ7nnSubmNzfn9RrR/2T0GRSSWHJQ0gQAQvz3WxPE=;
	b=hOIZnrXz3fPJvoUOEdOhXvyOBQj9YYDzZ97TC4bk+CpiNNUEC8sqaF1OzntBbmWcjz6Lur
	YmVkTgu8cpBAL02dhudA5bEk7BxzF8FKn6AscazLNutzO/Yx8GbgF6FNQSEwWQig48SpGf
	RALjRZXlyNPju3VeWcrEqLbAH6Va0Po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752667838;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ILZQ7nnSubmNzfn9RrR/2T0GRSSWHJQ0gQAQvz3WxPE=;
	b=HB9OuTQK77wzVWqTa4//BlL9FFNi+Hs4Fu/7B6R+eDYD+KP0tHVpyBwQo8d8EbYm3JpY9n
	FMcA1G7ztNUWssDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hOIZnrXz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HB9OuTQK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752667838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ILZQ7nnSubmNzfn9RrR/2T0GRSSWHJQ0gQAQvz3WxPE=;
	b=hOIZnrXz3fPJvoUOEdOhXvyOBQj9YYDzZ97TC4bk+CpiNNUEC8sqaF1OzntBbmWcjz6Lur
	YmVkTgu8cpBAL02dhudA5bEk7BxzF8FKn6AscazLNutzO/Yx8GbgF6FNQSEwWQig48SpGf
	RALjRZXlyNPju3VeWcrEqLbAH6Va0Po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752667838;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ILZQ7nnSubmNzfn9RrR/2T0GRSSWHJQ0gQAQvz3WxPE=;
	b=HB9OuTQK77wzVWqTa4//BlL9FFNi+Hs4Fu/7B6R+eDYD+KP0tHVpyBwQo8d8EbYm3JpY9n
	FMcA1G7ztNUWssDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69BEA138D2;
	Wed, 16 Jul 2025 12:10:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UNmMGL6Wd2jaXQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 16 Jul 2025 12:10:38 +0000
Date: Wed, 16 Jul 2025 14:10:38 +0200
Message-ID: <878qko8hfl.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Erick Karanja <karanja99erick@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	julia.lawall@inria.fr
Subject: Re: [PATCH v2] staging: sound: Adjust mutex unlock order
In-Reply-To: <20250716081804.727623-1-karanja99erick@gmail.com>
References: <20250716081804.727623-1-karanja99erick@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
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
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 97AB9211D2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

On Wed, 16 Jul 2025 10:18:04 +0200,
Erick Karanja wrote:
> 
> The mutexes qdev_mutex and chip->mutex are acquired in that order
> throughout the driver. To preserve proper lock hierarchy and avoid
> potential deadlocks, they must be released in the reverse
> order of acquisition.
> 
> This change reorders the unlock sequence to first release chip->mutex
> followed by qdev_mutex, ensuring consistency with the locking pattern.
> 
> changes since v1:
>    - Applied the unlock reordering in other functions with this pattern.
> 
> Signed-off-by: Erick Karanja <karanja99erick@gmail.com>

The code change looks good, but could you resubmit with the proper
subject prefix (e.g. "ALSA: usb: qcom:"), and with a Fixes tag?


thanks,

Takashi

