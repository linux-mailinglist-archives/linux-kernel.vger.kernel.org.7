Return-Path: <linux-kernel+bounces-787871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF09B37CB2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E335C200F6B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 08:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A146331A55C;
	Wed, 27 Aug 2025 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YiAMRB1e"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2014A2D320E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 08:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756281771; cv=none; b=FNNXs3FbL4UusYUf9KJAMF3FmFl/ctUr+W8Hmfur+ayyxRVKoX9p3zj9EkdJ7E+kaAzOO78lubdQcllJ1Jsv5IfZ5b+xY5/yPhcqWxW+slohaTMyz5n2l9FTxTrBSjD6m2UFo53M+bFFZNqVuw9G/ttGigM4Tu/Hcl4UFYzTo3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756281771; c=relaxed/simple;
	bh=FLTLlRj2l99VLo6DxkctWbbapbGFjWXzr0jrRSqXp5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQiKIadEeJuhhokB4Uz3+BQ+ZAYNUHKNY+KmLewGXDxIQWkRv3oiivJssc4P8BGNQM/ok6DdlFXNjwN2Ygu1JkdgCEON36ELJ7ziOaLUKAuUszuKUSVAuFuGEzhE529c7CoJZO2y7GpfYecKFKtQ0SAXx4GlhkuV3NdxpRKwIQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YiAMRB1e; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso5232910f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756281767; x=1756886567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KDBYQofHZrYl10kQ9PzJbTY770l6maNuIETUuPQwgh8=;
        b=YiAMRB1e5J/XAIbEb27hOsFoOBG3doXwhGqNfNc05kHqtjLRDjI47DXgyAmCysac6y
         OiSzxDjDeP390rTiOlWEWBWbyK882iMUpKjvMYzPGLEILNsYcHBPgy9xfFXH6gbyxZIO
         CHovtHQiiL4PSXfBQkhSPgxyws9yJPeJLR2K5M9/X8fx7gYv1raGUZvW3Z8m2c3Y+CMO
         lkqKjFuJal2f0Vvpqj6YtqxD4OhftXH+IK9M4bVaurG+jZkvgk2/64lspIoV8S76JKJf
         /aOViHEtwJ3ukqfgkNiLaYj+Vy7oXY3q6OUjNcjWHozUalYMi0CZM2lWO044PQIFgZXl
         W0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756281767; x=1756886567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDBYQofHZrYl10kQ9PzJbTY770l6maNuIETUuPQwgh8=;
        b=xO9ANm90UTWjgmjZIpXEmIAbbgbZlYUcfTFKeHlByrWAz8D8rfcT3ySfhYrM1uRrjR
         TVHOKK00Lb0OlLYz/wKkbl5NE0+xocT1Mt6/zEWAhGiJPeenCWxK0dd1nNhFwsqMlPz2
         uR2YtA+GVMx5sq+LX25Ocmvwx6dZyWBUTsdz8Gr7fZAMrvcp9b01DJt4+XVnIGLeaUb7
         gtm+TWTnhBvHbVOkvQSD9tiJ8ojW9wDvVc/CzliEjD1K/Z1+pqIL5bvSxJyf6y7qT5sY
         p1b+OnKlVq4uLJ518eCNUvG3kX+YZI/3ujIHDDVchDh3YpurlMTsyALBIWXxEEhq9jAc
         QlUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsxZtHjbccNzb0FWmwjEeWNJimKB0S4qJ6pGlb8lFs4KaoSUb1aCU18CtxTtYtxFLagg93hnj0W6FgXOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkT2EaiMSS4zfUG5lU+1Ekj436DRXoQBhXbZshE13zOUlW73AC
	CumJUS+v2OyBpunQwlHJfhYxkFXlJGAshKumMZrBrYNaieScigK6PQE/hVmLQK3NiiY=
X-Gm-Gg: ASbGncva7geQlDKTSNDG3zeXmbPmkx/JB7y8s4IXvB/XMjev+8Oq7zedEDXtccAGwnf
	pHxdSFWviu0uyZpG6enFKqOw53zvNoOzSBSSENuzRhMdVFDcX/8aTPGCMA6ii4Kb7HJFWlKwsID
	6d0IMMIFqMtY2wekPx+z0ch7RzNIoqB54Ofqwq3sHszNB7dzYpor1sHTMgYOJbHwZ/v8I7No4j6
	UHbhxSzT2n66ITQJzBLrJOTJZM1+I+2/QFKSok1SwM+xJNvIUjXubQqpyYNN+JvDgIpqertyDkc
	W7TF1DW8RTfT/Ci9M5VcRQTymHdbxT5IbNQLijuulMYPnVOb/iCZy6o5pB+KSoE4Iu5aVU3zr1J
	rtN223RQqIB2T3q8+HGLWzXxJtrs=
X-Google-Smtp-Source: AGHT+IF6Rlth0CMRJNdIQHC/Hhgq3FdizOsAb3JDfqJzuNPw+A8sYYuExQ63wUeMcxziaJJlxQPtDg==
X-Received: by 2002:a05:6000:40dc:b0:3b9:14f2:7eed with SMTP id ffacd0b85a97d-3cc22e34bc6mr2220251f8f.56.1756281767311;
        Wed, 27 Aug 2025 01:02:47 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c70f14372fsm19327876f8f.28.2025.08.27.01.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 01:02:46 -0700 (PDT)
Date: Wed, 27 Aug 2025 11:02:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: drop redundant conversion to bool
Message-ID: <aK67oBH4cQ10C4A6@stanley.mountain>
References: <20250827031500.91732-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827031500.91732-1-zhao.xichao@vivo.com>

On Wed, Aug 27, 2025 at 11:15:00AM +0800, Xichao Zhao wrote:
> The result of integer comparison already evaluates to bool. No need for
> explicit conversion.
> 
> No functional impact.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme.c        | 6 +++---
>  drivers/staging/rtl8723bs/os_dep/osdep_service.c | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> index 692d0c2b766d..570c99192d3f 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> @@ -1597,7 +1597,7 @@ inline bool rtw_is_scan_deny(struct adapter *adapter)
>  {
>  	struct mlme_priv *mlmepriv = &adapter->mlmepriv;
>  
> -	return (atomic_read(&mlmepriv->set_scan_deny) != 0) ? true : false;
> +	return (atomic_read(&mlmepriv->set_scan_deny) != 0);


mlmepriv->set_scan_deny is either 0 or 1 so it's cleaner to just do:

	return atomic_read(&mlmepriv->set_scan_deny);

(avoids the double negative).

regards,
dan carpenter


