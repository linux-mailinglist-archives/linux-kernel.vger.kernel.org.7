Return-Path: <linux-kernel+bounces-899533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CABC58111
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 25443353801
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7281D2D46C0;
	Thu, 13 Nov 2025 14:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="HztQvODp"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3ED29ACD7
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 14:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763045447; cv=none; b=OdEjU3FB6AAaDFol2nqKUCxndFb+utL+uJ4LNPHigzOieKymp4XCceZACyUv/mL/s+E8UdMq3PgWJq+CppJ+Tl99aW50Lw6nsdfmU1NnaPa7rjBhMhESBEYG0RgmH/9ZORTouVxvaCRthpwYA3UgbT9JZzTjqj6G0SZOd4LwuIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763045447; c=relaxed/simple;
	bh=V3NRUkCwpyXAHKZhigjr+8gsAPXHs140yNAQg5Rd8BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYu9lY2JfRLl/V3VVO94MnpqOjXgWLZvyMMNpq3LDREyRahk6ETlU1IcwE67JeDxkKit7IpwL+0FlXcOiP8ml2msWdXTADUPB7gWQG9F1/mwX7u65wtD1GhuE+Pabs3pp5p6kFArD51qtgSmabadPzAgggT5U+SX/6YmqnBKsp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=HztQvODp; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4edb166b4e3so7234271cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1763045445; x=1763650245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ET0d96Jr74GPyOWniH5D9NAeGfbNYsnJ+p2BnWJ+Iz4=;
        b=HztQvODp/VXWNtXvR4iPJvBmULDFA35mrzuKpKOBrBl/UZBV2G/XgJfErZ2rFwOcj1
         oQa69/nCzDaVlEocv8lKOOUkX+AybjPM8w1Fl3fY6a3Cgjdc8Cf/MjgO81/YEV3rEhQ4
         aigUFOne7/KkUjcr980QKYNcLtAuk9pN3kcoTCtBRApwGuE6jF9X6QVlOOWEg/75831k
         rxDrCF6R/aeKTrw4svlcciICxa8yuAJ0uE83zOnzWWH/5kcjptVArDC4hM5tlk1wf91m
         YOCoDo7rroNRSnp6BZBaZA4xXnNhv2feGvj/OWb7oI/dI4gA4kMpmLkYG0dIqseXQ5hb
         F6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763045445; x=1763650245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ET0d96Jr74GPyOWniH5D9NAeGfbNYsnJ+p2BnWJ+Iz4=;
        b=KORd0wW2IuiQqFRjxHgh8m9OkpBX4JkwR5lJVR2I03iCX55KYm4lJhgku0AhlqLuJ3
         /MC//N8xPxesjFHddEYrt09c9pRWKQ4gvv4KT3yDIy7HXd/Lqrg6nJ4zxtfyKbtTzA21
         TnoPF6wmIIAodVI+ujcZ9aht6FYXpjH+McAMuc6RH00s2ukHekNbBVcaikDEeWhfJo5M
         REA4aKc+DdthLh97vIKKbhWtsjletiyCGsRGMWJC7rxx0oNY+1oRVzGWAPeT/KbGwrC0
         dhDfsk5STxMa3R7+kzd1rtnUI58n3pa7uRSDupyQIQZiavSUkY7fBdTQ1jsgyzavdYU2
         2fPw==
X-Forwarded-Encrypted: i=1; AJvYcCUwWgNFljwOBd9Aq6zPFsxv6zd1f16qSiitUi7sCzPlyiU0jug56URWecIM3mY6SubP03fARUYBxxkkgOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2MQuCLY+6aL91e2FXnCtmu6G5F3DhuljL56W1vH52xmZzhM0H
	iJO2IjHpAZEZ1TIsW8yhpJXXe3PhfXgjDBknJ73cRJLrCvPrGT2jqwAHIGn7tfetoDl41iiPBIP
	Sox3oag==
X-Gm-Gg: ASbGncuIwgyHXr0HI5am5qUPhkdhVyhQmsQpLxS0e0n5AMAGUyICbXHTnvssG2gZEAn
	zU+L+9d+nHZ7HkqyfSVEv8ZK52yghv16i8O+br2ap/3ThLveb2CiC+nWQ8AaDlxlxLFNhkuGUYg
	v/FR0wOIKQXK4Xst9wlYvlsJ1XK3N+8cuTnYOrkggpqAYPctL10DcoM0n7eeXvWqxzwKq0qWLK0
	CKwdktsFpZVy30FLyNjBjMsdEeIRmwGyWrMWmBzRQyg1ztqEQAp82XeVauctCzcucVpg91yp1Db
	8UyDgoaITxdsUUX4gALN7bhpRIdX3fHHQr55GaXZDEaDrXlIcy1zfortVwrgJRmQuWP90bnAaCU
	1EW+Iph0PmtRWQys1MLh3PmLmCexaHME/oS0j7jWmBfD5s0i2Sim3K/bO2tSkWQae+lblrzlkic
	a4bgioJiIRWy5q5YkyuWbdZ6lc2J8W+0SqsznKU/fE0LMYML+Vcm9/lRYPYgV57wsXCJBbpX8av
	gaLWzmB
