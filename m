Return-Path: <linux-kernel+bounces-818970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B61B598FB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B3A4864E6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6546301463;
	Tue, 16 Sep 2025 14:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="miY4mDAa"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6531078F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031669; cv=none; b=gcpy54xIIWllgBfsbRFIZuXxZ/ZT5ps4Sz9gJX63T1bgISDXnOaiL3WIQThe0X8RlG0jHtv0KaCFUqAdF+Zc927mwHE97OXWhna1Oh5plphS7HKGjz+5Fm8KEdpAXt8lm7/3wdmQQLFNiKcwu+6GN7uEuGoEUGhVeHPDpK21r00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031669; c=relaxed/simple;
	bh=1NFn5KE/kXg8kjuzgfmxfbGhfOgwFsV7gF4h39ukfKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMThw1L2jbN97AD1TGJ72msKFfODgxl8izIbZPHvxbFPSMZuCUeOlV+k3e3b2ssDhPkwJngu9HbgFQb9KTXllNYQn539eqGie40gVT553dC+mL/A2sgBXsT8THU4X/ozUs49eIggs+lJyItRaGJk6l+Vz3WmPPxBw4BNszyZR08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=miY4mDAa; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45f2d21cbabso54535e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758031665; x=1758636465; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HShoPQmKhWPfy1OnMwKg01Y3DNas9O6fwq8aUeABtfI=;
        b=miY4mDAaXTpZfBwkhna20k6zi2tK25QY1idBRX8eo9PxxGD2GEgWFtiCEgAh7MDhJe
         y7ZxXMXYgpkTFsYutYKkUCFNj2tNLDXnIrvUbfolCpCZ1pohe7SXlxjoN3kAl3v2X2/1
         gJKyfK2bpi2nwbbH7e2bUQGX/aWR/NuXEdZqo1733RClz0P688JuQ73A4D/kgaKfpWfe
         rHxD/nqp/wpCtAXmYuFPKSmwdCuuNiSYL/FZrnzrxE0plzdUyURB6fYJye3RKtlo6ZFG
         lQyp6AYEQeRONrNHy7G6BHNZ/L4m8BQwuqHJ6xAjgT09Avk9bE0K9pA0EJP2yNVQ9XGd
         9mHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758031665; x=1758636465;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HShoPQmKhWPfy1OnMwKg01Y3DNas9O6fwq8aUeABtfI=;
        b=G3W+ppVTVgi8p8xY0Zmv5BVlsb64Q3Z4ctaQsav8zwNhXLZk2HuQ044hrmsg0GrafO
         S1TEGnUXE/XebOYPEPr9mQ3d6Jss8Aw1O1UX/VYh4LV0MxJ3RA8cnBXdjX30l38EBmxB
         kU6WiM7suycjFX4jnUqB52mYWq4TZlH2VXspo/YMF55J59SoBnQLwYGZCn1wodx5N3kh
         R0n/zvXAvUJEA089Vg9io7GMVLKJq1Sop7aUJJLVPfvIopXIpDYv0IYEzjE5U+axCiJ8
         CcZe7OpYOV6JDKaa4PquRvmYh3yCzNFNdi/5I6uw2Dk47eJ8J9WMuu5WJgT2iA2ka6SA
         dGJQ==
X-Gm-Message-State: AOJu0Yw9F84NG888WURjaoCcGRmFW0a4Hgjx7NbOALHlaQXW2FMhlao5
	FOHp4BjnD+USYTm2bGO3VczRMuKObWXHehYGsQLrK0MfNcO3PGm1t9sJ6iM2kzrkXA==
