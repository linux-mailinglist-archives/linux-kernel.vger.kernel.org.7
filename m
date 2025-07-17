Return-Path: <linux-kernel+bounces-734630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3441B08424
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC5316A3D6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 04:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC5E2046B3;
	Thu, 17 Jul 2025 04:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zOBCP8RO"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2098B1FF601
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 04:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752727504; cv=none; b=RIDJgumTk6uAqLs6brQ/sB6sffmJGyhN+2lblH7C8w4VRqZLzM0owH80cSTEJ3ZJnYnkmAh3TE1NABOrKNp9llKSEzmseP15187UGIUUKLyxS1qyYoRbpU2zsUHhRAeBRpD3VaKFNyaYcNCOVZAPJ5JPOgV6niABBrT4fJnMG44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752727504; c=relaxed/simple;
	bh=xYY88o1HZHO/K9meJ92FwNw3WDacmrol27HB7s9lxng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLmbQyEqtmTyBM31WfrYusubx0RPCtv5TSpp/OUDUj+B015KJztsqMaAA+mzzcmCsiEJS9J8bWwcGo5bPwvMmsOJ7viWIrpb7y0ud/c6t2gyReV5ChrVcQlKSAhunFkkEhwNwdBvTq/T+xCjVIiEhUazt7q0cZdNO06fvC8Nbvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zOBCP8RO; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-73e65d29fe9so274486a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 21:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752727501; x=1753332301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8BxFpUzbTga+mXNbGQF0qc8Yea8aD1D/kK9ilcak6H4=;
        b=zOBCP8ROTjU6dQtTHbwJI5I1zdAblQe3B2f966EtAokEGXWS6sbp/YA5ZO95dLsnc3
         KdmuyUR4gqBHLNqmh3WG5qM8fWuVhbOzo1dGAw8hMpRLyQSDTqfxq0GIA2ILsNKGP15X
         P+/JTYp3TecDJ/U4+JImEJ4xHQ/8MIKesG4gjdm2ApvLBKx6K/2E88my3c3vSwr2bUNo
         vlc1A5c4GKUGP6YihIzCxgeRfa0EbQIDB8go+q9DU+Ni8hg2Zx2G9/TpVkz46J1/7eTy
         eociT01XXpe7sqGyMFmvx76BroR1lFCB6cFUW7xEz9moB4ijMnNB79sLIC/HHxyS2eJN
         9org==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752727501; x=1753332301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BxFpUzbTga+mXNbGQF0qc8Yea8aD1D/kK9ilcak6H4=;
        b=beBYjEDKtRI0/RfokFAB3MXUBaPjWkbaZGkhRxp663YQXzfUIPvqN9J/jIcnGZa2qe
         KT/fky1kmhCKqugY/U+YIvVVELLxgoi5tw/Q1WkBvVXlhLDEUAzf7oDzlA2sB/Zov5wZ
         JJdpmkXnRvz05h5QuotYYaB8hOOg+SDlTbu2eZpe8YGgKvtEriQH+L5M9G5kECRrJqi3
         0K8dKycuNC+CBwmVAT6JCDMM0oX9yHBEfCICaiz/ROr+9HoOhQO1oGSAwjLly5YAwST+
         4/te0ooZSSoNAGNKlGQwplmnpnZF4iWw2E4/FED3RwhZVTcwMyXdLFd1M74huPynp13D
         mA5w==
X-Forwarded-Encrypted: i=1; AJvYcCWkQH03cv12mZZHclPfoZ0NPdTCTAER36hUwpFTZFcj9y4fyKufZBjeP4a6IhoZ9A38cq019EZ0cUtn7Ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvBk3iUv0W94WdJypcNEFflBSyh/WX9U2o+xbZ1UHFllmUjeDk
	wJSbiI5bVuQd9RBEUeJgVEEg27XVjTZ5DICisDrEPI7Nk/Zuw270awEyDAEThaf0lnQ=
X-Gm-Gg: ASbGncvWm/mimB3jAQiAfS/+hsoEd/PUex/JcL/ZMUQDPbalXUyNCA03vy5KAA52Nhj
	MdCW9BmBltA+LmqGzcCWON+WxBcVrynpBA4rHUgWKLmW+X9bUFV4+x/TAzMJ16w4WAKykgJDKpV
	9fl/n942E1D1FwqZ87B8u/PdajxqqJAMkoxFx1+Gq4PXfYX4aZYmub4vnYcJYHcr1kSVKfSgr4W
	nVgAiGRkL6jJVPThkueMFH2T5WkZgLrujkBqGN3uu0XXM6Ohzh47oxztTkrqnyMldSW6fmxVeDR
	sbLGPgc9DZm9v2wWoXgD5V2FBrLjIRqRqJHaJ6DT4tZEi0BypuV1p8sVWHFGym9ALK47Uus/maw
	pRIr7BaQtfyqwYVbHuZ6DHFLkqWlV
X-Google-Smtp-Source: AGHT+IE+DpDEa75xpbSgyLwwke9OcELJPLIznBHV4EgtqVLoSi+kaH/6b3ycchLcJ6wlacIG2Wojvw==
X-Received: by 2002:a05:6830:71a4:b0:72b:98d9:6b1c with SMTP id 46e09a7af769-73e66604fbcmr4375731a34.21.1752727501133;
        Wed, 16 Jul 2025 21:45:01 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:2c38:70d4:43e:b901])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e776b0dc9sm202888a34.26.2025.07.16.21.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 21:45:00 -0700 (PDT)
Date: Thu, 17 Jul 2025 07:44:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
Cc: hansg@kernel.org, mchehab@kernel.org, sakari.ailus@linux.intel.com,
	andy@kernel.org, gregkh@linuxfoundation.org,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v2] staging: media: atomisp: add missing mutex lock in
 atomisp_s_fmt_cap
Message-ID: <06f61db2-da3d-4de0-8ce5-04e135add870@suswa.mountain>
References: <20250717013003.20936-1-abdelrahmanfekry375@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717013003.20936-1-abdelrahmanfekry375@gmail.com>

On Thu, Jul 17, 2025 at 04:30:03AM +0300, Abdelrahman Fekry wrote:
> diff --git a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
> index bb8b2f2213b0..d3b8e480065e 100644
> --- a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
> +++ b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
> @@ -9,6 +9,7 @@
>  
>  #include <linux/delay.h>
>  #include <linux/pci.h>
> +#include <linux/cleanup.h>
>  
>  #include <media/v4l2-ioctl.h>
>  #include <media/v4l2-event.h>
> @@ -416,8 +417,15 @@ static int atomisp_s_fmt_cap(struct file *file, void *fh,
>  			     struct v4l2_format *f)
>  {
>  	struct video_device *vdev = video_devdata(file);
> +	struct atomisp_device *isp = video_get_drvdata(vdev);
> +

Delete this blank line.

> +	int ret;
>  
> -	return atomisp_set_fmt(vdev, f);
> +	scoped_guard(mutex, &isp->mutex)
> +	{
This open curly brace should have gone on the line before:

	scoped_guard(mutex, &isp->mutex) {

But actually just use:

	guard(mutex)(&isp->mutex);

It will hold the lock until the end of the function.

regards,
dan carpenter


> +		ret = atomisp_set_fmt(vdev, f);
> +	}
> +	return ret;
>  }


