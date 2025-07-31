Return-Path: <linux-kernel+bounces-751641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B328B16BBE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0132F3ADB33
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609DE241CAF;
	Thu, 31 Jul 2025 05:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b2MtUQZb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PnjynPx3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b2MtUQZb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PnjynPx3"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A41E1A315C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 05:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753941120; cv=none; b=fnCo59IPS/rNWCXW/dd8OhXdkzR1LBbCPlygx0Vi6lvqnJYOLsNZfsBA+fxG/5SNzAp22fBlC8bKvSfgmSV0MPw+Vi1wlIiZSjBJlJTqu2gsheScVupd53wYmsDEfFjTibYIBTVFJR/j2bPReuXJFrlLgFXGnfzaBDVTnPMyFek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753941120; c=relaxed/simple;
	bh=4iyxCJOMq/7oxqfWM+bR7G8f3KyhI8WcJu0xJy7MwZ0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GucHcVpj+dOjpXRGPOMzmLb/1/jD40sTb08ULgLtuTKAB0ThJ+jJanQEkDbdtaXg8TgkMFGGO+JBOqPoVjpukpluvAQm4GC8FKwP4lDtYr2iJbZc2jN7JqjV/vl3T799Qri4J0tsrSB7YCZmu1KBX02j77S/W4wevFzcYTsnnXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b2MtUQZb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PnjynPx3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b2MtUQZb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PnjynPx3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 77D0C21A8C;
	Thu, 31 Jul 2025 05:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753941116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z3dC4+b7eC/gHDHk2DCGYpJtzTewrOWV0zoEmeC25tk=;
	b=b2MtUQZbO3OACBzhw98scwhJwYTJB5t1OgbY8+BVHd9l0aLz4dCIOzG+cnXhBjg3aPOrxN
	t6WCMCuuA9pEdxSLTSdG6/sq2PNOtj5Qo/bTb4B+KcEeMippUOBZS1vcWgyBegldoKJ8Yy
	mbe97M7hC7Bw4IUzZSxph5YfEACiT+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753941116;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z3dC4+b7eC/gHDHk2DCGYpJtzTewrOWV0zoEmeC25tk=;
	b=PnjynPx3dLd6v42wHzLrWHols521g6KHt/Fibmsvv2Bdd9QPjvAoYpeHAQsIztEf7n3AaV
	As96Jwukym4N3WBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=b2MtUQZb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PnjynPx3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753941116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z3dC4+b7eC/gHDHk2DCGYpJtzTewrOWV0zoEmeC25tk=;
	b=b2MtUQZbO3OACBzhw98scwhJwYTJB5t1OgbY8+BVHd9l0aLz4dCIOzG+cnXhBjg3aPOrxN
	t6WCMCuuA9pEdxSLTSdG6/sq2PNOtj5Qo/bTb4B+KcEeMippUOBZS1vcWgyBegldoKJ8Yy
	mbe97M7hC7Bw4IUzZSxph5YfEACiT+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753941116;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z3dC4+b7eC/gHDHk2DCGYpJtzTewrOWV0zoEmeC25tk=;
	b=PnjynPx3dLd6v42wHzLrWHols521g6KHt/Fibmsvv2Bdd9QPjvAoYpeHAQsIztEf7n3AaV
	As96Jwukym4N3WBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E81E1378C;
	Thu, 31 Jul 2025 05:51:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IB/UBXwEi2hgUwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 31 Jul 2025 05:51:56 +0000
Date: Thu, 31 Jul 2025 07:51:55 +0200
Message-ID: <874iusucuc.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: <noble.yang@comtrue-inc.com>
Cc: "'Takashi Iwai'" <tiwai@suse.de>,
	<tiwai@suse.com>,
	<perex@perex.cz>,
	<hulianqin@vivo.com>,
	<lina+kernel@asahilina.net>,
	<cyan.vtb@gmail.com>,
	<dan.carpenter@linaro.org>,
	<bsevens@google.com>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA: usb-audio: Add DSD support for Comtrue USB Audio device
