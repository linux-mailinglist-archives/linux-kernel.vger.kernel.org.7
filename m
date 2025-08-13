Return-Path: <linux-kernel+bounces-766306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E78BAB244E5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080831B65A78
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521952E9EAF;
	Wed, 13 Aug 2025 09:02:10 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29A12D5A14
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755075729; cv=none; b=WqzwJuBfvv9a1sjQp2jruSUMx301OiIxHh1qudsC+Fjzb8V6MslqBdZfbXrMOFk46RoNgzEZZcEw6XiKUNcVEGyo7chpGkj1ZrMXgaCsQ2ppUJhGuKLM8THa5Fp97/g3/nOa3C92kVF0dL2y65ApBqpkwpJ7kbXfPwujCCngGdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755075729; c=relaxed/simple;
	bh=G1UUSPxwJPFh0OSozijaxnJtCy22AGNv480R14MO8k8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kaaDl5vPtiO/8thmPANORN8AHuUukAdGHzG2/d2eSDdaX9OfpPP0C6aXVsxG5SLc6VbLp4BxVVeiA0nB+ePT2pRN7XBOgH+5TIhO+jy/RvuRqnIlIl7O0zVwK7s4yuEtisatbHSBv+P6X+a3AqJm7u8PvIz/PAkUoJPho5w/ezc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id B3C65431F3;
	Wed, 13 Aug 2025 09:01:57 +0000 (UTC)
Message-ID: <d0f8d0d8-fb46-4009-a50f-3faacf8516fc@ghiti.fr>
Date: Wed, 13 Aug 2025 11:01:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/5] riscv: add SBI SSE extension definitions
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Himanshu Chauhan <hchauhan@ventanamicro.com>,
 Anup Patel <apatel@ventanamicro.com>, Xu Lu <luxu.kernel@bytedance.com>,
 Atish Patra <atishp@atishpatra.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Yunhui Cui <cuiyunhui@bytedance.com>
References: <20250808153901.2477005-1-cleger@rivosinc.com>
 <20250808153901.2477005-2-cleger@rivosinc.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250808153901.2477005-2-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeejkedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeelgeehveeivdeujeelkeevueettedvtdelheeftefhffejveejleekffegtdefffenucffohhmrghinheprhhishgtvhdrohhrghenucfkphepudelfedrfeefrdehjedrudelleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleefrdeffedrheejrdduleelpdhhvghloheplgduledvrdduieekrddvvddruddtudgnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtoheptghlvghgvghrsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvg
 hgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohephhgthhgruhhhrghnsehvvghnthgrnhgrmhhitghrohdrtghomhdprhgtphhtthhopegrphgrthgvlhesvhgvnhhtrghnrghmihgtrhhordgtohhm
X-GND-Sasl: alex@ghiti.fr

Hi Clément,

