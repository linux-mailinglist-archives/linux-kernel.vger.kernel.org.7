Return-Path: <linux-kernel+bounces-738816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE43B0BD99
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 09:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 365F13A4343
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 07:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2CC2820CB;
	Mon, 21 Jul 2025 07:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YFbp2Nei";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="68fM6nDr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YFbp2Nei";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="68fM6nDr"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E9D2046A6
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 07:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753082687; cv=none; b=GpTdbpgH2s9YnvmguA1/ug3t1j0reL2htmL/jp5smW22SxzyGlzDyJvmlZnUEF59Jw851EIs4O8x5EcDm02QTIfaFm7LtbI5soyWsz92Oo1fg9ONNv2mOX4Gma0H9vuLCaWztgBVTmCROmjbUrymDTP9Yf1a4OcNEZnhmidiUEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753082687; c=relaxed/simple;
	bh=PaGk3h625+x/13cV4FfN0b3wVFTm8eyIgp2uR1qODnY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/m2/LrDE/wadWxUnG2WTqe3BUnWEscxRIDFxTFX6TOB0BgKzs38H9tTB2rXGBp0Tz7iTXXVrOoP6EEECP2BIvAJgHpxPACXy1BqcQaRDGpEnh1fJtBH3uOWpRwrytvpaIPgv1LsL7o1zrBXo2fnSIK09OxGo6vAKT5okicRrg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YFbp2Nei; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=68fM6nDr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YFbp2Nei; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=68fM6nDr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C1C581F453;
	Mon, 21 Jul 2025 07:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753082677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=glnE2PpY1lMHyHLtzV2WYcGDdz+bQLmmEGM8dshSHXM=;
	b=YFbp2NeiaDSu+I4KXHbF2zpKg/KlnTjQesmxY+4Wa4rnNyd6T9yeacQULz7oHbYfvdQYJy
	2dCWDm6tcMEXfmom7SsVXcDarwa6HOhT3XQIJO+BwXK9N+14fXvkwWzB7S835RExjeT5NI
	A5g02/H/kUUWUD7ZIBs4RQIfSLneX3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753082677;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=glnE2PpY1lMHyHLtzV2WYcGDdz+bQLmmEGM8dshSHXM=;
	b=68fM6nDr0DaiWzYfj44TDhWqcnk6u4bxqa9yiEr0uim2WS26akERDOoNCAspMpLdaAkKPz
	V1swFwyDrFOKA9Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YFbp2Nei;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=68fM6nDr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753082677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=glnE2PpY1lMHyHLtzV2WYcGDdz+bQLmmEGM8dshSHXM=;
	b=YFbp2NeiaDSu+I4KXHbF2zpKg/KlnTjQesmxY+4Wa4rnNyd6T9yeacQULz7oHbYfvdQYJy
	2dCWDm6tcMEXfmom7SsVXcDarwa6HOhT3XQIJO+BwXK9N+14fXvkwWzB7S835RExjeT5NI
	A5g02/H/kUUWUD7ZIBs4RQIfSLneX3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753082677;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=glnE2PpY1lMHyHLtzV2WYcGDdz+bQLmmEGM8dshSHXM=;
	b=68fM6nDr0DaiWzYfj44TDhWqcnk6u4bxqa9yiEr0uim2WS26akERDOoNCAspMpLdaAkKPz
	V1swFwyDrFOKA9Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 980C2136A8;
	Mon, 21 Jul 2025 07:24:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WsDwIzXrfWh9XQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 21 Jul 2025 07:24:37 +0000
Date: Mon, 21 Jul 2025 09:24:37 +0200
Message-ID: <878qki57m2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Dawid Rezler <dawidrezler.patches@gmail.com>
Cc: tiwai@suse.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek - Add mute LED support for HP Pavilion 15-eg0xxx
In-Reply-To: <20250720154907.80815-2-dawidrezler.patches@gmail.com>
References: <20250720154907.80815-2-dawidrezler.patches@gmail.com>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: C1C581F453
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.01

On Sun, 20 Jul 2025 17:49:08 +0200,
Dawid Rezler wrote:
> 
> The mute LED on the HP Pavilion Laptop 15-eg0xxx,
> which uses the ALC287 codec, didn't work.
> This patch fixes the issue by enabling the ALC287_FIXUP_HP_GPIO_LED quirk.
> 
> Tested on a physical device, the LED now works as intended.
> 
> Signed-off-by: Dawid Rezler <dawidrezler.patches@gmail.com>

Applied now.  Thanks.


Takashi

