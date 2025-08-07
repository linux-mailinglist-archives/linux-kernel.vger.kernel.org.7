Return-Path: <linux-kernel+bounces-758936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBB2B1D5E2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 12:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F0903BF42B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 10:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6B622D780;
	Thu,  7 Aug 2025 10:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WPmGawis"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85F642AA5
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 10:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754562896; cv=none; b=SH43leOSgZh4L7WraXm7MzmfC8AqQ+kxTnjtRBzUAmRmXRZfmXjSZlWofchYySi4He6nw309L0D6TvfjxUr5XuNRErAiLqArzU35C5w6gyEq5CMiZeK2bp2VeQfx14mPYC9r5qlPJxsvUpsNWRBgQLjSUJlQqVv7ch7YFWMeCyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754562896; c=relaxed/simple;
	bh=gwjFiegsOP4xcnWbW0X5ifEkq0MsOmbvf2Z95Us2gCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aM4oUD29NFGO4pu8KOC5vm77MsmX8xrOMbT1iVFpxPk8nYnA7i2SKmCrejTi2pUXx1JrG7mHQFz+Wx/y5c91/iqJdi71UTOe9TwKR17yL/D5nto3BN/pbEedBtkypPx7qBT7tgdtBshjq1bZqHDp2nhfE4QaVJNCWwIZkUSFUlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WPmGawis; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b8de6f7556so459535f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 03:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754562893; x=1755167693; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+jqpfHFtr9RJd+Rj5jDYwLXh+hHq7pFdE9Sw57Atqmk=;
        b=WPmGawissfzMWa6qpPa0bLRvu60bfY5y3yjKLZbZK37l9uD9CjHmYksbnwU+CyLqt2
         a81zVXMddA+GEToFhLKfl1j67J4LB9btSXmOiSj/YujpZ9YsoFllpR/GRWbU9u6qDPDq
         620cs7FiBXtCzxabdSCn9QUpn3p/p7RdNt26MYA9naavJB5f27fs5vZjB8w1IS52C2IZ
         IwGYQI+0zgYrIJSjXQxETlX9g1HMzEvhIKaKgbiCg2WZ1MwUeFRSROnlR3NyJoe5DZyC
         N0b0j2Vs4/bhxZ72C/VACCFog2euKC9uHYbV5niZkbO04u+hmxjhG3JOCn4gfaxxfV/U
         lFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754562893; x=1755167693;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+jqpfHFtr9RJd+Rj5jDYwLXh+hHq7pFdE9Sw57Atqmk=;
        b=DtQTbuKCpMtJV/kOvPl0VD4KXZ9Jmw4ezkdKmWZbJ/FvLSunkS0MbUSHUg5bpE+fG6
         tP3UT+ab/m+6DAcnXzUnd1dJrroD7jzTGI9tSMLtWrErTDongNwXUDTR0f6nRyNkAMo0
         kp3UTKGkhJ3Gy0L376Y7L/AeH460WFNk/oxv2R5tP/CzAVO44gfnkwPHDcAo9ddNyrH6
         NyCqGuG1zhYQBLFli46MkxgwNUi7NOTaNsbTcd7LTyrPW4urufmkGWe8QkzEn1rVhdZe
         qnqjmzQ4Qi9ekoCff34sT5G/S+xxLCEKPBGII5+wthO6yW8nRMJk+10zCQHd+tI9TMvl
         JRNg==
X-Forwarded-Encrypted: i=1; AJvYcCWSzl4PwFY92xJJD6RFeJKD+40xqVR+uMGLf3UmC9oSy75ylwWhgmfyVVRu99CP/Q76lPlODUNqYDYfJAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm5j+5R5MzW/PuulupgrLcl/PFcGSz41gw8+fHENKJ2Pv1Cckx
	Z4i3q8q5e5VoIT9krxazcFsQZY5CfcAlngDUb1xws4o+3ZEhZmvcITWpRGIFdmtXVfw=
X-Gm-Gg: ASbGnctoDor7dbOsfqHzVmdSWSTmJzUFErjQ6sj/9XN2HdDp4zRnkr9nc5ePFBWfAY8
	gdAbVeoUv+/kOMHqMmytjZwhGqUR4RYgRon3XCHOp1m1XJHytF/8q/3api8CHE9XptxV9KiOmiM
	G79MbRfeujGU34ItsAhyadRDuSz70PB6OBVpsw6wSr8BgE6PkORmAOHU422Kdu5VC9f+YVfxjiK
	7uKNZmzJ1f0RQYtTtjohKRl5p9EaPYcaFN43/ldUC8w+VGLPxDkIAAlHVyV3s85tRT/MFCdTFJK
	MgqUeGBza0ycCkGXvTNYMvz+n9jAR7cOKxND55Ce+1qLQnIWmdy8NyvGAkM/OUZp1e4I1dx00/8
	9t6ZFm/cq/mL5j/10eCsuNHjHFoo=
