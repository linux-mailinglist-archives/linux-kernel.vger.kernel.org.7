Return-Path: <linux-kernel+bounces-738867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4360AB0BE73
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0966B189C808
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0735F2853E2;
	Mon, 21 Jul 2025 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="a3/WvkqM"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94547DA7F
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753085428; cv=none; b=EeLTLFBo6yLVmfdmZlnoH2ywF6GZSdraOxFr6yhAzz3JzSx9i4yni4en0kbclFGexkda4e0liueKDfirjdMKjMMTkqT6occA5gFC0o/UL5Ua3xQIzjZrk+OYaFXSqhqTxiHog6eWoz+WMi/lq+g+RUWNoluDVzraAbni7vwVtsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753085428; c=relaxed/simple;
	bh=J6JENgawWZQ/EvtNxY/L/1AIGnQltHbh2je1qLHU/Os=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PvZiqXsKxFOx2ImAMvWtCh+Fz5cHkKu3PKMlypiYpQNpgml0fWKvIqfJwc3fGRWlO919Ga8RG2FVZiuWYQzzpm/zRBinkvyrBUfzoinxI9S485HRVKV+ZlvSOohAyDM8xkOTSUIc41wXsNC9mSFx0OtR/BUX7jUoPOpTHBG+8YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=a3/WvkqM; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E68B544380;
	Mon, 21 Jul 2025 08:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753085418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SKFkCkwIghfCr+DM5CXjoz3KrgfvHy+jPlJJIScrzXg=;
	b=a3/WvkqMro8djZzEjYoTOpL8ApbW10+o2OdBWljK6/GULQv3HQCrw3nmy1Hli4rINv3NdY
	6vPkg17fGrhAw8aCVgfgbmSQoSn6k6z8HXFjPb3EvD88dAqU5/pfFUDFtftFegQKfU+uFO
	A6bvphZwJFoc8KJTcYQu47dDc+TESugpgzaLQHs6S+v80sleodXQTk2NeL3FQ29wIpIgtY
	mL9Hse9JKcUlI0k+3ZhINBn/uldVJrjskVmKdKp0gwd4MM2vUSpElhjCE5yJt+Q0s7rNdO
	RVr3FGUJgXKDMcQWZmfJiqfQjZyJIJSkBw1kI7PVDtwAFUBtxIfUudoFZI/sOA==
Date: Mon, 21 Jul 2025 10:10:15 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: jackysliu <1972843537@qq.com>
Cc: maz@kernel.org, tglx@linutronix.de, antonio.borneo@foss.st.com,
 anup@brainfault.org, jirislaby@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip/gic-v3: fix resource leak in
 partition_domain_translate()
Message-ID: <20250721101015.1183e89b@bootlin.com>
In-Reply-To: <tencent_72EDAD7F6E52D8FB5933030A569A08AEC406@qq.com>
References: <tencent_72EDAD7F6E52D8FB5933030A569A08AEC406@qq.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejudehiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtkeertdertdejnecuhfhrohhmpefjvghrvhgvucevohguihhnrgcuoehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveeiffefgeeitdelleeigefhjeelueeuveekveetgeffheeltdekgeduiefggfdvnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhephhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeekpdhrtghpthhtohepudeljedvkeegfeehfeejsehqqhdrtghomhdprhgtphhtthhopehmrgiisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopegrnhhtohhnihhordgsohhrnhgvohesfhhoshhsrdhsthdrtghomhdprhgtphhtthhopegrnhhuphessghrrghinhhfrghulhhtrdhorhhgpdhrtghpthhtohepjhhirhhishhlrggshieskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhin
 hhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: herve.codina@bootlin.com

On Mon, 21 Jul 2025 15:28:04 +0800
jackysliu <1972843537@qq.com> wrote:

> There is a device node reference leak in partition_domain_translate().
> After the function obtains the device node np via of_find_node_by_phandle,
> it does not call of_node_put(np) to release the node reference
> in both the error path and the normal return path.
> This causes the node reference count to increase each time
> the function is called, causing a resource leak.
> 
> This issue was detected by rule based static tools
> developed by Tencent.
> 
> Fixes: 87228532e7e9 ("irqchip: Switch to of_fwnode_handle()")
> 
> Signed-off-by: jackysliu <1972843537@qq.com>
> ---
>  drivers/irqchip/irq-gic-v3.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index efc791c43d44..61c1d404b726 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -1821,12 +1821,16 @@ static int partition_domain_translate(struct irq_domain *d,
>  		return -EINVAL;
>  
>  	ret = gic_irq_domain_translate(d, fwspec, &ppi_intid, type);
> -	if (WARN_ON_ONCE(ret))
> +	if (WARN_ON_ONCE(ret)) {
> +		of_node_put(np);
>  		return 0;
> +	}
>  
>  	ppi_idx = __gic_get_ppi_index(ppi_intid);
>  	ret = partition_translate_id(gic_data.ppi_descs[ppi_idx],
>  				     of_fwnode_handle(np));
> +	of_node_put(np);
> +
>  	if (ret < 0)
>  		return ret;
>  

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé

