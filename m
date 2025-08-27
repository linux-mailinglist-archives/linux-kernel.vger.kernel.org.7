Return-Path: <linux-kernel+bounces-788576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B5BB386B5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8983618918A0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393102C2347;
	Wed, 27 Aug 2025 15:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="eqdakVXa"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28C41DF268
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308774; cv=none; b=KXWSAE2jhMuYuhU4Lg3q+jQd+tOnG5UmMgdyhz320KfT/uRwC4MYDv0O602J2++5lgkG2sPBx3EiEsmmrq+8mvsZs5lxq+R7q4ettZKeuWZ8fStsFlVFuqS+ePMIDH8MQq/Fm5253hAy0CxsS0p0C99/UmNGyXRKs+EfQQAuH2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308774; c=relaxed/simple;
	bh=P/UMJneckZjggAZT0x9bqgpsXF7fGkyvPGShSvidpPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQtWY6xvxG790MLN0geaGoZARcZPsx0WgDF+0Wbnbg+q8VYqtHyRzvZHUtKlv0fwp3gnSqOFuaKc1xirZ4WeVD/2s77qEY675wiwba/kKmrHfJWJD3PiM81lGAMq0HXqSIPkN3n7bgV6Q3KaDlyCCDuKCwJoFZlRnwOS0zBpV40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=eqdakVXa; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2445824dc27so67248545ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 08:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1756308772; x=1756913572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HkG/57BcwE4Wenob4AVy6xzEYDK8Mso4vqGc1h+KMKw=;
        b=eqdakVXaik++n7+qHSe+eTr3eTYn7nRaY7RsSkKBC3VEfm2SWM3Qsezp0fdDvkSZi6
         oYrQvyp+VUmoG46LBWUuEpY3CO1eGp2wWSQbf1H0xMWdVUTCbrSYfs62h/BE+EpkfMwa
         +uQPgASRvDLnvzsdF1Cu5Zx8LqHxMlXlTbcl1dPzR8u9QmoKx/ts9CykX4I/U1IYRv0X
         tBVdZXGTXZ7Hp/cGF69Ovni4Y1KNO2OdnDPLdqm9kioreqEBOAmfzn1kNS0qt735PtjR
         GH8bzq3hrv0Tprqgjfqw8QB906mWG1gkVqd3wlhwIIXvTkcDy7jSjbNdlgcPruJpODLX
         hCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756308772; x=1756913572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkG/57BcwE4Wenob4AVy6xzEYDK8Mso4vqGc1h+KMKw=;
        b=CpvpjQoBt+bEkK+0ivm35NgNvbKa0z5gqSMREOoLaFU7ROXhsXasl4dqeGpgTHy1xl
         nqb219hKSd4OzujoEKaAbbo7WyKTtZwk9+MQEhln3GajKFjrRObgX399ryMKvd4204e7
         4DNPkTJKGIK7cWmfUN73x+gLlOHBZ0RZBfaCXD7PWNaK5kU9QIWbCL5o9nPH0axeQA7e
         m2VX3ETW5ZooUV3fncQiBNmID0x7YIFVnV2/DNSKjEZAzoYt1fMSDspjaCdWUXygGSsS
         +/OfyXlNa7VW9C/h3UOI1ExZFvsy2J7nXIH+MXEHs0Ocy4pRd/CmOdJTshHuNKmUwH32
         uV6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6mtAXf0tVGJ3Sjjp02IFvz2HtQ2pnb3M3P/nt3nGKK0jI5e/G1ktljXEKcV8SdDH1q1cOp43PHhVRhQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxIYjEjeN4bXB88H+v0BKIiTOvxlfbRxz+FXORKOz/MhxsVx6G
	5llJ9jw4GBD+vBoFgcDS1EoDdvVQ6M0eSXtbwWrHdxfCXqA3ITD9emw1bcOQVhfDB7M=
X-Gm-Gg: ASbGnctYX6MYq/CiI8w5joyu39ob7pKQQtTgmPaiJcteGpO3nWov04AH3M1IJvGoCsr
	OBE4WzZ8JCM3g9dgZbXYKPxDqRVhnu7dI3YCG/jefhOZs1tGnrRaORWcRFQUurFkJOTaUQBpULO
	dzdt6gJlqIY3LpzAdY/EgI1hujc2rpcII5EcXi4bT4IgagjaL4FOFiN1/l1HINNJN2/yWOLe6L5
	SzeXkirIEly/ktHmG6dlnEE0yfWsAER4OfASsCcddPFbLtZaUJvstenex61ex0hrzfAlv+Gb9/u
	duDMaEWWsrWsqSqhq3O5IDWwTqSudySDoukvRNpci2Vq0ONPgDjUzuriNIOFTUgrXw3FafIHJs/
	tumu3M0l1l3e3XkQCia0gqSytxrM6ZmBk+dw=
