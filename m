Return-Path: <linux-kernel+bounces-807131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F58B4A076
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A61D4E0AA4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4383F9FB;
	Tue,  9 Sep 2025 04:00:02 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9324F264636
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 03:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757390401; cv=none; b=MuY0/18oRLJESZ7ggt+Sqy+FBTKRjJYqfcSMKZWLaLA0NJWCBYxx1RlYsd3R6fI9ElG1gFJ0rq9L9LzMzj81OzxNIOInVj7ASTwh7YKLU5aSoC9I+fS7bYpz55f3K4Rm9juXzqFZEGoiKhsbfco5KHaLuQ65necPoiCNSapiG5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757390401; c=relaxed/simple;
	bh=OE18OxMrs1NopGdlKsIqB/3zyZA0Oh1NV6NM0txIROY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PaPnZuDVDKoVckBId1W1nu01Avua2qz233eBbNlNV29Svuf5ny0zbCma2+grPa1C7cF9PffmFIoeHRbHEg3BLa3kjDmhi18jk+Zio5YuMuGClaMSIstbB2UtorOF7Vx6WkuhALBRmS7gQVPn3zj5krBUN0Z0a9Z8su/02awoHGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cxf9Mzpr9oSDYIAA--.17198S3;
	Tue, 09 Sep 2025 11:59:47 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAxT+Ywpr9oez2JAA--.41171S3;
	Tue, 09 Sep 2025 11:59:45 +0800 (CST)
Subject: Re: [PATCH v1 2/3] objtool/LoongArch: Fix unreachable instruction
 warnings about EFISTUB
To: Josh Poimboeuf <jpoimboe@kernel.org>, Huacai Chen <chenhuacai@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250901081904.GB4067720@noisy.programming.kicks-ass.net>
 <82c913b9-4403-cde9-0542-5bd6e04415f5@loongson.cn>
 <wt4qpgi5isj5m6wq33pomvm6borvafuzktekc7lgtoitscar5q@brixzj3lccbw>
 <ccbb40c1-5f2d-77e9-e8d2-52f2fdbad645@loongson.cn>
 <CAAhV-H5qhKepa-8sz3_AC=_RCChbVeEmnHKESMqpiJ0phMORbg@mail.gmail.com>
 <52056c29-4f21-83c9-db1f-ebd1875a3675@loongson.cn>
 <CAAhV-H47VKERJCKRi7uAS7OmCWaE4yxZ07Hwz_si2DMVRDrsag@mail.gmail.com>
 <ybv2ndrzbqztkctzwhfphpdqrqbxlougs75glm22rcuzdmnrfp@lqwcms3j2d55>
 <4thrzifl6ntk7kdf65egt4srzkbrxqoqf7yzmasblwvaq3qwmt@vigfgpbxzjkq>
 <CAAhV-H53DkR6oK1chXQtoczqxYBCU-FMKrD99bjEvfXapND1Vw@mail.gmail.com>
 <itoqfhz4pxaf7aclzajkxcdsxe5akxhgahzj4dp24leh7w334k@epnvcxdga75p>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <49ceb19c-6107-d026-3ae6-ae897d1fcae4@loongson.cn>
Date: Tue, 9 Sep 2025 11:59:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <itoqfhz4pxaf7aclzajkxcdsxe5akxhgahzj4dp24leh7w334k@epnvcxdga75p>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxT+Ywpr9oez2JAA--.41171S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWw4ktr48AFykXr13AF47trc_yoWrKr4rpF
	ZFkF9Fyr4DGry8Xr97tw4j9r1aq3yDWF42qa4UWa40kFyqqr1Iqwn7Zr4UCF9xWw4kAFW0
	qF17JrWavFyjy3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
	I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8m9aDUUUUU==

