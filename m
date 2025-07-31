Return-Path: <linux-kernel+bounces-752265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2819FB17351
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22161189709B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6898A19C556;
	Thu, 31 Jul 2025 14:39:22 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6581A01C6
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753972762; cv=none; b=MVlRqvdh61QeLChFpfD/3cQl4Sbi4bmZ7ay+dsTO5QnPGCC3MTYmR5mZ8tMBzqNQ+MAWDyvA0Ito1nttdBCASpdDrIGg+sOcMN4Zsaz0cVDW+Ud82YOLzcwdym7n/mDDtNzfGrKwyUK6+mKnwgGM6wXb7/Bydn00dq+w0TN9xiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753972762; c=relaxed/simple;
	bh=PSvok+NtvgwqPlisIQL40EH1SwWIj4HPN7IwjHvE9YQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFT4eomQ9+Hg9HhmKv5r9m28W/c9zrtAjaSEwnUDaHI9v8ymyLa9VF1nC0u897wftofVsSagZe5oMlpbAOKOTp0eK2vLvSZmQ/x8oj+r1IgUYj0KbfRMEtPn6kE4YxZjdYfZ8HBxoVRGaCT+a70B8u43TIYRZozkWl9WrHIdcQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 45A87442A1;
	Thu, 31 Jul 2025 14:39:09 +0000 (UTC)
Message-ID: <4a887fce-a04a-4c85-8051-50afe88fd098@ghiti.fr>
Date: Thu, 31 Jul 2025 16:39:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] riscv: introduce ioremap_wc()
To: Yunhui Cui <cuiyunhui@bytedance.com>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, akpm@linux-foundation.org,
 catalin.marinas@arm.com, anshuman.khandual@arm.com, kas@kernel.org,
 ryan.roberts@arm.com, samuel.holland@sifive.com, namcao@linutronix.de,
 willy@infradead.org, abrestic@rivosinc.com, yongxuan.wang@sifive.com,
 apopple@nvidia.com, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Qingfang Deng <qingfang.deng@siflower.com.cn>
References: <20250722091504.45974-1-cuiyunhui@bytedance.com>
 <20250722091504.45974-2-cuiyunhui@bytedance.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250722091504.45974-2-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddutdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpedthfelfeejgeehveegleejleelgfevhfekieffkeeujeetfedvvefhledvgeegieenucfkphepvdgrtdegmegtvggttdemuddtjeefmegslegsgeemugejhegvmegtsgefjeemfeekudeimehfkeejvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtgeemtggvtgdtmedutdejfeemsgelsgegmegujeehvgemtggsfeejmeefkeduieemfhekjegvpdhhvghloheplgfkrfggieemvdgrtdegmegtvggttdemuddtjeefmegslegsgeemugejhegvmegtsgefjeemfeekudeimehfkeejvggnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepudekpdhrtghpthhtoheptghuihihuhhnhhhuihessgihthgvuggrnhgtvgdrtghomhdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsv
 ghlthdrtghomhdprhgtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhrtghpthhtoheprghnshhhuhhmrghnrdhkhhgrnhguuhgrlhesrghrmhdrtghomhdprhgtphhtthhopehkrghssehkvghrnhgvlhdrohhrgh
X-GND-Sasl: alex@ghiti.fr

Hi Yunhui,

On 7/22/25 11:15, Yunhui Cui wrote:
> Compared with IO attributes, NC attributes can improve performance,
> specifically in these aspects: Relaxed Order, Gathering, Supports Read
> Speculation, Supports Unaligned Access.
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> Signed-off-by: Qingfang Deng <qingfang.deng@siflower.com.cn>
> ---
>   arch/riscv/include/asm/io.h      | 4 ++++
>   arch/riscv/include/asm/pgtable.h | 1 +
>   2 files changed, 5 insertions(+)
>
> diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
> index a0e51840b9db4..09bb5f57a9d34 100644
> --- a/arch/riscv/include/asm/io.h
> +++ b/arch/riscv/include/asm/io.h
> @@ -28,6 +28,10 @@
>   #ifdef CONFIG_MMU
>   #define IO_SPACE_LIMIT		(PCI_IO_SIZE - 1)
>   #define PCI_IOBASE		((void __iomem *)PCI_IO_START)
> +
> +#define ioremap_wc(addr, size)	\
> +	ioremap_prot((addr), (size), __pgprot(_PAGE_KERNEL_NC))
> +
>   #endif /* CONFIG_MMU */
>   
>   /*
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 91697fbf1f901..3d17399a06c77 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -203,6 +203,7 @@ extern struct pt_alloc_ops pt_ops __meminitdata;
>   
>   #define PAGE_TABLE		__pgprot(_PAGE_TABLE)
>   
> +#define _PAGE_KERNEL_NC ((_PAGE_KERNEL & ~_PAGE_MTMASK) | _PAGE_NOCACHE)
>   #define _PAGE_IOREMAP	((_PAGE_KERNEL & ~_PAGE_MTMASK) | _PAGE_IO)
>   #define PAGE_KERNEL_IO		__pgprot(_PAGE_IOREMAP)
>   


I have just confirmed with Ved that mapping WC to NC is the correct 
thing to do, so:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

And I'll take that for 6.17.

Thanks,

Alex


