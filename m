Return-Path: <linux-kernel+bounces-820317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EABCDB7E474
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95EAA1C075A9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 09:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9425F30BBAD;
	Wed, 17 Sep 2025 09:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sctehk6i"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E92D3016F6
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758099979; cv=none; b=aaxY4oW3CaFyoutS716i7StDFrK4y1QMrIDhVIHpZzgP//QIlX4K1u3xd3tuuNrSf37vUcxbDIjOkyuRNm62LFL5nouyMiVn0R/LGVX2BsmidnO++VlrRw20O1NiPM8+JOPRrpbSotfnb8zD0iKr7YgxxADe5vaSzvdfl0FW5kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758099979; c=relaxed/simple;
	bh=GghLzT+gVWN+LXTG0ank6TakFsT4XsHIoin/jwYEIlE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jRUgUXbRNxcCQoAEgHvczIUvOwY9vXZEJc3Fs3apEQcsRx4ge/ZeIqr4lbeYfm0U8+6fRd31+bb9HCLaMJ0yXqN3YddGBNZEh27zkqTAYIeC2ewcUz3VzHMC1+/Q2tao+QzpB8mTyxk95yaH26djgmEKJ5H8mT9ibSGvU2COALo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sctehk6i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758099977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s42YcCZtqG5U4tPE6MzbcLPNCyA0Lf5G1D7xBLSScnU=;
	b=Sctehk6iKQB5nTqKkdXGlF9aKnCYXzvSdAy4lT0e/T4v5++kbngOzTAI5xD+rx0x7uI1Ey
	zWJRSTlOWVNXddlxlQAQX+jxey7BJ/mKt7XJRQso/LlLXeky7+UgGY0/kVobBmIRdP4LLV
	UrF0TgKP1RcWYLAL86WyBB5caxbKF0k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-9mlspapbPWuzphKUmZAKkw-1; Wed, 17 Sep 2025 05:06:15 -0400
X-MC-Unique: 9mlspapbPWuzphKUmZAKkw-1
X-Mimecast-MFC-AGG-ID: 9mlspapbPWuzphKUmZAKkw_1758099974
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45f2c41c819so22471775e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758099973; x=1758704773;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s42YcCZtqG5U4tPE6MzbcLPNCyA0Lf5G1D7xBLSScnU=;
        b=pgf7A7gMcSO/ocxOmgsFwQSYKzZcvQMYVz1klBDxEngA8gOniLP5KReKd04y+ufOkX
         WRwkDHrcqqTanC4zpWpeUc9PjRs0H+ymD4MSb7Yex+LlOH2aRhpD5icsEjEQOADshSJQ
         W8m/hRmowEzM0KVW98+t77El/7c/gQe5++nR3QpSneDkAlBLt7NiUrZ8tllz7OEdEQ0M
         aa1UxrSSbApmX81XXT6jlutGSNil0AVTpSBkEUK3wfVbAsR11R73Q1z5+hWXXPf0wrWg
         catEFWXVST2/cR5Oiarsx25C6ZftJp/vxFX5QJQt0vnCSwnU2JYQYuuGFFXdD/gVy3qS
         ZJjg==
X-Forwarded-Encrypted: i=1; AJvYcCXgBmNCL1Mo9KCZ/Cqw/fN3z6oAP2gTBvv4nEaGIqHKT7gW59rFHC+40b1mXabJjZn4MH5vn3omCm/jmTI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Ya7XLEmmtgSUT5OLHKmSlgOb8uVZOSxtui64OH5s4V3SQykz
	llGCpA3BL8lDODvTtjqw0jG76A5Vz3A8EI8M0/KXWTc6FcEbmX3ehqBTBWOMO1HP9/6pClsgEPT
	IIMvxFjWAbxk91i1/Gtg5uRaV6eaJd1DT3vfODvvOLNwKHt4/6DFSS6foAc0aTuildbH6r8fS5A
	==
