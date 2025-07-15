Return-Path: <linux-kernel+bounces-732628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7345B069C4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 01:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E8A4E5F66
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 23:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D527D2D541B;
	Tue, 15 Jul 2025 23:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQ0U49Ad"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405CF19F464
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 23:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752621269; cv=none; b=KPYcG5nKrM80+hfafVesiblDfSRvB7aDYw29AmrNp0Roosy10FViIRhQhHjU5m8n3juU+NYWSknGba55M0X4dvQBs9fRKAyqBUeqV9ldTEkPBj05c84AnT+Md0Io2qlv0uu5yyDd5AzWET6i+yjLJ757511ViJ8w6RtovMZMsC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752621269; c=relaxed/simple;
	bh=rfBtyqXY8rhywUkEMeVOyTnMFXFkjdOjRkkh6U0nA9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pzdt8g2G+NoC3y7FWyb2/AzyPoQx6l8M0FuYcpd3oACsp4N394eBYkEh/6kXXys0NJs+3E/RzHB+2cFh2YGDDkschZraOhywHY4rPW6zAA9xYykWDJbI/SzwS6ETKKd61dqbKBXvaNR1ryn2zgHYUMboqrNphwerkoFXBOMvgxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQ0U49Ad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D17C4CEE3;
	Tue, 15 Jul 2025 23:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752621268;
	bh=rfBtyqXY8rhywUkEMeVOyTnMFXFkjdOjRkkh6U0nA9Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YQ0U49AdhwuiL+X7IAQjAQibQKS2AGzVMrJwmq4TSZ4Zi0aKDgYzD4vHRhLmgPjNZ
	 8dMz7DD+C+cJPkzA+m/ZO782kZ9s2IE9mCobDNndNC7tlyNgqzYHjJFFVNXcv/sviD
	 gHuT4s1i1eCE/RK6eJBldvQ3VsJ86TxCuawBUDVfzyx5WQlKHY9nzbJeM2WJ+vNENN
	 DOicIUMX/OjIGzDrKkoxSWDW3IhF1Hjd42eR+K9qMwpA00NoDzfhGYbkpvWnBhfHSk
	 rUdXmErFAkTGKo46kY8GYXQFZrjNBKL92Ktn+5INf2M2DzaWEQBvzUTjKPja2DBYO9
	 UXES9geIEUmag==
Message-ID: <9a825e2c-7183-4c1e-afae-a8c55e27a70e@kernel.org>
Date: Wed, 16 Jul 2025 08:14:26 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: pci-epf: Do not complete commands twice if
 nvmet_req_init() fails
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: rick.wertenbroek@heig-vd.ch, alberto.dassatti@heig-vd.ch,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250715091826.3970789-1-rick.wertenbroek@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250715091826.3970789-1-rick.wertenbroek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/25 18:18, Rick Wertenbroek wrote:
> Have nvmet_req_init() and req->execute() complete failed commands.
> 
> Description of the problem:
> nvmet_req_init() calls __nvmet_req_complete() internally upon failure,
> e.g., unsupported opcode, which calls the "queue_response" callback,
> this results in nvmet_pci_epf_queue_response() being called, which will
> call nvmet_pci_epf_complete_iod() if data_len is 0 or if dma_dir is
> different than DMA_TO_DEVICE. This results in a double completion as
> nvmet_pci_epf_exec_iod_work() also calls nvmet_pci_epf_complete_iod()
> when nvmet_req_init() fails.
> 
> Steps to reproduce:
> On the host send a command with an unsupported opcode with nvme-cli,
> For example the admin command "security receive"
> $ sudo nvme security-recv /dev/nvme0n1 -n1 -x4096
> 
> This triggers a double completion as nvmet_req_init() fails and
> nvmet_pci_epf_queue_response() is called, here iod->dma_dir is still
> in the default state of "DMA_NONE" as set by default in
> nvmet_pci_epf_alloc_iod(), so nvmet_pci_epf_complete_iod() is called.
> Because nvmet_req_init() failed nvmet_pci_epf_complete_iod() is also
> called in nvmet_pci_epf_exec_iod_work() leading to a doubple completion.
> 
> This patch lets nvmet_req_init() and req->execute() complete all failed
> commands, and removes the double completion case in
> nvmet_pci_epf_exec_iod_work() therefore fixing the edge cases where
> double completions occurred.
> 
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> ---
>  drivers/nvme/target/pci-epf.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
> index a4295a5b8d28..aad828eb72d6 100644
> --- a/drivers/nvme/target/pci-epf.c
> +++ b/drivers/nvme/target/pci-epf.c
> @@ -1243,7 +1243,7 @@ static void nvmet_pci_epf_queue_response(struct nvmet_req *req)
>  	iod->status = le16_to_cpu(req->cqe->status) >> 1;
>  
>  	/* If we have no data to transfer, directly complete the command. */

Maybe change this comment to:

	/*
	 * If the command failed or we have no data to transfer, complete
	 * the command immediately.
	 */

Other than this, this looks good, so feel free to add:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> -	if (!iod->data_len || iod->dma_dir != DMA_TO_DEVICE) {
> +	if (iod->status || !iod->data_len || iod->dma_dir != DMA_TO_DEVICE) {
>  		nvmet_pci_epf_complete_iod(iod);
>  		return;
>  	}
> @@ -1604,8 +1604,13 @@ static void nvmet_pci_epf_exec_iod_work(struct work_struct *work)
>  		goto complete;
>  	}
>  
> +	/*
> +	 * If nvmet_req_init() fails (e.g., unsupported opcode) it will call
> +	 * __nvmet_req_complete() internally which will call
> +	 * nvmet_pci_epf_queue_response() and will complete the command directly.
> +	 */
>  	if (!nvmet_req_init(req, &iod->sq->nvme_sq, &nvmet_pci_epf_fabrics_ops))
> -		goto complete;
> +		return;
>  
>  	iod->data_len = nvmet_req_transfer_len(req);
>  	if (iod->data_len) {
> @@ -1643,10 +1648,11 @@ static void nvmet_pci_epf_exec_iod_work(struct work_struct *work)
>  
>  	wait_for_completion(&iod->done);
>  
> -	if (iod->status == NVME_SC_SUCCESS) {
> -		WARN_ON_ONCE(!iod->data_len || iod->dma_dir != DMA_TO_DEVICE);
> -		nvmet_pci_epf_transfer_iod_data(iod);
> -	}
> +	if (iod->status != NVME_SC_SUCCESS)
> +		return;
> +
> +	WARN_ON_ONCE(!iod->data_len || iod->dma_dir != DMA_TO_DEVICE);
> +	nvmet_pci_epf_transfer_iod_data(iod);
>  
>  complete:
>  	nvmet_pci_epf_complete_iod(iod);


-- 
Damien Le Moal
Western Digital Research

