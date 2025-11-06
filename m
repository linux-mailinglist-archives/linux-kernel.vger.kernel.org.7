Return-Path: <linux-kernel+bounces-889453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7898C3D989
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 23:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 922383A78FF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 22:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC5E3328F9;
	Thu,  6 Nov 2025 22:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WB+F/SQY"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9544F3346B3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 22:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468130; cv=none; b=S5QJ6GgF4qvfp5WQjM5ClRmbqaG5ox0+Qe6Ot5HaUoVHftsQz2vYVywjcGrw7P1Kk875PfJ2BUubshRCuCZmoz1FWUNLCJm4D0HagAg+veD36T4ingSzOrt5gglB2wZoZ4+jN7K1vUuKyU/x2TseGGBx73Cn2lyBhwX6ATWjYes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468130; c=relaxed/simple;
	bh=4JTu03iX6vFDrPqW0GxtDjNlpHZuyhsfQKG/6UtvK4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LkXjrcmWHuhyQLQN9odXrpau1a+eaDC4Gd3VdO7obh4hhSlt3H8RgajdYe9U/joxt96+0tJmRRcq7ZRQ9uu40BYqkolB3o1NnTCn6ICDqpeAPLA2No7DJM4tRy2hG9WjDiaHwIVOYCBk3CiI8LbSU+2SW57zA+jj892FvldaIyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WB+F/SQY; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-94884c52a03so5849839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 14:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762468127; x=1763072927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Ilnf9YNYEmJ0X/Bm5CjqVXNP0HKW5OPjipOTd8WS6M=;
        b=WB+F/SQYXW4hmM6oPiGFcayhyQzlaJmxbldJM/t59/yjh7wBd4EhM+p9TNgp/N3yh8
         kIMwbTA6Sj26fV73eF14Yebm83dT2X2RNPOdEAQNFhtyjMVY/zBvpL70UGMyGMxMgcPH
         ytchO+Q1W/pM5zVk7mxHPx19xA/zxwKNJTFcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762468127; x=1763072927;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Ilnf9YNYEmJ0X/Bm5CjqVXNP0HKW5OPjipOTd8WS6M=;
        b=shORHH1Rk1zO9JbPI3vEoK26Dzxg1KD2Vejvig6Ozd/PDk0bez03JwBOw+nEvCPrEp
         ku/OuOLBVuV/pcfXxp2wrIbN2KPSWUN5tdxD7mB+RmMqA0XGLjTEPsnpVfue1D/SuXo9
         vhxaWq3umCKOLWwB3f3qeqq1TLkn6YLYQy5sXRcUt/uMxczMSAjTSfTwYixKlLQYa5b5
         AAzR6saVJrUdJkPgtl5+wwb1kpIvo/Vlp8Mw2TjmdWaVcRaJW16RsdC/04Yd+KCtGFtz
         RFLxpcb6Up9kN2S9ghmb3DNKpuJbnVq4jGWv/ChnvhtWsqanpwfePY4WHKjznaJvF/Rp
         dOQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVliHYIHIFK/VUR8MmFazix1gg0f66tWw3e0NztS0uOFxVckue3p4AwlNGx6dRcDuf4utFKtZYFwOCr+U0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIusGqXsK/n8W0nenP19oiDOUwubXfYs9tR8MkZqrlZetAqhnO
	4fmfFBjblggC1pb3/jSwPeP7U0ebFOEbVlksHUMJF9Y3BipLXRBr3xNJ6xZA1LCf1Tw=
X-Gm-Gg: ASbGncsMwFZq36N4/UUshvF0yIwVZFMIEBF4sQ9bYIRT54886QKY1zrJAruKlPVRE5I
	XxToLIsnhG9FYlusAqYiil0I+DeEJYlcC5m6l1opGpb4S7cOPXRBs0vmHMYvH9qhzkRT+3e/0PM
	ykr/Cidz63d/IanAS0BeWyyfsEkPeUgzwfYkUJSRJnGNm9ZllqlZPeH1yloQNbu9PbOR2L1Rtdq
	ld/Zh/vOl2yb5h51H94a+pjW1MtF25H4Iz2yFF7G0lYSp+GExmb7flo0LXdpXbKufnDlLan/shF
	TNpvtwtfyrh+xNB7GUqNJV3FX/qI3G/FB/QjiktZ7c70VmWF4jNEZaFga37xUKs2pJXwqY4Fz8N
	mxJYZhe4rj1d7PNt6vfFjMYqI8GQOJpINbepr/VcRbQS2xc1ow/klRlqL+Cdi9gy9CFBgJy5gQJ
	9KZJMCC1yRLa6qWzUBbi8NPOc=
X-Google-Smtp-Source: AGHT+IGJhK5ac0+9nCUlURCUKRMOk9Pshm81p9z0cIwy8e2oj0giXJGWDnsGxvYGWJlHAfrDjfabsA==
X-Received: by 2002:a05:6e02:370c:b0:431:d726:9efd with SMTP id e9e14a558f8ab-4335f3cfb5dmr16442495ab.12.1762468126775;
        Thu, 06 Nov 2025 14:28:46 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4334f42cad7sm15817345ab.4.2025.11.06.14.28.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 14:28:46 -0800 (PST)
Message-ID: <0c7f307c-9de5-4d67-b9da-e728d43e00b6@linuxfoundation.org>
Date: Thu, 6 Nov 2025 15:28:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: fsl: fsl_ssi: Replace deprecated strcpy() with
 strscpy()
To: hariconscious@gmail.com, shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, nicoleotsuka@gmail.com, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: khalid@kernel.org, shuah@kernel.org, david.hunter.linux@gmail.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251105052113.39999-3-hariconscious@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251105052113.39999-3-hariconscious@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/25 22:21, hariconscious@gmail.com wrote:
> From: HariKrishna Sagala <hariconscious@gmail.com>
> 
> strcpy() is deprecated,use strscpy() instead.
> No functional changes intended.
> Link: https://github.com/KSPP/linux/issues/88
> 
> Signed-off-by: HariKrishna Sagala <hariconscious@gmail.com>
> ---
> This patch replaces strcpy() call with the strscpy() API.
> strscpy() is preferred over strcpy()/strncpy() as per the
> kernel documentation.

Which kernel documentation and can you add why strscpy() ie
better than strcpy() instead saying "as per the kernel documentation."
> 
> Thank you.
> 
>   sound/soc/fsl/fsl_ssi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 320108bebf30..b2e1da1781ae 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -1447,7 +1447,7 @@ static int fsl_ssi_probe_from_dt(struct fsl_ssi *ssi)
>   			dev_err(dev, "failed to get SSI index property\n");
>   			return -EINVAL;
>   		}
> -		strcpy(ssi->card_name, "ac97-codec");
> +		strscpy(ssi->card_name, "ac97-codec");
>   	} else if (!of_property_read_bool(np, "fsl,ssi-asynchronous")) {
>   		/*
>   		 * In synchronous mode, STCK and STFS ports are used by RX
> 
> base-commit: 284922f4c563aa3a8558a00f2a05722133237fe8

thanks,
-- Shuah

