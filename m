Return-Path: <linux-kernel+bounces-857508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE139BE6FAA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8970561684
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C73324676C;
	Fri, 17 Oct 2025 07:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DAySF/xR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F40023EA86;
	Fri, 17 Oct 2025 07:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760686884; cv=none; b=RV/Xl13cEtzS6sQ/kxazrAv7p9x7nah/h/ZhHfC8n+5/GtcMwIfExghSaPGTTRbBNWE6Jt05+mCcdpt5VmDxyvVjklEqTehBEaUm/fdPArZBq2TsK+2DqTBqIREfmqsKwcmtQSGSJg87gz10xJHZJ0CnICfdUWgsPU+ZfMCak5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760686884; c=relaxed/simple;
	bh=mgJWBkBfXdtKnxWbZVUu/4ZVAdw06XdfHp/03SfU8qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eL0GYeegyT8LXQu60TVA6HL+5a+nJhf+ZB/ifrWtAcx++xvdY+eR4Y9hJSks5ZvICaimVf2hsmHCSxeFCPmzksRTWB9PVPjGT40haI/9I9/uQnoCdsFclWqqJtZYUhbnlEVQG7wCuwRvJxpBpBwDswINXXUoBeaWdQuGxN6sYtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DAySF/xR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D839C4CEE7;
	Fri, 17 Oct 2025 07:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760686883;
	bh=mgJWBkBfXdtKnxWbZVUu/4ZVAdw06XdfHp/03SfU8qQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DAySF/xRd018SWv5FuwBnhgSbi6LisNNVgJV5Cs/WSfMMe77pYlhSRpH9F4fq2G4m
	 0fx+S1LzSqIubB6bNPwKl2o3lzs6V6mhDzwB5x+B9Ol/xqa1MZoiO5spIUEo3HhHy4
	 XGuLRTrGt2/3kYB96md354bDemqHFHZ401xDuKlg=
Date: Fri, 17 Oct 2025 09:41:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Deepak Sharma <deepak.sharma.472935@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	syzbot+6c905ab800f20cf4086c@syzkaller.appspotmail.com
Subject: Re: [PATCH] drivers: core: Fix synchronization of removal of device
 with rpm work
Message-ID: <2025101714-fiction-reprocess-9368@gregkh>
References: <20250917030955.41708-1-deepak.sharma.472935@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917030955.41708-1-deepak.sharma.472935@gmail.com>

On Wed, Sep 17, 2025 at 08:39:55AM +0530, Deepak Sharma wrote:
> Syzbot reports a use-after-free at `rpm_suspend`, while the free
> occurs at the `usb_disconnect`
> 
> All line numbers references will be for commit ID
> d69eb204c255c35abd9e8cb621484e8074c75eaa

Which is 6.17-rc5?

Please always include the full commit information when referencing git
ids.  This would be:
	d69eb204c255 ("Merge tag 'net-6.17-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

Which is an odd point in our tree :)

> This points to a possible synchronization issue. In `usb_disconnect`
> there's a call to `pm_runtime_barrier` but it does nothing more than
> acting as a sort of "flush" (while cancelling what's the pending
> rpm actions not started yet). There does not seem to be any increase
> in device usage count either in this stacktrace after this stacktrace

How is syzbot triggering any of this?  How is it disconnecting a device,
is this through the gadget api or something else?

> Then we have an eventual call to `device_del`, which further leads
> to a call to `device_pm_remove`. No code synchronizing in any way
> so far with the PM system after that `pm_runtime_barrier`
> 
> Let's say now that the timer expiration queued work for `rpm_suspend`
> executed in this period of absent synchronization. We can create few
> interesting situations here, I will address one
> 
> Let's say that we unlock the `dev->power.lock` at `rpm_suspend`
> work at `drivers/base/power/runtime.c:723` and then the code
> `device_pm_remove` proceeds as normal clearing up the device.
> Any further calls are not going to cancel the tasks we have pending
> and since the lock has been given up, we will proceed, and end up
> deleting the device too, which will lead to a use-after-free
> as observed.
> 
> So at the device removal, we could add a `pm_runtime_forbid`,
> followed by a `pm_runtime_barrier`. This leads to the completion of
> any pending work and forbids any other new work to be added.
> 
> Once we return, we can do `device_pm_remove`. `pm_runtime_forbid`
> does not seem to influence the behavior of `device_pm_remove`
> (tho it does lead to a call to `pm_runtime_get_noresume()` which
> touches the device usage count, but it would still work the same)
> 
> Reported-by: syzbot+6c905ab800f20cf4086c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=6c905ab800f20cf4086c
> Signed-off-by: Deepak Sharma <deepak.sharma.472935@gmail.com>
> ---
>  drivers/base/core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index d22d6b23e758..616fd02d18ed 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3876,7 +3876,13 @@ void device_del(struct device *dev)
>  	device_remove_file(dev, &dev_attr_uevent);
>  	device_remove_attrs(dev);
>  	bus_remove_device(dev);
> +	/* We need to forbid and then proceed with a barrier here,
> +	 * so that any pending work is flushed 
> +	*/

Trailing whitespace which checkpatch should have caught :(

Also odd comment style.

And you don't document what type of barrier or what type of pending work
you are flushing.

> +	pm_runtime_forbid(dev);
> +	pm_runtime_barrier(dev);
>  	device_pm_remove(dev);
> +	pm_runtime_allow(dev);

Why are you allowing this to happen again?  The device is going away, it
should be stopped by now as per the bus removal.

This all feels very fragile.

thanks,

greg k-h

