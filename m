Return-Path: <linux-kernel+bounces-798852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E16B423E7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208DB5E17B7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CD32135D7;
	Wed,  3 Sep 2025 14:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bd6FiEQT"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE1F20B1F5
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 14:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756910479; cv=none; b=Z9HqePKLYcvdA++cj3B1QIT0w8cyqJExscU5uzxyzni/yUCXBTtKs9KV4HX/BU/zy851Em0ARTwTt5/J66bAuhxUFzzOP5fStKhppl+6vKUKoOkFtxZXQ70Tm4t0KL7SrcUAe7NdD9OBZGSP9YkbA8+LapSVBubL1eYrK6GuW54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756910479; c=relaxed/simple;
	bh=K3mFIWLIsG39oROp1dwXayOIKtKJ1h8fGBFQHAP7fgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cRJUEBUtBSmh6ZPZePuj5PrFeeBP0PqmHW6emGZlblbp02R4hU/yCbjQesD/zwTcXLTT57S12cK3Rsb/P3cX2ne5rVWu5x8Y9079g3REHN10W7WRxihdv9BCmrG6njblESDqf3r7oED3hcKYketMCMYzo7se3lZO6VhysVNpuWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bd6FiEQT; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5332a040f08so92483137.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 07:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756910474; x=1757515274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyiEoT+mfYk4CeGhzX31QR1RtE0qWzCxT6Ooec2Q79Q=;
        b=bd6FiEQTNDoCpvRqpnEsN//FjbLwszYAuiwVdGRKU0CSHyREtGgNRay1blkSU34dzT
         TrJSN8DLTG0EA1Cpq87ve+Wx+bO4tfK4lO1RDNRlf5iJ3y7OfBWexTQ9npdcVvJ2pX0j
         6MfMpm+56R7+nBssjvnZDfO6lQ9DMktuVvEBW/Ch7K88auLHTZrKV1HReVuvwg39l4fN
         ZJwC9+TReM1NN9Udky6wEh/RFbtceYsEGee2TaJnevU9eYHgApRmyHQDddQj+v7hcI+I
         m7vgZDPGJtm/DQWFBcLj7g+oWC5h88B72FyvCzugYYYVMcokSt/LuojCTx41UdwiYUvc
         75Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756910474; x=1757515274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yyiEoT+mfYk4CeGhzX31QR1RtE0qWzCxT6Ooec2Q79Q=;
        b=GdIIa97paN9gI4+yCSnjjWfO3m2TmehSvV66QHn0uAcDevNJEexh0c7hONZC5cdOm4
         XC+0vYEfooFykc7QZELdXEKV2afzRMiEl9t72v51g395ghbQuzJd677pJkoItaO4iQqR
         ZnggMsUF4DUox9qNjlllhl3iIMiVEfEbSuAEjlBxij9sNJsq0v0T9CBNh/SYRwpxUrD+
         xnO6jd2uy9qdMUvP1S/kuGafK4gG0TWnvy/moxyje4YqhjBjIy3BAOhjKL+eDISaUVAS
         g+dSM0u5EBIprbZZQg8gGWWppwfTaUI8d28SDK55NONeA3pBE8tMEf/zyoboFBYqe2OI
         fKUw==
X-Forwarded-Encrypted: i=1; AJvYcCU6ke5Km0put8vCjNPTFbqbMUcSykN66i/7PKJ66HgPh3rcqP+Sco8Q4JfNOPcqtxvmf/9J++nrnEpj4Fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyodfPGFWwHr9F09YylNs/rogOn7df8yqK16JN7VjwBzyr6udil
	2secgCRdBlFP21kNIm6JIn/7E31irYFTCExygRp761WpBUBb0Z6sXFhvjG7DN6OFMn/9SGQLFn8
	gpmSFmtH6axy5BYGUPh/LnC8l5xUCBu/EXw==
X-Gm-Gg: ASbGncseQISTsNsvdwM4olv1tHATzUABRJyQ3C4OcvBcOkCpHNjkfltEsanwPbdALDO
	7nk/IcSpPAMdaszl+XtUGkyTHxenkdCPNsVU+9tdqKyYnOxjsrK/hjidYnuByOggfn4FttECcLM
	qk8DgclVvR8yLUrv+x4WU1QvnxFAYmGafSSsMhaymTKRfFCaU19ehRxlP8JJlhUX1sdUVyZTPMk
	vs8rK/WOe/1XoExLg==
X-Google-Smtp-Source: AGHT+IEyh3Y9AxDCa/xdhhqWf1YCQxLzXKwd3gIYOmCkWoy3vTgqsxiRKeS/SpQwqq1y1LWALKzKaX246XyCeC9BWrI=
X-Received: by 2002:a05:6102:4b8c:b0:525:53c5:e42c with SMTP id
 ada2fe7eead31-52a333c0215mr2108906137.3.1756910474393; Wed, 03 Sep 2025
 07:41:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903122110.389182-1-rongqianfeng@vivo.com>
In-Reply-To: <20250903122110.389182-1-rongqianfeng@vivo.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Sep 2025 10:41:01 -0400
X-Gm-Features: Ac12FXzy5Ri8tZm5mbQlpKXXZ-zKYmYlUUy60tQ2sW2evL2L32EL0ptBMza3kj4
Message-ID: <CADnq5_MtZryr=DEuC7o2bKfEsyRi35=Tnw6ZaaoG84bvKRx5Ag@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon/ci_dpm: Use int type to store negative error codes
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Wed, Sep 3, 2025 at 8:59=E2=80=AFAM Qianfeng Rong <rongqianfeng@vivo.com=
> wrote:
>
> Change the 'ret' variable in ci_populate_all_graphic_levels()
> and ci_populate_all_memory_levels() from u32 to int, as it needs to store
> either negative error codes or zero returned by other functions.
>
> Storing the negative error codes in unsigned type, doesn't cause an issue
> at runtime but can be confusing.  Additionally, assigning negative error
> codes to unsigned type may trigger a GCC warning when the -Wsign-conversi=
on
> flag is enabled.
>
> No effect on runtime.
>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  drivers/gpu/drm/radeon/ci_dpm.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_=
dpm.c
> index 7c3a960f486a..1f9f4424055a 100644
> --- a/drivers/gpu/drm/radeon/ci_dpm.c
> +++ b/drivers/gpu/drm/radeon/ci_dpm.c
> @@ -3238,7 +3238,8 @@ static int ci_populate_all_graphic_levels(struct ra=
deon_device *rdev)
>         u32 level_array_size =3D sizeof(SMU7_Discrete_GraphicsLevel) *
>                 SMU7_MAX_LEVELS_GRAPHICS;
>         SMU7_Discrete_GraphicsLevel *levels =3D pi->smc_state_table.Graph=
icsLevel;
> -       u32 i, ret;
> +       int ret;
> +       u32 i;
>
>         memset(levels, 0, level_array_size);
>
> @@ -3285,7 +3286,8 @@ static int ci_populate_all_memory_levels(struct rad=
eon_device *rdev)
>         u32 level_array_size =3D sizeof(SMU7_Discrete_MemoryLevel) *
>                 SMU7_MAX_LEVELS_MEMORY;
>         SMU7_Discrete_MemoryLevel *levels =3D pi->smc_state_table.MemoryL=
evel;
> -       u32 i, ret;
> +       int ret;
> +       u32 i;
>
>         memset(levels, 0, level_array_size);
>
> --
> 2.34.1
>

