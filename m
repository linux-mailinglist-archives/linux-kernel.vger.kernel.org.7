Return-Path: <linux-kernel+bounces-761394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D37CB1F989
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 11:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B02D23B9F47
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 09:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A76243951;
	Sun, 10 Aug 2025 09:59:14 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E056B14A0B7
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 09:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754819953; cv=none; b=fmEyKl+krsy/l9RQ3I9PUWC07uCTP0VPkFMTgxOp/S5Wtc2S1xd9ljoWSCZxHwDOUT4D3hHqROfguUxu2fwOhp5T3IgLMU0FPt+Xb02Xr+OXQt5/rnfh9wPoS2rO91j5486hobHNuMEzHlskD/6gbnV341cknonh2PqnCnVA3nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754819953; c=relaxed/simple;
	bh=MR0BJBiidtx0ChMQLgs/IbEzrG6FhO9Bo9m/jmtmG08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bkV8aknSJd197AxSj0C3jW6ANiJ/J57+EEfOeBdsNLLjvz4QanjZavTt3cCEBqIOjlfAFTLOYZ/ZAPST+QBQ+susWLnpiwAmssiS8ONgVAcoNXVBscb7PP/aSSYYeUDG7vVx3mptjEYJ/rKVbu/0VTdERPhOtxN2Av6pjXCfdUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.23.20] (unknown [119.78.253.22])
	by APP-05 (Coremail) with SMTP id zQCowABHn1_2a5ho0jOfCg--.37321S2;
	Sun, 10 Aug 2025 17:52:55 +0800 (CST)
Message-ID: <5a96d08e-0714-4925-a9c4-ea66549623d1@iscas.ac.cn>
Date: Sun, 10 Aug 2025 17:52:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: Add sysctl to control discard of vstate during
 syscall
To: Drew Fustini <fustini@kernel.org>, Darius Rad <darius@bluespec.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Samuel Holland <samuel.holland@sifive.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Andy Chiu <andybnac@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Drew Fustini <dfustini@tenstorrent.com>
References: <20250806-riscv_v_vstate_discard-v2-1-6bfd61b2c23b@kernel.org>
 <aJXvWuPKIc2lCSX3@localhost.localdomain>
 <e4d21516-23b5-404b-a7da-cf6ebfd02dbc@iscas.ac.cn> <aJb+wifbIAsit+me@x1>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <aJb+wifbIAsit+me@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zQCowABHn1_2a5ho0jOfCg--.37321S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jry5WFW7tFWrAF47Ww47twb_yoWxJr18pr
	W3GFsrKr1DZw1xZwn2qw48XFWxKFZ3Gw45Wr15G348ZF98ur9xtrn3tayruF97XrW8Cryj
	qw4F9a4xZ3yUAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY
	1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x07betCcUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/


On 8/9/25 15:54, Drew Fustini wrote:
> On Sat, Aug 09, 2025 at 11:58:24AM +0800, Vivian Wang wrote:
>> My previous comment on v1 on prefering clobbering with VS = Initial
>> handling aside...
> I found that in the discard vector state patch discussion 2 years ago
> that Andy and Bjorn discussed how Initial could cause a problem [1]:
>
>   It's not a racy, but you're correct that setting the state to Initial,
>   will cause issues. When get/set_regs is called, the tracee will be
>   stopped, and a schedule() has been done.
>
> In the v3 series, Bjorn notes [2]:
>
>   Set state to Dirty after discard, for proper ptrace() handling (Andy)

Ahh... That's more complicated than I thought.

I have some rough ideas on fixing ptrace handling, and I personally
still vastly prefer VS=Initial, but given the complexity, I think it
makes sense to defer this work until later and just get this performance
fix in first. And also...

> Also, I would like the ability to have the ability to switch off
> __riscv_v_vstate_discard() and not loose any cycles to it, so I think
> this sysctl is a good fit for that.

I was initially (ha!) worried about the sysctl knob getting in, and
immediately going away after we implement VS=Initial (correctly), but if
you think the right thing is to have this knob always, that wouldn't be
a problem.

