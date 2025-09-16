Return-Path: <linux-kernel+bounces-819678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 816EFB5A921
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 00:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36E803B24B3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873D12222D1;
	Tue, 16 Sep 2025 22:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEuvnzma"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1671E9B1C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 22:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060228; cv=none; b=aDgkWT3gRnRZLyU9vnpoXJX1FBc77deLuwJ0fo9/+AzQYpgR/LlXrdSdfCsFtntBsUxrOOyalzuS+37PLZMbCUHf8sO6NjdaIfo3Zj0aUGIcuDSfcBUVox8YzDMqLSqpa5WXK03pisOBEwZOH+1J88IVpgP7XK2mFnhZAYyvbtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060228; c=relaxed/simple;
	bh=rngYmVobiGFs88K9afobninraV2yxLvnoogWo8W+5NM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Nyf6O0xpPu9oBVcyPCuIRc5G0227S+HL+G74L5mPBO9Vxh8id2l6pmvzOJEIEfSVLMZnSf3ijE/cP/B/EBYs/m+HJgDEVRobQVrW6cP+Ydd0cJcXA/8KNROmj5WFhrLdmkja0PicR03cI1bkHw2bQgZHddBDs3VYUsg4qUkRWRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEuvnzma; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b0e7bc49263so469570466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758060225; x=1758665025; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o0Ob/UE4RTVxiwS8RzGBBRyiZqvn0MV4NxGM4WOAL0E=;
        b=ZEuvnzmaJG8e6mGdrfvaoP/Ij6kqyosv9K+1qvc8fjwX0nzYieBGdF4JxZPRaVklHN
         67BDL/7QwUT0Xa9fgRqPsOwvONMbVsThIxrWeVpJI6B2hJvYA5TWnQRnYqWe6Dcxv7df
         WDBVtwnfegrOWXNnKNXi+fuI8qAM3grgkYVHfRMCbNvF5ZRJGm5hyaNhh+X4X5q9a3Qk
         arNpUbt5nJCxDl5s0UgduJqE41PHaVyk1QuhH8NalC4FDRT9M8bKuRAxDP3Uob0ypigz
         DZPSPzW5dZ0fdG/GYGAC4GGGGg9m+eVV4lOQy9ETOJDjYIscerF3L+3WHOx5570VTM3Y
         Xo4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060225; x=1758665025;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0Ob/UE4RTVxiwS8RzGBBRyiZqvn0MV4NxGM4WOAL0E=;
        b=ZnEsMt7dgHv+D39eFjrdTcyRUbevRMCw3WAeMsbZJ54/yLGC3Z46Gt7y2dpLxc0Fhm
         RdJm2Jdiq1MnXOphNBm0pj3zjydPxxCMma7bksgg513hmO5SP42X5fhT6hixWcVb5AtL
         f6HIcoSawQiLrDQaEv2wYbFIHG5b9yZk/sPVyIyX76jVarP2UQREDpO/LQpgjo5YbUaq
         TCt9qrqyaK/pcteqkdoiiPGgDLuai0V10o2AEDZp92Wir2RuTzGKqy8U1MpfPnY73/vQ
         D60TU6833N/kEsNZ3f734cVvOaS9vawzhqTXYNyrV7AI/haGMa29+E3EDjmkP8yI88GP
         gj0g==
X-Forwarded-Encrypted: i=1; AJvYcCX6brxhufJ+IoseKGArQho2YToizNHLZIYf3MhMYwzXum42UkcWFFw21SC3+eM9OVb4Xt7XYp2VE5+RCU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIY8wujNdLdP2SrAbSIXFNOjIGu9Mnncr4YfgoIuI+XYRWtkCh
	eBg4aKzShWhiuDDlbU5iP3DpOJ014Fs5LSouz+fCWY3eWR7y5EYw7SXj
