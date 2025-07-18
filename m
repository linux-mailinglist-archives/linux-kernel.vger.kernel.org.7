Return-Path: <linux-kernel+bounces-736249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F227B09A76
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9037617FD3A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 04:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5EE1DAC95;
	Fri, 18 Jul 2025 04:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xn7K4bhI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E4779CD
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 04:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752812095; cv=none; b=kAWFVNYkQPNbg2/yQ9pWMsW9brfHo0qUKzwCaETcuWwqmRJnWlmh5SUoZsYJh7rqJSURgXu/L0gwVrA3y+h9BkOJNuEc9HpGZ7esqpOrPtkFz3DNPrnDAt5CoFnBq3vyHWLV3rmPKIn++UwhUXkfbxI6UtDR+VkL24h/aMe4Mlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752812095; c=relaxed/simple;
	bh=WTcM2M9kmNXsP+5g19CjgmgDeuKz6sK0Y/K74c6qLhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EqsPUYh0FD8AroLTwxynQ5+KmbIKYKYUgrWyv6D3ia+AAd2yyygL38P8ulCEAhJU3GV8s/WxBk6YkPbrKuCPp0CHya8NiUjTBOYQUzsr5oxsFlM2hcqbsPB0zFqUeuhQANgVJEvjjQLr1qHTvBlIoZQU1GM5yWh0lUPYauL8rYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xn7K4bhI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D71DC4CEED;
	Fri, 18 Jul 2025 04:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752812094;
	bh=WTcM2M9kmNXsP+5g19CjgmgDeuKz6sK0Y/K74c6qLhI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xn7K4bhISJNgiqwZjTilQT8pVaxN0woNqzBHvIbvZ4fnjCL6iKAowSlM9EPCL+lrs
	 iKFm64+4vc2JnylFeUirOKNVPITseyxTtD0pVNvI5XUyCY8GGf0XN73YH5ZYjeU0ii
	 uuAeKHVw2iICipRtuyVVsJnQHhtqdTZoOh9Cct39agl9GNW05XCgc3UKtx9qMJhH/M
	 OaMuC1RxzF8WDCvwzaEdBLNmapi9HRiqSi10sn/ydnvQwM6louO0SfET9OXnyNrwK5
	 vybqXwDzfvOJFwQlkmMu7pLoiDdYfd/fFz9vaGwYgu+pFf52VOmomOkK7Cbnkr52TK
	 urma+ArOBaycg==
Message-ID: <b99e0ae6-f273-4c2d-bdc3-dd8b301f2f0b@kernel.org>
Date: Fri, 18 Jul 2025 13:14:51 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] nvme: add capability to connect to an
 administrative controller
To: Kamaljit Singh <kamaljit.singh1@wdc.com>, kbusch@kernel.org,
 axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: cassel@kernel.org
References: <20250718001415.3774178-1-kamaljit.singh1@wdc.com>
 <20250718001415.3774178-2-kamaljit.singh1@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250718001415.3774178-2-kamaljit.singh1@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/07/18 9:14, Kamaljit Singh wrote:
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> 
> Add capability to connect to an administrative controller by
> preventing ioq creation for admin-controllers.
> 
> * Add helper nvme_admin_ctrl() to check for an administrative controller
> * Add helper nvme_override_prohibited_io_queues() to override queue_count
> * Call nvme_override_prohibited_io_queues() from nvme_init_ctrl_finish()
>   so it applies to nvme/tcp and nvme/rdma
> 
> Signed-off-by: Kamaljit Singh <kamaljit.singh1@wdc.com>
> ---
>  drivers/nvme/host/core.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e533d791955d..105127638c31 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3149,6 +3149,21 @@ static inline bool nvme_discovery_ctrl(struct nvme_ctrl *ctrl)
>  	return ctrl->opts && ctrl->opts->discovery_nqn;
>  }
>  
> +static inline bool nvme_admin_ctrl(struct nvme_ctrl *ctrl)
> +{
> +	return ctrl->cntrltype == NVME_CTRL_ADMIN;
> +}
> +
> +/*
> + * An admin controller has one admin queue, but no I/O queues.
> + * Override queue_count so it only creates an admin queue.
> + */
> +static inline void nvme_override_prohibited_io_queues(struct nvme_ctrl *ctrl)
> +{
> +	if (nvme_admin_ctrl(ctrl))
> +		ctrl->queue_count = 1;
> +}
> +
>  static bool nvme_validate_cntlid(struct nvme_subsystem *subsys,
>  		struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>  {
> @@ -3670,6 +3685,12 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl, bool was_suspended)
>  	if (ret)
>  		return ret;
>  
> +	if (nvme_admin_ctrl(ctrl))
> +		dev_dbg(ctrl->device,
> +			"Subsystem %s is an administrative controller",
> +			ctrl->subsys->subnqn);
> +	nvme_override_prohibited_io_queues(ctrl);

I do not think that this inline function is useful. Simply open-code it inside
the if above:

	if (nvme_admin_ctrl(ctrl)) {
		/*
		 * An admin controller has one admin queue, but no I/O queues.
		 * Override queue_count so it only creates an admin queue.
		 */
		dev_dbg(ctrl->device,
			"Subsystem %s is an administrative controller",
			ctrl->subsys->subnqn);
		ctrl->queue_count = 1;
	}

With this, feel free to add:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

