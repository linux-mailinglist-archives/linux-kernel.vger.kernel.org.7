Return-Path: <linux-kernel+bounces-858472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8020DBEAE28
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B46E05883F3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE692E03E6;
	Fri, 17 Oct 2025 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eYM79maS"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79242DF3FD
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760719385; cv=none; b=KYwR0Nxqri/J7za3qdQEk3GdEbq3GUxzXUV4TsonmeIp7gb3+t5I0xP9q4RadTfUNc+oV7MeicT4khBFvDDjfU2syOBl2/YnhSLzTSGN/pNtjIHmFEEPGdT/c8bwpX3BPfhI5psCAoAqwsqs+ff4vbDN7UQdQhsD5L6+HloH6W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760719385; c=relaxed/simple;
	bh=Q3sAr5IgC4u/2uxZQzODES4J6Xqsz5aUfWZySpoCpzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZom+bhAjRMV61r7Z0Vddh7UHpsjAela1GJmGSl5RGsR+HNNtwRzQcAkN+vBykbpoTF62ECE2se2IMlLYcFeWH4v0/EyAzxNq3KrH1zVc/iRCAaN86RWdB6lF69n2UGnI7Djyy/ni7qAgvkDK2dRzPALpeHczPiE1KuYx3LXJI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eYM79maS; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-427091cd4fdso422804f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760719382; x=1761324182; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G6gCBpn1xaSdsDN3kuu/6RChT6cW/pr078XU7axphUc=;
        b=eYM79maSRCBjK3X69Aak89HAGLyGmO5tFGeRxbudnCUoqiHLn47/ZgoJJz/sxzByU0
         cyF3ahES36u7PjReT/xnXVNrlyhxv66bhAHl8U0TsV9hl1xz1DOQIrEiUVM69SzlWV5o
         psV0cIdUxSbBkXS9TLBTJdmUlGHq15XYzG2/9nzuCGeKaIcV7ZiaqkNWtOr9GzCwbhu0
         sEj5zJhEq+/StU6RrMIBVOUi8A0C8QkuZClbZN2cidG0+IAEJaof/N9bbIOekXmVJv0E
         oAe+E7AO8vKi+xu0+kP9/+mZAgpbFAzocnC8XLigY2apL7RwlZECy0L/Il6MsegCRPbQ
         gHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760719382; x=1761324182;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G6gCBpn1xaSdsDN3kuu/6RChT6cW/pr078XU7axphUc=;
        b=cgsn5RK9kHffQ5/qK3tqQYgHY5rbpT8EFSweZECiR9uLXQ+XoP2nn49edKTgKQy2td
         7b8HC+s0/eHiRk1vJ52e6Cmm04MN3uuQKUmkMPMSzUsSvoOl7YVttXR5o6jzqV3Slw/4
         FivBSr0zKiS2xDSlRgiskwJCTF3fZ9gzvfnBf1WAcE4AGO8oINYmTvq6m8375F5ckYbV
         b1oOXltDa8Lwq+90RA5+D4ndq5Oqc3iui0RB9fYsS0raUj2jvXl93DXqwUyjQIH+fiDN
         ptJvhsfBCbji87Xb/YUXqTIsK5Rgb2ESr3KpObHnaORZtkC9c/XsO8x1ez552GNRxhVV
         y1Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWrEibR5tlUTRwjg/OOQZ89cvYZcnzrQ9JG70a7lQMDVTPstflRnXwVPsP16LLXUHcCPT5/3YchnPUqbNs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu/ZBXjDwxr6OCNE+dCdi+A4rj5HN95ySaLr28BEPXE2ytMCji
	hiM8ry/kzTW7NRuZlIH/Qkxp0TpMzT+NahDCCtVtx3VQdnxEt4NX4xXyl7NVYY9RIBE=
X-Gm-Gg: ASbGncsCwIc8D8m5s50TaR+ehrlcgMAmrZRvhaD2zxCNoV1QatOJxb2a0G++VxZhDzn
	8/vJGZxhYD8RAMspczDXV98AcejxAXJQ/YNIaFC0h1JivlFHE6EL0tt5BlAiS7Bwfu9+pNlVmqO
	qQKSfV8VRelSeXWYEDkK+hz02oQS+/lvNcjbutIf5ePs9d0tLffEWfk+MpAst7xsyrujFtQEl+v
	K/VR6NrJNEHgmlBCsElcdpGDEgzq59DGUB5S1O6bOx38ucFclFVp59FvxNr2onppFeaORPux2vu
	VWGn4eZS9rg0+9XIPiK0o+S3Ak/oU2GWnDlRDehSbma2HUABc5drS+GKxkeKPgAB/we/eQcBHGL
	VovTX0D2Bw6TISMPFlIsN6p48RVMgZbCQz2y2FbnCvF2mEy+k5DPHB5RkyjRci589TpwWiAsLR3
	9EXpSbaCksVth2vErt
X-Google-Smtp-Source: AGHT+IGMBA0qJ4gxpjjM3xG9IuatY3oWeNvAk3ViyCHo+q3HrYjHTp52+8ZLn0SPVSWIlQ60ex3wqw==
X-Received: by 2002:a5d:5d08:0:b0:427:a34:648c with SMTP id ffacd0b85a97d-4270a34652cmr1088821f8f.58.1760719381734;
        Fri, 17 Oct 2025 09:43:01 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427f00ce06bsm76237f8f.45.2025.10.17.09.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:43:01 -0700 (PDT)
Date: Fri, 17 Oct 2025 19:42:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] drm/sysfb: Fix a NULL vs IS_ERR() bug
Message-ID: <aPJyEMWmWpWkcQvE@stanley.mountain>
References: <aPJo1W5Dl4rmGX_P@stanley.mountain>
 <aPJrs7_u8KcalNsC@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPJrs7_u8KcalNsC@intel.com>

On Fri, Oct 17, 2025 at 07:15:47PM +0300, Ville Syrjälä wrote:
> On Fri, Oct 17, 2025 at 07:03:33PM +0300, Dan Carpenter wrote:
> > The drm_atomic_get_crtc_state() function never returns NULL, it returns
> > error pointers.  Update the error checking to match.
> > 
> > Fixes: cb71de092553 ("drm/sysfb: Lookup blit function during atomic check")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  drivers/gpu/drm/sysfb/drm_sysfb_modeset.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
> > index 8517c490e815..d2c4d8f3d4d0 100644
> > --- a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
> > +++ b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
> > @@ -259,7 +259,7 @@ int drm_sysfb_plane_helper_begin_fb_access(struct drm_plane *plane,
> >  	ret = -EINVAL;
> >  
> >  	crtc_state = drm_atomic_get_crtc_state(plane_state->state, plane_state->crtc);
> 
> Looking at where this gets called, that should be
> drm_atomic_get_new_crtc_state(). Either that or the
> code is more seriously borked.
> 

I can't comment on that.  Let's drop this patch and instead (probably
I guess?) change it to drm_atomic_get_new_crtc_state().

regards,
dan carpenter


