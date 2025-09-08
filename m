Return-Path: <linux-kernel+bounces-805685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E72CEB48C4A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D2BC17658B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57863299920;
	Mon,  8 Sep 2025 11:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1ZZpm+j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC37D1E1E19;
	Mon,  8 Sep 2025 11:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757331336; cv=none; b=Umly6ELCVi4eDlj0pgg95oOz4iteY8Ol5+qPAarBinvQzZICNnjhOALG6nqvB9fkdfGHL7PEQw1/WtWWkhxmJ59jRl0Dvxd0uZzTCIDjFa/w2yN2MPspIHgmflAD8tzl96uGDDUAy/64MuLshAG+4IxTOtQho/780vbzPjXwez4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757331336; c=relaxed/simple;
	bh=FqvTpKoAL4sbdB9E3kCKVZwWGdTsIkbto1wVMKUNI30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EV+ixeiZflQ0B1j1rbN8bL/xsnuz3MgBYeqQZs603WetSg949mz1m90U4CStfDQspnc1aiiOyG0E7i8vUfztLJZ0XCB4t47dnFgYyygLufs02fKgd8bdvhxo3leP8ZHpZWvI/sIR6n6zzCFXBWMrgXHZQ3MLYtaeZRCq/OaxTYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1ZZpm+j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1002C4CEF1;
	Mon,  8 Sep 2025 11:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757331336;
	bh=FqvTpKoAL4sbdB9E3kCKVZwWGdTsIkbto1wVMKUNI30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H1ZZpm+jY44sJchL9i8k82WM+dUfGroOmG68PnFpdeKf9Zzsz4+yPlv4EHp2idD9o
	 l5mFE87BTM3P4VNmJJsZit2hlzEdmLLz20esv9AhZdUk0KsfLvnl7vnWkOnQkMEbmN
	 VfQGa2j46E3KzKrEleaDEJm6nQ44GPnM8OtwYoJdl0aNwOa3sogs7zI20qQpypEMQ9
	 hxlI7/USQQ2eeG5DP4e5EM0Lo4cdtz+yv8NJrxvNkVyIKQLFgBlZkgG0/PS2Wu7NRD
	 WT4dVRe98DalzpCUDje/nz6JypAjwum8FmYnEZPDhuHE83EEfyOMHDz3EtI4WdvpMj
	 MrTm2cdDFOJ/A==
Date: Mon, 8 Sep 2025 12:35:29 +0100
From: Will Deacon <will@kernel.org>
To: Huang Shijie <shijie@os.amperecomputing.com>
Cc: catalin.marinas@arm.com, corbet@lwn.net, patches@amperecomputing.com,
	cl@linux.com, yang@os.amperecomputing.com,
	akpm@linux-foundation.org, paulmck@kernel.org, rostedt@goodmis.org,
	Neeraj.Upadhyay@amd.com, bp@alien8.de, ardb@kernel.org,
	anshuman.khandual@arm.com, suzuki.poulose@arm.com, gshan@redhat.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, rdunlap@infradead.org,
	Christoph Lameter <cl@gentwo.org>
Subject: Re: [PATCH V6 1/2] arm64: refactor the rodata=xxx
Message-ID: <aL6_gZWeqAGZjda2@willie-the-truck>
References: <20250703094212.20294-1-shijie@os.amperecomputing.com>
 <20250703094212.20294-2-shijie@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703094212.20294-2-shijie@os.amperecomputing.com>

On Thu, Jul 03, 2025 at 05:42:11PM +0800, Huang Shijie wrote:
> As per admin guide documentation, "rodata=on" should be the default on
> platforms. Documentation/admin-guide/kernel-parameters.txt describes
> these options as
> 
>    rodata=         [KNL,EARLY]
>            on      Mark read-only kernel memory as read-only (default).
>            off     Leave read-only kernel memory writable for debugging.
>            full    Mark read-only kernel memory and aliases as read-only
>                    [arm64]
> 
> But on arm64 platform, "rodata=full" is the default instead.

Please mention RODATA_FULL_DEFAULT_ENABLED here.

> This patch implements the following changes.
> 
>  - Make "rodata=on" behaviour same as the original "rodata=full"

You should mention that this gives us parity with x86.

>  - Make "rodata=noalias" (new) behaviour same as the original "rodata=on"
>  - Drop the original "rodata=full"

>  - Add comment for arch_parse_debug_rodata()
>  - Update kernel-parameters.txt as required

These last two are self-evident from the code and don't need to be listed
here.

> After this patch, the "rodata=on" will be the default on arm64 platform
> as well.
> 
> Reviewed-by: Christoph Lameter (Ampere) <cl@gentwo.org>
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  2 +-
>  arch/arm64/include/asm/setup.h                | 28 +++++++++++++++++--
>  2 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index ee0735c6b8e2..3590bdc8d9a5 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6354,7 +6354,7 @@
>  	rodata=		[KNL,EARLY]
>  		on	Mark read-only kernel memory as read-only (default).
>  		off	Leave read-only kernel memory writable for debugging.
> -		full	Mark read-only kernel memory and aliases as read-only
> +		noalias	Use more block mappings, may have better performance.
>  		        [arm64]

This isn't particularly helpful documentation and I think we need to mention
the linear alias rather than talk about the page-table structure.

How about:

	noalias	Mark read-only kernel memory as read-only but retain
		writable aliases in the direct map for regions outside
		of the kernel image. [arm64]

?

> diff --git a/arch/arm64/include/asm/setup.h b/arch/arm64/include/asm/setup.h
> index ba269a7a3201..6b994d0881d1 100644
> --- a/arch/arm64/include/asm/setup.h
> +++ b/arch/arm64/include/asm/setup.h
> @@ -13,6 +13,30 @@
>  extern phys_addr_t __fdt_pointer __initdata;
>  extern u64 __cacheline_aligned boot_args[4];
>  
> +/*
> + * rodata=on (default)
> + *
> + *    This applies read-only attributes to VM areas and to the linear
> + *    alias of the backing pages as well. This prevents code or read-
> + *    only data from being modified (inadvertently or intentionally),
> + *    via another mapping for the same memory page.
> + *
> + *    But this might cause linear map region to be mapped down to base
> + *    pages, which may adversely affect performance in some cases.
> + *
> + * rodata=off
> + *
> + *    This provides more block mappings and contiguous hints for linear
> + *    map region which would minimize TLB footprint. This also leaves
> + *    read-only kernel memory writable for debugging.
> + *
> + * rodata=noalias
> + *
> + *    This provides more block mappings and contiguous hints for linear
> + *    map region which would minimize TLB footprint. This leaves the linear
> + *    alias of read-only mappings in the vmalloc space writeable, making
> + *    them susceptible to inadvertent modification by software.
> + */

Please remove this comment. If you want to keep it, this information
belongs either in the commit message (to justify the performance impact)
or the Documentation (to describe the functional impact) but there's
little point having it hidden away here.

With those changes, this looks good and I can pick it up for 6.18 if
you respin.

Cheers,

Will

