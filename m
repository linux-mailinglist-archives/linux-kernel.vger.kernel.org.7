Return-Path: <linux-kernel+bounces-899449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 77923C57CB9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 42052356310
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FB51A9F93;
	Thu, 13 Nov 2025 13:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xL6KKFzu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5VDWruWo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D998E1A3165
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763041582; cv=none; b=Uvwoe9rS39sHPeWGiG1zcaiA2iHAveV1oiW7biVcI5Hp780VV/QhSEb/tJtIfVvJhA9JQ9680irnZcBvszl6EcFs1MPylb/fi1XUwUhQH2pLYAtWpLJHxsVq0Ql1CsTLOOduC8je6jkUI180FgLgZEwb6iTQDDDd8LBvJ6huhHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763041582; c=relaxed/simple;
	bh=3TWhjn28LUWOEOTNhxUySr1lC8fUnJuCV2LfMxtKYLo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GnZYGD1rgN44MVJDQ6O9kBBzQbvv6nQwo+UQfIhA5iPuWqky/7I+TAArD1eimEWrw44UdHUIrkecCB9j9imKWi5uWQhR8eRjP7x4eexG6r4Dwg0PYHlrvGaRsxokWrWdfn06NSTLFYQVfvZAsxXI5kXQp7qXBwSC1yYlxtCGWaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xL6KKFzu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5VDWruWo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763041579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BcELPkL6wDQwLgDXJox+08ranOjjapY/9/Uv/7w5s/8=;
	b=xL6KKFzumb8h2juG9e4yy/kbTuJ1eI5gW+Om/ZuV8uHyeGtWAjf1GvfkEMAGS6kNF3J8a/
	BhieBVbQREVcQ7sRN6DFc+XYzzrE8cA5bDKTlqcnynYGHebDub7UitIENx1j2QsNArxJZz
	9pH87Nzl/OJJoMqdThOgj1qxVJPQ5LovWa0igX5Ex/zCHEtGa0ZuYhLAVBZv6wye+WqBua
	BIJjqElAt10O2ApYqjw8zAcJEPYcHuUKps1urfgyJA3Fy9YbglOGOXG4VPkMg1sJv7DP/b
	tQK07zPAL2acHUzYJo4mqq3sJejUpd9BoQ2K21OiBOxZluzRQf6ie9dLQklo2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763041579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BcELPkL6wDQwLgDXJox+08ranOjjapY/9/Uv/7w5s/8=;
	b=5VDWruWoyFVxjyvMp4ssoP4LjuBxlZCRGS9rCq0lDMlTuAxkSkxzeGk+Xeib9WA1kGcQh/
	rUAkB4hKyBr8GyDg==
To: Tianyang Zhang <zhangtianyang@loongson.cn>, chenhuacai@kernel.org,
 kernel@xen0n.name, akpm@linux-foundation.org, willy@infradead.org,
 david@redhat.com, linmag7@gmail.com, thuth@redhat.com,
 maobibo@loongson.cn, apopple@nvidia.com
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, Tianyang Zhang
 <zhangtianyang@loongson.cn>, Liupu Wang <wangliupu@loongson.cn>
Subject: Re: [PATCH v6 2/2] irqchip/irq-loongarch-ir:Add Redirect irqchip
 support
In-Reply-To: <20251113034923.9699-3-zhangtianyang@loongson.cn>
References: <20251113034923.9699-1-zhangtianyang@loongson.cn>
 <20251113034923.9699-3-zhangtianyang@loongson.cn>
Date: Thu, 13 Nov 2025 14:46:17 +0100
Message-ID: <87ecq2cafq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Nov 13 2025 at 11:49, Tianyang Zhang wrote:
>  arch/loongarch/include/asm/cpu-features.h |   1 +
>  arch/loongarch/include/asm/cpu.h          |   2 +
>  arch/loongarch/include/asm/loongarch.h    |   6 +
>  arch/loongarch/kernel/cpu-probe.c         |   2 +

Can you please split the architecture parts out into a separate patch?

