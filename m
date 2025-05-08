Return-Path: <linux-kernel+bounces-640012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABABEAAFF7D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 17:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B144C1BC596D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 15:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7175D1957FF;
	Thu,  8 May 2025 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ox5Y0Ogv"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563322CCC0
	for <linux-kernel@vger.kernel.org>; Thu,  8 May 2025 15:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746719195; cv=none; b=hHUqn03kECy3UDcs9tLzLqoDavjgwNSF2C+yhr88i8w2vcTHR5LG2vg3Qk2DHUE9xoLlTQN2f7I0dHX8nWjXvM731vnU5QS7d06fnPmN8b4CVeVl2jXPtpRx71ALFsEnkjz1CScNss4opn3BLf1gkAY7vXUdckUO0L+TV0kd45Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746719195; c=relaxed/simple;
	bh=fdAvBX5KUZVLm9yVjfjFKbXCGL+iCvCMzIkwpCLRTSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/vv/I0SN1OQspYm7hhbLVr5ofnpzXEUddIiNWSPX6uwgaSfTECjkGhNbhszIAvF9wUH3MGZym4eYtZdyHJa8z+JP8d6qIwkcySuSb1+MKuzEke6CXIl1sdMk3NeFm984bu9BB1u09z85Rb8yXNWUA08guZfhhytvKGDhliWDz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ox5Y0Ogv; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22c336fcdaaso14144895ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 May 2025 08:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746719192; x=1747323992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1WlYjJ1Yz4c8qiP7WRJEAcv6RJzb/TVseyzR6Ka6TRg=;
        b=ox5Y0Ogv6BQw0GyBHCkAEs7aTDspTIdVzhwd9EHIgBc5/Qe10iJSZs9slz++eqiQQ8
         u0JQU7mlUpDWfdA6Ai+uXzoZF8R2RB1loeKU+0j+NrNe1cKT6ebYqjwtt63htKwXp1dw
         OEufaZ8gzlYzj0YWB/51g1KlERhzYSoNNXIbZp1p3sS84ra5n7STRykIEyoL5a6E7V2a
         yN+5eDhTewZ4iWz15AyETy0TlrCBBbgMgMrSwJspqzPnlcr9T3JrByyPgqBvLhfkICaV
         ERKBVRd1asDsEWkqB2vhMcuiBXFmXWvBZMVrj4ZPiQbPAC6Ts5fCMhnIi5dhiSbbv626
         Sogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746719192; x=1747323992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WlYjJ1Yz4c8qiP7WRJEAcv6RJzb/TVseyzR6Ka6TRg=;
        b=jehu+b3SPqztYH7u0LF7CkI2VpuTyHlQM3IuMRkKpLDVhFi7MKrQJzfJmcrV0w5Gkc
         rbFy7ny728vXz2aoRtMDAWUZKSzRXseKgXD7VgDX6kg3OGZ9z8vMfv55pHLkkOIaMeUB
         l5yRZDPKqElMrZWL6R0lMkeqa+hk4zQTZwOQIVbms1mlrT7DZAjgs4SfN7AokWQP1oqL
         YiupKR841cnJp/sDauA7/iDEAVSuzOV8oXp/hQ1zmx4hRisATyzWMD4dYbWGAfOlT14O
         r3YwyLN3Bf+Vcd4tccl+za2R1mG1SKmY/eQaA9/vwPuhKZEg8I8FiDzrx6DNcJlOgWkU
         tnZw==
X-Forwarded-Encrypted: i=1; AJvYcCXfwp48cGnR4niJRJU22MovfzY5c92k9Tt7QvlCBo3SScbdzVZtBA92Njbzn9aM78caEWvlvq1ATsNic5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxoZtEXEXm2NxbmOFdXNDmdjpYIejwZuLHPyQH8atu+rEBNHtQ
	d6hTyyi8pP4I8WjvY0Sy+rYZuCCASgfTHMM4xZww7WODNl1EiYit5mUtLo13sKs=
X-Gm-Gg: ASbGncsHXHstH2JqwyTsCvo4fW4GiYDfg6s6QZTnzCMi03aw9XY6KuZjt5MT5q7bB00
	epIjjc7E+PYwCfJfyFX5BSOqfOw4xhrA20x006NHWniy4nup6ASXdTfbbqfDySaWTKwmq4+OBnc
	ERa398DKbyHXqZuIxCpCBwrLBxBOk0cvp9tk0h2Kuj335IJxiszn/oL/SSsIaaHynBEuohC5Lql
	lf0D7sjq8O1DooiGCTPilUboJFyVjyHz18cLVf0t5n/4lokUD7dAa/cpfktheOkiygTdKaH6HKu
	ZarOqvi+sQV0iHdu6pBv6Y5nSS9WVqL5DtHc3pvwKwiM
