Return-Path: <linux-kernel+bounces-891914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A30C43CDD
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 12:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 535DC3A9BCA
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 11:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220DC2DC771;
	Sun,  9 Nov 2025 11:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="sKpESS/T"
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E0E13D891;
	Sun,  9 Nov 2025 11:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.48.224.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762689081; cv=none; b=UBgHfaTomPZAf5KctfHOwqoQV/VYOfdg2924i4pbLQ8pIQbIqb2FiQItUmU3ZaVcn80ejEwOmk2GtRaVQxZGe2mL3bcGBAYqgJBWHIEm33C4lIFAf+WpRBjCbm0HhsbZun/IY3lp+8xRwp56lTJqCQqK9/wbq4pBM+dJFGqyAFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762689081; c=relaxed/simple;
	bh=WG0dH/owgOQ4c26KQScqRuUd23YnK1gkJO/TEHSp4Lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EFtNFAayA3jbUaVT8XdtpzhtLHFwGeP0CUcTiP10cVBnrE0nfK0LU3+hNxsa/a8el2m/0Ki/V/P7y4gb5VmvE+lOiTw9MO1p1GP8gfz92UQXy3vMD0INckUp81G811EYJlz74CaZ4K5wbKxQxjSo/T4weGSlVZ3Q72dwpCQRyGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=perex.cz; spf=pass smtp.mailfrom=perex.cz; dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b=sKpESS/T; arc=none smtp.client-ip=77.48.224.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=perex.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perex.cz
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id D78386B94;
	Sun,  9 Nov 2025 12:43:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz D78386B94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1762688598; bh=5cc1L2c43uj+L5WXXlPh7HDtuw9FuYeh8taNlYWqHoM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sKpESS/TF1E6wBA+NsFe+nVoqLTI48qyzZ4IYFIUzUha/Vdh1Y+XIA+BDMmz3Wq8p
	 TklSmUSwEjFeT+oiUZ/p7iZ07GunrONjRXUXWEcc1+0O1WyuCV/Ljsb1Gf31sEzP1Z
	 Oo+u6FPmSdNYE05gmJP7c8jDW6HtoFu8QTt5mLS0=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Sun,  9 Nov 2025 12:43:08 +0100 (CET)
Message-ID: <a86b51fa-20c0-4ba0-a3b8-c8ac9cd3b433@perex.cz>
Date: Sun, 9 Nov 2025 12:43:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: DP/HDMI Jack and Pipewire
To: Takashi Iwai <tiwai@suse.de>,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 linux-sound <linux-sound@vger.kernel.org>, wtaymans@redhat.com,
 arun@asymptotic.io, lkml <linux-kernel@vger.kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <76b8ca1d-040b-472e-9804-5c0c0100b5b5@oss.qualcomm.com>
 <874ir4ribm.wl-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
Content-Language: en-US
Autocrypt: addr=perex@perex.cz; keydata=
 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
In-Reply-To: <874ir4ribm.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/8/25 10:21, Takashi Iwai wrote:
> On Fri, 07 Nov 2025 11:15:50 +0100,
> Srinivas Kandagatla wrote:
>>
>> Hi Everyone,
>>
>> On Qualcomm platforms we have an issue enabling Display port on a full
>> Distro setup with pipewire and wireplumber in place.
>>
>> The issue is that Display port Audio IP on Qualcomm SoC is powered off
>> if there is no Display connected. It make sense to keep it in this low
>> power mode when there is no use. And the DP IP is not expecting any data
>> in this state and any attempt to configure or send data would result in
>> error from DSP.
>>
>> However, we create PCM devices and jacks for all audio sinks and
>> sources, including DisplayPort DAI links. When PipeWire starts up
>> without any awareness of jack state it probes all available PCM devices,
>> including the DisplayPort ones. Since no display is connected, the
>> prepare callback for DP fails, leading PipeWire to mark the sound card
>> as unusable. Consequently, it abandons entire sound card, including
>> other valid audio sinks. I have also started discussing this issue with
>> pipewire [1]
>>
>>
>> What is the expected pcm device behavior when DP jack is not connected?
>>
>> Two possibilities:
>>
>> 1. Consume the data even when the Display is not connected. I see that
>> in Intel case it sinks the data somewhere and gives the user an
>> experience that the data is getting consumed.
>>
>> 2. Throw an error to user if they attempt to configure or send the data
>> to this disconnected pcm.
>>
>>
>> Also what userspace ABI to for such usecase?
>>
>> This is blocking end-to-end DP audio enablement on Qualcomm SoCs.
>>
>> Not sure if this is right approach or will work but somehow we back the
>> pcm devices with disconnected jack state to use dummy pcm ops instead of
>> actual pcm ops?
>> This should at least keep the pipewire happy. Is this the right approach?
>>
>>
>> [1]: https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/4938
>>
>> Thanks,
>> Srini
> 
> I believe this has been a long-standing problem even for HD-audio.
> The HD-audio HDMI driver does open and process without actual pin
> setup for allowing the probe by PA/PW with the assumption of some
> basic PCM parameters.  It was introduced in the commit
> 42b2987079eca0238b576c08af1144ed5bd52188
>      ALSA: hda - hdmi playback without monitor in dynamic pcm bind mode
> 
> So I find using a dummy ops would make sense (assuming it's actually
> enough to convince PA/PW).

Or the pipewire/pulseaudio should not go beyond SNDRV_PCM_STATE_SETUP for 
probing and just do enumeration using hw parameters given from the driver. At 
least for UCM, the devices should be defined properly. PW/PA should allow open 
only when the associated Jack control signalized the availability of the PCM 
device.

IMHO it's not reponsibility for the kernel driver to accept such incorrect 
scenarios. The PCM API is straight for this.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

