Return-Path: <linux-kernel+bounces-863595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EA32FBF8439
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9708934CDF7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4989350A15;
	Tue, 21 Oct 2025 19:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H07EQ1uB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A287350A08
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 19:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761074987; cv=none; b=ZNn3n/wpLZ4c8djvtm44gtWxubg92v5xrnW3KN+Q/LII5MLl40ib3W0J025U5GzVUIBhMSRHBcnhPs+KFtoPQHqwyiJLWeJ2ckk1x1lm/OcK/3iLK/9ExJ74hK93Fw42qttA9io18CboOx8c0/FejmZC8UCfPFf7TbGmIgsKklw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761074987; c=relaxed/simple;
	bh=q6S5GiJ3ywgOj7twAo72P4mY98Q4wcLmhOpJGnE8J5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GUx1SR5gZzwH1ZHROfn9uoBh3RakxpwX2nUDzRCxO3FRVwTZJL4yDa3k3/DwfQ85DxHYz7TYiiJ3TXwJPT0Q04MBWNBzqIAx4S0pKVwVZSjQaplzlrT4uX8pLTrO4r8wZbfRFWTPaHZaHdFK0dKJD2Ztq1yWCb0ArC4zyTmCg28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H07EQ1uB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03FDC116D0
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 19:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761074986;
	bh=q6S5GiJ3ywgOj7twAo72P4mY98Q4wcLmhOpJGnE8J5Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=H07EQ1uBakwyc21Luv0ndliRECXpKz6eU/TzUWRQTWBfqKkOaQLVWtnjaC96+q+9c
	 g2uX/fhiuMsg9LWpKcKcqeZqnTo+vnXbbZI3ULFJ2RBrliau23QI2xuuNcihD3zGta
	 oJXhjYE/CN1UxT+0lIi7tBO3x1R5Lylp8imC/ZEpzTBDHsdDOOEi/s/eLM2WKEX1wF
	 PthGLeXRM01RbExQf+aR8c0QvLErHr4XaYI2M4olIDZmoYiW3ObJHzXNwMGnr9QZBD
	 cn6FchDOK4fWsZ0hcONmEinnFbp/zh0opajZ2rsiLqUVrdussNgM1gTrXyNs3mmT93
	 GS83sWpeVTpUQ==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c280d27ea7so2570717a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:29:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVlL8StDfh7NrXxlSWBnqkCBc0g+NDaBUHd4op+vS0+q0xJyeo8kHLMb5yJsMsEmeOjTCEhb39DD5DL8+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIBszI0S+yly9NX9tWi6+ASF2TfihMdkO7HjvJ/PjA6DGapuYV
	3K28Ia2rVVibwUWa88vcRpOL+GO53acXRperwH2jYdmAOKkA/ajGIajF3qY13Jnh9QfY3QTUrBV
	lv60V4dzeZ00T5c8wHj1qqPlybF7Df5Y=
X-Google-Smtp-Source: AGHT+IG+BXd38cfFtbwMBcXtnTYgyco11g8AQcwu+6YkZOFsgkzGzrySZCcPeVXTuLw+ipHBnNH1pN89EmrHwBDQRBM=
X-Received: by 2002:a05:6808:1b90:b0:43f:713c:a38e with SMTP id
 5614622812f47-443a2f1c1f2mr7744183b6e.30.1761074986190; Tue, 21 Oct 2025
 12:29:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929093754.3998136-1-lihuisong@huawei.com> <20250929093754.3998136-2-lihuisong@huawei.com>
In-Reply-To: <20250929093754.3998136-2-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 21 Oct 2025 21:29:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gFdmFhDxoX8HNHf5h+-L4XV=3TZZx_L1u3H7A=4bEzUA@mail.gmail.com>
X-Gm-Features: AS18NWDua4VJHtGMRpGZS0nFnJsDncwHDR_pT2NhOpfrPbjQhyi9N5-PzPfn04E
Message-ID: <CAJZ5v0gFdmFhDxoX8HNHf5h+-L4XV=3TZZx_L1u3H7A=4bEzUA@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] ACPI: processor: idle: raise up log level when
 evaluate LPI failed
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
> According to ACPI spec, LPI package must be ACPI_TYPE_PACKAGE and
> the count of package must be greater than 4. And the count contained
> in package needs to be equal to the value of count field in LPI package.
> All are illegal and return failure. It is better for these verification
> to use error level log instead of debug so as to get detailed logs direct=
ly
> when initialization fails.
>
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/acpi/processor_idle.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index 22b051b94a86..5acf12a0441f 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -908,7 +908,7 @@ static int acpi_processor_evaluate_lpi(acpi_handle ha=
ndle,
>         /* There must be at least 4 elements =3D 3 elements + 1 package *=
/
>         if (!lpi_data || lpi_data->type !=3D ACPI_TYPE_PACKAGE ||
>             lpi_data->package.count < 4) {
> -               pr_debug("not enough elements in _LPI\n");
> +               pr_err("not enough elements in _LPI\n");
>                 ret =3D -ENODATA;
>                 goto end;
>         }
> @@ -917,7 +917,7 @@ static int acpi_processor_evaluate_lpi(acpi_handle ha=
ndle,
>
>         /* Validate number of power states. */
>         if (pkg_count < 1 || pkg_count !=3D lpi_data->package.count - 3) =
{
> -               pr_debug("count given by _LPI is not valid\n");
> +               pr_err("count given by _LPI is not valid\n");
>                 ret =3D -ENODATA;
>                 goto end;
>         }
> --

They are pr_debug() on purpose because they are not useful to anyone
other than the people who work on _LPI implementations in firmware or
debug firmware issues.  They do not indicate kernel functional issues
in particular.

