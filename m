Return-Path: <linux-kernel+bounces-800497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78088B43865
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6EC84E196D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2322B2EB854;
	Thu,  4 Sep 2025 10:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HMNP3pES"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9E72E7F03
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 10:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756980911; cv=none; b=KQXSwh16j0V4AKtJRMco4p9B0pB+X/p2VfrgMM3ue4obFqqEMkwStzGLIdpqYkApj6TT6iq8XyYeybrq0k4YKmtCvpVg601sb8VdRAdOQCH5gjkOPW/JEGwxJNeD+1qJkoF9lflI2fuCHfC93EX0Qxt2qIoLPh4LfSurXCOg44E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756980911; c=relaxed/simple;
	bh=hXmp/6NZtKOVFeRFoYpqlmngv8dalmMKWbkl+IudaVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IuD6e7nK8VW9FmRV9aI5ldMqKOlXdlWcoF8vsHdSdGbjag0/ces4pIr3KGc9zuaFR0nndMU0fR03iuaghBcmieH1gWZ3KCj8ySnucMSJJXbnmmI/IkOoho+LFOFW1oT67b6aZiQEcAWIPDEitybzsTFfq/h7/vUM/UGQ7LbucGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HMNP3pES; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d603a269cso8576687b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 03:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756980908; x=1757585708; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TUjaia+OhMAEZTusU0F5Oa10icPeXNIDTIJALCJZSU0=;
        b=HMNP3pESzpg354o/f1ivPsH6ICqaXLiQ3k6XhQ9WH6r04GsM217BK17frrsV6Rng5q
         uHdqRw9d1h/te5VTnMtUDHyluuMJO4oSF24CSY4tDgWXVHGctf040OfwLW49Uzmm1LnK
         teKipBw6nh8X3GJoceFg/WaRPo2ffS/6Ba09+Hza6Hrej2PE8jVaHzCjbbKFQKU059HN
         5ycy3P0KqxJ4T2dRpiSBzbOzFcTYbpyP8tUf14fFJ2oYw2VUMzGO9eyQqP0jHzjjLSmo
         w77UBL7J6HmolPte2FPsooG+W33p4oRZY2LDaYN0Pa+nnAaJHkQZLEB5REeWJl5MQJ/4
         UKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756980908; x=1757585708;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUjaia+OhMAEZTusU0F5Oa10icPeXNIDTIJALCJZSU0=;
        b=S6TnE+d3vDxzRDDPwfQFrqpthG1gJmFum8ZlhS6dTBU77StiUuJH5cynz1Ws2xbgnI
         WwfgypxaSK0dAVZ++IR4zrI5vGGbSmbl4V94SGhEdGiVyjOGX6faTkDE8w82tKYJFrvD
         xJWuo0dG4srGujtUy19zNyEIyTbQmVeTdNcgiRXUnPScUSXz4HH7THdpdtrLJ4PYYPtw
         7hIVCiQj15KMP94xT26Urd5KmAkmkrcALROYiYmiBfWTAGUlmjDAFV3oQQcShp+mmDm3
         rN2/MKSfAHxWAgS62Lu1SP2Ep9RLK78vmVlH11wtL/c+9f1twiKEyRblYRIgwlhZpX9J
         v7UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV+ztItQUJp+muqtjN93z6I5/KPkTjVrpRfQ4vrPsdt0dcTksGGEo9iiRVUHb6xPY8N49BNDYT7LKS9fU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxinXIFHWGFb7N1g8zghGhcmc2VBmXuY9/zl3XBE4bi7KKH5i+G
	tk/LjyV2gBB7RlGy0yyaH3AMYYdQPY+ThDKcA1dLRZqEQKxQCkh4hyjMOxNMfmsKBNt0xO7X4F/
	8SjlLNcxY/ihQ0bdp9/eMfar6rpcgLECtdXAuML8HDA==
X-Gm-Gg: ASbGncu/sYD2Z0OfYYlqK45R95uGxgJdKNh26rYj+eIlj1gXQeO74X+kOMYgxbZwP1P
	FBJMHbyYb2lsNooSgt3eI7slCISqgSVTMwjKtYc/c4w5T9y9jZDNhFa8pvzlSStx8qt5FWEEbzM
	M0x9tuRqX7c9XTubi6GbnQoFk+WqFsxNE9aPh91O++iK16L2f0sdj1dmcjigFp5JkxRmaiVbKEY
	/Tpg9u9