X-Google-Smtp-Source: AGHT+IEJZFFSnC6OyV3Ckz3ldGk5h0RG3Okc+NeFrocarUAZUjxcjd1haqhnntbT67+wRuAV6TUqug==
X-Received: by 2002:a05:6000:2f86:b0:3a0:b84d:60cc with SMTP id ffacd0b85a97d-3b8f41a837fmr5055520f8f.2.1754562892893;
        Thu, 07 Aug 2025 03:34:52 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b8ff860acbsm70000f8f.51.2025.08.07.03.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 03:34:52 -0700 (PDT)
Date: Thu, 7 Aug 2025 13:34:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>, wens@csie.org,
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
	airlied@gmail.com, simona@ffwll.ch, jernej.skrabec@gmail.com,
	samuel@sholland.org, neil.armstrong@linaro.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: backend: Fix error pointers in
 sun4i_backend_atomic_check
Message-ID: <aJSBSLvIeSpvaYpK@stanley.mountain>
References: <20250314012029.668306-1-chenyuan0y@gmail.com>
 <20250314-prophetic-attentive-platypus-3ab214@houat>
 <CALGdzurT1_fY_o8Hv92j4+XFQHu1iHRzqVtZAM8upHYBPfA1BA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALGdzurT1_fY_o8Hv92j4+XFQHu1iHRzqVtZAM8upHYBPfA1BA@mail.gmail.com>

On Fri, Mar 14, 2025 at 11:00:26AM -0500, Chenyuan Yang wrote:
> HI Maxime.
> 
> Thanks so much for pointing that out!
> 
> How about such a patch?
> 

This patch is corrupted so we can't review it.

> diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c
> b/drivers/gpu/drm/sun4i/sun4i_backend.c
> index 2dded3b828df..5ad0e90d3e6b 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> @@ -490,9 +490,14 @@ static int sun4i_backend_atomic_check(struct
> sunxi_engine *engine,
>   drm_for_each_plane_mask(plane, drm, crtc_state->plane_mask) {
>   struct drm_plane_state *plane_state =
>   drm_atomic_get_plane_state(state, plane);
> - struct sun4i_layer_state *layer_state =
> - state_to_sun4i_layer_state(plane_state);
> - struct drm_framebuffer *fb = plane_state->fb;
> + struct sun4i_layer_state *layer_state = NULL;
> + struct drm_framebuffer *fb = NULL;

No need to initialize things like this.  NULL isn't a valid pointer.
This just disables static checker tools from finding uninitialized
variable warnings so all the expense of writing the checker tools is
now wasted.

regards,
dan carpenter

> +
> + if (IS_ERR(plane_state))
> + return PTR_ERR(plane_state);
> +
> + layer_state = state_to_sun4i_layer_state(plane_state);
> + fb = plane_state->fb;
> 
>   if (!sun4i_backend_plane_is_supported(plane_state,
>         &layer_state->uses_frontend))
> -- 
> 
> -Chenyuan
> 
> On Fri, Mar 14, 2025 at 2:17 AM Maxime Ripard <mripard@kernel.org> wrote:
> >
> > Hi,
> >
> > On Thu, Mar 13, 2025 at 08:20:29PM -0500, Chenyuan Yang wrote:
> > > The function sun4i_backend_atomic_check was dereferencing pointers
> > > returned by drm_atomic_get_plane_state without checking for errors. This
> > > could lead to undefined behavior if the function returns an error pointer.
> > >
> > > This commit adds checks using IS_ERR to ensure that plane_state is
> > > valid before dereferencing them.
> > >
> > > Similar to commit da29abe71e16
> > > ("drm/amd/display: Fix error pointers in amdgpu_dm_crtc_mem_type_changed").
> > >
> > > Fixes: 96180dde23b7 ("drm/sun4i: backend: Add a custom atomic_check for the frontend")
> > > Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> > > ---
> > >  drivers/gpu/drm/sun4i/sun4i_backend.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > > index 2dded3b828df..a8e0e2123764 100644
> > > --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> > > +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > > @@ -490,6 +490,10 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
> > >       drm_for_each_plane_mask(plane, drm, crtc_state->plane_mask) {
> > >               struct drm_plane_state *plane_state =
> > >                       drm_atomic_get_plane_state(state, plane);
> > > +
> > > +             if (IS_ERR(plane_state))
> > > +                     return PTR_ERR(plane_state);
> > > +
> >
> > This introduces a build warning. You shouldn't mix declarations and code.
> >
> > Maxime

