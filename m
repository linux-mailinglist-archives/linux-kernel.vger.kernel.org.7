Return-Path: <linux-kernel+bounces-729322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06409B034F4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 05:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F25717393B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 03:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBD11E04AD;
	Mon, 14 Jul 2025 03:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aqb8lVH3"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687741DF26B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 03:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752463752; cv=none; b=NILz/632t5ozPWhhQ7CyM1nt5dDoQkk3YOL66yfrt/5fkMyDxqWVIaARwfTVvFt6SItUaVIC/Ro5r+elRkzZmptM4yd3Hoh0UrrjwH53F2fX+DW5j86WFFIMSmy3SeSjaS6o14mu0+ojhEHwlTzvBhivc8pZxZIKubO9VLJ1904=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752463752; c=relaxed/simple;
	bh=cn680N+Lbe1YOLdllxDrT4jSd2RORFRplVpLq6vJcBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQwV4uM1gMrU07JcaGkeZ48MUL5iXvwaZ+M2nabSO1dxXtl/NYbK+BRZKgiD0yJm8zXQd2AFfH0R/tnKFxMLotOn3S6yfGs75uGz1mBy7cPG498FQIeIycJx1RXSlzFVXYR4WepVWFghdPbqe0I136DXrZxwnEVSnVQfSiMWarM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aqb8lVH3; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b2c4e46a89fso3106342a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 20:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752463750; x=1753068550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AuFfMb94T1QlI5VB+hGYMUtffHMe70rkO85YQAjY0iE=;
        b=aqb8lVH3MxA5ju5G0Ymm/qyM/EJ6vTB+J0PSUxIrfLipd0jJaLLg9QU4ruY6YztKIF
         7gac8KyQPnXQYIPa/8qv1WEEhEVVVULw8kR5DOWzqPQiVrozsS5la87osoL3BJv3sF3a
         S6u6EzVDZLA5fKoGh0rx32dsnxVyTAO5e7kxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752463750; x=1753068550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuFfMb94T1QlI5VB+hGYMUtffHMe70rkO85YQAjY0iE=;
        b=mcf9+lBZ6h6xfAPg9ad8o6ktf/Pui2P+8D4IkTUwgBKUntLqHjQFRrFf1/td01Q/4K
         hdx21GlpkTOu42IEQLuLgB+0J90sHfTl/xO74QoLqwgVeN1VX2LJGlWW0kLxRjlNejEf
         wvgP9g8/HP9jB0Hv9FBh+uTnPG+oSfurg7c4MCjrrKZcAHL4oUXVB3908FJ/pL9JIIV9
         B6M3OpHgxOtTvxrhC+ix8PUYtYEanqOXgBfSFKfmRCT0d1DlHMJBruGlJLtWRpPdp6jp
         zgcC/x+3y8uS876+Old2rGbhpOVXnevqjqC3b7uNeXKStmVTPFKhzj15d4CC8z3Qasw2
         34kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJCfAgr1KIde8JZ0NWofermsA/V6EsHmnEioDhpJoMy2d38eissZDbGvGfHJMbxOCY+jLuLTpCgqGBWzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCMaeAU3T4IFN+LvLDrf9dlNLVaVVnYcS5XWR3dyssobn6z7dG
	loUPArOXMGYz32oROFg5YJqPXV5fn6s8Yi0NjUZ8m33UwiVUYLb4RFxxq0IwaTV69A==
X-Gm-Gg: ASbGncuROXyB/8qTqUJn6aR8xBmFvGIH5qtvqOa6Bj8cBynO576a2H2N1nMZWxDutWf
	hoGfpmxvsbFBta6rcP24ck3vIhNbDHWz11eZVN8FnoBIjZr8FOWAH+BMYn4y91FuEJRR359LIvr
	xf+ZgOQ3zbSBE9srXOd6rYPPLdJV7CfJUtcv6bu3pJDxIpfyLAz8kn1g6a9erb1Z0CPcJwvk5X4
	zJFH/6ieEy04HZyOJ4fK40x1rsJdRrdL71RQpsFuu7jOYMnXncDzrgi3WlSJC34+BikLgkWMcqo
	G5SdA3kito8KlNqajbYI15VAzFDp9ZtgNYGtrlyzGCWW74sftsH3/AYcl93dSSoFMVVytuegsSb
	UTZvU6GOHMW/rzVAfkVXbvgDYgQ==
