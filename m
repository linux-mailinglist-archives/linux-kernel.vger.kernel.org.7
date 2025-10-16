Return-Path: <linux-kernel+bounces-856378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12959BE4017
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8BD7A358E04
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8C734DCFF;
	Thu, 16 Oct 2025 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GibI3dyY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C369D34AAF2
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626119; cv=none; b=mGNfePJsQvINo/FVo4mwAqSqUDLNAHTxOWlEE5ZxGDItyMyPxDyssy4MUS/6nIeUVxD48F+ZWvhWWrLiq6J9bmBSugtLOmTs10cUADrJrrYC6ueN1fuRUMmp8j4WDclAcDmzrWZesmbkThShUru1ayULc6x3UpCIM86GAPT2e7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626119; c=relaxed/simple;
	bh=rCHePoYx8vH9EdNoImNI/2s0auUBEN1avC23MrK3ySE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tB3X+kBBX/CZCA2mmEoS8Wcfd9IJL11uj4HMxKUtZBHjpr8JZJ+fYzikk8jI7FY7yYJWVGbCVlMuO2eie3q6WY5zR4FZo0yiVQHc/WegAgyIYr++S9CWImONdetusxnImd7JJy/j4yc3Glui4QSXuw7MGi+zea9jt1m6o1hmp0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GibI3dyY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760626108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U03eGbs4wjj3PFtRG+pRSc+mdF22jPXyW9jnySqsUVw=;
	b=GibI3dyYFu1LMcoRFCk97vhuTB8D2JXWGa0HFO7rpim3MRAgF5DP8XePQjZuFwqBH4CxBX
	Bdhx66DO1yHo56M6Yp3iQ+MR6OSY0eMi1/oHrOvviYWSihyD1eWSLL3cqmwDM/Uz1Rs6AC
	v1FYz7IMuu6mcr0H5yuRaYccgAXYfMQ=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-0_zUbnKpOuKnQt9-2GqBiQ-1; Thu, 16 Oct 2025 10:48:25 -0400
X-MC-Unique: 0_zUbnKpOuKnQt9-2GqBiQ-1
X-Mimecast-MFC-AGG-ID: 0_zUbnKpOuKnQt9-2GqBiQ_1760626104
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7810289cd5eso1780857b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:48:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760626104; x=1761230904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U03eGbs4wjj3PFtRG+pRSc+mdF22jPXyW9jnySqsUVw=;
        b=FWDdf/vAr12n2KN5r+JUZehmvE06KuK5Rr8+1y/uvIcFWBMtAFCeuzu/m3J25f2x5t
         N4tXa2RSuTxcBOq9+apzKZse9HrFbaQ6nM3QZILH1K+IiecYTotnh+VPKueQRXQkAlr+
         AWrqh9g/fw/0cHxE6LBVPDuO84CbLqaoI4jeBLPZhzzv4k0r3gN+RIx389H4FzT+UFGD
         Ja4yHzVvEKR/iZMfw0QRVKtHelxvqzTXTv63aZx6nLBjuIa8YYSHjmacgj1iyK3fBt5M
         I6F/0tcpJczkl4APUPuimct1KiF66otfuO7vcUVtkYtLWMZB+MRs104BqlyMHdEzjtFn
         4Nww==
X-Forwarded-Encrypted: i=1; AJvYcCWHfAuEJOnlbzibNYlkIXil+/2rHTQ3SSgSP7jlgdJXJsC3XEE6ME9bhXeC6hzjCKbDFNYxj6iyLxnl6zQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+wJb+QyPiYE/uAEgdjHmMAuOo17w6dqk/AZGFALquIo8KC+JI
	Z7Lz2yxQwYVYB/Xemi9mK8TKatYGZ7hIixSHFoWyB6kBCNMkKOkRtuNQW0T32Ym/Pf9EOL1hoWq
	PZvQwu3a7z0/UizWeNNsN+ODrHTi2C4Gvvz0bfDFvJ09nLL7eE/VPODzRpazCKurlkg==
X-Gm-Gg: ASbGncvOQU2JnjT1mm5JS9bQJqkJAtuO0QHj2++LC33wx3+Yr3eothUcNf/YMWKegjF
	/J0y7uUNXTpiSM13VHHtVbVh7Vr+iaZreg1IEWDCnFNttmwmLIGZf8s8qIB6pRGhWaFCkVXKM7G
	vPs74NUkZDsO1S0NzIXPtkBd3IEegx8v5zSBEfpkBh0PC0kzMfBQl0zFr+I8+4zn3iSwq/EWrgB
	trR0NN/LNQgbOjzodhXjTrfjpGu57WqFGQ5PxiJYPwJDM5aya9IXfza4QUvmvdBWPwKhtNW1Bm7
	gsBi4rGERBl3acFK0aRq96DCbxKoRQDDnBrmLme+VlYNyJpJF1w7Zi8dIK7iVws2ehLIHg==
