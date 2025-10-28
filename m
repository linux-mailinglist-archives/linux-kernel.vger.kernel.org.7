Return-Path: <linux-kernel+bounces-873308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCC6C13A19
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42FDD508785
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE012F39A6;
	Tue, 28 Oct 2025 08:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNWxWL8B"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A09D2DF149
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641267; cv=none; b=BbyLPA4jzUklALZnl0+5GNg9s4n2hXz6zaOPvDGR3DkQx43ukhMOxwlbYNM4vLlN4LKt4tXe3ox9FIGdlWKVziVgVGoqGZjg7iNrLrcYizaIdet4fz4lbCWeoZO1aD/N2Uu222RPWAaAQF9atlk/5RdS7NHpX9fxn/f2dBM34TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641267; c=relaxed/simple;
	bh=r9yRyupvds6l2O39gsnYYAgVBhowuzrjd1estJhrb0U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kh4sYS5UkDe9Cupbiwm4gQUyHv6rxa5YRHhoNJzPiXk/nNWqCzNgJYFWwbX65ji/6yUkjHpxLezL04iJwb5xLR5jo2EHYq66MALLr7j284xx+QUBAZLz0chwNwXkZoaGhCgcWLKtoTnOTjtH9x6RYuVtcDNMXDMPLAiRcYId/DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNWxWL8B; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-36d77de259bso37650171fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 01:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761641263; x=1762246063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vRLc0auh5JUbiEVtJ5AkHNMy18AHU8gRSkIPhMjaAHY=;
        b=XNWxWL8BieEMtl2dJSnHfFnomBr+y0dFhz8PqQ+d6tgS+flLNM+CZ5HDu32n/u8/Sm
         nIUquQJdWQWK4BTgOu5ftwqEuh8KDE18u8IKUhSpRLSZ1McOekeBphVrxyccEiWiM/nH
         53perlSUO32N/S5yElYe6J3uiZjzE4hNA6aSvj7q8guZUeXle9+JXObDi8bOtoZxjmQc
         TUI/7ByIrWUwL+bOXQQgLQ6m2/+jguYVG8qatH1mh7roC+2Y5dH+ryEnOQGb9fyx1m7d
         VAcYdOGn5GoP8ECagk8qqPeRsfX996TdBX9VC/OeAhFwy0d/W5qsW3mBgXfT7sotgruq
         WvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761641263; x=1762246063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRLc0auh5JUbiEVtJ5AkHNMy18AHU8gRSkIPhMjaAHY=;
        b=itpcM2icxpnVXNDTxqvIeIZoSVTCRPQkG+lrD54PN6N4qKytyVniefcb9qahxdqOt2
         QlJSrUjZPSuluJDdDJ7C7smAoILfFE1wYHDZB82wLxJiNUEqO2Ov/tFg4d41QDgu93p6
         I9y0Y+PJrbwzjXYSYO5dabQJFYbZlEAnkSTI4VAr9DWcXao/B/2BazwXTmUM9uD92exl
         fsg3bHBez79AS3dny8qXILKBm+2qkTdMoYp/noTpyGcYANg3i1Ge8aaM+Np0uBrbmtI/
         6CK83WjgJe9UD5oixuinm/XHZFTbnQ1fuoDzevW7OdbiYMn2O8+zc+5SKf9nRMLvq9Wi
         Nb3g==
X-Forwarded-Encrypted: i=1; AJvYcCWdrqtkrvxts0SgAanVN+2SOdr2ftCASv8YMe6Esm3lDTVm61XMFkQacLbZDYTLN9RMBZMAQ+J5L8+Jytk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBgnLNCX+WbchPvsSJi01QqCoilVSZR/7Y+szLsTB88YSremFB
	cWJh2aqsrzwObVSWq9Eqq6UWtgk8xhdgz6wAJQFjXJbdNe1g3Ihg93zB
