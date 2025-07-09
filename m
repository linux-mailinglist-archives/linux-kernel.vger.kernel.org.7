Return-Path: <linux-kernel+bounces-723227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE3FAFE4A5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07F864A3A55
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878DA288528;
	Wed,  9 Jul 2025 09:54:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690132877F4;
	Wed,  9 Jul 2025 09:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752054894; cv=none; b=lZyzcO4TmSSTC/5alizeTTnbDwiWWtIYPZDLWw68VpzSwhj3PM1SIWcjkbvJjuHod9QhSSQayt5vK17YRU3xvNJmAsjRFW4+KFTBoQMWjyVwS3MGCudinYyuu1YVM/BEwWGzgHkRtQTBplK9rM1tf2tsegBcCSZZVbTUPvOg5AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752054894; c=relaxed/simple;
	bh=nFr811HkLUTfWvgeMmQs3NpQQAVr/xLDkDi7T+QTvIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsAJ0ZhqBjyz0trw9aVeW1e5PBDDJe5fTnu/E9KyQH5caaOM3logmFdBRMywZwQo6HaBwInAFO8ATeqw9K78Fucdyh6PTITVzqj9FAxD1W6WppIKWQoZ8h6tkrBBL6qTpic7dPFot/4hBdGVBET/Qu2SnTY/7BPNBr3Gv+fuw6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CB3B153B;
	Wed,  9 Jul 2025 02:54:40 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17D243F694;
	Wed,  9 Jul 2025 02:54:47 -0700 (PDT)
Date: Wed, 9 Jul 2025 10:53:57 +0100
From: Joey Gouly <joey.gouly@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, leo.yan@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v3 05/10] KVM: arm64: Add trap configs for PMSDSFR_EL1
Message-ID: <20250709095357.GA2715835@e124191.cambridge.arm.com>
References: <20250605-james-perf-feat_spe_eft-v3-0-71b0c9f98093@linaro.org>
 <20250605-james-perf-feat_spe_eft-v3-5-71b0c9f98093@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605-james-perf-feat_spe_eft-v3-5-71b0c9f98093@linaro.org>

Hi James!

On Thu, Jun 05, 2025 at 11:49:03AM +0100, James Clark wrote:
> SPE data source filtering (SPE_FEAT_FDS) adds a new register
> PMSDSFR_EL1, add the trap configs for it. PMSNEVFR_EL1 was also missing
> its VNCR offset so add it along with PMSDSFR_EL1.
> 

A (well behaving) guest won't try access this because:
The presence of PMSDSFR_EL1 is checked by accessing PMSDSFR_EL1.FDS, which is
currently `undef_access` and we hide SPE from the guest in
read_sanitised_id_aa64dfr0_el1().

So makes sense it is just undef!

Reviewed-by: Joey Gouly <joey.gouly@arm.com>

Thanks,
Joey

> Tested-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  arch/arm64/include/asm/vncr_mapping.h | 2 ++
>  arch/arm64/kvm/emulate-nested.c       | 1 +
>  arch/arm64/kvm/sys_regs.c             | 1 +
>  3 files changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/vncr_mapping.h b/arch/arm64/include/asm/vncr_mapping.h
> index 6f556e993644..dba0e58a5fac 100644
> --- a/arch/arm64/include/asm/vncr_mapping.h
> +++ b/arch/arm64/include/asm/vncr_mapping.h
> @@ -92,6 +92,8 @@
>  #define VNCR_PMSICR_EL1         0x838
>  #define VNCR_PMSIRR_EL1         0x840
>  #define VNCR_PMSLATFR_EL1       0x848
> +#define VNCR_PMSNEVFR_EL1       0x850
> +#define VNCR_PMSDSFR_EL1        0x858
>  #define VNCR_TRFCR_EL1          0x880
>  #define VNCR_MPAM1_EL1          0x900
>  #define VNCR_MPAMHCR_EL2        0x930
> diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
> index 3a384e9660b8..60bd8b7f0e5b 100644
> --- a/arch/arm64/kvm/emulate-nested.c
> +++ b/arch/arm64/kvm/emulate-nested.c
> @@ -1174,6 +1174,7 @@ static const struct encoding_to_trap_config encoding_to_cgt[] __initconst = {
>  	SR_TRAP(SYS_PMSIRR_EL1,		CGT_MDCR_TPMS),
>  	SR_TRAP(SYS_PMSLATFR_EL1,	CGT_MDCR_TPMS),
>  	SR_TRAP(SYS_PMSNEVFR_EL1,	CGT_MDCR_TPMS),
> +	SR_TRAP(SYS_PMSDSFR_EL1,	CGT_MDCR_TPMS),
>  	SR_TRAP(SYS_TRFCR_EL1,		CGT_MDCR_TTRF),
>  	SR_TRAP(SYS_TRBBASER_EL1,	CGT_MDCR_E2TB),
>  	SR_TRAP(SYS_TRBLIMITR_EL1,	CGT_MDCR_E2TB),
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index a6cf2888d150..4a88ba15c7df 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -3008,6 +3008,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>  	{ SYS_DESC(SYS_PMBLIMITR_EL1), undef_access },
>  	{ SYS_DESC(SYS_PMBPTR_EL1), undef_access },
>  	{ SYS_DESC(SYS_PMBSR_EL1), undef_access },
> +	{ SYS_DESC(SYS_PMSDSFR_EL1), undef_access },
>  	/* PMBIDR_EL1 is not trapped */
>  
>  	{ PMU_SYS_REG(PMINTENSET_EL1),
> 
> -- 
> 2.34.1
> 

