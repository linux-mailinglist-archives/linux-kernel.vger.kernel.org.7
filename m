Return-Path: <linux-kernel+bounces-723395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 530A0AFE65D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9565189C220
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F50295DA5;
	Wed,  9 Jul 2025 10:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o7YFm446"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADBD2D5A18
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 10:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057882; cv=none; b=hRpJC4D+wC7/XOv/JxU2t+tbIbYaQ9kXlKG1pCquqUEpA5RofbRqkDSQx+NsxPkSbviQzps/znYOL7vTw2OkqHsmn+M1xsrHAYZ1eH1vAXxRKMB1WnXV751dPmA3wg6hgG06dLc3MIXBS1tbpzpnRlbbH2zGFagN4FMiCizlQH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057882; c=relaxed/simple;
	bh=yOCb08n6dTxn+8x6DVj9LK4gXyvl6SKEuzpMFpGrFiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+lh09kWgD4lK6tL6FbSRkOUvyedcIgJmjeEDL9seXcVuapI6CnGiLKEjM0ir+JQLqF+wQUs7tHWjx38pemG6fzk3cpRs76dkEi4mxRpeJcYkVnB8VP+bNMujTgiCXHP0NSF75XRdENEhZV86EtTG8T8l7Srn0nD7P+ApB3Wfww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o7YFm446; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-313910f392dso4448557a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 03:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752057878; x=1752662678; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D8B77kU2J+Ybm9h9uGUkEFQ01LW8PrgIRBca0KXYjU0=;
        b=o7YFm446vluoDP5hV9dBx5M0IEA1EjSJsd83lN2M1N8qgAQ4raXlJVVLyMmMVTm/Ux
         6bnOTLAD/6iggA49YR+rx5KY3H8KcEYG3WrI4B72/WHYFY2EsjN9KKV6kvB2o1BlkysI
         LUqBb7K9e4vISYlA43bmpps+ENsa4lsenJZRxT30hogtreXa66b2OTtt7XdTMjqybN9l
         7xOTDat1IhzZgw9E2FvyqWcwArcb3AjIEOMG4ORPYC2x4cvs/JTQTAliny+kL9yDx/E3
         5kYoLzTl60QMrk2NllkSVi7Ao/iF3Yrgn9FbOC1ihUXGzqlgC6Is5h+vX925kf+oeq+K
         HFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752057878; x=1752662678;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D8B77kU2J+Ybm9h9uGUkEFQ01LW8PrgIRBca0KXYjU0=;
        b=vTFYnulmzz2shJnqDu21GmG67XP+8C9PQ9ui7u/Qyy8zZXPvvB1vcbSNf2mpTTzPrD
         HdH/egxCShvk0ORYhLCU4Cyw6J8d9Uf9Lc1X2GRZpJj691drOQSxnnR/f1kGADg7UF+v
         CM+s6jZi2fdy1Uq3posQHRmJv18F/Q32Fo0FIvYcIQOL/+FIMHXJvflEqUZFMAGS0KQe
         T4E43YOmkxk2m24zvbVwEUpF9vNAR++dlPK3HZ38Es1LYpkoyaLScWTbIA84/cPAa0Zn
         10MNikn7QLlC54wiHCqOSJW1JlaZgPAekVJJmTnDRU1LtQATyNuX4ogjJxq1m8HwqilI
         RmFg==
X-Gm-Message-State: AOJu0YyOLvUWhOqthF8ZwG7HiW1f7S6Rcn9HhRgYGm/GC56mNk2qoCNz
	II9186HHOUPu+W1WQnZrYuucmxVT4q8/kBWNFspIOG/25NzQYxem9bSiXsBDhKMmL8J8fXmyfoX
	NopmZw6BNCqP+71pk/r81ns2//hc6/BLGas+RafmV1w==
X-Gm-Gg: ASbGncuINtmyG1yzG96BVPftHnxFhP8ZJns1AesRyZapoxjT6KPAXD8OoYxht33kExj
	0JjRvEzk0ErhiOL2V9/9htZ9UnGN51a/jL6/BglE54qDYZSRK7CN0jfn/cpScKt13BjE/aGWi2u
	/KVxqAP/h/3i5JcaJtVEVXyzTS2Jp//kF4a1nPHvGrL/qZOtU1S9Yq1dyOci0mxHeSe1Ebe/B+j
	tzP
