Return-Path: <linux-kernel+bounces-697405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C24DCAE33BE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 04:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60894188F4F2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 02:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2662719C556;
	Mon, 23 Jun 2025 02:46:16 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8314ABA50;
	Mon, 23 Jun 2025 02:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750646775; cv=none; b=IGXMt9AVSIYMHkAfYovvtHDZPOP614M0PrZfBsHP6qQnTh7XWOVxUH5DTSSzjAsDiloCsAWUp8NGD0+ejnWe3xHsEkBZ3h/f8KnZ83obyHzRjdzty8Ie+hyoU/It6r6Z9JALdpsaPgUu3wZBiBHMONSaY/YqEO2wqr+q+l2RMq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750646775; c=relaxed/simple;
	bh=noVEtO+mmxWEMSDatHCpAJTN3cZTOH7PStFp6VmyguE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HrJGHI9BdAmHEYtGoN1DU8qk53l27980ddf91LjqHyLaBWcJVG9+KHkfSN1G+KytEnpgMhRNwlWxts4yTupwhxFzlTdBAqEYLagVhHl/JhASaNBqOQXLz5qwg0BFZGMXg522RDordQSWhaHJ8a1Q2ONC2+edHgHOve3yXxcKZh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.24])
	by gateway (Coremail) with SMTP id _____8Bxnmvwv1ho4WAbAQ--.20967S3;
	Mon, 23 Jun 2025 10:46:08 +0800 (CST)
Received: from [10.20.42.24] (unknown [10.20.42.24])
	by front1 (Coremail) with SMTP id qMiowMBx3xvfv1ho7qcmAQ--.62230S3;
	Mon, 23 Jun 2025 10:45:54 +0800 (CST)
Subject: Re: [PATCH v4 2/2] irq/irq-loongarch-ir:Add Redirect irqchip support
To: Thomas Gleixner <tglx@linutronix.de>, chenhuacai@kernel.org,
 kernel@xen0n.name, corbet@lwn.net, alexs@kernel.org, si.yanteng@linux.dev,
 jiaxun.yang@flygoat.com, peterz@infradead.org, wangliupu@loongson.cn,
 lvjianmin@loongson.cn, maobibo@loongson.cn, siyanteng@cqsoftware.com.cn,
 gaosong@loongson.cn, yangtiezhu@loongson.cn
Cc: loongarch@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250610114252.21077-1-zhangtianyang@loongson.cn>
 <20250610114252.21077-3-zhangtianyang@loongson.cn> <87o6uris6p.ffs@tglx>
From: Tianyang Zhang <zhangtianyang@loongson.cn>
Message-ID: <9c60326b-f7bd-0b36-3bc5-0ad7d19690f1@loongson.cn>
Date: Mon, 23 Jun 2025 10:45:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87o6uris6p.ffs@tglx>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMBx3xvfv1ho7qcmAQ--.62230S3
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9fXoW3tFy5ur45Cw48KFy8CF15GFX_yoW8XrW7Xo
	WfJrs7Aa18Wr1rGrWUCayIyFy3Aa4rur48Aw1UGwsrA3Z0va1UCw4xG3y5XFWagF40qF47
	Ja48J3s8KFWjqrn3l-sFpf9Il3svdjkaLaAFLSUrUUUU5b8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUOn7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
	xGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8XTm3
	UUUUU==

Hi, Thomas

