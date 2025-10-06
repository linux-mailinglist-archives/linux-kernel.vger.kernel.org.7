Return-Path: <linux-kernel+bounces-842871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A91BBDD71
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 13:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938683BCA7E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 11:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDEC269CE1;
	Mon,  6 Oct 2025 11:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T+7z9LOr"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EF1CA4B
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 11:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759749150; cv=none; b=c7x/MeVUXMdFvOOjANTWvksAV7qlxEGEWUgDSQsinthVwgbFnKQuPm0Cn0AablVTXJrrdUHkBK+lwJyScD8B5UG/Bk7I8A7oy8NkHfH/i1g+6h/8g51USnoK7MqTPZQq3KG0Uf/RM0NAOaJCkFoby++SqLrbbKk3hbo2wMQ1jCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759749150; c=relaxed/simple;
	bh=zrJDYNSApTHnAaMQBJu4RPWao8aOd2DGCsXyTXRy5+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n7Ihi5o2fOaTHSlwhdR80o/1owq9Lbcl0xCK4XVA8pEiJ0h1oCkx/knf8P1BDGzka7D2rT6NNJqOgkhlVcfqAHpxnH2lxsPRr5qs2TKbKR6c5DIl6WZiNb6yNXNybeUqfr7+594W4A54FcemOSloJ+2ymrqx54y/4wC8I37k4+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T+7z9LOr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e542196c7so32398565e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 04:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759749146; x=1760353946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Y28niRMzt7DTJLvTv7YHssogiH+TYaxfjknJwt5S2c=;
        b=T+7z9LOredrA1PcznL/IGvcm/2pSpOsBwMPOyXdKqh12velTn9XgKrJS1xs63UQTpK
         xxlqrKurQs+z1nalf0+gsRhjqmzsAtHqsWbU+IR8QMzMhLUgkzPV8/WDHGoqKKyuzX+i
         alrNu2QgJiZNdrgqhFeR9ldSADPuhxKkqFdNCUgjVUShLRNE52vaVdpNosFUxiNctgX+
         PmpAHzPug4iL0O8C7SpXuNyVCVJlKzPhDNc4AslwXqYZ9inUsWblabxG0s3NBwDWHTEM
         A+ww1xj9rb5oOXlIG8VGSY/y7mvpxhswIAKrrXKL7PgAib/sT9VjGuhC55bnX8SxwqOY
         yr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759749146; x=1760353946;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Y28niRMzt7DTJLvTv7YHssogiH+TYaxfjknJwt5S2c=;
        b=B69KlaNvdgUSNvnkuv5IhiJpdN/QrI3Bwyo+eGyPpOUk/DHLgESXfLx+XwRj8SBuKy
         wYFD2IMFVwhEh0hBXD92ItzQlbwy3PubQT0LSHOgplY+Tc53ubsCXoiO1AJlLT8v4IY7
         7x5US7AQO3ynapjDizSh4U122pxFWXHFrOCe6GRyTs4L8ZEx187hsKM9TQ32PIxIbvAG
         JgB+B4n8bp01a6iPm4SFyzVFFTYra4UMm+RZauUBlEI985jj8EtRlMKabNmaFm3B/q4E
         H1bdHwmuHgrxTl6eIBA7so2v4UoZRHufjrjqVTPVkLNT9asARViWM4hEmXfpncbUzIXr
         tCgA==
X-Forwarded-Encrypted: i=1; AJvYcCVBE8s3fE3ef8Ig02iSXhDM79Ia8FT3J1IwrFXwj8PVd5ZC8fagr00wgIKg1LexNbhqU9jadLcgVVfWxlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJvp+/OfB6q+EVU6nybp3bnjTd6pxbLiZzUNoeielTeBDhGPQS
	zInmWGN863AZhykG5AjTwGmr1jEocOGGx5YEjsuCHZ32gP8kKeKBep6HH3ffjEKRFu0=
X-Gm-Gg: ASbGncv6rDZgTa9MBY5sndPegzjLME0SfduAkxA0U/OiP85PwjUI+2//ko3phq52gUK
	PfPUJoGqljLEl612vsGHe93ZVXIdrCdELbFIkMLWvg0RuLozhzpJFr+YHMCo7mb1mWnKdjyXXEN
	AkRM/674ua+hUNGVI2kA0ww1v5UYSExaOHGppoYco9IsIawtOAFU2J4YpOPana0SzF1wzGzHMOZ
	PwYbnzADM8qW41G6wqsGjRdeRe0tJVbu4vsK2+eng9awNIlY5e4NHEPNMt19SYZtKL8LOvEH/7w
	Szx2Qn+ARZol3DT7O06Jv6eR8ptTW+TSdPm+xDl953XkMLTsokB6CC5y4Ma1i8E9IydnHsJn52F
	LjX3XZR10pcvqEajy0hY0BEb9tvZWYUep7+ZEVafBauGEF0f5GvxmRbRfHRQTffFonoN1IDVE7J
	M1tAC5D9hrQYcDp7o1vB2wyAyWQ8k=
