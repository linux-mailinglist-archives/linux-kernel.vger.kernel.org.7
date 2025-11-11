Return-Path: <linux-kernel+bounces-895029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3666FC4CC28
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAC114E2FC2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19672EDD64;
	Tue, 11 Nov 2025 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="MyrqbHIw"
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B2D2586E8
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854268; cv=none; b=EawF14/6XZziuR4oFBdgBw4Cp9Woyy6D6xYTpY8Ln/tmtOXoCDDMppfTClYRZyxCcCDZwzB8iDCZtDFPsMqPePU0hAXzI85Dh+jfvLnLZCajYfHQyENwa/9u0XWkKorD9sf28LNh2VgUDFmJlSrDSVf/1IwxpIUnhIRgmBFq5Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854268; c=relaxed/simple;
	bh=t7YrpOqHhlDtbCitd87M+XXffXg81eiU0GnPjZ+GryA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KPS6iHUMZNCHMlv+kmm6axpvITkRP1r7H4IARNl9JXwN8Kh2Kq/PLkCRpmL8sAVuWwTwZyN3b3n9IIKCoxjbBRY6HQ0FN301jtxztR4Cd1qEyh+pMU8xuYMwLbD3Uz/v36MGrCi8jSmy9pTP5NOFk3hux52hM7I2ez0JJI8feHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=MyrqbHIw; arc=none smtp.client-ip=80.12.242.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id Ikv8vvv4mV77oIkv9vtG0N; Tue, 11 Nov 2025 10:44:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1762854257;
	bh=CHfLli/YyfFwV3T0yFA5G67pC7Ph9J6EzmMhdJSTX8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=MyrqbHIwDIIicrv0dBc9pNSUOif9qqZ3Q74BUyuUG1+zXfgFU0lbDirwv10WniNvE
	 rpD9UL+grgg+40XvtnkngWeCx8xhVlpzXrzr+M6KEmQ7UsG5MF+EbVTJrLlSagSQHC
	 yEyuCfK2BpKelwB1h9BXz6G+vP2I6Fn8Lt4Cdy2lDhrpL7kMVVWdGTTz0Ej4bmLF7i
	 MpsGvTklr9drVCRxy29UCnCESthcl6okud7P0l+RvE5YWQTq1yowP+MBboUpug4UsI
	 97D612mB25qwdaNeavvsy/yFeH8vQiL2LYklYvLkHqeUFaVvh1Nu9D6qbnCANbKFPE
	 CbzWXS+pBLuQA==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 11 Nov 2025 10:44:17 +0100
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <269e26c5-556c-47c5-bd1a-163bf2386365@wanadoo.fr>
Date: Tue, 11 Nov 2025 10:44:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 3/5] accel/amd_vpci: Add Remote Management(RM) queue
 infrastructure
To: David Zhang <yidong.zhang@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, maciej.falkowski@linux.intel.com,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, sonal.santan@amd.com,
 mario.limonciello@amd.com, lizhi.hou@amd.com, Nishad Saraf <nishads@amd.com>
References: <20251111011550.439157-1-yidong.zhang@amd.com>
 <20251111011550.439157-4-yidong.zhang@amd.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <20251111011550.439157-4-yidong.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 11/11/2025 à 02:15, David Zhang a écrit :
> This patch introduces a Remote Management (RM) queue service, which
> provides a way to communicate between the management PCIe function (PF0)
> and the embedded firmware running on AMD Versal SoCs.
> 
> The RM service implements a hardware-based ring buffer for bidirectional
> command and response exchange between the host driver and the firmware.
> 
> This patch adds the core infrastructure for:
>    - Initializing and managing the RM queue
>    - Submitting commands to the embedded firmware
>    - Polling for command completion
> 
> Subsequent patches will integrate the infrastructure with the firmware
> management logic to enable firmware download, status query, and other
> control operations.
> 
> Co-developed-by: Nishad Saraf <nishads@amd.com>
> Signed-off-by: Nishad Saraf <nishads@amd.com>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>

...

> diff --git a/drivers/accel/amd_vpci/versal-pci-rm-service.h b/drivers/accel/amd_vpci/versal-pci-rm-service.h
> new file mode 100644
> index 000000000000..d2397a1a672c
> --- /dev/null
> +++ b/drivers/accel/amd_vpci/versal-pci-rm-service.h

...

> +#define RM_CMD_ID_MIN			1
> +#define RM_CMD_ID_MAX			(BIT(17) - 1)
> +#define RM_CMD_SQ_HDR_OPS_MSK		GENMASK(15, 0)
> +#define RM_CMD_SQ_HDR_SIZE_MSK		GENMASK(14, 0)
> +#define RM_CMD_SQ_SLOT_SIZE		SZ_512
> +#define RM_CMD_CQ_SLOT_SIZE		SZ_16
> +#define RM_CMD_CQ_BUFFER_SIZE		(1024 * 1024)

SZ_1M to be consistent with other xx_SIZE macro?

> +#define RM_CMD_CQ_BUFFER_OFFSET		0x0
> +#define RM_CMD_LOG_PAGE_TYPE_MASK	GENMASK(15, 0)
> +#define RM_CMD_VMR_CONTROL_MSK		GENMASK(10, 8)
> +#define RM_CMD_VMR_CONTROL_PS_MASK	BIT(9)
> +
> +#define RM_CMD_WAIT_CONFIG_TIMEOUT	msecs_to_jiffies(10 * 1000)
> +#define RM_CMD_WAIT_DOWNLOAD_TIMEOUT	msecs_to_jiffies(300 * 1000)

secs_to_jiffies() maybe to be less verbose?

> +
> +#define RM_COMPLETION_TIMER		(HZ / 10)
> +#define RM_HEALTH_CHECK_TIMER		(HZ)

...

CJ

