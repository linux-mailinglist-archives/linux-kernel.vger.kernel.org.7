Return-Path: <linux-kernel+bounces-655536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2AEABD71E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 13:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AA76179EB3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 11:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1597827C863;
	Tue, 20 May 2025 11:43:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C3B266EEA;
	Tue, 20 May 2025 11:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747741398; cv=none; b=GMpie/t4dqWB0T/uHXWeteBCUhTpqpKtPQ+1g4QKjNzpmCZZjBMPCcDZPLN0g1fPAApu6vQMltLPtdkQKtM5G8D3CTwE2iBVsPEqMdrl/zMgg4sZWvTRTguDNd0n6wy7sP8qmtfTSUXbjmIxTQyEpEXC7T+i9Bl/sbhp0H8w48E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747741398; c=relaxed/simple;
	bh=qr0eZYmHJGO5MdXBVpRR9jra0EGYvmiK9FXIt8YD2kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vdju7ln6Y9vOEjBFTqSDwV30lZFFrU4hfg56hYe/qQgqD9zhbfySpEL5WwTFkYhWREoJJkt5JAbJg60OTouC4GW0Lb0sUEvbc0wTUsP8sMo4wb+9V2dkRA2Xq2QT9Ys4924I/lF0CRoOeHRG2eDoB/qsFRSEYxFiWhsihl9qOTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E8121516;
	Tue, 20 May 2025 04:43:01 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72D593F6A8;
	Tue, 20 May 2025 04:43:14 -0700 (PDT)
Date: Tue, 20 May 2025 12:43:09 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH 07/10] perf: arm_spe: Add support for filtering on data
 source
Message-ID: <20250520114309.GO412060@e132581.arm.com>
References: <20250506-james-perf-feat_spe_eft-v1-0-dd480e8e4851@linaro.org>
 <20250506-james-perf-feat_spe_eft-v1-7-dd480e8e4851@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506-james-perf-feat_spe_eft-v1-7-dd480e8e4851@linaro.org>

