Return-Path: <linux-kernel+bounces-626503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FE9AA43ED
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 09:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E4FA7A56D8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 07:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D00204F9B;
	Wed, 30 Apr 2025 07:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQ5nKMuw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F77E1E32D7;
	Wed, 30 Apr 2025 07:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745998093; cv=none; b=Y8cVIZKwc/SjrJTerYJyBOCIQ5q/d1Xh9KeG1/Iw35lqaBQ97hO2eG6edKU+6ozEFXaBxQoLiOxsqngT++RVaNG54+vNRqPdIkWUEO1HdDbW9JR4zOqtqWf+wBwsugloKL/J6z8Qbj7I/bOysqkBtJgkDk+F8wXQOzAZK09BUnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745998093; c=relaxed/simple;
	bh=WDHiPMrNDsXHgzKxar3EuOQub7OP819jmgai+caaIm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IJVa7gJYiDTkbiwxKTax8ygvRksy3s1+va8L4EjYy8L0FBzkUIsyoaDRy1gLapHCUyHxp+OZCQTs0HNkGVpsH40GCKd5PQeYNl25TNDax0rKmm77oLpc7ZEf+f5OYj6SaZFbxg87Q9UOS81P/y4gq74jBgq5g57bz0F06BDCg7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQ5nKMuw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07D8C4CEEA;
	Wed, 30 Apr 2025 07:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745998093;
	bh=WDHiPMrNDsXHgzKxar3EuOQub7OP819jmgai+caaIm8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jQ5nKMuw984Mn2Ylj/pIQMmoqnGNYFKNjzkn15y2jcAkqT//y31uHTUSw44pM7DIu
	 GTMoWqk9bgZvN000q8smVSRjpn9seLt6/0B4Mr1YkaL8zNGKryW2t+FSKuo1E4J67k
	 ++Foz5P/7+xN9Ydvu5SvQ8YUdDldHjLy04FUKf2kAraORxVWydS0MfjnZ2+5V3aIsw
	 dXvX5OEeC3yRt5OL0orbQ/jF7ASyAvGqP64N4CMEKyvBjUzbG6crMQgZGFCuGZQs5a
	 myxC4uS5Yro9Se2E1uHPlXg1JZMGDSLyT7oEKEepC4WiK8U3v4hKQXa1c7jZPmX26L
	 Ym/pvPRI26QrQ==
Message-ID: <4f9f1dab-118e-4d5e-acf2-33da5e0a4905@kernel.org>
Date: Wed, 30 Apr 2025 09:28:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/22] irqchip/gic-v5: Add GICv5 ITS support
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Sascha Bischoff <sascha.bischoff@arm.com>,
 Timothy Hayes <timothy.hayes@arm.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250424-gicv5-host-v2-0-545edcaf012b@kernel.org>
 <20250424-gicv5-host-v2-20-545edcaf012b@kernel.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250424-gicv5-host-v2-20-545edcaf012b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24. 04. 25, 12:25, Lorenzo Pieralisi wrote:
> --- /dev/null
> +++ b/drivers/irqchip/irq-gic-v5-its.c
> @@ -0,0 +1,1293 @@
...
> +static u32 its_readl_relaxed(struct gicv5_its_chip_data *its_node,
> +			     const u64 reg_offset)

I wonder -- can the offset be u64 at all?

