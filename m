Return-Path: <linux-kernel+bounces-863619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C6DBF8511
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CCA00347511
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3921126F2BD;
	Tue, 21 Oct 2025 19:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pf6Sfpm/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B3A26B0BE
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 19:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761076153; cv=none; b=JIURYRxvM44BNnwWhPv6mjEMMBFJCQkqLwjxldN2QohI/SWJ3nIJ/xUiYRcm8vN8BrI5tgtoTNLmuy9i+JuVibBRlSXslAI2ij8/mc3hoXqbSYQheJuoXRbH0C3vfFgyOri13Xp7PmMy/7MnD/IpVXcJrC+UiHIdxztB+kNf9SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761076153; c=relaxed/simple;
	bh=Nymk+VhegVFJqCBDqoCr+/+CwR8rmRcHJjtErx2Jnp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A5oXdGFoX0KIp3YSodNEzrXfv52luEktvQWGMjwKz90IY1pitpE0k8gMDN4H6pAfjL8FuvfqINe+OYXvDSflGpWfe3+Lwa/7MCRDBch7puK4gyxQMKLm/2/shubla7aBjGQLZ8+OHho+Be5BLfbeEvg4axsZlbBbpzLlgJY/ZCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pf6Sfpm/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA55C116B1
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 19:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761076153;
	bh=Nymk+VhegVFJqCBDqoCr+/+CwR8rmRcHJjtErx2Jnp8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Pf6Sfpm/nFwnX+KgkkBNRXxDCxreNz1bNW6KVkApAG1MyEBxu0K+DX5cG3rwcEWCw
	 7vODOy2iUsVnBatdEGAzHVd2NPDL5O/HUM4DMAAO0UW5jC1rBYEWD3eNZRlXc7E1rF
	 M/ZmkrF2XB3eT4Ehj/vJRwxe/K3nT1SCD/vo0Hqdfb5jNlJZdAJTRlZf9w2q+dNOTL
	 9dljsXpTLSEoANW4SxSaQEMAYa3Lhf3ttyW9UqwIc1fs4Ezfxtsa1EL1ay9bZFSmXc
	 AxTpUsyC4Ooz3tNDqd3RrDrUVP9PU2CG5Whh1cFdLexH4N9NCUrn2P3XlC4UwRm1kp
	 i+h4zb29iOCVA==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-443afb2334bso2168063b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:49:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXsQqyeUDl1tIG91kar1hHn1FWA+6sEKUqxzzRXxLUdxD1HEoSgzve4n4qEFPP9wqePQjLS2PWz+c9+Yek=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfQA0HYOyOZYkaFhfasz+Nhh8x0b/sJ7WKW+/IfG6jvkYFigJ/
	1Zy5porW3ApUuOaFr21gy7EpiAVnTVWQNiQjfLvpIKYUWk3DKIMcUEqDuFPLhm/ozsokGHU8X3o
	Cm4uXPmRJ6dHBwgvvKenvsuEPnK2AE2c=
X-Google-Smtp-Source: AGHT+IGB3cTbXskvve7WDx8ING8sV7p9/P1zgRPCqYXexpfcldfpJBfn8oDKRQevxqvK43r0BH46/5JgUXcf9r7/8A8=
X-Received: by 2002:a05:6808:5086:b0:441:8f74:f10 with SMTP id
 5614622812f47-443a30e6210mr8203603b6e.58.1761076152229; Tue, 21 Oct 2025
 12:49:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929093754.3998136-1-lihuisong@huawei.com> <20250929093754.3998136-7-lihuisong@huawei.com>
In-Reply-To: <20250929093754.3998136-7-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 21 Oct 2025 21:49:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jBqPLjK2v7A-8Qd6ERhwz47jP3YCiTHJhD8vAgRHVjcQ@mail.gmail.com>
X-Gm-Features: AS18NWCLxDWuc8JFmVbKZHbKfQkeF5DFL9BTHlIwRqNTYKDQ-dm1DZjJaTKzFfo
Message-ID: <CAJZ5v0jBqPLjK2v7A-8Qd6ERhwz47jP3YCiTHJhD8vAgRHVjcQ@mail.gmail.com>
Subject: Re: [PATCH v1 6/9] ACPI: processor: idle: Do not change power states
 if get power info failed
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
> Driver will update power states when processor power states have been
> changed. To prevent any other abnormal issues, here add the verification
> for the result of getting power information, don't change power states
> and one error log when get power information failed.

But the old states may not be usable any more in that case.

If you want to check the acpi_processor_get_power_info(), it should
disable ACPi idle entirely on failures.

> Fixes: f427e5f1cf75 ("ACPI / processor: Get power info before updating th=
e C-states")
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/acpi/processor_idle.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index b0d6b51ee363..92b231f5d514 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1315,6 +1315,7 @@ int acpi_processor_power_state_has_changed(struct a=
cpi_processor *pr)
>         int cpu;
>         struct acpi_processor *_pr;
>         struct cpuidle_device *dev;
> +       int ret =3D 0;
>
>         if (disabled_by_idle_boot_param())
>                 return 0;
> @@ -1344,16 +1345,20 @@ int acpi_processor_power_state_has_changed(struct=
 acpi_processor *pr)
>                 }
>
>                 /* Populate Updated C-state information */
> -               acpi_processor_get_power_info(pr);
> -               acpi_processor_setup_cpuidle_states(pr);
> +               ret =3D acpi_processor_get_power_info(pr);
> +               if (ret)
> +                       pr_err("Get processor-%u power information failed=
.\n",
> +                              pr->id);
> +               else
> +                       acpi_processor_setup_cpuidle_states(pr);
>
>                 /* Enable all cpuidle devices */
>                 for_each_online_cpu(cpu) {
>                         _pr =3D per_cpu(processors, cpu);
>                         if (!_pr || !_pr->flags.power_setup_done)
>                                 continue;
> -                       acpi_processor_get_power_info(_pr);
> -                       if (_pr->flags.power) {
> +                       ret =3D acpi_processor_get_power_info(_pr);
> +                       if (!ret && _pr->flags.power) {
>                                 dev =3D per_cpu(acpi_cpuidle_device, cpu)=
;
>                                 acpi_processor_setup_cpuidle_dev(_pr, dev=
);
>                                 cpuidle_enable_device(dev);
> @@ -1363,7 +1368,7 @@ int acpi_processor_power_state_has_changed(struct a=
cpi_processor *pr)
>                 cpus_read_unlock();
>         }
>
> -       return 0;
> +       return ret;
>  }
>
>  void acpi_processor_register_idle_driver(void)
> --
> 2.33.0
>