X-Google-Smtp-Source: AGHT+IEpjQpHK3+ik7IZ0qu9k6UqkxO+9w+5Qki/aJaLIKQ8RZWFWebkRwvWoVWU/U44TdeefXSUww==
X-Received: by 2002:a17:903:3ba7:b0:226:30f6:1639 with SMTP id d9443c01a7336-22e8bd095a8mr47407615ad.51.1746719192446;
        Thu, 08 May 2025 08:46:32 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:1a9a:3552:f543:e289])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc82893f7sm539545ad.159.2025.05.08.08.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 08:46:31 -0700 (PDT)
Date: Thu, 8 May 2025 09:46:29 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: andersson@kernel.org, afd@ti.com, hnagalla@ti.com, u-kumar1@ti.com,
	jm@ti.com, jan.kiszka@siemens.com, christophe.jaillet@wanadoo.fr,
	jkangas@redhat.com, eballetbo@redhat.com,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 12/35] remoteproc: k3: Refactor mailbox rx_callback
 functions into common driver
Message-ID: <aBzR1YrJ0eWQUlfP@p14s>
References: <20250425104135.830255-1-b-padhi@ti.com>
 <20250425104135.830255-13-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425104135.830255-13-b-padhi@ti.com>

On Fri, Apr 25, 2025 at 04:11:12PM +0530, Beleswar Padhi wrote:
> The mailbox .rx_callback implementations in TI K3 R5, DSP and M4
> remoteproc drivers handle inbound mailbox messages in the same way.
> Introduce a common driver 'ti_k3_common.c' and refactor the
> implementations into a common function 'k3_rproc_mbox_callback'() in it.
> 
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> Tested-by: Judith Mendez <jm@ti.com>
> ---
> v11: Changelog:
> 1. Carried T/B tag.
> 
> Link to v10:
> https://lore.kernel.org/all/20250417182001.3903905-13-b-padhi@ti.com/
> 
> v10: Changelog:
> None
> 
> Link to v9:
> https://lore.kernel.org/all/20250317120622.1746415-11-b-padhi@ti.com/
> 
>  drivers/remoteproc/Makefile               |  4 +-
>  drivers/remoteproc/ti_k3_common.c         | 84 +++++++++++++++++++++++
>  drivers/remoteproc/ti_k3_common.h         |  1 +
>  drivers/remoteproc/ti_k3_dsp_remoteproc.c | 50 +-------------
>  drivers/remoteproc/ti_k3_m4_remoteproc.c  | 49 +------------
>  drivers/remoteproc/ti_k3_r5_remoteproc.c  | 50 +-------------
>  6 files changed, 90 insertions(+), 148 deletions(-)
>  create mode 100644 drivers/remoteproc/ti_k3_common.c
> 
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index 5ff4e2fee4abd..e30908ca4bfcd 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -36,7 +36,7 @@ obj-$(CONFIG_RCAR_REMOTEPROC)		+= rcar_rproc.o
>  obj-$(CONFIG_ST_REMOTEPROC)		+= st_remoteproc.o
>  obj-$(CONFIG_ST_SLIM_REMOTEPROC)	+= st_slim_rproc.o
>  obj-$(CONFIG_STM32_RPROC)		+= stm32_rproc.o
> -obj-$(CONFIG_TI_K3_DSP_REMOTEPROC)	+= ti_k3_dsp_remoteproc.o
> -obj-$(CONFIG_TI_K3_M4_REMOTEPROC)	+= ti_k3_m4_remoteproc.o
> +obj-$(CONFIG_TI_K3_DSP_REMOTEPROC)	+= ti_k3_dsp_remoteproc.o ti_k3_common.o
> +obj-$(CONFIG_TI_K3_M4_REMOTEPROC)	+= ti_k3_m4_remoteproc.o ti_k3_common.o
>  obj-$(CONFIG_TI_K3_R5_REMOTEPROC)	+= ti_k3_r5_remoteproc.o

The R5 driver doesn't need to be compile with ti_k3_common.c?

