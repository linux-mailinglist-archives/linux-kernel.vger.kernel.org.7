Return-Path: <linux-kernel+bounces-785434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FFAB34A95
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F57D1A8837E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A941CAA7B;
	Mon, 25 Aug 2025 18:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JE+9KjQW"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF91E21ABDB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 18:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756147542; cv=none; b=I2iwfpKk8Z3648ckSXaBeat+YTlNyB3ElLLgA9Wt0WhJsHmRRAWCDUCc4HQIvZKovdhwYNyyrSQ0UqkzhmTegzQ+GJ/gJGPmOF07UwAqCNU+uyHCvFinfuM5CrAudVuxZx/ZdUxCjLp8pf4AoV5g1V2g09viVj1BaH30vStqanI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756147542; c=relaxed/simple;
	bh=ISuuJyeIRfRMZgoFww4dIR2jZEbUMHvARIsYpsK/hm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZadLrWQgItKkU2RnuQb55adnmbew5eT8Qur6VwiMwmk+Irjqhl1fAuR98ZxfZNpH/A4pOMXLFkB7BB/0uJcHPDotVxuRo/sePU+WasWieU6W1QC6P9wqcNQoPPc/KedPKISIGxdqrnZWyZgjG1t7zA0/eA+KbIzgSse/zVwCJjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JE+9KjQW; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61c51f57224so2277939a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 11:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756147539; x=1756752339; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2zMojxEaqSXvN7rZ89UIzDP+AqmDlozbvrUX8uFGJo=;
        b=JE+9KjQWBDxJ5YREB3KtgVI6ph3Aa2wzhhREv8lBEemnJsqImWuDQw5rhCWFll53hx
         8jwfqorBfSybEM+gSPqYDB+VBzvZkcQxy0gw5LI+mrRhy7tbUXTR1emRbZDKn4r0CNQG
         ONckS3k+oo+Wrlk5MBRM9KADpm9lhl+0ppQqODS7vdWBhJswx3VuyKy9u5/RzwPp9nIU
         hVxb3/k6E4SeR3kSFJ7tbfHm/64z9a3rHe+NoTOzlh3SyPqRshpSi1D3y1Qe5kZKLf8a
         h3xEnxPjtRNYbpiKUb3PWUnp5qOQvnMR775bNVD7b9+phBeAxAaH1gRtiOeyGlPM8/Eb
         JR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756147539; x=1756752339;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q2zMojxEaqSXvN7rZ89UIzDP+AqmDlozbvrUX8uFGJo=;
        b=Vfxr0+Ox19oHuRHVjlPlIhtnphaoqsx/++tp/IZnag/OeGwSkZ/+IPpqnVi4NfvBP3
         aQCgmQY/MgjfY3VA97rm9G7U7ciy9PyVChUabQ06i26q2qusH7nV6CiuJ4c5P2bhKuEd
         nfWEm6PQLRa7zCMK9dHSzLlr3vpCZpdv+0P+IvKM6nTROpbgTGOl9OYtejCZBDodrlfD
         Est4I5LPiLcbiVT+xcA7VAkJz7QjZ34I6Q4n1gxjlbBMqYr2mrMW7FmkdlKzwhQBKSUd
         qCzOjl+rGUOYJm5WsqnNvEoP4ESTzqSgENie2/nrYG9jeIqa8aTCuk1ZYj5UmqA2rMbY
         qDhw==
X-Forwarded-Encrypted: i=1; AJvYcCXxy0XQ2auOcdkVIMCup7x3x5v0vaYD8IS4Hz6Z47ArmyT8tRk2PjjmS1c5w3Hnd8m4yKIXJD1jr4t5KqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMuDf5pJTbvjYttMLEdUW2kfCz6nuAuivLCQ6lRbbl7hQDf7B/
	iq+tYETEU9M38xx8WUYfPsLsRpFz86Q8reUQgTACk/mwuJukyCn7yO0ksgthMaWDm2NsnzLQH7N
	w6hRcokLmoTp6Q/CeMfWRQWwBhj0w4NM=
