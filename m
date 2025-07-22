Return-Path: <linux-kernel+bounces-740173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D830B0D0ED
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 06:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5283F1AA3462
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 04:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F341C84DE;
	Tue, 22 Jul 2025 04:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="FMWVlV2N"
Received: from lf-1-19.ptr.blmpb.com (lf-1-19.ptr.blmpb.com [103.149.242.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C604414
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 04:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.149.242.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753159562; cv=none; b=mmyHuxkDb5vXb/RdRcppKK4UQ7WqzJEYJonuti2huJrZtKlLdexiysmQ0G1JbXpWzFLSg1o0YcPnqZSzhPdmhun/WpmJadoglukQt/uiZXMEH0tOb1I7BEt5wxclf5NNrkiM6G2v1yd3bUb8CwEwfE/6KGy9MggEGlKNAOvaQg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753159562; c=relaxed/simple;
	bh=1vQNK9Rt/Cndv7jSwRWun40QhRNeUa/Z2lEx7rUuFuA=;
	h=From:Message-Id:Content-Type:To:Cc:Subject:Date:Mime-Version:
	 References:In-Reply-To; b=LK/rV+ZU488frg5PfzYcHFKloCFgXcXDgBIN+i0NStGjtpp1TP+l2e0K1yrNTlzndTF2XyLfXc1bkmurfc2TXYSwzBHSlpOdo7CeM1mNtZQ2NPcmmQ/4OJ6NRCpzou3dypOpULDO9xtqCBInly72vuawYqsKaKwcjmK6b6L3k+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=FMWVlV2N; arc=none smtp.client-ip=103.149.242.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1753158788;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=Hzmpv4N547W+vBo+aJGwLDOqtL6G3pdPOh8VAcFg3f0=;
 b=FMWVlV2NyE7xWZUc8CjC12utDtxMol9z6LaGOHNWrDbtQe1YTcYVHyrONrj04w49lshIrV
 M1v8CRdWCbctUPTF9PTiLIjaP/v5EUD+drxo2cv5ZZtquo7V9kMwV/Iwbcb2nclELgIZdr
 p1vVq3pyXTEmKPcqMnXadLK251HrM07cb2nUlWqa4hPmaZ+xP5wjMzwXf3CC8qxiQICpLy
 eiuCjIzSu8yAR2x5DTL6r8R79A2l6BxyRGwB7bJXdczEiK+jZEZofH3UIjttm1ndtv4D9f
 rD9sswza6mG/WUm9nHoO78LdNANufl56EHN4ubYZnVty4AzEODy42VfuTwKD9Q==
From: "Nutty Liu" <liujingqi@lanxincomputing.com>
Message-Id: <b7dd1004-4bfd-43c7-aba7-823c0290b5d3@lanxincomputing.com>
X-Original-From: Nutty Liu <liujingqi@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8
To: "Junhui Liu" <junhui.liu@pigmoral.tech>, 
	"Paul Walmsley" <paul.walmsley@sifive.com>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, 
	"Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>
Cc: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+2687f1482+5142a2+vger.kernel.org+liujingqi@lanxincomputing.com>
Subject: Re: [PATCH 1/2] riscv: mm: Return intended SATP mode for noXlvl options
Date: Tue, 22 Jul 2025 12:33:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722-satp-from-fdt-v1-0-5ba22218fa5f@pigmoral.tech> <20250722-satp-from-fdt-v1-1-5ba22218fa5f@pigmoral.tech>
Received: from [127.0.0.1] ([116.237.111.137]) by smtp.feishu.cn with ESMTPS; Tue, 22 Jul 2025 12:33:05 +0800
In-Reply-To: <20250722-satp-from-fdt-v1-1-5ba22218fa5f@pigmoral.tech>
User-Agent: Mozilla Thunderbird

On 7/22/2025 12:53 AM, Junhui Liu wrote:
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

Nice, this change is a good idea. It's more readable.

Reviewed-by: Nutty Liu <liujingqi@lanxincomputing.com>

Thanks,
Nutty