X-Gm-Gg: ASbGnctFV6h10kb6abPKkzMcbn2qpFFGKro3PwdALYBgba5pGzPO5dJvn0qlnDkhLJW
	jZmwb7p3rLab7Rz7+rgFaI/j+5dQRAJTDB2q/ugbaC+TeDPnlZ2zxLd3wxJmSwv0vP+pz85Bpb4
	Z8+Z2vC/U52y3SFlyHyWJxDvCdkmecHu+Twc/NotBrE+NlVfDXQW1G8ndlE76Z61Eqfqhq6RJnx
	+rH2yvouhg32k1T8XBgnCSiHBe5AkonppfT2GMpcyesvb7UhdH17RdCMCAn96pobo0dK7pTM0so
	TlB4S7vu51JnZUD9XqhQdK8KW66OXNoxvfz1MAtM6AN8dUTQLl3mKshJWgdBQBU7o1sT63m9Z31
	BXxad+tXtYO9UGbiAb65ghaJ6Zr49yaqsemVGS1JIVyGAUZeUkzvr/GaerYoD6Doy6ygwfycZ8R
	epSrdi
X-Google-Smtp-Source: AGHT+IEVo4a+qAIT+mxk3e2bBJu0HzPute2usozdzr8r6tBTGChpG2GP9sikTw0U3WHTfaTbYtNMLw==
X-Received: by 2002:a05:600c:8b6a:b0:45f:5b02:b0cb with SMTP id 5b1f17b1804b1-45f5b02b390mr1185505e9.0.1758031664917;
        Tue, 16 Sep 2025 07:07:44 -0700 (PDT)
