Return-Path: <linux-kernel+bounces-855135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 727B4BE05A2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EDCA134FADD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD498303A0B;
	Wed, 15 Oct 2025 19:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UwJGf+Ul"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194AC1D90DF
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556179; cv=none; b=MJ5LRjpuPfli785YylvA118n35pkVrx0D8RKED14i8oX0Rk7+FY7R0QhH4z/aPc25jPdupTXYqe9IMysM7DQiWzCjSe4tBoan2LjeOy5u+M96f8UU4MEfBVBhzGVDJPnnb+gAx0VSULjuAdhiF90/zLdCT8oy45YQu7/rhmAqM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556179; c=relaxed/simple;
	bh=6FJ/R1ITDsF+bIAIpfjW01XbZyF5cdVhQGhS9FNGWBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YWcczmrVxGOecAui4NK1Txr5Bs2UUGQYTBC+V5g+jchlIQ9ciJLi2CDlpgHOTTMoImZWYpL5P+1ncy06nF9TEMXdW4iu4zQBdJePG50pO0g0pyUNJHmIDs+Gq8ccejc/c1zTrgvp6sZag1Us+Boo2wKUjEpiohdkJMNeN39y1DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UwJGf+Ul; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-58b002614d2so985994e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760556175; x=1761160975; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2uKCDGSkRJ1nI5Vl4WxpkpeLM82j5VPKiPiLY2XZbg=;
        b=UwJGf+UlWJ7t8hswzGU8YK+rxrOuzqHONzuZvAEiwpkAROzMHTpLkkQNhV7o/LEmva
         jZoNgA+b1QlTvQITTDVjuuuvZKbv1rFcfWcvt1WYbn0PpXPmG3xiWtyEFuphXwHCzzge
         0iFKQmd07AWa18Jc8VcjsBEbzoaZZj2pFVCE026X7r89Vik8YAKk0Jgg23aOl0rpd5PN
         rBpBs2+RJCTSiDv1nqCc/36aDGgX8n8tgQCOs9I5xO8Cm8R6XiYcLThitzFuraUTG/qb
         HUsq+QSuVAvrmIhMl8jxjfRBxrTAP7sepgYisGScurVa6EI6ShCZbU9mRnHUcSLc5p27
         aAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556175; x=1761160975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D2uKCDGSkRJ1nI5Vl4WxpkpeLM82j5VPKiPiLY2XZbg=;
        b=RspCbsEMAVqTP9rXwlQLQK5iof51GZF6bN+LUPF9Z+Jq5/JSnBL85IOQ2KIXwjYRwL
         9hqKgMzWOKyyZ9pLexcWTNMmGRvvs5LRb+pl8n7fcQiuxprhuohlUc/ddzF76BcJvVyu
         g6dh8XROerbHCzoS4QTeH2ANj7q1gjHU+d2zLzAgIhogqi5tPMeQE63WIiEZvG7dz0+Z
         HmhfazwUY8SO+J67Ms0+lBUMH/B9PcFbSTmLlvN/Xc98t3QdW5SRJjn7oIiOoKgQ2aBU
         GmahHGxFCeHTuHhmqwxamfKyBov/e5xqnO6DVqF+emHmkxiwF0XSY+NYrY+v7/+qpsAW
         +OWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgSFDbISLXhrujnTpsTdfErLiX4XWEEpSHC1Zecxsghf5TBJeS0ey37DD/Q7iJCfPMrTmr32Mxi1m1hSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT1ntsqyQJS/z+woJgSOJWCfHk2K3JnTOrNxz5DGU4aGOGUw1K
	spQdoyTOkIofvPFywE61+TfiTiAvEkISrly6yqfmaQZDChujBWp1tRwE19kTyPCFbqI=
