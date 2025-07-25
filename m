Return-Path: <linux-kernel+bounces-745884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F507B12001
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E21A1C26E9B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AE71FC0E2;
	Fri, 25 Jul 2025 14:21:43 +0000 (UTC)
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EBF1E833D
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753453303; cv=none; b=BSYWYdOJGsLcFrV0QjrbXfRZUD1S2NuviRlWvij5Z+FQYyYb4nv5YNdeqXKdIGNBG2NPRitBh6kLEJ890865uZ1k5A/GpoaeV5bJ2TYA8ZIYoR4hcoogYKLtw4/V2+nagGHJNS0GeaRhgZM9xAI1S5ukcsp5XlTH8gRr/Y3VcPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753453303; c=relaxed/simple;
	bh=Dgcb01g50UZw+LnvgphrRYVFZimxYrj3NmVGS8CEt6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VpGlRCUZ31p9UzCfiBRrocTQnzDRl3kw9LrPdBiPjaV3NQ4oZjXefN7SpN1WX2BgOvV/7iWtO21tWSjNAPIrzAfM1xvq3Va1CXnxvlfbiB5MNRlB6Ec7Oi3KB1Rj06r9KqGtsXLfSM2CEPo2WgUkA+1rert9d7qrot5MAMHiCHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 412DE44280;
	Fri, 25 Jul 2025 14:21:31 +0000 (UTC)
Message-ID: <61532c2c-0509-49ed-bdb5-f229f0be8576@ghiti.fr>
Date: Fri, 25 Jul 2025 16:21:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] riscv: use lw instead of REG_L when reading int cpu
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
 linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Deepak Gupta <debug@rivosinc.com>
References: <20250722160556.2216925-2-rkrcmar@ventanamicro.com>
 <20250722160556.2216925-4-rkrcmar@ventanamicro.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250722160556.2216925-4-rkrcmar@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekfeejiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhephffhtdefjeetgfdvhfehgefhteekkeevffehheegtedtieduheeltdegheeuleffnecuffhomhgrihhnpegvnhhtrhihrdhssgenucfkphepleehrddugedurddutddvrddukeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepleehrddugedurddutddvrddukeeipdhhvghloheplgdutddruddtrddugeeirddvudejngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheprhhkrhgtmhgrrhesvhgvnhhtrghnrghmihgtrhhordgtohhmpdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehpr
 ghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtohepuggvsghughesrhhivhhoshhinhgtrdgtohhm


On 7/22/25 18:05, Radim Krčmář wrote:
> REG_L is wrong, because thread_info.cpu is 32-bit, not xlen-bit wide.
> The struct currently has a hole after cpu, so little endian accesses
> seemed fine.
>
> Fixes: be97d0db5f44 ("riscv: VMAP_STACK overflow detection thread-safe")
> Fixes: 503638e0babf ("riscv: Stop emitting preventive sfence.vma for new vmalloc mappings")
> Signed-off-by: Radim Krčmář <rkrcmar@ventanamicro.com>
> ---
>   arch/riscv/include/asm/asm.h | 2 +-
>   arch/riscv/kernel/entry.S    | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
> index b3022bc224ec..93b1e4ce34d1 100644
> --- a/arch/riscv/include/asm/asm.h
> +++ b/arch/riscv/include/asm/asm.h
> @@ -91,7 +91,7 @@
>   #endif
>   
>   .macro asm_per_cpu dst sym tmp
> -	REG_L \tmp, TASK_TI_CPU(tp)
> +	lw    \tmp, TASK_TI_CPU(tp)
>   	slli  \tmp, \tmp, PER_CPU_OFFSET_SHIFT
>   	la    \dst, __per_cpu_offset
>   	add   \dst, \dst, \tmp
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 75656afa2d6b..4fdf187a62bf 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -46,7 +46,7 @@
>   	 * a0 = &new_vmalloc[BIT_WORD(cpu)]
>   	 * a1 = BIT_MASK(cpu)
>   	 */
> -	REG_L 	a2, TASK_TI_CPU(tp)
> +	lw	a2, TASK_TI_CPU(tp)
>   	/*
>   	 * Compute the new_vmalloc element position:
>   	 * (cpu / 64) * 8 = (cpu >> 6) << 3


I went across the same kind of bug a week ago, thanks for catching this one.

You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Though, to get backported to stable kernels, it will be easier if you 
split this patch into 2 independent patches as it will fail to apply on 
older releases. And it should not be dependent on the renaming of 
TASK_TI_CPU_NUM.

Please also add:

Cc: <stable@vger.kernel.org>

So that they will get backported automatically.

Thanks again for the catch,

Alex