X-Gm-Gg: ASbGncv1JMNOxTT3lhr1knxyTkipC/1rtu0hfiotlFX/S0Y1r+MDjvvAsiRXqsrvJdg
	2Uf+Xn1zmmIE+9hzh5INObPG6/vEaY+IbsVGO+rpmXXqNg/h7v3s8lQGNJJDjIqAKxDmxZ2g8Sd
	/2UUqsAbz6ecm8RHoKdkMqtOeZ+zH9ey8+DAlJ8Uin6t/Hsv3YPYoU9eUMKlb5oqgA1iRXK1jBH
	JhTttRIRYAxq4XV6aOa6dwWIGWMeS6Lr9pKTTp39JunwQ4ToDGnAvpS14eDZM5KWCz+P4RXU+PG
	J6P4JwPDTHzjusv0jgS6szJ92cYLV9U7jwBVT+9OHx3/nboFUjFe0aBmBRKhpC6L7B8ScJcHizf
	0e6K/D3Rn08szHiPI2lHKHQ6W6VuSTNvgtaddPjZ+UbE=
X-Google-Smtp-Source: AGHT+IEdfnNRUozr4xhoAo4HjYXDAefDjAlsaDl5RblosO0jl3zzldZ8dEMI2G4Tp89Dq4IeKHLxhw==
X-Received: by 2002:a05:651c:551:b0:378:cff9:93f with SMTP id 38308e7fff4ca-379076d81f5mr8932271fa.12.1761641262989;
        Tue, 28 Oct 2025 01:47:42 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee0da49fsm24829691fa.44.2025.10.28.01.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 01:47:42 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Tue, 28 Oct 2025 09:47:40 +0100
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Alasdair Kergon <agk@redhat.com>, DMML <dm-devel@lists.linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dm-bufio: align write boundary on bdev_logical_block_size
Message-ID: <aQCDLBie3fGwMDW2@milan>
References: <20251020123350.2671495-1-urezki@gmail.com>
 <cdb598ce-88ec-0c3c-8e4b-b557093bea92@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdb598ce-88ec-0c3c-8e4b-b557093bea92@redhat.com>

Hello!

Sorry i have missed you email for unknown reason to me. It is
probably because you answered to email with different subject
i sent initially.

> 
> On Mon, 20 Oct 2025, Uladzislau Rezki (Sony) wrote:
> 
> > When performing a read-modify-write(RMW) operation, any modification
> > to a buffered block must cause the entire buffer to be marked dirty.
> > 
> > Marking only a subrange as dirty is incorrect because the underlying
> > device block size(ubs) defines the minimum read/write granularity. A
> > lower device can perform I/O only on regions which are fully aligned
> > and sized to ubs.
> 
> Hi
> 
> I think it would be better to fix this in dm-bufio, so that other dm-bufio 
> users would also benefit from the fix. Please try this patch - does it fix 
> it?
> 
If it solves what i describe i do not mind :)

> 
> 
> From: Mikulas Patocka <mpatocka@redhat.com>
> 
> There may be devices with logical block size larger than 4k. Fix
> dm-bufio, so that it will align I/O on logical block size. This commit
> fixes I/O errors on the dm-ebs target on the top of emulated nvme device
> with 8k logical block size created with qemu parameters:
> 
> -device nvme,drive=drv0,serial=foo,logical_block_size=8192,physical_block_size=8192
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org
> 
> ---
>  drivers/md/dm-bufio.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> Index: linux-2.6/drivers/md/dm-bufio.c
> ===================================================================
> --- linux-2.6.orig/drivers/md/dm-bufio.c	2025-10-13 21:42:47.000000000 +0200
> +++ linux-2.6/drivers/md/dm-bufio.c	2025-10-20 14:40:32.000000000 +0200
> @@ -1374,7 +1374,7 @@ static void submit_io(struct dm_buffer *
>  {
>  	unsigned int n_sectors;
>  	sector_t sector;
> -	unsigned int offset, end;
> +	unsigned int offset, end, align;
>  
>  	b->end_io = end_io;
>  
> @@ -1388,9 +1388,10 @@ static void submit_io(struct dm_buffer *
>  			b->c->write_callback(b);
>  		offset = b->write_start;
>  		end = b->write_end;
> -		offset &= -DM_BUFIO_WRITE_ALIGN;
> -		end += DM_BUFIO_WRITE_ALIGN - 1;
> -		end &= -DM_BUFIO_WRITE_ALIGN;
> +		align = max(DM_BUFIO_WRITE_ALIGN, bdev_logical_block_size(b->c->bdev));
> +		offset &= -align;
> +		end += align - 1;
> +		end &= -align;
>  		if (unlikely(end > b->c->block_size))
>  			end = b->c->block_size;
>  
> 
I will check it and get back soon.

Thank you.

--
Uladzislau Rezki

