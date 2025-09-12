Return-Path: <linux-kernel+bounces-813587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9D8B547EF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFCD0188431F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B797027AC28;
	Fri, 12 Sep 2025 09:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JrlFHmLo"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DC128B4FE
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757669698; cv=none; b=YlCzALqdjzT9Oe9TXdmHUiQhpP3imFinQF605v4iY2vzxc+Fr2GRZeiFL2rDNTyBHEPeNPd/VVB+ShznKHePrPfp8K/rDfEclrLYebNDOip+Zqk2C6i+CQZ3h3g47eOmI856hpREpQKipj7B3wsSjV6o+PYh+qDMzvuv7EGoPjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757669698; c=relaxed/simple;
	bh=Qsle6hxGQYSzPH1l0peF73bL/L6zYuK8SHjY8hrNsMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YnEg96RaxijIPdflVTxcx1+85TyF1Ttic09Z4qJLq2plTv4OVLRdlCm01Xe7+FlQXIrVSssNO+mquH+G/ypGgtP0TBJtE213zPhbMLic16DqHyYECcuwn/Iu78q6bHC8x33zsEpop9jYzJwtx35TcZBLSjXt3qkpxO4jxgoIKdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JrlFHmLo; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45dd0d53e04so3072605e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757669695; x=1758274495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zf9WqLb4fMZEFph0jHkD9+f3W/6St7LAtSwXtmX2PL0=;
        b=JrlFHmLoAV1ql5Oj5CP3M/imdbW294e87mvTjJeEBttlPZBS8/H09lf6iUyCGRQAp1
         n41XE7o5n3eFxUh8wcwf1Vg2RDB2lTtOqrOs1m/a1YBbGtVqsw3gx3SmzgKwDVFV1qNM
         nXpHXh7Fy9mMPeNk6bFUqpJLpTVz+nsgaxHzvWkogEorwBg91hYKVCkR9wrrEjuDrXMT
         GKuUIpnhRcD9WMIUQDs9wJe7po6m8Rk8f6hIDjtOPAHg063RXQkYQ1H4RoXWgBChBH3W
         WlbdznYYXLwxsurtVfWAgd4mli//pdG6+lXntIjdb/PvLfwUswFF1B5ZrPOZ7UU/Hffg
         lKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757669695; x=1758274495;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zf9WqLb4fMZEFph0jHkD9+f3W/6St7LAtSwXtmX2PL0=;
        b=LosMsHyc/j1xnmacKK79kOKP1Y2+q5C7+8w4FQ54FpjqD1pW1crEm/dCUYLoWisTHx
         mCIoOGXpOzbhBtj1e7mhHMq/50t4BWHHN16Q4hpHIG151QSxN6iZNXKxukATZkr05ZR9
         iD+T4Dc8TFtHYG1UzCwZKkII2P2Jg+RnpL8myRoyz0OXdi4yQcPgAvI8VZQxAQQ2pYqn
         JdLIyFCephfL1FGm8wSwcIDQFYPs03IQ1kxEngUYTI6tilqGjbG9hvnvKlRQbs8E8qPz
         vblfhiC5Mnt3ixXEZmn69rsm+jO34V71WAbZF3u1Jyr/5abQIWRyq5xuslKcmzm/P4Ec
         8JnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMReebse7w89rk4Ho7ZrxcCi5F8cGgShK/8c/wzjgSfYNfjMt0uWcSD6w54qTB9qinDPsfMB0sa3uh6OE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5+ryxHFbAvrqRwR4x0CpJkAU6+gcaXSFDLiDcqYGZixg00jcq
	eZvy833LUyKoPawp8i3JRCZjNHOFv/Hh0cPDFnv+c2CobCi89xfYHPMHs7IHgOZGX8gCoQh0NE3
	lYL61
X-Gm-Gg: ASbGnctAZDLtcA79YEzDpye95F1SUYfjjEeQ+w+fVCHEnX0/oROQlbb5cyanc33v/4D
	bRfvf1AVcqqM/GRcBJUdTZm8AkVcpE9iMVyeasTnC3iazZDN87y5heOFtOARKjmhiBn3myk6c6P
	4s5hwF5vQsZLM6Gj84F5AK7w07Z93iERvQU2OPurShm/4xkclgqKUEwl+wKelF79ICTaITW8Hrd
	+qSNrO72TtLyhjir4Gt+tTpnpTKs4hHAExWVsCNPWAu/lW4U1ORng8MU/mKdoy/k5n82l/3EzN8
	q++wVmZ+Ds2U9GF/G2bz99fLSRb+lG+TqXeF1zpb3BjFQz67Jt6SeJhdRppqC+cQhzEND/ARwP0
	Fnp7CjGmWtsD1vMnJx1MO6JzD0FqaZbKEgZdjD9KAyGQZxsUZ0SB90A==
X-Google-Smtp-Source: AGHT+IGjXFRlSmZcHZGIXD5Id9GFvrzWUXYRNPBHL9G4yT0TLddXsGiJtkt4F6BcP3pf0TZ8fGw5tA==
X-Received: by 2002:a05:600c:821b:b0:45b:8a1e:3b83 with SMTP id 5b1f17b1804b1-45f228d5cadmr8419815e9.8.1757669695226;
        Fri, 12 Sep 2025 02:34:55 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0156abecsm58835185e9.4.2025.09.12.02.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 02:34:54 -0700 (PDT)
Message-ID: <c5df4196-b951-4f8e-b2ca-c63fba63d1ee@linaro.org>
Date: Fri, 12 Sep 2025 11:34:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: arm_scmi: Simplify printks with pOF format
To: Sudeep Holla <sudeep.holla@arm.com>,
 Cristian Marussi <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250912092423.162497-2-krzysztof.kozlowski@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20250912092423.162497-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/09/2025 11:24, Krzysztof Kozlowski wrote:
> Print full device node name with %pOF format, so the code will be a bit
> simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/firmware/arm_scmi/bus.c                | 13 ++++++-------
>  drivers/firmware/arm_scmi/transports/mailbox.c |  7 +++----
>  2 files changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
> index 24e59ddf85e7..c7698cfaa4e8 100644
> --- a/drivers/firmware/arm_scmi/bus.c
> +++ b/drivers/firmware/arm_scmi/bus.c
> @@ -401,8 +401,8 @@ static void scmi_device_release(struct device *dev)
>  
>  static void __scmi_device_destroy(struct scmi_device *scmi_dev)
>  {
> -	pr_debug("(%s) Destroying SCMI device '%s' for protocol 0x%x (%s)\n",
> -		 of_node_full_name(scmi_dev->dev.parent->of_node),
> +	pr_debug("(%pOF) Destroying SCMI device '%s' for protocol 0x%x (%s)\n",
> +		 scmi_dev->dev.parent->of_node,
>  		 dev_name(&scmi_dev->dev), scmi_dev->protocol_id,
>  		 scmi_dev->name);

Heh, I misread the docs and see now in the testing that my patch changes
the behavior. of_node_full_name() is just node name. pOF is full path.

This might be desired or not...

Best regards,
Krzysztof

