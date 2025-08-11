Return-Path: <linux-kernel+bounces-762226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DF1B203B0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 885097AF092
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBB71D54FE;
	Mon, 11 Aug 2025 09:31:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFDF3D561
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904663; cv=none; b=hp9rWMoowS/3hO1KmRCnIKZjPMCPr7DkCbwac0lG7VEiOoEw+6l5zuD9Ebyrk4cdNXaBcVpquPRdTSZNV9ZRKp29tr7foalgBrIH1kE7CzOnCOhZpEwrKLNiP2XZqjkPB2xQ1OQZIagLHiuRCbEyq0c3WZHhIF+LJ6OmqDR+RJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904663; c=relaxed/simple;
	bh=U5T+MRdoU2ut8ZfAwliMu6fHkF1NxzjGtnfR/X+ITac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAqbWNY0pTXozHGkm9DQuYNH9EFN0R6pFbuWil4r5SEL1HaXJ0AX7fgbUQZMJ4I7FvQl9UKfisgn0AQdzcrWXci7/w6eqHwErkY8rxWSuj0lzyEWR9jxDn+KcgE9LQQiHz2RgfXWygkJ19yduBuBI2AHgVL1rKoNd4gTi3SwTYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05D07152B;
	Mon, 11 Aug 2025 02:30:52 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4899B3F5A1;
	Mon, 11 Aug 2025 02:30:59 -0700 (PDT)
Date: Mon, 11 Aug 2025 10:30:51 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	"open list:MAILBOX ARM MHUv3" <linux-kernel@vger.kernel.org>,
	"moderated list:MAILBOX ARM MHUv3" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] mailbox: arm_mhuv3: Remove no_free_ptr() to maintain the
 original form of the pointer
Message-ID: <aJm35DGRj2RZ7W9Q@pluto>
References: <20250811082536.377896-1-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811082536.377896-1-liaoyuanhong@vivo.com>

On Mon, Aug 11, 2025 at 04:25:36PM +0800, Liao Yuanhong wrote:
> Remove no_free_ptr() to ensure PTR_ERR() consistently retrieves the correct
> error code.
> 

Hi,

> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  drivers/mailbox/arm_mhuv3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mailbox/arm_mhuv3.c b/drivers/mailbox/arm_mhuv3.c
> index b97e79a5870f..0910da67f8a1 100644
> --- a/drivers/mailbox/arm_mhuv3.c
> +++ b/drivers/mailbox/arm_mhuv3.c
> @@ -945,7 +945,7 @@ static irqreturn_t mhuv3_mbx_comb_interrupt(int irq, void *arg)
>  			if (IS_ERR(data)) {
>  				dev_err(dev,
>  					"Failed to read in-band data. err:%ld\n",
> -					PTR_ERR(no_free_ptr(data)));
> +					PTR_ERR(data));
>  				goto rx_ack;

Yes indeed the cleanup kfree helper takes care to skip any ERR_OR_NULL
by itself...good catch, thanks for this.

Acked-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

