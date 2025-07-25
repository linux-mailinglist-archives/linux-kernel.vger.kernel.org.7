Return-Path: <linux-kernel+bounces-745872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25074B11FD9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519C53A9E8A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4D61E8337;
	Fri, 25 Jul 2025 14:14:46 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BB719E99F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753452886; cv=none; b=aCqEoaV9kCFRQb2FCJY6TLX/x400JX84C/gVD6QMn7ogbGBp89iGohCGgdW4zrDki6DZAU4FW9whDjCHFSjxNTrIF7vEZfQJhChsJbr840OgPQVnKF4Q9G5KHKCUFS14a8kFvMrkF3wEzvJ35xkofoqc3+XzELy2TENZEUZxfNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753452886; c=relaxed/simple;
	bh=U/okvdiR6HPGvGXmKGx/gqUNpFyvycUVJ8180zQCc0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DR9CFwndjDQ+kwS3WO8Ke8a1vSYt/16sw5NMbZzqbwHPD4rJUIVxK2o65P42IAz+8uEJ/lvSZ83Rsou5Lff+ZOXJENxXxwjwIhW+7TDkaidpqn2JQ/bVLd4Xof6Ks+vtSk4mXmeT5Yf5YxDEPQygvpEuiSSNim+Qk9bnTjvi0jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5137C441CB;
	Fri, 25 Jul 2025 14:14:41 +0000 (UTC)
Message-ID: <04d6d616-6df4-4c39-8813-31f95145c3bb@ghiti.fr>
Date: Fri, 25 Jul 2025 16:14:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] riscv: use TASK_TI_CPU instead of TASK_TI_CPU_NUM
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
 linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Deepak Gupta <debug@rivosinc.com>
References: <20250722160556.2216925-2-rkrcmar@ventanamicro.com>
 <20250722160556.2216925-3-rkrcmar@ventanamicro.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250722160556.2216925-3-rkrcmar@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekfeejgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnheptdeguefhhfevueejteevveeikeelkedvffdufeelveeggfeikeekgfeghfdttdevnecukfhppeelhedrudeguddruddtvddrudekieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeelhedrudeguddruddtvddrudekiedphhgvlhhopegluddtrddutddrudegiedrvddujegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepjedprhgtphhtthhopehrkhhrtghmrghrsehvvghnthgrnhgrmhhitghrohdrtghomhdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmp
 dhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhidrvgguuhdprhgtphhtthhopeguvggsuhhgsehrihhvohhsihhntgdrtghomh
X-GND-Sasl: alex@ghiti.fr

Hi Radim,

On 7/22/25 18:05, Radim Krčmář wrote:
> The offsets of TASK_TI_CPU and TASK_TI_CPU_NUM are identical, and
> TASK_TI_CPU is a better name for thread_info.cpu.
>
> Signed-off-by: Radim Krčmář <rkrcmar@ventanamicro.com>
> ---
>   arch/riscv/include/asm/asm.h    | 2 +-
>   arch/riscv/kernel/asm-offsets.c | 1 -
>   2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
> index a8a2af6dfe9d..b3022bc224ec 100644
> --- a/arch/riscv/include/asm/asm.h
> +++ b/arch/riscv/include/asm/asm.h
> @@ -91,7 +91,7 @@
>   #endif
>   
>   .macro asm_per_cpu dst sym tmp
> -	REG_L \tmp, TASK_TI_CPU_NUM(tp)
> +	REG_L \tmp, TASK_TI_CPU(tp)
>   	slli  \tmp, \tmp, PER_CPU_OFFSET_SHIFT
>   	la    \dst, __per_cpu_offset
>   	add   \dst, \dst, \tmp
> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
> index 6e8c0d6feae9..49cf2c347485 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -49,7 +49,6 @@ void asm_offsets(void)
>   	OFFSET(TASK_TI_A2, task_struct, thread_info.a2);
>   #endif
>   
> -	OFFSET(TASK_TI_CPU_NUM, task_struct, thread_info.cpu);
>   	OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
>   	OFFSET(TASK_THREAD_F1,  task_struct, thread.fstate.f[1]);
>   	OFFSET(TASK_THREAD_F2,  task_struct, thread.fstate.f[2]);


Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


