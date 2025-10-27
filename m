Return-Path: <linux-kernel+bounces-872258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BE6C0FBFD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51DED465A8F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBF1296BC5;
	Mon, 27 Oct 2025 17:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tmc36Yqp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B36D1E2614
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761587271; cv=none; b=UlqM9kMSeBmNezic2ebCX/4I9Y1NiE5owlA3EKy8OTEIxscZNSTTpjGWJo7Fca320Bvg8x+o8tDBy7OeaeU5e0XkwoLIO62T8jYkBz8X8tAfxHRf8xzVNAvrWqbaMiNRHHoyhJ0OFYXoOhj6CFjp4CWR8HPJrPrk1KHSfO0CCpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761587271; c=relaxed/simple;
	bh=lEDwiAkaOmOaXP65JPO7UPrE8f0UT4oZYKTFFx6yKoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mkNr+ug3YWu/Yw5A9hF5vY7QDPgtq2NnIrDsU0kVnlCGa/HHJ1m80Y9ZFN4BWsCv+4ObDBH7/P60o4GtqVML2NxPrMGYI2inGuxNFMy/rryYg4fNhsCoQp9hrMtC7Hl5cH0lgnjwT21p5Ssc3Re8ukm+1bpldAeiEeQEd2FqLNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tmc36Yqp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761587267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ivFzYCwRxbqfHnGcadZCNnv5FrvdqFe/7nCBoNuqOws=;
	b=Tmc36Yqp0bhZXJuR99WIoOWQXZ728hx7bfdWYIVPig1qaGSCuUds3UAm2jQTut5UBevzss
	OTOfy4xwHG1WORPjkRj+kem5LMOcm3UV3ggWDrG1NF0FZicnOynBRNwYsZOkebR8klMFfM
	YDbN50g682GN55ZgPjlVGm3ionZk3hI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-a0fazt7AMGuuoMdgNU31UA-1; Mon,
 27 Oct 2025 13:47:44 -0400
X-MC-Unique: a0fazt7AMGuuoMdgNU31UA-1
X-Mimecast-MFC-AGG-ID: a0fazt7AMGuuoMdgNU31UA_1761587263
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5C6A1800D86;
	Mon, 27 Oct 2025 17:47:42 +0000 (UTC)
Received: from cmirabil.redhat.com (unknown [10.22.64.253])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2D6981800452;
	Mon, 27 Oct 2025 17:47:41 +0000 (UTC)
From: Charles Mirabile <cmirabil@redhat.com>
To: lkp@intel.com
Cc: cmirabil@redhat.com,
	linux-kernel@vger.kernel.org,
	lzampier@redhat.com,
	oe-kbuild-all@lists.linux.dev,
	tglx@linutronix.de,
	x86@kernel.org
Subject: Re: [tip:irq/drivers 22/22] drivers/irqchip/irq-sifive-plic.c:590:55: sparse: sparse: incorrect type in argument 1 (different address spaces)
Date: Mon, 27 Oct 2025 13:47:23 -0400
Message-ID: <20251027174725.1014197-1-cmirabil@redhat.com>
In-Reply-To: <202510271316.AQM7gCCy-lkp@intel.com>
References: <202510271316.AQM7gCCy-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi all—

