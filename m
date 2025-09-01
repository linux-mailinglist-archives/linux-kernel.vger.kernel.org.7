Return-Path: <linux-kernel+bounces-794092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C20D9B3DCC1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E044E3BA887
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62B92FC000;
	Mon,  1 Sep 2025 08:39:36 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E082FB992
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715976; cv=none; b=CiIykCCx/embVSVFLyWBEVbkrI1U1pgZqUIii/upKfKYOqRxGIq5JGqYk2fgtn7PFwbK0LDZ3G62W6hquR2QeJOHWXuo6KkFjNk4fW70YBtd3TwbhaweIhWFtUdzimia90GlQCVi+8QiekVytNHowD5M88jlhA1UpGYLdNWBwOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715976; c=relaxed/simple;
	bh=GIftNVJjFgHrRrN7LUcZ2GN5PRbGvAM7Rm+3Sj9T2vI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TF8Sln92LTB44kWUTLQhFyo+zPS2VxmEMyc/KTRFloJLQI1hrLvy+Iji1+BW5yf3x7Zek1EaV/s1QcJQ3Sa0o4FK8YvmkGQwrMFn5lvAZ4FHKV+zwmnSgy2om5UZxmibNooTliNDPkCYg7pweHYeYePEbR0YBluo/dwnP9dyO0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxG9LEW7VoWUwFAA--.10587S3;
	Mon, 01 Sep 2025 16:39:32 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxjcHCW7VotI52AA--.55959S3;
	Mon, 01 Sep 2025 16:39:31 +0800 (CST)
Subject: Re: [PATCH v1 2/3] objtool/LoongArch: Fix unreachable instruction
 warnings about EFISTUB
To: Peter Zijlstra <peterz@infradead.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250901072156.31361-1-yangtiezhu@loongson.cn>
 <20250901072156.31361-3-yangtiezhu@loongson.cn>
 <20250901081904.GB4067720@noisy.programming.kicks-ass.net>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <82c913b9-4403-cde9-0542-5bd6e04415f5@loongson.cn>
Date: Mon, 1 Sep 2025 16:39:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250901081904.GB4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxjcHCW7VotI52AA--.55959S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF45KF4UWw4DKFy3AFyfZrc_yoW5ZFy7pF
	47Cryjva90qF1qqw4DGr4ag34ava15Xr4qqF1UJa45K3yjv3Z7tanYyr17CFyqgr4Y9FW3
	XayUt34DCFyjk3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
	Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48J
	MxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0b6pPUUUU
	U==

On 2025/9/1 下午4:19, Peter Zijlstra wrote:
> On Mon, Sep 01, 2025 at 03:21:55PM +0800, Tiezhu Yang wrote:
>> When compiling with LLVM and CONFIG_LTO_CLANG is set, there exist the
>> following objtool warnings:
>>
>>    vmlinux.o: warning: objtool: .head.text+0x0: unreachable instruction
>>    vmlinux.o: warning: objtool: .head.text+0x18: unreachable instruction
>>    vmlinux.o: warning: objtool: .head.text+0x38: unreachable instruction
>>    vmlinux.o: warning: objtool: .head.text+0x3c: unreachable instruction
>>    vmlinux.o: warning: objtool: .head.text+0x40: unreachable instruction
>>    vmlinux.o: warning: objtool: .head.text+0x44: unreachable instruction
>>    vmlinux.o: warning: objtool: .head.text+0x54: unreachable instruction
>>    vmlinux.o: warning: objtool: .head.text+0x58: unreachable instruction
>>    vmlinux.o: warning: objtool: .head.text+0x6c: unreachable instruction
>>    vmlinux.o: warning: objtool: .head.text+0x84: unreachable instruction
>>    vmlinux.o: warning: objtool: .head.text+0x94: unreachable instruction
>>    vmlinux.o: warning: objtool: .head.text+0x9c: unreachable instruction
>>    vmlinux.o: warning: objtool: .head.text+0xc4: unreachable instruction
>>    vmlinux.o: warning: objtool: .head.text+0xf8: unreachable instruction
>>    vmlinux.o: warning: objtool: .head.text+0xfc: unreachable instruction
>>    vmlinux.o: warning: objtool: .head.text+0x104: unreachable instruction
>>    vmlinux.o: warning: objtool: .head.text+0x10c: unreachable instruction
>>    vmlinux.o: warning: objtool: .head.text+0x11c: unreachable instruction
>>    vmlinux.o: warning: objtool: .head.text+0x120: unreachable instruction
>>    vmlinux.o: warning: objtool: .head.text+0x124: unreachable instruction
>>    vmlinux.o: warning: objtool: .head.text+0x144: unreachable instruction
>>
>> The instructions in the .head.text section are related with EFISTUB,
>> they are image header and can be ignored by objtool, so just check the
>> section name in ignore_unreachable_insn() to ignore it.
> 
> I am confused; why do the efi/libstub functions generate this error?
> 
> Is this zboot-header.S perhaps? Why can't we properly annotate that
> file?

This is arch/loongarch/kernel/head.S.

There is "OBJECT_FILES_NON_STANDARD_head.o := y" in Makefile
to skip objtool checking for head.o, but OBJECT_FILES_NON_STANDARD
does not work for link time validation of vmlinux.o.

At the beginning, give UNWIND_HINT_UNDEFINED for these instructions,
but there is an argument in the previous RFC [1]:

"The efi header is completely not code, the annotations are very strange."

Josh suggested to do something to put these instructions in the data
section, but as said in the previous reply, it needs to modify the link
process and seems too complicated and expensive for this warning to some
extent.

So I did this change for objtool.

[1] 
https://lore.kernel.org/loongarch/CAAhV-H7NNtH-oaqMsN5=2c+EdF0-dy5mxcsO=_KFGWqb-FZj_w@mail.gmail.com/
[2] 
https://lore.kernel.org/loongarch/l7l2ik5b2inhwbxmlae7ozrlxi7hbdjbrhjsrykjgotlhflah6@jebephhvtxki/

Thanks,
Tiezhu


