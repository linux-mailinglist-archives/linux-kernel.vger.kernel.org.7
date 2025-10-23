Return-Path: <linux-kernel+bounces-867084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46616C018CA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E10CF3B066B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947C2315778;
	Thu, 23 Oct 2025 13:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="LtPJVx9a"
Received: from smtp88.ord1d.emailsrvr.com (smtp88.ord1d.emailsrvr.com [184.106.54.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233DC313E0F
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=184.106.54.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227500; cv=none; b=LZW5JhzQbNTMKqSfbo6cX26K8yVaL2JASQK2C3FVb/6tC1Bhod/3rYw/sqk1FeTUShDTK2TUvHvIvrCqKDfcuARgrsKs0A9kLZiZRigb6yV0Swnhvphtw1oZit86hxsDTcVoroJ+4wsqEP2PnW+E1wxy1XTnaRv3HIW4VTXpIms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227500; c=relaxed/simple;
	bh=JcZg/isUw4CxnJKAK4LeFdSuwxs63Lfq7Mj8qUD8Ylo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OwcOk5E7l3lIY91IiiqH2wgYW0hc9eglk9l7JRuGWnPg6dJrzNKm/QQactj1LT+PoWT48bNl24oVVat9Nc7QAmient639ofHrNNh/KRJE8J83T14dFmPFtwDYeA0eN1AWFtuGqfdtuSeIrooM2N/P6r7j2gDGavZUQSEW5VYCg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=LtPJVx9a; arc=none smtp.client-ip=184.106.54.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1761226449;
	bh=JcZg/isUw4CxnJKAK4LeFdSuwxs63Lfq7Mj8qUD8Ylo=;
	h=Date:Subject:To:From:From;
	b=LtPJVx9aqlOguaYQuZomlq7Cqh+ngvHPLfjfVBpXQFFxk8VdZgTIi46yKSyqLmHXR
	 JBVQwcGQqwQNU3Z4G3oqh26SG63u63d4iMjuI9i+MVjbkGEjND1RG2e1mw0soQx9Rv
	 nYH084R1oUldnvlkI/Klnow7UQMLQCCk2LUCVqTY=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp4.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id E92674022E;
	Thu, 23 Oct 2025 09:34:07 -0400 (EDT)
Message-ID: <61f72946-1d7f-4e31-bc1d-85b779681987@mev.co.uk>
Date: Thu, 23 Oct 2025 14:34:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] comedi: multiq3: sanitize config options in
 multiq3_attach()
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 syzbot+7811bb68a317954a0347@syzkaller.appspotmail.com
References: <20251023132205.395753-1-n.zhandarovich@fintech.ru>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20251023132205.395753-1-n.zhandarovich@fintech.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 70c2a07d-7fdb-4c55-93a9-2b8517daffa8-1-1

On 23/10/2025 14:22, Nikita Zhandarovich wrote:
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
> a sensible limit on the number of encoder chips (4 chips max, each
> with 2 channels) to stop this behaviour from manifesting.
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
> v2 -> v3: Switch to less confusing macro name MULTIQ3_MAX_ENC_CHANS,
> adjust comments accordingly, as well as commit description itself.
> 
>   drivers/comedi/drivers/multiq3.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/comedi/drivers/multiq3.c b/drivers/comedi/drivers/multiq3.c
> index 07ff5383da99..ac369e9a262d 100644
> --- a/drivers/comedi/drivers/multiq3.c
> +++ b/drivers/comedi/drivers/multiq3.c
> @@ -67,6 +67,11 @@
>   #define MULTIQ3_TRSFRCNTR_OL		0x10	/* xfer CNTR to OL (x and y) */
>   #define MULTIQ3_EFLAG_RESET		0x06	/* reset E bit of flag reg */
>   
> +/*
> + * Limit on the number of optional encoder channels
> + */
> +#define MULTIQ3_MAX_ENC_CHANS		8
> +
>   static void multiq3_set_ctrl(struct comedi_device *dev, unsigned int bits)
>   {
>   	/*
> @@ -312,6 +317,10 @@ static int multiq3_attach(struct comedi_device *dev,
>   	s->insn_read	= multiq3_encoder_insn_read;
>   	s->insn_config	= multiq3_encoder_insn_config;
>   
> +	/* sanity check for number of encoder channels */
> +	if (s->n_chan > MULTIQ3_MAX_ENC_CHANS)
> +		s->n_chan = MULTIQ3_MAX_ENC_CHANS;
> +
>   	for (i = 0; i < s->n_chan; i++)
>   		multiq3_encoder_reset(dev, i);
>   

Looks good. Thanks for the fix!

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