>> On 8/8/25 20:36, Darius Rad wrote:
>>> On Wed, Aug 06, 2025 at 07:03:28AM -0700, Drew Fustini wrote:
>>> [...]
>>>> diff --git a/Documentation/arch/riscv/vector.rst b/Documentation/arch/riscv/vector.rst
>>>> index 3987f5f76a9deb0824e53a72df4c3bf90ac2bee1..b702c00351617165a4d8897c7df68eadcd2d562e 100644
>>>> --- a/Documentation/arch/riscv/vector.rst
>>>> +++ b/Documentation/arch/riscv/vector.rst
>>>> @@ -134,7 +134,25 @@ processes in form of sysctl knob:
>>>>  3.  Vector Register State Across System Calls
>>>>  ---------------------------------------------
>>>>  
>>>> -As indicated by version 1.0 of the V extension [1], vector registers are
>>>> -clobbered by system calls.
>>>> +Linux adopts the syscall ABI proposed by version 1.0 of the V extension [1],
>>>> +where vector registers are clobbered by system calls. Specifically:
>>>> +
>>>> +    Executing a system call causes all caller-saved vector registers
>>>> +    (v0-v31, vl, vtype) and vstart to become unspecied.
>>>> +
>>> Perhaps:
>>>
>>> Clobbering the vector registers may prevent leaking information to user
>> No... Not clobbering does not "leak" anything. If you find that it leaks
>> information, please report - that's a bug.
> Thanks Darius and Vivian for your comments. I think it is a good idea
> for me to write about the possible advantages of mandatory clobbering on
> syscall entry. However, I am also uncertain how clobbering on syscall
> entry helps prevent leaking information.
>
>>> space and aid in debugging, but can significantly increase system call
>>> latency for some implementations.  [...]
> I think that is a good idea for me to call out that this is can be
> useful for debugging and testing.
>
Yeah, I agree that this second part of the description is good.

>>>> +However, clobbering the vector registers can significantly increase system call
>>>> +latency for some implementations. To mitigate this performance impact, a sysctl
>>>> +knob is provided that controls whether vector state is always discarded in the
>>>> +syscall path:
>>>> +
>>>> +* /proc/sys/abi/riscv_v_vstate_discard
>>>> +
>>>> +    Valid values are:
>>>> +
>>>> +    * 0: Vector state is not always clobbered in all syscalls
>>>> +    * 1: Mandatory clobbering of vector state in all syscalls
>>>> +
>>>> +    Reading this file returns the current discard behavior. The initial state is
>>>> +    controlled by CONFIG_RISCV_ISA_V_VSTATE_DISCARD.
>>>>  
>>>>  1: https://github.com/riscv/riscv-v-spec/blob/master/calling-convention.adoc
>>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>>> index 36061f4732b7496a9c68a9a10f9959849dc2a95c..7bb8a8513135cbc105bd94d273012486a886f724 100644
>>>> --- a/arch/riscv/Kconfig
>>>> +++ b/arch/riscv/Kconfig
>>>> @@ -656,6 +656,16 @@ config RISCV_ISA_V_DEFAULT_ENABLE
>>>>  
>>>>  	  If you don't know what to do here, say Y.
>>>>  
>>>> +config RISCV_ISA_V_VSTATE_DISCARD
>>>> +	bool "Enable Vector state discard by default"
>>>> +	depends on RISCV_ISA_V
>>>> +	default n
>>>> +	help
>>> Perhaps add the following paragraph:
>>>
>>> Discarding vector state is more robust, but has negative performance
>>> implications in certain implementations.
>> "Robust" is too vague... I don't think this word is helpful for anyone
>> trying to understand what this does.
> I agree that I should add more description to the Kconfig option as I
> think what I wrote assumes too much prior knowledge of the code. Maybe
> something like this:
>
>   Discarding vector state on syscall entry can help identify userpace
>   programs that are mistakenly relying on vector state being preserved
>   across syscalls. This can be useful for debugging and test suites.
>   However, this behavior can negatively impact performance on some
>   RISC-V implementations.
>
>   Say Y here if you want mandatory clobbering of vector state before
>   entering all syscalls. If you select N, then userspace can still
>   eanble it via the abi.riscv_v_vstate_discard sysctl knob.

Typo: eanble -> enable

Also, I think it kinda makes the false impression that the sysctl knob
is only available with this set to N? I think this should be structured
to say something like this being the default value, and also say that
userspace can override this behavior system-wide via the sysctl knob.

Otherwise mostly looks good to me, assuming that this matches the
intentions of the original design.

Thanks,
Vivian "dramforever" Wang

>   If you don't know what to do here, then select N.
>
> Thanks,
> Drew
>
>
> [1] https://lore.kernel.org/linux-riscv/87r0pug6hb.fsf@all.your.base.are.belong.to.us/
> [2] https://lore.kernel.org/linux-riscv/20230629062730.985184-1-bjorn@kernel.org/


