Return-Path: <linux-kernel+bounces-829007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F36FB96070
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F81F2E6208
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E59327A17;
	Tue, 23 Sep 2025 13:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haDKboVi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7941E327A0D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758634497; cv=none; b=HJFTuH3umN1AKiiarGQKbvZ9XM0UCBWXpK+u+BSq5FpVlXpTOORxel3d2id+uVCs2Sp/A/K0fhCBXZHhj4aShAFMv4X0NQYn/zGcJzPubJrXYRqw7orfAINsy46VDt62zGgrr5S9yh4UrleaTIyG8oUn3jFv9GAXnW8uo2p/CAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758634497; c=relaxed/simple;
	bh=yaSeglKsElepTyoAoMoD/IiNdFrvm+hJDv+AkZ6gx0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mEE3IIdCIoTAmpD/oKlUlFwNvdcH6jxRoq5jNOEHW63ij81/2ghaxXy15ndiFn/3ts1/uErr+ige3I/c0VQ2Xq5dzRxHlSa6Wvx6h4/8SbVDLJe8IyvCLWYMxUYveNcY9ykcD+Ffyf0IozFhwOl6/VFj9Rs8B23gnRDHvBq4I8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haDKboVi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D08C19421
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758634497;
	bh=yaSeglKsElepTyoAoMoD/IiNdFrvm+hJDv+AkZ6gx0U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=haDKboViXsLUD1P553cbLhLCJ6thUdEJz2VayKcf81MxQDGeNCnXUSKoGmCG1ayB7
	 53H3OVv+7XIQbBgGA11wA+L2k0jgW+StiM7TNVpMzorBbKnREwClyZWLyWhV12EixU
	 VQEW37rgMkzVciIx7QZWmh0PjS6H7aLgA2v6hSPOxyfuFIJimyaYF42rI6P1zjZ3LF
	 gcabKK/5FO7dZKD1McX16tMmeY63BQF9CSsqDiY6xpwmqLIJ097VN5a4E/XjbMwHWh
	 PgRwfRqSdc9qoRknTyRDajfqHdzq08R472vCn7AC1UaX9OHNCL0jZjfcCrggG9cZta
	 MIzHA9m5vDESw==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-621a79a580bso1349182eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:34:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUl7bFlCeELWo4SAbKr7/y7JK+TYfw0tv8YXs5YNZGVSMWGlmLO6HFYbKUJ8k2/cVHoNSRcpTICGvE7Iz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOjM0oqzw87GTAIRagDCd6xbAv7B0HmwY7QVG/9pys/fcNjLHc
	kHYeKtp7YZUfWn79uA1C31rt11Ijl573nIi60EZ+L4yJPq6NtW00+asjOLldCzBQTbPLZirwyC3
	lvSxeMybYIf+HBhvnvliEHuEoisKGQlc=
X-Google-Smtp-Source: AGHT+IHPi0UXO9bDN41DG2+C7j9zxUDGwvXu4aKfSI/XsvLjnfvBnYH1tfJR0DPxBO2+UzIeFqhPPxSw0NKu+MGuZ08=
X-Received: by 2002:a05:6820:221d:b0:632:d187:c4c5 with SMTP id
 006d021491bc7-6330681441amr1251863eaf.2.1758634496244; Tue, 23 Sep 2025
 06:34:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923032428.2656329-1-lihuisong@huawei.com> <20250923032428.2656329-2-lihuisong@huawei.com>
In-Reply-To: <20250923032428.2656329-2-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Sep 2025 15:34:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jrWJqX7ompc_EBQk_dt87KAQ7=Oo+O0cq9S3a+LrVVsw@mail.gmail.com>
X-Gm-Features: AS18NWArHn05vJope0LFo1m1M2fhJ_p27bYv7krs4J7-ycruZM5NS106JbIKutA
Message-ID: <CAJZ5v0jrWJqX7ompc_EBQk_dt87KAQ7=Oo+O0cq9S3a+LrVVsw@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] ACPI: processor: Do not expose the global
 acpi_idle_driver variable
To: Huisong Li <lihuisong@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 5:24=E2=80=AFAM Huisong Li <lihuisong@huawei.com> w=
rote:
>
> Currently, processor_driver just use the global acpi_idle_driver variable
> to check if the cpuidle driver is acpi_idle_driver. Actually, there is no
> need to expose this global variable defined in processor_idle.c to outsid=
e.
> So move the related check to acpi_processor_power_init() and limit the
> global variable to a static one.
>
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/acpi/processor_driver.c | 3 +--
>  drivers/acpi/processor_idle.c   | 9 ++++++++-
>  include/acpi/processor.h        | 1 -
>  3 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_dri=
ver.c
> index de17c1412678..5d824435b26b 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -166,8 +166,7 @@ static int __acpi_processor_start(struct acpi_device =
*device)
>         if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
>                 dev_dbg(&device->dev, "CPPC data invalid or not present\n=
");
>
> -       if (cpuidle_get_driver() =3D=3D &acpi_idle_driver)
> -               acpi_processor_power_init(pr);
> +       acpi_processor_power_init(pr);
>
>         acpi_pss_perf_init(pr);
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index 698d14c19587..935ff2aa6f3a 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -51,7 +51,7 @@ module_param(latency_factor, uint, 0644);
>
>  static DEFINE_PER_CPU(struct cpuidle_device *, acpi_cpuidle_device);
>
> -struct cpuidle_driver acpi_idle_driver =3D {
> +static struct cpuidle_driver acpi_idle_driver =3D {
>         .name =3D         "acpi_idle",
>         .owner =3D        THIS_MODULE,
>  };
> @@ -1404,6 +1404,13 @@ void acpi_processor_power_init(struct acpi_process=
or *pr)
>  {
>         struct cpuidle_device *dev;
>
> +       /*
> +        * The code below only works if the current cpuidle driver is
> +        * acpi_idle_driver.
> +        */
> +       if (cpuidle_get_driver() !=3D &acpi_idle_driver)
> +               return;
> +
>         if (disabled_by_idle_boot_param())
>                 return;
>
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index 24fdaa3c2899..7146a8e9e9c2 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -417,7 +417,6 @@ static inline void acpi_processor_throttling_init(voi=
d) {}
>  #endif /* CONFIG_ACPI_CPU_FREQ_PSS */
>
>  /* in processor_idle.c */
> -extern struct cpuidle_driver acpi_idle_driver;
>  #ifdef CONFIG_ACPI_PROCESSOR_IDLE
>  void acpi_processor_power_init(struct acpi_processor *pr);
>  void acpi_processor_power_exit(struct acpi_processor *pr);
> --

Applied with a few tweaks as 6.18 material, thanks!

