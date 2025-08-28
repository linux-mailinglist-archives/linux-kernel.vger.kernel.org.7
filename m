Return-Path: <linux-kernel+bounces-790090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA63B39F3A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E976F188A9E9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FE93112C8;
	Thu, 28 Aug 2025 13:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="MjKK3Dtj"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B562C1D63D8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756388487; cv=none; b=QC0DbmsEDYEysyXdeX359PhiI183n8kMifHRqIgjuVngDMoaMh1RUksa8sQ9Vw57tugcUKQSTZ5WuykVaWikVGudgWPjAarhPZ42hx9XAPQVk8WRiKc56nQiYfkPR21A0c2jVzNOqgKtZDMChkXi53ZsxbPvWMPEXpZo8Vjo1MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756388487; c=relaxed/simple;
	bh=PL7F268rqVN0kzepayKHsOBthscu5J8ZLA+JAVENn4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdDC3PxrPxrCPShL2a9uYWAyWbttgIj5YISFnsoqRUr/kGjQM5ja5WSiLwfZ4mI79GhVq8lQp/885wwpxWX0+ucFg+9ZzOGXaShF0HvcW78iqRf5pqfTIzAucr6QDySL12g24f3RwQx1sFRABsGQJLMORcozGLHAOAwz2dh+qAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=MjKK3Dtj; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-770d7dafacdso1058399b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1756388484; x=1756993284; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BaNd4zgJDvSVwDta7Z2HUiEHvw8kwrQhC0z21XNx1zE=;
        b=MjKK3Dtj3odxcjTC2IYyp8qxM3dVh3rZ1mjW8anUYJ9a89A6sfEKkA0En9CmEe210T
         08E5F68nagEajWH+i9Kf5qK8hdJMzQQqmyC++bAxero/siPhYeLWBbwxT7U5kKRrcBrQ
         /EmGjiyFz7gnvMHaos+ya1hv90jLf0pABNWgFxXXTwwQxjZtpLoOFNGtJzWgn8o1Zlpk
         X76XnkgAxLsRSzjbkfVyXTZC4AETQOrIeWShbZ/xjb0NrM9rCQbJ8ACwoeUprp8bO7yx
         1D3b4dz7wWAI+rnom0uuICczRrdUoU3grfst9XVO1XFld89e10aio5qRBKrmK82QsQ7J
         IRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756388484; x=1756993284;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BaNd4zgJDvSVwDta7Z2HUiEHvw8kwrQhC0z21XNx1zE=;
        b=EMt6zYPggctO7fqH4IjvrVSIy/uX7FHQmCX2sog5+mB4/HxrqyWEd89I+tWo3m9oSW
         X2uAAdYpc0x4M5CsYx0I8TN1ntuhkZyc+6plJXEtcJHyj7K8RHDRY2s5l6QLXdWOUOtQ
         FMfECrEWeofDQpK4g7UmWhLXRH52Vz4qzVUazyNAi/WBUVPK/zyOPhvxKYfW0k5cQ8mo
         tbui9BKBDzyB0QMmsBGArMljzJ3ivNv3kDaUa6/1hQJCwB6GU5Wa8iukJAAb4epi6hbP
         tej6hfzKjLp5nCkuqgDP/x981p/YsDvVxB0Iz1EkD6/QeC8ckNpMO2gUjfqyM0nUD9eJ
         FUhw==
X-Forwarded-Encrypted: i=1; AJvYcCW3C6IAqQWWsJPPuXBqEnL9dmmFNgJTEe+Kg51dcKW4pwleGLJIuHuGIZj7PdYq+7Y+9ectyJtHux65V0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9U0DsSXsaC21frR28hBoxBjPXUe5x5DnwLFZTgJd3+mk8R5o7
	S8u37GJe0sdKIHHxOgj1vO/mnbNs85X3Qu81g4uNI+4wh88NqMvMm2fkfjQrgjoV6qo=
X-Gm-Gg: ASbGnctBtN/+BLqGPofmf1zIBr4WNmzszO+YsrlRvBO5LJ/D0eBtexznl3endKPLd/X
	m3FpZ6M8SPWljbodYKmLcnSuz3ObQTWazDLRAX590A2P6kPbI2RdVGIeV9MF0IbzvGT784cgMbu
	408oXP5AfCC0LAikoGKD2QQjhy4kwjbdoIe5tJLWdXCfm/LcuNH5NTZYeZdnHWlWaPCK+eratkJ
	/Qj/ftIBPfuZ148P9/Qu2AcLTJkmTPd5pp03jZYz/ezRRa6pPCZIHvX7uak5IcmfSUCKeKxPF7Y
	OjPMrADXeYeEzlCru50UetEoNWLs1PVk8r7s/MCmJKDH5tBswMFqBSz3oHAwuBBT6HK0tdeKRfA
	xkewiYszVaskGuZiQFIqgUEVsupma+f7YN6E=
X-Google-Smtp-Source: AGHT+IEQzkyirglNRqXeXp6qgeffVdpkbeluDSoSGZXI5N427MwQHntWJtr/WbrZdj9g16hQ0jqHvQ==
X-Received: by 2002:a05:6a21:339c:b0:238:351a:6442 with SMTP id adf61e73a8af0-24340d5e23amr36210632637.45.1756388483813;
        Thu, 28 Aug 2025 06:41:23 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7703ffebd33sm16023891b3a.29.2025.08.28.06.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 06:41:23 -0700 (PDT)
