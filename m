Return-Path: <linux-kernel+bounces-710268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9C7AEEA08
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 00:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC203E0DAB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 22:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA2023ABA0;
	Mon, 30 Jun 2025 22:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="s1gtYdNu"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4006245033;
	Mon, 30 Jun 2025 22:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751321708; cv=none; b=NENQwDul17joCibzjRmSL4qxiUZn+yuiWtp87qxrNcbaRlSxOY9UeQBdr+bOxxtfqRbsMOrRlPRZYsu2ohr2Yr0H4ybkAbIR86UTrLjCK/l1s+bJjbLTt+x8lE2zIPwRkvTqDY11r7E7JpBKyrqsXsIt3AydSCqCs0uvgKTgsw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751321708; c=relaxed/simple;
	bh=77Wymn2VG+JYjQD1GOZ61eQIOBrfETnY+b1WhyvIXjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgiKOtj7EHnlWZLXugw9Aefc1m1tmHJbtlQ5r85pyJ8EdFgTbL5PRP/XQoJ+JKmozghCPk/SBLyNKQugMKxjNtHJSH2e+aOYAW3dPbpEGAdBIj+6bHIJL3YNsHHVn77QaqaItzBTfZaUrPe0WkODmXtYOhXbqHXbapMjGbWUn9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=s1gtYdNu; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 08307169;
	Tue,  1 Jul 2025 00:14:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1751321683;
	bh=77Wymn2VG+JYjQD1GOZ61eQIOBrfETnY+b1WhyvIXjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s1gtYdNuFztKgGzamObOrpiTMVFB/ouPA5TKGQ1Ov6QCJ3kPxJSPevFtKADk6TcAQ
	 IlKGEJDbgV5Tv2CLrxlRU4+DypjjoTVTt2ErBmitmZUwVTffYu1DrgbGtxK7vIkI4+
	 r48P/vDwzSnbxb0I6JR4J98WHV9lhCcv0hKfGp80=
Date: Tue, 1 Jul 2025 01:14:39 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>, Hans de Goede <hansg@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/8] media: uvcvideo: Do not enable camera during
 UVCIOC_CTRL_MAP*
Message-ID: <20250630221439.GB15184@pendragon.ideasonboard.com>
References: <20250630-uvc-grannular-invert-v3-0-abd5cb5c45b7@chromium.org>
 <20250630-uvc-grannular-invert-v3-6-abd5cb5c45b7@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630-uvc-grannular-invert-v3-6-abd5cb5c45b7@chromium.org>

Hi Ricardo,

Thank you for the patch.

On Mon, Jun 30, 2025 at 02:20:31PM +0000, Ricardo Ribalda wrote:
> The device does not need to be enabled to do this, it is merely an
> internal data operation.

How about the following code path ?

uvc_ioctl_xu_ctrl_map()
  uvc_ctrl_add_mapping()
    uvc_ctrl_init_xu_ctrl()
      uvc_ctrl_fill_xu_info()
        uvc_query_ctrl()

?

> Reviewed-by: Hans de Goede <hansg@kernel.org>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_v4l2.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index 7ab1bdcfb493fe9f47dbdc86da23cba98d7d10ff..350cd2cc88f872d2e8bd19e2b8fb067894916364 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -1178,10 +1178,6 @@ static long uvc_v4l2_compat_ioctl32(struct file *file,
>  	void __user *up = compat_ptr(arg);
>  	long ret;
>  
> -	ret = uvc_pm_get(handle->stream->dev);
> -	if (ret)
> -		return ret;
> -
>  	switch (cmd) {
>  	case UVCIOC_CTRL_MAP32:
>  		ret = uvc_v4l2_get_xu_mapping(&karg.xmap, up);
> @@ -1197,9 +1193,15 @@ static long uvc_v4l2_compat_ioctl32(struct file *file,
>  
>  	case UVCIOC_CTRL_QUERY32:
>  		ret = uvc_v4l2_get_xu_query(&karg.xqry, up);
> +		if (ret)
> +			break;
> +
> +		ret = uvc_pm_get(handle->stream->dev);
>  		if (ret)
>  			break;
>  		ret = uvc_xu_ctrl_query(handle->chain, &karg.xqry);
> +		uvc_pm_put(handle->stream->dev);
> +
>  		if (ret)
>  			break;
>  		ret = uvc_v4l2_put_xu_query(&karg.xqry, up);
> @@ -1212,8 +1214,6 @@ static long uvc_v4l2_compat_ioctl32(struct file *file,
>  		break;
>  	}
>  
> -	uvc_pm_put(handle->stream->dev);
> -
>  	return ret;
>  }
>  #endif
> @@ -1226,6 +1226,7 @@ static long uvc_v4l2_unlocked_ioctl(struct file *file,
>  
>  	/* The following IOCTLs do not need to turn on the camera. */
>  	switch (cmd) {
> +	case UVCIOC_CTRL_MAP:
>  	case VIDIOC_CREATE_BUFS:
>  	case VIDIOC_DQBUF:
>  	case VIDIOC_ENUM_FMT:

-- 
Regards,

Laurent Pinchart

