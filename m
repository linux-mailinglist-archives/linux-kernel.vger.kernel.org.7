Return-Path: <linux-kernel+bounces-788352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63368B38357
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 155667BCBBD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12481276022;
	Wed, 27 Aug 2025 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b9jrQ/bv"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE502F0C66
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299671; cv=none; b=WnJxLIWDp9n3rU4KoxPiF87HDYRhEjnSlMISWKXepLaGGIVVB9D83dr3fAY7Z88kBZIqkZQTLYuXk8UrMbN930z3gNY82K3D3OVXg8+ddG3BFHx0HnWKlc3FOcD/a92bSGYzQMTLeaMryRgVvR1/AernIHigDzF+IAplmf2fh9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299671; c=relaxed/simple;
	bh=hxB5lyREhdgbUBcOx3UJyF20LvnlKY+cAGXFsyaLqBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HK/HdGo0wQvYuE7d3zZU6BOE9Kk8ycH1jwDatuYsIvxhQeOL4V1zsME4YIc8RctnWF2K63VetfVOisfuTDYYLkPN7IdAgmZk4MD58bVK3FbUxnD2XKlyVnZTQqYtZwVy/O+NR4oEtP1KRFX0Ks/oMUyeW8m4lKVOLIPIj3EUNRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b9jrQ/bv; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a1b05a59fso51222665e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756299663; x=1756904463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HR0ZA4NZ0E17Q0Z6+d0qJgv1KmpugOB/InPQaoD7lOo=;
        b=b9jrQ/bvqyUhmac0mgQrgGlpMaYtG4ugRVamMtBvKByrnA1PBn3AZWIBZFelvmDVHP
         8OY2ppJ71PmEcumpolpIunrlPOFHmo6OTUskP13osQtc1bksVjIxbn04OY7Gvf6HOAnI
         BuFaL7t9XbWwKqNdlUVLFLJMQxMkY0meEkHNhhG1ZlZL8y2p69WOqEmvbAWUuAePt7ms
         vzQettJ+WJBj54FjXnXTDzlSiTinUz0suXtx5cMtH/QgS+cEEBasmJd1lBrBDM1G859m
         nP+LXn6ROH8f2B3522nVzbxjK2rBR+2p4u5T0S9Yw4VWk2ar34fhORYuTnST25FOZ4RA
         Ng2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756299663; x=1756904463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HR0ZA4NZ0E17Q0Z6+d0qJgv1KmpugOB/InPQaoD7lOo=;
        b=P6ue4YQPVyTl6d8zYKSkpGaD5QsoDY1rLX9vVIVs8YPl/AETGCskLLY1vD+Fz/Z4Qk
         2cMDdTKugMAge6yuZK21RZWY7rTPZD02c+/u+acsY6lob3Fv8tNBiE9aYUlrODbuqDCA
         IC/zmjrqeq9MKNVGI488xuJ5D9PWTMBUZNzs0p1zbLYnlT5DZr8bwhPLrOCIoftxiG1F
         pVQI6Wt03OmuSEax//b6Fx3I64tiCfQfSYnqpe2MSdAD3Klu/pSy2YN099b+a2W/FYAx
         pQ/Ns7uHmRi2lQCRf21fM2qTgDGzh6kgRs9LcSOfSF85zEj6+HReDdjC/ptu57TtdQgk
         C86Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7bGV8pPJBKkBbWz0srTiHZiaUwhQ0bkQbRf5nUBiFji1DdEN4OCEzT8aZ3TYWspyF8dajqQyOoaqfIWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuwDCWPNRoZmLGgf4cI5AHt/dGpR60Fc5/tCFLNk3krkJTrqN1
	YO6cCROuFvW0KS9o27p29DChBotTrwgtjvHkTrMzwSyAA99IkBmC/X52XRDONia9WF8=
X-Gm-Gg: ASbGnct9RgNc5RPeiQRTKtTWlEbO3bedjpeTPgJ7KX94M3KPvzFKWirGKacEb5TNQCe
	4eKpEVY/PJdiQFBrpCpx/whv2yjj6mn4VTCTyoHP8MDlAzwjgGVDL2cmKW2vpiz2JuL+dSI8ieL
	pBhbVmUCL35rRDAOZ1wgH2KZJtFyZqTtHMZyQY20OEtetAdM5/ZarhnmLc9+rXTAV961nUnzCxg
	uy5pmAO7DQjexZe7HkyrkkA9pCsk/qnulI6POFjoL3Hbr1uaiaEnK+nl1jfw9C491e9auw76BzB
	hSfq7nGxW10/ZLusiG8uss7j6kUZ4WB+yK0E4gTevzHIDC/Hz7ey7WGGfxFnYfSYq2t0VL1/CiD
	W7OyDmAK6dfjG38JZFI1PuYe2lQTT6Ic429z+Ug==
X-Google-Smtp-Source: AGHT+IF1J878zuA2zsA2LZmjU+Nf3PbWC4scoCL4N2DKNTYWqSPUxijVodiq3E9n32T4M+Wmjv6xGg==
X-Received: by 2002:a05:600c:3b0c:b0:458:a7fa:2120 with SMTP id 5b1f17b1804b1-45b517d2668mr180851495e9.25.1756299662976;
        Wed, 27 Aug 2025 06:01:02 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b6f2eab0csm29733035e9.20.2025.08.27.06.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 06:01:02 -0700 (PDT)
Date: Wed, 27 Aug 2025 16:00:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Ricky Wu <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@sandisk.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	"open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mmc: rtsx_usb_sdmmc: Remove redundant ternary
 operators
Message-ID: <aK8Bi0yIMW8-yb_n@stanley.mountain>
References: <20250827093530.416071-1-liaoyuanhong@vivo.com>
 <20250827093530.416071-3-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827093530.416071-3-liaoyuanhong@vivo.com>

On Wed, Aug 27, 2025 at 05:35:26PM +0800, Liao Yuanhong wrote:
> Remove redundant ternary operators to clean up the code.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  drivers/mmc/host/rtsx_usb_sdmmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
> index 84674659a84d..97bc3a2e3cca 100644
> --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> @@ -1169,7 +1169,7 @@ static void sdmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  		break;
>  	}
>  
> -	host->initial_mode = (ios->clock <= 1000000) ? true : false;
> +	host->initial_mode = ios->clock <= 1000000;

This is more minimalist, but is it really more readable?  All the
"redundant" bits are deliberate visual clues that this is a condition.
Probably the most readable thing is to just make it an if statement:

	if (ios->clock <= 1000000)
		host->initial_mode = true;
	else
		host->initial_mode = false;

I don't really have strong feelings either way...

regards,
dan carpenter


