Return-Path: <linux-kernel+bounces-883478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 772BAC2D8C3
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB5A3B796D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD67272E63;
	Mon,  3 Nov 2025 17:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuUEjwpU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCE71C5F13
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762192591; cv=none; b=oOtdmSVhfZr+6vI315kHqTp2aArKD71xqoAWw8hXAVrFAFMHZSj2aYVCx3qTrnB6dgeADR2vg+qMNrMuT3kIXpxfhwVNXERsKfgc0tyRIUwcSYLrcU0UEfQ77ievzCYwNPBFSpdq7IFd/9jIxncXU7oj+dMx27FYBM+BhkF4zx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762192591; c=relaxed/simple;
	bh=l0s/CJzMtmoLzoVSGfIFSL/5X8SAB4lNgoi+wbyiuD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SB/WE+PrBxezvUV0CWJtv9IVP3VXew8WG9Z3CuTClwgC/176tGBowTGCwYszv4Cq5uuqvchPdbkk/G8HlJBH68WLkjbYP5H1TWFPIUIBu47q7iOr36OxYHyVZH7VdRjf2iq+FdLIpkOqQa1k6+dRUHmOT8ekgYbBiXXhH7GOs7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuUEjwpU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E488C19422
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762192591;
	bh=l0s/CJzMtmoLzoVSGfIFSL/5X8SAB4lNgoi+wbyiuD4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PuUEjwpUj6KTmX8zPP2FxxqUTKW3ocdCTAPUX2GDB3Pm5L8CAiIGu5lQITa+ZheJ6
	 lb3cC27BdDRKPFp0NH60uvPXbIw8qNFEqb0S84QbkwZBUdBzL/N4L1wG8R+ovEiLcp
	 x+EOpw1clJv1QnoqRHidXeubeQmPckEeYHUOkTSE7jT0j3x5s4rKmCzwxAs4C1VJX4
	 UQX3kHQwXTe3xbBpy6sZ/iwjku3vU1c0hNaC94wDHYvlvoAkM6PvkupKFkjLY4C7MA
	 AOxD2gmbL0kANkzzpC6BQW36Zi5JGZZ/trqGiuZ+zS4oxgsSfSjRTl9W6o9/6krcT9
	 nNd/0oV+1VBDw==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-65366485678so2435730eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 09:56:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXAOEtcVHJuGt4oIK2Y18GYUVNiZ5gfjEUaYSzGocT4tk6AJmDiR2cTmhYdUk1w9Y8tj2KIms2x5m2Q7kc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX0y53Uu0xDZ9SaGy0iSmMh/wWxU43K6Q76vTPkBUv1nVZijDH
	swmJXfTvHuZGDFN6xWIVb4El0/+oBSeDB7nDbdWx7zA4gCsOWgCE9QXvD174KFIhQZJrvpMksTv
	E+uWT8TiwYGfISQsIFNKM+UoB+Vwplpc=
X-Google-Smtp-Source: AGHT+IG1XpHAGy/5KBBueNuAcbnzlZWu5HGHkkiV47kxzW8eScPyC2HT4psXVB4vnVn8p86mEfoBrbB/Zg4EnOlt/u4=
X-Received: by 2002:a4a:ee06:0:b0:654:faee:1065 with SMTP id
 006d021491bc7-6568a6880eemr5591327eaf.5.1762192591000; Mon, 03 Nov 2025
 09:56:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103084244.2654432-1-lihuisong@huawei.com> <20251103084244.2654432-4-lihuisong@huawei.com>
In-Reply-To: <20251103084244.2654432-4-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 3 Nov 2025 18:56:19 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gf=eTuY_CoUDSp94Naj3fxjapc_FWYY+nBjX6qvvM_cg@mail.gmail.com>
X-Gm-Features: AWmQ_bl4pWcIyFRvS5ITzfSUqievi1ub9ILwaETIcFxluyaRt7Ry2Bu4gZ0G68E
Message-ID: <CAJZ5v0gf=eTuY_CoUDSp94Naj3fxjapc_FWYY+nBjX6qvvM_cg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] ACPI: processor: idle: Relocate and verify acpi_processor_ffh_lpi_probe
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
> The platform used LPI need check if the LPI support and the entry
> method is valid by the acpi_processor_ffh_lpi_probe(). But the return
> of acpi_processor_ffh_lpi_probe() in acpi_processor_setup_cpuidle_dev()
> isn't verified by any caller.
>
> What's more, acpi_processor_get_power_info() is a more logical place for
> verifying the validity of FFH LPI than acpi_processor_setup_cpuidle_dev()=
.
> So move acpi_processor_ffh_lpi_probe() from the latter to the former and
> verify its return.
>
> Fixes: a36a7fecfe60 ("ACPI / processor_idle: Add support for Low Power Id=
le(LPI) states")

If you want to add this Fixes: tag, please add some information on
what systems it breaks on and what the symptoms are to the changelog.

> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/acpi/processor_idle.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index 5213a545fa78..c73df5933691 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1266,7 +1266,7 @@ static int acpi_processor_setup_cpuidle_dev(struct =
acpi_processor *pr,
>
>         dev->cpu =3D pr->id;
>         if (pr->flags.has_lpi)
> -               return acpi_processor_ffh_lpi_probe(pr->id);
> +               return 0;
>
>         return acpi_processor_setup_cpuidle_cx(pr, dev);
>  }
> @@ -1277,7 +1277,13 @@ static int acpi_processor_get_power_info(struct ac=
pi_processor *pr)
>
>         ret =3D acpi_processor_get_lpi_info(pr);
>         if (ret)
> -               ret =3D acpi_processor_get_cstate_info(pr);
> +               return acpi_processor_get_cstate_info(pr);
> +
> +       if (pr->flags.has_lpi) {
> +               ret =3D acpi_processor_ffh_lpi_probe(pr->id);
> +               if (ret)
> +                       pr_err("Processor FFH LPI state is invalid.\n");
> +       }
>
>         return ret;
>  }
> --

