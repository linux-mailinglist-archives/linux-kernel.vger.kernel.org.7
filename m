Return-Path: <linux-kernel+bounces-745858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 889C7B11FB4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10E317045F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE991ADC97;
	Fri, 25 Jul 2025 14:02:42 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C1F10FD
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753452161; cv=none; b=f0dhGFk2bivzJiksSd8ZbYoPzfKJyyV/7j2y14XWbnTTFH+0SsvUqtbSxp07PVGTuiLrh23q7jX9OTSJgo2mS8ziH0cDDt3OwL2tMQ1VVwnNGr+t6Nr7YWvey0a9we+4vgQa5gLZ+KCKllvqYn+19lbor/Ea2KFSZwbGaDRQnB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753452161; c=relaxed/simple;
	bh=NiBcFMRFBbhNru3GR7IYCTWSb1pGtoRON3c/CeALEYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=knagyFvRK23uuXr/OBDnXNDiJAINQ6wN+jgdvTiAERhqmnBOadrURML/sO6mmnOyAWg5mrUXirexLzSYunsOaDTdWXlmJRgc7cDDj3SXLEbcACQvSFyHCj4hhEQAx99TjLntiS5XowwQLoUJ6lhe+rD/RZE9n5ki5I0v8QVHnUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1FF05441C5;
	Fri, 25 Jul 2025 14:02:28 +0000 (UTC)
Message-ID: <7b127468-9333-4425-bfe4-91ffa5b2e242@ghiti.fr>
Date: Fri, 25 Jul 2025 16:02:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] riscv: mm: Return intended SATP mode for noXlvl
 options
To: Junhui Liu <junhui.liu@pigmoral.tech>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250722-satp-from-fdt-v1-0-5ba22218fa5f@pigmoral.tech>
 <20250722-satp-from-fdt-v1-1-5ba22218fa5f@pigmoral.tech>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250722-satp-from-fdt-v1-1-5ba22218fa5f@pigmoral.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekfeejvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnheptdfhleefjeegheevgeeljeellefgvefhkeeiffekueejteefvdevhfelvdeggeeinecukfhppeelhedrudeguddruddtvddrudekieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeelhedrudeguddruddtvddrudekiedphhgvlhhopegluddtrddutddrudegiedrvddujegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepiedprhgtphhtthhopehjuhhnhhhuihdrlhhiuhesphhighhmohhrrghlrdhtvggthhdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhop
 ehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: alex@ghiti.fr

Hi Junhui,

On 7/21/25 18:53, Junhui Liu wrote:
> Change the return value of match_noXlvl() to return the SATP mode that
> will be used, rather than the mode being disabled. This enables unified
> logic for return value judgement with the function that obtains mmu-type
> from the fdt, avoiding extra conversion. This only changes the naming,
> with no functional impact.
>
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> ---
>   arch/riscv/kernel/pi/cmdline_early.c | 4 ++--
>   arch/riscv/mm/init.c                 | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/kernel/pi/cmdline_early.c b/arch/riscv/kernel/pi/cmdline_early.c
> index fbcdc9e4e14322af0cedd31343aeb9403ba2dd14..389d086a071876dde2fd57ee6f6661e65c38b7c4 100644
> --- a/arch/riscv/kernel/pi/cmdline_early.c
> +++ b/arch/riscv/kernel/pi/cmdline_early.c
> @@ -41,9 +41,9 @@ static char *get_early_cmdline(uintptr_t dtb_pa)
>   static u64 match_noXlvl(char *cmdline)
>   {
>   	if (strstr(cmdline, "no4lvl"))
> -		return SATP_MODE_48;
> +		return SATP_MODE_39;
>   	else if (strstr(cmdline, "no5lvl"))
> -		return SATP_MODE_57;
> +		return SATP_MODE_48;
>   
>   	return 0;
>   }
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 8d0374d7ce8ed72320f58e4cea212d0e2bce8fd4..d03e02a92379f2338a4f4df0ab797a7859b83dfc 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -864,9 +864,9 @@ static __init void set_satp_mode(uintptr_t dtb_pa)
>   
>   	kernel_map.page_offset = PAGE_OFFSET_L5;
>   
> -	if (satp_mode_cmdline == SATP_MODE_57) {
> +	if (satp_mode_cmdline == SATP_MODE_48) {
>   		disable_pgtable_l5();
> -	} else if (satp_mode_cmdline == SATP_MODE_48) {
> +	} else if (satp_mode_cmdline == SATP_MODE_39) {
>   		disable_pgtable_l5();
>   		disable_pgtable_l4();
>   		return;
>

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


