Return-Path: <linux-kernel+bounces-777356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED40B2D83A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C16E7BED41
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBBF2D239F;
	Wed, 20 Aug 2025 09:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHkn+hfK"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B6E2DCBEC;
	Wed, 20 Aug 2025 09:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682203; cv=none; b=qXdScAilOFIDhvCdghmkidtERJ+5tNyDiLuhteGF1cL5c6qMRB05xSCeZDnu+5q4nxoOjDnJHXuzMruWRrumkJBEZ6lu7wjg9n5NA12HIHshLiHGAM2WRT7Prn6ITzOijs5vBw1s5wFCbrXMnC/q2b+MpO3/Ciy8H5Tz/znYLBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682203; c=relaxed/simple;
	bh=v+VMI9o0BkK2V+kp3wrywxvNurGikAUy1sLctoaFuTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NnsDkHMIolAlrQgxxtz8XfzuRiRayVle212HiZJhfqnHo7C8ZdYYgmiYb6ol5zpjkYQnANELXaMAF3NHrSJ29bLoul3TzQbJnB3jLIsDop07TSfEpx/EEFyVYmt2T+LddurNy3U6ppKjT3ldwsrH1FUICL0TioGLf6kysTpHbm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHkn+hfK; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b9d41baedeso3313318f8f.0;
        Wed, 20 Aug 2025 02:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755682200; x=1756287000; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dSXQX1TpN85oW4/+/+HYjWq1kMXicfJprO2opFSejas=;
        b=KHkn+hfKgVHjosWDg25OMyRLk0+wKzXleC89oGvsZusC0Yu4RwWVIdFslvMGZaslyK
         qw70WjY5yicylRasD3ZM4uIbY6RdmK8sEy69d2uqlJFXQmiYyfSMQ2bgoLYnmbYrfUqD
         cHZfH753ukfZURx2rmcY/hWyE4xHafgo7c4H0ipOPoiaSVlIQDN60FK+WttW5lH+PyQb
         SxXQjnS/g68pUw8sufjLrfD+BSXrhfvo7Kh8tebOZg9lyStuVhpF3UFoOGuXVacjvrhw
         AzxV4YGCRJp1dk0DvdeXoyZMC3PD0/gX16ijrbagKoUpUetvVOVCSvVeGO7yG6FFipIO
         42TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755682200; x=1756287000;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dSXQX1TpN85oW4/+/+HYjWq1kMXicfJprO2opFSejas=;
        b=edYev0KKY0OHJDuf5oV4PDkT6/9TGeuBQO2v20KEtM8XqRRBZuMb2o2EJVXHOIOIYo
         G9dgnQ+1ByD8ntia3oYUQhFTsC3vqQdNOyGcIvNtIkgw14yQD3Y1EvTcMMwG5cRxm9+E
         XZZSbQPebNWhqviYSko/kDSMSnrLxEBZfwIw2yGQJ4zCnf9bXZSfXgTF4EOfWDMKd9+p
         546sSl0fNCuHUZvqy8ZFvsSRyNV+i+5VNwojDqa3gfps2W9bqRTSj4n9R73zzekg/OYQ
         pzZ4xpEbquJU9NtmnIy0sVeOkDaLKZB2nYJLEyDVr0/IK/lCpywyQMoxGR91tz3pUWlN
         WHAw==
X-Forwarded-Encrypted: i=1; AJvYcCU1UTo5FGiTMBU7/rLAcdIwsCb412rn0tl7WSjWz4RfvOA11TkDhHeDQSrMGWEDlJHADoN5joblmuHMpj4=@vger.kernel.org, AJvYcCW/jHKBeuatszxI5KbdcH4eiSzTUS67m3gDD4mIIeEFEnlZ3YEMZw1bYIS2f1GK1BAXMAsNze5zl2fYe+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6dddnb8wYu6QIyQVTnfIkJszvjlwweSysgB/0xMNxWV108SG6
	wJcqlIiuOh5Twye2lEgEDs6j9pe7431CYyt3fKKuYUbTl+pT1Je/qg4Y
