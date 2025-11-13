Return-Path: <linux-kernel+bounces-899418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC920C57A9D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 46A9C355AA7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1244A35292B;
	Thu, 13 Nov 2025 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pqBNYNH8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575A733F8D2;
	Thu, 13 Nov 2025 13:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040533; cv=none; b=KLb2sonratekC4uVNurCXabN3OYj4vFgGx2VuxTf8XvefQPi3R3pLLo6vm9yHWNpj4V3PgBNdmpQS53lEfUc5UQfJI10VhdoXbw14070PMGLVsQ4st2gQh5T1Tvb1TG4aQ2PeOoY4avXH+vwp1PyApRm9wA+gd1+E3PjN6aiwlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040533; c=relaxed/simple;
	bh=d1S6EXhuajmdeR7g4lfZh2Y4Mab0D3MUxG1o04pb/Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3hb1r0UmFaR+Np6H06xwg0XvzgKgi0kY6K90sYjTdptT/06YLVkOcCwXbsWUGhI7D0u1BVY581TS1ETpBf1xT80HFlyPW8jxJ7XdOvWJteOQ67rq+ILv/kLuXKtCOaVXGrTO8Mh+Pr2tcPjJakoIr7lavBKNklNE4QiWClFnGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pqBNYNH8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC0FC4CEF5;
	Thu, 13 Nov 2025 13:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763040532;
	bh=d1S6EXhuajmdeR7g4lfZh2Y4Mab0D3MUxG1o04pb/Rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pqBNYNH8/BIfoX/TrzoEjwLZDxdxVbfbQ+cHttzzxvvz0Kkz+Fv4p0ifL5XAQ9hG3
	 plIcQgkNonNx3etrLAl7wnYbgu24yeTNdEAZ3wo6hpjASn23oneq/KlhkNK4ZbJwLl
	 TZf3WjvciP6u9O/D/cHIyR8UXfdK6LmePt6vFAVo=
Date: Thu, 13 Nov 2025 08:28:50 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: Jie Deng <dengjie03@kylinos.cn>
Cc: mathias.nyman@linux.intel.com, sakari.ailus@linux.intel.com,
	stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: core: fix NULL dereference in usb_ifnum_to_if()
 during device removal
Message-ID: <2025111342-chummy-preppy-e3e6@gregkh>
References: <20251113114411.1410343-1-dengjie03@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113114411.1410343-1-dengjie03@kylinos.cn>

On Thu, Nov 13, 2025 at 07:44:11PM +0800, Jie Deng wrote:
> During USB device hot-unplug, in the time window between when
> usb_disconnect() calls usb_disable_device() to set
> dev->actconfig->interface[i] to NULL but before dev->actconfig
> is set to NULL.At this point, outside the kernel, usb_ifnum_to_if()
> is called through usb_set_interface(), and usb_ifnum_to_if() continues
> to access interface[i]->altsetting[i], triggering a null pointer.

I do not understand, sorry.  What do you mean by "outside the kernel"?

> kernel log:
> [ 9518.779148][ 1] [ T4650] pc : usb_ifnum_to_if+0x34/0x50
> [ 9518.784360][ 1] [ T4650] lr : usb_hcd_alloc_bandwidth+0x260/0x348

What is the [TXXX] stuff?