X-Google-Smtp-Source: AGHT+IF2a95UFz+E3M7dK/4U3eUSAXdz1qQAmh7AbREiDIoBeb2vVRykyPSOAbfKv9PM3hbNEiDH/BibegL1kGds8rA=
X-Received: by 2002:a17:90b:2811:b0:311:a314:c2d1 with SMTP id
 98e67ed59e1d1-31c2fd27addmr3020424a91.6.1752057878131; Wed, 09 Jul 2025
 03:44:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYvif6kDDFar5ZK4Dff3XThSrhaZaJundjQYujaJW978yg@mail.gmail.com>
 <20250709002521.GB1599700@nvidia.com>
In-Reply-To: <20250709002521.GB1599700@nvidia.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 9 Jul 2025 16:14:26 +0530
X-Gm-Features: Ac12FXyU-FP3ktQ1sRAwSIeSHnaGDmqm4MOSRwtxAVa2cr-dh9UvRjWr4CHKisQ
Message-ID: <CA+G9fYtOZLYe7yN7EdaEHLyJgVypgKFO2R6POoiEZv7PcLw+3A@mail.gmail.com>
Subject: Re: next-20250702 WARNING iommu io-pgtable-arm.c at
 arm_lpae_map_pages qcom_iommu_map
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: open list <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	Nicolin Chen <nicolinc@nvidia.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Jul 2025 at 05:55, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Wed, Jul 09, 2025 at 02:26:20AM +0530, Naresh Kamboju wrote:
> > Regression identified while booting the Dragonboard 410c (Qualcomm
> > APQ8016 SBC) using the Linux next-20250702 kernel tag. During device
> > initialization, the kernel triggers a WARNING in the arm_lpae_map_pages()
> > function, which is part of the IOMMU subsystem. The call trace also involves
> > qcom_iommu_map().
> >
> > Test environments:
> > - Dragonboard-410c
> >
> > Regression Analysis:
> > - New regression? Yes
> > - Reproducibility? Yes
> >
> > Boot regression: next-20250702 WARNING iommu io-pgtable-arm.c at
> > arm_lpae_map_pages qcom_iommu_map
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > List of suspected patches with recent changes.
> >  * https://lore.kernel.org/all/0-v2-68a2e1ba507c+1fb-iommu_rm_ops_pgsize_jgg@nvidia.com/
>
> Can you test this fix please:


I have tested this patch on top of Linux next-20250702 tag,
and found kernel warning,

