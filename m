Return-Path: <linux-kernel+bounces-875136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6EFC184AB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B84C188DFCB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48162F7ACB;
	Wed, 29 Oct 2025 05:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rFQdn1y4"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C9C2F7AB7
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761715793; cv=none; b=MmDj+o5WnkUlXgWDNRSFiwDr0wLD+WpG9CLBfl7otv8JlmFAZRT+jKEsQdSkNKzjj3jKyRWdFZNsLxnnJs3Y7JtZtqlNazAavfAEOBHJp97fKwL5grPHUJERRINSynlEl7TnLABoN7pOb/fOqtNNEDioz1D6nf9pzjAxMBGehTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761715793; c=relaxed/simple;
	bh=08/mzPYxSm/1nDpxNMmjbrtO5PkDhUO1zOysCCv/okI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGsR1lTsODqd8+BmsVzZ1RnZJWAzLWXDszIg0Dj49UzJguYdp0CziG+csXaXhuzSm3s692UgmzZwtC52U3MLqn8uaCOFj/oC6N4kV2v/8mr8s7O1n294iPMVzf+L+MGyQYQLj9egWh0wiXZzmh6YHQbxs2ThhVpNTPja6hZrq2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rFQdn1y4; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47721293fd3so910625e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 22:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761715789; x=1762320589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pHaGH2NXIUYjcvzs9hO31NRTn0XjtT+KRdHL3PUBxU8=;
        b=rFQdn1y4g5Z1CkF1aKD8Y1A5sQ9H7frsuEwID6DGNdKuVJ4vH63j+v2GeB5ClCwK4Z
         nmX0u3AkNmsgQfP6YoZOEC+RPKrejDZBwOlWJi9AQ7JbkanngvBPtFA4o8AJ1ihj3hP1
         RkZM20fTfKEUCnT8zEH5r/Qb7OL0X9M9CtL6UsiZi/VAQgWrRMT5KqsPuwBx6NcA07Zi
         on9ERJ2a0o0l28BWwqfig9eT9oxVp/iEvnKZI3LSrlvWeiF5gvRkOssLcpS4xfGEtkl7
         sb/yHKlmAnb0cE+QvR7OidAsIv+arfms2ekr9yk3Aj/YbwSNH1g6pcU8bA1qlWYlcKgG
         XEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761715789; x=1762320589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHaGH2NXIUYjcvzs9hO31NRTn0XjtT+KRdHL3PUBxU8=;
        b=aS8HNMCIoZfAWjr9oh+fgK/dRFw/wokk9E3jab6ALgv/WUgCbE+08r0uyUgWMlDHNt
         Hj4Djvs0vyk9TzTfJMSnZsNrQQK01u+G0O/638nQBsbbwh2ssFqvnIWcdnuH2WikIof4
         YMU0PyyWnrcBujq6mzv2TRvAa8Y9LWcupjXMwh6yeNQtI9pU9iUfIMMURaYZBCHo/92O
         mDs9yPG0DPoYl9ChsmOdYIC1+U/Rd58j7m1P1jjzECBUewCjnnEouf5JGt6ODRKIJKge
         aHTDmvxdxGoC/IsDvUsndHfBe2yyg7tYiP/13AEpR2tMlMsxg0bR6GJtEI0IDEcTLg5k
         Vgkw==
X-Forwarded-Encrypted: i=1; AJvYcCXnQOOlpR2vHLwBO7NhyyGdbXFOwBckAZJIOD7PdvMkqE6w34X94VI/k33NcpZXSD3apDz6PgB4FjcSkRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7bU4OM6F7qjZDRIf6u9cYND9WkqJniUKYAiht9xXsCNzxkJG5
	+p6S+wjhD9L9xsUzyCswyzPrw2IWE0CHpcs+3/XjHr3HoEbl0p9CsLj4Xgrnt4qCkbo=
