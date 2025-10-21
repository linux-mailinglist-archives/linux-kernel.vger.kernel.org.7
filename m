Return-Path: <linux-kernel+bounces-863602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EE4BF8469
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12B6319C1123
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3411350A00;
	Tue, 21 Oct 2025 19:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P89UT1ZC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A049242D6A
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 19:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761075266; cv=none; b=GVwzQrshs1T7h3FTx2mhDyEv/8Ey9FFRFXj33HkfG5O//ruA2wGLuEiCDvou/RDKE2PRVLb1khcVTaKMksX87xhISNduNT0gN2OLjSbDurzt4GIp1Tvw1wuX0XKY79Eehid6AvYgRHYallCJFuy/sJ+u8Ga1o0Pv3Sv3MO/Om7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761075266; c=relaxed/simple;
	bh=V5qBLi3zK77pXgOVJaV6ksMZC32XpEnGEdrJWDwYmY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j9swWUMwrh/i15ixYdY1xmXRgZXUU9b47QVadTU6TMxqrnUpYnoFmEFp9ADC5f7SUSOMRFpPi0rsuJ54zRQpo9ZwhrWP/8uf+Yd5zH/HHBCqogekWtkGoAxA0W6Izb9IeBqOKXV7FsFizbVxXYEBAzhcPf/v8DKFkriQyYGgSvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P89UT1ZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF3BC4AF0B
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 19:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761075265;
	bh=V5qBLi3zK77pXgOVJaV6ksMZC32XpEnGEdrJWDwYmY0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P89UT1ZCRzeTW0VeLj7ijZRnK+wnC8EzhHG9fU98VmqZ0bpkzhSCQFB/6IVZd35W/
	 I2jwIz1yZIiKUG8ShKT+gBSH3BaU03mlRuq3NJWt6zLmndNACRKQOqq6WDpxG3wAaV
	 2rM8aqYOO4lz92Oxf0H0eSm56kXFKKkQ2PiWdM7ew+EweOOJc4jrBFeeU0VtP1Pvrx
	 g3UB95Z+XrsIJjmeZLDiApy9BlA8qdUuQHe1M52+V8To+Y6avEaXDgDMZkPdsCJIBX
	 Xp6BDN88SShFtcKqvBc7kDryfs/b77lPaJM15Ty+HMMU6GYXiIrvedcRcd3pD1okL7
	 m0x5uB3RwiHhQ==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-651d30a5bebso2162256eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:34:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXo9CvXVYtlnZ13gHGBfeXRaGounih1GA/1o2nQ/rGEBnPIvN50cvQNaXVb+AfxKz6YMdSW+u7LEPo27ro=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq7OVfGw53PcA0irvNerSn0kvS6yHrXSD9he4sydXryoTZQflz
	1+MFenJqNIRG5hbFwDZjlOWBpI7Oj27SrYBj3L01m+JPdYvATL+akT3Q6MGuoQ7LvNhK0Lg98/r
	TuHtmPx9pYZPuO2g7nXHFn+mfNemHics=
X-Google-Smtp-Source: AGHT+IEjJ240LLD4aWTURSy3Kpfjl2K/yWW+oTYgs4nkYbRCFKp2r4stFggEJLs+i2X79N/a8vB54125GN5q2x352V0=
X-Received: by 2002:a05:6808:2508:b0:441:8f74:fba with SMTP id
 5614622812f47-443a319b0d4mr8130709b6e.55.1761075265025; Tue, 21 Oct 2025
 12:34:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929093754.3998136-1-lihuisong@huawei.com> <20250929093754.3998136-3-lihuisong@huawei.com>
In-Reply-To: <20250929093754.3998136-3-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 21 Oct 2025 21:34:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ikPpwKA4WLvwon3p+e8+53fOQuudOioOr-KD-Ee-E0dA@mail.gmail.com>
X-Gm-Features: AS18NWDwIWNmRUJAP79s28jwKq8U8tt1PZxDilox8o7Jt0mZ-BpZaOIJ7hov73E
Message-ID: <CAJZ5v0ikPpwKA4WLvwon3p+e8+53fOQuudOioOr-KD-Ee-E0dA@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] ACPI: processor: idle: Return failure if entry
 method is not buffer or integer type
To: Huisong Li <lihuisong@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sudeep.Holla@arm.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 11:38=E2=80=AFAM Huisong Li <lihuisong@huawei.com> =
wrote:
>
> According to ACPI spec, entry method in LPI sub-package must be buffer
> or integer. However, acpi_processor_evaluate_lpi() regeards it as success
> and treat it as an effective LPI state.

Is that the case?  AFAICS, it just gets to the next state in this case
and what's wrong with that?

> This is unreasonable and needs to
> return failure to prevent other problems from occurring.
>
> Fixes: a36a7fecfe60 ("ACPI / processor_idle: Add support for Low Power Id=
le(LPI) states")
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/acpi/processor_idle.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index 5acf12a0441f..681587f2614b 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -958,7 +958,9 @@ static int acpi_processor_evaluate_lpi(acpi_handle ha=
ndle,
>                         lpi_state->entry_method =3D ACPI_CSTATE_INTEGER;
>                         lpi_state->address =3D obj->integer.value;
>                 } else {
> -                       continue;
> +                       pr_err("Entry method in LPI sub-package must be b=
uffer or integer.\n");
> +                       ret =3D -EINVAL;
> +                       goto end;
>                 }
>
>                 /* elements[7,8] skipped for now i.e. Residency/Usage cou=
nter*/
> --

