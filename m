Return-Path: <linux-kernel+bounces-795927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A96CBB3F98A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 442824E1B58
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2402EA73F;
	Tue,  2 Sep 2025 09:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q0AVoKJI"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272112EA15B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803756; cv=none; b=ZRZXYcEURHBpcDMDr4CuqoAiAvXY1Smw0m4E4lMpPqkJdgUIFTrMx01xpP2pg9qqNk1Tex5zVlXD6PqNIzqZZiRNui98/0mBMtSP+eudJnYoBLuKmYl6fYs9xatOMmvHlkdgp/U++wNTYW7YoS6YVKyY73oLh0VBZSrC/gt0deE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803756; c=relaxed/simple;
	bh=oOsC2gd09SWVStH3OCZPd0RWU1k+5APOO3/9u+LKdaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxNss+Ty7hInYbPLZHr8g8zoguQ8JHhhU7Os4HpNkeRI0JO6HrdvaCxgVqbFrjK1ys9SjKwsFSbN1iWF/bncVb19rB495B9vMbgzTP0DgFWhKu/A+qFA7FZZ8OSGXK3Ty4i8FBZ1gOggi76S5jZNyrzMhDyw5XPBfbYGBA7nBZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q0AVoKJI; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b82a21eeeso32394645e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 02:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756803753; x=1757408553; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C1qJLMRO86kBaK32XQGtbUGvCudTpu+XINTSG1qXn1M=;
        b=Q0AVoKJIRU6sLXsFLAs6bAGG7pVAokR6TfTczxJuCKeK+niBYjWuPPORUHSurAuDYU
         0VE+8X8yCfNxxeSoh44lQ5XMJih6AvbBHB4FjMBeE9YfS3bCgoZGWcN1vY+mpYUfKJ4g
         GNI/1+oEeW8wNlvhuxQIhZAPPQ1P93G+J8JZmdIu8u7mLghzezfGxY5JgH9x6KFxjB3I
         napbU7q615e+ZG5TfPm3PsE2xUvCIdwNJqeQ2qBqU5qARmYAD0NNfBcYVfGQieBvzYht
         P5hegCh68Eq+8DBLLvWEYtENh+HTjPYApEX3ipbWf/b+kTPt0S/Le6ppjKH2rtCZ96uU
         eV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756803753; x=1757408553;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C1qJLMRO86kBaK32XQGtbUGvCudTpu+XINTSG1qXn1M=;
        b=PFPBUQYf/5BHqE5HRF/uazAuLoatcTCzzExSd9lqPdC0jSQjjqylzh4qchGpXDISKt
         KhYi20bLjhUi54PhrwhVYZKhBqjdssEDZ9rcd6/yulXEa0fAJZM2i+hKmjEYztAPEJz9
         obl8vfyRFi5GokSZVP6jXRjyDYzUI2usN62nUjPG+pEdl/FEVcpINkAV/IFY/hruMUMo
         7yOwRSnxGuHiJ1KCtfXRwHFSERbknWy6NprycIFjFTZ/Wd9+6clwz+qesPDPsF+NMeuO
         m1iadYZ37SzNKTTjd+OvBymqA/EqDJkLMvq3YN1+e8VnViOh9OrK4lL0gOvp+wGiim1f
         1LSA==
X-Forwarded-Encrypted: i=1; AJvYcCVdJUalDi8U/A12KD/UqwpRtOnIjeASCEIsd8VE7AFEHkvd4vG53yklwN0oK76cryg81CWIxa65ZNXQZdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWUyvbCNW0zVBmRgP4h2OY5E/iy8NUyOTAadKnvjMs2BJAdTpB
	Tis7rGJrephK/ug3AbxAZ8RJAEJ9v65u657/sSzeqk71CsIuUHGK9ltBCnXCerrUvJQ=