X-Gm-Gg: ASbGncvBzwvd78STGKB4NaskRNbwt0pFe1OZBRkv7aCZrQm2bWWujIbb+i7Fkl4UCOa
	N+EIjaPZnx07OnNCP8y2PSz8+DhZLfPmghSlBIH5KPlLbcD1/9tekFeHmbbQhntCOUzFPWRKIBt
	Ky5eEAPErwv0koo3Mlqqv3sfvb/0YGMNbiUEhkMhtkNIj5axz1d55XNw8Mi0pmKQLCXEx/K5aPU
	UJnyK1DuOWyGquzXT2jYxzlFjcxNW9qttyiKDxrXxbj0JkQ5+gZxAQx/4nckP16WRs4bZ7Bo1VV
	3kRpGHMYxz9SotJ3cRpKUooLit+Nhx9nd5bwPv6Xb6Nde+95tVZwMqVNc6YljCieRG4Om5CXYPE
	FzziKEvfrPcpdcie+I34T+ynYfELjE0y7xI/mH2/hnNCblck/pWU+QrzDcdSK12IWrBYqbJBiNf
	3lLWYiywyENq+ViDnF
X-Google-Smtp-Source: AGHT+IHG2WznNN/Rizk/zJNzOf90BpJVy0QqUr8IDk1RCx9tIDyYps0DxYX9Z8QZNUQwV5GlDx1Ltw==
X-Received: by 2002:a05:600c:58d7:b0:46f:b42e:e363 with SMTP id 5b1f17b1804b1-477181c334emr32548945e9.20.1761715789186;
        Tue, 28 Oct 2025 22:29:49 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4771e3c878fsm28225995e9.17.2025.10.28.22.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 22:29:48 -0700 (PDT)
Date: Wed, 29 Oct 2025 08:29:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Cristian Del Gobbo <cristiandelgobbo87@gmail.com>
Cc: sudip.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750fb: style fixes: align call and split
 chained assignment
Message-ID: <aQGmSIinidUQnHT4@stanley.mountain>
References: <20251029022123.5829-1-cristiandelgobbo87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029022123.5829-1-cristiandelgobbo87@gmail.com>

This patch was really confusing because I had no idea what I reported.
Just remove my reported by tag...

This is not a v2 patch, it's a whole new patch.  Don't call it a v2.

On Wed, Oct 29, 2025 at 03:21:23AM +0100, Cristian Del Gobbo wrote:
> - Drop previous change that made g_fbmode[] elements const (broke build).

But if it were a v2, this isn't the right way to send a v2.  In a v2 this
would go under the --- cut off line.

https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

> - Align the continued arguments of sm750_hw_cursor_set_size() with the
>   opening parenthesis.
> - Replace a chained assignment of red/green/blue with a temporary
>   variable to satisfy checkpatch and improve readability.

These are unrelated changes.  Do them as separate patches.

> 
> No functional change intended.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> Signed-off-by: Cristian Del Gobbo <cristiandelgobbo87@gmail.com>

Also run your patch through checkpatch.pl.

> ---
>  drivers/staging/sm750fb/sm750.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 3659af7e519d..94a99af4320e 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -121,8 +121,8 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
>  	sm750_hw_cursor_disable(cursor);
>  	if (fbcursor->set & FB_CUR_SETSIZE)
>  		sm750_hw_cursor_set_size(cursor,
> -					fbcursor->image.width,
> -					fbcursor->image.height);
> +					 fbcursor->image.width,
> +					 fbcursor->image.height);
>  
>  	if (fbcursor->set & FB_CUR_SETPOS)
>  		sm750_hw_cursor_set_pos(cursor,
> @@ -538,7 +538,11 @@ static int lynxfb_ops_setcolreg(unsigned int regno,
>  	}
>  
>  	if (info->var.grayscale)
> -		red = green = blue = (red * 77 + green * 151 + blue * 28) >> 8;
> +		int y = (red * 77 + green * 151 + blue * 28) >> 8;

y is a strange variable name.  It has nothing to do with the y axis.

regards,
dan carpenter