> +{
> +	return readl_relaxed(its_node->its_base + reg_offset);
> +}
> +
> +static void its_writel_relaxed(struct gicv5_its_chip_data *its_node,
> +			       const u32 val, const u64 reg_offset)
> +{
> +	writel_relaxed(val, its_node->its_base + reg_offset);
> +}
> +
> +static void its_writeq_relaxed(struct gicv5_its_chip_data *its_node,
> +			       const u64 val, const u64 reg_offset)
> +{
> +	writeq_relaxed(val, its_node->its_base + reg_offset);
> +}
> +
> +static void its_write_table_entry(struct gicv5_its_chip_data *its,
> +				  __le64 *entry, u64 val)
> +{
> +	WRITE_ONCE(*entry, val);

This triggers a warning with the le/be checker enabled, right? You 
likely need cpu_to_le64() or __force.

> +	if (its->flags & ITS_FLAGS_NON_COHERENT)
> +		dcache_clean_inval_poc((unsigned long)entry,
> +				       (unsigned long)entry + sizeof(*entry));
> +	else
> +		dsb(ishst);
> +}
> +
> +#define gicv5_its_wait_for_op(base, reg, mask)				\

What's the purpose of this not being an inline?

> +	({								\
> +		int ret;						\
> +									\
> +		ret = gicv5_wait_for_op(base, reg, mask, NULL);		\
> +		if (unlikely(ret == -ETIMEDOUT))			\
> +			pr_err_ratelimited(#reg" timeout...\n");	\

Ah, this. Is it worth it? At least you should not clobber variables like 
"ret". Also grepping sources for "GICV5_ITS_STATUSR timeout..." would be 
clueless anyway. Yeah, at least there would be a driver prefix.

> +		ret;							\
> +	 })
...
> +static int gicv5_its_device_get_itte_ref(struct gicv5_its_dev *its_dev,
> +					 __le64 **itte, u16 event_id)
> +{
> +	if (!its_dev->itt_cfg.l2itt) {
> +		__le64 *itt = its_dev->itt_cfg.linear.itt;
> +		*itte = &itt[event_id];

Can you return 0 here and dedent the whole } else { block?

> +	} else {
> +		__le64 *l2_itt, *l1_itt = its_dev->itt_cfg.l2.l1itt;
> +		unsigned int l1_idx, l2_idx, l2_size, l2_bits;
> +		int ret;
> +
> +		ret = gicv5_its_l2sz_to_l2_bits(its_dev->itt_cfg.l2.l2sz);
> +		if (ret < 0)
> +			return ret;
> +		l2_bits = ret;
> +
> +		l1_idx = event_id >> l2_bits;
> +
> +		if (!FIELD_GET(GICV5_ITTL1E_VALID,
> +			       le64_to_cpu(l1_itt[l1_idx]))) {
> +			pr_debug("L1 ITT entry is not valid.\n");
> +			return -EINVAL;
> +		}
> +
> +		l2_idx = event_id & GENMASK(l2_bits - 1, 0);
> +
> +		l2_size = BIT(FIELD_GET(GICV5_ITTL1E_SPAN,
> +					le64_to_cpu(l1_itt[l1_idx])));
> +
> +		// Sanity check our indexing
> +		if (l2_idx >= l2_size) {
> +			pr_debug("L2 ITT index (%u) exceeds L2 table size (%u)!\n",
> +			       l2_idx, l2_size);
> +			return -EINVAL;
> +		}
> +		l2_itt = its_dev->itt_cfg.l2.l2ptrs[l1_idx];
> +		*itte = &l2_itt[l2_idx];
> +	}
> +
> +	return 0;
> +}

...
> +static struct gicv5_its_dev *gicv5_its_alloc_device(
> +				struct gicv5_its_chip_data *its, int nvec,
> +				u32 dev_id)
> +{
> +	struct gicv5_its_dev *its_dev;
> +	int ret;
> +
> +	its_dev = gicv5_its_find_device(its, dev_id);
> +	if (!IS_ERR(its_dev)) {
> +		pr_debug("A device with this DeviceID (0x%x) has already been registered.\n",
> +			 dev_id);
> +
> +		if (nvec > its_dev->num_events) {
> +			pr_debug("Requesting more ITT entries than allocated\n");

Why only _debug()?

> +			return ERR_PTR(-ENXIO);
> +		}
> +
> +		its_dev->shared = true;
> +
> +		return its_dev;
> +	}
> +
> +	its_dev = kzalloc(sizeof(*its_dev), GFP_KERNEL);
> +	if (!its_dev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	its_dev->device_id = dev_id;
> +	its_dev->num_events = nvec;
> +	its_dev->num_mapped_events = 0;
> +
> +	ret = gicv5_its_device_register(its, its_dev);
> +	if (ret) {
> +		pr_debug("Failed to register the device\n");

And here.

> +		kfree(its_dev);

Can you use __free() and return_ptr() instead?

> +		return ERR_PTR(ret);
> +	}
> +
> +	gicv5_its_device_cache_inv(its, its_dev);
> +
> +	/*
> +	 * This is the first time we have seen this device. Hence, it is not
> +	 * shared.
> +	 */
> +	its_dev->shared = false;
> +
> +	its_dev->its_node = its;
> +
> +	its_dev->event_map =
> +		(unsigned long *)bitmap_zalloc(its_dev->num_events, GFP_KERNEL);
> +	if (!its_dev->event_map) {
> +		gicv5_its_device_unregister(its, its_dev);
> +		kfree(its_dev);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	xa_store(&its->its_devices, dev_id, its_dev, GFP_KERNEL);

This can fail.

> +
> +	return its_dev;
> +}

...
> +static int gicv5_its_alloc_event(struct gicv5_its_dev *its_dev, u16 event_id,
> +				 u32 lpi)
> +{
> +	struct gicv5_its_chip_data *its = its_dev->its_node;
> +	u64 itt_entry;
> +	__le64 *itte;
> +	int ret;
> +
> +	if (event_id >= its_dev->num_events) {
> +		pr_debug("EventID 0x%x outside of ITT range (0x%x)\n", event_id,
> +		       its_dev->num_events);

Again, is this so often to be _debug()?

> +		return -EINVAL;
> +	}
> +
> +	if (WARN(its_dev->num_mapped_events == its_dev->num_events,
> +		"Reached maximum number of events\n"))

Weird indent level.

> +		return -EINVAL;
> +
> +	ret = gicv5_its_device_get_itte_ref(its_dev, &itte, event_id);
> +	if (ret)
> +		return ret;
> +
> +	if (FIELD_GET(GICV5_ITTL2E_VALID, *itte))
> +		return -EEXIST;
> +
> +	itt_entry = FIELD_PREP(GICV5_ITTL2E_LPI_ID, lpi) |
> +		    FIELD_PREP(GICV5_ITTL2E_VALID, 0x1);
> +
> +	its_write_table_entry(its, itte, cpu_to_le64(itt_entry));
> +
> +	gicv5_its_itt_cache_inv(its, its_dev->device_id, event_id);
> +
> +	its_dev->num_mapped_events += 1;

This is not python, we have ++ :).

> +
> +	return 0;
> +}
> +
> +static void gicv5_its_free_event(struct gicv5_its_dev *its_dev, u16 event_id)
> +{
> +	struct gicv5_its_chip_data *its = its_dev->its_node;
> +	u64 itte_val;
> +	__le64 *itte;
> +	int ret;
> +
> +	if (WARN(!its_dev->num_mapped_events, "No mapped events\n"))
> +		return;
> +
> +	ret = gicv5_its_device_get_itte_ref(its_dev, &itte, event_id);
> +	if (ret) {
> +		pr_debug("Failed to get the ITTE!\n");
> +		return;
> +	}
> +
> +	itte_val = le64_to_cpu(*itte);
> +	itte_val &= ~GICV5_ITTL2E_VALID;
> +
> +	its_write_table_entry(its, itte, cpu_to_le64(itte_val));
> +
> +	gicv5_its_itt_cache_inv(its, its_dev->device_id, event_id);
> +
> +	its_dev->num_mapped_events -= 1;

And --.

> +}
> +
> +static int gicv5_its_alloc_eventid(struct gicv5_its_dev *its_dev,
> +				   unsigned int nr_irqs, u32 *eventid)
> +{
> +	int ret;
> +
> +	ret = bitmap_find_free_region(its_dev->event_map,
> +				      its_dev->num_events,
> +				      get_count_order(nr_irqs));
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	*eventid = ret;
> +
> +	return 0;
> +}
...
> +static int gicv5_its_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> +				      unsigned int nr_irqs, void *arg)
> +{
> +	u32 device_id, event_id_base, lpi;
> +	struct msi_domain_info *msi_info;
> +	struct gicv5_its_chip_data *its;
> +	struct gicv5_its_dev *its_dev;
> +	msi_alloc_info_t *info = arg;
> +	irq_hw_number_t hwirq;
> +	struct irq_data *irqd;
> +	int ret, i;

Why is i not unsigned too?

> +
> +	device_id = info->scratchpad[0].ul;
> +
> +	msi_info = msi_get_domain_info(domain);
> +	its = msi_info->data;
> +
> +	mutex_lock(&its->dev_alloc_lock);
> +
> +	its_dev = gicv5_its_find_device(its, device_id);
> +	if (IS_ERR(its_dev)) {
> +		mutex_unlock(&its->dev_alloc_lock);

scope_guard() would make much sense here.

> +		return PTR_ERR(its_dev);
> +	}
> +
> +	ret = gicv5_its_alloc_eventid(its_dev, nr_irqs, &event_id_base);
> +	if (ret) {
> +		mutex_unlock(&its->dev_alloc_lock);
> +		return ret;
> +	}
> +
> +	mutex_unlock(&its->dev_alloc_lock);
> +
> +	ret = iommu_dma_prepare_msi(info->desc, its->its_trans_phys_base);
> +	if (ret)
> +		goto out_eventid;
> +
> +	for (i = 0; i < nr_irqs; i++) {
> +		lpi = gicv5_alloc_lpi();
> +		if (ret < 0) {
> +			pr_debug("Failed to find free LPI!\n");
> +			goto out_eventid;
> +		}
> +
> +		ret = irq_domain_alloc_irqs_parent(domain, virq + i, 1, &lpi);
> +		if (ret)
> +			goto out_free_lpi;
> +
> +		/*
> +		 * Store eventid and deviceid into the hwirq for later use.
> +		 *
> +		 *	hwirq  = event_id << 32 | device_id
> +		 */
> +		hwirq = FIELD_PREP(GICV5_ITS_HWIRQ_DEVICE_ID, device_id) |
> +			FIELD_PREP(GICV5_ITS_HWIRQ_EVENT_ID, (u64)event_id_base + i);
> +		irq_domain_set_info(domain, virq + i, hwirq,
> +				    &gicv5_its_irq_chip, its_dev,
> +				    handle_fasteoi_irq, NULL, NULL);
> +
> +		irqd = irq_get_irq_data(virq + i);
> +		irqd_set_single_target(irqd);
> +		irqd_set_affinity_on_activate(irqd);
> +		irqd_set_resend_when_in_progress(irqd);
> +	}
> +
> +	return 0;
> +out_free_lpi:
> +	gicv5_free_lpi(lpi);
> +out_eventid:
> +	gicv5_its_free_eventid(its_dev, event_id_base, nr_irqs);
> +
> +	return ret;
> +}
> +
> +static void gicv5_its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
> +				      unsigned int nr_irqs)
> +{
> +	struct msi_domain_info *msi_info;
> +	struct gicv5_its_chip_data *its;
> +	struct gicv5_its_dev *its_dev;
> +	struct irq_data *d;
> +	u16 event_id_base;
> +	bool free_device;
> +	u32 device_id;
> +	int i;
> +
> +	msi_info = msi_get_domain_info(domain);
> +	its = msi_info->data;
> +
> +	d = irq_domain_get_irq_data(domain, virq);
> +	device_id = FIELD_GET(GICV5_ITS_HWIRQ_DEVICE_ID, d->hwirq);
> +	event_id_base = FIELD_GET(GICV5_ITS_HWIRQ_EVENT_ID, d->hwirq);
> +
> +	guard(mutex)(&its->dev_alloc_lock);
> +
> +	its_dev = gicv5_its_find_device(its, device_id);
> +	if (IS_ERR(its_dev)) {
> +		pr_debug("Couldn't find the ITS device!\n");

This is serious, not debug, IMO. Either we leak memory or even allow out 
of bounds accesses somewhere.

> +		return;
> +	}
> +
> +	bitmap_release_region(its_dev->event_map, event_id_base,
> +			      get_count_order(nr_irqs));
> +
> +	free_device = !its_dev->shared && bitmap_empty(its_dev->event_map,
> +						       its_dev->num_events);
> +
> +	/*  Hierarchically free irq data */
> +	for (i = 0; i < nr_irqs; i++) {
> +		d = irq_domain_get_irq_data(domain, virq + i);
> +
> +		gicv5_free_lpi(d->parent_data->hwirq);
> +		irq_domain_reset_irq_data(d);
> +	}
> +	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
> +
> +	gicv5_its_syncr(its, its_dev);
> +	gicv5_irs_syncr();
> +
> +	if (free_device) {
> +		gicv5_its_device_unregister(its, its_dev);
> +		bitmap_free(its_dev->event_map);
> +		xa_erase(&its->its_devices, device_id);
> +		kfree(its_dev);
> +	}
> +}

