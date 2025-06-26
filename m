Return-Path: <linux-kernel+bounces-705312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 005CDAEA818
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 22:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E193BD92B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 20:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D422F2345;
	Thu, 26 Jun 2025 20:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BGHz9LMK"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D3B2F002E
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 20:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750968705; cv=none; b=FFK0UjEgD8ioHHhUILj6jZfVqGE2e4104G3SV/PB3szqWI6RzIt6EKDB6Gt69WLtzvzEATPhsGyMzArLIrFYea7HJo2j0Uuhcq2umAEKZQoDjIy5WmFeXr6t9y8bLAYSwKp5EA9aweEmvA/FweknAbQ3/b5FvarNzZUo7oPakHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750968705; c=relaxed/simple;
	bh=dv8i+ER5+NkYyx9vElx2GjhZMNV7mUmAid3ueyB2dW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIve7Cdh4yNN+V3O7DGpTMdsu4BiTo8Cdv/yW8ufCLJHwMcaCQyB0WBcEDEGkn33IRM1A+dfBD3kb1idCbUvy2hP/6ECInEjNrz8dBHyQnjgD6gCO9KCJbHJ21Ls9enk0wKy2Ew6xWnuyu6LFDwOdZseujpSEKBblatBOKuwX/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BGHz9LMK; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2d09d495c6cso396476fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 13:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750968702; x=1751573502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DdbUq5FWdJghT4h/JjubAGfMLvpsjI7mA2zXcnSbP4g=;
        b=BGHz9LMKOPLo2ELl+fOlueBHux6f4tknWgj+LoUZK+I7cP0Ry4s89acI+BvdO/Iul3
         EBBKktkTl1jth2en0YOyEDHkDJQN8MbylNVrP+qCeM5AvKjE2RtdNhFQhpveoi5AdRHf
         Bru2inb4Xwy9mkBBjDYuso112fvMxp7Ulm74uxr8QE6TSx5beZBncf9zK0IZq0DKTtv8
         WuAjlB+C450bDWcIvMIiQRrbOEQmsfN2UZQARNtMyzQQY3UL2l2dTVxKsToD4t9c98BB
         FoxmCkoceKghnl7IZV+yy4OpH+u77HRIY9Yf2zcT5FBjEHrJ+GO7acmR1POBHsXv0O5T
         O9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750968702; x=1751573502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdbUq5FWdJghT4h/JjubAGfMLvpsjI7mA2zXcnSbP4g=;
        b=k2hgco7+/8AWCkYUGUfU2vsrkjuNi6y3qM6oeNr65qF6XXINRyWVoH8IyyIXEu1D3O
         svI6Fd/VGNgDw/5FB/5C7iUgbMMg6VjMCI/MKglymujC57/aQTIxeIdN2FBIF3YX9noq
         gO2548CbT0IDL9pTLqkbk/ZdyFhgCVy5pSMIaiz3ZEZzcOkJUAVh3vl1oP4Nlp8OyAlv
         hc4+z9VNJYXjWt0+NJt2XH/Y9cDzIzhNYzhtqSHdFHZ79TwCfeCy7d0/tYteyEH7ncFo
         k6E00ji7Lewi3M0esx2FUGjz7APkvazxhx6iOYroqWxAKOrAEeuN5FeEixOaYQmJeIN+
         FhRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgZk2q3lq73QCx3KA9OCdw18LhETXgw/xI8q/dgwmbcv+hkK3gJJNVVdZe/6KaGKGUfHhPaw4EB6rcgCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWEK8f/hg1HF6/U27ro/zr+M556UERqTfL8XYBdw5kDgz+Vvt9
	58hG/Oj3MWGZVEyQBNH1kInlb3I+0HSLXYGWQzanWk7FyBiunfmsNK70eS0PNxZUaCI=
X-Gm-Gg: ASbGnctZmnRlnLWH4JGfGVgpcx5be2Hyc9zpDSypn44MCb2LUHitFhfvRwjbPBfDZeO
	pJnCOK5yxg20hBazaXX5dx15ea1Si6rYL2ATX3X9J8uKpbIsc5Ns9SHeXYeMDdExtagTdAPEfP5
	9PThwfe7BU+fG7HEzgLpbH5UOvSZP706SLjcIZEAJMUaJvPAO6yauaTk3hsqVvpetpGvsD6e4Y7
	/K1x409xb0nq4Nc3upklnBhGW//LDRkoVm5q58opYhxy1ukkF7IoI6ikMmFqfW6QjDNV03LJ3Qe
	4o7tvS92euXuZjbrHR/41MDWjnuNLb7HGIsfWBo3rrWSvi4HuxULZlEI6blEPgAEycNo
X-Google-Smtp-Source: AGHT+IFg2nQff2Lhmdlw/pyysFVbUjX9x2OsHwDegwLfzTwSuU9M/XoGhqdFda6acuF09hZL3XGMBg==
X-Received: by 2002:a05:6870:6193:b0:2d4:c4d8:a4d0 with SMTP id 586e51a60fabf-2efed79348fmr230128fac.33.1750968702141;
        Thu, 26 Jun 2025 13:11:42 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:154:5a01:d5a1:16d6])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2efd50fa38asm513196fac.40.2025.06.26.13.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 13:11:41 -0700 (PDT)
