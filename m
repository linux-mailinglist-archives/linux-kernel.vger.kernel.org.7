Return-Path: <linux-kernel+bounces-794070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B309AB3DC64
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D27437A116D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7052F83D9;
	Mon,  1 Sep 2025 08:31:45 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187902F83D8
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715505; cv=none; b=uXemrDzyO852Iyq7LknwbrUK/q7AgKYG1ik63ABObhtDt0oHFgkJ6e2k3STd8GavdHAfny6NnDBD03FNyBFKa0ohUzkoMZ3hiBy18Jfyk05w9TUx13akIVBeZRbSsWuxCJBQ3IhJGmwncr4tYkP9XzE6fa9dJSMSjfyW9Lxu268=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715505; c=relaxed/simple;
	bh=VcHsK1OBhOnKkgN7PU7CkPFpJGZLnQT0rG1KgXhfG7Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RFKHSxWeVf2pqG/Vt4aZecsEAmV8UbUrMO77Eek0Q5wjwt/BVf7NpzGw76LXUdE53d4qlx/IkXAKCqcgGe566OBtOlRw0RbC3IZT5HX3664gvlEQBAJBpT37Ii4cg/8hHGc1D21TfDkyDw5xHLV8OgF+2ZY+oH3Fqv2yQkRdSLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Dxb_DrWbVoWksFAA--.11025S3;
	Mon, 01 Sep 2025 16:31:39 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxXMHpWbVoUYt2AA--.55997S3;
	Mon, 01 Sep 2025 16:31:37 +0800 (CST)
Subject: Re: [PATCH v1 1/3] objtool/LoongArch: Fix fall through warning about
 efi_boot_kernel()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250901072156.31361-1-yangtiezhu@loongson.cn>
 <20250901072156.31361-2-yangtiezhu@loongson.cn>
 <20250901081616.GA4067720@noisy.programming.kicks-ass.net>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <a59b3eaa-133d-88bf-f1f3-41328d023c4a@loongson.cn>
Date: Mon, 1 Sep 2025 16:31:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250901081616.GA4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxXMHpWbVoUYt2AA--.55997S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr4kJFWrGFWDAw48WFyfAFc_yoW8KFWxpa
	yUCFyUCFs8Jr4xta4kXw4F9Fy3XwsrtrWaga48J3s5Aw4DZFn2vF4Fgr1avF9rZr47Gw1a
	vF40qrnI9a4DAagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
	xVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07jYSoJUUUUU=

On 2025/9/1 下午4:16, Peter Zijlstra wrote:
> On Mon, Sep 01, 2025 at 03:21:54PM +0800, Tiezhu Yang wrote:
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
>> an unconditional jump instruction, but it is not a proper way.
>>
>> After more analysis, one simple way is to ignore these EFISTUB functions
>> in validate_branch() of objtool since they are useless for stack unwinder.
>>
> 
> This is drivers/firmware/efi/libstub/loongarch.c:efi_boot_kernel(),
> right?
> 
> Why not simply do something like:
> 
> diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmware/efi/libstub/loongarch.c
> index 3782d0a187d1..082611a5f1f0 100644
> --- a/drivers/firmware/efi/libstub/loongarch.c
> +++ b/drivers/firmware/efi/libstub/loongarch.c
> @@ -81,4 +81,5 @@ efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
>   
>   	real_kernel_entry(true, (unsigned long)cmdline_ptr,
>   			  (unsigned long)efi_system_table);
> +	BUG();
>   }

At the beginning, I did the above change, but no effect.

The first thing is to remove the attribute __noreturn for
real_kernel_entry(), otherwise the compiler can not generate
instructions after that.

But there is an argument in the previous RFC [1]:

"From my point of view this is incorrect, this function is indeed a
noreturn function, and this modification makes LoongArch different to
other architectures."

Josh suggested to do something so that the EFI stub code isn't linked 
into vmlinux.o [2], it needs to modify the link process and seems too
complicated and expensive for this warning to some extent.

So I did this change for objtool.

[1] 
https://lore.kernel.org/loongarch/CAAhV-H5wW_04NHQ7z+SCPb6-T5Hc__n+x=ykg-u9vn4b4GXuww@mail.gmail.com/
[2] 
https://lore.kernel.org/loongarch/xyrcgkl7ud5pgh4h5yjyejz646bc22fnnwxahaoafqvnqintf3@mdhtfaybai67/

Thanks,
Tiezhu


