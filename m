Return-Path: <linux-kernel+bounces-828158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B1BB94135
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD3A1668CC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1282B2472B1;
	Tue, 23 Sep 2025 03:14:10 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967C022D9EB;
	Tue, 23 Sep 2025 03:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758597249; cv=none; b=oNztDyiwOShBJZEgCRYyPB4Dv+sMKOA8ih6manekwen03ysbioa1lRcEieM+IY3U1D/78M24Lc7xtUq+fC3evwshMGyNCXUbvhG6RSVah/5r67IifHX0x5yctfrgl60YqrAjBDokvheyLlUC0A+qocJwEGpDsce5y88u+ZW0f6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758597249; c=relaxed/simple;
	bh=ZrlGg5+T9abifBw/iJ/AfUiU2mX4DnhZuR3Zd+vV5XE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=h3vpNbYZkflw3PWQkEsWpJMMpe3P/TKxDp99WaTpG5btHD6yQrEWLEI/6SulvOwwc3VYOeFwqttBe5+iomV7QEl75Sj0u9LaRDeppteZEAgnJIKGOVdMsARpu06vXTgeSIf1+ysSH5LWB+3+sbjPdAueVJ7sDINq0jB58Zj5TT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cx7792ENJown0NAA--.27437S3;
	Tue, 23 Sep 2025 11:13:58 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAxVOR1ENJorgqnAA--.10350S3;
	Tue, 23 Sep 2025 11:13:58 +0800 (CST)
Subject: Re: [PATCH v1 1/2] LoongArch: Make LTO case independent in Makefile
To: Nathan Chancellor <nathan@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 WANG Rui <wangrui@loongson.cn>, rust-for-linux@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20250909092707.3127-1-yangtiezhu@loongson.cn>
 <20250909092707.3127-2-yangtiezhu@loongson.cn>
 <20250920061536.GA1460394@ax162>
 <CAAhV-H5=w82CDx=1=PZjf4FVW_dGWe_e__QazwDTwE3kKXtPLQ@mail.gmail.com>
 <c9c4c0e6-946d-95de-9c03-a4b8e1636b81@loongson.cn>
 <7eafa4a6-55bf-2fcb-19ef-b18bd51bfd39@loongson.cn>
 <CAAhV-H4xx-C28-a8H7yJTK30+r90zL9XTSAb87Jr4zLc5ShBoA@mail.gmail.com>
 <750c907d-cc95-5116-4507-52dd48927cec@loongson.cn>
 <20250923011057.GA3980504@ax162>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <a04cc3e2-d8d9-8ac4-d919-705babf4ccd8@loongson.cn>
Date: Tue, 23 Sep 2025 11:13:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250923011057.GA3980504@ax162>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxVOR1ENJorgqnAA--.10350S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Aw13Xry8tF13JFyfXw15KFX_yoW8CrW7pa
	ykWFy3Krs8JF4Iy39Fvw4UKFZ8KrsxGFy8Xr1rtr1kZr1DZrWIgrWxtrZ3XasrZr9rJFW2
	qFW8t3s8AF4UZ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
	CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07URa0PU
	UUUU=

On 2025/9/23 上午9:10, Nathan Chancellor wrote:
>>>> ifdef CONFIG_LTO_CLANG
>>>> ifdef CONFIG_LLD_HAS_ANNOTATE_TABLEJUMP
>>>> KBUILD_LDFLAGS                  += -mllvm --loongarch-annotate-tablejump
>>>> else
>>>> KBUILD_LDFLAGS                  += -mllvm --no-jump-tables
>>>> endif
> 
> There is no '--no-jump-tables' LLVM option so this will not work.
> Shouldn't -fno-jump-tables and -Zno-jump-tables take care of generating
> jump tables?
> 
>> I do not know whether this is valid, you can test it with llvm 18
>> and llvm 20 if you think it is a proper way.
> 
> For what it's worth, Huacai's original suggestion of
> 
>      KBUILD_LDFLAGS += $(call ld-option,-mllvm --loongarch-annotate-tablejump)
> 
> appears to work for me and I do not see any objtool warnings with LTO
> enabled but I might be missing something.

As discussed offline, Huacai will test this change and submit a patch
later.

>> But IIRC, there is objtool warning with llvm 18, I reported to llvm
>> developer Wang Lei and he fixed it as the following commit:
>>
>> [LoongArch] Avoid indirect branch jumps using the ra register
>> https://github.com/llvm/llvm-project/commit/21ef17c62645
>>
>> Actually, the above commit solved a performance issue of llvm compiler,
>> so I prefer to update the minimal llvm version to 20 for LoongArch.
> 
> I tend to let architecture maintainers make the call around minimum
> supported versions of compilers, so if that is how you would like to
> proceed, I am fine with that. I will say LLVM 20 is pretty new (released
> on March 4th, 2025) but I expect most of your users to probably be using
> bleeding edge tools for all the changes you make in the compiler and
> lower level libraries?

Usually, I like to use the latest LLVM upstream version to test the
kernel, but maybe somebody only uses the lower version, so keep the
minimal version as is.

Thanks,
Tiezhu


