Return-Path: <linux-kernel+bounces-738697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08ABAB0BC0B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 07:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3677D1771FF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 05:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E94D190072;
	Mon, 21 Jul 2025 05:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TvT+ZUze"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C09C1E489;
	Mon, 21 Jul 2025 05:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753076356; cv=none; b=YsDDC9QL5C4TMpqTjWvjnFOGvEDA5udpyk2aPyjRVqRWgV5L6hiocXUcuLgsxjOPMopbkrTFQvER6l/R6TeRwFOEOkqsyBcxLj6YhHWKdNePYO2y1ZJLLQuEeXxjzNHBUF5DfofhQc1F+2WP0Y2T+tiG6U8/44+P2hCLe1djLGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753076356; c=relaxed/simple;
	bh=IzjSet9jg6pPQtROJFXhSSwZmbVirJFjosi+fTcj+VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdUDaZov1oM+IivJrBNcM1MTnHkoFAGcbpchrE0/sgsMB0Za63yOmwZdCbfvqyrZPOp5XvKJM0ymuiNsH3lcovtTVXG8n+SGmPNx3ncN23M6OM0Ot52JI1njTUeV3wqpAfS4YhbjIfBdy0loJbLt8RLRc4HeoaO6AtdHXDaFGCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TvT+ZUze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD03C4CEF1;
	Mon, 21 Jul 2025 05:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753076355;
	bh=IzjSet9jg6pPQtROJFXhSSwZmbVirJFjosi+fTcj+VY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TvT+ZUzeKAiWxGbFyrZ//e+ucHLsFvGU0K50RrJGmnYamDc1SMMjyw3LxoAqgMCxK
	 +31Fs8shuABGeq4UFrulyFTliakeY8X/rCV4zytFCD5h67W2LweNu/UNMwNDuD79WH
	 e1BX1Ob14B7Be5x09jdy7o0Y0lrWXik4707FuqVA=
Date: Mon, 21 Jul 2025 07:39:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tao Xue <xuetao09@huawei.com>
Cc: Thinh.Nguyen@synopsys.com, prashanth.k@oss.qualcomm.com,
	m.grzeschik@pengutronix.de, Chris.Wulff@biamp.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	caiyadong@huawei.com, suzhuangluan@hisilicon.com,
	weiwenwen3@huawei.com
Subject: Re: [PATCH v2] usb: gadget : fix use-after-free in
 composite_dev_cleanup()
Message-ID: <2025072150-unfunded-washable-b524@gregkh>
References: <20250721035849.11330-1-xuetao09@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721035849.11330-1-xuetao09@huawei.com>

On Mon, Jul 21, 2025 at 11:58:49AM +0800, Tao Xue wrote:
> 1. In func configfs_composite_bind() -> composite_os_desc_req_prepare():
> if kmalloc fails, the pointer cdev->os_desc_req will be freed but not
>  set to NULL. Then it will return a failure to the upper-level function.
> 2. in func configfs_composite_bind() -> composite_dev_cleanup():
> it will checks whether cdev->os_desc_req is NULL. If it is not NULL, it
>  will attempt to use it.This will lead to a use-after-free issue.
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
> ---
> v2: update Signed-off and commit message
> v1: initial submission
> 
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

Please add a comment here as to why this must be set to NULL at this
point in time, as it is not obvious at all.

thanks,

greg k-h