In-Reply-To: <002601dc01de$fc127db0$f4377910$@comtrue-inc.com>
References: <001e01dc01d6$cc4c64e0$64e52ea0$@comtrue-inc.com>
	<875xf8udel.wl-tiwai@suse.de>
	<002601dc01de$fc127db0$f4377910$@comtrue-inc.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=BIG5
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.de,suse.com,perex.cz,vivo.com,asahilina.net,gmail.com,linaro.org,google.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[kernel];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[perex.cz:email,reurl.cc:url,comtrue-inc.com:url,comtrue-inc.com:email,asahilina.net:email,suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,vivo.com:email,suse.com:email,linaro.org:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 77D0C21A8C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.01

On Thu, 31 Jul 2025 07:50:13 +0200,
<noble.yang@comtrue-inc.com> wrote:
> 
> Hello Takashi
> 
> Please try download it as below link
> https://reurl.cc/8951Ro

You can't submit like this style.  Please try to submit in the proper
format embedded in the email.


thanks,

Takashi

> 
> Thanks
> Noble
> 
> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de> 
> Sent: Thursday, July 31, 2025 1:40 PM
> To: noble.yang@comtrue-inc.com
> Cc: tiwai@suse.com; perex@perex.cz; hulianqin@vivo.com;
> lina+kernel@asahilina.net; cyan.vtb@gmail.com; dan.carpenter@linaro.org;
> bsevens@google.com; linux-sound@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] ALSA: usb-audio: Add DSD support for Comtrue USB Audio
> device
> 
> On Thu, 31 Jul 2025 06:51:37 +0200,
> <noble.yang@comtrue-inc.com> wrote:
> > 
> > 
> > The vendor Comtrue Inc. (0x2fc6) produces USB audio chipsets like
> > 
> > the CT7601 which are capable of Native DSD playback.
> > 
> > This patch adds QUIRK_FLAG_DSD_RAW for Comtrue (VID 0x2fc6), which 
> > enables
> > 
> > native DSD playback (DSD_U32_LE) on their USB Audio device. This has 
> > been
> > 
> > verified under Ubuntu 25.04 with JRiver.
> > 
> > Best Regards !
> 
> I see no patch in the mail.  Could you try to send via git-send-email?
> 
> 
> thanks,
> 
> Takashi
> 
> > 
> > ===========================
> > 
> > Noble Yang
> > 
> > Cell : +886-955-347822
> > 
> > 晨臻股份有限公司
> > 
> > Comtrue Inc.
> > 
> > www.comtrue-inc.com
> > 
> > 新地址 : 新竹縣竹北市縣政十街10號2F之1
> > 
> > 2F.-1, No. 10, Xianzheng 10th St., Zhubei City, Hsinchu County 302, 
> > Taiwan
> > (R.O.C.)
> > 
> > The information included in this email is privileged and confidential 
> > and just for the exclusive use of the addressee.
> > 
> > For people other than the addressee the use, disclosure and 
> > reproduction is strictly prohibited.
> > 
> > If this message has been received in error, please contact the sender 
> > and delete all copies.
> > 
> > 
> > cat /proc/asound/card*/stream0
> > Comtrue-inc Comtrue-inc UAC2 Device EVM-GB at usb-0000:00:14.0-5, high 
> > speed : USB Audio
> > 
> > Playback:
> >   Status: Stop
> >   Interface 1
> >     Altset 1
> >     Format: S16_LE
> >     Channels: 2
> >     Endpoint: 0x01 (1 OUT) (ASYNC)
> >     Rates: 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000,
> 705600, 768000
> >     Data packet interval: 125 us
> >     Bits: 16
> >     Channel map: FL FR
> >     Sync Endpoint: 0x81 (1 IN)
> >     Sync EP Interface: 1
> >     Sync EP Altset: 1
> >     Implicit Feedback Mode: No
> >   Interface 1
> >     Altset 2
> >     Format: S24_3LE
> >     Channels: 2
> >     Endpoint: 0x01 (1 OUT) (ASYNC)
> >     Rates: 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000,
> 705600, 768000
> >     Data packet interval: 125 us
> >     Bits: 24
> >     Channel map: FL FR
> >     Sync Endpoint: 0x81 (1 IN)
> >     Sync EP Interface: 1
> >     Sync EP Altset: 2
> >     Implicit Feedback Mode: No
> >   Interface 1
> >     Altset 3
> >     Format: S32_LE
> >     Channels: 2
> >     Endpoint: 0x01 (1 OUT) (ASYNC)
> >     Rates: 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000,
> 705600, 768000
> >     Data packet interval: 125 us
> >     Bits: 32
> >     Channel map: FL FR
> >     Sync Endpoint: 0x81 (1 IN)
> >     Sync EP Interface: 1
> >     Sync EP Altset: 3
> >     Implicit Feedback Mode: No
> >   Interface 1
> >     Altset 4
> >     Format: SPECIAL DSD_U32_BE
> >     Channels: 2
> >     Endpoint: 0x01 (1 OUT) (ASYNC)
> >     Rates: 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000,
> 705600, 768000
> >     Data packet interval: 125 us
> >     Bits: 32
> >     DSD raw: DOP=0, bitrev=0
> >     Channel map: FL FR
> >     Sync Endpoint: 0x81 (1 IN)
> >     Sync EP Interface: 1
> >     Sync EP Altset: 4
> >     Implicit Feedback Mode: No
> > 
> > Capture:
> >   Status: Stop
> >   Interface 2
> >     Altset 1
> >     Format: S16_LE
> >     Channels: 2
> >     Endpoint: 0x82 (2 IN) (ASYNC)
> >     Rates: 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000,
> 705600, 768000
> >     Data packet interval: 125 us
> >     Bits: 16
> >     Channel map: FL FR
> >   Interface 2
> >     Altset 2
> >     Format: S24_3LE
> >     Channels: 2
> >     Endpoint: 0x82 (2 IN) (ASYNC)
> >     Rates: 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000,
> 705600, 768000
> >     Data packet interval: 125 us
> >     Bits: 24
> >     Channel map: FL FR
> >   Interface 2
> >     Altset 3
> >     Format: S32_LE
> >     Channels: 2
> >     Endpoint: 0x82 (2 IN) (ASYNC)
> >     Rates: 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000,
> 705600, 768000
> >     Data packet interval: 125 us
> >     Bits: 32
> >     Channel map: FL FR
> >   Interface 2
> >     Altset 4
> >     Format: SPECIAL DSD_U32_BE
> >     Channels: 2
> >     Endpoint: 0x82 (2 IN) (ASYNC)
> >     Rates: 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000,
> 705600, 768000
> >     Data packet interval: 125 us
> >     Bits: 32
> >     DSD raw: DOP=0, bitrev=0
> >     Channel map: FL FR
> > 
> 
> cat /proc/asound/card*/stream0
> Comtrue-inc Comtrue-inc UAC2 Device EVM-GB at usb-0000:00:14.0-5, high speed : USB Audio
> 
> Playback:
>   Status: Stop
>   Interface 1
>     Altset 1
>     Format: S16_LE
>     Channels: 2
>     Endpoint: 0x01 (1 OUT) (ASYNC)
>     Rates: 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000, 705600, 768000
>     Data packet interval: 125 us
>     Bits: 16
>     Channel map: FL FR
>     Sync Endpoint: 0x81 (1 IN)
>     Sync EP Interface: 1
>     Sync EP Altset: 1
>     Implicit Feedback Mode: No
>   Interface 1
>     Altset 2
>     Format: S24_3LE
>     Channels: 2
>     Endpoint: 0x01 (1 OUT) (ASYNC)
>     Rates: 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000, 705600, 768000
>     Data packet interval: 125 us
>     Bits: 24
>     Channel map: FL FR
>     Sync Endpoint: 0x81 (1 IN)
>     Sync EP Interface: 1
>     Sync EP Altset: 2
>     Implicit Feedback Mode: No
>   Interface 1
>     Altset 3
>     Format: S32_LE
>     Channels: 2
>     Endpoint: 0x01 (1 OUT) (ASYNC)
>     Rates: 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000, 705600, 768000
>     Data packet interval: 125 us
>     Bits: 32
>     Channel map: FL FR
>     Sync Endpoint: 0x81 (1 IN)
>     Sync EP Interface: 1
>     Sync EP Altset: 3
>     Implicit Feedback Mode: No
>   Interface 1
>     Altset 4
>     Format: SPECIAL DSD_U32_BE
>     Channels: 2
>     Endpoint: 0x01 (1 OUT) (ASYNC)
>     Rates: 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000, 705600, 768000
>     Data packet interval: 125 us
>     Bits: 32
>     DSD raw: DOP=0, bitrev=0
>     Channel map: FL FR
>     Sync Endpoint: 0x81 (1 IN)
>     Sync EP Interface: 1
>     Sync EP Altset: 4
>     Implicit Feedback Mode: No
> 
> Capture:
>   Status: Stop
>   Interface 2
>     Altset 1
>     Format: S16_LE
>     Channels: 2
>     Endpoint: 0x82 (2 IN) (ASYNC)
>     Rates: 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000, 705600, 768000
>     Data packet interval: 125 us
>     Bits: 16
>     Channel map: FL FR
>   Interface 2
>     Altset 2
>     Format: S24_3LE
>     Channels: 2
>     Endpoint: 0x82 (2 IN) (ASYNC)
>     Rates: 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000, 705600, 768000
>     Data packet interval: 125 us
>     Bits: 24
>     Channel map: FL FR
>   Interface 2
>     Altset 3
>     Format: S32_LE
>     Channels: 2
>     Endpoint: 0x82 (2 IN) (ASYNC)
>     Rates: 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000, 705600, 768000
>     Data packet interval: 125 us
>     Bits: 32
>     Channel map: FL FR
>   Interface 2
>     Altset 4
>     Format: SPECIAL DSD_U32_BE
>     Channels: 2
>     Endpoint: 0x82 (2 IN) (ASYNC)
>     Rates: 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000, 705600, 768000
>     Data packet interval: 125 us
>     Bits: 32
>     DSD raw: DOP=0, bitrev=0
>     Channel map: FL FR
> 