> [ 9518.790439][ 1] [ T4650] sp : ffffffa25a6c79d0
> [ 9518.794868][ 1] [ T4650] x29: ffffffa25a6c79d0 x28: 0000000040045613
> [ 9518.801294][ 1] [ T4650] x27: 0000000000000000 x26: 0000000000000000
> [ 9518.807720][ 1] [ T4650] x25: ffffffa2e1597408 x24: ffffffa2e1597408
> [ 9518.814146][ 1] [ T4650] x23: ffffffa2e15974f8 x22: 0000000000000000
> [ 9518.820572][ 1] [ T4650] x21: ffffffa2e9acc000 x20: ffffffa2e6712000
> [ 9518.826998][ 1] [ T4650] x19: ffffffa2e6a8a800 x18: 0000000000000000
> [ 9518.833423][ 1] [ T4650] x17: 0000007fbb91b4b0 x16: ffffffc01016a170
> [ 9518.839849][ 1] [ T4650] x15: 0000000000000000 x14: 0845c02202702800
> [ 9518.846275][ 1] [ T4650] x13: 0000000000000001 x12: 0000000000000000
> [ 9518.852700][ 1] [ T4650] x11: 0000000000000400 x10: ffffffff89e5d720
> [ 9518.859126][ 1] [ T4650] x9 : 0000000000000000 x8 : 0000000000000000
> [ 9518.865551][ 1] [ T4650] x7 : ffffffa2fff1e440 x6 : ffffffa28175c900
> [ 9518.871977][ 1] [ T4650] x5 : 0000000000000060 x4 : ffffffa2e9bc54b0
> [ 9518.878403][ 1] [ T4650] x3 : ffffffa2e9bc54a0 x2 : ffffffa2e9bc54a0
> [ 9518.884828][ 1] [ T4650] x1 : 0000000000000001 x0 : 0000000000000000
> [ 9518.891254][ 1] [ T4650] Call trace:
> [ 9518.894817][ 1] [ T4650]  usb_ifnum_to_if+0x34/0x50
> [ 9518.899681][ 1] [ T4650]  usb_set_interface+0x108/0x3c8
> [ 9518.904898][ 1] [ T4650]  uvc_video_stop_streaming+0x3c/0x90 [uvcvideo]
> [ 9518.911500][ 1] [ T4650]  uvc_stop_streaming+0x24/0x90 [uvcvideo]
> [ 9518.917583][ 1] [ T4650]  __vb2_queue_cancel+0x44/0x458 [videobuf2_common]
> [ 9518.924444][ 1] [ T4650]  vb2_core_streamoff+0x20/0xb8 [videobuf2_common]
> [ 9518.931221][ 1] [ T4650]  vb2_streamoff+0x18/0x60 [videobuf2_v4l2]
> [ 9518.937390][ 1] [ T4650]  uvc_queue_streamoff+0x30/0x50 [uvcvideo]
> [ 9518.943557][ 1] [ T4650]  uvc_ioctl_streamoff+0x40/0x68 [uvcvideo]
> [ 9518.949724][ 1] [ T4650]  v4l_streamoff+0x20/0x28
> [ 9518.954415][ 1] [ T4650]  __video_do_ioctl+0x17c/0x3e0
> [ 9518.959540][ 1] [ T4650]  video_usercopy+0x1d8/0x558
> [ 9518.964490][ 1] [ T4650]  video_ioctl2+0x14/0x1c
> [ 9518.969094][ 1] [ T4650]  v4l2_ioctl+0x3c/0x58
> [ 9518.973526][ 1] [ T4650]  do_vfs_ioctl+0x374/0x7b0
> [ 9518.978304][ 1] [ T4650]  ksys_ioctl+0x78/0xa8
> [ 9518.982734][ 1] [ T4650]  sys_ioctl+0xc/0x18
> [ 9518.986991][ 1] [ T4650]  __sys_trace_return+0x0/0x4
> [ 9518.991943][ 1] [ T4650] Code: eb04005f 54000100 f9400040 91002042 (f9400003)
> [ 9518.999153][ 1] [ T4650] ---[ end trace f7c7d3236806d9a4 ]---
> 
> To resolve this issue, a null pointer check for config->interface[i]
> can be added in the usb_ifnum_to_if() function.
> 
> Signed-off-by: Jie Deng <dengjie03@kylinos.cn>
> ---
>  drivers/usb/core/usb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> index e740f7852bcd..85dcda06a838 100644
> --- a/drivers/usb/core/usb.c
> +++ b/drivers/usb/core/usb.c
> @@ -355,7 +355,7 @@ struct usb_interface *usb_ifnum_to_if(const struct usb_device *dev,
>  	if (!config)
>  		return NULL;
>  	for (i = 0; i < config->desc.bNumInterfaces; i++)
> -		if (config->interface[i]->altsetting[0]
> +		if (config->interface[i] && config->interface[i]->altsetting[0]

Are you sure this is not just papering over a race?  What prevents this
from changing right after you check it?

And what is causing this to happen now?  What commit broke this to
require this change?

thanks,

greg k-h