>  obj-$(CONFIG_XLNX_R5_REMOTEPROC)	+= xlnx_r5_remoteproc.o
> diff --git a/drivers/remoteproc/ti_k3_common.c b/drivers/remoteproc/ti_k3_common.c
> new file mode 100644
> index 0000000000000..7b45e3b416186
> --- /dev/null
> +++ b/drivers/remoteproc/ti_k3_common.c
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * TI K3 Remote Processor(s) driver common code
> + *
> + * Refactored out of ti_k3_r5_remoteproc.c, ti_k3_dsp_remoteproc.c and
> + * ti_k3_m4_remoteproc.c.
> + *
> + * ti_k3_dsp_remoteproc.c:
> + * Copyright (C) 2018-2022 Texas Instruments Incorporated - https://www.ti.com/
> + *	Suman Anna <s-anna@ti.com>
> + *
> + * ti_k3_m4_remoteproc.c:
> + * Copyright (C) 2021-2024 Texas Instruments Incorporated - https://www.ti.com/
> + *	Hari Nagalla <hnagalla@ti.com>
> + */
> +
> +#include <linux/io.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/omap-mailbox.h>
> +#include <linux/platform_device.h>
> +#include <linux/remoteproc.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +
> +#include "omap_remoteproc.h"
> +#include "remoteproc_internal.h"
> +#include "ti_sci_proc.h"
> +#include "ti_k3_common.h"
> +
> +/**
> + * k3_rproc_mbox_callback() - inbound mailbox message handler
> + * @client: mailbox client pointer used for requesting the mailbox channel
> + * @data: mailbox payload
> + *
> + * This handler is invoked by the K3 mailbox driver whenever a mailbox
> + * message is received. Usually, the mailbox payload simply contains
> + * the index of the virtqueue that is kicked by the remote processor,
> + * and we let remoteproc core handle it.
> + *
> + * In addition to virtqueue indices, we also have some out-of-band values
> + * that indicate different events. Those values are deliberately very
> + * large so they don't coincide with virtqueue indices.
> + */
> +void k3_rproc_mbox_callback(struct mbox_client *client, void *data)
> +{
> +	struct k3_rproc *kproc = container_of(client, struct k3_rproc, client);
> +	struct device *dev = kproc->rproc->dev.parent;
> +	struct rproc *rproc = kproc->rproc;
> +	u32 msg = (u32)(uintptr_t)(data);
> +
> +	dev_dbg(dev, "mbox msg: 0x%x\n", msg);
> +
> +	switch (msg) {
> +	case RP_MBOX_CRASH:
> +		/*
> +		 * remoteproc detected an exception, but error recovery is not
> +		 * supported. So, just log this for now
> +		 */
> +		dev_err(dev, "K3 rproc %s crashed\n", rproc->name);
> +		break;
> +	case RP_MBOX_ECHO_REPLY:
> +		dev_info(dev, "received echo reply from %s\n", rproc->name);
> +		break;
> +	default:
> +		/* silently handle all other valid messages */
> +		if (msg >= RP_MBOX_READY && msg < RP_MBOX_END_MSG)
> +			return;
> +		if (msg > rproc->max_notifyid) {
> +			dev_dbg(dev, "dropping unknown message 0x%x", msg);
> +			return;
> +		}
> +		/* msg contains the index of the triggered vring */
> +		if (rproc_vq_interrupt(rproc, msg) == IRQ_NONE)
> +			dev_dbg(dev, "no message was found in vqid %d\n", msg);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(k3_rproc_mbox_callback);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("TI K3 common Remoteproc code");
> diff --git a/drivers/remoteproc/ti_k3_common.h b/drivers/remoteproc/ti_k3_common.h
> index 43aedab9f0aa3..785bb4b17d02f 100644
> --- a/drivers/remoteproc/ti_k3_common.h
> +++ b/drivers/remoteproc/ti_k3_common.h
> @@ -88,4 +88,5 @@ struct k3_rproc {
>  	void *priv;
>  };
>  
> +void k3_rproc_mbox_callback(struct mbox_client *client, void *data);
>  #endif /* REMOTEPROC_TI_K3_COMMON_H */
> diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> index e92fab831670c..7bd1d5a790cb2 100644
> --- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> @@ -24,54 +24,6 @@
>  
>  #define KEYSTONE_RPROC_LOCAL_ADDRESS_MASK	(SZ_16M - 1)
>  
> -/**
> - * k3_dsp_rproc_mbox_callback() - inbound mailbox message handler
> - * @client: mailbox client pointer used for requesting the mailbox channel
> - * @data: mailbox payload
> - *
> - * This handler is invoked by the OMAP mailbox driver whenever a mailbox
> - * message is received. Usually, the mailbox payload simply contains
> - * the index of the virtqueue that is kicked by the remote processor,
> - * and we let remoteproc core handle it.
> - *
> - * In addition to virtqueue indices, we also have some out-of-band values
> - * that indicate different events. Those values are deliberately very
> - * large so they don't coincide with virtqueue indices.
> - */
> -static void k3_dsp_rproc_mbox_callback(struct mbox_client *client, void *data)
> -{
> -	struct k3_rproc *kproc = container_of(client, struct k3_rproc, client);
> -	struct device *dev = kproc->rproc->dev.parent;
> -	const char *name = kproc->rproc->name;
> -	u32 msg = omap_mbox_message(data);
> -
> -	dev_dbg(dev, "mbox msg: 0x%x\n", msg);
> -
> -	switch (msg) {
> -	case RP_MBOX_CRASH:
> -		/*
> -		 * remoteproc detected an exception, but error recovery is not
> -		 * supported. So, just log this for now
> -		 */
> -		dev_err(dev, "K3 DSP rproc %s crashed\n", name);
> -		break;
> -	case RP_MBOX_ECHO_REPLY:
> -		dev_info(dev, "received echo reply from %s\n", name);
> -		break;
> -	default:
> -		/* silently handle all other valid messages */
> -		if (msg >= RP_MBOX_READY && msg < RP_MBOX_END_MSG)
> -			return;
> -		if (msg > kproc->rproc->max_notifyid) {
> -			dev_dbg(dev, "dropping unknown message 0x%x", msg);
> -			return;
> -		}
> -		/* msg contains the index of the triggered vring */
> -		if (rproc_vq_interrupt(kproc->rproc, msg) == IRQ_NONE)
> -			dev_dbg(dev, "no message was found in vqid %d\n", msg);
> -	}
> -}
> -
>  /*
>   * Kick the remote processor to notify about pending unprocessed messages.
>   * The vqid usage is not used and is inconsequential, as the kick is performed
> @@ -155,7 +107,7 @@ static int k3_dsp_rproc_request_mbox(struct rproc *rproc)
>  
>  	client->dev = dev;
>  	client->tx_done = NULL;
> -	client->rx_callback = k3_dsp_rproc_mbox_callback;
> +	client->rx_callback = k3_rproc_mbox_callback;
>  	client->tx_block = false;
>  	client->knows_txdone = false;
>  
> diff --git a/drivers/remoteproc/ti_k3_m4_remoteproc.c b/drivers/remoteproc/ti_k3_m4_remoteproc.c
> index 04095407a483d..a1bcc4b265dfe 100644
> --- a/drivers/remoteproc/ti_k3_m4_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_m4_remoteproc.c
> @@ -21,53 +21,6 @@
>  #include "ti_sci_proc.h"
>  #include "ti_k3_common.h"
>  
> -/**
> - * k3_m4_rproc_mbox_callback() - inbound mailbox message handler
> - * @client: mailbox client pointer used for requesting the mailbox channel
> - * @data: mailbox payload
> - *
> - * This handler is invoked by the K3 mailbox driver whenever a mailbox
> - * message is received. Usually, the mailbox payload simply contains
> - * the index of the virtqueue that is kicked by the remote processor,
> - * and we let remoteproc core handle it.
> - *
> - * In addition to virtqueue indices, we also have some out-of-band values
> - * that indicate different events. Those values are deliberately very
> - * large so they don't coincide with virtqueue indices.
> - */
> -static void k3_m4_rproc_mbox_callback(struct mbox_client *client, void *data)
> -{
> -	struct device *dev = client->dev;
> -	struct rproc *rproc = dev_get_drvdata(dev);
> -	u32 msg = (u32)(uintptr_t)(data);
> -
> -	dev_dbg(dev, "mbox msg: 0x%x\n", msg);
> -
> -	switch (msg) {
> -	case RP_MBOX_CRASH:
> -		/*
> -		 * remoteproc detected an exception, but error recovery is not
> -		 * supported. So, just log this for now
> -		 */
> -		dev_err(dev, "K3 rproc %s crashed\n", rproc->name);
> -		break;
> -	case RP_MBOX_ECHO_REPLY:
> -		dev_info(dev, "received echo reply from %s\n", rproc->name);
> -		break;
> -	default:
> -		/* silently handle all other valid messages */
> -		if (msg >= RP_MBOX_READY && msg < RP_MBOX_END_MSG)
> -			return;
> -		if (msg > rproc->max_notifyid) {
> -			dev_dbg(dev, "dropping unknown message 0x%x", msg);
> -			return;
> -		}
> -		/* msg contains the index of the triggered vring */
> -		if (rproc_vq_interrupt(rproc, msg) == IRQ_NONE)
> -			dev_dbg(dev, "no message was found in vqid %d\n", msg);
> -	}
> -}
> -
>  /*
>   * Kick the remote processor to notify about pending unprocessed messages.
>   * The vqid usage is not used and is inconsequential, as the kick is performed
> @@ -581,7 +534,7 @@ static int k3_m4_rproc_probe(struct platform_device *pdev)
>  
>  	kproc->client.dev = dev;
>  	kproc->client.tx_done = NULL;
> -	kproc->client.rx_callback = k3_m4_rproc_mbox_callback;
> +	kproc->client.rx_callback = k3_rproc_mbox_callback;
>  	kproc->client.tx_block = false;
>  	kproc->client.knows_txdone = false;
>  	kproc->mbox = mbox_request_channel(&kproc->client, 0);
> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> index a6799ce121327..a1dfbe383c13c 100644
> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> @@ -129,54 +129,6 @@ struct k3_r5_core {
>  	bool released_from_reset;
>  };
>  
> -/**
> - * k3_r5_rproc_mbox_callback() - inbound mailbox message handler
> - * @client: mailbox client pointer used for requesting the mailbox channel
> - * @data: mailbox payload
> - *
> - * This handler is invoked by the OMAP mailbox driver whenever a mailbox
> - * message is received. Usually, the mailbox payload simply contains
> - * the index of the virtqueue that is kicked by the remote processor,
> - * and we let remoteproc core handle it.
> - *
> - * In addition to virtqueue indices, we also have some out-of-band values
> - * that indicate different events. Those values are deliberately very
> - * large so they don't coincide with virtqueue indices.
> - */
> -static void k3_r5_rproc_mbox_callback(struct mbox_client *client, void *data)
> -{
> -	struct k3_rproc *kproc = container_of(client, struct k3_rproc, client);
> -	struct device *dev = kproc->rproc->dev.parent;
> -	const char *name = kproc->rproc->name;
> -	u32 msg = omap_mbox_message(data);
> -
> -	dev_dbg(dev, "mbox msg: 0x%x\n", msg);
> -
> -	switch (msg) {
> -	case RP_MBOX_CRASH:
> -		/*
> -		 * remoteproc detected an exception, but error recovery is not
> -		 * supported. So, just log this for now
> -		 */
> -		dev_err(dev, "K3 R5F rproc %s crashed\n", name);
> -		break;
> -	case RP_MBOX_ECHO_REPLY:
> -		dev_info(dev, "received echo reply from %s\n", name);
> -		break;
> -	default:
> -		/* silently handle all other valid messages */
> -		if (msg >= RP_MBOX_READY && msg < RP_MBOX_END_MSG)
> -			return;
> -		if (msg > kproc->rproc->max_notifyid) {
> -			dev_dbg(dev, "dropping unknown message 0x%x", msg);
> -			return;
> -		}
> -		/* msg contains the index of the triggered vring */
> -		if (rproc_vq_interrupt(kproc->rproc, msg) == IRQ_NONE)
> -			dev_dbg(dev, "no message was found in vqid %d\n", msg);
> -	}
> -}
> -
>  /* kick a virtqueue */
>  static void k3_r5_rproc_kick(struct rproc *rproc, int vqid)
>  {
> @@ -356,7 +308,7 @@ static int k3_r5_rproc_request_mbox(struct rproc *rproc)
>  
>  	client->dev = dev;
>  	client->tx_done = NULL;
> -	client->rx_callback = k3_r5_rproc_mbox_callback;
> +	client->rx_callback = k3_rproc_mbox_callback;
>  	client->tx_block = false;
>  	client->knows_txdone = false;
>  
> -- 
> 2.34.1
> 

