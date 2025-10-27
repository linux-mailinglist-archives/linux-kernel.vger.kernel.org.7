Return-Path: <linux-kernel+bounces-872321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D764EC0FEB7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0592E4ED258
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A39D2D876B;
	Mon, 27 Oct 2025 18:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnzzAYeY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB710433B3
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761589556; cv=none; b=QusJM7hErQtJ95JdBjUIhEVP7vKovW3WCIyWo2gQl5i3uWxQggvcbyy665ZF88Ayyng0N+2C33DKYHgLHNK/qq6E7ZcyA4iw33Ag8zfbXc+oR6JsJHfrSReopD9MTNJRVgdTjQ7hXnZV17vq1ovxod6uqvBpdsKsvyGLWM75Fa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761589556; c=relaxed/simple;
	bh=x0GdLq5oDT2bsye4+zTGepjhdJueRV6Y+YQZ4kwiQjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uFmfNxFHKZV8526pJfmv+PsBg3u9irhwSTiLxv2IJhxGIS6Y422WtbUBIBp+YKRaNezEvyb9qidwksv1YlCPPH8H/QbAyquyupCHvwyQ2kjLIPV2P4Xpu6QoHkbgLOWa7ESU6OaBj+kd/ZKkDBDojIvohA9JS9OTvXElIHLsggQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnzzAYeY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CC2C4CEFD
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 18:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761589556;
	bh=x0GdLq5oDT2bsye4+zTGepjhdJueRV6Y+YQZ4kwiQjI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gnzzAYeYRz3Mqb8WaFg/u8kWKIHC/9wtZNUsL4sZFO0qmlko7bbcQ5ilEk18RYcCN
	 LMG90WoISGQMs1krcPexq6q4y92QG+z9J+f3in7KMugAUCKqZhExUxSCj0pG4E649y
	 KUXbjdGTiyAgfKEKoD6swr13seSDIgUh5H9i6X9iRJk4F2JJ9kEGD2SKR9gMDdHENQ
	 JAw7PKzgHEgQniBjIVBL96yyHNDWGtVLaP6CJQnfD6d2S83uAPlJGAPefNSGzpHFqt
	 7uL6o8q9/8nSAAYvvOfZd6XZO9B8beUEIgdyEd+MbRlL74heJiEQhNWSCsQao9JcLz
	 nxDz1foQ+lTiQ==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7c0e357ab51so4707026a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:25:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXaG/l70Hnjda/PjM77OSv41hjdHuGSgNaTtmD2acIDMpiMknkHQXDgKkj6xhp+DhXfSSUJ5GFyb2crsek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1WdoP07qm+Fp9CpgEiSPMTK+daJO62Tx+VoGnnviWJuQaepM7
	jqKsv8nz/rcyzNpaTmgt+6GECDwwjYTBzrXFS+j6836E83pM+RyqJMMOGat3QVF6w/yvHEMjqZ9
	ffleL1fTlkUIsg6+K8PFOGgccSZgAZq8=
X-Google-Smtp-Source: AGHT+IH+/v+LQw9DzQQ8Vvjc8o5cD0s9vYZfdVPNB6aKtMkLpGObabhiy1PrnQHxjpgsbBapAIOim4OcgWEv0zzMosQ=
X-Received: by 2002:a05:6808:f89:b0:44b:1f75:dee7 with SMTP id
 5614622812f47-44f6b911a0cmr399801b6e.8.1761589555767; Mon, 27 Oct 2025
 11:25:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_EAFBEC2D1967D73F4F76B8048D2F59BB1105@qq.com>
In-Reply-To: <tencent_EAFBEC2D1967D73F4F76B8048D2F59BB1105@qq.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 27 Oct 2025 19:25:43 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0httK0xmvA5zcYruU1Ypsw1YXHBOaPQxwCai8YDLsGkvA@mail.gmail.com>
X-Gm-Features: AWmQ_bkhyJQvdvhTfLeogaWPxZqKwt3rdWh3HYbs3GEZYZulKc9_EJEohW0F2fg
Message-ID: <CAJZ5v0httK0xmvA5zcYruU1Ypsw1YXHBOaPQxwCai8YDLsGkvA@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: PRM: Skip the initialization when boot from
 legacy BIOS
To: "Shang song (Lenovo)" <shangsong2@foxmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shangsong2@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 10:38=E2=80=AFAM Shang song (Lenovo)
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
>  drivers/acpi/prmt.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> index 6792d4385eee..ec367d322ab2 100644
> --- a/drivers/acpi/prmt.c
> +++ b/drivers/acpi/prmt.c
> @@ -305,11 +305,6 @@ static acpi_status acpi_platformrt_space_handler(u32=
 function,
>         efi_status_t status;
>         struct prm_context_buffer context;
>
> -       if (!efi_enabled(EFI_RUNTIME_SERVICES)) {
> -               pr_err_ratelimited("PRM: EFI runtime services no longer a=
vailable\n");
> -               return AE_NO_HANDLER;
> -       }
> -

The check removed by this change addresses a different case than the
similar check in init_prmt(), so removing it when relocating the other
check is questionable.

Please limit this patch to the init_prmt() changes.

>         /*
>          * The returned acpi_status will always be AE_OK. Error values wi=
ll be
>          * saved in the first byte of the PRM message buffer to be used b=
y ASL.
> @@ -388,6 +383,14 @@ void __init init_prmt(void)
>         acpi_status status;
>         int mc;
>
> +       /*
> +        * Return immediately if EFI_RUNTIME_SERVICES is not enabled.
> +        */

One-line comment would be sufficient here.

> +       if (!efi_enabled(EFI_RUNTIME_SERVICES)) {
> +               pr_info("PRM: EFI runtime services unavailable, can not i=
nitialize.\n");
> +               return;
> +       }
> +
>         status =3D acpi_get_table(ACPI_SIG_PRMT, 0, &tbl);
>         if (ACPI_FAILURE(status))
>                 return;
> @@ -404,11 +407,6 @@ void __init init_prmt(void)
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

