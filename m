Return-Path: <linux-kernel+bounces-759052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9097B1D7B9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43611AA5BFA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 12:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDBC23BF8F;
	Thu,  7 Aug 2025 12:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3NttjHh"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F117227BB5
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 12:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754568991; cv=none; b=i8sI9UoyrGiOKpnVTnQgx1jvYsgFVuHytS2TX1HVCM9e0cTJesm3W44+NYO8+EEonBoP6WSqG8l8INY5yaCFV8+XF87bXnRfN6IBBynjSyruOSOk/xeqR2Xf9/7ephjFScE/JymhddjqwPOwIR2SA1K4SASak6tecj0xm2GPIb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754568991; c=relaxed/simple;
	bh=QKyJ16bfUqqq4m+uPGZs8XFxjmM8/t5B8GO7S8gKkK8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aedrgl6v0vxQl6GrdKT5DOUQWyAJqpht/4w2s7lS7rrtbHoJHdRhqW7wo+z8DncfKVI405iLkn22PMhwf9r4kkHtwaUCoDv1+FhjZ9PX83grJ3f68op+v2yq33MadCPDTRt5QAGK5uItvfkDQ9v/G2fpo6bh8LDogS7KdE9jDf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3NttjHh; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-458b2d9dba5so5994695e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 05:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754568987; x=1755173787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHVxavGBrjI2mC/mT+iovNRLtR2msFcHcq0N4dnm4w4=;
        b=O3NttjHhmcoEPuIb7fB0wE4mF/a1VWcNcUcOV5Q4a2gH8UKZ/2rLrCAuF8bgWXk2Rw
         CbTNooRrxmrVHxJFUbrYQR7b9L7S/PhshYYgXdUBf0ulp7s641SSNO9aL3gYCjRXGDIp
         mVzYuGCPsZECBy14i4q9WI8okKTou+cexXkSuk5SIIgQQxqKdS4QG2l/Uy0nx37gKUqT
         l3s5bqjRDIbHooKLrAbkTUhsO1is2RL+tN2rDcFPRl+/vnlHGlkahC198D6xwrDXOcJT
         ND+MzAhkeZ4zPocC5EMeiCaX4R5h5AZyAR6vbsF5xKSqwSn5s4ROf0UmlDwptX7gn3Ri
         Bnng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754568987; x=1755173787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHVxavGBrjI2mC/mT+iovNRLtR2msFcHcq0N4dnm4w4=;
        b=l3vH2YFd7yY9hRmTsTdtZyim5I/mrqPfC2iP5vkU56qk7COOHt+H0uJhunychrDBJG
         Hb6+XALD+YcjG/vEVsHYSAzOtTujo8a1RaxkJamOL3ckBqbj4OGk2z+t9mcGuClyYkmX
         rwZopajzZvU+CBMBdQps0pp5kTSIh+1EBXhkcl8yjf5mzGgT4WCcuJe95t57jOSvrP+F
         bgFR+0xwJ18C9D/hj0ooubJltlaaIFZl1wjdF2OOOIz7Qj8T14K2og149FKvXjCCaLTo
         Fxc/JBxsD0SPW7rook4pxh54/k5bq7/znOkh76cvWVaEnahJ93b0wHMDb2wzvpzy58sC
         SSNw==
X-Forwarded-Encrypted: i=1; AJvYcCWyFyUtt+AOroXfXxBzlZ/OODyAL8AFReq+gGdtESYZQiqg06Efxmsd6cch8WGy4XhKHw91dGWfA+D7aME=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZN62SH5CFl5u/bV5FnG1bX9b8r9MWAUpR6zbksXT2w//X50eK
	tGLoDBd3VWOPuO1AEs4kE+MPVh0+st/bwRBs+50/XKmQ0AlGZVnjDFcS
X-Gm-Gg: ASbGnctf+VH1OrRsOOxOlv4FpoLgqVkvVP5HWXmOg7G5ZgATCcsv6o4VAAqKnXHbiDn
	5gxWEZDdJDGoC9/e11RgnAP39UF0VSNUsAohHYA3o6Kezje4+V6R130HUDwIGJS9ubIzCyibXdU
	4y6mYuJAp1W8lP902MRwc/tAPy8gJZ3c0b2a73gYurGyMBkEkptFvMqW/5uj49jH2n7p1KfNh/5
	2rl3H1Ck8zituhuSvBq1h9NXy+Y32Gny3QyAmarvnV4iyKv12ppDH9W5ZNR5nku8F8kX9TR8HY8
	2LX2D1OD76pk1k/akgLxRWqejqUv7T9depP2mHNGe4WDyDva3y3TSdKUI8LoZlntmqqdYSodgTn
	d1ZlFdIBIWUHQS/vxdMWzZUflWUWPBtk9dQ6VeAgRoZ+mYmySNtAwwNtwuBJm
X-Google-Smtp-Source: AGHT+IEOgiOG7X+/+74Nfd3tZumZZr82xYQBn2+nD/Q2k2sFIFigqmAXZC4pBSX/xsQ8vrDeLg+6aQ==
X-Received: by 2002:a05:600c:5486:b0:456:43c:dcdc with SMTP id 5b1f17b1804b1-459e7136bfbmr57298345e9.33.1754568987042;
        Thu, 07 Aug 2025 05:16:27 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e0e70218sm120028755e9.20.2025.08.07.05.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 05:16:26 -0700 (PDT)
