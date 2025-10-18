Return-Path: <linux-kernel+bounces-859158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E2DBECE9C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 13:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AE0A19C4FC4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 11:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1766B1ADC7E;
	Sat, 18 Oct 2025 11:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xz60DgMY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4C71EB9E1
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760786851; cv=none; b=LPzrDp9/xwcii8ycCH+F2HsbooVx2krX5RI51a/e138ahXScQd3XRsuONZUvSCQ+NdlbckvQehRsddbBQVueL1tNnLsa5m5Qi/LBwI9ViA58sfdjhE9dLEQJa414VBaRZOtLKjwObH8ob8vJI19cef+NxMlTaARWT9QuAMcDPiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760786851; c=relaxed/simple;
	bh=gf3HoOxKt4m1NqIGatZeeHhS1uuAWLXIJ3lR3WwC8o4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ui6gB9FO/6yuwKnWZ52qNm2gxheyUk+8ClUumilBUeHNVLgtfzgVljZ0qZKfziK0THIkaUNcNVPtnihh+ICpuQ6fEgdP4ksjmnKGQMHuZnGWCGlmaz+iwXsDX33oA78Ri3gKiIH0wLMtrzsGcu/M6Xgm9mXD8R23mPoYfuCcGL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xz60DgMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07775C19421
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 11:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760786851;
	bh=gf3HoOxKt4m1NqIGatZeeHhS1uuAWLXIJ3lR3WwC8o4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xz60DgMYd73n//dk1vGHAOomRDj84nYu8gPFNrzM1S4rJu/z4l1hAy+yCj5p1rnJB
	 fsO/1nw9Ii8cD0gsgUEHlQxYZuth9Atjqr+bxr1MhkeUFNDXZz/on6S/g74FRogMaw
	 D1wESx1cces56hnh4z/9GuSeWzze2Yr6750Gjx+GViEN54bqLldMbiDTksIxl0gIYW
	 T4u0V6YiJQ3taLJOl6dnlaR707VTqcuR6roLRjOD8qL0tINKJv2RB4cf2fkIfK0Sl1
	 ldjBmk+EJuVDqgoKNWkQC50KtwKEDE5B2lCP6LdbQOjuhRTtByzP5mPrgs0cFaO1P/
	 MOhKuOsoJD+3w==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-65051376edbso708065eaf.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 04:27:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFJFE+W053XXyYEr1AG+gPqx/tXta4y0dR/66gdD5RHbvc/286yQ7iVdc6Oh7SK6Gb7mioED0jzCPdMcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFgM3o0hCIxLe50zw3OdLia7599fvP30kGQGdALqksMm9GcTE7
	oTMEspIR+fGnQNIUG+Cfhh5QOaeEfixmBaD1vLn+ch/OEzIPbYCdC27PDn6lFN3tg1dOyAcj0ZO
	L7kTOVJvxaz1LMX2iNmRlwNYrzUZw374=
X-Google-Smtp-Source: AGHT+IEqtAjX7bGgXFLTiXHINPUgRACxPa5e5SbtFa0/3L8xX27Do+XIrKmU1uLH+LDyENKH88LxrEs2OHkNKCwG2EE=
X-Received: by 2002:a05:6808:1a16:b0:43d:43a5:ccaf with SMTP id
 5614622812f47-443a2fb214amr2650331b6e.43.1760786850233; Sat, 18 Oct 2025
 04:27:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017122123.v2.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
In-Reply-To: <20251017122123.v2.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 18 Oct 2025 13:27:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ie0Jz6AJdZJx2jNSRcqRQOqMCF+gYdgemTs=rKwXD1_g@mail.gmail.com>
X-Gm-Features: AS18NWD6bHTd_vUF_qBtVIKT5NWPoUwfrydYcGt_jLLmqKDaZufr6wiJXQu2i5E
Message-ID: <CAJZ5v0ie0Jz6AJdZJx2jNSRcqRQOqMCF+gYdgemTs=rKwXD1_g@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/PM: Prevent runtime suspend before devices are
 fully initialized
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pm@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 9:22=E2=80=AFPM Brian Norris <briannorris@chromium.=
org> wrote:
>
> Today, it's possible for a PCI device to be created and
> runtime-suspended before it is fully initialized. When that happens, the
> device will remain in D0, but the suspend process may save an
> intermediate version of that device's state -- for example, without
> appropriate BAR configuration. When the device later resumes, we'll
> restore invalid PCI state and the device may not function.
>
> Prevent runtime suspend for PCI devices by deferring pm_runtime_enable()
> until we've fully initialized the device.
>
> More details on how exactly this may occur:
>
> 1. PCI device is created by pci_scan_slot() or similar
> 2. As part of pci_scan_slot(), pci_pm_init() enables runtime PM; the
>    device starts "active" and we initially prevent (pm_runtime_forbid())
>    suspend -- but see [*] footnote
> 3. Underlying 'struct device' is added to the system (device_add());
>    runtime PM can now be configured by user space
> 4. PCI device receives BAR configuration
>    (pci_assign_unassigned_bus_resources(), etc.)
> 5. PCI device is added to the system in pci_bus_add_device()
>
> The device may potentially suspend between #3 and #4.
>
> [*] By default, pm_runtime_forbid() prevents suspending a device; but by
> design, this can be overridden by user space policy via
>
>   echo auto > /sys/bus/pci/devices/.../power/control
>
> Thus, the above #3/#4 sequence is racy with user space (udev or
> similar).
>
> Notably, many PCI devices are enumerated at subsys_initcall time and so
> will not race with user space. However, there are several scenarios
> where PCI devices are created later on, such as with hotplug or when
> drivers (pwrctrl or controller drivers) are built as modules.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Cc: <stable@vger.kernel.org>

Can you please add a Link: pointer to the discussion on the previous
version of the patch?

With that

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>
> Changes in v2:
>  * Update CC list
>  * Rework problem description
>  * Update solution: defer pm_runtime_enable(), instead of trying to
>    get()/put()
>
>  drivers/pci/bus.c | 3 +++
>  drivers/pci/pci.c | 1 -
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index f26aec6ff588..fc66b6cb3a54 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -14,6 +14,7 @@
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/proc_fs.h>
>  #include <linux/slab.h>
>
> @@ -375,6 +376,8 @@ void pci_bus_add_device(struct pci_dev *dev)
>                 put_device(&pdev->dev);
>         }
>
> +       pm_runtime_enable(&dev->dev);
> +
>         if (!dn || of_device_is_available(dn))
>                 pci_dev_allow_binding(dev);
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b14dd064006c..f792164fa297 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3226,7 +3226,6 @@ void pci_pm_init(struct pci_dev *dev)
>         pci_pm_power_up_and_verify_state(dev);
>         pm_runtime_forbid(&dev->dev);
>         pm_runtime_set_active(&dev->dev);
> -       pm_runtime_enable(&dev->dev);
>  }
>
>  static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
> --
> 2.51.0.858.gf9c4a03a3a-goog
>

