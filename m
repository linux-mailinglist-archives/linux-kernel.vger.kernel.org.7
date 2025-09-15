Return-Path: <linux-kernel+bounces-816630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B26B5767B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5407F1A22877
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24762FC03B;
	Mon, 15 Sep 2025 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="emt6egCR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZX83q5nv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="emt6egCR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZX83q5nv"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C70A2FB99E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757932471; cv=none; b=sfsfoI04/mLWkcsa/GSu3HXlQAK6hfQPOPzIlmvUDqZjq7Xd92l/tck7oYyrIIkSRmkTwqmIADStX/uCpKfc3tW4epzSslCV2y2125d3mN29jpWSFfshtpDcb9RaDyZWBDNDzOye1U8wkDBgYI1h4OWRf6wXzQkvCDBTsweDdvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757932471; c=relaxed/simple;
	bh=l0IxsEhh0UI2MeXsRkhtWOxyRsRXivFNd5jOuvoFet4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BqxU7+dd64YCXrfw6/MJlJiMF/Bb4yXoJduS2EigR3PKXBEyxyEx4uanRUgYoeXK4uG9n6vidXyrBAxfIrlViMVIi5vC05nrw7efLfVky5PUn7Hek3O77JafHjNmrSmaf6EMzrfvO/e5TPUCxik5rN5Qp0dwZej9D9/nR0Pq/ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=emt6egCR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZX83q5nv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=emt6egCR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZX83q5nv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A030F22C0A;
	Mon, 15 Sep 2025 10:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757932467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9SW5c+gjQIhlWqokd5OPBkQQfnZsSckbhdO380pLmBQ=;
	b=emt6egCR9DHZpy+AhzKmh745PRSdMlVEhOM+xCzcHW5SGL5aeMR7aMhlbXCOuRAs1KDbq7
	Xgz5w8tno1Vq/h/S5rhSjyLIEBkXxSciWn2DkXBBK8RSAmqQ2MDxbWL5/2lPDD853iclbK
	kAAgj5MGCMfyr0WaRQyv+SuTllDUSQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757932467;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9SW5c+gjQIhlWqokd5OPBkQQfnZsSckbhdO380pLmBQ=;
	b=ZX83q5nvJ3+IWo/tdKUmgL4nRmLEmGCYG/aaGFvdHnxo29qg3Tp1uGj+8itjwSMxs/Ly+P
	D4iW5XwriXv1/6BA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=emt6egCR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZX83q5nv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757932467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9SW5c+gjQIhlWqokd5OPBkQQfnZsSckbhdO380pLmBQ=;
	b=emt6egCR9DHZpy+AhzKmh745PRSdMlVEhOM+xCzcHW5SGL5aeMR7aMhlbXCOuRAs1KDbq7
	Xgz5w8tno1Vq/h/S5rhSjyLIEBkXxSciWn2DkXBBK8RSAmqQ2MDxbWL5/2lPDD853iclbK
	kAAgj5MGCMfyr0WaRQyv+SuTllDUSQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757932467;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9SW5c+gjQIhlWqokd5OPBkQQfnZsSckbhdO380pLmBQ=;
	b=ZX83q5nvJ3+IWo/tdKUmgL4nRmLEmGCYG/aaGFvdHnxo29qg3Tp1uGj+8itjwSMxs/Ly+P
	D4iW5XwriXv1/6BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 734B11368D;
	Mon, 15 Sep 2025 10:34:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6MHEGrPrx2gPEwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 15 Sep 2025 10:34:27 +0000
Date: Mon, 15 Sep 2025 12:34:26 +0200
Message-ID: <87jz203sy5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: John Keeping <jkeeping@inmusicbrands.com>
Cc: linux-sound@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: serial-generic: remove shared static buffer
In-Reply-To: <20250915094220.2959202-1-jkeeping@inmusicbrands.com>
References: <20250915094220.2959202-1-jkeeping@inmusicbrands.com>
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
X-Rspamd-Queue-Id: A030F22C0A
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
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.51

On Mon, 15 Sep 2025 11:42:19 +0200,
John Keeping wrote:
> 
> If multiple instances of this driver are instantiated and try to send
> concurrently then the single static buffer snd_serial_generic_tx_work()
> will cause corruption in the data output.
> 
> Move the buffer into the per-instance driver data to avoid this.
> 
> Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>

Thanks, applied now to for-next branch.


Takashi

