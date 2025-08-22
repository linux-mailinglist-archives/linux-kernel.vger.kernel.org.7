Return-Path: <linux-kernel+bounces-781866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC05B317F0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C02FFAA3EE4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183132FB639;
	Fri, 22 Aug 2025 12:35:23 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DC92FAC05
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755866122; cv=none; b=nHs2Bsh3yuxoZERPK/Y8Mi35w/DxfDkA62H6kGJWINDAUxMQfwXLyZyWc2CmUv70Q7L5jHytobVwciYcuCE0hIS2oP254WvH+/FcOA8iFi6G7W/C28P43Vm50N4S3+c/mc41XVZdWEb1pxsMkEi06ONpnddLvuy86tCE09Tw2wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755866122; c=relaxed/simple;
	bh=QFpVs+JtR54ukkLsAfaVc1s/kJsduXsF07xuMTGlmmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KbnDev3x6EmY7epOqFEZ6wMzLwnUIUGsxJutl84NKVuRI3TSsmNaO9Nghs25gcaYeFfUKeYT9vP5V2j3g6EiWR0yV1TzxxTMAUxL639yd3QDIY8tIbxbe+wPIGSu6yMnrFWYiqsORN0ktQRtmQKWc55/hIVC3Dfp2GTZy05LKQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2A7D643848;
	Fri, 22 Aug 2025 12:35:16 +0000 (UTC)
Message-ID: <c09fa979-e853-44b7-9287-0c4b71cb1073@ghiti.fr>
Date: Fri, 22 Aug 2025 14:35:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] riscv: Unconditionally use linker relaxation
To: Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Kees Cook <kees@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 llvm@lists.linux.dev, patches@lists.linux.dev,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org
References: <20250821-bump-min-llvm-ver-15-v2-0-635f3294e5f0@kernel.org>
 <20250821-bump-min-llvm-ver-15-v2-8-635f3294e5f0@kernel.org>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250821-bump-min-llvm-ver-15-v2-8-635f3294e5f0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieefjeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeehiefhuddtuddukeetkeehhedtffduhfevfeeftdefveffgfeuffejjeejfeekueenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeektddrvddugedrvdduuddrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeektddrvddugedrvdduuddrvddtuddphhgvlhhopegludelvddrudeikedrkedtrddufeefngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopehnrghthhgrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvgdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhhitghkrdguvghsrghulhhnihgvrhhsodhlkhhmlhesghhmrghilhdrtghom
 hdprhgtphhtthhopehmohhrsghosehgohhoghhlvgdrtghomhdprhgtphhtthhopehjuhhsthhinhhsthhithhtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehllhhvmheslhhishhtshdrlhhinhhugidruggvvh
X-GND-Sasl: alex@ghiti.fr


On 8/21/25 23:15, Nathan Chancellor wrote:
> Now that the minimum supported version of LLVM for building the kernel
> has been bumped to 15.0.0, CONFIG_RISCV_USE_LINKER_RELAXATION will
> always be enabled, so it can be removed.
>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Alexandre Ghiti <alex@ghiti.fr>
> Cc: linux-riscv@lists.infradead.org
> ---
>   arch/riscv/Kconfig  | 6 ------
>   arch/riscv/Makefile | 9 +--------
>   2 files changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 1d53bf02d0fa..d482236e93f4 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -246,15 +246,9 @@ config HAVE_SHADOW_CALL_STACK
>   	# https://github.com/riscv-non-isa/riscv-elf-psabi-doc/commit/a484e843e6eeb51f0cb7b8819e50da6d2444d769
>   	depends on $(ld-option,--no-relax-gp)
>   
> -config RISCV_USE_LINKER_RELAXATION
> -	def_bool y
> -	# https://github.com/llvm/llvm-project/commit/6611d58f5bbcbec77262d392e2923e1d680f6985
> -	depends on !LD_IS_LLD || LLD_VERSION >= 150000
> -
>   # https://github.com/llvm/llvm-project/commit/bbc0f99f3bc96f1db16f649fc21dd18e5b0918f6
>   config ARCH_HAS_BROKEN_DWARF5
>   	def_bool y
> -	depends on RISCV_USE_LINKER_RELAXATION
>   	# https://github.com/llvm/llvm-project/commit/1df5ea29b43690b6622db2cad7b745607ca4de6a
>   	depends on AS_IS_LLVM && AS_VERSION < 180000
>   	# https://github.com/llvm/llvm-project/commit/7ffabb61a5569444b5ac9322e22e5471cc5e4a77
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index df57654a615e..ecf2fcce2d92 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -46,17 +46,10 @@ else
>   	KBUILD_LDFLAGS += -melf32lriscv
>   endif
>   
> -ifndef CONFIG_RISCV_USE_LINKER_RELAXATION
> -	KBUILD_CFLAGS += -mno-relax
> -	KBUILD_AFLAGS += -mno-relax
> -ifndef CONFIG_AS_IS_LLVM
> -	KBUILD_CFLAGS += -Wa,-mno-relax
> -	KBUILD_AFLAGS += -Wa,-mno-relax
> -endif
>   # LLVM has an issue with target-features and LTO: https://github.com/llvm/llvm-project/issues/59350
>   # Ensure it is aware of linker relaxation with LTO, otherwise relocations may
>   # be incorrect: https://github.com/llvm/llvm-project/issues/65090
> -else ifeq ($(CONFIG_LTO_CLANG),y)
> +ifeq ($(CONFIG_LTO_CLANG),y)
>   	KBUILD_LDFLAGS += -mllvm -mattr=+c -mllvm -mattr=+relax
>   endif
>   
>

Acked-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


