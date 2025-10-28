Return-Path: <linux-kernel+bounces-873813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D638C14CB9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DC844E809F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618D61E3DF2;
	Tue, 28 Oct 2025 13:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMObxLmu"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96C51534EC
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761657502; cv=none; b=ZouKWd/I8pXyaRamRBSsXptMS713ofnRb0epZwE0EsyaWu3sS5ALuW+VGAqBhkf6YVYu2JXivCtzEl0Jvwocb68ccZc29le0gCX02DF47HRzs5UmVg/gH04TjIJ7pTszkzQmOuiUkCfqbsuHDl+zGbWeHXgmS+DMKZHESHEl8PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761657502; c=relaxed/simple;
	bh=fiLWZK6ImQVCW9629k9PoFbTy4/Jk9SIirXQPkk2UZQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thI9ih10Q7rgIuoaAy7pkCfvii5WZ3QSnnciqouFewTiwWYVQ8bDj9Syme599HMvzNWWUmv5Ob3ztyGzsg+ek/fBETteGs7+Df+UKmKw8Dwc8jwT7AueYe3boM14GAIawEPWE8Y9JJ1WRbDa99VkG4IlVCxeiJat8rO2M/Rl2NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMObxLmu; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-592fdbeb7b2so5995743e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761657499; x=1762262299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TqhalhS8wH7ktHtboyTNLZoKooOIXtABZeKACOZEvrg=;
        b=KMObxLmuHCAoskojdE3pq0YS5LVn7dOFJxPVuVKQKX9HnmaN5wVrU0Icb+EDa/wvPB
         blypoeYlGTEuXMdrCAFDko+yje12V3IC+CAKpJ3xXCN2jh/PntaBA7bwJps3rGBYhpg6
         6aZAsZrnPvRCfNWNszPAq4ry+CznuH/waQNeAhMjvJPNJOvijsxH06NwFDMqy+PN1oM8
         8f2UnbE1SOtOIy3oKQ/Sin8uLDKfQiLC1O6g1oKDEmU7RNTwD7t7APG20TuPScj5Lr24
         glTwRDlTbcUZ0FX24Tg1CFtWN0q93jj1mXeaE641XjJPrIYVLf3II3PMqPndRkiu8ovt
         iuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761657499; x=1762262299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqhalhS8wH7ktHtboyTNLZoKooOIXtABZeKACOZEvrg=;
        b=rP14/OMQv5t1jgqTv770H0pnKIKiNSECFyr2jf9tn+HCimdG0fnvhwMH3mHKNdig9x
         GXGUazHUKVqErPQDISqhBQMM9w80Iw5T6D9l0haXjizblSM3UBi83etUzHY0+6HqeGNS
         W8x8Hp17dPbHGFWBd901kbf0KGkZ8fqdXUsrRwc/MRNdTJA88DVXFGaEHAHpFwDQXTqr
         dBhOXqG3n2y+/YSBmMORtVsNBI4p230yPKp4LYGBdxepdJV7jykA7SgLgyHIA8UNapYf
         O5wT4MTSQZK+nMzOn1MqP3ZFfnbi/D1FdSmnGAg0A2YuDsoVr+7pVIOUlhi0ilpZPZws
         vezw==
X-Forwarded-Encrypted: i=1; AJvYcCWU1cOlYOIrm1E+Al4YcFcQcHFUA/KlcwW9spqdrtTJNUdZWPuFywTvo204qcie5/2MduH+RdS0LhHno/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOErkYR0cvjL3+FkzlcinjwZblWKbQIvhKqtC6CbKNtKf7gp3S
	yLpQM5cLLfhOpEtE4fYchvOKK5OaSi0xg5zWsiU9Wrq5gOQAc0gmLHKnyNISMqjnkrs=
X-Gm-Gg: ASbGncvff/QKdqrSMRfMklHvZbU1qMUXxsPiDLyv5eMkraL6zZvuB6QXM7WIvdoDAhE
	9CpEILYii6jdvcAK/cxEUZ5s/gO0kLkFe6trQlI3dwPX7a7Vs39GZJLckQM6A3tEo/bC1Y55U7k
	vzCCDh13wnkXRBOL9vT6soivnFEVvRdl15JTc0Qb9FHqEtAqRfgbxXzUVnfAiO6T3kVgahvtNY5
	A1LZ1RyK1fDeuvRUb0rIo/6OGUWyNjVVRpR42NshzeZFM2wojIZSXrOcLngYb/uW1zEL+XJZc6v
	c7UXpVZ3YMQlbhm/OciEkyoF5Zybycl+G7faCfyYUi4Ry7qYYNproFRaenaIopnPa2IUDHVdeJo
	C+e3qWX0P+LDlSRLkpqGriERVaevnUJLGQpXrE+cZgSo=