X-Gm-Gg: ASbGncvTSuxBu3vZ80AiLLaf6qkOF1yT8uMOmexUlnPhfyWr8zn1xeHmRl7foGXCRhV
	B9h5sgIzfCqCxZb51GSG8bLep+d09OsbiE6Vz0xDe/JXSNOyJi9PcgvFEmQBrDfEly7FvPONEtj
	m4tOQpE8m4idj2SwwRuBbfvz7yXbjZHRQXwa6g41C5ClaNoRifkM/quWgjWi3uhOpSWRb8GIqyy
	4dNHdXiSB+0EdXj8Vpw82wjMxTYjxvX6eFe0AIagcxXs8RlqNGldIRnmmhgAiDgIodPmjCC8MUQ
	Ynh9EDfB+aI+sliDNBid9KYTUAV1ppI2jMpCa3P829nvCkJsZ7I9HLJc/gmzq8/lXlSlwN1LERb
	jyj3MhVoPUKl64dO7e0Zedqh443c=
X-Google-Smtp-Source: AGHT+IFuemm//sDn/qj0h4zJPJMFIak6SnCztGlZa9zOLzUoeyHjd+ENyXK8/Xhkk0G9vUcU6KL79A==
X-Received: by 2002:a05:600c:1390:b0:45b:8366:2a1a with SMTP id 5b1f17b1804b1-45b8555ccb3mr90650645e9.11.1756803753361;
        Tue, 02 Sep 2025 02:02:33 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b6f0c6db6sm287723295e9.2.2025.09.02.02.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 02:02:32 -0700 (PDT)
Date: Tue, 2 Sep 2025 12:02:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Adrian =?utf-8?Q?Barna=C5=9B?= <abarnas@google.com>
Cc: Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [RFC] staging: media: atomisp: Simplyfy masking bit logic
Message-ID: <aLaypTjukJJloGuL@stanley.mountain>
References: <20250902073841.2338568-1-abarnas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250902073841.2338568-1-abarnas@google.com>

On Tue, Sep 02, 2025 at 07:38:40AM +0000, Adrian Barnaś wrote:
> Simplified masking logic in pci/hive_isp_css_common/host/vmem.c.
> 
> ---
> 
> I have tested this change on whole range of *valid* inputs, and it gives
> the same results as before, but this function seems to be little
> counter-intuitive as far as start is a (bit index) but end is
> (bit index + 1).

Yeah.  The "end - 1" is unfortunate.  I guess we accidentally started
counting from 1...  I looked at how to remove it but got lost.

> 
> It is follow up to: https://lore.kernel.org/linux-staging/20250901091050.1935505-1-abarnas@google.com/
> ---
>  .../staging/media/atomisp/pci/hive_isp_css_common/host/vmem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/vmem.c b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/vmem.c
> index 722b684fbc37..9703e39b7497 100644
> --- a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/vmem.c
> +++ b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/vmem.c
> @@ -22,14 +22,14 @@ typedef hive_uedge *hive_wide;
>  static inline hive_uedge
>  subword(hive_uedge w, unsigned int start, unsigned int end)
>  {
> -	return (w & (((1ULL << (end - 1)) - 1) << 1 | 1)) >> start;
> +	return (w & __GENMASK_ULL(end-1, 0)) >> start;
>  }
>  
>  /* inverse subword bits move like this: MSB[xxxx____xxxx]LSB -> MSB[xxxx0000xxxx]LSB */
>  static inline hive_uedge
>  inv_subword(hive_uedge w, unsigned int start, unsigned int end)
>  {
> -	return w & (~(((1ULL << (end - 1)) - 1) << 1 | 1) | ((1ULL << start) - 1));
> +	return w & (~__GENMASK_ULL(end-1, start));
>  }

nit: white space.  Add spaces.  Remove parentheses.

These are supposed to be opposites, right?  Subword and inverse Subword.
You could dress them up to make them look more opposite.

	return (w & __GENMASK_ULL(end - 1, start)) >> start;
	return w & ~__GENMASK_ULL(end - 1, start);

regards,
dan carpenter