X-Received: by 2002:a05:6a00:1a94:b0:781:18b2:36aa with SMTP id d2e1a72fcca58-7a220a5700fmr415380b3a.4.1760626104084;
        Thu, 16 Oct 2025 07:48:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGQ44ZW5qtLmpXABJdEGtyVfV9M7TtOdFyJpQ/vxnPLRjHGV4Uly8iyTm+ovbwyTlxsS9SKw==
X-Received: by 2002:a05:6a00:1a94:b0:781:18b2:36aa with SMTP id d2e1a72fcca58-7a220a5700fmr415341b3a.4.1760626103649;
        Thu, 16 Oct 2025 07:48:23 -0700 (PDT)
Received: from zeus ([2405:6580:83a0:7600:6e93:a15a:9134:ae1f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d09671asm22675521b3a.47.2025.10.16.07.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 07:48:23 -0700 (PDT)
Date: Thu, 16 Oct 2025 23:48:19 +0900
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: zack.rusin@broadcom.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, jfalempe@redhat.com, ian.forbes@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH drm-misc-next v3 0/1] add drm_panic_support for
 vmwgfx-stdu
Message-ID: <aPEFs0kYfXGZUHCA@zeus>
References: <20250919032936.2267240-1-ryasuoka@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919032936.2267240-1-ryasuoka@redhat.com>

On Fri, Sep 19, 2025 at 12:29:29PM +0900, Ryosuke Yasuoka wrote:
> Add drm_panic support for stdu in vmwgfx. This patch was tested in a VM
> with VMSVGA on Virtual Box.
> 
> Based on the feedback for v2 patch, I've made the following updates in
> my v3 patch.
> - Use MEMREMAP_WB | MEMREMAP_DEC flags for memremap
> - Use vmw_priv->initial_height and initial_width for sb and VRAM
> - Move all panic related functions to the vmwgfx_kms.c file
> - Ensure if the current display unit is 0 in get_scanout_buffer()
> 
> I did not apply all of Ian's feedback in this v3 patch for the reasons
> outlined below.
> 
> > 1. You can call `vmw_kms_write_svga` directly in `panic_flush`. There
> > is no need to mark the buffer as dirty or send any commands.
> 
> In my test environment (VirtualBox), the panic screen appears unstably 
> without dirty command's submission. Without it, the screen sometimes
> appears immediately as expected, and at other times, there's a delay
> of 15 to 20 seconds. I've also observed that it sometimes only appears
> after switching between the VirtualBox console window and other windows.
> 
> With command submission, we can stably get a panic screen. Even if it
> fails, we may get the panic screen ultimately. Therefore, I think we
> should retain vmw_kms_panic_do_bo_dirty() to submit commands.
> 
> > 2. The format should be hardcoded to RGB565 to minimize the risk of
> > overrunning VRAM. Adjust the pitch accordingly to 2x width.
> 
> While it's possible to output the panic screen with RGB565 by adjusting
> pitch and width, and BPP on the (virtual) hardware side, this approach
> causes debugfs to fail. It appears that the BPP must be reset after the
> panic screen is displayed, and there is no way to wait for the screen
> to be fully displayed within the drm_panic handler code.
> 
> In my test environment, as VRAM has enough space even when using
> XRGB8888 (32 bits), I think the risk of overruning VRAM is low. So I've
> kept the default format and CPP size.
> 
> v1:
> https://lore.kernel.org/all/20250901083701.32365-1-ryasuoka@redhat.com/
> 
> v2:
> https://lore.kernel.org/all/20250908141152.221291-2-ryasuoka@redhat.com/
> - Map a scanout_buffer to VRAM in .get_scanout_buffer
> - And then write to VRAM directly using fifo in legacy mode to avoid
> allocations or command submissions.
> 
> 
> Ryosuke Yasuoka (1):
>   drm/vmwgfx: add drm_panic support for stdu mode
> 
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.h  |   4 +
>  drivers/gpu/drm/vmwgfx/vmwgfx_kms.c  | 165 +++++++++++++++++++++++++++
>  drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c |   2 +
>  3 files changed, 171 insertions(+)
> 
> 
> base-commit: d41c79838c47bc822534cd53628fe5e0f8ad2424
> -- 
> 2.51.0

Hi all,

This is a gentle reminder for this v3 patch.
I would appreciate any feedback when you have a chance.

Ian, your feedback on v1 and v2 were very helpful. I would appreciate it
if you could take another look when you have a moment.

Any comments are welcome.

Thank you
Ryosuke