On Mon, Oct 27, 2025 at 01:16:01PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/drivers
> head:   14ff9e54dd14339776afff78e2d29e0edb3a4402
> commit: 14ff9e54dd14339776afff78e2d29e0edb3a4402 [22/22] irqchip/sifive-plic: Cache the interrupt enable state
> config: riscv-randconfig-r132-20251027 (https://download.01.org/0day-ci/archive/20251027/202510271316.AQM7gCCy-lkp@intel.com/config)
> compiler: riscv64-linux-gcc (GCC) 14.3.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251027/202510271316.AQM7gCCy-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202510271316.AQM7gCCy-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
> >> drivers/irqchip/irq-sifive-plic.c:590:55: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct plic_handler *handler @@     got void [noderef] __iomem *enable_base @@
>    drivers/irqchip/irq-sifive-plic.c:590:55: sparse:     expected struct plic_handler *handler
>    drivers/irqchip/irq-sifive-plic.c:590:55: sparse:     got void [noderef] __iomem *enable_base

This is related to https://git.kernel.org/tip/tip/c/14ff9e54

> 
> vim +590 drivers/irqchip/irq-sifive-plic.c
> 
> a15587277a246c Anup Patel        2024-02-22  508  
> 4d936f10ff8027 Anup Patel        2024-08-20  509  static int plic_probe(struct fwnode_handle *fwnode)
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  510  {
> a15587277a246c Anup Patel        2024-02-22  511  	int error = 0, nr_contexts, nr_handlers = 0, cpu, i;
> 8ec99b033147ef Anup Patel        2024-02-22  512  	unsigned long plic_quirks = 0;
> 2234ae846ccb9e Anup Patel        2020-05-18  513  	struct plic_handler *handler;
> a15587277a246c Anup Patel        2024-02-22  514  	u32 nr_irqs, parent_hwirq;
> 8ec99b033147ef Anup Patel        2024-02-22  515  	struct plic_priv *priv;
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  516  	irq_hw_number_t hwirq;
> 4d936f10ff8027 Anup Patel        2024-08-20  517  	void __iomem *regs;
> 206dd13a101196 Sunil V L         2024-08-27  518  	int id, context_id;
> 206dd13a101196 Sunil V L         2024-08-27  519  	u32 gsi_base;
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  520  
> 4d936f10ff8027 Anup Patel        2024-08-20  521  	if (is_of_node(fwnode)) {
> 8ec99b033147ef Anup Patel        2024-02-22  522  		const struct of_device_id *id;
> 8ec99b033147ef Anup Patel        2024-02-22  523  
> 4d936f10ff8027 Anup Patel        2024-08-20  524  		id = of_match_node(plic_match, to_of_node(fwnode));
> 8ec99b033147ef Anup Patel        2024-02-22  525  		if (id)
> 8ec99b033147ef Anup Patel        2024-02-22  526  			plic_quirks = (unsigned long)id->data;
> 4d936f10ff8027 Anup Patel        2024-08-20  527  
> 4d936f10ff8027 Anup Patel        2024-08-20  528  		regs = of_iomap(to_of_node(fwnode), 0);
> 4d936f10ff8027 Anup Patel        2024-08-20  529  		if (!regs)
> 4d936f10ff8027 Anup Patel        2024-08-20  530  			return -ENOMEM;
> 4d936f10ff8027 Anup Patel        2024-08-20  531  	} else {
> 206dd13a101196 Sunil V L         2024-08-27  532  		regs = devm_platform_ioremap_resource(to_platform_device(fwnode->dev), 0);
> 206dd13a101196 Sunil V L         2024-08-27  533  		if (IS_ERR(regs))
> 206dd13a101196 Sunil V L         2024-08-27  534  			return PTR_ERR(regs);
> 8ec99b033147ef Anup Patel        2024-02-22  535  	}
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  536  
> 206dd13a101196 Sunil V L         2024-08-27  537  	error = plic_parse_nr_irqs_and_contexts(fwnode, &nr_irqs, &nr_contexts, &gsi_base, &id);
> 95652106478030 Anup Patel        2024-02-22  538  	if (error)
> 4d936f10ff8027 Anup Patel        2024-08-20  539  		goto fail_free_regs;
> 95652106478030 Anup Patel        2024-02-22  540  
> 4d936f10ff8027 Anup Patel        2024-08-20  541  	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> 4d936f10ff8027 Anup Patel        2024-08-20  542  	if (!priv) {
> 4d936f10ff8027 Anup Patel        2024-08-20  543  		error = -ENOMEM;
> 4d936f10ff8027 Anup Patel        2024-08-20  544  		goto fail_free_regs;
> 4d936f10ff8027 Anup Patel        2024-08-20  545  	}
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  546  
> 4d936f10ff8027 Anup Patel        2024-08-20  547  	priv->fwnode = fwnode;
> dd46337ca69662 Lad Prabhakar     2022-06-30  548  	priv->plic_quirks = plic_quirks;
> 95652106478030 Anup Patel        2024-02-22  549  	priv->nr_irqs = nr_irqs;
> 4d936f10ff8027 Anup Patel        2024-08-20  550  	priv->regs = regs;
> 206dd13a101196 Sunil V L         2024-08-27  551  	priv->gsi_base = gsi_base;
> 206dd13a101196 Sunil V L         2024-08-27  552  	priv->acpi_plic_id = id;
> dd46337ca69662 Lad Prabhakar     2022-06-30  553  
> 4d936f10ff8027 Anup Patel        2024-08-20  554  	priv->prio_save = bitmap_zalloc(nr_irqs, GFP_KERNEL);
> 4d936f10ff8027 Anup Patel        2024-08-20  555  	if (!priv->prio_save) {
> 4d936f10ff8027 Anup Patel        2024-08-20  556  		error = -ENOMEM;
> 4d936f10ff8027 Anup Patel        2024-08-20  557  		goto fail_free_priv;
> 4d936f10ff8027 Anup Patel        2024-08-20  558  	}
> e80f0b6a2cf302 Mason Huo         2023-04-04  559  
> 6adfe8d2f5b353 Anup Patel        2019-02-12  560  	for (i = 0; i < nr_contexts; i++) {
> 206dd13a101196 Sunil V L         2024-08-27  561  		error = plic_parse_context_parent(fwnode, i, &parent_hwirq, &cpu,
> 206dd13a101196 Sunil V L         2024-08-27  562  						  priv->acpi_plic_id);
> a15587277a246c Anup Patel        2024-02-22  563  		if (error) {
> 4d936f10ff8027 Anup Patel        2024-08-20  564  			pr_warn("%pfwP: hwirq for context%d not found\n", fwnode, i);
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  565  			continue;
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  566  		}
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  567  
> 206dd13a101196 Sunil V L         2024-08-27  568  		if (is_of_node(fwnode)) {
> 206dd13a101196 Sunil V L         2024-08-27  569  			context_id = i;
> 206dd13a101196 Sunil V L         2024-08-27  570  		} else {
> 206dd13a101196 Sunil V L         2024-08-27  571  			context_id = acpi_rintc_get_plic_context(priv->acpi_plic_id, i);
> 206dd13a101196 Sunil V L         2024-08-27  572  			if (context_id == INVALID_CONTEXT) {
> 206dd13a101196 Sunil V L         2024-08-27  573  				pr_warn("%pfwP: invalid context id for context%d\n", fwnode, i);
> 206dd13a101196 Sunil V L         2024-08-27  574  				continue;
> 206dd13a101196 Sunil V L         2024-08-27  575  			}
> 206dd13a101196 Sunil V L         2024-08-27  576  		}
> 206dd13a101196 Sunil V L         2024-08-27  577  
> a4c3733d32a72f Christoph Hellwig 2019-10-28  578  		/*
> a4c3733d32a72f Christoph Hellwig 2019-10-28  579  		 * Skip contexts other than external interrupts for our
> a4c3733d32a72f Christoph Hellwig 2019-10-28  580  		 * privilege level.
> a4c3733d32a72f Christoph Hellwig 2019-10-28  581  		 */
> a15587277a246c Anup Patel        2024-02-22  582  		if (parent_hwirq != RV_IRQ_EXT) {
> 098fdbc3531f06 Niklas Cassel     2022-03-02  583  			/* Disable S-mode enable bits if running in M-mode. */
> 098fdbc3531f06 Niklas Cassel     2022-03-02  584  			if (IS_ENABLED(CONFIG_RISCV_M_MODE)) {
> 098fdbc3531f06 Niklas Cassel     2022-03-02  585  				void __iomem *enable_base = priv->regs +
> 098fdbc3531f06 Niklas Cassel     2022-03-02  586  					CONTEXT_ENABLE_BASE +
> 098fdbc3531f06 Niklas Cassel     2022-03-02  587  					i * CONTEXT_ENABLE_SIZE;
> 098fdbc3531f06 Niklas Cassel     2022-03-02  588  
> 098fdbc3531f06 Niklas Cassel     2022-03-02  589  				for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
> 098fdbc3531f06 Niklas Cassel     2022-03-02 @590  					__plic_toggle(enable_base, hwirq, 0);

I wasn't running sparse so I missed fixing this call to the dunder version
of the toggle function. I don't think we actually want to run the code to
update the caches for this anyways since these are unrelated enable bits
for other contexts. I have attached a patch to fix it that just directly
issues the mmio writes (faster too because we can just disable in groups
of 32 with a single write instead of the machinery to update a single bit
from the __plic_toggle impl).

> 098fdbc3531f06 Niklas Cassel     2022-03-02  591  			}
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  592  			continue;
> 098fdbc3531f06 Niklas Cassel     2022-03-02  593  		}
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  594  
> fc03acaeab358c Atish Patra       2019-02-12  595  		if (cpu < 0) {
> 4d936f10ff8027 Anup Patel        2024-08-20  596  			pr_warn("%pfwP: Invalid cpuid for context %d\n", fwnode, i);
> fc03acaeab358c Atish Patra       2019-02-12  597  			continue;
> fc03acaeab358c Atish Patra       2019-02-12  598  		}
> fc03acaeab358c Atish Patra       2019-02-12  599  
> 9ce06497c2722a Christoph Hellwig 2019-09-03  600  		/*
> 9ce06497c2722a Christoph Hellwig 2019-09-03  601  		 * When running in M-mode we need to ignore the S-mode handler.
> 9ce06497c2722a Christoph Hellwig 2019-09-03  602  		 * Here we assume it always comes later, but that might be a
> 9ce06497c2722a Christoph Hellwig 2019-09-03  603  		 * little fragile.
> 9ce06497c2722a Christoph Hellwig 2019-09-03  604  		 */
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  605  		handler = per_cpu_ptr(&plic_handlers, cpu);
> 3fecb5aac28888 Anup Patel        2019-02-12  606  		if (handler->present) {
> 4d936f10ff8027 Anup Patel        2024-08-20  607  			pr_warn("%pfwP: handler already present for context %d.\n", fwnode, i);
> ccbe80bad571c2 Atish Patra       2020-03-02  608  			plic_set_threshold(handler, PLIC_DISABLE_THRESHOLD);
> 9ce06497c2722a Christoph Hellwig 2019-09-03  609  			goto done;
> 3fecb5aac28888 Anup Patel        2019-02-12  610  		}
> 3fecb5aac28888 Anup Patel        2019-02-12  611  
> f1ad1133b18f2a Atish Patra       2020-03-02  612  		cpumask_set_cpu(cpu, &priv->lmask);
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  613  		handler->present = true;
> 0d3616bbd03cdf Niklas Cassel     2022-03-02  614  		handler->hart_base = priv->regs + CONTEXT_BASE +
> 206dd13a101196 Sunil V L         2024-08-27  615  			context_id * CONTEXT_SIZE;
> 86c7cbf1e8d1d4 Anup Patel        2019-02-12  616  		raw_spin_lock_init(&handler->enable_lock);
> 0d3616bbd03cdf Niklas Cassel     2022-03-02  617  		handler->enable_base = priv->regs + CONTEXT_ENABLE_BASE +
> 206dd13a101196 Sunil V L         2024-08-27  618  			context_id * CONTEXT_ENABLE_SIZE;
> f1ad1133b18f2a Atish Patra       2020-03-02  619  		handler->priv = priv;
> e80f0b6a2cf302 Mason Huo         2023-04-04  620  
> 4d936f10ff8027 Anup Patel        2024-08-20  621  		handler->enable_save = kcalloc(DIV_ROUND_UP(nr_irqs, 32),
> e80f0b6a2cf302 Mason Huo         2023-04-04  622  					       sizeof(*handler->enable_save), GFP_KERNEL);
> 6eabf656048d90 Charlie Jenkins   2024-09-03  623  		if (!handler->enable_save) {
> 6eabf656048d90 Charlie Jenkins   2024-09-03  624  			error = -ENOMEM;
> a15587277a246c Anup Patel        2024-02-22  625  			goto fail_cleanup_contexts;
> 6eabf656048d90 Charlie Jenkins   2024-09-03  626  		}
> 9ce06497c2722a Christoph Hellwig 2019-09-03  627  done:
> a1706a1c5062e0 Samuel Holland    2022-07-01  628  		for (hwirq = 1; hwirq <= nr_irqs; hwirq++) {
> 86c7cbf1e8d1d4 Anup Patel        2019-02-12  629  			plic_toggle(handler, hwirq, 0);
> a1706a1c5062e0 Samuel Holland    2022-07-01  630  			writel(1, priv->regs + PRIORITY_BASE +
> a1706a1c5062e0 Samuel Holland    2022-07-01  631  				  hwirq * PRIORITY_PER_ID);
> a1706a1c5062e0 Samuel Holland    2022-07-01  632  		}
> 6adfe8d2f5b353 Anup Patel        2019-02-12  633  		nr_handlers++;
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  634  	}
> 8237f8bc4f6eb7 Christoph Hellwig 2018-07-26  635  
> 206dd13a101196 Sunil V L         2024-08-27  636  	priv->irqdomain = irq_domain_create_linear(fwnode, nr_irqs + 1,
> b68d0ff529a939 Anup Patel        2024-02-22  637  						   &plic_irqdomain_ops, priv);
> 6eabf656048d90 Charlie Jenkins   2024-09-03  638  	if (WARN_ON(!priv->irqdomain)) {
> 6eabf656048d90 Charlie Jenkins   2024-09-03  639  		error = -ENOMEM;
> a15587277a246c Anup Patel        2024-02-22  640  		goto fail_cleanup_contexts;
> 6eabf656048d90 Charlie Jenkins   2024-09-03  641  	}
> b68d0ff529a939 Anup Patel        2024-02-22  642  
> 2234ae846ccb9e Anup Patel        2020-05-18  643  	/*
> e306a894bd5118 Samuel Holland    2024-05-29  644  	 * We can have multiple PLIC instances so setup global state
> 8ec99b033147ef Anup Patel        2024-02-22  645  	 * and register syscore operations only once after context
> 8ec99b033147ef Anup Patel        2024-02-22  646  	 * handlers of all online CPUs are initialized.
> 2234ae846ccb9e Anup Patel        2020-05-18  647  	 */
> e306a894bd5118 Samuel Holland    2024-05-29  648  	if (!plic_global_setup_done) {
> e306a894bd5118 Samuel Holland    2024-05-29  649  		struct irq_domain *domain;
> e306a894bd5118 Samuel Holland    2024-05-29  650  		bool global_setup = true;
> e306a894bd5118 Samuel Holland    2024-05-29  651  
> 8ec99b033147ef Anup Patel        2024-02-22  652  		for_each_online_cpu(cpu) {
> 8ec99b033147ef Anup Patel        2024-02-22  653  			handler = per_cpu_ptr(&plic_handlers, cpu);
> 8ec99b033147ef Anup Patel        2024-02-22  654  			if (!handler->present) {
> e306a894bd5118 Samuel Holland    2024-05-29  655  				global_setup = false;
> 8ec99b033147ef Anup Patel        2024-02-22  656  				break;
> 8ec99b033147ef Anup Patel        2024-02-22  657  			}
> 8ec99b033147ef Anup Patel        2024-02-22  658  		}
> e306a894bd5118 Samuel Holland    2024-05-29  659  
> e306a894bd5118 Samuel Holland    2024-05-29  660  		if (global_setup) {
> e306a894bd5118 Samuel Holland    2024-05-29  661  			/* Find parent domain and register chained handler */
> e306a894bd5118 Samuel Holland    2024-05-29  662  			domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(), DOMAIN_BUS_ANY);
> e306a894bd5118 Samuel Holland    2024-05-29  663  			if (domain)
> e306a894bd5118 Samuel Holland    2024-05-29  664  				plic_parent_irq = irq_create_mapping(domain, RV_IRQ_EXT);
> e306a894bd5118 Samuel Holland    2024-05-29  665  			if (plic_parent_irq)
> e306a894bd5118 Samuel Holland    2024-05-29  666  				irq_set_chained_handler(plic_parent_irq, plic_handle_irq);
> e306a894bd5118 Samuel Holland    2024-05-29  667  
> ccbe80bad571c2 Atish Patra       2020-03-02  668  			cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
> ccbe80bad571c2 Atish Patra       2020-03-02  669  					  "irqchip/sifive/plic:starting",
> ccbe80bad571c2 Atish Patra       2020-03-02  670  					  plic_starting_cpu, plic_dying_cpu);
> f99b926f6543fa Anup Patel        2023-10-25  671  			register_syscore_ops(&plic_irq_syscore_ops);
> e306a894bd5118 Samuel Holland    2024-05-29  672  			plic_global_setup_done = true;
> 2234ae846ccb9e Anup Patel        2020-05-18  673  		}
> 8ec99b033147ef Anup Patel        2024-02-22  674  	}
> 2234ae846ccb9e Anup Patel        2020-05-18  675  
> 
> :::::: The code at line 590 was first introduced by commit
> :::::: 098fdbc3531f06aae2426b3a6f9bd730e7691258 irqchip/sifive-plic: Disable S-mode IRQs if running in M-mode
> 
> :::::: TO: Niklas Cassel <niklas.cassel@wdc.com>
> :::::: CC: Marc Zyngier <maz@kernel.org>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

Best—Charlie

---
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 9c4af7d58846..fbf7378899d3 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -590,12 +590,12 @@ static int plic_probe(struct fwnode_handle *fwnode)
 		if (parent_hwirq != RV_IRQ_EXT) {
 			/* Disable S-mode enable bits if running in M-mode. */
 			if (IS_ENABLED(CONFIG_RISCV_M_MODE)) {
-				void __iomem *enable_base = priv->regs +
+				u32 __iomem *enable_base = priv->regs +
 					CONTEXT_ENABLE_BASE +
 					i * CONTEXT_ENABLE_SIZE;
 
-				for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
-					__plic_toggle(enable_base, hwirq, 0);
+				for (int j = 0; j <= nr_irqs / 32; j++)
+					writel(0, enable_base + j);
 			}
 			continue;
 		}
-- 
2.51.0


