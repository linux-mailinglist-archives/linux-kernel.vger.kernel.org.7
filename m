Return-Path: <linux-kernel+bounces-827264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 225ACB914F0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69B6D3AAD72
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC313093D7;
	Mon, 22 Sep 2025 13:11:15 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8433009E3
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546675; cv=none; b=uk3+0obeJkZaLn9Fmq2RAbSbrGm9k33QeEEqDF+jc+Gq6s54km+340bdLeeHkdtbWOT1wVTUGFdiTC5b6xz+j6+F0d53ct5plFYMaG7Ov+oOqIKx5w3pNdVKu3XLwHFZj4hXrfrVOtiO/t5N2hw6JDbZFqlXuihnlqjTnIq+V4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546675; c=relaxed/simple;
	bh=JSwcYX8p8MAuqN8qn3IrBJHS2tgbn8hI/oTjA9ipafY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ur0ROTKROhyYMy7u3V3cGQyf7kVzAbAvkbwqQA9hL+S1grs1961+2V3DGmqGqwCf2bse8ZFia4ox3eoKpje5qCv1sJVmpvIM/mDWc92da8OG8E8peBLzVFfI9WrAKFVES6Cu5kPlZYXFG4m5fDeY09DWnPT+chIs9L/v/yh8Liw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cVk552bzpzYQvH2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 21:11:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A9C471A0E2C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 21:11:09 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP1 (Coremail) with SMTP id cCh0CgDXiOHsStFo_rjEAQ--.20692S2;
	Mon, 22 Sep 2025 21:11:09 +0800 (CST)
Message-ID: <a15e3b40-f387-45be-afaa-a8a87bfb9e45@huaweicloud.com>
Date: Mon, 22 Sep 2025 21:11:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v3] x86/dumpstack: Prevent KASAN false positive
 warnings in __show_regs
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, jpoimboe@kernel.org,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Alexander Potapenko
 <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Dmitry Vyukov <dvyukov@google.com>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20250830092556.3360776-1-wutengda@huaweicloud.com>
 <20250922094404.GAaNEaZIj-Hdilh_9H@fat_crate.local>
 <697be899-8501-405f-b4f6-eff306ae05e8@huaweicloud.com>
 <20250922122855.GBaNFBB1GeS9ao4RmU@fat_crate.local>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20250922122855.GBaNFBB1GeS9ao4RmU@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgDXiOHsStFo_rjEAQ--.20692S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFW3Wr47Wr17Ww1kKFWxJFb_yoW8Aw1fpF
	yqk3ZFvF4qv348tws7Kw47XF98Xrs5KF45Xrs5Jw18Aa45urn2vFsIgF4jgFykWFZ7Ca1U
	t3yjvFn8X3WjyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2025/9/22 20:28, Borislav Petkov wrote:
> On Mon, Sep 22, 2025 at 08:14:50PM +0800, Tengda Wu wrote:
>> Running 'echo t > /proc/sysrq-trigger' will trigger this type of asynchronous
>> stack walk, as demonstrated in the use case provided below.
> 
> So lead with that please.
> 
>>>> [332706.552324] BUG: KASAN: out-of-bounds in __show_regs+0x4b/0x340
>>>> [332706.552433] Read of size 8 at addr ffff88d24999fb20 by task sysrq_t_test.sh/3977032
>>>> [332706.552562]
>>>> [332706.552652] CPU: 36 PID: 3977032 Comm: sysrq_t_test.sh Kdump: loaded Not tainted 6.6.0+ #20
> 						^^^^^^^^^^^^^^
> 
> This doesn't help - it is some random script. Trigger this with the echo 't'
> ... thing.
> 
>> However, the main challenge with stopping the task first is that it fundamentally
>> alters the state we're trying to inspect. The primary use case for an asynchronous
>> stack walk is to diagnose a task that is already misbehaving (e.g., spinning in a
>> hard lockup, not responding to stops). If we need to stop a task to get its stack,
>> we might not be able to stop it at all, or the act of stopping it could change the
>> call stack, hiding the root cause of the issue.
>>
>> This is why my implementation selectively disables KASAN precisely for the async
>> walk scenario.
> 
> Add this to the commit message too. You need to explain it in such a way so
> that someone can use your instructions and reproduce it herself, without
> asking more questions. IOW, it needs to be perfectly clear what the issue is
> and what this is fixing.
> 
> Also, you don't have to rush your next version - we have a merge window coming
> up so this'll wait for the next round.
> 
> Thx.
> 

Will do. I'll revise the commit message with the needed details.

Thanks for the note on the timing. I'll hold it for the next round.

Best regards,
Tengda


