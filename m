Return-Path: <linux-kernel+bounces-891426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7830C42A40
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 10:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56DFC188E0C5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 09:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2279F2E8E0C;
	Sat,  8 Nov 2025 09:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CY3ha9VX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jsmD3O/8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CY3ha9VX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jsmD3O/8"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF3127A10F
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 09:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762593668; cv=none; b=LDYIBJl4tJ+ahQ4qrsUhOgh6I6V52W30Wq1jN3iwW0brfvHfVT2jChLor09ZmywI8c1DPQU+i8MK1lvePypIOBCQOyemOCJ61ycp/+s2GISA96UJHH2hzpmlo7SJmuiQv46R1ZXrEjzKjFQXXlXa/q4M6HUZIAvNnoPrKYNnSbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762593668; c=relaxed/simple;
	bh=Uy88C2SjCJIfR3cAecLbezrw6l1/UAhwh6dkqi+2uQA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HmdehaXCXalhlkEDE5DXHOWr+dP4iD1nAT9TpvWhWjNTbSpIQTvlaD9TcDZm2dYu3kJb1fSzTKSe8s3GM5Ehgwc74SZDXRv2IvfaRO1H6HxOse0sbIPRH5dtkWn+tun06aTNghg1YMbyDfhx2v+fIozwrupyOFp+mX3bkC0LJgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CY3ha9VX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jsmD3O/8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CY3ha9VX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jsmD3O/8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 911DF22ADA;
	Sat,  8 Nov 2025 09:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762593662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LVmypjStJF0wHHSdM4fOxIQ0UmCqsal7qteIjbv1mxs=;
	b=CY3ha9VX2Kh2K0aKBXcW/g8Z1Nv027J7osiji+OZizvLEbr3ZU2VZv8L7TUk7C/rrIUgf4
	xkyEygRQifDPagvdtEt66D6SVHphsp8tiidn8kxvabVUupwowL8cZI0JxQ14kWXp4p+/oS
	dE0+xF2d/nDD1L9PAif6wvUSx1cVQaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762593662;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LVmypjStJF0wHHSdM4fOxIQ0UmCqsal7qteIjbv1mxs=;
	b=jsmD3O/8DSoANAAhzkJpH4PMCYSILIraPkn1/AJkj1B3WhR44zpv04rQrbVCulmTJsGKWP
	FWgpqMS78VoGyiDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CY3ha9VX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="jsmD3O/8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762593662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LVmypjStJF0wHHSdM4fOxIQ0UmCqsal7qteIjbv1mxs=;
	b=CY3ha9VX2Kh2K0aKBXcW/g8Z1Nv027J7osiji+OZizvLEbr3ZU2VZv8L7TUk7C/rrIUgf4
	xkyEygRQifDPagvdtEt66D6SVHphsp8tiidn8kxvabVUupwowL8cZI0JxQ14kWXp4p+/oS
	dE0+xF2d/nDD1L9PAif6wvUSx1cVQaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762593662;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LVmypjStJF0wHHSdM4fOxIQ0UmCqsal7qteIjbv1mxs=;
	b=jsmD3O/8DSoANAAhzkJpH4PMCYSILIraPkn1/AJkj1B3WhR44zpv04rQrbVCulmTJsGKWP
	FWgpqMS78VoGyiDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F49C132DD;
	Sat,  8 Nov 2025 09:21:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YXZ3EX4LD2krQAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 08 Nov 2025 09:21:02 +0000
Date: Sat, 08 Nov 2025 10:21:01 +0100
Message-ID: <874ir4ribm.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound <linux-sound@vger.kernel.org>,
	wtaymans@redhat.com,
	arun@asymptotic.io,
	Jaroslav Kysela <perex@perex.cz>,
	lkml <linux-kernel@vger.kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: DP/HDMI Jack and Pipewire
In-Reply-To: <76b8ca1d-040b-472e-9804-5c0c0100b5b5@oss.qualcomm.com>
References: <76b8ca1d-040b-472e-9804-5c0c0100b5b5@oss.qualcomm.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 911DF22ADA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 

On Fri, 07 Nov 2025 11:15:50 +0100,
Srinivas Kandagatla wrote:
> 
> Hi Everyone,
> 
> On Qualcomm platforms we have an issue enabling Display port on a full
> Distro setup with pipewire and wireplumber in place.
> 
> The issue is that Display port Audio IP on Qualcomm SoC is powered off
> if there is no Display connected. It make sense to keep it in this low
> power mode when there is no use. And the DP IP is not expecting any data
> in this state and any attempt to configure or send data would result in
> error from DSP.
> 
> However, we create PCM devices and jacks for all audio sinks and
> sources, including DisplayPort DAI links. When PipeWire starts up
> without any awareness of jack state it probes all available PCM devices,
> including the DisplayPort ones. Since no display is connected, the
> prepare callback for DP fails, leading PipeWire to mark the sound card
> as unusable. Consequently, it abandons entire sound card, including
> other valid audio sinks. I have also started discussing this issue with
> pipewire [1]
> 
> 
> What is the expected pcm device behavior when DP jack is not connected?
> 
> Two possibilities:
> 
> 1. Consume the data even when the Display is not connected. I see that
> in Intel case it sinks the data somewhere and gives the user an
> experience that the data is getting consumed.
> 
> 2. Throw an error to user if they attempt to configure or send the data
> to this disconnected pcm.
> 
> 
> Also what userspace ABI to for such usecase?
> 
> This is blocking end-to-end DP audio enablement on Qualcomm SoCs.
> 
> Not sure if this is right approach or will work but somehow we back the
> pcm devices with disconnected jack state to use dummy pcm ops instead of
> actual pcm ops?
> This should at least keep the pipewire happy. Is this the right approach?
> 
> 
> [1]: https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/4938
> 
> Thanks,
> Srini

I believe this has been a long-standing problem even for HD-audio.
The HD-audio HDMI driver does open and process without actual pin
setup for allowing the probe by PA/PW with the assumption of some
basic PCM parameters.  It was introduced in the commit
42b2987079eca0238b576c08af1144ed5bd52188
    ALSA: hda - hdmi playback without monitor in dynamic pcm bind mode

So I find using a dummy ops would make sense (assuming it's actually
enough to convince PA/PW).


thanks,

Takashi

