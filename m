Return-Path: <linux-kernel+bounces-880194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B17C2515E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD60427DD6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D5C1F09A3;
	Fri, 31 Oct 2025 12:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfCPR+Yi"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1381A23B6
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761914889; cv=none; b=a37O7ltv89mNHSoJO5xQqj0KDWPC/WDKA1kyP1QJLjSIvRrUwAKIk6kC0dTi7ET4e1zMD2iGhuJiSaSKSj1ab9xB/qBJQCD/6jdZLWLV0IinTkB9PwwShvpyX5J04QBTEfSB6/9WyAr7S0Scs9HaXE+meZK85ybyfLHoCoCbEBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761914889; c=relaxed/simple;
	bh=oEIi4/egWFIODg42J9XPRujrpVICJX0n3todLlx8tb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sil7pSXF5cAaQ0Vwi0wKSa89fx+4mxK7ZETcYOv/6M0gr0lqnotImHi5HCkFqxiiFyzCCfZO2w6/3RiQGa1geqO91MJ3JfPE7LaOAt9XtwZLRxxgxgvHtFSKxjsVHh86GVEKK4dpipJ/nWePt0mUXVDpOh5Oq0YYY2Zs3nrKo1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfCPR+Yi; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso2042735f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761914885; x=1762519685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TMq2rs4attrXqSrcDi+nNC5MviqH/WzxTcqB5ovvwh0=;
        b=gfCPR+YiwXsdzD17mii3+KukO9gfRs+b5Gk4Dv/f8ww3O60Uq0zRrQ3EFmfSVPUOog
         doJceSXze2UoPMsAQc8jW9oMjUjfEZBfy872Xr83+au794pwmhVHVXu44MGz3dqmUD1U
         Z27QwJP3PMx8j5WfFA+N27/DwA7CMcbdFb/qyjRnoZ0AZi/3Gs+v71t/k767rwUuYiaE
         4VoY3HfSO8X7e4gw7+StPKEKe11LX5e138Sa9k4s1SKkpIvzqAHFtr2XkX3Oq6QRpXGj
         u7BOuwc/nvEJCqZ2zSDCUw4rI2Y5tPYDb4W7xe2G9pS6UwQus/C4nZ00b8V+Zn7LBslL
         ivGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761914885; x=1762519685;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TMq2rs4attrXqSrcDi+nNC5MviqH/WzxTcqB5ovvwh0=;
        b=X8pwwAOMcFign6GzlnQ7sX2h93DMWfDqhISjmz3gYYSysFo4K/26iRvB92l/i1wV6E
         DbgnEYg5y/qLbWxDtJaqgmWFIGAwsPXAHJ0x0NXMeac+JcaAxc5VhQo7d3nMxYcI3gre
         iogx276HeN/m22D1xUP4NlbfYTRIzUWG1i/wlDLZ8MaoTasSt/zROIXgBzA11ygyCbP1
         q2MTZHXckWu8OjoePisgiF3x0Cc4sfSNeI2+Rvs1H+phr1g6s8XmcsAQwcaI/vcSv84A
         6ZNvUa7V/9jx7MecQqfhoxDQQYVtjYhwkiKBDYmPQXovhI+AE9xA6xp5WfBx7ShtCgFn
         H7OA==
X-Forwarded-Encrypted: i=1; AJvYcCUl2fLcVhbOS+PukcieudiL5Xew+2aJc4zT0//PvEGaQG3VV9g/5gZVzAoRMTZGqzhwKRE40A7Wo8ZHuyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHB+f2b8BnzXJpuOeWVL0Yc1PkZJgT3gcWotQtC+E6zJiI+ZL2
	zAzsq98G9kfW12u8z+3sQ95kvEmZoArH4E4ZfkTDGvuRmY59JC+qMrKJ