X-Google-Smtp-Source: AGHT+IFrl7GvASaCXPeEF/Bz7u5HyCncPixtKgI1OSsTM6i3nwJfB1/d9QLc4rH6Y+Pb82nfD8qYZg==
X-Received: by 2002:a05:622a:252:b0:4ed:20bc:dc0b with SMTP id d75a77b69052e-4eddbd6ce7cmr91437691cf.35.1763045445025;
        Thu, 13 Nov 2025 06:50:45 -0800 (PST)
Received: from rowland.harvard.edu (nat-65-112-8-29.harvard-secure.wrls.harvard.edu. [65.112.8.29])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ede86b3820sm13156341cf.4.2025.11.13.06.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 06:50:44 -0800 (PST)
Date: Thu, 13 Nov 2025 09:50:42 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Jie Deng <dengjie03@kylinos.cn>
Cc: gregkh@linuxfoundation.org, mathias.nyman@linux.intel.com,
	sakari.ailus@linux.intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: core: fix NULL dereference in usb_ifnum_to_if()
 during device removal
Message-ID: <0bec2aa5-cb3e-49c2-ab40-39a9ebceb2ad@rowland.harvard.edu>
References: <20251113114411.1410343-1-dengjie03@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113114411.1410343-1-dengjie03@kylinos.cn>

On Thu, Nov 13, 2025 at 07:44:11PM +0800, Jie Deng wrote:
> During USB device hot-unplug, in the time window between when
> usb_disconnect() calls usb_disable_device() to set
> dev->actconfig->interface[i] to NULL but before dev->actconfig
> is set to NULL.At this point, outside the kernel, usb_ifnum_to_if()
> is called through usb_set_interface(), and usb_ifnum_to_if() continues
> to access interface[i]->altsetting[i], triggering a null pointer.

> [ 9518.891254][ 1] [ T4650] Call trace:
> [ 9518.894817][ 1] [ T4650]  usb_ifnum_to_if+0x34/0x50
> [ 9518.899681][ 1] [ T4650]  usb_set_interface+0x108/0x3c8
> [ 9518.904898][ 1] [ T4650]  uvc_video_stop_streaming+0x3c/0x90 [uvcvideo]
> [ 9518.911500][ 1] [ T4650]  uvc_stop_streaming+0x24/0x90 [uvcvideo]
> [ 9518.917583][ 1] [ T4650]  __vb2_queue_cancel+0x44/0x458 [videobuf2_common]
> [ 9518.924444][ 1] [ T4650]  vb2_core_streamoff+0x20/0xb8 [videobuf2_common]
> [ 9518.931221][ 1] [ T4650]  vb2_streamoff+0x18/0x60 [videobuf2_v4l2]
> [ 9518.937390][ 1] [ T4650]  uvc_queue_streamoff+0x30/0x50 [uvcvideo]
> [ 9518.943557][ 1] [ T4650]  uvc_ioctl_streamoff+0x40/0x68 [uvcvideo]
> [ 9518.949724][ 1] [ T4650]  v4l_streamoff+0x20/0x28
> [ 9518.954415][ 1] [ T4650]  __video_do_ioctl+0x17c/0x3e0
> [ 9518.959540][ 1] [ T4650]  video_usercopy+0x1d8/0x558
> [ 9518.964490][ 1] [ T4650]  video_ioctl2+0x14/0x1c
> [ 9518.969094][ 1] [ T4650]  v4l2_ioctl+0x3c/0x58
> [ 9518.973526][ 1] [ T4650]  do_vfs_ioctl+0x374/0x7b0
> [ 9518.978304][ 1] [ T4650]  ksys_ioctl+0x78/0xa8
> [ 9518.982734][ 1] [ T4650]  sys_ioctl+0xc/0x18
> [ 9518.986991][ 1] [ T4650]  __sys_trace_return+0x0/0x4
> [ 9518.991943][ 1] [ T4650] Code: eb04005f 54000100 f9400040 91002042 (f9400003)
> [ 9518.999153][ 1] [ T4650] ---[ end trace f7c7d3236806d9a4 ]---

This looks like a bug in the uvc driver.  usb_disable_device() unbinds 
ther interface's driver before it sets dev->actconfig->interface[i] to 
NULL, and the uvc driver shouldn't call usb_set_interface() after it has 
been unbound.

> To resolve this issue, a null pointer check for config->interface[i]
> can be added in the usb_ifnum_to_if() function.

That won't fix the real bug.  You need to change the uvc driver.

Alan Stern

