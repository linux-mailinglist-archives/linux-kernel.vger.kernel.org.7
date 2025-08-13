Return-Path: <linux-kernel+bounces-767038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55675B24E61
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 727569A4835
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE5123C8CD;
	Wed, 13 Aug 2025 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V7zyuGgJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="10TXlJb1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V7zyuGgJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="10TXlJb1"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5B6283CBE
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099906; cv=none; b=fFKATeFuZFh6NzW/e49pwHq5+Bx0ybrpFF7by+f49tLro2szzde+H+KCpOQEDqzgyle4oWgTv16JAb4IdIQg3mpSeAODvxT6VQYVLasUKb21keFkPrO9Sre3ThAV2Y1IADcDZQwfLlCd+vrSnoFgZzcVQGoXVpvp8j8P7y9O4ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099906; c=relaxed/simple;
	bh=7dC3c/Oj1O8mGYJBgCX4c3GUtvAz3JvaPHIGlyvtdYY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eBXssG57BIy3KSuUYQBGZUDN32foYrMRIPL1ojnaS62iUFG8mpPJ9ITYnbC9HSTYqAzcuopjQLa3iSx1m+pFA6XemWNorUJdHfAgyKxnfJc7HcAZMm+ymbi5SQUAFibT37AU7Fmo0Mub90SwAetfpw3koA8r2mkdXKrX1ZnM0bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V7zyuGgJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=10TXlJb1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V7zyuGgJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=10TXlJb1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5BB7A21295;
	Wed, 13 Aug 2025 15:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755099902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LzhjmpiRHG3vpXVa2XFcg53XYjO+rAptmOKZ1SHGM+Y=;
	b=V7zyuGgJAxlaTaQme+cPSxcPquSH0GoMxjhr2lcgTgA9RaB2IphyiNDHndceBGE7hx+Vjz
	gu7NquvxAjlXPlOEj73M8GjJBL9tSB16aYq2BAnUOOOD77K4ErqbxQrGviEtHBH1/+9WMZ
	rnmm/B8F5HaadSrLQRR1BPUkWK+oWd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755099902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LzhjmpiRHG3vpXVa2XFcg53XYjO+rAptmOKZ1SHGM+Y=;
	b=10TXlJb1I1FJao+z+4Sxac0KiDPjrFhcPPB23cCGZiKEx36kniEMe8tsL0SESzsePgGL4j
	a/iPYUluZpenptCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755099902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LzhjmpiRHG3vpXVa2XFcg53XYjO+rAptmOKZ1SHGM+Y=;
	b=V7zyuGgJAxlaTaQme+cPSxcPquSH0GoMxjhr2lcgTgA9RaB2IphyiNDHndceBGE7hx+Vjz
	gu7NquvxAjlXPlOEj73M8GjJBL9tSB16aYq2BAnUOOOD77K4ErqbxQrGviEtHBH1/+9WMZ
	rnmm/B8F5HaadSrLQRR1BPUkWK+oWd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755099902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LzhjmpiRHG3vpXVa2XFcg53XYjO+rAptmOKZ1SHGM+Y=;
	b=10TXlJb1I1FJao+z+4Sxac0KiDPjrFhcPPB23cCGZiKEx36kniEMe8tsL0SESzsePgGL4j
	a/iPYUluZpenptCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D4B513929;
	Wed, 13 Aug 2025 15:45:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 23zmBf6ynGjKBgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 13 Aug 2025 15:45:02 +0000
Date: Wed, 13 Aug 2025 17:45:01 +0200
Message-ID: <87cy8zw7ia.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Wentao Liang <vulab@iscas.ac.cn>,
	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: Improve local variable data type in snd_hda_get_num_devices()
In-Reply-To: <20250813103418.164110-2-thorsten.blum@linux.dev>
References: <20250813103418.164110-2-thorsten.blum@linux.dev>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

On Wed, 13 Aug 2025 12:34:16 +0200,
Thorsten Blum wrote:
> 
> Use 'int' instead of 'unsigned int' because the local variable 'parm'
> can be negative.
> 
> While an unsigned integer is harmless in practice due to the implicit
> type conversion, it's safer and more idiomatic to use a signed integer
> to properly check for -1.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Applied now.  Thanks.


Takashi

