Return-Path: <linux-kernel+bounces-819425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DF7B5A083
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ABC5584F24
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2461A2F5A17;
	Tue, 16 Sep 2025 18:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcLZIk4Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EE62DBF45;
	Tue, 16 Sep 2025 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758047413; cv=none; b=bxom1l9JVX8vgWL8xy3+016wQV5gkyTaV4d+HJ22jygP2hC2iUm0hpJCpz+Gng7MkcvOcnP11LxTWsa5VUbgvz4cXIoZH34H6+HbU2guryvcDWOGU5IgvbtcwTDrOTmfWHPOOyC7+gM1oU9PWcFFDZBA5Xy2r9RSGFX34EpvXYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758047413; c=relaxed/simple;
	bh=/60SfQxaLsYIsKPNHgxsvyMnMI3qJ6/je9Dcc85USXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGnQL6XgDJ9I4Yrg8FZa3ZD9/055ZDpR185LMimzmUnbhNghU+qcyMFg5GHDyo+ZPYbzjiHIHBKczoKUmvWknN6YRySX7Kp+rd5P8euxoTAPT/id8dlvi/6E9u6L39GDXc7t0U2CS5Iqq4yuzc97SCrpw6e6IYUf17TpIb21SWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcLZIk4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA528C4CEEB;
	Tue, 16 Sep 2025 18:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758047412;
	bh=/60SfQxaLsYIsKPNHgxsvyMnMI3qJ6/je9Dcc85USXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NcLZIk4QG8OaXaSJ6ufu602atIlGG4XngoCeveTzoBf0H5s4S/4ATiIAFhg+GsW2M
	 fW/hAwaRfqoyUpisKvnIScAAkVvMzyym7vkGoVqnfq4bNlCkeksiZMxbdF1seehl8f
	 +fHiL8pnW5UPKuMS9qDEAspXz5A8CV4zayuab9X1bYDHOGseWTZUr8IKZ4Reasb26w
	 5gnDUNeJPxXAuwT1qYNUKvMT3J5yfBwTYW0jdPknCs20Ke5dYwTeEcsOxudBTuNMXX
	 eypasJchs+QTE1Z4JxfppJNo5VzbVkjFFfbYNJ/ZMMlo2TLlLf/KSI5uIN92oluPSb
	 RVH9i2BbTS1LA==
Date: Tue, 16 Sep 2025 11:30:10 -0700
From: Drew Fustini <fustini@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	oe-kbuild-all@lists.linux.dev,
	Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
	Adrien Ricciardi <aricciardi@baylibre.com>,
	James Morse <james.morse@arm.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Atish Patra <atish.patra@linux.dev>,
	Vasudevan Srinivasan <vasu@rivosinc.com>, guo.wenjia23@zte.com.cn,
	liu.qingtao2@zte.com.cn, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] RISC-V: Add support for srmcfg CSR from Ssqosid
 ext
Message-ID: <aMmssvhxw+oH32OA@x1>
References: <20250915-ssqosid-v6-17-rc5-v2-3-2d4b0254dfd6@kernel.org>
 <202509162355.wByessnb-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202509162355.wByessnb-lkp@intel.com>

On Tue, Sep 16, 2025 at 11:55:39PM +0800, kernel test robot wrote:
> Hi Drew,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Drew-Fustini/dt-bindings-riscv-Add-Ssqosid-extension-description/20250916-131818
> base:   76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c
> patch link:    https://lore.kernel.org/r/20250915-ssqosid-v6-17-rc5-v2-3-2d4b0254dfd6%40kernel.org
> patch subject: [PATCH v2 3/3] RISC-V: Add support for srmcfg CSR from Ssqosid ext
> config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20250916/202509162355.wByessnb-lkp@intel.com/config)
> compiler: riscv64-linux-gcc (GCC) 15.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250916/202509162355.wByessnb-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202509162355.wByessnb-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    kernel/sched/core.c: In function 'context_switch':
> >> kernel/sched/core.c:5357:35: error: macro '__switch_to_srmcfg' passed 1 arguments, but takes just 0
>     5357 |         switch_to(prev, next, prev);
>          |                                   ^

It seems I had incorrectly defined __switch_to_srmcfg() in the case
where CONFIG_RISCV_ISA_SSQOSID is not defined. I was able to reproduce
the error locally and this change seems to resolve it:


diff --git a/arch/riscv/include/asm/qos.h b/arch/riscv/include/asm/qos.h
index 7371e53e9e91..84830d7c6dc4 100644
--- a/arch/riscv/include/asm/qos.h
+++ b/arch/riscv/include/asm/qos.h
@@ -35,7 +35,7 @@ static __always_inline bool has_srmcfg(void)
 #else /* ! CONFIG_RISCV_ISA_SSQOSID  */

 static __always_inline bool has_srmcfg(void) { return false; }
-#define __switch_to_srmcfg() do { } while (0)
+#define __switch_to_srmcfg(__next) do { } while (0)

 #endif /* CONFIG_RISCV_ISA_SSQOSID */
 #endif /* _ASM_RISCV_QOS_H */


I'll include this change in the next revision.

Thanks,
Drew

