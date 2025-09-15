Return-Path: <linux-kernel+bounces-817137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BCBB57E58
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C4094E1744
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED4F3093C4;
	Mon, 15 Sep 2025 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="r3yRAoc5"
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5631D555
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757945121; cv=none; b=P2/XT4Pfou3aYje42trt1MA4j1b3jyt6a9Q97keF2pS1gZmF8ZHZNXBLzwjImsuifu58fwRr0UhX0YgeXTkE/33JlaSy/egtAR+snsZCiWtXSo69U/mK7oVgJQEUm3oYZC4AhvuiYkFSQWwCIf3h95nmqIKGrPoZNMyqtr663Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757945121; c=relaxed/simple;
	bh=C+r9QydbdeWXlv7FnOvwDgfSKZyi0JtsDi6wUiXpcAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3435bnFa0OYPTOsFrDCuFORBYmVjyfAk6C/RQUJQ4X1BTqMIwdJH3WwKXuvKDcsG0yXXsx6mjNt2w7e2/PQ8bxeX3O3ExQpddbPGMvkoMPyi/0tovhNjefmISchbWRZJvfXyzzvzkxK5Zwzk2jsSMo4Zzbjzuocfml4Nu6/0wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=r3yRAoc5; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-629061bb7e3so853176d50.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1757945119; x=1758549919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bwYnkwtdfCqWLl9gcBIyB33wD9YpSZTIVWI9Hj0NbHI=;
        b=r3yRAoc5yU/UTJ0pohGFtYeyt3bFTFCXAJS/C9RnL+3Gi136AAXUpBzLLx9k22S3qr
         /n9E2+1WxQWNgDb/NZLiJsL5Uy+dLHsHv73aeDL53GobX3rL068P4rgrYj1FTC9k2myH
         sXpoWHnOCz+gMOotI8LlRcfMXzJpo2I9S5pCkDzKjsshviJPiMqdPss1V3+eZXJqyjLk
         fndPqEsj0JQa6uDmZQzNpfDl5aO6C+Ss/oJeGBJNOvkGjGkTX7mrrrVqEFA91yYSZ1jC
         atBrV0LgKkuNOn9yv41zxfwgiHG4P69oh3Jl4/dOlH2TszOoljmWPaVq2/l3D2HM3lvy
         RSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757945119; x=1758549919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwYnkwtdfCqWLl9gcBIyB33wD9YpSZTIVWI9Hj0NbHI=;
        b=B5fmmGy+94ogwFWUJN5+tAbN5BO5kdRS9lymGew8F3ACiTyifXVefm95rHoPU1cTef
         QyP5x/9nOhypSwqa60v2znq7c9nQ42gAyOPNdDEh+BPnlea/e/wSngs0PHxom/+2nNos
         fjZ5K43WOr+h7DJ+eG1jSasxIPfifXPAkXiwEkflpKqBLjOrZzxPpS6UsqatGoIsq9eJ
         WPn+v0YJJhNIW7JgKoerrBG3Ji/Da8HHrmS1LJgbybIihiwcDk5t0bXUWRgQFLVDlFlr
         3TMqBQoUyNuI7ATBGIUmGhe8R45Uin1/d2qTdDSRy0qI3Ad/QLsxtPjiMSVSVGHXET6C
         RY7A==
X-Forwarded-Encrypted: i=1; AJvYcCUJyEanz3+/wQ/3Gz3MJ93sWsecjK5Pmi44Ftrg8KMULKTbjJVNlRZACgWiNPLQy3DXudOH6LtAZTJcH9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAvUrQ2oPUIXAqPWYxWqRRfY/lgwe2QpmGuCDmIJzquJjI+2CJ
	15r6RoEs4HOQb/yIX09m+BdnSKgUN+69pBjW8qOAKJ1SbcGlPTiXD4VG0Qp5UG2rUg==
X-Gm-Gg: ASbGncuK3/N7KOGOx8m5K6keRTxg0wpEuhv6DFnAdxVWulONyX3Ar/oUquaN7Dt4rzE
	wyyyOR/Bj3CNeYOvu83bXoMSDT+2escQVtXY/uHOlQT5QZrqI73DAaUkCx8PPHoC8qiRU8+Bs+d
	1hndO2gj02Hrz9f2Q+SX+S7x7UrI/qRPo3XRGqxlSaNM3ccDUx8rVe3yxsj9kFd8nFmucVFFlAe
	YlAQVBTXcYAv4N5lKJhE4J9X3h/h8GPMeNO/7yZR9Xes1wRt/zRKetwlt6Tqu/QXelz7KUCCfYx
	lBgbODdhwFNE5M5kDW6m4JXl7NFHYulPTQKrKd9TVXRFpcRbrHcCqVbx4ZvicLbvxovWgK2HvhI
	n0WBqQRlFFcyxl6xeTQuWQNGww0EcxjqJ+79DK7+JNNa4yWPBGGR1
X-Google-Smtp-Source: AGHT+IHKOwAZPyuZ8MCrgdObQBKROdhMB9ALbM4MZEg1IGWdFzuJ1297fvboQyVsLtiGKky0GtLGFg==
X-Received: by 2002:a53:e8cb:0:b0:62c:204:5dfe with SMTP id 956f58d0204a3-62c02046306mr5284610d50.4.1757945118538;
        Mon, 15 Sep 2025 07:05:18 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-77a987c2099sm32195346d6.35.2025.09.15.07.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 07:05:17 -0700 (PDT)
Date: Mon, 15 Sep 2025 10:05:15 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, jun.li@nxp.com
Subject: Re: [PATCH] usb: gadget: zero: add function wakeup support
Message-ID: <95ff48ae-5cdb-4e3d-aeb9-1b6cc33412dd@rowland.harvard.edu>
References: <20250915090230.1280460-1-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915090230.1280460-1-xu.yang_2@nxp.com>

On Mon, Sep 15, 2025 at 05:02:30PM +0800, Xu Yang wrote:
> When the device working at enhanced superspeed, it needs to send function

Is this also true when the device is connected at regular (not enhanced) 
SuperSpeed?

> remote wakeup signal to the host instead of device remote wakeup. Add
> function wakeup support for the purpose.
> 
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> ---
>  drivers/usb/gadget/legacy/zero.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/gadget/legacy/zero.c b/drivers/usb/gadget/legacy/zero.c
> index a05785bdeb30..fe286b597f9f 100644
> --- a/drivers/usb/gadget/legacy/zero.c
> +++ b/drivers/usb/gadget/legacy/zero.c
> @@ -147,6 +147,12 @@ static struct usb_gadget_strings *dev_strings[] = {
>  	NULL,
>  };
>  
> +static struct usb_function *func_lb;
> +static struct usb_function_instance *func_inst_lb;
> +
> +static struct usb_function *func_ss;
> +static struct usb_function_instance *func_inst_ss;
> +
>  /*-------------------------------------------------------------------------*/
>  
>  static struct timer_list	autoresume_timer;
> @@ -156,6 +162,7 @@ static void zero_autoresume(struct timer_list *unused)
>  {
>  	struct usb_composite_dev	*cdev = autoresume_cdev;
>  	struct usb_gadget		*g = cdev->gadget;
> +	int status;

Please use the same style for your new code as for the existing code.  
In this case, use tabs to align "status" with "*g" and "*cdev".

Alan Stern