Received: from google.com (157.24.148.146.bc.googleusercontent.com. [146.148.24.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ecdbc7fe1bsm804909f8f.52.2025.09.16.07.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:07:44 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:07:40 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	jgg@ziepe.ca, mark.rutland@arm.com
Subject: Re: [PATCH v4 04/28] iommu/io-pgtable-arm: Move selftests to a
 separate file
Message-ID: <aMlvLHFgubf0lcfO@google.com>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-5-smostafa@google.com>
 <aMgkvTLAWLUJ7OD5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMgkvTLAWLUJ7OD5@google.com>

On Mon, Sep 15, 2025 at 02:37:49PM +0000, Pranjal Shrivastava wrote:
> On Tue, Aug 19, 2025 at 09:51:32PM +0000, Mostafa Saleh wrote:
> > Soon, io-pgtable-arm.c will be compiled as part of the KVM/arm64
> > in the hypervisor object, which doesn't have many of the kernel APIs,
> > as faux devices, printk...
> > 
> > We would need to factor this things outside of this file, this patch
> > moves the selftests outside, which remove many of the kernel
> > dependencies, which also is not needed by the hypervisor.
> > Create io-pgtable-arm-kernel.c for that, and in the next patch
> > the rest of the code is factored out.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  drivers/iommu/Makefile                |   2 +-
> >  drivers/iommu/io-pgtable-arm-kernel.c | 216 +++++++++++++++++++++++
> >  drivers/iommu/io-pgtable-arm.c        | 245 --------------------------
> >  drivers/iommu/io-pgtable-arm.h        |  41 +++++
> >  4 files changed, 258 insertions(+), 246 deletions(-)
> >  create mode 100644 drivers/iommu/io-pgtable-arm-kernel.c
> > 
> > diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> > index 355294fa9033..d601b0e25ef5 100644
> > --- a/drivers/iommu/Makefile
> > +++ b/drivers/iommu/Makefile
> > @@ -11,7 +11,7 @@ obj-$(CONFIG_IOMMU_DEBUGFS) += iommu-debugfs.o
> >  obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
> >  obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
> >  obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
> > -obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
> > +obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o io-pgtable-arm-kernel.o
> >  obj-$(CONFIG_IOMMU_IO_PGTABLE_DART) += io-pgtable-dart.o
> >  obj-$(CONFIG_IOMMU_IOVA) += iova.o
> >  obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
> > diff --git a/drivers/iommu/io-pgtable-arm-kernel.c b/drivers/iommu/io-pgtable-arm-kernel.c
> > new file mode 100644
> > index 000000000000..f3b869310964
> > --- /dev/null
> > +++ b/drivers/iommu/io-pgtable-arm-kernel.c
> 
> If this file just contains the selftests, how about naming it
> "io-pgtable-arm-selftests.c" ? 

In the next patch I am adding more kernel code to it, so it’s not just
selftests, but as Jason suggested, we can just completely move the self
tests out, in that case "io-pgtable-arm-selftests.c" makes sense.

Thanks,
Mostafa

> 
> > @@ -0,0 +1,216 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * CPU-agnostic ARM page table allocator.
> > + *
> > + * Copyright (C) 2014 ARM Limited
> > + *
> > + * Author: Will Deacon <will.deacon@arm.com>
> > + */
> > +#define pr_fmt(fmt)	"arm-lpae io-pgtable: " fmt
> > +
> > +#include <linux/device/faux.h>
> > +#include <linux/kernel.h>
> > +#include <linux/slab.h>
> > +
> > +#include "io-pgtable-arm.h"
> > +
> > +#ifdef CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST
> > +
> > +static struct io_pgtable_cfg *cfg_cookie __initdata;
> > +
> > +static void __init dummy_tlb_flush_all(void *cookie)
> > +{
> > +	WARN_ON(cookie != cfg_cookie);
> > +}
> > +
> > +static void __init dummy_tlb_flush(unsigned long iova, size_t size,
> > +				   size_t granule, void *cookie)
> > +{
> > +	WARN_ON(cookie != cfg_cookie);
> > +	WARN_ON(!(size & cfg_cookie->pgsize_bitmap));
> > +}
> > +
> > +static void __init dummy_tlb_add_page(struct iommu_iotlb_gather *gather,
> > +				      unsigned long iova, size_t granule,
> > +				      void *cookie)
> > +{
> > +	dummy_tlb_flush(iova, granule, granule, cookie);
> > +}
> > +
> > +static const struct iommu_flush_ops dummy_tlb_ops __initconst = {
> > +	.tlb_flush_all	= dummy_tlb_flush_all,
> > +	.tlb_flush_walk	= dummy_tlb_flush,
> > +	.tlb_add_page	= dummy_tlb_add_page,
> > +};
> > +
> > +static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
> > +{
> > +	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
> > +	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> > +
> > +	pr_err("cfg: pgsize_bitmap 0x%lx, ias %u-bit\n",
> > +		cfg->pgsize_bitmap, cfg->ias);
> > +	pr_err("data: %d levels, 0x%zx pgd_size, %u pg_shift, %u bits_per_level, pgd @ %p\n",
> > +		ARM_LPAE_MAX_LEVELS - data->start_level, ARM_LPAE_PGD_SIZE(data),
> > +		ilog2(ARM_LPAE_GRANULE(data)), data->bits_per_level, data->pgd);
> > +}
> > +
> > +#define __FAIL(ops, i)	({						\
> > +		WARN(1, "selftest: test failed for fmt idx %d\n", (i));	\
> > +		arm_lpae_dump_ops(ops);					\
> > +		-EFAULT;						\
> > +})
> > +
> > +static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
> > +{
> > +	static const enum io_pgtable_fmt fmts[] __initconst = {
> > +		ARM_64_LPAE_S1,
> > +		ARM_64_LPAE_S2,
> > +	};
> > +
> > +	int i, j;
> > +	unsigned long iova;
> > +	size_t size, mapped;
> > +	struct io_pgtable_ops *ops;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(fmts); ++i) {
> > +		cfg_cookie = cfg;
> > +		ops = alloc_io_pgtable_ops(fmts[i], cfg, cfg);
> > +		if (!ops) {
> > +			pr_err("selftest: failed to allocate io pgtable ops\n");
> > +			return -ENOMEM;
> > +		}
> > +
> > +		/*
> > +		 * Initial sanity checks.
> > +		 * Empty page tables shouldn't provide any translations.
> > +		 */
> > +		if (ops->iova_to_phys(ops, 42))
> > +			return __FAIL(ops, i);
> > +
> > +		if (ops->iova_to_phys(ops, SZ_1G + 42))
> > +			return __FAIL(ops, i);
> > +
> > +		if (ops->iova_to_phys(ops, SZ_2G + 42))
> > +			return __FAIL(ops, i);
> > +
> > +		/*
> > +		 * Distinct mappings of different granule sizes.
> > +		 */
> > +		iova = 0;
> > +		for_each_set_bit(j, &cfg->pgsize_bitmap, BITS_PER_LONG) {
> > +			size = 1UL << j;
> > +
> > +			if (ops->map_pages(ops, iova, iova, size, 1,
> > +					   IOMMU_READ | IOMMU_WRITE |
> > +					   IOMMU_NOEXEC | IOMMU_CACHE,
> > +					   GFP_KERNEL, &mapped))
> > +				return __FAIL(ops, i);
> > +
> > +			/* Overlapping mappings */
> > +			if (!ops->map_pages(ops, iova, iova + size, size, 1,
> > +					    IOMMU_READ | IOMMU_NOEXEC,
> > +					    GFP_KERNEL, &mapped))
> > +				return __FAIL(ops, i);
> > +
> > +			if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
> > +				return __FAIL(ops, i);
> > +
> > +			iova += SZ_1G;
> > +		}
> > +
> > +		/* Full unmap */
> > +		iova = 0;
> > +		for_each_set_bit(j, &cfg->pgsize_bitmap, BITS_PER_LONG) {
> > +			size = 1UL << j;
> > +
> > +			if (ops->unmap_pages(ops, iova, size, 1, NULL) != size)
> > +				return __FAIL(ops, i);
> > +
> > +			if (ops->iova_to_phys(ops, iova + 42))
> > +				return __FAIL(ops, i);
> > +
> > +			/* Remap full block */
> > +			if (ops->map_pages(ops, iova, iova, size, 1,
> > +					   IOMMU_WRITE, GFP_KERNEL, &mapped))
> > +				return __FAIL(ops, i);
> > +
> > +			if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
> > +				return __FAIL(ops, i);
> > +
> > +			iova += SZ_1G;
> > +		}
> > +
> > +		/*
> > +		 * Map/unmap the last largest supported page of the IAS, this can
> > +		 * trigger corner cases in the concatednated page tables.
> > +		 */
> > +		mapped = 0;
> > +		size = 1UL << __fls(cfg->pgsize_bitmap);
> > +		iova = (1UL << cfg->ias) - size;
> > +		if (ops->map_pages(ops, iova, iova, size, 1,
> > +				   IOMMU_READ | IOMMU_WRITE |
> > +				   IOMMU_NOEXEC | IOMMU_CACHE,
> > +				   GFP_KERNEL, &mapped))
> > +			return __FAIL(ops, i);
> > +		if (mapped != size)
> > +			return __FAIL(ops, i);
> > +		if (ops->unmap_pages(ops, iova, size, 1, NULL) != size)
> > +			return __FAIL(ops, i);
> > +
> > +		free_io_pgtable_ops(ops);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int __init arm_lpae_do_selftests(void)
> > +{
> > +	static const unsigned long pgsize[] __initconst = {
> > +		SZ_4K | SZ_2M | SZ_1G,
> > +		SZ_16K | SZ_32M,
> > +		SZ_64K | SZ_512M,
> > +	};
> > +
> > +	static const unsigned int address_size[] __initconst = {
> > +		32, 36, 40, 42, 44, 48,
> > +	};
> > +
> > +	int i, j, k, pass = 0, fail = 0;
> > +	struct faux_device *dev;
> > +	struct io_pgtable_cfg cfg = {
> > +		.tlb = &dummy_tlb_ops,
> > +		.coherent_walk = true,
> > +		.quirks = IO_PGTABLE_QUIRK_NO_WARN,
> > +	};
> > +
> > +	dev = faux_device_create("io-pgtable-test", NULL, 0);
> > +	if (!dev)
> > +		return -ENOMEM;
> > +
> > +	cfg.iommu_dev = &dev->dev;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(pgsize); ++i) {
> > +		for (j = 0; j < ARRAY_SIZE(address_size); ++j) {
> > +			/* Don't use ias > oas as it is not valid for stage-2. */
> > +			for (k = 0; k <= j; ++k) {
> > +				cfg.pgsize_bitmap = pgsize[i];
> > +				cfg.ias = address_size[k];
> > +				cfg.oas = address_size[j];
> > +				pr_info("selftest: pgsize_bitmap 0x%08lx, IAS %u OAS %u\n",
> > +					pgsize[i], cfg.ias, cfg.oas);
> > +				if (arm_lpae_run_tests(&cfg))
> > +					fail++;
> > +				else
> > +					pass++;
> > +			}
> > +		}
> > +	}
> > +
> > +	pr_info("selftest: completed with %d PASS %d FAIL\n", pass, fail);
> > +	faux_device_destroy(dev);
> > +
> > +	return fail ? -EFAULT : 0;
> > +}
> > +subsys_initcall(arm_lpae_do_selftests);
> > +#endif
> > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> > index 96425e92f313..791a2c4ecb83 100644
> > --- a/drivers/iommu/io-pgtable-arm.c
> > +++ b/drivers/iommu/io-pgtable-arm.c
> > @@ -7,15 +7,10 @@
> >   * Author: Will Deacon <will.deacon@arm.com>
> >   */
> >  
> > -#define pr_fmt(fmt)	"arm-lpae io-pgtable: " fmt
> > -
> >  #include <linux/atomic.h>
> >  #include <linux/bitops.h>
> >  #include <linux/io-pgtable.h>
> > -#include <linux/kernel.h>
> > -#include <linux/device/faux.h>
> >  #include <linux/sizes.h>
> > -#include <linux/slab.h>
> >  #include <linux/types.h>
> >  #include <linux/dma-mapping.h>
> >  
> > @@ -24,33 +19,6 @@
> >  #include "io-pgtable-arm.h"
> >  #include "iommu-pages.h"
> >  
> > -#define ARM_LPAE_MAX_ADDR_BITS		52
> > -#define ARM_LPAE_S2_MAX_CONCAT_PAGES	16
> > -#define ARM_LPAE_MAX_LEVELS		4
> > -
> > -/* Struct accessors */
> > -#define io_pgtable_to_data(x)						\
> > -	container_of((x), struct arm_lpae_io_pgtable, iop)
> > -
> > -#define io_pgtable_ops_to_data(x)					\
> > -	io_pgtable_to_data(io_pgtable_ops_to_pgtable(x))
> > -
> > -/*
> > - * Calculate the right shift amount to get to the portion describing level l
> > - * in a virtual address mapped by the pagetable in d.
> > - */
> > -#define ARM_LPAE_LVL_SHIFT(l,d)						\
> > -	(((ARM_LPAE_MAX_LEVELS - (l)) * (d)->bits_per_level) +		\
> > -	ilog2(sizeof(arm_lpae_iopte)))
> > -
> > -#define ARM_LPAE_GRANULE(d)						\
> > -	(sizeof(arm_lpae_iopte) << (d)->bits_per_level)
> > -#define ARM_LPAE_PGD_SIZE(d)						\
> > -	(sizeof(arm_lpae_iopte) << (d)->pgd_bits)
> > -
> > -#define ARM_LPAE_PTES_PER_TABLE(d)					\
> > -	(ARM_LPAE_GRANULE(d) >> ilog2(sizeof(arm_lpae_iopte)))
> > -
> >  /*
> >   * Calculate the index at level l used to map virtual address a using the
> >   * pagetable in d.
> > @@ -163,18 +131,6 @@
> >  #define iopte_set_writeable_clean(ptep)				\
> >  	set_bit(ARM_LPAE_PTE_AP_RDONLY_BIT, (unsigned long *)(ptep))
> >  
> > -struct arm_lpae_io_pgtable {
> > -	struct io_pgtable	iop;
> > -
> > -	int			pgd_bits;
> > -	int			start_level;
> > -	int			bits_per_level;
> > -
> > -	void			*pgd;
> > -};
> > -
> > -typedef u64 arm_lpae_iopte;
> > -
> >  static inline bool iopte_leaf(arm_lpae_iopte pte, int lvl,
> >  			      enum io_pgtable_fmt fmt)
> >  {
> > @@ -1274,204 +1230,3 @@ struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns = {
> >  	.alloc	= arm_mali_lpae_alloc_pgtable,
> >  	.free	= arm_lpae_free_pgtable,
> >  };
> > -
> > -#ifdef CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST
> > -
> > -static struct io_pgtable_cfg *cfg_cookie __initdata;
> > -
> > -static void __init dummy_tlb_flush_all(void *cookie)
> > -{
> > -	WARN_ON(cookie != cfg_cookie);
> > -}
> > -
> > -static void __init dummy_tlb_flush(unsigned long iova, size_t size,
> > -				   size_t granule, void *cookie)
> > -{
> > -	WARN_ON(cookie != cfg_cookie);
> > -	WARN_ON(!(size & cfg_cookie->pgsize_bitmap));
> > -}
> > -
> > -static void __init dummy_tlb_add_page(struct iommu_iotlb_gather *gather,
> > -				      unsigned long iova, size_t granule,
> > -				      void *cookie)
> > -{
> > -	dummy_tlb_flush(iova, granule, granule, cookie);
> > -}
> > -
> > -static const struct iommu_flush_ops dummy_tlb_ops __initconst = {
> > -	.tlb_flush_all	= dummy_tlb_flush_all,
> > -	.tlb_flush_walk	= dummy_tlb_flush,
> > -	.tlb_add_page	= dummy_tlb_add_page,
> > -};
> > -
> > -static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
> > -{
> > -	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
> > -	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> > -
> > -	pr_err("cfg: pgsize_bitmap 0x%lx, ias %u-bit\n",
> > -		cfg->pgsize_bitmap, cfg->ias);
> > -	pr_err("data: %d levels, 0x%zx pgd_size, %u pg_shift, %u bits_per_level, pgd @ %p\n",
> > -		ARM_LPAE_MAX_LEVELS - data->start_level, ARM_LPAE_PGD_SIZE(data),
> > -		ilog2(ARM_LPAE_GRANULE(data)), data->bits_per_level, data->pgd);
> > -}
> > -
> > -#define __FAIL(ops, i)	({						\
> > -		WARN(1, "selftest: test failed for fmt idx %d\n", (i));	\
> > -		arm_lpae_dump_ops(ops);					\
> > -		-EFAULT;						\
> > -})
> > -
> > -static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
> > -{
> > -	static const enum io_pgtable_fmt fmts[] __initconst = {
> > -		ARM_64_LPAE_S1,
> > -		ARM_64_LPAE_S2,
> > -	};
> > -
> > -	int i, j;
> > -	unsigned long iova;
> > -	size_t size, mapped;
> > -	struct io_pgtable_ops *ops;
> > -
> > -	for (i = 0; i < ARRAY_SIZE(fmts); ++i) {
> > -		cfg_cookie = cfg;
> > -		ops = alloc_io_pgtable_ops(fmts[i], cfg, cfg);
> > -		if (!ops) {
> > -			pr_err("selftest: failed to allocate io pgtable ops\n");
> > -			return -ENOMEM;
> > -		}
> > -
> > -		/*
> > -		 * Initial sanity checks.
> > -		 * Empty page tables shouldn't provide any translations.
> > -		 */
> > -		if (ops->iova_to_phys(ops, 42))
> > -			return __FAIL(ops, i);
> > -
> > -		if (ops->iova_to_phys(ops, SZ_1G + 42))
> > -			return __FAIL(ops, i);
> > -
> > -		if (ops->iova_to_phys(ops, SZ_2G + 42))
> > -			return __FAIL(ops, i);
> > -
> > -		/*
> > -		 * Distinct mappings of different granule sizes.
> > -		 */
> > -		iova = 0;
> > -		for_each_set_bit(j, &cfg->pgsize_bitmap, BITS_PER_LONG) {
> > -			size = 1UL << j;
> > -
> > -			if (ops->map_pages(ops, iova, iova, size, 1,
> > -					   IOMMU_READ | IOMMU_WRITE |
> > -					   IOMMU_NOEXEC | IOMMU_CACHE,
> > -					   GFP_KERNEL, &mapped))
> > -				return __FAIL(ops, i);
> > -
> > -			/* Overlapping mappings */
> > -			if (!ops->map_pages(ops, iova, iova + size, size, 1,
> > -					    IOMMU_READ | IOMMU_NOEXEC,
> > -					    GFP_KERNEL, &mapped))
> > -				return __FAIL(ops, i);
> > -
> > -			if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
> > -				return __FAIL(ops, i);
> > -
> > -			iova += SZ_1G;
> > -		}
> > -
> > -		/* Full unmap */
> > -		iova = 0;
> > -		for_each_set_bit(j, &cfg->pgsize_bitmap, BITS_PER_LONG) {
> > -			size = 1UL << j;
> > -
> > -			if (ops->unmap_pages(ops, iova, size, 1, NULL) != size)
> > -				return __FAIL(ops, i);
> > -
> > -			if (ops->iova_to_phys(ops, iova + 42))
> > -				return __FAIL(ops, i);
> > -
> > -			/* Remap full block */
> > -			if (ops->map_pages(ops, iova, iova, size, 1,
> > -					   IOMMU_WRITE, GFP_KERNEL, &mapped))
> > -				return __FAIL(ops, i);
> > -
> > -			if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
> > -				return __FAIL(ops, i);
> > -
> > -			iova += SZ_1G;
> > -		}
> > -
> > -		/*
> > -		 * Map/unmap the last largest supported page of the IAS, this can
> > -		 * trigger corner cases in the concatednated page tables.
> > -		 */
> > -		mapped = 0;
> > -		size = 1UL << __fls(cfg->pgsize_bitmap);
> > -		iova = (1UL << cfg->ias) - size;
> > -		if (ops->map_pages(ops, iova, iova, size, 1,
> > -				   IOMMU_READ | IOMMU_WRITE |
> > -				   IOMMU_NOEXEC | IOMMU_CACHE,
> > -				   GFP_KERNEL, &mapped))
> > -			return __FAIL(ops, i);
> > -		if (mapped != size)
> > -			return __FAIL(ops, i);
> > -		if (ops->unmap_pages(ops, iova, size, 1, NULL) != size)
> > -			return __FAIL(ops, i);
> > -
> > -		free_io_pgtable_ops(ops);
> > -	}
> > -
> > -	return 0;
> > -}
> > -
> > -static int __init arm_lpae_do_selftests(void)
> > -{
> > -	static const unsigned long pgsize[] __initconst = {
> > -		SZ_4K | SZ_2M | SZ_1G,
> > -		SZ_16K | SZ_32M,
> > -		SZ_64K | SZ_512M,
> > -	};
> > -
> > -	static const unsigned int address_size[] __initconst = {
> > -		32, 36, 40, 42, 44, 48,
> > -	};
> > -
> > -	int i, j, k, pass = 0, fail = 0;
> > -	struct faux_device *dev;
> > -	struct io_pgtable_cfg cfg = {
> > -		.tlb = &dummy_tlb_ops,
> > -		.coherent_walk = true,
> > -		.quirks = IO_PGTABLE_QUIRK_NO_WARN,
> > -	};
> > -
> > -	dev = faux_device_create("io-pgtable-test", NULL, 0);
> > -	if (!dev)
> > -		return -ENOMEM;
> > -
> > -	cfg.iommu_dev = &dev->dev;
> > -
> > -	for (i = 0; i < ARRAY_SIZE(pgsize); ++i) {
> > -		for (j = 0; j < ARRAY_SIZE(address_size); ++j) {
> > -			/* Don't use ias > oas as it is not valid for stage-2. */
> > -			for (k = 0; k <= j; ++k) {
> > -				cfg.pgsize_bitmap = pgsize[i];
> > -				cfg.ias = address_size[k];
> > -				cfg.oas = address_size[j];
> > -				pr_info("selftest: pgsize_bitmap 0x%08lx, IAS %u OAS %u\n",
> > -					pgsize[i], cfg.ias, cfg.oas);
> > -				if (arm_lpae_run_tests(&cfg))
> > -					fail++;
> > -				else
> > -					pass++;
> > -			}
> > -		}
> > -	}
> > -
> > -	pr_info("selftest: completed with %d PASS %d FAIL\n", pass, fail);
> > -	faux_device_destroy(dev);
> > -
> > -	return fail ? -EFAULT : 0;
> > -}
> > -subsys_initcall(arm_lpae_do_selftests);
> > -#endif
> > diff --git a/drivers/iommu/io-pgtable-arm.h b/drivers/iommu/io-pgtable-arm.h
> > index ba7cfdf7afa0..a06a23543cff 100644
> > --- a/drivers/iommu/io-pgtable-arm.h
> > +++ b/drivers/iommu/io-pgtable-arm.h
> > @@ -2,6 +2,8 @@
> >  #ifndef IO_PGTABLE_ARM_H_
> >  #define IO_PGTABLE_ARM_H_
> >  
> > +#include <linux/io-pgtable.h>
> > +
> >  #define ARM_LPAE_TCR_TG0_4K		0
> >  #define ARM_LPAE_TCR_TG0_64K		1
> >  #define ARM_LPAE_TCR_TG0_16K		2
> > @@ -27,4 +29,43 @@
> >  #define ARM_LPAE_TCR_PS_48_BIT		0x5ULL
> >  #define ARM_LPAE_TCR_PS_52_BIT		0x6ULL
> >  
> > +/* Struct accessors */
> > +#define io_pgtable_to_data(x)						\
> > +	container_of((x), struct arm_lpae_io_pgtable, iop)
> > +
> > +#define io_pgtable_ops_to_data(x)					\
> > +	io_pgtable_to_data(io_pgtable_ops_to_pgtable(x))
> > +
> > +struct arm_lpae_io_pgtable {
> > +	struct io_pgtable	iop;
> > +
> > +	int			pgd_bits;
> > +	int			start_level;
> > +	int			bits_per_level;
> > +
> > +	void			*pgd;
> > +};
> > +
> > +#define ARM_LPAE_MAX_ADDR_BITS		52
> > +#define ARM_LPAE_S2_MAX_CONCAT_PAGES	16
> > +#define ARM_LPAE_MAX_LEVELS		4
> > +
> > +/*
> > + * Calculate the right shift amount to get to the portion describing level l
> > + * in a virtual address mapped by the pagetable in d.
> > + */
> > +#define ARM_LPAE_LVL_SHIFT(l,d)						\
> > +	(((ARM_LPAE_MAX_LEVELS - (l)) * (d)->bits_per_level) +		\
> > +	ilog2(sizeof(arm_lpae_iopte)))
> > +
> > +#define ARM_LPAE_GRANULE(d)						\
> > +	(sizeof(arm_lpae_iopte) << (d)->bits_per_level)
> > +#define ARM_LPAE_PGD_SIZE(d)						\
> > +	(sizeof(arm_lpae_iopte) << (d)->pgd_bits)
> > +
> > +#define ARM_LPAE_PTES_PER_TABLE(d)					\
> > +	(ARM_LPAE_GRANULE(d) >> ilog2(sizeof(arm_lpae_iopte)))
> > +
> > +typedef u64 arm_lpae_iopte;
> > +
> >  #endif /* IO_PGTABLE_ARM_H_ */
> 
> Apart from the renaming above, I was able to apply this patch alone, and
> build succesfully while toggling IOMMU_IO_PGTABLE_LPAE_SELFTEST across 
> builds.
> 
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> 
> > -- 
> > 2.51.0.rc1.167.g924127e9c0-goog
> > 

