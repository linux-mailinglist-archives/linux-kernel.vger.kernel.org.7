Return-Path: <linux-kernel+bounces-755327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 886FAB1A4FA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E79F07A67BC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A772701B4;
	Mon,  4 Aug 2025 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvuCcl7s"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FDC3FC2;
	Mon,  4 Aug 2025 14:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754317976; cv=none; b=ZxpE9Y3hbSDZ6hOH7KESsbYHKxeixV/DuBjexE7WupnTFkU6UP786HvScsDIbbvbbHlS262OwNG1QKnJM59588xXcPoUdIoWhPB9pltki0fCqqlDfrMbY4EcLCkM9hIercNpN8VXzPVg2Nyh2CWanYfSuOT8NRtkPvQEVfeB+b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754317976; c=relaxed/simple;
	bh=/mwwvH02Bzvkl+c3RzLYTCTG4kQQGDYWXfehRlycaLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S10kFyLuko8nVk1340EJGLGpRMlESk1CkMHLZSNNQXrCoixudAYhJ9Nh2kcZ+rJMhiOw9fsNMJjUtbqq28jdIudgEZ78E4i3fvzQBg1FWOKaLrnScFtI9K0XyuRLvU9JTBi9jN9asLS8xAQJUQN6/wMhbp8+eGd6W0UNNWYPtTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvuCcl7s; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b3badf1afc0so704182a12.3;
        Mon, 04 Aug 2025 07:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754317974; x=1754922774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VwQYHiITIJoPNIH3t9+T75Uq05OHfjWXaf+GOec9BM=;
        b=cvuCcl7szBVJjMIuuTr/2SlZEDn0JAQvmrHxB5Yfx2DVVnMRg1yTKtoR+1/6BvWpA2
         YrWbWprHWMABgi+3OT2bVQ1wvvYsf5Lm6a7UNot/8YaLiW4xXj+50FTqDrT/c95A+u8D
         CMwN+ckTWtgpcAdV3KoeZTisH19RKzsbOFS05svnPVIszlmIBAV/F253Ax6r5Wr5VPha
         Ncly7PN6o6SjsJbjgDsPsKte7FUflc+3uUCxJhBT8bKGZcmVR04UsHA6F83PYkHacUM0
         dkP5c2bCF+FImxFB+zTf4Fb8Gv/yFuyZZ6zUR5dLh55oRhC6TTNjJtwQTVEXD7a85dMC
         Qfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754317974; x=1754922774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3VwQYHiITIJoPNIH3t9+T75Uq05OHfjWXaf+GOec9BM=;
        b=APzwe6UBjcuDsm325cHXIc9yT3v0hBobd7Cp2mft9SoYjGFyU/SoFBR6FTDUkMsAHG
         6L3PsVTvAnSrsz880+2mCoWVpNAf/8DWpny4a1IEmedb6DiWXWY0xwqiCM8+nKXlYbyK
         jqTYyj3p/vGgTthYJXMZY7yjJbDGD4fIX22pQ1p8cCd31nRHzMLZ/e9mmikl2ZKs3Yau
         ztJs9p/hIDCnwubCT+mwKPrRczNCbkNkE4HZ8eZeKNwzINHOCTIywEIHIc8hEeWthump
         LQLbeZCqEyAmwe/yY1GkncFCQpM2NGlFs/ZRb+CHsX7++R6obdrZr73XxoMWOQE/f54L
         CdGA==
X-Forwarded-Encrypted: i=1; AJvYcCUG+z+utpKwBtfD2Zmy8jlSaqUC68KtY5mKU2KH1ceDqX7iBxpwoLoKvbWiNuYE1gfL5cN7uwJZONL5bkxl@vger.kernel.org, AJvYcCVN4xm5HZA+Nvfpes9HRZdZ8XohJSd4bC0YVn7ZUQtn8J4OJeJvwR1w7WRzTtx1k1oAqaxhBfuJeUD/+4tqbWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzF2HS3ToQv+pGR32dUe7Ii1B+NGqbol39/fNQUdGnSqGuPdJK
	f9qipTmpEh1evc5Qx2a7h8iT5HzfPEWkDLXOeHqZBebKfmx3Q/0MF6zBy5xx47GwfeDQsl+4Ddo
	WByitd6ovWYHwrhgmzLnBDSCoOfzS49I=
X-Gm-Gg: ASbGncv1NtyTHb61bolp/4f80L8rwTGUbDVM15tCXIJ3BDKsYEHDa6DhOzNzB+Jxz+4
	hM3D4g4iafFdIIZweo7mvcDymp1l6p8yTnLV3QH+g9lVjzKrpDnx6QaANob5Igasy1DIRGCEfPh
	A+7T2mYCubrUU7DKw2CT7exVc9ECOEc60e/zvnaTvUh9ie0ukgIssbc1gydu+4RO9BqOldUZaXR
	0ZjLHMQ
X-Google-Smtp-Source: AGHT+IFU8SQn+t9P5YQiglKfiFVWoRrg0f+OYP5ZENWD+GqnAinpFBixGqrr/sdqrwCYurLyvZoUZ/+IOIbC+g9fHlg=
X-Received: by 2002:a05:6a20:7289:b0:240:1a3a:d7d4 with SMTP id
 adf61e73a8af0-2401a3adbd2mr720316637.2.1754317974392; Mon, 04 Aug 2025
 07:32:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801-amdgfx10-v1-1-e1dcbe18d84e@ethancedwards.com>
In-Reply-To: <20250801-amdgfx10-v1-1-e1dcbe18d84e@ethancedwards.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 10:32:43 -0400
X-Gm-Features: Ac12FXw4Ip0lDCJ5FVa-kIabSeRpvVdWcCZBk7u-5qBZ0hGaf7CXjMiAEelQ6SQ
Message-ID: <CADnq5_N+bQppUAD-qR8QC8M6nW+oRF8+7z=Qakcxc=a6Z8q4Gg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx10: remove redundant repeated null checks
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 2, 2025 at 4:22=E2=80=AFAM Ethan Carter Edwards
<ethan@ethancedwards.com> wrote:
>
> The repeated checks on grbm_soft_reset are unnecessary. Remove them.
>

These are not NULL checks and they are necessary.  The code is
checking if any bits are set in that register.  If not, then we can
skip that code as there is nothing to do.

Alex

> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index 7bd506f06eb155de7f2edb2c1c9d5ed7232b16fc..264183ab24ec299425e6a6d05=
39339ee69f60c24 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -7668,19 +7668,17 @@ static int gfx_v10_0_soft_reset(struct amdgpu_ip_=
block *ip_block)
>                 /* Disable MEC parsing/prefetching */
>                 gfx_v10_0_cp_compute_enable(adev, false);
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
> change-id: 20250801-amdgfx10-f96c43cb0c59
>
> Best regards,
> --
> Ethan Carter Edwards <ethan@ethancedwards.com>
>

