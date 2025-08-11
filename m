Return-Path: <linux-kernel+bounces-761772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E65DB1FE46
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 05:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69C4A7A435B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 03:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2925C243951;
	Mon, 11 Aug 2025 03:59:23 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927598F6F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754884762; cv=none; b=Hv9CN3OtIg8/LeJLSniE8cjY6QEyaZhVGKFxzgu83quXZSzJnJ0M1Ypp5KQhU80eneoGhK09Wy1OUxNskrGIc0HTJvALP5mN+4BGjb08nJWi7N+i5t64UHMrY7AQ1RYNLMkD61px31I+wm52cwswn/Je4RBGtpwheUyj8YFLnZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754884762; c=relaxed/simple;
	bh=bPrGDF3og42GRMJhIr5A+0puROLrdfVRSiTYRlrB6pQ=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qjJ2iKAr7YfLOHHbL41Ri5fyB3EZpld6ybOQLtBC2PqV0/BdWrGsg9bgsn1KGxxZYnXogrnTvfj38H4snPUj+ZGpkNhr6nvyHO4wkHvKYjHRVXZNiKT+o4rsGiI/2EMV75J+/LTrcVxcsw7m7zXNBfSzHa/zXuI+hpfnVwF1wCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Axz3ORaploBS0+AQ--.52048S3;
	Mon, 11 Aug 2025 11:59:13 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJAxvsGOaplohvFBAA--.7618S3;
	Mon, 11 Aug 2025 11:59:12 +0800 (CST)
Subject: Re: [PATCH] tick: Remove unreasonable detached state set in
 tick_shutdown()
From: Bibo Mao <maobibo@loongson.cn>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
References: <20250807035954.2412399-1-maobibo@loongson.cn>
Message-ID: <e08270ec-1151-9119-ba06-bf56352d2029@loongson.cn>
Date: Mon, 11 Aug 2025 11:57:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250807035954.2412399-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxvsGOaplohvFBAA--.7618S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KF1UJF4kGF15Kw18Zw1kWFX_yoW8CF43pr
	Z7AF9IgrWUKr40ga1xWr1qgF9xG3y5Arn5GF9rGryxCrn5AryrtF4kK347ZFy5A39I9ws8
	X3WFvw4kCayUAagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-
	e5UUUUU==

Hi,

Previously tick_shutdown() is called in BP, percpu timer cannot be 
shutdown in BP. Now it is called in AP, percpu timer can be shutdown in 
AP itself.

And there is another method, like other architectures add hotplug event 
callbak to shutdown percpu timer such as CPUHP_AP_LOONGARCH_TIMER_STARTING.

Which one do you prefer?

Regards
Bibo Mao

On 2025/8/7 上午11:59, Bibo Mao wrote:
> Function clockevents_switch_state() will check whether it has already
> switched to specified state, do nothing if it has.
> 
> In function tick_shutdown(), it will set detached state at first and
> call clockevents_switch_state() in clockevents_exchange_device(). The
> function clockevents_switch_state() will do nothing since it is already
> detached state. So the tick timer device will not be shutdown when CPU
> is offline. In guest VM system, timer interrupt will prevent vCPU to sleep
> if vCPU is hot removed.
> 
> Here remove state set before calling clockevents_exchange_device(),
> its state will be set in function clockevents_switch_state() if it
> succeeds to do so.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   kernel/time/tick-common.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
> index 9a3859443c04..eb9b777f5492 100644
> --- a/kernel/time/tick-common.c
> +++ b/kernel/time/tick-common.c
> @@ -424,11 +424,6 @@ void tick_shutdown(unsigned int cpu)
>   
>   	td->mode = TICKDEV_MODE_PERIODIC;
>   	if (dev) {
> -		/*
> -		 * Prevent that the clock events layer tries to call
> -		 * the set mode function!
> -		 */
> -		clockevent_set_state(dev, CLOCK_EVT_STATE_DETACHED);
>   		clockevents_exchange_device(dev, NULL);
>   		dev->event_handler = clockevents_handle_noop;
>   		td->evtdev = NULL;
> 
> base-commit: 7e161a991ea71e6ec526abc8f40c6852ebe3d946
> 


