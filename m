Return-Path: <linux-kernel+bounces-794828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7127B3E7B7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4319C7A1007
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D319342CA2;
	Mon,  1 Sep 2025 14:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Bh7aUgp7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Y7BPv5re";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Bh7aUgp7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Y7BPv5re"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139CA341665
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756738075; cv=none; b=oKvzZ9WTiWTrYA2I6LsEhxFodsIlwUP1/uuY1wlNfx7mUfflVgqSXNgM9dF2pwmekDukoo8B4f1wCGe8FIOjfxh+QNO0qBO+SIfJCocs7cXBa0EtaOTCYYwDUqzQAoebs75Xzkm2idwHfyIbsUeCeddodkVbr2Zmw4yQa3X6FxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756738075; c=relaxed/simple;
	bh=4PlS+RGkX7iEBQZ6XTQMODjWNQpIR62pAMQXHTcCR+s=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UdDBZWrv1rw77fkbUc07bK3NdIQ6YWvqcKLXC6HimQ65Ekxt/mW/sewoXUDOlBog0Udm4p+/sUj6jbLbp5DRiGOuVplYH2EyvwUnJiWC3eMvJoGFP8iZ6i3ut/Dbd2h4xJgl2Mm6ht2Rio6R5k+erChhzZocGlNq1hhboP3KYOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Bh7aUgp7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Y7BPv5re; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Bh7aUgp7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Y7BPv5re; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 228FF21191;
	Mon,  1 Sep 2025 14:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756738070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mI1fQGwM4jEvPoGFhraU1Y/EB1MiDRz7dzQzgQ/Cl4I=;
	b=Bh7aUgp7v6sE+DjVEpLPd9+B06IYHYvFpXwkSvvrH9nURbpuWra9UKKwWjcz3HkUv/+PZn
	NseV03HkoovRMnTqWX0uFj00AysRU83gAObrck53RHU/xt9sWR0FydNb1BZm8Hz3sBo5DW
	le68V16trbdtKvfPMLjEs71yAJ6LnmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756738070;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mI1fQGwM4jEvPoGFhraU1Y/EB1MiDRz7dzQzgQ/Cl4I=;
	b=Y7BPv5reabX/r6y0lrPDdwTzuey6KihcNsrctyE0SsEx3sf5x1kN0aSBEry1i7W4jxGrI4
	KUcFLa5nUZdFKdDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Bh7aUgp7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Y7BPv5re
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756738070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mI1fQGwM4jEvPoGFhraU1Y/EB1MiDRz7dzQzgQ/Cl4I=;
	b=Bh7aUgp7v6sE+DjVEpLPd9+B06IYHYvFpXwkSvvrH9nURbpuWra9UKKwWjcz3HkUv/+PZn
	NseV03HkoovRMnTqWX0uFj00AysRU83gAObrck53RHU/xt9sWR0FydNb1BZm8Hz3sBo5DW
	le68V16trbdtKvfPMLjEs71yAJ6LnmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756738070;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mI1fQGwM4jEvPoGFhraU1Y/EB1MiDRz7dzQzgQ/Cl4I=;
	b=Y7BPv5reabX/r6y0lrPDdwTzuey6KihcNsrctyE0SsEx3sf5x1kN0aSBEry1i7W4jxGrI4
	KUcFLa5nUZdFKdDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3849136ED;
	Mon,  1 Sep 2025 14:47:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BWR7MhWytWgWVwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 01 Sep 2025 14:47:49 +0000
Date: Mon, 01 Sep 2025 16:47:49 +0200
Message-ID: <87plca5iwa.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Mark Brown <broonie@kernel.org>,
	Charles Keepax	
 <ckeepax@opensource.cirrus.com>,
	Bard Liao
 <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart
 <pierre-louis.bossart@linux.dev>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH] ASoC: SDCA: Add quirk for incorrect function types for 3 systems
In-Reply-To: <3643b07326567604a6ba5b59ece84903dffcd3e5.camel@opensource.cirrus.com>
References: <20250901075755.2070983-1-mstrozek@opensource.cirrus.com>
	<87tt1m5kvl.wl-tiwai@suse.de>
	<3643b07326567604a6ba5b59ece84903dffcd3e5.camel@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 228FF21191
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
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,kernel.org,opensource.cirrus.com,linux.intel.com,linux.dev,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[opensuse.org:url,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.51

On Mon, 01 Sep 2025 16:28:48 +0200,
Maciej Strozek wrote:
> 
> W dniu pon, 01.09.2025 o godzinie 16∶05 +0200, użytkownik Takashi Iwai
> napisał:
> > On Mon, 01 Sep 2025 09:57:46 +0200,
> > Maciej Strozek wrote:
> > > 
> > > Certain systems have CS42L43 DisCo that claims to conform to
> > > version 0.6.28
> > > but uses the function types from the 1.0 spec. Add a quirk as a
> > > workaround.
> > > 
> > > Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
> > 
> > It's a fix for the report below, right?
> >   https://github.com/thesofproject/linux/issues/5515
> > Then please put it to Link tag.  Also at best give Fixes tag if you
> > can give some hint for the stable backports.
> > 
> That's correct, will put the Link in v2, thanks.
> Not sure however if Fixes tag is appropriate (not fixing a bug in a
> kernel commit but in the ACPI after all) - maybe a "Cc:
> stable@vger.kernel.org" is going to be enough?

I thought it's a regression, judging from the original bug report on
  https://bugzilla.opensuse.org/show_bug.cgi?id=1248239
but Cc-to-stable works, too.


thanks,

Takashi

