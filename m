Return-Path: <linux-kernel+bounces-826524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAC3B8EB90
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 03:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A82E7A1AF5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 01:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C5B2EC0B7;
	Mon, 22 Sep 2025 01:49:47 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47772C08BB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 01:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758505787; cv=none; b=hViVXpukPHKvbQIY1zhkfZud/8tRLnS6Ys9mFU5I8qcmJaIH6NnIpaoL0INa0V2s0GS/XiDlHjrUx/Sh6wxdbAQu8K0HYss2aoUglQW4YlUkjxO5wi/7OaU082vi63OrbwG8TipzmzmE6hxR+xSvK4xnlOAwSC/ZAiGFGL1+NjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758505787; c=relaxed/simple;
	bh=MKtW4EN9S8ZBRcAqyFc04Ams4I02EIDqB78fPKWw5Ng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T2kkDvIC3rlDb4cpVoDlJGFP9unaHbN5x9E8yY3b4G8RcXVat27xrk/H4PPaIi9/UlW8fOpL6UdIalc3LIEhTStohHUg7tfz7Vb+hmXXnJpDDpWuJEh+bGaS5+zfLr8P32OnraCjaCIIEOoZcl4jtbRqpXhnRNECu3CvrlJc2To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cVQyn1JsCzKHMWd
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:49:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 39E3D1A187C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:49:40 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with SMTP id _Ch0CgBnAD8xq9BobIuPAQ--.46643S2;
	Mon, 22 Sep 2025 09:49:38 +0800 (CST)
Message-ID: <3c3d3956-250c-4216-9ebf-c85cf31fa2ba@huaweicloud.com>
Date: Mon, 22 Sep 2025 09:49:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v3] x86/dumpstack: Prevent KASAN false positive
 warnings in __show_regs
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>, x86@kernel.org,
 jpoimboe@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>,
 Dmitry Vyukov <dvyukov@google.com>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20250830092556.3360776-1-wutengda@huaweicloud.com>
 <1c54cadb-36e7-4e72-83e9-53c597570c9b@gmail.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <1c54cadb-36e7-4e72-83e9-53c597570c9b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgBnAD8xq9BobIuPAQ--.46643S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF18XFyxXw43ZF4DWF15Arb_yoWrJr1rpw
	4rJan5XF1Yy34rtr429F4kJr9xXF4qqryvq393Jr17JF1Uurn5J3y5CF1jvr1fGryUCFy5
	Jayqq34qkryfCaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Gentle Reminder: Patch Not Merged Yet

Hi,

Just a quick follow-up on my patch that got acked and reviewed over two weeks
ago. Could you please check on its status? Let me know if anything is needed
from my side.

Thanks,
Tengda

On 2025/9/5 22:12, Andrey Ryabinin wrote:
> 
> 
> On 8/30/25 11:25 AM, Tengda Wu wrote:
>> When task A walks task B's stack without suspending it, the continuous
>> changes in task B's stack (and corresponding KASAN shadow tags) may cause
>> task A to hit KASAN redzones when accessing obsolete values on the stack,
>> resulting in false positive reports. [1][2]
>>
>> The specific issue occurs as follows:
>>
>> Task A (walk other tasks' stacks)           Task B (running)
>> 1. echo t > /proc/sysrq-trigger
>>
>> show_trace_log_lvl
>>   regs = unwind_get_entry_regs()
>>   show_regs_if_on_stack(regs)
>>                                             2. The stack data pointed by
>>                                                `regs` keeps changing, and
>>                                                so are the tags in its
>>                                                KASAN shadow region.
>>     __show_regs(regs)
>>       regs->ax, regs->bx, ...
>>         3. hit KASAN redzones, OOB
>>
>> Fix this by detecting asynchronous stack unwinding scenarios through
>> `task != current` during unwinding, and disabling KASAN checks when this
>> scenario occurs.
>>
>> [1] https://lore.kernel.org/all/000000000000cb8e3a05c4ed84bb@google.com/
>> [2] KASAN out-of-bounds:
>> [332706.552324] BUG: KASAN: out-of-bounds in __show_regs+0x4b/0x340
>> [332706.552433] Read of size 8 at addr ffff88d24999fb20 by task sysrq_t_test.sh/3977032
>> [332706.552562]
>> [332706.552652] CPU: 36 PID: 3977032 Comm: sysrq_t_test.sh Kdump: loaded Not tainted 6.6.0+ #20
>> [332706.552783] Hardware name: Huawei RH2288H V3/BC11HGSA0, BIOS 3.35 10/20/2016
>> [332706.552906] Call Trace:
>> [332706.552998]  <TASK>
>> [332706.553089]  dump_stack_lvl+0x32/0x50
>> [332706.553193]  print_address_description.constprop.0+0x6b/0x3d0
>> [332706.553303]  print_report+0xbe/0x280
>> [332706.553409]  ? __virt_addr_valid+0xed/0x160
>> [332706.553512]  ? __show_regs+0x4b/0x340
>> [332706.553612]  kasan_report+0xa8/0xe0
>> [332706.553716]  ? __show_regs+0x4b/0x340
>> [332706.553816]  ? asm_exc_page_fault+0x22/0x30
>> [332706.553919]  __show_regs+0x4b/0x340
>> [332706.554021]  ? asm_exc_page_fault+0x22/0x30
>> [332706.554123]  show_trace_log_lvl+0x274/0x3b0
>> [332706.554229]  ? load_elf_binary+0xf6e/0x1610
>> [332706.554330]  ? rep_stos_alternative+0x40/0x80
>> [332706.554439]  sched_show_task+0x211/0x290
>> [332706.554544]  ? __pfx_sched_show_task+0x10/0x10
>> [332706.554648]  ? _find_next_bit+0x6/0xc0
>> [332706.554749]  ? _find_next_bit+0x37/0xc0
>> [332706.554852]  show_state_filter+0x72/0x130
>> [332706.554956]  sysrq_handle_showstate+0x7/0x10
>> [332706.555062]  __handle_sysrq+0x146/0x2d0
>> [332706.555165]  write_sysrq_trigger+0x2f/0x50
>> [332706.555270]  proc_reg_write+0xdd/0x140
>> [332706.555372]  vfs_write+0x1ff/0x5f0
>> [332706.555474]  ? __pfx_vfs_write+0x10/0x10
>> [332706.555576]  ? __pfx___handle_mm_fault+0x10/0x10
>> [332706.555682]  ? __fget_light+0x99/0xf0
>> [332706.555785]  ksys_write+0xb8/0x150
>> [332706.555887]  ? __pfx_ksys_write+0x10/0x10
>> [332706.555989]  ? ktime_get_coarse_real_ts64+0x4e/0x70
>> [332706.556094]  do_syscall_64+0x55/0x100
>> [332706.556196]  entry_SYSCALL_64_after_hwframe+0x78/0xe2
>>
>> Fixes: 3b3fa11bc700 ("x86/dumpstack: Print any pt_regs found on the stack")
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> 
> Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>


