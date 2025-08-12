Return-Path: <linux-kernel+bounces-765299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89704B22E4F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2073AFA85
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECDF2F659D;
	Tue, 12 Aug 2025 16:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5yrHrWv"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0709B23D7CF
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755017186; cv=none; b=mdbnLD4bqCs9roEYEprHKYUiVksXdORqjMxmOhn4P+tzxIh1jx4y2Pjrkr4Ehe8e+0UtVRRua8RvQAPQ/fw3y9IzIEaU8UEkaX4z1Cb91/NBlPA5gFZbIbHKMFI3noINDbzNWWvW4L2atU3uGvB3xJ8Mz58xKduohzlrS2RFxdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755017186; c=relaxed/simple;
	bh=hCFfkaC8SwzixXhIiVA1nkh/lsHKzLt4HFxdjV+yKT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g6zgjeNbzvwEpPK2vOMS+u7wAJDPFBGopc9oCP9oH18SMmevNUhf3ka5GiFMOrJtuFfVaeakfPcB2P3ZZHxO7EJRtCDGLneWAo2OEKpFmCAF3YUALzJ5bM3cihDIm36nZWg+3qMgR7IQGlecx10hQsRJ1GaOwQwObun3z9Xg/6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5yrHrWv; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2400a0c3cf7so8385735ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755017184; x=1755621984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USPFLLOKabQENCa/2/HmAk7p8VGjHmr7nMXA6HKhXog=;
        b=a5yrHrWvByDa6i76xCkiBBiW6Rnc1ZEjNiQakkWE68CdC8OCLncchdeHY2owRcc5Vp
         0IXBAS4NXCJEmf1ra6xqC8ZAlAPG19kzQ/q9diWz0GHx8XU2UE6DOMigjSRlwGtTpjpX
         j6uOxMR2EMgCjsmAjSw1lKiPTXDseloIq8S7LDmPdy7PENRhXD2rRr79UaG+xcl0LFTT
         74Dusb5hoMtbz4YhZWUp5alac+wT1vTWnpj2TVFWAhE2G1KzU5/naGZvuVXml6GhvEcE
         aW3DaRjH4wl57iYoHAcAiCNB4hfuoU7Ug6ynvMfS1/oDfGUMNxEYYl7KfL3IMJzQUv8Z
         CEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755017184; x=1755621984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USPFLLOKabQENCa/2/HmAk7p8VGjHmr7nMXA6HKhXog=;
        b=qvuZ5cLngCoBPiwbWMppiRPt5at6zE+pwaRmrcINboPawxKgpqnIHM+53/qhnxypAs
         UBh/iVT4BaAvztHQKXGONr5MNt98EP+cCJVPK9LaE6MwjBXLe0OOMtGkijZI9tMfSSgj
         NEU5b0KJ4WCbXkKOdOZG8eSihyD2so0ObcuWCIR86d1NJEHSF5eV7vXWMwvzTHYvNhQc
         XgrWhPYjlec5ij0NhykG1wFaj8TLeIlbf1Wb4ASvzM7SegHIfPlwmY5rgbjacgNk/a9B
         9pv4ThCnZ9X4AzkB9xvWk08AjVrvNFENSCPtVLhmh7Z7koTIcdFjOJiuGSBpL6AmSary
         fWmg==
X-Forwarded-Encrypted: i=1; AJvYcCVspmXgfSpF01kkH2ZbHSWa2tucR+7ps1mLYryFZEMsbnV85sM/r1UNXGN6g9eTlXRpcDXx1AuaT4TCvkI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnsq9GtG3m+Lvdcw5+Ukfq+elO0EVemXcM32KGOOBGjl/03i+M
	VW6HkPsNow7BeDCh860L4eMOxPwdMG7nMVglxqQlmrhWvS0n3X7kuG0fii9VBcfiA825LuEoDVK
	EbJg7DPc+xlVcBwZO4vblNd3DdVsOYIk=
X-Gm-Gg: ASbGnctPwyYq+0vikYVG7NZJcIHi1XDgLS/u+KmS5AiHvCATrEtnuDwFAoy5S1VrQDr
	W8l6kcrpLq/xMGCQgWg00FJ2X5NYqTmNezCy7hg2R3CuFrirnb2JlpewlztC2Og9KC/c4Pt3xTh
	gpDiLVrBQV/IxT2dANVSnukGcUE1TZdBvCGzHHDhhax54DdCkV2cCWdVBejQwKCvamSpIF67d7r
	Js9h3pnOLw4XwMwAg==
