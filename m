Return-Path: <linux-kernel+bounces-886517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E796C35CDF
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E82D560CCF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5392531BCBC;
	Wed,  5 Nov 2025 13:20:37 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1E22E62D4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 13:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762348837; cv=none; b=Sye1k2ojnnIqIcBbXZzpRBHR1MYAtX5M0N1GtaYBu+jww5XQfcFDaahxW7zorPhL/XJcjWMnQhWs2jTMUyVZobdwFJjKbRcvlJ84VT1FM/OfHXHhJN8OYUPIb3RYCGuVTZ6pr0Swz+DMbJJZq5r74PKT6E8y4VfAD4JKTxKhOM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762348837; c=relaxed/simple;
	bh=WMCSDA99bKnGUne3ckWxyqvNPl6HTTZOpcaLnW4wIE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5WyZH0qCSisLVvRUjJQgMbUT394tcFAP0kXCzBKhYb9APe+I2o/R6+/BTJDQSkPxjUL0XwylL4uNCtVeuRhTiRbNx6cMNyWTPbaChgjWmciX63ZpGH1uMlEzq0RII05QYBM1H5Z3Q6zmqaKciY/ugQ0KguJFD6k/z1WM45Rq4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4A727227AAA; Wed,  5 Nov 2025 14:20:24 +0100 (CET)
Date: Wed, 5 Nov 2025 14:20:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: hare@suse.de, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2] nvmet-auth: update sc_c in target host hash
 calculation
Message-ID: <20251105132023.GC19044@lst.de>
References: <20251104231414.1150771-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104231414.1150771-1-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

>  4 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index a01178caf15b..19980122d3d5 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -492,6 +492,7 @@ static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
>  	ret = crypto_shash_update(shash, buf, 2);
>  	if (ret)
>  		goto out;
> +	memset(buf, 0, sizeof(buf));
>  	*buf = chap->sc_c;
>  	ret = crypto_shash_update(shash, buf, 1);

I'm really confused about both the existing code and this fixup.

Why isn't chap->sc_c directly passed to crypto_shash_update here?
Why do we need to memset buf when only a single byte is passed to
crypto_shash_update?

>  	ret = crypto_shash_update(shash, buf, 2);
>  	if (ret)
>  		goto out;
> -	*buf = sc_c;
> +	*buf = req->sq->sc_c;
>  	ret = crypto_shash_update(shash, buf, 1);

Just pass it directly here?

>  	if (ret)
>  		goto out;
> @@ -378,6 +378,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
>  	ret = crypto_shash_update(shash, ctrl->hostnqn, strlen(ctrl->hostnqn));
>  	if (ret)
>  		goto out;
> +	memset(buf, 0, sizeof(buf));
>  	ret = crypto_shash_update(shash, buf, 1);

just have a

	sttic const u8 zero = 0;

and use that here instead of the memset?


