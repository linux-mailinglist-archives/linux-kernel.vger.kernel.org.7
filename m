Return-Path: <linux-kernel+bounces-761949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15952B2004E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 548B57A6306
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BFB2D9EC7;
	Mon, 11 Aug 2025 07:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZiVwnSMN"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1922DA74A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754897419; cv=none; b=k4lBaZ9RYOuh/vp3dg1Pzf0F4y3pjj7+nc3fPmzQ79xN6icCj//BQsytbXxdEzVj1JOI+RAvN3hR6A5ruPAlRAbw9mZsN470EZO3beRF2BbEc16mHw5gEhkCWA/v+5mMUW02jbulXry3VLGCrsvITOY2K+1i0ihO7gpBwkZ939A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754897419; c=relaxed/simple;
	bh=O5bVzxxklGV2wx9J0P6ne1RrDA/KRssltJb+lkhoM08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DlM4hQny+XZsETWBGjFUCV29/5QZD9aYizDgfuObbPhTwvqmLWEPtM2fvcxePLE5IbaDlOfN1/jJmLaUtl0eis6Lt2dpbLw0y/R0lgPjJRLNJ7bGUOAEMUt2Cx3E8YFKX87bhFxjtl4MbywGwBZmLCGVwHWQaQYCWLfQ8PUa/Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZiVwnSMN; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b783ea502eso2737459f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 00:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754897416; x=1755502216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A9EiUhQxYzz/KcbXsPpOFxaqjoUFAlADSRrsbCh5BCc=;
        b=ZiVwnSMN7iG8GxB4NHBmgypPgfqteZDCiMNKpM3hU6Oucscv0MP5iTnTHEw4UrwM7r
         b8FqJNdx6KmXXr3syhBKdgPV/GdXx+bL6stpNCZ2JR6PEP6N+00kA4c8ssTE4GWrCj0Z
         bnwL+a2TmGYQnCNmAlPSK6anftBk3QZiMasv5aXJstU2X/Y1+xSPr0PKDPcLMEziQSL9
         hYXCc1633NZ+HOiFN1dEPKVs8EPPb+3ORkgfSwwzscuhVnvz0TP+nLcDPTS+kyhR+7VG
         NOl73dTX2fRFtA9WsOoDgQcFdGH/3IRZzFLNFhxlZv5o/0whXFj0+iuaVTury6OuYl9x
         v3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754897416; x=1755502216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9EiUhQxYzz/KcbXsPpOFxaqjoUFAlADSRrsbCh5BCc=;
        b=TVnqvY799ytUlbkXYvVm/VcSWLkRYr4vEzUkAC8Tweqi45R9drPe3nTDO+urZbPJ8h
         uQpJDeXai3GRJZfpi/eC/JFQMxjRFei3mirfT9TOeACnBIRbeJPY7ZcOtcW5iHkA1FxV
         fr8xamKmmWd+Qi6qj+mYPGXk4pDKj2oNpWbFj0FH8vhLWz1b91oW2QHiE2FKkLO0De5o
         B/BlMgNGJYInu9Z+Fdq2cGF/oN0wk/ABcPd+umO19StWc1AbSkrbcKcb2YrIhxxTndk3
         x8mhvtsWQwvDN0MLBWah3PaFOIgjip8wrCSr9DP1m9Ez+zs8L5CKBr9OSaNfsIpRS9Pp
         630Q==
X-Forwarded-Encrypted: i=1; AJvYcCVg1RjGO0/vfdZqzX5u0prone2ib/OPn7u72E4ilcy0oBN0vQZjebpx3j/gBXhXhfQ/aCP4EtpwmTPH5xE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoB/1JGvwX4L28Ml/XKqEDWyIpYqdGGP5ra5Vby5Tt3S4nYWgn
	3LpeABVXbRPblFHI4nscUEOj5RJbuk2nkJUoWEfZoP4cOLsk0q3FCDE0WZfq8YbscLrcAlp19Uo
	TZUPj
