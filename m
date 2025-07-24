Return-Path: <linux-kernel+bounces-743578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A38BAB10070
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64D9D1C27D96
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 06:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF25E204592;
	Thu, 24 Jul 2025 06:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MakuCFlB"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD72A28F4
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753337849; cv=none; b=n+7h7SuQpRBKL2flZTmzaFAljQY0iDsqDqskSU7z4iXcpLwSLn8laOIWjLHmuAAGq5uh33TaD6ilxAtk9+STeMKbjZ+sXogudag5Vp6jhKVQM5H1kThZa9qVotUW3XzRkOdn40seFDj/SAeqlFMDJKRymPvKxK/ZpewlJ2aiW78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753337849; c=relaxed/simple;
	bh=rWWRsgh9HNoOJkAgfbUl8mdjaja0Tq24l8W8LBLrF8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTj/f9/uS/i9awMR7YAs3k6mjhJ86rf1u3DXrjNfAP2LcH4W8fpWPW9I4tFxcyczBcufBb8ob1TuasiK/9SZOw930NOGt342X1KWXumENaeBUsk8+PLUbHto/2VhUD0rtIcwyKbFGjrHQh/Ja/yBgExmtTY4GIIkmHhqjwQC4Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MakuCFlB; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-315cd33fa79so385769a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 23:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753337847; x=1753942647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ma2sXkb0s8zsnuWYCNF5UobkWR25rqDpRvTg7Iv6AjU=;
        b=MakuCFlBb5BYnCVRf1BINAJMNvYasqOg57kBAQeZk5ZYlYFrk6iGk7n2OIjHjOoJi2
         6K5hMRixVf4FJDEMI1wTGt93GngtsA8+fvP/FH3iPn9MpAn02vpznLwT2LdKGEKRd8Il
         1akF+1fV/mbH0FURge/dkiyUMQx4pqvF+jnc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753337847; x=1753942647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ma2sXkb0s8zsnuWYCNF5UobkWR25rqDpRvTg7Iv6AjU=;
        b=bfxu08uc1GLqo/ZiTBkND7roEpKO89NIRNYGQwZR0sr8nXyHRdiRYK6q9X89iHiLun
         J5fFFGl4U4N0nExzRB3mbP9kSIu0x/5KOPs1oDNBj5qISWi1XnPkaPJI8ZAJ7x5ZWHsS
         1cgzJ1eDwGPjIdMCnW2JMbNXEA1MzS5j7lViF6CH6s9jDuBM2ZdnumEo6VX6fh6Yi0G1
         tjrBOEoh+DsdEKVSsNd/Q6e+qZNAE2nWb2h654xdmtyV8M4fKcjrZHYuKN4HRV3/B66k
         e3g3CEawZZxOmalpdy1pe/SBuWcX2bRP6yu22KqwnStuUJbyrcXveZlvJ2rHeV2VeQbV
         3ReQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgWZ1w4psHrsgwimwsVTW9aoGBhWDc9FO8P6qLyevkM/3lBpzn2n30+4mahfV768PnDETtkqPkm59fbwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyluNwde1DW33fXY7vG1M1s4Fu8MufK+4/AqFQs6E9NVqcDcDAh
	gN1jaPQr+yQNC2mog3pfdM4XEvKwVIi+J4Wg4CnPRt7EQYOLPfuk9WmWxBAbZ5h6JQ==
X-Gm-Gg: ASbGnctW9q7X22OC9++bPkvgSJ6Q72HGqoFzXwDyOBX0BB6WMy9Qmmn6BkPdQ3rpk8W
	30pGY9XhchwA5ZsGRQWy2eQwnNLqtt+JBgM/1SWU5j8BKrDcOnuMrG4HYyr7VMAqdoubbFVwPxE
	n7y3eg1Vei7/414LsWsXw1W886fTeycF2f+RH+j26aTSbGdTuJP8JIjA+NmpVBU/B3ogPTm8H5S
	HpTZnV7nzTYHex04P6N9bsypfQ21GID3ZIUoBMJqLrihGuvif7MqQmH5DCVrIKMdamXZXcf5ri1
	dfvG1qvGzyhYQgr3MytKZOOQSWGrLyUSeHzEzbD9F+HrURrloD4LOxwr/SeV+GVP4c+1fcM/BG8
	rl6qVndChBSChULo=
X-Google-Smtp-Source: AGHT+IEOpg2wuJkazWw0natLuKqySLIjKWWWyZ8Dime1cBH9lZjwKuUE1lFEDeUmKFM23MP7GYkuWw==
X-Received: by 2002:a17:90b:554d:b0:2fe:85f0:e115 with SMTP id 98e67ed59e1d1-31e5080524dmr7154899a91.26.1753337847030;
        Wed, 23 Jul 2025 23:17:27 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:eae7:88cb:81e1:a589])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e66267f99sm501715a91.2.2025.07.23.23.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 23:17:26 -0700 (PDT)
Date: Thu, 24 Jul 2025 14:17:22 +0800
From: Chen-Yu Tsai <wenst@chromium.org>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: it6505: select REGMAP_I2C
Message-ID: <20250724061722.GA54817@google.com>
References: <20250610235825.3113075-1-olvaffe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610235825.3113075-1-olvaffe@gmail.com>

On Tue, Jun 10, 2025 at 04:58:25PM -0700, Chia-I Wu wrote:
> Fix
> 
>   aarch64-linux-gnu-ld: drivers/gpu/drm/bridge/ite-it6505.o: in function `it6505_i2c_probe':
>   ite-it6505.c:(.text+0x754): undefined reference to `__devm_regmap_init_i2c'

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")

> Signed-off-by: Chia-I Wu <olvaffe@gmail.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

Somehow I botched my previous reply.

> ---
>  drivers/gpu/drm/bridge/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index b9e0ca85226a6..a6d6e62071a0e 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -122,6 +122,7 @@ config DRM_ITE_IT6505
>  	select EXTCON
>  	select CRYPTO
>  	select CRYPTO_HASH
> +	select REGMAP_I2C
>  	help
>  	  ITE IT6505 DisplayPort bridge chip driver.
>  
> -- 
> 2.50.0.rc0.642.g800a2b2222-goog
> 

