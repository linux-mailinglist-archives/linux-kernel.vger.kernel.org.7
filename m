Return-Path: <linux-kernel+bounces-764141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04474B21E84
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2C3F1A272DC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 06:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488F42D6E5F;
	Tue, 12 Aug 2025 06:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="g6prJ0ft";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lnSDHn7g";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="g6prJ0ft";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lnSDHn7g"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3EF1A9FAD
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754981006; cv=none; b=M5Zi1clmKzW/3Yddhw+zg9/dQM3cdkclXuO3yqrdJtvJB+ZzYBky3w8/QJQ3J11jSG5RTJngSnnlsrMblYxK6gx6+FAH6Dmgrkb9Pwt7Ouas1LaP3ishMAYtSGNpZIXSHJhqkVj8bWibcqmqdqAp6/V13oQdujW54wrOb9JS0tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754981006; c=relaxed/simple;
	bh=TQl2TPYu7KnlQ2D9x5rVcoRtynF25Gop0WSSzxunoms=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YMoC/MO3hVpWrLFJRwurmxTOq1EpiGulPfl29yZVfdUtf+2IAsYi+ErDqW8sBNPabjHIYAHJLFM29TQrN8fV0on7mu0gjYlrMVwsUvun54VFkmjLHx1YzC0gav5vyNOmNsU544XqXSCDwinJduyjP4p/NjwHARdABnjDCQa7/nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=g6prJ0ft; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lnSDHn7g; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=g6prJ0ft; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lnSDHn7g; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A123E219F5;
	Tue, 12 Aug 2025 06:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754981002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OU9B9fNQG2MGtM/gkUEPnE1wDz2NkzWTy2UYMxGIbXM=;
	b=g6prJ0ftfU0FguocXpstFV0DUufy1elMqpJgFgmF/hB/ObjuhxhmrZuMF1jwOozjDl+Sid
	D41CXr02eltV8ngLiWPFQfePze78Dtcbw0q118ZhXthZIoki1LPIfYeRDBEc+UN1kR8p1c
	6lwVqITg3/MPyZ3wWzsQ3PAs5PeA3B4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754981002;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OU9B9fNQG2MGtM/gkUEPnE1wDz2NkzWTy2UYMxGIbXM=;
	b=lnSDHn7gqrWQSoqG0dbhUQRv9DKw6LuD1dp8ZgHqdN7nM1Z+kiBzr7KniWgkIzKrFfLT8D
	PWL67bJ/UeDKSgDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754981002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OU9B9fNQG2MGtM/gkUEPnE1wDz2NkzWTy2UYMxGIbXM=;
	b=g6prJ0ftfU0FguocXpstFV0DUufy1elMqpJgFgmF/hB/ObjuhxhmrZuMF1jwOozjDl+Sid
	D41CXr02eltV8ngLiWPFQfePze78Dtcbw0q118ZhXthZIoki1LPIfYeRDBEc+UN1kR8p1c
	6lwVqITg3/MPyZ3wWzsQ3PAs5PeA3B4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754981002;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OU9B9fNQG2MGtM/gkUEPnE1wDz2NkzWTy2UYMxGIbXM=;
	b=lnSDHn7gqrWQSoqG0dbhUQRv9DKw6LuD1dp8ZgHqdN7nM1Z+kiBzr7KniWgkIzKrFfLT8D
	PWL67bJ/UeDKSgDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 759361351A;
	Tue, 12 Aug 2025 06:43:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nZuCG4rimmiqSgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 12 Aug 2025 06:43:22 +0000
Date: Tue, 12 Aug 2025 08:43:22 +0200
Message-ID: <87tt2dyr91.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-2?Q?=A9erif?= Rami <ramiserifpersia@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] ALSA: usb-audio: us144mkii: Add PCM core infrastructure
In-Reply-To: <20250810124958.25309-3-ramiserifpersia@gmail.com>
References: <20250810124958.25309-1-ramiserifpersia@gmail.com>
	<20250810124958.25309-3-ramiserifpersia@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

On Sun, 10 Aug 2025 14:49:53 +0200,
©erif Rami wrote:
> 
> --- a/sound/usb/usx2y/us144mkii.h
> +++ b/sound/usb/usx2y/us144mkii.h
> @@ -1,38 +1,75 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  // Copyright (c) 2025 ©erif Rami <ramiserifpersia@gmail.com>
>  
> - #ifndef __US144MKII_H
> - #define __US144MKII_H
> +#ifndef __US144MKII_H
> +#define __US144MKII_H
>  
> - #include <linux/usb.h>
> - #include <sound/core.h>
> - #include <sound/initval.h>
> +#include <linux/usb.h>
> +#include <sound/core.h>
> +#include <sound/initval.h>
> +#include <sound/pcm.h>
>  
> - #define DRIVER_NAME "us144mkii"
> +#define DRIVER_NAME "us144mkii"
>  
>  /* --- USB Device Identification --- */
> - #define USB_VID_TASCAM 0x0644
> - #define USB_PID_TASCAM_US144 0x800f
> - #define USB_PID_TASCAM_US144MKII 0x8020
> +#define USB_VID_TASCAM 0x0644
> +#define USB_PID_TASCAM_US144 0x800f
> +#define USB_PID_TASCAM_US144MKII 0x8020

Another unneeded indentation changes.  Please fix in the first patch.
(Also for the rest.)


thanks,

Takashi

