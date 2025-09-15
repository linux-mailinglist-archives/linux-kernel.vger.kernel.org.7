Return-Path: <linux-kernel+bounces-816600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD07B57615
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 241E71AA2A13
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE00D28C006;
	Mon, 15 Sep 2025 10:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGLssWT4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E781DB546
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757931414; cv=none; b=fltHvsQCa++uFpL+pVATagWs3FbIun5biRsTv+XY/zeExZ5eD9pVf2eTQy20ypnEgQrQgWmydTJX5LbSSyVvVuuSWMPMuBYAQfMUMG5e9eJzouj7MbFPqCwG+H/IymrudMMgmdawtbL883zsYGlSotfrn8ZAQ+lKtccltkSV/kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757931414; c=relaxed/simple;
	bh=ZiVvWIffehN2Q6Px9dVsyvsbdVXJBkYiBFE/Cflc4qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b5rjpmOWnap7M/vnD4WpHApknNfF4xAu43p/ksVVl2VgwqkDBzkw+7lmnL8qBFnhq2k8i/VFnuXlRx4nEh9IdAH4yiggDbc2071j49uHEFHWL7IZMUo482s0SyFoe1RdTh9TTN7J/2rdVtIUoVPzRRY70gNBqud4rCXwarBxA3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGLssWT4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2A3C113D0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757931413;
	bh=ZiVvWIffehN2Q6Px9dVsyvsbdVXJBkYiBFE/Cflc4qk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XGLssWT4/F3bP0ic7ZWfSFozXiC0UkaExsNgal0uoepHOigBRzWgnAoTvoXz/0LyO
	 /Zjxrk5kBeBbdjUwij3JzopT23NGw/+tOpvtmFjNhVj04Q8IRCXqgiJZ/KF5RDYAoj
	 Y7YqM0wtBWGoWPbml+BKqmE0giIHyHtsloTFclzloyju4YJWmXxqg9Sw9GVhL8MK8W
	 aBVCp4ceZqe8dno6VXAA1h/zG0x9eT54wMSuHHH2V7rArbZRuO8si7OvJoSRxNq/zJ
	 yhbDvmxz7O2SvuMDAzfzgUzNNG6MTk9gl8twSQUf53DOGbnh7lNWVCpCt5kX/FfMm1
	 7pdeiZL/k/wsQ==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-753a9c8dabeso962952a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:16:52 -0700 (PDT)
X-Gm-Message-State: AOJu0Yynfbt1oVmKyb0U7ece2PJsk9u7+j6/kw1rjOGxNvLEOVIgoThM
	rQY8Z8Hdf5nZo4CD172QAthNozR6Pf+cZEIqK7zggeenBgvYIid8DxhN/DuDmumai6ZX6x4+3PO
	tXoap/lt7NwB8WzvF4vQ90kZ92r8QcmE=
X-Google-Smtp-Source: AGHT+IHkc9WA1H1RAzKSXflZFNZUb5BQK4FvLF4EHvdkLxrAnXIuGEhgXx7Jom4DNm6HBoQZRGmY5ncRbgMzQeiN+RA=
X-Received: by 2002:a05:6830:65d2:20b0:757:5bc5:3f2f with SMTP id
 46e09a7af769-7575bc544c7mr1998812a34.36.1757931412233; Mon, 15 Sep 2025
 03:16:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915085702.519996-1-maz@kernel.org> <20250915085702.519996-3-maz@kernel.org>
In-Reply-To: <20250915085702.519996-3-maz@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Sep 2025 12:16:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iMQJV6mXS3STN6qkNT+eBpC8wGwOorA=-N8Jt+9dDm4A@mail.gmail.com>
X-Gm-Features: Ac12FXwK7HYdc3TEF2ZC4JVY_CmEo3BbTiV6hYw23p4jbXZLrpzMKN2MNXJ-Jik
Message-ID: <CAJZ5v0iMQJV6mXS3STN6qkNT+eBpC8wGwOorA=-N8Jt+9dDm4A@mail.gmail.com>
Subject: Re: [PATCH v2 02/25] ACPI: irq: Add IRQ affinity reporting interface
To: Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, James Clark <james.clark@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 10:57=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrot=
e:
>
> Plug the irq_populate_fwspec_info() helper into the ACPI layer
> to offer an IRQ affinity reporting function. This is currently
> only supported for the CONFIG_ACPI_GENERIC_GSI configurations,
> but could later be extended to legacy architectures if necessary.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  drivers/acpi/irq.c   | 19 +++++++++++++++++++
>  include/linux/acpi.h |  7 +++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
> index 76a856c32c4d0..d1595156c86a4 100644
> --- a/drivers/acpi/irq.c
> +++ b/drivers/acpi/irq.c
> @@ -300,6 +300,25 @@ int acpi_irq_get(acpi_handle handle, unsigned int in=
dex, struct resource *res)
>  }
>  EXPORT_SYMBOL_GPL(acpi_irq_get);
>
> +const struct cpumask *acpi_irq_get_affinity(acpi_handle handle,
> +                                           unsigned int index)
> +{
> +       struct irq_fwspec_info info;
> +       struct irq_fwspec fwspec;
> +       unsigned long flags;
> +
> +       if (acpi_irq_parse_one(handle, index, &fwspec, &flags))
> +               return NULL;
> +
> +       if (irq_populate_fwspec_info(&fwspec, &info))
> +               return NULL;
> +
> +       if (!(info.flags & IRQ_FWSPEC_INFO_AFFINITY_VALID))
> +               return NULL;
> +
> +       return info.affinity;
> +}
> +
>  /**
>   * acpi_set_irq_model - Setup the GSI irqdomain information
>   * @model: the value assigned to acpi_irq_model
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 1c5bb1e887cd1..c506ae4bacc86 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1509,12 +1509,19 @@ static inline int acpi_parse_spcr(bool enable_ear=
lycon, bool enable_console)
>
>  #if IS_ENABLED(CONFIG_ACPI_GENERIC_GSI)
>  int acpi_irq_get(acpi_handle handle, unsigned int index, struct resource=
 *res);
> +const struct cpumask *acpi_irq_get_affinity(acpi_handle handle,
> +                                           unsigned int index);
>  #else
>  static inline
>  int acpi_irq_get(acpi_handle handle, unsigned int index, struct resource=
 *res)
>  {
>         return -EINVAL;
>  }
> +static inline const struct cpumask *acpi_irq_get_affinity(acpi_handle ha=
ndle,
> +                                                         unsigned int in=
dex)
> +{
> +       return NULL;
> +}
>  #endif
>
>  #ifdef CONFIG_ACPI_LPIT
> --
> 2.39.2
>

