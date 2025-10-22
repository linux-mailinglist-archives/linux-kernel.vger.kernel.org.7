Return-Path: <linux-kernel+bounces-865047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F75BFC1EF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18572621B51
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA346348882;
	Wed, 22 Oct 2025 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="DWn3zTIq"
Received: from smtp88.iad3b.emailsrvr.com (smtp88.iad3b.emailsrvr.com [146.20.161.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B00133DECB
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761138424; cv=none; b=dZxmeNDA7e1G6tA5y3ZSbzl9DNEiqyhhYZa7MyNg3OVEDmHapaZFBVU0NCu86rW4Wi0VzpnxSrTIhahiGq39VeJWXX+8i2Mj/VqVYOFMEX65bZ7Z1FCSR+UKn19spVgOB8HqlCxqxgjShrYpQbqmcqrXxQNQiRU1/dm7/T+EtMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761138424; c=relaxed/simple;
	bh=aUlU4Pbad8exeU3PvXAN8EgQadXY4mrcDVLjV83v1HI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PGKq9jpzcbUtRhjvJ84MVM/KemVhf5UGs96YHFoe9LIL2tnzLMn6UCXO5rZWAGn7i9D/PnxcWEUHF4ed6pHRjZTzkptXPD1vN3I97tJajZGSP7k6cfd+yItimlWnrJnORnt+eTVxNld4jhIL6PwG3ti7lDLl/zx1qqFwhhbH6R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=DWn3zTIq; arc=none smtp.client-ip=146.20.161.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1761129535;
	bh=aUlU4Pbad8exeU3PvXAN8EgQadXY4mrcDVLjV83v1HI=;
	h=Date:Subject:To:From:From;
	b=DWn3zTIq/KJAFqF0ULiJljkwhb5pHcX6GmZ7vm/Xna31KvMSrym1y92KdAn9625Ud
	 x77ZbC1j4Uh/2dGcKbQDLnkNnV9j/HX+SdWIfUTH5b5hvdbV+M97v8RzYvHQXBhxIc
	 aZx8updX90im00Q5ZhR8S3XAqbw8Jf5HFQuxzH9Q=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp12.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 6140BC0291;
	Wed, 22 Oct 2025 06:38:54 -0400 (EDT)
Message-ID: <f0f48940-213b-494e-88f5-0275874fe044@mev.co.uk>
Date: Wed, 22 Oct 2025 11:38:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] comedi: multiq3: sanitize config options in
 multiq3_attach()
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 syzbot+7811bb68a317954a0347@syzkaller.appspotmail.com
References: <20251021145951.260762-1-n.zhandarovich@fintech.ru>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20251021145951.260762-1-n.zhandarovich@fintech.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 9b896020-3f0c-42ab-b8b5-f247ea7bd99a-1-1

On 21/10/2025 15:59, Nikita Zhandarovich wrote:
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
>   drivers/comedi/drivers/multiq3.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/comedi/drivers/multiq3.c b/drivers/comedi/drivers/multiq3.c
> index 07ff5383da99..0248321e3bfa 100644
> --- a/drivers/comedi/drivers/multiq3.c
> +++ b/drivers/comedi/drivers/multiq3.c
> @@ -67,6 +67,11 @@
>   #define MULTIQ3_TRSFRCNTR_OL		0x10	/* xfer CNTR to OL (x and y) */
>   #define MULTIQ3_EFLAG_RESET		0x06	/* reset E bit of flag reg */
>   
> +/*
> + * Semi-arbitrary limit on the number of optional encoder chips
> + */
> +#define MULTIQ3_MAX_ENC_CHIPS		16
> +
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

Nice, but the limit on number of optional encoder chip channels 
(s->n_chan) seems to be 8 (it->options[2] = 4 encoder chips with 2 
channels per chip).  See the `MULTIQ_CTRL_E_CHAN(x)` macro:

#define MULTIQ3_CTRL_E_CHAN(x)		(((x) & 0x7) << 3)

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

