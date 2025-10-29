Return-Path: <linux-kernel+bounces-876096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C7EC1ADAC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A5C9627B5E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032C5306B2E;
	Wed, 29 Oct 2025 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1coBC40"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3BF2EBBA4
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743198; cv=none; b=h/r4Dn6uxe90tAUWLQ7lRNpfzKVKUQ8ltdQYN5NhAQMznprrF7qffFaI4FU5h2EOdFP3aJzs18MKNY3aUGAig4JRn4sinPu9pRfqev0YyL+rVE80+n5hgSWtdI/EavnEzL62ZuHNbcgInBGejkBQ2k7CVsbv4HxgwGSBth6Kaok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743198; c=relaxed/simple;
	bh=RsaO7VAXwouvy9HZ/OEuTxB0IDJRQxCRWcTIffwfEE4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYUZzSgb1zy7C62YcERBBiTxtYIGJPlVECbtZ/8TlE2HUTrPuoHL08RuBq3dTEpUxxPc7hGddaiNJLfj9OsoKKV82b/UQbzPIm0zN1X0QEZmcagGNcNCBECi8Pu34elrQnhAfzC/5U/fZyQcTVIpbIlRBKikxOaQqkT8ZE9hpiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1coBC40; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-378ddb31efaso86602581fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761743194; x=1762347994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b7OF/YjgS2U029gez5iQZAa3hsUdBSYG5emzqmsuSEY=;
        b=i1coBC40DRmF9Q84rGEdMde0/fzBuK5zjMGLMyDDOwL2AJ2h9HH40eFgA9JP4bFqJC
         m4rQbslxA/m3Y4q9DA9p9D6aNatYKRflN6wWBY25SUrDH5vc/liUlYhlsKc/OerphZyT
         D1E+ZteBmvEZ/mvDJc+ADUL7n0kyXbVGC42jMjLpKGyRluMARd19dpKltx1whLZxt4lZ
         iPKXdebBB39nbIRaO2szLUXs9zDIUXMwEhP54GhojsM0ERjGiBprCXg1TgoHvyL86stj
         qgNEjXEGRpbbDFkuFm2xNfN826ZPN9gCzpLDX4xw4bSZ3ZBi/dw1Vs0NhXHXh3X8yF1i
         WEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761743194; x=1762347994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7OF/YjgS2U029gez5iQZAa3hsUdBSYG5emzqmsuSEY=;
        b=BhNcg3Bl7r1fw1cZ+DEulPnKz/+3X+83efiqvrCEE+tI4uj2Dzn2Qz4IbNHqxsBvWA
         v0I9N3Yf5AvkwPtEEZCYX2BGWXXuUHAxeXAKeyjCA108yd61TGM8K5xDk5/v2q7kv011
         S48T/cSMcwWYKQ0xrOoR8Q5GJW7m3rCPmpp93rOnus+Ja2mlDmm3U+DZYNYdMzYlh4ve
         oEYi1qwY4xsNMhYYZDNRi8ZvD+95CaZSy2tWOfpd42+hw64i0AwlU69H4f4fNLQXH7pQ
         OgE05WHqoV2T6FZje2/E1Zx9K2C2bPsi4vMtUeUupIsLQkx4aVTdM3O6M4aQ16+Lhr/M
         skEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZEbAg7UrEL/agvBUkLVoYvlMpoENigLFO5CegjgzExIWxRwDO0/r2FQoIMkRnNxnhX3aoL73evPUdFCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIEUJzWP+y/K1VZF0wp3xRaRQklWof5wJofMiw1FXltMaVUnic
	ntS5LFJ1UgiOauX0XxFXd0c9MyonI9aY479gKVq34TInNxUAGICltm8B
X-Gm-Gg: ASbGnctlk+ww4mq/tyb3h1vs8LA2x0Sfttad4M+5a+wSVLRoltl+HDm6+Hfmh1k+Vm7
	xAk8qrGSWzvFv9uAz4pPcEtblr1co9V4sQK5xLvKeObbxxygDvaZKtoLP0YxF1OyY9M0O//XEDQ
	d3bb/dVQrnBgoeHxG0+9AG+Zb8ssqX82eBOnZbeUInHMcKGN0ftX0r1rCnXWhyoNt/5zx/oRWRY
	asQhH3U6vSR6SeSow9CJ/xQBCrHTykKqXCtDseMgfYEbxujH96Y+72POo9/q23PWWAaKju5gXEl
	VJPVNJl/ihev7+6wHFA/MX3oudzNvQLUrFTzfcLBIGZ68eCzbtn2zbeTZSyUlATZGBaK6JWI6t5
	Du5CzA15aKylzqOxSIuBn++lFT7QYEiu6mXt2M07c2J3OY/yp4M+vrBSp4TOaSqjeJ2H9A/BEBm
	07OBXyxd29Qyz28iAnve7QbvUdyAa98g==
X-Google-Smtp-Source: AGHT+IHn+iYM86fiNMcTAPtAf73qE9hUkHMk/9Lv5hKb1jLvbDo9mpK9c5Zeb2tsc98bHx7EZd3nVg==
X-Received: by 2002:a05:6512:baa:b0:592:f359:ff2b with SMTP id 2adb3069b0e04-594128c0913mr894714e87.41.1761743193988;
        Wed, 29 Oct 2025 06:06:33 -0700 (PDT)
