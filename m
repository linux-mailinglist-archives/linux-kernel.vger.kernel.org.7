Return-Path: <linux-kernel+bounces-818737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C93AFB595E3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A40117A2D81
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325F82D8393;
	Tue, 16 Sep 2025 12:18:58 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130041C695;
	Tue, 16 Sep 2025 12:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758025137; cv=none; b=WExsE8lS9MZjuTXnGBK8DdtZb7GtUN78blBJP+urzTRD3+o8X7jQBh+e7a/gtWqzNfV+/+szRjGFH8H6SLqVGuV7FYHL02XT8QqnmktgWPphncURzq07OMctX9uTxudusRQ5M0tMfX60S0tULzlXhGcWWVK297VSX4lU99GrP7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758025137; c=relaxed/simple;
	bh=Qzyx6iaqieZHa1bD+k8VgtFucreEpdcW2COkAWhgJbU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pWzz9mgC3KWvctOt99OCwG8f2A5JYIDdbEWG/695R9B7DdsdL63cpMVlGoHgGsR2Pu83eAKsjmchs2F4X1sSyagNJdvLuicWRVnESuolzgYgaikVBjTi0ktUCx6XPISoyU4m8D5r/j0SluSZGSYc29a0txV9ixv0w8SpNrfamNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Bx3tKqVcloH_EKAA--.23580S3;
	Tue, 16 Sep 2025 20:18:50 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxrcGpVclouVKZAA--.6520S3;
	Tue, 16 Sep 2025 20:18:49 +0800 (CST)
Subject: Re: [PATCH v1] objtool/LoongArch: Mark special atomic instruction as
 INSN_BUG type
To: WANG Rui <wangrui@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 rust-for-linux@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250916061117.32315-1-yangtiezhu@loongson.cn>
 <CAHirt9jbY4yX84Kfzax71rCvPY--SQpDKrjqWsDCHMVnuUuD0g@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <b218d981-49a4-3ee3-6eb9-68953ec29b1e@loongson.cn>
Date: Tue, 16 Sep 2025 20:18:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHirt9jbY4yX84Kfzax71rCvPY--SQpDKrjqWsDCHMVnuUuD0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxrcGpVclouVKZAA--.6520S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kw4kWw1fWrWUGryDCFy8Zwc_yoW8Xw1rpF
	srZa4ftayDXFZFg3Z7tFZ2gayayrW3ArW7XF1rWr18t398tF13tFn0qrWUJFWrA3yY9ryj
	qF4qva48uFyY9FXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
	6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
	vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8vApUUU
	UUU==

On 2025/9/16 下午5:02, WANG Rui wrote:
> On Tue, Sep 16, 2025 at 2:11 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> When compiling with LLVM and CONFIG_RUST is set, there exists the
>> following objtool warning:
>>
>>    rust/compiler_builtins.o: warning: objtool: __rust__unordsf2(): unexpected end of section .text.unlikely.
>>
>> objdump shows that the end of section .text.unlikely is a atomic
>> instruction:
>>
>>    amswap.w        $zero, $ra, $zero
>>
>> According to the LoongArch Reference Manual, if the amswap.w atomic
>> memory access instruction has the same register number as rd and rj,
>> the execution will trigger an Instruction Non-defined Exception, so
>> mark the above instruction as INSN_BUG type to fix the warning.
> 
> LLVM lowers `llvm.trap()` to `amswap.w R0, R1, R0`. For x86, it lowers
> to `ud2`, and objtool marks it as INSN_BUG.
> 
> https://github.com/llvm/llvm-project/blob/788a25a0f71bfa5e5e1c12ad093993b115d10e7a/llvm/lib/Target/LoongArch/LoongArchInstrInfo.td#L1376-L1381

Thanks for the detailed explanation from the point of view of the
compiler.

> LLVM and GCC handle this differently, GCC lowers it to a break
> instruction. Since the break instruction has other uses, can objtool
> mark all break instructions as INSN_BUG? or it should mark different
> types based on the break immediate code.

If the break immediate code is 0, it should mark the type
as INSN_TRAP. If the break immediate code is 1, it should
mark the type as INSN_BUG. I will do it.

Thanks,
Tiezhu


