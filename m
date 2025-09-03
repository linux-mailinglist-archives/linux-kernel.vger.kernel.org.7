Return-Path: <linux-kernel+bounces-798166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE42B41A35
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BA5D168E14
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83072E2EEF;
	Wed,  3 Sep 2025 09:38:14 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5466A1B3935
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 09:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756892294; cv=none; b=VzZfeo8YM/uDPUhJGYRK17ywEEF1SSBaCQNjrBBC9t5zYl9Pkj0NVpV9lWoGrKpaBit5jSZkIXklWzcMBrqmu97vaKBY7cldJdXHoui5Kar15tXeGNF/9Xj4EGLwW1HVjPWyaWDVVKKoCwEAtScctthlMFQ45go5Kr4vUnI9F7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756892294; c=relaxed/simple;
	bh=vu2WiTWiau9aUXGHqTYJRxhtrPCS5+9tdoc8VWQksYA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GySPtNsdqiyfUcn9aTlAM2CeoaUf3F3SG8vepB17Ee4UlbzyLor8JkOTcf3VbVUUuOEc8en/AG7hNWcqYPHWX0zyCVK/SCtzWKz4ahTndhi8cSWOziFXZ77WOCOHyC8V1hH/7YUIA0Uh68ZeRhvDcDo1gaFgfW3QFoM4F9F4eek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Dxb_B_DLho+SsGAA--.13088S3;
	Wed, 03 Sep 2025 17:38:07 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJDx_8N8DLhoLfR6AA--.59822S3;
	Wed, 03 Sep 2025 17:38:07 +0800 (CST)
Subject: Re: [PATCH] tick: Remove unreasonable detached state set in
 tick_shutdown()
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org
References: <20250807035954.2412399-1-maobibo@loongson.cn>
 <aLb6NFWw3CP2MYp-@localhost.localdomain>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <77b00eac-8dd5-23bc-a44c-3c3621b7c62a@loongson.cn>
Date: Wed, 3 Sep 2025 17:36:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aLb6NFWw3CP2MYp-@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDx_8N8DLhoLfR6AA--.59822S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kr4rArW7WF1UGw1kWw15GFX_yoW8Zry5pF
	4kJrn0kr98Ww4FqF13tw1UWF93Gay8Ar4kKF13G3sF9rWrJw18tF4DKFW7uFy3J3sI9wna
	q3WFyr48uFWUAagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-e5UU
	UUU==



On 2025/9/2 下午10:07, Frederic Weisbecker wrote:
> Le Thu, Aug 07, 2025 at 11:59:54AM +0800, Bibo Mao a écrit :
>> Function clockevents_switch_state() will check whether it has already
>> switched to specified state, do nothing if it has.
>>
>> In function tick_shutdown(), it will set detached state at first and
>> call clockevents_switch_state() in clockevents_exchange_device(). The
>> function clockevents_switch_state() will do nothing since it is already
>> detached state. So the tick timer device will not be shutdown when CPU
>> is offline. In guest VM system, timer interrupt will prevent vCPU to sleep
>> if vCPU is hot removed.
>>
>> Here remove state set before calling clockevents_exchange_device(),
>> its state will be set in function clockevents_switch_state() if it
>> succeeds to do so.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> 
> On a second thought, it may need the following tags:
> 
> Fixes: bf9a001fb8e4 ("clocksource/drivers/timer-tegra: Remove clockevents shutdown call on offlining")
> Fixes: cd165ce8314f ("clocksource/drivers/qcom: Remove clockevents shutdown call on offlining")
> Fixes: 30f8c70a85bc ("clocksource/drivers/armada-370-xp: Remove clockevents shutdown call on offlining")
> Fixes: ba23b6c7f974 ("clocksource/drivers/exynos_mct: Remove clockevents shutdown call on offlining")
> Fixes: 15b810e0496e ("clocksource/drivers/arm_global_timer: Remove clockevents shutdown call on offlining")
> Fixes: 78b5c2ca5f27 ("clocksource/drivers/arm_arch_timer: Remove clockevents shutdown call on offlining")
> Fixes: 900053d9eedf ("ARM: smp_twd: Remove clockevents shutdown call on offlining")
> 
> Because those commits removed shutdown calls made from drivers that assumed the
> core would do on their behalf. But it was not the case before your fix.
Ok, will add these fixes tags in next version.

Regards
Bibo Mao
> 
> Thanks!
> 