Date: Thu, 28 Aug 2025 06:41:21 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Wang Liang <wangliang74@huawei.com>
Cc: giometti@enneenne.com, mschmidt@redhat.com, gregkh@linuxfoundation.org,
	yuehaibing@huawei.com, zhangchangzhong@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pps: fix warning in pps_register_cdev when register
 device fail
Message-ID: <aLBcgTpVO3VlVtM7@mozart.vkv.me>
References: <20250827065010.3208525-1-wangliang74@huawei.com>
 <aK8lIakmj_5eoPZN@mozart.vkv.me>
 <a390e024-6115-442f-a1f6-6ebe379ade9f@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a390e024-6115-442f-a1f6-6ebe379ade9f@huawei.com>

On Thursday 08/28 at 17:24 +0800, Wang Liang wrote:
> 
> 在 2025/8/27 23:32, Calvin Owens 写道:
> > On Wednesday 08/27 at 14:50 +0800, Wang Liang wrote:
> > > Similar to previous commit 2a934fdb01db ("media: v4l2-dev: fix error
> > > handling in __video_register_device()"), the release hook should be set
> > > before device_register(). Otherwise, when device_register() return error
> > > and put_device() try to callback the release function, the below warning
> > > may happen.
> > > 
> > >    ------------[ cut here ]------------
> > >    WARNING: CPU: 1 PID: 4760 at drivers/base/core.c:2567 device_release+0x1bd/0x240 drivers/base/core.c:2567
> > >    Modules linked in:
> > >    CPU: 1 UID: 0 PID: 4760 Comm: syz.4.914 Not tainted 6.17.0-rc3+ #1 NONE
> > >    RIP: 0010:device_release+0x1bd/0x240 drivers/base/core.c:2567
> > >    Call Trace:
> > >     <TASK>
> > >     kobject_cleanup+0x136/0x410 lib/kobject.c:689
> > >     kobject_release lib/kobject.c:720 [inline]
> > >     kref_put include/linux/kref.h:65 [inline]
> > >     kobject_put+0xe9/0x130 lib/kobject.c:737
> > >     put_device+0x24/0x30 drivers/base/core.c:3797
> > >     pps_register_cdev+0x2da/0x370 drivers/pps/pps.c:402
> > >     pps_register_source+0x2f6/0x480 drivers/pps/kapi.c:108
> > >     pps_tty_open+0x190/0x310 drivers/pps/clients/pps-ldisc.c:57
> > >     tty_ldisc_open+0xa7/0x120 drivers/tty/tty_ldisc.c:432
> > >     tty_set_ldisc+0x333/0x780 drivers/tty/tty_ldisc.c:563
> > >     tiocsetd drivers/tty/tty_io.c:2429 [inline]
> > >     tty_ioctl+0x5d1/0x1700 drivers/tty/tty_io.c:2728
> > >     vfs_ioctl fs/ioctl.c:51 [inline]
> > >     __do_sys_ioctl fs/ioctl.c:598 [inline]
> > >     __se_sys_ioctl fs/ioctl.c:584 [inline]
> > >     __x64_sys_ioctl+0x194/0x210 fs/ioctl.c:584
> > >     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >     do_syscall_64+0x5f/0x2a0 arch/x86/entry/syscall_64.c:94
> > >     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > >     </TASK>
> > > 
> > > Before commit c79a39dc8d06 ("pps: Fix a use-after-free"),
> > > pps_register_cdev() call device_create() to create pps->dev, which will
> > > init dev->release to device_create_release(). Now the comment is outdated,
> > > just remove it.
> > Hi Wang,
> > 
> > I'm curious why pps_register_cdev() is failing, is there possibly a
> > second issue to investigate there? Or was it fault injection?
> 
> 
> I find this issue from my local syzkaller project.
> 
> Function pps_register_cdev() call the universal interface 'device_register',
> which can return error when kzalloc fail, or sysfs error, etc.
> 
> Hope the above information is helpful.

Thanks Wang, no worries, I just noticed it was under TIOCSETD and
thought syzcaller might've lucked into something interesting there too.

> ------
> Best regards
> Wang Liang
> 
> > 
> > Otherwise, makes perfect sense to me. I'm new to this code, so grain of
> > salt, but since I exposed it:
> > 
> > Reviewed-by: Calvin Owens <calvin@wbinvd.org>
> > 
> > Thanks,
> > Calvin
> > 
> > > Fixes: c79a39dc8d06 ("pps: Fix a use-after-free")
> > > Signed-off-by: Wang Liang <wangliang74@huawei.com>
> > > ---
> > >   drivers/pps/pps.c | 4 +---
> > >   1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
> > > index 9463232af8d2..0d2d57250575 100644
> > > --- a/drivers/pps/pps.c
> > > +++ b/drivers/pps/pps.c
> > > @@ -383,13 +383,11 @@ int pps_register_cdev(struct pps_device *pps)
> > >   	pps->dev.devt = MKDEV(pps_major, pps->id);
> > >   	dev_set_drvdata(&pps->dev, pps);
> > >   	dev_set_name(&pps->dev, "pps%d", pps->id);
> > > +	pps->dev.release = pps_device_destruct;
> > >   	err = device_register(&pps->dev);
> > >   	if (err)
> > >   		goto free_idr;
> > > -	/* Override the release function with our own */
> > > -	pps->dev.release = pps_device_destruct;
> > > -
> > >   	pr_debug("source %s got cdev (%d:%d)\n", pps->info.name, pps_major,
> > >   		 pps->id);
> > > -- 
> > > 2.33.0
> > > 