X-Google-Smtp-Source: AGHT+IFLkgScNI+Yz9Vjrzk4w5lMnNdZBYL3hqwZyQm+Rd3Rkok5tTd8ktpgrIQiDrdDWglqEo7HhA==
X-Received: by 2002:a17:903:37cb:b0:240:763d:e999 with SMTP id d9443c01a7336-2462ef4c905mr268245105ad.29.1756308771887;
        Wed, 27 Aug 2025 08:32:51 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687a59b1sm125108945ad.42.2025.08.27.08.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:32:51 -0700 (PDT)
Date: Wed, 27 Aug 2025 08:32:49 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Wang Liang <wangliang74@huawei.com>
Cc: giometti@enneenne.com, mschmidt@redhat.com, gregkh@linuxfoundation.org,
	yuehaibing@huawei.com, zhangchangzhong@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pps: fix warning in pps_register_cdev when register
 device fail
Message-ID: <aK8lIakmj_5eoPZN@mozart.vkv.me>
References: <20250827065010.3208525-1-wangliang74@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250827065010.3208525-1-wangliang74@huawei.com>

On Wednesday 08/27 at 14:50 +0800, Wang Liang wrote:
> Similar to previous commit 2a934fdb01db ("media: v4l2-dev: fix error
> handling in __video_register_device()"), the release hook should be set
> before device_register(). Otherwise, when device_register() return error
> and put_device() try to callback the release function, the below warning
> may happen.
> 
>   ------------[ cut here ]------------
>   WARNING: CPU: 1 PID: 4760 at drivers/base/core.c:2567 device_release+0x1bd/0x240 drivers/base/core.c:2567
>   Modules linked in:
>   CPU: 1 UID: 0 PID: 4760 Comm: syz.4.914 Not tainted 6.17.0-rc3+ #1 NONE
>   RIP: 0010:device_release+0x1bd/0x240 drivers/base/core.c:2567
>   Call Trace:
>    <TASK>
>    kobject_cleanup+0x136/0x410 lib/kobject.c:689
>    kobject_release lib/kobject.c:720 [inline]
>    kref_put include/linux/kref.h:65 [inline]
>    kobject_put+0xe9/0x130 lib/kobject.c:737
>    put_device+0x24/0x30 drivers/base/core.c:3797
>    pps_register_cdev+0x2da/0x370 drivers/pps/pps.c:402
>    pps_register_source+0x2f6/0x480 drivers/pps/kapi.c:108
>    pps_tty_open+0x190/0x310 drivers/pps/clients/pps-ldisc.c:57
>    tty_ldisc_open+0xa7/0x120 drivers/tty/tty_ldisc.c:432
>    tty_set_ldisc+0x333/0x780 drivers/tty/tty_ldisc.c:563
>    tiocsetd drivers/tty/tty_io.c:2429 [inline]
>    tty_ioctl+0x5d1/0x1700 drivers/tty/tty_io.c:2728
>    vfs_ioctl fs/ioctl.c:51 [inline]
>    __do_sys_ioctl fs/ioctl.c:598 [inline]
>    __se_sys_ioctl fs/ioctl.c:584 [inline]
>    __x64_sys_ioctl+0x194/0x210 fs/ioctl.c:584
>    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>    do_syscall_64+0x5f/0x2a0 arch/x86/entry/syscall_64.c:94
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>    </TASK>
> 
> Before commit c79a39dc8d06 ("pps: Fix a use-after-free"),
> pps_register_cdev() call device_create() to create pps->dev, which will
> init dev->release to device_create_release(). Now the comment is outdated,
> just remove it.

Hi Wang,

I'm curious why pps_register_cdev() is failing, is there possibly a
second issue to investigate there? Or was it fault injection?

Otherwise, makes perfect sense to me. I'm new to this code, so grain of
salt, but since I exposed it:

Reviewed-by: Calvin Owens <calvin@wbinvd.org>

Thanks,
Calvin

> Fixes: c79a39dc8d06 ("pps: Fix a use-after-free")
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>  drivers/pps/pps.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
> index 9463232af8d2..0d2d57250575 100644
> --- a/drivers/pps/pps.c
> +++ b/drivers/pps/pps.c
> @@ -383,13 +383,11 @@ int pps_register_cdev(struct pps_device *pps)
>  	pps->dev.devt = MKDEV(pps_major, pps->id);
>  	dev_set_drvdata(&pps->dev, pps);
>  	dev_set_name(&pps->dev, "pps%d", pps->id);
> +	pps->dev.release = pps_device_destruct;
>  	err = device_register(&pps->dev);
>  	if (err)
>  		goto free_idr;
>  
> -	/* Override the release function with our own */
> -	pps->dev.release = pps_device_destruct;
> -
>  	pr_debug("source %s got cdev (%d:%d)\n", pps->info.name, pps_major,
>  		 pps->id);
>  
> -- 
> 2.33.0
> 

