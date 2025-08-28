Return-Path: <linux-kernel+bounces-789117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A35B39160
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 04:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E6B983BDE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 02:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BD823D7DD;
	Thu, 28 Aug 2025 02:02:00 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736F413635E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 02:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756346520; cv=none; b=SioP2SGa3Am6YW/FkL5ZFleXbx7grNI7bnkW09GgTH857KKhDWa4HGYyNMa6OuD3P11CcZVQD32ed5ufFqgzAYwt+mVsW2efOHdGO4wgOk8kdgZG54NH39MZl99qa7nbRh31Egodt0Z5E03GyP1W2WcI/f2LYPfFVjkpJW6q8eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756346520; c=relaxed/simple;
	bh=y+yiHm33LCeinfNE7Xo6ziOU1LbRw5peGyD+75TwjBc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rEYDkx3jIcKNDMugK+mROZ/jiqDPyp5CVvlXc1kQNto/JLa8TTjG46Yyd8xL+2BziHyTPQhG1f3B2RuP5MhoazTYpcrU0uPBxkGwfMdAV34EkTfYJyPBJOSRGVW9cz2kjerDlUSW90a9umuSow85Jd/mEoE755Siqcxuvsrs+/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxXNKTuK9oGQIEAA--.7977S3;
	Thu, 28 Aug 2025 10:01:55 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxH8KSuK9oIXxtAA--.25297S3;
	Thu, 28 Aug 2025 10:01:54 +0800 (CST)
Subject: Re: [RFC PATCH 2/2] objtool/LoongArch: Fix unreachable instruction
 warnings about head.S
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Nathan Chancellor <nathan@kernel.org>,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250826064631.9617-1-yangtiezhu@loongson.cn>
 <20250826064631.9617-3-yangtiezhu@loongson.cn>
 <CAAhV-H7NNtH-oaqMsN5=2c+EdF0-dy5mxcsO=_KFGWqb-FZj_w@mail.gmail.com>
 <b7551efd-cb5b-7503-c455-b8f22fac81bd@loongson.cn>
 <l7l2ik5b2inhwbxmlae7ozrlxi7hbdjbrhjsrykjgotlhflah6@jebephhvtxki>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <8f1a50bf-3c18-c550-1c69-525d30cb8f26@loongson.cn>
Date: Thu, 28 Aug 2025 10:01:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <l7l2ik5b2inhwbxmlae7ozrlxi7hbdjbrhjsrykjgotlhflah6@jebephhvtxki>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxH8KSuK9oIXxtAA--.25297S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WF4DuF4xuryUCF48Cw47Jrc_yoW8Xw48pa
	yrAa1kGrZ5Grs3ta1Dtw4avFZxtr9rJ3yxW3Z8tryrt3sFqr1rtr10yF1j9Fyqqw48Xr10
	qF10g39xuF1UA3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
	Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48J
	MxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8m2NtUUUU
	U==

On 2025/8/27 上午7:43, Josh Poimboeuf wrote:
> On Tue, Aug 26, 2025 at 08:30:23PM +0800, Tiezhu Yang wrote:
>> On 2025/8/26 下午4:26, Huacai Chen wrote:
>>> On Tue, Aug 26, 2025 at 2:46 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>>>
>>>> When compiling with LLVM and CONFIG_LTO_CLANG is set, there exist the
>>>> following objtool warnings after silencing all of the other warnings:
>>
>> ...
>>
>>>>    arch/loongarch/kernel/head.S | 8 ++++----
>>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
>>>> index e3865e92a917..566a1dbf5fa0 100644
>>>> --- a/arch/loongarch/kernel/head.S
>>>> +++ b/arch/loongarch/kernel/head.S
>>>> @@ -20,6 +20,7 @@
>>>>           __HEAD
>>>>
>>>>    _head:
>>>> +       UNWIND_HINT_UNDEFINED
>>>>           .word   IMAGE_DOS_SIGNATURE     /* "MZ", MS-DOS header */
>>>>           .org    0x8
>>>>           .dword  _kernel_entry           /* Kernel entry point (physical address) */
>>>> @@ -30,6 +31,7 @@ _head:
>>>>           .long   pe_header - _head       /* Offset to the PE header */
>>>>
>>>>    pe_header:
>>>> +       UNWIND_HINT_UNDEFINED
>>>>           __EFI_PE_HEADER
>>> The efi header is completely not code, the annotations are very strange.
>>
>> Yes, I think so too, but the aim is only to not checking for objtool,
>> it seems no other better way.
> 
> Objtool is only getting confused because there's data in a text section.
> Why not put that in a data section?

Thank you very much, that is to say, these EFISTUB instructions can be
ignored by objtool, I will do it.

Thanks,
Tiezhu


