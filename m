Return-Path: <linux-kernel+bounces-883345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C1FC2D1F2
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 22EED4EB1C3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD893164C7;
	Mon,  3 Nov 2025 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGK9MJuN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D05E315D2D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187251; cv=none; b=Uz1ShsZZvQtipaZXbjX1Vkvy2RiuT8HleK4xEO+1rwT5KGMvipjXsiG9naAuuwOXSEHi1xO0iOIYdyAesYIYlHbFY9rMk/5UYrHQL9nJqOAzARVXhbXgeAyOyCTLOXSctYFwchevat6S4VtY/xGGmYrM/j2GIoGiQQZsducjpZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187251; c=relaxed/simple;
	bh=99+24Dku6zFrLH/hUuVbw0xMRUYdTdyUD6CNYwa6Q40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kG22QdxUNJECRz2HL/BrHuR7NonH9EK/45ZctM3bxmPVyTDN41NVR36dWG/DQ2fiDeLQq0Mz+SFwJ7I7+8gc1pLBWFyd1yGdjF1b+kDDxof6uIWiSoGmX4jQFmeOmfhdOnrLzMuwPcF2Sq/g82aFWJg/ffYL+tPber1ypJo33i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGK9MJuN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322F8C116D0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762187251;
	bh=99+24Dku6zFrLH/hUuVbw0xMRUYdTdyUD6CNYwa6Q40=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vGK9MJuN9D4CwGxKGa1gJjrJG5viR0BdIwgemkpI2vm1hG8Xo80oIcS4jsVqEVmyZ
	 uAgSKsEgqFDczhDvvxbOyLOIkHnFNeSIClJeydizoMn6C9nFFxWuntdWUi1eASfa+S
	 tRkrUX/R2OmrW+pdUfiITIMN9bUyIroVsw335pV/nOpSXB/WRFsEkgO34SdVeToyLt
	 L4dYiVwzNVpAtNRmT3CUcvaXrXNT4Nq9zyYcgFda/vH2XnEchYNZ7xBMljSN2SQZHC
	 6zPesP0Nb68HRSE18OzwQ6Tf7Kz9rrx9xsscDSkE0+A/0JV+akWqIWtonZJIgcKZgR
	 ceFWGul0mGO0g==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7c68bfe1719so1100134a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:27:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU8jmVkIT5hYRnuuIcN1tj5kznYA1A50vN66UXYaVa3CfOD1RcspGq81u8w0lj5rFwldm0BkPwY57SWGDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaP9Vgohs7rcEsn6c4+g1IoLeWrunM2Z9QAhU19XEVCl3qc3B6
	TJGvywFznDKGIkll6cTrinY4fXBmfU2uCT/wSldZjUWC3w4mqW5rdPF4QwHU7MkubYqQqILKFfC
	03nqzOVWLKmm9lZO6WvflDRrMwwg5GrE=
X-Google-Smtp-Source: AGHT+IExOLZR7f9wMpzNuqxAydREiXbX+indVPH2iGYqivv4RxmbM+TAfIOffxAB6YNFuQz1VRP3f7waNT0RIyo4rCY=
X-Received: by 2002:a05:6808:3308:b0:44d:bc4c:22bd with SMTP id
 5614622812f47-44f95e3c0d1mr6190960b6e.24.1762187250539; Mon, 03 Nov 2025
 08:27:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_EA7267F6C936BBDE7977C3076819C9BA8D08@qq.com>
In-Reply-To: <tencent_EA7267F6C936BBDE7977C3076819C9BA8D08@qq.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 3 Nov 2025 17:27:19 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jM8OAeKYMHSfkEZ9HEkKW+ap6nSYLw_8Wm_S5uHX885g@mail.gmail.com>
X-Gm-Features: AWmQ_blBBZZ3ZlPE-rVoP1etylf1qZIfnjmB6jo14PjL4RDSwDa_wPT8ieCsvRk
Message-ID: <CAJZ5v0jM8OAeKYMHSfkEZ9HEkKW+ap6nSYLw_8Wm_S5uHX885g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ACPI: PRM: Skip the initialization when boot from
 legacy BIOS
To: "Shang song (Lenovo)" <shangsong2@foxmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shangsong2@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 7:31=E2=80=AFAM Shang song (Lenovo)
<shangsong2@foxmail.com> wrote:
>
> To address the confusion caused by the misleading "Failed to find VA for =
GUID..."
> message during legacy BIOS boot, making 'EFI_RUNTIME_SERVICES's earlier j=
udgment
> can prevent this false alert.
>
> Signed-off-by: Shang song (Lenovo) <shangsong2@foxmail.com>
> ---
>
> Changes in v2:
>   - Add comment for the code update.
>
>  drivers/acpi/prmt.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> index 6792d4385eee..4457ff17f878 100644
> --- a/drivers/acpi/prmt.c
> +++ b/drivers/acpi/prmt.c
> @@ -392,6 +392,14 @@ void __init init_prmt(void)
>         if (ACPI_FAILURE(status))
>                 return;
>
> +       /*
> +        * Return immediately if EFI_RUNTIME_SERVICES is not enabled.
> +        */
> +       if (!efi_enabled(EFI_RUNTIME_SERVICES)) {
> +               pr_err("PRM: EFI runtime services unavailable\n");
> +               return;
> +       }
> +
>         mc =3D acpi_table_parse_entries(ACPI_SIG_PRMT, sizeof(struct acpi=
_table_prmt) +
>                                           sizeof (struct acpi_table_prmt_=
header),
>                                           0, acpi_parse_prmt, 0);
> @@ -404,11 +412,6 @@ void __init init_prmt(void)
>
>         pr_info("PRM: found %u modules\n", mc);
>
> -       if (!efi_enabled(EFI_RUNTIME_SERVICES)) {
> -               pr_err("PRM: EFI runtime services unavailable\n");
> -               return;
> -       }
> -
>         status =3D acpi_install_address_space_handler(ACPI_ROOT_OBJECT,
>                                                     ACPI_ADR_SPACE_PLATFO=
RM_RT,
>                                                     &acpi_platformrt_spac=
e_handler,
> --

Applied as 6.19 material with modified subject and changelog, thanks!

