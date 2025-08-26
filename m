Return-Path: <linux-kernel+bounces-786610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 153F5B35F16
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 107A67B1AF3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A046322557;
	Tue, 26 Aug 2025 12:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="WERC/HQa"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D726721D3C0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 12:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756211121; cv=none; b=ZcNA8YOGC27JWsfz/Wm82OioBJNYdmco/eApWOO4yhGAzrfLerbR6QMIQgqoq9udg3IUXjLUD/2PMOse3EXw9IT9HTY8aOKi8Hiqzi3bujCRQX9bC2nMOEgWkG9ggEgqvONCyzHzwUGlNy4OdI3MYneQKRQ8c1PmpUa0zjN+LFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756211121; c=relaxed/simple;
	bh=PNMy+OZa+h0ka2tSa42Gsji14Y+mfKOHX6dXlusUKBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QF8IwxUJEei+k7ck7kZ+gE5FhoQq4Fkx3oqAgb9EjzswNjQYX9hD5tr0GuacSSGQXJjgOZEksrW/aBtIbrAqdW6C1fMaPZX+SDO4klA4YSdp7I/qsIxx2v39GRkbay+uYq5tVuxqULgODx0wdBGewaugosxjWKq6E/oSgSnKSQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=WERC/HQa; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b1098f9e9eso87377501cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 05:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1756211119; x=1756815919; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4hO3ALaftqFmH4oH4pH+kk6zISTsy/rbnhx2jQsr7Dw=;
        b=WERC/HQaMzgxeqmk83WLQbl/L8jDyfeOSiK7eN/Lo4NHiZrexkL1JPGVX2xaiajDSE
         pV9ZC44F1/QrzasdmN8GUJRhyR8fWZ5FOR5pa7mrpvzcIow8c/VQYDzWr2WsaBB2OS/k
         rvvtWXG8baSNd/UannI5omGFcOqZH2igZlJkJswegyZCm2O/IoL+LkFoBEpompHMVkS7
         wS1kMZ+lHalh8f5Q5dcv83/0vOlcr5lIfVPe6Ay/7Xg7xCiAux5oqykM+m0VCGVgBrOL
         t/gHE59PzDonfFrWqwP40V3eiGFOyyP96UcrMr6sbn4fESqW4lDYX+gRgPHS0HOkvI/j
         tLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756211119; x=1756815919;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4hO3ALaftqFmH4oH4pH+kk6zISTsy/rbnhx2jQsr7Dw=;
        b=CMRj9NVE4vgySdEgCVdyTh6FUuaIDcoS6/mCKyYQxQkGeLLMtaUUBBsbJRanKnpLP+
         C3py3ONL8dvWxxefeosrsLtZysdONpR62olI1SFw2tDMw4My2iV6NXcRAbDRDz0csGam
         TgNjpmKoBLFmg93zwETnoZJuHTkcoIbXD1y8CvGwvY6hXu5PTAd9yjO3OCoMlkm/P9G3
         FB2zK/Fs1SDKDGIe0EP+ug4hmyj1VwsaWEcetezIuJxaMtSwdVJJbg+heY1DGPbq4NYy
         qeRFSJLMX0hurUQdhsx7Nr7oc9NdqIWBKvdbYca+Q37T29kPlKfQHzrkVgARmWDfepsQ
         Bsgg==
X-Forwarded-Encrypted: i=1; AJvYcCXCjiVKrnG9J6vBMbeCRipxzMH3I1jd+6e8eqpgetPdDlFq9+R/e0wlmmq+kbD3Y3IWXxhIeObax1XnReY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFS6qcagYnWArtebLlCcO7FISz7dKtMnWCRUoZLubBiWGfbipL
	UOPWMjE29MzoZWOkAgJN7QI0oLAkynJsY2PyO6RSWbH2AR8AefXJXF2NYwbfL2hRqYQdD67VTDE
	G/SZMbR9ce3bQ25o2OVrIXaY9f1dw65IxAErIhgeF7g==
X-Gm-Gg: ASbGncuXIXiYou/c16y2AzupeYVVpHXYmvIzF936c8O9KYs+sDR2uLWv8yq62R4D3NK
	+Vg6QPjA+mgIOlZrKgRklePxsNT5N4u+sNE+IgkW6CtpJL6wENWpuspYrbek/tLRvzjw+41INCH
	kVl581akfgl78bzx++R2AYHGxSLsT6XHPCBQtkWEY0UnrAOI7zYxSWjrlidWjGcW2ppBH+1SqY7
	itJVMCAsT3WUPnB