On 2025/9/6 上午12:04, Josh Poimboeuf wrote:
> On Fri, Sep 05, 2025 at 12:36:16PM +0800, Huacai Chen wrote:
>> Hi, Josh,
>>
>> On Fri, Sep 5, 2025 at 5:46 AM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>>>
>>> On Thu, Sep 04, 2025 at 10:39:30AM -0700, Josh Poimboeuf wrote:
>>>> On Thu, Sep 04, 2025 at 11:59:30AM +0800, Huacai Chen wrote:
>>>>> This is from RISC-V code.
>>>>>
>>>>> __HEAD
>>>>> SYM_CODE_START(_start)
>>>>>          /*
>>>>>           * Image header expected by Linux boot-loaders. The image header data
>>>>>           * structure is described in asm/image.h.
>>>>>           * Do not modify it without modifying the structure and all bootloaders
>>>>>           * that expects this header format!!
>>>>>           */
>>>>> #ifdef CONFIG_EFI
>>>>>          /*
>>>>>           * This instruction decodes to "MZ" ASCII required by UEFI.
>>>>>           */
>>>>>          c.li s4,-13
>>>>>          j _start_kernel
>>>>> #else
>>>>>          /* jump to start kernel */
>>>>>          j _start_kernel
>>>>>          /* reserved */
>>>>>          .word 0
>>>>> #endif
>>>>>
>>>>> The HEAD section has instructions, if you change it into a data
>>>>> section then it loses the "x" attribute.
>>>
>>> Actually, the "x" attribute isn't needed for vmlinux.  The vmlinux
>>> linker script places it in the text region regardless.
>>>
>>> Moving the data to a data section should be really simple, something
>>> like the below.
>>>
>>> And yes, even the above RISC-V code can be in a data section.  Those
>>> instructions are part of the 'struct riscv_image_header' data structure.
>> This may work but also look strange (code in data section), it is more
>> like a "workaround". :)
> 
> The "strange" part of the code is the intermixing of code and data.  If
> they can't be separated, then they are part of a data structure and
> belong in a data section.

I tried the following minimal changes, put the image header into
the section .head.data, do not link efistub lib.a into vmlinux.o,
just link efistub lib.a into vmlinux, no other changes, they have
same effect with patch #1 and #2, what do you think?

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

diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index e3865e92a917..c42500d9fad8 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -17,7 +17,7 @@

  #include "efi-header.S"

-       __HEAD
+       __HEADDATA

  _head:
         .word   IMAGE_DOS_SIGNATURE     /* "MZ", MS-DOS header */
diff --git a/arch/loongarch/kernel/vmlinux.lds.S 
b/arch/loongarch/kernel/vmlinux.lds.S
index 08ea921cdec1..fc35ef349aba 100644
--- a/arch/loongarch/kernel/vmlinux.lds.S
+++ b/arch/loongarch/kernel/vmlinux.lds.S
@@ -38,6 +38,7 @@ SECTIONS
         . = VMLINUX_LOAD_ADDRESS;

         _text = .;
+       HEAD_DATA_SECTION
         HEAD_TEXT_SECTION

         . = ALIGN(PECOFF_SEGMENT_ALIGN);
diff --git a/include/asm-generic/vmlinux.lds.h 
b/include/asm-generic/vmlinux.lds.h
index ae2d2359b79e..0f95fb1649f3 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -645,6 +645,14 @@ defined(CONFIG_AUTOFDO_CLANG) || 
defined(CONFIG_PROPELLER_CLANG)
                 *(.static_call.text)                                    \
                 __static_call_text_end = .;

+/* Section used for early init (in .S files) */
+#define HEAD_DATA  KEEP(*(.head.data))
+
+#define HEAD_DATA_SECTION                                              \
+       .head.data : AT(ADDR(.head.data) - LOAD_OFFSET) {               \
+               HEAD_DATA                                               \
+       }
+
  /* Section used for early init (in .S files) */
  #define HEAD_TEXT  KEEP(*(.head.text))

diff --git a/include/linux/init.h b/include/linux/init.h
index a60d32d227ee..4e5be09c42cd 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -98,6 +98,7 @@

  /* For assembly routines */
  #define __HEAD         .section        ".head.text","ax"
+#define __HEADDATA     .section        ".head.data","aw"
  #define __INIT         .section        ".init.text","ax"
  #define __FINIT                .previous

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

Thanks,
Tiezhu


