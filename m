Return-Path: <linux-kernel+bounces-895062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D701C4CD5D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C1064F84D9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EA831B810;
	Tue, 11 Nov 2025 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="CK1iDT5h"
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C222FD7DD
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854796; cv=none; b=CW2uNpFJoxyHY0akXK76+Zlzg4aUgDwHOUx9WsDKg7ZARJxyp9W8zNr3mkvs+VXmg4LtU4ee+MAj/yd5TCMpmEyF0SiH37ySDbTaThTiIn+JZ44H1rM+a8C7ugi5DuJTsZ4TFSqseMt5bhfgekHGz2dpUR6UbH6qUwAWv+0pCDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854796; c=relaxed/simple;
	bh=XibWU+b9/RkADHZkBvyaFiNtSPTt+zVdGvhnw2C47Xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=si+6+jEkj47Kpp8RtBg6jkvRxohaDWu8gFaFaFU6+g/tzwoi7gEFpk4+MMEymntEfcwzfuvdwEFhEQg6Lw5nXpoAluk1U/isacTGrii1l1eOTVCaKsjTnaiX9ZgBua/FLGrbaozZQktSDMQPU2oJzrnJDx+gm9jD3h6LhTzIve0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=CK1iDT5h; arc=none smtp.client-ip=80.12.242.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id Il2dvVh0IctOkIl2dvVzyv; Tue, 11 Nov 2025 10:52:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1762854722;
	bh=gfy7N/mDK+VpLubk+NOWvskvwmHqqBPmJx4tUfYEUDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=CK1iDT5h78TDCDCJVut3FTukn6kfp8u9E5nv+falxzhViaXuy1bB/KwPURIcrvV5o
	 DUXwXXWG1m7CFhTSXVUsTF/nIe4W7iOex2qnuMit4hluqk0y30+VMCZrk7Q0u6vkGV
	 4i3zz+5xj9VplSUgN+3jYQskKbiippzWrwgaoB2bPA/NNKAl0qMANU1tzorsxAdSkH
	 BVsUwrnSGWjtvgkrmPjmvYJAFoMd3sjxLchzA+anMBwn6gXRqQutigL7qKOHLQFIzg
	 Q6dzLdeWUcPYz9b+oQdeguevKtXVpes5SIjF6f5f2QCmZYdbpIFJjBJs6Cc2e0cLiY
	 GwCRSuoF9gRwQ==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 11 Nov 2025 10:52:02 +0100
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <3f40d64a-5312-40b1-890d-68d6c5e5203b@wanadoo.fr>
Date: Tue, 11 Nov 2025 10:51:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 4/5] accel/amd_vpci: Add Remote Management (RM) queue
 service APIs
To: David Zhang <yidong.zhang@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, maciej.falkowski@linux.intel.com,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, sonal.santan@amd.com,
 mario.limonciello@amd.com, lizhi.hou@amd.com, Nishad Saraf <nishads@amd.com>
References: <20251111011550.439157-1-yidong.zhang@amd.com>
 <20251111011550.439157-5-yidong.zhang@amd.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <20251111011550.439157-5-yidong.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 11/11/2025 à 02:15, David Zhang a écrit :
> This patch introduces a set of APIs for allowing the PCIe driver submit
> commands, transfer binary payloads and retrieve firmware metadata.
> 
> Key features:
> - RM queue command APIs:
>    - create and destroy RM queue commands
>    - Initialized command data payloads
>    - Send and poll for command completion
> - Service-level operations:
>    - Retrieve firmware ID
>    - Program accelerator and APU firmware images
>    - Periodic health monitoring
> 
> Co-developed-by: Nishad Saraf <nishads@amd.com>
> Signed-off-by: Nishad Saraf <nishads@amd.com>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>

...

> +static void rm_check_health(struct work_struct *w)
> +{
> +	struct rm_device *rdev = to_rdev_health_monitor(w);
> +	u32 max_len = PAGE_SIZE;
> +	struct rm_cmd *cmd;
> +	int ret;
> +
> +	ret = rm_queue_create_cmd(rdev, RM_QUEUE_OP_GET_LOG_PAGE, &cmd);
> +	if (ret)
> +		return;
> +
> +	ret = rm_queue_payload_init(cmd, RM_CMD_LOG_PAGE_AXI_TRIP_STATUS);
> +	if (ret)
> +		goto destroy_cmd;
> +
> +	ret = rm_queue_send_cmd(cmd, RM_CMD_WAIT_CONFIG_TIMEOUT);
> +	if (ret == -ETIME || ret == -EINVAL)
> +		goto payload_fini;
> +
> +	if (ret) {
> +		u32 log_len = cmd->cq_msg.data.page.len;
> +
> +		if (log_len > max_len) {
> +			vdev_warn(rdev->vdev, "msg size %d is greater than requested %d",
> +				  log_len, max_len);
> +			log_len = max_len;
> +		}
> +
> +		if (log_len) {
> +			char *buffer = vzalloc(log_len);
> +
> +			if (!buffer)
> +				goto payload_fini;
> +
> +			ret = rm_queue_copy_response(cmd, buffer, log_len);
> +			if (ret) {
> +				vfree(buffer);
> +				goto payload_fini;
> +			}
> +
> +			vdev_err(rdev->vdev, "%s", buffer);

This looks like the normal path. is vdev_err() expected here?

> +			vfree(buffer);
> +
> +		} else {
> +			vdev_err(rdev->vdev, "firewall check ret%d", ret);
> +		}
> +
> +		rdev->firewall_tripped = 1;
> +	}
> +
> +payload_fini:
> +	rm_queue_payload_fini(cmd);
> +destroy_cmd:
> +	rm_queue_destroy_cmd(cmd);
> +
> +	vdev_dbg(rdev->vdev, "check result: %d", ret);
> +}

...

> +struct rm_device *versal_pci_rm_init(struct versal_pci_device *vdev)
> +{
> +	struct rm_header *header;
> +	struct rm_device *rdev;
> +	u32 status;
> +	int ret;
> +
> +	rdev = devm_kzalloc(&vdev->pdev->dev, sizeof(*rdev), GFP_KERNEL);
> +	if (!rdev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	rdev->vdev = vdev;
> +	header = &rdev->rm_metadata;
> +
> +	rm_shmem_bulk_read(rdev, RM_HDR_OFF, (u32 *)header, sizeof(*header));
> +	if (header->magic != RM_HDR_MAGIC_NUM) {
> +		vdev_err(vdev, "Invalid RM header 0x%x", header->magic);
> +		ret = -ENODEV;
> +		goto err;
> +	}
> +
> +	status = rm_shmem_read(rdev, header->status_off);
> +	if (!status) {
> +		vdev_err(vdev, "RM status %d is not ready", status);

This can be simplified, status is knwon to be 0.

> +		ret = -ENODEV;
> +		goto err;
> +	}

...

CJ