X-Gm-Gg: ASbGncuAJHiKVe3fenWZCkoKNWGlKKu1gMqAl9UDN6yWu8eykxJGMZuiieh9ZoJnnpd
	yY9myfURDBPPGijeDrb/nkjhuhjLllxei/bRaaw1mD/ljPes6nNkl+Jyt4CZtnahxRcmZkO8y72
	C+SdJfa51J4f/Jry1ps2pgnVmD7I1ZIKWC3gPzAnID5ZeQcQy+POFsc3vCvkHzm3jJr5At6llvl
	InVOYXNoaeX6eU5QhW3ot7R3RDsiJkxf89NnCpUY8+pHTYjhWDns1a7UGrY/dCke7awDQMJqV6W
	NLwSYwR75c1S/6c9UvQujwebirhyFRD2kuYx0Mexs4fUdgzMH3RsIqX33x1RkFV9oAdbLVLqPoj
	ZgVFmvmcQ0zn2Ajtw+meOZMeHnTmSAeMDQt9ddrCx4QUa9PT9OXbn/A==
X-Google-Smtp-Source: AGHT+IHIqaj17VsNjxB+be2CUn4JNttKe5xtKu6I/n4WpGV/LbFdHc37zcZJehduBXUBlXQI8jKxew==
X-Received: by 2002:a05:6000:2386:b0:3b7:75dd:f37d with SMTP id ffacd0b85a97d-3c32ac109admr1134834f8f.0.1755682199372;
        Wed, 20 Aug 2025 02:29:59 -0700 (PDT)
Received: from [192.168.1.129] ([82.79.237.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4371e7d4sm30752225e9.0.2025.08.20.02.29.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 02:29:59 -0700 (PDT)
Message-ID: <7e75ed1c-a519-448a-ba79-5be80553a81d@gmail.com>
Date: Wed, 20 Aug 2025 12:29:57 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: SOF: imx: Remove the use of dev_err_probe()
To: Xichao Zhao <zhao.xichao@vivo.com>, lgirdwood@gmail.com,
 peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
 ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de
Cc: kai.vehmanen@linux.intel.com, pierre-louis.bossart@linux.dev,
 kernel@pengutronix.de, festevam@gmail.com, linux-sound@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250819112654.588527-1-zhao.xichao@vivo.com>
Content-Language: en-US
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <20250819112654.588527-1-zhao.xichao@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/19/2025 2:26 PM, Xichao Zhao wrote:
> The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
> Therefore, remove the useless call to dev_err_probe(), and just
> return the value instead.
>
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  sound/soc/sof/imx/imx-common.c | 4 ++--
>  sound/soc/sof/imx/imx8.c       | 3 +--
>  2 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/sound/soc/sof/imx/imx-common.c b/sound/soc/sof/imx/imx-common.c
> index f00b381cec3b..4523621cda10 100644
> --- a/sound/soc/sof/imx/imx-common.c
> +++ b/sound/soc/sof/imx/imx-common.c
> @@ -354,8 +354,8 @@ static int imx_probe(struct snd_sof_dev *sdev)
>  
>  	common = devm_kzalloc(sdev->dev, sizeof(*common), GFP_KERNEL);
>  	if (!common)
> -		return dev_err_probe(sdev->dev, -ENOMEM,
> -				     "failed to allocate common data\n");
> +		return -ENOMEM;
> +
>  	sdev->pdata->hw_pdata = common;
>  
>  	common->ipc_dev = platform_device_register_data(sdev->dev, "imx-dsp",
> diff --git a/sound/soc/sof/imx/imx8.c b/sound/soc/sof/imx/imx8.c
> index b73dd91bd529..7e9eab2e3034 100644
> --- a/sound/soc/sof/imx/imx8.c
> +++ b/sound/soc/sof/imx/imx8.c
> @@ -171,8 +171,7 @@ static int imx8m_probe(struct snd_sof_dev *sdev)
>  
>  	chip = devm_kzalloc(sdev->dev, sizeof(*chip), GFP_KERNEL);
>  	if (!chip)
> -		return dev_err_probe(sdev->dev, -ENOMEM,
> -				     "failed to allocate chip data\n");
> +		return -ENOMEM;
>  
>  	chip->dap = devm_ioremap(sdev->dev, IMX8M_DAP_DEBUG, IMX8M_DAP_DEBUG_SIZE);
>  	if (!chip->dap)


Good stuff, thanks! Maybe it would be worth mentioning in the commit

message that generic messages on OOM errors such as these ones are unneeded

since the kernel is already verbose enough? This seems to be the reason why

dev_err_probe() doesn't do anything on -ENOMEM anyways.


Either way:

Reviewed-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>


