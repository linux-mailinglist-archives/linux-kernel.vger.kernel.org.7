Return-Path: <linux-kernel+bounces-826843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39116B8F79A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19A417FF3B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673E82F7ACA;
	Mon, 22 Sep 2025 08:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dVxQ/oEF"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D226F2F659B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529349; cv=none; b=k3DAVtQ9xoi2q/V24LMrDtbcfDaRrc/TXei4fV1TpMuMqPD9aIw7IIcHlqo1o636SAts7pRb8Iu/OuHaevSHEAhSdGyfLTffUlbj/j+THdWowhG13cSNpKr/bRrlK8JjYrXBldRUW+S92kkRvsNSvT7/jZN7lLKjVVpfQcDygf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529349; c=relaxed/simple;
	bh=wcgd5vKAWbHO0vRZ+p4xrg5t4PZ/hiZsS2W2PPEHtOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CU08UfxR61TcU8ajZLoitMfMQLxEa386azEH5em3cBqYHaB2BRqDszBM8byB6aJ5kPOkwV9njeNLR2DQn6QMsOTXpNMzplfsTARZce3hF9KipyQqa3ZiaUhn48IuY+s12zUuBZcXUWnqLYbE0Oi4SXqlqFy5YZMQbHHAnKicbms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dVxQ/oEF; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46d72711971so28005e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 01:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758529346; x=1759134146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gqTj3W7IZ9HZZBW9wKpYWsYyOAxKSEoa6COxIZsKaeQ=;
        b=dVxQ/oEF/b/SezVFNRT52YM6ZkFPr+S7yE0ipWc9IPovYyOT85mhtGIH4cahmC7Mr/
         9xyMM5f8G0ykz3WVd1qmPmN/doyl2nHw0Mahq9O2p53/mZAsbWFqBBcYlFCUcOEe8W4i
         odlZjFZDZA7jkkEeGt7R7ONdwuS0CkyJJvXlOdJESRNcc8n8yUaHCxDjl/kSWjrmM4nz
         A9pqh4rCZk9r//PM24Gw7nbisH/Yjo6sTVXlfJ7L/hcJoDnrn1SS7lahXJ7R/2hTjPLZ
         ENWs7a6aeuRI70cot+WMqXTguZXJyreJ9ZON6Xv1YJRuaUp/CmF0spl50glvXX7AIAbA
         KW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758529346; x=1759134146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqTj3W7IZ9HZZBW9wKpYWsYyOAxKSEoa6COxIZsKaeQ=;
        b=LpxjO1Zad2qY6rujVzWP0GirBth091RbK8xP2UE/ld3IjKQxAST6uGDuI1dsI1lJiB
         g5y9taJxS0MnjjgmK5K32OfRuXov5ilY+8GckAecnyCQhNtp55CfwKmv0r+my/qQ5O0l
         9u2qkk0gINK59+biPAW3SIiik6xv9UsoHZv8yeIjy4t4fqezeU0q1g9ixV2g/Qb0GJg7
         5IZqVreFVinw6bIPW78LYODKYNeIwd14CSo6OgAJxGq0pOBd0Cjvzp2YX46zXX2CJW9E
         SHwDjDxZTPGfWpw0MXXjLb7gk0qy0gfEvAFeNM8TQ2lsoGkAqqH+qv1xhhN0GTwbuXig
         IWfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkf/61QM0hugIizipM6Uuq4AHcEFWy8GjKB3/A6ngb7Wd1Um5GHxOrM2NqYt6ISui+UCSfFi/VxI+D930=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN1Uej8UW/1VZHVadREuVNgnZomcWB+NYhjAtqZXe0pztjO8xD
	oRHKD4txayceD5cI2TKSGh6Av1B4TTcxgsKdKnxFUNxzOGUlCRkQ224kIGdistTkgQ==
