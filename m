Return-Path: <linux-kernel+bounces-734847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83052B08717
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 917F81883E6B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603DE2528F7;
	Thu, 17 Jul 2025 07:38:24 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AB520468E
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752737904; cv=none; b=kL+TRNJloJsW2ZVkXJzNudXHJw9L6wGwGn/OXRnasVytvV7wRftp8/iUE9ywP1/YTIMGGpjNGO6pPcY70IF+Rx/LDAH8CS1Wv083MXjZRDZ5E/P1vud1Uop3NFDEz6DlbrOz3F1e1B9bmgWLMg3D3dUzdCN5WGLYr6uryAj40PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752737904; c=relaxed/simple;
	bh=7HyleOpcsK2ThKDAfQldZoEJp2sJOyUWxl/yzQfSZFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T/Qq25mYRtsURBAVeGeOQaq36rdSN6omA04fyIu1gtpVer6QphKzS0Q0CEnisMvw2jnWIFIIWLam2t2vGzHeQyr0hUJUizRViNdAFzPfNXvKp7G9WjTWt+/Lq1F/hfWMWkzNZELq1PIOZEg5YeJMtZdsIR2Ul7yxEH8OnSthDO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 622C844362;
	Thu, 17 Jul 2025 07:38:13 +0000 (UTC)
Message-ID: <970a2116-58d2-466f-8a3e-f1b9e99ccf9b@ghiti.fr>
Date: Thu, 17 Jul 2025 09:38:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] riscv: Enable ARCH_HAVE_NMI_SAFE_CMPXCHG
To: Pu Lehui <pulehui@huaweicloud.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Pu Lehui <pulehui@huawei.com>
References: <20250711090443.1688404-1-pulehui@huaweicloud.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250711090443.1688404-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitddtudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnheptdfhleefjeegheevgeeljeellefgvefhkeeiffekueejteefvdevhfelvdeggeeinecukfhppedukeehrddvudefrdduheegrdduhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudekhedrvddufedrudehgedrudehuddphhgvlhhopegluddtrddugedrtddrudefngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeehpdhrtghpthhtohepphhulhgvhhhuiheshhhurgifvghitghlohhuugdrtghomhdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtohepphhulhgvhhhuiheshhhurgifvghirdgtohhm
X-GND-Sasl: alex@ghiti.fr

Hi Pu,

On 7/11/25 11:04, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
>
> The implement of cmpxchg() in riscv is based on atomic primitives and
> has NMI-safe features, so it can be used safely in the in_nmi context.
> ftrace's ringbuffer relies on NMI-safe cmpxchg() in the NMI context.
> Currently, in_nmi() is true when riscv kprobe is in trap-based mode, so
> this config needs to be selected, otherwise kprobetrace will not be
> available.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>   arch/riscv/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 36061f4732b7..0e2dfa98338a 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -23,6 +23,7 @@ config RISCV
>   	select ARCH_ENABLE_MEMORY_HOTREMOVE if MEMORY_HOTPLUG
>   	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
>   	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
> +	select ARCH_HAVE_NMI_SAFE_CMPXCHG
>   	select ARCH_HAS_BINFMT_FLAT
>   	select ARCH_HAS_CRC32 if RISCV_ISA_ZBC
>   	select ARCH_HAS_CRC64 if 64BIT && RISCV_ISA_ZBC


Given the definition of ARCH_HAVE_NMI_SAFE_CMPXCHG in commit 
df013ffb8119 ("Add Kconfig option ARCH_HAVE_NMI_SAFE_CMPXCHG"), we can 
indeed enable this config, so:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

And I followed your instructions in your answer, it works as you 
presented so:

Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>

I'll send this as part of my 6.17 PR.

Thanks,

Alex


