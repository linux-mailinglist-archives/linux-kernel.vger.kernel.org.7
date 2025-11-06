Return-Path: <linux-kernel+bounces-888820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB8DC3C051
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F59565301
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354A9224B0D;
	Thu,  6 Nov 2025 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zfjtctJI"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FD71DE2A7
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442172; cv=none; b=HCCkLje8X0Hd4RzSgvvqiQc9I/I5JjRzpsLVD8KrGA0FaG5TSTDgATFeeCCvCUDzY1DbZUbMK5rgMwRCSK7kgXQ1lIvn/2ScJKlRrfM/05MxUEOWOvb15MY3W6H0Xxo4BH7AXSdaBA4+XzKtMSPeg/tsvFfY3aaA9k+LCrm721U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442172; c=relaxed/simple;
	bh=41zrFfEL2l2XQ63gU+qhrRtQA3Ib9OhNjrgYj07OAIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkFcvzmZSZyMvz045EJ0rITLxpexwh0xgie7ey3RPIYYX5qjE0b7E4utWSW6+0WCqdz4rc9lS3sjaAaBVbq5Mslp5IEaNKX5oWiyXKZYykF7GpTPb39KbFvI32+0Y+kFKGY6kEOZfh9wY0pXwjM6VgdHaquh3uQGbY/VGF1ZR4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zfjtctJI; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b710601e659so212399866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 07:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762442168; x=1763046968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u14FmWvrKmKOUArfGYUhEF2EQY6v0Fb3SsmeCkhwUFM=;
        b=zfjtctJIwwNY5wZF9bcH90FsR/wdhHbdAIAETM1W6yZxKXSf0Ugqsh5mlgRRdt95Pq
         lVkM34/AWkPAstaf89flf17ltRQshX9HCwTF3evDDbtHU06x/d0IIgNZcKOlC0FYrWCP
         h3E0XKPSKi/yWRsVFjh3+L94FxR3367k0hsrauv70lT+0lEIriQMWR2nQEWUL8ks2mwE
         QsiFXUh+RKg4l9yH0CzemEHFEGCr1UgKXP60aHcvXrOE2MLgYNfKIoNM1v6qieW5LuyP
         6DMBtToEkmAbU26GToNIjviMcZr2xz2dcFaqB8zrSnFoFyf0BqfLY+CmEdc1DnsskPS7
         pnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762442168; x=1763046968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u14FmWvrKmKOUArfGYUhEF2EQY6v0Fb3SsmeCkhwUFM=;
        b=RwQxxqtchKqjbZy1xv4EKBVBkoaGB61A29wvHWQkqfGRWcY3wCjYIYUm/oJOqGvgPH
         YNuvS/bhCyznuqXn2eeiGelNmefk6H9pFPflp51zH++k5BVim5cT/0AFQxQZ7xCcHczi
         mSrdbpSFIQXw3ic5eL96U/JTwp1awaLFzQuoANZGLpFHZBwTQ/uEyx/aP7Y7LjTnXQG9
         4c47GAt70ikt18eX7twaOzxx1SKSOlypiBPA2cW1fzct8lt8gNYZ2LeTTAdOQsRW54Y9
         pl61jBL03JBq+tqOj7GdtOs/JqYdy7Kzbu7gNaQZ3Zo9tXFoI4y/PwWLJ/tS7v/4wJ2z
         TCAw==
X-Forwarded-Encrypted: i=1; AJvYcCWc8g7cyAYpcteosBEdE4VIy/+I00GxhC7QRJOibShP6Y5mWSpP8vaWrMEwauUjL5gF3+9OgQyjZsVTvSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlKlTE5jEqW159WurDJgFFNf+izqzVgHbhzwxAZpZeatTMxFr2
	MU2u3d9/qaAxn7WGWJqGPoY1lc4BrcOD1HeR0BAoSfh/kY7ttiRh5zFvdhs6mZcIelk=
X-Gm-Gg: ASbGncsnSpdXEC2WwZrM8T2cV3dZSzCAKJzVvH1Z4l5C7imTSubqfOwPfruzuLv3r2d
	0OvCHx2mBNJKeU8UMlYaKXYUlzz8qEORvPocQtR9xtMDwQ3Vy2UfQaVTg9ETpUL/bu70PWAE/aN
	MYc2GlH/HhFdVVyklG4FcpQmD37RQsjcJd9gB99e0ly4j7I7+U9ChEgmk7WrqrTUP3Di85RpX0I
	I/hdC+Dv34/8YJA4wtUW/0b+gxI4XxfjwmI2OSt/jGsD3RRHyQzN4sKY1uajemBYMEKKhi8Dq02
	A1+li6vvOU94Im2GKFl6m5nOaMP6wuDNLM5sIGcCNhufHdPB9FcKsrzW318IPockjX+ockGUR9j
	LVto3cTjclAQ+WjjjjkA2R2N2G7A6Sy00auTYPT8nTYpC2JOkLH/aHacwQsOBu3C92F/Q19Nq8e
	ydZepFB9hqL8cW
X-Google-Smtp-Source: AGHT+IEf7wBLuEfCRt4j+/RlzPZKjUAiSvKjoVNYNm2utzq6YqdxRCDzqeo4lC5zRpb3wTnkArDt4w==
X-Received: by 2002:a17:906:f59b:b0:b71:51b:bd4c with SMTP id a640c23a62f3a-b726554bb96mr724343966b.50.1762442168333;
        Thu, 06 Nov 2025 07:16:08 -0800 (PST)
Received: from localhost ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b728937cc60sm236069866b.16.2025.11.06.07.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:16:07 -0800 (PST)
Date: Thu, 6 Nov 2025 18:16:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, error27@gmail.com, andriy.shevchenko@intel.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: trigger: Fix error handling in viio_trigger_alloc
Message-ID: <74993472-4845-42d5-8b50-8fa8dc5b42fa@suswa.mountain>
References: <20251106082923.32688-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106082923.32688-1-make24@iscas.ac.cn>

On Thu, Nov 06, 2025 at 04:29:23PM +0800, Ma Ke wrote:
> ---
> Changes in v2:
> - modified the patch, thanks for developer's suggestions.
> ---
>  drivers/iio/industrialio-trigger.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 54416a384232..9f6d30a244d9 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -524,6 +524,7 @@ static void iio_trig_release(struct device *device)
>  			       CONFIG_IIO_CONSUMERS_PER_TRIGGER);
>  	}
>  	kfree(trig->name);
> +	mutex_destroy(&trig->pool_lock);
>  	kfree(trig);
>  }
>  
> @@ -596,8 +597,9 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
>  
>  free_descs:
>  	irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
> +	trig->subirq_base = 0;

This doesn't work.  Do it before the goto.

regards,
dan carpenter

>  free_trig:
> -	kfree(trig);
> +	put_device(&trig->dev);
>  	return NULL;
>  }
>  
> -- 
> 2.17.1

