Return-Path: <linux-kernel+bounces-800191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E52B43469
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87063A5BAD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6932BD015;
	Thu,  4 Sep 2025 07:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xW1589Wh"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A023429E11D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971779; cv=none; b=hBS0X/SzMo7i4BAw1gco6/rvaFg5+WQML+F2nOdUzUdrJGCnLl0eewgrcVpDeA7uWYMOk3fAm6niI7mCr2dWBtuXV+dMLk21wHFYpqdG/dCgeY2LQC+8VOD24ByYm742uLD2KNZTdz5bX4Dg+axF1GDVCRs3cpERuy6FVXnuF68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971779; c=relaxed/simple;
	bh=ZaFZpuefFgzZpMrXGV6OywiSg0kF8Ybw36uYEX7yPQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoqSb6615Qcn7sBbq0LZ+DpqMtucbyOcBY6Er32TynY3C59Q2X+3qPVOfZ58Fpdh5LbbeTbT2UOEa4HrTPydo1tTWsywenFbf+rtcHRVGYmCKTnjHynlpPAuyo+b4QcAvq1XVy8jaVTWCw2WauSwQKfLhGvsGPAZGDovBIkryDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xW1589Wh; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b7722ea37so2929265e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 00:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756971775; x=1757576575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PE1WEm0x+xTSY0iMhqlk9K01ZY7gt87ogAjaJwXEInI=;
        b=xW1589WhtSiPKPlw/dypU/6ZR9KItV8E9v1S9KloUtfctUFvo38LN+JhCMkTj4k5bm
         nl0OPDNYSLQXPHkPGLKBeXc8JdFgafQxCuaZKYecc4g8A9bIi4mTi1+xyH4vIPrf4l6x
         C8OFz8mWKOLRT3Aw/9qW1xt0nZ/Z18u3GXtgYJmFMeMf3g+GvCyxdccGmp7NthclNDJD
         w1UKsKTbW6h+Mbnxm5sP7FrK1M19FIsjX7EJNuMNSL9EnROYg3pA9ONpooT6eSlozJuz
         BZN37s24fYByKdKznErlmP5o1GLTKcDj4YfQB2wWtQR/dwkuYD0Vr6zbwJgyHkeLwsWS
         kRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756971775; x=1757576575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PE1WEm0x+xTSY0iMhqlk9K01ZY7gt87ogAjaJwXEInI=;
        b=v0VYE8vjAXgGpd1Tcik5blFAqfY5BbjZJ/r36C+DRAA2GGwdBOoIPblRhecExMiogs
         +1OYxwZhLvQaaiKH1rXmT2/o64Ahexr1AmAeePI1RDAoJk838xe69+9ago9AsXUn3iJ8
         baWpLFuvCuQJo0Jc+aSNtsMcgjclRgcWg0WHZWKl7AcYfAAa+5zNXMrpKeSABMribisg
         lAVkSlVlMWEMLGBp+AovIOdLtyCQRyWK0rnLBYCxnvzgm1xg9gRX3xffkFSRTsGKzlOC
         PcWBou5E+dIn5rvD3SlACNz5Lr9gncnqHPkruZq7xw0/cwTtzj0Xu3DKAM/vcEKz2dMO
         ISeg==
X-Forwarded-Encrypted: i=1; AJvYcCWiMZjKKNg6ye9y3QawJ6nNio7Nk7GmNSEh7tNyFvo90K1L7yQm9UeVohCCIfVNbVmoREt3ZsZONB4uEY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrLWgtD0Ehhyx8f7q4wURtQsghhYDaXyaK+ohxWE8SnUgv/TKd
	upMP+6GSyCHFtw2oZ6vze0XHk/7f5TW4llwIWbqrC2GuRJtRZnlUesQYjGVtJsIQ2Sw=
