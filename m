Return-Path: <linux-kernel+bounces-883499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D441C2D9BC
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 19:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 336F91899E9C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 18:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B823C3195FC;
	Mon,  3 Nov 2025 18:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVjTmFo6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1123101DE
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 18:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762193460; cv=none; b=kfx3dp0xxKRqgp0duD9Q7OiTjFfA1Bs6ZwXEPKi0Jv9vXkxv6g/c47LbP8MosHNrnBWfUpTlKVclPgd2wWkXjbqBRRy5if6H/IOtvff9cRvVrQ/9rzWkaQh0THkarlAH4MoLt/MAEqZensbNEQIrdjL7xgk21UC4h1jcF2t8pGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762193460; c=relaxed/simple;
	bh=F1cyaRwXuuiAD27jN50XcYaxxfBoxB5Wu4eUm8fx+uA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HIm6aw85CokRd4Ypix8sP8jnGsH/GhQ9f3LbWXYZbZiYGIrXagkBntqLnjDJRbQcuZfj2TV/H5/Q7f/7m+QLT2Zw1cvmkITg2CxOomMnhUBDgmh0emPab+GJs46Y8kU5cvSqQ2kdTEHzkPJ9HExVUtvGQ635J3FHz4qfrHxJP6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVjTmFo6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF63C4CEF8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 18:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762193459;
	bh=F1cyaRwXuuiAD27jN50XcYaxxfBoxB5Wu4eUm8fx+uA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AVjTmFo6eE2n7m9U4FxE+w8fgmU1/VSrNVelJszu9r30YaFM3Pjg79naCLqYaplHL
	 07yBns7mFoTpFZJFC2ZuttemVcD9KlnlAopPxKS4qIkie0scId2nZCKGn3NCkrnCQo
	 QWIzef7Hc/gEWNxnzBQU7YvPcxgU9WRzC7mbwWxq+OIkibajVwjLjihrug3QbXZ/90
	 uhbNfNw2masPZYk9JNX+v23EPFsBn3bKRMsrPaWizycKbQ5ieVpdz3DkMKCeqP65hR
	 sy+oxBgqjQrTYoyzaf7iZ9a2ok8H9/tC5Xrs+amI7zrUxcN/T9VNtbR+jX8KXmRah3
	 yGOUapH7vuAww==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-44fa06c8975so1202952b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 10:10:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV+JttOzC5984ve3RmtMCkC8NgahEFLpgrLMsTZCxCC6kmKKZACbFE2ujaWbCh0sMHTlI73qjvSqOWEYOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw11TQhUwm0QFC1TPo1RkeB1JAdD22U9UDV+vW51y+0dBCzDOyw
	/RjtXBvdSVKM73qACn1jmzDLKYNZaJPLSqA6RwdYYJiM+OfgBTKsmg9mitniUCtpLIhUXhcszDb
	1/IGNNmL8VjZyQncOBwk4D+KpPT5yQv8=
X-Google-Smtp-Source: AGHT+IERn6uEe1JRDuOSy89W8uoKbaW2TvHTNbgPSoGwUcM6iCWeIBZxgdOrz7EQeB+XzOWr1sYvL5eZMZFEJqP8g1E=
X-Received: by 2002:a05:6808:1a1c:b0:43b:2829:e643 with SMTP id
 5614622812f47-44f95e93ac6mr6027362b6e.25.1762193459096; Mon, 03 Nov 2025
 10:10:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103084244.2654432-1-lihuisong@huawei.com> <20251103084244.2654432-6-lihuisong@huawei.com>
In-Reply-To: <20251103084244.2654432-6-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 3 Nov 2025 19:10:48 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ifcuqF7=+NowYOfPbKfGq5XCe4+mg_9Sv8gRHyMZ0gNQ@mail.gmail.com>
X-Gm-Features: AWmQ_bkRcMul9OXlVST-nV0lHS9Uqs3aBiK8rz7lypqaN1KzWZulxPX6I3uuvhg
Message-ID: <CAJZ5v0ifcuqF7=+NowYOfPbKfGq5XCe4+mg_9Sv8gRHyMZ0gNQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] ACPI: processor: idle: Remove useless codes about
 the verification of cstate count
To: Huisong Li <lihuisong@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sudeep.Holla@arm.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 9:42=E2=80=AFAM Huisong Li <lihuisong@huawei.com> wr=
ote:
>
> The acpi_processor_setup_cstates and acpi_processor_setup_cpuidle_cx will
> be called after successfully obtaining the power information. These setup
> functions have their own main role, but also verify the validity of cstat=
e
> count.
>
> Actually, the acpi_processor_get_power_info_cst will return failure if th=
e
> cstate count is zero and acpi_processor_get_power_info will return failur=
e.
>
> So the verification of cstate count in these functions are useless.
>
> No intentional functional impact.
>
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/acpi/processor_idle.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index 4627b00257e6..1f332f02d273 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -732,8 +732,8 @@ static int __cpuidle acpi_idle_enter_s2idle(struct cp=
uidle_device *dev,
>         return 0;
>  }
>
> -static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
> -                                          struct cpuidle_device *dev)
> +static void acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
> +                                           struct cpuidle_device *dev)
>  {
>         int i, count =3D ACPI_IDLE_STATE_START;
>         struct acpi_processor_cx *cx;
> @@ -753,14 +753,9 @@ static int acpi_processor_setup_cpuidle_cx(struct ac=
pi_processor *pr,
>                 if (count =3D=3D CPUIDLE_STATE_MAX)
>                         break;
>         }
> -
> -       if (!count)
> -               return -EINVAL;
> -
> -       return 0;
>  }
>
> -static int acpi_processor_setup_cstates(struct acpi_processor *pr)
> +static void acpi_processor_setup_cstates(struct acpi_processor *pr)
>  {
>         int i, count;
>         struct acpi_processor_cx *cx;
> @@ -822,11 +817,6 @@ static int acpi_processor_setup_cstates(struct acpi_=
processor *pr)
>         }
>
>         drv->state_count =3D count;
> -
> -       if (!count)
> -               return -EINVAL;
> -
> -       return 0;
>  }
>
>  static inline void acpi_processor_cstate_first_run_checks(void)
> @@ -1248,7 +1238,8 @@ static int acpi_processor_setup_cpuidle_states(stru=
ct acpi_processor *pr)
>         if (pr->flags.has_lpi)
>                 return acpi_processor_setup_lpi_states(pr);
>
> -       return acpi_processor_setup_cstates(pr);
> +       acpi_processor_setup_cstates(pr);
> +       return 0;
>  }
>
>  /**
> @@ -1268,7 +1259,8 @@ static int acpi_processor_setup_cpuidle_dev(struct =
acpi_processor *pr,
>         if (pr->flags.has_lpi)
>                 return 0;
>
> -       return acpi_processor_setup_cpuidle_cx(pr, dev);
> +       acpi_processor_setup_cpuidle_cx(pr, dev);
> +       return 0;
>  }
>
>  static int acpi_processor_get_power_info(struct acpi_processor *pr)
> --

Does this patch depend on the previous patches in the series?  If it
doesn't, why don't you send it independently?

