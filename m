Return-Path: <linux-kernel+bounces-697939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9C2AE3AC2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 11:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB93618968BF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 09:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDBC239E94;
	Mon, 23 Jun 2025 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fVouHzBo"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA504238144
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 09:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750671460; cv=none; b=RSbFmStM2+ZAO8+W1wgkfHXStzhXaSNQMvBhoJNxqyxNsjKty/+dBeQypY5ZlKtaQa0cgbgROk8JfUorE2le6KnFy0jJ+QI925YxOodsNOoQhCThnTQPNkUUINFEfUGaVvmiv9RIO1erfGid0UThu6ME5XYtxz3t5L49oL0h5Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750671460; c=relaxed/simple;
	bh=ddEAH4GqI8AV5OOFMXUJFW/kDXymbCVLNkhdxfZZ+Iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=kDDoQ/HMju9LsdsKG2M85CKGpkBL7BfNqzQ4kmy1ShczPFpJt2QGHOzFf0ds2Yh5v7qfrnsxYg7RH2EITlufAlyEGgT3nPTBcThlYKOtF2oO1ufYXvuJB3HR8K/lld54NaRut5XKfFipDMmW3dccU2GaoQiOfw9fa/AOVMlCbI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fVouHzBo; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250623093736euoutp0258d59f9777b668a426eed12340669855~Lomn68r953017730177euoutp026
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 09:37:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250623093736euoutp0258d59f9777b668a426eed12340669855~Lomn68r953017730177euoutp026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750671456;
	bh=A+5IcRjSNl6qTqtwlarHYbjTthP/DIVVwhUwdFuoGjY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=fVouHzBovKz06ZjCSTUzzVtvq1/bXcnO6R8VuQS7xqwdD09innDB78O3m+FPkHLQT
	 jCR+MZVCrVaSRAkIqbLUqSBVCpUJaxGHhomvvJVspNLeVVsHSvszjhylVLw61sbF5I
	 ZYoEU7YplN+4hRjKmoHlscC77y4zVCqcTlzmneLE=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250623093735eucas1p2843b624612475c22eb8e1c677b03d9cc~Lomm81wST1776817768eucas1p2q;
	Mon, 23 Jun 2025 09:37:35 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250623093734eusmtip2411fe770a0df6b19f0942a2c666da528~Loml5U_gb0224702247eusmtip2N;
	Mon, 23 Jun 2025 09:37:34 +0000 (GMT)
Message-ID: <c7f8523e-a139-4438-9987-466f415099f8@samsung.com>
Date: Mon, 23 Jun 2025 11:37:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] drm/imagination: Enable PowerVR driver for
 RISC-V
To: kernel test robot <lkp@intel.com>, Drew Fustini <drew@pdp7.com>, Guo Ren
	<guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Philipp Zabel
	<p.zabel@pengutronix.de>, Frank Binns <frank.binns@imgtec.com>, Matt Coster
	<matt.coster@imgtec.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>, Ulf Hansson <ulf.hansson@linaro.org>, Marek
	Szyprowski <m.szyprowski@samsung.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <202506201103.GX6DA9Gx-lkp@intel.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250623093735eucas1p2843b624612475c22eb8e1c677b03d9cc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250620033331eucas1p22011774fc3a362b04e2bb98db2424299
X-EPHeader: CA
X-CMS-RootMailID: 20250620033331eucas1p22011774fc3a362b04e2bb98db2424299
References: <20250618-apr_14_for_sending-v5-8-27ed33ea5c6f@samsung.com>
	<CGME20250620033331eucas1p22011774fc3a362b04e2bb98db2424299@eucas1p2.samsung.com>
	<202506201103.GX6DA9Gx-lkp@intel.com>



