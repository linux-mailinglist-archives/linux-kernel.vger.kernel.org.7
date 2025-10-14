Return-Path: <linux-kernel+bounces-852150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5188BD849B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E030819211FB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD0C2DC79B;
	Tue, 14 Oct 2025 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e/lWdt2i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8zmUS8OO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e/lWdt2i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8zmUS8OO"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BFD202997
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760431974; cv=none; b=kCVzqATD3+cXYOsqpTf9Kya9uJ1HdZPQMa9POomUlQncGwBQk16UmKCYzD++iDZU3X2rPwUu7AydAUjJXYFYnEIlparv+jILFMbexYIPG+VBQir4rbjDt73rARs/RT99gSJFkS/xuoEoaXLJ0vGgT5VA88aAQzKn6pn/pdpYj7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760431974; c=relaxed/simple;
	bh=k8/YQ8ncH/9IyJTCoRmqYbMBukQw1hh6q1JIyqq5tK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AW12pwt1qhQ1Vk3U/AkyH8eBf9BEmZPtOlwVvNYYAcqxgsOLXHeds1myYDe/FPPFwMeyB/6Ubjl0UBnmE9oVMiate5HZbM8P+oWlONrTjtCFytURPTUaoMptcjPa24F2asuSqc7+Tom042eKH+a5MLAtX/Ou7vTpr0Jawlb8TDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e/lWdt2i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8zmUS8OO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e/lWdt2i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8zmUS8OO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4774822092;
	Tue, 14 Oct 2025 08:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760431971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pfac//zbA/kALxeTnYsE9fQ5p0m4fWqCLZLa45e2NUI=;
	b=e/lWdt2ios6JUjO8MRxkzcL+STItpU3rWkLq9vhVboXy7aCwavVvjbZYEaeeZ7MHN/t9AO
	39kacyTwDmNjIxpaLiGEozeorTZTqz0P7VHKhzvyhCVvahLgMNgT2M7MZ9X9cDyvkGMtZg
	eu2kw7LZLTELQm2vjKHXOvxkprhdwh0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760431971;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pfac//zbA/kALxeTnYsE9fQ5p0m4fWqCLZLa45e2NUI=;
	b=8zmUS8OOhODopUQ88mzbFfOTcEdseW4QQe7qYmkBgqBveWSboExqjaR3IPBLcoUS/TWiCA
	pFInrbf0xIzbB6Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760431971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pfac//zbA/kALxeTnYsE9fQ5p0m4fWqCLZLa45e2NUI=;
	b=e/lWdt2ios6JUjO8MRxkzcL+STItpU3rWkLq9vhVboXy7aCwavVvjbZYEaeeZ7MHN/t9AO
	39kacyTwDmNjIxpaLiGEozeorTZTqz0P7VHKhzvyhCVvahLgMNgT2M7MZ9X9cDyvkGMtZg
	eu2kw7LZLTELQm2vjKHXOvxkprhdwh0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760431971;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pfac//zbA/kALxeTnYsE9fQ5p0m4fWqCLZLa45e2NUI=;
	b=8zmUS8OOhODopUQ88mzbFfOTcEdseW4QQe7qYmkBgqBveWSboExqjaR3IPBLcoUS/TWiCA
	pFInrbf0xIzbB6Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9CAE513A44;
	Tue, 14 Oct 2025 08:52:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pyf6I2IP7mgBLAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Tue, 14 Oct 2025 08:52:50 +0000
Message-ID: <7618ec1b-6e3c-4d29-8435-cc5269bdb9df@suse.de>
Date: Tue, 14 Oct 2025 11:52:40 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] irqchip: Pass platform device to platform drivers
To: Johan Hovold <johan@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Changhuang Liang <changhuang.liang@starfivetech.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org
References: <20251013094611.11745-1-johan@kernel.org>
 <20251013094611.11745-12-johan@kernel.org>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20251013094611.11745-12-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[renesas];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,pengutronix.de,gmail.com,tuxon.dev,linaro.org,baylibre.com,googlemail.com,starfivetech.com,glider.be,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Hi Johan,

