Return-Path: <linux-kernel+bounces-895046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5092AC4CC97
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43FBD424F0E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913AE2F2617;
	Tue, 11 Nov 2025 09:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="dxduQ7ps"
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FDF2F1FC7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854444; cv=none; b=BXC7gQxH8VPe3f7VsfyuXVnLAsFqSeVCBSkMB8MmrK0ZYjobhmJDFw2/dqtNVUXwV/hqOgyeSFdgelxVcAM1XP81/prZiu4vNMLsAQo2JuJqwm/+pzPUmzVVqhFILPl9TN9mcIg5gftkiYjvqHhPA+8948W3Hnud5oBHKH/ME04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854444; c=relaxed/simple;
	bh=UAxszELuEnpSmtdc2G6CcBbKlzk0ns7ac3g+hNCk1FQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pQonswuJ4Y23xB/hxbwbRgbDoDte14CvrJ01fp3Rw8qNiEEk1gX3O9ZeKceZUVoU4TOLbpYksoiu2gzhS4k95LYCMsG+RRbZwLJDOy7M8VwyIrZ4cns+c8N6TBfGnk25jNYrAE3/1TxPqzLwKxkyL1x1D1ApF0hcclYP4sM/Z6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=dxduQ7ps; arc=none smtp.client-ip=80.12.242.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id IkpUvNVrnw5gXIkpUvZHmg; Tue, 11 Nov 2025 10:38:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1762853907;
	bh=CD71TS+f0jBrjomTVL8fc9Sskt5DCQsvmFsPOOKDSDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=dxduQ7psZTs8B8HCU2xIs+rtlY6iD6SukMsvtmTHlMVDyQrMLIvSw56EJhOjwG2uO
	 v7glFRMXtZBfaUDaQaILHII+5k5/XsLX9r+U0hzXDtnlCsNe69977nVdxUpFMe0/VW
	 6Y3VXxAx5XMaJLEN5ihiMS2Ej6iJfC8qVRlKjKKAXQ3OlBFL7CV3h8jja63Q/++lkP
	 5FLfV4EuQfaexqlYVtYsqHhttBv3uGAenfhQlU0b57c4bYU8C+Djd+ut2O3J72U9Dq
	 8JcclhNkiQCRR2ZGV4bOF1VEmPYHQSTYba7egq1VTigRKer+xeis55R8mnDJuvAu5k
	 Yc7j8M2NsMKpA==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 11 Nov 2025 10:38:27 +0100
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <91aad9d6-f408-4716-a45f-7ad3199ee36f@wanadoo.fr>
Date: Tue, 11 Nov 2025 10:38:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 2/5] accel/amd_vpci: Add new driver for AMD Versal PCI
 accelerator
To: David Zhang <yidong.zhang@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, maciej.falkowski@linux.intel.com,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, sonal.santan@amd.com,
 mario.limonciello@amd.com, lizhi.hou@amd.com,
 DMG Karthik <Karthik.DMG@amd.com>, Nishad Saraf <nishads@amd.com>
References: <20251111011550.439157-1-yidong.zhang@amd.com>
 <20251111011550.439157-3-yidong.zhang@amd.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <20251111011550.439157-3-yidong.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 11/11/2025 à 02:15, David Zhang a écrit :
> This patch introduces a new PCI driver for AMD Versal-based accelerator
> cards.
> 
> The driver provides basic module and PCI device initialization, based on
> BAR resources used to establish a hardware queue-based ring buffer between
> the PCIe host and the Versal Management Runtime (VMR) service running on
> the embedded SoC. This interface enables firmware management and board
> health monitoring.
> 
> Key features:
>     - PCI probe and BAR resource initialization.
>     - Integration with configfs for firmware management
>     - Compatibility check using firmware-reported UUIDs
> 
> The base firmware image is expected under /lib/firmware/xilinx/<fw_name>
> and can be programmed to the device through the configfs interface.
> Firmware transfer is handled via a remote queue service (added in a later
> patch).
> 
> Co-developed-by: DMG Karthik <Karthik.DMG@amd.com>
> Signed-off-by: DMG Karthik <Karthik.DMG@amd.com>
> Co-developed-by: Nishad Saraf <nishads@amd.com>
> Signed-off-by: Nishad Saraf <nishads@amd.com>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
> ---

...

> +static int versal_pci_device_setup(struct versal_pci_device *vdev)
> +{
> +	int ret;
> +
> +	ret = versal_pci_fw_init(vdev);
> +	if (ret) {
> +		vdev_err(vdev, "Failed to init fw, err %d", ret);
> +		goto comm_chan_fini;
> +	}
> +
> +	ret = versal_pci_cfs_init(vdev);
> +	if (ret) {

Do we need to call versal_pci_fw_fini()?
(here or in the error handling path to be future proof)

> +		vdev_err(vdev, "Failed to init configfs subsys, err %d", ret);
> +		goto comm_chan_fini;
> +	}
> +
> +	return 0;
> +
> +comm_chan_fini:
> +
> +	return ret;
> +}

...

> diff --git a/drivers/accel/amd_vpci/versal-pci.h b/drivers/accel/amd_vpci/versal-pci.h
> new file mode 100644
> index 000000000000..ca309aee87ad
> --- /dev/null
> +++ b/drivers/accel/amd_vpci/versal-pci.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Driver for Versal PCIe device
> + *
> + * Copyright (C) 2025 Advanced Micro Devices, Inc. All rights reserved.
> + */
> +
> +#ifndef __VERSAL_PCI_H
> +#define __VERSAL_PCI_H
> +
> +#include <linux/configfs.h>
> +#include <linux/firmware.h>
> +
> +#define MGMT_BAR		0
> +
> +#define vdev_info(vdev, fmt, args...)					\
> +	dev_info(&(vdev)->pdev->dev, "%s: "fmt, __func__, ##args)

\n could be added after fmt, as it is not included in the messages 
themselves, when used.

Same for the other macro below.

> +
> +#define vdev_warn(vdev, fmt, args...)					\
> +	dev_warn(&(vdev)->pdev->dev, "%s: "fmt, __func__, ##args)
> +
> +#define vdev_err(vdev, fmt, args...)					\
> +	dev_err(&(vdev)->pdev->dev, "%s: "fmt, __func__, ##args)
> +
> +#define vdev_dbg(vdev, fmt, args...)					\
> +	dev_dbg(&(vdev)->pdev->dev, fmt, ##args)

...

CJ

