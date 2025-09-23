Return-Path: <linux-kernel+bounces-828626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E23B95092
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF9FC19041EE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142F731D393;
	Tue, 23 Sep 2025 08:40:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47A831D733
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758616834; cv=none; b=Nqy1nactBW31xKKio94ZMLqkgLz4LvwfDRbvEJUTqJybL7i5wkcT8eUjhJ7QeRWpEAVoR3YR8haiRTDAojtDaXm+pM3KBLJyQThGW8mo3ppbf0TZrn7reCTS9pykB3TcNpGW/vXUCpYpIr97kBMD85A3owbyaTvXE6oj7OjzMis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758616834; c=relaxed/simple;
	bh=YUKrGPi1KmtXOh7IwelHIni70ayTxeBt0LKTKm51GP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKPRTRMXZ2rNd+TMAnK2EKQNr4GDlD+V4LSoShU1Z03wgK791mwDPnzRnVhmt1duTeMiFbaV2QHQ3FEn7IAeT2vujTQ0dehiaJLuGG7rvoMBUBnlBWZOVmnIWUcL+1g7p0Nf6lBt9ExRz2qidvCSxea/rhM8s3aiEr4OEg899Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6524497;
	Tue, 23 Sep 2025 01:40:23 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E23533F694;
	Tue, 23 Sep 2025 01:40:30 -0700 (PDT)
Date: Tue, 23 Sep 2025 09:40:28 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: gregkh@linuxfoundation.org, dakr@kernel.org, rafael@kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch_topology: Fix incorrect error check in
 topology_parse_cpu_capacity()
Message-ID: <20250923-spectral-rich-shellfish-3ab26c@sudeepholla>
References: <20250923072520.3964688-1-kaushlendra.kumar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923072520.3964688-1-kaushlendra.kumar@intel.com>

On Tue, Sep 23, 2025 at 12:55:20PM +0530, Kaushlendra Kumar wrote:
> Fix incorrect use of PTR_ERR_OR_ZERO() in topology_parse_cpu_capacity()
> which causes the code to proceed with NULL clock pointers. The current
> logic uses !PTR_ERR_OR_ZERO(cpu_clk) which evaluates to true for both
> valid pointers and NULL, leading to potential NULL pointer dereference
> in clk_get_rate().
> 
> PTR_ERR_OR_ZERO(cpu_clk) returns:
> - 0 if cpu_clk is a valid pointer or NULL
> - error code if cpu_clk is an error pointer
> 
> Therefore !PTR_ERR_OR_ZERO(cpu_clk) is true for both valid pointers and
> NULL, causing the code to call clk_get_rate(NULL) when of_clk_get()
> returns NULL. Replace with IS_ERR_OR_NULL() which correctly identifies
> only valid pointers, ensuring clk_get_rate() is called only with valid
> clock objects.
>

Nice catch, wonder how it survived so long unnoticed. I also checked
if PTR_ERR_OR_ZERO() is used in similar way anywhere else. This happens
to be the only occurrence.

I think it needs,

Fixes: b8fe128dad8f ("arch_topology: Adjust initial CPU capacities with current freq")

With that,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
>  drivers/base/arch_topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 1037169abb45..e1eff05bea4a 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -292,7 +292,7 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
>  		 * frequency (by keeping the initial capacity_freq_ref value).
>  		 */
>  		cpu_clk = of_clk_get(cpu_node, 0);
> -		if (!PTR_ERR_OR_ZERO(cpu_clk)) {
> +		if (!IS_ERR_OR_NULL(cpu_clk)) {
>  			per_cpu(capacity_freq_ref, cpu) =
>  				clk_get_rate(cpu_clk) / HZ_PER_KHZ;
>  			clk_put(cpu_clk);
> -- 
> 2.34.1
> 

-- 
Regards,
Sudeep

