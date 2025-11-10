Return-Path: <linux-kernel+bounces-892843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EDEC45EED
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1698B3B7D39
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBF0309EE2;
	Mon, 10 Nov 2025 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhN5L9t/"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F179D30216D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762770375; cv=none; b=FGYIcMzABg9Oo42Fe18tJfyFSe6qlzmRSPq21b//xnQAjOi25hz4PA4gftONTY8GLYtWQiGWzhd+CedLkyIKHG1y3YPFFVuqt9y1wI2Zx6EaL0GJJ9zXGsOv9oKteepFHoMNbkpTSK1aduDekg0jKHwmNYzY60ilzZ5+g1/x9DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762770375; c=relaxed/simple;
	bh=NVfWpvkVvTAgCSIX0tKarfXupAWex1W6dIbaCGoKFlY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aq8yKt2LNurbBkJ5FRfSZi2vmTD/Ml9wlv680bbl996NZuqXz/ya3ddTjOwq8KWK6qZvqrGonNiREyw8R6/a5J3PxGvoBKlTFz0EYMU/lqTZAacszQhpZS9LUaI4rZtygcrvDBgeAWQDJ1fKBXP5n8g7v9HLLW/nvM+Ql+Up4eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhN5L9t/; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-58b025fce96so2359420e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762770372; x=1763375172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ewdf73ORA74EmIwjByKtBRnel8D4jCLt63rwPXIKWQg=;
        b=AhN5L9t/9bcNP7VHOJCVkA2xZ2iWkE3Qio7U+ZoSWtlB9WGeiOC2fkyZtb+o/tfYwu
         jimiZrnvK+qIy4Oa4Dk96ErFx0wyfwGSqDnlWXN+9LXEgZhODPW00KOOR8lyJYxV88cA
         wfrYx0asL0+dfps4zBxgjEIj1dbWV96Ng7w6lUuGsz/dYktGTtyW4FtkWNttbZvoadEB
         C/Dnw0WZ2PA19q7MSTik0axgrkod4Gop4C12F8lZPItaNT9dnf+JPD5MR9kTMRW+FiNf
         XpeQw2iRqGXaa1AZpSkBk6trETh/YlXvdaNTj7rmTTJXRRJ2gZVrclDD0fhw+2C+vcfW
         j0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762770372; x=1763375172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ewdf73ORA74EmIwjByKtBRnel8D4jCLt63rwPXIKWQg=;
        b=E1qhjnHykdFkS0V5mfABJR++iZeH9apTWgA8FRABD/PPuXwyyI0NEHhPMeY1PeYJmZ
         zbOfXmaoi3adgp5lbicmCo88uH3jMw4BT7hIVePRSwFk3djWZccYd8KPLEgvHVx2vZhq
         Vdsxkqjf+Bfs5iAIxy9tY9GG6QuTOO4xI3UYhbakjmUrEIP6If0rT2oYeis8GMmhl+82
         5Wff1VRABJlbVHflQtk7VEMuhPzS53Ly34tdrCVf9DoJJKlDiZxPLAWwXgrTcPJ8SscP
         L/U+bTLyXCAYsLQh03mNLiRZO7jGc1piv12EudeLgErAuW7KFMqgPQ4me8szXkHsfiY6
         yCsg==
X-Forwarded-Encrypted: i=1; AJvYcCV6KGo0jpgjJF8LbaP94suxFsNNSop+llyZ2MvwMv0RJEqAM/42Rw8wGtFU1ntRW948K/Ei6nYx2/ueGtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YykewedVfWIy7gO1hcMUYS5gJVcLvWu/I3nhKLBBzRgVzMvvKO+
	vvANY75OXaPnLAbD1zN5tvg0wJ3/fumoBmJ6/7w5GoJDZzh7PyHpWBAT
X-Gm-Gg: ASbGncsyRSCfMKpdcqrSdbxZ1td+XSC4B2/kGwDQFoo+6d6BpcgwvZ6TrzivJRBatFo
	xmuj836k8PQe7uV8f0GqnW3qSclF+xvaEKSqqihq2Rh2T6S6B8v6hTW+vfqN9c2VgJ7vIsl3eWy
	DPBuzqWbeWrdj4yXYsoRYZmMyaLRrNwt9s269HQf+RcPRsoR3acfOug+j6kzQAXHXe0EvlTUZ7j
	8GtBAcLFrA34jLDFvI+eR8PXlUgMWnlx1vcyDaR+r2kmTSoT7BzxuUKNDIMIN/nF+KC6pJbVLVs
	lkqzToJPExx+8r77HIG74gx1ThGxAgrwiukiYPcjqDtFvyR74/9JTLvawSvcNjQBSOdTzd/z674
	h3cLbRRzxasu+JeudIqg2JPaO90GIXo45az3NftkJardrMHVWB+/QDqLBZgroA0UjswvDENKKsJ
	VZ5TL7+to0Xdo2TQRvl5qwGxqpIDR6Bzh4TJ/DEZC6
X-Google-Smtp-Source: AGHT+IHudJKoKPiG0LQ9lbIoxNO8k1GkVn+qEN63QzX3e9UkArrSvU30UPfUxCkx6meUV76CCDyq/A==
X-Received: by 2002:a05:6512:10c2:b0:594:25a6:99c1 with SMTP id 2adb3069b0e04-5945f15bffcmr2259502e87.14.1762770371806;
        Mon, 10 Nov 2025 02:26:11 -0800 (PST)
