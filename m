Return-Path: <linux-kernel+bounces-764514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991D8B223F9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEDBE3A9CD9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A799826AEC;
	Tue, 12 Aug 2025 10:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QLSohah8"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ADB2EA49C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754992886; cv=none; b=WXPjuX91kVamhk1wvxHp6tnoaIWOgTdbHpzLptFjMUh1HAnGoe/1oqsQedOUJUePUK3AA+yAEmj9LFSEGo+FwIQTqEh5AyN6Zk1sefVotX03NVDTZVpggSKYCBLJQsqVc1pmTxHcG1uYYgb2YWOOwFJw2+gkp7BUoP/9lDAsnHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754992886; c=relaxed/simple;
	bh=xjG3+Klaa4pUjieq3lq4HgSkgaUslUv7jDB2S7x0DiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jSmf3Ufr5d/VvXwnONm5d3tjve03IcKAlozV4S8Qmf8vsaMzEj0q0V+OxsBRMklqhl9sDpUlseCfhPtKk2ufF9BdhSpXiT+XjWQ5Ezoflio9f6aUsRjoLgk9GOMVvG+9mAbKFCHLqCcAH6Hs4N/lK/GS+IljNxpU/oqB2cQbvnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QLSohah8; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71bd9e38af7so49309997b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754992884; x=1755597684; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wIcDLJkcC/4h4vpD3h9Md+aGM0+RgBKilVDmhk7f1DA=;
        b=QLSohah8Ky9mNdw+CPJp3R8cdBDa3uiZdSyyGhgJ9KytRqGdBulegS2JPOgs+T8cUH
         qAt19979srkQ8KUck8JueaBvCXToyXExLtS2GpFf+W69BiFGcenuuZ5+rFbyotOPm2yj
         OR5CFAXwhtaNRLkdk4xJmZi2n7aww7cE2RTj0LMYaIRzAfmHdwuK2bdi3OQkwva6VFUb
         0JEm6Ad+HR6pbFcb5azC+ta/tJiqppFw+LfqcxoIKfmqxxTSvjpOUz9fe0MdrhI3iOlV
         yNBuYnF8apONE7auf8TGmXWSEJMd6WRky0Xa7v979XYVrOin5rhvs0c4eMhtE5fpXe93
         nveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754992884; x=1755597684;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wIcDLJkcC/4h4vpD3h9Md+aGM0+RgBKilVDmhk7f1DA=;
        b=ML2wSmQOube75dC0OvOYryaGI+/RR5Pd6RzRLIvPR/U9ahnYctrZ8AnSdK/8Lje1d2
         HMQ8dgwsfBYN3yOv3tT3hX97Vd4kzRrK6DPttZWWN73tOvj70+UV9bMP8fLdeYEhJtYc
         AMw6y1cYmcvl1E6rAzqttNAqylPWHqV+ccPboG/TQVtaybmJByc1JzBjd01QrRDk2VBa
         VIPYXqsGS3PJwrbllkKfaUPvSWs/YxAsjjpIriN6mNnmrBSaKA9mYehOjxj2i1n8IQtf
         j7XY28JZiFZXzZPnJSKpRWNVsaYBFx8OEtSAtXmu6H4w4hkl45PAswEm9SAFt+w3NxsZ
         TFjw==
X-Forwarded-Encrypted: i=1; AJvYcCXOx4Gck+8y35zDe+/5ypFYo9z3zb2a9wYAAttF5fM4amB9Rm8sj0I1mH5aI+XyOrx62rLwTKYeJOC8nz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQJk9oeMZarbUwnfYGw3bg095kveyx+MahLhCGchdXoyN+Y5dI
	RwxodhqmB1PWoRDecu+3SPXSB7j7aBe7hwpqqVvDiDzzgZ9XJbt6g8xCw369Hd4qmiKt3H9BCYI
	tnQMPoUjonR/Ft0KR3FkZUu1LBs32BuZ4ZkaNCGmmEg==
X-Gm-Gg: ASbGncvF1v/xkvcvE7HY3SQmqR86THQF5yipX0D0yHHPt14jkeQ2jBdSd3COpQCBVv2
	oqJEBP+hcg0FHUi8aMWqG7zHCHPSXqu5NQZXidoAw+u7+xzv62h6jUNqlXnPOK27cdyUO8cYSEo
	pNgJZrNM3UpxzvvIzB9CGDflr39rrDwaNuhjiDDpPIot4tU9eVn3hGXDrp2RLB8xo0wS2tSxZpT
	gIFKA3t
