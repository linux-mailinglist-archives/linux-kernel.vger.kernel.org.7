Return-Path: <linux-kernel+bounces-799670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC284B42ECC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900C37C2BC6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D048C374C4;
	Thu,  4 Sep 2025 01:26:57 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FB71C6FF5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 01:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756949217; cv=none; b=ThKCOgbfgloO5owLZYPjXQeswmgkvt5rATKBpaguq9qBfYS0uYZ1qDwcLxOcV6LmoNofpf4vWp/uh9nNIhyyhP0O186K3kHcZK6yTihk8CfGaV76en9HfwZ324mTVqqISQ0kP2JQ8KFD2GDRL1bzp5gSiJqTB6w0c3S9oWnSIZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756949217; c=relaxed/simple;
	bh=cuaU9uG3GXxPtLcYoEepVCklgjJFmkWc6RMtvoPPB/k=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qEsx0+HyP69L5DnD+0NfYDLfZXqWQZMP0KHnoNoADcSFDo3UQRbQDk97hzM6Wi1k86PDAx/o3A7/DqLmNfiHf+KgU6ZuwKlA/XmQre5aUVcjb31CCTvuZum5Rt9e4lAcW3+UA+5IcaM0vCAWf4ybSL+YlVkfLe9nOUZxaYCQ2NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [111.9.175.10])
	by gateway (Coremail) with SMTP id _____8Dx_tLY6rhoY3YGAA--.13572S3;
	Thu, 04 Sep 2025 09:26:48 +0800 (CST)
Received: from [10.136.12.26] (unknown [111.9.175.10])
	by front1 (Coremail) with SMTP id qMiowJDxrcHU6rholbt8AA--.41867S3;
	Thu, 04 Sep 2025 09:26:46 +0800 (CST)
Subject: Re: [PATCH v1 3/3] LoongArch: Fix unreachable instruction warnings
 about entry functions
To: Josh Poimboeuf <jpoimboe@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Nathan Chancellor <nathan@kernel.org>,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250901072156.31361-1-yangtiezhu@loongson.cn>
 <20250901072156.31361-4-yangtiezhu@loongson.cn>
 <ots6w2ntyudj5ucs5eowncta2vmfssatpcqwzpar3ekk577hxi@j45dd4dmwx6x>
From: Jinyang He <hejinyang@loongson.cn>
Message-ID: <93a93bcf-8778-a6a3-142d-c8aeb3cee5cd@loongson.cn>
Date: Thu, 4 Sep 2025 09:26:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ots6w2ntyudj5ucs5eowncta2vmfssatpcqwzpar3ekk577hxi@j45dd4dmwx6x>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:qMiowJDxrcHU6rholbt8AA--.41867S3
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Xr4DWr4Uur4kAF47XrWfXrc_yoW8Jr4UpF
	y7CFsrXrWDKrnFywn8t3409FWDJa4DG342g3WDKFyFkwsFqr17Zr48Zr9rWFyqqw4Iy3yF
	qFn5W39rtF4UAacCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
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

On 2025-09-04 03:22, Josh Poimboeuf wrote:

> On Mon, Sep 01, 2025 at 03:21:56PM +0800, Tiezhu Yang wrote:
>> +++ b/arch/loongarch/kernel/Makefile
>> @@ -3,8 +3,6 @@
>>   # Makefile for the Linux/LoongArch kernel.
>>   #
>>   
>> -OBJECT_FILES_NON_STANDARD_head.o := y
>> -
>>   always-$(KBUILD_BUILTIN)	:= vmlinux.lds
>>   
>>   obj-y		+= head.o cpu-probe.o cacheinfo.o env.o setup.o entry.o genex.o \
>> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
>> index e3865e92a917..a11880f3a7e1 100644
>> --- a/arch/loongarch/kernel/head.S
>> +++ b/arch/loongarch/kernel/head.S
>> @@ -42,6 +42,7 @@ SYM_DATA(kernel_fsize, .long _kernel_fsize);
>>   	.align 12
>>   
>>   SYM_CODE_START(kernel_entry)			# kernel entry point
>> +	UNWIND_HINT_UNDEFINED
> Should this not be UNWIND_HINT_END_OF_STACK?
>
> I notice Loongarch doesn't seem to use that anywhere.  How does any ORC
> unwind succeed?
IIRC, unwinder stops when fail when call __kernel_text_address(bt_address),
or success when call 
arch/loongarch/kernel/unwind_orc.c::is_entry_func(bt_address).
> UNWIND_HINT_UNDEFINED sets an error condition which
> should cause a livepatch transition to stall.
>


