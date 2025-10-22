Return-Path: <linux-kernel+bounces-864925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB9FBFBDF5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B7586507202
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBEB32E142;
	Wed, 22 Oct 2025 12:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="gitHoXAy"
Received: from smtp107.iad3b.emailsrvr.com (smtp107.iad3b.emailsrvr.com [146.20.161.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3FE343D8F
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761136324; cv=none; b=K1SeDcu5HEEVB5/E+MZRNCRWzANQM0yZHR0jEiDmWe1XTsuoXhFrGuB4F8r1koh6tWH8QB4YBIcUO0HKQ0WkI7G0tS8VJwaGR5f3C5SO+DsW7avE/CFA/p8q8C3JuqbvVtQKIRZwU5x1GTfNO4FamzYRzd+bhEJ++5B7Omtnx6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761136324; c=relaxed/simple;
	bh=Ahcy1JkWdZhs4Wb0qxaN6FVZjLIHt2HFl5ntqcxUepo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lLYSYrPxCiwd5Xle6Ex4Kf+764vNNf2K+ZwHIQc3AlSyYsu1Pg5OmtwPqXkYyXe0zI6Jq3R9OCyX5338+DCyuuzJ44dRibH10O4Q0peMCOYQY0PuunHtBhZjeaDmaKpLSVgq48AdWcZ/DqbGG//bdt3Q/v6MTnsglBtfGaz9Vdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=gitHoXAy; arc=none smtp.client-ip=146.20.161.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1761127336;
	bh=Ahcy1JkWdZhs4Wb0qxaN6FVZjLIHt2HFl5ntqcxUepo=;
	h=Date:Subject:To:From:From;
	b=gitHoXAylJKM50saSGT+pMb5FAEmW04gIN4nwhTbntQGhxtoFJzUgayQOqr1ft2V+
	 lDBJdw4b/syr4BUvl1MT9KUmTsBWQgvahLNG6J+aWJie7RP1jazCw0+bMSYQNPWhAU
	 nNL6TET0B6jX4MFUfKl79hiLLW1yQ0t7phau0qUs=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp14.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 34931E029E;
	Wed, 22 Oct 2025 06:02:12 -0400 (EDT)
Message-ID: <24d288e5-9e98-49c0-964d-40476aadc267@mev.co.uk>
Date: Wed, 22 Oct 2025 11:02:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] comedi: pcl818: fix null-ptr-deref in pcl818_ai_cancel()
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Hillf Danton <hdanton@sina.com>,
 lvc-project@linuxtesting.org
References: <20251020161208.4151618-1-n.zhandarovich@fintech.ru>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20251020161208.4151618-1-n.zhandarovich@fintech.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: f1f689e8-3ce7-4bfa-9e0c-0e174211ccfe-1-1

On 20/10/2025 17:12, Nikita Zhandarovich wrote:
> Syzbot identified an issue [1] in pcl818_ai_cancel(), which stems from
> the fact that in case of early device detach via pcl818_detach(),
> subdevice dev->read_subdev may not have initialized its pointer to
> &struct comedi_async as intended. Thus, any such dereferencing of
> &s->async->cmd will lead to general protection fault and kernel crash.
> 
> Mitigate this problem by checking in advance whether async struct is
> properly present.
> 
> Original idea for this patch belongs to Hillf Danton
> <hdanton@sina.com>.
> 
> Note: as suggested by Ian in [2], there may be a different solution to
> improving the way ISRs are set up (and possibly, this flaw as well).
> However, until that idea (based on reference counters and completion
> structs) comes to fruition, it makes sense to fix this now, if only
> to stop kernel crashing so often during syzkaller runs.

In this case, it seems to be because the driver allows the device to 
operate without an IRQ, but will not support async commands in that case 
and the subdevice's `async` pointer will be null.  However, the 
`pcl818_ai_cancel()` function called from `pcl818_detach()` assumes that 
the `async` pointer is valid.

The unchecked dereference of the `async` pointer in `pcl818_ai_cancel()` 
seems to have been introduced by 00aba6e7b5653 ("staging: comedi: 
pcl818: remove 'neverending_ai' from private data").


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
> [2] Ian's suggestion on how to fix interrupt handlers in comedi drivers:
> Link: https://lore.kernel.org/all/9c92913c-c04b-4784-9cdc-5d75b10d2ed9@mev.co.uk/
> 
> Reported-by: syzbot+fce5d9d5bd067d6fbe9b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=fce5d9d5bd067d6fbe9b
> Suggested-by: Hillf Danton <hdanton@sina.com>
> Fixes: 00aba6e7b565 ("staging: comedi: pcl818: remove 'neverending_ai' from private data")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
> P.S. Tested with syzkaller reproducers as well as by doing a trial
> syzkaller run w/wo the patch.
> 
>   drivers/comedi/drivers/pcl818.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/comedi/drivers/pcl818.c b/drivers/comedi/drivers/pcl818.c
> index 4127adcfb229..3c6cfb212492 100644
> --- a/drivers/comedi/drivers/pcl818.c
> +++ b/drivers/comedi/drivers/pcl818.c
> @@ -759,12 +759,15 @@ static int pcl818_ai_cancel(struct comedi_device *dev,
>   {
>   	struct pcl818_private *devpriv = dev->private;
>   	struct comedi_isadma *dma = devpriv->dma;
> -	struct comedi_cmd *cmd = &s->async->cmd;
> +	struct comedi_cmd *cmd;
>   
>   	if (!devpriv->ai_cmd_running)
>   		return 0;
>   
>   	if (dma) {
> +		if (!s || !s->async)
> +			return 0;
> +		cmd = &s->async->cmd;
>   		if (cmd->stop_src == TRIG_NONE ||
>   		    (cmd->stop_src == TRIG_COUNT &&
>   		     s->async->scans_done < cmd->stop_arg)) {

An alternative fix would be to remove the call to `pcl818_ai_cancel()` 
from `pcl818_detach()`.  If the subdevice was set up to support 
asynchronous commands (non-null `async` pointer), the subdevice's 
`->cancel()` hander function would have already been called via 
`comedi_device_detach_locked()` ==> `comedi_device_cancel_all()` ==> 
`do_cancel()` before the driver's `->detach()` handler is called.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