X-Google-Smtp-Source: AGHT+IH+kgYcIU+KIQofto2+FJUD73uoizAVljhEzlAHBsS06NuOjMp+vsz1mWGXO8RJi58Vv7ybYaDk6l97P7frFRA=
X-Received: by 2002:a05:690c:4b93:b0:71a:34bb:4277 with SMTP id
 00721157ae682-71c429b0643mr35302057b3.18.1754992883651; Tue, 12 Aug 2025
 03:01:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
 <CAPDyKFr=u0u2ijczExkntHK1miWZ6hRrEWBMiyUwShS3m6c29g@mail.gmail.com>
 <CAMuHMdX1BacUfqtmV8g7NpRnY9aTdL=fh+jC7OryMLz4ijaOCg@mail.gmail.com>
 <CAPDyKFqANQZmGXd8ccA5qWiGrCor2N=W_7dmV+OK8hMd_+zmmw@mail.gmail.com> <CAMuHMdVrkr56XsRsbG7H-tLHVzmP+g-7=5Nrv9asC25ismwiYA@mail.gmail.com>
In-Reply-To: <CAMuHMdVrkr56XsRsbG7H-tLHVzmP+g-7=5Nrv9asC25ismwiYA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 12 Aug 2025 12:00:47 +0200
X-Gm-Features: Ac12FXzfiqHB8h5pg7wGWT0OcU-UbYb0hngDXruGLnrHgo3vA-Bxi3AW8WYY6Fk
Message-ID: <CAPDyKFq7z9e9hEC9QWiYcaU=t+Gs_GgRurmK-+cNYp4xkhr5Ow@mail.gmail.com>
Subject: Re: [PATCH v3 00/24] pmdomain: Add generic ->sync_state() support to genpd
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Saravana Kannan <saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Johan Hovold <johan@kernel.org>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Michal Simek <michal.simek@amd.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Hiago De Franco <hiago.franco@toradex.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Aug 2025 at 11:38, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ulf,
>
> On Wed, 30 Jul 2025 at 12:29, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Wed, 30 Jul 2025 at 11:56, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Wed, 9 Jul 2025 at 13:31, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > On Tue, 1 Jul 2025 at 13:47, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > Changes in v3:
> > > > >         - Added a couple of patches to adress problems on some Renesas
> > > > >         platforms. Thanks Geert and Tomi for helping out!
> > > > >         - Adressed a few comments from Saravanna and Konrad.
> > > > >         - Added some tested-by tags.
> > > >
> > > > I decided it was time to give this a try, so I have queued this up for
> > > > v6.17 via the next branch at my pmdomain tree.
> > > >
> > > > If you encounter any issues, please let me know so I can help to fix them.
> > >
> > > Thanks for your series!  Due to holidays, I only managed to test
> > > this very recently.
> > >
> > > Unfortunately I have an issue with unused PM Domains no longer being
> > > disabled on R-Car:
> > >   - On R-Car Gen1/2/3, using rcar-sysc.c, unused PM Domains are never
> > >     disabled.
> > >   - On R-Car Gen4, using rcar-gen4-sysc.c, unused PM Domains are
> > >     sometimes not disabled.
> > >     At first, I noticed the IOMMU driver was not enabled in my config,
> > >     and enabling it did fix the issue.  However, after that I still
> > >     encountered the issue in a different config that does have the
> > >     IOMMU driver enabled...
> > >
> > > FTR, unused PM Domains are still disabled correctly on R/SH-Mobile
> > > (using rmobile-sysc.c) and on BeagleBone Black. Note that these use
> > > of_genpd_add_provider_simple(), while all R-Car drivers use
> > > of_genpd_add_provider_onecell().  Perhaps there is an issue with
> > > the latter?  If you don't have a clue, I plan to do some more
> > > investigation later...
>
> of_genpd_add_provider_onecell() has:
>
>     if (!dev)
>             sync_state = true;
>     else
>             dev_set_drv_sync_state(dev, genpd_sync_state);
>
>     for (i = 0; i < data->num_domains; i++) {
>             ...
>             if (sync_state && !genpd_is_no_sync_state(genpd)) {
>                     genpd->sync_state = GENPD_SYNC_STATE_ONECELL;
>                     device_set_node(&genpd->dev, fwnode);
>                     sync_state = false;
>                     ^^^^^^^^^^^^^^^^^^^
>             }
>             ...
>     }
>
> As the R-Car SYSC drivers are not platform drivers, dev is NULL, and
> genpd->sync_state is set to GENPD_SYNC_STATE_ONECELL for the first PM
> Domain only.  All other domains have the default value of sync_state
> (0 = GENPD_SYNC_STATE_OFF).  Hence when genpd_provider_sync_state()
> is called later, it ignores all but the first domain.
> Apparently this is intentional, as of_genpd_sync_state() tries to
> power off all domains handled by the same controller anyway (see below)?

Right, this is intentional and mainly because of how fw_devlink works.

fw_devlink is limited to use only the first device - if multiple
devices share the same fwnode. In principle, we could have picked any
of the devices in the array of genpds here - and reached the same
result.

