Return-Path: <linux-kernel+bounces-834887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAECBA5C3E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 11:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08CC017B6F1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 09:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681372D6401;
	Sat, 27 Sep 2025 09:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iT3SLaqC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w9L8Uxfj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iT3SLaqC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w9L8Uxfj"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE4D4A21
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 09:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758964906; cv=none; b=qxPL8lybEs+6TzD7WyHVZIvNlZ2EEbzuNLZtCFyPn4v+e/gXL2hZCBrNirUZXMKbliFDj/HteBEQAFexhJqGTzhNTD9T+9rd9WopEX9ivsXED6A/MSt03QsOq/iGAm6rC3HUZq3SQTR9IUcWB5Fyo/4AxNYHawVe3/u8Wnc279k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758964906; c=relaxed/simple;
	bh=1HPEkogKgNA16iYLN1Kn1Wr+MKHXwuuWXUJpvOz3z7k=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CV3bi/nVeSwByCT+Fq9Fq27cpQgL1nYoihCBs1Sqj+phePlX3rdpMpabPdMcn4mRo+b112bw776g/06xncSdPhDfTfTOVJh3rb5ehFW2b+VxK+2AC3X9lGgNiL6dw4AUDHSys3uSWGNqumNC/G3PYgOkRtIuMi/MRgFNwZZe2pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iT3SLaqC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w9L8Uxfj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iT3SLaqC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w9L8Uxfj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 239FD247F9;
	Sat, 27 Sep 2025 09:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758964896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g0BGEeqNMtk8niqM/ncz8Cf2lO+rTybLPgHuVF39WS0=;
	b=iT3SLaqC8An7Bz4kOKpRYcgI1HkTYbQo0UQhS/+P5HKHF5h5zopc4tclChWarCBKfpD/ip
	a6IwAlDgRohxwiqT5Jl0Q+s3Ef9rYetazV9AB9QMSrBPgMjrla00ip+vfUcPnxebKxssAR
	89UrfBL3ibrUv+FAd4rlWUHL9bgM61E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758964896;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g0BGEeqNMtk8niqM/ncz8Cf2lO+rTybLPgHuVF39WS0=;
	b=w9L8UxfjUj05jZ5G8sr9pDG5wJdMLj98VFKeRPspM417VDnC6M580gCYDUYRMrNs2U1Qs2
	HQ4CPNl/qXwVyrBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iT3SLaqC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=w9L8Uxfj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758964896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g0BGEeqNMtk8niqM/ncz8Cf2lO+rTybLPgHuVF39WS0=;
	b=iT3SLaqC8An7Bz4kOKpRYcgI1HkTYbQo0UQhS/+P5HKHF5h5zopc4tclChWarCBKfpD/ip
	a6IwAlDgRohxwiqT5Jl0Q+s3Ef9rYetazV9AB9QMSrBPgMjrla00ip+vfUcPnxebKxssAR
	89UrfBL3ibrUv+FAd4rlWUHL9bgM61E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758964896;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g0BGEeqNMtk8niqM/ncz8Cf2lO+rTybLPgHuVF39WS0=;
	b=w9L8UxfjUj05jZ5G8sr9pDG5wJdMLj98VFKeRPspM417VDnC6M580gCYDUYRMrNs2U1Qs2
	HQ4CPNl/qXwVyrBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF8621373E;
	Sat, 27 Sep 2025 09:21:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r6ZjKZ+s12jISAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 27 Sep 2025 09:21:35 +0000
Date: Sat, 27 Sep 2025 11:21:35 +0200
Message-ID: <875xd4b68w.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: cryolitia@uniontech.com
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Nie Cheng <niecheng1@uniontech.com>,
	Zhan Jun <zhanjun@uniontech.com>,
	Feng Yuan <fengyuan@uniontech.com>,
	qaqland <anguoli@uniontech.com>,
	kernel@uniontech.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH v5 0/4] ALSA: usb-audio: improve module param quirk_flags
In-Reply-To: <20250925-sound-v5-0-2593586ff350@uniontech.com>
References: <20250925-sound-v5-0-2593586ff350@uniontech.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 239FD247F9
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

On Thu, 25 Sep 2025 11:25:15 +0200,
Cryolitia PukNgae via B4 Relay wrote:
> 
> As an implementation of what has been discussed previously[1].
> 
> 1. https://lore.kernel.org/all/87h5xm5g7f.wl-tiwai@suse.de/
> 
> Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>

Thanks for the new patch set.  In general the code change looks good.

But, could you provide a bit more information in the patch
description?  Ideally speaking, the patch description should suffice
to understand what's done in the commit without seeing the commit
change itself.

Also, please try to use guard() for mutex.


thanks,

Takashi

> ---
> Changes in v5:
> - Apply review comments. Thanks a lot, Takashi Iwai!
> - Link to v4: https://lore.kernel.org/r/20250918-sound-v4-0-82cf8123d61c@uniontech.com
> 
> Changes in v4:
> - Split basic parse and dynamic change
> - Drop usage of linked list
> - Link to v3: https://lore.kernel.org/r/20250917-sound-v3-0-92ebe9472a0a@uniontech.com
> 
> Changes in v3:
> - Instead of a new param, improve the existed one.
> - Link to v2: https://lore.kernel.org/r/20250912-sound-v2-0-01ea3d279f4b@uniontech.com
> 
> Changes in v2:
> - Cleaned up some internal rebase confusion, sorry for that
> - Link to v1: https://lore.kernel.org/r/20250912-sound-v1-0-cc9cfd9f2d01@uniontech.com
> 
> ---
> Cryolitia PukNgae (4):
>       ALSA: usb-audio: add two-way convert between name and bit for QUIRK_FLAG_*
>       ALSA: usb-audio: improve module param quirk_flags
>       ALSA: usb-audio: make param quirk_flags change-able in runtime
>       ALSA: doc: add docs about improved quirk_flags in snd-usb-audio
> 
>  Documentation/sound/alsa-configuration.rst | 108 +++++++++++------
>  sound/usb/card.c                           |  66 +++++++++--
>  sound/usb/quirks.c                         | 179 ++++++++++++++++++++++++++++-
>  sound/usb/quirks.h                         |  11 +-
>  sound/usb/usbaudio.h                       |  84 +++++++++-----
>  5 files changed, 376 insertions(+), 72 deletions(-)
> ---
> base-commit: 4c421c40c8b30ab7aae1edc7f7e294fcd33fc186
> change-id: 20250910-sound-a91c86c92dba
> 
> Best regards,
> -- 
> Cryolitia PukNgae <cryolitia@uniontech.com>
> 
> 

