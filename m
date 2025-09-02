Return-Path: <linux-kernel+bounces-795628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82ED3B3F58B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59AB5204E7C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01ED72E1754;
	Tue,  2 Sep 2025 06:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZkWJCfAe"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5EE1E521D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 06:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756794812; cv=none; b=abswHS0QTYuHoaP8qtUy8UrH69ROrFKDgUiGwZUcAtGhuBZRFUTC3gncE30g0Xoe9uRHMAr5xp0UCIRGfJcRexNGjYG5VkpCohTFmaG1HxfzZZQeM0A0h4xk4yaPThQAytJicO0AU1G0eJxuB4t8aty8ItpIe1lMphqjuGbm7JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756794812; c=relaxed/simple;
	bh=OmgqGRS9lpyTrEFn41VfN0D8+8Pt7MBlL94ZsnDQY2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUiP0BmaSFLAd3LxkDl6cepv7if24cowMtnKwpmao4y95Gp7kkvReDoHGJTJfL3nzIHKkUsQSHk8NV3EgFsXL5atPqrdgV14ji7KP8p2KHhrHU1LtV2KN+Q5lyCm4kIJeWIkgJJa4xEwOYkkBZietboimbqgmT7pOpN0vYWfto4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZkWJCfAe; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3d118d8fa91so606820f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 23:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756794809; x=1757399609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pZyWSfEXmR6en5hSqVkcdSusIQHGptuPDvKtOGXyj7g=;
        b=ZkWJCfAeAxmEpER8eSZHZbcBIUeyNMDxW6NNe3+OamKom9IPoiHjOFIe7rhF2d9vO2
         V5pu3ctbboXjATPh12YCDy5qf8LD1WFYB0nz/eGGtXim9h1hnqOJ50xKF41YtMrNwv6M
         RWYMmv4D6GldExrinUcZvMu4SLzcjkW9e1ZMy89IlX59JHSGYIUYlN69WQGnseJM5Omg
         qe5KA01zOx8lzDQaiPzhvCtrQRZvR/XDPCXhzGqhFqsGTKs4wEsnh2fweh1uI3zc4unN
         zh+18gV+cfPwDkjAJJIO9Yzym5JQjZPoT4CkIZ+t8oOggNC6ddCjU7FkHj1OLPeL0qyv
         KiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756794809; x=1757399609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZyWSfEXmR6en5hSqVkcdSusIQHGptuPDvKtOGXyj7g=;
        b=rw6/5TnR1yZfJr5a/U09zgDXE3JtfviimS+N5rFWqiScH05lmA8AvqTXM0ew37DzOZ
         zaI+KN9/095jdIKLNfZv9vCiWWJ6/w03ZczSIBAr+srMJdUvp+DY3lgiTXMO3nq7Gdry
         kjycNG4Z36xdKkQgWMw1hIyiFHuCyjcdPAO1DQn0wze9lRa+xQVJg3n1yrPCHbE8s7yO
         k1dzcTd76yuDZ+133+yfnOu4ApeL7sziduuEvErwjVNjPrVpob90qkKoX2U3rEYGc1vh
         IovHUx6pnPo8noMxwdo+K2XfqNQ2UzDEf0vZ/AkIkjdktasEhvWuTt8rzbylrDo0AR30
         b3Sw==
X-Forwarded-Encrypted: i=1; AJvYcCX/mnMJxlGksuM0HQAbhkLLRGLgJozwbB1OOqlCNPBZ1GtqcDWxkKajJcu30NZgrASqKxor4A7D+rrlb40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy64+vm9l/GFgHg3jasRrO6zEIULMSAQlxyD3rQfQFbsiveqYXd
	t6vowtNz5MLHvggExD9zWy4+kcsL0SB+TB9ofBRuhFx0aQXKky+mwHCPhbIq+0pljv8=
X-Gm-Gg: ASbGncvqjnk5p8gOg97TQsvDasVsrCDnTgCOdOTDXJEyjCcJVwnp726+eDx3lOKrQVE
	Z0ayAia69SOTMw0aC9OUoF3prNtT+lveWO+7LkinlL8VX67sPM+rNDcZq+sQb2FNUMdZramaNl0
	QjK4aPpxRupoq7S/NJsuBdBQyAMJP4qieImFemrnh3re4oqR3otQARTj9XSokVmmaf+d24pSPmZ
	5Spr4qD2tzEvsLDlWU6QthcV9MDjN2vkMY7HTV9MD3XCgatkiTDoTZ0mgmx8Y1+tl89ayQsm5hR
	MPCVUi7fpeWOuQ1G7MoXethWvXm0oc5WsuiPruGCTlSeyxv3NdMGfMQ4yxEAG5DOkbwOkb3Uu5C
	b5iOU54P3ouNBtUI5SLYQVU08fIU=
X-Google-Smtp-Source: AGHT+IHKIWGa/m0pamORceoT/ghQw4RmChJ+ED2prLmd/mL7KJlk1waSR7kGX/s+IgenapL9sr29cg==
X-Received: by 2002:a05:6000:18af:b0:3d9:c661:88ec with SMTP id ffacd0b85a97d-3d9c661934emr1225669f8f.13.1756794808924;
        Mon, 01 Sep 2025 23:33:28 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cf33fba9fbsm18284186f8f.50.2025.09.01.23.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 23:33:28 -0700 (PDT)
Date: Tue, 2 Sep 2025 09:33:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: broonie@kernel.org, linux-sound@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, Frank.Li@nxp.com, robh@kernel.org,
	laurentiu.mihalcea@nxp.com, waqar.hameed@axis.com,
	festevam@gmail.com, kernel@pengutronix.de, lgirdwood@gmail.com,
	peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com
Subject: Re: [PATCH] ASoC: SOF: imx: Fix devm_ioremap_resource check
Message-ID: <aLaPtf-eZ6sM47yV@stanley.mountain>
References: <20250901151513.286454-1-daniel.baluta@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901151513.286454-1-daniel.baluta@nxp.com>

On Mon, Sep 01, 2025 at 06:15:13PM +0300, Daniel Baluta wrote:
> devm_ioremap_resource does not return NULL on error
> but an error pointer so we need to use IS_ERR to check
> the return code.
> 
> Fixes: bc163baef570 ("ASoC: Use of_reserved_mem_region_to_resource() for "memory-region"")
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  sound/soc/sof/imx/imx-common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/sof/imx/imx-common.c b/sound/soc/sof/imx/imx-common.c
> index 40debc541bf9..b3248c65215d 100644
> --- a/sound/soc/sof/imx/imx-common.c
> +++ b/sound/soc/sof/imx/imx-common.c
> @@ -316,7 +316,7 @@ static int imx_parse_ioremap_memory(struct snd_sof_dev *sdev)
>  		}
>  
>  		sdev->bar[blk_type] = devm_ioremap_resource(sdev->dev, res);
> -		if (!sdev->bar[blk_type])
> +		if (IS_ERR(sdev->bar[blk_type]))
>  			return dev_err_probe(sdev->dev,
>  					     -ENOMEM,

It's annoying that I didn't catch this bug.  It's because the error
pointer was stored in an array instead of a a "simple" variable.
Smatch does actually have a lower quality warning for this but I
wasn't reviewing them since that check had too many false positives.

I've done a little hack around, so this bug will be caught in the
future and it found a few other similar bugs which I've fixed as well.

regards,
dan carpenter


