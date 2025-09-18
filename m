Return-Path: <linux-kernel+bounces-785438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F46EB34AA4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24BA65E328B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C040927D770;
	Mon, 25 Aug 2025 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GIMBXs1n"
Received: from mail-yb1-f226.google.com (mail-yb1-f226.google.com [209.85.219.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FA4279DD3
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 18:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756147839; cv=none; b=gpC1SACOHvwrnMvNysRJwxSiG1H7AUs8FSq+WiyhL6jFFxgDFf6IQjabOwJlYVc1lfYZWnoryrg5cWQGSjNcJ9cdGSRn0ZrTHaFFNBLDi2971FvoP/NtIkhJ6NSAGP1LmTOlMsRSUrG+oIAjW1PqXywLoziBQR4BFrmebauvvzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756147839; c=relaxed/simple;
	bh=LgPf7tO7LA4Nq5C0p3/tFJPAPdgLytXg8fU47WqWOAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7TBFciM318oSjo7DtT+rL7yPF+RF2WTdhS0Rgy/zvG5vRgR08tNSMSqqx9BiCUjcVzpdXPAZv5pCs/SOsVqhTTlXPmm8n1zT1K+D8TzlOa16NGItaCtu4Ld6ynBtcjZOWEdxAPty4zXtuz/DbmGO3ex6UzepaCxLG9L1FiX3Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GIMBXs1n; arc=none smtp.client-ip=209.85.219.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f226.google.com with SMTP id 3f1490d57ef6-e951dd0689bso3045942276.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 11:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756147837; x=1756752637;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=liJTTmWIhLEKq1u6NIvPKDgRgEjQMcr2uJNbg3L27ug=;
        b=e07jj7OZKbq/iZgxO4nqmFpAkp06JRiyc/hAaYlQ7EUvFVfyOEEeX023eWeWlXL8ar
         C4ipCMQKTXFYTt9F61YzCf45KTT35iUDKYtWjT0r9Q+bU6fgZvaGGzz7YIFdGqNYi92/
         pjV31JZbnITELvly4OIAfkxdnlmq23BlEXvMIbQS5cg2c5KkJA0RgI5CpPQ1CgH6EhIF
         fdNPzgTf7QxfoGdKYhdVHzbjvPNgqlV0NEsCPcincLe9jOSn6TahKwbv3nAGWKCirPyJ
         vOqPTXd5BoQbl7crROBOKXaf3wTPp8CMVvUJNkgpcoBDWyv5HTshTYKy4P9xFPJePvJ2
         iYcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVy5TFhk+sfrLscHkYiA1fqTu06NgL2D6Lt7XRhs6SbWnUoh1KXh+BRCiEZjD930nxu2VlGXYeEhHqzQ+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIybBVjlB/pvB8v7/g3huAQyGyVyZ1US5zP8SCWOOVJPn0eY+o
	lj4xq0y2PjFa6fkMixTQ0yS4qp02G9rMTD5b6E3t1QihyPhO6JVQExMlQqnA2sEPwM1+018R6Zw
	nxzwrU1ufQliX6x0hVOHnwOs1oeM0tkWj4BHKMp3eV+TzFR3uVhY3fcYNsd/dw2n0oUTpV9B+bU
	800rPgfBlXHUehakAn7FTFJd5faDplMj8gmbTXyb5F0NrHQAX1BkYG+8N2px+yevlL6LtCW3z8O
	Kh/9NBK8yEU8L0ccW8Zsl/7Mw==
X-Gm-Gg: ASbGncvqOudE26a34KCuDEIpqJX5awq33CKluQ+xpJ5vUqmrKg0FSbfiXZtZRP/BoCz
	KV4S0VwOxw14USd5HCkCD0StLKRIL5lP0xpprAvi3AukGSuGqqJ7QjSkoT98QysCuaA5/QPWyHU
	tYjwq1x/vgUxcnG5H7xfri7R8HVu6L28VTKK7IrO0VplZPq4ambmIWacA4tbN024JtO/iXqyl+H
	DP+dr0UncUJMI5qVWd307dqTgMYxBvVvG0tO0R6wKK1G16GmEqgs44jaQN8vAS4DQTFkVMKALvE
	Ugd1NnS+tiSzDuOo2IEv7hBeo/CF9chGiNftTkG56b+mkJQsMr8P5o9KTqyCa8Nfhl1HIXiBkK5
	lnkCwSky6i66dFfrnaAgbgpf8zQDxLYaTxL7xIVNX0y/MuqIijYPUYLhoKGkfKr9yDMp3Ut7p0C
	GIneg=
X-Google-Smtp-Source: AGHT+IFnSmIfwpO05zsYuOil9ohjy4rng3svvuBDFy8ItI/WlbJM/9mvGi/+Nw5vw4SoC8iTxehMZRXnBTPK
X-Received: by 2002:a05:6902:1505:b0:e90:63e6:afcf with SMTP id 3f1490d57ef6-e951c2be3femr14509344276.37.1756147836913;
        Mon, 25 Aug 2025 11:50:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 3f1490d57ef6-e952c29526bsm601500276.8.2025.08.25.11.50.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Aug 2025 11:50:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-afea26eea2aso3159966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 11:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756147835; x=1756752635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=liJTTmWIhLEKq1u6NIvPKDgRgEjQMcr2uJNbg3L27ug=;
        b=GIMBXs1ndciUy9oTrFYuMoLTJ34XA9tfobZZm+H/WzmIVMS6ebaB6q5btAwbETvS8S
         FQRdtDNRWGq3YzrBnJz1RDh1FvD+I2GpfmnGG9W+mkBul5qpvE32fVmQ10EpS4W1l8KX
         bw9BCccY4vTO7DeMCtYE069sONPF2nTK49CgE=
X-Forwarded-Encrypted: i=1; AJvYcCXD0rEAvVd6VFoJX1jwo7XR6IXfV+cu7MzURCdaszVgR/JFgstNO6IHOui5VPFW4lpBDp9RaX8hTx7+Oys=@vger.kernel.org
X-Received: by 2002:a17:907:d644:b0:af9:6863:9d41 with SMTP id a640c23a62f3a-afe9ce96076mr50858266b.14.1756147835295;
        Mon, 25 Aug 2025 11:50:35 -0700 (PDT)
X-Received: by 2002:a17:907:d644:b0:af9:6863:9d41 with SMTP id a640c23a62f3a-afe9ce96076mr50856266b.14.1756147834837;
        Mon, 25 Aug 2025 11:50:34 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe48fc07f9sm603202266b.25.2025.08.25.11.50.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 11:50:34 -0700 (PDT)
Message-ID: <11546959-3090-4070-93fa-349bc64f3bdd@broadcom.com>
Date: Mon, 25 Aug 2025 20:50:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] wifi: cfg80211: simplify the code
To: tanzheng <tanzheng@kylinos.cn>, johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250825055123.960168-1-tanzheng@kylinos.cn>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20250825055123.960168-1-tanzheng@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 8/25/2025 7:51 AM, tanzheng wrote:
> Simplifying the code makes it more readable：
> 1.Use dev_name instead of pdev->driver->name.
> 2.There is no need to call wiphy_dev again.

Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Signed-off-by: Zheng tan <tanzheng@kylinos.cn>
> ---
>   net/wireless/ethtool.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/wireless/ethtool.c b/net/wireless/ethtool.c
> index 2613d6ac0fda..0acfdc44b479 100644
> --- a/net/wireless/ethtool.c
> +++ b/net/wireless/ethtool.c
> @@ -10,7 +10,7 @@ void cfg80211_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info)
>   	struct device *pdev = wiphy_dev(wdev->wiphy);
>   
>   	if (pdev->driver)
> -		strscpy(info->driver, pdev->driver->name,
> +		strscpy(info->driver, dev_name(pdev),
Did you test this with some wifi device before and after applying the 
patch. This is not correct as pdev->driver->name is the name of the 
*driver* and dev_name(pdev) is the name of the *device*. Those are two 
different things.

>   			sizeof(info->driver));
>   	else
>   		strscpy(info->driver, "N/A", sizeof(info->driver));
> @@ -23,7 +23,7 @@ void cfg80211_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info)
>   	else
>   		strscpy(info->fw_version, "N/A", sizeof(info->fw_version));
>   
> -	strscpy(info->bus_info, dev_name(wiphy_dev(wdev->wiphy)),
> +	strscpy(info->bus_info, dev_name(pdev),

This makes sense.

>   		sizeof(info->bus_info));
>   }
>   EXPORT_SYMBOL(cfg80211_get_drvinfo);

