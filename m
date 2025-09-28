Return-Path: <linux-kernel+bounces-835321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD331BA6B88
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 10:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92D5E16A353
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 08:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4232BE7D2;
	Sun, 28 Sep 2025 08:39:26 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C491A9FB6
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 08:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759048766; cv=none; b=OZTRvxMcwGGwon7XTqTSBAdrLNA50dFodmjmJJL6qXvBIyLAy7+1fboqJ08QNcFvUg2baR/7VHy/lAhbDcqLncnLQBX7FRqPtt6NEpWF7WRbfr8MA2E2bVmSF9njHQdA7m5yXF8cix2yM8jolV6ML9vJBVb/ugrFIK9N5jfEp2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759048766; c=relaxed/simple;
	bh=EiVpTxxt/XlNmJqKGTiXNq/ExTvkP3RexGCWhQSsol0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=REnnAPruSSBqtRw2QzoWLkHkzCVW9KqwgSkxNPyui8xcWTEtG7zerVULA065tezCFoWjQZXbIqm46A3Da9Fnh18DMwKv9aoMeLuECmRL1f9eUdMo7vnMhO+tt7R/7mMrJK+NkwhnRScrrJgnKurYpUZ/dLbheNCgiWZXn4h2s6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxT_Ax9Nhof8oPAA--.33115S3;
	Sun, 28 Sep 2025 16:39:14 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDx_8Mw9NhofGe5AA--.63170S3;
	Sun, 28 Sep 2025 16:39:12 +0800 (CST)
Subject: Re: [PATCH v1] LoongArch: Add
 -fno-isolate-erroneous-paths-dereference in Makefile
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Rui <wangrui@loongson.cn>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250923061722.24457-1-yangtiezhu@loongson.cn>
 <CAAhV-H4e0xeHoEJ4Vzs8pQT+sbjaAL8N=Vc=TrU8fd3iU=97nQ@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <33c3dbaa-05e5-cb75-dd35-d05bf02fea2e@loongson.cn>
Date: Sun, 28 Sep 2025 16:39:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4e0xeHoEJ4Vzs8pQT+sbjaAL8N=Vc=TrU8fd3iU=97nQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDx_8Mw9NhofGe5AA--.63170S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZw4UZw18Wr1UWrykWw4rZwc_yoWrtw1xpF
	W5tr4UCa95Xr18Zas7Grs5XrW3A3y3AF4jgFZ8KF1fA3yFqryUtw1Sgry3GF4kGF4kuryj
	vw12g342vF1IyabCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_Ma
	UUUUU

On 2025/9/23 下午10:32, Huacai Chen wrote:
> Hi, Tiezhu,
> 
> On Tue, Sep 23, 2025 at 2:17 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> Currently, when compiling with GCC, there is no "break 0x7" instruction
>> for zero division due to using the option -mno-check-zero-division, but
>> the compiler still generates "break 0x0" instruction for zero division.
>>
>> Here is a simple example:
>>
>>    $ cat test.c
>>    int div(int a)
>>    {
>>            return a / 0;
>>    }
>>    $ gcc -O2 -S test.c -o test.s
>>
>> GCC generates "break 0" On LoongArch and "ud2" on x86, objtool decodes
>> "ud2" as INSN_BUG for x86, so decode "break 0" as INSN_BUG can fix the
>> objtool warnings for LoongArch, but this is not the intention.
>>
>> When decoding "break 0" as INSN_TRAP in the previous commit, the aim is
>> to handle "break 0" as a trap. The generated "break 0" for zero division
>> by GCC is not proper, it should generate a break instruction with proper
>> bug type, so add the GCC option -fno-isolate-erroneous-paths-dereference
>> to avoid generating the unexpected "break 0" instruction for now.
> You said that this patch make performance increase a little. But this
> is strange, because -isolate-erroneous-paths-dereference rather than
> -no-isolate-erroneous-paths-dereference is considered as an
> optimization.

I tested linux 6.17-rc7 with loongson3_defconfig, only a
little improvement (about 0.3%) with "./Run -c 1".

Here are the test steps, anyone who is interested can test
again to get the actual results on the specified environment:

   git clone https://github.com/kdlucas/byte-unixbench.git
   cd byte-unixbench/UnixBench/
   make
   ./Run -c 1
   ./Run -c 8

Here are the objdump info for sched_update_scaling() in
kernel/sched/fair.o:

Before:

000000000000bbc8 <sched_update_scaling>:
     bbc8:       1a00000c        pcalau12i       $t0, 0
     bbcc:       1a00000d        pcalau12i       $t1, 0
     bbd0:       02c0018c        addi.d          $t0, $t0, 0
     bbd4:       288001ae        ld.w            $t2, $t1, 0
     bbd8:       24000190        ldptr.w         $t4, $t0, 0
     bbdc:       004081ce        slli.w          $t2, $t2, 0x0
     bbe0:       40006200        beqz            $t4, 96 # bc40 
