Return-Path: <linux-kernel+bounces-740527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2007BB0D545
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2F21891B76
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C1E2D3A7C;
	Tue, 22 Jul 2025 09:07:28 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2137F4CE08
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753175248; cv=none; b=FVa+2mDxqiBxztYGi/zM8OGhpyrNmUqTDP48InZER/4jhYG0aiZTdSk0zUOXUfK4NiS4NbspN+N3uciH0Bh+B6gFr15UrgHZ5Iu7a7LZWUCw+BC40DPNRAZmOB0ZvQz9kc78yMIIWRyIKY5AZ/BMo3QHhFub0+/N8URcu3l8XlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753175248; c=relaxed/simple;
	bh=uu7YEV+sBYy0lZ9HJM6cHIKZrL33VDKt+RK+6r+PsbI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pZrp9trXBettpuLOPK3YgKmyNPpLQi+ez+48rYiAWsP2XPx6IXlnoC3AnfNAPVlaY5C9pCUMcw8XXr7+F+DzF+G729rMwZLzggd6wne7J03f+nciMyNuugcjIGiOlC/Cx4PBP8S3kyyPoawGPQkIObp1K8ecrtv20FszI8A4FPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8CxTOLHVH9oaH4vAQ--.55719S3;
	Tue, 22 Jul 2025 17:07:19 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJAxE+S4VH9ohbEhAA--.44151S3;
	Tue, 22 Jul 2025 17:07:06 +0800 (CST)
Subject: Re: [PATCH v2] LoongArch: Implement physical address with ELF program
 header
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, WANG Xuerui <kernel@xen0n.name>,
 Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250721091248.3896152-1-maobibo@loongson.cn>
 <202507220309.mDl9W32Y-lkp@intel.com>
 <7a5789f1-d6a5-3892-98c1-2c4b8515459d@loongson.cn>
 <CAAhV-H74EpbKsPpc_ToGqP6LKx04z+Dvyuw52u-1A4nQ-wr6WQ@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <d6b6aaa8-06f2-1b0d-5ebc-e7a71a20dd7a@loongson.cn>
Date: Tue, 22 Jul 2025 17:05:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H74EpbKsPpc_ToGqP6LKx04z+Dvyuw52u-1A4nQ-wr6WQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxE+S4VH9ohbEhAA--.44151S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXw1xGw4kAF4UZFW8JF13GFX_yoWrZw43pr
	n5AayqqF4UKr93X34DKFn0gw1qqrnxWr42qa98J3WfCFy7XF18Z3s7Gr9ruasFq34UK3W0
	gFyrGayjya4Ut3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_
	JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48J
	MxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0Urc3UUUU
	U==



On 2025/7/22 下午12:58, Huacai Chen wrote:
> On Tue, Jul 22, 2025 at 9:33 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> Oops, it is the obvious compile issue. And I am messed with parallel
>> tasks and do not notice this, what I test is old kernel.
>>
>> Regards
>> Bibo Mao
> Add this part to the patch is enough.
> 
> diff --git a/arch/loongarch/include/asm/addrspace.h
> b/arch/loongarch/include/asm/addrspace.h
> index fe198b473f84..babcc1c6c820 100644
> --- a/arch/loongarch/include/asm/addrspace.h
> +++ b/arch/loongarch/include/asm/addrspace.h
> @@ -18,11 +18,20 @@
>   /*
>    * This gives the physical RAM offset.
>    */
> -#ifndef __ASSEMBLER__
> +#ifdef __ASSEMBLER__
> +
> +#ifndef PHYS_OFFSET
> +#define PHYS_OFFSET    0
> +#endif
> +
> +#else
> +
>   #ifndef PHYS_OFFSET
>   #define PHYS_OFFSET    _UL(0)
>   #endif
> +
>   extern unsigned long vm_map_base;
> +
>   #endif /* __ASSEMBLER__ */
> 
>   #ifndef IO_BASE
sure, will do in this way.

Regards
Bibo Mao
> 
>>
>> On 2025/7/22 上午3:19, kernel test robot wrote:
>>> Hi Bibo,
>>>
>>> kernel test robot noticed the following build errors:
>>>
>>> [auto build test ERROR on 89be9a83ccf1f88522317ce02f854f30d6115c41]
>>>
>>> url:    https://github.com/intel-lab-lkp/linux/commits/Bibo-Mao/LoongArch-Implement-physical-address-with-ELF-program-header/20250721-171418
>>> base:   89be9a83ccf1f88522317ce02f854f30d6115c41
>>> patch link:    https://lore.kernel.org/r/20250721091248.3896152-1-maobibo%40loongson.cn
>>> patch subject: [PATCH v2] LoongArch: Implement physical address with ELF program header
>>> config: loongarch-allnoconfig (https://download.01.org/0day-ci/archive/20250722/202507220309.mDl9W32Y-lkp@intel.com/config)
>>> compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 853c343b45b3e83cc5eeef5a52fc8cc9d8a09252)
>>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250722/202507220309.mDl9W32Y-lkp@intel.com/reproduce)
>>>
>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202507220309.mDl9W32Y-lkp@intel.com/
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>>> ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:15: symbol not found: PHYS_OFFSET
>>>      ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:18: symbol not found: PHYS_OFFSET
>>>      ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:33: symbol not found: PHYS_OFFSET
>>>      ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:34: symbol not found: PHYS_OFFSET
>>>      ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:41: symbol not found: PHYS_OFFSET
>>>      ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:46: symbol not found: PHYS_OFFSET
>>>      ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:47: symbol not found: PHYS_OFFSET
>>>      ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:50: symbol not found: PHYS_OFFSET
>>>      ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not found: PHYS_OFFSET
>>>      ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not found: PHYS_OFFSET
>>>      ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not found: PHYS_OFFSET
>>>      ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not found: PHYS_OFFSET
>>>      ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not found: PHYS_OFFSET
>>>      ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not found: PHYS_OFFSET
>>>      ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not found: PHYS_OFFSET
>>>      ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not found: PHYS_OFFSET
>>>      ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not found: PHYS_OFFSET
>>>      ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not found: PHYS_OFFSET
>>>      ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not found: PHYS_OFFSET
>>>      ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not found: PHYS_OFFSET
>>>      ld.lld: error: too many errors emitted, stopping now (use --error-limit=0 to see all errors)
>>>
>>


