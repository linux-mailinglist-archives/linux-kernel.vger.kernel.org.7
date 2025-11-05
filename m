Return-Path: <linux-kernel+bounces-887100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BA492C37462
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 19:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 60F5834F4A5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 18:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8479274B42;
	Wed,  5 Nov 2025 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="iChMyb/f"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F5C26ED54;
	Wed,  5 Nov 2025 18:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762366926; cv=none; b=nvSlKl7b6eg9dffiVbJVyn7DFwy+AIkW6nJ11XUndyTjFG7d8zxtWVszKg799iRFXSVvYIozf0XaFdcWdVrSBgBDExgJomfz6Ej25AL1bQ7Q6bG+pErrM0xuGeTXIwIPzrTsFtwGEpJmi6zlImNjRYPrxBV6lADTj+TMUqIGBaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762366926; c=relaxed/simple;
	bh=rn6lpHyqVDDYjoTIgoDSgaML8D42aZry1x8K04rmuig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9/oryAg1ze6ZPXoUmL2H5aOtn90nK/sXGqpB0mYSAzJUcT7WJm1M8jtP5mNPRwFfehyMH1O3o3RhKfZ4gqMLflyhDHWxP0XHWvJzuxBKoaP63/HxXbvtbm+3lWUVub//piHYG1o3AtIPMPvO2fOLGOEiwf30p/7ekIY7YPPw6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=iChMyb/f; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (82-203-161-95.bb.dnainternet.fi [82.203.161.95])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 026A0664;
	Wed,  5 Nov 2025 19:20:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762366808;
	bh=rn6lpHyqVDDYjoTIgoDSgaML8D42aZry1x8K04rmuig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iChMyb/f0sa93v8E+Wol0iT8728tV55uRd6icHRLSqdFgKW1SOy2ARIEDA7fjlVg8
	 HnkIGixdFK++gk6DfKT1rzmXO/2t9UnBposK6fAg6xnd06ikdt471fRpROIHa7b3Dm
	 Qs87rWd1MaTt34+S6eedS8mNFrGbJgjCuGVu7hmk=
Date: Wed, 5 Nov 2025 20:21:59 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tarang Raval <tarang.raval@siliconsignals.io>
Cc: Dafna Hirschfeld <dafna@fastmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: rkisp1: Fix enum_framesizes accepting invalid
 pixel formats
Message-ID: <20251105182159.GE6046@pendragon.ideasonboard.com>
References: <20250829101425.95442-1-tarang.raval@siliconsignals.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250829101425.95442-1-tarang.raval@siliconsignals.io>

Hi Tarang,

Thank you for the patch.

On Fri, Aug 29, 2025 at 03:44:24PM +0530, Tarang Raval wrote:
> Reject unsupported pixel formats in rkisp1_enum_framesizes() to
> fix v4l2-compliance failure.
> 
> v4l2-compliance test failure:
> 
> fail: ../utils/v4l2-compliance/v4l2-test-formats.cpp(403): Accepted framesize for invalid format
> test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: FAIL
> 
> Tested on: Debix i.MX8MP Model A
> Kernel version: v6.17-rc3
> v4l2-compliance: 1.31.0-5387
> 
> Signed-off-by: Tarang Raval <tarang.raval@siliconsignals.io>

I've tested this with libcamera, so

Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> index 6dcefd144d5a..107937b77153 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> @@ -1383,6 +1383,9 @@ static int rkisp1_enum_framesizes(struct file *file, void *fh,
>  	};
>  	struct rkisp1_capture *cap = video_drvdata(file);
>  
> +	if (!rkisp1_find_fmt_cfg(cap, fsize->pixel_format))
> +		return -EINVAL;
> +
>  	if (fsize->index != 0)
>  		return -EINVAL;
>  

-- 
Regards,

Laurent Pinchart

