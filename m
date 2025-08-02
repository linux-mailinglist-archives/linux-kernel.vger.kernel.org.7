Return-Path: <linux-kernel+bounces-753975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A0EB18B16
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 09:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E57C17B0CB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 07:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C3B1F12FB;
	Sat,  2 Aug 2025 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jt44mGFW"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929AE38FA6
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 07:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754120141; cv=none; b=fTBg9jEH45ADberolGRypBe7Le+kSUr6vEpY7G7/CNPARQFUJP2z5jdmKL3Jddp1XYpkPPLcrBr2GuX1Hb6M8OnojfDGCehMjlsl3sfdXFMScJJtHsuKKoY9zcqzzx2RiPL7ZLBmB/LDYn9zwR5tnQYsb9zNDihfI4PmsrKDIXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754120141; c=relaxed/simple;
	bh=KjMy+vyJoWdsOdo2HrOGdddfSmmyGsxLRyR/Gb4wSEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMI1HgOHI+SbtPzwr0RUrZJ5YJvotNImCY4e93YFIPU2rFVTF85pDg7YeALmLQUkK5vvok00dZuzwsbVRFoznYE9NjUUd/za8IG1An/2Z0zvVlX5VlGdty2kvNiv4BO1lS9PB3EBUHoSnsOzJErDrglMb/T9DosM+aZnbMoBzAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jt44mGFW; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b788feab29so1395740f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 00:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754120138; x=1754724938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/Rq8yrsaANYeJXcIdVpkfDYBEqWUqNEPhGfDYm3Rks=;
        b=Jt44mGFWF3oF5h5reEJ/StWTAR5+xTK1cQ7Y0C6GLEZ8GMO9mGI8l2ZtGSt2Vb5/Z4
         m1AZUjNAuviJ52w/dVuEkunTF3Td0KJVHb36Eg95vpPgzR3d1nlPQu+W4kO1vUUn7YY+
         0i0DEMiv+WBIgHjuRkbz4Btw6/OTAyS3AGv4qcugBW5lCKdhwGowfg4uJhXNGNy/r2X/
         AgwABHMahT/qsy1bGKy59c0LPcBJn9rkOrhpT3XPfSn3V2IWBw5/ub1iiV2uFKstn9aS
         vzKOIKg7E/DTX1X9IjzFj48hOXTv8xfKNGMQUusVKaYiscTw8sD1VTOh1RahF8bfX9Ij
         UVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754120138; x=1754724938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/Rq8yrsaANYeJXcIdVpkfDYBEqWUqNEPhGfDYm3Rks=;
        b=ADmNOdfFExEq097AQ22k3P91FVU49GgrvWWcGR6g6Ly/czOhvGQ1jgPJhUFOq4C8HR
         BYJTBr1bkJDMvdEmuLjNvsNzRjxcnlJ2i7xphI8X6ZKpKhNQCD6I8GXI+SbTQ4mZT+rG
         JUJzQxRdUkW+AUw5SA+wgXA65ETtdx2V0ROkJ1Oe0wkRQ9/XVMwCnw24UQFX5/UYTRAe
         qFm0VH50Z2A/MFDBNU3CJpP/cXdOwnAkgoVdIRMAy78LcSqASuWXFWbwn6cQjmE5WOft
         uId17UfhLIAhUC0u/vUNNIzVXkx201L+aDuvfj7JdwTqrnJ7/cZ/qbCG5eBQzKSZXJAb
         hqOg==
X-Forwarded-Encrypted: i=1; AJvYcCXwyK2UoWcvbKZc1wt0r5y1Z9o69uH46p/mEcWjkaN2xqUmHqPnm5nCE9ZyTr96AIygtWqD58eunR3XnVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg1aGcI26ZLSvsz4x/EDqjtmaNeoBZEV76vXzvq7dDPmFc3yUu
	BkxZrNzQS1JFPIAEVL5H/ZBY93648N4lSbJxg4Y1C8AJFq1gelf2xgQuw6zxB2TMjCk=
X-Gm-Gg: ASbGnctfSCXdt1c5nNoCQh2mvu4YnIxTJE4/nvhvquBs8KpwlYyfYXZ7ZGSKHHm2uVK
	4bQiTgF/ktUZc+MkskuzBTb32GeAb/ZfqKGBRGiJM2JUpvkoOHNtRYwHK712jdLCEk8RTaYdYRt
	fShEABQOmfKFBqtZXs35MZBSU591YaYfY+xJxrBUlyHwsVlK+OR9IQRN2aiafyaQwVm15sY7Rf3
	xnuFyQBRaxIhIFhsRP3XlQgLuHW/MNBC0e5ArixpQgNDIi01gFbgevLPNBlV2c/nGj7RcfAaNXV
	CILjxJAeqjv+/hzA6PbwM8ZCHC1/rJmjZ0doc/SbwstYaV85qyLr/RY6ZX+Zu/9b6DPGAge8bKd
	Cf3C8SKzN/rkoBv0aG7/YBjCRHlXGBqfpt64KXw==
X-Google-Smtp-Source: AGHT+IGzFox4oyjb5/WhDqdQVJopYxoMkjFPEJSXG+cagflCj14ks0y04aMJJDzRXsWdRJFhVzyzQg==
X-Received: by 2002:a05:6000:4011:b0:3b8:d32c:7740 with SMTP id ffacd0b85a97d-3b8d94c1372mr1661279f8f.43.1754120137907;
        Sat, 02 Aug 2025 00:35:37 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453c80sm8299041f8f.43.2025.08.02.00.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 00:35:37 -0700 (PDT)
Date: Sat, 2 Aug 2025 10:35:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm/nouveau/gsp: remove always true if check
Message-ID: <6a0dd96d-e98a-488e-87d1-a3e6cbce7b53@suswa.mountain>
References: <20250801-nouveau-fifo-v1-1-25b9db5283bc@ethancedwards.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801-nouveau-fifo-v1-1-25b9db5283bc@ethancedwards.com>

On Fri, Aug 01, 2025 at 09:49:26PM -0400, Ethan Carter Edwards wrote:
> if (1) always evaluates to true. Remove the unneeded check.
> 
> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
> ---
>  .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fifo.c | 36 ++++++++++------------
>  1 file changed, 16 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fifo.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fifo.c
> index 1ac5628c5140e66d306a1aadce10c810886afad3..104c72ec359a07a318ac99f5c217f0b07db2b784 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fifo.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fifo.c
> @@ -188,32 +188,28 @@ r535_chan_ramfc_write(struct nvkm_chan *chan, u64 offset, u64 length, u32 devm,
>  	if (ret)
>  		return ret;
>  
> -	if (1) {
> -		NVA06F_CTRL_GPFIFO_SCHEDULE_PARAMS *ctrl;
> +	NVA06F_CTRL_GPFIFO_SCHEDULE_PARAMS *ctrl;
>  
> -		if (1) {
> -			NVA06F_CTRL_BIND_PARAMS *ctrl;
> +	NVA06F_CTRL_BIND_PARAMS *ctrl;
>  

I really don't like this business of declaring variables randomly
throughout the code, unless it's required for __cleanup magic.  Anyway,
here it breaks the build.

regards,
dan carpenter



