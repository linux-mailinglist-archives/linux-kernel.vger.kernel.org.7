Return-Path: <linux-kernel+bounces-751856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EC0B16E4A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCADC1C20480
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAFD291C19;
	Thu, 31 Jul 2025 09:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="138KwVsK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EKmsLEw+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="138KwVsK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EKmsLEw+"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834E217BD3
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753953355; cv=none; b=LeDSOSp8AGwD+CAnO88tppD6rhNdaJRSbVWpqyoie89NRQEHjMjVw66oKgkfjIolHINkltlTi0RENyskix71ZRWKDRLu2KdYHJllJklcS3USr0wVRA1bLX+LCGy0wPB61Nw+x53TVNt91Xdn3N9pUuhW+Gu5Y8S+9t4W7hcRr4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753953355; c=relaxed/simple;
	bh=aEcQB/Jc4SBPMbMZcq5iyveSi2+v29OSIGGyYIE7CsY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fDIHr6CrDlHtBQjIZlRe3HMG7rotsJVWPNOFeEr+YzLwBxVJLa7MAp2hvR7jhjff22aCCCvCQtCVwl/x3GgsnDzJ8yusVXIW1ePaUqg1BLj3Knefx+yuj4u7FbTWaM7zKPtQJhMODwuzz3brhIGJI8JKQX+2oXgqPRhgHLFwo6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=138KwVsK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EKmsLEw+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=138KwVsK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EKmsLEw+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B950F21207;
	Thu, 31 Jul 2025 09:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753953351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hqt/14zHFN/2dJkoQfIcLfzi/Yt2gslHinKrfpwzWV0=;
	b=138KwVsKfJiZwZ8s2zsNO2fdXVXfuAjhGe2ArtY1quaCHwhI9W8nNleY9aZOjjXikhvQ8J
	/rOscRzvpqPkYQo4L2xoGkgnuK5JOBERZxIRY7F4r2euuY4iOiivDDv23tva+gKvn92klo
	R5zrFN3fMxRcrCHIN46bqO33yRt5cYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753953351;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hqt/14zHFN/2dJkoQfIcLfzi/Yt2gslHinKrfpwzWV0=;
	b=EKmsLEw+AI5qxQSIzw96SDQU56Qrb2YB6z8ZjYIZBUQ2MIc+JrJqjOHXesxWRE9cEEjwuA
	vj2aDS4wrvubv1BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753953351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hqt/14zHFN/2dJkoQfIcLfzi/Yt2gslHinKrfpwzWV0=;
	b=138KwVsKfJiZwZ8s2zsNO2fdXVXfuAjhGe2ArtY1quaCHwhI9W8nNleY9aZOjjXikhvQ8J
	/rOscRzvpqPkYQo4L2xoGkgnuK5JOBERZxIRY7F4r2euuY4iOiivDDv23tva+gKvn92klo
	R5zrFN3fMxRcrCHIN46bqO33yRt5cYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753953351;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hqt/14zHFN/2dJkoQfIcLfzi/Yt2gslHinKrfpwzWV0=;
	b=EKmsLEw+AI5qxQSIzw96SDQU56Qrb2YB6z8ZjYIZBUQ2MIc+JrJqjOHXesxWRE9cEEjwuA
	vj2aDS4wrvubv1BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FD9313876;
	Thu, 31 Jul 2025 09:15:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d6sXGkc0i2icFwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 31 Jul 2025 09:15:51 +0000
Date: Thu, 31 Jul 2025 11:15:51 +0200
Message-ID: <87cy9gsou0.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: noble228@gmail.com
Cc: tiwai@suse.com,
	perex@perex.cz,
	hulianqin@vivo.com,
	lina+kernel@asahilina.net,
	cyan.vtb@gmail.com,
	dan.carpenter@linaro.org,
	bsevens@google.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"noble.yang" <noble.yang@comtrue-inc.com>
Subject: Re: [PATCH] ALSA: usb-audio: Add DSD support for Comtrue USB Audio device
In-Reply-To: <20250731081559.10842-1-noble228@gmail.com>
References: <20250731081559.10842-1-noble228@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.com,perex.cz,vivo.com,asahilina.net,gmail.com,linaro.org,google.com,vger.kernel.org,comtrue-inc.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[kernel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -1.80

On Thu, 31 Jul 2025 10:15:59 +0200,
noble228@gmail.com wrote:
> 
> From: "noble.yang" <noble.yang@comtrue-inc.com>
> 

Could you fill the patch description?  You already wrote enough
information in the original post, and put the text here.

> --- a/sound/usb/quirks.c
> +++ b/sound/usb/quirks.c
> @@ -2408,6 +2408,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
>  		   QUIRK_FLAG_DSD_RAW),
>  	VENDOR_FLG(0x2d87, /* Cayin device */
>  		   QUIRK_FLAG_DSD_RAW),
> +        VENDOR_FLG(0x2fc6, /* Comture-inc devices */

The indentation doesn't look right.  Try to use tabs.


thanks,

Takashi

