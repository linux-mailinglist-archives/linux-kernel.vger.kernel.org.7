Return-Path: <linux-kernel+bounces-786620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B2CB35F26
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBDB01BA1D81
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F4B2475CE;
	Tue, 26 Aug 2025 12:33:28 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC67137932
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 12:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756211607; cv=none; b=cTcylJcWokl/yncMyyu2u0bWTcGW4ML+xMOr5BPOhU+yhgi/nQdzzsZ2eGeZVJ6gASb2UnWeRrItP/b5yMRJsGdFxi7ISQzTZJTUF03Jn+u9so7P957ruhTXQbj/cx9+MLjCfqlA2Uxy3g13+9BbpGb8st59d8mUpfwkFIuaYUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756211607; c=relaxed/simple;
	bh=OvUphhKlruNLmE/+Atv0pgtEDg79X0l18KbHUjKmaEY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=m/9inh9FXLRh3amw0Ds1M0sL7ZrI4r2UuFBTDQH6yVU075OmzaCdhMGdoeJ2wdoBH/LMFhXyQKFObPHoPTlYT7x79VqUAViGk7uytQcFR02KYZaM8mO3HmVMQQ2Fw14BgiNTi49IDdC4T9o4JWn0BhDKH8vPpoeVhTpyOIW5wd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxbNKRqa1o91wDAA--.6474S3;
	Tue, 26 Aug 2025 20:33:21 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxTMGQqa1oDwFqAA--.13153S3;
	Tue, 26 Aug 2025 20:33:20 +0800 (CST)
Subject: Re: [RFC PATCH 1/2] objtool/LoongArch: Fix fall through warning about
 efi_boot_kernel()
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Nathan Chancellor
 <nathan@kernel.org>, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250826064631.9617-1-yangtiezhu@loongson.cn>
 <20250826064631.9617-2-yangtiezhu@loongson.cn>
 <CAAhV-H5wW_04NHQ7z+SCPb6-T5Hc__n+x=ykg-u9vn4b4GXuww@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <487a8149-6cbe-46a7-6771-66aef0045f07@loongson.cn>
Date: Tue, 26 Aug 2025 20:33:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5wW_04NHQ7z+SCPb6-T5Hc__n+x=ykg-u9vn4b4GXuww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxTMGQqa1oDwFqAA--.13153S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tw45CF4xurWUKFWxKr1Dtwc_yoW8WF17p3
	W5KFW0krWkZr4Utas7A3ya9FyYqa95K342ga48JryrAanrZan8trs8A3yUKFyvqr109a4S
	yayfK3sIkayqywcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
	I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j22NtUUUUU=

On 2025/8/26 下午4:32, Huacai Chen wrote:
> On Tue, Aug 26, 2025 at 2:46 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> When compiling with LLVM and CONFIG_LTO_CLANG is set, there exists
>> the following objtool warning:
>>
>>    vmlinux.o: warning: objtool: __efistub_efi_boot_kernel()
>>    falls through to next function __efistub_exit_boot_func()

...

>> -typedef void __noreturn (*kernel_entry_t)(bool efi, unsigned long cmdline,
>> +typedef void (*kernel_entry_t)(bool efi, unsigned long cmdline,
>>                                            unsigned long systab);
>  From my point of view this is incorrect, this function is indeed a
> noreturn function, and this modification makes LoongArch different to
> other architectures.
> 
> Maybe it is better to let objtool ignore the whole
> drivers/firmware/efi/libstub directory. Because efistub is discarded
> at runtime so it is useless for stack unwinder.

I tested the following change but there is no effect, the objtool
warning still exists, this is because OBJECT_FILES_NON_STANDARD
does not work for link time validation of vmlinux.o according to
tools/objtool/Documentation/objtool.txt.

diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index 8efbcf699e4f..f1fff48eea76 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -10,6 +10,8 @@
  #
  KASAN_SANITIZE_runtime-wrappers.o      := n

+OBJECT_FILES_NON_STANDARD              := y
+
  obj-$(CONFIG_ACPI_BGRT)                += efi-bgrt.o
  obj-$(CONFIG_EFI)                      += efi.o vars.o reboot.o 
memattr.o tpm.o
  obj-$(CONFIG_EFI)                      += memmap.o

Thanks,
Tiezhu


