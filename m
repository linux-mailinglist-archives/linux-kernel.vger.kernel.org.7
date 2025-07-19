Return-Path: <linux-kernel+bounces-737607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 266A3B0AE50
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 08:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C93C17F56A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 06:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EF522E40F;
	Sat, 19 Jul 2025 06:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v6f7DdJK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A5513AD3F;
	Sat, 19 Jul 2025 06:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752908213; cv=none; b=M+sLl1gKGlAvsfp8ZRjpVt+3G/MfLbt0w+OBBX6UHZNdIaN/XirgWxAxgErutASquVO3snPq3U7shV2MGp0vZxKM2bafir8TNiiQr0KZQlCa7GaHt+C8w1q6kX055o7X58QcxDbNi5s+1D+BwODmehRzv970uBMwmvGlv51UKOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752908213; c=relaxed/simple;
	bh=r6bw3423e8YmtqggTsK4AedE2im5LHqew1In59FP+cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdqWOBllK9dCyJ/u3sl9lj+Nvl495zlvx/uUdIZmlKA2GyL/Hjj7E5r+S5+Sf6MT6dGbJk18bDVnuZK73W8o1YhY/FKjiecg8oPe6MYJvT3Oul0sVRct87CXwKpUe3APba2C1T26+cBTrhgyYV0Y3XXcr1r1SjbGuzdZ1Vvs7KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v6f7DdJK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046F2C4CEE3;
	Sat, 19 Jul 2025 06:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752908212;
	bh=r6bw3423e8YmtqggTsK4AedE2im5LHqew1In59FP+cM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v6f7DdJKgdJuivI7S1S/mCg1pPwsQ8aB7Cu34YiEF3mykd67v0WUibsLotqpEP3TM
	 cLOWc3VvGSR5aXI2wsTYDv0uw6F/TrGknofh05Ow7XQ5+S8J9mTIVJLApOesyWwQ7A
	 nu82/yCcF1IoeXR2KyPdhsERK/6i9LnKTaTop5AA=
Date: Sat, 19 Jul 2025 08:56:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tao Xue <xuetao09@huawei.com>
Cc: Thinh.Nguyen@synopsys.com, prashanth.k@oss.qualcomm.com,
	m.grzeschik@pengutronix.de, Chris.Wulff@biamp.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	caiyadong@huawei.com, suzhuangluan@hisilicon.com,
	weiwenwen3@huawei.com
Subject: Re: [PATCH] usb: gadget : fix use-after-free in
 composite_dev_cleanup()
Message-ID: <2025071946-dilation-elongated-b68f@gregkh>
References: <20250719045612.10739-1-xuetao09@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250719045612.10739-1-xuetao09@huawei.com>

On Sat, Jul 19, 2025 at 12:56:12PM +0800, Tao Xue wrote:
> The pointer cdev->os_desc_req need to be set null when kmalloc failed in
> composite_os_desc_req_prepare(),otherwise the use-after-free issue will
> be encountered in composite_dev_cleanup()
> 
> BUG: KASAN: use-after-free in composite_dev_cleanup+0xf4/0x2c0
> Read of size 8 at addr 0000004827837a00 by task init/1
> 
> CPU: 10 PID: 1 Comm: init Tainted: G           O      5.10.97-oh #1
>  kasan_report+0x188/0x1cc
>  __asan_load8+0xb4/0xbc
>  composite_dev_cleanup+0xf4/0x2c0
>  configfs_composite_bind+0x210/0x7ac
>  udc_bind_to_driver+0xb4/0x1ec
>  usb_gadget_probe_driver+0xec/0x21c
>  gadget_dev_desc_UDC_store+0x264/0x27c
> 
> Fixes: 37a3a533429e ("usb: gadget: OS Feature Descriptors support")
> Signed-off-by: Tao Xue <xuetao09@huawei.com>
> Signed-off-by: weiwenwen <weiwenwen3@huawei.com>

The order of signed-off-by is odd here.  And I need a "full" name for
the last one please.

> ---
>  drivers/usb/gadget/composite.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
> index 8dbc132a505e..385398a039ea 100644
> --- a/drivers/usb/gadget/composite.c
> +++ b/drivers/usb/gadget/composite.c
> @@ -2489,6 +2489,7 @@ int composite_os_desc_req_prepare(struct usb_composite_dev *cdev,
>  	if (!cdev->os_desc_req->buf) {
>  		ret = -ENOMEM;
>  		usb_ep_free_request(ep0, cdev->os_desc_req);
> +		cdev->os_desc_req = NULL;

Can you add a comment here as to why you need to set this to NULL, as it
is not obvious at all.

thanks,

greg k-h