X-Gm-Gg: ASbGncszXcc/R5SPWPsrfY7Ugzrnq/8rEBUjszi3WHjrEq5WEp/uV7Seeh9AggSVKJB
	eWvAIaaOdA2VC/7wTl7Ei71sORDCRFL/2jdGPaA37Ol1O4VAkadx9fkqciEVc8e3pE24oiwPAza
	xJyP97hgtbZgBebxcq49NTaC+reYfwpYoRflTSHYdYGBcLoa15EkDcP9pONTdFA5JvxFmnHAsB1
	i0cMjcECvVK1f0yHzYer/Qu5Xow9AuVLMgsaWwaKSw18NLNO+vdAs6MY9GSkvEvJ5VsdwxiGBeL
	En70c/cniRdqt7kRI5/eKVq5ckIWY95cxsc6A06Va7QwIVUmBxWYKUK63sIKjN3EuUH9uk4NcMC
	PZ/dfAMIToxBIJlMTZ0yUh2KSqlDq8v0FzL4TwBVmvAXgTiSnDm52IOjMGuQDMXqDxfovRz/ZOi
	UvAXuf1G2tYw==
X-Google-Smtp-Source: AGHT+IEGBlLHx6Azb37x52GbpGa6RG/g5vSRbK4hfdeJ/a0ZQQ9d2uxDnQSAO6dG0F3Q2RqJaRySOA==
X-Received: by 2002:a05:6000:2301:b0:429:8d46:fc40 with SMTP id ffacd0b85a97d-429bd682dd2mr2975029f8f.25.1761914885258;
        Fri, 31 Oct 2025 05:48:05 -0700 (PDT)
Received: from [192.168.20.170] ([93.89.165.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13ebfe8sm3428499f8f.35.2025.10.31.05.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 05:48:04 -0700 (PDT)
Message-ID: <5dd8e39e-6fa4-43c0-96b0-d64a03caf3af@gmail.com>
Date: Fri, 31 Oct 2025 13:48:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] phy: sparx5-serdes: make it selectable for
 ARCH_LAN969X
Content-Language: hu
To: Robert Marko <robert.marko@sartura.hr>, vkoul@kernel.org,
 kishon@kernel.org, geert+renesas@glider.be, herve.codina@bootlin.com,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: luka.perkov@sartura.hr, Daniel Machon <daniel.machon@microchip.com>
References: <20251031121834.665987-1-robert.marko@sartura.hr>
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <20251031121834.665987-1-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Robert,

2025. 10. 31. 13:18 keltezéssel, Robert Marko írta:
> LAN969x uses the SparX-5 SERDES driver, so make it selectable for
> ARCH_LAN969X.
> 
> Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
> Changes in v2:
> * Rebase onto next-20251031
> * Add Reviewed-by tag
> 
>  drivers/phy/microchip/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/microchip/Kconfig b/drivers/phy/microchip/Kconfig
> index 2f0045e874ac..2e6d1224711e 100644
> --- a/drivers/phy/microchip/Kconfig
> +++ b/drivers/phy/microchip/Kconfig
> @@ -6,7 +6,7 @@
>  config PHY_SPARX5_SERDES
>  	tristate "Microchip Sparx5 SerDes PHY driver"
>  	select GENERIC_PHY
> -	depends on ARCH_SPARX5 || COMPILE_TEST
> +	depends on ARCH_SPARX5 || ARCH_LAN969X || COMPILE_TEST
>  	depends on OF
>  	depends on HAS_IOMEM
>  	help

This probably deserves a 'Fixes' tag, as it fixes the following warning:

    WARNING: unmet direct dependencies detected for PHY_SPARX5_SERDES
      Depends on [n]: (ARCH_SPARX5 [=n] || COMPILE_TEST [=n]) && OF [=y] && HAS_IOMEM [=y]
      Selected by [y]:
      - SPARX5_SWITCH [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_MICROCHIP [=y] && NET_SWITCHDEV [=y] && HAS_IOMEM [=y] && OF [=y] && (ARCH_SPARX5 [=n] || ARCH_LAN969X [=y] || COMPILE_TEST [=n]) && PTP_1588_CLOCK_OPTIONAL [=y] && (BRIDGE [=y] || BRIDGE [=y]=n [=n])

I have seen it on v6.18-rc3, and it is caused by commit 6287982aa549 ("net: ethernet:
microchip: sparx5: make it selectable for ARCH_LAN969X").

Tested-by: Gabor Juhos <j4g8y7@gmail.com>


