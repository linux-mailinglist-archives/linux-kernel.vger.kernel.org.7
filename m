Return-Path: <linux-kernel+bounces-816945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A45F6B57B10
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ABF5442F9D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D0130217A;
	Mon, 15 Sep 2025 12:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="K5YpGm5o"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3657A2F28FD
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757939520; cv=none; b=HyhGJyD0nk6N0J+SahwJA8j7GqnXX/WjrWO/AtmHFwLO6UCW3WLPjfDwve5wa4chU/nN3leVpFdlf7sRiwLoiV01mlFmCwKefJIHq80NuQmem+BE6veoNLcuj51PS7L3Jb+ksApyvkHn2tLzI2mAlU+1IejAjfAu8127o36L7nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757939520; c=relaxed/simple;
	bh=gjNWAmF/9tNc5Q0fXY5Fk1DQ0mbjaLCfSOt0RX8RU6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OlF1OFnc3ulY8PZ2kr4tNyCKIOeLihi+2bawq02KtRPmkybedmQuPY/hls/b9FvFS9l9KQefcMwBzaQ4eTF8KZbpcmMyjwNDXN6vMurUWIT1lbI1W4wkz+WTdEs4Uf3lsreBnuxvK32vKT7Y7oAn9lwD/sNoH520BPk/LtWJgnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=K5YpGm5o; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-32e3726e2bbso1261633a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 05:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1757939518; x=1758544318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knTNCoPdWg2pHCztUfEQ8k7yWdqtvYzIJewGisE0oL4=;
        b=K5YpGm5o0JMby6NmNfgXQseYOy0aIbY8g9lmThoFzdPhSTyKUjx9POg9yWZcJMUIRn
         Leb90YKt8fsCi5JeFOkBlpYlYM0Hi8Kq+vxhLPxdSLCVlaN5545PDiKUVnbkU1xl+kmj
         dZdPT+FrqBZ9Jm2O1lbmOmiCRLrlwRAPpaMf51Gf+VJq/9xQ1fetWIcUuyX4iEMHTAV1
         QpOw0O7Q+j6IgvXCF/aI63PGg619oHPs5P3zkhZXl33WfMH/d4XhsPQ2+JVwrLjW+UOX
         4CYsoazzdk7Qjc2YTiC/l8OkHvxal7kEJvrjgini1UIp/Mfvzai986mLEFdVUF5t3v7V
         Ud9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757939518; x=1758544318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knTNCoPdWg2pHCztUfEQ8k7yWdqtvYzIJewGisE0oL4=;
        b=pozLt37DpwUB2uawt4evfB0qQTyLB91LmxF6tIneuOpD3uxAOaJKOp4ROpQEq+EPGE
         j5/AyENdnXxMIGUE4P+sGFdIOe0e2B9G1S9Y27vDQQ32dWEDV7FigRpASZD6Psbe7qzs
         sEZVcKJGCPE1D5DDPltxBJNO/IR3O1apBHoQxlRCP+4Dthbs+67mtPz44hqAeVKvhShi
         RAb7JeiL8xBhxcaG3HNJBXNmSQt+PI+vrQQbJ7HR2uCmYzUw969W6eDJB+gYtIh0gkzS
         17SfRuUpJSkMo8LPkRQg+y6ZJmBsxMGXRBx+OvSz1dUhRurbGTnP0p5GlTDUZNTS7j9a
         OnQw==
X-Forwarded-Encrypted: i=1; AJvYcCUFGFqgIeGCcfLegld7m2rF2LwFt62SNqneDsc3f+h8pnkHxcTDYVZkxUSh2+rY0E7BDKQAagtzzAx0qr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt/rpe3bHhy6iLLdbTi6XFaTYhoba8eudHZUeffBRnOjCvSexP
	WK93kaOme364gJNq0CDCnii7cJ9HkKdfQdOThzTcNgHxKBr2hpO6sap3U03sdz5E4WfcsfSy7qP
	M3eZIOCtChgRXZposcq/1E2c4vVzzaldG4wKE1Sn+KQ==
X-Gm-Gg: ASbGnct5xxWCra0DkBkxM0XXDgUoPafY1xblGYvG7fBTzo9cSo6sVOphxytfIO13fg7
	bC8GtN5tgTSK6pXv/xvjS1xBbOd8t0vWiQ2FRBJQIRoh/oFPMguL6CA+C7qRA7/FhMN0OQC3aFZ
	A/j7O1HYAETtLBtNF7YXBrg7QABnd2kbInpSUQ+hbyePtOhdg2uWgIH2YypavSiTbEryeGvGIcF
	m1pKM9dj9l7nrOq12TEwM4AtY429H7FCJxH133/vKErzt6QbKs/
