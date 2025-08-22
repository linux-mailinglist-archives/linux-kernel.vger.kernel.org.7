Return-Path: <linux-kernel+bounces-781872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C67B31807
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50CA188AD26
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CAB2FB972;
	Fri, 22 Aug 2025 12:38:18 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F951B4141
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755866298; cv=none; b=VYiGCyIDNBdIvDqKZxwRqum3bZWNonf3Z4WS5TncElP+TJst9T0TkP+bJSql08ktP7IZ53oQZqJhOdie6PMNomXdg04xCTSnYU5bxJs3M3BUBeofHxZF6k3ke6gwIIzXKdefNpLClvgnkGtjYkpXwz06dAQojczPqdEBYfekXUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755866298; c=relaxed/simple;
	bh=vTU6/21/tsv+e8WPOQeqgNrvSRjoFUgsFJUPIX7P6iE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OIY9b1bby1Q0ssFd0PehvQuamcKc8kP9CRgit26MXUrFWWu/ertvsJtlR0n/mS7T0vriGurKzC6524Th97Ac/RfHTUsLvXSOwu7DM+ycK9KQr5cm5diksnVOUc+sMMyXskBFrnV07b2EiIbltM7nbtBkRXzQBh2skIPouVoA6vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id E13EB443CB;
	Fri, 22 Aug 2025 12:38:11 +0000 (UTC)
Message-ID: <30ebd580-80e7-456e-8628-9d0a08dced95@ghiti.fr>
Date: Fri, 22 Aug 2025 14:38:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] riscv: Remove ld.lld version checks from many
 TOOLCHAIN_HAS configs
To: Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Kees Cook <kees@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 llvm@lists.linux.dev, patches@lists.linux.dev,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org
References: <20250821-bump-min-llvm-ver-15-v2-0-635f3294e5f0@kernel.org>
 <20250821-bump-min-llvm-ver-15-v2-9-635f3294e5f0@kernel.org>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250821-bump-min-llvm-ver-15-v2-9-635f3294e5f0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieefjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpedthfelfeejgeehveegleejleelgfevhfekieffkeeujeetfedvvefhledvgeegieenucfkphepkedtrddvudegrddvuddurddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkedtrddvudegrddvuddurddvtddupdhhvghloheplgduledvrdduieekrdektddrudeffegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepuddupdhrtghpthhtohepnhgrthhhrghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnihgtkhdruggvshgruhhlnhhivghrshdolhhkmhhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhorhgsohesghhoohhgl
 hgvrdgtohhmpdhrtghpthhtohepjhhushhtihhnshhtihhtthesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhlvhhmsehlihhsthhsrdhlihhnuhigrdguvghv
X-GND-Sasl: alex@ghiti.fr

On 8/21/25 23:15, Nathan Chancellor wrote:
> Now that the minimum supported version of LLVM for building the kernel
> has been bumped to 15.0.0, several ld.lld version checks become
> tautological, as they are always true. Replace them with a simple
> CONFIG_LD_IS_LLD check.
>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Alexandre Ghiti <alex@ghiti.fr>
> Cc: linux-riscv@lists.infradead.org
> ---
>   arch/riscv/Kconfig | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d482236e93f4..850ba4b4b534 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -620,7 +620,7 @@ config TOOLCHAIN_HAS_V
>   	default y
>   	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64imv)
>   	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32imv)
> -	depends on LLD_VERSION >= 140000 || LD_VERSION >= 23800
> +	depends on LD_IS_LLD || LD_VERSION >= 23800
>   	depends on AS_HAS_OPTION_ARCH
>   
>   config RISCV_ISA_V
> @@ -721,7 +721,7 @@ config TOOLCHAIN_HAS_ZBB
>   	default y
>   	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zbb)
>   	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zbb)
> -	depends on LLD_VERSION >= 150000 || LD_VERSION >= 23900
> +	depends on LD_IS_LLD || LD_VERSION >= 23900
>   	depends on AS_HAS_OPTION_ARCH
>   
>   # This symbol indicates that the toolchain supports all v1.0 vector crypto
> @@ -736,7 +736,7 @@ config TOOLCHAIN_HAS_ZBA
>   	default y
>   	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zba)
>   	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zba)
> -	depends on LLD_VERSION >= 150000 || LD_VERSION >= 23900
> +	depends on LD_IS_LLD || LD_VERSION >= 23900
>   	depends on AS_HAS_OPTION_ARCH
>   
>   config RISCV_ISA_ZBA
> @@ -771,7 +771,7 @@ config TOOLCHAIN_HAS_ZBC
>   	default y
>   	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zbc)
>   	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zbc)
> -	depends on LLD_VERSION >= 150000 || LD_VERSION >= 23900
> +	depends on LD_IS_LLD || LD_VERSION >= 23900
>   	depends on AS_HAS_OPTION_ARCH
>   
>   config RISCV_ISA_ZBC
> @@ -794,7 +794,7 @@ config TOOLCHAIN_HAS_ZBKB
>   	default y
>   	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zbkb)
>   	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zbkb)
> -	depends on LLD_VERSION >= 150000 || LD_VERSION >= 23900
> +	depends on LD_IS_LLD || LD_VERSION >= 23900
>   	depends on AS_HAS_OPTION_ARCH
>   
>   config RISCV_ISA_ZBKB
>

Acked-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks for the v2!

Alex


