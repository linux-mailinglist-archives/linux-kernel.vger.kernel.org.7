Return-Path: <linux-kernel+bounces-788195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E9DB3811C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEA967B5F96
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD3E2BE7D0;
	Wed, 27 Aug 2025 11:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="HNdXhQOe"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4281C283FD9
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756294382; cv=none; b=qNXJ6z/hQ7x1NALLnm4vQ7iQPAiL5EkqkYevq0HsoNKjkXZLLHDQH7kC9VWns9rfwo+lh4iVgHswWj4jnizZl7gTJNc271npnZq7ZKdMV3C8roSSZo5dwU3UmgDLIki7Rb0cxoQNVy3qgSk0JlmoK6BUR9Of5n933SXmv1U716U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756294382; c=relaxed/simple;
	bh=Z3y4v46ZF7X8g5ThZrHBlGjNn21i+MtQxtbp82F3kG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IOnscBz7cIrt6UjH8yyPQxfZq0G4Unlflqp7ckCA8rO8A3/qFZFOpCYxIcIkqxrFIgbyliE1xDwJlHxioo9nE2dru2WBVVnPLGcEJAJ2HRFeyu8m+pCYLUBKPoMulSWKHoF95Bw34Mrc6YnFmeGzYmWvL9GgCjzp5j7a+9pIyHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=HNdXhQOe; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7f84c17078fso26520985a.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 04:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1756294380; x=1756899180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3y4v46ZF7X8g5ThZrHBlGjNn21i+MtQxtbp82F3kG8=;
        b=HNdXhQOekTiVizzX+KROjuokstP4vQl+MZG8d8qJHVvYIi10UtnPr4IKq7CsWJ84o6
         8Guhkq2OB4UIsbjIdVsR6/5Ylt8GvIezX2jKWggNhnggI6LS8gpuSeI9FTjt9OdxKcm+
         FRFydhGF4JQMvFfYbMuPnzKW+yZhMaN/ezKRbTS7s3yIkce8ngrQEU4jSoB+SekconJ7
         Dj6GhOM9zLVpAbUb/F9KWscEbG6Tz6FGzx+9h9DRhFLzfWKsJOLglIkOBOZtvf9hyr1E
         qKyPvNw2mfa8ZBpz0/lqG/fX3jo9NRFL5wMOacEZ5ZpBFVSRK8F4MWB4u3jMFqO55zYX
         9KGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756294380; x=1756899180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3y4v46ZF7X8g5ThZrHBlGjNn21i+MtQxtbp82F3kG8=;
        b=WsuuGWG56Ggu2ZFAC2QCs1Zxsxja1GNDs/Re1o5p4DmusgaC8wYP9GJN/ZZuo86fif
         qgbOOCK/nrVx7FTtFFjRWeE0NY0EioxusUCaU+YdhsdWci3KItmqe+6d6XrwDLKzcDfq
         rkwJRqgl/rls0cCQQWL9xCc1PCQ3J1myTtGeuuL67Vb76jByFh7j8KjmS5DAnIW52kyi
         Id+Ftccp1+Ki6xw/1OV9hMH4hl4w2Bj+rh11TMEQTRMXYKFk0Df2P+BL66zKZBWBmPLm
         9jtzVvboifZHbtwsyuSppm7kBWq5uh9K2s2A5qBuwDPVAu0Qu5U8hzgwRKs0ZuE2UNSa
         /Wgg==
X-Forwarded-Encrypted: i=1; AJvYcCX75y1N53tChBOzYvD8mdcf1lSBLuKhOok/9cYMt/Aw2EwyEKyVkIcnlO3/rsgCSwnWCWkCCiabcJc/aIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZDqmrZwoPXKU3D6YfM+JopkO1/IF+VnHmBJL69Z/sutuBSRbR
	acBfuJrid9SqnL2LM10mFNxyUK8/wEuEZjQzzMFeR6EvQujDIgQFDe1wZ5A6JAHpO66obnpEtr5
	XCYAvhoD4wYKso/fVzehZgjIVsiIOfkHG41MlZTEcgA==
X-Gm-Gg: ASbGncur7lSE/BqNFOdN0jlH145JuYefkItqD1zfzuwFfrTQsqviyEBDg74eJ8A4fDn
	aGj7Tu/2OF4D1BBCJfAea0RC7x38H7s6Yg7hN7oh2hgWPxVtpL2x3sewgJ0KPLu1khPO2XsYzqC
	cn30WkSR/EEsI8X2CNC0tD0iYfPQnl4Zin/g1734jLWGvuGNKVFCozMixtqoeugbw7OJcrMOqb8
	6ClJqmDn6oTYmwr
