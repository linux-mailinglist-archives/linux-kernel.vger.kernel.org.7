Return-Path: <linux-kernel+bounces-841052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E8468BB6235
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 09:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D850D4E1D1E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 07:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A0E22D9F7;
	Fri,  3 Oct 2025 07:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pt0rT/KK"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E8122A4DB
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 07:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759475263; cv=none; b=RF/9IWYWBmi647wpuZ5VeYJjtvhP64meHYEfOIDveY8TcUVEvNwbExMc5OENLLwB0eu5ZaO7k2+FgEdqPfZjgiYoV96gVtJZlFtj1sR5WTJM/qlfcq5H7+XK11EwxQYXYLucptNGwJF7XUML8Ys7wS9qUnPRrm+i12TE2KK0MUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759475263; c=relaxed/simple;
	bh=VfnrwV00n1OTVgQ7ak+8WGMC6Lhvu/i4uIuO4QQf7B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6eNE5bQI5eepeZ3mmnJi4X/gYrGn43NFS04frM4zKOcK47mOEveiGsajhfKFydZP3/Rf5FDEwlUJngDf/w71Esa7roPjM1goDxLbXYZ+1GLaaVQuq5lWijcq0qefmX8iA+MtdwxjyM74pqKFiKGufC1ENEm87Nr5LinWPpyaZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pt0rT/KK; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42557c5cedcso1039489f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 00:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759475260; x=1760080060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+dLYg+KUenxi+tGWfH6hX1Q42Ol8JhSulu76BtWPmL4=;
        b=Pt0rT/KKCsnSTktZVPcoGGmRXgamgaDWaS5hPp1VuMkq+j6o55J0B7C22vPcEgkbrR
         nQeOnqnexflHRHMIQkWNo4pT6FpGvqCkKNyRu959fz82CoezuU52QQ+B6tMZ8DyQL3Nu
         wFfbdBL3fSCjAo99cPhymT4G7Hp54WyVq9zh5R8iUI5WyPm+JRk5usYqVTz7eXcyM01i
         jNHJuSl5jaUkUQjUKr3MOqGbqeMCvMoikO2624TnexwEMr2Aqa14zuIm/FL+nq7Jokwt
         uU9YKf/hP1Qlek8IZICiZIdM2w32O8Fu9UnKVX7ofU1sMvygLnpgVwzfebpbddxmH9AR
         Dpcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759475260; x=1760080060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dLYg+KUenxi+tGWfH6hX1Q42Ol8JhSulu76BtWPmL4=;
        b=BEBQheh9rwx594rpRf3o2jZ+m9yKPu9Mm6tL2g1KV3BJQEnIl0P44iLrpQVWU88SRB
         TJ4n9Q2grprZcfQghw1i1ffld3H74GEwlreBaAzr67zjEKhY5PE2Ya+QZAX+4tCPAe68
         gU7Uyqq6+5yM574Hw/FMoStGLM0EL8om8ZJSU4XikjZRKQ/nmmYEUpJ0xtpJmXFoxKbC
         p4gTpCHXR/t9M/wQ4K59nxUfnIWXoMu32vs2zish+s5cmmJXMf+fT2WiEvHFCnwdal1J
         /7RLCXLMEN/ERvkHwbwKFr9fpoXYIkRXwXwf2w67cfzYMouoNAtz+ffXY7jKQ/DP8vhO
         GB3g==
X-Forwarded-Encrypted: i=1; AJvYcCWeiDdDhqHSC3lEyRcZnCw7gWkCXtkA53XkUh9M0T212VFLA682GUp/2HzjWonWK2+g4xOMkLKIRI/KYyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSiOpEBwnzciCpxpKfG4slN7Hv2wqVWBiIeP1UJdBwbD+OS1ow
	KefgLeWu7o3m6Nl8EoAXMOEz+lvtY4tBFE5L4bPnU4b3drLt8o+2vFfTTiz2sxpV9ms=
X-Gm-Gg: ASbGncs3oyX4EynQNTeRcel5Dvre3pvU8uMWyLd7WlatMWQZRukUEaRB08/088zeB9o
	eFowkhDo8PGHnMMQZkwQbGlPJD75k5MAFNsHf/m+34nAwODX+gf8djxNiTrtUrRLA2TqpOycb82
	9tMEM4BmQV9RzSVmddmoFcsUwfNLWzk+893X3Q3r9WcP+Zga+9GwCuwjljkhQBQUbktxo/jlekY
	HK5urxAfZtyfVgGoK65chK3GrM6WZEnXV225EI4XnH/3rclycGO/1gwzDq5sTv0hson/NqD31ik
	e5xc/QTMpTgqapAjjnNXF2LFEi4tiT5PjHaKtQMCIwOagC7r2XdOIXCmKo8AHZXl24petEKarnF
	oA6MFcE6rvea/h1w+zpahSN8oEKB/5IiTVkWQ3f9vQwMBoxSYLexZxFBR
X-Google-Smtp-Source: AGHT+IH6eMzb4VOW5KfpbZYuUFHDgM4wKDGHErJCIyTzM3ybhw/asDsLkBOmij7ls7Gu/mDzsM8qHg==
X-Received: by 2002:a05:6000:4285:b0:3ea:c360:ff88 with SMTP id ffacd0b85a97d-4256719ebdcmr1056224f8f.31.1759475259872;
        Fri, 03 Oct 2025 00:07:39 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4255d8f01absm6582677f8f.44.2025.10.03.00.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 00:07:39 -0700 (PDT)
Date: Fri, 3 Oct 2025 10:07:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/16] staging: rtl8723bs: fix excessive indentation
 in nested if statement
Message-ID: <aN92OChccPlzs0KR@stanley.mountain>
References: <20251002172304.1083601-1-vivek.balachandhar@gmail.com>
 <20251002172304.1083601-10-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002172304.1083601-10-vivek.balachandhar@gmail.com>

On Thu, Oct 02, 2025 at 05:22:57PM +0000, Vivek BalachandharTN wrote:
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
> index 5d31684c7cf3..34fdef878b51 100644
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

Wut?

regards,
dan carpenter


