Return-Path: <linux-kernel+bounces-732336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6F5B06549
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 19:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 504C41AA179C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B6C27465A;
	Tue, 15 Jul 2025 17:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCrHXFKl"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238D31CAA79;
	Tue, 15 Jul 2025 17:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752601084; cv=none; b=cAtH6OG1pC2zbSTBv78GqnRxJ0FEa3qlvLy40ZQoP/u9zUNxgceGNtyKu/dtULrWT3XtT5Pw3ws1HZoBT8RlsKAaBTNWQ8lgGqPWzoi+Kdqh+8WrHgUi0blbC/dSIUqy4CjbUOFGfChl7Evq72XO3tsQPfqGaV3Qz6noDvLYBoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752601084; c=relaxed/simple;
	bh=RokskiVnHeDOIkG3Zrje271ADxomOe2tpD8OefT3e48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2Mlo0vdUB/bIhbnUo06M6uHBj3OGH4FgV0MFhHJZg7iXN8ttIQzGTD0mfkB/7+t74p3Q6Ph5g/yRF75dWOOc6LFPkZCaM+mJCBIwq0/XG1nLC4mVXotkZf+DDIh0mOh418TNrr3yMZ/rng8yxBJT50dC44Dws4ur9/qkgOS+8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCrHXFKl; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-235f9e87f78so52434855ad.2;
        Tue, 15 Jul 2025 10:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752601081; x=1753205881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VJc/XmJl+S7tRYzSOTC45bBg3wo1MIlmmMY6O7r1Xss=;
        b=eCrHXFKl+mVNOYHR96pgXBXsQImEGykBxhxnMroM/ZoNC6fWsci/Waz0iWtF2n93vf
         ZF2D7LY4RGWqYBX3RAqqXvLNsDJmhd87lw2zqh6oVd/j1u/APU6fGXzIzEcSohpWhnFS
         WzhmpDkAgwBTC/5C6cacCOzXTm0YSkb3s7cvcj0t/fCb+57x4IiNbmOf9XN7UVKsHoAy
         m2bAgauJRwE+auqzAovJXJGfkAt45h2vU5j08nlLaRlWXDhf7ptjRttv+E3eISh3eQR0
         Ry6mBSsn+7A5vfz6vORGv9ypmhuE9B2rgzkGCVo+ey0Zih6T5Y2fWaPO1Klb2v4ILW+Z
         hkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752601081; x=1753205881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJc/XmJl+S7tRYzSOTC45bBg3wo1MIlmmMY6O7r1Xss=;
        b=sh/eeGWAYudySxcR5ERzVTeQPXlSvyiOhHnJA10zKuRWbOK4LS7jmPk/AVGqCeZ60U
         vUMVZ4SANnYWhbur5cwtWMmBqIZ/6iMDrOk521jW54vmW79k/Ok3J6+V2rZ9nU85Uh1V
         TH7CAp29qecgCZNBKfrb8cw6o+eb0rSaTHTrAwCpOyhYAdUEvD7kGjPA2eR42wYboHQI
         s4KtQ5WEDTQt9/I15yorEuYLJ28tcUk248GSZzQ1TBIsElJZLJDQlSt+gnrCWkNBB0fi
         4x+Ful6LG75sPtVzStnFf36VL9X87MifiR/EBu63vUc/IEyXiJDnLWyDG0+QL19qVEYL
         c9rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVTkmDmsiRve470mFJrZIHzfwaBIIcS2MbqUOXr50092gzYfRMBZk8NAaywCWjn7LCBlioJGMWtmV5HN8=@vger.kernel.org, AJvYcCV7jFNW5lle4uts7AgyHfYYB7lhnOUBDU76aBchl9IxelBDl61ZJmxtGddP62U5usnLsCuMycZkpGOyInFJ@vger.kernel.org, AJvYcCVPHE2rdpbmT4JdmoIfihndzCiR5BBHUIcyURfIuYJ3CpMqWR1oLzloojTI3KWV2vrk4eBKmc10oSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVO7ET8PK4qx8cQbxnqyZqWvycHjNxtlsTRw0owQVibgMzwXxI
	VMpTLPqMdCRJ1iwxrN/7Cn+enUQVCueHa+uRz4W0XkzSWf9kgKcqTfybjNLptg==
X-Gm-Gg: ASbGncvJ5FDjD94rkb6W3/Pfyn3QPrN9x7HZlewJrCo9FHDlsk63LIPKnyOrhjq+6l8
	Y0Bj2R1q2G4bBsOLymH201R/boUvfEeXkNkeUqkM5VpxWqLtbM1s9E52FXAeOzRxPRYtTj9Rff/
	7nPKUPIkpcg72AmlnYTsnD/AGFF/tjcd9RD/oB3/4ShifZ7rxNeMAWQp0khCCqwlN7aRa2EwhU9
	rltz5QA0Mq2rXPkXwMrpa6ydz6/GyqhFnoqJJqMhzc3elf+BreKtZRhpVUmorvLzPEkNecE9f9C
	gy994dkIiLcu0mT9r7pmXDEXlw1qpJt+BuHIBWxKPqKey1i63I+btLsiEx5j6lO7f4U24o3WRUW
	vun2A8i6EV9w9L+CKb7KIaHTfv1spKrzbsI4=
