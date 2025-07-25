Return-Path: <linux-kernel+bounces-745862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19280B11FBE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9362FAE1E5A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8B01E0B91;
	Fri, 25 Jul 2025 14:04:49 +0000 (UTC)
Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB3F191F92
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 14:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753452289; cv=none; b=W40lBMwu5FsI/AzF2piZoPmsCCLEtc1FmN9HMR4xUnppTgMDcKRZlmQ+v5mJYv88ZK2nRwburK+kKUJkYAPec6ZuTAkW+OsP+ERscOoQExHblgBblqjGvbnHTE/RnT3uHFggRr1VRz8oJtzZZra8ZG+NCYcILrFNxChBrSjw2QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753452289; c=relaxed/simple;
	bh=fFIgSeEylmyExTQHJYtSPkY2IdENL5npCDiYbZ70ADE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VMmYK8t91pSKV66fCmu7rNXRpXBZPzqGF4t/ghKBITzBZaAD+f7VG1YTj2zhXhyQ6dlHiayLdstLeNvHwswpw4ddG/l7jvvPvZZvA41s+tN1LWRt+PXJ3h/YVFu1+bBEnAJpuvkwFJn6fb1qRkACMA7mq+o420o7mgPvPXTyvqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id BA0FE4496E;
	Fri, 25 Jul 2025 14:04:36 +0000 (UTC)
Message-ID: <e7499ddb-04f6-4891-bbce-38bb80a87401@ghiti.fr>
Date: Fri, 25 Jul 2025 16:04:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] riscv: mm: Use mmu-type from FDT to limit SATP mode
To: Junhui Liu <junhui.liu@pigmoral.tech>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250722-satp-from-fdt-v1-0-5ba22218fa5f@pigmoral.tech>
 <20250722-satp-from-fdt-v1-2-5ba22218fa5f@pigmoral.tech>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250722-satp-from-fdt-v1-2-5ba22218fa5f@pigmoral.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekfeejvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnheptdfhleefjeegheevgeeljeellefgvefhkeeiffekueejteefvdevhfelvdeggeeinecukfhppeelhedrudeguddruddtvddrudekieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeelhedrudeguddruddtvddrudekiedphhgvlhhopegluddtrddutddrudegiedrvddujegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepiedprhgtphhtthhopehjuhhnhhhuihdrlhhiuhesphhighhmohhrrghlrdhtvggthhdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhop
 ehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh

On 7/21/25 18:53, Junhui Liu wrote:
> Some RISC-V implementations may hang when attempting to write an
> unsupported SATP mode, even though the latest RISC-V specification
> states such writes should have no effect. To avoid this issue, the
> logic for selecting SATP mode has been refined:
>
> The kernel now determines the SATP mode limit by taking the minimum of
> the value specified by the kernel command line (noXlvl) and the
> "mmu-type" property in the device tree (FDT). If only one is specified,
> use that.
> - If the resulting limit is sv48 or higher, the kernel will probe SATP
>    modes from this limit downward until a supported mode is found.
> - If the limit is sv39, the kernel will directly use sv39 without
>    probing.
>
> This ensures SATP mode selection is safe and compatible with both
> hardware and user configuration, minimizing the risk of hangs.
>
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> ---
>   arch/riscv/kernel/pi/fdt_early.c | 40 ++++++++++++++++++++++++++++++++++++++++
>   arch/riscv/kernel/pi/pi.h        |  1 +
>   arch/riscv/mm/init.c             | 11 ++++++++---
>   3 files changed, 49 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/pi/fdt_early.c b/arch/riscv/kernel/pi/fdt_early.c
> index 9bdee2fafe47e4a889132ebe2d0d360717c464e9..a12ff8090f190331f555d9e22ce4d1b3e940bceb 100644
> --- a/arch/riscv/kernel/pi/fdt_early.c
> +++ b/arch/riscv/kernel/pi/fdt_early.c
> @@ -3,6 +3,7 @@
>   #include <linux/init.h>
>   #include <linux/libfdt.h>
>   #include <linux/ctype.h>
> +#include <asm/csr.h>
>   
>   #include "pi.h"
>   
> @@ -183,3 +184,42 @@ bool fdt_early_match_extension_isa(const void *fdt, const char *ext_name)
>   
>   	return ret;
>   }
> +
> +/**
> + *  set_satp_mode_from_fdt - determine SATP mode based on the MMU type in fdt
> + *
> + * @dtb_pa: physical address of the device tree blob
> + *
> + *  Returns the SATP mode corresponding to the MMU type of the first enabled CPU,
> + *  0 otherwise
> + */
> +u64 set_satp_mode_from_fdt(uintptr_t dtb_pa)
> +{
> +	const void *fdt = (const void *)dtb_pa;
> +	const char *mmu_type;
> +	int node, parent;
> +
> +	parent = fdt_path_offset(fdt, "/cpus");
> +	if (parent < 0)
> +		return 0;
> +
> +	fdt_for_each_subnode(node, fdt, parent) {
> +		if (!fdt_node_name_eq(fdt, node, "cpu"))
> +			continue;
> +
> +		if (!fdt_device_is_available(fdt, node))
> +			continue;
> +
> +		mmu_type = fdt_getprop(fdt, node, "mmu-type", NULL);
> +		if (!mmu_type)
> +			break;
> +
> +		if (!strcmp(mmu_type, "riscv,sv39"))
> +			return SATP_MODE_39;
> +		else if (!strcmp(mmu_type, "riscv,sv48"))
> +			return SATP_MODE_48;
> +		break;
> +	}
> +
> +	return 0;
> +}
> diff --git a/arch/riscv/kernel/pi/pi.h b/arch/riscv/kernel/pi/pi.h
> index 21141d84fea603fdfc439e12a8c3216f1527c65f..3fee2cfddf7cfb8179af6f2d9b69a0d5e412fad7 100644
> --- a/arch/riscv/kernel/pi/pi.h
> +++ b/arch/riscv/kernel/pi/pi.h
> @@ -14,6 +14,7 @@ u64 get_kaslr_seed(uintptr_t dtb_pa);
>   u64 get_kaslr_seed_zkr(const uintptr_t dtb_pa);
>   bool set_nokaslr_from_cmdline(uintptr_t dtb_pa);
>   u64 set_satp_mode_from_cmdline(uintptr_t dtb_pa);
> +u64 set_satp_mode_from_fdt(uintptr_t dtb_pa);
>   
>   bool fdt_early_match_extension_isa(const void *fdt, const char *ext_name);
>   
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index d03e02a92379f2338a4f4df0ab797a7859b83dfc..0f30fa875abf92a201579ac6469958b0d95b5a58 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -816,6 +816,7 @@ static __meminit pgprot_t pgprot_from_va(uintptr_t va)
>   
>   #if defined(CONFIG_64BIT) && !defined(CONFIG_XIP_KERNEL)
>   u64 __pi_set_satp_mode_from_cmdline(uintptr_t dtb_pa);
> +u64 __pi_set_satp_mode_from_fdt(uintptr_t dtb_pa);
>   
>   static void __init disable_pgtable_l5(void)
>   {
> @@ -855,18 +856,22 @@ static void __init set_mmap_rnd_bits_max(void)
>    * underlying hardware: establish 1:1 mapping in 4-level page table mode
>    * then read SATP to see if the configuration was taken into account
>    * meaning sv48 is supported.
> + * The maximum SATP mode is limited by both the command line and the "mmu-type"
> + * property in the device tree, since some platforms may hang if an unsupported
> + * SATP mode is attempted.
>    */
>   static __init void set_satp_mode(uintptr_t dtb_pa)
>   {
>   	u64 identity_satp, hw_satp;
>   	uintptr_t set_satp_mode_pmd = ((unsigned long)set_satp_mode) & PMD_MASK;
> -	u64 satp_mode_cmdline = __pi_set_satp_mode_from_cmdline(dtb_pa);
> +	u64 satp_mode_limit = min_not_zero(__pi_set_satp_mode_from_cmdline(dtb_pa),
> +					   __pi_set_satp_mode_from_fdt(dtb_pa));
>   
>   	kernel_map.page_offset = PAGE_OFFSET_L5;
>   
> -	if (satp_mode_cmdline == SATP_MODE_48) {
> +	if (satp_mode_limit == SATP_MODE_48) {
>   		disable_pgtable_l5();
> -	} else if (satp_mode_cmdline == SATP_MODE_39) {
> +	} else if (satp_mode_limit == SATP_MODE_39) {
>   		disable_pgtable_l5();
>   		disable_pgtable_l4();
>   		return;
>

I guess it's more convenient to use the 'mmu-type' property on this core 
rather than using no4lvl right?

Anyway, what you implemented matches the description of the 'mmu-type' 
binding, so:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

I'll take that for 6.17.

Thanks,

Alex


