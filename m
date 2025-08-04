Return-Path: <linux-kernel+bounces-755330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE593B1A505
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1E518A24E2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B5226D4F6;
	Mon,  4 Aug 2025 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/lG78MI"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06C1238C08;
	Mon,  4 Aug 2025 14:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754318030; cv=none; b=bft6TS5GPq5kB3ochwfx9HkdVpheTXJKj0Y/0vxyZsKnZUgq2BYeBfPdaW9VfAwgkHu5LyJebEXArGyaFq+4Sbhss07b+0QIi3UrkAy6CEEfiN+w7ub8ewFREnGRcVOTHA6fC90vFMDwp8EDbm46R3PeVsDAQDNcSGInS4h/3B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754318030; c=relaxed/simple;
	bh=bx8QwYW9aKoPUoEVF4B53ZWCYLIgV8Aibpzv3lO0PPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gN04xAGL+Ki8HX8xvZYYyXnQsDVj0MgmC2Wx4kofrMmPKxkJjQFK60A+b73Eqb4dhivLisMAq48KfaDh3pGFzxSsAzGcW2saGkI3Nnz9aSxhE9zhrKDo1ZaU0y11vmQqAV6MkaQLj3zxgh1Yt0pGwhOQ0VaHaGXk2KO7cHuKRmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/lG78MI; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b3510c22173so501888a12.0;
        Mon, 04 Aug 2025 07:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754318028; x=1754922828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0T5bNkjOLwUXjeJPET1PATYeweG7dwzoZgOeClfm6o=;
        b=D/lG78MIDXZkAi4u5OHSAWir0eSbJViJHn/jPdFdtSWs7RekHrFA6vUrNmSkP6Hoh6
         vCBOybhLYJgPHNmpWLNwB+1BzOXmUfwmy95gyCm8rblm9u0/inequsD4vdsAQNtKVUMH
         7dUMqo7sVpjrIr86k0mHKZEpY8nyM7PK0M7jw4IBUEyZJEV6o9319zyxXNB00eLtvYwz
         +3NfYfXCvtODtbhHSDavcziHGhHsqVlLGicIkhEJqxjbDiQ9CD4um2o6t6fmgZDw+CTE
         hkINRAzxUkEk6h6rxGsei9GQ0YnB5wfWEaeX5pWdOHTfQdyXW77/q4WqSREakVaGBiF8
         rvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754318028; x=1754922828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0T5bNkjOLwUXjeJPET1PATYeweG7dwzoZgOeClfm6o=;
        b=IV9g8NyU69nvj+IttHxdgIPgCn+eNHUAuUVqOxAraoo1RNoos0+N59DFIN/1ofhrH2
         fNrvQ2tC9kyWunWPweRey7xiVIbLFUYqK+pvm3UhZ5f/T9EzXq8i9JnomO6q5GyOIiJN
         LCjKc1iRelNzMd8be/FhKZNCAh89EUU1kPsB6f0SylhLMvApocYSkzxY1znRTM7LCrEp
         EQfrAym8oHBhyqbAOWs7UnJhGYZgY/6LMQVwkHGpsNEEvpkRmhdQtTF3OoFs18L0v2/3
         gYXrO6uDZT62eG6+5c5wl4QajJeJL8vw1vgdg/ig2OnoteyfaDQwal34c/fdLxs7Kk4e
         sJUg==
X-Forwarded-Encrypted: i=1; AJvYcCUD2QKVZ8PKqQV2IrpnOSnvhuMTeFkSHMWvE000KUWXnt2l3+8USgrfPUtdC6R41K/MdXA7bq/KScqbhZCX@vger.kernel.org, AJvYcCVKVYP1AyqJtGHQxGiQbKAUb9mfPMskF/psP4NW5QAwM1BmotyYb+ttAaPI6NPQnpmm0D9CVlXusQuo4OtyAEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJtCnCkzWa6k70NPRB23EYhdysDPjoSGIPfSn9ZVAnwITk+ZGJ
	H0nWDdVHnM06EZ5qLH1nieA2jhVzUbpdHFV63iuMtbArKoFU4Od4+Vqrg7OlGnz/qzGD/XyVTJF
	NDIeKs0NkjiZ85lKDW0/P3u4zuATixeY=
