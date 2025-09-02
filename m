Return-Path: <linux-kernel+bounces-797142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C52D7B40C5F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4994E189BF54
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4A3310654;
	Tue,  2 Sep 2025 17:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtVpFWGs"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC74342C9C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 17:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756835147; cv=none; b=mmsMRvfFhZLZva2JuWZCon7EU7usmcytDB8cgEeyqhlz71ExUN92b/vNz6lJvZAzst914N52wBh1sbyRkfFAaTc5X4hJtdKB0pHX3ErVRF7ZDMq9NIrrx9aDebAblqaUDnmtFkeWa7SlEp3VgL4Y1xRKEigUxnT97lZpmaz9Uj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756835147; c=relaxed/simple;
	bh=T1cNLnm6fzB7ytY14KThLj3IRp6/I0MEf6zLS1aqZ10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDHWimw80M4OS3hAXy2xfWzj3r1KhLX/DHnDEhUdMVGI2Ant9Hu02eArlpdXMrGUjsGqFxGgZNSOcrcymP9ajHLgrXmP7LEJTAoHYV4OFtWn9TH8jUlNrr3nZSaMaz94KVr2YV7y5itooPnfcrISelEUNoZaoZ8y03Ty5/2x01s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtVpFWGs; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-772481b2329so3190268b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 10:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756835145; x=1757439945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mLftuepl8Ai11mnJzzF3qo/kXusPLAacbdlidpMXOjM=;
        b=LtVpFWGsrYB2fIcHPStv0e35c8D4TMiuB4XrmFUyEd141qfSDjTuRJfUtlO/z4W3wb
         Q9EoMVOiuTn06EUGe9MxeQ9UwIa8NhXAyDPqEBLTVs1vhikAK1c0rR1Cs2y6jlhRPmco
         P6YPER93fsKfiC3fTAEt8Ni2xCadKxJJ/eCl19ExjoUFd8UiZE5oTsbpGJKDmA9wFQMc
         UUVIbUlw1SFzKeFy/3ZNoBhmP3H1yPrzPpSlprS26lFuDh09cS8ex/WXCbT4cDqap7jv
         xL5KeJ+WooSZfdPaY2AS1iXdlh0YGQ60eMKhTcPUJ27JOgoagvxtT/xq02RYnk0rWUK5
         KBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756835145; x=1757439945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLftuepl8Ai11mnJzzF3qo/kXusPLAacbdlidpMXOjM=;
        b=WTiH6G+7HkuSh5LHNEsegHBjaukIu2sEVBIVnpbTXvVH7Iuzuqn/flc9dIesRaylN0
         L5h5Gobm8ArFLqnCtPypzKWxP+dmSXmaB1ud38Q3SJwKJrc0XruCin6Y37V96UVXrxCh
         MDweThronlhBYM/i+FPihzkGuaM9FGaCQgN7f9Zxhf6xlqmIv5z3S/eRzgFAobdsUF/e
         edVlm10opQvn8AMdgSGBsxUSFBcT2zVWTm4XjzzBoxRE6hwmPOC8+tV/SqSvKW1BUgzU
         U6M1k41Q5P1+XSj4PDpy5x4NglMrAtN1Uo9gaTPauG+gClViWuBo+Cg1dc4hVv8bYttV
         JT3w==
X-Forwarded-Encrypted: i=1; AJvYcCVHkIQ0vyd4DvztKxrA3scS7OmZD9BB33uWLqx/dkA2gan9grGvpOlxJ+3fpjNekPnvjSRukhEfpxjKn1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx2udGWM6yv0WGkUdiaJLF0M91sVwUepQZuCqIOsGcfuJUTNp7
	NyNSGM6u1OYnzThV8ocQeOW/ySAO0N5aRsxz4eegbRRRkpQal6beoz0y
X-Gm-Gg: ASbGncsBStMSCn1gq4kvowlxI9vrCnOSnR214CcMt5aPLR+T41DvTGvn3q8ecF08Rlh
	ruy2y6LmFd3AtSRHYO1bqjjgtjI1IKVoUgXUtVIJE+iVfh/M4qZNLqdaLQdNF1BC1YwHEFldL/0
	lY7oJAZQ8A3EYh0k+haCB82hkgpE4Zqvs97CWWcRQ+nmX6byJ1Yg+U6wfRz8C7HpvqQEmxh26oh
	5bb3BJuyasgjIbowDY8wZFhsgvbh9A60ZmctnFvxyk+KBSMYwTaJj00ux/OjP4CF4bShLoN/Qq0
	8eRp8CgfkazTnXoSCL3Kpcn4BwCAUQiIzNzlLm0cKr7R4ToyrPfFget5+XnH810sBoEq1Gf9DGf
	MaSAE7varEx5J5x1mMQpAa8R9R5eveh6I4BbljgI=
X-Google-Smtp-Source: AGHT+IHraZscRDQf4h1fjj89O4jtpkvZmFKpvnnflKmKHVlG1h1oO0o54pzOpCTebqJtHo6A7gyQVw==
X-Received: by 2002:a05:6a20:258f:b0:240:1241:5f2c with SMTP id adf61e73a8af0-243d6dd13dfmr20064959637.10.1756835144876;
        Tue, 02 Sep 2025 10:45:44 -0700 (PDT)