X-Google-Smtp-Source: AGHT+IED6zGsorMymWzXbyfZfVfZ17caCEuzSle55VwjdBVqw0LnTAkN02fIG8Fbsdt4Nd5VRu5UlQ==
X-Received: by 2002:a05:600c:920:b0:46e:74bb:6bd with SMTP id 5b1f17b1804b1-46e7760bed7mr42278615e9.4.1759749145876;
        Mon, 06 Oct 2025 04:12:25 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5b622f37sm144432315e9.1.2025.10.06.04.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 04:12:25 -0700 (PDT)
Message-ID: <5ab4d0a3-6c58-49b1-93b8-7a69b150c1a9@linaro.org>
Date: Mon, 6 Oct 2025 12:12:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm: Fix GEM free for imported dma-bufs
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
References: <zR1Ft0CGCZU6PwpoeaGHv9LDWAyJqqpAXhI25pUYMlRV1LfCJYhuDQVLkclBphRZkgcA-VrvHykxdchDBlzrmw==@protonmail.internalid>
 <20250923140441.746081-1-robin.clark@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250923140441.746081-1-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/09/2025 15:04, Rob Clark wrote:
> Imported dma-bufs also have obj->resv != &obj->_resv.  So we should
> check both this condition in addition to flags for handling the
> _NO_SHARE case.
> 
> Fixes this splat that was reported with IRIS video playback:
> 
>      ------------[ cut here ]------------
>      WARNING: CPU: 3 PID: 2040 at drivers/gpu/drm/msm/msm_gem.c:1127 msm_gem_free_object+0x1f8/0x264 [msm]
>      CPU: 3 UID: 1000 PID: 2040 Comm: .gnome-shell-wr Not tainted 6.17.0-rc7 #1 PREEMPT
>      pstate: 81400005 (Nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
>      pc : msm_gem_free_object+0x1f8/0x264 [msm]
>      lr : msm_gem_free_object+0x138/0x264 [msm]
>      sp : ffff800092a1bb30
>      x29: ffff800092a1bb80 x28: ffff800092a1bce8 x27: ffffbc702dbdbe08
>      x26: 0000000000000008 x25: 0000000000000009 x24: 00000000000000a6
>      x23: ffff00083c72f850 x22: ffff00083c72f868 x21: ffff00087e69f200
>      x20: ffff00087e69f330 x19: ffff00084d157ae0 x18: 0000000000000000
>      x17: 0000000000000000 x16: ffffbc704bd46b80 x15: 0000ffffd0959540
>      x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
>      x11: ffffbc702e6cdb48 x10: 0000000000000000 x9 : 000000000000003f
>      x8 : ffff800092a1ba90 x7 : 0000000000000000 x6 : 0000000000000020
>      x5 : ffffbc704bd46c40 x4 : fffffdffe102cf60 x3 : 0000000000400032
>      x2 : 0000000000020000 x1 : ffff00087e6978e8 x0 : ffff00087e6977e8
>      Call trace:
>       msm_gem_free_object+0x1f8/0x264 [msm] (P)
>       drm_gem_object_free+0x1c/0x30 [drm]
>       drm_gem_object_handle_put_unlocked+0x138/0x150 [drm]
>       drm_gem_object_release_handle+0x5c/0xcc [drm]
>       drm_gem_handle_delete+0x68/0xbc [drm]
>       drm_gem_close_ioctl+0x34/0x40 [drm]
>       drm_ioctl_kernel+0xc0/0x130 [drm]
>       drm_ioctl+0x360/0x4e0 [drm]
>       __arm64_sys_ioctl+0xac/0x104
>       invoke_syscall+0x48/0x104
>       el0_svc_common.constprop.0+0x40/0xe0
>       do_el0_svc+0x1c/0x28
>       el0_svc+0x34/0xec
>       el0t_64_sync_handler+0xa0/0xe4
>       el0t_64_sync+0x198/0x19c
>      ---[ end trace 0000000000000000 ]---
>      ------------[ cut here ]------------
> 
> Reported-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> Fixes: de651b6e040b ("drm/msm: Fix refcnt underflow in error path")
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/msm/msm_gem.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index 9f0f5b77f1bd..3aea9b493375 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -1121,12 +1121,16 @@ static void msm_gem_free_object(struct drm_gem_object *obj)
>   		put_pages(obj);
>   	}
> 
> -	if (obj->resv != &obj->_resv) {
> +	/*
> +	 * In error paths, we could end up here before msm_gem_new_handle()
> +	 * has changed obj->resv to point to the shared resv.  In this case,
> +	 * we don't want to drop a ref to the shared r_obj that we haven't
> +	 * taken yet.
> +	 */
> +	if ((msm_obj->flags & MSM_BO_NO_SHARE) && (obj->resv != &obj->_resv)) {
>   		struct drm_gem_object *r_obj =
>   			container_of(obj->resv, struct drm_gem_object, _resv);
> 
> -		WARN_ON(!(msm_obj->flags & MSM_BO_NO_SHARE));
> -
>   		/* Drop reference we hold to shared resv obj: */
>   		drm_gem_object_put(r_obj);
>   	}
> --
> 2.51.0
> 
> 
Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org> # qrb5165-rb5

