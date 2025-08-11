Return-Path: <linux-kernel+bounces-763487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8FCB21541
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 21:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72C133BE477
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307492D4813;
	Mon, 11 Aug 2025 19:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1za9Nhe"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439CF311C2A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 19:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754939911; cv=none; b=Lg09MSDgL9SpmhfjAtvm7K2TQrzv3q1I8IONjd+eYVR/tuApz6rZa+wtlRg6fedEcKPUUK0cnj7OLCrt6epF6HU+F4r6IF0eggEyKQ7oVl43H949acbQdlulkPbOts22CtSvGK9UEgpt9wbG4GeWsw6RBsSC4jvKekIz9EelO50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754939911; c=relaxed/simple;
	bh=35T9BEu9i7VLKF6/sBCJQ+Z93TxpqBdcRFj/tGP2fgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNIvpglFoV3igy1c4Xer6SH5m+Tui9UF/ghAskW9W3rdyCvx7zc7z3NTTEBapnJ5sz7YtRbp20aywib0+1lfgYGKSiYVGbzKHgAQl889WjKEPqI7hieZ0cOYozxqmXLAGa+pI6gecTqx2UsVjwrXP2nh2/b/sAZH/yGHmnYca/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1za9Nhe; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-31f4e49dca0so5759030a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754939909; x=1755544709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C+y9z0wbb7UZ5PYTp6B+LzKdJrgF2sCfiImrK7E1sdo=;
        b=O1za9Nhe8Bqm+sJUxFbbYCdDl57fQuWciPDmneJhBFZlk6SW5L4LjDZQoxpqrtLqqj
         oo4ZHBmZ8clKSFU8GHCeI6IW2Q/a60EcM2Re0Zzi3kCgDe3ue24h9XHqZ8ZtBUpezwBA
         GfPoMcK1QBpYOxB8AkIqc55A3svWDvhQig0MTG3x7+XAdwZ0BTV+Pv4UBh9cwLKi3lDO
         dGJ99W6jxSVWuimp1cO6ejBEL1ij+0m/FAycmr07qYl/qqq4wBrG0OuXSzUeFlnmwfwx
         QqFJLYh8IqJHqLALLAAmTh4pUqjAHs8CoUz3idbuX96U4XUQaP0uIbAqzxlUHWYksXyL
         gyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754939909; x=1755544709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+y9z0wbb7UZ5PYTp6B+LzKdJrgF2sCfiImrK7E1sdo=;
        b=eSXOgi8GFgyQMnNO/k6TR6AMcu6kS3PPW9sY7Ljui3Pz5YyqOXsEtD3TdEiBvXJqoz
         CGrXaY+4WJZPlx0s9nZo6YRhc4lYk+DugjpB+kCqyU26knP+hANGVe42QnrQlYEnhWdo
         SezqwDX1KBEYJf15Bjwym2qv4OpUj/oQbGG5DfQe7j/hqQS0AcLMSaKhpYCJoyUT2T4Y
         NNqLS79Gf/rZ/paL/ux7W+e/a58QGNEgN1TjdW1+sepJYPf5jde/xvURD1ZAX5DZ0pyX
         67+g+D/gFk7MKq335Anf9REIbC3qUcrBst+7v7Fc7GdfcAcfA5Y7Nrv9Y08gBPwfc0rq
         9qHA==
X-Forwarded-Encrypted: i=1; AJvYcCXg+KqKYmbIqjwZ1zS6HjL1UsjrS6k7YmuAsAXFa8E/gWx9Q247h+0tRND5rMUbfJ2qq1+hetcqNL6OZyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm2yMJeDdhv76jXYO9o6fBmxLugE6uP28Hka1fiRAU8FEqtKHM
	LTuXHKB8xR9hNxXY/whaRhaJ7DEkWV+dysGZu/Z32r9SRUFlzTaerO35
X-Gm-Gg: ASbGnctgmyjiV9OrtzsX7Rfu9uGy6gi5NNJKJ6DfjUU2xvJpALzaK3iilFcXqQtow7K
	nNRlgYEGnvTej7fZhH6IUWbwao2xI2JkcTtCqfKsMQeGfEvl7y+yMRkyJt+ZXlnW/y2+TKRszDp
	ihWaW2uwZQzHxSjyxm+VJpBFwZkLHtB5IXCQS/Toax/koNDwG6oFC5pL3/ooSOc8Id9ti1qSkir
	3MDxqzOr+GOTavpse8vkF8MDSE3dw1Wwj/V1sgRl8kAoZuXPxPRbFbjbAX5edenX97v4p8HcKN3
	9wG0mPxNmCgmvi1xxwLRFgzP3+RPy7r4PjCiz9zlHeDbCBaupnR329sTHfclliTO6Vs4lIIEuzp
	wM3rY17uhujbw+y2GnlfbvlznkJ/9zyjtaGlyR8MikJwY89LS9ixA1w==
X-Google-Smtp-Source: AGHT+IGrT3Iq/yNt1IOa/hXKnvcE2sGXzFXA7QFiniXSckk6w3tjG0VIizmC6LR3GRwM0xAh5JgKJw==
X-Received: by 2002:a17:90b:58cd:b0:312:ea46:3e66 with SMTP id 98e67ed59e1d1-321c0aa6dffmr950367a91.21.1754939909511;
        Mon, 11 Aug 2025 12:18:29 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bacbb74sm23639347a12.42.2025.08.11.12.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 12:18:28 -0700 (PDT)
Date: Mon, 11 Aug 2025 12:18:25 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: ryabinin.a.a@gmail.com, akpm@linux-foundation.org, glider@google.com,
	andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove unnecessary pointer variables
Message-ID: <aJpCATXWQx1hEyta@fedora>
References: <20250811034257.154862-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811034257.154862-1-zhao.xichao@vivo.com>

On Mon, Aug 11, 2025 at 11:42:57AM +0800, Xichao Zhao wrote:
> Simplify the code to enhance readability and maintain a consistent
> coding style.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  mm/kasan/init.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> index ced6b29fcf76..e5810134813c 100644
> --- a/mm/kasan/init.c
> +++ b/mm/kasan/init.c
> @@ -266,11 +266,9 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
>  		}
>  
>  		if (pgd_none(*pgd)) {
> -			p4d_t *p;
>

Nit - Get rid of the empty line between the if statements.

Aside from that, LGTM.
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

>  			if (slab_is_available()) {
> -				p = p4d_alloc(&init_mm, pgd, addr);
> -				if (!p)
> +				if (!p4d_alloc(&init_mm, pgd, addr))
>  					return -ENOMEM;
>  			} else {
>  				pgd_populate(&init_mm, pgd,
> -- 
> 2.34.1
> 

