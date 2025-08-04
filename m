Return-Path: <linux-kernel+bounces-754636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0ECB19A4F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 04:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1D417449D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 02:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951B321C182;
	Mon,  4 Aug 2025 02:53:17 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9B020A5EB
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 02:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754275997; cv=none; b=AtDsteABToe/messNSCV73KHkEIkGpvboJS8mzrabFXNDJQlGmFebqeK8NrtvzFpFGbFoIsAGXiTkReuSFP6w6+kA9WqGzIM+KbU3ee9qmeMALI4DdsBq/hyMje5HVPTtzmodWsWgI/BEKdCZ7dHCazgGcrNnrejg6a8O9dWVro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754275997; c=relaxed/simple;
	bh=l5B4lJwk8CEdP9mZBAa5j1SigN5pFdanxaMinONd+p8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PdIe6OXkqIqdDorOtcz0h9qn99xAfj9gSSvzBkmijHp5IGmzxwY3v2XGO1Wsb5HKELT3lmgKUlx8PuTXXRLBRO2921Pe30KWYpfCSS3znj6Fu0RMG++yS01kbyEzMziSwMg39myIy/0qDZM5OIeH835q/1BENuinzdchPAYP/XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8CxNHCQIJBo1xc4AQ--.44755S3;
	Mon, 04 Aug 2025 10:53:04 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJAxvsGMIJBoiuo0AA--.22459S3;
	Mon, 04 Aug 2025 10:53:02 +0800 (CST)
Subject: Re: [PATCH v3] LoongArch: Implement physical address with ELF program
 header
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
 Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250723080640.442339-1-maobibo@loongson.cn>
 <00651F3A-6649-4C69-B365-352C8D323902@flygoat.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <bc680815-b67b-638f-a920-03a0ac65540d@loongson.cn>
Date: Mon, 4 Aug 2025 10:51:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <00651F3A-6649-4C69-B365-352C8D323902@flygoat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxvsGMIJBoiuo0AA--.22459S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Ar18ZFyxCr17uF18Ar1UJwc_yoW7Kryrpr
	Wqya18CF4rGr1rZwnIqFn09FyUtrnak3Wjgr45Ja48AF1agr1DKw47Gr1DGF90vw4kZr4I
	vFykJ3y2v3Z3KagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jepB-UUUUU=



On 2025/8/1 下午4:57, Jiaxun Yang wrote:
> 
> 
>> 2025年7月23日 16:06，Bibo Mao <maobibo@loongson.cn> 写道：
>>
>> With structure elf64_phdr, field p_paddr is physical address of the
>> segment. And it is convenient for qemu to calculate the physical
>> address when directly boot ELF kernel image.
>>
>> Otherwise QEMU needs convert virtual address p_vaddr into physical
>> address, the conversion logic assumes that DMW method is used where
>> 48 bit physical address is supported. However with direct MMU mapping
>> method with start address from 0xFFFF800000000000, only 47 bit physical
>> address is supported. QEMU cannot assume the kernel behavior at kernel
>> loading stage.
>>
>> Here add physical address indication in ELF program header, it is
>> convenient to get physical kernel loading address.
> 
> Hi Bibo,
> 
> Thanks for your patch. Unfortunately it breaks PMON’s DWARF debugging
> Feature, causing exception on list symbols.
> 
> I’ll try to investigate.
Hi Jiaxun.

Thanks for reporting it. Could you describe the problem with more 
detailed information? such as which command of PMON etc.

