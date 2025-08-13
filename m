Return-Path: <linux-kernel+bounces-765786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABE8B23E44
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 04:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838681B6033A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 02:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD4F1A3155;
	Wed, 13 Aug 2025 02:30:37 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BA61EA6F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 02:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755052237; cv=none; b=iHpZMAH0xAoL82iwhCc0rBiBiio//9CFzUA/8/n5OWaQJxIOi2BxKJCIjjUudf0uvwVdwdRL1B33FTn9bQMIWja445bWUaIh7XUf2FcYoIAA0B8xal9rwcbviRFpuUuU/6xdOKrHXkRbQ9SB+J+90f8MFHVta6tPyxZm3uUEVeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755052237; c=relaxed/simple;
	bh=rFxGt71pAfBpY4kl8ifJorZ6fJ9QuIiicyDhtCYx70c=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=P9wD0Bzwyx2yz02puA7qD0ALrRwyA0EI41d/aFGlnIRf3V9Oa6n/Qk6IR9zYPqD4hkgn0bzNK08wiaWVcv/TgBW5VTr1vgBjBr0sAbF6CsG42pczbD4O1JZK/3CHQbzt39zYTmP7vq0TXfocbM1on55VDRh3BAdPwVc4fLueHDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.239])
	by gateway (Coremail) with SMTP id _____8AxmnHH+JtobS4_AQ--.54216S3;
	Wed, 13 Aug 2025 10:30:31 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
	by front1 (Coremail) with SMTP id qMiowJDxQ+TD+Jto9RRIAA--.11342S3;
	Wed, 13 Aug 2025 10:30:29 +0800 (CST)
Subject: Re: [PATCH] LoongArch: KVM: Use kvm_get_vcpu_by_id() instead of
 kvm_get_vcpu()
To: Yanteng Si <si.yanteng@linux.dev>, maobibo@loongson.cn,
 zhaotianrui@loongson.cn, chenhuacai@kernel.org, lixianglai@loongson.cn
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250811025544.458422-1-gaosong@loongson.cn>
 <ed67c8bd-9e79-47c7-9186-910b530a191c@linux.dev>
From: gaosong <gaosong@loongson.cn>
Message-ID: <0ab5cded-c1e1-e0bc-25fb-f4f8ef9567b6@loongson.cn>
Date: Wed, 13 Aug 2025 10:33:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ed67c8bd-9e79-47c7-9186-910b530a191c@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowJDxQ+TD+Jto9RRIAA--.11342S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7AFyUKF15GF1UKF4rGrW5CFX_yoW8Kr4rpF
	n7Can0vFWrKrykG34Uta4UZFyUGrs5tw1kWF40yFy5Ar47XF1jgry8Wr90gFyUCw4xGF40
	qr1Ygr1avF4UJ3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
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

在 2025/8/12 上午10:06, Yanteng Si 写道:
> 在 8/11/25 10:55 AM, Song Gao 写道:
>> Use kvm_get_vcpu() may can't get vcpu context, use kvm_get_vcpu_by_id()
>> instead of kvm_get_vcpu().
> Since using kvm_get_vcpu() may fail to retrieve the vcpu context,
> kvm_get_vcpu_by_id() should be used instead.
>
> Under this premise, and under the premise of making revisions
> in accordance with Bibo's and Huacai's suggestions，pick up my tag in v2.
>
Got it .
> Reviewed-by: Yanteng Si <siyanteng@cqsoftware.com.cm>
>
> Additionally, do we need a fixes tag?
>
I will add a fixes tag on v2.

Thanks.
Song Gao
> Thanks,
> Yanteng
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   arch/loongarch/kvm/intc/eiointc.c | 5 ++++-
>>   arch/loongarch/kvm/intc/ipi.c     | 2 +-
>>   2 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/loongarch/kvm/intc/eiointc.c 
>> b/arch/loongarch/kvm/intc/eiointc.c
>> index a3a12af9ecbf..5180da91d2e6 100644
>> --- a/arch/loongarch/kvm/intc/eiointc.c
>> +++ b/arch/loongarch/kvm/intc/eiointc.c
>> @@ -45,7 +45,10 @@ static void eiointc_update_irq(struct 
>> loongarch_eiointc *s, int irq, int level)
>>       }
>>         cpu = s->sw_coremap[irq];
>> -    vcpu = kvm_get_vcpu(s->kvm, cpu);
>> +    vcpu = kvm_get_vcpu_by_id(s->kvm, cpu);
>> +    if (unlikely(vcpu == NULL)) {
>> +        return;
>> +    }
>>       if (level) {
>>           /* if not enable return false */
>>           if (!test_bit(irq, (unsigned long *)s->enable.reg_u32))
>> diff --git a/arch/loongarch/kvm/intc/ipi.c 
>> b/arch/loongarch/kvm/intc/ipi.c
>> index e658d5b37c04..0348a83a7ed7 100644
>> --- a/arch/loongarch/kvm/intc/ipi.c
>> +++ b/arch/loongarch/kvm/intc/ipi.c
>> @@ -298,7 +298,7 @@ static int kvm_ipi_regs_access(struct kvm_device 
>> *dev,
>>       cpu = (attr->attr >> 16) & 0x3ff;
>>       addr = attr->attr & 0xff;
>>   -    vcpu = kvm_get_vcpu(dev->kvm, cpu);
>> +    vcpu = kvm_get_vcpu_by_id(dev->kvm, cpu);
>>       if (unlikely(vcpu == NULL)) {
>>           kvm_err("%s: invalid target cpu: %d\n", __func__, cpu);
>>           return -EINVAL;
>


