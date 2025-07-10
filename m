Return-Path: <linux-kernel+bounces-725951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 905C1B005DB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDBB85A2C8A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CF9270568;
	Thu, 10 Jul 2025 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DHUKbCea"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391DD2727E5
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752159330; cv=none; b=oj/kTHcCYrOv4WBv/8fj/h4nvbFQzfJ9pY3/c6YNJzsK8OxRs9FBfLayPzXWDixdL9+BMxGSDz60LZJ/ds34llVn/IP1EVVG7/dYLFwnznHZhQjNG/xscQyVj7Jf8IdkVjfSEtT/xrFS62bjwO3GTB+9//tZdP73e2xKektGu/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752159330; c=relaxed/simple;
	bh=RgZOXcAiaWJ2UESpiY6hcJImCEgHuZweTtoYAmvvpfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=If42J3gJtHezBPWpgp/s1ulOag3H4UzR3OQaeSFV/oLxgv8lFTo5NLg0Ki+pnuULQAnBZc4/PjxZ9dkP9AKnpL7udRNv8LnZQl9cyJDdW86UI+kXLy380jOvuAYqv+6qzxl9k7TaXhlcT+Zo406/ttknwl8gJ2FOIXoRBeQC4Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DHUKbCea; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-711a3dda147so12276887b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752159327; x=1752764127; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nwOZdn2NiDVjIPrABYZCyte+ZpAf7Y1hBgPJVXATIso=;
        b=DHUKbCeaWzngKFD1x7IB2bNDAA8bYEMWY+/noEO2RLYNRiXvAPJ2C/eOnp1xMOVFR8
         DVfLZS1upM1zXONmIoXIvtASUqJ3IjS017mCC7qMJLDvQJaecAL55PaLNNoTcZ2TXOOE
         9kbGvLIuM1xzXa/CQZ1hp2HPIYpn8O0hbtQqgM5D8JeIePIP9E3xdha9XWNmRpf5AH9t
         c0hhQ5CWdKKoBxjIF3OFsv880Z3bnLwuAA/dnhw7IfjGmO+FDEaZVDmhHERSBkSeM/7S
         fiUgxQwL/hwI9rXhuu4bhyD9KteOyxgBQYvHTyUkqPahJ08u6i+baUZIdAQpgFPugGo4
         rqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752159327; x=1752764127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nwOZdn2NiDVjIPrABYZCyte+ZpAf7Y1hBgPJVXATIso=;
        b=My6xwD1h9h1e+jNNSSDEhKT6fyUIPKmRWeiWJ2l2wCi7vrExcY7mrTYMMrXTgnGPL5
         Fw0pEEvQEizIrsYe05/5pIU2Ve9vBwIdt00yGfjpIrfPcjGYuFuoHayOEbk2BKOQduKm
         EzL5uBGFonuxVT7vnAMp5DqKBeMAwkIgtN1sqazQ+TtQfaHEyJn2hs9vWPCpJ69Za8fG
         Q6Q/SxgpZZbe2+8L8GJT5kopXnAxvocT00mv4AYFMidhG003GPnWo9JimoIgNsWAAT9+
         W8ILFYCiiY+UBuC/XyYqdIJRazvcyVgbu0wDwENY/YNhhzp5gD5bacwVE9LFvYlgXFoV
         TIww==
X-Forwarded-Encrypted: i=1; AJvYcCXQSeUBl5S9aMESzYr9tfhO9jzYNTtdMX0067GxNWPc5ua1cwEaxp0MfvgSz3QVx9v1dSyIKFIcfv109eU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbBX0J+miOvUnO++CBG3pLz3HCq1cZzZGeK1fTRqdLUNFVo8oG
	hWmIs4EMa3eHKm4w7xDrvqTUCUf03s8gOpWQcl6R7y/7yUfA5xlnVKARUthYaEhd5/nsRxg/P+E
	h84SYmbia9ix0mx6lxfE3GSj1tLyAvj1arjwsAF0HHw==
X-Gm-Gg: ASbGncsyPuR8DDYyxlXjG/vd6mk5ML3+Hgkfng6k0YJwxpfHVfIMjmsWzzm7eiLJQcm
	mGqwObmlOrc4LZuq+9EeGAYyldIgk04SeBm54xUzhTIXhuk6W0sOb7QAkaO3pzDjVu4zz4wC1JY
	C27STMx8iO6wcYUehsxDZXPjj8q9/1eoIZpSJjrjCcrBM=
X-Google-Smtp-Source: AGHT+IHc5dtpkiZ7u2SN9CrdCVrZBHY9P08NaQD/OycrMWylt76w9oUZCr6FAkSY6jbXyljQzIQ7UX5mkXVQHKZ643o=
X-Received: by 2002:a05:690c:87:b0:70d:ecdd:9bd1 with SMTP id
 00721157ae682-717b198ef8emr101473497b3.24.1752159326962; Thu, 10 Jul 2025
 07:55:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
 <CGME20250710122654eucas1p20f1179a9ff22d562d89252f924d34dae@eucas1p2.samsung.com>
 <20250701114733.636510-22-ulf.hansson@linaro.org> <212a1a56-08a5-48a5-9e98-23de632168d0@samsung.com>
