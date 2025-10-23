Return-Path: <linux-kernel+bounces-866503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A5BBFFF0D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 908924F3C87
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6083002D0;
	Thu, 23 Oct 2025 08:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rczCHipR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4050E2FFDDA
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761208268; cv=none; b=kede8EoMNT+y9ZyOYv2ui3dWVDwOsBkjR6ywf1SaLWuWzMM5vudv4CwIO2aUa4TqV9VM3AL1wnE14h/YbozrU0HoKypKGbqJlOJc2dtgSpR0VMNITyzfL0W/whSSnEI62aGhUnEHhvcTu6jEumbfR+dSRJbLujZ2WDLAr9ms4mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761208268; c=relaxed/simple;
	bh=bFoOFvqHEoQk620s/iyc0FwUv0/+PYvVS9nDEBN1DGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iosty1k1wV4frkXDaT57IB3Yqvq0YNatt34BYWexVoWtILD2eieHHjsTJHQlj//ASeoUo5MdTe4WWXzBuY7RCABV0x8q1X15rRBtvPWq+iBrzMrOd3NdVoDpppbnE8yRAjMBwkM5Es7VXQQH7guaQBZXeh5DI20RswD34pGq8cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rczCHipR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40B0C4CEFF
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761208267;
	bh=bFoOFvqHEoQk620s/iyc0FwUv0/+PYvVS9nDEBN1DGc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rczCHipRMct75wabc6EWWhjvu2ktMfl9mYmKrMiqQIIQlubasW4cUoHtKHTz7/wve
	 pG9nEUVX6fmRC/G8TENPbCjQQkqrso7RdP4KASV+x2sn/jlzc+2uZXBoRvuniMzO/l
	 j9le2fQ7PRa2o4/zt2EgB//1wGufYLWomuKJXy9KNbeLZkHtQ4pcH1VXjHzMbgz/ny
	 fmMIfq/jT1FlwFQBSp+EcvLpMneHn0Jq7RNyN8hGD+l/Xikng6wyhVBEgVgw87vdQX
	 CJIMXT8NZGSVqSp9cRhmPNGlQYUNn3egzh+0FdLZKkIecRmn+L1ftNYJ9bv+rbN29q
	 5QaBPbov6LzdA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-592f5fe03dcso492386e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:31:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVC5D39vJJ+IRtYVdEhd1wYQvEsbd4oYIUOLJQRwGMNbb9HwGFyzcLPGhp3dnIb7cBxXUtNhPc3wGKG1AE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTvpGPMVH/gdwahG0Xna/+aTlOrYf3CERetIMRDe3Au4GiAgJ3
	R2O3y1zTCnGqfqXzxyYXS/G7tZpvUw5kpySviknJv6EWAod3VDXXBhH7lilAoX7+Z+ApLJ32RoH
	+E8EcAlheo1L6du1IFQDmDqWrDJ497xo=
X-Google-Smtp-Source: AGHT+IEhcLf5FIRwByJaSQnfDpZsBKep/9aXOLRRWcORJP4c6v5Nn9uvZ0mdqWItpwlkTlQdKxUgwjjzv9WgOvAqi9Q=
X-Received: by 2002:a05:6512:3e18:b0:592:f315:843 with SMTP id
 2adb3069b0e04-592f3150ac3mr1217650e87.50.1761208266234; Thu, 23 Oct 2025
 01:31:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023082129.75612-1-maqianga@uniontech.com>
In-Reply-To: <20251023082129.75612-1-maqianga@uniontech.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 23 Oct 2025 10:30:55 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHs3vC4TEWg1ogG=N8Dd5L0rkQ=qAFLWKiAA5yi_He3GA@mail.gmail.com>
X-Gm-Features: AS18NWAqPnAyqoEewao8d7Q2_zh3PAnOF7TqO_cE-DS3GzEfQDx2JtSNzXOLUjg
Message-ID: <CAMj1kXHs3vC4TEWg1ogG=N8Dd5L0rkQ=qAFLWKiAA5yi_He3GA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM/efi: Remove duplicate permission settings
To: Qiang Ma <maqianga@uniontech.com>
Cc: linux@armlinux.org.uk, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Oct 2025 at 10:22, Qiang Ma <maqianga@uniontech.com> wrote:
>
> In the efi_virtmap_init(), permission settings have been applied:
>
> static bool __init efi_virtmap_init(void)
> {
>         ...
>         for_each_efi_memory_desc(md)
>                 ...
>                 efi_create_mapping(&efi_mm, md);
>         ...
>         efi_memattr_apply_permissions(&efi_mm, efi_set_mapping_permissions);
>         ...
> }
>
> Therefore, there is no need to apply it again in the efi_create_mapping().
>
> Fixes: 9fc68b717c24 ("ARM/efi: Apply strict permissions for UEFI Runtime Services regions")
>
> Signed-off-by: Qiang Ma <maqianga@uniontech.com>

No, efi_memattr_apply_permissions() uses the /optional/ memory
attributes table, whereas efi_create_mapping() uses the permission
attributes in the EFI memory map. The memory attributes table is
optional, in which case any RO/XP attributes from the memory map
should be used.


> ---
>  arch/arm/kernel/efi.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/arch/arm/kernel/efi.c b/arch/arm/kernel/efi.c
> index 6f9ec7d28a71..d2fca20d912e 100644
> --- a/arch/arm/kernel/efi.c
> +++ b/arch/arm/kernel/efi.c
> @@ -70,11 +70,6 @@ int __init efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md)
>
>         create_mapping_late(mm, &desc, true);
>
> -       /*
> -        * If stricter permissions were specified, apply them now.
> -        */
> -       if (md->attribute & (EFI_MEMORY_RO | EFI_MEMORY_XP))
> -               return efi_set_mapping_permissions(mm, md, false);
>         return 0;
>  }
>
> --
> 2.20.1
>

