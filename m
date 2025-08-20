Return-Path: <linux-kernel+bounces-777073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B80B2D4C3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1023586FFD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16412D3ED2;
	Wed, 20 Aug 2025 07:23:21 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EA626F476
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 07:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755674601; cv=none; b=qcpaISiN+OOwwTJpA93/rlmuwfBVOOvMd2YNmM6aTOnblkmLAoiPBJVVMOU46843LyAJ1ZMDR063OCHkiZydxXIbvQJv74sq3Z2m0G1dAbK0sRGrmanLZF5QrjcET8EGHeq20RTnvAoMC3ya5K+0pUG9JzV2haS9n5dGIDIsWXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755674601; c=relaxed/simple;
	bh=lAJQKe2IUXmpnDMH2MLQn/N2R7Eh9rHNLAeuZxEA8YA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=phbxpS/iuAGPkLteg1IBzRCm0PyQP2KSYStcXJ1QW/xfeq/QVM33Mw7MO+OFGmTaRNJJkW67j9hRqfPnsO9emd6wAjOP8DBdtRpCj4AGlpqlNmN5WdwpgF+Qdhnnk6pjRpC/qkCW8jzb+ZNhpcDiro2oSh52V1Z/UM7o10kigLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1BD45442D0;
	Wed, 20 Aug 2025 07:23:08 +0000 (UTC)
Message-ID: <8078e385-e08e-40a5-b6df-31c0b5be8f43@ghiti.fr>
Date: Wed, 20 Aug 2025 09:23:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] riscv: Remove version check for LTO_CLANG selects
To: Nathan Chancellor <nathan@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Kees Cook <kees@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org
References: <20250818-bump-min-llvm-ver-15-v1-0-c8b1d0f955e0@kernel.org>
 <20250818-bump-min-llvm-ver-15-v1-7-c8b1d0f955e0@kernel.org>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250818-bump-min-llvm-ver-15-v1-7-c8b1d0f955e0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheejjeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeejveeuuddtuedtffevkeevteelffelueeiveeitdevieejgeffteekkeevhedugfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtdegmegtvggttdemuddvudgumehfvdefvdemjegufhekmegsfhegsgemgeeliegvmeduugegsgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtgeemtggvtgdtmeduvdduugemfhdvfedvmeejughfkeemsghfgegsmeegleeivgemudgugegspdhhvghloheplgfkrfggieemvdgrtdegmegtvggttdemuddvudgumehfvdefvdemjegufhekmegsfhegsgemgeeliegvmeduugegsggnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtohepnhgrthhhrghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrkhhpmheslhhin
 hhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvgdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhhitghkrdguvghsrghulhhnihgvrhhsodhlkhhmlhesghhmrghilhdrtghomhdprhgtphhtthhopehmohhrsghosehgohhoghhlvgdrtghomhdprhgtphhtthhopehjuhhsthhinhhsthhithhtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: alex@ghiti.fr

Hi Nathan,

On 8/18/25 20:57, Nathan Chancellor wrote:
> Now that the minimum supported version of LLVM for building the kernel
> has been bumped to 15.0.0, there is no need to check the LLD version
> before selecting ARCH_SUPPORTS_LTO_CLANG{,_THIN} because it will always
> be true.
>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Alexandre Ghiti <alex@ghiti.fr>
> Cc: linux-riscv@lists.infradead.org
>
> Small note, this will conflict with
> https://lore.kernel.org/20250710-riscv-restrict-lto-to-medany-v1-1-b1dac9871ecf@kernel.org/
> but I think it is simple enough to deal with.


FYI, I'll send this patch for some 6.17-rcX.


> ---
>   arch/riscv/Kconfig | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index a4b233a0659e..1d53bf02d0fa 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -64,9 +64,8 @@ config RISCV
>   	select ARCH_SUPPORTS_DEBUG_PAGEALLOC if MMU
>   	select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
>   	select ARCH_SUPPORTS_HUGETLBFS if MMU
> -	# LLD >= 14: https://github.com/llvm/llvm-project/issues/50505
> -	select ARCH_SUPPORTS_LTO_CLANG if LLD_VERSION >= 140000
> -	select ARCH_SUPPORTS_LTO_CLANG_THIN if LLD_VERSION >= 140000
> +	select ARCH_SUPPORTS_LTO_CLANG
> +	select ARCH_SUPPORTS_LTO_CLANG_THIN
>   	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS if 64BIT && MMU
>   	select ARCH_SUPPORTS_PAGE_TABLE_CHECK if MMU
>   	select ARCH_SUPPORTS_PER_VMA_LOCK if MMU
>

I found another bunch of LLD_VERSION check in this file that could be 
removed:

https://elixir.bootlin.com/linux/v6.17-rc2/source/arch/riscv/Kconfig#L253
https://elixir.bootlin.com/linux/v6.17-rc2/source/arch/riscv/Kconfig#L262
https://elixir.bootlin.com/linux/v6.17-rc2/source/arch/riscv/Kconfig#L630
https://elixir.bootlin.com/linux/v6.17-rc2/source/arch/riscv/Kconfig#L731
https://elixir.bootlin.com/linux/v6.17-rc2/source/arch/riscv/Kconfig#L746
https://elixir.bootlin.com/linux/v6.17-rc2/source/arch/riscv/Kconfig#L781
https://elixir.bootlin.com/linux/v6.17-rc2/source/arch/riscv/Kconfig#L804

Thanks,

Alex