Date: Thu, 26 Jun 2025 23:11:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Abdun Nihaal <abdun.nihaal@gmail.com>, andy@kernel.org,
	gregkh@linuxfoundation.org, lorenzo.stoakes@oracle.com,
	tzimmermann@suse.de, riyandhiman14@gmail.com, willy@infradead.org,
	notro@tronnes.org, thomas.petazzoni@free-electrons.com,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fix potential memory leak in
 fbtft_framebuffer_alloc()
Message-ID: <0327da98-8a7c-4db8-8bcd-4179b87a9486@suswa.mountain>
References: <20250626172412.18355-1-abdun.nihaal@gmail.com>
 <aF2Ic8BP0zWS6R19@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF2Ic8BP0zWS6R19@smile.fi.intel.com>

On Thu, Jun 26, 2025 at 08:50:43PM +0300, Andy Shevchenko wrote:
> On Thu, Jun 26, 2025 at 10:54:10PM +0530, Abdun Nihaal wrote:
> > In the error paths after fb_info structure is successfully allocated,
> > the memory allocated in fb_deferred_io_init() for info->pagerefs is not
> > freed. Fix that by adding the cleanup function on the error path.
> 
> Thanks for the report and the fix! My comments below.
> 
> ...
> 
> >  release_framebuf:
> > +	fb_deferred_io_cleanup(info);
> >  	framebuffer_release(info);
> 
> While the fix sounds good, there are still problems in the driver in this area:
> 
> 1) managed resources allocation is mixed up with plain allocations
> (as you discovery hints);
> 
> 2) the order in fbtft_framebuffer_release() is asymmetrical to what
> we have in fbtft_framebuffer_alloc().
> 
> I would recommend to study this code a bit more and provide the following
> patches as a result:
> 
> 1) fixing the order in fbtft_framebuffer_release();
> 
> 2) moving vmem allocation closer to when it's needed, i.e. just after
> successful allocation of the info; at the same time move txbuf allocation
> from managed to unmanaged (drop devm, add respective kfree() calls where
> it's required);
> 


Symetrical in this sense means that the cleanup in
fbtft_framebuffer_release() and in fbtft_framebuffer_alloc() are
similar:

	fb_deferred_io_cleanup();
	vfree();
 	framebuffer_release();

I feel like number 1 and 2 are sort of opposite approaches to making the
order symmetrical.  #1 is changing fbtft_framebuffer_release() and #2 is
changing fbtft_framebuffer_alloc().  #2 is the less awkward approach.

> 3) this patch.
> 
> All three should have the respective Fixes tags and hence may be backported.

Changing the order isn't a bug fix so it wouldn't get a Fixes tag.
I agree with Andy that the code isn't beautiful.  But I think it's
easier to just fix the bug, and do the cleanup later as an optional
patch 2/2.  I would also have been fine with a larger patch that does
the cleanup and the bug fix in one patch but I think other people
won't like that.

Diff below.  Except, oops, this doesn't compile.  Change the other
goto alloc_fail places to "return NULL;"  I guess that means you
get authorship credit if you fix that.

So if you want you could resend your patch and you could send these
changes I've suggested as a patch 2/2 and then I think everyone will
be happy.

regards,
dan carpenter

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index da9c64152a60..abfd7b1157df 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -568,11 +568,6 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 		height = display->height;
 	}
 
-	vmem_size = display->width * display->height * bpp / 8;
-	vmem = vzalloc(vmem_size);
-	if (!vmem)
-		goto alloc_fail;
-
 	fbdefio = devm_kzalloc(dev, sizeof(struct fb_deferred_io), GFP_KERNEL);
 	if (!fbdefio)
 		goto alloc_fail;
@@ -595,6 +590,11 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	if (!info)
 		goto alloc_fail;
 
+	vmem_size = display->width * display->height * bpp / 8;
+	vmem = vzalloc(vmem_size);
+	if (!vmem)
+		goto release_framebuf;
+
 	info->screen_buffer = vmem;
 	info->fbops = &fbtft_ops;
 	info->fbdefio = fbdefio;
@@ -652,7 +652,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	if (par->gamma.curves && gamma) {
 		if (fbtft_gamma_parse_str(par, par->gamma.curves, gamma,
 					  strlen(gamma)))
-			goto release_framebuf;
+			goto cleanup_deferred;
 	}
 
 	/* Transmit buffer */
@@ -669,7 +669,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	if (txbuflen > 0) {
 		txbuf = devm_kzalloc(par->info->device, txbuflen, GFP_KERNEL);
 		if (!txbuf)
-			goto release_framebuf;
+			goto cleanup_deferred;
 		par->txbuf.buf = txbuf;
 		par->txbuf.len = txbuflen;
 	}
@@ -691,12 +691,12 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 
 	return info;
 
+cleanup_deferred:
+	fb_deferred_io_cleanup(info);
+	vfree(info->screen_buffer);
 release_framebuf:
 	framebuffer_release(info);
 
-alloc_fail:
-	vfree(vmem);
-
 	return NULL;
 }
 EXPORT_SYMBOL(fbtft_framebuffer_alloc);


