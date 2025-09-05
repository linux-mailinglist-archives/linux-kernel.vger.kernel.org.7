Return-Path: <linux-kernel+bounces-803391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94668B45E87
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7598B1C82F5C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC51E313274;
	Fri,  5 Sep 2025 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FG0Jc0rC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1366830B506;
	Fri,  5 Sep 2025 16:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757090736; cv=none; b=egRPsd6kqWKQXoFi2KaqVDPfIaC49fszua7sHWoVrIp/VrW1ssMASgegvJ4uyB2SicV6nKw2Q/ygpEYmNNEaQxKNkL/jlTK7ngZihJY45GFICohfxZhQeTtbG/wDmRLYR89013TfzIs5DWmwUj8Cf4Dn/C/3BEcKDsDqDY0Mh1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757090736; c=relaxed/simple;
	bh=J0/c4MhGr5y7EUXllfjjRQh7A9aIyzgaVoFCXpdGxEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YkNRuoKSV5Qaj0xtv66F4hnlV2gu22NFNgpxdGzj6du1YXFVJKCf6fjsCJv5ea1j4VWok6fptzUoiplJ82kYFFHTbLzrrdWbyb6IrSYQvYWWpux1hr16BKHLZ0b8J8wBh1Vdo93NDiZ79Xoggr8/+DPzx1N/yqVgl0KjeXkZmcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FG0Jc0rC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA01C4CEF4;
	Fri,  5 Sep 2025 16:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757090735;
	bh=J0/c4MhGr5y7EUXllfjjRQh7A9aIyzgaVoFCXpdGxEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FG0Jc0rCJvgPJau9CIzVXIWliIv/qxApqxOehawfDhv3iEsFOu7c77tUX6zV5oWUk
	 nYMbd7cfCTqwBSampW5IyexZFQKUzqA/z0VEPjO7528h1P1gCf/cahfgkjvlJhneNy
	 E9b4yi9TvJMELzuHT0wNC4VQl41M/X9WInBsBOZ314SB1PpbQpx5TYZaZjhEE1cIrm
	 0okZxnNY8Kw5JnvglNUQHFgRpjUZs1crM2Z8W8SWjUUG7wJX807kUZvu9jrEzu3HQF
	 4dudCLvYsJElPJdGqQmbH0sXysdTzkt9EEAP4DyS2hFIkSwBZ8jsuX+ZzGNXQiBZWe
	 ZlRQfJbyCE3/A==
Date: Fri, 5 Sep 2025 22:15:28 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Adam Xue <zxue@semtech.com>
Cc: jeff.hugo@oss.qualcomm.com, quic_yabdulra@quicinc.com, 
	chentao@kylinos.cn, quic_mattleun@quicinc.com, krishna.chundru@oss.qualcomm.com, 
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imocanu@semtech.com
Subject: Re: [PATCH v3] Fix potential kernel panic by calling dev_err
Message-ID: <6lge6p5e3ulcy5pbencvhjfhcwrfsptvclxyu53z3t7anwyrj6@bxbidmvaiql5>
References: <20250904183405.32986-1-zxue@semtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250904183405.32986-1-zxue@semtech.com>

On Thu, Sep 04, 2025 at 11:34:05AM GMT, Adam Xue wrote:

Missing subject prefix:

	bus: mhi: host:

> In mhi_init_irq_setup, the device pointer used for dev_err was not initialized.
>  Use the pointer from mhi_cntrl instead.
> 

You need to add relevant fixes tag and CC stable list. Below tags are valid for
this fix:

Fixes: b0fc0167f254 ("bus: mhi: core: Allow shared IRQ for event rings")
Fixes: 3000f85b8f47 ("bus: mhi: core: Add support for basic PM operations")

- Mani

> Signed-off-by: Adam Xue <zxue@semtech.com>
> ---
>  drivers/bus/mhi/host/init.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> index 7f72aab38ce9..099be8dd1900 100644
> --- a/drivers/bus/mhi/host/init.c
> +++ b/drivers/bus/mhi/host/init.c
> @@ -194,7 +194,6 @@ static void mhi_deinit_free_irq(struct mhi_controller *mhi_cntrl)
>  static int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
>  {
>  	struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
> -	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>  	unsigned long irq_flags = IRQF_SHARED | IRQF_NO_SUSPEND;
>  	int i, ret;
>  
> @@ -221,7 +220,7 @@ static int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
>  			continue;
>  
>  		if (mhi_event->irq >= mhi_cntrl->nr_irqs) {
> -			dev_err(dev, "irq %d not available for event ring\n",
> +			dev_err(mhi_cntrl->cntrl_dev, "irq %d not available for event ring\n",
>  				mhi_event->irq);
>  			ret = -EINVAL;
>  			goto error_request;
> @@ -232,7 +231,7 @@ static int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
>  				  irq_flags,
>  				  "mhi", mhi_event);
>  		if (ret) {
> -			dev_err(dev, "Error requesting irq:%d for ev:%d\n",
> +			dev_err(mhi_cntrl->cntrl_dev, "Error requesting irq:%d for ev:%d\n",
>  				mhi_cntrl->irq[mhi_event->irq], i);
>  			goto error_request;
>  		}
> -- 
> 2.43.0
> 
> 
> To view our privacy policy, including the types of personal information we collect, process and share, and the rights and options you have in this respect, see www.semtech.com/legal.

-- 
மணிவண்ணன் சதாசிவம்

