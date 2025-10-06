Return-Path: <linux-kernel+bounces-842637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FDFBBD369
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 09:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 49AFE34892B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 07:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22559255222;
	Mon,  6 Oct 2025 07:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B792VVeg"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B84128819
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 07:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759735818; cv=none; b=Q1dDuOMZAPx4Asu7cnLQ8dZz/lAh7x9IkhJtRALLlXR7q4KN8KADzU/KltvM2QutZUqQzmkimDGdZ/Lwazi8XQCRE4031jctAnIljk02UmixR/0TiDtvRGnmI6/D92umCzbHhC9IWxcU+QrtGvv5celr3dwtuiS1H2BkCEcg5e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759735818; c=relaxed/simple;
	bh=ZQRchX5XNIjfkgA4fLsxerAd7QtYqk1aoXp2CVgu4dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MU8L22QRIOrbnOspsaGJTlGKUh/YaLkdYKV4kQ8fVh2H+HTB2Rbdr5QBGYiua43Re+jY8PuamqvlzSJwDr3EwtTDrHibBjgpAHC/7z7GDqvwS/3QfddBt1FvOYsa9MKE3/cSxS1TCHZ9pZZBskl+1FUTr2evSbT5AcBnUHXrGDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B792VVeg; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46b303f7469so28368535e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 00:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759735815; x=1760340615; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uf4L8RA/IZXS6HOIL8R8teBc6YGCc1dTgFC5yo9YzMI=;
        b=B792VVegVxwYsPZR3jBjot4Q/7uQwcrWqPjICw/mTIxEQXpS3MeseHr/0SEXf/hSjH
         aFiZ9O3atrKq2PkxYXeH9vYnMkzQo2T5lCdTDvCGSOOsFt9tmMsVkc5hu5VRcI1TfhKO
         RjFgs7+jUfkwi3FkOl3CI6oZPS9tzNW9VUEaL770NOx4YDPuMQ6WNE+n3j5Sp8HLmuRH
         rg70C94qEUaYy+hp+ZpAPDIlxFX2vK1vlEfzfQYOHkY+Sps8Cj+V4Ma93DSbE3EUaoU3
         6idEG3prX2OaCZjSEgGUVXdNwvaBOB3kmlfTKAmiLct2HiZ1PM7BCmcuW9XaqN8lmZLC
         Ehmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759735815; x=1760340615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uf4L8RA/IZXS6HOIL8R8teBc6YGCc1dTgFC5yo9YzMI=;
        b=NZ4hbdvrDbX+6jbHIdxMyen/z/GFbbXg0nZG7XycvnnIxvcb0gp619bPpJ+AlnT5ey
         c0KUkLyPsJ7k/iFqFDtUoj3zGiOiPFD6Plr7rNWlmqlButuEcD/J9fBqy8VKKEPI1UTf
         nqnuQ7/kt4DJz0KSFEcsE72KBNhVO5pGQQnh0II52P4IArm43YrwTq+DN6w+O8hqYrkP
         Aj0XabTFvMS3qvu/2ztBdhl426+vr8auCyF9oZ5kqmhykyT6wP0Snh/zVnzpxhHXeVDA
         Gv/vJx3LWBcoKYJFEFpX31KWK1f2a6/V5V8PC/HlL2BhQSGxK1zpffFYsdOGPS+HR2nA
         7slA==
X-Forwarded-Encrypted: i=1; AJvYcCWfD7PD0wtLJW56Dyh3rSG03F+6doOY78E17HuTuaCIJ3yIdBXO+UHijSunLpWcT2ynDrEVrgyq+v2kS0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YysMojYMqkELgIU9i3hBo+MDPYhdatlp1vv+UnapjBNUjoESwVZ
	viYvDIWsIp3KaWxLzfEeXylcqH6ZBavEp53kQjFX39hcGDtropOAs1lFC5o5E4zOckk=
X-Gm-Gg: ASbGncs8tBsTgdP4mtHfo1bynpS9mpGxUUlFRkf1SMwhd0SCpxWQwSbnU/2jdnc0s41
	qhOCE1+Mn1w+Kwf3AqDzc/wqcKOknyCOFOCixysf28d34PeiMwio6PeWGf1x2FWzRmyfGQpFZvv
	UhH2OsXJdeZwX2j96QsnpfKbSaSMPddzp+Nhap/iS7uVqYCteLj9w97F56+WYUWwoV5ayPrjEZY
	i5ire9nG8MUAGbzB0UjeY5IIm6KOk8Q8MgMxONyO3YItR2zKlUl+qaQHM8noY1aqqovAyhnvB5Z
	2eVbHzBFzCWQhtFZdrhDVrbPoMxviFsi5hznhjrF9/fU4eqYW8fKQt2HETsG+DyP10KFaEchjxt
	m3qEfljJgwdHbfyfMJKuiaa6l9wtfwLGuMrg4Pa/teZYXy9IOo1Pwepot
X-Google-Smtp-Source: AGHT+IHiuM1xHkBMQnAT7uqFLgh/CgZeXvWiOZCyevwvHia0yK8WCmbmVIHa/xjRLr6XfhSV7yHHmg==
X-Received: by 2002:a05:600c:8b42:b0:46d:3a07:73cd with SMTP id 5b1f17b1804b1-46e7113f6f4mr71668335e9.23.1759735814631;
        Mon, 06 Oct 2025 00:30:14 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e72374ac5sm161139725e9.18.2025.10.06.00.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 00:30:13 -0700 (PDT)
Date: Mon, 6 Oct 2025 10:30:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rohan Tripathi <trohan2000@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] staging: rtl8723bs: split long comments in rtw_ap.c
Message-ID: <aONwAXk2EcV9Bgrv@stanley.mountain>
References: <20251005155920.381334-1-trohan2000@gmail.com>
 <20251005155920.381334-3-trohan2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251005155920.381334-3-trohan2000@gmail.com>

On Sun, Oct 05, 2025 at 11:59:18AM -0400, Rohan Tripathi wrote:
> This patch splits overly long comments that exceeded 100 characters
> into multiple shorter lines, following kernel coding style guidelines.
> 
> This is a coding style cleanup only. No functional changes.
> 
> Signed-off-by: Rohan Tripathi <trohan2000@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_ap.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
> index 93ab0015ca89..2c906c1137bf 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ap.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
> @@ -391,7 +391,9 @@ void update_bmc_sta(struct adapter *padapter)
>  
>  		memset((void *)&psta->sta_stats, 0, sizeof(struct stainfo_stats));
>  
> -		/* psta->dot118021XPrivacy = _NO_PRIVACY_;//!!! remove it, because it has been set before this. */
> +		/* psta->dot118021XPrivacy = _NO_PRIVACY_;
> +		 * remove it, because it has been set before this.
> +		 */
>  
>  		/* prepare for add_RATid */
>  		supportRateNum = rtw_get_rateset_len((u8 *)&pcur_network->supported_rates);
> @@ -655,7 +657,10 @@ void start_bss_network(struct adapter *padapter)
>  	cur_ch_offset = HAL_PRIME_CHNL_OFFSET_DONT_CARE;
>  
>  	/* check if there is wps ie, */
> -	/* if there is wpsie in beacon, the hostapd will update beacon twice when stating hostapd, */
> +	/* if there is wpsie in beacon,
> +	 *the hostapd will update beacon
> +	 *twice when stating hostapd,

Missing space after the asterisk.

regards,
dan carpenter


