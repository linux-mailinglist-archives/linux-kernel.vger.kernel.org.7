Return-Path: <linux-kernel+bounces-799834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45237B430CD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBF501BC43DC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEBF23909C;
	Thu,  4 Sep 2025 04:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="RMh+wrYe"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64E41E3DF8
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756958906; cv=none; b=GzJR3Ymlw/SMx6p1gD9gEG8Gka69jCwn0mx8R910FcqXyHIdnzdTFjOU6DveVMXZhSB+cNkDpde9fQ9sBVQR/reP2WXHhe/ne+Tkn9X5k7tLIHo/P6UK9qBgbksEt6kluGtbY4lk2ghKank6waACUDC1JTwUUoRkI6KD0RC8rfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756958906; c=relaxed/simple;
	bh=1JRwEzrIX2kkAGBMecS5GjyzkoFvn/tbeil7b3RcSgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUvIg6GwbfIAWxXApUK/u/MTsByHQrMbPMwhlYOqMMO+Mp9fH5xglUC5Tx4zKx+m3OC6astTfS4sK29Ejw9T4iNLiLhuMSHtKdkwxPn+bGk9tlzysiPLz3iuYi6O1QqGybeiUaQPF6kkGeEE6wteCM3kJ3YFUqu7aLcua+ATiC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=RMh+wrYe; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24b1596b1beso6555895ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1756958902; x=1757563702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/vOytjm+JByHKwE8veWgTHPwS5ggRjMOC7tSxApTbOE=;
        b=RMh+wrYelyT1fJI7Qukoi6oCHEXZeVvaziehsj2boyoXzB0egMTNh6yP6R0LFJrIjD
         zpxuzD8KM8O7pYh7tyixekWMBijCZAAWe8zOiDIaYvi02HTLxxvfKLK7KGXhHSqqlAg+
         kUsHMrKczsgobANYWzsHiDlLHEl3YIk1017QWPwob6l7iTH0nVZa3yi9z2VOl1t3II0e
         Ictgslhgjs3+PUfTwXwWds+HgizXH3e2e7aQuvnT1pQOmIaHv5ZQYfMNqn9h4kn7CxsK
         I+mN0lwNYdOvS2O0eg5sh9zG7LgW31pDpmEoDrS5fFoW+21BSA47Q1Cz8xRut5vRF8vw
         y2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756958902; x=1757563702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vOytjm+JByHKwE8veWgTHPwS5ggRjMOC7tSxApTbOE=;
        b=tRPmlRByKjvemI64IxhFQEYV7kD0urDs/wXKPG1q2ByTw2OaK0MlJ5Q9kP3UDipM69
         67hjGoulkTVY728AYT3siKu0ocIu0NcZq1zDh6YWBIXm9hUnpPEHcIwMzKbVNPdHs8aF
         k8bSCtf8UqX518u5SntTTtupRAN5ygsZBDhLYl+TppxeGc6wz5vMuCASxZhgxGJr2ljX
         U4hM66UUBwFvkqi64aK//OKt0BfevMVRt4C9sHe3nNWI4x59G+imXwLcG59ab1mnWIte
         T7mePReN9ZrSyFmaXsQ7AnZElFFdSZqx+Ez3cm+TVoVYFNZpSCzG/foy9vvilAFh1uGT
         G3aA==
X-Forwarded-Encrypted: i=1; AJvYcCVqj5XCt1pneDsLQKOYqgKSuFKzvfUVP9QJL0apNYDDLpUTYSyJLugdAXJqoQinQWsuYyRGuE5uenBZAnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN96BqWyBpTcioC7HgkmZErV/0GjI5a8nJXKrNvfkPHyCasHI0
	pgudQ/Iopqcny841bt+GTBhg8XXQRXrb67VbpJVykrAykHDE/Iochz1eItf4JcvOZV4=