X-Google-Smtp-Source: AGHT+IGmmuxWMn1RQng0MqU7LfWDmGXD9wRFwAweLJvIB7bsSHwPntqlQ+JKaDysNEyaOvC876Q504deR3IuVc5pgao=
X-Received: by 2002:a05:620a:2804:b0:7e8:1718:daf4 with SMTP id
 af79cd13be357-7ea10fc7a07mr2104471485a.16.1756294379779; Wed, 27 Aug 2025
 04:32:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822-mtk-post-blend-color-pipeline-v1-0-a9446d4aca82@collabora.com>
 <20250822-mtk-post-blend-color-pipeline-v1-1-a9446d4aca82@collabora.com> <DCD62EFHFCEB.XEOPUPKZQ5XW@redhat.com>
In-Reply-To: <DCD62EFHFCEB.XEOPUPKZQ5XW@redhat.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 27 Aug 2025 12:32:48 +0100
X-Gm-Features: Ac12FXz3D5zUTg3Df1XjwtCpaINdk3SCVFUs0YESiGpt04Vrw7Xa6CeoI-p4LK4
Message-ID: <CAPj87rMDvaj28+h9fHkH+bZYH43N-dS_XHu9eomDphjXmPqArA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/5] drm: Support post-blend color pipeline API
To: Sebastian Wick <sebastian.wick@redhat.com>
Cc: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Alex Hung <alex.hung@amd.com>, 
	wayland-devel@lists.freedesktop.org, harry.wentland@amd.com, leo.liu@amd.com, 
	ville.syrjala@linux.intel.com, pekka.paalanen@collabora.com, 
	contact@emersion.fr, mwen@igalia.com, jadahl@redhat.com, 
	shashank.sharma@amd.com, agoins@nvidia.com, joshua@froggi.es, 
	mdaenzer@redhat.com, aleixpol@kde.org, xaver.hugl@gmail.com, 
	victoria@system76.com, uma.shankar@intel.com, quic_naseer@quicinc.com, 
	quic_cbraga@quicinc.com, quic_abhinavk@quicinc.com, marcan@marcan.st, 
	Liviu.Dudau@arm.com, sashamcintosh@google.com, 
	chaitanya.kumar.borah@intel.com, louis.chauvet@bootlin.com, mcanal@igalia.com, 
	kernel@collabora.com, daniels@collabora.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Simona Vetter <simona.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey,

On Wed, 27 Aug 2025 at 12:17, Sebastian Wick <sebastian.wick@redhat.com> wr=
ote:
> On Fri Aug 22, 2025 at 8:36 PM CEST, N=C3=ADcolas F. R. A. Prado wrote:
> > Introduce support for a post-blend color pipeline API analogous to the
> > pre-blend color pipeline API. While the pre-blend color pipeline was
> > configured through a COLOR_PIPELINE property attached to a drm_plane,
> > the post-blend color pipeline is configured through a COLOR_PIPELINE
> > property on the drm_crtc.
> >
> > Since colorops can now be attached to either a drm_plane or a drm_crtc,
> > rework the helpers to account for both cases.
> >
> > Also introduce a new cap, DRM_CLIENT_CAP_POST_BLEND_COLOR_PIPELINE, to
> > enable support for post-blend color pipelines, and prevent the now
> > legacy GAMMA_LUT, DEGAMMA_LUT, GAMMA_LUT_SIZE and CTM properties from
> > being exposed.
>
> Please note that you'll also have to deprecate the semi-standard
> Broadcast RGB property. It serves two purposes at once: it changes the
> values between the color range (similar to COLOR_RANGE but at the other
> end) and informats the sink of the range as well.
>
> So the post blending color pipeline will need something like an inverse
> COLOR_RANGE op.
>
> We will also need a new connector property where user space can select
> the color range, which does not change the pixel values, and only
> exposes options that can be achieved (default sink behavior, full range
> infoframe, limited range infoframe).

As a note to others, the follow-up is on the 'pixel_encoding' property
thread here:
https://lore.kernel.org/all/DCD5VIFRKFB9.1KHIZI3ASID2I@redhat.com/

I think we should keep discussion of those properties there. :)

Also strongly related is the proposal to add range/encoding properties
to writeback connectors; analagous to the inbound properties:
https://lore.kernel.org/all/20250813170542.331206-1-robert.mader@collabora.=
com/

I've talked myself around into thinking that the writeback-connector
property is better than trying to use colorops to do the transform. On
the hardware I've seen, whilst the CRTC output pipeline does have
colour-transform properties, the final yard of the encoding (YUV/RGB,
full/limited range, primaries, etc) is in fact a per-connector
property, so I think it makes more sense there, as that allows
usecases like RGB display output whilst streaming to YUV writeback so
you can push it directly into an encoder without an intermediate
RGB->YUV conversion step. But again, I think conversation about that
would be better on that thread rather than here.

Thanks!

Cheers,
Daniel

