Return-Path: <linux-kernel+bounces-606362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AA8A8AE3A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 04:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB4DF1681DB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 02:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F313F1E1DEF;
	Wed, 16 Apr 2025 02:37:30 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA33165F16;
	Wed, 16 Apr 2025 02:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744771050; cv=none; b=EBNXFpnQs3SBcxo4jVtxd7psst8sirv8Q2/KNwmHZvM8/DXQa5hy3v2SAXbLT7h2YPqdKDM1G7563LivseQxLHB0eauwMfipCx4xZyFjQs5veRP4x0GwcZcyThxusI/3wGAT/p1be7F9j7h2yx2UbdzZuKG2nYF1A2woJ/Ek57c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744771050; c=relaxed/simple;
	bh=GJPc6rDaq9qmr80cAjmQqa54UWqVwKhMVrhP2kNVQpM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=W8wqeGvc5f0wZw1ys3Uyb6rhwryJ1fP1fnWGFS1/hDWn7BU/cpT9+LuzgsVfjUrF3dEsufRv0LA5/cpLOZYdGu10MjX1/nuxG31YKz92lCU3zSEPCv8Vyo/JAUE3F8cQ+c7CSy6t7mVB2cmOunU5ZmQ3LLi40YhTsEowf3uFaMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.24])
	by gateway (Coremail) with SMTP id _____8CxvOLjF_9n9hy_AA--.56319S3;
	Wed, 16 Apr 2025 10:37:23 +0800 (CST)
Received: from [10.20.42.24] (unknown [10.20.42.24])
	by front1 (Coremail) with SMTP id qMiowMBxHcXaF_9nAfiEAA--.63916S3;
	Wed, 16 Apr 2025 10:37:17 +0800 (CST)
Subject: Re: [PATCH v2 2/2] irq/irq-loongarch-ir:Add Redirect irqchip support
To: Yanteng Si <si.yanteng@linux.dev>, chenhuacai@kernel.org,
 kernel@xen0n.name, corbet@lwn.net, alexs@kernel.org, tglx@linutronix.de,
 jiaxun.yang@flygoat.com, peterz@infradead.org, wangliupu@loongson.cn,
 lvjianmin@loongson.cn, maobibo@loongson.cn, siyanteng@cqsoftware.com.cn,
 gaosong@loongson.cn, yangtiezhu@loongson.cn
Cc: loongarch@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250331064116.32540-1-zhangtianyang@loongson.cn>
 <20250331064116.32540-3-zhangtianyang@loongson.cn>
 <6863ae24-10de-4d50-9175-ab5012f204ed@linux.dev>
From: Tianyang Zhang <zhangtianyang@loongson.cn>
Message-ID: <ebfc0d43-df69-5afc-bff1-5bb6d5f7f6ab@loongson.cn>
Date: Wed, 16 Apr 2025 10:36:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6863ae24-10de-4d50-9175-ab5012f204ed@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMBxHcXaF_9nAfiEAA--.63916S3
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3WF1rtFWDWw4xJFy3Xr1UJwc_yoWfZrW5pF
	4kJFWUXrWrJr1rWr1UGr4UZFyayr18Ja1DJr18X3WUJrsFkr10gF1UWryq9F1rAr4rJr1U
	Ar4jqrZrurnrJrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUD529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
	I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jr9NsUUUUU=

Hi, Yanteng