X-Google-Smtp-Source: AGHT+IFH42jTuKwp0a5o9y/IlF7jThN+9qfutPbd8sJT3wsJFSPYJU9S3gA+Z0OKXiwtbIQO2EAhtw==
X-Received: by 2002:a05:6512:31d0:b0:592:fc21:bbfc with SMTP id 2adb3069b0e04-5930e9dd0a7mr1227732e87.44.1761657498708;
        Tue, 28 Oct 2025 06:18:18 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f55739sm3048909e87.49.2025.10.28.06.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 06:18:18 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Tue, 28 Oct 2025 14:18:16 +0100
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>, Alasdair Kergon <agk@redhat.com>,
	DMML <dm-devel@lists.linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dm-bufio: align write boundary on bdev_logical_block_size
Message-ID: <aQDCmAPfpIGZiceo@milan>
References: <20251020123350.2671495-1-urezki@gmail.com>
 <cdb598ce-88ec-0c3c-8e4b-b557093bea92@redhat.com>
 <aQCDLBie3fGwMDW2@milan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQCDLBie3fGwMDW2@milan>

On Tue, Oct 28, 2025 at 09:47:40AM +0100, Uladzislau Rezki wrote:
> Hello!
> 
> Sorry i have missed you email for unknown reason to me. It is
> probably because you answered to email with different subject
> i sent initially.
> 
> > 
> > On Mon, 20 Oct 2025, Uladzislau Rezki (Sony) wrote:
> > 
> > > When performing a read-modify-write(RMW) operation, any modification
> > > to a buffered block must cause the entire buffer to be marked dirty.
> > > 
> > > Marking only a subrange as dirty is incorrect because the underlying
> > > device block size(ubs) defines the minimum read/write granularity. A
> > > lower device can perform I/O only on regions which are fully aligned
> > > and sized to ubs.
> > 
> > Hi
> > 
> > I think it would be better to fix this in dm-bufio, so that other dm-bufio 
> > users would also benefit from the fix. Please try this patch - does it fix 
> > it?
> > 
> If it solves what i describe i do not mind :)
> 
> > 
> > 
> > From: Mikulas Patocka <mpatocka@redhat.com>
> > 
> > There may be devices with logical block size larger than 4k. Fix
> > dm-bufio, so that it will align I/O on logical block size. This commit
> > fixes I/O errors on the dm-ebs target on the top of emulated nvme device
> > with 8k logical block size created with qemu parameters:
> > 
> > -device nvme,drive=drv0,serial=foo,logical_block_size=8192,physical_block_size=8192
> > 
> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > Cc: stable@vger.kernel.org
> > 
> > ---
> >  drivers/md/dm-bufio.c |    9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > Index: linux-2.6/drivers/md/dm-bufio.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/md/dm-bufio.c	2025-10-13 21:42:47.000000000 +0200
> > +++ linux-2.6/drivers/md/dm-bufio.c	2025-10-20 14:40:32.000000000 +0200
> > @@ -1374,7 +1374,7 @@ static void submit_io(struct dm_buffer *
> >  {
> >  	unsigned int n_sectors;
> >  	sector_t sector;
> > -	unsigned int offset, end;
> > +	unsigned int offset, end, align;
> >  
> >  	b->end_io = end_io;
> >  
> > @@ -1388,9 +1388,10 @@ static void submit_io(struct dm_buffer *
> >  			b->c->write_callback(b);
> >  		offset = b->write_start;
> >  		end = b->write_end;
> > -		offset &= -DM_BUFIO_WRITE_ALIGN;
> > -		end += DM_BUFIO_WRITE_ALIGN - 1;
> > -		end &= -DM_BUFIO_WRITE_ALIGN;
> > +		align = max(DM_BUFIO_WRITE_ALIGN, bdev_logical_block_size(b->c->bdev));
>
Should it be physical_block_size of device? It is a min_io the device
can perform. The point is, a user sets "ubs" size which should correspond
to the smallest I/O the device can write, i.e. physically.

--
Uladzislau Rezki