<sched_update_scaling+0x78>
     bbe4:       0280200d        addi.w          $t1, $zero, 8
     bbe8:       0012b9ad        sltu            $t1, $t1, $t2
     bbec:       02802012        addi.w          $t6, $zero, 8
     bbf0:       0013b5cf        masknez         $t3, $t2, $t1
     bbf4:       0013364d        maskeqz         $t1, $t6, $t1
     bbf8:       001535ed        or              $t1, $t3, $t1
     bbfc:       02800811        addi.w          $t5, $zero, 2
     bc00:       004081af        slli.w          $t3, $t1, 0x0
     bc04:       58001611        beq             $t4, $t5, 20    # bc18 
<sched_update_scaling+0x50>
     bc08:       400051c0        beqz            $t2, 80 # bc58 
<sched_update_scaling+0x90>
     bc0c:       000015ad        clz.w           $t1, $t1
     bc10:       0280800f        addi.w          $t3, $zero, 32
     bc14:       001135ef        sub.w           $t3, $t3, $t1
     bc18:       24000d8d        ldptr.w         $t1, $t0, 12
     bc1c:       00150004        or              $a0, $zero, $zero
     bc20:       00213dad        div.wu          $t1, $t1, $t3
     bc24:       2980418d        st.w            $t1, $t0, 16
     bc28:       4c000020        jirl            $zero, $ra, 0
     bc2c:       03400000        andi            $zero, $zero, 0x0
     bc30:       03400000        andi            $zero, $zero, 0x0
     bc34:       03400000        andi            $zero, $zero, 0x0
     bc38:       03400000        andi            $zero, $zero, 0x0
     bc3c:       03400000        andi            $zero, $zero, 0x0
     bc40:       24000d8d        ldptr.w         $t1, $t0, 12
     bc44:       0280040f        addi.w          $t3, $zero, 1
     bc48:       00150004        or              $a0, $zero, $zero
     bc4c:       00213dad        div.wu          $t1, $t1, $t3
     bc50:       2980418d        st.w            $t1, $t0, 16
     bc54:       4c000020        jirl            $zero, $ra, 0
     bc58:       002a0000        break           0x0
     bc5c:       03400000        andi            $zero, $zero, 0x0

After:

000000000000bbc8 <sched_update_scaling>:
     bbc8:       1a00000c        pcalau12i       $t0, 0
     bbcc:       1a00000d        pcalau12i       $t1, 0
     bbd0:       02c0018c        addi.d          $t0, $t0, 0
     bbd4:       288001ae        ld.w            $t2, $t1, 0
     bbd8:       24000190        ldptr.w         $t4, $t0, 0
     bbdc:       0280040f        addi.w          $t3, $zero, 1
     bbe0:       004081ce        slli.w          $t2, $t2, 0x0
     bbe4:       40003a00        beqz            $t4, 56 # bc1c 
<sched_update_scaling+0x54>
     bbe8:       0280200d        addi.w          $t1, $zero, 8
     bbec:       0012b9ad        sltu            $t1, $t1, $t2
     bbf0:       02802012        addi.w          $t6, $zero, 8
     bbf4:       0013b5cf        masknez         $t3, $t2, $t1
     bbf8:       0013364d        maskeqz         $t1, $t6, $t1
     bbfc:       001535ed        or              $t1, $t3, $t1
     bc00:       02800811        addi.w          $t5, $zero, 2
     bc04:       004081af        slli.w          $t3, $t1, 0x0
     bc08:       58001611        beq             $t4, $t5, 20    # bc1c 
<sched_update_scaling+0x54>
     bc0c:       000015ad        clz.w           $t1, $t1
     bc10:       0280800f        addi.w          $t3, $zero, 32
     bc14:       001135ef        sub.w           $t3, $t3, $t1
     bc18:       001339ef        maskeqz         $t3, $t3, $t2
     bc1c:       24000d8d        ldptr.w         $t1, $t0, 12
     bc20:       00150004        or              $a0, $zero, $zero
     bc24:       00213dad        div.wu          $t1, $t1, $t3
     bc28:       2980418d        st.w            $t1, $t0, 16
     bc2c:       4c000020        jirl            $zero, $ra, 0

There is no beqz instruction for zero division with this patch,
I guess it will affect the performance to some extent. IMO, the
isolate-erroneous-paths-dereference optimization is for error
code path, not for performance.

Anyway, my initial aim is to check whether exist performance
regression, from the point of view of the test results, there
is no obvious differences with this patch.

Thanks,
Tiezhu


