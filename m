Return-Path: <linux-kernel+bounces-879361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4A0C22EDA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F77A4E989B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 01:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FE726C3AE;
	Fri, 31 Oct 2025 01:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2GBhAG4"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B149212B93
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761875817; cv=none; b=hGsh0ym4avZwcptvnt9a3zWv7PmAZqTpWtmgZX5fNFdbjWziHVsg20GdHIA6K7IdWbKUXDOyT7h3KaoJQgV5BGQac5UEAqub5pnm3jmZPUZuZZE/P2jgTEMcpyJTezayNSL2ICiF/rW7QQtKLU8LuB7vkpBXkcI0qqBZCST08EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761875817; c=relaxed/simple;
	bh=CZTds3X6aLw+PBJT8jGzhmUg8shr79vJ9ejoYot3ZlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VCpCrgS31HiKzbcn1GTiUqTrb1wfJAaTVebozx3lNCj+lRoEj/DM37aCgGL/+FfKtSnM16S2sdZTnaVZWhccX75YJSXtt9D8DZnlqCX1QnQP/L4YNAynjCcPODEdbRK/1nqzJl2zod12FY5e8Rh8BhefHiWgMm2U1x6XHAfGy6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2GBhAG4; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-795be3a3644so10905166d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761875814; x=1762480614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPm8hhAmizQjOcUpCPxb+6jnF/zsbuFZoDm6e8517P0=;
        b=Z2GBhAG4VhcpXutt27b2Ebwv7o+OqaJFRLv9ETTgAhQEi+XZkdqywVPGnGQuvqts/D
         lHrMtNzTFLiVe8FsbUmUzJzfxVue67cCrx8qsvP7MMGP73kyWsi7opaYkn3n+wY29S1k
         lhZEBsUR+B4f1iFMI3Dr62nlwZBQGOW6yBO3la9Waxd+iEkmvp+UqVraj3n1rJW7O8Ny
         kgXyKe3j0nUZPAJCPdlQM6PzUblMm3y4jZDEqZSNYF7zln2QwFJviRqah1kbzrDN6oOc
         rcf0G7XjReYjVEJ+JoXctgkg9tLQtkmnYZPHfHgnSKPB3l+uOUv/+Gp+v62ikXOAiCNW
         4B7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761875814; x=1762480614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPm8hhAmizQjOcUpCPxb+6jnF/zsbuFZoDm6e8517P0=;
        b=Ek5/aGm080zKt6GZxUH0Y01mev6BdKbXxOHtQD3hFHN9m7y7ddxsO+mr8PM3lonDVz
         0h4CKIAlIE+TvqSwVCFA030Bhxf9azEy51mABB2VUyGUh9PFTDbQMIY8vmXUXyC0rBJm
         eNyU8wjz3S9kWGc6Nj/oug6M7EJHzMlaEbLeg5Q0pOLpSKsHy/UNT8VtpHCLTzrN18x4
         n+HRdPc3EOpFrDbOeXQl0j19pAVeiD+khaMInWsb6VDK5bqgx+YSte12endnOwDNSSmD
         MDaJqfqXvGmE1uadoC6Smfe43cp+MdzOpOfM3CKcZIJ8VwQ6DiLCTYw5xfBRceFjgORp
         wahQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrRzdPm5QWc58dqHz30LXPRlmmnAgaCo2g4Hh7rDOIUMSCMUd/NF5fhU4hHMW2DSU0yPP6Mj6UlQ1RWVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxaCbf0eB4ZrSEpeknd+Ic0vthbDOKUsnNwXeGZ7H+dz6m1szX
	DPV5YswbZZ9ZloasbVb43OMUx33JFnLblanigRXc9MWGL/aNyjRl0GIAE68FQ5k/c3O9wmruBUl
	agwnc1HHgTxdTucxkPgZZyrGtEwULGuw=