On 6/20/25 05:32, kernel test robot wrote:
> Hi Michal,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 4774cfe3543abb8ee98089f535e28ebfd45b975a]
> 
> url:    https://protect2.fireeye.com/v1/url?k=459f4078-1a047974-459ecb37-000babff3563-f67f8714258a7e91&q=1&e=0474f2bc-b688-4260-ae67-33e26f33bf90&u=https%3A%2F%2Fgithub.com%2Fintel-lab-lkp%2Flinux%2Fcommits%2FMichal-Wilczynski%2Fpower-sequencing-Add-T-HEAD-TH1520-GPU-power-sequencer-driver%2F20250618-182429
> base:   4774cfe3543abb8ee98089f535e28ebfd45b975a
> patch link:    https://lore.kernel.org/r/20250618-apr_14_for_sending-v5-8-27ed33ea5c6f%40samsung.com
> patch subject: [PATCH v5 8/8] drm/imagination: Enable PowerVR driver for RISC-V
> config: sparc64-randconfig-r121-20250620 (https://download.01.org/0day-ci/archive/20250620/202506201103.GX6DA9Gx-lkp@intel.com/config)
> compiler: sparc64-linux-gcc (GCC) 8.5.0
> reproduce: (https://download.01.org/0day-ci/archive/20250620/202506201103.GX6DA9Gx-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202506201103.GX6DA9Gx-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/gpu/drm/imagination/pvr_mmu.c:57:3: error: #error Unsupported device page size PVR_DEVICE_PAGE_SIZE
>     # error Unsupported device page size PVR_DEVICE_PAGE_SIZE
>       ^~~~~
>    In file included from ./arch/sparc/include/generated/asm/rwonce.h:1,
>                     from include/linux/compiler.h:390,
>                     from include/linux/dev_printk.h:14,
>                     from include/linux/device.h:15,
>                     from include/linux/node.h:18,
>                     from include/linux/memory.h:19,
>                     from drivers/gpu/drm/imagination/pvr_mmu.h:7,
>                     from drivers/gpu/drm/imagination/pvr_mmu.c:4:
>    drivers/gpu/drm/imagination/pvr_mmu.c: In function 'pvr_page_table_l1_entry_raw_set':
>    drivers/gpu/drm/imagination/pvr_mmu.c:577:50: error: 'ROGUE_MMUCTRL_PAGE_SIZE_X' undeclared (first use in this function); did you mean 'ROGUE_MMUCTRL_PAGE_SIZE_1MB'?
>          PVR_PAGE_TABLE_FIELD_PREP(1, PD, PAGE_SIZE, ROGUE_MMUCTRL_PAGE_SIZE_X) |
>                                                      ^~~~~~~~~~~~~~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:55:33: note: in definition of macro '__WRITE_ONCE'
>      *(volatile typeof(x) *)&(x) = (val);    \
>                                     ^~~
>    drivers/gpu/drm/imagination/pvr_mmu.c:574:2: note: in expansion of macro 'WRITE_ONCE'
>      WRITE_ONCE(entry->val,
>      ^~~~~~~~~~
>    drivers/gpu/drm/imagination/pvr_mmu.c:577:6: note: in expansion of macro 'PVR_PAGE_TABLE_FIELD_PREP'
>          PVR_PAGE_TABLE_FIELD_PREP(1, PD, PAGE_SIZE, ROGUE_MMUCTRL_PAGE_SIZE_X) |
>          ^~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/gpu/drm/imagination/pvr_mmu.c:577:50: note: each undeclared identifier is reported only once for each function it appears in
>          PVR_PAGE_TABLE_FIELD_PREP(1, PD, PAGE_SIZE, ROGUE_MMUCTRL_PAGE_SIZE_X) |
>                                                      ^~~~~~~~~~~~~~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:55:33: note: in definition of macro '__WRITE_ONCE'
>      *(volatile typeof(x) *)&(x) = (val);    \
>                                     ^~~
>    drivers/gpu/drm/imagination/pvr_mmu.c:574:2: note: in expansion of macro 'WRITE_ONCE'
>      WRITE_ONCE(entry->val,
>      ^~~~~~~~~~
>    drivers/gpu/drm/imagination/pvr_mmu.c:577:6: note: in expansion of macro 'PVR_PAGE_TABLE_FIELD_PREP'
>          PVR_PAGE_TABLE_FIELD_PREP(1, PD, PAGE_SIZE, ROGUE_MMUCTRL_PAGE_SIZE_X) |
>          ^~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/gpu/drm/imagination/pvr_mmu.c: In function 'pvr_page_table_l0_entry_raw_set':
>    drivers/gpu/drm/imagination/pvr_mmu.c:741:24: error: 'ROGUE_MMUCTRL_PAGE_X_RANGE_CLRMSK' undeclared (first use in this function); did you mean 'ROGUE_MMUCTRL_PAGE_1MB_RANGE_CLRMSK'?
>               (dma_addr & ~ROGUE_MMUCTRL_PAGE_X_RANGE_CLRMSK) |
>                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:55:33: note: in definition of macro '__WRITE_ONCE'
>      *(volatile typeof(x) *)&(x) = (val);    \
>                                     ^~~
>    drivers/gpu/drm/imagination/pvr_mmu.c:739:2: note: in expansion of macro 'WRITE_ONCE'
>      WRITE_ONCE(entry->val, PVR_PAGE_TABLE_FIELD_PREP(0, PT, VALID, true) |
>      ^~~~~~~~~~
>    drivers/gpu/drm/imagination/pvr_mmu.c: In function 'pvr_page_table_l0_idx':
>    drivers/gpu/drm/imagination/pvr_mmu.c:1713:9: error: 'ROGUE_MMUCTRL_PAGE_X_RANGE_SHIFT' undeclared (first use in this function); did you mean 'ROGUE_MMUCTRL_PAGE_4KB_RANGE_SHIFT'?
>             ROGUE_MMUCTRL_PAGE_X_RANGE_SHIFT;
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>             ROGUE_MMUCTRL_PAGE_4KB_RANGE_SHIFT
>>> drivers/gpu/drm/imagination/pvr_mmu.c:1714:1: warning: control reaches end of non-void function [-Wreturn-type]
>     }

It's clear from the build log that enabling COMPILE_TEST has exposed
some pre existing portability issues in pvr_mmu.c.

Fixing these underlying MMU issues seem to be outside the scope
of this patch series, which is focused on enabling the TH1520 SoC GPU.
To keep this work focused on its original goal, I will remove the
COMPILE_TEST addition for now.

The addition of COMPILE_TEST support can be revisited in a separate,
dedicated series.

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

