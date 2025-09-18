Return-Path: <linux-kernel+bounces-821880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8344DB828A9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37E573281D2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6486D236437;
	Thu, 18 Sep 2025 01:44:34 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008FD10957
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758159874; cv=none; b=JoSIBuMkYyvoMJTthHwMNvf7k/s3PR82evjKE2FzxWFNdDJFvvSbpUjeYy8/WjUI16vCRXlWFetMMmL7gswRq1VUKf+Ed2GsnqOKBZ2N+veZpKqvuboE8g5g1Ba6L6HMB715u1fPfNxeojlVLtHVLzkeYHK6aw053R7bJUf5NhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758159874; c=relaxed/simple;
	bh=AxF4xKFZH0YTiOI8tfP7JO7jIoU68GO/jZFynjfk9Pc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=AbxUm6x/ulX1lOiZCOPQCn4Fg3xIb/nwsn4NUVmQ/0vXT01AytC2muxzLq7cnorHuSHqVsT5nW9Jd5lezSj9SKw5k7y99K+b8mx1ebFfJkbQqsQZ57/kt0wUmb8HXuU7ZsAK3B7oFff+AkD2If8em/xThuA3Q0N1RPU1LTotpKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Bx3tL7Y8toyp0LAA--.25153S3;
	Thu, 18 Sep 2025 09:44:27 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxjcH4Y8toEKacAA--.53165S3;
	Thu, 18 Sep 2025 09:44:25 +0800 (CST)
Subject: Re: [PATCH v3 1/3] objtool/LoongArch: Fix fall through warning about
 efistub
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Huacai Chen
 <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250917112716.24415-1-yangtiezhu@loongson.cn>
 <20250917112716.24415-2-yangtiezhu@loongson.cn>
 <ym3yf3rkxfq3sukfqbemmbpamjfsx4jjushqh3f54ah5ugamse@qqwabon64umq>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <64530e20-9bc7-0c0b-d6ea-a4c7df3e85d9@loongson.cn>
Date: Thu, 18 Sep 2025 09:44:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ym3yf3rkxfq3sukfqbemmbpamjfsx4jjushqh3f54ah5ugamse@qqwabon64umq>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxjcH4Y8toEKacAA--.53165S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF4rCrWxur4fWFy5WFy3Awc_yoWrGF4xpa
	yjyrW2vrs8JrWvq3s7J3yF9ryaqFsxtrZIga4DuryrA3W5Xr1IvrWIqr4DZFZrXw4vy3WI
	qryftrnFka4DA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
	vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUU
	U

On 2025/9/18 上午6:32, Josh Poimboeuf wrote:
> On Wed, Sep 17, 2025 at 07:27:14PM +0800, Tiezhu Yang wrote:
>> When compiling with LLVM and CONFIG_LTO_CLANG is set, there exists
>> the following objtool warning:
>>
>>    vmlinux.o: warning: objtool: __efistub_efi_boot_kernel()
>>    falls through to next function __efistub_exit_boot_func()
>>
>> This is because efi_boot_kernel() doesn't end with a return instruction
>> or an unconditional jump, then objtool has determined that the function
>> can fall through into the next function.
>>
>> At the beginning, try to do something to make efi_boot_kernel() ends with
>> an unconditional jump instruction, but this modification seems not proper
>> and makes LoongArch different to other architectures.
>>
>> Furthermore, it is not proper to link efistub separately for LoongArch,
>> ARM64 and RISC-V too due to there is technical reason why vmlinux.o needs
>> efistub linked in.
>>
>> For example, there are two ways of populating the core kernel's struct
>> screen_info via the stub, the latter is preferred because it makes the
>> EFIFB earlycon available very early, but it only works if the EFI stub
>> is part of the core kernel image itself. For more information, please
>> see the comments in drivers/firmware/efi/libstub/screen_info.c.
> 
> Hm?  Of course libstub needs to be linked into *vmlinux*.  But that
> doesn't mean it needs to be in vmlinux.o.
> 
> Why not build libstub.a separately, and then link it with vmlinux.o
> during the final vmlinux link, as x86 does?

If this change is not OK, what do you think of the following changes?
Which one do you prefer?

(1) libstub doesn't link to vmlinux.o, only link libstub with vmlinux.o
during the final vmlinux link.

----->8-----
diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index a3a9759414f4..919c1970ce14 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -164,7 +164,6 @@ CHECKFLAGS += $(shell $(CC) $(KBUILD_CPPFLAGS) 
$(KBUILD_CFLAGS) -dM -E -x c /dev
  endif

  libs-y += arch/loongarch/lib/
-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a

  drivers-y              += arch/loongarch/crypto/

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 51367c2bfc21..c664bfb9b15f 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -69,6 +69,12 @@ vmlinux_link()
                 libs="${KBUILD_VMLINUX_LIBS}"
         fi

+       if [ "${SRCARCH}" = "loongarch" ]; then
+               if is_enabled CONFIG_EFI_STUB; then
+                       libs="${libs} drivers/firmware/efi/libstub/lib.a"
+               fi
+       fi
+
         if is_enabled CONFIG_GENERIC_BUILTIN_DTB; then
                 objs="${objs} .builtin-dtbs.o"
         fi

https://lore.kernel.org/loongarch/49ceb19c-6107-d026-3ae6-ae897d1fcae4@loongson.cn/

(2) make efi_boot_kernel() ends with an unconditional jump instruction.

----->8-----
diff --git a/drivers/firmware/efi/libstub/loongarch.c 
b/drivers/firmware/efi/libstub/loongarch.c
index 3782d0a187d1..e309fd78fca7 100644
--- a/drivers/firmware/efi/libstub/loongarch.c
+++ b/drivers/firmware/efi/libstub/loongarch.c
@@ -10,7 +10,7 @@
  #include "efistub.h"
  #include "loongarch-stub.h"

-typedef void __noreturn (*kernel_entry_t)(bool efi, unsigned long cmdline,
+typedef void (*kernel_entry_t)(bool efi, unsigned long cmdline,
  					  unsigned long systab);

  efi_status_t check_platform_features(void)
@@ -81,4 +81,7 @@ efi_status_t efi_boot_kernel(void *handle, 
efi_loaded_image_t *image,

  	real_kernel_entry(true, (unsigned long)cmdline_ptr,
  			  (unsigned long)efi_system_table);
+
+	/* We should never get here */
+	while (1);
  }

https://lore.kernel.org/loongarch/20250826064631.9617-2-yangtiezhu@loongson.cn/

Thanks,
Tiezhu