在 2025/4/1 上午10:15, Yanteng Si 写道:
>
> 在 3/31/25 2:41 PM, Tianyang Zhang 写道:
>> The main function of the Redirected interrupt controller is to manage 
>> the
>> redirected-interrupt table, which consists of many redirected entries.
>> When MSI interrupts are requested, the driver creates a corresponding
>> redirected entry that describes the target CPU/vector number and the
>> operating mode of the interrupt. The redirected interrupt module has an
>> independent cache, and during the interrupt routing process, it will
>> prioritize the redirected entries that hit the cache. The driver
>> invalidates certain entry caches via a command queue.
>>
>> Co-developed-by: Liupu Wang <wangliupu@loongson.cn>
>> Signed-off-by: Liupu Wang <wangliupu@loongson.cn>
>> Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/cpu-features.h |   1 +
>>   arch/loongarch/include/asm/cpu.h          |   2 +
>>   arch/loongarch/include/asm/loongarch.h    |   6 +
>>   arch/loongarch/kernel/cpu-probe.c         |   2 +
>>   drivers/irqchip/Makefile                  |   2 +-
>>   drivers/irqchip/irq-loongarch-avec.c      |  21 +-
>>   drivers/irqchip/irq-loongarch-ir.c        | 561 ++++++++++++++++++++++
>>   drivers/irqchip/irq-loongson.h            |  12 +
>>   include/linux/cpuhotplug.h                |   1 +
>>   9 files changed, 594 insertions(+), 14 deletions(-)
>>   create mode 100644 drivers/irqchip/irq-loongarch-ir.c
>>
>>
>> +static void invalid_enqueue(struct redirect_queue *rqueue, struct 
>> irde_inv_cmd *cmd)
>> +{
>> +    struct irde_inv_cmd *inv_addr;
>> +    u32 tail;
>> +
>> +    guard(raw_spinlock_irqsave)(&rqueue->lock);
>> +
>> +    while (invalid_queue_is_full(rqueue->node, &tail))
>> +        cpu_relax();
>> +
>> +    inv_addr = (struct irde_inv_cmd *)(rqueue->base + tail * 
>> sizeof(struct irde_inv_cmd));
>> +    memcpy(inv_addr, cmd, sizeof(struct irde_inv_cmd));
>> +    tail = (tail + 1) % INVALID_QUEUE_SIZE;
>> +
>
>> +    wmb();
>
> Add some comments?  In kernel docs:
>
>
> 22) 所有内存屏障（例如 ``barrier()``, ``rmb()``, ``wmb()`` 
> ）都需要源代码注
>     释来解释它们正在执行的操作及其原因的逻辑。
Ok, I got it ,thansk
>> +
>> +    iocsr_write32(tail, LOONGARCH_IOCSR_REDIRECT_CQT);
>> +}
>> +
>> +static void smp_call_invalid_enqueue(void *arg)
>> +{
>> +    struct smp_invalid_arg *s_arg = (struct smp_invalid_arg *)arg;
>> +
>> +    invalid_enqueue(s_arg->queue, s_arg->cmd);
>> +}
>> +
>> +static void irde_invlid_entry_node(struct redirect_item *item)
>> +{
>> +    struct redirect_queue *rqueue;
>> +    struct smp_invalid_arg arg;
>> +    struct irde_inv_cmd cmd;
>> +    volatile u64 raddr = 0;
>> +    int node = item->table->node, cpu;
>> +
>> +    rqueue = &(irde_descs[node].inv_queue);
>> +    cmd.cmd_info = 0;
>> +    cmd.index.type = INVALID_INDEX;
>> +    cmd.index.need_notice = 1;
>> +    cmd.index.index = item->index;
>> +    cmd.notice_addr = (u64)(__pa(&raddr));
>> +
>> +    if (cpu_to_node(smp_processor_id()) == node)
>> +        invalid_enqueue(rqueue, &cmd);
>> +    else {
>> +        for_each_cpu(cpu, cpumask_of_node(node)) {
>> +            if (cpu_online(cpu))
>> +                break;
>> +        }
>> +        arg.queue = rqueue;
>> +        arg.cmd = &cmd;
>> +        smp_call_function_single(cpu, smp_call_invalid_enqueue, 
>> &arg, 0);
>> +    }
>> +
>> +    while (!raddr)
>> +        cpu_relax();
>> +
>> +}
>> +
>> +static inline struct avecintc_data *irq_data_get_avec_data(struct 
>> irq_data *data)
>> +{
>> +    return data->parent_data->chip_data;
>> +}
>> +
>> +static int redirect_table_alloc(struct redirect_item *item, struct 
>> redirect_table *ird_table)
>> +{
>> +    int index;
>> +
>> +    guard(raw_spinlock_irqsave)(&ird_table->lock);
>> +
>> +    index = find_first_zero_bit(ird_table->bitmap, IRD_ENTRIES);
>> +    if (index > IRD_ENTRIES) {
>> +        pr_err("No redirect entry to use\n");
>> +        return -ENOMEM;
>> +    }
>> +
>> +    __set_bit(index, ird_table->bitmap);
>> +
>> +    item->index = index;
>> +    item->entry = &ird_table->table[index];
>> +    item->table = ird_table;
>> +
>> +    return 0;
>> +}
>> +
>> +static int redirect_table_free(struct redirect_item *item)
>> +{
>> +    struct redirect_table *ird_table;
>> +    struct redirect_entry *entry;
>> +    unsigned long flags;
>> +
>> +    ird_table = item->table;
>> +
>> +    entry = item->entry;
>> +    memset(entry, 0, sizeof(struct redirect_entry));
>> +
>> +    raw_spin_lock_irqsave(&ird_table->lock, flags);
>> +    bitmap_release_region(ird_table->bitmap, item->index, 0);
>> +    raw_spin_unlock_irqrestore(&ird_table->lock, flags);
>> +
>> +    kfree(item->gpid);
>> +
>> +    irde_invlid_entry_node(item);
>> +
>> +    return 0;
>> +}
>> +
>> +static inline void redirect_domain_prepare_entry(struct 
>> redirect_item *item, struct avecintc_data *adata)
>> +{
>> +    struct redirect_entry *entry = item->entry;
>> +
>> +    item->gpid->en = 1;
>> +    item->gpid->irqnum = adata->vec;
>> +    item->gpid->dst = adata->cpu;
>> +
>> +    entry->lo.valid = 1;
>> +    entry->lo.gpid = ((long)item->gpid >> GPID_ADDR_SHIFT) & 
>> (GPID_ADDR_MASK);
>> +    entry->lo.vector = 0xff;
>> +    wmb();
>> +}
>> +
>> +static int redirect_set_affinity(struct irq_data *data, const struct 
>> cpumask *dest, bool force)
>> +{
>> +    struct redirect_item *item = data->chip_data;
>> +    struct avecintc_data *adata;
>> +    int ret;
>> +
>> +    ret = irq_chip_set_affinity_parent(data, dest, force);
>> +    if (ret == IRQ_SET_MASK_OK_DONE)
>> +        return IRQ_SET_MASK_OK;
>> +    else if (ret) {
>> +        pr_err("IRDE:set_affinity error %d\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    adata = irq_data_get_avec_data(data);
>> +
>> +    redirect_domain_prepare_entry(item, adata);
>> +
>> +    irde_invlid_entry_node(item);
>> +
>> +    avecintc_sync(adata);
>> +    return IRQ_SET_MASK_OK;
>> +}
>> +
>> +static void redirect_compose_msi_msg(struct irq_data *d, struct 
>> msi_msg *msg)
>> +{
>> +    struct redirect_item *item;
>> +
>> +    item = irq_data_get_irq_chip_data(d);
>> +    msg->address_lo = (msi_base_addr | 1 << 2 | ((item->index & 
>> 0xffff) << 4));
>> +    msg->address_hi = 0x0;
>> +    msg->data = 0x0;
>> +}
>> +
>> +static inline void redirect_ack_irq(struct irq_data *d)
>> +{
>> +}
>> +
>> +static inline void redirect_unmask_irq(struct irq_data *d)
>> +{
>> +}
>> +
>> +static inline void redirect_mask_irq(struct irq_data *d)
>> +{
>> +}
>> +
>> +static struct irq_chip loongarch_redirect_chip = {
>> +    .name            = "REDIRECT",
>> +    .irq_ack        = redirect_ack_irq,
>> +    .irq_mask        = redirect_mask_irq,
>> +    .irq_unmask        = redirect_unmask_irq,
>> +    .irq_set_affinity    = redirect_set_affinity,
>> +    .irq_compose_msi_msg    = redirect_compose_msi_msg,
>> +};
>> +
>> +static void redirect_free_resources(struct irq_domain *domain,
>> +                        unsigned int virq, unsigned int nr_irqs)
>> +{
>> +    struct irq_data *irq_data;
>> +    struct redirect_item *item;
>> +
>> +    for (int i = 0; i < nr_irqs; i++) {
>> +        irq_data = irq_domain_get_irq_data(domain, virq  + i);
>> +        if (irq_data && irq_data->chip_data) {
>> +            item = irq_data->chip_data;
>> +            redirect_table_free(item);
>> +            kfree(item);
>> +        }
>> +    }
>> +}
>> +
>
>> +static int redirect_alloc(struct irq_domain *domain,
>> +                    unsigned int virq, unsigned int nr_irqs,
>> +                     void *arg)
>
> The line break handling here is not good. Two lines would be
>
> sufficient. Your code style is extremely terrible, and it seems
>
> that you haven't passed the checkpatch.pl test yet.
>
>
> https://docs.kernel.org/translations/zh_CN/process/coding-style.html
>
>
> Maybe it would be a good idea to read the kernel
>
> documentation before preparing for v3.
Well, according to the documentation, this is indeed inappropriate. I'll 
take your advice.
>
>
> Thanks,
>
> Yanteng

Thanks,

Tianyang