On 8/8/25 17:38, Clément Léger wrote:
> Add needed definitions for SBI Supervisor Software Events extension [1].
> This extension enables the SBI to inject events into supervisor software
> much like ARM SDEI.
>
> [1] https://lists.riscv.org/g/tech-prs/message/515
>
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>   arch/riscv/include/asm/sbi.h | 61 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 61 insertions(+)
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 341e74238aa0..e4993fb664d2 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -36,6 +36,7 @@ enum sbi_ext_id {
>   	SBI_EXT_STA = 0x535441,
>   	SBI_EXT_NACL = 0x4E41434C,
>   	SBI_EXT_FWFT = 0x46574654,
> +	SBI_EXT_SSE = 0x535345,
>   
>   	/* Experimentals extensions must lie within this range */
>   	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
> @@ -430,6 +431,66 @@ enum sbi_fwft_feature_t {
>   
>   #define SBI_FWFT_SET_FLAG_LOCK			BIT(0)
>   
> +enum sbi_ext_sse_fid {
> +	SBI_SSE_EVENT_ATTR_READ = 0,
> +	SBI_SSE_EVENT_ATTR_WRITE,
> +	SBI_SSE_EVENT_REGISTER,
> +	SBI_SSE_EVENT_UNREGISTER,
> +	SBI_SSE_EVENT_ENABLE,
> +	SBI_SSE_EVENT_DISABLE,
> +	SBI_SSE_EVENT_COMPLETE,
> +	SBI_SSE_EVENT_SIGNAL,


Nit but in the specification this event is referred as "inject" instead 
of "signal", any reason to change that naming?


> +	SBI_SSE_EVENT_HART_UNMASK,
> +	SBI_SSE_EVENT_HART_MASK,
> +};
> +
> +enum sbi_sse_state {
> +	SBI_SSE_STATE_UNUSED     = 0,
> +	SBI_SSE_STATE_REGISTERED = 1,
> +	SBI_SSE_STATE_ENABLED    = 2,
> +	SBI_SSE_STATE_RUNNING    = 3,
> +};
> +
> +/* SBI SSE Event Attributes. */
> +enum sbi_sse_attr_id {
> +	SBI_SSE_ATTR_STATUS		= 0x00000000,
> +	SBI_SSE_ATTR_PRIO		= 0x00000001,
> +	SBI_SSE_ATTR_CONFIG		= 0x00000002,
> +	SBI_SSE_ATTR_PREFERRED_HART	= 0x00000003,
> +	SBI_SSE_ATTR_ENTRY_PC		= 0x00000004,
> +	SBI_SSE_ATTR_ENTRY_ARG		= 0x00000005,
> +	SBI_SSE_ATTR_INTERRUPTED_SEPC	= 0x00000006,
> +	SBI_SSE_ATTR_INTERRUPTED_FLAGS	= 0x00000007,
> +	SBI_SSE_ATTR_INTERRUPTED_A6	= 0x00000008,
> +	SBI_SSE_ATTR_INTERRUPTED_A7	= 0x00000009,
> +
> +	SBI_SSE_ATTR_MAX		= 0x0000000A
> +};
> +
> +#define SBI_SSE_ATTR_STATUS_STATE_OFFSET	0
> +#define SBI_SSE_ATTR_STATUS_STATE_MASK		0x3
> +#define SBI_SSE_ATTR_STATUS_PENDING_OFFSET	2
> +#define SBI_SSE_ATTR_STATUS_INJECT_OFFSET	3
> +
> +#define SBI_SSE_ATTR_CONFIG_ONESHOT	BIT(0)
> +
> +#define SBI_SSE_ATTR_INTERRUPTED_FLAGS_SSTATUS_SPP	BIT(0)
> +#define SBI_SSE_ATTR_INTERRUPTED_FLAGS_SSTATUS_SPIE	BIT(1)
> +#define SBI_SSE_ATTR_INTERRUPTED_FLAGS_HSTATUS_SPV	BIT(2)
> +#define SBI_SSE_ATTR_INTERRUPTED_FLAGS_HSTATUS_SPVP	BIT(3)
> +
> +#define SBI_SSE_EVENT_LOCAL_HIGH_PRIO_RAS	0x00000000
> +#define SBI_SSE_EVENT_LOCAL_DOUBLE_TRAP		0x00000001
> +#define SBI_SSE_EVENT_GLOBAL_HIGH_PRIO_RAS	0x00008000
> +#define SBI_SSE_EVENT_LOCAL_PMU_OVERFLOW	0x00010000
> +#define SBI_SSE_EVENT_LOCAL_LOW_PRIO_RAS	0x00100000
> +#define SBI_SSE_EVENT_GLOBAL_LOW_PRIO_RAS	0x00108000
> +#define SBI_SSE_EVENT_LOCAL_SOFTWARE_INJECTED	0xffff0000
> +#define SBI_SSE_EVENT_GLOBAL_SOFTWARE_INJECTED	0xffff8000


And here you use "injected".


> +
> +#define SBI_SSE_EVENT_PLATFORM		BIT(14)
> +#define SBI_SSE_EVENT_GLOBAL		BIT(15)
> +
>   /* SBI spec version fields */
>   #define SBI_SPEC_VERSION_DEFAULT	0x1
>   #define SBI_SPEC_VERSION_MAJOR_SHIFT	24

