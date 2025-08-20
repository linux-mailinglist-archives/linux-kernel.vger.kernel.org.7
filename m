Return-Path: <linux-kernel+bounces-777847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6D6B2DE7A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE83189A9EB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FA41D6195;
	Wed, 20 Aug 2025 13:53:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9972D1A9FB5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 13:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755698005; cv=none; b=eWbZileEAZtAXL3hITvkb9fmdLcMdbybcr0Qxr3eu8E2ZYUJfXwX7Vy47cFVuvSW53ahdSpq34JYxs1a2lB3OsfC3+WYigeBGUOcxrnJeeJ8inFj0bOpInOsM4tmN3WP0FkfP4r0VtJmkXHUR88qF1wmhPZoPArFSo620cMrJ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755698005; c=relaxed/simple;
	bh=k4GwsWLqDfFVA8BBIrdKPqII7sa00eXmkGduE3C7iQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lO54qbne85sZ92mubKAW9aFIVCwUm1g80fYFDrwbs2gzCk1x/WJ6dWYZus2Rh4O2r6ao5tUZXP3jiqk/I54YZP6BBE3YpubdIvBm+RkextFuPWpZ0fmpI1Wz4/zWGyltIYw5txmwhNACBNFPTGjah41l1xGyKIW97KyFfPYz+cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDC031D31;
	Wed, 20 Aug 2025 06:53:14 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 040873F63F;
	Wed, 20 Aug 2025 06:53:20 -0700 (PDT)
Date: Wed, 20 Aug 2025 14:53:18 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] firmware: imx: Add stub functions for SCMI CPU API
Message-ID: <aKXTTqoIBAMWbeCI@pluto>
References: <20250807-imx9-sm-v1-0-3489e41a6fda@nxp.com>
 <20250807-imx9-sm-v1-3-3489e41a6fda@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807-imx9-sm-v1-3-3489e41a6fda@nxp.com>

On Thu, Aug 07, 2025 at 09:47:44AM +0800, Peng Fan wrote:
> To ensure successful builds when CONFIG_IMX_SCMI_CPU_DRV is not enabled,
> this patch adds static inline stub implementations for the following
> functions:
> 
>   - scmi_imx_cpu_start()
>   - scmi_imx_cpu_started()
>   - scmi_imx_cpu_reset_vector_set()
> 
> These stubs return -EOPNOTSUPP to indicate that the functionality is not
> supported in the current configuration. This avoids potential build or
> link errors in code that conditionally calls these functions based on
> feature availability.
> 
> Fixes: 1055faa5d660 ("firmware: imx: Add i.MX95 SCMI CPU driver")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  include/linux/firmware/imx/sm.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/include/linux/firmware/imx/sm.h b/include/linux/firmware/imx/sm.h
> index f2a72177bb37c1d46145a60710e3809641e0f5a2..a33b45027356751f4b8ad9b9136f0dd302a82520 100644
> --- a/include/linux/firmware/imx/sm.h
> +++ b/include/linux/firmware/imx/sm.h
> @@ -41,10 +41,28 @@ static inline int scmi_imx_misc_ctrl_set(u32 id, u32 val)
>  }
>  #endif
>  
> +#if IS_ENABLED(CONFIG_IMX_SCMI_CPU_DRV)
>  int scmi_imx_cpu_start(u32 cpuid, bool start);
>  int scmi_imx_cpu_started(u32 cpuid, bool *started);
>  int scmi_imx_cpu_reset_vector_set(u32 cpuid, u64 vector, bool start, bool boot,
>  				  bool resume);
> +#else
> +static inline int scmi_imx_cpu_start(u32 cpuid, bool start)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int scmi_imx_cpu_started(u32 cpuid, bool *started)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int scmi_imx_cpu_reset_vector_set(u32 cpuid, u64 vector, bool start,
> +						bool boot, bool resume)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif

LGTM.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