>
> > > BTW, the "pending due to"-messages look weird to me.
> > > On R-Car M2-W (r8a7791.dtsi) I see e.g.:
> > >
> > >     genpd_provider ca15-cpu0: sync_state() pending due to e6020000.watchdog
> > >     renesas-cpg-mssr e6150000.clock-controller: sync_state() pending
> > > due to e6020000.watchdog
> > >
> > > ca15-cpu0 is the PM Domain holding the first CPU core, while
> > > the watchdog resides in the always-on Clock Domain, and uses the
> > > clock-controller for PM_CLK handling.
>
> Unfortunately the first PM Domain is "ca15-cpu0", which is blocked on
> these bogus pending states, and no PM Domain is powered off.

I see, thanks for the details. I am looking closer at this.

In any case, this is the main issue, as it prevents the ->sync_state()
callback to be called. Hence the "genpd->stay_on" will also *not* be
cleared for any of the genpd's for the genpd-provider.

>
> If I remove the "sync_state = false" above, genpd_provider_sync_state()
> considers all domains, and does power down all unused domains (even
> multiple times, as expected).

I think those are getting called because with the change above, there
is no device_link being tracked. As stated above, fw_devlink is
limited to use only one device - if multiple devices share the same
fwnode.

In other words, the ->sync_state() callbacks are called even if the
corresponding consumer devices have not been probed yet.

>
> Upon closer look, all "pending due to" messages I see claim that the
> first (index 0) PM Domain is pending on some devices, while all of
> these devices are part of a different domain (usually the always-on
> domain, which is always the last (32 or 64) on R-Car).
>
> So I think there are two issues:
>   1. Devices are not attributed to the correct PM Domain using
>      fw_devlink sync_state,
>   2. One PM Domain of a multi-domain controller being blocked should
>      not block all other domains handled by the same controller.

Right, that's a current limitation with fw_devlink. To cope with this,
it's possible to enforce the ->sync_state() callback to be invoked
from user-space (timeout or explicitly) for a device.

Another option would be to allow an opt-out behavior for some genpd's
that are powered-on at initialization. Something along the lines of
the below.

From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 29 Jul 2025 14:27:22 +0200
Subject: [PATCH] pmdomain: core: Allow powered-on PM domains to be powered-off
 during boot

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c   | 3 ++-
 include/linux/pm_domain.h | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 0006ab3d0789..ef0760824c92 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -187,6 +187,7 @@ static const struct genpd_lock_ops genpd_raw_spin_ops = {
 #define genpd_is_opp_table_fw(genpd)   (genpd->flags & GENPD_FLAG_OPP_TABLE_FW)
 #define genpd_is_dev_name_fw(genpd)    (genpd->flags & GENPD_FLAG_DEV_NAME_FW)
 #define genpd_is_no_sync_state(genpd)  (genpd->flags &
GENPD_FLAG_NO_SYNC_STATE)
+#define genpd_is_no_stay_on(genpd)     (genpd->flags & GENPD_FLAG_NO_STAY_ON)

 static inline bool irq_safe_dev_in_sleep_domain(struct device *dev,
                const struct generic_pm_domain *genpd)
@@ -2392,7 +2393,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
        INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
        atomic_set(&genpd->sd_count, 0);
        genpd->status = is_off ? GENPD_STATE_OFF : GENPD_STATE_ON;
-       genpd->stay_on = !is_off;
+       genpd->stay_on = !genpd_is_no_stay_on(genpd) && !is_off;
        genpd->sync_state = GENPD_SYNC_STATE_OFF;
        genpd->device_count = 0;
        genpd->provider = NULL;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index b9d3c7d5c4f8..61b81574efc4 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -109,6 +109,12 @@ struct dev_pm_domain_list {
  *                             genpd provider specific way, likely through a
  *                             parent device node. This flag makes genpd to
  *                             skip its internal support for this.
+ *
+ * GENPD_FLAG_NO_STAY_ON:      A powered-on PM domain at initialization is
+ *                             prevented by genpd from being powered-off until
+ *                             we receive a ->sync_state() or runs the
+ *                             late_initcall_sync. Use this flag to allow
+ *                             power-off without waiting for these conditions.
  */
 #define GENPD_FLAG_PM_CLK       (1U << 0)
 #define GENPD_FLAG_IRQ_SAFE     (1U << 1)
@@ -120,6 +126,7 @@ struct dev_pm_domain_list {
 #define GENPD_FLAG_OPP_TABLE_FW         (1U << 7)
 #define GENPD_FLAG_DEV_NAME_FW  (1U << 8)
 #define GENPD_FLAG_NO_SYNC_STATE (1U << 9)
+#define GENPD_FLAG_NO_STAY_ON   (1U << 10)

 enum gpd_status {
        GENPD_STATE_ON = 0,     /* PM domain is on */
-- 
2.43.0

Kind regards
Uffe

