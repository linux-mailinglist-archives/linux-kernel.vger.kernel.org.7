Return-Path: <linux-kernel+bounces-851213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AE8BD5CA7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7133A4EB45B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D9E2D7DF6;
	Mon, 13 Oct 2025 18:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhzMZV9z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9771CA84;
	Mon, 13 Oct 2025 18:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760381570; cv=none; b=qIQhvTfMjVBLbNmDXSQidwWpWGRSUXt8Un8ha+8BQnw6n8XI1aG0H3bL9wKj7YSHYlYR2wr8ZzoqmyvReyWMsuQy1K/CxtDSY1+oNetOWIvtWYwYlZx6NXEkES2Elco/QVO1fYNIiwXPLhfWVrkSs+rJDsSkmUd6GyG9C7H+xzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760381570; c=relaxed/simple;
	bh=4sLL6G9jYZeZ+/pZ2rSnKZ59x5jDuXto1TmO7MozFPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sEk3ZwxO1c5Y7e2vkav2l4+krRX58VOxwFS8yCai6NF0ZsoCGlER+wOmL392vBfAQw5k6ZrhN/ensTX0Wig++qYff9ZQkZyAN0SsZfikJepwWYF4Rci8TwbZFIL1oALJ2KqhfNoVuurLNUWnMUyo4gD26POABuJnsjpmWdwaVY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhzMZV9z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3EEC4CEE7;
	Mon, 13 Oct 2025 18:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760381569;
	bh=4sLL6G9jYZeZ+/pZ2rSnKZ59x5jDuXto1TmO7MozFPA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DhzMZV9z9B0OWYwW3D7cHJanbkQPi4QmaN1BUHS/pMyuJ3QBinF4kjBImdPRjZWpN
	 R3BzFMr5+Wq3JPNkjlihMlm+d/eW38a9GNf79NJSB0E8nmscVlw30Gn2x91/LAw/qR
	 HgLucqjA+PQm2729kak7FQkeRQZteP07+5+77ttXEB+GkQSpTQnP6cVx8rt7SGPoK8
	 AfuFdWC0hmnrEyg/m1HK7W4xrDN5vrdp1BKa6HTTAyfSttjwB1e5LiySTR7BmB0DOW
	 aRvMq+9F/M9mqVcBWqug9JjeFZ6G/qgHuCaJQGwAsx8G95w+t9WTYg9Xx4dH/9sM0F
	 IgHfStEpNOVNQ==
Message-ID: <b35783d1-c676-4c66-8a50-627883ff2c3b@kernel.org>
Date: Mon, 13 Oct 2025 13:52:48 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] platform/x86/amd: hfi: Remove unused cpumask from
 cpuinfo struct
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: perry.yuan@amd.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com,
 jserv@ccns.ncku.edu.tw, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251011063837.2318535-1-visitorckw@gmail.com>
 <20251011063837.2318535-2-visitorckw@gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20251011063837.2318535-2-visitorckw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/11/25 1:38 AM, Kuan-Wei Chiu wrote:
> The cpus field within the struct amd_hfi_cpuinfo was allocated and set
> in the amd_hfi_online() CPU hotplug callback, and subsequently freed in
> the amd_hfi_offline() callback.
> 
> However, after being initialized, this cpumask was never read or used
> for any purpose within the driver. It represents dead code that serves
> no functional role.
> 
> This change has no impact on the driver's functionality as the removed
> code was entirely superfluous.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> Build test only.

Thanks, this LGTM.  There is other code that was going to use these, but 
it's not upstream ready still.  If we end up using them we can bring 'em 
back later.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

> 
>   drivers/platform/x86/amd/hfi/hfi.c | 10 ----------
>   1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
> index a465ac6f607e..5d5d2cf23a75 100644
> --- a/drivers/platform/x86/amd/hfi/hfi.c
> +++ b/drivers/platform/x86/amd/hfi/hfi.c
> @@ -12,7 +12,6 @@
>   
>   #include <linux/acpi.h>
>   #include <linux/cpu.h>
> -#include <linux/cpumask.h>
>   #include <linux/debugfs.h>
>   #include <linux/gfp.h>
>   #include <linux/init.h>
> @@ -95,7 +94,6 @@ struct amd_hfi_classes {
>    * struct amd_hfi_cpuinfo - HFI workload class info per CPU
>    * @cpu:		CPU index
>    * @apic_id:		APIC id of the current CPU
> - * @cpus:		mask of CPUs associated with amd_hfi_cpuinfo
>    * @class_index:	workload class ID index
>    * @nr_class:		max number of workload class supported
>    * @ipcc_scores:	ipcc scores for each class
> @@ -106,7 +104,6 @@ struct amd_hfi_classes {
>   struct amd_hfi_cpuinfo {
>   	int		cpu;
>   	u32		apic_id;
> -	cpumask_var_t	cpus;
>   	s16		class_index;
>   	u8		nr_class;
>   	int		*ipcc_scores;
> @@ -295,11 +292,6 @@ static int amd_hfi_online(unsigned int cpu)
>   
>   	guard(mutex)(&hfi_cpuinfo_lock);
>   
> -	if (!zalloc_cpumask_var(&hfi_info->cpus, GFP_KERNEL))
> -		return -ENOMEM;
> -
> -	cpumask_set_cpu(cpu, hfi_info->cpus);
> -
>   	ret = amd_hfi_set_state(cpu, true);
>   	if (ret)
>   		pr_err("WCT enable failed for CPU %u\n", cpu);
> @@ -329,8 +321,6 @@ static int amd_hfi_offline(unsigned int cpu)
>   	if (ret)
>   		pr_err("WCT disable failed for CPU %u\n", cpu);
>   
> -	free_cpumask_var(hfi_info->cpus);
> -
>   	return ret;
>   }
>   


