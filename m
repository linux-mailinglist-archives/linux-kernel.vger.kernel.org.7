Return-Path: <linux-kernel+bounces-812727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 001A9B53BE3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B53169C86
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA513F9C5;
	Thu, 11 Sep 2025 18:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W6eNl/N7"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7F3178372
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 18:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757616733; cv=none; b=g1Abe7pCbVKbJD3EBN1HEVbMFH+3079t3u6JLIKeJTbI/j2fMag91AlvvVYbQUX7+8fXypiDR5yM+afNv9AiApt3Y+wTZWmuromHYzFNqRSj5RGpRvbFk2fDZ7GKJQPWjTGZUswu64UH1ueOM0jk3WO5bq63JrRbu4V8VT0x7cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757616733; c=relaxed/simple;
	bh=rXd/6eNnkgwcu1obGsgNivj+t82h/1UPQb10m9TrnYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1eFEdNS5catbez9spWIBbv3cdQU4bTlYh+K9eK+B+66AjdgO+l0nUSy3ARi9ZxAiAloSX0rUnD008TCD81R1NPCYD3IIjOtFOJ66621FLr4mTGTgV/4f3SF4uqwazUWkZuRjbIvnWKDKJng56Ixl6ni6BG8pBBHzZ2qtXDoyHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W6eNl/N7; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45dd513f4ecso7478325e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757616728; x=1758221528; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/qPRJJ/6GDpv3hVxWcXnPmSZ8FtyUTqpKhwovBWsMd0=;
        b=W6eNl/N7gV8Vo06nCIoLUz5Pu+3YVtPbejVGJd3GYzkkuYGXUY90wwKNAlJCVtuNSd
         ti6nxFgnWEbB3IdNTXy67or3L8EpPhzYoN3Kqe+lmrQVd63+oJKVQv0LC+NQqwi+K1QK
         zguqqM4zS3Q9VQ8nQGciDwTzCYquH0hIJbMaVkLY37Dg/tZj/kYgAmT8VvRoWcKAJfyo
         ZYnFK+CDr5E0z0kNAAyVnhPF+eYtoZo+0jVW0WqQdbsT6+g00XIn4gmIpDvoJEiqPYd3
         p4XYR19crlOijzvx1jOOHjjt6oQAZVduZFGkey0pEjshK25ue8azMIdDUhvFcF3urWn4
         JzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757616728; x=1758221528;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/qPRJJ/6GDpv3hVxWcXnPmSZ8FtyUTqpKhwovBWsMd0=;
        b=EGueYbTHFjr/T9e/ZEHxlOK6VtJYFD8sarD+2tlJAexqBnTS0vsQopOJflVo6FW4GE
         Si7Pi+V4JvuPgroKYShR3GbDBL2iFxRwNEWnhVkxhypp4odwwk/H6NJTok5Zu4NFV2oH
         T/GLWM8Gh7/gCqxzRQ0KfoMvFJF1/nIsDySC8AROlMs6J65IXVHvTeLEtNs6GM2kV8Ke
         uYLIeTscRbKO+E97rsgmbcqy2p2ghEd7jT8ymC9OUH4yp1P9XCJlZaTSkg6PeG21DrcP
         OZkzZIG0t+3pTqkBOS/8aMrREvRlh1yxZJQNp03KuQRWGCr5GRx1nY5P2HJZ1ZG/eg70
         DjnA==
X-Forwarded-Encrypted: i=1; AJvYcCXq9DGtMQrlRSs1al0NKU+1ZNnhmaCREN2xJnj/4AO4PsC5nQKBWmDwfrqBc5og8pRleS3dnO6lwVVygqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykr8GEq2vpLqU2R4WczziO++DoAR33JW/zmbBDuZYHhIIoB6lj
	1rAtoBktE//9WJt1RPeBl+12Q9i8DlA8D1ICZ0u34faiaurkHEAtWGyNmJhh/JV/chc=
X-Gm-Gg: ASbGncshekz1IHCIA4OR8n2ynT+7G0aeLyagxjA0nW9eZAIqwijpCe+NvSzUomnONLU
	smE9EW/XiDy969+MwjVfXat1w02/1oBcLQS7PmakrpRuoth9hpiQh/pYhZa+TXiKjW48IdC0fgI
	mlzrEV4XFgJ8QLHFZYFxL8ROBV3uFbbu0JBcScpJYA856djhjaF9M658GI1MRu34/8QJFcW2wMy
	lMfXlNFISbsFYGOr+jnYJcdd3kjQ6m32vTEYy6yWCdkFb9AzzjWyzMM9Z6AszVWW7wByo2jFk0T
	MUFXOjyHsI21L+O1dpQQg/00PeHcrznM1fttdNb+5Cpanj46dWtZK26Bs4Wjq50WXgc6el5njUh
	XI+h1mUjIdSu65ixqhnBa942Taro=
X-Google-Smtp-Source: AGHT+IGbe0i5zX7GrPZfXxtP9KwFOHD5VEyjXbbI2e/fygTlh6S6/f6eSWgbH0sRjrbQGsV2TsTPvQ==
X-Received: by 2002:a05:600c:19d1:b0:45d:98be:ee8f with SMTP id 5b1f17b1804b1-45f212609f5mr4155545e9.26.1757616728466;
        Thu, 11 Sep 2025 11:52:08 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e7607e2d43sm3441866f8f.59.2025.09.11.11.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 11:52:08 -0700 (PDT)
Date: Thu, 11 Sep 2025 21:52:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Akiyoshi Kurita <weibu@redadmin.org>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix typo in comment
Message-ID: <aMMaVOSQx_8zftnp@stanley.mountain>
References: <20250911150207.602285-1-weibu@redadmin.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250911150207.602285-1-weibu@redadmin.org>

On Fri, Sep 12, 2025 at 12:02:07AM +0900, Akiyoshi Kurita wrote:
> Fix a spelling mistake in hal_pwr_seq.c:
>   - 'configurtions' → 'configurations'
> 
> No functional change.

This part isn't required.  It's obvious.

> 
> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
> ---
>  drivers/staging/rtl8723bs/hal/hal_pwr_seq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/hal_pwr_seq.c b/drivers/staging/rtl8723bs/hal/hal_pwr_seq.c
> index 2438931ca51b..fba67a7c069c 100644
> --- a/drivers/staging/rtl8723bs/hal/hal_pwr_seq.c
> +++ b/drivers/staging/rtl8723bs/hal/hal_pwr_seq.c
> @@ -8,7 +8,7 @@
>  /*
>  *
>  This file includes all kinds of Power Action event for RTL8723B
> -and corresponding hardware configurations which are released from HW SD.
> +and corresponding hardware configurtions which are released from HW SD.

I don't know how you did it, but you somehow reversed this patch.
The - lines in a patch are the old lines and the + lines are the new
lines.

regards,
dan carpenter

