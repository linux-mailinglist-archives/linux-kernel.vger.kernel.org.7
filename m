Return-Path: <linux-kernel+bounces-829864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EC1B98152
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 04:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6171B1B2070A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 02:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A0C7A13A;
	Wed, 24 Sep 2025 02:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="Z0qbgezD"
Received: from va-2-40.ptr.blmpb.com (va-2-40.ptr.blmpb.com [209.127.231.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605562147F9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 02:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758681388; cv=none; b=jr60fw0Fc9FV4D2ca6S3MQV5MS/AadKsxcvHYR6sM/B5PHTn6w8+XBOlYDnpUcdDTSFokStiG7kqR92Z8a2sUP1Bm50HsYPEylDyiWY2uCADYTs52VJP3tfkok1hkfgbev+6YywLVxbjq8luZRCOpnKRSiC27rRYJsc6C/0fYBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758681388; c=relaxed/simple;
	bh=UVJsO0fm05URxouO+hmVLn4EhU490r3xcCT+QibkZwE=;
	h=From:Date:Message-Id:In-Reply-To:To:Subject:Mime-Version:Cc:
	 References:Content-Type; b=hEZLikZlShQBgPPPb6XqPtuQHDV3of78rMgvysdyl9k93sRndkyNn5jWQ06oVubuB5P/IWp46i1gYVDLtLCLgj+aqstOllhwLB0oAIB1RliGRzMxoLuYiv87XScpxV6TGM8/ShNjBD+HGAu/UnZrrON8t4gC72YG7wbwPJ7tTUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=Z0qbgezD; arc=none smtp.client-ip=209.127.231.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1758681331;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=eok84aP1Pvike2H3H6rF9a3VUr2fUupZ8SYJp6uSjEU=;
 b=Z0qbgezDvXZ4mBqAUkDqcWvJJozPa4c6/JwipC4VD+eD9k1g+//d0FCpktbMZjFgQcwCaG
 0j33v1jmgBIYf2waIspmlmMvGOWnEWIMw4RCU385rrVDCGAzkEc9UDaKP/m9auJll1+rmf
 D1YfSTT32a5yln3g7NrMXolnIPzOKq8rMuLUAF4tNFuBG+02zqVfybcOK4TnsbZObcAIgT
 4c3xGePHqZWuUZPuGLGnQnEUjKlHxDOlvD1nTQoIHGXYL2DunNHaC1wcT7XDHqHt426RqA
 geH/3PauGhsyAgh+LMG8LUpApWCdyRIba3Ij1RAR7tB1ptVVd2JvYwJqHc1RmA==
Received: from [127.0.0.1] ([222.128.9.250]) by smtp.feishu.cn with ESMTPS; Wed, 24 Sep 2025 10:35:28 +0800
From: "BillXiang" <xiangwencheng@lanxincomputing.com>
Date: Wed, 24 Sep 2025 10:35:25 +0800
Message-Id: <1be32bd0-a3d1-4fea-8f22-e050f664907b@lanxincomputing.com>
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+268d358f1+340975+vger.kernel.org+xiangwencheng@lanxincomputing.com>
In-Reply-To: <20250923-5498566fbd48a3dfd61ecd08@orel>
User-Agent: Mozilla Thunderbird
To: "Andrew Jones" <ajones@ventanamicro.com>
Subject: Re: [PATCH] riscv: Move user-visible sbi ext ids to uapi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Language: en-US
Cc: <anup@brainfault.org>, <kvm-riscv@lists.infradead.org>, 
	<linux-kernel@vger.kernel.org>, <paul.walmsley@sifive.com>, 
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>, 
	<atishp@rivosinc.com>
X-Original-From: BillXiang <xiangwencheng@lanxincomputing.com>
References: <20250917085246.1430354-1-xiangwencheng@lanxincomputing.com> <20250923-5498566fbd48a3dfd61ecd08@orel>
Content-Type: text/plain; charset=UTF-8

On 9/24/2025 4:14 AM, Andrew Jones wrote:
> On Wed, Sep 17, 2025 at 04:52:46PM +0800, BillXiang wrote:
>> Move those sbi ext ids to uapi because they will be forwarded
>> to user space by kvm.
> 
> We don't need to publish the IDs in UAPI since they are already known to
> userspace by reading the SBI spec. Indeed QEMU already defines all of
> these except for the experimental range.>
> What problem are you trying to solve?


I'm working on rust-vmm[1], which auto-generates the ID constants
from uapi/kvm.h via bindgen[2]. Any ID that isn't exported there is
invisible to us. I expect other VMMs besides QEMU will need these
numbers as well, so let's keep one canonical definition in the UAPI
headers for everyone to share.


[1] https://github.com/rust-vmm
[2] https://crates.io/crates/bindgen

> 
> Thanks,
> drew
> 
>>
>> Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
>> ---
>>   arch/riscv/include/asm/sbi.h      | 16 +-----------
>>   arch/riscv/include/uapi/asm/sbi.h | 43 +++++++++++++++++++++++++++++++
>>   2 files changed, 44 insertions(+), 15 deletions(-)
>>   create mode 100644 arch/riscv/include/uapi/asm/sbi.h
>>
>> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
>> index 341e74238aa0..e196feaabb2e 100644
>> --- a/arch/riscv/include/asm/sbi.h
>> +++ b/arch/riscv/include/asm/sbi.h
>> @@ -10,13 +10,12 @@
>>   #include <linux/types.h>
>>   #include <linux/cpumask.h>
>>   #include <linux/jump_label.h>
>> +#include <uapi/asm/sbi.h>
>>   
>>   #ifdef CONFIG_RISCV_SBI
>>   enum sbi_ext_id {
>>   #ifdef CONFIG_RISCV_SBI_V01
>>   	SBI_EXT_0_1_SET_TIMER = 0x0,
>> -	SBI_EXT_0_1_CONSOLE_PUTCHAR = 0x1,
>> -	SBI_EXT_0_1_CONSOLE_GETCHAR = 0x2,
>>   	SBI_EXT_0_1_CLEAR_IPI = 0x3,
>>   	SBI_EXT_0_1_SEND_IPI = 0x4,
>>   	SBI_EXT_0_1_REMOTE_FENCE_I = 0x5,
>> @@ -37,13 +36,6 @@ enum sbi_ext_id {
>>   	SBI_EXT_NACL = 0x4E41434C,
>>   	SBI_EXT_FWFT = 0x46574654,
>>   
>> -	/* Experimentals extensions must lie within this range */
>> -	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
>> -	SBI_EXT_EXPERIMENTAL_END = 0x08FFFFFF,
>> -
>> -	/* Vendor extensions must lie within this range */
>> -	SBI_EXT_VENDOR_START = 0x09000000,
>> -	SBI_EXT_VENDOR_END = 0x09FFFFFF,
>>   };
>>   
>>   enum sbi_ext_base_fid {
>> @@ -263,12 +255,6 @@ enum sbi_pmu_ctr_type {
>>   #define SBI_PMU_STOP_FLAG_RESET BIT(0)
>>   #define SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT BIT(1)
>>   
>> -enum sbi_ext_dbcn_fid {
>> -	SBI_EXT_DBCN_CONSOLE_WRITE = 0,
>> -	SBI_EXT_DBCN_CONSOLE_READ = 1,
>> -	SBI_EXT_DBCN_CONSOLE_WRITE_BYTE = 2,
>> -};
>> -
>>   /* SBI STA (steal-time accounting) extension */
>>   enum sbi_ext_sta_fid {
>>   	SBI_EXT_STA_STEAL_TIME_SET_SHMEM = 0,
>> diff --git a/arch/riscv/include/uapi/asm/sbi.h b/arch/riscv/include/uapi/asm/sbi.h
>> new file mode 100644
>> index 000000000000..d29ac0abeefe
>> --- /dev/null
>> +++ b/arch/riscv/include/uapi/asm/sbi.h
>> @@ -0,0 +1,43 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> +/*
>> + * Copyright (C) 2025 Lanxincomputing Corporation or its affiliates.
>> + *
>> + * Authors:
>> + *     BillXiang <xiangwencheng@lanxincomputing.com>
>> + */
>> +
>> +#ifndef _UAPI_ASM_RISCV_SBI_H
>> +#define _UAPI_ASM_RISCV_SBI_H
>> +
>> +
>> +enum SBI_EXT_ID {
>> +	/*
>> +	* The CONSOLE_GETCHAR/CONSOLE_PUTCHAR SBI calls cannot be
>> +	* handled in kernel so they will be forwarded to userspace by kvm.
>> +	*/
>> +	SBI_EXT_0_1_CONSOLE_PUTCHAR = 0x1,
>> +	SBI_EXT_0_1_CONSOLE_GETCHAR = 0x2,
>> +	/*
>> +	* Both SBI experimental and vendor extensions are
>> +	* unconditionally forwarded to userspace by kvm.
>> +	*/
>> +	/* Experimentals extensions must lie within this range */
>> +	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
>> +	SBI_EXT_EXPERIMENTAL_END = 0x08FFFFFF,
>> +
>> +	/* Vendor extensions must lie within this range */
>> +	SBI_EXT_VENDOR_START = 0x09000000,
>> +	SBI_EXT_VENDOR_END = 0x09FFFFFF,
>> +};
>> +
>> +/*
>> +* The SBI debug console functions are unconditionally
>> +* forwarded to the userspace by kvm.
>> +*/
>> +enum sbi_ext_dbcn_fid {
>> +	SBI_EXT_DBCN_CONSOLE_WRITE = 0,
>> +	SBI_EXT_DBCN_CONSOLE_READ = 1,
>> +	SBI_EXT_DBCN_CONSOLE_WRITE_BYTE = 2,
>> +};
>> +
>> +#endif /* _UAPI_ASM_RISCV_SBI_H */
>> \ No newline at end of file
>> -- 
>> 2.43.0

