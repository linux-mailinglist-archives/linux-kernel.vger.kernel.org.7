Return-Path: <linux-kernel+bounces-738841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF82B0BE05
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 09:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4D877AC81C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 07:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4222820CE;
	Mon, 21 Jul 2025 07:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gOXQWEUM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616AFAD23;
	Mon, 21 Jul 2025 07:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753084027; cv=none; b=WCiAkB6jNmrHhuWU6DBiAjjZhtP6svyp+jlPL9VZ0C90DFM5c82vqL6fjxKWBPZ1XYUFr2GMOD6JQbXT6/6nBY2vYq4mxIHF9ai5Flzl7ruWeeL7t7hOuW2q7gqagtKVas4W6YJNHLaFEgTcwpxFupJErFTtihbVtct50hkIjk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753084027; c=relaxed/simple;
	bh=vipiOsheUEUfVcZfe/f8Unsa2t3MPDU99scYVxF7E3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNu/hnNQLdN1K1oKOrIfum0zbgPgfr3x8wTjEpMWSai9oxxDyFmBZZ6RnrhQy14ZxSZ15i/C1jV1+LLQKhRDdjJm/GYFhmO7K7ZovDBg5CqY4b6j+OfcabZrMDfIqnHQCp+PrmROHzjMLW3Iebc/K50GIDykIUYlcEUe5O/Zcxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gOXQWEUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E27C4CEED;
	Mon, 21 Jul 2025 07:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753084026;
	bh=vipiOsheUEUfVcZfe/f8Unsa2t3MPDU99scYVxF7E3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gOXQWEUMI/lZGmlxZmdGE3lR+17oVtpTamAwF2jY8d1crSF9FqmgIrUsc2T8CTfIR
	 S0QD8oNvXD5Cu9zcBojsxjmFZ06e46O2Eh9xcyHuyO61o66+aZMQstzJeMPizqxKcO
	 Qm2FLb566zpMHf1cL6hsShDGZUKSMXV0vJDi1OvI=
Date: Mon, 21 Jul 2025 09:47:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tao Xue <xuetao09@huawei.com>
Cc: Thinh.Nguyen@synopsys.com, prashanth.k@oss.qualcomm.com,
	m.grzeschik@pengutronix.de, Chris.Wulff@biamp.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	caiyadong@huawei.com, suzhuangluan@hisilicon.com,
	weiwenwen3@huawei.com
Subject: Re: [PATCH v3] usb: gadget : fix use-after-free in
 composite_dev_cleanup()
Message-ID: <2025072150-congenial-feisty-dde1@gregkh>
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
> +		cdev->os_desc_req = NULL;
>  		goto end;
>  	}
>  	cdev->os_desc_req->context = cdev;
> -- 
> 2.17.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:


- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

