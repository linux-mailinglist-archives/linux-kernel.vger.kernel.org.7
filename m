Return-Path: <linux-kernel+bounces-822754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBEAB84971
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 536C73AB117
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD45191F72;
	Thu, 18 Sep 2025 12:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKhAH4sT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CD034BA3B;
	Thu, 18 Sep 2025 12:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758198715; cv=none; b=e7MKOrf70dFOgAeM53Bb2VsYXcRD+2gEuq7RmDr/Q0+yxHuqbFAMQw9zwZx7iWnxaAaBOy4Nhl51veQ2F5ktkt2tRxYcRappOiYrbxvsHlz//r8e9w9+0eMjs/lxpcghy0mLTGaAfy2s71Cjy6wzdRg/VlZ7R54dkTruvbqw+i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758198715; c=relaxed/simple;
	bh=9YE8xRlSzp0qtaXULH+Q+S0tyjvcR7V5a6iVKARxGWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRn50q+aczcOBk5C6i/Nn1O7It0MTcqC8X73JbfeueDZP8wZPfx4HBrsovjRVtskUBmEqEvE1L8zF5DgUs4oEeusmZ2fZV+SOXLwrpD/UbS15NMA5xMv5PojU80nO2P/yYj5zOhxq8tK5YoGON4nfnbp4tt2rHWCRLRwlPm5I5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKhAH4sT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABDBC4AF09;
	Thu, 18 Sep 2025 12:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758198715;
	bh=9YE8xRlSzp0qtaXULH+Q+S0tyjvcR7V5a6iVKARxGWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QKhAH4sTdDcS42MZJjyQjOGuZgD3/4jy171TaLbjCTGU3FRaZc4/90465vNUoGnlV
	 /gv1qZUHGvREwprA6mY4T0RuAFcIbLvJsqNe/lMntY+4WpUwwVymsoFERsgiQVBTnD
	 Zp+OjcIaDNgtSSTVqX9enOeXx2njaLZJ/AO6dlLz9PMDBCzh7alQPxshl3UaOH6Psb
	 ayRPpeoDbYC4okqeVsaBvb8s8dNs3q7awhNnOTKyjEYrgUFK4eSRnnqvXR1L2bjkkf
	 bxydSLbYzzJYarwnd859HDu/IBnu0dQmK1qgZWogRAD99nR3eT91Cn4AEcY4ROpsNO
	 nqo1EiabPe0Tw==
Date: Thu, 18 Sep 2025 13:31:49 +0100
From: Will Deacon <will@kernel.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, catalin.marinas@arm.com,
	gshan@redhat.com, aneesh.kumar@kernel.org, sami.mujawar@arm.com,
	sudeep.holla@arm.com, steven.price@arm.com
Subject: Re: [PATCH v2 3/3] arm64: acpi: Enable ACPI CCEL support
Message-ID: <aMv7tbA3JGd7ZcbW@willie-the-truck>
References: <20250908223519.1759020-1-suzuki.poulose@arm.com>
 <20250908223519.1759020-4-suzuki.poulose@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908223519.1759020-4-suzuki.poulose@arm.com>

On Mon, Sep 08, 2025 at 11:35:19PM +0100, Suzuki K Poulose wrote:
> Add support for ACPI CCEL by handling the EfiACPIMemoryNVS type memory.
> As per UEFI specifications NVS memory is reserved for Firmware use even
> after exiting boot services. Thus map the region as read-only.
> 
> Cc: Sami Mujawar <sami.mujawar@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v1
>  - Map NVS region as read-only, update comment to clarify that the region
>    is reserved for firmware use.
> 
> ---
>  arch/arm64/kernel/acpi.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index 4d529ff7ba51..93b70f48a51f 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -360,6 +360,17 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
>  			prot = PAGE_KERNEL_RO;
>  			break;
>  
> +		case EFI_ACPI_MEMORY_NVS:
> +			/*
> +			 * ACPI NVS marks an area reserved for use by the
> +			 * firmware, even after exiting the boot service.
> +			 * This may be used by the firmware for sharing dynamic
> +			 * tables/data (e.g., ACPI CCEL) with the OS. Map it
> +			 * as read-only.
> +			 */
> +			prot = PAGE_KERNEL_RO;
> +			break;
> +

Shouldn't this be merged with the other case handling read-only mappings?
e.g. something like:

		switch (region->type) {
		case EFI_LOADER_CODE:
		case EFI_LOADER_DATA:
		case EFI_BOOT_SERVICES_CODE:
		case EFI_BOOT_SERVICES_DATA:
		case EFI_CONVENTIONAL_MEMORY:
		case EFI_PERSISTENT_MEMORY:
			if (memblock_is_map_memory(phys) ||
			    !memblock_is_region_memory(phys, size)) {
				pr_warn(FW_BUG "requested region covers kernel memory @ %pa\n", &phys);
				return NULL;
			}
			/*
			 * Mapping kernel memory is permitted if the region in
			 * question is covered by a single memblock with the
			 * NOMAP attribute set: this enables the use of ACPI
			 * table overrides passed via initramfs, which are
			 * reserved in memory using arch_reserve_mem_area()
			 * below. As this particular use case only requires
			 * read access, fall through to the R/O mapping case.
			 */
			fallthrough;

		case EFI_RUNTIME_SERVICES_CODE:
			/*
			 * This would be unusual, but not problematic per se,
			 * as long as we take care not to create a writable
			 * mapping for executable code.
			 */
			fallthrough;

		case EFI_ACPI_MEMORY_NVS:
			/*
			 * ACPI NVS marks an area reserved for use by the
			 * firmware, even after exiting the boot service.
			 * This may be used by the firmware for sharing dynamic
			 * tables/data (e.g., ACPI CCEL) with the OS. Map it
			 * as read-only.
			 */
			prot = PAGE_KERNEL_RO;
			break;


With that, I'm happy to pick up the series (let me know if you want me
to make the change above locally to save you a resend).

Will

