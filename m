Return-Path: <linux-kernel+bounces-864819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 101CBBFB9C9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E826A4EC4DC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B98B3370ED;
	Wed, 22 Oct 2025 11:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="I6AfEZxj"
Received: from smtp126.ord1d.emailsrvr.com (smtp126.ord1d.emailsrvr.com [184.106.54.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5FF285C8B
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=184.106.54.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761132115; cv=none; b=q+VciYr8G4FgLyx+jBedRAbXLcYvQbGWt+n14G6HDHgvAlomNHgigYEo+PjJ4F9qfOoevIf7MvtsQiNsEu6SVUd3669Ubds83Yq22IGNA6elSO0TKz51faZdgxWXCFmwfKlITni88ZuACyJHF9XNqJp242VPzVvTmUL8NdOgiYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761132115; c=relaxed/simple;
	bh=zCGOfjAhu1jNzZbMlthggBceLmLstKmb2EQICvtGWr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qwi78nd4vo1whIgyDURciQZ/eEUfQozSy4K6oqLMeONyn4KmtwlBG5wG1Eiso/ZAu04GxeJYEekJ1uv3geToMgdy1NS/jCFu2p+TH2zfeeHh17yhvqEbtSSmkYZmnRV+5/Z2YoJzj2xAH6TkxD5O8xg6IPUJFg70wK6iZ8sb1Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=I6AfEZxj; arc=none smtp.client-ip=184.106.54.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1761131157;
	bh=zCGOfjAhu1jNzZbMlthggBceLmLstKmb2EQICvtGWr8=;
	h=Date:Subject:To:From:From;
	b=I6AfEZxjlAPxqpo3j/CdrTSkhBidxpvGx3vy4RbkXNUzvchQaAv1WUzMIRdkgU3oC
	 mlTDZuX7LTyMDKh27AX2Lbkw+dIp+kGK+UzBolYRABwDKiVl1AcDrGz8xxl6+ZC6sO
	 QE9LI+PfUyRckwkPJgmlwouXIPQLhTWRk5voMM9o=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp16.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id BBFBC4025C;
	Wed, 22 Oct 2025 07:05:56 -0400 (EDT)
Message-ID: <294599d2-0d07-430a-a200-821d04d14914@mev.co.uk>
Date: Wed, 22 Oct 2025 12:05:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] comedi: check device's attached status in compat ioctls
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org,
 syzbot+ab8008c24e84adee93ff@syzkaller.appspotmail.com,
 lvc-project@linuxtesting.org
References: <20251020174125.150608-1-n.zhandarovich@fintech.ru>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20251020174125.150608-1-n.zhandarovich@fintech.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 31bb2d92-01c5-4459-8e8d-501b186191e5-1-1

On 20/10/2025 18:41, Nikita Zhandarovich wrote:
> Syzbot identified an issue [1] that crashes kernel, seemingly due to
> unexistent callback dev->get_valid_routes(). By all means, this should
> not occur as said callback must always be set to
> get_zero_valid_routes() in __comedi_device_postconfig().
> 
> As the crash seems to appear exclusively in i386 kernels, at least,
> judging from [1] reports, the blame lies with compat versions
> of standard IOCTL handlers. Several of them are modified and
> do not use comedi_unlocked_ioctl(). While functionality of these
> ioctls essentially copy their original versions, they do not
> have required sanity check for device's attached status. This,
> in turn, leads to a possibility of calling select IOCTLs on a
> device that has not been properly setup, even via COMEDI_DEVCONFIG.
> 
> Doing so on unconfigured devices means that several crucial steps
> are missed, for instance, specifying dev->get_valid_routes()
> callback.
> 
> Fix this somewhat crudely by ensuring device's attached status before
> performing any ioctls, improving logic consistency between modern
> and compat functions.
> 
> [1] Syzbot report:
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> ...
> CR2: ffffffffffffffd6 CR3: 000000006c717000 CR4: 0000000000352ef0
> Call Trace:
>   <TASK>
>   get_valid_routes drivers/comedi/comedi_fops.c:1322 [inline]
>   parse_insn+0x78c/0x1970 drivers/comedi/comedi_fops.c:1401
>   do_insnlist_ioctl+0x272/0x700 drivers/comedi/comedi_fops.c:1594
>   compat_insnlist drivers/comedi/comedi_fops.c:3208 [inline]
>   comedi_compat_ioctl+0x810/0x990 drivers/comedi/comedi_fops.c:3273
>   __do_compat_sys_ioctl fs/ioctl.c:695 [inline]
>   __se_compat_sys_ioctl fs/ioctl.c:638 [inline]
>   __ia32_compat_sys_ioctl+0x242/0x370 fs/ioctl.c:638
>   do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
> ...
> 
> Reported-by: syzbot+ab8008c24e84adee93ff@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=ab8008c24e84adee93ff
> Fixes: 3fbfd2223a27 ("comedi: get rid of compat_alloc_user_space() mess in COMEDI_CHANINFO compat")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
> Compile-tested only due to my QEMU setup currently being broken.
> Also, there is no decent syzkaller repro for this problem so
> testing this is a little tricky.
> 
> P.S. 'Fixes' tag is technically not correct, as each compat ioctl
> that requires special handling arguments-wise has been modified
> in separate commit. I've opted not to mention each and every one
> of them.
> 
> P.P.S. While these multiple identical checks look abhorrent, I've
> decided against changing current approach to compat functions.
> 
>   drivers/comedi/comedi_fops.c | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
> index 7e2f2b1a1c36..123e9af2ed44 100644
> --- a/drivers/comedi/comedi_fops.c
> +++ b/drivers/comedi/comedi_fops.c
> @@ -3023,6 +3023,11 @@ static int compat_chaninfo(struct file *file, unsigned long arg)
>   	chaninfo.rangelist = compat_ptr(chaninfo32.rangelist);
>   
>   	mutex_lock(&dev->mutex);
> +	if (!dev->attached) {
> +		dev_dbg(dev->class_dev, "no driver attached\n");
> +		mutex_unlock(&dev->mutex);
> +		return -ENODEV;
> +	}
>   	err = do_chaninfo_ioctl(dev, &chaninfo);
>   	mutex_unlock(&dev->mutex);
>   	return err;
> @@ -3044,6 +3049,11 @@ static int compat_rangeinfo(struct file *file, unsigned long arg)
>   	rangeinfo.range_ptr = compat_ptr(rangeinfo32.range_ptr);
>   
>   	mutex_lock(&dev->mutex);
> +	if (!dev->attached) {
> +		dev_dbg(dev->class_dev, "no driver attached\n");
> +		mutex_unlock(&dev->mutex);
> +		return -ENODEV;
> +	}
>   	err = do_rangeinfo_ioctl(dev, &rangeinfo);
>   	mutex_unlock(&dev->mutex);
>   	return err;
> @@ -3120,6 +3130,11 @@ static int compat_cmd(struct file *file, unsigned long arg)
>   		return rc;
>   
>   	mutex_lock(&dev->mutex);
> +	if (!dev->attached) {
> +		dev_dbg(dev->class_dev, "no driver attached\n");
> +		mutex_unlock(&dev->mutex);
> +		return -ENODEV;
> +	}
>   	rc = do_cmd_ioctl(dev, &cmd, &copy, file);
>   	mutex_unlock(&dev->mutex);
>   	if (copy) {
> @@ -3145,6 +3160,11 @@ static int compat_cmdtest(struct file *file, unsigned long arg)
>   		return rc;
>   
>   	mutex_lock(&dev->mutex);
> +	if (!dev->attached) {
> +		dev_dbg(dev->class_dev, "no driver attached\n");
> +		mutex_unlock(&dev->mutex);
> +		return -ENODEV;
> +	}
>   	rc = do_cmdtest_ioctl(dev, &cmd, &copy, file);
>   	mutex_unlock(&dev->mutex);
>   	if (copy) {
> @@ -3205,6 +3225,12 @@ static int compat_insnlist(struct file *file, unsigned long arg)
>   	}
>   
>   	mutex_lock(&dev->mutex);
> +	if (!dev->attached) {
> +		dev_dbg(dev->class_dev, "no driver attached\n");
> +		mutex_unlock(&dev->mutex);
> +		kfree(insns);
> +		return -ENODEV;
> +	}
>   	rc = do_insnlist_ioctl(dev, insns, insnlist32.n_insns, file);
>   	mutex_unlock(&dev->mutex);
>   	kfree(insns);
> @@ -3224,6 +3250,11 @@ static int compat_insn(struct file *file, unsigned long arg)
>   		return rc;
>   
>   	mutex_lock(&dev->mutex);
> +	if (!dev->attached) {
> +		dev_dbg(dev->class_dev, "no driver attached\n");
> +		mutex_unlock(&dev->mutex);
> +		return -ENODEV;
> +	}
>   	rc = do_insn_ioctl(dev, &insn, file);
>   	mutex_unlock(&dev->mutex);
>   	return rc;

It's OK as is, but may be better to use `else` to avoid duplicate calls 
to `mutex_unlock()`, `kfree()`, etc., replacing `return -ENODEV;` with 
`rc = -ENODEV;` or `err = -ENODEV;`.

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

