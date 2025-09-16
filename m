Return-Path: <linux-kernel+bounces-819170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6A9B59C6D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DA28175F63
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13A7299AAB;
	Tue, 16 Sep 2025 15:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="wiOGfKu6"
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DA1260575
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758037684; cv=none; b=oppp2rgKDYYBTzQBnGYUvrtDpt4J4NrFk7nVuQWmOTiMxt9BEx4+jcA5cu8VyKvY0vsryhWnZu+iE/xWIyi8jvGNdrAjkvisQzcPXPCpSThNKJ8Ts95Q01YaGReMjxqvKq4iBEUY8AuRMCkg19fcL5gqgIuVS4V0A36ia7o9YyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758037684; c=relaxed/simple;
	bh=5vmeuOQep/axLIESm0gMGf7FNHR8sSOeAgD3FaJZAjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3euuDZlHD90F0pv4o32H1nMQ/OUYQTMMTEIyi4f8ZqyKHb3QbnyPbu4hpKB406ngmiPaiPzkIw5iOLUwpi2Rw5qdLL1RO5guAq2W2gOQ0HfrcvdStJMLMIKFRyLPOhr9bLGcAEChYUiQXZXE0glzMBTRvXLdnDzZFAcw2CYhBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=wiOGfKu6; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-812bc4ff723so522996085a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1758037681; x=1758642481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SmRV7y5RVjtRRykDfJzsy6QTbLlkodoS8n+eLseT97c=;
        b=wiOGfKu6v1zDczasHwIQP03QsEZ1p8C2BqSVbPUn5+/B/UumfCz526uny3femMJlC9
         6GfVFNxGQH+k4KZxSCHY28amgRW7RKoTgHLdTssHsiHLjiR7movuLjAAhetQt8D+Yf1m
         eOjSFTQEdKVvZ0sE2X4FVWgMrFAuiuVxbIKyhPZSTCgi/c3A5snCGfcLq28rSOffjf4C
         8nU+6zxaR+Aw3w7/ZsgHEimt9KYhn1moJoJ3bhIRLH/k+srTPS5SrsiZ68rfViMehLdm
         xEMsmyxcHxrYXg8pGQRoJyuvNWHaa+cY0ZPcuj934vAzdmqwsHpO4/tYzqVN11BDoMq0
         yK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758037681; x=1758642481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmRV7y5RVjtRRykDfJzsy6QTbLlkodoS8n+eLseT97c=;
        b=eR8LW0rx8II1463jLkzX/eg9OdKvbhRwaBEMQ99csBLcliE4TDdW9p2/LVyjdDxrAj
         2/W4flyXQpll50O2NouRB0WRniGTkl9iiCrRTBg6DdGNjxqqnyjE25S3o2rU2rNGtcir
         lq1m43B8oU+XYX3MWGRZbPnJXjT6u/gdbWEg9jKbxzAmuOqMAmTZvTsIX2jxqcLvZgjD
         dWXzGAUa0jAZVrVCJpZTNF5RlQziJLebISmgA9oF/fWm8vSWEMF4v96Ep3GJhz55ewoU
         fvB0xdXWHXVxdjFnvyfTnLGrVWXBnX8kdPmXuj7s6sfA4KZ8YDTZS2YvLAZrV+P2/tSu
         8m9g==
X-Forwarded-Encrypted: i=1; AJvYcCW0ddaoa8fj60JPyd/DXy+U87108Xttl2y17NZ+tYcfQtOA/vUv9zXasj8RrFARDTbfsggAExO/WZdZcVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+SmmGKilGgHSaT+UPX5zwVuYrfrFuAxKF0z9WwtBL6LqKOGJ3
	Wq0wIxF/sGwFartrjouNbR5s3Er3sOOk4IRYw/+ZRWEbRp97bP7lAjZtpiptliJLnw==