X-Gm-Gg: ASbGncsiZ9NwYPg86JBouQD5tAPkxq998tbgiK8rHn4keWC7rW7GDzlE/sNSWYosq/Y
	rLHuvTVE94x30gmE+sS57SIzfYOlm7YRS95YyAeeQ/2tY0KBRx2nBgO3SImxDS9CPeVTTo77FHH
	Hbfvd5wpErjDYHIyGr0+FwK2LNwREscofJiUYXZjcJKhylW1wgRSYkWCDBMND+mk5vYsxCu0O9S
	xKIoxw2TPeyCmTvUP2i1HLk9NOuWmCD9/I/RDkW
X-Google-Smtp-Source: AGHT+IHSoLDTkq5deXOI5kOXvOEJGs7/045c3SFr+zmXA7JcB8nnmgDCdO7Qbzl8FAm2rty6nUd0qaQ2gfQlRQ8Uk8I=
X-Received: by 2002:a17:907:d10:b0:af9:1be8:c2aa with SMTP id
 a640c23a62f3a-afe295e56d1mr1138094366b.45.1756147538797; Mon, 25 Aug 2025
 11:45:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822-mtk-post-blend-color-pipeline-v1-0-a9446d4aca82@collabora.com>
 <20250822-mtk-post-blend-color-pipeline-v1-1-a9446d4aca82@collabora.com> <CAPj87rPAoD2D99zTdsvJ=9K8+G17mTS2jDYHMPYmXNtUyp2L_Q@mail.gmail.com>
In-Reply-To: <CAPj87rPAoD2D99zTdsvJ=9K8+G17mTS2jDYHMPYmXNtUyp2L_Q@mail.gmail.com>
From: Xaver Hugl <xaver.hugl@gmail.com>
Date: Mon, 25 Aug 2025 20:45:27 +0200
X-Gm-Features: Ac12FXwIBvZYaDx3nXuRC59YLfGWHPRaFpCScdKvQ4nArJPhSi57cSubMBYyjfo
Message-ID: <CAFZQkGwotQ6cxVCSgp-BhUi5DaZ7MyVvbnrDJW11Z7ztzqy58g@mail.gmail.com>
Subject: Re: [PATCH RFC 1/5] drm: Support post-blend color pipeline API
To: Daniel Stone <daniel@fooishbar.org>
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

> > @@ -416,6 +417,24 @@ int drm_mode_object_get_properties(struct drm_mode_object *obj, bool atomic,
> >                                 continue;
> >                 }
> >
> > +               if (post_blend_color_pipeline && obj->type == DRM_MODE_OBJECT_CRTC) {
> > +                       struct drm_crtc *crtc = obj_to_crtc(obj);
> > +                       struct drm_mode_config mode_config = crtc->dev->mode_config;
> > +
> > +                       if (prop == mode_config.gamma_lut_property ||
> > +                           prop == mode_config.degamma_lut_property ||
> > +                           prop == mode_config.gamma_lut_size_property ||
> > +                           prop == mode_config.ctm_property)
> > +                               continue;
> > +               }
> > +
> > +               if (!post_blend_color_pipeline && obj->type == DRM_MODE_OBJECT_CRTC) {
> > +                       struct drm_crtc *crtc = obj_to_crtc(obj);
> > +
> > +                       if (prop == crtc->color_pipeline_property)
> > +                               continue;
> > +               }
>
> Hmmm. One issue with this is that it makes things like drm_info
> harder: if drm_info opted into the client cap, it would no longer be
> able to see any GAMMA_LUT/etc programmed by the prior userspace. So I
> think allowing at least read-only access would be reasonable here.
FWIW the cap for per-plane pipelines also hides COLOR_RANGE and
COLOR_ENCODING properties from the client.

From a compositor POV, I slightly prefer hiding the properties
entirely, but ignoring them on the compositor side when a color
pipeline is available would also be trivial.

> Having a client cap without a driver cap also puts userspace in a
> difficult position. If the driver doesn't support post-blend colorops,
> then enabling the client cap strictly removes support without a
> replacement. And without a driver cap, the client doesn't have a way
> to know which is better.
>
> Cheers,
> Daniel