>  drivers/irqchip/Makefile                  |   2 +-
>  drivers/irqchip/irq-loongarch-avec.c      |  20 +-
>  drivers/irqchip/irq-loongarch-ir.c        | 527 ++++++++++++++++++++++
>  drivers/irqchip/irq-loongson.h            |  19 +
>  8 files changed, 565 insertions(+), 14 deletions(-)
>  create mode 100644 drivers/irqchip/irq-loongarch-ir.c
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 93e3ced023bb..a0be18891890 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -118,7 +118,7 @@ obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
>  obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
>  obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+= irq-ti-sci-inta.o
>  obj-$(CONFIG_TI_PRUSS_INTC)		+= irq-pruss-intc.o
> -obj-$(CONFIG_IRQ_LOONGARCH_CPU)		+= irq-loongarch-cpu.o irq-loongarch-avec.o
> +obj-$(CONFIG_IRQ_LOONGARCH_CPU)		+= irq-loongarch-cpu.o irq-loongarch-avec.o irq-loongarch-ir.o
>  obj-$(CONFIG_LOONGSON_LIOINTC)		+= irq-loongson-liointc.o
>  obj-$(CONFIG_LOONGSON_EIOINTC)		+= irq-loongson-eiointc.o
>  obj-$(CONFIG_LOONGSON_HTPIC)		+= irq-loongson-htpic.o
> diff --git a/drivers/irqchip/irq-loongarch-avec.c b/drivers/irqchip/irq-loongarch-avec.c
> index bf52dc8345f5..de7b6059c1b6 100644
> --- a/drivers/irqchip/irq-loongarch-avec.c
> +++ b/drivers/irqchip/irq-loongarch-avec.c
> @@ -24,7 +24,6 @@
>  #define VECTORS_PER_REG		64
>  #define IRR_VECTOR_MASK		0xffUL
>  #define IRR_INVALID_MASK	0x80000000UL
> -#define AVEC_MSG_OFFSET		0x100000
>  
>  #ifdef CONFIG_SMP
>  struct pending_list {
> @@ -47,15 +46,6 @@ struct avecintc_chip {
>  
>  static struct avecintc_chip loongarch_avec;
>  
> -struct avecintc_data {
> -	struct list_head	entry;
> -	unsigned int		cpu;
> -	unsigned int		vec;
> -	unsigned int		prev_cpu;
> -	unsigned int		prev_vec;
> -	unsigned int		moving;
> -};
> -
...
> -static void avecintc_sync(struct avecintc_data *adata)
> +void avecintc_sync(struct avecintc_data *adata)

Moving the struct to the header and exposing this function should be a
separate patch as well.


>  {
>  	struct pending_list *plist;
>  
> @@ -109,7 +99,7 @@ static int avecintc_set_affinity(struct irq_data *data, const struct cpumask *de
>  			return -EBUSY;
>  
>  		if (cpu_online(adata->cpu) && cpumask_test_cpu(adata->cpu, dest))
> -			return 0;
> +			return IRQ_SET_MASK_OK_DONE;

Changing that return value wants to be a separate patch with an
explanation why this is done and why it's functionaly equivalent.

> +#define IRD_ENTRY_SIZE			16

Shouldn't that be sizeof(struct redirect_entry) or if you want to keep
it this way then you want a compile time assert that ensures that
sizeof(struct redirect_entry) == IRD_ENTRY_SIZE.

> +struct irde_inv_cmd {

Same for this one.

> +#define REDIRECT_REG(reg, node) \
> +	((void __iomem *)(IO_BASE | redirect_reg_base | (u64)(node) << NODE_ADDRSPACE_SHIFT | (reg)))
> +

This only works when @node is guaranteed to be a real node number and
not NUMA_NO_NODE.

> +static inline void redirect_write_reg64(u32 node, u64 val, u32 reg)
> +{
> +	void __iomem *reg_addr = REDIRECT_REG(reg, node);
> +
> +	return writeq(val, reg_addr);
> +}
> +
> +static inline void redirect_write_reg32(int node, u32 val, u32 reg)

Can you make your mind up and use a consistent data type for @node?

> +static void irde_invalid_entry_node(struct redirect_item *item)
> +{
> +	struct irde_inv_cmd cmd;
> +	u64 raddr = 0;
> +
> +	cmd.cmd_info = 0;
> +	cmd.index.type = INVALID_INDEX;
> +	cmd.index.need_notice = 1;
> +	cmd.index.index = item->index;
> +	cmd.notice_addr = (u64)(__pa(&raddr));
> +
> +	invalid_enqueue(item, &cmd);
> +
> +	while (!raddr)

Please add a comment what this @raddr magic does.

> +		cpu_relax();
> +
> +}
> +
> +static inline struct avecintc_data *irq_data_get_avec_data(struct irq_data *data)
> +{
> +	return data->parent_data->chip_data;
> +}
> +
> +static int redirect_table_alloc(struct redirect_item *item)
> +{
> +	struct redirect_table *ird_table = &item->irde->ird_table;
> +	int index;
> +
> +	guard(raw_spinlock_irqsave)(&ird_table->lock);
> +
> +	index = find_first_zero_bit(ird_table->bitmap, IRD_ENTRIES);
> +	if (index > IRD_ENTRIES) {

Off by one. Valid index is 0 ... (IRD_ENTRIES - 1)

> +static void redirect_table_free(struct redirect_item *item)
> +{
> +	struct redirect_table *ird_table = &item->irde->ird_table;
> +	struct redirect_entry *entry = item_get_entry(item);
> +
> +	memset(entry, 0, sizeof(*entry));
> +
> +	scoped_guard(raw_spinlock_irq, &ird_table->lock)
> +		bitmap_release_region(ird_table->bitmap, item->index, 0);

That's silly. bitmap_release_region(..., order = 0) is equivalent to
clear_bit(...) no?

> +	kfree(item->gpid);

Is it correct to free this _before_ invalidating the entry?

> +	irde_invalid_entry_node(item);
> +}
> +
> +static inline void redirect_domain_prepare_entry(struct redirect_item *item,
> +						 struct avecintc_data *adata)
> +{
> +	struct redirect_entry *entry = item_get_entry(item);
> +
> +	item->gpid->en = 1;
> +	item->gpid->irqnum = adata->vec;
> +	item->gpid->dst = adata->cpu;
> +
> +	entry->lo.valid = 1;
> +	entry->lo.gpid = ((u64)item->gpid & GPID_ADDR_MASK) >> GPID_ADDR_SHIFT;
> +	entry->lo.vector = 0xff;
> +}
> +
> +static int redirect_set_affinity(struct irq_data *data, const struct cpumask *dest, bool force)
> +{
> +	struct redirect_item *item = data->chip_data;
> +	int ret;
> +
> +	ret = irq_chip_set_affinity_parent(data, dest, force);
> +	if (ret == IRQ_SET_MASK_OK_DONE) {
> +		return ret;
> +	} else if (ret) {
> +		pr_err("IRDE:set_affinity error %d\n", ret);
> +		return ret;
> +	} else {
> +		struct avecintc_data *adata = irq_data_get_avec_data(data);
> +
> +		redirect_domain_prepare_entry(item, adata);
> +		irde_invalid_entry_node(item);

Can you name that function irde_invalidate_entry() please? That's
actually telling what it does. irde_invalid_entry_node() is confusing at
best.

> +		avecintc_sync(adata);
> +	}
> +
> +	return IRQ_SET_MASK_OK;
> +}

> +static int redirect_domain_alloc(struct irq_domain *domain, unsigned int virq,
> +				 unsigned int nr_irqs, void *arg)
> +{
> +	msi_alloc_info_t *info = arg;
> +	int ret, i, node;
> +
> +	node = dev_to_node(info->desc->dev);
> +
> +	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
> +	if (ret < 0)
> +		return ret;
> +
> +	for (i = 0; i < nr_irqs; i++) {
> +		struct irq_data *irq_data = irq_domain_get_irq_data(domain, virq + i);
> +		struct redirect_item *item;
> +
> +		item = kzalloc(sizeof(*item), GFP_KERNEL);
> +		if (!item) {
> +			pr_err("Alloc redirect descriptor failed\n");
> +			goto out_free_resources;
> +		}
> +		item->irde = &irde_descs[node];
> +
> +		ret = redirect_table_alloc(item);
> +		if (ret) {
> +			pr_err("Alloc redirect table entry failed\n");
> +			goto out_free_resources;
> +		}
> +		/*
> +		 * Only bits 47:6 of the GPID are passed to the controller,
> +		 * 64-byte alignment must be guaranteed.
> +		 */
> +		BUILD_BUG_ON(sizeof(*item->gpid) != 64);

s/BUILD_BUG_ON()/static_assert()/

Also sizeof() does help to guarantee alignment. It only tells you the size.

> +		item->gpid = kzalloc_node(sizeof(*item->gpid), GFP_KERNEL, node);
> +		if (!item->gpid) {
> +			pr_err("Alloc redirect GPID failed\n");
> +			goto out_free_resources;
> +		}
> +
> +		irq_data->chip_data = item;
> +		irq_data->chip = &loongarch_redirect_chip;
> +
> +		redirect_domain_prepare_entry(item, irq_data_get_avec_data(irq_data));
> +	}
> +	return 0;
> +
> +out_free_resources:
> +	redirect_free_resources(domain, virq, nr_irqs);
> +	irq_domain_free_irqs_common(domain, virq, nr_irqs);
> +
> +	return -ENOMEM;
> +}

> +static int redirect_table_init(struct irde_desc *irde)
> +{
> +	struct redirect_table *ird_table = &irde->ird_table;
> +	struct folio *folio;
> +	unsigned long *bitmap;
> +	int node = irde->node;

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations

> +
> +	folio = __folio_alloc_node(GFP_KERNEL | __GFP_ZERO, IRD_TABLE_PAGE_ORDER, node);
> +	if (!folio) {
> +		pr_err("Node [%d] redirect table alloc pages failed!\n", node);
> +		goto fail;

No point in making this a goto. Just return -ENOMEM.

> +static int redirect_irde_init(int node)
> +{
> +	struct irde_desc *irde = &irde_descs[node];
> +	int ret;
> +
> +	irde->node = node;
> +
> +	ret = redirect_table_init(irde);
> +	if (ret)
> +		goto fail;

Same

> +	ret = redirect_queue_init(irde);
> +	if (ret)
> +		goto fail_clear;

Just get rid of the goto and handle the failure here.

> +	redirect_irde_cfg(irde);
> +
> +	return 0;
> +
> +fail_clear:
> +	__redirect_irde_fini(irde);
> +fail:
> +	return ret;
> +}

> +#ifdef CONFIG_ACPI
> static int __init pch_msi_parse_madt(union acpi_subtable_headers *header, const unsigned long end)

So if ACPI is disabled, the code in this file is dead code. Why do you
build it at all if ACPI is off?

> +int __init redirect_acpi_init(struct irq_domain *parent)
> +{
> +	struct fwnode_handle *fwnode;
> +	int ret = -EINVAL, node;
> +
> +	fwnode = irq_domain_alloc_named_fwnode("redirect");
> +	if (!fwnode) {
> +		pr_err("Unable to alloc redirect domain handle\n");
> +		goto fail;
> +	}
> +
> +	redirect_domain = irq_domain_create_hierarchy(parent, 0, IRD_ENTRIES, fwnode,
> +						      &redirect_domain_ops, irde_descs);
> +	if (!redirect_domain) {
> +		pr_err("Unable to alloc redirect domain\n");
> +		goto out_free_fwnode;
> +	}
> +
> +
> +	for_each_node_mask(node, node_possible_map) {
> +		ret = redirect_irde_init(node);
> +		if (ret)
> +			goto out_clear_irde;
> +	}
> +
> +	ret = acpi_cascade_irqdomain_init();
> +	if (ret < 0)
> +		pr_err("Failed to cascade IRQ domain, ret=%d\n", ret);
> +
> +	pr_info("loongarch irq redirect modules init succeeded\n");

If acpi_cascade_irqdomain_init() fails, then this prints first an error
and then claims that it succeeded and returns success. That doesn't make
any sense.

Thanks,

        tglx

