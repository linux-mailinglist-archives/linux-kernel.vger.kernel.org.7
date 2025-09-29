Return-Path: <linux-kernel+bounces-836678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1020BAA492
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 20:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CF131C4252
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 18:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C0323B61E;
	Mon, 29 Sep 2025 18:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="z98r0WBj"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE141C8605
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 18:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759170404; cv=none; b=QYgkXxzuci+uqfztvCharjtxCoU9iesKH8JY3l1ofKHfwO3oWBJNfplT1x3P533XKvE4EZBCVWGEUltFgJ5xgi6HC5qhjNVuJKb2oK0fOR7IvlxagJDJvUDO5J508NlXroRdzr2SDoo6fIgfikgvahjTx/G/Tc49rv3Fldt6tSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759170404; c=relaxed/simple;
	bh=mfHBnPq9iCTX7egJO5POY0ibnnkC/uTk9rgcgvOv4AI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJLNdwOQCOJ+RU1sfEq7MjBlTm6EaDFhu4vWJgEGTUbipDhG43dMXW3mmpf3tS+zcQc8xAzTmn0BCHXa26gfQ3KrybgXxQ7deNW8xDO0FQVKFE0/cW8yIz1NUuYui0n5GmdpkTjSmBuA+kQa6K2A1v30qoSWTsmx6nGTBYnE7Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=z98r0WBj; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-43f715fb494so267967b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1759170401; x=1759775201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eYghtAHXDu1pA8kk0UZm4ZBUJGT5BJDSlgQOoijoBY=;
        b=z98r0WBjTmkzJ/XZU+ruHFAWY631FPcZQaDXLFiGSTBvOYbok8rNwkBua7/6xjZyLo
         Q4tNWYGH4UxnJJ6FwSE+LF22LOw5eqIiJh/6Gkii/bjOHeJh6j5jOFmQ/aLt/ddG7c+x
         XhPtdn9N+Ne52XgdUdzYlIYPFMIIEigvsRsM7jmnBEDgVhkqsj5i+unHo68WNZXfr1dH
         V/hdzCwXGBmHbHUNBPcSOYTyS9N8zjGVrrJS4iLtSECr6zyguixTmm/f5AsR22PmZgnQ
         a+09y7PVTlU3GhBczVDyrXNf3U8l7ut+zuoXyQJRJ0cTGInnYxcaGCSGjmuU+mzU5yOQ
         hnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759170401; x=1759775201;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/eYghtAHXDu1pA8kk0UZm4ZBUJGT5BJDSlgQOoijoBY=;
        b=coj5R/W1jLLKIfSccW8p8f6JIyvBbx5F4Dy0iRiGIHjox7hqBa3iC9eNGx32p+Pco3
         NWCPj7Y4y5sGgxfkD8GGxxpW4tMu8M/Pb94+XvhC286kBMycMAZWeX8STQQtt0ntYRrs
         RjIQgaO0J255WCu0od7p699/mWfdvtytak0JRSTZd6V74dnX3ctD/kSokdoW6HEItYWl
         wHA+rjqnduY98nTxt9R3HzIVW1bB9Dm2duR64AIM7MkDwGrlazPboT8Fm29xKk1uQzon
         LRfG4hFZkL9atvboYfI4/x7G2ZE9guoKQx+K51SnOyE890oN6RMiOICyoAyETMBiU7bX
         0k3w==
X-Forwarded-Encrypted: i=1; AJvYcCUJNxzhCIvfi38cZF2GBBg40k73BWCgNAiQQIsTPGg8BmhGduZ5vBuvp9zUsbyr9kddOq5CmbCOwy40gsg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ketX2vCXUZzU4ffkWt22g7wJMHc0EFm5zyUzuHzENkkEP4ZO
	5onFQYzOslvLV0tT5YmI/9OhfC4rZHxRHCRws2zB6CxYMD6HKh4XMFvE99MpTnPNBGs=
X-Gm-Gg: ASbGnct9Zd6NPFD3ZWoQVYQN7ktCd66ifp8uj7v8CqgD+SnRZ1IJWqzxXcuTX/xGu5L
	dU3dMlusaH0gS8YHksrnB9thzFjOUIZolP/1jfSeFc3yyLx/3HBYlWaKyt0SiY1osmo/klaD70b
	6dmbrIcVX1XYHmjY3+4IwiQonIXSP9Bi5X1+tkLauvVwcLqmBCbM1F+wXGqclarf4rPZkH19CUi
	uo/MARkK0cCGWNu0JevfZKDHuYvI1v9czHF6DwU/eFk1b62KiQyCz4cY6AVPi3bIItqiaNegPmh
	ja/app9fb3xpHxefRtrSRRNSzeGWWO5LSlAleegO8nxPkwGUx85x0seCzM81qSZAhWbZteUCLhA
	b+KM+2HAC93pXZP4EezkqfMDI1hg1EAuW3bbEzFfmpP5+9Hc=
X-Google-Smtp-Source: AGHT+IEKLWxJ+3ZDPhd6Nur5aJ4UIrpgeIvU4A77msFQxuJvAzWesSOKns525AqkHpq9Nh3NzkYgqA==
X-Received: by 2002:a05:6808:2209:b0:43f:228a:2098 with SMTP id 5614622812f47-43f4ceb1890mr1512041b6e.42.1759170401179;
        Mon, 29 Sep 2025 11:26:41 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:5542:a82d:8748:cc0b])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43f51238c63sm2285632b6e.22.2025.09.29.11.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 11:26:39 -0700 (PDT)
Date: Mon, 29 Sep 2025 13:26:35 -0500
From: Corey Minyard <corey@minyard.net>
To: Jinhui Guo <guojinhui.liam@bytedance.com>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi: Close the race between __scan_channels() and
 deliver_response()
