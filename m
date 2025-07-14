Return-Path: <linux-kernel+bounces-730741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DF0B04922
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BC0D4A28BC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 21:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9154266B59;
	Mon, 14 Jul 2025 21:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DIenBUXz"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B73D2475E3
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 21:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752527379; cv=none; b=fj1y97hJwKBzfkVdXSOeN/xPwgDOPdcUa3CVdzjAYQJlIHZi8fdhjfzWix31XrK8O8+LVMWcvsJ9D8T+P12PlWR1BBbFa+TDcXNziyFPuo4HmtnpI54W3gnMtyBcnrWnYvfe/zCgtKgKZIu8GL3cbga9MLDTKA7F+kpsNfYbZdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752527379; c=relaxed/simple;
	bh=Eo0o2hEb39hiPyghzkvSTKfu8tBjairbI2YusZgQgHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfdWmYjTOrUGzw8oxWwQAmns+45CoBS2PVvWkQqYJPFJm/F5O4lDuIRZ5DV0/mn9UFLV3VXi/2BuUd0HJ6DrZLc6XI95dZGk8wpgUcrGhTomC2JLs+k+j4nVDIC7kUGn3m+80dmWMghzR+bChjWNh4T/6S9myWcECTFOH3w/fc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DIenBUXz; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-41b1ca1f28cso422416b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752527375; x=1753132175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UvTi+cy+QDC0rQAzEsO6ZT46EiAuz4DM9iAPl2nhYbk=;
        b=DIenBUXzhBH5yf1uThKAVGvtwAvrWsDBjgETugfoQrqzbLEnUgF8CSPbCnXQjsueNq
         1LOLIMLksV6rYrNGO5sufVh4AaFoBeuYv5XxwTYz3OE1JK9M2bXXCOZhwIFx1gmnUAXb
         CDVhVNdxKMu0lz+DTJ70tb7t5b2IvJhUlJxfWCWCClNY5IMorQY+p+MrdWZ8RHhmyIIn
         Dr1uE9LCBZJoBC/cW/UZ4YT7XouVipaVw/L7h/2/i5eumyiiKhIjpl6/Mvll0GQNQVJN
         yqrHlYlIZAwhJ6KiRwZQe0uo/Cbsl1iHksC7tLtUfMgJx5N8OALR5V1Se4+OBLoU3uTS
         /0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752527375; x=1753132175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvTi+cy+QDC0rQAzEsO6ZT46EiAuz4DM9iAPl2nhYbk=;
        b=QHqVKPNTpUbOoSvejRBUHlEXayYcHu5p66WtW4FJoaDOXXGMrsA8dv8eNyd2OPr/ag
         8Vnt1CnBBm19EnTuS2H5Q05kaSskn/dwUVHij+1I9MVXJPNv1liDuLdZTC8PcH4OdlFi
         GIaBzAWX5y6n+Yjn+/ZdAR/3rvUGshZgVSOqBTwzVylBGlpMGeNOx9gPyIyfRP/yT/Am
         nZ6tb1DD5wpXO44XjeI9LKVl27cVUpdVZArg+5joDMN/Lz/ClDO0W7/4SZmSXbYp6lXQ
         iMi1o+jv82FKz07YoxAE5pDmGriOLLWUwbPg3GtzspisM6/Jdr9ddvWy5G7+FYq5FfoQ
         oqtA==
X-Forwarded-Encrypted: i=1; AJvYcCXahUFu/IfhzUZxrFJ8UW4XntVcWuF/GZJF3SUNUs2KCEEBAmUJfK5GbZ+NwaYSAbmouMP/xfEiTMomBMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVe3e35sIUOReGypA1RN695apzZaacRizcrhKHaAISOSHfWd40
	5TTbClGihXN3jtUWSs14gtCycsPInCn+4rm+3bInu9hT/8+A6qFAjEduw+1hZXQS8Xo=
X-Gm-Gg: ASbGncvNTgJMhx9l50b/1N2W2GZjjL0wIxV4awt1TlSsQChQFD52r9M4MHAl2V8VRu+
	C+5vB85lLiS+FxPlC0ymvBT4jSL1sa/NBIKUpx0U01KCmiseavL/J+ZpbkqevZ+jvCVe8UDgGFx
	RiYpOm6XMDmHFs1F4tzNTC/xv7/epwZln7DLn+F1q/VBPT676U07kU3XHS7a23G2KMeDtVDfCxO
	bvdhUyTCa8lNAh1NVm72uml1NjUBEg/GWZ3AjL8WjJ0CjY72MDz+B8iE+5jqmh95BoRTQCJDQLB
	22uq/ymhVILnzcoJ5uP4Qbto5U1GarOuDR10xIHx/XkQdBP5pDk7Pkv93gMSKX749Yt/88I5bsY
	b3YuptA66Cn9u9SA/y8QBwa7kiPjBGtJjfzKH3IfU
X-Google-Smtp-Source: AGHT+IERTMOpjsDRrZFdMuMNdim8TfF6hlXEjvbR3D4xp58pSuklvW4nDe2xvA8xk6yFe6KPdBlrbw==
X-Received: by 2002:a05:6808:11ca:b0:406:71fd:b610 with SMTP id 5614622812f47-41539d98e0bmr10236884b6e.33.1752527375538;
        Mon, 14 Jul 2025 14:09:35 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:6bb2:d90f:e5da:befc])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-41418c0c259sm1635798b6e.5.2025.07.14.14.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 14:09:35 -0700 (PDT)
Date: Tue, 15 Jul 2025 00:09:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: sina hosseinizad <sina.hz@gmail.com>
Cc: hansg@kernel.org, mchehab@kernel.org, sakari.ailus@linux.intel.com,
	andy@kernel.org, gregkh@linuxfoundation.org,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] media: staging: atomisp: stylefix
Message-ID: <6519f649-82bd-4f58-b99a-731fb86aa1a6@suswa.mountain>
References: <20250714142645.88038-1-sina.hz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714142645.88038-1-sina.hz@gmail.com>

On Mon, Jul 14, 2025 at 04:26:45PM +0200, sina hosseinizad wrote:
> change the spaces at the beginning of the line to tabs
> 
> Signed-off-by: sina hosseinizad <sina.hz@gmail.com>

You probably want to capitalize your name.  It's supposed to be written
like you would write it on a legal document.  (These Signed off by lines
are supposed to be like a legal thing which says that you haven't stolen
any code or violated any copy rights in this patch).

> ---
> My first contribution to the linux kernel, so starting out with a stylefix
> ---
>  drivers/staging/media/atomisp/pci/atomisp_compat_css20.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c b/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
> index bc97fa2c374c..bd3a017490ef 100644
> --- a/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
> +++ b/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
> @@ -2347,7 +2347,7 @@ int atomisp_css_video_configure_output(struct atomisp_sub_device *asd,
>  }
>  
>  int atomisp_css_video_configure_viewfinder(
> -    struct atomisp_sub_device *asd,
> +	struct atomisp_sub_device *asd,
>      unsigned int width, unsigned int height,

The other lines don't match now.

regards,
dan carpenter

>      unsigned int min_width,
>      enum ia_css_frame_format format)
> -- 
> 2.39.5
> 

