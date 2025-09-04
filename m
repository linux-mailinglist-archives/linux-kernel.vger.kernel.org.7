Return-Path: <linux-kernel+bounces-801522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD5EB44627
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16C99A44688
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D8C26738D;
	Thu,  4 Sep 2025 19:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="buIFpMzW"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EAB1FDE09
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 19:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757012896; cv=none; b=CH4FAAQwhe05/BJ7fxY9PBSQeFRCPt0WylfLNDwPnzd6xT3pDE2Qoe/yIzPBJy/grDnpVFqgeA9d1f82WBW1SB5w2XlWfXUwyt7zLXJKVi3TaZtxk5DM8rCe6TogUl+KE+ev5CToe+Sgkos6/pxPZvDrno94tVTPmCWJrwqaO7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757012896; c=relaxed/simple;
	bh=vAc8GWlbS1dNAlArdFmlz8JV/K5D/zFsXv7QiZpMwiE=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYltP9bIIZrULW/aZPX2mpayLtQoayj9ikRfKs31hfkvnx6ShzxmqCJ8yd3DamcgfDePdDR6WH8sR71x438nUKVbd70qwLgRc+ly2YPhz1EBYMWH2Hw66fHtpissDjoROgSaRRL8ba2PLzstKyCeXWYEyQm1g32F5//ipLI2Ab4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=buIFpMzW; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-560880bb751so1436337e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 12:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757012891; x=1757617691; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vo5h9zWwGoqlYpJct4FmDo3z+MmmKvsMCfXCdRWbkd0=;
        b=buIFpMzWhzI1UteyKZo2+nFbuh1svmpvVoAMHuXy03PXBAXPfvBiNAV7T5LFChxUls
         Re38b2oeGWZ03aUrUSgLgPa5IGhfIb60IRGLbt1XfHWFypykZhIMWi74QeitGdgHbFgx
         r1IwH5uwiZvqxvMySdOx736Af8+pLyxzl3vmZZcoWv/vWXdn4M6hmjIhZhV+5D3tapY0
         rvFgj1iuIKpbfNDsIdVkSt1NRZBAbtZHuz9T5n4RqPFZllJzpre8ivLtk+Tnu0nbhW51
         JnnKq1cCBIJF92uTIAXYWiobXYuuJw2lkldiwINUpQ90SyF+hWqLJ64bh5VBTpXm4uiQ
         8T3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757012891; x=1757617691;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vo5h9zWwGoqlYpJct4FmDo3z+MmmKvsMCfXCdRWbkd0=;
        b=B3Bp52wEq8WTIFxAVBu4O1vednOxBMJNpooloPQ84Ser9JbtZPModWeKYot5HYSgqx
         dSuXAjEkH+hzDnIjInaAmh+5wj62R4zDDeovB/n8cdQST4osh3Oxo0yZDtJQn1z6do/0
         Hxq58PzjY0GWniY7HrRVmIXcgJZLz23IRC9UU3joA3+LqOjuTIPIKFKrEZ+3EAgkNnnC
         XRA7J6cNRcoTfPSK05vf0uy0sYOZRx+QUaItfi/22ykoM1DUlbG4Q0ijVFnoZ/GU2mfM
         gQEJIs/MRPy9Gh5Ze+smhqZiEVZzA0/ptfKAQhsRy59ZsX0gPvfJHYJVh3Y07r55w4p0
         +NVw==
X-Forwarded-Encrypted: i=1; AJvYcCUtJ/pFe+EQ9rTocNxc2L/Efo576bRnJrC1sU7iSQkTfJe1ABrcM8/1fKgFuvKdcrNMgvlhg3jUHMP0Dd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ+XExJhLEg5QcPqJaoLccLn0ng5Z7ygRK4L0MS+XjoTi43JLW
	cPcWXf/IbILvkcVZyzQfNaFZpND6whMtiNFyTTCSzIKoOtTHJunZygTZSERXG31wB/ed56WCutr
	d9kKGoOJIWjzLxlAeNBaTvG4lnbebZm/YJk88LoGt0ivksk8YKix3W+A=
X-Gm-Gg: ASbGnctjLP3H1e0kgoi9hLC2WxkbM64evHBlRQIKSwtuPqvLAd9jmdCk20sQUQyDSFQ
	CjmxOMb6hj0kO8FGtkzecd5aPwqqJjI/t4r4r4vhbo1vy7EVY70RlvSNWw/SnyqVL9kkQDiBrQv
	RxEKtpJo0Ejn+A8LXM16Ky42QXIolqZ+6Lyx9hXlh92gr1hu0GuE4rhNfeD0RLRum1iu4CABslf
	iG55h1t0DrGAjWKRrZ5NhTGe/bQLeLc4SWgpQ==
X-Google-Smtp-Source: AGHT+IEjg25sWuO3bmaj5PHUknGO0S2JXM45w9uKMpw3odRt7dOKB/ZN0eWo0rVVU5lHI6RtH5iDMCEfa3X9yWzPwAE=
X-Received: by 2002:a05:6512:291a:b0:55f:63f5:747b with SMTP id
 2adb3069b0e04-55f708b4f88mr6505796e87.16.1757012891026; Thu, 04 Sep 2025
 12:08:11 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Sep 2025 15:08:10 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Sep 2025 15:08:10 -0400
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <aLnhbpfeweBI1H4N@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aLnhbpfeweBI1H4N@stanley.mountain>
Date: Thu, 4 Sep 2025 15:08:10 -0400
X-Gm-Features: Ac12FXysO6QNdjIEOI33bmHVFPgLJt02PCy8XpvyDgLc8P_ntklQBO8hfnzbYpY
Message-ID: <CAMRc=MfZuB53p2AMG_=zTzERL8+3cfZdXh+c-UhO9S8_aZJoHg@mail.gmail.com>
Subject: Re: [PATCH next] pinctrl: keembay: fix double free in keembay_build_functions()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Sep 2025 20:58:54 +0200, Dan Carpenter
<dan.carpenter@linaro.org> said:
> This kfree() was accidentally left over when we converted to devm_
> and it would lead to a double free.  Delete it.
>
> Fixes: 995bc9f4826e ("pinctrl: keembay: release allocated memory in detach path")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/pinctrl/pinctrl-keembay.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/pinctrl/pinctrl-keembay.c b/drivers/pinctrl/pinctrl-keembay.c
> index 30122ca90cbe..3241d3ae6219 100644
> --- a/drivers/pinctrl/pinctrl-keembay.c
> +++ b/drivers/pinctrl/pinctrl-keembay.c
> @@ -1643,10 +1643,8 @@ static int keembay_build_functions(struct keembay_pinctrl *kpc)
>  	new_funcs = devm_krealloc_array(kpc->dev, keembay_funcs,
>  					kpc->nfuncs, sizeof(*new_funcs),
>  					GFP_KERNEL);
> -	if (!new_funcs) {
> -		kfree(keembay_funcs);
> +	if (!new_funcs)
>  		return -ENOMEM;
> -	}
>
>  	return keembay_add_functions(kpc, new_funcs);
>  }
> --
> 2.47.2
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