On Tue, May 06, 2025 at 12:41:39PM +0100, James Clark wrote:
> SPE_FEAT_FDS adds the ability to filter on the data source of packets.
> Like the other existing filters, enable filtering with PMSFCR_EL1.FDS
> when any of the filter bits are set.
> 
> Each bit maps to data sources 0-63 described by bits[0:5] in the data
> source packet (although the full range of data source is 16 bits so
> higher value data sources can't be filtered on). The filter is an OR of
> all the bits, so for example setting bits 0 and 3 filters packets from
> data sources 0 OR 3.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/perf/arm_spe_pmu.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index 9309b846f642..d04318411f77 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -87,6 +87,7 @@ struct arm_spe_pmu {
>  #define SPE_PMU_FEAT_INV_FILT_EVT		(1UL << 6)
>  #define SPE_PMU_FEAT_DISCARD			(1UL << 7)
>  #define SPE_PMU_FEAT_EFT			(1UL << 8)
> +#define SPE_PMU_FEAT_FDS			(1UL << 9)
>  #define SPE_PMU_FEAT_DEV_PROBED			(1UL << 63)
>  	u64					features;
>  
> @@ -232,6 +233,10 @@ static const struct attribute_group arm_spe_pmu_cap_group = {
>  #define ATTR_CFG_FLD_inv_event_filter_LO	0
>  #define ATTR_CFG_FLD_inv_event_filter_HI	63
>  
> +#define ATTR_CFG_FLD_data_src_filter_CFG	config4	/* PMSDSFR_EL1 */
> +#define ATTR_CFG_FLD_data_src_filter_LO	0
> +#define ATTR_CFG_FLD_data_src_filter_HI	63
> +
>  GEN_PMU_FORMAT_ATTR(ts_enable);
>  GEN_PMU_FORMAT_ATTR(pa_enable);
>  GEN_PMU_FORMAT_ATTR(pct_enable);
> @@ -248,6 +253,7 @@ GEN_PMU_FORMAT_ATTR(float_filter);
>  GEN_PMU_FORMAT_ATTR(float_filter_mask);
>  GEN_PMU_FORMAT_ATTR(event_filter);
>  GEN_PMU_FORMAT_ATTR(inv_event_filter);
> +GEN_PMU_FORMAT_ATTR(data_src_filter);
>  GEN_PMU_FORMAT_ATTR(min_latency);
>  GEN_PMU_FORMAT_ATTR(discard);
>  
> @@ -268,6 +274,7 @@ static struct attribute *arm_spe_pmu_formats_attr[] = {
>  	&format_attr_float_filter_mask.attr,
>  	&format_attr_event_filter.attr,
>  	&format_attr_inv_event_filter.attr,
> +	&format_attr_data_src_filter.attr,
>  	&format_attr_min_latency.attr,
>  	&format_attr_discard.attr,
>  	NULL,
> @@ -286,6 +293,9 @@ static umode_t arm_spe_pmu_format_attr_is_visible(struct kobject *kobj,
>  	if (attr == &format_attr_inv_event_filter.attr && !(spe_pmu->features & SPE_PMU_FEAT_INV_FILT_EVT))
>  		return 0;
>  
> +	if (attr == &format_attr_data_src_filter.attr && !(spe_pmu->features & SPE_PMU_FEAT_FDS))
> +		return 0;
> +
>  	if ((attr == &format_attr_branch_filter_mask.attr ||
>  	     attr == &format_attr_load_filter_mask.attr ||
>  	     attr == &format_attr_store_filter_mask.attr ||
> @@ -406,6 +416,9 @@ static u64 arm_spe_event_to_pmsfcr(struct perf_event *event)
>  	if (ATTR_CFG_GET_FLD(attr, inv_event_filter))
>  		reg |= PMSFCR_EL1_FnE;
>  
> +	if (ATTR_CFG_GET_FLD(attr, data_src_filter))
> +		reg |= PMSFCR_EL1_FDS;
> +
>  	if (ATTR_CFG_GET_FLD(attr, min_latency))
>  		reg |= PMSFCR_EL1_FL;
>  
> @@ -430,6 +443,12 @@ static u64 arm_spe_event_to_pmslatfr(struct perf_event *event)
>  	return FIELD_PREP(PMSLATFR_EL1_MINLAT, ATTR_CFG_GET_FLD(attr, min_latency));
>  }
>  
> +static u64 arm_spe_event_to_pmsdsfr(struct perf_event *event)
> +{
> +	struct perf_event_attr *attr = &event->attr;
> +	return ATTR_CFG_GET_FLD(attr, data_src_filter);
> +}

Seems to me, arm_spe_event_to_pmsdsfr() is not needed as it does not do
any conversion from event config to register value.  So simply read the
field value in opened code would be fine.

I am fine to keep it and would leave SPE driver maintainers to decide
which is preferring.  Otherwise, LGTM:

Reviewed-by: Leo Yan <leo.yan@arm.com>

> +
>  static void arm_spe_pmu_pad_buf(struct perf_output_handle *handle, int len)
>  {
>  	struct arm_spe_pmu_buf *buf = perf_get_aux(handle);
> @@ -788,6 +807,10 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
>  	if (arm_spe_event_to_pmsnevfr(event) & arm_spe_pmsevfr_res0(spe_pmu->pmsver))
>  		return -EOPNOTSUPP;
>  
> +	if (arm_spe_event_to_pmsdsfr(event) &&
> +	    !(spe_pmu->features & SPE_PMU_FEAT_FDS))
> +		return -EOPNOTSUPP;
> +
>  	if (attr->exclude_idle)
>  		return -EOPNOTSUPP;
>  
> @@ -857,6 +880,11 @@ static void arm_spe_pmu_start(struct perf_event *event, int flags)
>  		write_sysreg_s(reg, SYS_PMSNEVFR_EL1);
>  	}
>  
> +	if (spe_pmu->features & SPE_PMU_FEAT_FDS) {
> +		reg = arm_spe_event_to_pmsdsfr(event);
> +		write_sysreg_s(reg, SYS_PMSDSFR_EL1);
> +	}
> +
>  	reg = arm_spe_event_to_pmslatfr(event);
>  	write_sysreg_s(reg, SYS_PMSLATFR_EL1);
>  
> @@ -1116,6 +1144,9 @@ static void __arm_spe_pmu_dev_probe(void *info)
>  	if (FIELD_GET(PMSIDR_EL1_EFT, reg))
>  		spe_pmu->features |= SPE_PMU_FEAT_EFT;
>  
> +	if (FIELD_GET(PMSIDR_EL1_FDS, reg))
> +		spe_pmu->features |= SPE_PMU_FEAT_FDS;
> +
>  	/* This field has a spaced out encoding, so just use a look-up */
>  	fld = FIELD_GET(PMSIDR_EL1_INTERVAL, reg);
>  	switch (fld) {
> 
> -- 
> 2.34.1
> 

