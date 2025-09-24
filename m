Return-Path: <linux-kernel+bounces-830403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7D0B99905
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0EEC4C3B94
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271DF2E6100;
	Wed, 24 Sep 2025 11:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s39B4XWh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E802E11A6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758712921; cv=none; b=jr+ptJj58oHK/DPn9F+GCOeb/YKGQ8DJpXJDqcQTky1I9zJb7eORNz2+7likFiU8Ke4cD91yJpR4eiWB9wzDI6UgYIHROssEZzXKTa9AjQ9/Fh40IJPWAsWP3vNlbahVsDW702XuF3PZzY9pmC6N/znczp25ff0KQtxBy4QBecU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758712921; c=relaxed/simple;
	bh=X7GIGF2FsHIBZtxGFEtJeOu9snmHHyv0w2PWFjS9Qgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCNZuYIy7lNSsESx/OrOGTPkibYeOWlwf1GVy6oFD9UqHyhf929rgte4eqbUJihRYnf9gXysWI3HBY85f7R2WXEKM8D0TAs0Hah7FPf5hX2Ht2LK7jw4IoYSJ+5uyklI+BAJzG2Bp3yV/b4gvJLRuRkXfzrgO4B17iiw8FnOnP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s39B4XWh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CCFC4CEF0;
	Wed, 24 Sep 2025 11:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758712921;
	bh=X7GIGF2FsHIBZtxGFEtJeOu9snmHHyv0w2PWFjS9Qgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s39B4XWh9JRah+ZAUcjPHW2yD9vovdGwxH8YMl7ATmxflxxhVFa3jkS4bi+x2461v
	 DMhKUBVhWjxbkCcSWJoW1FNvG13n+f03NL5y+gZKSkB72Zj0Avh2/MMIvRF1G/f10T
	 LM2rUFsnZDcdbuJcCYqwTIaQCh99pFaxoTbxKtA/9NuMEwLpVRDbO4oUNUbDDeVKG9
	 6brUMHEjRNho9/i8UKZB0pVvwFiJjCFRbUkH6p4ELmpl8F8YATybQZZRmolcRLQi36
	 RlChf13e6Ak06R40yk5iYFulIOX800XdQ2RH7zaPHoHwM3XS69i4dIsctIfAb4WSb4
	 WcIAyA3xxQ7hA==
Date: Wed, 24 Sep 2025 12:19:31 +0100
From: Will Deacon <will@kernel.org>
To: Yicong Yang <yangyicong@huawei.com>
Cc: Yushan Wang <wangyushan12@huawei.com>, Jonathan.Cameron@huawei.com,
	yangyicong@hisilicon.com, mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, liuyonglong@huawei.com,
	wanghuiqiang@huawei.com, prime.zeng@hisilicon.com,
	hejunhao3@h-partners.com, linuxarm@huawei.com, fanghao11@huawei.com
Subject: Re: [PATCH v3 5/9] drivers/perf: hisi: Extend the field of tt_core
Message-ID: <aNPTwxnlXGbazFLR@willie-the-truck>
References: <20250829101427.2557899-1-wangyushan12@huawei.com>
 <20250829101427.2557899-6-wangyushan12@huawei.com>
 <aNFMUdPJeJo9XU1e@willie-the-truck>
 <3cc3fcdf-436a-9e73-a377-ed896d07a825@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cc3fcdf-436a-9e73-a377-ed896d07a825@huawei.com>

On Tue, Sep 23, 2025 at 03:31:15PM +0800, Yicong Yang wrote:
> diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
> index bbd81a43047d..a52d98f1ed34 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
> @@ -57,6 +57,11 @@
>  #define L3C_V2_NR_EVENTS	0xFF
> 
>  HISI_PMU_EVENT_ATTR_EXTRACTOR(ext, config, 17, 16);
> +/*
> + * Remain the config1:0-7 for backward compatibility if some existing users
> + * hardcode the config1:0-7 directly without parsing the sysfs attribute.
> + */
> +HISI_PMU_EVENT_ATTR_EXTRACTOR(tt_core_deprecated, config1, 7, 0);
>  HISI_PMU_EVENT_ATTR_EXTRACTOR(tt_req, config1, 10, 8);
>  HISI_PMU_EVENT_ATTR_EXTRACTOR(datasrc_cfg, config1, 15, 11);
>  HISI_PMU_EVENT_ATTR_EXTRACTOR(datasrc_skt, config1, 16, 16);
> @@ -95,6 +100,21 @@ static bool support_ext(struct hisi_l3c_pmu *pmu)
>  	return l3c_pmu_ext->support_ext;
>  }
> 
> +/*
> + * tt_core was extended to cover all the CPUs sharing the L3 and was moved from
> + * config1:0-7 to config2:0-*. Try it first and fallback to tt_core_deprecated
> + * if user's still using the deprecated one.
> + */
> +static u32 hisi_l3c_pmu_get_tt_core(struct perf_event *event)
> +{
> +	u32 core = hisi_get_tt_core(event);
> +
> +	if (core)
> +		return core;
> +
> +	return hisi_get_tt_core_deprecated(event);
> +}

Perhaps we should be stricter about this and fail validation for events
that specify both a non-zero tt_core and a non-zero tt_core_deprecated?

Will