X-Google-Smtp-Source: AGHT+IFgi8Q9hHqPvEtovjl/Iou25u0OhOejPE9XEDWvvY8QwIuVfSOpzRV+vwb4VBRl5Im89zG6tFcD4jX2gBQishU=
X-Received: by 2002:a05:620a:4149:b0:7e8:6a84:e82e with SMTP id
 af79cd13be357-7ea10fdbed6mr1861144585a.32.1756211118444; Tue, 26 Aug 2025
 05:25:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822-mtk-post-blend-color-pipeline-v1-0-a9446d4aca82@collabora.com>
 <20250822-mtk-post-blend-color-pipeline-v1-1-a9446d4aca82@collabora.com>
 <CAPj87rPAoD2D99zTdsvJ=9K8+G17mTS2jDYHMPYmXNtUyp2L_Q@mail.gmail.com> <CAFZQkGwotQ6cxVCSgp-BhUi5DaZ7MyVvbnrDJW11Z7ztzqy58g@mail.gmail.com>
In-Reply-To: <CAFZQkGwotQ6cxVCSgp-BhUi5DaZ7MyVvbnrDJW11Z7ztzqy58g@mail.gmail.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Tue, 26 Aug 2025 13:25:05 +0100
X-Gm-Features: Ac12FXxHW5zk0HB8cp7qpDLRzhJSLilNkY6mrjMA15E-TnryutF26kuEp3eSmiI
Message-ID: <CAPj87rMTOD3_tC70QX4xz3G4zdG=tmwt5VgPhq6jNyf8bbW49Q@mail.gmail.com>
Subject: Re: [PATCH RFC 1/5] drm: Support post-blend color pipeline API
To: Xaver Hugl <xaver.hugl@gmail.com>
Cc: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Alex Hung <alex.hung@amd.com>, 
	wayland-devel@lists.freedesktop.org, harry.wentland@amd.com, leo.liu@amd.com, 
	ville.syrjala@linux.intel.com, pekka.paalanen@collabora.com, 
	contact@emersion.fr, mwen@igalia.com, jadahl@redhat.com, 
	sebastian.wick@redhat.com, shashank.sharma@amd.com, agoins@nvidia.com, 
	joshua@froggi.es, mdaenzer@redhat.com, aleixpol@kde.org, 
	victoria@system76.com, uma.shankar@intel.com, quic_naseer@quicinc.com, 
	quic_cbraga@quicinc.com, quic_abhinavk@quicinc.com, marcan@marcan.st, 
	Liviu.Dudau@arm.com, sashamcintosh@google.com, 
	chaitanya.kumar.borah@intel.com, louis.chauvet@bootlin.com, mcanal@igalia.com, 
	kernel@collabora.com, daniels@collabora.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Simona Vetter <simona.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, 25 Aug 2025 at 19:45, Xaver Hugl <xaver.hugl@gmail.com> wrote:
> > > @@ -416,6 +417,24 @@ int drm_mode_object_get_properties(struct drm_mode_object *obj, bool atomic,
> > > +               if (post_blend_color_pipeline && obj->type == DRM_MODE_OBJECT_CRTC) {
> > > +                       struct drm_crtc *crtc = obj_to_crtc(obj);
> > > +                       struct drm_mode_config mode_config = crtc->dev->mode_config;
> > > +
> > > +                       if (prop == mode_config.gamma_lut_property ||
> > > +                           prop == mode_config.degamma_lut_property ||
> > > +                           prop == mode_config.gamma_lut_size_property ||
> > > +                           prop == mode_config.ctm_property)
> > > +                               continue;
> > > +               }
> > > +
> > > +               if (!post_blend_color_pipeline && obj->type == DRM_MODE_OBJECT_CRTC) {
> > > +                       struct drm_crtc *crtc = obj_to_crtc(obj);
> > > +
> > > +                       if (prop == crtc->color_pipeline_property)
> > > +                               continue;
> > > +               }
> >
> > Hmmm. One issue with this is that it makes things like drm_info
> > harder: if drm_info opted into the client cap, it would no longer be
> > able to see any GAMMA_LUT/etc programmed by the prior userspace. So I
> > think allowing at least read-only access would be reasonable here.
>
> FWIW the cap for per-plane pipelines also hides COLOR_RANGE and
> COLOR_ENCODING properties from the client.
>
> From a compositor POV, I slightly prefer hiding the properties
> entirely, but ignoring them on the compositor side when a color
> pipeline is available would also be trivial.

It makes it impossible to do smooth transitions from legacy clients,
as the old (current) properties can't be read back.

I assume the atomic state would also carry the old values (even if the
drivers are specified to have to ignore them), so there would be an
odd transition:
* pre-colorop userspace sets GAMMA_LUT to invert brightness
* colorop userspace takes over, does not set any colorops on the CRTC,
brightness is no longer inverted (presumably? depends on what the
default set of colorops is? and what the drivers do?), but the atomic
state still carries the old gamma_lut blob
* pre-colorop userspace takes over, does not touch GAMMA_LUT,
brightness is inverted as the colorop from the previous atomic state
is ignored and the pre-atomic one now takes precedence

This isn't necessarily wrong per se, but does seem kind of janky and
error-prone: like should the old state be reset to zero/bypass for
commits from colorop-aware clients? Or should we explicitly allow 0
but no other value?

Cheers,
Daniel