[    1.510468] ------------[ cut here ]------------
[    1.516302] WARNING: drivers/iommu/iommu.c:1142 at
iommu_create_device_direct_mappings+0x240/0x258, CPU#1: swapper/0/1
[    1.521001] Modules linked in:
[    1.531485] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted
6.16.0-rc4-next-20250702 #1 PREEMPT
[    1.534538] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[    1.543473] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    1.550241] pc : iommu_create_device_direct_mappings
(drivers/iommu/iommu.c:1142 (discriminator 7))
[    1.556924] lr : iommu_setup_default_domain
(drivers/iommu/iommu.c:2992 (discriminator 1))
[    1.563170] sp : ffff80008002b9c0
[    1.568113] x29: ffff80008002b9e0 x28: 0000000000000000 x27: ffff80008174e2c0
[    1.571596] x26: ffff000004c58030 x25: ffff800081d75228 x24: ffff80008221eba4
[    1.578714] x23: ffff000003d99410 x22: ffff80008002b9c8 x21: ffff000003ce5900
[    1.585833] x20: ffff000003ce5948 x19: ffff000002e6d5a0 x18: 0000000000000000
[    1.592951] x17: ffff000003d4a000 x16: ffff000002c37e00 x15: 07690720076f0774
[    1.600068] x14: 0000000000000000 x13: ffff800082237670 x12: 000000000003786e
[    1.607185] x11: 0000000000000115 x10: 0000000000103758 x9 : 0000000000000000
[    1.614303] x8 : ffff000003ce5d00 x7 : 0000000000000000 x6 : 000000000000003f
[    1.621422] x5 : 0000000000000040 x4 : 0000000000000000 x3 : 0000000000000001
[    1.628539] x2 : ffff000002ce0000 x1 : ffff000003d99410 x0 : 0000000000000003
[    1.635660] Call trace:
[    1.642766] iommu_create_device_direct_mappings
(drivers/iommu/iommu.c:1142 (discriminator 7)) (P)
[    1.645031] iommu_setup_default_domain (drivers/iommu/iommu.c:2992
(discriminator 1))
[    1.651277] iommu_device_register (drivers/iommu/iommu.c:1905
drivers/iommu/iommu.c:277)
[    1.655877] qcom_iommu_device_probe
(drivers/iommu/arm/arm-smmu/qcom_iommu.c:860)
[    1.660392] platform_probe (drivers/base/platform.c:1404)
[    1.665163] really_probe (drivers/base/dd.c:579 drivers/base/dd.c:657)
[    1.668723] __driver_probe_device (drivers/base/dd.c:799)
[    1.672371] driver_probe_device (drivers/base/dd.c:829)
[    1.676623] __driver_attach (drivers/base/dd.c:1216 drivers/base/dd.c:1155)
[    1.680615] bus_for_each_dev (drivers/base/bus.c:370)
[    1.684434] driver_attach (drivers/base/dd.c:1234)
[    1.688255] bus_add_driver (drivers/base/bus.c:678)
[    1.692073] driver_register (drivers/base/driver.c:249)
[    1.695633] __platform_driver_register (drivers/base/platform.c:868)
[    1.699368] qcom_iommu_init (drivers/iommu/arm/arm-smmu/qcom_iommu.c:943)
[    1.704226] do_one_initcall (init/main.c:1269)
[    1.707873] kernel_init_freeable (init/main.c:1330 (discriminator
1) init/main.c:1347 (discriminator 1) init/main.c:1366 (discriminator
1) init/main.c:1579 (discriminator 1))
[    1.711607] kernel_init (init/main.c:1473)
[    1.716118] ret_from_fork (arch/arm64/kernel/entry.S:863)
[    1.719419] ---[ end trace 0000000000000000 ]---
[    1.723302] iommu 1ef0000.iommu: IOMMU driver was not able to
establish FW requested direct mapping.
[    1.734231] platform 1c00000.gpu: Adding to iommu group 2
[    1.748218] loop: module loaded

Links:
 - https://lkft.validation.linaro.org/scheduler/job/8350682#L2838

> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> @@ -229,7 +229,7 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
>                 goto out_unlock;
>
>         pgtbl_cfg = (struct io_pgtable_cfg) {
> -               .pgsize_bitmap  = domain->pgsize_bitmap,
> +               .pgsize_bitmap  = SZ_4K | SZ_64K | SZ_1M | SZ_16M,
>                 .ias            = 32,
>                 .oas            = 40,
>                 .tlb            = &qcom_flush_ops,
> @@ -246,6 +246,8 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
>                 goto out_clear_iommu;
>         }
>
> +       /* Update the domain's page sizes to reflect the page table format */
> +       domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
>         domain->geometry.aperture_end = (1ULL << pgtbl_cfg.ias) - 1;
>         domain->geometry.force_aperture = true;
>
> @@ -335,7 +337,6 @@ static struct iommu_domain *qcom_iommu_domain_alloc_paging(struct device *dev)
>
>         mutex_init(&qcom_domain->init_mutex);
>         spin_lock_init(&qcom_domain->pgtbl_lock);
> -       qcom_domain->domain.pgsize_bitmap = SZ_4K | SZ_64K | SZ_1M | SZ_16M;
>
>         return &qcom_domain->domain;
>  }
>
> Of all the drivers qcom is the only one that uses the 64 bit arm page
> table, 4 & 64k sizes, and was using the ops global. The io_pgtable
> code will remove one of the two depending on PAGE_SIZE which makes
> things inconsistent and hits that warn.
>
> Jason