X-Gm-Gg: ASbGnctODbS+emDgaLyn1x7GtSc7WBDn6iUSO2RGmAf2mWL1H3CCcrv+MEbhu2QgeQW
	CkV6D8lBNQXLDugRFbQFXCx0sOdEWOaiTINXVRswQ3/+zjwgd+oSRX3SPGhoZ7m/wBac8bWFGKA
	Gkd6t0oEOlIINVxf8EGF+CEqTxhSzI6yS2AO+ICMV12845CLFR3hskE6C8HUErJHPQwAuBzQ5gQ
	ygaOXFWYVPSl1ZBmrjnGsy51DDi4MTd3VrA66NVJ9b+f8eZ2xgSkCG4oYx2bnnCqJtiHmRO
X-Google-Smtp-Source: AGHT+IGHRNW5ve9MfYrIumeQT60Oe/ZI51vPRQHltGYBjI9/W3Gf4lJ6TGxJq9jXE+9SVtlbRGsEi+oN5NDYG3LHztk=
X-Received: by 2002:a05:6214:1bc9:b0:87c:43f0:374a with SMTP id
 6a1803df08f44-8802f311f58mr22293466d6.29.1761875813700; Thu, 30 Oct 2025
 18:56:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030193955.107148-1-i@rong.moe> <20251030193955.107148-2-i@rong.moe>
In-Reply-To: <20251030193955.107148-2-i@rong.moe>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Thu, 30 Oct 2025 18:56:42 -0700
X-Gm-Features: AWmQ_bkH0rMtZc34Jno0rHVU5V9xM0sKsjwAUSR9O4U8i-gPZnLXJxpss0mop7A
Message-ID: <CAFqHKTn4tEqGpTpyaWEMUHvskRux1RHGxp89tWr1UeYgsnsV2Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] platform/x86: lenovo-wmi-helpers: convert returned
 4B buffer into u32
To: Rong Zhang <i@rong.moe>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, Armin Wolf <W_Armin@gmx.de>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Guenter Roeck <linux@roeck-us.net>, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 12:40=E2=80=AFPM Rong Zhang <i@rong.moe> wrote:
>
> The Windows WMI-ACPI driver converts all ACPI objects into a common
> buffer format, so returning a buffer with four bytes will look like an
> integer for WMI consumers under Windows.
>
> Therefore, some devices may simply implement the corresponding ACPI
> methods to always return a buffer. While lwmi_dev_evaluate_int() expects
> an integer (u32), convert returned 4-byte buffer into u32 to support
> these devices.
>
> Suggested-by: Armin Wolf <W_Armin@gmx.de>
> Link: https://lore.kernel.org/r/f1787927-b655-4321-b9d9-bc12353c72db@gmx.=
de/
> Signed-off-by: Rong Zhang <i@rong.moe>
> ---
> Changes in v2:
> - New patch (thanks Armin Wolf)
> ---
>  drivers/platform/x86/lenovo/wmi-helpers.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/x86/lenovo/wmi-helpers.c b/drivers/platform=
/x86/lenovo/wmi-helpers.c
> index f6fef6296251e..f3bc92ac505ac 100644
> --- a/drivers/platform/x86/lenovo/wmi-helpers.c
> +++ b/drivers/platform/x86/lenovo/wmi-helpers.c
> @@ -59,10 +59,25 @@ int lwmi_dev_evaluate_int(struct wmi_device *wdev, u8=
 instance, u32 method_id,
>                 if (!ret_obj)
>                         return -ENODATA;
>
> -               if (ret_obj->type !=3D ACPI_TYPE_INTEGER)
> -                       return -ENXIO;
> +               switch (ret_obj->type) {
> +               /*
> +                * The ACPI method may simply return a 4-byte buffer when=
 a u32
> +                * integer is expected. This is valid on Windows as its W=
MI-ACPI
> +                * driver converts everything to a common buffer.
> +                */
> +               case ACPI_TYPE_BUFFER: {
> +                       if (ret_obj->buffer.length !=3D 4)
> +                               return -ENXIO;
>
> -               *retval =3D (u32)ret_obj->integer.value;
> +                       *retval =3D *((u32 *)ret_obj->buffer.pointer);
> +                       return 0;
> +               }
> +               case ACPI_TYPE_INTEGER:
> +                       *retval =3D (u32)ret_obj->integer.value;
> +                       return 0;
> +               default:
> +                       return -ENXIO;
> +               }
>         }
>
>         return 0;
> --
> 2.51.0
>

Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>

Thanks,
Derek

