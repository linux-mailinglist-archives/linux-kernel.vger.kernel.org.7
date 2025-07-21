Return-Path: <linux-kernel+bounces-739059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FF1B0C140
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE1CA189E272
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998D028F527;
	Mon, 21 Jul 2025 10:27:26 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8922919DF62
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 10:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753093646; cv=none; b=mOUW5QCCxdC+lQwf4DTW32BRpm7W1TFcTWRwx/PXgEr1hIHoDMOxBoYkoB0plRMGm1b+RZXHUnRG2TXEPyn/6VH43bthWCm4ZyCKL2pyCeZYLwLquZafMAg/0YyLibKS0eLvWMxBL6NGXgT17S/oCuieL19SrTV3dXwoOhZlX0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753093646; c=relaxed/simple;
	bh=cYcCoNiLvDem6aHfPJvncD+8qdaEZBgmebTrvOKBgMs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d6SsbxUJziXpzvWuF3rvTnQBINPUezbb10PSt9ko4nasrLlGOfuAsHQPBVltDJ3kmlCU/GNwERkZdd17hkS9jNltjbsgO48LiFbgWl2HypyVFvO0kfPHfdbwwLyODPT5Jj+TlNKNpAzN9o169UwT6qpNXJzaUaF3LlTS8ljQCpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4blxPZ3zbdz6L5RM;
	Mon, 21 Jul 2025 18:25:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E4CE3140417;
	Mon, 21 Jul 2025 18:27:20 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 21 Jul
 2025 12:27:20 +0200
Date: Mon, 21 Jul 2025 11:27:18 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Marc Zyngier <maz@kernel.org>
CC: jackysliu <1972843537@qq.com>, <tglx@linutronix.de>,
	<herve.codina@bootlin.com>, <antonio.borneo@foss.st.com>,
	<anup@brainfault.org>, <jirislaby@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] irqchip/gic-v3: fix resource leak in
 partition_domain_translate()
Message-ID: <20250721112718.00002e23@huawei.com>
In-Reply-To: <86qzya7xwu.wl-maz@kernel.org>
References: <tencent_72EDAD7F6E52D8FB5933030A569A08AEC406@qq.com>
	<86qzya7xwu.wl-maz@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 21 Jul 2025 09:25:53 +0100
Marc Zyngier <maz@kernel.org> wrote:

> On Mon, 21 Jul 2025 08:28:04 +0100,
> jackysliu <1972843537@qq.com> wrote:
> > 
> > There is a device node reference leak in partition_domain_translate().
> > After the function obtains the device node np via of_find_node_by_phandle,
> > it does not call of_node_put(np) to release the node reference
> > in both the error path and the normal return path.
> > This causes the node reference count to increase each time
> > the function is called, causing a resource leak.
> >
> > This issue was detected by rule based static tools
> > developed by Tencent.
> > 
> > Fixes: 87228532e7e9 ("irqchip: Switch to of_fwnode_handle()")
> > 
> > Signed-off-by: jackysliu <1972843537@qq.com>  
> 
> Drop the spurious blank line.
> 
> > ---
> >  drivers/irqchip/irq-gic-v3.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> > index efc791c43d44..61c1d404b726 100644
> > --- a/drivers/irqchip/irq-gic-v3.c
> > +++ b/drivers/irqchip/irq-gic-v3.c
> > @@ -1821,12 +1821,16 @@ static int partition_domain_translate(struct irq_domain *d,
> >  		return -EINVAL;
> >  
> >  	ret = gic_irq_domain_translate(d, fwspec, &ppi_intid, type);
> > -	if (WARN_ON_ONCE(ret))
> > +	if (WARN_ON_ONCE(ret)) {
> > +		of_node_put(np);
> >  		return 0;
> > +	}
> >  
> >  	ppi_idx = __gic_get_ppi_index(ppi_intid);
> >  	ret = partition_translate_id(gic_data.ppi_descs[ppi_idx],
> >  				     of_fwnode_handle(np));
> > +	of_node_put(np);
> > +
> >  	if (ret < 0)
> >  		return ret;
> >    
> 
> Frankly, this looks awful, and we have much better ways to solve this
> whole class of problems. Why can't the (untested) patch below do the
> right thing, without the ugliness?
> 
> 	M.
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index efc791c43d441..c4839032ce8d0 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -1808,8 +1808,8 @@ static int partition_domain_translate(struct irq_domain *d,
>  				      unsigned long *hwirq,
>  				      unsigned int *type)
>  {
> +	struct device_node *np __free(device_node) = NULL;

Linus has expressed fairly strongly that he really doesn't like separation
of the constructor and destructor.  See guidance in cleanup.h which was
based on that and bunch of other early discussion around this stuff.

Here it's easy to solve though. Just move that declaration down to
give something like:


>  	unsigned long ppi_intid;
> -	struct device_node *np;
>  	unsigned int ppi_idx;
>  	int ret;
>  
	if (!gic_data.ppi_descs)
		return -ENOMEM;

	struct device_node *np __free(device_node) =
		of_find_node_by_phandle(fwspec->param[3]);


	if (WARN_ON(!np))
		return -EINVAL;