X-Gm-Gg: ASbGncu1T9TeknA/hdlPhdoTvP9Vmeym6bvVvZHs4XuwB8TnXw7Z01vQXkxH/rLm70G
	5IM4ZrPEXq61YcJMRJYvPanhDXFUrTl4bWVfegzjsYB7P4xIP288YhsiMYrrUZTScpxr1QkylbN
	Z7QswtaL30CLPIUVzRLSlKTtpRqlnx4G4uODMBffED/TvRcrHW4QROTbXBqLZGEJjKwSC0q4aFq
	Q1rcNJ8jfh4v9ZAiQc=
X-Google-Smtp-Source: AGHT+IGLgrHrPD6FJJCxW/OQubfBA53Jif9CMWKpZX11VoglF2lNuXufKtAMRai10ALKftx1KRAW03kCD5zS0tZlsb8=
X-Received: by 2002:a17:90b:4b92:b0:31e:facd:ca30 with SMTP id
 98e67ed59e1d1-3211611c1b9mr5992708a91.0.1754318027882; Mon, 04 Aug 2025
 07:33:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801-uartlite-redundant-v1-1-6141b97a3c7f@ethancedwards.com>
In-Reply-To: <20250801-uartlite-redundant-v1-1-6141b97a3c7f@ethancedwards.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 10:33:36 -0400
X-Gm-Features: Ac12FXzRBElqGCC5tidrwbuqwnJHL33G6bP8oj-Ab2Z3a5A_mE7hHKx2MC4CCxQ
Message-ID: <CADnq5_OdnxRhX74svDrrK6OtrcJKywJPvZDo=J_VArALZVUdDw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx9.4.3: remove redundant repeated null checks
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 2, 2025 at 4:28=E2=80=AFAM Ethan Carter Edwards
<ethan@ethancedwards.com> wrote:
>
> The repeated checks on grbm_soft_reset are unnecessary. Remove them.
>

Same comment as the gfx10 patch.  These are necessary.

Alex

> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index 51babf5c78c86c20ef806e31e9d0a4185ffda5b8..8ba66d4dfe86e96073f63e259=
177ca0ca2416a6d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -2461,19 +2461,17 @@ static int gfx_v9_4_3_soft_reset(struct amdgpu_ip=
_block *ip_block)
>                 /* Disable MEC parsing/prefetching */
>                 gfx_v9_4_3_xcc_cp_compute_enable(adev, false, 0);
>
> -               if (grbm_soft_reset) {
> -                       tmp =3D RREG32_SOC15(GC, GET_INST(GC, 0), regGRBM=
_SOFT_RESET);
> -                       tmp |=3D grbm_soft_reset;
> -                       dev_info(adev->dev, "GRBM_SOFT_RESET=3D0x%08X\n",=
 tmp);
> -                       WREG32_SOC15(GC, GET_INST(GC, 0), regGRBM_SOFT_RE=
SET, tmp);
> -                       tmp =3D RREG32_SOC15(GC, GET_INST(GC, 0), regGRBM=
_SOFT_RESET);
> -
> -                       udelay(50);
> -
> -                       tmp &=3D ~grbm_soft_reset;
> -                       WREG32_SOC15(GC, GET_INST(GC, 0), regGRBM_SOFT_RE=
SET, tmp);
> -                       tmp =3D RREG32_SOC15(GC, GET_INST(GC, 0), regGRBM=
_SOFT_RESET);
> -               }
> +               tmp =3D RREG32_SOC15(GC, GET_INST(GC, 0), regGRBM_SOFT_RE=
SET);
> +               tmp |=3D grbm_soft_reset;
> +               dev_info(adev->dev, "GRBM_SOFT_RESET=3D0x%08X\n", tmp);
> +               WREG32_SOC15(GC, GET_INST(GC, 0), regGRBM_SOFT_RESET, tmp=
);
> +               tmp =3D RREG32_SOC15(GC, GET_INST(GC, 0), regGRBM_SOFT_RE=
SET);
> +
> +               udelay(50);
> +
> +               tmp &=3D ~grbm_soft_reset;
> +               WREG32_SOC15(GC, GET_INST(GC, 0), regGRBM_SOFT_RESET, tmp=
);
> +               tmp =3D RREG32_SOC15(GC, GET_INST(GC, 0), regGRBM_SOFT_RE=
SET);
>
>                 /* Wait a little for things to settle down */
>                 udelay(50);
>
> ---
> base-commit: b9ddaa95fd283bce7041550ddbbe7e764c477110
> change-id: 20250801-uartlite-redundant-c4cb6f87bb68
>
> Best regards,
> --
> Ethan Carter Edwards <ethan@ethancedwards.com>
>

