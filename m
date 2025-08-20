Return-Path: <linux-kernel+bounces-777978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE89B2E00F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946F14E7D62
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A645320CBA;
	Wed, 20 Aug 2025 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfGXm+eR"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600E8320CC9
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755701736; cv=none; b=k9MVnWnI16e7z5eVcSC3Tek7VEX6lgiLo0uSBM2L9Ikcr3Es2xsERZWRzs6U+gKiEfTd04dqfcq93ASdqAppY2GPypIzOW0In9Ab7FZgvsoacAbd0oX9KYLn1Efyg2GnT/u7pGYdSIXMBV9Y3fXWdlyC3lG0VvELZ2NuzYkyN/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755701736; c=relaxed/simple;
	bh=FqdPPHWyb5z7Q8PiNBhfYnPb8hAOhJOZpHcwbgKE7Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TulB7k5NpVNElzxKYmUmwfBL4ALe2fTqQB73FkSMYU9sI8SCFV+Yrj88r8SZSExilou7WcLlZwblJx7YxgoECbkVZDY7cwr+22jtlNW74+wtgJk1F45n3WXM3kSPvCYBus9dbFHYWhvSqn4MiTDCcBXlNSHaFDaMv972IuTmSJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfGXm+eR; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32326bd4f4dso981559a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 07:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755701734; x=1756306534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o0V2bDIBX6RG9O1tv9XNytM5AkMScDjTGK8YhSMkxjM=;
        b=JfGXm+eRmZZvWA+W2tpMyzIagKEUDNl4VekPvUEpdmiOfiUjZ+OJirl08EkQuJ9hqf
         uiYn0UHUBsl3D6FrRSGk+avtddTzr/nh9qCtxcgPMq+T0oh62I5tLaD+uJSB498qUP9C
         fr0X4W/4ZRbpeQIK94ZavK9jmOqsas6RPGoErq2fa0+ZN85vaLO5zmXi3SRYIxKI/kOf
         MBaeeP7YBNRUwMfTa4u2d9EYuV3qtOzh78i9LRfHD/FW5pPzqfTeWnzQGFDjmClHeuKI
         KAcPwx38ausesCONzqwyznV675J3S8/ngsLIlaEQoibmLK/L1rmlpuovqcpWXkgDUxNW
         2uoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755701734; x=1756306534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0V2bDIBX6RG9O1tv9XNytM5AkMScDjTGK8YhSMkxjM=;
        b=ke0+r334Jrk2BuQqZ+wY3nr4ZCUBhvpuSZ4OfUSkFKcrzzwX9ssGUKtLMwMlRCFGN3
         MB0zzfnmMLU1iZaXMYSq9HmtByMJZr5YLNKTII2jqzRfx5plLkmXpiIGtZ2RelpUnjbh
         7QQ2sVcP7uPOROuMPaUqM89NmC9dqEnFg75S6CHlUMmuh2sOC4OpaHc/kai6txTGSYUD
         GzI1EsbVXKXpiHanfIXx41Du/q1kzhg94x1UV4aVFOdDwtqJAFca3a+XYdtITYHq5hSc
         SEn+tMJjMh3kVpnHvRGaR8ElOrT6+T9xF0fgCgQK/XIZ9z+rwy4KAdBjR1NSG9htha6K
         OJUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjnTneN0j6qqc+Cq0z6Q0Gn3NWIpxP3LcQPv5OiF6x98UQzm9tKEEEFfRhTcimcKxEDIEEmshyMSiL1M0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwh+xKcbsMTcbp6nGnIevA71hlJBtr1BHvTeuUYVUczo9Xn4gt
	UDoukeFbLUcutGuKRbG05CPPqr19gRsn9F2TXcyxsrzgLVzqAJcTyUNp
X-Gm-Gg: ASbGncti/ecrq13YvDdXgaUTlP/LX6ZDy8W/jvf7prwPvt2h5/XW6DndE+VbOpQPCwr
	6YAGfDtwIwDU7ODkKR1C2FctVRRhbl7cYzWEfnpa1uCNY+gbNasPsXhD5/BiUqDjUzvZ3wuxrb0
	Lh1jGrtsnlT8EIbBvEEp+M9i5aZ5T6XhgtaYdMzxLy11LBwVDmg9kFiF/CVNP5MHBqsWaq0qeNV
	u+VV47kq2ZBqm8PG1NNWRNzI5Ex/EFtG4NyjQu+vIpTT5/Ztjy8xw1gBNXLyyvEZoBr3VKkZW5o
	aoP8d4bZP5+jScKeejXlpzBBMPHV/Yul7kit9nc8CyzeoWDACpU2wLxSFFkemdvR40Z5P1v8WCV
	YpdZhs/1dbRceFPzq7Q==
