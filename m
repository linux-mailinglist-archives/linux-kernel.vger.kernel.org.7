Return-Path: <linux-kernel+bounces-759218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED2FB1DA70
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 16:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35CFB18C3CF7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1636248867;
	Thu,  7 Aug 2025 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q+IrhUyb"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1AE204F93
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754578557; cv=none; b=tML5DwmjCRnMd8pzDBzSv+YBOik/sTHM273e3KkASqZZhmUPkOm1Ega5yHObvMOEZRr5NbLeO5ZL+9Se6SMjSc6SaR0zuKjhRkz0kk6whIjRQBvX/kSLMPlJqqcUMRS5mhuZMlM8E4dpjvDAKoTGqJKQDbRwPOycNLF2Ilsj/pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754578557; c=relaxed/simple;
	bh=V81HFKIF4WvOdFINJuelVowhXkakDrHn2gVz7wiimas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVHct/UZn+jiLFtEOub//mCtnZyd3L+d0FLuYQZM1VBNpexILiJeH2LdObIEjBvSHHJj+HNpe+EchKJs0P02WGC5BmzoOyk5uzOC6UfN7Aohv28AWIkZyI6gE+4uwVbRZ3P3jMiJCVXlaNbRVvmmLNMX5OLmU6NGnHqgQ9tuUrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q+IrhUyb; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b8de6f7556so627866f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 07:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754578553; x=1755183353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CDQjd7e1dEINU3xXqkIWXUzUoOcvOxZ9G/ybcyRrH1s=;
        b=q+IrhUyb2perhK9mz6Nzi7ujiINIj7u0GkwVGw/ji5iZvQW32HP1ExjGPmAhR/kSGh
         WxkgrPK57sIuPgGAJHCVOFoK/leq+zQhH9Ta3MFbZGdO6qdOVfQsLDb7wZtwlwqfsUod
         9wuBLpH8BRQLPZhIXcmDvqfeBTqEGq6j5z6oELy42bgACrhAC8YxD9A33KRZcI/5Vyxv
         LGIzfcko4Omg2pF447Tjk+vCnzgvHjSx/B1dkG/5zxtsN+6Vuz9IAkEwlhgTINUz4E36
         O0cnfkte4ztczf38QNKougehUrvxzqZ/q2rkhGLpvARuk00hs7+yNSsgADqOgsCcTFSD
         8IaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754578553; x=1755183353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDQjd7e1dEINU3xXqkIWXUzUoOcvOxZ9G/ybcyRrH1s=;
        b=At7sLst2ur0NkgO+JJrTMIU4ZGTOatBKWUGtrziRajund6S7Sv4vX2GdcVq1u8uTJ9
         5QgepbHS8/+0CPOO/IxPmKe2KQd5ROSsWUYBkDl6y6DIc0vRBEEhZ0uq7z+PcVsMP8EC
         5QuV7GCmoK4xW8JKehpTcGEcJTwTvh9tNwgy7IO/meeMUdcSFdZqEITuNbVAr+lisvG4
         HTDMXw7MHvxterZ1jAoCfjrceSmHvArtOv3i72SQgcSTX9O+cbVLf+fEBU2oMdc12EK+
         kKSw9QaZH+8ujyOX7khkrp++6twfp1G64r5ERCOfEsELlOl7gDmPwpklwADfHMYG9UXs
         yrOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZgGJbsqxFAdpKir1VtjCjOfvjoSUd7bFtO1/94L1mKqB45RWS8+RIZkkms2cWeBbMCjoy2sbmS9uFRwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg5aWQRfSCopxlrJDP/bO4VUQnAjAuk/NvSe5A0unaEeN+gQcM
	78UbYyxAYD/mlStGE64vOqd6++vhuT1wFduw4010WHl5ZvTYtuW5s7kzxLrwjJft108=
X-Gm-Gg: ASbGncv4CakHUI/2NWeq2i0YUZYWAhN/falBr6YLtQnVqDnQ6scEKnco8XUOQQiR0KU
	+qGah5TP7regrHlMiFKVJqh5+cXnGxAXw5pyo96iarY1b/I0jnIZRyEvLATt1IwlGozp2CYok2h
	eJHoGgDHh9jSGxtAw78qrY4xRt6LWOSkfPLSYtJcH9jD/xSoqDUFfdUE19RnhOuI1hX5MWPapxh
	Y4saMW4A8kWo5+/Sbm1p0hu2Y377h/U3jTRYKGTTuZJfm9m3F6czU80zNqlRHWugUd53Ckco0B9
	vHvjhJegdV+cTNi1xQqwseWxm9QfRF8h9OBwC7jHQjuTYC23eCWISFm3E1QlqzscvMLdwZ1UckO
	0RGJJQuFMpq4j6CEmjpthv7p36J0VrahE
X-Google-Smtp-Source: AGHT+IF6NY9gxXA7JqfnA4KnwXRga6feyk2kpV11UBsAGyAtweNaW4JjSHV3HQL5tmgX7CEyEe756w==
X-Received: by 2002:a05:6000:1a86:b0:3a5:8a09:70b7 with SMTP id ffacd0b85a97d-3b8f41d4363mr5608855f8f.38.1754578553343;
        Thu, 07 Aug 2025 07:55:53 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8fc6ef28esm2353171f8f.60.2025.08.07.07.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 07:55:52 -0700 (PDT)
Date: Thu, 7 Aug 2025 17:55:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] irqchip/gic-v5: Delete a stray tab
Message-ID: <3a1aa279-718f-4e45-add0-05727ba41706@suswa.mountain>
References: <cover.1752777667.git.dan.carpenter@linaro.org>
 <670bb1dc-7827-4916-84f3-bb46ee408b20@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670bb1dc-7827-4916-84f3-bb46ee408b20@sabinyo.mountain>

Hi Thomas,

Sorry, I screwed up the over letter so it was sent as a different
thread.  These three patches are still required.  Lorenzo reviewed
and tested them.

Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Tested-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

regards,
dan carpenter

On Thu, Jul 17, 2025 at 01:45:24PM -0500, Dan Carpenter wrote:
> This line is indented one tab too far.  Delete the tab.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: no change
> 
>  drivers/irqchip/irq-gic-v5-irs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v5-irs.c b/drivers/irqchip/irq-gic-v5-irs.c
> index f845415f9143..ad1435a858a4 100644
> --- a/drivers/irqchip/irq-gic-v5-irs.c
> +++ b/drivers/irqchip/irq-gic-v5-irs.c
> @@ -568,7 +568,7 @@ static void __init gicv5_irs_init_bases(struct gicv5_irs_chip_data *irs_data,
>  			FIELD_PREP(GICV5_IRS_CR1_IST_RA, GICV5_NO_READ_ALLOC)	|
>  			FIELD_PREP(GICV5_IRS_CR1_IC, GICV5_NON_CACHE)		|
>  			FIELD_PREP(GICV5_IRS_CR1_OC, GICV5_NON_CACHE);
> -			irs_data->flags |= IRS_FLAGS_NON_COHERENT;
> +		irs_data->flags |= IRS_FLAGS_NON_COHERENT;
>  	} else {
>  		cr1 = FIELD_PREP(GICV5_IRS_CR1_VPED_WA, GICV5_WRITE_ALLOC)	|
>  			FIELD_PREP(GICV5_IRS_CR1_VPED_RA, GICV5_READ_ALLOC)	|
> -- 
> 2.47.2

