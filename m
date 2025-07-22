Return-Path: <linux-kernel+bounces-740170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1660EB0D0E7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 06:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0939F7B246C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 04:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C9428BA83;
	Tue, 22 Jul 2025 04:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="eBPi1HEK"
Received: from sg-3-20.ptr.tlmpb.com (sg-3-20.ptr.tlmpb.com [101.45.255.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC64D18DF8D
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 04:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.45.255.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753159123; cv=none; b=eRLRuAzSgzuWw7DyozePw8OZaC7bBATW1ZBptLpAuJ4XMMXvxHp292QCrWlywIr8RCOfZl76U/28fOEUVfmDqBnx/KDB+UPqacnre4UltPmkG6rTIajHC2LJW5bkVkErL/VchekwvT6ykPNTOnY0M9/xDar/BBGJAkNupgVK6uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753159123; c=relaxed/simple;
	bh=D19RubbGYVju8GV+ZQhRQVgcv5AebdJ94P2UnARos8g=;
	h=Subject:Message-Id:In-Reply-To:From:To:Cc:Date:Mime-Version:
	 References:Content-Type; b=OYwNLS/pYlr95HejTag2wQRDeNHeF1ae6lTJsKARDWcto71agcdwlWnPy/FwkGlumz+Rq7FVdpQnuGEgm4lJzx7ZgoTr8YVZuOxe0uqvzX3EE2aHmY315uVXBcX3X8uM2ogQgZqjb+WNrvZa107xAsnTBVTPxZFQ91Tu+MnInVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=eBPi1HEK; arc=none smtp.client-ip=101.45.255.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1753158986;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=+9bctTJiffn2opVe6FpoBhDjVwlWXbhmCqBuDxg7YuU=;
 b=eBPi1HEK4Y0OTs29Ex/2n2ev1I78/pmbpCll0MI1g2xHErWui1Ud/JTCpDtQnrIWfVTuNT
 HRmpc8W9WkHNKa8N5SWk2U+jz5/l4jGuQ+U2kKM3MnEPMpGuyoLcPPy4nipWRlnn8Po1BT
 qz5dQUWfLiL0oNlCweRaDLc6K4b0Dk9KDh5wbULEd6Cpd+h2hJZNyvD2npIRW99xVHy5Si
 r86Caiy0NaroPZeJ0gV70T8ze3OdwdbbjVZ8tEXMTlPV/wSrGNOBNznpSt+oVdeXHCoInN
 igdEk52X3hRwiDw2mI1b8EPIWPxpHbLUSPfNvl49arnjA7aFrEPWX4Wr0Dw+mg==
User-Agent: Mozilla Thunderbird
X-Original-From: Nutty Liu <liujingqi@lanxincomputing.com>
Subject: Re: [PATCH 2/2] riscv: mm: Use mmu-type from FDT to limit SATP mode
Message-Id: <590ddc94-afce-412f-911d-2cc67d4a7e4a@lanxincomputing.com>
In-Reply-To: <20250722-satp-from-fdt-v1-2-5ba22218fa5f@pigmoral.tech>
X-Lms-Return-Path: <lba+2687f1548+d137a9+vger.kernel.org+liujingqi@lanxincomputing.com>
Content-Transfer-Encoding: 7bit
Received: from [127.0.0.1] ([116.237.111.137]) by smtp.feishu.cn with ESMTPS; Tue, 22 Jul 2025 12:36:23 +0800
Content-Language: en-US
From: "Nutty Liu" <liujingqi@lanxincomputing.com>
To: "Junhui Liu" <junhui.liu@pigmoral.tech>, 
	"Paul Walmsley" <paul.walmsley@sifive.com>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, 
	"Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>
Cc: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Date: Tue, 22 Jul 2025 12:36:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722-satp-from-fdt-v1-0-5ba22218fa5f@pigmoral.tech> <20250722-satp-from-fdt-v1-2-5ba22218fa5f@pigmoral.tech>
Content-Type: text/plain; charset=UTF-8

On 7/22/2025 12:53 AM, Junhui Liu wrote:
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
Reviewed-by: Nutty Liu <liujingqi@lanxincomputing.com>

Thanks,
Nutty
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

