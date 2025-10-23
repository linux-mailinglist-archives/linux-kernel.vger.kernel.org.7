Return-Path: <linux-kernel+bounces-867013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EB3C0156C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34BA4501596
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B2C314D13;
	Thu, 23 Oct 2025 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="gtimIPa6"
Received: from smtp74.ord1d.emailsrvr.com (smtp74.ord1d.emailsrvr.com [184.106.54.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0264A2FBDF1
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=184.106.54.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225710; cv=none; b=pUyDseueFYPVpc0zw8jTtEYYao/EKH0s0RSbAmOWsy+Mo00O2fl1KZJoLMG7tvtme+2M+SkRoKmNtyvTeWoHkZR72eNm0BZW/cxtswacyaqhkLT6iwm5OgLEL/mP2cruf+sjuScdj5rHPSBfkJTrP+fCklBZ29N93yYupWDufgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225710; c=relaxed/simple;
	bh=LpcNoCTwoo2mT0mvQcZZ6RNH+LF7rB5Ve7qeUZd7kXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V0aIZEsVtcREhwIRTC3z4JMUNJRNxqwom+dho8CY4bDY4UGYDSjPeB5eVBQncDMXTvGIDubjvX6a9adlZoeVxMIrJbuu6UthvkzwY7xKACluaZn8WO5CqzuvM7Viwq8cYkf0YBo1lCQGhp3FHCR8N5sRdOWzj6vfAs/E5hrLj7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=gtimIPa6; arc=none smtp.client-ip=184.106.54.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1761224669;
	bh=LpcNoCTwoo2mT0mvQcZZ6RNH+LF7rB5Ve7qeUZd7kXY=;
	h=Date:Subject:To:From:From;
	b=gtimIPa69n7ZS+u1dx2hZSmKZPsku4n+r1sjCYv4l/0TcUbI/jhXPxYU+AqNxCx+Z
	 AIZuV8ofqrSyK3v0nh0TdYept8WSMviiWk6qEzFV1UB4H8D/QUgXofdnNk89SwX3n4
	 KCu78Pvl54ly8/wEgAgUhjG3PvmnMe9DVMPiaOA0=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp10.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id C2C9EA02BA;
	Thu, 23 Oct 2025 09:04:28 -0400 (EDT)
Message-ID: <6b8713a1-4a34-4b0f-80d4-3a6f630c5105@mev.co.uk>
Date: Thu, 23 Oct 2025 14:04:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] comedi: multiq3: sanitize config options in
 multiq3_attach()
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 syzbot+7811bb68a317954a0347@syzkaller.appspotmail.com
References: <20251023125304.390221-1-n.zhandarovich@fintech.ru>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20251023125304.390221-1-n.zhandarovich@fintech.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: e593f330-c284-4dfe-816f-c0af998106be-1-1

On 23/10/2025 13:53, Nikita Zhandarovich wrote:
> Syzbot identified an issue [1] in multiq3_attach() that induces a
> task timeout due to open() or COMEDI_DEVCONFIG ioctl operations,
> specifically, in the case of multiq3 driver.
> 
> This problem arose when syzkaller managed to craft weird configuration
> options used to specify the number of channels in encoder subdevice.
> If a particularly great number is passed to s->n_chan in
> multiq3_attach() via it->options[2], then multiple calls to
> multiq3_encoder_reset() at the end of driver-specific attach() method
> will be running for minutes, thus blocking tasks and affected devices
> as well.
> 
> While this issue is most likely not too dangerous for real-life
> devices, it still makes sense to sanitize configuration inputs. Enable
> a semi-arbitrary limit on the number of encoder chips to stop this
> behaviour from manifesting.

See comment below about "semi-arbitrary".

> 
> [1] Syzbot crash:
> INFO: task syz.2.19:6067 blocked for more than 143 seconds.
> ...
> Call Trace:
>   <TASK>
>   context_switch kernel/sched/core.c:5254 [inline]
>   __schedule+0x17c4/0x4d60 kernel/sched/core.c:6862
>   __schedule_loop kernel/sched/core.c:6944 [inline]
>   schedule+0x165/0x360 kernel/sched/core.c:6959
>   schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7016
>   __mutex_lock_common kernel/locking/mutex.c:676 [inline]
>   __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:760
>   comedi_open+0xc0/0x590 drivers/comedi/comedi_fops.c:2868
>   chrdev_open+0x4cc/0x5e0 fs/char_dev.c:414
>   do_dentry_open+0x953/0x13f0 fs/open.c:965
>   vfs_open+0x3b/0x340 fs/open.c:1097
> ...
> 
> Reported-by: syzbot+7811bb68a317954a0347@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=7811bb68a317954a0347
> Fixes: 77e01cdbad51 ("Staging: comedi: add multiq3 driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
> v1 -> v2: Lower limit to 8 channels instead of 16 per Ian Abbott's
> <abbotti@mev.co.uk> suggestion.
> 
>   drivers/comedi/drivers/multiq3.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/comedi/drivers/multiq3.c b/drivers/comedi/drivers/multiq3.c
> index 07ff5383da99..08b812332a1a 100644
> --- a/drivers/comedi/drivers/multiq3.c
> +++ b/drivers/comedi/drivers/multiq3.c
> @@ -67,6 +67,11 @@
>   #define MULTIQ3_TRSFRCNTR_OL		0x10	/* xfer CNTR to OL (x and y) */
>   #define MULTIQ3_EFLAG_RESET		0x06	/* reset E bit of flag reg */
>   
> +/*
> + * Semi-arbitrary limit on the number of optional encoder chips
> + */
> +#define MULTIQ3_MAX_ENC_CHIPS		8
> +

That may be slightly confusing because there is a maximum of 4 encoder 
chips, each of which has 2 channels.  Renaming the macro to 
`MULTIQ3_MAX_ENC_CHANS` and adjusting the comment accordingly would be 
better.  Also, the limit isn't really "semi-arbitrary" so I suggest 
removing that part.

>   static void multiq3_set_ctrl(struct comedi_device *dev, unsigned int bits)
>   {
>   	/*
> @@ -312,6 +317,10 @@ static int multiq3_attach(struct comedi_device *dev,
>   	s->insn_read	= multiq3_encoder_insn_read;
>   	s->insn_config	= multiq3_encoder_insn_config;
>   
> +	/* sanity check for number of optional encoders */
> +	if (s->n_chan > MULTIQ3_MAX_ENC_CHIPS)
> +		s->n_chan = MULTIQ3_MAX_ENC_CHIPS;
> +
>   	for (i = 0; i < s->n_chan; i++)
>   		multiq3_encoder_reset(dev, i);
>   

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

