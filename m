Return-Path: <linux-kernel+bounces-751890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7D2B16ECF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B43DA5A4307
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD352BDC03;
	Thu, 31 Jul 2025 09:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LRVzrQor";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2MWOH+UT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LRVzrQor";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2MWOH+UT"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE77022331C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753954818; cv=none; b=fghRszqOSSbCukRiDTbV+nxlqtoFxgw8QQZJeinBlCCvIXDkIpit8wRhuie2AIKV8f3BSp1LKxmOGU/vC1uYn7Oq9xKs9PtToT0ZYYNBKk8p/HwCIrKisjc4ox7SNalITRntuDrtxZQVJ/jtIFFntLwx90XsflnARLKzUmTC0iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753954818; c=relaxed/simple;
	bh=sLifnOl/GbOVPT4IF6hza70g8xjhqjbIx2M8RCtZK04=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JRvuUjdPVd63tAC2vdmB/9LmSR1FdAN9OL5zYxWTQnMM30HLuFy3TO0ZDhFQTglaq52Cbq4x19GG9vcQoB7MREOqwf7WLwxfHuthsM7Ubhp8jMVYWkaNWa0WqtpH2KFbhV+pteF1/1yVF/Udvqxgju+xaYyZ/fpWpiTkNMSIXMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LRVzrQor; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2MWOH+UT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LRVzrQor; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2MWOH+UT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3BAC21F399;
	Thu, 31 Jul 2025 09:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753954808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZF49dnsCt4KAlTrf6s5AmrYnfBm9cKAIsmwUN0yhEK8=;
	b=LRVzrQorMve0cj9i1RvaWc5Pz9VIAhklv851soMaRQeYTcPWEq+6dDBky8Ux/MwLq9Qpdf
	Ao97X3Yr8/zAXKv9Eujiuv7roT3hSrvF+3PjPlRllWjj/8hau0CzCR8qKZWloI1yLioKMk
	JVeFDNXW/yATwa86xOrH4XPiL6AFH0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753954808;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZF49dnsCt4KAlTrf6s5AmrYnfBm9cKAIsmwUN0yhEK8=;
	b=2MWOH+UTMO70oSYZjf6Z2iMjYOJG1O4C64XzeG2X474SsCPUW+2Chf+nePiFTtKH0WpHhE
	Zq9C1kUQBlrmCsCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753954808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZF49dnsCt4KAlTrf6s5AmrYnfBm9cKAIsmwUN0yhEK8=;
	b=LRVzrQorMve0cj9i1RvaWc5Pz9VIAhklv851soMaRQeYTcPWEq+6dDBky8Ux/MwLq9Qpdf
	Ao97X3Yr8/zAXKv9Eujiuv7roT3hSrvF+3PjPlRllWjj/8hau0CzCR8qKZWloI1yLioKMk
	JVeFDNXW/yATwa86xOrH4XPiL6AFH0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753954808;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZF49dnsCt4KAlTrf6s5AmrYnfBm9cKAIsmwUN0yhEK8=;
	b=2MWOH+UTMO70oSYZjf6Z2iMjYOJG1O4C64XzeG2X474SsCPUW+2Chf+nePiFTtKH0WpHhE
	Zq9C1kUQBlrmCsCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1395013A43;
	Thu, 31 Jul 2025 09:40:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1bJwA/g5i2hnIAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 31 Jul 2025 09:40:08 +0000
Date: Thu, 31 Jul 2025 11:40:07 +0200
Message-ID: <878qk4snpk.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: Re: [PATCH v2 2/3] LoongArch: Update HD-audio codec configs
In-Reply-To: <CAAhV-H6uDytXrsWv43uxNic9PH=ed1M3=29LTqCoYxzNdESkfw@mail.gmail.com>
References: <20250731091109.16901-1-tiwai@suse.de>
	<20250731091109.16901-3-tiwai@suse.de>
	<CAAhV-H6uDytXrsWv43uxNic9PH=ed1M3=29LTqCoYxzNdESkfw@mail.gmail.com>
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
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,linux.dev:email]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Thu, 31 Jul 2025 11:33:38 +0200,
Huacai Chen wrote:
> 
> On Thu, Jul 31, 2025 at 5:11 PM Takashi Iwai <tiwai@suse.de> wrote:
> >
> > The HD-audio codec driver configs have been updated again the drivers
> > got split with different kconfigs.
> I'm sorry for making noise, but is SND_HDA_INTEL_HDMI_SILENT_STREAM
> needed for common use? If yes, I also prefer it be enabled.

It's better to be disabled, IMO.
(And this config hasn't been changed at all.) 


Takashi

> 
> Huacai
> 
> >
> > Enable all Realtek HD-audio codecs and HDMI codecs (except for
> > NVIDIA_MCP and TEGRA) per request.
> >
> > Fixes: 1d8dd982c409 ("ALSA: hda/realtek: Enable drivers as default")
> > Fixes: 81231ad173d8 ("ALSA: hda/hdmi: Enable drivers as default")
> > Cc: loongarch@lists.linux.dev
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > ---
> > v1->v2: enable all Realtek codecs and most of HDMI codecs
> >
> > The changes are only in sound.git tree, so I'll pick up this there, too
> >
> >  arch/loongarch/configs/loongson3_defconfig | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
> > index 0d59af6007b7..7993020ffebb 100644
> > --- a/arch/loongarch/configs/loongson3_defconfig
> > +++ b/arch/loongarch/configs/loongson3_defconfig
> > @@ -784,8 +784,23 @@ CONFIG_SND_HDA_HWDEP=y
> >  CONFIG_SND_HDA_INPUT_BEEP=y
> >  CONFIG_SND_HDA_PATCH_LOADER=y
> >  CONFIG_SND_HDA_CODEC_REALTEK=y
> > +CONFIG_SND_HDA_CODEC_REALTEK_LIB=y
> > +CONFIG_SND_HDA_CODEC_ALC260=y
> > +CONFIG_SND_HDA_CODEC_ALC262=y
> > +CONFIG_SND_HDA_CODEC_ALC268=y
> > +CONFIG_SND_HDA_CODEC_ALC269=y
> > +CONFIG_SND_HDA_CODEC_ALC662=y
> > +CONFIG_SND_HDA_CODEC_ALC680=y
> > +CONFIG_SND_HDA_CODEC_ALC861=y
> > +CONFIG_SND_HDA_CODEC_ALC861VD=y
> > +CONFIG_SND_HDA_CODEC_ALC880=y
> > +CONFIG_SND_HDA_CODEC_ALC882=y
> >  CONFIG_SND_HDA_CODEC_SIGMATEL=y
> >  CONFIG_SND_HDA_CODEC_HDMI=y
> > +CONFIG_SND_HDA_CODEC_HDMI_GENERIC=y
> > +CONFIG_SND_HDA_CODEC_HDMI_INTEL=y
> > +CONFIG_SND_HDA_CODEC_HDMI_ATI=y
> > +CONFIG_SND_HDA_CODEC_HDMI_NVIDIA=y
> >  CONFIG_SND_HDA_CODEC_CONEXANT=y
> >  CONFIG_SND_USB_AUDIO=m
> >  CONFIG_SND_SOC=m
> > --
> > 2.50.1
> >
> >

