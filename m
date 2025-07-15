Return-Path: <linux-kernel+bounces-731976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E459BB0608E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 885551C4240E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE552EE610;
	Tue, 15 Jul 2025 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3NGqv8d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF99026D4F2
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587790; cv=none; b=Vf93Ss30Sr0OVPEEsMHYq+EKdFh9ZxnefpSGAZIlEZ3mB0d5sJ5dFufnJ+mFOPDgUOezOTZ5dwa4D+WT4ViX6SS9rVecMdFO1qS6BHH1AMRalufatcI8CpLO1uLYw98E9P6hG2snVOgHXe2DeaG3QGbfoUR15iylxSAMpiwTKXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587790; c=relaxed/simple;
	bh=lxGBZXNmhK90ryWWn0M7PYKuPCR44PJj8beihaNQ+Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ed1BqRyfHXcWfFlYV3bCxzFzX8l4+MhyOz2CHcZDFD9stz5tcN3U9opvwWMkAApIJwqk+eGx0O+fi4xtv44wateejJ7lS2SHx4/VEjJjeYfwtekRe8ifK9igq1mWpa5nw/a594HFU+0Gx8NU2GXTFVamr2Tc4TJluixEUOUTEFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3NGqv8d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E40BC4CEF4;
	Tue, 15 Jul 2025 13:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752587789;
	bh=lxGBZXNmhK90ryWWn0M7PYKuPCR44PJj8beihaNQ+Ew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i3NGqv8dP/JBoVgVbxCCriGVEnXIwsXQfxcVZH2gydseuhgM9yWEXUVeD3GCL3mkw
	 TtY4K48KM5pXNdqg905NST600zSShNNGVZO7c0gTifOhgkNTbQZzr5auV7gqM5vibo
	 pYDGkhc5+HyRCBcXnhdN10vOoQMH9jMglQBISlSzYrYaZU5WR12tMtDIYUZ9X/d3cS
	 Mzohib4qA6a3F2hukyo8bJ8aKvK3F0JyuRca3v2pJbkK8U2iPbCx2A8txLIVyjRYfX
	 IsTjmXL47ylLpM8pmseKsqNdXXiQCaCSWYq6mqaZ+8eMh2jt4nXA89Zw70cEYa5zW1
	 Gwp2cu3KywxRA==
Date: Tue, 15 Jul 2025 14:56:24 +0100
From: Will Deacon <will@kernel.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	sami.mujawar@arm.com, aneesh.kumar@kernel.org, steven.price@arm.com,
	linux-kernel@vger.kernel.org, sudeep.holla@arm.com
Subject: Re: [PATCH 3/3] arm64: acpi: Enable ACPI CCEL support
Message-ID: <aHZeCKNyDeZEsuCt@willie-the-truck>
References: <20250613111153.1548928-1-suzuki.poulose@arm.com>
 <20250613111153.1548928-4-suzuki.poulose@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613111153.1548928-4-suzuki.poulose@arm.com>

On Fri, Jun 13, 2025 at 12:11:53PM +0100, Suzuki K Poulose wrote:
> ACPI CCEL memory area is reported as Non-Volatile storage area. Map it as
> PAGE_KERNEL.

It would be helpful to have a citation for that. I've tried digging it
out of the ACPI spec, but that pointed me to the Intel TDX site and I
got lost in whitepapers :/

> Cc: Sami Mujawar <sami.mujawar@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/kernel/acpi.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index b9a66fc146c9..f52439d411a0 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -356,6 +356,11 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
>  			prot = PAGE_KERNEL_RO;
>  			break;
>  
> +		case EFI_ACPI_MEMORY_NVS:
> +			/* Non-volatile storage, required for CCEL */
> +			prot = PAGE_KERNEL;

By "storage" you just mean memory, right?

Will