Message-ID: <aNrPW4AEfJhyh4rO@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20250929081602.1901-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929081602.1901-1-guojinhui.liam@bytedance.com>

On Mon, Sep 29, 2025 at 04:16:02PM +0800, Jinhui Guo wrote:
> The command "ipmi -b -t" would occasionally fail:
>   #ipmitool -b 6 -t 0x2c raw 0x6 0x01
>   Unable to send command: Invalid argument
>   Unable to send RAW command (channel=0x6 netfn=0x6 lun=0x0 cmd=0x1)
> 
> The race window between __scan_channels() and deliver_response() causes
> the parameters of some channels to be set to 0.
> 
> 1.[CPUA] After ipmi_add_smi() calling __bmc_get_device_id() ->
>          __scan_channels(), the intf->channels_ready is set to true and
> 	 is never cleared by any function. ipmi_add_smi() then invokes
> 	 __scan_channels(), which issues an IPMI request and waits with
> 	 wait_event() until all channels have been scanned. wait_event()
>          internally calls might_sleep(), which might yield the CPU.
>          (wait_event() could also be interrupted by an interrupt, causing
> 	 the task to yield the CPU.)
> 2.[CPUB] deliver_response() is invoked when the CPU receives the IPMI
>          response. After processing a IPMI response, deliver_response()
>          directly assigns intf->wchannels to intf->channel_list and sets
> 	 intf->channels_ready to true. However, not all channels are actually
> 	 ready for use.
> 3.[CPUA] Since intf->channels_ready is already true, wait_event() never
>          enters __wait_event(). __scan_channels() immediately clears
> 	 intf->null_user_handler and exits.
> 4.[CPUB] Once intf->null_user_handler is set to NULL, deliver_response()
>          ignores further IPMI responses, leaving the remaining channels
> 	 zero-initialized and unusable.
> 
> CPUA                             CPUB
> -------------------------------  -----------------------------
> ipmi_add_smi()
>  __scan_channels()
>   intf->null_user_handler
>         = channel_handler;
>   send_channel_info_cmd(intf,
>         0);
>   wait_event(intf->waitq,
> 	intf->channels_ready);
>    do {
>     might_sleep();
>                                  deliver_response()
>                                   channel_handler()
>                                    intf->channel_list =
> 				         intf->wchannels + set;
>                                    intf->channels_ready = true;
>                                    send_channel_info_cmd(intf,
> 				          intf->curr_channel);
>     if (condition)
>      break;
>     __wait_event(wq_head,
> 	    condition);
>    } while(0)
>   intf->null_user_handler
>         = NULL;
>                                  deliver_response()
>                                   if (!msg->user)
>                                    if (intf->null_user_handler)
>                                     rv = -EINVAL;
>                                   return rv;
> -------------------------------  -----------------------------
> 
> Fix the race between __scan_channels() and deliver_response() with the
> following changes.
> 
> 1. Drop the redundant __scan_channels() call in ipmi_add_smi(), the
>    function is already invoked via ipmi_add_smi() -> __bmc_get_device_id()
>    -> __scan_channels().

It's only called conditionally in __bmc_get_device_id(), what if it's
not called there?

> 2. channel_handler() sets intf->channels_ready to true but no one clears
>    it, preventing __scan_channels() from rescanning channels. Clear
>    intf->channels_ready to false in channel_handler() before starting
>    the channel scan.

This is mostly the intent.  The channels shouldn't change unless the BMC software changes.

The only exception would be after the comment:
    /* Version info changes, scan the channels again. */
    __scan_channels(intf, &bmc->fetch_id);

In that case, since the BMC has changed, you want to rescan the channels.
So you would want to reset that flag there.

> 3. Only assign intf->channel_list = intf->wchannels and set
>    intf->channels_ready = true in channel_handler() after all channels
>    have been successfully scanned or after failing to send the IPMI
>    request.

Yeah, that's a bug.

Normal style is to leave the {} in if any part of the if statement has
braces.

Also, the above three are independent problems; they should be separate
patches.

Thanks,

-corey

> 
> Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index 8e9050f99e9e..73dab3b21221 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -3405,11 +3405,8 @@ channel_handler(struct ipmi_smi *intf, struct ipmi_recv_msg *msg)
>  			intf->channel_list = intf->wchannels + set;
>  			intf->channels_ready = true;
>  			wake_up(&intf->waitq);
> -		} else {
> -			intf->channel_list = intf->wchannels + set;
> -			intf->channels_ready = true;
> +		} else
>  			rv = send_channel_info_cmd(intf, intf->curr_channel);
> -		}
>  
>  		if (rv) {
>  			/* Got an error somehow, just give up. */
> @@ -3433,6 +3430,9 @@ static int __scan_channels(struct ipmi_smi *intf, struct ipmi_device_id *id)
>  {
>  	int rv;
>  
> +	/* Clear channels_ready to force channels rescan. */
> +	intf->channels_ready = false;
> +
>  	if (ipmi_version_major(id) > 1
>  			|| (ipmi_version_major(id) == 1
>  			    && ipmi_version_minor(id) >= 5)) {
> @@ -3633,12 +3633,6 @@ int ipmi_add_smi(struct module         *owner,
>  		goto out_err_started;
>  	}
>  
> -	mutex_lock(&intf->bmc_reg_mutex);
> -	rv = __scan_channels(intf, &id);
> -	mutex_unlock(&intf->bmc_reg_mutex);
> -	if (rv)
> -		goto out_err_bmc_reg;
> -
>  	intf->nr_users_devattr = dev_attr_nr_users;
>  	sysfs_attr_init(&intf->nr_users_devattr.attr);
>  	rv = device_create_file(intf->si_dev, &intf->nr_users_devattr);
> -- 
> 2.20.1
> 

