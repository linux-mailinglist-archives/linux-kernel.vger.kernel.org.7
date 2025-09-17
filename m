Return-Path: <linux-kernel+bounces-820772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EA5B7F316
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D38A74A80B1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1BF3161B4;
	Wed, 17 Sep 2025 13:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QcJIh7J/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="55KP0dXB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QcJIh7J/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="55KP0dXB"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED942DA76C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758114747; cv=none; b=TOCXHTjS6COFTglN0eOoLYzXzlwGRIOctbRds2e3v3o4vXEuBVa4JHEY+Ny1rkkx5LnVrC58n4aRtznZ7VsMLoPt1irGOREkObQ9oZXkn8exIWS3tg4EtMdE8AP2se/JgE+lYWCFQSpXF0Nf4bENHt9l9+csm0sQsEjBu5ia+m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758114747; c=relaxed/simple;
	bh=idEVzpN4vlkpt3jQp88gH0ZL7rkRcPSesetXBfE6c3c=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fRjQpfF7pcCC5XGrS0joLI+YZZEly7SYWnZ4Tb2dS2hE6vIV0XnfpVzNeCOn7dfS3HfwDQK6eToo1ydL0SO1TXwnx2rHgvE7ZPcviThKcYKMmL23X/tYTsTsH9mp1bQznUOYPTmJ7rhJnYhyxiHBjCYJR89cBHWWlf7gohw0U0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QcJIh7J/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=55KP0dXB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QcJIh7J/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=55KP0dXB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BBC1C1FED5;
	Wed, 17 Sep 2025 13:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758114743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=miYOdNg0sxOGY/FSiJ8E5n6I55+a3iiyeqkliFEPIEA=;
	b=QcJIh7J/FPWE5BMPsqpDdNav5cS4/xejQB3Om7ZiOpo4LnPwPH9tZZNRZrnOILHW+uIMfp
	+jGHNYr9K/BgzkOeCKrm4nW/ozvXHMGoTqmobOfplq13UCrqkF5Ew/DeQtCFte1Twb1wBf
	imY9UaIgx4Cbt7K40+vN84Mcljuw1dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758114743;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=miYOdNg0sxOGY/FSiJ8E5n6I55+a3iiyeqkliFEPIEA=;
	b=55KP0dXBHd/7jL+iUa3FeZ17nju5SetCNuLmAkp2z94R9J9HPF0u2fQwyHc7cMlnMYfgt/
	5RLW1aCvYxFC2oAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758114743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=miYOdNg0sxOGY/FSiJ8E5n6I55+a3iiyeqkliFEPIEA=;
	b=QcJIh7J/FPWE5BMPsqpDdNav5cS4/xejQB3Om7ZiOpo4LnPwPH9tZZNRZrnOILHW+uIMfp
	+jGHNYr9K/BgzkOeCKrm4nW/ozvXHMGoTqmobOfplq13UCrqkF5Ew/DeQtCFte1Twb1wBf
	imY9UaIgx4Cbt7K40+vN84Mcljuw1dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758114743;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=miYOdNg0sxOGY/FSiJ8E5n6I55+a3iiyeqkliFEPIEA=;
	b=55KP0dXBHd/7jL+iUa3FeZ17nju5SetCNuLmAkp2z94R9J9HPF0u2fQwyHc7cMlnMYfgt/
	5RLW1aCvYxFC2oAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5BEAA1368D;
	Wed, 17 Sep 2025 13:12:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4ScSFLezymgUbwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 17 Sep 2025 13:12:23 +0000
Date: Wed, 17 Sep 2025 15:12:22 +0200
Message-ID: <87tt11cjex.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Takashi Iwai" <tiwai@suse.de>,
	"Luca Weiss" <luca.weiss@fairphone.com>,
	"Arnd Bergmann" <arnd@kernel.org>,
	"Mark Brown" <broonie@kernel.org>,
	"Wesley Cheng" <quic_wcheng@quicinc.com>,
	"Jaroslav Kysela" <perex@perex.cz>,
	"Takashi Iwai" <tiwai@suse.com>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	"Dan Carpenter" <dan.carpenter@linaro.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ALSA: qc_audio_offload: try to reduce address space confusion
In-Reply-To: <548b20d2-70f5-403c-821c-630c1e605b34@app.fastmail.com>
References: <20250513123442.159936-1-arnd@kernel.org>
	<20250513123442.159936-4-arnd@kernel.org>
	<DBR2363A95M1.L9XBNC003490@fairphone.com>
	<87v7n72pg0.wl-tiwai@suse.de>
	<DBR3FZGY4QS1.BX6M1PZS5RH4@fairphone.com>
	<87ms8j2on6.wl-tiwai@suse.de>
	<DCKUCB8A1JCV.1GK0TW2YMXNZP@fairphone.com>
	<87bjnpqe45.wl-tiwai@suse.de>
	<a2a6843f-7e03-4b7e-b5fc-415ac9fc6621@app.fastmail.com>
	<DCU39JVDVFAG.2EOCQ37KAS3N0@fairphone.com>
	<87o6raxtu9.wl-tiwai@suse.de>
	<DCUXFIZ5KRCU.3JANM98BSE8SE@fairphone.com>
	<87v7lhwkf2.wl-tiwai@suse.de>
	<548b20d2-70f5-403c-821c-630c1e605b34@app.fastmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Wed, 17 Sep 2025 14:52:54 +0200,
Arnd Bergmann wrote:
> 
> On Wed, Sep 17, 2025, at 10:30, Takashi Iwai wrote:
> > On Wed, 17 Sep 2025 10:19:23 +0200,
> >> >> 
> >> >> Are you planning to post this as a proper patch? It's a bit late in the
> >> >> 6.17 cycle already but good to still get this fixed for final release.
> 
> I was expecting your earlier suggestion (without my experimental
> changes) to get merged for 6.17.

Ah that was misunderstanding, then.

> >> Should that code be removed with the new code now?
> >
> > Yes, please try the revised patch below.
> 
> This version looks good to me, thanks for following up,
> and sorry if I caused you extra work.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks, I'm going to include this for the next PR for 6.17-rc7.


Takashi