X-Google-Smtp-Source: AGHT+IGFvP2mdH1afPSE7DmUb8WifMmqbuLptsjHv9YDI67dI175Nw5rSwYCLwFWOxdl9topoJcN8Q==
X-Received: by 2002:a05:6a21:f119:b0:232:ac34:70f1 with SMTP id adf61e73a8af0-232ac3472a1mr10402898637.30.1752463749673;
        Sun, 13 Jul 2025 20:29:09 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:d84e:323a:598d:f849])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f7fa50sm9322801b3a.145.2025.07.13.20.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 20:29:09 -0700 (PDT)
Date: Mon, 14 Jul 2025 12:29:04 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Phillip Potter <phil@philpotter.co.uk>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, 
	Chris Rankin <rankincj@gmail.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: cdrom: cdrom_mrw_exit() NULL ptr deref
Message-ID: <fcoixqhllcn4cjycwse253zeyg27bghyrsablmlw6cdz7c27xj@3tzfom227xrq>
References: <uxgzea5ibqxygv3x7i4ojbpvcpv2wziorvb3ns5cdtyvobyn7h@y4g4l5ezv2ec>
 <aHF4GRvXhM6TnROz@equinox>
 <7kbmle3wlpeqcnfieelypkxzypfxoh7bqmuqn2d3hbjgbcm7mt@cze3mv7htbeg>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7kbmle3wlpeqcnfieelypkxzypfxoh7bqmuqn2d3hbjgbcm7mt@cze3mv7htbeg>

On (25/07/14 12:10), Sergey Senozhatsky wrote:
> Date: Mon, 14 Jul 2025 12:10:16 +0900
> From: Sergey Senozhatsky <senozhatsky@chromium.org>
> To: Phillip Potter <phil@philpotter.co.uk>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,  Jens Axboe
>  <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,  Chris Rankin
>  <rankincj@gmail.com>, linux-kernel@vger.kernel.org,
>  linux-block@vger.kernel.org
> Subject: Re: cdrom: cdrom_mrw_exit() NULL ptr deref
> Message-ID: <7kbmle3wlpeqcnfieelypkxzypfxoh7bqmuqn2d3hbjgbcm7mt@cze3mv7htbeg>
> 
> On (25/07/11 21:46), Phillip Potter wrote:
> > > <1>[335443.339244] BUG: kernel NULL pointer dereference, address: 0000000000000010
> > > <4>[335443.339301] RIP: 0010:blk_queue_enter+0x5a/0x250
[..]
> > > <4>[335443.339439] blk_mq_alloc_request+0x16a/0x220
> > > <4>[335443.339450] scsi_execute_cmd+0x65/0x240
> > > <4>[335443.339458] sr_do_ioctl+0xe3/0x210 [sr_mod (HASH:ab3e 2)]
> > > <4>[335443.339471] sr_packet+0x3d/0x50 [sr_mod (HASH:ab3e 2)]
> > > <4>[335443.339482] cdrom_mrw_exit+0xc1/0x240 [cdrom (HASH:9d9a 3)]
> > > <4>[335443.339497] sr_free_disk+0x45/0x60 [sr_mod (HASH:ab3e 2)]
> > > <4>[335443.339506] disk_release+0xc8/0xe0
> > > <4>[335443.339515] device_release+0x39/0x90
> > > <4>[335443.339523] kobject_release+0x49/0xb0
> > > <4>[335443.339533] bdev_release+0x19/0x30
> > > <4>[335443.339540] deactivate_locked_super+0x3b/0x100
> > > <4>[335443.339548] cleanup_mnt+0xaa/0x160
> > > <4>[335443.339557] task_work_run+0x6c/0xb0
> > > <4>[335443.339563] exit_to_user_mode_prepare+0x102/0x120
> > > <4>[335443.339571] syscall_exit_to_user_mode+0x1a/0x30
> > > <4>[335443.339577] do_syscall_64+0x7e/0xa0
> > > <4>[335443.339582] ? exit_to_user_mode_prepare+0x44/0x120
> > > <4>[335443.339588] entry_SYSCALL_64_after_hwframe+0x55/0xbf
> > > <4>[335443.339595] RIP: 0033:0x7d52bea41f07
> > > 
[..]
> The device is detached already, I assume there isn't much that
> cdrom_mrw_exit() can do at that point.

If I read it correctly

<4>[335443.339482] cdrom_mrw_exit+0xc1/0x240 [cdrom (HASH:9d9a 3)]
<4>[335443.339497] sr_free_disk+0x45/0x60 [sr_mod (HASH:ab3e 2)]
<4>[335443.339506] disk_release+0xc8/0xe0
<4>[335443.339515] device_release+0x39/0x90

device_release() calls dev->type->release() before dev->class->dev_release().
dev->type->release() probably should be scsi_device_dev_release() which, among
other things, does sdev->request_queue = NULL, so dev->class->dev_release()
is called too late to execute any scsi commands.