�� 2025/6/13 ����11:20, Thomas Gleixner д��:
> On Tue, Jun 10 2025 at 19:42, Tianyang Zhang wrote:
>>   		if (cpu_online(adata->cpu) && cpumask_test_cpu(adata->cpu, dest))
>> -			return 0;
>> +			/*
>> +			 * The new affinity configuration has taken effect,
>> +			 * and returning IRQ_SET_MASK_OK_DONE here indicates that no further
>> +			 * changes need to be made in the subsequent process
> This is not what IRQ_SET_MASK_OK_DONE is about. The documentation
> clearly says:
>
>   * IRQ_SET_MASK_OK_DONE - Same as IRQ_SET_MASK_OK for core. Special code to
>   *                        support stacked irqchips, which indicates skipping
>   *                        all descendant irqchips.
>
> It's not about further changes. It's about preventing invoking
> set_affinity() callbacks down the hierarchy.
>
> And you still fail to explain why this change is correct for the
> existing code. That explanation wants to be in the changelog of the
> seperate patch doing this change.
>
> And then you can spare the comment, which is btw. also violating the
> bracket rules in the tip maintainers documentation.

OK, This means that this change involves adjustments to the code 
organization

and cannot be included solely in a large patch. It requires clearer 
submission records and explanations

If that's the case, I will make the necessary modifications as 
requested. Thank you

>
>
>> +			 */
>> +			return IRQ_SET_MASK_OK_DONE;
>>   
>>   		cpumask_and(&intersect_mask, dest, cpu_online_mask);
>>   
>> @@ -121,7 +116,8 @@ static int avecintc_set_affinity(struct irq_data *data, const struct cpumask *de
>>   		adata->cpu = cpu;
>>   		adata->vec = vector;
>>   		per_cpu_ptr(irq_map, adata->cpu)[adata->vec] = irq_data_to_desc(data);
>> -		avecintc_sync(adata);
>> +		if (!cpu_has_redirectint)
>> +			avecintc_sync(adata);
>>   	}
>>   
>>   	irq_data_update_effective_affinity(data, cpumask_of(cpu));
>> @@ -412,6 +408,9 @@ static int __init pch_msi_parse_madt(union acpi_subtable_headers *header,
>>   
>>   static inline int __init acpi_cascade_irqdomain_init(void)
>>   {
>> +	if (cpu_has_redirectint)
>> +		return redirect_acpi_init(loongarch_avec.domain);
>> +
>>   	return acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC, pch_msi_parse_madt, 1);
>>   }
>>   
>> diff --git a/drivers/irqchip/irq-loongarch-ir.c b/drivers/irqchip/irq-loongarch-ir.c
>> new file mode 100644
>> index 000000000000..ae42ec5028d2
>> --- /dev/null
>> +++ b/drivers/irqchip/irq-loongarch-ir.c
>> @@ -0,0 +1,562 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2020 Loongson Technologies, Inc.
>> + */
>> +
>> +#include <linux/cpuhotplug.h>
>> +#include <linux/init.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/irq.h>
>> +#include <linux/irqchip.h>
>> +#include <linux/irqdomain.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/msi.h>
>> +
>> +#include <asm/irq.h>
>> +#include <asm/loongarch.h>
>> +#include <asm/setup.h>
>> +#include <larchintrin.h>
>> +
>> +#include "irq-loongson.h"
>> +#include "irq-msi-lib.h"
>> +
>> +#define IRD_ENTRIES			65536
>> +
>> +/* redirect entry size 128bits */
>> +#define IRD_PAGE_ORDER			(20 - PAGE_SHIFT)
>> +
>> +/* irt cache invalid queue */
>> +#define	INVALID_QUEUE_SIZE		4096
> Use SPACE after #define, not TAB. All over the place...
OK, I got it
>
>> +#define INVALID_QUEUE_PAGE_ORDER	(16 - PAGE_SHIFT)
> I'm pretty sure that the above magic numbers have dependencies in some
> way, right? So why is it not expressed in a way which makes this obvious?
>
> These magic numbers are just incomprehensible as they make the reader
> guess what this is about. Here is my (probably not so) wild guess:
>
> #define IRD_ENTRY_SIZE			16
>
> #define IRD_ENTRIES			65536
> #define IRD_PAGE_ORDER			get_order(IRD_ENTRIES * IRD_ENTRY_SIZE)
>
> #define	INVALID_QUEUE_SIZE		4096
> #define IRD_INVALID__QUEUE_PAGE_ORDER	get_order(INVALID_QUEUE_SIZE * IRD_ENTRY_SIZE)
>
> No?
Yes, this is better way , and I will pay attention to improving the 
readability of the code in the future
>
> GENMASK()
Ok , I got it , thanks
>
>> +#define CFG_DISABLE_IDLE		2
>> +#define INVALID_INDEX			0
>> +
>> +#define MAX_IR_ENGINES			16
>
>> +struct redirect_gpid {
>> +	u64	pir[4];      /* Pending interrupt requested */
>> +	u8	en	: 1, /* doorbell */
> Use C++ style tail comments for this as documented. Do you I really have
> to point out every single item in the documentation explicitely or can
> you just read all of it and follow the guidelines?

Okay, here are some references to existing code....

I will reorganize all code style issues according to the documentation

>
>> +struct irde_desc {
>> +	struct	redirect_table	ird_table;
>> +	struct	redirect_queue	inv_queue;
>> +	int	finish;
> Groan.
>
> "Struct declarations should align the struct member names in a tabular fashion:
>
>   struct bar_order {
>          unsigned int    guest_id;
>          int             ordered_item;
>          struct menu     *menu;
>   };"
>
> It clearly says to align the struct member names, no?
>
> Otherwise the example would be:
>
>   struct bar_order {
>          unsigned int    guest_id;
>          int             ordered_item;
>          struct 		menu     	*menu;
>   };
>
> which is unreadable garbage obviously.
Ok, I will adjust here and check for other similar issues
>
>> +static void invalid_enqueue(struct redirect_queue *rqueue, struct irde_inv_cmd *cmd)
>> +{
>> +	struct irde_inv_cmd *inv_addr;
>> +	u32 tail;
>> +
>> +	guard(raw_spinlock_irqsave)(&rqueue->lock);
>> +
>> +	while (invalid_queue_is_full(rqueue->node, &tail))
>> +		cpu_relax();
>> +
>> +	inv_addr = (struct irde_inv_cmd *)(rqueue->base + tail * sizeof(struct irde_inv_cmd));
>> +	memcpy(inv_addr, cmd, sizeof(struct irde_inv_cmd));
> Seriously?
>
> struct redirect_queue {
> 	int				node;
>          union {
>   		u64			base;
>                  struct irde_inv_cmd	*cmds;
>          };
> 	u32				max_size;
>          ...
> };
>
> and then this becomes
>
>      	memcpy(&rqueue->cmds[tail], cmd, sizeof(cmd));
>
> That's too comprehensible, right?
Yes, this is a more readable writing style, thank you
>
>> +	tail = (tail + 1) % INVALID_QUEUE_SIZE;
> Why is this before the barrier? The barrier does not do anything about
> this and you can simplify this. See below.
>
> And as there is no rmb() counterpart you want to explain that this is
> serializing against the hardware.
>> +	 */
>> +	wmb();
>> +
>> +	write_queue_tail(rqueue->node, tail);
> 	write_queue_tail(rqueue->node, (tail + 1) & INVALID_QUEUE_MASK);
>
> No?

The reason fo coding here is that during testing, it was found that a 
barrier is needed between the

update of temporary variable 'tail' and the operation of register with 
'write_queue_tail'

, otherwise write_queue_tail will probabilistically fail to obtain the 
correct value.

We will conduct testing on the above methods, and if possible, make 
changes as required, or promote improvements in code readability

thanks

>
>> +}
>> +
>> +static void irde_invlid_entry_node(struct redirect_item *item)
>> +{
>> +	struct redirect_queue *rqueue;
>> +	struct irde_inv_cmd cmd;
>> +	volatile u64 raddr = 0;
> No. See Documentation/process/volatile-considered-harmful.rst
Ok, I will follow the agreement here
>
>> +static void redirect_table_free(struct redirect_item *item)
>> +{
>> +	struct redirect_table *ird_table;
>> +	struct redirect_entry *entry;
>> +
>> +	ird_table = item->table;
>> +
>> +	entry = item->entry;
>> +	memset(entry, 0, sizeof(struct redirect_entry));
>          memset(entry, 0, sizeof(entry));
>
> It's obvious why using sizeof(type) is a bad idea.
Ok, I got it
>
>> +	scoped_guard(raw_spinlock_irqsave, &ird_table->lock)
> raw_spinlock_irq as this code can never be invoked from an interrupt
> disabled region.
Ok, I will make the necessary corrections here
>
>> +		bitmap_release_region(ird_table->bitmap, item->index, 0);
>> +
>> +	kfree(item->gpid);
>> +
>> +	irde_invlid_entry_node(item);
>> +}
>> +static inline void redirect_domain_prepare_entry(struct redirect_item *item,
>> +						 struct avecintc_data *adata)
>> +{
>> +	struct redirect_entry *entry = item->entry;
>> +
>> +	item->gpid->en = 1;
>> +	item->gpid->irqnum = adata->vec;
>> +	item->gpid->dst = adata->cpu;
>> +
>> +	entry->lo.valid = 1;
>> +	entry->lo.gpid = ((long)item->gpid >> GPID_ADDR_SHIFT) & (GPID_ADDR_MASK);
> Hardware addresses are type unsigned long and not long.
Ok , I got it
>
>> +	entry->lo.vector = 0xff;
>> +}
>> +static void redirect_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
>> +{
>> +	struct redirect_item *item;
>> +
>> +	item = irq_data_get_irq_chip_data(d);
> Just move the initialization into the declaration line.
Ok, I got it
>
>> +		if (irq_data && irq_data->chip_data) {
>> +			struct redirect_item *item;
>> +
>> +			item = irq_data->chip_data;
> Same and all over the place.
>
>> +			redirect_table_free(item);
>> +			kfree(item);
>> +		}
>> +	}
>> +}
>> +
>> +static int redirect_domain_alloc(struct irq_domain *domain, unsigned int virq,
>> +			unsigned int nr_irqs, void *arg)
> I asked you before to align the arguments of the second line properly
> and according to documentation..

Sorry, I have reconfirmed the modification records and found that it was 
fixed in the first temporary version.

However, the modification was lost during several testing environment 
migrations in the middle.

I will adjust my code organization process

>
>> +{
>> +	struct redirect_table *ird_table;
>> +	struct avecintc_data *avec_data;
>> +	struct irq_data *irq_data;
>> +	msi_alloc_info_t *info;
>> +	int ret, i, node;
>> +
>> +	info = (msi_alloc_info_t *)arg;
> What's that type cast for?
emm......, An oversight during the code modification process
>
>> +	node = dev_to_node(info->desc->dev);
>> +	ird_table = &irde_descs[node].ird_table;
>> +
>> +	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	for (i = 0; i < nr_irqs; i++) {
>> +		struct redirect_item *item;
>> +
>> +		item = kzalloc(sizeof(struct redirect_item), GFP_KERNEL);
>> +		if (!item) {
>> +			pr_err("Alloc redirect descriptor failed\n");
>> +			goto out_free_resources;
>> +		}
>> +
>> +		irq_data = irq_domain_get_irq_data(domain, virq + i);
>> +
>> +		avec_data = irq_data_get_avec_data(irq_data);
> Neither irq_data nor avec_data are used here and only required way
> down. Can you structure your code so it makes sense?
Ok, I will follow your advice
>
>> +		ret = redirect_table_alloc(item, ird_table);
>> +		if (ret) {
>> +			pr_err("Alloc redirect table entry failed\n");
>> +			goto out_free_resources;
>> +		}
>> +
>> +		item->gpid = kzalloc_node(sizeof(struct redirect_gpid), GFP_KERNEL, node);
>> +		if (!item->gpid) {
>> +			pr_err("Alloc redirect GPID failed\n");
>> +			goto out_free_resources;
>> +		}
> Why do you need this extra allocation here instead of simply embedding
> gpid into item?
Ok, I got it , thanks
>> +		irq_data->chip_data = item;
>> +		irq_data->chip = &loongarch_redirect_chip;
>> +		redirect_domain_prepare_entry(item, avec_data);
>> +	}
>> +	return 0;
>> +	iocsr_write64(((rqueue->base & (CQB_ADDR_MASK << CQB_ADDR_SHIFT)) |
>> +				(CQB_SIZE_MASK << CQB_SIZE_SHIFT)), LOONGARCH_IOCSR_REDIRECT_CQB);
> Align second line properly.
Ok, I got it , thanks
>
>> +	return 0;
>> +}
>> +
>> +static int redirect_table_init(int node)
>> +{
>> +	struct redirect_table *ird_table = &(irde_descs[node].ird_table);
> Remove the pointless brackets.
Ok, I got it , thanks
>
>> +	unsigned long *bitmap;
>> +	struct page *pages;
>> +	int ret;
>> +
>> +	pages = alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO, IRD_PAGE_ORDER);
>> +	if (!pages) {
>> +		pr_err("Node [%d] redirect table alloc pages failed!\n", node);
>> +		return -ENOMEM;
>> +	}
>> +	ird_table->page = pages;
>> +	ird_table->table = page_address(pages);
>> +
>> +	bitmap = bitmap_zalloc(IRD_ENTRIES, GFP_KERNEL);
>> +	if (!bitmap) {
>> +		pr_err("Node [%d] redirect table bitmap alloc pages failed!\n", node);
>> +		ret = -ENOMEM;
>> +		goto free_pages;
>> +	}
>> +
>> +	ird_table->bitmap = bitmap;
>> +	ird_table->nr_ird = IRD_ENTRIES;
>> +	ird_table->node = node;
>> +
>> +	raw_spin_lock_init(&ird_table->lock);
>> +
>> +	if (redirect_queue_init(node)) {
>> +		ret = -EINVAL;
>> +		goto free_bitmap;
> So redirect_queue_init() returns -ENOMEM which is then converted to
> -EINVAL here. That makes absolutely no sense at all.
>
> Neither makes the 'ret' variable sense because all failures should
> return -ENOMEM and therefore you can make redirect_queue_init() return
> bool (true on success) and return -ENOMEM in the failure path.
>
> No?
Yes, it is a more reasonable way to do this
>> +static void redirect_table_fini(int node)
>> +{
>> +	struct redirect_table *ird_table = &(irde_descs[node].ird_table);
>> +	struct redirect_queue *rqueue = &(irde_descs[node].inv_queue);
> No brackets. They have no value and just disturb reading.
Ok, I got it , thanks
>
>> +static int redirect_cpu_online(unsigned int cpu)
>> +{
>> +	int ret, node = cpu_to_node(cpu);
>> +
>> +	if (cpu != cpumask_first(cpumask_of_node(node)))
>> +		return 0;
>> +
>> +	if (irde_descs[node].finish)
>> +		return 0;
> What's this finish thing about?
>
> Neither the CPU mask check nor this finish hack is required:
>
>          if (irde_descs[node].pages)
>          	return 0;
>
> covers all of it, no?
Ok, I got it , thanks
>
>> +	ret = redirect_table_init(node);
>> +	if (ret) {
>> +		redirect_table_fini(node);
> What is this for? You already mopped up the mess in the failure path of
> redirect_table_init(), so doing it again makes no sense.
>
> Just get rid of the failure path in redirect_table_init() and let that
> return a bool (true on success) and invoke redirect_table_fini() here
There may have been a logical confusion in the version iteration here, 
and I will reorganize this part of the code, thanks
>
>> +		return -EINVAL;
> Seriously? The failure condition is -ENOMEM so why do you want to change
> that?
Ok , return ret is enought there, thanks
>> +	}
>> +
>> +	irde_descs[node].finish = 1;
>> +	return 0;
>> +}
>> +
>> +#ifdef	CONFIG_ACPI
> What's the TAB for?
Ok. I got it , thanks
>> +int __init redirect_acpi_init(struct irq_domain *parent)
>> +{
>> +	struct fwnode_handle *fwnode;
>> +	struct irq_domain *domain;
>> +	int ret;
>> +
>> +	fwnode = irq_domain_alloc_named_fwnode("redirect");
>> +	if (!fwnode) {
>> +		pr_err("Unable to alloc redirect domain handle\n");
>> +		goto fail;
>> +	}
>> +
>> +	domain = irq_domain_create_hierarchy(parent, 0, IRD_ENTRIES, fwnode,
>> +					     &redirect_domain_ops, irde_descs);
>> +	if (!domain) {
>> +		pr_err("Unable to alloc redirect domain\n");
>> +		goto out_free_fwnode;
>> +	}
>> +
>> +	redirect_domain = domain;
> What's the point of this local domain variable?
This is indeed meaningless, thanks
>
>> +	ret = redirect_table_init(0);
>> +	if (ret)
>> +		goto out_free_table;
>> +
> Oh well...
There may have been a logical confusion in the version iteration here, 
and I will reorganize this part of the code, thanks
>
> Thanks,
>
>          tglx

Thanks

Tianyang


