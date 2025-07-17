Return-Path: <linux-kernel+bounces-734895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 953E7B087D1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62C21AA5FFD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1E7285CAC;
	Thu, 17 Jul 2025 08:21:46 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9092727BF89
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 08:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752740505; cv=none; b=rnMuwecydlV/kd0a0o/5wCMcVmjtS0DKcDUq2EaPwZUrpjqjGRNnI62aAxtxHTvmwWdIMSfWSaRELEWbV+XJ9PGa0nS19RkcSJBPulTjD6iFQWrDy9Xk4yORv+Xk3fELXWRkyL0aqSo/HQIBYOe9R/5ZFkgL21EbXBbAMBsFK7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752740505; c=relaxed/simple;
	bh=NAOvq7vfIBtjbd2uyZc4mTvnbKjkqEZAw4djlYUSkBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rzM6Fn8/BRv7ivTv+ymn1XOwKdANcdSjzLZkCI64GIT1p86NY56eAzokeRKtl/uAW0P7qBO6KTIptSR95A/8wUeCinDP3CNyvrVUvMlVzw3BV/KBVNwDKaXTj2RjUUNv6O5iBXmc/TgJfOIE8e5/TbLnvRkuwDu2LNdJ1sKaW9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 96B5543157;
	Thu, 17 Jul 2025 08:21:38 +0000 (UTC)
Message-ID: <c6045d12-4e6c-4b95-b23e-289ce92b7474@ghiti.fr>
Date: Thu, 17 Jul 2025 10:21:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] riscv: Move vendor errata definitions to new
 header
To: guoren@kernel.org, palmer@dabbelt.com, conor@kernel.org,
 alexghiti@rivosinc.com, paul.walmsley@sifive.com, bjorn@rivosinc.com,
 eobras@redhat.com, corbet@lwn.net, peterlin@andestech.com,
 rabenda.cn@gmail.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250713155321.2064856-1-guoren@kernel.org>
 <20250713155321.2064856-2-guoren@kernel.org>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250713155321.2064856-2-guoren@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpedthfelfeejgeehveegleejleelgfevhfekieffkeeujeetfedvvefhledvgeegieenucfkphepudekhedrvddufedrudehgedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedukeehrddvudefrdduheegrdduhedupdhhvghloheplgdutddrudegrddtrddufegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtohepghhuohhrvghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegtohhnohhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgihghhhithhisehrihhvohhsihhntgdrtghomhdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopegsjhhorhhnsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopegvohgsrhgrshesrhgvughhrghtr
 dgtohhmpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvght
X-GND-Sasl: alex@ghiti.fr

Hi Guo,

On 7/13/25 17:53, guoren@kernel.org wrote:
> From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
>
> Move vendor errata definitions into errata_list_vendors.h.
>
> Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
> ---
>   arch/riscv/include/asm/errata_list.h         | 19 +---------------
>   arch/riscv/include/asm/errata_list_vendors.h | 24 ++++++++++++++++++++
>   2 files changed, 25 insertions(+), 18 deletions(-)
>   create mode 100644 arch/riscv/include/asm/errata_list_vendors.h
>
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index 6e426ed7919a..18c9f7ee9b7c 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -10,24 +10,7 @@
>   #include <asm/insn-def.h>
>   #include <asm/hwcap.h>
>   #include <asm/vendorid_list.h>
> -
> -#ifdef CONFIG_ERRATA_ANDES
> -#define ERRATA_ANDES_NO_IOCP 0
> -#define ERRATA_ANDES_NUMBER 1
> -#endif
> -
> -#ifdef CONFIG_ERRATA_SIFIVE
> -#define	ERRATA_SIFIVE_CIP_453 0
> -#define	ERRATA_SIFIVE_CIP_1200 1
> -#define	ERRATA_SIFIVE_NUMBER 2
> -#endif
> -
> -#ifdef CONFIG_ERRATA_THEAD
> -#define	ERRATA_THEAD_MAE 0
> -#define	ERRATA_THEAD_PMU 1
> -#define	ERRATA_THEAD_GHOSTWRITE 2
> -#define	ERRATA_THEAD_NUMBER 3
> -#endif
> +#include <asm/errata_list_vendors.h>
>   
>   #ifdef __ASSEMBLY__
>   
> diff --git a/arch/riscv/include/asm/errata_list_vendors.h b/arch/riscv/include/asm/errata_list_vendors.h
> new file mode 100644
> index 000000000000..a37d1558f39f
> --- /dev/null
> +++ b/arch/riscv/include/asm/errata_list_vendors.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef ASM_ERRATA_LIST_VENDORS_H
> +#define ASM_ERRATA_LIST_VENDORS_H
> +
> +#ifdef CONFIG_ERRATA_ANDES
> +#define ERRATA_ANDES_NO_IOCP 0
> +#define ERRATA_ANDES_NUMBER 1
> +#endif
> +
> +#ifdef CONFIG_ERRATA_SIFIVE
> +#define	ERRATA_SIFIVE_CIP_453 0
> +#define	ERRATA_SIFIVE_CIP_1200 1
> +#define	ERRATA_SIFIVE_NUMBER 2
> +#endif
> +
> +#ifdef CONFIG_ERRATA_THEAD
> +#define	ERRATA_THEAD_MAE 0
> +#define	ERRATA_THEAD_PMU 1
> +#define	ERRATA_THEAD_GHOSTWRITE 2
> +#define	ERRATA_THEAD_NUMBER 3
> +#endif
> +
> +#endif


Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