In-Reply-To: <212a1a56-08a5-48a5-9e98-23de632168d0@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 10 Jul 2025 16:54:50 +0200
X-Gm-Features: Ac12FXxhP_ygVu4kvJK5PvHoMEGqfNOT1CdeqATazqx35-lOUW-8uexy7JlAHYk
Message-ID: <CAPDyKFrPOgWW_=ehCjtqAUR97HoLKmgFNO3bRT50-w6A1LgGFw@mail.gmail.com>
Subject: Re: [PATCH v3 21/24] pmdomain: core: Leave powered-on genpds on until late_initcall_sync
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Saravana Kannan <saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Johan Hovold <johan@kernel.org>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Michal Simek <michal.simek@amd.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Hiago De Franco <hiago.franco@toradex.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Jul 2025 at 14:26, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> On 01.07.2025 13:47, Ulf Hansson wrote:
> > Powering-off a genpd that was on during boot, before all of its consumer
> > devices have been probed, is certainly prone to problems.
> >
> > As a step to improve this situation, let's prevent these genpds from being
> > powered-off until genpd_power_off_unused() gets called, which is a
> > late_initcall_sync().
> >
> > Note that, this still doesn't guarantee that all the consumer devices has
> > been probed before we allow to power-off the genpds. Yet, this should be a
> > step in the right direction.
> >
> > Suggested-by: Saravana Kannan <saravanak@google.com>
> > Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Colibri iMX8X
> > Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> # TI AM62A,Xilinx ZynqMP ZCU106
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> This change has a side effect on some Exynos based boards, which have
> display and bootloader is configured to setup a splash screen on it.
> Since today's linux-next, those boards fails to boot, because of the
> IOMMU page fault.

Thanks for reporting, let's try to fix this as soon as possible then.

>
> This happens because the display controller is enabled and configured to
> perform the scanout from the spash-screen buffer until the respective
> driver will reset it in driver probe() function. This however doesn't
> work with IOMMU, which is being probed earlier than the display
> controller driver, what in turn causes IOMMU page fault once the IOMMU
> driver gets attached. This worked before applying this patch, because
> the power domain of display controller was simply turned off early
> effectively reseting the display controller.

I can certainly try to help to find a solution, but I believe I need
some more details of what is happening.

Perhaps you can point me to some relevant DTS file to start with?

>
> This has been discussed a bit recently:
> https://lore.kernel.org/all/544ad69cba52a9b87447e3ac1c7fa8c3@disroot.org/
> and I can add a workaround for this issue in the bootloaders of those
> boards, but this is something that has to be somehow addressed in a
> generic way.

It kind of sounds like there is a missing power-domain not being
described in DT for the IOMMU, but I might have understood the whole
thing wrong.

Let's see if we can work something out in the next few days, otherwise
we need to find another way to let some genpds for these platforms to
opt out from this new behaviour.

Kind regards
Uffe

>
> > ---
> >   drivers/pmdomain/core.c   | 10 ++++++++--
> >   include/linux/pm_domain.h |  1 +
> >   2 files changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> > index 5cef6de60c72..18951ed6295d 100644
> > --- a/drivers/pmdomain/core.c
> > +++ b/drivers/pmdomain/core.c
> > @@ -931,11 +931,12 @@ static void genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
> >        * The domain is already in the "power off" state.
> >        * System suspend is in progress.
> >        * The domain is configured as always on.
> > +      * The domain was on at boot and still need to stay on.
> >        * The domain has a subdomain being powered on.
> >        */
> >       if (!genpd_status_on(genpd) || genpd->prepared_count > 0 ||
> >           genpd_is_always_on(genpd) || genpd_is_rpm_always_on(genpd) ||
> > -         atomic_read(&genpd->sd_count) > 0)
> > +         genpd->stay_on || atomic_read(&genpd->sd_count) > 0)
> >               return;
> >
> >       /*
> > @@ -1346,8 +1347,12 @@ static int __init genpd_power_off_unused(void)
> >       pr_info("genpd: Disabling unused power domains\n");
> >       mutex_lock(&gpd_list_lock);
> >
> > -     list_for_each_entry(genpd, &gpd_list, gpd_list_node)
> > +     list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
> > +             genpd_lock(genpd);
> > +             genpd->stay_on = false;
> > +             genpd_unlock(genpd);
> >               genpd_queue_power_off_work(genpd);
> > +     }
> >
> >       mutex_unlock(&gpd_list_lock);
> >
> > @@ -2352,6 +2357,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
> >       INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
> >       atomic_set(&genpd->sd_count, 0);
> >       genpd->status = is_off ? GENPD_STATE_OFF : GENPD_STATE_ON;
> > +     genpd->stay_on = !is_off;
> >       genpd->sync_state = GENPD_SYNC_STATE_OFF;
> >       genpd->device_count = 0;
> >       genpd->provider = NULL;
> > diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> > index d68e07dadc99..99556589f45e 100644
> > --- a/include/linux/pm_domain.h
> > +++ b/include/linux/pm_domain.h
> > @@ -199,6 +199,7 @@ struct generic_pm_domain {
> >       unsigned int performance_state; /* Aggregated max performance state */
> >       cpumask_var_t cpus;             /* A cpumask of the attached CPUs */
> >       bool synced_poweroff;           /* A consumer needs a synced poweroff */
> > +     bool stay_on;                   /* Stay powered-on during boot. */
> >       enum genpd_sync_state sync_state; /* How sync_state is managed. */
> >       int (*power_off)(struct generic_pm_domain *domain);
> >       int (*power_on)(struct generic_pm_domain *domain);
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>

