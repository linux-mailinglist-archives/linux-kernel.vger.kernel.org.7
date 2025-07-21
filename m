Return-Path: <linux-kernel+bounces-738840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F83EB0BE02
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 09:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 927D517A604
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 07:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353FA27F000;
	Mon, 21 Jul 2025 07:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XBHK/HgY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FE3E555;
	Mon, 21 Jul 2025 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753083994; cv=none; b=ahYrztj+EPXRez+BgZEz8YalzbtNVdPW1Dxii83XtiO0y89gY1LN2wR4PJWw2PSbmHWybTI1k+Khvy5VxgDti0S32KxSiK9hz6DBO1I1YCQWtunNIP6FrlPKggfgoqQUscvIJPfcFOncBxdWClv5Smfpi+Zn0K2AYixA9K/qnbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753083994; c=relaxed/simple;
	bh=6PraR24UPK00rb1bzZXXtk9wnPTp2FVqYNTVjH72N4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnqkgEgveNk055rOsBYEPWhIER9bELQMRltmeCYRNYhJar7u96CkYK1doL4wVoeWSWXu5YZTf/xXrEqs0p280CYX3cUUY7RatoiRU764fbO1ECC+yOT1PPdiNaCTGGI7EgWHvoHMjeJVBTDv2AGquIornz2WL04/F6U6X3ga5XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XBHK/HgY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB019C4CEF1;
	Mon, 21 Jul 2025 07:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753083994;
	bh=6PraR24UPK00rb1bzZXXtk9wnPTp2FVqYNTVjH72N4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XBHK/HgYEebg6tPeeY+BVG1JHAslYcG+5Uhm0iPJha4ty+GkvOr3q/bjUQuyoICVJ
	 QvR9asqBIttv31a/jEnN+9dycqaQbbiZKVwv7TKFr74TAPVSM4J9ZtmxjG1u9svkq/
	 Pi3zvuxKZOOaD1w2QkAyVjXECOZ4CBWMPNKiORyE=
Date: Mon, 21 Jul 2025 09:46:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tao Xue <xuetao09@huawei.com>
Cc: Thinh.Nguyen@synopsys.com, prashanth.k@oss.qualcomm.com,
	m.grzeschik@pengutronix.de, Chris.Wulff@biamp.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	caiyadong@huawei.com, suzhuangluan@hisilicon.com,
	weiwenwen3@huawei.com
Subject: Re: [PATCH v3] usb: gadget : fix use-after-free in
 composite_dev_cleanup()
Message-ID: <2025072118-linguini-carded-fcfb@gregkh>
References: <20250721072946.14638-1-xuetao09@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721072946.14638-1-xuetao09@huawei.com>

On Mon, Jul 21, 2025 at 03:29:46PM +0800, Tao Xue wrote:
> 1. In func configfs_composite_bind() -> composite_os_desc_req_prepare():
> if kmalloc fails, the pointer cdev->os_desc_req will be freed but not
> set to NULL. Then it will return a failure to the upper-level function.
> 2. in func configfs_composite_bind() -> composite_dev_cleanup():
> it will checks whether cdev->os_desc_req is NULL. If it is not NULL, it
> will attempt to use it.This will lead to a use-after-free issue.
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
> v3: add comment in patch
> v2: update Signed-off and commit message
> v1: initial submission
> 
>  drivers/usb/gadget/composite.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
> index 8dbc132a505e..adf0a79b3d3d 100644
> --- a/drivers/usb/gadget/composite.c
> +++ b/drivers/usb/gadget/composite.c
> @@ -2489,6 +2489,11 @@ int composite_os_desc_req_prepare(struct usb_composite_dev *cdev,
>  	if (!cdev->os_desc_req->buf) {
>  		ret = -ENOMEM;
>  		usb_ep_free_request(ep0, cdev->os_desc_req);
> +		/* composite_dev_cleanup() will check whether cdev->os_desc_req
> +		 * is NULL and will use it when it is not NULL, so we need to set
> +		 * NULL here.
> +		 */

Didn't checkpatch complain that this is not the correct way to do a
multi-line comment?

And that's a bit verbose, how about
		/* Set os_desc_req to NULL so that composite_dev_cleanup() will not try to free it again */

And you ignored my patch bot for some reason :(

{sigh}


