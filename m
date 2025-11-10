Return-Path: <linux-kernel+bounces-893127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CB3C4695E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8C363BF41E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B733FBE5E;
	Mon, 10 Nov 2025 12:24:39 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1211918626
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762777479; cv=none; b=EOkpnee5EWTEUehaC1Sxr59a2hHO09D81f9mvKy2/tC/s3zSmHRj93bezkp9PEuHtxlXKhx8SxKj/aRywqJslOq+drdE8YBAITZPMocLghGBfMneKUzwr26bGFQHUe6ELbILs2CjWIDbhoBUKIYomBLChjQyfDIWJ0Erk3O9uFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762777479; c=relaxed/simple;
	bh=5F52AzEPXsCHU2TlETR3GM8Gqw/rYkrelJ/fFBb3pdo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uTBOO10kcabPxw1DElo+ASmtb8jM5n3GN5T7TLavToNs/nUno1LwSP6QmHIhlWpGvHmnv4Jc/68oLP1vF1rJ8MdwZX2oveWf+oHYJvR3Bu2CoFWPbOXJITH4N1oflPeRehW/fSq+DM+OJ6haW11NyiqsEHbyM4a6JCW130H1Xdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.10.40.23])
	by gateway (Coremail) with SMTP id _____8CxL9N82RFpWnchAA--.5948S3;
	Mon, 10 Nov 2025 20:24:28 +0800 (CST)
Received: from [10.10.40.23] (unknown [10.10.40.23])
	by front1 (Coremail) with SMTP id qMiowJCxG8F52RFpzx0uAQ--.32684S3;
	Mon, 10 Nov 2025 20:24:25 +0800 (CST)
Subject: Re: [PATCH v2 0/2] LoongArch: Refine init_hw_perf_events()
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, vishal.moola@gmail.com, arnd@arndb.de
References: <20251110025906.17096-1-yangtiezhu@loongson.cn>
 <CAAhV-H4=ZfYfRFE8VYmxyKxTAi8E=YKysG1fzed4kZRWnMUoeA@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <4deb96d9-509c-3b3f-934f-58de8d29241b@loongson.cn>
Date: Mon, 10 Nov 2025 20:24:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4=ZfYfRFE8VYmxyKxTAi8E=YKysG1fzed4kZRWnMUoeA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxG8F52RFpzx0uAQ--.32684S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFWUuw13AFW7Aw4kZw15WrX_yoW8XFyfpF
	WDAFsI9r4DGrn7ZF4qga18WFyjqF1kWr9IgFy8J3s8uFWDZ3Wvvw18ur4xuF97Xr98KF1j
	qFyfXa4kuFyUA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUc0eHDUUUU

在 2025/11/10 下午2:48, Huacai Chen 写道:
> V1 was applied last week and now in linux-next, don't do meaningless work.
> 
> Huacai
> 
> On Mon, Nov 10, 2025 at 10:59 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> This version is based on 6.18-rc5, use the proper patch title
>> to make it clear.
>>
>> Tiezhu Yang (2):
>>    LoongArch: Use CPUCFG6_PMNUM_SHIFT to get PMU number
>>    LoongArch: Detect PMU bits via CPUCFG instruction
>>
>>   arch/loongarch/include/asm/loongarch.h | 1 +
>>   arch/loongarch/kernel/perf_event.c     | 7 ++++---
>>   2 files changed, 5 insertions(+), 3 deletions(-)

I do not like to argue with you, but I do not think what you said is
right, there are double standards here.

The code are rebased frequently by you in linux-loongson.git, the latest
is after 6.18-rc5 that is in this week, my patch is also rebased.

You accepted the suggestion of your patch v1 title [1] and send v2 [2]
although v1 has been applied by Andrew, because you think it is a good
suggestion.

I just do the similar and right thing,  but your reply is not polite
and friendly, and also do not do the thing what you should to do as a
maintainer.

[1] 
https://lore.kernel.org/linux-mm/20251108084724.3e389b6597294900347b0476@linux-foundation.org/

[2] 
https://lore.kernel.org/linux-mm/20251109021817.346181-1-chenhuacai@loongson.cn/

[3] 
https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git/commit/?h=loongarch-fixes&id=4c8a7c982772

Thanks,
Tiezhu


