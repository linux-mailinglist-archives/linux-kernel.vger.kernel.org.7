Return-Path: <linux-kernel+bounces-759595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0770B1DFD8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 01:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE96727A9A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 23:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B10E267F48;
	Thu,  7 Aug 2025 23:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTzFtmil"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CF6256C87;
	Thu,  7 Aug 2025 23:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754610678; cv=none; b=Pg1Ol1wTWzLYNyEkw+pgK4N31eUNdedpeezOxPAvHYoZn/iZjf2kgS59L3RFN5KCjScjd74lTRKZ0dIRu+qpRQvosDZnSEPf78csi0flrh9x5zmBAV5NdTOroEv0W3pcZu+inZWULAHGrGFM5t88USteq2LyZzMD9Y5gEvQA9e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754610678; c=relaxed/simple;
	bh=r6GdvpWaL3cpLLqsdi99ytb15e6yqHPdubboS+65pyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fG4jLxSSe4m1F3DyXxOMS9cK+BW7ePtS8Arr2lsXUD0u6cAoCipPbjYHhTdII9XgEBuQ5PWqRgyVo8LX6n0JgRNSgPUkHgkz531cJ+OYISSSe/euiV2wnC8BTqMniBTyqDw9yuoWJsk/psPTbQcY3OxR+fELBbcEtn0RnN3j57w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTzFtmil; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76bdce2ee10so1451029b3a.2;
        Thu, 07 Aug 2025 16:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754610676; x=1755215476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZqeOHkesYJCTX0u/WgubNDClPRMqiv7yAMC5mG65rhs=;
        b=bTzFtmilgnGUWXlq0WfZJyD+8PU+xMd+8wiPSvK6lBXhYQ7wbiLxkrQsAp64UmLbjJ
         a97Ces6FK9jxG7td5KeYiaYDfuoNNtE58280tcYsxbwDBdA3p+xC5fh90b2Ga6ppHvhS
         l9v1WgiSVq5tKFksskbGWv4VqY2ApMExgf4MrvKgRxIFswwpBszVf4tPkl2gESLe2yvi
         el9ETwY6Yf7xUrmjlaD9C79W0jyY2srf/zDOL4IOOcrB/D1BAseOgpNzld66iQooaAD2
         MpRoJc/wPjAgtNDWgmccI2w9eygAwy+/7ZkprX1nex8keJdeF1OMhQXqCNyk5hoV1iWD
         AO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754610676; x=1755215476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqeOHkesYJCTX0u/WgubNDClPRMqiv7yAMC5mG65rhs=;
        b=YsF+QVVXqfMIC4Z3mdZ7wSR6wXqknbFmqLnGNzKlmIIxhBxcu3lesXMajSxgb4412S
         tLHD3z3G7aACTv+nO6QuZHNDwdtSf6Hrqg2+dYEa6IUgsjsjerZ6ZVEr+YU30aEkYdbL
         wnVfQcGeCGJ6caQCHcVPmUOIQRwAI4B0bo3pVmfDn/xSo5dW7jlL/g5oFtl7+L+krmXC
         /YVOzlrmCQVk68Okbl+gwcoSl94B4EqLkJ7xF82bfQXkyLdtzIRwESWANEIMGc10DahW
         0JEkDWDaFsFlUr54u169pU87sjqZsDGe6MKl6AzSMmz+CiS/TYa4cqXcWFj4L2h4hDF5
         ERFg==
X-Forwarded-Encrypted: i=1; AJvYcCVzqJziow0x2a7/FBm6tCV38NoPO+Z5FcjcYZyiu6syk4iKAzozkn8zkSi/bh6RmAuIPb8uXzW7lBMk80Q+@vger.kernel.org, AJvYcCWTpSBjI1iZ4tXXYwXBf1BdB53PJv8JsrLk3gZyehZ2vll0yibceZUj7Z6ALXDwJqUEyDmrrNYYjA0bcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEBzuITkudyAu8HE57MKmqmoo3tULzNYEvziNQ4T++v8o4l4MA
	Wg0TdDgLmR3tqbH/BxSmpoLS5RLZg3LjuoEw581HC3ieLecx08GRM0MQ
X-Gm-Gg: ASbGncuPXlgeZmcjNMUQnIsc+29+vmp4aBi5HbTbglvl7ap9uaj1SkrLyXBZr8Lzbol
	9bMbcpYdHp831Dz2+Ke/FOTz1prIv9tloYKYkpRTTNDgKc+/b+wGa55OgsM1QArIOKleBoGRKqG
	g+mYn8MmjyExMFnIY3l3E3XoJv5p0vg1YuG92RjQ8X1tH1zBmFCGIBfeVBCsQ9ElA+2de4nk9/L
	EYAfK6G29EFaFW4lrew6H4ZbflOhQcGQn0tvlQWnLNofR941kUGsjmEo5XBalm4XWXLq7p9vjGm
	WFKZvm3GmSqVZYBU06TCwy5nL+XSu8CbcJwUrBLzqOMDdBqRshdZWgiNMznfvd7+c1VkMnfRq8f
	Ou3kcQtvA3dG0YRz5hRtIk2ECrFAeeT60i60=
X-Google-Smtp-Source: AGHT+IHavm9k9+nMEll8HiyEa/LrCnzXl/WZ5Vi8uwM5erzCzX3se/wQYFcv8BYf2F4sqH+5MF0Mtw==
X-Received: by 2002:a05:6a21:32aa:b0:240:16af:3ff5 with SMTP id adf61e73a8af0-240551ff7fcmr1158273637.44.1754610676341;
        Thu, 07 Aug 2025 16:51:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce6f6eesm19059339b3a.22.2025.08.07.16.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 16:51:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 7 Aug 2025 16:51:15 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eugene Shalygin <eugene.shalygin@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) narrow lock for X870E-CREATOR
 WIFI
Message-ID: <4a1f9ce0-70ad-4ace-bb96-44870651039b@roeck-us.net>
References: <20250805203157.18446-1-eugene.shalygin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805203157.18446-1-eugene.shalygin@gmail.com>

On Tue, Aug 05, 2025 at 10:31:48PM +0200, Eugene Shalygin wrote:
> Use mutex from the SIO device rather than the global lock
> 
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
> 
> Fixes: 3e538b52157b ("hwmon: (asus-ec-sensors) add ProArt X870E-CREATOR WIFI")

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/asus-ec-sensors.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
> index e2f7b8705cb1..83047c3263d3 100644
> --- a/drivers/hwmon/asus-ec-sensors.c
> +++ b/drivers/hwmon/asus-ec-sensors.c
> @@ -409,7 +409,7 @@ static const struct ec_board_info board_info_pro_art_x870E_creator_wifi = {
>  	.sensors = SENSOR_TEMP_CPU | SENSOR_TEMP_CPU_PACKAGE |
>  		SENSOR_TEMP_MB | SENSOR_TEMP_VRM |
>  		SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CPU_OPT,
> -	.mutex_path = ACPI_GLOBAL_LOCK_PSEUDO_PATH,
> +	.mutex_path = ASUS_HW_ACCESS_MUTEX_SB_PCI0_SBRG_SIO1_MUT0,
>  	.family = family_amd_800_series,
>  };
>  

