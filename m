Return-Path: <linux-kernel+bounces-602930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF630A88124
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 15:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B289164A75
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 13:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677632C3747;
	Mon, 14 Apr 2025 13:05:56 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E972BF3F7
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744635955; cv=none; b=ixJic6C2/v1M0TF1CnryHF/P1DcaA9RDyJ7O00hMCVv+vdKdt7qoMyHsLEDC352gupiNQ7o9szrZE0cOXfHd4OwBm0WS+ZHZ6hRTqFu57TC5M/HOPYP/rZFjucV9UTEjkGunW17sKpXoMuwOX0QEQdSP79hJ7M3Qi9Y3NWYQxnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744635955; c=relaxed/simple;
	bh=eSn+7qZstkOiL3HKgAGb39wLfTbQEQsMAKi+mcdORDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fk+VZrSt+rYypNk8MWuzJ3WeZwdFtSDUUiynZFNwgN83esJ6zz0cJJLddvElDcc0LjYFmYv2bEHkf72lUpSsTskvmnHCZEyxXoOQetgPwGWo9w0tmmjLT2YOtfyHzbD4Xlp5nGsBwsd4FZ+y0tLMzBzfkknzGtC0vsh28aw/mWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7321A42E7E;
	Mon, 14 Apr 2025 13:05:42 +0000 (UTC)
Message-ID: <6b0d2b2f-5ccc-4337-aeaf-d18ed6e6097f@ghiti.fr>
Date: Mon, 14 Apr 2025 15:05:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Provide all alternative macros all the time
To: Andrew Jones <ajones@ventanamicro.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, conor.dooley@microchip.com,
 oe-kbuild-all@lists.linux.dev, charlie@rivosinc.com,
 samuel.holland@sifive.com, kernel test robot <lkp@intel.com>
References: <20250414120947.135173-2-ajones@ventanamicro.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250414120947.135173-2-ajones@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddtiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpefhhfdutdevgeelgeegfeeltdduhfduledvteduhfegffffiefggfektefhjedujeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemhegvfhgsmeeiieeikeemkeefiegsmegufhgrleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemhegvfhgsmeeiieeikeemkeefiegsmegufhgrledphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemhegvfhgsmeeiieeikeemkeefiegsmegufhgrlegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtoheprghjohhnvghssehvvghnthgrnhgrmhhitghrohdrtghomhdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggur
 dhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtoheptghonhhorhdrughoohhlvgihsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtohepohgvqdhksghuihhlugdqrghllheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopegthhgrrhhlihgvsehrihhvohhsihhntgdrtghomh
X-GND-Sasl: alex@ghiti.fr

Hi Drew,

On 14/04/2025 14:09, Andrew Jones wrote:
> We need to provide all six forms of the alternative macros
> (ALTERNATIVE, ALTERNATIVE_2, _ALTERNATIVE_CFG, _ALTERNATIVE_CFG_2,
> __ALTERNATIVE_CFG, __ALTERNATIVE_CFG_2) for all four cases derived
> from the two ifdefs (RISCV_ALTERNATIVE, __ASSEMBLY__) in order to
> ensure all configs can compile. Define this missing ones and ensure
> all are defined to consume all parameters passed.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202504130710.3IKz6Ibs-lkp@intel.com/
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>   arch/riscv/include/asm/alternative-macros.h | 19 +++++++------------
>   1 file changed, 7 insertions(+), 12 deletions(-)
>
> diff --git a/arch/riscv/include/asm/alternative-macros.h b/arch/riscv/include/asm/alternative-macros.h
> index 721ec275ce57..231d777d936c 100644
> --- a/arch/riscv/include/asm/alternative-macros.h
> +++ b/arch/riscv/include/asm/alternative-macros.h
> @@ -115,24 +115,19 @@
>   	\old_c
>   .endm
>   
> -#define _ALTERNATIVE_CFG(old_c, ...)	\
> -	ALTERNATIVE_CFG old_c
> -
> -#define _ALTERNATIVE_CFG_2(old_c, ...)	\
> -	ALTERNATIVE_CFG old_c
> +#define __ALTERNATIVE_CFG(old_c, ...)		ALTERNATIVE_CFG old_c
> +#define __ALTERNATIVE_CFG_2(old_c, ...)		ALTERNATIVE_CFG old_c
>   
>   #else /* !__ASSEMBLY__ */
>   
> -#define __ALTERNATIVE_CFG(old_c)	\
> -	old_c "\n"
> +#define __ALTERNATIVE_CFG(old_c, ...)		old_c "\n"
> +#define __ALTERNATIVE_CFG_2(old_c, ...)		old_c "\n"
>   
> -#define _ALTERNATIVE_CFG(old_c, ...)	\
> -	__ALTERNATIVE_CFG(old_c)
> +#endif /* __ASSEMBLY__ */
>   
> -#define _ALTERNATIVE_CFG_2(old_c, ...)	\
> -	__ALTERNATIVE_CFG(old_c)
> +#define _ALTERNATIVE_CFG(old_c, ...)		__ALTERNATIVE_CFG(old_c)
> +#define _ALTERNATIVE_CFG_2(old_c, ...)		__ALTERNATIVE_CFG_2(old_c)
>   
> -#endif /* __ASSEMBLY__ */
>   #endif /* CONFIG_RISCV_ALTERNATIVE */
>   
>   /*


I could not find the right Fixes tag, so unless you have one, I'll add 
the commit pointed at by kernel test robot.

You can add:

Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks for looking into this!

Alex


