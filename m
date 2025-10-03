Return-Path: <linux-kernel+bounces-841184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2925BB66EF
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 12:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EFDB3ACE98
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 10:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DC02E8DFC;
	Fri,  3 Oct 2025 10:14:00 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8331494DB
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 10:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759486440; cv=none; b=hbUWvY0l92W0WW8MuxXuue9yyDPGdkjUYVgi7avEhPTpHTrumzO6dntouqiMsK5uYxM0gRu5MxtpKPu+oTi1uZh4mat8Y3AzM7uLPOR/Nhvwc5iuJisQ7nzGKwJcspB0fZk7pnCSDLaU3BecjHbcYq+qbPfXEepgzklRmLPZgKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759486440; c=relaxed/simple;
	bh=saHBgdu0s870ggEMLm0aWYMuNl5Bs3Vbzk00hX+rf9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9F8NnG+zHZd9TcaaKUUK8IQ7SUSHLSZE9CV33FU1J2H9aG9rNAxYXWQGFhp8jD3IardpmVTMfWdQj03bJ+l65jZG1V9OGavzJvulAe34JomipIxwiZWIEMfWy091Xm09PnVW1FRD6hvWTmtGrcQKw2X1TUMSfN2Gn40wXU0r2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2E6FF227AAC; Fri,  3 Oct 2025 12:13:54 +0200 (CEST)
Date: Fri, 3 Oct 2025 12:13:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexandr Sapozhnkiov <alsp705@gmail.com>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
	Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH] nvme: target: fix error checking in
 nvmet_fc_schedule_delete_assoc()
Message-ID: <20251003101354.GA15826@lst.de>
References: <20251002092202.11-1-alsp705@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002092202.11-1-alsp705@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Adding Daniel who has been touching this area recently.

On Thu, Oct 02, 2025 at 12:22:01PM +0300, Alexandr Sapozhnkiov wrote:
> From: Alexandr Sapozhnikov <alsp705@gmail.com>
> 
> The nvmet_fc_tgtport_get() function may return an error.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
> ---
>  drivers/nvme/target/fc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 337ee1cb09ae..68a416a92bfc 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -1110,8 +1110,8 @@ nvmet_fc_delete_assoc_work(struct work_struct *work)
>  static void
>  nvmet_fc_schedule_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
>  {
> -	nvmet_fc_tgtport_get(assoc->tgtport);
> -	queue_work(nvmet_wq, &assoc->del_work);
> +	if (nvmet_fc_tgtport_get(assoc->tgtport))
> +		queue_work(nvmet_wq, &assoc->del_work);
>  }
>  
>  static bool
> -- 
> 2.43.0
---end quoted text---