X-Gm-Gg: ASbGncuY3zf5wc3r3NdHx25KZQz1ZV/nQihy6O7Q3dbmnSZ/Vbzsq0+BqSwim6K6eAj
	MQMUWQtt9yJ/gwzIwCY6Z16O/0krzxeZ9tdb+aYmaKNcKB4wBvVFihAa6KJRBfBlrMTCzQxHxtE
	OiTtcG46LI4X+HgWHKCDhnHU6agnn87PFCxenkXIOzIzlNFmEhIzOiS2o7KEAfe9LmX68trOJxA
	fPlvF4yyLlEIC2VMyqWa9EGSN1kdstU0dvVIJ6aYHIhACOAp22L033Z0X4rmsHOrFFGigSGYXb1
	x6q64dEL6HotiL1KOj4yRz+4BTTk/Pwiy3KiLlVcMy2Qv2CYE1tTFFd3Vt4SARvJxnhXiSjzFCg
	O0cuXWZF0eY2CXVIsEkokr8mLUPPTi/c3U7YMwjt2ULFe5tDz
X-Google-Smtp-Source: AGHT+IFqEKV1dOU6AtGVeQbAA7dRuZZOzzWKEs0hUSqjXwiB8fUJpq/jUJLWO3K7o6PoM/UBdUvBIg==
X-Received: by 2002:a05:600c:a419:b0:45b:9b9f:88cb with SMTP id 5b1f17b1804b1-45b9b9f8af4mr43283525e9.16.1756971774749;
        Thu, 04 Sep 2025 00:42:54 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45c6faad9cfsm82663845e9.0.2025.09.04.00.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 00:42:54 -0700 (PDT)
Date: Thu, 4 Sep 2025 10:42:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/16] staging: rtl8723bs: remove unnecessary braces
 for single statement blocks
Message-ID: <aLlC-raf6UksVFlC@stanley.mountain>
References: <20250904021448.216461-1-vivek.balachandhar@gmail.com>
 <20250904021448.216461-13-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904021448.216461-13-vivek.balachandhar@gmail.com>

On Thu, Sep 04, 2025 at 02:14:44AM +0000, Vivek BalachandharTN wrote:
> Drop braces around conditional blocks that contain only a single
> statement, as required by kernel coding style. This enhances clarity
> and reduces visual clutter.
> 
> No functional changes.
> 
> Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> index ef9057456768..27be46c11b65 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> @@ -514,9 +514,8 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
>  			break;
>  		}
>  
> -		if (rtw_roam_flags(adapter)) {
> +		if (rtw_roam_flags(adapter))
>  			/* TODO: don't select network in the same ess as oldest if it's new enough*/
> -		}

Heh.  No.

>  
>  		if (!oldest || time_after(oldest->last_scanned, pnetwork->last_scanned))
>  			oldest = pnetwork;
> @@ -2546,9 +2545,8 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
>  	len = 0;
>  	p = rtw_get_ie(pie + sizeof(struct ndis_802_11_fix_ie), WLAN_EID_HT_OPERATION, &len,
>  		       ie_len - sizeof(struct ndis_802_11_fix_ie));
> -	if (p && len > 0) {
> +	if (p && len > 0)
>  		/* todo: */
> -	}

Also no.  Also heh.  You've introduced a bug.  Smatch does find this
sort of bug btw.

$ ~/smatch/released/smatch_scripts/kchecker --spammy drivers/staging/rtl8723bs/core/rtw_mlme.c
  SYNC    include/config/auto.conf
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/basic/fixdep
  CHECK   scripts/mod/empty.c
  CALL    scripts/checksyscalls.sh
  DESCEND objtool
  INSTALL libsubcmd_headers
  CC [M]  drivers/staging/rtl8723bs/core/rtw_mlme.o
  CHECK   drivers/staging/rtl8723bs/core/rtw_mlme.c
drivers/staging/rtl8723bs/core/rtw_mlme.c:843 find_network() error: we previously assumed 'pwlan' could be null (see line 838)
drivers/staging/rtl8723bs/core/rtw_mlme.c:2413 rtw_restructure_ht_ie() warn: odd binop '0x1c & 0x0'
drivers/staging/rtl8723bs/core/rtw_mlme.c:2467 rtw_update_ht_cap() warn: if statement not indented
$

It's always a good idea to add a kchecker to your QC process.

regards,
dan carpenter