X-Gm-Gg: ASbGnctFsbylEoyjVhn1jRlkqkBnj/Egk+Yb0ySIDReDwLELVjL1mcaAJar/2wY3Xd/
	FNAMM+uSXCUqIAasPWBOPqGd1ZlZfFye/fvxPuXl0NwHntY+9Q5cWRrXxPOsopzm/q+oaoMVna1
	O/2ebPOQVqnIosf95OUD2jI71GJXY9G/4pHyZSgaOdGvEe+VjF2zHjW+/alyW7lFXIEajT4xixX
	zXFOM8hIqCnCCpLeegf08Xa1UGpfnYdKqa4eb1Ik7ua3ke/ypM6Tqq0+rqwZH8qLnUXIWdyiMCF
	NSeAjykJ5o0yYGopcHNROSELGSGhbbYg+UFxQp+lLZG6EF/vrJrFDi5UBhFN+YHCn1XkA7sq1Wk
	8QdUjbD57twsPtOh57FgzIoQv
X-Google-Smtp-Source: AGHT+IHHEf/KxYrGaKTUWfkkpxyRuBCTOhkh8z8aYBa5H4Ru1Ukx3upLhzLd3vbVwE1UnR0C68KKrw==
X-Received: by 2002:a05:620a:4628:b0:80b:981:a0e4 with SMTP id af79cd13be357-8240084e283mr1902714085a.70.1758037681099;
        Tue, 16 Sep 2025 08:48:01 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::bb27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820ce19d151sm954058385a.50.2025.09.16.08.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:47:59 -0700 (PDT)
Date: Tue, 16 Sep 2025 11:47:56 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Lizhi Xu <lizhi.xu@windriver.com>,
	Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	syzbot+205ef33a3b636b4181fb@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2] usbip: Fix locking bug in RT-enabled kernels
Message-ID: <61e796d2-0139-4459-a4e3-f27892384de2@rowland.harvard.edu>
References: <4f7805f7-805a-4678-8844-c38a97650dda@rowland.harvard.edu>
 <20250916014143.1439759-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916014143.1439759-1-lizhi.xu@windriver.com>

On Tue, Sep 16, 2025 at 09:41:43AM +0800, Lizhi Xu wrote:
> Interrupts are disabled before entering usb_hcd_giveback_urb().
> A spinlock_t becomes a sleeping lock on PREEMPT_RT, so it cannot be
> acquired with disabled interrupts.
> 
> Save the interrupt status and restore it after usb_hcd_giveback_urb().
> 
> syz reported:
> BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> Call Trace:
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  rt_spin_lock+0xc7/0x2c0 kernel/locking/spinlock_rt.c:57
>  spin_lock include/linux/spinlock_rt.h:44 [inline]
>  mon_bus_complete drivers/usb/mon/mon_main.c:134 [inline]
>  mon_complete+0x5c/0x200 drivers/usb/mon/mon_main.c:147
>  usbmon_urb_complete include/linux/usb/hcd.h:738 [inline]
>  __usb_hcd_giveback_urb+0x254/0x5e0 drivers/usb/core/hcd.c:1647
>  vhci_urb_enqueue+0xb4f/0xe70 drivers/usb/usbip/vhci_hcd.c:818
> 
> Reported-by: syzbot+205ef33a3b636b4181fb@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=205ef33a3b636b4181fb
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
> V1 -> V2: fix it in usbip
> 
>  drivers/usb/usbip/vhci_hcd.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> index e70fba9f55d6..eb6de7e8ea7b 100644
> --- a/drivers/usb/usbip/vhci_hcd.c
> +++ b/drivers/usb/usbip/vhci_hcd.c
> @@ -809,15 +809,15 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
>  no_need_xmit:
>  	usb_hcd_unlink_urb_from_ep(hcd, urb);
>  no_need_unlink:
> -	spin_unlock_irqrestore(&vhci->lock, flags);
>  	if (!ret) {
>  		/* usb_hcd_giveback_urb() should be called with
>  		 * irqs disabled
>  		 */
> -		local_irq_disable();
> +		spin_unlock(&vhci->lock);
>  		usb_hcd_giveback_urb(hcd, urb, urb->status);
> -		local_irq_enable();
> +		spin_lock(&vhci->lock);
>  	}
> +	spin_unlock_irqrestore(&vhci->lock, flags);
>  	return ret;
>  }

This looks right to me; it's the same pattern that the other host 
controller drivers use.  However, the final decision is up to the usbip 
maintainers.

Also, there are several other places in the usbip drivers where 
usb_hcd_giveback_urb() gets called; shouldn't they all be changed to 
follow this pattern?

Alan Stern