X-Google-Smtp-Source: AGHT+IHF1kIGWY054cGjdVbveA50uwXOVq+jDM9Mm6EaLoFzcA0qIVghSloC2lGUEWAwHkw2f+pVgxP0txXalE+Im9c=
X-Received: by 2002:a17:902:c403:b0:240:3e5c:476b with SMTP id
 d9443c01a7336-24306922280mr13308645ad.3.1755017184153; Tue, 12 Aug 2025
 09:46:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812083208.53809-1-rongqianfeng@vivo.com>
In-Reply-To: <20250812083208.53809-1-rongqianfeng@vivo.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Aug 2025 12:46:11 -0400
X-Gm-Features: Ac12FXxlBngCDP3QV-1TzQwHhARxDaRo_kVC615Woiv2wEL4cZJCtOfmTG9U064
Message-ID: <CADnq5_OuicNuLOhOXhotQ1gKx4MfzRpByMk5bdFut-smCwvpEQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Use boolean context for pointer null checks
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Austin Zheng <austin.zheng@amd.com>, Jun Lei <jun.lei@amd.com>, 
	Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <siqueira@igalia.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Dillon Varone <dillon.varone@amd.com>, Alvin Lee <alvin.lee2@amd.com>, 
	Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Tue, Aug 12, 2025 at 4:38=E2=80=AFAM Qianfeng Rong <rongqianfeng@vivo.co=
m> wrote:
>
> Replace "out =3D=3D 0" with "!out" for pointer comparison to improve code
> readability and conform to coding style.
>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  .../amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_factory.c | 2 +-
>  .../amd/display/dc/dml2/dml21/src/dml2_dpmm/dml2_dpmm_factory.c | 2 +-
>  .../amd/display/dc/dml2/dml21/src/dml2_mcg/dml2_mcg_factory.c   | 2 +-
>  .../amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_factory.c   | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2=
_core_factory.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/d=
ml2_core_factory.c
> index 28394de02885..640087e862f8 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_f=
actory.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_f=
actory.c
> @@ -10,7 +10,7 @@ bool dml2_core_create(enum dml2_project_id project_id, =
struct dml2_core_instance
>  {
>         bool result =3D false;
>
> -       if (out =3D=3D 0)
> +       if (!out)
>                 return false;
>
>         memset(out, 0, sizeof(struct dml2_core_instance));
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_dpmm/dml2=
_dpmm_factory.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_dpmm/d=
ml2_dpmm_factory.c
> index 3861bc6c9621..dfd01440737d 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_dpmm/dml2_dpmm_f=
actory.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_dpmm/dml2_dpmm_f=
actory.c
> @@ -20,7 +20,7 @@ bool dml2_dpmm_create(enum dml2_project_id project_id, =
struct dml2_dpmm_instance
>  {
>         bool result =3D false;
>
> -       if (out =3D=3D 0)
> +       if (!out)
>                 return false;
>
>         memset(out, 0, sizeof(struct dml2_dpmm_instance));
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_mcg/dml2_=
mcg_factory.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_mcg/dml2=
_mcg_factory.c
> index cd3fbc0591d8..c60b8fe90819 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_mcg/dml2_mcg_fac=
tory.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_mcg/dml2_mcg_fac=
tory.c
> @@ -15,7 +15,7 @@ bool dml2_mcg_create(enum dml2_project_id project_id, s=
truct dml2_mcg_instance *
>  {
>         bool result =3D false;
>
> -       if (out =3D=3D 0)
> +       if (!out)
>                 return false;
>
>         memset(out, 0, sizeof(struct dml2_mcg_instance));
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_=
pmo_factory.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2=
_pmo_factory.c
> index 7ed0242a4b33..55d2464365d0 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_fac=
tory.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_fac=
tory.c
> @@ -26,7 +26,7 @@ bool dml2_pmo_create(enum dml2_project_id project_id, s=
truct dml2_pmo_instance *
>  {
>         bool result =3D false;
>
> -       if (out =3D=3D 0)
> +       if (!out)
>                 return false;
>
>         memset(out, 0, sizeof(struct dml2_pmo_instance));
> --
> 2.34.1
>