...
> +static int __init gicv5_its_init_bases(phys_addr_t its_trans_base,
> +				       void __iomem *its_base,
> +				       struct fwnode_handle *handle,
> +				       struct irq_domain *parent_domain)
> +{
> +	struct device_node *np = to_of_node(handle);
> +	struct gicv5_its_chip_data *its_node;
> +	struct msi_domain_info *info;
> +	struct irq_domain *d;
> +	u32 cr0, cr1;
> +	bool enabled;
> +	int ret;
> +
> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	its_node = kzalloc(sizeof(*its_node), GFP_KERNEL);
> +	if (!its_node) {
> +		kfree(info);
> +		return -ENOMEM;
> +	}
> +
> +	info->ops = &its_msi_domain_ops;
> +	info->data = its_node;
> +
> +	mutex_init(&its_node->dev_alloc_lock);
> +	xa_init(&its_node->its_devices);
> +	its_node->fwnode = handle;
> +	its_node->its_base = its_base;
> +	its_node->its_trans_phys_base = its_trans_base;
> +
> +	d = irq_domain_create_hierarchy(parent_domain, IRQ_DOMAIN_FLAG_ISOLATED_MSI,
> +					0, handle, &gicv5_its_irq_domain_ops, info);
> +	its_node->domain = d;
> +	irq_domain_update_bus_token(its_node->domain, DOMAIN_BUS_NEXUS);
> +
> +	its_node->domain->msi_parent_ops = &gic_its_msi_parent_ops;
> +	its_node->domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
> +
> +	cr0 = its_readl_relaxed(its_node, GICV5_ITS_CR0);
> +	enabled = FIELD_GET(GICV5_ITS_CR0_ITSEN, cr0);
> +	if (WARN(enabled, "ITS %s enabled, disabling it before proceeding\n",
> +		 np->full_name)) {
> +		cr0 = FIELD_PREP(GICV5_ITS_CR0_ITSEN, 0x0);
> +		its_writel_relaxed(its_node, cr0, GICV5_ITS_CR0);
> +		ret = gicv5_its_wait_for_cr0(its_node);
> +		if (ret) {
> +			irq_domain_remove(its_node->domain);
> +			kfree(info);
> +			kfree(its_node);
> +			return ret;
> +		}
> +	}
> +
> +	if (of_property_read_bool(np, "dma-noncoherent")) {
> +		/*
> +		 * A non-coherent ITS implies that some cache levels cannot be
> +		 * used coherently by the cores and GIC. Our only option is to mark
> +		 * memory attributes for the GIC as non-cacheable; by default,
> +		 * non-cacheable memory attributes imply outer-shareable
> +		 * shareability, the value written into ITS_CR1_SH is ignored.
> +		 */
> +		cr1 = FIELD_PREP(GICV5_ITS_CR1_ITT_RA, GICV5_NO_READ_ALLOC)	|
> +		      FIELD_PREP(GICV5_ITS_CR1_DT_RA, GICV5_NO_READ_ALLOC)	|
> +		      FIELD_PREP(GICV5_ITS_CR1_IC, GICV5_NON_CACHE)		|
> +		      FIELD_PREP(GICV5_ITS_CR1_OC, GICV5_NON_CACHE);
> +		its_node->flags |= ITS_FLAGS_NON_COHERENT;
> +	} else {
> +		cr1 = FIELD_PREP(GICV5_ITS_CR1_ITT_RA, GICV5_READ_ALLOC)	|
> +		      FIELD_PREP(GICV5_ITS_CR1_DT_RA, GICV5_READ_ALLOC)		|
> +		      FIELD_PREP(GICV5_ITS_CR1_IC, GICV5_WB_CACHE)		|
> +		      FIELD_PREP(GICV5_ITS_CR1_OC, GICV5_WB_CACHE)		|
> +		      FIELD_PREP(GICV5_ITS_CR1_SH, GICV5_INNER_SHARE);
> +	}
> +
> +	its_writel_relaxed(its_node, cr1, GICV5_ITS_CR1);
> +
> +	ret = gicv5_its_init_devtab(its_node);
> +	if (ret) {
> +		irq_domain_remove(its_node->domain);
> +		kfree(info);
> +		kfree(its_node);
> +		return ret;
> +	}
> +
> +	cr0 = FIELD_PREP(GICV5_ITS_CR0_ITSEN, 0x1);
> +	its_writel_relaxed(its_node, cr0, GICV5_ITS_CR0);
> +
> +	ret = gicv5_its_wait_for_cr0(its_node);
> +	if (ret) {
> +		irq_domain_remove(its_node->domain);
> +		kfree(info);
> +		kfree(its_node);

Either convert to cleanup.h or do this in a common error label(s).

> +		return ret;
> +	}
> +
> +	list_add(&its_node->entry, &its_nodes);
> +
> +	gicv5_its_print_info(its_node);
> +
> +	return 0;
> +}
...

> diff --git a/drivers/irqchip/irq-gic-v5.c b/drivers/irqchip/irq-gic-v5.c
> index c4d4e85382f672fa4ae334db1a4e4c7c4f46b9fe..e483d0774936035b5cf2407da9a65d776bad3138 100644
> --- a/drivers/irqchip/irq-gic-v5.c
> +++ b/drivers/irqchip/irq-gic-v5.c
...
> @@ -168,17 +271,90 @@ struct gicv5_irs_chip_data {
>   
>   void __init gicv5_init_lpi_domain(void);
>   void __init gicv5_free_lpi_domain(void);
> +static inline int gicv5_wait_for_op(void __iomem *addr, u32 offset, u32 mask,
> +				    u32 *val)
> +{
> +	void __iomem *reg = addr + offset;
> +	u32 tmp;
> +	int ret;
> +
> +	ret = readl_poll_timeout_atomic(reg, tmp, tmp & mask, 1, 10 * USEC_PER_MSEC);

Does this have to be atomic? The call chain is complex, I haven't 
managed to check...

> +
> +	if (val)
> +		*val = tmp;

Do you really want to write val in case of timeout? Sounds unexpected.

> +	return ret;
> +}

thanks,
-- 
js
suse labs