Received: from pc636 (host-90-233-197-228.mobileonline.telia.com. [90.233.197.228])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59306b2de0fsm3024869e87.7.2025.10.29.06.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 06:06:33 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 29 Oct 2025 14:06:31 +0100
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, Alasdair Kergon <agk@redhat.com>,
	DMML <dm-devel@lists.linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dm-bufio: align write boundary on bdev_logical_block_size
Message-ID: <aQIRV51yLQzOwJvB@pc636>
References: <20251020123350.2671495-1-urezki@gmail.com>
 <cdb598ce-88ec-0c3c-8e4b-b557093bea92@redhat.com>
 <aQCDLBie3fGwMDW2@milan>
 <aQDCmAPfpIGZiceo@milan>
 <b791d8e8-5e30-b50c-04ca-e823c0a06747@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b791d8e8-5e30-b50c-04ca-e823c0a06747@redhat.com>

On Wed, Oct 29, 2025 at 11:24:25AM +0100, Mikulas Patocka wrote:
> 
> 
> On Tue, 28 Oct 2025, Uladzislau Rezki wrote:
> 
> > On Tue, Oct 28, 2025 at 09:47:40AM +0100, Uladzislau Rezki wrote:
> > > Hello!
> > > 
> > > Sorry i have missed you email for unknown reason to me. It is
> > > probably because you answered to email with different subject
> > > i sent initially.
> > > 
> > > > 
> > > > On Mon, 20 Oct 2025, Uladzislau Rezki (Sony) wrote:
> > > > 
> > > > > When performing a read-modify-write(RMW) operation, any modification
> > > > > to a buffered block must cause the entire buffer to be marked dirty.
> > > > > 
> > > > > Marking only a subrange as dirty is incorrect because the underlying
> > > > > device block size(ubs) defines the minimum read/write granularity. A
> > > > > lower device can perform I/O only on regions which are fully aligned
> > > > > and sized to ubs.
> > > > 
> > > > Hi
> > > > 
> > > > I think it would be better to fix this in dm-bufio, so that other dm-bufio 
> > > > users would also benefit from the fix. Please try this patch - does it fix 
> > > > it?
> > > > 
> > > If it solves what i describe i do not mind :)
> > > 
> > > > 
> > > > 
> > > > From: Mikulas Patocka <mpatocka@redhat.com>
> > > > 
> > > > There may be devices with logical block size larger than 4k. Fix
> > > > dm-bufio, so that it will align I/O on logical block size. This commit
> > > > fixes I/O errors on the dm-ebs target on the top of emulated nvme device
> > > > with 8k logical block size created with qemu parameters:
> > > > 
> > > > -device nvme,drive=drv0,serial=foo,logical_block_size=8192,physical_block_size=8192
> > > > 
> > > > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > > > Cc: stable@vger.kernel.org
> > > > 
> > > > ---
> > > >  drivers/md/dm-bufio.c |    9 +++++----
> > > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > > 
> > > > Index: linux-2.6/drivers/md/dm-bufio.c
> > > > ===================================================================
> > > > --- linux-2.6.orig/drivers/md/dm-bufio.c	2025-10-13 21:42:47.000000000 +0200
> > > > +++ linux-2.6/drivers/md/dm-bufio.c	2025-10-20 14:40:32.000000000 +0200
> > > > @@ -1374,7 +1374,7 @@ static void submit_io(struct dm_buffer *
> > > >  {
> > > >  	unsigned int n_sectors;
> > > >  	sector_t sector;
> > > > -	unsigned int offset, end;
> > > > +	unsigned int offset, end, align;
> > > >  
> > > >  	b->end_io = end_io;
> > > >  
> > > > @@ -1388,9 +1388,10 @@ static void submit_io(struct dm_buffer *
> > > >  			b->c->write_callback(b);
> > > >  		offset = b->write_start;
> > > >  		end = b->write_end;
> > > > -		offset &= -DM_BUFIO_WRITE_ALIGN;
> > > > -		end += DM_BUFIO_WRITE_ALIGN - 1;
> > > > -		end &= -DM_BUFIO_WRITE_ALIGN;
> > > > +		align = max(DM_BUFIO_WRITE_ALIGN, bdev_logical_block_size(b->c->bdev));
> > >
> > Should it be physical_block_size of device? It is a min_io the device
> > can perform. The point is, a user sets "ubs" size which should correspond
> > to the smallest I/O the device can write, i.e. physically.
> 
> physical_block_size is unreliable - some SSDs report physical block size 
> 512 bytes, some 4k. Regardless of what they report, all current SSDs have 
> 4k sector size internally and they do slow read-modify-write cycle on 
> requests that are not aligned on 4k boundary.
> 
I see. Some NVMEs have buggy firmwares therefore we have a lot of quicks
flags. I agree there is mess there.
 
The change does not help my project and case. I posted the patch to fix
the dm-ebs as the code offloads partial size instead of ubs size, what
actually a user asking for. When a target is created, the physical_block_size
corresponds to ubs.
 
I really appreciate if you take the fix i posted. Your patch can be
sent out separately.
 
Does it work for you?
 
Thank you!
 
--
Uladzislau Rezki


