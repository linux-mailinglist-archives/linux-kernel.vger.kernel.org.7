Return-Path: <linux-kernel+bounces-745894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1DEB12023
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F8D566AAC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39331E5701;
	Fri, 25 Jul 2025 14:30:27 +0000 (UTC)
Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9387015B971
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753453827; cv=none; b=XSetAeqGlR6Q8tng8ylylIhflRdEaHzsY/QsSbDNq4FhRbzwXr+OeaNfYbiKbmCbyAHVVEo8qvUAYNl3B3Ybio2Rqir5cCh0bxX8tUM+/N06KQzhp4fRrtuiAGhnvDsIQ5G8N68opF+sY+ztgsDALVxq+5L908v6lm5+GeKMLaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753453827; c=relaxed/simple;
	bh=Fj1hfO2kIkR/Yz1RFGe7vt2a8YGAliWI4Gpsy0dyQus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SzAb155RkoI+1loK+L/hN1aWNMdrck7RRjjZkB6u1PdbgJTvC/n/xlWQrBn8+WJHfphzeOY8R7AISNMjqQO5MdCqVVLlEB4RY8LVxFQ8NBshjGXF6EmjKlvpLB1xf70f/G+yXnz1uH/ypXsg/4ukB+qx+IfSrQQMs3P9mrmiGe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2F847449AA;
	Fri, 25 Jul 2025 14:30:21 +0000 (UTC)
Message-ID: <77437392-5d68-4620-ba05-08eba133b547@ghiti.fr>
Date: Fri, 25 Jul 2025 16:30:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] riscv: pack rv64 thread_info better
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
 linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Deepak Gupta <debug@rivosinc.com>
References: <20250722160556.2216925-2-rkrcmar@ventanamicro.com>
 <20250722160556.2216925-5-rkrcmar@ventanamicro.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250722160556.2216925-5-rkrcmar@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekfeejjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnheptdeguefhhfevueejteevveeikeelkedvffdufeelveeggfeikeekgfeghfdttdevnecukfhppeelhedrudeguddruddtvddrudekieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeelhedrudeguddruddtvddrudekiedphhgvlhhopegluddtrddutddrudegiedrvddujegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepjedprhgtphhtthhopehrkhhrtghmrghrsehvvghnthgrnhgrmhhitghrohdrtghomhdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmp
 dhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhidrvgguuhdprhgtphhtthhopeguvggsuhhgsehrihhvohhsihhntgdrtghomh


On 7/22/25 18:05, Radim Krčmář wrote:
> On rv64, preempt_count and cpu were both 32-bit followed by 64-bit, so
> placing one in the hole saves 8 bytes in the struct.
>
> Signed-off-by: Radim Krčmář <rkrcmar@ventanamicro.com>
> ---
>   arch/riscv/include/asm/thread_info.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
> index f5916a70879a..c267d6bd838e 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -53,6 +53,7 @@
>   struct thread_info {
>   	unsigned long		flags;		/* low level flags */
>   	int                     preempt_count;  /* 0=>preemptible, <0=>BUG */
> +	int			cpu;
>   	/*
>   	 * These stack pointers are overwritten on every system call or
>   	 * exception.  SP is also saved to the stack it can be recovered when
> @@ -60,7 +61,6 @@ struct thread_info {
>   	 */
>   	long			kernel_sp;	/* Kernel stack pointer */
>   	long			user_sp;	/* User stack pointer */
> -	int			cpu;
>   	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
>   #ifdef CONFIG_SHADOW_CALL_STACK
>   	void			*scs_base;


Great, that now fits into a cacheline. I guess other structures would 
deserve the same attention.

You can add:

Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


