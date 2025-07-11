Return-Path: <linux-kernel+bounces-727940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6359CB021A1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 189485459B6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2752EF2BC;
	Fri, 11 Jul 2025 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="mOHIUOTX"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFDA2EAB66
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251061; cv=none; b=aBCNapkuu75brUz49LaDBitOUBwlkPzkMkiGnsWnVvNIu8OxML4rLABwxopC9rpsmYu4bZh+34JofE88rbQ4/EMgX76eyHAO5FDSY73/IvISE4/siJf22Riv7ZG0mM2G1PNbWQq0cxf45vEes6E4LhUfp28Y5NtkI/rmDzA7h5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251061; c=relaxed/simple;
	bh=cMO21aNE8jePVmw//BGrQpUoEr6scyBmxSjxl2zqlxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LVrSgpbLLsaQwuUVy5lTOHJi2BLkV0lohyVY+pe++QSbtlfkMNu8DQjcGS7yq28gP3fkkIF0n5Kpz/QpZXJZzgC2wnLA56ktXipNtED/FM0XeuQz5rkFiQEfAbwOBBQQIxZ1WI2JJU73NWs8rTa75zMBGFNPD5kLW5t9GAtofg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=mOHIUOTX; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-86d00726631so74802239f.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1752251059; x=1752855859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrIf+wWA/D3VVdudVKE3VUjB5xcAA2WL2BSQ0S3Af6s=;
        b=mOHIUOTXm+35xXz47LMHxFTrV67n3/YSViVb0TjlVmhMKVSoOg2r2Zs85zcebwTotq
         nkt4cvdjUdImkrW6YPSlLGQ1MMc1EMDw9J96c99xNFNzWz5d19Khzh5Vgi2EAfCiEDdn
         gGU8O1noKHHTMQnVN4Kw4lYZ40avzHsSPnbfd13LWtlmp/JFYlhmA+PhJ+VE3S+lhJt7
         dagriTLodCExpIS/qlEubz5GrDYjr0X1bMdYgWYL7y34kF507S04U5RmzQ4jb9tzg9+k
         NIsi28+Vkk/9276bu7nVYf1yYZvKFyIIF7EgeS5lfCKZQASg3Ouyn3YZeXi5J28wAqGi
         M9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752251059; x=1752855859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrIf+wWA/D3VVdudVKE3VUjB5xcAA2WL2BSQ0S3Af6s=;
        b=oUpvL0/Kv55WmGkPVMqPvfhdYy+srKL6RVDHRnLlDz2uv790H6VB64L9RyUhG0zM8e
         fRwgq4szbT8CtAgADqTcOCOkoUMi7EYy9JNmYAkyQUSw/KX2+bKPA5qsUEUWFY+R+hcx
         vjF9Wt9jgZZkL8D9ALz0rqRE8G+jHgvU9+tftv/1h4l6lYipx7tdWdRazTeT0zKNqSar
         AdiA8sWjsd8sKCPntmmLhgD6YHG9A07MjGKhGpgTtEr+jDZfpO/DmoaI7Ir78Fvqhg2B
         iDl1sQNjBrT/pgVptdCA5BwnNJnMzM8PCsK/c/L7+YRegZIXr2Y1Dz/vtWeD8Ad8yfFy
         klHA==
X-Forwarded-Encrypted: i=1; AJvYcCWjmZnj76o8irGcrGATkehn+yJcsC4bXuWC/L0wFRL5eDVNkSOgaBFPcDLH1Vz3sBhRV58lh8M6qDt2ErI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLzwshra67QkxPuI+3TBYtRKSTZD0VnypYkPjlPaiApD/oL6eU
	SDxm5ZLjNqlQTSBM53JOYxo1WgxItws6TXrLzPwV6vRbb0elAVgwBwFLJ+I4bOz4gVyDHlJ5j7W
	pcs2FYiySsk43B+DG9FBcBf1sJgJty16+bExcjvcCWg==
X-Gm-Gg: ASbGnctFo5A8XPYmA+uOe1/f89hfKPOjR75IYpEQMRl77p5BUNxyZCWUXinksIkFmTQ
	C638YZgr55Mrlm6MY5JZn6K6OQDhQnrk6lvu/CZ+rWI5ToZfs8/t/gX33U/Rc5WbIlb95cRubAb
	O7F4tusMVROMZOqzf6+eN3LnOFXR6gWuNi80+xObbIvfwhe6nDYzi/ncZwT0PAlPtGbRjC4TP6H
	amXK5I=
X-Google-Smtp-Source: AGHT+IEgo0yoNtHXaZRHtcGwnexmwO8T42ro0oy6XMW829CWZxM0G/3ulBECSGHLVGNEjLJFmuCzUmfD9G4uz5kdDa4=
X-Received: by 2002:a05:6e02:1fc4:b0:3de:128d:15c4 with SMTP id
 e9e14a558f8ab-3e253fa39a0mr42624545ab.0.1752251058238; Fri, 11 Jul 2025
 09:24:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711140013.3043463-1-sunilvl@ventanamicro.com>
In-Reply-To: <20250711140013.3043463-1-sunilvl@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 11 Jul 2025 21:54:07 +0530
X-Gm-Features: Ac12FXwUkiRJWGtrJ4BJLcD_qt-SO7VTbgyLm_cGjFvtWTFEfiq5mlAj0Rq7ox0
Message-ID: <CAAhSdy00ztZoX4LF88RTmnyJwKGWseD5qcHkuBW2w_JP5bBL6Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI: RISC-V: Remove unnecessary CPPC debug message
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <apatel@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 7:30=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> The presence or absence of the CPPC SBI extension is currently logged
> on every boot. This message is not particularly useful and can clutter
> the boot log. Remove this debug message to reduce noise during boot.
>
> This change has no functional impact.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  drivers/acpi/riscv/cppc.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
> index 4cdff387deff..440cf9fb91aa 100644
> --- a/drivers/acpi/riscv/cppc.c
> +++ b/drivers/acpi/riscv/cppc.c
> @@ -37,10 +37,8 @@ static int __init sbi_cppc_init(void)
>  {
>         if (sbi_spec_version >=3D sbi_mk_version(2, 0) &&
>             sbi_probe_extension(SBI_EXT_CPPC) > 0) {
> -               pr_info("SBI CPPC extension detected\n");
>                 cppc_ext_present =3D true;
>         } else {
> -               pr_info("SBI CPPC extension NOT detected!!\n");
>                 cppc_ext_present =3D false;
>         }
>
> --
> 2.43.0
>
>

