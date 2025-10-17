Return-Path: <linux-kernel+bounces-857702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21922BE7C73
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 189981884B7B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7CB2D73A1;
	Fri, 17 Oct 2025 09:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=murena.io header.i=@murena.io header.b="IAcslZ3e"
Received: from mail2.ecloud.global (mail2.ecloud.global [135.181.6.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BF024678C;
	Fri, 17 Oct 2025 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=135.181.6.248
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760692771; cv=pass; b=E9Uq0K4l09hDhhihQCA+OpyOlL3qiglgcU9HROzoJ/qNqn2dKDX+TKGeI+LzJsg7rkKvy2SYcpWXTepegq5EPTMOgDF3GORrYyX7ytgffNSMtKmRPX0qB1vni3SnAs6/bUj/ZB6gPGHZyPp6LouWzcyT6+woY9Fp+tIuMvvZ7RQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760692771; c=relaxed/simple;
	bh=+MdvQn0r7wPN0gAdaUvlXtTJ23ETMzQllzx0ZT+N8IU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E1LXCdDc321HXTYXVezfEtsGa+yezsnyqK4727VevlWK4rHMIFkz0d5usvIBJoLI3BrIGJ1nAKgcrsAfpm3zdWJmt+S9R2A2axJVHXFTMgPuMKXHNhn7dIDuLNeAeSyb8xI/nBU0taKd6DGkJBBSK+VtcGhAesD0H5QSiBSKwfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=murena.io; spf=pass smtp.mailfrom=murena.io; dkim=pass (1024-bit key) header.d=murena.io header.i=@murena.io header.b=IAcslZ3e; arc=pass smtp.client-ip=135.181.6.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=murena.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=murena.io
Received: from authenticated-user (mail2.ecloud.global [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail2.ecloud.global (Postfix) with ESMTPSA id 223E2720BA2;
	Fri, 17 Oct 2025 09:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=murena.io; s=mail2;
	t=1760692763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f9WUAUwdDcfIz24VKFjBPQuU3/34kcMzU6Efs904sLA=;
	b=IAcslZ3eI216ng359HSpCdLh1KGoCMoFu155xdibUE+QtoZVaBS++0KJruWv6F4VxyoHuU
	ADyqN8gFBBbLkqmlcdLw5RqIFNDy+uIo5tjcCR6I5iKXyyCspdyTVD1JkCEK9Td40OAN8R
	riZhSqm2Hjfs8U9zoAF+SHHoBRFErwE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=murena.io;
	s=mail2; t=1760692763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f9WUAUwdDcfIz24VKFjBPQuU3/34kcMzU6Efs904sLA=;
	b=l2kmcn3LKIPL0J0ZBlPWnYcLUOk3jvxKyV3rRndWr8mf5IULb4J6urfIju5TvDDj+O11ri
	FVfy05Di2oDnPuHEfAiNRaXXoGw2WDs415CigosAXMn9XBcZnfBECuqYbNuEItYwJ772Ao
	z+zcRqIwr3XOlpP58cAsJRo98UAGdbg=
ARC-Seal: i=1; s=mail2; d=murena.io; t=1760692763; a=rsa-sha256; cv=none;
	b=YoxRgvVsvCNylnu8Zz4E5kvP6dmE2gSA/e+1Wduz5JkG+zJ0Ks969ugSua8f5T2KJjgaqm
	UoJwhm6WByJnEWemoMYgvLFqOd+ls4Ul+5Urto4wMEtuw18/8BnC4qNakznN9D212IYRGB
	wa5cF2gzYGT90OIt4+NNTwWSVNwG6tc=
ARC-Authentication-Results: i=1;
	mail2.ecloud.global;
	auth=pass smtp.mailfrom=maud_spierings@murena.io
Message-ID: <392dc6d7-a0e5-4f9e-85c4-8d811777a697@murena.io>
Date: Fri, 17 Oct 2025 11:19:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v8 2/2] MAINTAINERS: Add entry for Innosilicon hdmi bridge
 library
To: Andy Yan <andyshrk@163.com>
Cc: Laurent.pinchart@ideasonboard.com, andrzej.hajda@intel.com,
 andy.yan@rock-chips.com, devicetree@vger.kernel.org,
 dmitry.baryshkov@oss.qualcomm.com, dri-devel@lists.freedesktop.org,
 heiko@sntech.de, jernej.skrabec@gmail.com, jonas@kwiboo.se,
 knaerzche@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 neil.armstrong@linaro.org, rfoss@kernel.org, simona@ffwll.ch,
 tzimmermann@suse.de
References: <20251016083843.76675-3-andyshrk@163.com>
 <040d8fe8-da2f-4aa5-a2c3-1aec0cf2e8f0@murena.io>
 <671fc19.84e3.199f162a66c.Coremail.andyshrk@163.com>
Content-Language: en-US
From: Maud Spierings <maud_spierings@murena.io>
In-Reply-To: <671fc19.84e3.199f162a66c.Coremail.andyshrk@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Andy,

On 10/17/25 10:56, Andy Yan wrote:
>
> Hello Maud，
>
> At 2025-10-17 15:58:22, "Maud Spierings" <maud_spierings@murena.io> wrote:
>> Hi Andy,
>>
>>> From: Andy Yan <andy.yan@rock-chips.com>
>>>
>>> Add entry for Innosilicon hdmi bridge library
>>>
>>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>>> ---
>>>
>>> (no changes since v1)
>>>
>>>   MAINTAINERS | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index f9f985c7d7479..0adcfb1c264a1 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -12299,6 +12299,14 @@ M:	Samuel Holland <samuel@sholland.org>
>>>   S:	Maintained
>>>   F:	drivers/power/supply/ip5xxx_power.c
>>>   
>>> +INNOSILICON HDMI BRIDGE DRIVER
>>> +M:	Andy Yan <andy.yan@rock-chips.com>
>>> +L:	dri-devel@lists.freedesktop.org
>>> +S:	Maintained
>>> +T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>>> +F:	drivers/gpu/drm/bridge/inno-hdmi.c
>>> +F:	include/drm/bridge/inno_hdmi.h
>>> +
>>>   INOTIFY
>>>   M:	Jan Kara <jack@suse.cz>
>>>   R:	Amir Goldstein <amir73il@gmail.com>
>>> -- 
>>> 2.43.0
>> I believe this patch should be squashed into the patch that actually
>> creates the files listed in the MAINTAINERS entry, like I do here [1].
>> Checkpatch should be complaining about patch [1/2] if I'm not mistaken,
>> when you run `b4 prep --check`.
> We talked about something similar here[2]：
> Maxime believes they should be separate patches,
> And I've seen many merged commits in the kernel are also handle MAINTAINERS entry as separate patches
>
>
> [2]https://lore.kernel.org/linux-rockchip/3ygqnj4idey7u4m7ltlv7pnfhkkvcepmpfdijdszctaeopq3ky@qteg33comjl3/

It seems there are indeed opinions about this [3], guess whatever the 
actual maintainer wants is what will happen, sorry to disturb.


Would be nice to get some central guideline about how it should be.


[3] 
https://lore.kernel.org/all/51b72003-e9a5-4f34-ad08-249fc24b3041@kernel.org/

>
>> Link:
>> https://lore.kernel.org/all/20251009-max25014-v4-1-6adb2a0aa35f@gocontroll.com/
>> [1]
>>
>> Kind regards,
>> Maud