X-Gm-Gg: ASbGncvByzNmg9+bWPPvJJZOTFgMBdGt+6gxec6+smp8L+9fjj/tAyUduqO9px7BaQz
	JJ43v9K/wndIepThKdqPRp5SKVFb3Vvj9YqOum4IWoiaX+el17WKsdFgqmqbtqtrMtADmn+HFGt
	RBE5mg6We7H1pNRko3L7Jx0fmSsR0P/anHUjRldrJwcv9zG618cPKUpj5fOkD2ADjmZuX6u3Ibx
	LtDjoUkNfbxhAj8urDDMq49Xsz4/3XueG+wEeIhvV3VjNYIkqCvNgPkOewimk0hc8ceYcedWmQc
	Y4fsL1a8HfHsufZgvYjQ0CxOHOzN5eH9AHLxlyo/BGQfeiMHVI2Mfx5IZNYuGHAsvKsrefafeO5
	XQggyNdCTPggta3QTg3VhEM5VZ+c=
X-Google-Smtp-Source: AGHT+IFnZcurUjSB0/hSFNgOLLFovKhhBQzF571ByqSxJzK51BtjHE2aT99IpvR/yipJ190BOOAJ0Q==
X-Received: by 2002:a05:6000:210d:b0:3b9:6:8970 with SMTP id ffacd0b85a97d-3b9000689f8mr8078708f8f.23.1754897416339;
        Mon, 11 Aug 2025 00:30:16 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b910180aebsm77506f8f.59.2025.08.11.00.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 00:30:15 -0700 (PDT)
Date: Mon, 11 Aug 2025 10:30:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yao-Wen Chang <changyaowen19980629@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] staging: rtl8723bs: Reformat code to respect
 100-column line limit
Message-ID: <aJmcA7SlCjXXPsOl@stanley.mountain>
References: <20250811062132.102525-1-changyaowen19980629@gmail.com>
 <20250811062132.102525-2-changyaowen19980629@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811062132.102525-2-changyaowen19980629@gmail.com>

On Mon, Aug 11, 2025 at 02:21:25PM +0800, Yao-Wen Chang wrote:
> This commit breaks several long lines of code to ensure they do not exceed
> the 100-character limit.
> 
> Signed-off-by: Yao-Wen Chang <changyaowen19980629@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_ap.c  |  12 ++-
>  drivers/staging/rtl8723bs/core/rtw_cmd.c | 106 ++++++++++++++++-------
>  2 files changed, 83 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
> index 47c63177b2a6..2e59a26e6318 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ap.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
> @@ -391,7 +391,9 @@ void update_bmc_sta(struct adapter *padapter)
>  
>  		memset((void *)&psta->sta_stats, 0, sizeof(struct stainfo_stats));
>  
> -		/* psta->dot118021XPrivacy = _NO_PRIVACY_;//!!! remove it, because it has been set before this. */
> +		/* psta->dot118021XPrivacy = _NO_PRIVACY_;
> +		 * //!!! remove it, because it has been set before this.
> +		 */

Delete commented out code.  Also what the heck is up with "* //!!! remove it, ".

>  
>  		/* prepare for add_RATid */
>  		supportRateNum = rtw_get_rateset_len((u8 *)&pcur_network->supported_rates);
> @@ -841,7 +843,9 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
>  	memcpy(pbss_network->mac_address, myid(&padapter->eeprompriv), ETH_ALEN);
>  
>  	/* beacon interval */
> -	p = rtw_get_beacon_interval_from_ie(ie);/* ie + 8;	8: TimeStamp, 2: Beacon Interval 2:Capability */
> +	p = rtw_get_beacon_interval_from_ie(ie); /* ie + 8; 8:
> +						  *TimeStamp, 2: Beacon Interval 2:Capability
> +						  */

This is whack.  Just go through the rest of the patchset and really
think about things a little bit more carefully.  We could obviously
have fixed all the checkpatch patches automatically and there is a
checkpatch option to do that, but we want people to do it manually
and really review things in context.

regards,
dan carpenter


