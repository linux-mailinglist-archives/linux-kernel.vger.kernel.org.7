Return-Path: <linux-kernel+bounces-739874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B724EB0CC7D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3B7F7B27E9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 21:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D6A23E34C;
	Mon, 21 Jul 2025 21:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nKJ2N0Rt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VuD/dWCi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD6C15530C
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 21:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753132980; cv=none; b=AYCAVLgs11pFXgHFpmwsURMMnpF9C4u44u86OaGqQIAkPCD0IO58GtfH/evgZHqMnMV/LQUcCy28dVQ44RBBJ52y8Jvu0aG3ekC29wJDtGD6gY/6l1SLjOVBnF2CwmevIXt8xdxW6K8D98S9HG09D1iQjSQxXgJOoftyBWRh5TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753132980; c=relaxed/simple;
	bh=m/LFjWmIEvfiUc0WnuMcHjnFfLukze96F+S6A8r2KXo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m5SHcXyqGP+JlA+Y9eZJQ70+ZJGQ2PoJGP/+mNF1MQIMaEFJ4Ha1yZtbfCFH9QEwXA8EcSPOI4jXSX7ks/PMjC+2ij3b80y85TfTzkoCEXI4YOIKAUUidbvBba07vz2HGdpp0J5628cxuWE3gL+wcPm3kNAJlZ2X5AQiQX/k1n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nKJ2N0Rt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VuD/dWCi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753132976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hU3EuHcWDWLlIe4uZVNHRB1yn3VDo4n0cE7txljJj5o=;
	b=nKJ2N0RtoSkwb/2Pp36LJ0A0UsUpjeVS7qsJe39lsvCbLMURtYz9ietEso9zPCaNZ2G4/6
	gUMhI1eHtGFEPWqenGgOViJh35xhEejRbyCLJpSi1V4oyBUci7dSQ1us9i0i+pQXqg5AiU
	ENeW8yyaMW1k/8GJ+1ydlhc/U4VckxxPN8R2o+44WMQV2WCZ8phAKgREkHzjClrfyi7xMV
	UdLbkOQA9bt7O4Ex2sgPzyEyf9uxEkNcJOmiOQTgETPYRyxc3+haJskXudMvycA6CnY8zj
	oG+R9WmACpBUUi5fg0gelTVfEXz1cahXmbL5K1hDwBfO44mWmZg5w8/bFkGY3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753132976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hU3EuHcWDWLlIe4uZVNHRB1yn3VDo4n0cE7txljJj5o=;
	b=VuD/dWCizR+efcuLC9Sldy5mK0l9PfaC5X/dJnFmjW8LpuCcTDkztFOBEqmlnChANhCB5/
	p70C4+3Av9MZ2+Cw==
To: jackysliu <1972843537@qq.com>
Cc: linux-kernel@vger.kernel.org, Siyang Liu <1972843537@qq.com>
Subject: Re: [PATCH] irqchip/ls-extirq: fix resource leak in
 ls_extirq_parse_map()
In-Reply-To: <tencent_0A4AB3348A519A1A2EF46D99BF6A52D9BB06@qq.com>
References: <tencent_0A4AB3348A519A1A2EF46D99BF6A52D9BB06@qq.com>
Date: Mon, 21 Jul 2025 23:22:55 +0200
Message-ID: <87bjpdtf0w.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 21 2025 at 12:43, jackysliu wrote:

> From: Siyang Liu <1972843537@qq.com>
>
> The ls_extirq_parse_map function uses of_find_node_by_phandle() to obtain

ls_extirq_parse_map() uses ...

> interrupt parent nodes within a loop, but fails to release the reference
> count on these nodes. This results in a kernel memory leak as the node
> reference counts continuously increase.

There is no continous increase as each ipar node is only looked up and
referenced exactly once. So this leaks exactly ONE reference count per
node.

> Add of_node_put() calls to properly release the references when the nodes

I see only one call, not several calls...

> are no longer needed
>
> Signed-off-by: Siyang Liu <1972843537@qq.com>
> ---
>  drivers/irqchip/irq-ls-extirq.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/irqchip/irq-ls-extirq.c b/drivers/irqchip/irq-ls-extirq.c
> index 50a7b38381b9..fb4e7b3a6e2f 100644
> --- a/drivers/irqchip/irq-ls-extirq.c
> +++ b/drivers/irqchip/irq-ls-extirq.c
> @@ -164,6 +164,7 @@ ls_extirq_parse_map(struct ls_extirq_data *priv, struct device_node *node)
>  		for (j = 0; j < intsize; ++j)
>  			priv->map[hwirq].param[j] = be32_to_cpup(map++);
>  		mapsize -= intsize;
> +		of_node_put(ipar);

That's the wrong point as this might not be reached because of the
following checks before the inner loop:

		ret = of_property_read_u32(ipar, "#interrupt-cells", &intsize);
		if (ret)
			return ret;

		if (intsize > mapsize)
			return -EINVAL;

Please don't add put() calls in every error return path. _ONE_ put() at
the proper place is sufficient.

Thanks,

        tglx

