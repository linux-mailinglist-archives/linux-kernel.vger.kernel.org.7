Return-Path: <linux-kernel+bounces-867579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29135C0303A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE55B1898922
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA5B27FB32;
	Thu, 23 Oct 2025 18:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DL6YeJYr"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A84225A64C
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244502; cv=none; b=qjGViYMzK5cbUee2AwoHYry7HZpmyrIdG1p9VhnUgb21w1osQmbOG3CDmH9MnzEldVaHcPU4CGYBZzCQN1spWXpzfd2OaqCqh4bfpJM64c+WU7zS44r3WmtXdcNT8XIyiXAx1y6C0miOxvGPnSOFX4eiHIGH4q5RretMlOuTq20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244502; c=relaxed/simple;
	bh=SPUax74LgvfnS22qRNjdPzNnSFPqKgRwa5WTYIXEV2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1xwlRXCOXP9lxz+9JAO7BKKKgpk1ExciL/FuIRnKt3KqUgzjMq7HwNu754fd+EI2nP1EnDbGqU/a+5/bYACJfriZdDVTcCK3Qx4EWPS5+JCiFcn/i2kaBAOXZm4t3GLsm2WOKZVxMiMWYLQ9f3m4Rj6O4h6UMAg98CNWw3UmTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DL6YeJYr; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b6ceba7c97eso1058179a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761244500; x=1761849300; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6nuoMJ97qtbUY/Trjdlag2VQw68geuw/k2BTI9Rt2oo=;
        b=DL6YeJYr1kW5Rw3mb09Im2XHQ1NT+I54WfNmAWU2wSUJthMFfrGpCyhRQG5sXFJxWw
         OEUOstKm0pBBLhF3ON0szIvJfwwGKUuGqEJbAUgcowty/wWqUKL4VaCuvsiMoEJSSyLI
         5LBDlEArecCTcXScf74+1yQwJvf3Yj+rs0ET8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761244500; x=1761849300;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6nuoMJ97qtbUY/Trjdlag2VQw68geuw/k2BTI9Rt2oo=;
        b=Vceuz52Kt3D4ZfE2J+EtxP2VozkejlIVvW16pzrHGjQYutxeUP2MVioXv9ODk//grl
         jQ/Jv0HClumOcXHNaLmfjn8TrPoFVFWx7Q0NqShN/s8hUS+1QIEGTfNmU/9iLrPXq2WQ
         3gfjMnFI4ZNd9lZbbZbS28iMIHOnc8PYTKQReRLIFDcc8W4EuJ+NTrbpLnBEL/xm9QY+
         ah/W1ncLKIi36cZYy9bH1DwAEvDlNRgiFGnnKdATJsjJ2aaiMdOOtZA3RCTb04chFV0P
         6u+Ykqk46fxd/ym2PvHQbHU/shKVXhQQhAFY7rzB1So6jacuXPE9nGh2M517Df3taXxE
         2GhA==
X-Forwarded-Encrypted: i=1; AJvYcCVbLQWXM8mhSqfokLUMZ82WqKoW7/sqR6gZIe+8r95DP+u9y9dDaGCghwSwFnT9+H0WtVhleTOPIWlOx3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpMrku6FEDu777AKGEkxSIOXo6QE1znchkfte92c5qlgVh7tQO
	J3+9XDsro/fpA62XDAUq+7Tfy4uiFiaf17BAnCop/igm0umOV1LBzZqbYiuLPlZEVw==
X-Gm-Gg: ASbGncs2M88JuHKdEdikBtSdT3A94hjwRG8BLcb/grfsMvqAJZk4Lcb2WW7XC3u7dHB
	vZdPMUMNei3WJTdNH38dPY2dGpI7c7TTkkas+ENAwC63qyFf+V3wkMNgfC2MnuB/dukjm4EB1TA
	9TjqbBNkiJpzZ6O76yWPEDmw7oyUNgg1UZpf/qy9KT66lpJ68N2PhRS+QWJU945X//mPhGBT283
	a+bkpgVYpcm2sr4fCxInsPpP0EthidwZEFsnb8bMSJy0vuLx0MBuZ/3tptzaeuOrvcCe91hfJZG
	7xkzpoBC4g4pFf24mQUPHKYmU+jAAeQvrmed87mSA8mSTYfuESx30I9dul/NItYSbTPrXDBvHDH
	AER/CC1pnzOIQBq0c2d56zplj9bCcIdHU4cYPxll4Kjqg0TWItrD9S/mjS7QqV4arAidNJ3BdwX
	eA7d9OdAQrtfkAGpQTOVnFIh6MCFe+WvhIRM9tHfGPXJJUs1A1
X-Google-Smtp-Source: AGHT+IF9nl11vVtaakhDyS6lQfmP3vdzYGTg2RcSslOSdH+UpIhSi4MDwaT7++gY/SFq1hZJySLLIg==
X-Received: by 2002:a17:903:2b06:b0:25c:b543:2da7 with SMTP id d9443c01a7336-290c9c93a96mr296576605ad.9.1761244499572;
        Thu, 23 Oct 2025 11:34:59 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:839c:d3ee:bea4:1b90])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2946e2578desm30119195ad.106.2025.10.23.11.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 11:34:59 -0700 (PDT)
Date: Thu, 23 Oct 2025 11:34:57 -0700
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v3] PCI/PM: Prevent runtime suspend before devices are
 fully initialized
Message-ID: <aPp1UWdc2rmafZr-@google.com>
References: <20251022141434.v3.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
 <CAJZ5v0ieBdfuu_OF5YQsgsgy_L3H-UkVvn+kk45UFDfJSBtj0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0ieBdfuu_OF5YQsgsgy_L3H-UkVvn+kk45UFDfJSBtj0g@mail.gmail.com>

On Thu, Oct 23, 2025 at 11:41:38AM +0200, Rafael J. Wysocki wrote:
> On Wed, Oct 22, 2025 at 11:15 PM Brian Norris <briannorris@chromium.org> wrote:
> >
> > Today, it's possible for a PCI device to be created and
> > runtime-suspended before it is fully initialized. When that happens, the
> > device will remain in D0, but the suspend process may save an
> > intermediate version of that device's state -- for example, without
> > appropriate BAR configuration. When the device later resumes, we'll
> > restore invalid PCI state and the device may not function.
> >
> > Prevent runtime suspend for PCI devices by deferring pm_runtime_enable()
> > until we've fully initialized the device.
> >
> > More details on how exactly this may occur:
> >
> > 1. PCI device is created by pci_scan_slot() or similar
> > 2. As part of pci_scan_slot(), pci_pm_init() enables runtime PM; the
> >    device starts "active" and we initially prevent (pm_runtime_forbid())
> >    suspend -- but see [*] footnote
> > 3. Underlying 'struct device' is added to the system (device_add());
> >    runtime PM can now be configured by user space
> > 4. PCI device receives BAR configuration
> >    (pci_assign_unassigned_bus_resources(), etc.)
> > 5. PCI device is added to the system in pci_bus_add_device()
> >
> > The device may potentially suspend between #3 and #4.
> >
> > [*] By default, pm_runtime_forbid() prevents suspending a device; but by
> > design [**], this can be overridden by user space policy via
> >
> >   echo auto > /sys/bus/pci/devices/.../power/control
> >
> > Thus, the above #3/#4 sequence is racy with user space (udev or
> > similar).
> >
> > Notably, many PCI devices are enumerated at subsys_initcall time and so
> > will not race with user space. However, there are several scenarios
> > where PCI devices are created later on, such as with hotplug or when
> > drivers (pwrctrl or controller drivers) are built as modules.
> >
> > [**] The relationship between pm_runtime_forbid(), pm_runtime_allow(),
> > /sys/.../power/control, and the runtime PM usage counter can be subtle.
> > It appears that the intention of pm_runtime_forbid() /
> > pm_runtime_allow() is twofold:
> >
> > 1. Allow the user to disable runtime_pm (force device to always be
> >    powered on) through sysfs.
> > 2. Allow the driver to start with runtime_pm disabled (device forced
> >    on) and user space could later enable runtime_pm.
> >
> > This conclusion comes from reading `Documentation/power/runtime_pm.rst`,
> > specifically the section starting "The user space can effectively
> > disallow".
> >
> > This means that while pm_runtime_forbid() does technically increase the
> > runtime PM usage counter, this usage counter is not a guarantee of
> > functional correctness, because sysfs can decrease that count again.
> >
> > Link: https://lore.kernel.org/all/20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid/
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > Cc: <stable@vger.kernel.org>
> > Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> > ---
> >
> > Changes in v3:
> >  * Add Link to initial discussion
> >  * Add Rafael's Reviewed-by
> >  * Add lengthier footnotes about forbid vs allow vs sysfs
> >
> > Changes in v2:
> >  * Update CC list
> >  * Rework problem description
> >  * Update solution: defer pm_runtime_enable(), instead of trying to
> >    get()/put()
> >
> >  drivers/pci/bus.c | 3 +++
> >  drivers/pci/pci.c | 1 -
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > index f26aec6ff588..fc66b6cb3a54 100644
> > --- a/drivers/pci/bus.c
> > +++ b/drivers/pci/bus.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/of.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> >  #include <linux/proc_fs.h>
> >  #include <linux/slab.h>
> >
> > @@ -375,6 +376,8 @@ void pci_bus_add_device(struct pci_dev *dev)
> >                 put_device(&pdev->dev);
> >         }
> >
> > +       pm_runtime_enable(&dev->dev);
> > +
> >         if (!dn || of_device_is_available(dn))
> >                 pci_dev_allow_binding(dev);
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index b14dd064006c..f792164fa297 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -3226,7 +3226,6 @@ void pci_pm_init(struct pci_dev *dev)
> >         pci_pm_power_up_and_verify_state(dev);
> >         pm_runtime_forbid(&dev->dev);
> >         pm_runtime_set_active(&dev->dev);
> 
> Actually, I think that the two statements above can be moved too.
> 
> The pm_runtime_forbid() call doesn't matter until runtime PM is
> enabled and it is better to do pm_runtime_set_active() right before
> enabling runtime PM.

Ehh, sure, I can do that I suppose. That signs me up for fixing some
excessive Documentation/ that spells out exactly what goes on in
pci_pm_init() for some reason, but I can do that too :)

Brian

> > -       pm_runtime_enable(&dev->dev);
> >  }
> >
> >  static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
> > --