X-Google-Smtp-Source: AGHT+IG8ldfxQaFlFR9n1LdiPDQHlQEpQI4SJcztaYgkxIV+25ENTr0NTKySauZEe4IfUI9wm1RmPMFKF6lcMHOVLNM=
X-Received: by 2002:a05:690c:2606:b0:724:be89:9b69 with SMTP id
 00721157ae682-724be899db1mr15536087b3.3.1756980907994; Thu, 04 Sep 2025
 03:15:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818074906.2907277-1-uwu@icenowy.me> <20250818074906.2907277-3-uwu@icenowy.me>
In-Reply-To: <20250818074906.2907277-3-uwu@icenowy.me>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 4 Sep 2025 12:14:31 +0200
X-Gm-Features: Ac12FXx0dPstIEelprge7mji5eoxeEe15kSVfZZNfNFrPoUORBDZRgDPR8LTXnQ
Message-ID: <CAPDyKFombYNFvTsChewQ6cFY2woS+vSb1YUV0Bp_+DcigrFFXA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pmdomain: thead: create auxiliary device for rebooting
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
	Han Gao <rabenda.cn@gmail.com>, Yao Zi <ziyao@disroot.org>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Aug 2025 at 09:49, Icenowy Zheng <uwu@icenowy.me> wrote:
>
> The reboot / power off operations require communication with the AON
> firmware too.
>
> As the driver is already present, create an auxiliary device with name
> "reboot" to match that driver, and pass the AON channel by using
> platform_data.
>
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
>  drivers/pmdomain/thead/th1520-pm-domains.c | 35 ++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/thead/th1520-pm-domains.c b/drivers/pmdomain/thead/th1520-pm-domains.c
> index 9040b698e7f7f..8285f552897b0 100644
> --- a/drivers/pmdomain/thead/th1520-pm-domains.c
> +++ b/drivers/pmdomain/thead/th1520-pm-domains.c
> @@ -129,12 +129,39 @@ static void th1520_pd_init_all_off(struct generic_pm_domain **domains,
>         }
>  }
>
> -static void th1520_pd_pwrseq_unregister_adev(void *adev)
> +static void th1520_pd_unregister_adev(void *adev)
>  {
>         auxiliary_device_delete(adev);
>         auxiliary_device_uninit(adev);
>  }
>
> +static int th1520_pd_reboot_init(struct device *dev, struct th1520_aon_chan *aon_chan)
> +{
> +       struct auxiliary_device *adev;
> +       int ret;
> +
> +       adev = devm_kzalloc(dev, sizeof(*adev), GFP_KERNEL);
> +       if (!adev)
> +               return -ENOMEM;
> +
> +       adev->name = "reboot";
> +       adev->dev.parent = dev;
> +       adev->dev.platform_data = aon_chan;
> +
> +       ret = auxiliary_device_init(adev);
> +       if (ret)
> +               return ret;
> +
> +       ret = auxiliary_device_add(adev);
> +       if (ret) {
> +               auxiliary_device_uninit(adev);
> +               return ret;
> +       }
> +
> +       return devm_add_action_or_reset(dev, th1520_pd_unregister_adev,
> +                                       adev);

We have devm_auxiliary_device_create() now, I suggest we use that instead.

That said, I think it would make sense to convert the pwrseq-gpu
auxiliary device to be registered with devm_auxiliary_device_create()
too, but that's a separate change, of course.

> +}
> +
>  static int th1520_pd_pwrseq_gpu_init(struct device *dev)
>  {
>         struct auxiliary_device *adev;
> @@ -169,7 +196,7 @@ static int th1520_pd_pwrseq_gpu_init(struct device *dev)
>                 return ret;
>         }
>
> -       return devm_add_action_or_reset(dev, th1520_pd_pwrseq_unregister_adev,
> +       return devm_add_action_or_reset(dev, th1520_pd_unregister_adev,
>                                         adev);
>  }
>
> @@ -235,6 +262,10 @@ static int th1520_pd_probe(struct platform_device *pdev)
>         if (ret)
>                 goto err_clean_provider;
>
> +       ret = th1520_pd_reboot_init(dev, aon_chan);
> +       if (ret)
> +               goto err_clean_provider;
> +
>         return 0;
>
>  err_clean_provider:
> --
> 2.50.1
>

Otherwise this looks good to me!

Kind regards
Uffe

