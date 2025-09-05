Return-Path: <linux-kernel+bounces-803849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69584B46624
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 23:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BD161885A85
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DAE286419;
	Fri,  5 Sep 2025 21:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A257DYfj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5D022129B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 21:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757108965; cv=none; b=u3jso1nJu8yPUGo2Nh8smsKTzUqUw2G2PbycLlVVRP2iMn9AQaIQo5pUPjD+4hR14HgVYxoqiZ3QxNpq1hX16QYw/n+QBoFiiyfNpKJKSVesCk7jNTt5BBvXEXKwe9RnGFbxoIrR5mMeehnvRJcRHdh9FBaDufMM24oRXTilB24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757108965; c=relaxed/simple;
	bh=8rqxU2P26RfovZdy3bMvysD1ArZ5IT9wXUXD021PhVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCe5q0FX1FIwVazocjPFIqxNTP+1UsgFIObpyLio/xWqyoS9rkoHHlCCgIeWHFdw5X+Drf3caHIk8IQUU91vAfhHplG7bCjH6dpZzm7A/EeqWidqr/uhoQAde2xhWXg/kQmSB790rL6yTD8YFfVwtc5/Wk/PPNRB2jkUITzxRvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A257DYfj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7EA6C4CEF1;
	Fri,  5 Sep 2025 21:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757108965;
	bh=8rqxU2P26RfovZdy3bMvysD1ArZ5IT9wXUXD021PhVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A257DYfjQbLn8wfTw8C2eXsFdJ6qMxlepGDijsenuTfCBmMh+6lBfrHvwZhFiKoet
	 FqcwvCM7JXkR0HGZOM6Aao38PM6VlrBe4UN18BU4qRWseDYFZw0KxPNlIk3fuvqVPn
	 GpttiZeEn7P7zGRh/o6rVYIARhBkyzecDY1NHCpFul4g4fFsbHrI4GQwTRjikAS/bl
	 IfM7s4g+6WtpbKjLpKtp/ULW8dYbcU2w2jpy9Gunkb317iEvocwhp5MZ0hXk7duIHW
	 DyvRSY2vNLBvu1hpd//2Xc/AfUimSUAm/z5Rz6wAVYT1T9ZfzjvvVYqRmYt6Ufj58z
	 36mit388J8cIw==
Date: Fri, 5 Sep 2025 15:49:23 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	cassel@kernel.org, dlemoal@kernel.org, kamaljit.singh1@wdc.com
Subject: Re: [PATCH v1 1/1] nvme-core: exclude ioccsz/iorcsz checks for admin
 ctrlr
Message-ID: <aLta40FO1Ud6TZ4T@kbusch-mbp>
References: <20250905211002.1937414-1-kamaljit.singh@opensource.wdc.com>
 <20250905211002.1937414-2-kamaljit.singh@opensource.wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905211002.1937414-2-kamaljit.singh@opensource.wdc.com>

On Fri, Sep 05, 2025 at 02:10:01PM -0700, Kamaljit Singh wrote:
> An administrative controller does not support I/O queues, hence it
> should exclude existing checks for IOCCSZ/IORCSZ.
> 
> Signed-off-by: Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
> ---
>  drivers/nvme/host/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index d67545bd7abb..ac72bae800a9 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3491,14 +3491,14 @@ static int nvme_check_ctrl_fabric_info(struct nvme_ctrl *ctrl, struct nvme_id_ct
>  		return -EINVAL;
>  	}
>  
> -	if (!nvme_discovery_ctrl(ctrl) && ctrl->ioccsz < 4) {
> +	if (!nvmf_discovery_ctrl(ctrl) && !nvme_admin_ctrl(ctrl) && ctrl->ioccsz < 4) {
>  		dev_err(ctrl->device,
>  			"I/O queue command capsule supported size %d < 4\n",
>  			ctrl->ioccsz);
>  		return -EINVAL;
>  	}
>  
> -	if (!nvme_discovery_ctrl(ctrl) && ctrl->iorcsz < 1) {
> +	if (!nvmf_discovery_ctrl(ctrl) && !nvme_admin_ctrl(ctrl) && ctrl->iorcsz < 1) {

Excessive line length over 80 chars.

Perhaps, though, we should have a helper to indicate IO controllers
rather than chaining conditions for everything that isn't one.