X-Gm-Gg: ASbGncuE9fzB88FhxxjAVBr/203AWCKne6v9T8HXQcRDNvPSo6iPMXFGmVfP4pYt2Ie
	Dbh6tzeZLGB7Ydqy+NsegkeCp5alESUDssT5j8VpLFHpw3qP9UGCss5E7HqrNh6cW5ajX5G035s
	QjZjyBo18ZIARhvIF0a8fPwKUaO23ZPg5bupfe7TC7cORr7612EvLN+6cAeL/F5wdXhUKUpww4F
	odCPDUwJ71daUDLtKwTGwHrAjfg2nokg2w8Xeuj+1K+JYxFJZqn/xESiozcb6pr+l39QrjK1m1A
	oFNGDHjY6sCusIejp91wAyodJZV+LFMqfDeDNQ/4OOeUSQ3txV9wINTyvgFoAcXrq8OeOrifkF4
	3wwcV9xAkuf+xVQMyR4kUnU2PQlxrsnSQbNLR67oFlYsKPyQ/but6I2/0XN/yyK9iO6gFAvSUR9
	Zmv6bJoWAt6wfE5g5/Bqh9ExmbErcI75gmVnEONzx0vWpbGwWJ46LLPzkuQptrbDVFc9+vkQ==
X-Google-Smtp-Source: AGHT+IGD/Uw/fgx84AFertLSvfVKmejPqlvypnP8IIzpqbGwR8abvcNYUgIYpDHVV55dLFfVQQ6myg==
X-Received: by 2002:a05:6512:39c6:b0:58a:fa11:b795 with SMTP id 2adb3069b0e04-5906d87bd8cmr5059024e87.3.1760556174897;
        Wed, 15 Oct 2025 12:22:54 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59092ed98d9sm5657624e87.24.2025.10.15.12.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 12:22:54 -0700 (PDT)
Message-ID: <62da6efb-24d0-4a6b-9a52-c8f981f09d30@linaro.org>
Date: Wed, 15 Oct 2025 22:22:53 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: qcom: camss: Use a macro to specify the initial
 buffer count
To: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
References: <20251014-use-marco-to-denote-image-buffer-number-v1-1-f782e4cc622d@oss.qualcomm.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20251014-use-marco-to-denote-image-buffer-number-v1-1-f782e4cc622d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/25 05:42, Hangxiang Ma wrote:
> Replace the hardcoded buffer count value with a macro to enable
> operating on these buffers elsewhere in the CAMSS driver based on this
> count. Some of the hardware architectures require deferring the AUP and
> REG update until after the CSID configuration and this macro is expected
> to be useful in such scenarios.
> 
> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> ---
> This change use a global macro to specify the initial buffer count. It
> meets the requirement that some hardware architectures need to defer the
> AUP and REG update to CSID configuration stage.

Both the commit message and the explanation above brings no clarity on
the necessity of this change at all.

This is a dangling useless commit, if you'd like to connect it to
something meaningful, please include it into a series.

> ---
>   drivers/media/platform/qcom/camss/camss-vfe.c | 2 +-
>   drivers/media/platform/qcom/camss/camss.h     | 1 +
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
> index 09b29ba383f1..2753c2bb6c04 100644
> --- a/drivers/media/platform/qcom/camss/camss-vfe.c
> +++ b/drivers/media/platform/qcom/camss/camss-vfe.c
> @@ -541,7 +541,7 @@ int vfe_enable_output_v2(struct vfe_line *line)
>   
>   	ops->vfe_wm_start(vfe, output->wm_idx[0], line);
>   
> -	for (i = 0; i < 2; i++) {
> +	for (i = 0; i < CAMSS_INIT_BUF_COUNT; i++) {
>   		output->buf[i] = vfe_buf_get_pending(output);
>   		if (!output->buf[i])
>   			break;
> diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
> index a70fbc78ccc3..901f84efaf7d 100644
> --- a/drivers/media/platform/qcom/camss/camss.h
> +++ b/drivers/media/platform/qcom/camss/camss.h
> @@ -41,6 +41,7 @@
>   	(to_camss_index(ptr_module, index)->dev)
>   
>   #define CAMSS_RES_MAX 17
> +#define CAMSS_INIT_BUF_COUNT 2
>   
>   struct camss_subdev_resources {
>   	char *regulators[CAMSS_RES_MAX];
> 

-- 
Best wishes,
Vladimir