X-Gm-Gg: ASbGncu2yS/UCja9qHVTJMPWXQSLylqeeMP2Jfcouy65ZbcRaJqYOBh+jraS2yvG1fv
	hbePH0MU0WNYqAZ8yrE4GPIvCY55ZVTHXwGuE9gCzR70/M8EGwHcnvKPy4vgmiJq6jAdrnwDyt+
	dnXgsDfFaK4Q+LTbenBRhfuJbqufgGbZCTRJGh1s4vXjJJyKXW6WSAiBK9i/2xmZ9dChBPmvMki
	CDYv+P+RbUIg47nC1KfcqktRqF7m0+MPiTntcznQEyB0ncmstEsVmazHh5I+NczYi2PuWE2U5b0
	DF0WJD0XCobILj11+IbZTzIjPJKc5dldeduFG1PcC/e9CT2TNYSF5MjKw8Rty/C0HFSbos2juGx
	oDnZkwIITMKk5dtcSjFPMkWy58bJWdalq1LQ=
X-Google-Smtp-Source: AGHT+IFXAHW+eWSiLT79d1NDwET9KOUKQ4ridYeJgKPA3Kkvd9ncaMJpxqMATAMr8NYPSbafeChong==
X-Received: by 2002:a17:903:f8d:b0:246:255a:1913 with SMTP id d9443c01a7336-24944b29d4fmr230559585ad.39.1756958901971;
        Wed, 03 Sep 2025 21:08:21 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24a92f89758sm136007985ad.9.2025.09.03.21.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 21:08:21 -0700 (PDT)
Date: Wed, 3 Sep 2025 21:08:19 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Wang Liang <wangliang74@huawei.com>
Cc: giometti@enneenne.com, gregkh@linuxfoundation.org, mschmidt@redhat.com,
	yuehaibing@huawei.com, zhangchangzhong@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pps: fix warning in pps_register_cdev when register
 device fail
Message-ID: <aLkQs8gNkK9NfiOh@mozart.vkv.me>
References: <20250830075023.3498174-1-wangliang74@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250830075023.3498174-1-wangliang74@huawei.com>

On Saturday 08/30 at 15:50 +0800, Wang Liang wrote:
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
> 
> Thanks for the reminder from Calvin Owens, 'kfree_pps' should be removed
> in pps_register_source() to avoid a double free in the failure case.

Looks good to me, thanks for cleaning this up :)

Reviewed-By: Calvin Owens <calvin@wbinvd.org>

> Link: https://lore.kernel.org/all/20250827065010.3208525-1-wangliang74@huawei.com/
> Fixes: c79a39dc8d06 ("pps: Fix a use-after-free")
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
> v2: remove kfree_pps in pps_register_source().
> ---
>  drivers/pps/kapi.c | 5 +----
>  drivers/pps/pps.c  | 5 ++---
>  2 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pps/kapi.c b/drivers/pps/kapi.c
> index 92d1b62ea239..e9389876229e 100644
> --- a/drivers/pps/kapi.c
> +++ b/drivers/pps/kapi.c
> @@ -109,16 +109,13 @@ struct pps_device *pps_register_source(struct pps_source_info *info,
>  	if (err < 0) {
>  		pr_err("%s: unable to create char device\n",
>  					info->name);
> -		goto kfree_pps;
> +		goto pps_register_source_exit;
>  	}
>  
>  	dev_dbg(&pps->dev, "new PPS source %s\n", info->name);
>  
>  	return pps;
>  
> -kfree_pps:
> -	kfree(pps);
> -
>  pps_register_source_exit:
>  	pr_err("%s: unable to register source\n", info->name);
>  
> diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
> index 9463232af8d2..c6b8b6478276 100644
> --- a/drivers/pps/pps.c
> +++ b/drivers/pps/pps.c
> @@ -374,6 +374,7 @@ int pps_register_cdev(struct pps_device *pps)
>  			       pps->info.name);
>  			err = -EBUSY;
>  		}
> +		kfree(pps);
>  		goto out_unlock;
>  	}
>  	pps->id = err;
> @@ -383,13 +384,11 @@ int pps_register_cdev(struct pps_device *pps)
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