X-Gm-Gg: ASbGncuzLfg+gI9HqzTZuSnfTQirJbXok7LPcfHKc2WVBr3rmeWVpjaf+HZzGUHBnOQ
	0ahEU/4WTGygwQcIGEjsRoaIe7YwPm7vYswM3tcy56qbZ+mzVZL/p66BrKcGxC0XlMOuHoY4ksq
	uWsXoPAoBtAIRGNJJSLDII5HTZCODCQjgnyrRP/GTxBJLQfyyoGNteWR7NGXMmEhlfNrybv0XSV
	wYubxJADWxafx4jjkMJsr8W16H7kSN2ZrrXSqDSy7dMNbmiUsOxHDyEfKeyb0sre196sbbV3UkI
	QxurX+ro0v9atkgvvFSiclDSCximv/d1IUSHOahYre8gdiofpM7HOvd5UoxczYyZ7Aj67i01Dp0
	NERDLrFzD2wpG01kovVlUKJ6xZViBxY2l/TOw1j5pf1ACyFX8tQUZhJnFV1ARh+H+fGaR
X-Google-Smtp-Source: AGHT+IEQodNvL7Edth6QjxYHTIysPZRAz+uUM7UuZtp4kejKP8E79m/qDu+L/TqlV6RUd269kcVcYg==
X-Received: by 2002:a17:907:9713:b0:b04:8358:26fa with SMTP id a640c23a62f3a-b1bc02f66ecmr1410466b.33.1758060225245;
        Tue, 16 Sep 2025 15:03:45 -0700 (PDT)
Received: from ?IPV6:2001:861:3385:e20:6384:4cf:52c5:3194? ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b30da43esm1237094866b.14.2025.09.16.15.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 15:03:44 -0700 (PDT)
Message-ID: <235312e0-b912-4e10-874a-e6364131aaee@gmail.com>
Date: Wed, 17 Sep 2025 00:03:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] STi device-tree display subsystem rework
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
To: Alain Volmat <alain.volmat@foss.st.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20250717-sti-rework-v1-0-46d516fb1ebb@gmail.com>
Content-Language: en-US, fr
In-Reply-To: <20250717-sti-rework-v1-0-46d516fb1ebb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 17/07/2025 à 21:15, Raphael Gallais-Pou a écrit :
> This serie aims to rework the display-subsystem node, which was
> previously included directly within the SoC node.  This was wrong
> because it is an abstraction and describes how IPs behave together, not
> what the hardware is.  Instead, extract display-subsystem outside of the
> SoC node, and let IPs describe their connections.  Doing so helps the
> readability, and eases the understanding of the hardware.
> 
> Several nodes have been renamed to stick to the generic names defined in
> the device-tree specification.
> 
> This series depends on another sent a few days ago.  It is not critical
> though, since not having it only triggers warnings when building
> deprecated device-trees.  Please see link below.
> 
> Link: https://lore.kernel.org/lkml/20250714-sti-rework-v2-0-f4274920858b@gmail.com
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
> Raphael Gallais-Pou (4):
>        drm/sti: check dma_set_coherent_mask return value
>        drm/sti: make use of drm_of_component_probe
>        ARM: dts: sti: extract display subsystem out of soc
>        ARM: dts: sti: remove useless cells fields
> 
Hi,

@Patrice
Would you agree to make the device-tree patches go through drm-misc 
instead of your tree ? So that the breaking change lands in -next in the 
same time as the driver changes.

I will send another series to convert display subsystem bindings to DT 
schema as soon as the series is merged.

@Alain
Do you prefer to merge it yourself or you rather let me do it ?

Best regards,
Raphaël>   arch/arm/boot/dts/st/stih410.dtsi | 316 
++++++++++++++++++++++----------------
>   drivers/gpu/drm/sti/sti_drv.c     |  18 +--
>   2 files changed, 192 insertions(+), 142 deletions(-)
> ---
> base-commit: b9a572f471993d3e8bf874fcb57f331d66650440
> change-id: 20250401-sti-rework-b009551a362c
> 
> Best regards,


