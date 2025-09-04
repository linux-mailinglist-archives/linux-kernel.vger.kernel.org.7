Return-Path: <linux-kernel+bounces-800229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C77B434E7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C36518805D4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C8F29BDA0;
	Thu,  4 Sep 2025 08:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="avIb+ecg"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5872857EF
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 08:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756973081; cv=none; b=LKhSkjlgWEXB2iUzwyLvVDvFKDCM+I4sgdh7JUVn9K85jIHUXDgvSgKoNJIB62lvb318x01lOVSwOyp0446VwIt2vkinoDYvyq3bOvyDUrq3S88EiYdg6wa9otlNdq8ct5ibNmL+nMF9Ejq7BNS+dYCJbTwvTtgnz/wS06aiO6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756973081; c=relaxed/simple;
	bh=R0F4LxX8JeRbwSchRubd0jiTtwG2dsiQbgH91N64AuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ReoC8uVTHywaMgYLN4CMFlP5w9P71exwz1OW2+7hO7m812BchMMZ9HfA7LhbEeA9sI/YKuTa64630ZFnB2ZGkg5w3ySbbJhGW6SNbPHt8iq2IG8ns5LWcCmC5o6vI8e0xN2xFyWnsUwGoaSHkXwFuUL8OpCOFmk0Nt/HaAd2Z/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=avIb+ecg; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3cdc54cabb1so287557f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 01:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756973078; x=1757577878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NMQgTSi+TMSWhdqJbfwjnB9XNjiX9Q7epetailYd/f0=;
        b=avIb+ecgoo9+YL9WEIzV5/WO8opKItsMU0+bNNEShHtVnKRkBKnivM6sRxiTEL+zPu
         nMEQ85WxLO49CkPaeIGxKa8lm0OY+0U75KACtrTTR4aOSQTVLfO1kQi84FSuyaeOcjXe
         sFXIu05EzSKhzB5j2YNJrhgiMg9yKvhDF9/BImKJCkdN5Eq7vAtscn3gDvDWVpLbCiuq
         CcFkhP3fi//OT14D8Bpi7zgXhfOz840r3X5/kSST5I3MB1lJiZ5nJInC9Ih3JJmuub28
         4EW3qyKsXJnYXxtJMDcY93oI/n80YbX8G6fSpr4EbwvWS2Xojogy0lr2kSZNQjXdCvQX
         NPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756973078; x=1757577878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMQgTSi+TMSWhdqJbfwjnB9XNjiX9Q7epetailYd/f0=;
        b=BnogKodL1bNe3EqYCGfpupuWp4evwFi1m7NoUNGV+qhnHWA/u27zSHuwkp+4LdU1p8
         1euj11IYqOC62xqsv/jJqNEREQsVNZbHLhnzHYzZUK/f1wfWYts/z+T156d3SryTP1Ec
         oNWCE8R6WKDm3ZTFNjt08WEdyMqlADaRY70hohG7wPLbVArJL0Q6y6YDDbhRPS6fi8LX
         T6+7b6CNLrxIIh/btTv6dPfnwLKTuZRBSfwZUZ+1tGfeP/qbFvZY0DXl6dV3E1TXRTov
         xIIwG+uWCO0cjl3SQJlmowGu0vINKJCSx7cACPX3oOLeMnwsRgCOnWHeWUOvgcMqsyYn
         5RdA==
X-Forwarded-Encrypted: i=1; AJvYcCX33DNXWlgYYWyYE/zHphIj5tCoaWRRATxYEwH3GuMmcHIBZ+71ZSN1qdZfCJDuvNH1p6gIxsAiFc+MK5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM8tBVNYSuFTC1smMibu/GJ/s/zUsHuU6SXCSV20s/4AsM//n2
	z89NxXfjEoYF+u1YVpnG5NbRClGZ0wDE+v/WPdIJQNbiKgV+hw88NosNYG1BDqSyWBo=
X-Gm-Gg: ASbGncsMvSf/VV/6d+xHc6p7Nkzcs4QihyVrIoCadGY9FQtiZ98lumnNAPrQizWMkZa
	wgufKlrnHcdsM1odL+9notQiLnRYtYlogKZNNX9gkhQnAlwaSqOAWflfTH8yWLV7J1uBDhYOZFi
	2bV2MZB/oyW/9ChMVJoHrmp7SvhmhP6OCEsxEZAroTLfH3ZxnYh6Ijqqh7F1zL0sExXpl8KaKy/
	jZlaXLUJsX7Uw9cz3qt5Hfsj2bTRrZk9HQHQs7zvDlB+JsvRvbXKyUJU/kLs6R0A19IeHPtSxfu
	BduWBhjVxsMbUYFV1lcOwyDSlE1YDTAcmNl0cGy9n0Yf2LIGfobNu5BENrh5ld3vYDJoD04fN1S
	WC9aGAERMnBib0Lz/LxsSECoJ89w=
X-Google-Smtp-Source: AGHT+IGCbRet6mDjv8hEUzW+n1WN7HfErihvQ0mwTKDBWlJ8UG8XGONqSLDPD72SdxeMgb9oxxEkRA==
X-Received: by 2002:a5d:5d02:0:b0:3d5:55c9:f218 with SMTP id ffacd0b85a97d-3d555c9f834mr9936116f8f.2.1756973077662;
        Thu, 04 Sep 2025 01:04:37 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3d6cf485eb7sm16503365f8f.3.2025.09.04.01.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 01:04:37 -0700 (PDT)
Date: Thu, 4 Sep 2025 11:04:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/16] staging: rtl8723bs: fix excessive indentation
 in nested if statement
Message-ID: <aLlIEspZ2wLRnCru@stanley.mountain>
References: <20250904021448.216461-1-vivek.balachandhar@gmail.com>
 <20250904021448.216461-10-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904021448.216461-10-vivek.balachandhar@gmail.com>

On Thu, Sep 04, 2025 at 02:14:41AM +0000, Vivek BalachandharTN wrote:
> Adjust indentation in a nested if-statement to match kernel coding
> style and improve readability.
> 
> No functional changes.
> 
> Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> index d05ff073af2d..a2b1e34765ac 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> @@ -1254,8 +1254,8 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
>  
>  					ptarget_wlan = rtw_find_network(&pmlmepriv->scanned_queue, pnetwork->network.mac_address);
>  					if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
> -						if (ptarget_wlan)
> -							ptarget_wlan->fixed = true;
> +					    if (ptarget_wlan)
> +						ptarget_wlan->fixed = true;

Wait, what?  We're moving from tabs to 4 space indents?

regards,
dan carpenter