X-Google-Smtp-Source: AGHT+IGmg/Cdj77TohGjYD8IlyALQCYhp/tkC4enDj7ZH8cBGpX8QTjsNTkyqiMmliHyuGe6n21pIw==
X-Received: by 2002:a17:90b:1810:b0:31f:252:e765 with SMTP id 98e67ed59e1d1-324e1086f4bmr4174755a91.6.1755701734365;
        Wed, 20 Aug 2025 07:55:34 -0700 (PDT)
Received: from Terra ([2001:df0:b240:b5e:abe3:8cfd:3fd8:5d8e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e8f20c7dbsm2403650b3a.68.2025.08.20.07.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 07:55:33 -0700 (PDT)
Date: Wed, 20 Aug 2025 20:25:27 +0530
From: Athul Raj Kollareth <krathul3152@gmail.com>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: tzimmermann@suse.de, airlied@gmail.com, dri-devel@lists.freedesktop.org,
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	simona@ffwll.ch, skhan@linuxfoundation.org, krathul3152@gmail.com
Subject: Re: [PATCH v3] drm: Replace the deprecated DRM_* logging macros in
 gem helper files
Message-ID: <aKXh31C9LGZBgu7Y@Terra>
References: <90f79bba-bee6-47ea-9881-9ae37eae42e0@intel.com>
 <20250819121517.46998-2-krathul3152@gmail.com>
 <a5d58430-1ae7-4b7e-8275-dad09a5c8cae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5d58430-1ae7-4b7e-8275-dad09a5c8cae@intel.com>

On Tue, Aug 19, 2025 at 10:14:30PM +0200, Michal Wajdeczko wrote:
> 
> 
> On 8/19/2025 2:11 PM, Athul Raj Kollareth wrote:
> > Replace the DRM_* logging macros used in gem helper files with the appropriate
> > ones specified in /include/drm/drm_print.h.
> > 
> > Signed-off-by: Athul Raj Kollareth <krathul3152@gmail.com>
> > ---
> > Changes in v3:
> >     - Revert all changes to drm_gem_objects_lookup()
> >     - Use drm_device as suggested in [1]. 
> > Changes in v2:
> >     - Change drm_gem_objects_lookup() to take a drm_device* argument.
> >     - Make appropriate changes to all calls of drm_gem_objects_lookup().
> > 
> > [1]
> > https://lore.kernel.org/dri-devel/90f79bba-bee6-47ea-9881-9ae37eae42e0@intel.com
> > ---
> >  drivers/gpu/drm/drm_gem.c            | 10 +++++++---
> >  drivers/gpu/drm/drm_gem_dma_helper.c |  2 +-
> >  2 files changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> > index 4a89b6acb6af..fbea8c50f17c 100644
> > --- a/drivers/gpu/drm/drm_gem.c
> > +++ b/drivers/gpu/drm/drm_gem.c
> > @@ -102,7 +102,7 @@ drm_gem_init(struct drm_device *dev)
> >  	vma_offset_manager = drmm_kzalloc(dev, sizeof(*vma_offset_manager),
> >  					  GFP_KERNEL);
> >  	if (!vma_offset_manager) {
> > -		DRM_ERROR("out of memory\n");
> > +		drm_err(dev, "out of memory\n");
> 
> IIRC we shouldn't additionally report OOM errors as there will be
> already lot of messages when we hit this
>

Okay, then I will remove it.

> >  		return -ENOMEM;
> >  	}
> >  
> > @@ -787,6 +787,8 @@ int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
> >  	u32 *handles;
> >  	struct drm_gem_object **objs;
> >  
> 
> remove extra line and please run checkpatch.pl as it should catch that
> 
> also consider declaring variables in reverse-xmas-tree order
> 

Got it, thanks, I'll keep that in mind.

Best regards,
Athul

> > +	struct drm_device *dev = filp->minor->dev;
> > +
> >  	if (!count)
> >  		return 0;
> >  
> > @@ -805,7 +807,7 @@ int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
> >  
> >  	if (copy_from_user(handles, bo_handles, count * sizeof(u32))) {
> >  		ret = -EFAULT;
> > -		DRM_DEBUG("Failed to copy in GEM handles\n");
> > +		drm_dbg_core(dev, "Failed to copy in GEM handles\n");
> >  		goto out;
> >  	}
> >  
> > @@ -856,9 +858,11 @@ long drm_gem_dma_resv_wait(struct drm_file *filep, u32 handle,
> >  	long ret;
> >  	struct drm_gem_object *obj;
> >  
> 
> ditto
> 
> > +	struct drm_device *dev = filep->minor->dev;
> > +
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

