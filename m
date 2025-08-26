Return-Path: <linux-kernel+bounces-786611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 755D4B35F17
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CCC01B65718
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FED8327797;
	Tue, 26 Aug 2025 12:27:25 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5257031987F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 12:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756211244; cv=none; b=dSKDuVnGlc86YvIn4AFAhjkvJkB+0gQv9VDknb+ejqw+tN3jl43MDMIcOh7v7s8TySmG316FK3XWqSwU5MFOYRP6PONz0lQOWF3optIzVT2kRn6tiTMzbQh1Ubpj/65bq82y8lMbZNgOhPTX6s2WanP2LJVmddavJzALo53ZFy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756211244; c=relaxed/simple;
	bh=lr/ktiqN8EGAwxTSlE1IH8BeTaDaJt2Zb2PkjFQqbHY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nfHPdIN0EosW9T9JZPvg3RdiG2u2GJTpaGrGWJEjmkuv8KejlJC/HJs31DW5UBqwHYrYknxeZxcMYXZjRRcWtNY5G6cYW12KV43R7A7uQhmQsh3HxwFGBhfltC/I5xjKg729zUI7nKBGNxOogvW/XJkVs/fGY5ZtCHdy1rqRETs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Dxfb8lqK1oc1wDAA--.5461S3;
	Tue, 26 Aug 2025 20:27:17 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxzsEhqK1oQ_5pAA--.40668S3;
	Tue, 26 Aug 2025 20:27:14 +0800 (CST)
Subject: Re: [RFC PATCH 2/2] objtool/LoongArch: Fix unreachable instruction
 warnings about head.S
To: Peter Zijlstra <peterz@infradead.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250826064631.9617-1-yangtiezhu@loongson.cn>
 <20250826064631.9617-3-yangtiezhu@loongson.cn>
 <20250826082057.GE3245006@noisy.programming.kicks-ass.net>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <8dfe8bde-0095-d6c3-b9ca-cce2bf720ac2@loongson.cn>
Date: Tue, 26 Aug 2025 20:27:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250826082057.GE3245006@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxzsEhqK1oQ_5pAA--.40668S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWrZrW7ZF4rCFykXFy3tw1DurX_yoW8JF17pF
	WUAw40kFZ8Jr1I9a13Ja1fWFyY9FZxXrWfGr1q9rySyayqyayjqr1agr1j9F9Iva9xKFyF
	vw4DtF909Fn8AagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
	6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
	vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8vApUUU
	UUU==

On 2025/8/26 下午4:20, Peter Zijlstra wrote:
> On Tue, Aug 26, 2025 at 02:46:31PM +0800, Tiezhu Yang wrote:
>> When compiling with LLVM and CONFIG_LTO_CLANG is set, there exist the
>> following objtool warnings after silencing all of the other warnings:

...

>> Just give a proper unwind hint to silence the above warnings. By the way,
>> the previous instructions of kernel_entry+0xf4 and smpboot_entry+0x68 are
>> the 'bl' instructions, the call destination symbols are start_kernel() and
>> start_secondary() which are noreturn functions, then the 'bl' instructions
>> are marked as dead end in annotate_call_site(), so actually ASM_BUG() can
>> be removed due to unnecessary, otherwise there are following warnings:

...

>> Link: https://lore.kernel.org/lkml/20250814083651.GR4067720@noisy.programming.kicks-ass.net/
>> Suggested-by: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>   arch/loongarch/kernel/head.S | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> At this point you should also be able to remove that Makefile thing,
> right?

Yes, you are right, will do it in the next version if this patch
makes sense.

Thanks,
Tiezhu


