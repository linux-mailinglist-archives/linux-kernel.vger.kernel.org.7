Return-Path: <linux-kernel+bounces-755333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F032B1A50F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EEBBF4E1899
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062D127467A;
	Mon,  4 Aug 2025 14:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zo+MYhK0"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DF8271450;
	Mon,  4 Aug 2025 14:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754318047; cv=none; b=pGnuV60TMGTEY3PWm7sqD6sfz8bx5+Bq9rgRDU9EqQ7lJHCMwemwrhgMAWWs40/a/TfTchQmWXS4R/oRubT2c27jvcXOZNDfL5DhjVye9Sgx0JbM4rS0SWMmUf2xrtudqziqt1nk0wyDjo4YurN0XxyoEwyAIjEcpbltk6IOMEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754318047; c=relaxed/simple;
	bh=QZTKp0AdmNxOZCCBvKATKlV+WF+E2k4VVUMWfpw3TsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X16OuxLlVuoSM9XdsqqFaTnRruwgkEXDWc6Xm/cNuGGaNzxWOFnhtDk1HOXYnEgily1FbqvAmlkR6rwZ3lYHL48UXo2K5CwQkbQbMaL6cZtMGemynJmLprtcVsZrkqqESudgDlayERDitgSklwBkOvSJaEcbitvdgr88jeQDcQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zo+MYhK0; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32127d5f63eso154931a91.0;
        Mon, 04 Aug 2025 07:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754318045; x=1754922845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ThPz4EG6ZmgX+GG9SQyYVrMb+M6NgBy3ZDuWSe5fSmc=;
        b=Zo+MYhK0Xny74u38HgDnumoCaefnQ+MQSZc8o1md+X21cUqOzb+c9tOKfspRGBN/7I
         70hFFhAHOyBvzq3shFnVytO0OsOII79ld42k4qAJX1pSh+aWA6/oJj8zDEEhCql4LKGq
         hYsk+PURlAFaeIFzhpNdnrb3FHNcR7QBtO21QHPa1DysaG4bnFGiqH30e6WnN0QJRRlZ
         w/Yz9Fub6J6eukCd0qELU93qZ3JArz2ZYUKlBLuLuptRgmg34lpd7eTI7cxhnzuuRRXl
         paUS9mAcKuEgwYZOvVO6RWwpXk9M0NXwiLzQe72PDEDMT/hbVh3BeupY2DPqNaPfdfwK
         PY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754318045; x=1754922845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThPz4EG6ZmgX+GG9SQyYVrMb+M6NgBy3ZDuWSe5fSmc=;
        b=ZKG5m+vUsiRlmt0GbUMEju1b/2A5gMTRy8/N0ocUKwHvqYJTpk4VGh44AqdNRxaNad
         uDr9cQ0qPGgSaFYXTx7wL4yaXWhhCe6OVAXyZjE2KiaO2LCFFjkKvvaWTC4Iy+bao+ub
         0DfMHJsVlNSTBqf9tKz8oX3GBrn9SFKc4ZE2iZqEWzEwPx83Ab6RdA8mKhhDfQ69MEx6
         1AGcMEOx61lSd/pjp3RSrmmLgY6vROpLnWbu7917LAEJgK5EXMCNsrJoVKfFt28DY/QS
         JgErIYJb32U2jBXE4LpJz/fp1PBKqI3jD7/ifN4RCCVMvkSMI24z9ou/5DB0FNLqhQxl
         U1VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwYl3Aznrc7i4LrDGdDCzhStpAWgE+6W9cZOVfovnmPTC8EHebvplK1tCzgaSmp70TfsPZi9BHLSI753CL@vger.kernel.org, AJvYcCXndGSVYarNpqkv98TUra8uwb9lGpE5/lPxITeREOeCLFa/kCYExtIVmEDsPFi58QG+PCSWOXeMrvmCqhfCIjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzYcIz55oNskPA+jOtHPRMmnguJ0fDP2DpUA5gPbMmJ0dIssvk
	xdlE3I531Y628jaM1M2DGyaDp2Orn+N4CMVv0zqoV8jKwhR/8HOZzlo9vxki13HckgLK3EUktOu
	BnRSjdVfCApWDfIfk7EXPe+Zk9u0KLYI=
X-Gm-Gg: ASbGncsLQdMmuS5S20KIKmhXlS8Dz50DuLY/oijmrVBtTYEx1kyDkcbe8ez7M3VNgHG
	dzJSX6NzzL3PJYvyrokeF9C5zGZLziTzSr2QkZ6sCdfKxWBbWbzMsgG9DFFM1HTtf69J2cBStw5
	+4lwe71vD1UR9jG1Fgo3p6zUJsKRFsO2cbEXzk8Zoup8QydKlnBDo+AeOPKwvb/nT5B05l+zk/8
	kOdHYW6
X-Google-Smtp-Source: AGHT+IH2SjTWTgUng0xb8MVNI07treE0Rf1uZrlyLZS28ps1VWH5GeUrd451Qm6fRobbn3ai1A5EuPF9RQCs85dAYm4=
X-Received: by 2002:a17:90b:1804:b0:31f:55a7:6504 with SMTP id
 98e67ed59e1d1-321162c71c9mr6274051a91.5.1754318045294; Mon, 04 Aug 2025
 07:34:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801-amdgfxv9-v1-1-0b9670ab5509@ethancedwards.com>
In-Reply-To: <20250801-amdgfxv9-v1-1-0b9670ab5509@ethancedwards.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 10:33:52 -0400
X-Gm-Features: Ac12FXzEWmuF5wDSj54XY1blu563_2bdAIUexGomIzDirrtij04qOUL9B36nQoM
Message-ID: <CADnq5_Nzia7kvqBYxVwnRASFHyWWDPPrA-qBsLH4OxP_S49L5Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx9: remove redundant repeated null checks
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 2, 2025 at 4:33=E2=80=AFAM Ethan Carter Edwards
<ethan@ethancedwards.com> wrote:
>
> The repeated checks on grbm_soft_reset are unnecessary. Remove them.
>

Same comment as the gfx10 patch.  These are necessary.

Alex

> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index 6a9cf3587cc6f0a0d00ab1c109fd599dd8aa2579..a6ff9a137a83a93cde0b0c9c9=
e51db66374bcbee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4175,19 +4175,17 @@ static int gfx_v9_0_soft_reset(struct amdgpu_ip_b=
lock *ip_block)
>                 /* Disable MEC parsing/prefetching */
>                 gfx_v9_0_cp_compute_enable(adev, false);
>
> -               if (grbm_soft_reset) {
> -                       tmp =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> -                       tmp |=3D grbm_soft_reset;
> -                       dev_info(adev->dev, "GRBM_SOFT_RESET=3D0x%08X\n",=
 tmp);
> -                       WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
> -                       tmp =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> -
> -                       udelay(50);
> -
> -                       tmp &=3D ~grbm_soft_reset;
> -                       WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
> -                       tmp =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> -               }
> +               tmp =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> +               tmp |=3D grbm_soft_reset;
> +               dev_info(adev->dev, "GRBM_SOFT_RESET=3D0x%08X\n", tmp);
> +               WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
> +               tmp =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> +
> +               udelay(50);
> +
> +               tmp &=3D ~grbm_soft_reset;
> +               WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
> +               tmp =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
>
>                 /* Wait a little for things to settle down */
>                 udelay(50);
>
> ---
> base-commit: b9ddaa95fd283bce7041550ddbbe7e764c477110
> change-id: 20250801-amdgfxv9-30357749717e
>
> Best regards,
> --
> Ethan Carter Edwards <ethan@ethancedwards.com>
>

