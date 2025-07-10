Return-Path: <linux-kernel+bounces-726082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD660B007F0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95A017D35B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F0A51022;
	Thu, 10 Jul 2025 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZjqwG/BZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BozYFRGQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZjqwG/BZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BozYFRGQ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A4627602E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162827; cv=none; b=R/pd1X4KMfA7czFonvVafr9gJXpIWoYkjP2xZVQgjEGijNl59BtMhjSLyHN+3POcSF6onra6C6RdAkfUUMOOThi90sEA2h5cqFSVthW0N6xtXXjYLNMlIhZHf13hF40pcUyU2zHBiFhG9cqCirxjeQcqKrTi+C4kpMRdkD8l6F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162827; c=relaxed/simple;
	bh=IkBoNhttrTtkaubDJe8GX/zJdY0BaFLFvaMb15n9VAQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e2fnW1mZn2GGdGp4eR+tAF9cJyn7PyVBwnfYF1wrBlyk1kK067Fs7jDEelLPBpeDvuqMpkT1aCe3V6tRq1kmnbj4T6IAdo50BBj/Auu/EqfuFLNymZBNGVfa/hgKE6clCWBbQfH+MnfqWbwwbhOnFFgqdx8I/y/c+FADtCknOrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZjqwG/BZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BozYFRGQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZjqwG/BZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BozYFRGQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0EAFF1F457;
	Thu, 10 Jul 2025 15:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752162824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=43gQc/GEYmcCJWsGfpJtKf771cWtvI+yuBklyQeWbPQ=;
	b=ZjqwG/BZeFzEdOOkwcd9O6iVDw3kwYyHpCuNdL9HohMk1d116i6xAVmvs89qh1+KLfNU1A
	YlHMfvIooDXkYbk4rT1yIRKvlbgEV+e2Hf86aIOld46OnbD1RBd2UC4RWwX0NauSpXbAS9
	S37bxyN1SB/E3Vb4GI2vliJFjRKwxYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752162824;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=43gQc/GEYmcCJWsGfpJtKf771cWtvI+yuBklyQeWbPQ=;
	b=BozYFRGQ8dEAFQ+2NXRdq/oWbxNPw06h/d13X9oVtNCZLyuy90GjQJMPiW2S27lzeGkBrm
	E1l/BA9cJDyUYsBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752162824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=43gQc/GEYmcCJWsGfpJtKf771cWtvI+yuBklyQeWbPQ=;
	b=ZjqwG/BZeFzEdOOkwcd9O6iVDw3kwYyHpCuNdL9HohMk1d116i6xAVmvs89qh1+KLfNU1A
	YlHMfvIooDXkYbk4rT1yIRKvlbgEV+e2Hf86aIOld46OnbD1RBd2UC4RWwX0NauSpXbAS9
	S37bxyN1SB/E3Vb4GI2vliJFjRKwxYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752162824;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=43gQc/GEYmcCJWsGfpJtKf771cWtvI+yuBklyQeWbPQ=;
	b=BozYFRGQ8dEAFQ+2NXRdq/oWbxNPw06h/d13X9oVtNCZLyuy90GjQJMPiW2S27lzeGkBrm
	E1l/BA9cJDyUYsBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4F15136CB;
	Thu, 10 Jul 2025 15:53:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nA/FMgfib2g0UQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 10 Jul 2025 15:53:43 +0000
Date: Thu, 10 Jul 2025 17:53:43 +0200
Message-ID: <87o6tsvy7s.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Ahelenia =?ISO-8859-2?Q?Ziemia=F1ska?=
 <nabijaczleweli@nabijaczleweli.xyz>
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: emu10k1: fix "for/take a while" typos
In-Reply-To: <6fvir6xkdvdu4pfo7hcv7zucaxosxjqb5t7gklovzcglnfkvc7@tarta.nabijaczleweli.xyz>
References: <e4owjda3hf5vjc2237m3ctokey4qglfrciga6ho24bd4os5awk@tarta.nabijaczleweli.xyz>
	<87tt3kw26n.wl-tiwai@suse.de>
	<6fvir6xkdvdu4pfo7hcv7zucaxosxjqb5t7gklovzcglnfkvc7@tarta.nabijaczleweli.xyz>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nabijaczleweli.xyz:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Thu, 10 Jul 2025 17:44:20 +0200,
Ahelenia Ziemiañska wrote:
> 
> On Thu, Jul 10, 2025 at 04:28:00PM +0200, Takashi Iwai wrote:
> > On Thu, 03 Jul 2025 20:21:29 +0200,
> > Ahelenia Ziemiañska wrote:
> > > 
> > > Signed-off-by: Ahelenia Ziemiañska <nabijaczleweli@nabijaczleweli.xyz>
> > > ---
> > > v1: https://lore.kernel.org/lkml/h2ieddqja5jfrnuh3mvlxt6njrvp352t5rfzp2cvnrufop6tch@tarta.nabijaczleweli.xyz/t/#u
> > Well, "awhile" is a proper word, AFAIK.
> Yes, but these two uses are clearly typos of "a while";
> "awhile" is used differently: you could do
> -	/* Step 3: Wait for awhile;   XXX We can't get away with this
> +	/* Step 3: Wait awhile;   XXX We can't get away with this
> for example.

That may be true from the strict grammatic POV, but "for awhile" is
seen relatively frequently and loosely perceived.


Takashi

