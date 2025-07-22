Return-Path: <linux-kernel+bounces-741261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B334B0E21B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC73565924
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA7427AC2F;
	Tue, 22 Jul 2025 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="mdAQewW0"
Received: from smtp95.iad3b.emailsrvr.com (smtp95.iad3b.emailsrvr.com [146.20.161.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37AC20CCE5
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 16:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753202820; cv=none; b=h1/AX4KQb2FALD3QrKNWovU6PPnGIPICa55vMX9isU6plgN3Y5GlhgvkPWaLWtYoJBtBB4OLboax4Ze9S3W3B6uF6Bgay4B4I8rmdwYMti3jClhdff1acJe7Igs54zDjVkp+7pOvJr4TRqZwmLP/yMeISMbQ05sGzorgleXsUhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753202820; c=relaxed/simple;
	bh=CxFYY9XzoyfCvU/A8tYea4snnJVOiVn/JCKT1qx48Xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mIsDrVCV06I9olSmnDL07oMtgokkW/O7E/f6il+g7c4yG4NTuVQZH0bJUS5Hk2d7vsgW6XEQoGwBJ4QnBTl4TiTm/XbhvQL1/GI6nE3lcMsy4Up/RAUxFJGYPFSXTsHOkDkKr1Uxe+ujSNc6ArZViDVZFFZrBhaRtkZawtuc7HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=mdAQewW0; arc=none smtp.client-ip=146.20.161.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1753198150;
	bh=CxFYY9XzoyfCvU/A8tYea4snnJVOiVn/JCKT1qx48Xk=;
	h=Date:Subject:To:From:From;
	b=mdAQewW0Zx/wUxEgXGKo2PFeSWGUd+tD5DyT+jSn+mTmMzkgwgoXddffjd+pTnukm
	 kQ2bzBvkRADV+F1uUV0JR5vg319w/QjadSb1pgX50t5vv3bDfxs9rsTul/emyfVyuG
	 qhghT6w54ARb33oYYQzjHa7/YpsRcIvNqn3pZYsU=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp4.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id E758420246;
	Tue, 22 Jul 2025 11:29:09 -0400 (EDT)
Message-ID: <4c4400e0-dd8c-4694-8030-f35273e5522d@mev.co.uk>
Date: Tue, 22 Jul 2025 16:29:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] comedi: include poll wait state in busy assessment
To: Jens Axboe <axboe@kernel.dk>, hsweeten@visionengravers.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <de833d76-0176-4514-b102-dc83bf93491f@kernel.dk>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <de833d76-0176-4514-b102-dc83bf93491f@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: d89999a4-7c87-40f8-babd-8556e9aaddc7-1-1

On 22/07/2025 13:49, Jens Axboe wrote:
> syzbot reports a use-after-free in comedi in the below link, which is
> due to comedi gladly removing the allocated async area even though poll
> requests are still active on the wait_queue_head inside of it. This can
> cause a use-after-free when the poll entries are later triggered or
> removed, as the memory for the wait_queue_head has been freed. The
> notion of being busy in comedi seems mostly centered around sync
> syscalls, where the comedi subdevice stores the file in 'busy' as a
> marker. This is obviously broken for things like poll which can be
> persistent across syscalls.
> 
> Rename is_device_busy() to start_detach(), and move it under the
> dev->attach_lock. The latter serializes it with poll attempts. If
> start_detach() is successful, then it will have marked the device with
> ->detaching == 1 and this will prevent further poll attempts.
> 
> Similarly, have start_detach() check for active polls on the device, and
> return busy for that case.
> 
> Cc: stable@vger.kernel.org
> Fixes: 8ffdff6a8cfb ("staging: comedi: move out of staging directory")
> Link: https://lore.kernel.org/all/687bd5fe.a70a0220.693ce.0091.GAE@google.com/
> Reported-by: syzbot+01523a0ae5600aef5895@syzkaller.appspotmail.com
> Tested-by: syzbot+01523a0ae5600aef5895@syzkaller.appspotmail.com
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
> index c83fd14dd7ad..58b034e45283 100644
> --- a/drivers/comedi/comedi_fops.c
> +++ b/drivers/comedi/comedi_fops.c
> @@ -782,24 +782,33 @@ void comedi_device_cancel_all(struct comedi_device *dev)
>   	}
>   }
>   
> -static int is_device_busy(struct comedi_device *dev)
> +static int start_detach(struct comedi_device *dev)
>   {
>   	struct comedi_subdevice *s;
> -	int i;
> +	int i, is_busy = 0;
>   
>   	lockdep_assert_held(&dev->mutex);
> +	lockdep_assert_held(&dev->attach_lock);
>   	if (!dev->attached)
>   		return 0;
>   
>   	for (i = 0; i < dev->n_subdevices; i++) {
>   		s = &dev->subdevices[i];
> -		if (s->busy)
> -			return 1;
> -		if (s->async && comedi_buf_is_mmapped(s))
> -			return 1;
> +		if (s->busy) {
> +			is_busy = 1;
> +			break;
> +		}
> +		if (!s->async)
> +			continue;
> +		if (comedi_buf_is_mmapped(s) ||
> +		    wq_has_sleeper(&s->async->wait_head)) {
> +			is_busy = 1;
> +			break;
> +		}
>   	}
> -
> -	return 0;
> +	if (!is_busy)
> +		dev->detaching = 1;
> +	return is_busy;
>   }
>   
>   /*
> @@ -825,8 +834,13 @@ static int do_devconfig_ioctl(struct comedi_device *dev,
>   		return -EPERM;
>   
>   	if (!arg) {
> -		if (is_device_busy(dev))
> +		/* prevent new polls */
> +		down_write(&dev->attach_lock);
> +		if (start_detach(dev)) {
> +			up_write(&dev->attach_lock);
>   			return -EBUSY;
> +		}
> +		up_write(&dev->attach_lock);
>   		if (dev->attached) {
>   			struct module *driver_module = dev->driver->module;
>   
> @@ -2479,7 +2493,7 @@ static __poll_t comedi_poll(struct file *file, poll_table *wait)
>   
>   	down_read(&dev->attach_lock);
>   
> -	if (!dev->attached) {
> +	if (!dev->attached || dev->detaching) {
>   		dev_dbg(dev->class_dev, "no driver attached\n");
>   		goto done;
>   	}
> diff --git a/include/linux/comedi/comedidev.h b/include/linux/comedi/comedidev.h
> index 4cb0400ad616..b2bec668785f 100644
> --- a/include/linux/comedi/comedidev.h
> +++ b/include/linux/comedi/comedidev.h
> @@ -545,6 +545,7 @@ struct comedi_device {
>   	const char *board_name;
>   	const void *board_ptr;
>   	unsigned int attached:1;
> +	unsigned int detaching:1;
>   	unsigned int ioenabled:1;
>   	spinlock_t spinlock;	/* generic spin-lock for low-level driver */
>   	struct mutex mutex;	/* generic mutex for COMEDI core */
> 

Thanks for the patch.  I'll post my version shortly.  One problem with 
this patch is that dev->detaching does not get cleared.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