Received: from Terra ([2001:df0:b240:6cbd:e842:2f6a:96d:9188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7724f079b88sm8154759b3a.40.2025.09.02.10.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 10:45:44 -0700 (PDT)
Date: Tue, 2 Sep 2025 23:15:39 +0530
From: Athul Raj Kollareth <krathul3152@gmail.com>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: tzimmermann@suse.de, skhan@linuxfoundation.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
	simona@ffwll.ch, mripard@kernel.org
Subject: Re: [PATCH v4 RESEND] drm: Replace the deprecated DRM_* logging
 macros in gem helper files
Message-ID: <aLctQ5pbI5vITf0S@Terra>
References: <aLcGnf_wrY5QuZZC@Terra>
 <6a5cc1e0-ea0a-4d7f-8834-20a371346d79@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a5cc1e0-ea0a-4d7f-8834-20a371346d79@intel.com>

On Tue, Sep 02, 2025 at 05:35:48PM +0200, Michal Wajdeczko wrote:
> 
> 
> On 9/2/2025 5:00 PM, Athul Raj Kollareth wrote:
> > Replace the DRM_* logging macros used in gem helper files with the
> > appropriate ones specified in /include/drm/drm_print.h.
> > 
> > Signed-off-by: Athul Raj Kollareth <krathul3152@gmail.com>
> > ---
> > Changes in v4:
> >     - Some codestyle corrections.
> >     - Remove OOM error logging in drm_gem_init().
> > 
> > Changes in v3:
> >     - Revert all changes to drm_gem_objects_lookup().
> >     - Use drm_device from minor.
> > 
> > Changes in v2:
> >     - Change drm_gem_objects_lookup() to take a drm_device* argument.
> >     - Make appropriate changes to all calls of drm_gem_objects_lookup().
> > ---
> >  drivers/gpu/drm/drm_gem.c            | 13 +++++++------
> >  drivers/gpu/drm/drm_gem_dma_helper.c |  2 +-
> >  2 files changed, 8 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> > index 4a89b6acb6af..dc3d6cfa692b 100644
> > --- a/drivers/gpu/drm/drm_gem.c
> > +++ b/drivers/gpu/drm/drm_gem.c
> > @@ -102,7 +102,6 @@ drm_gem_init(struct drm_device *dev)
> >  	vma_offset_manager = drmm_kzalloc(dev, sizeof(*vma_offset_manager),
> >  					  GFP_KERNEL);
> >  	if (!vma_offset_manager) {
> > -		DRM_ERROR("out of memory\n");
> >  		return -ENOMEM;
> >  	}
> 
> nit: you can now remove { }, didn't checkpatch.pl complain?
No, it did not.
> >  
> > @@ -783,9 +782,10 @@ static int objects_lookup(struct drm_file *filp, u32 *handle, int count,
> >  int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
> >  			   int count, struct drm_gem_object ***objs_out)
> >  {
> > -	int ret;
> > -	u32 *handles;
> > +	struct drm_device *dev = filp->minor->dev;
> >  	struct drm_gem_object **objs;
> > +	u32 *handles;
> > +	int ret;
> >  
> >  	if (!count)
> >  		return 0;
> > @@ -805,7 +805,7 @@ int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
> >  
> >  	if (copy_from_user(handles, bo_handles, count * sizeof(u32))) {
> >  		ret = -EFAULT;
> > -		DRM_DEBUG("Failed to copy in GEM handles\n");
> > +		drm_dbg_core(dev, "Failed to copy in GEM handles\n");
> >  		goto out;
> >  	}
> >  
> > @@ -853,12 +853,13 @@ EXPORT_SYMBOL(drm_gem_object_lookup);
> >  long drm_gem_dma_resv_wait(struct drm_file *filep, u32 handle,
> >  				    bool wait_all, unsigned long timeout)
> >  {
> > -	long ret;
> > +	struct drm_device *dev = filep->minor->dev;
> >  	struct drm_gem_object *obj;
> > +	long ret;
> >  
> >  	obj = drm_gem_object_lookup(filep, handle);
> >  	if (!obj) {
> > -		DRM_DEBUG("Failed to look up GEM BO %d\n", handle);
> > +		drm_dbg_core(dev, "Failed to look up GEM BO %d\n", handle);
> >  		return -EINVAL;
> >  	}
> >  
> > diff --git a/drivers/gpu/drm/drm_gem_dma_helper.c b/drivers/gpu/drm/drm_gem_dma_helper.c
> > index 4f0320df858f..a507cf517015 100644
> > --- a/drivers/gpu/drm/drm_gem_dma_helper.c
> > +++ b/drivers/gpu/drm/drm_gem_dma_helper.c
> > @@ -582,7 +582,7 @@ drm_gem_dma_prime_import_sg_table_vmap(struct drm_device *dev,
> >  
> >  	ret = dma_buf_vmap_unlocked(attach->dmabuf, &map);
> >  	if (ret) {
> > -		DRM_ERROR("Failed to vmap PRIME buffer\n");
> > +		drm_err(dev, "Failed to vmap PRIME buffer\n");
> >  		return ERR_PTR(ret);
> >  	}
> >  
> 
> otherwise LGTM, so with nit fixed:
> 
> 	Reviewed-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> 
> but you still need someone else to merge it
> 
Thank you, I will fix it and hopefully get someone to merge it.

Best regards,
Athul