X-Gm-Gg: ASbGnct7VnWYBUEXbWOS29I5jZb8jmEIi6gS5TMTv5HJXNenLSb1sUyiYFFRva4Jh+V
	LUto7+i6PAvmi2nEMtyYNGQuSBya88eIucBhQG1HhVyF6LvwqbTtEezmXoES6JyH1cugidlWbOe
	8rK1wqEZ/WDDrPpu/FQr3rnYJpkH3vnUrxwPgbgTpci2mb8AbEhCEaHP4s0owwaq6jGI4fwFhao
	3FCzOrd61pqcYFTCyB5gl4hHbbsxXJjlO2ix8XFvJ8QouMzv9SN/tghyobFFUEAGJgBVlmFXn+h
	1HgGiV668YLif2lCl5CgPAAsIRkdBCQwkT85CAg2DT12k8pqS7LEUliwGlW3bmzg5cq0Si2xP0R
	Gtq20BncmnQqPDYalnpYshQ==
X-Received: by 2002:a05:600c:46c6:b0:45f:31d8:4977 with SMTP id 5b1f17b1804b1-4620683f20bmr14654955e9.30.1758099973556;
        Wed, 17 Sep 2025 02:06:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcyoriy+uMOj9MXtJ6yzyrRmGbnqpV4ucQ0xz+kHdj29UO15ZM66mcByWkYZMl93uD4Cj9Gg==
X-Received: by 2002:a05:600c:46c6:b0:45f:31d8:4977 with SMTP id 5b1f17b1804b1-4620683f20bmr14654525e9.30.1758099973064;
        Wed, 17 Sep 2025 02:06:13 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-460942b6c3csm23049745e9.1.2025.09.17.02.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:06:12 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Iker Pedrosa <ikerpedrosam@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Iker
 Pedrosa <ikerpedrosam@gmail.com>
Subject: Re: [PATCH 1/5] drm/solomon: Move calls to drm_gem_fb_end_cpu*()
In-Reply-To: <20250912-improve-ssd130x-v1-1-bc9389ed299e@gmail.com>
References: <20250912-improve-ssd130x-v1-0-bc9389ed299e@gmail.com>
 <20250912-improve-ssd130x-v1-1-bc9389ed299e@gmail.com>
Date: Wed, 17 Sep 2025 11:06:11 +0200
Message-ID: <874it1phx8.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Iker Pedrosa <ikerpedrosam@gmail.com> writes:

Hello Iker,

Thanks for your patch.

> Calls to drm_gem_fb_end_cpu*() should be between the calls to
> drm_dev*(), and not hidden inside some other function. This way the
> critical section code is visible at a glance, keeping it short and
> improving maintainability.
>
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> ---
>  drivers/gpu/drm/solomon/ssd130x.c | 33 +++++++++++++++------------------
>  1 file changed, 15 insertions(+), 18 deletions(-)
>

[...]

> @@ -1232,6 +1214,9 @@ static void ssd130x_primary_plane_atomic_update(struct drm_plane *plane,
>  	if (!drm_dev_enter(drm, &idx))
>  		return;
>  
> +	if (drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE))
> +		return;
> +

In this error path you should call drm_dev_exit(). The convention in the
kernel usually is to have a goto label for this, e.g.:

       if (drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE))
              goto out_drm_dev_exit;

>  	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
>  	drm_atomic_for_each_plane_damage(&iter, &damage) {
>  		dst_clip = plane_state->dst;
> @@ -1245,6 +1230,8 @@ static void ssd130x_primary_plane_atomic_update(struct drm_plane *plane,
>  				     &shadow_plane_state->fmtcnv_state);
>  	}
>  
> +	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
> +

and then here before the call you could have the label.

out_drm_dev_exit:

>  	drm_dev_exit(idx);

Same comments for the other places where you are adding the
drm_gem_fb_end_cpu*() calls next to the drm_dev*() ones.

After the mentioned changes:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