X-Google-Smtp-Source: AGHT+IFDx7osl3hyBqFwE1F8HYPIldvFoWsc6rInox4Un+XQ97hWb9Rm9pMGGTV5j+tjtbkS76vbvg==
X-Received: by 2002:a17:902:e947:b0:234:9092:9dda with SMTP id d9443c01a7336-23dede7d49bmr328233875ad.24.1752601081050;
        Tue, 15 Jul 2025 10:38:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de433e527sm116815505ad.187.2025.07.15.10.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 10:38:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 15 Jul 2025 10:37:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Wenliang Yan <wenliang202407@163.com>,
	kernel@pengutronix.de
Subject: Re: [PATCH] hwmon: ina238: Report energy in microjoules
Message-ID: <a42af051-c9d2-44bc-a8ca-2dcbe9380863@roeck-us.net>
References: <20250715-hwmon-ina238-microjoules-v1-1-9df678568a41@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715-hwmon-ina238-microjoules-v1-1-9df678568a41@pengutronix.de>

On Tue, Jul 15, 2025 at 03:02:41PM +0200, Jonas Rebmann wrote:
> The hwmon sysfs interface specifies that energy values should be
> reported in microjoules. This is also what tools such as lmsensors
> expect, reporting wrong values otherwise.
> 
> Adjust the driver to scale the output accordingly and adjust ina238
> driver documentation.
> 
> Fixes: 6daaf15a1173 ("hwmon: (ina238) Add support for SQ52206")
> Signed-off-by: Jonas Rebmann <jre@pengutronix.de>

Applied.

Guenter
> ---
> This is a fix for a bug introduced into ina238.c recently (6daaf15a1173
> ("hwmon: (ina238) Add support for SQ52206")) and merged into
> v6.16-rc1.
> 
> Jean, Guenter, can you include this for 6.16, please?
> ---
>  Documentation/hwmon/ina238.rst | 2 +-
>  drivers/hwmon/ina238.c         | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> 
> ---
> base-commit: 155a3c003e555a7300d156a5252c004c392ec6b0
> change-id: 20250715-hwmon-ina238-microjoules-3d8edaa5ded0
> 
> Best regards,
> 
> diff --git a/Documentation/hwmon/ina238.rst b/Documentation/hwmon/ina238.rst
> index d1b93cf8627f352612f17953c62efc5ef5596fe5..9a24da4786a43f7493b364b005b2ae9992c3b10d 100644
> --- a/Documentation/hwmon/ina238.rst
> +++ b/Documentation/hwmon/ina238.rst
> @@ -65,7 +65,7 @@ Additional sysfs entries for sq52206
>  ------------------------------------
>  
>  ======================= =======================================================
> -energy1_input		Energy measurement (mJ)
> +energy1_input		Energy measurement (uJ)
>  
>  power1_input_highest	Peak Power (uW)
>  ======================= =======================================================
> diff --git a/drivers/hwmon/ina238.c b/drivers/hwmon/ina238.c
> index a4a41742786bd19e1c5dab34c7d71973527161a1..9a5fd16a4ec2a6d5a6cd5e8070d0442e1ef0135a 100644
> --- a/drivers/hwmon/ina238.c
> +++ b/drivers/hwmon/ina238.c
> @@ -97,7 +97,7 @@
>   *  Power (mW) = 0.2 * register value * 20000 / rshunt / 4 * gain
>   *  (Specific for SQ52206)
>   *  Power (mW) = 0.24 * register value * 20000 / rshunt / 4 * gain
> - *  Energy (mJ) = 16 * 0.24 * register value * 20000 / rshunt / 4 * gain
> + *  Energy (uJ) = 16 * 0.24 * register value * 20000 / rshunt / 4 * gain * 1000
>   */
>  #define INA238_CALIBRATION_VALUE	16384
>  #define INA238_FIXED_SHUNT		20000
> @@ -500,9 +500,9 @@ static ssize_t energy1_input_show(struct device *dev,
>  	if (ret)
>  		return ret;
>  
> -	/* result in mJ */
> -	energy = div_u64(regval * INA238_FIXED_SHUNT *	data->gain * 16 *
> -				data->config->power_calculate_factor, 4 * 100 * data->rshunt);
> +	/* result in uJ */
> +	energy = div_u64(regval * INA238_FIXED_SHUNT *	data->gain * 16 * 10 *
> +				data->config->power_calculate_factor, 4 * data->rshunt);
>  
>  	return sysfs_emit(buf, "%llu\n", energy);
>  }