X-Gm-Gg: ASbGncuhYE9+v7wFhXUMlKd5lfGAzQL/qZNCodL6oM4r0xoy1MU7RiNBz5PvVFEEU8N
	BqyGgPCeLJ4fjIqRUgCbCJS1CEO5YDwXSJOKKtDsOxJc9bhxB3qMW8yAQHbl94fNOjARn0YJR+7
	Asjq6GUPkhgyTaW+HWFT0EYj4DAFYjYfcPV4OErtZ5Igq7LEh+e27aW0KpUC3s3lgrKyt+bsWOx
	T4cG+fiTUw2f+zAVVDkDXmQylnxsFcYqqjH4hF7h2LdHBQvFqwbbFLRDnKYBInC7X6XN2VohDPY
	b6UohlCgMH/SScsn+xXTza4KAUKZ2Qu/sNd7Enico3L8zjwIymNE5KaaPPcKquuirYLmnF3FkmQ
	cyMZSbF9qJ/Ja5ON4+kINSwWYJd35CEuwUgJnuWSMixSUPaFsjNZ0c0I1GB5esF8=
X-Google-Smtp-Source: AGHT+IHFYkFn8z+GUWkNUAawcZ1YV51AhOshm97PW4qM3AjxsaLYtJ0SsbO2jweyVtrKw2JD5LyFpA==
X-Received: by 2002:a05:600c:4251:b0:46e:251:b1c2 with SMTP id 5b1f17b1804b1-46e0251b2b1mr355875e9.7.1758529345943;
        Mon, 22 Sep 2025 01:22:25 -0700 (PDT)
Received: from google.com (157.24.148.146.bc.googleusercontent.com. [146.148.24.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee1095489asm18071631f8f.24.2025.09.22.01.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 01:22:25 -0700 (PDT)
Date: Mon, 22 Sep 2025 08:22:22 +0000
From: Mostafa Saleh <smostafa@google.com>
To: kernel test robot <lkp@intel.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
	robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
	jgg@ziepe.ca, praan@google.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 4/4] iommu/io-pgtable-arm-selftests: Use KUnit
Message-ID: <aNEHPo16_HgyYafz@google.com>
References: <20250919133316.2741279-5-smostafa@google.com>
 <202509201819.f369wBHc-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202509201819.f369wBHc-lkp@intel.com>

On Sat, Sep 20, 2025 at 06:42:59PM +0800, kernel test robot wrote:
> Hi Mostafa,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on soc/for-next]
> [also build test ERROR on linus/master v6.17-rc6 next-20250919]
> [cannot apply to joro-iommu/next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Mostafa-Saleh/iommu-io-pgtable-arm-Simplify-error-prints-for-selftests/20250919-213912
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
> patch link:    https://lore.kernel.org/r/20250919133316.2741279-5-smostafa%40google.com
> patch subject: [PATCH v3 4/4] iommu/io-pgtable-arm-selftests: Use KUnit
> config: i386-randconfig-013-20250920 (https://download.01.org/0day-ci/archive/20250920/202509201819.f369wBHc-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.4.0-5) 12.4.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250920/202509201819.f369wBHc-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202509201819.f369wBHc-lkp@intel.com/
> 
> All error/warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> WARNING: modpost: drivers/iommu/io-pgtable-arm-selftests: section mismatch in reference: arm_lpae_run_tests+0x100 (section: .text) -> arm_lpae_dump_ops (section: .init.text)
> >> ERROR: modpost: "alloc_io_pgtable_ops" [drivers/iommu/io-pgtable-arm-selftests.ko] undefined!
> >> ERROR: modpost: "free_io_pgtable_ops" [drivers/iommu/io-pgtable-arm-selftests.ko] undefined!
> 
> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LPAE
>    Depends on [n]: IOMMU_SUPPORT [=y] && (ARM || ARM64 || COMPILE_TEST [=n]) && !GENERIC_ATOMIC64 [=n]
>    Selected by [m]:
>    - IOMMU_IO_PGTABLE_LPAE_KUNIT_TEST [=m] && IOMMU_SUPPORT [=y] && KUNIT [=m]
> 

There are 2 issues here:
- I missed one __init for dump_ops
- Then new kconfig change to select IOMMU_IO_PGTABLE_LPAE broke build for
  some ARM targets which select GENERIC_ATOMIC64

I will send a new version shortly

Thanks,
Mostafa

> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

