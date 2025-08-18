Return-Path: <linux-kernel+bounces-772888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 672D7B298E5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 07:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FA2F3B22A5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 05:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD75B26A0D5;
	Mon, 18 Aug 2025 05:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUVEBIwQ"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF8B26F471
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 05:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755495009; cv=none; b=rFlX0SQ9M5u1Xyj1akeSMA/ZAIWviNegenahmvMTs5w8R98bJvMThHEkdxCedHOtPT6Q2duhaCUHXU+3tocOK8v/F+DJVrkcBPo0QzNnm5pxWbwqBO7RVj0b3cu98X/NtaovpPxKOqDpoxc9pDMiG7UoiJJMttX05Jf+Bxg74RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755495009; c=relaxed/simple;
	bh=bxSUmziJrMUKQSakd2D2W+QeDKeos/RKqpcoLDWfOzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CSFws2AEJ+1g9Fg6pQDxN3LPBTfjQK+XLAzC6G9pTFxkqzxwrT55gragFEoKft/Oqr2TEIgs9AUC0EyG9IMg3jF6H/4+JcGXw4IRyWNWG2prkf2yg+jMUK1v7dpSSN74GlrmPM/iDSkm8z5QpeAjCgQlmCTTWlWRaF0DBzl9Hic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUVEBIwQ; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55ce5287a47so3383114e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 22:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755495005; x=1756099805; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1BNjZ6vedifVSqfiCuk4T3yaxbR7jpS/6PUw88V836o=;
        b=RUVEBIwQ44A0KOUjMVc878fo9y36UjGfkmhj2UR98d7zL/maJqM1mvQ/zos3bC+1M+
         CluqgMoq0N+7t53+/yh/SinW/aQzceTB8o/FBd4Hnnki0BO3tWnlKW8n/5xK4dHyrmIV
         WyH1nNNZEaE9Zdt7K4m33IpL/E+6yzIx02S9DGSldANYDwRUuCbQdVuK9/nDe+ZNIALB
         r9azOiiqOVweZ6gpvZ7i0LgT+F9KU64ce4SCNGRdPNA5yUtdA7eMODKy9aA/CPf3mtiL
         1RsQ0mMUMEtACVhZYXzI5Frs9F0NXkKPzvKk/tvAOd2fEfFjp38FOuLGiM+sA5cTEEdI
         8Syg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755495005; x=1756099805;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1BNjZ6vedifVSqfiCuk4T3yaxbR7jpS/6PUw88V836o=;
        b=hSuC09sB5Hrb5lXhnXR/jJqkNjD41oHZK7MrMN5k+OB++u+Z4LY9xY0VqSal/b0ZPg
         mpygH43VhfYvLGmUJXOttBUnS/x2XMMlCdqsz3QIR30wEHsrBGktWiVWPFqOWVrUpE/v
         0BJONowRk2K3UTOHqjmlAG+W48Dk28U6mfDPk6n+4k+NfBgWHmY4gAcW0fZpZg+8XFSx
         7qDd1c9ZAHC1D2kNad9sxkM0UFI5PcHSITGxepKJEt+jbl1lFxlB5Zh5QUGbrxmYNWDt
         C9orZhSaL3SDSqaUEZ8QRRRtKS3Tx9wRpVbJ07WjMPcdfwIcbO/02uhuW/xLPV6mzTrl
         q/ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZjAuywNTEVTBis/7nj/1bHaKPCivwmLLhJwMKT+jfcJ/v3Whi8Nc8q3cOFAZVsmY8FCB4n2+2CKZor0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBNPip/Ra9psw4qXP7JvUYOcDC74GRqJXse/0MIkTgBBHLjQmJ
	c5RrwUb/Q8tJGhZ5/8UnmsjrXlUuxb/QAwSp+1hvqjEWqCVdGm5xff8T
X-Gm-Gg: ASbGncucr2hlZVjAxajbAB+Hk7mZJul1Ds5N4cZuflHQZcw/v3khDga9iLfLEmarKpm
	zgn2Ew5Mb7SK1lezZgkCmQk8oojmde3eTj5p2MJCEp9tmxdIHjXVhAtt14+pWFU3/O4N9o13Klr
	PUDS1aujMnE+qjYee8+idwiPBL8nTR3WurtiHgfdQACgVHBz8QoElRX/MOBAW2Ex1IfCqok7aU+
	e/+QNoOupN/zK/kgx+5pEzaFsmOwNKYV/pK6QCzlLGUDQ1j0Va/ZxaLGv2520iIFSu+6Wfb1Rl4
	Ubs3Y1+qzHelX4CzXOgI5rzMyuS3zfy7pXdVijXj9OeAXzKcNo0523xvt32eendOTO2eVKy9Ejw
	k3iyeewd3uEG2n8TLioMMl/4znGoiindSp/ktrJJC4RfbEGGepno1vnQUNisXm9QUkzQWqi3Uqw
	dTl5gmPvFhhYjkcw==
X-Google-Smtp-Source: AGHT+IHyjBGAXRBpzFs35nEkMpvH61exSQ+9VdpCucsWB/0zTbhvH43rZaAZTVTM2SrXyFtSJYKMzQ==
X-Received: by 2002:a05:6512:671b:b0:55b:95a2:d70f with SMTP id 2adb3069b0e04-55ceeadb366mr1895102e87.18.1755495005175;
        Sun, 17 Aug 2025 22:30:05 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3cc736sm1480656e87.79.2025.08.17.22.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 22:30:04 -0700 (PDT)
Message-ID: <eb3555e9-afc1-4f0f-969c-fdb66231d0b8@gmail.com>
Date: Mon, 18 Aug 2025 08:30:03 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regulator: bd718x7: Use kcalloc() instead of kzalloc()
To: Qianfeng Rong <rongqianfeng@vivo.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20250817142327.174531-1-rongqianfeng@vivo.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250817142327.174531-1-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/08/2025 17:23, Qianfeng Rong wrote:
> Replace calls of 'devm_kzalloc(dev, count * sizeof([type]), flags)'
> with 'devm_kcalloc(dev, count, sizeof([type]), flags)' in
> setup_feedback_loop() for safer memory allocation with built-in
> overflow protection.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>   drivers/regulator/bd718x7-regulator.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
> index e803cc59d68a..022d98f3c32a 100644
> --- a/drivers/regulator/bd718x7-regulator.c
> +++ b/drivers/regulator/bd718x7-regulator.c
> @@ -1598,7 +1598,7 @@ static int setup_feedback_loop(struct device *dev, struct device_node *np,
>   		if (desc->n_linear_ranges && desc->linear_ranges) {
>   			struct linear_range *new;
>   
> -			new = devm_kzalloc(dev, desc->n_linear_ranges *
> +			new = devm_kcalloc(dev, desc->n_linear_ranges,
>   					   sizeof(struct linear_range),
>   					   GFP_KERNEL);
>   			if (!new)

Thanks Qianfeng.

I don't think this is particularly hazardous, because the 
n_linear_ranges is known to be small. (It's populated in this same file, 
with a size of pre-defined array). Still, this seems like a valid change 
to me. I know some would say we should use sizeof(*new), but I kind of 
like the sizeof(struct linear_range).

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Yours,
	-- Matti

