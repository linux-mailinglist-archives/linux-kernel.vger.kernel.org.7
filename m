Return-Path: <linux-kernel+bounces-768023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99CFB25BF5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50A25C4F5E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF77B253B73;
	Thu, 14 Aug 2025 06:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="miRUqXf3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rnZTycuF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZxFdop4F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2+X+dTiZ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B86252903
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755153627; cv=none; b=KHj7V14hFOEsr9CDwVppuOWCRS4mVBBUpyCDqjF2xDaY0OnSK9rGhoCAxy3g5CunlYTskw1pYUk2G3pX9vkoQWr9lK13hsBrz3Q04hTZ4Zxv10BEedG4yc8jwTl4W/CoGLhaCAuXKcvdpCm9adqIjdTUvb7Zlz4wk6Jpyye07vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755153627; c=relaxed/simple;
	bh=MhWHhTRJO+DSytqn3+SK5OnuaBUnj3Ai2GIi/W+qeHY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jcJAZV2wjB9oS1fN91deYoq1geXXKQ91o3oGee04DdthqiGNqvVm5ZQYxSY580PBqq71Npvdlc24Ndo9k930NJ539aaQ+RoSmRuWEdutSFefSdYws49/y9433yVfKUlVLUZCvdjnlt5DrN7Z6J6mdAC6mmYr7Y+4HQQ8OZVYBT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=miRUqXf3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rnZTycuF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZxFdop4F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2+X+dTiZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D206A21ACE;
	Thu, 14 Aug 2025 06:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755153622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5R6WdRPK1GyW0YhBaEFYdGmCdZqRwRQm4twHoF64n78=;
	b=miRUqXf3OCGfpHanDr7XqvvkUKzCwKhZD5q6Sxzc6Cz2Q6C5BZYsdCiX+uHVqbkfNRouPp
	26szlKt6HvfwZWBHJ+XDH4THeOoOlHd5oxinXEG2869P5E4jl22D9nmM2UhsE8OIzxVrsV
	969kJFYrZHHBb64TTjwSX2wtRuCUFGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755153622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5R6WdRPK1GyW0YhBaEFYdGmCdZqRwRQm4twHoF64n78=;
	b=rnZTycuF5DERvED79uTtLQJ++vwNVCyKce0oyazHbGjX6xEJjZEdHDc36Ll2rDs+Rx+8db
	+tYUWmJ2rmiskrBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZxFdop4F;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2+X+dTiZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755153621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5R6WdRPK1GyW0YhBaEFYdGmCdZqRwRQm4twHoF64n78=;
	b=ZxFdop4F67WNPLAWsao4lpawIopCqHFnbqVpaL69MEn/IsE6BThCmnQgSOcxzrGfJ5nFiG
	JjVhtn6OpOduB0KUbbLJ5EHSttu1EPf980PDko1B6L8k+uiDVkOb/2AmASloBs6SZtrz7I
	nIYGM/8O6opxj5QwprI2RHZs6m5vNXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755153621;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5R6WdRPK1GyW0YhBaEFYdGmCdZqRwRQm4twHoF64n78=;
	b=2+X+dTiZf1BfIA/eJDLqcD5FO1W1um2pkxzPxr6hLvX3A9QQ34trU4SMH3Yk4BuBYa5a3A
	i7fNxHlREY3JYyDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83B9E1368C;
	Thu, 14 Aug 2025 06:40:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HS2fHtWEnWjSbgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 14 Aug 2025 06:40:21 +0000
Date: Thu, 14 Aug 2025 08:40:21 +0200
Message-ID: <87y0rmv222.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Wentao Liang <vulab@iscas.ac.cn>,
	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ALSA: hda: Use min() to simplify snd_hda_get_devices()
In-Reply-To: <20250813205507.215658-2-thorsten.blum@linux.dev>
References: <20250813205507.215658-2-thorsten.blum@linux.dev>
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
	RCPT_COUNT_SEVEN(0.00)[9];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: D206A21ACE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

On Wed, 13 Aug 2025 22:55:02 +0200,
Thorsten Blum wrote:
> 
> Use min() to simplify snd_hda_get_devices() and improve its readability.
> 
> Change the function parameter 'max_devices' from 'int' to 'unsigned int'
> to avoid a min() signedness error. Update all related local variables
> and the function's return type to 'unsigned int' accordingly.
> 
> No functional changes intended.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Applied both patches now.  Thanks.


Takashi

