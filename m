Return-Path: <linux-kernel+bounces-725262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15523AFFC92
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6DA13A94EF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9053D28C5CE;
	Thu, 10 Jul 2025 08:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZA88T+xf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jKbKYe28";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZA88T+xf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jKbKYe28"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEEC28373
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136873; cv=none; b=h3VEnHqEwPBdlumcgrO3MbaTNfLGsh4M5hLTVHFSSyyJFqMX4XOHKwbyrlATlYSBQbz9poinBiei3jPq1JjtwPuIAFE8uIctola1MxLOZpmoN4v7oCdhk1Elf7Ku9ao59S98rwpwr4fnN3+15mYydJrZdovizCL61F2ikUKtIv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136873; c=relaxed/simple;
	bh=STn2q57jeDo3RRSnh6mN3+zMgSMN7WYjZz6DINKL4tM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ezNKN1hmaOxnX5KOx540IzCBzWMXQPrQvAO6rhWd82npBY2hmB+VT8wsr2CxSP1fp3jxmQy3QDviJfDzuQThQZKEsjNi+O1pyzfz7lp05L8JsftAPmy57+hpTpgELqZF+JmFgyUYEoDClex9Soa+KWB+GYO2+shPzUYq1H+svyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZA88T+xf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jKbKYe28; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZA88T+xf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jKbKYe28; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3202E1F385;
	Thu, 10 Jul 2025 08:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752136870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qg+lWA2L4+zvonrovL4IYLbdYYc0w/2hrLPns47Y6AU=;
	b=ZA88T+xfBel3jCeGEJLD0/Goa8lVUXuNPLNMZiUdZnMtsPqHfGceX3ko+R796pwlcI3q3l
	SozVIl2sOWM4VhWh1R2WMBzqxmjcd31wKclDCXKwCkAR4QZBABmNYsM5eeBvoJwZDQ46l/
	apciIM+HP4Efs3haynV2QYsgYbxiIHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752136870;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qg+lWA2L4+zvonrovL4IYLbdYYc0w/2hrLPns47Y6AU=;
	b=jKbKYe28EhX6EG1vCWmR7kWz+xgELookfRg/e6WMpWMj73hIzCGjZSD/irLdGEmFPmXfAA
	vPitzDIXYizuRhCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZA88T+xf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jKbKYe28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752136870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qg+lWA2L4+zvonrovL4IYLbdYYc0w/2hrLPns47Y6AU=;
	b=ZA88T+xfBel3jCeGEJLD0/Goa8lVUXuNPLNMZiUdZnMtsPqHfGceX3ko+R796pwlcI3q3l
	SozVIl2sOWM4VhWh1R2WMBzqxmjcd31wKclDCXKwCkAR4QZBABmNYsM5eeBvoJwZDQ46l/
	apciIM+HP4Efs3haynV2QYsgYbxiIHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752136870;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qg+lWA2L4+zvonrovL4IYLbdYYc0w/2hrLPns47Y6AU=;
	b=jKbKYe28EhX6EG1vCWmR7kWz+xgELookfRg/e6WMpWMj73hIzCGjZSD/irLdGEmFPmXfAA
	vPitzDIXYizuRhCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D261F13A70;
	Thu, 10 Jul 2025 08:41:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N5j4MaV8b2gjPAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 10 Jul 2025 08:41:09 +0000
Date: Thu, 10 Jul 2025 10:41:09 +0200
Message-ID: <87frf4xwt6.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Philipp Stanner <phasta@kernel.org>,
	Andres Urian Florez <andres.emb.sys@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: echoaudio: Replace deprecated strcpy() with strscpy()
In-Reply-To: <aG97MbrEKqqZbsYe@smile.fi.intel.com>
References: <20250709124655.1195-1-thorsten.blum@linux.dev>
	<87bjptzch3.wl-tiwai@suse.de>
	<7F3BCAEF-67D2-4907-9392-CAEFD3EF58C7@linux.dev>
	<aG97MbrEKqqZbsYe@smile.fi.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
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
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,suse.de,perex.cz,suse.com,kernel.org,gmail.com,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 3202E1F385
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.01

On Thu, 10 Jul 2025 10:34:57 +0200,
Andy Shevchenko wrote:
> 
> On Wed, Jul 09, 2025 at 10:55:02PM +0200, Thorsten Blum wrote:
> > On 9. Jul 2025, at 16:05, Takashi Iwai wrote:
> > > Thanks, applied now.
> 
> > > And now I'm going to convert all the rest of such trivial stuff
> > > (strcpy() with card->driver, shortname, mixername, longname, as well
> > > as pcm->name, and else) in sound/* for 6.17.
> > 
> > Yes, please :) I thought about submitting a patch series for all of
> > sound/*, but didn't find the time yet.
> 
> Note that strscpy() supports 3rd argument optionally, it means it's better
> to use 2-arg variant when the destination is supposed to be an array of
> characters.

Yes, most of Thomas' patches are using 2 arg variant, just replacing
strcpy() with strscpy().


thanks,

Takashi