X-Google-Smtp-Source: AGHT+IH/frGLEtZ7ZHZnQY/5z33pxs75DFZAWxPCVhbB4mB21NkvYviO2w4jUhkbFFY8+vXiW0ByKtS6YODahX8cUnM=
X-Received: by 2002:a17:90b:4c4d:b0:32e:32e4:9785 with SMTP id
 98e67ed59e1d1-32e32e49ff9mr6355901a91.6.1757939518184; Mon, 15 Sep 2025
 05:31:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822-mtk-post-blend-color-pipeline-v1-0-a9446d4aca82@collabora.com>
 <20250822-mtk-post-blend-color-pipeline-v1-1-a9446d4aca82@collabora.com>
 <CAPj87rPAoD2D99zTdsvJ=9K8+G17mTS2jDYHMPYmXNtUyp2L_Q@mail.gmail.com>
 <CAFZQkGwotQ6cxVCSgp-BhUi5DaZ7MyVvbnrDJW11Z7ztzqy58g@mail.gmail.com>
 <CAPj87rMTOD3_tC70QX4xz3G4zdG=tmwt5VgPhq6jNyf8bbW49Q@mail.gmail.com> <269ca85a59f613568543f45867fba7e604cc9f11.camel@collabora.com>
In-Reply-To: <269ca85a59f613568543f45867fba7e604cc9f11.camel@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Mon, 15 Sep 2025 13:31:45 +0100
X-Gm-Features: Ac12FXx-lR_XqhTnyAEupBeFxl6WMTjW6Kcjw5_GSL4qiK2IHfeaMNkbyUCiheY
Message-ID: <CAPj87rMhsFy+uzKmNecrQG4e+BEoeX1FyEobO7bnHdQqhy1_2Q@mail.gmail.com>
Subject: Re: [PATCH RFC 1/5] drm: Support post-blend color pipeline API
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Xaver Hugl <xaver.hugl@gmail.com>, 
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
Content-Transfer-Encoding: quoted-printable

Hi N=C3=ADcolas,

On Wed, 3 Sept 2025 at 19:43, N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
> On Tue, 2025-08-26 at 13:25 +0100, Daniel Stone wrote:
> Based on this discussion, this is my understanding for the changes
> desired on the series and their reasonings:
>
> 1. Add a driver cap, DRM_CAP_POST_BLEND_COLOR_PIPELINE, which drivers
> will use to signal they support post-blend color pipelines.
>   - Reason: Allow userspace to figure out that the driver doesn't
> support post-blend color pipelines and choose to not set the client
> cap, DRM_CLIENT_CAP_POST_BLEND_COLOR_PIPELINE, so it can use legacy
> color management instead.
> 2. Make it so setting the client cap,
> DRM_CLIENT_CAP_POST_BLEND_COLOR_PIPELINE, fails if the driver cap,
> DRM_CAP_POST_BLEND_COLOR_PIPELINE, isn't set
>   - Reason: Prevent userspace from making color management unusable if
> the driver doesn't support post-blend color pipelines, as the legacy
> color-management properties (GAMMA_LUT, DEGAMMA_LUT, CTM) would be
> unwriteable with the client cap set.

Definitely.

> 3. Make legacy color-management properties (GAMMA_LUT, DEGAMMA_LUT,
> CTM) read-only if the client cap,
> DRM_CLIENT_CAP_POST_BLEND_COLOR_PIPELINE, is set
>   - Reason: Allow drm_info to print legacy color management
> configuration while still enabling post-blend color pipelines through
> the client cap. Also to allow smooth handover from pre-colorop
> userspace client to colorop-ready userspace client, as the latter can
> now replicate the legacy color configuration through the colorops.

I think yes, but I don't really feel strongly about this. If others
involved have stronger opinions, I'm happy to yield.

> Side note: Smooth handover back to pre-colorop userspace after tweaking
> the colorops to something else would not be possible without making the
> legacy properties writable too, so that the client could update them to
> match the colorops setting before switching back. I don't imagine this
> would be a common use case, and colorops are a superset of the legacy
> properties so there are cases where it wouldn't even be possible to
> replicate the colorop setting on the legacy properties, but thought I'd
> mention this limitation for completeness' sake.

That's a totally acceptable tradeoff. We don't have a standard
inter-client capability handshake, so if downgrading from a
newer/more-capable to an older/less-capable client is a bit janky,
that's OK. There's only so much we can do given the original design
decision for the KMS core to not be opinionated about a 'golden state'
that could be used as a reference for userspace to work from as a
base.

> Also, as Xaver noted, this feedback also applies to pre-blend pipelines
> and its legacy color-management properties (COLOR_ENCODING,
> COLOR_RANGE), so the same changes would be desirable there for the same
> reasons. So we should share this feedback on that series as well.

Yep.

Cheers,
Daniel