Received: from pc636 (host-90-233-197-228.mobileonline.telia.com. [90.233.197.228])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a58ed40sm3936997e87.88.2025.11.10.02.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:26:11 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 10 Nov 2025 11:26:08 +0100
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>, Alasdair Kergon <agk@redhat.com>,
	DMML <dm-devel@lists.linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dm-bufio: align write boundary on bdev_logical_block_size
Message-ID: <aRG9wBP71wxE2Mtk@pc636>
References: <20251020123350.2671495-1-urezki@gmail.com>
 <cdb598ce-88ec-0c3c-8e4b-b557093bea92@redhat.com>
 <aQCDLBie3fGwMDW2@milan>
 <aQDCmAPfpIGZiceo@milan>
 <b791d8e8-5e30-b50c-04ca-e823c0a06747@redhat.com>
 <aQIRV51yLQzOwJvB@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQIRV51yLQzOwJvB@pc636>

On Wed, Oct 29, 2025 at 02:06:31PM +0100, Uladzislau Rezki wrote:
> On Wed, Oct 29, 2025 at 11:24:25AM +0100, Mikulas Patocka wrote:
> > 
> > 
> > On Tue, 28 Oct 2025, Uladzislau Rezki wrote:
> > 
> > > On Tue, Oct 28, 2025 at 09:47:40AM +0100, Uladzislau Rezki wrote:
> > > > Hello!
> > > > 
> > > > Sorry i have missed you email for unknown reason to me. It is
> > > > probably because you answered to email with different subject
> > > > i sent initially.
> > > > 
> > > > > 
> > > > > On Mon, 20 Oct 2025, Uladzislau Rezki (Sony) wrote:
> > > > > 
> > > > > > When performing a read-modify-write(RMW) operation, any modification
> > > > > > to a buffered block must cause the entire buffer to be marked dirty.
> > > > > > 
> > > > > > Marking only a subrange as dirty is incorrect because the underlying
> > > > > > device block size(ubs) defines the minimum read/write granularity. A
> > > > > > lower device can perform I/O only on regions which are fully aligned
> > > > > > and sized to ubs.
> > > > > 
> > > > > Hi
> > > > > 
> > > > > I think it would be better to fix this in dm-bufio, so that other dm-bufio 
> > > > > users would also benefit from the fix. Please try this patch - does it fix 
> > > > > it?
> > > > > 
> > > > If it solves what i describe i do not mind :)
> > > > 
> > > > > 
> > > > > 
> > > > > From: Mikulas Patocka <mpatocka@redhat.com>
> > > > > 
> > > > > There may be devices with logical block size larger than 4k. Fix
> > > > > dm-bufio, so that it will align I/O on logical block size. This commit
> > > > > fixes I/O errors on the dm-ebs target on the top of emulated nvme device
> > > > > with 8k logical block size created with qemu parameters:
> > > > > 
> > > > > -device nvme,drive=drv0,serial=foo,logical_block_size=8192,physical_block_size=8192
> > > > > 
> > > > > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > > > > Cc: stable@vger.kernel.org
> > > > > 
> > > > > ---
> > > > >  drivers/md/dm-bufio.c |    9 +++++----
> > > > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > > > 
> > > > > Index: linux-2.6/drivers/md/dm-bufio.c
> > > > > ===================================================================
> > > > > --- linux-2.6.orig/drivers/md/dm-bufio.c	2025-10-13 21:42:47.000000000 +0200
> > > > > +++ linux-2.6/drivers/md/dm-bufio.c	2025-10-20 14:40:32.000000000 +0200
> > > > > @@ -1374,7 +1374,7 @@ static void submit_io(struct dm_buffer *
> > > > >  {
> > > > >  	unsigned int n_sectors;
> > > > >  	sector_t sector;
> > > > > -	unsigned int offset, end;
> > > > > +	unsigned int offset, end, align;
> > > > >  
> > > > >  	b->end_io = end_io;
> > > > >  
> > > > > @@ -1388,9 +1388,10 @@ static void submit_io(struct dm_buffer *
> > > > >  			b->c->write_callback(b);
> > > > >  		offset = b->write_start;
> > > > >  		end = b->write_end;
> > > > > -		offset &= -DM_BUFIO_WRITE_ALIGN;
> > > > > -		end += DM_BUFIO_WRITE_ALIGN - 1;
> > > > > -		end &= -DM_BUFIO_WRITE_ALIGN;
> > > > > +		align = max(DM_BUFIO_WRITE_ALIGN, bdev_logical_block_size(b->c->bdev));
> > > >
> > > Should it be physical_block_size of device? It is a min_io the device
> > > can perform. The point is, a user sets "ubs" size which should correspond
> > > to the smallest I/O the device can write, i.e. physically.
> > 
> > physical_block_size is unreliable - some SSDs report physical block size 
> > 512 bytes, some 4k. Regardless of what they report, all current SSDs have 
> > 4k sector size internally and they do slow read-modify-write cycle on 
> > requests that are not aligned on 4k boundary.
> > 
> I see. Some NVMEs have buggy firmwares therefore we have a lot of quicks
> flags. I agree there is mess there.
>  
> The change does not help my project and case. I posted the patch to fix
> the dm-ebs as the code offloads partial size instead of ubs size, what
> actually a user asking for. When a target is created, the physical_block_size
> corresponds to ubs.
>  
> I really appreciate if you take the fix i posted. Your patch can be
> sent out separately.
>  
> Does it work for you?
>  
Any feedback or comments on it?

--
Uladzislau Rezki