On 10/13/25 12:46 PM, Johan Hovold wrote:
> The IRQCHIP_PLATFORM_DRIVER macros can be used to convert OF irqchip
> drivers to platform drivers but currently reuse the OF init callback
> prototype that only takes OF nodes as arguments. This forces drivers to
> do reverse lookups of their struct devices during probe if they need
> them for things like dev_printk() and device managed resources.
> 
> Half of the drivers doing reverse lookups also currently fail to release
> the additional reference taken during the lookup, while other drivers
> have had the reference leak plugged in various ways (e.g. using
> non-intuitive cleanup constructs which still confuse static checkers).
> 
> Switch to using a probe callback that takes a platform device as its
> first argument to simplify drivers and plug the remaining (mostly
> benign) reference leaks.
> 
> Fixes: 32c6c054661a ("irqchip: Add Broadcom BCM2712 MSI-X interrupt controller")
> Fixes: 70afdab904d2 ("irqchip: Add IMX MU MSI controller driver")
> Fixes: a6199bb514d8 ("irqchip: Add Qualcomm MPM controller driver")
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/irqchip/irq-bcm2712-mip.c          | 10 ++-----
>  drivers/irqchip/irq-bcm7038-l1.c           |  5 ++--
>  drivers/irqchip/irq-bcm7120-l2.c           | 20 ++++---------
>  drivers/irqchip/irq-brcmstb-l2.c           | 21 ++++++-------
>  drivers/irqchip/irq-imx-mu-msi.c           | 25 +++++++---------
>  drivers/irqchip/irq-mchp-eic.c             |  5 ++--
>  drivers/irqchip/irq-meson-gpio.c           |  5 ++--
>  drivers/irqchip/irq-qcom-mpm.c             |  6 ++--
>  drivers/irqchip/irq-renesas-rzg2l.c        | 35 +++++++---------------
>  drivers/irqchip/irq-renesas-rzv2h.c        | 32 ++++++--------------
>  drivers/irqchip/irq-starfive-jh8100-intc.c |  5 ++--
>  drivers/irqchip/irqchip.c                  |  6 ++--
>  drivers/irqchip/qcom-pdc.c                 |  5 ++--
>  include/linux/irqchip.h                    |  8 ++++-
>  14 files changed, 78 insertions(+), 110 deletions(-)
> 

<snip>

>  
>  IRQCHIP_PLATFORM_DRIVER_BEGIN(qcom_pdc)
> -IRQCHIP_MATCH("qcom,pdc", qcom_pdc_init)
> +IRQCHIP_MATCH("qcom,pdc", qcom_pdc_probe)
>  IRQCHIP_PLATFORM_DRIVER_END(qcom_pdc)
>  MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Power Domain Controller");
>  MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
> index d5e6024cb2a8..bc4ddacd6ddc 100644
> --- a/include/linux/irqchip.h
> +++ b/include/linux/irqchip.h
> @@ -17,12 +17,18 @@
>  #include <linux/of_irq.h>
>  #include <linux/platform_device.h>
>  
> +typedef int (*platform_irq_probe_t)(struct platform_device *, struct device_node *);
> +
>  /* Undefined on purpose */
>  extern of_irq_init_cb_t typecheck_irq_init_cb;

This is not used anymore?

> +extern platform_irq_probe_t typecheck_irq_probe;
>  
>  #define typecheck_irq_init_cb(fn)					\
>  	(__typecheck(typecheck_irq_init_cb, &fn) ? fn : fn)

ditto

~Stan

>  
> +#define typecheck_irq_probe(fn)						\
> +	(__typecheck(typecheck_irq_probe, &fn) ? fn : fn)
> +
>  /*
>   * This macro must be used by the different irqchip drivers to declare
>   * the association between their DT compatible string and their
> @@ -42,7 +48,7 @@ extern int platform_irqchip_probe(struct platform_device *pdev);
>  static const struct of_device_id drv_name##_irqchip_match_table[] = {
>  
>  #define IRQCHIP_MATCH(compat, fn) { .compatible = compat,		\
> -				    .data = typecheck_irq_init_cb(fn), },
> +				    .data = typecheck_irq_probe(fn), },
>  
>  
>  #define IRQCHIP_PLATFORM_DRIVER_END(drv_name, ...)			\


