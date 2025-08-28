Return-Path: <linux-kernel+bounces-790051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE8EB39EB9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A88F1C8301E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38641311957;
	Thu, 28 Aug 2025 13:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="gvUBMkPP"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF443112D8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387467; cv=none; b=oB5BnlGKkYZPrVmRYnoYHq9DUUVE0pSPwKFioSSENBa4JrCTfFo5dfa4rDKulMrY63qlMmHd6jIj2qlHYCX4ljgLCalWNA1IwoIg5Z5yNI9nHxJimAmJLzZ16vQqEtJ/jeqmbqit0bRKiussnvpid8nkv8yoUMCu1zh0PIQrPGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387467; c=relaxed/simple;
	bh=JIIQ8HdX4xg6ooGNG2EQ6DNXEBDbUeog1AYdkJ7jNPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpIlXj4AD1kXqFnTCG5rOBR+G0xXKtpHbAwMQVE6DBRcbA3HEXMT7W9LpXfERbCE6iUolVnHAPMQRTcsB8jGi8YOTxeGrHVZToO/vkeatUBbvCG/lnX1Lpw2LUwHqSQgGD/XYE6ZFP3DqD11tjRmhoZrP7n/UVU5armrPCQqZrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=gvUBMkPP; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-771e987b4e6so727731b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1756387465; x=1756992265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FDRkPCo0asbsGhkq1ZiCZpOvy9VtYp/OV0fGTEmQQVE=;
        b=gvUBMkPPgVe94FKnsbS2yFwW/v8BAG744sXIey4X1hnxoOavnzaPJyWiZPya1ht9EK
         nQJtNDTRPt06sqwtpRQd1P8ABeHtch9LtFnitT9IqS/KuXCoP05lHDhWsLiy4z/8NuMZ
         0e4Fmd1gDDLjK9ScC6LNMRroHJ8x714EsV6aHGtNRGbmFpnJ8RTYrF6+KMmb+C9iDeo8
         Dxs4FnTCCzRK3EK6Kamf6V4UIBcbZ7AkF2btdKvkqghmdPeSzwukwN6mVVjTA7ANb22B
         ZYNZO/EwEW434NHvSvpWzh/AfqdXoy249Bcm90CRY6ErojSYHWci70te0Dy/l0VjLkUU
         u9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756387465; x=1756992265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDRkPCo0asbsGhkq1ZiCZpOvy9VtYp/OV0fGTEmQQVE=;
        b=XcW5xWZbVjVx8masHAkGUYmOiojAAbTkBnetuRUFfIewYoLyQlqpxlsC52fJvz+KPq
         qOlNp19ow3LNtg2ff9b3/bNJpG0MKL/OPY4QW7+i3Qfkf93zJnY3yTenMzrKasP19bvu
         xQBXtxuxJi/UADL8W6ipfjcO+MRH9WSlzlMyT7CESgJOowAm/XAFia62f+UFr2cjGEjs
         PtFju3kWWYF+adc4VqMtiG8OIukdeS6IVO+ibONPOS43ua/VMX0869nETxaUCOAriWiU
         idYr7IxSy0lADYsx4JpvgJOcIsWTWts+Pe525tbExKaZSLx1Oj2TmbOlQEGK1gJRSdt0
         +uQg==
X-Forwarded-Encrypted: i=1; AJvYcCWtGDIsfVv4dkVY2SobRG8WO/4EPWiuD/WEsG1PvtC2+8xl9SV0rB0A1KoTz1IsITeLWAagqOyvlGiwnKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyszASB2F3gTkONkMo8aeV2DSYonbGfg15Jy2mcpyBVQ0aUATP/
	kzQjY5Dzkw0CPpzhMbHz53eF89JIg4LYi7ItNJcNARrefa1T2m1CPvp2W8HB6S+9X0g=
X-Gm-Gg: ASbGncumTzNA2Pq+wVDq4sXuZPbRpRdEBsNEVFn3mVqLR57ZS29isZNZ/wIAL6BfTWB
	5CTDr5ONgkfZbU9LpAOK78lm0eBUvVqR5Jv26Pavbs88srOd27g+ZmjOlDCPKs5/SksRblqu8ua
	2kqxhKmmse0GQdPM0DyrLsqV30ng3/TwjT28/xUB2B7ZB1kx7s8wevoZ/HxK2U0Z+/eVc04nBLA
	BAk3Y+I5Sdv2wtKG/CJ9ZWasLwDOVmU6q3shQs/py8TAS+WIxhnnWJbcY8hP0lZCPcvWO20f9KJ
	7ERK1oSOpDBkF59ju8/Y+uKG0OfJfRkz+FsxM76Ig2dDkyrPBU+0ukb5lM4vkG61pSdISkUd8nR
	PM83i2S82P/nJ5deiFErLnfhh
X-Google-Smtp-Source: AGHT+IHlhfaNvzO85psNvdd+0JfWStVJePKgOzgh1XaDksTKEf5s4oZUpUvpd5gPVuE48/scdMHrAA==
X-Received: by 2002:a05:6a00:198b:b0:771:e06b:7edf with SMTP id d2e1a72fcca58-771e06b839bmr18620321b3a.24.1756387464681;
        Thu, 28 Aug 2025 06:24:24 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771e9c6f2ffsm10640297b3a.6.2025.08.28.06.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 06:24:24 -0700 (PDT)
Date: Thu, 28 Aug 2025 06:24:23 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Wang Liang <wangliang74@huawei.com>
Cc: giometti@enneenne.com, mschmidt@redhat.com, gregkh@linuxfoundation.org,
	yuehaibing@huawei.com, zhangchangzhong@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pps: fix warning in pps_register_cdev when register
 device fail
