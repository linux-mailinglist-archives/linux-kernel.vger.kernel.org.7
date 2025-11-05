Return-Path: <linux-kernel+bounces-885754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F90CC33D51
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 04:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77DD1463725
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 03:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B46723BD1D;
	Wed,  5 Nov 2025 03:12:48 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92D117C220
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 03:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762312368; cv=none; b=Lj7qXwIjBFBk9qX/V0L6S6it+8fw5KiWpkglA54pqzMKCLJ+nhapotDwfb5jZKMrLJiS2QOOEG0v+ak543LQyIhDKE5iSGAY+wee95i2TR1Xh4OScP97LeZc77pFrScO359XoG9X25X72S9TlUgQGKVCsCnCdNJGRsNcxWpmwjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762312368; c=relaxed/simple;
	bh=Cc8tcOLIYtLa02HjBXT/S5QLaMDyVzaGmWUsKoqT0uM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WTL0g/T1ghomSNVXpi9KpXI2BYdbVlq0gthvCwSJYv6Dn9SFFZo0P5UaE9f1wVSGLU/Eg3p1r3zJvCg5Slag6JohhwL/24x4Ful6iOx9UqrvHkMMdmCCUlITJQVdNJHDeq9A4BeXK6jtQDo/tQQeQ0csg5EhpagKU6cskWn/4GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxSNGowAppMQgfAA--.2413S3;
	Wed, 05 Nov 2025 11:12:40 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAxE+SkwAppoaAnAQ--.58995S3;
	Wed, 05 Nov 2025 11:12:37 +0800 (CST)
Subject: Re: [PATCH] LoongArch: ptrace: Merge ptrace_hbp_set_*()
To: Huacai Chen <chenhuacai@kernel.org>, Bill Tsui <b10902118@ntu.edu.tw>
Cc: oleg@redhat.com, kernel@xen0n.name, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251029153649.33345-1-b10902118@ntu.edu.tw>
 <CAAhV-H5E79jZ9rMYyP3h+KLX5rDGcB-Ec8WqyAhPC-pvuvv5UQ@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <429e94ee-ee77-3a5c-a2f7-c0d027fb7c4c@loongson.cn>
Date: Wed, 5 Nov 2025 11:12:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5E79jZ9rMYyP3h+KLX5rDGcB-Ec8WqyAhPC-pvuvv5UQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxE+SkwAppoaAnAQ--.58995S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWrZFWfGw1rKry7CrykAw4rCrX_yoW8JF1rp3
	yIyrs0kFs8tw40kw1xKw10qa4j9r1UKa45C3s5Xa4rZ3WY9Fn3AFWI9ay3KayUGry0934I
	vrZxZrZ3uFy5uacCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
	I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
	JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8q2NtUUUUU==

Hi Bill,

On 2025/11/5 上午8:57, Huacai Chen wrote:
> Hi, Tiezhu,
> 
> On Wed, Oct 29, 2025 at 11:38 PM Bill Tsui <b10902118@ntu.edu.tw> wrote:
>>
>> In hw_break_set(), those functions actually can be combined into one.
>> This eliminates intermediate calls to modify_user_hw_breakpoint() that
>> may leave hardware registers in a partially updated state.
>>
>> This redundancy was originally found in ARM ptrace, where it caused
>> non-4-byte address alignment checks to fail.
>>
>> Link:
>> https://lore.kernel.org/all/20251018133731.42505-2-b10902118@ntu.edu.tw/
>>
>> The LoongArch implementation appears to have been derived from ARM,
>> so this refactor helps avoid the same issue and simplifies future
>> maintenance.
> What do you think about it?

Can you describe directly what is wrong with the current code
on LoongArch? Please do not show the ARM's under-review patch
link in the commit message.

Does this patch fix real problem? If there is a test case to
reproduce the problem, please add it into the commit message.

If there is no functional change, just to refactor the code or
avoid the potential issues, please give a explicit description.
We will test GDB to see whether there is a regression.

Thanks,
Tiezhu


