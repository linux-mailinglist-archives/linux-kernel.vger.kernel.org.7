Return-Path: <linux-kernel+bounces-867252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A97C02055
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8DE23B6208
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8932F32AAC8;
	Thu, 23 Oct 2025 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="VHMFae26"
Received: from smtp119.ord1d.emailsrvr.com (smtp119.ord1d.emailsrvr.com [184.106.54.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFF9219EB
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=184.106.54.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761232006; cv=none; b=fv9Vm8+xl94ABzPLqJ2Dij5DMTS+eGwctgk40Xg1EJa2UE/Xm4LmJUgLFq0vkK8rYvS7m7Zv54ftigcV4hPkzAzyPZ9nMlMbqDVz9bJAWxkPynqa4LVRxsUmGX06sNtccnb89gnnnaMTvW5CbaLcRqw6+X0gUpeAGx7sa8mrhlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761232006; c=relaxed/simple;
	bh=wrxa66l/KvBgvDwVqMPPP5q0JPvo30D9eKiiHrXxG3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S6roNXqLaUvKHDSiNv+3X9xmReADicg+1Hd5Y21xtNSvW9K3pTZz/4sQSKwty8XzAfGkpCgo5XnNdHnBbA+G1iecgE/xvcdrbDd414mr3IJQuHdCQJkK3O1OOf5zrvHTz3vYwb3EKUpeejBexmtlZcg30hJ4dA0UjnDHr26FIuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=VHMFae26; arc=none smtp.client-ip=184.106.54.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1761229710;
	bh=wrxa66l/KvBgvDwVqMPPP5q0JPvo30D9eKiiHrXxG3Y=;
	h=Date:Subject:To:From:From;
	b=VHMFae265OnJte/Tp+v5uXfa0f1ouzAWSoQH3OQHez2ZgNzrUPIJXGDfwbhfq49jV
	 c+lJ7PgEsqZMH071HLesEpCIzOachHAe0plMyx8HBAOIpJWSMn9psUaMKHx7Rq7i0/
	 ysCd6Pz4G3BLmEek4j4CVYRyS+qmiTNFNqLDsaqc=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp23.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 69E95201FD;
	Thu, 23 Oct 2025 10:28:29 -0400 (EDT)
Message-ID: <a687f917-6e4f-4452-8189-d4b539c533f0@mev.co.uk>
Date: Thu, 23 Oct 2025 15:28:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] comedi: pcl818: fix null-ptr-deref in
 pcl818_ai_cancel()
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20251023141457.398685-1-n.zhandarovich@fintech.ru>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20251023141457.398685-1-n.zhandarovich@fintech.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: db0f39ec-b1e3-48ab-a982-5e5e01151f00-1-1

On 23/10/2025 15:14, Nikita Zhandarovich wrote:
> Syzbot identified an issue [1] in pcl818_ai_cancel(), which stems from
> the fact that in case of early device detach via pcl818_detach(),
> subdevice dev->read_subdev may not have initialized its pointer to
> &struct comedi_async as intended. Thus, any such dereferencing of
> &s->async->cmd will lead to general protection fault and kernel crash.
> 
> Mitigate this problem by removing a call to pcl818_ai_cancel() from
> pcl818_detach() altogether. This way, if the subdevice setups its
> support for async commands, everything async-related will be
> handled via subdevice's own ->cancel() function in
> comedi_device_detach_locked() even before pcl818_detach(). If no
> support for asynchronous commands is provided, there is no need
> to cancel anything either.
> 
> [1] Syzbot crash:
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
> CPU: 1 UID: 0 PID: 6050 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
> RIP: 0010:pcl818_ai_cancel+0x69/0x3f0 drivers/comedi/drivers/pcl818.c:762
> ...
> Call Trace:
>   <TASK>
>   pcl818_detach+0x66/0xd0 drivers/comedi/drivers/pcl818.c:1115
>   comedi_device_detach_locked+0x178/0x750 drivers/comedi/drivers.c:207
>   do_devconfig_ioctl drivers/comedi/comedi_fops.c:848 [inline]
>   comedi_unlocked_ioctl+0xcde/0x1020 drivers/comedi/comedi_fops.c:2178
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:597 [inline]
> ...
> 
> Reported-by: syzbot+fce5d9d5bd067d6fbe9b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=fce5d9d5bd067d6fbe9b
> Fixes: 00aba6e7b565 ("staging: comedi: pcl818: remove 'neverending_ai' from private data")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
> v1 -> v2: Switch to a better, more logical approach, put forward by
> Ian Abbott <abbotti@mev.co.uk>, instead of doing an awkward
> check in pcl818_ai_cancel() itself. Adjust commit description.
> 
> P.S. I've chosen to keep the old Fixes: tag. Not sure it's best,
> but it's at least partially correct.
> 
>   drivers/comedi/drivers/pcl818.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/comedi/drivers/pcl818.c b/drivers/comedi/drivers/pcl818.c
> index 4127adcfb229..06fe06396f23 100644
> --- a/drivers/comedi/drivers/pcl818.c
> +++ b/drivers/comedi/drivers/pcl818.c
> @@ -1111,10 +1111,9 @@ static void pcl818_detach(struct comedi_device *dev)
>   {
>   	struct pcl818_private *devpriv = dev->private;
>   
> -	if (devpriv) {
> -		pcl818_ai_cancel(dev, dev->read_subdev);
> +	if (devpriv)
>   		pcl818_reset(dev);
> -	}
> +
>   	pcl818_free_dma(dev);
>   	comedi_legacy_detach(dev);
>   }

Looks good. Thanks for the patch!

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