Date: Thu, 7 Aug 2025 13:16:11 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: wang lian <lianux.mm@gmail.com>, akpm@linux-foundation.org,
 broonie@kernel.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 sj@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 brauner@kernel.org, gkwang@linx-info.com, jannh@google.com,
 Liam.Howlett@oracle.com, ludovico.zy.wu@gmail.com, p1ucky0923@gmail.com,
 richard.weiyang@gmail.com, ryncsn@gmail.com, shuah@kernel.org,
 vbabka@suse.cz, zijing.zhang@proton.me
Subject: Re: [PATCH 1/2] selftests/mm: reuse FORCE_READ to replace "asm
 volatile("" : "+r" (XXX));"
Message-ID: <20250807131611.430a097a@pumpkin>
In-Reply-To: <22169C82-5701-4ABB-811F-075D22CE6FCD@nvidia.com>
References: <20250717131857.59909-1-lianux.mm@gmail.com>
	<20250717131857.59909-2-lianux.mm@gmail.com>
	<22169C82-5701-4ABB-811F-075D22CE6FCD@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 05 Aug 2025 10:26:17 -0400
Zi Yan <ziy@nvidia.com> wrote:

> On 17 Jul 2025, at 9:18, wang lian wrote:
> 
> > Several mm selftests use the `asm volatile("" : "+r" (variable));`
> > construct to force a read of a variable, preventing the compiler from
> > optimizing away the memory access. This idiom is cryptic and duplicated
> > across multiple test files.
> >
> > Following a suggestion from David[1], this patch refactors this
> > common pattern into a FORCE_READ() macro
> >
> > [1] https://lore.kernel.org/lkml/4a3e0759-caa1-4cfa-bc3f-402593f1eee3@redhat.com/
> >
> > Signed-off-by: wang lian <lianux.mm@gmail.com>
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  tools/testing/selftests/mm/cow.c              | 30 +++++++++----------
> >  tools/testing/selftests/mm/guard-regions.c    |  7 -----
> >  tools/testing/selftests/mm/hugetlb-madvise.c  |  5 +---
> >  tools/testing/selftests/mm/migration.c        | 13 ++++----
> >  tools/testing/selftests/mm/pagemap_ioctl.c    |  4 +--
> >  .../selftests/mm/split_huge_page_test.c       |  4 +--
> >  tools/testing/selftests/mm/vm_util.h          |  7 +++++
> >  7 files changed, 31 insertions(+), 39 deletions(-)
> >  
> 
> <snip>
> 
> > diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
> > index f0d9c035641d..05de1fc0005b 100644
> > --- a/tools/testing/selftests/mm/split_huge_page_test.c
> > +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> > @@ -399,7 +399,6 @@ int create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, int *fd,
> >  		char **addr)
> >  {
> >  	size_t i;
> > -	int dummy = 0;
> >  	unsigned char buf[1024];
> >
> >  	srand(time(NULL));
> > @@ -441,8 +440,7 @@ int create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, int *fd,
> >  	madvise(*addr, fd_size, MADV_HUGEPAGE);
> >
> >  	for (size_t i = 0; i < fd_size; i++)
> > -		dummy += *(*addr + i);
> > -	asm volatile("" : "+r" (dummy));
> > +		FORCE_READ((*addr + i));  
> 
> I encountered a segfault when running the test on x86_64.
> i is 4194297 and fd_size is 4194304.
> It seems that FORCE_READ() is reading (*addr + i) in 8 byte size
> and i is only 7 bytes away from the end of the memory address.
> This led to segfault.
> 
> (*(volatile char*)(*addr + i)); works fine.
> 
> Both gcc-12 and gcc-14 have the issue.

The definition of FORCE_READ in 6.16 is:
#define FORCE_READ(x) (*(volatile typeof(x) *)x)
this is clearly bogus.
'x' is a pointer - follow it through.
Possibly:
#define FORCE_READ(x) (*(volatile typeof(*(x)) *)(x))
is better,
But why not use READ_ONCE(*addr[i]) ?

	David

> 
> >
> >  	if (!check_huge_file(*addr, fd_size / pmd_pagesize, pmd_pagesize)) {
> >  		ksft_print_msg("No large pagecache folio generated, please provide a filesystem supporting large folio\n");
> > diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
> > index 2b154c287591..c20298ae98ea  100644
> > --- a/tools/testing/selftests/mm/vm_util.h
> > +++ b/tools/testing/selftests/mm/vm_util.h
> > @@ -18,6 +18,13 @@
> >  #define PM_SWAP                       BIT_ULL(62)
> >  #define PM_PRESENT                    BIT_ULL(63)
> >
> > +/*
> > + * Ignore the checkpatch warning, we must read from x but don't want to do
> > + * anything with it in order to trigger a read page fault. We therefore must use
> > + * volatile to stop the compiler from optimising this away.
> > + */
> > +#define FORCE_READ(x) (*(volatile typeof(x) *)x)
> > +  
> 
> Also, look at FORCE_READ again, it converts x to a pointer to x and
> deferences x as a point. It does not seem right to me.
> 
> Best Regards,
> Yan, Zi
> 