Message-ID: <aLBYh7Fkrgg1IReX@mozart.vkv.me>
References: <20250827065010.3208525-1-wangliang74@huawei.com>
 <aK8lIakmj_5eoPZN@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aK8lIakmj_5eoPZN@mozart.vkv.me>

On Wednesday 08/27 at 08:32 -0700, Calvin Owens wrote:
> On Wednesday 08/27 at 14:50 +0800, Wang Liang wrote:
> > Similar to previous commit 2a934fdb01db ("media: v4l2-dev: fix error
> > handling in __video_register_device()"), the release hook should be set
> > before device_register(). Otherwise, when device_register() return error
> > and put_device() try to callback the release function, the below warning
> > may happen.
> > 
> >   ------------[ cut here ]------------
> >   WARNING: CPU: 1 PID: 4760 at drivers/base/core.c:2567 device_release+0x1bd/0x240 drivers/base/core.c:2567
> >   Modules linked in:
> >   CPU: 1 UID: 0 PID: 4760 Comm: syz.4.914 Not tainted 6.17.0-rc3+ #1 NONE
> >   RIP: 0010:device_release+0x1bd/0x240 drivers/base/core.c:2567
> >   Call Trace:
> >    <TASK>
> >    kobject_cleanup+0x136/0x410 lib/kobject.c:689
> >    kobject_release lib/kobject.c:720 [inline]
> >    kref_put include/linux/kref.h:65 [inline]
> >    kobject_put+0xe9/0x130 lib/kobject.c:737
> >    put_device+0x24/0x30 drivers/base/core.c:3797
> >    pps_register_cdev+0x2da/0x370 drivers/pps/pps.c:402
> >    pps_register_source+0x2f6/0x480 drivers/pps/kapi.c:108
> >    pps_tty_open+0x190/0x310 drivers/pps/clients/pps-ldisc.c:57
> >    tty_ldisc_open+0xa7/0x120 drivers/tty/tty_ldisc.c:432
> >    tty_set_ldisc+0x333/0x780 drivers/tty/tty_ldisc.c:563
> >    tiocsetd drivers/tty/tty_io.c:2429 [inline]
> >    tty_ioctl+0x5d1/0x1700 drivers/tty/tty_io.c:2728
> >    vfs_ioctl fs/ioctl.c:51 [inline]
> >    __do_sys_ioctl fs/ioctl.c:598 [inline]
> >    __se_sys_ioctl fs/ioctl.c:584 [inline]
> >    __x64_sys_ioctl+0x194/0x210 fs/ioctl.c:584
> >    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >    do_syscall_64+0x5f/0x2a0 arch/x86/entry/syscall_64.c:94
> >    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >    </TASK>
> > 
> > Before commit c79a39dc8d06 ("pps: Fix a use-after-free"),
> > pps_register_cdev() call device_create() to create pps->dev, which will
> > init dev->release to device_create_release(). Now the comment is outdated,
> > just remove it.
> 
> Hi Wang,
> 
> I'm curious why pps_register_cdev() is failing, is there possibly a
> second issue to investigate there? Or was it fault injection?
> 
> Otherwise, makes perfect sense to me. I'm new to this code, so grain of
> salt, but since I exposed it:
> 
> Reviewed-by: Calvin Owens <calvin@wbinvd.org>

I apologize Wang, I missed something when I looked at this yesterday:

I think your patch introduces a double-free, because the pps object is
already freed by pps_register_source() when pps_register_cdev() returns
an error. Because put_device() was a nop with the missing release_fn, it
wasn't actually doing anything. That's very confusing, and my fault.

Your patch is clearly an improvement. But I think you additionally need
to remove the 'kfree_pps' error logic at the bottom of
pps_register_source() to avoid a double free in the failure case:

diff --git a/drivers/pps/kapi.c b/drivers/pps/kapi.c
index 92d1b62ea239..4d0ba35590a3 100644
--- a/drivers/pps/kapi.c
+++ b/drivers/pps/kapi.c
@@ -116,9 +116,6 @@ struct pps_device *pps_register_source(struct pps_source_info *info,
 
 	return pps;
 
-kfree_pps:
-	kfree(pps);
-
 pps_register_source_exit:
 	pr_err("%s: unable to register source\n", info->name);
 

The only reason I put that kfree() there is because I noticed the memory
was being leaked in the failure case. Doh. Your patch makes this right.

> Thanks,
> Calvin
> 
> > Fixes: c79a39dc8d06 ("pps: Fix a use-after-free")
> > Signed-off-by: Wang Liang <wangliang74@huawei.com>
> > ---
> >  drivers/pps/pps.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
> > index 9463232af8d2..0d2d57250575 100644
> > --- a/drivers/pps/pps.c
> > +++ b/drivers/pps/pps.c
> > @@ -383,13 +383,11 @@ int pps_register_cdev(struct pps_device *pps)
> >  	pps->dev.devt = MKDEV(pps_major, pps->id);
> >  	dev_set_drvdata(&pps->dev, pps);
> >  	dev_set_name(&pps->dev, "pps%d", pps->id);
> > +	pps->dev.release = pps_device_destruct;
> >  	err = device_register(&pps->dev);
> >  	if (err)
> >  		goto free_idr;
> >  
> > -	/* Override the release function with our own */
> > -	pps->dev.release = pps_device_destruct;
> > -
> >  	pr_debug("source %s got cdev (%d:%d)\n", pps->info.name, pps_major,
> >  		 pps->id);
> >  
> > -- 
> > 2.33.0
> > 

