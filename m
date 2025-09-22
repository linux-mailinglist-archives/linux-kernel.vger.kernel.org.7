Return-Path: <linux-kernel+bounces-827287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A57B8B915CC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A487C18A5897
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC6D30C365;
	Mon, 22 Sep 2025 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWNHE1G8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D94430C35D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758547031; cv=none; b=O+Evup7rmCQafb1P9IymFMs3DOmA7mCn0Ycder5FwhbdZSEcfDyo/Ip4uLWIDDkUPXOC2LerC33s5pn1gl+Y+UWy/J1z2pUYxRIXnhb6bp/NU0gGJDVL1fXR4kQ85AqcHKP2kiA8HiLFBJ2759eD9ANQNwANnGJF0widhjoroB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758547031; c=relaxed/simple;
	bh=qwlHTg4aPlAq/HCxAc3/+aeHYqycjOb3rj/8p3g4PnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QD6SkEyYHc2aA+ex4RpzRb2ee15n3onoW2NpEt6lJDuIJ8iMR9Xd5x2UDcmGJ894nFm0nASJ+3VmE24YwclqKKPYlCH2yTE2b539lhy8lg5z0eeqRAY6ng/3glPUvWO25GpBRse38YJg+9yz6zd9qB6+20XXGG1jgdUQBaAtIsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWNHE1G8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45420C113D0;
	Mon, 22 Sep 2025 13:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758547030;
	bh=qwlHTg4aPlAq/HCxAc3/+aeHYqycjOb3rj/8p3g4PnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RWNHE1G8YssERyk1JUnokVu8CrXeaw1eWFhIRuQFSw6pRErrBu+05ocN1tFmTXwgy
	 eaw2JmgICPM2yMS5GZRcFx7CZz2+RFGtM3AAd+H6TmXEejZtMYCvQaIlyIe2SVJBVr
	 ZmetPjKzkSJouyK2Ua+85ZuT546YQ2CJXqaOIt1BffPoo/BJGVRLafjDALG4AVKtVC
	 KzJOtBAvD+Wl5mN4YF1IMRtaJYlfJU0dyufMiABtVAukHFsdgwPNcLiqodRhzERJEO
	 DoxDpJ6ddAq/ZErS+GhzMIz+UqQEUv4+YLDJtuENmujcjJxl70wr+g6UFQQijjCIjZ
	 jnH0axWKI9Vww==
Date: Mon, 22 Sep 2025 14:17:05 +0100
From: Will Deacon <will@kernel.org>
To: Yushan Wang <wangyushan12@huawei.com>
Cc: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	yangyicong@huawei.com, Jonathan.Cameron@huawei.com,
	liuyonglong@huawei.com, wanghuiqiang@huawei.com,
	prime.zeng@hisilicon.com, hejunhao3@h-partners.com,
	linuxarm@huawei.com, fanghao11@huawei.com
Subject: Re: [PATCH v3 5/9] drivers/perf: hisi: Extend the field of tt_core
Message-ID: <aNFMUdPJeJo9XU1e@willie-the-truck>
References: <20250829101427.2557899-1-wangyushan12@huawei.com>
 <20250829101427.2557899-6-wangyushan12@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829101427.2557899-6-wangyushan12@huawei.com>

On Fri, Aug 29, 2025 at 06:14:23PM +0800, Yushan Wang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Currently the tt_core's using config1's bit [7, 0] and can not be
> extended. For some platforms there's more the 8 CPUs sharing the
> L3 cache. So make tt_core use config2's bit [15, 0] and the remaining
> bits in config2 is reserved for extension.
> 
> Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
> ---
>  drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
> index a372dd2c07b5..39444f11cbad 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
> @@ -55,10 +55,10 @@
>  #define L3C_V1_NR_EVENTS	0x59
>  #define L3C_V2_NR_EVENTS	0xFF
>  
> -HISI_PMU_EVENT_ATTR_EXTRACTOR(tt_core, config1, 7, 0);
>  HISI_PMU_EVENT_ATTR_EXTRACTOR(tt_req, config1, 10, 8);
>  HISI_PMU_EVENT_ATTR_EXTRACTOR(datasrc_cfg, config1, 15, 11);
>  HISI_PMU_EVENT_ATTR_EXTRACTOR(datasrc_skt, config1, 16, 16);
> +HISI_PMU_EVENT_ATTR_EXTRACTOR(tt_core, config2, 15, 0);
>  
>  static void hisi_l3c_pmu_config_req_tracetag(struct perf_event *event)
>  {
> @@ -397,7 +397,7 @@ static const struct attribute_group hisi_l3c_pmu_v1_format_group = {
>  
>  static struct attribute *hisi_l3c_pmu_v2_format_attr[] = {
>  	HISI_PMU_FORMAT_ATTR(event, "config:0-7"),
> -	HISI_PMU_FORMAT_ATTR(tt_core, "config1:0-7"),
> +	HISI_PMU_FORMAT_ATTR(tt_core, "config2:0-15"),
>  	HISI_PMU_FORMAT_ATTR(tt_req, "config1:8-10"),
>  	HISI_PMU_FORMAT_ATTR(datasrc_cfg, "config1:11-15"),
>  	HISI_PMU_FORMAT_ATTR(datasrc_skt, "config1:16"),

I'm a _tiny_ bit worried about this change in that it has the potential
to break any users who've hardcoded the 'tt_core' encoding in 'config1'.
Granted, they should be parsing this out of sysfs, but you never know.

If we were going to avoid the possibility of a regression entirely, I
think we'd either need to (a) split the field so that the upper 8 bits
of 'tt_core' live in 'config2' but the bottom 8 bits stay where they
are or (b) leave 'config1:0-7' as an alias of 'config2:0-7'.

The latter is still do-able, as you haven't re-allocated the config1
bits yet.

Will

