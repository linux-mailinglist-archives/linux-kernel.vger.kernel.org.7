Return-Path: <linux-kernel+bounces-862916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B118BF6844
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A4719A3BC0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8516E333432;
	Tue, 21 Oct 2025 12:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iu0n0IjZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FCA3328E0
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761050713; cv=none; b=nWTSKSaNxHr7lA/LUKBRScWd2p/PE+Jnp3u9BXnhgVUd0K4onYvLg30tjTF2KM0E3Sd9f1LDCOyFYIie35cKu31yo8aXpYMXluf5rot3L+999uBQdVHfnaJgwHvCwN4p40znwN+8rA9wb3KuiAQacTl5r9gRbdq/IbvbdHVshO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761050713; c=relaxed/simple;
	bh=fNqD+B6s469Yj7Uuf2+D0qytTYH3QsTqcGglEXhywPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=be7Z9J8hq25TatgBzPQLvURt1v6fZSzNRsLHcDKVONCCsCqJ8Isj2vSGKz/1o+fdaaBrb+xyGPBOXMPCzKIAWVSFaJplP2xihGLRuCANa6pXfv239GF8MvKXNQUa6eFe2wiE0eVlHvJBMVvsJjUkhPQRblE76ACPy985PURiL6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iu0n0IjZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D34C4CEF1
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761050713;
	bh=fNqD+B6s469Yj7Uuf2+D0qytTYH3QsTqcGglEXhywPQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Iu0n0IjZdJ1BkmkUfib/wrwtDaZ6xxHsH/c9fcxkTJjMAdwzqS98vY2XcO/fnDlZp
	 w3jJfmFgk+1Px+pty5cxR0VQczTngpA2iuD22WeZm98XvhzSCPuJYTXDbFuJXUXUM1
	 sdws1JBJcySlRx3SqYvtwrpL2rqFaHzXDCzooFesdHaB6NNtPefPtIfdsfGMwupJrC
	 3u0Uk0umvEPeP/Ei35P/BRrFymRIDy/uNLraeQX2nAxGbHlG+0kNp4HFW7jLoM28ec
	 kAoRz8OcCUravdQt/zI4VWy0/VrLeTWbg+xWB7UesTOpYB4aRKhD/L05DtyCkprZFy
	 aBVoJ4agTixUA==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-651c743b2d9so2465948eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:45:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQLJm+nboqaglUC+JQ1rIY4kJL1TpIRZm3KlMUPZwa11bPAVqS/jMYmSJ3fe2VFHU49BkyRnqXcANU+4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5wv8keFPtKLEfAPzty++YBME+k2tsASaaGri+hegtNZTmzZuf
	AhdDNhZhk7pmlKw/zS4FQIORVBzLDvaGZBzberFYkoVDyTZhTggmpjYMLtn8qhFpcJWX24zjDa0
	YHlok/1qjSyf0WaItRU+A2keMNceWiCY=
X-Google-Smtp-Source: AGHT+IH6obx8zcmEauqGoNYLVkeBLUIIr0ww8RYLI2qsmTsgyzzB7QT2RsZlbIpSX2hhGlD1fpjflbZtgs/poJLEHoA=
X-Received: by 2002:a05:6808:1383:b0:43f:5b28:f0a6 with SMTP id
 5614622812f47-443a2ee46d2mr7050078b6e.1.1761050712765; Tue, 21 Oct 2025
 05:45:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6196611.lOV4Wx5bFT@rafael.j.wysocki> <2323750.iZASKD2KPV@rafael.j.wysocki>
 <25435d82-575d-495f-ae61-bd38570ff9ad@linux.ibm.com>
In-Reply-To: <25435d82-575d-495f-ae61-bd38570ff9ad@linux.ibm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 21 Oct 2025 14:44:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iC-Lz59iu+5Ps-T9W5Ow__pm_0-txF2mDERypPFQYFsw@mail.gmail.com>
X-Gm-Features: AS18NWBovxp0gk85Y0l34CMY9sPShK1oLNJ-hGiHVklLTkmzTqdfgdStD1r2e9w
Message-ID: <CAJZ5v0iC-Lz59iu+5Ps-T9W5Ow__pm_0-txF2mDERypPFQYFsw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] PCI/sysfs: Use runtime PM guard macro for auto-cleanup
To: Farhan Ali <alifm@linux.ibm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, Alex Williamson <alex.williamson@redhat.com>, 
	Zhang Qilong <zhangqilong3@huawei.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Frank Li <Frank.Li@nxp.com>, Dhruva Gole <d-gole@ti.com>, 
	Niklas Schnelle <schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 12:07=E2=80=AFAM Farhan Ali <alifm@linux.ibm.com> w=
rote:
>
>
> On 9/26/2025 9:24 AM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Use the newly introduced pm_runtime_active_try guard to simplify
> > the code and add the proper error handling for PM runtime resume
> > errors.
> >
> > Based on an earlier patch from Takashi Iwai <tiwai@suse.de> [1].
> >
> > Link: https://patch.msgid.link/20250919163147.4743-3-tiwai@suse.de [1]
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v3 -> v4:
> >     * Use ACQUIRE()/ACQUIRE_ERR() (Jonathan)
> >     * Adjust subject and changelog
> >     * Take patch ownership (it's all different now)
> >     * Pick up Bjorn's ACK from v3 (Bjorn, please let me know if that's =
not OK)
> >
> > v2 -> v3: No changes
> >
> > v1 -> v2:
> >     * Adjust the name of the class to handle the disabled runtime PM ca=
se
> >       transparently (like the original code).
> >
> > ---
> >   drivers/pci/pci-sysfs.c |    5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -1475,8 +1475,9 @@ static ssize_t reset_method_store(struct
> >               return count;
> >       }
> >
> > -     pm_runtime_get_sync(dev);
> > -     struct device *pmdev __free(pm_runtime_put) =3D dev;
> > +     ACQUIRE(pm_runtime_active_try, pm)(dev);
> > +     if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
> > +             return -ENXIO;
> >
> >       if (sysfs_streq(buf, "default")) {
> >               pci_init_reset_methods(pdev);
> >
> >
> Hi Rafael,
>
> This patch breaks updating the 'reset_method' sysfs file on s390. If we
> try to update the reset_method, we are hitting the ENXIO error. eg:
>
> echo 'bus' > /sys/bus/pci/devices/0007\:00\:10.1/reset_method
> -bash: echo: write error: No such device or address
>
> I don't think s390 does anything different in this path, so this could
> also impact other platforms? Changing this to something like this fixes i=
t
>
>
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 9d6f74bd95f8..d7fc0dc81c30 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1517,8 +1517,8 @@ static ssize_t reset_method_store(struct device *de=
v,
>                  return count;
>          }
>
> -       ACQUIRE(pm_runtime_active_try, pm)(dev);
> -       if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
> +       ACQUIRE(pm_runtime_active, pm)(dev);
> +       if (ACQUIRE_ERR(pm_runtime_active, &pm))
>                  return -ENXIO;
>
> This changes the logic to what it was previously which used
> pm_runtime_get_sync and pm_runtime_put. But I am not familiar with the
> PM runtime code, so not sure what would be the right fix here.

Can you please check if this helps:

https://lore.kernel.org/linux-pm/5943878.DvuYhMxLoT@rafael.j.wysocki/