Regards
Bibo Mao
> 
> Thanks
> Jiaxun
> 
> 
> 
>>
>> Here is output with command readelf -l vmlinux with patch:
>> Elf file type is EXEC (Executable file)
>> Entry point 0x90000000015f5000
>> There are 2 program headers, starting at offset 64
>> Program Headers:
>>    Type           Offset             VirtAddr           PhysAddr
>>                   FileSiz            MemSiz              Flags  Align
>>    LOAD           0x0000000000010000 0x9000000000200000 0x0000000000200000
>>                   0x000000000293b000 0x0000000002a79b98  RWE    0x10000
>>
>> And output with command readelf -l vmlinux without the patch:
>> Elf file type is EXEC (Executable file)
>> Entry point 0x90000000015f5000
>> There are 2 program headers, starting at offset 64
>> Program Headers:
>>    Type           Offset             VirtAddr           PhysAddr
>>                   FileSiz            MemSiz              Flags  Align
>>    LOAD           0x0000000000010000 0x9000000000200000 0x9000000000200000
>>                   0x000000000293b000 0x0000000002a79b98  RWE    0x10000
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>> v2 ... v3:
>> 1. Fix compile issue where macro PHYS_OFFSET is not defined with assemble
>>     code.
>> v1 ... v2:
>> 1. Set LOAD_OFFSET with PAGE_OFFSET rather than CACHE_BASE, since it
>>     is generic with PAGE_OFFSET.
>> 2. Add AT information with missing edata_padding section.
>> ---
>> arch/loongarch/include/asm/addrspace.h |  2 +-
>> arch/loongarch/kernel/vmlinux.lds.S    | 36 +++++++++++++++++---------
>> 2 files changed, 25 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/loongarch/include/asm/addrspace.h b/arch/loongarch/include/asm/addrspace.h
>> index e739dbc6329d..18f6c2b469bb 100644
>> --- a/arch/loongarch/include/asm/addrspace.h
>> +++ b/arch/loongarch/include/asm/addrspace.h
>> @@ -18,10 +18,10 @@
>> /*
>> * This gives the physical RAM offset.
>> */
>> -#ifndef __ASSEMBLER__
>> #ifndef PHYS_OFFSET
>> #define PHYS_OFFSET	_UL(0)
>> #endif
>> +#ifndef __ASSEMBLER__
>> extern unsigned long vm_map_base;
>> #endif /* __ASSEMBLER__ */
>>
>> diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
>> index 08ea921cdec1..8ce6b0d948f4 100644
>> --- a/arch/loongarch/kernel/vmlinux.lds.S
>> +++ b/arch/loongarch/kernel/vmlinux.lds.S
>> @@ -3,10 +3,12 @@
>> #include <asm/asm-offsets.h>
>> #include <asm/thread_info.h>
>> #include <asm/orc_lookup.h>
>> +#include <asm/addrspace.h>
>>
>> #define PAGE_SIZE _PAGE_SIZE
>> #define RO_EXCEPTION_TABLE_ALIGN	4
>> #define PHYSADDR_MASK			0xffffffffffff /* 48-bit */
>> +#define LOAD_OFFSET			PAGE_OFFSET
>>
>> /*
>> * Put .bss..swapper_pg_dir as the first thing in .bss. This will
>> @@ -42,7 +44,7 @@ SECTIONS
>>
>> 	. = ALIGN(PECOFF_SEGMENT_ALIGN);
>> 	_stext = .;
>> -	.text : {
>> +	.text : AT(ADDR(.text) - LOAD_OFFSET) {
>> 		TEXT_TEXT
>> 		SCHED_TEXT
>> 		LOCK_TEXT
>> @@ -60,7 +62,7 @@ SECTIONS
>> 	__inittext_begin = .;
>>
>> 	INIT_TEXT_SECTION(PAGE_SIZE)
>> -	.exit.text : {
>> +	.exit.text : AT(ADDR(.exit.text) - LOAD_OFFSET) {
>> 		EXIT_TEXT
>> 	}
>>
>> @@ -82,7 +84,7 @@ SECTIONS
>> 	}
>>
>> 	INIT_DATA_SECTION(16)
>> -	.exit.data : {
>> +	.exit.data : AT(ADDR(.exit.data) - LOAD_OFFSET) {
>> 		EXIT_DATA
>> 	}
>>
>> @@ -90,7 +92,7 @@ SECTIONS
>> 	PERCPU_SECTION(1 << CONFIG_L1_CACHE_SHIFT)
>> #endif
>>
>> -	.init.bss : {
>> +	.init.bss : AT(ADDR(.init.bss) - LOAD_OFFSET) {
>> 		*(.init.bss)
>> 	}
>> 	. = ALIGN(PECOFF_SEGMENT_ALIGN);
>> @@ -101,27 +103,34 @@ SECTIONS
>> 	_sdata = .;
>> 	RO_DATA(4096)
>>
>> -	.got : ALIGN(16) { *(.got) }
>> -	.plt : ALIGN(16) { *(.plt) }
>> -	.got.plt : ALIGN(16) { *(.got.plt) }
>> +	. =  ALIGN(16);
>> +	.got : AT(ADDR(.got) - LOAD_OFFSET) { *(.got) }
>> +	. =  ALIGN(16);
>> +	.plt : AT(ADDR(.plt) - LOAD_OFFSET) { *(.plt) }
>> +	. =  ALIGN(16);
>> +	.got.plt : AT(ADDR(.got.plt) - LOAD_OFFSET) { *(.got.plt) }
>>
>> 	RW_DATA(1 << CONFIG_L1_CACHE_SHIFT, PAGE_SIZE, THREAD_SIZE)
>>
>> -	.rela.dyn : ALIGN(8) {
>> +	. = ALIGN(8);
>> +	.rela.dyn : AT(ADDR(.rela.dyn) - LOAD_OFFSET) {
>> 		__rela_dyn_begin = .;
>> 		 *(.rela.dyn) *(.rela*)
>> 		__rela_dyn_end = .;
>> 	}
>>
>> #ifdef CONFIG_RELR
>> -	.relr.dyn : ALIGN(8) {
>> +	. = ALIGN(8);
>> +	.relr.dyn : AT(ADDR(.relr.dyn) - LOAD_OFFSET) {
>> 		__relr_dyn_begin = .;
>> 		 *(.relr.dyn)
>> 		__relr_dyn_end = .;
>> 	}
>> #endif
>>
>> -	.data.rel : { *(.data.rel*) }
>> +	.data.rel : AT(ADDR(.data.rel) - LOAD_OFFSET) {
>> +		*(.data.rel*)
>> +	}
>>
>> #ifdef CONFIG_RELOCATABLE
>> 	. = ALIGN(8);
>> @@ -134,10 +143,13 @@ SECTIONS
>>
>> 	ORC_UNWIND_TABLE
>>
>> -	.sdata : {
>> +	.sdata : AT(ADDR(.sdata) - LOAD_OFFSET) {
>> 		*(.sdata)
>> 	}
>> -	.edata_padding : { BYTE(0); . = ALIGN(PECOFF_FILE_ALIGN); }
>> +	.edata_padding : AT(ADDR(.edata_padding) - LOAD_OFFSET) {
>> +		BYTE(0);
>> +		. = ALIGN(PECOFF_FILE_ALIGN);
>> +	}
>> 	_edata =  .;
>>
>> 	BSS_SECTION(0, SZ_64K, 8)
>>
>> base-commit: 89be9a83ccf1f88522317ce02f854f30d6115c41
>> -- 
>> 2.39.3
>>
>>


