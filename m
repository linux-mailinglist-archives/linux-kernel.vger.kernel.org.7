Return-Path: <linux-kernel+bounces-842351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F30EBB9905
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 17:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAE801896583
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 15:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A18D2882CC;
	Sun,  5 Oct 2025 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hg6Xjwq8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E551419A9
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759678811; cv=none; b=o8wVvwHqJj5DvDJjBTJ8rL/vA0OR2efv+2ObasytTGEu+ynbPPZCnVZ+GzgoAig3SGnVLBcMSymzjMKsGN3/hPPiCtqKqEqZhPrqx8yOCwRMQXqQGmQ928+AQ1aY65ide4tUlz/crFD14a/UdVV+fvgns9cZoeWt5XUMzMwc/ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759678811; c=relaxed/simple;
	bh=R1K2JFKJydcEZh45xXiV8Sc9Vqu8beUFlAY3k7qUxFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2opZ0u+NYWckf57PS5IyiXD/dyq90nDJzPhrYczeHm7gjceo81TPxOqxA3ylhCZOHPZR+hdYbklaJdByLdaCP1mt864oT53J1n2U13WvkPfmd0KtA3n/EfqKls+S7dJVOO/zEwTyuxsJ3KhdhE+LgNQZQLxq8mh5ifEOjUJurc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hg6Xjwq8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759678806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ug83nJMIxm1+l9zlfeCnO8Pp3qwC8RmBILGiMr6FtEA=;
	b=Hg6Xjwq8xq4oFxGoyQ7Cp/Oi1mp56b9jxfaTm9ZdONYlN9IP8Z7tct232kNpDHAAp391hM
	1RlGvEY43EvhY6N/woZ6JWyJAb6loFwqzLtu7hB5pbBC2DhWvDniAVOL8R/BHJV3FLxNK9
	KYttvsBlM7pOByAMnDgcSskZwNH8td4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-abuHwFyqNTGYwu3u5mS7PA-1; Sun, 05 Oct 2025 11:40:04 -0400
X-MC-Unique: abuHwFyqNTGYwu3u5mS7PA-1
X-Mimecast-MFC-AGG-ID: abuHwFyqNTGYwu3u5mS7PA_1759678804
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32eaa47c7c8so3574090a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 08:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759678804; x=1760283604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ug83nJMIxm1+l9zlfeCnO8Pp3qwC8RmBILGiMr6FtEA=;
        b=Im68ClrUXkdLRiSlfnJKpnITV89Z3Hld2B7Kj6yZCRGsfa2YkyEo9eUzaipXiMtmLl
         QpYQpQgxSlr0hySZQ+xd3374H0PiYBrD7mGQH4PCocX7a6SqZ4rV5xrchOY3BYCZbPLj
         beuH0zGol4PCZT+wgh86wXoesvKXsf4dI/mdzXPZLWpPOQiT/9TtlFBVesjahLuXA1ij
         WIDXXyuY69tNYSDC2kVJSqnUpsuXtWUOwdFubH1C68pSr4JxzOGSjm/Zo7Y+6dyclEJA
         YxkJVL4G1PHtX/Lt+EPgbmCdxrWMUgL80Ylmy+avwj7e5FAe49EGXpVar53rtsWA91M0
         dVXw==
X-Forwarded-Encrypted: i=1; AJvYcCVBTaxqHcjgdVJbKfQOPefdmAGvpct7WMhZWQg7yQqV3ILOYzbISkscHDjfvEoU1mAD5Dg0QCQ1YGqUch0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW40qOIzDs3wRUJ48Morgspx7dEujIb9ORTsVLVpOi39O8Wsvt
	/3Ibzmm9k0UyguUZX743Bw7IzQ5fbSrCbKQWJxglv/514cH9TrvQN/vD7q5PnQuVjR6d/uODV+0
	QZYQPqYCH7jtVh0fGtZTyXarU2c0TuePMqyq/TkV7KqXKzkZ5XosJ7CYUo5UrZKfJQA==
X-Gm-Gg: ASbGnct1kdAtH3wb6RMVt7GK5R0oPY0bnkVAs1D80VJ+CSzkcWfFBQnuJvSD6azH8Xr
	KMYZihAjO1ryp+wiPwp7B2ehy8HCVWN23pxmMtL3MRwhUdr6wFUK3TaEYRqUqXUBiDugUVU2KEX
	W+fPt94gHzMyZiPLs+fhArwnSSyYmesUgIttP/TjEzL0wjTrHrTJ+sPPI5hRn89A8bzUv7gIIhQ
	Y7CNGajPMVBiWKho5lei3yrjAWNm/8cydJSzbaUNdDRoP4e/kcTEDKkr8EjGE7PeU9kQSSblu3I
	H4Ce0OUcCqeoTtYZeCkvxenMWciC9E8IRuRNBuMD1NKLw87yoBNT6boYaOK1dIuweQ9xvooIr/i
	fBqbJIgiFZw==
X-Received: by 2002:a17:90b:1c8f:b0:334:cb89:bde6 with SMTP id 98e67ed59e1d1-339c2708152mr11655663a91.4.1759678803387;
        Sun, 05 Oct 2025 08:40:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+5A5ndgSqmcSPje32KNyrlaoqKKZEgvjbPFV9uoEl3fimy9YeWgI871mlSOzBWHxJetpfFQ==
X-Received: by 2002:a17:90b:1c8f:b0:334:cb89:bde6 with SMTP id 98e67ed59e1d1-339c2708152mr11655642a91.4.1759678802881;
        Sun, 05 Oct 2025 08:40:02 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ff27fbsm13374036a91.14.2025.10.05.08.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 08:40:02 -0700 (PDT)
Date: Sun, 5 Oct 2025 23:39:56 +0800
From: Zorro Lang <zlang@redhat.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	djwong@kernel.org, john.g.garry@oracle.com, tytso@mit.edu,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v7 04/12] ltp/fsx.c: Add atomic writes support to fsx
Message-ID: <20251005153956.zofernclbbva3xt6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1758264169.git.ojaswin@linux.ibm.com>
 <c3a040b249485b02b569b9269b649d02d721d995.1758264169.git.ojaswin@linux.ibm.com>
 <20250928131924.b472fjxwir7vphsr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aN683ZHUzA5qPVaJ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20251003171932.pxzaotlafhwqsg5v@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aOJrNHcQPD7bgnfB@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOJrNHcQPD7bgnfB@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Sun, Oct 05, 2025 at 06:27:24PM +0530, Ojaswin Mujoo wrote:
> On Sat, Oct 04, 2025 at 01:19:32AM +0800, Zorro Lang wrote:
> > On Thu, Oct 02, 2025 at 11:26:45PM +0530, Ojaswin Mujoo wrote:
> > > On Sun, Sep 28, 2025 at 09:19:24PM +0800, Zorro Lang wrote:
> > > > On Fri, Sep 19, 2025 at 12:17:57PM +0530, Ojaswin Mujoo wrote:
> > > > > Implement atomic write support to help fuzz atomic writes
> > > > > with fsx.
> > > > > 
> > > > > Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > > > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > > > Reviewed-by: John Garry <john.g.garry@oracle.com>
> > > > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > > > ---
> > > > 
> > > > Hmm... this patch causes more regular fsx test cases fail on old kernel,
> > > > (e.g. g/760, g/617, g/263 ...) except set "FSX_AVOID=-a". Is there a way
> > > > to disable "atomic write" automatically if it's not supported by current
> > > > system?
> > > 
> > > Hi Zorro, 
> > > Sorry for being late, I've been on vacation this week.
> > > 
> > > Yes so by design we should be automatically disabling atomic writes when
> > > they are not supported by the stack but seems like the issue is that
> > > when we do disable it we print some extra messages to stdout/err which
> > > show up in the xfstests output causing failure.
> > > 
> > > I can think of 2 ways around this:
> > > 
> > > 1. Don't print anything and just silently drop atomic writes if stack
> > > doesn't support them.
> > > 
> > > 2. Make atomic writes as a default off instead of default on feature but
> > > his loses a bit of coverage as existing tests wont get atomic write
> > > testing free of cost any more.
> > 
> > Hi Ojaswin,
> > 
> > Please have a nice vacation :)
> > 
> > It's not the "extra messages" cause failure, those "quiet" failures can be fixed
> > by:
> 
> Oh okay got it.
> 
> > 
> > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > index bdb87ca90..0a035b37b 100644
> > --- a/ltp/fsx.c
> > +++ b/ltp/fsx.c
> > @@ -1847,8 +1847,9 @@ int test_atomic_writes(void) {
> >         struct statx stx;
> >  
> >         if (o_direct != O_DIRECT) {
> > -               fprintf(stderr, "main: atomic writes need O_DIRECT (-Z), "
> > -                               "disabling!\n");
> > +               if (!quiet)
> > +                       fprintf(stderr, "main: atomic writes need O_DIRECT (-Z), "
> > +                                       "disabling!\n");
> >                 return 0;
> >         }
> >  
> > @@ -1867,8 +1868,9 @@ int test_atomic_writes(void) {
> >                 return 1;
> >         }
> >  
> > -       fprintf(stderr, "main: IO Stack does not support "
> > -                       "atomic writes, disabling!\n");
> > +       if (!quiet)
> > +               fprintf(stderr, "main: IO Stack does not support "
> > +                               "atomic writes, disabling!\n");
> >         return 0;
> >  }
> 
> > 
> > But I hit more read or write failures e.g. [1], this failure can't be
> > reproduced with FSX_AVOID=-a. Is it a atomic write bug or an unexpected
> > test failure?
> > 
> > Thanks,
> > Zorro
> > 
> 
> <...>
> 
> > +244(244 mod 256): SKIPPED (no operation)
> > +245(245 mod 256): FALLOC   0x695c5 thru 0x6a2e6	(0xd21 bytes) INTERIOR
> > +246(246 mod 256): MAPWRITE 0x5ac00 thru 0x5b185	(0x586 bytes)
> > +247(247 mod 256): WRITE    0x31200 thru 0x313ff	(0x200 bytes)
> > +248(248 mod 256): SKIPPED (no operation)
> > +249(249 mod 256): TRUNCATE DOWN	from 0x78242 to 0xf200	******WWWW
> > +250(250 mod 256): FALLOC   0x65000 thru 0x66f26	(0x1f26 bytes) PAST_EOF
> > +251(251 mod 256): WRITE    0x45400 thru 0x467ff	(0x1400 bytes) HOLE	***WWWW
> > +252(252 mod 256): SKIPPED (no operation)
> > +253(253 mod 256): SKIPPED (no operation)
> > +254(254 mod 256): MAPWRITE 0x4be00 thru 0x4daee	(0x1cef bytes)
> > +255(255 mod 256): MAPREAD  0xc000 thru 0xcae9	(0xaea bytes)
> > +256(  0 mod 256): READ     0x3e000 thru 0x3efff	(0x1000 bytes)
> > +257(  1 mod 256): SKIPPED (no operation)
> > +258(  2 mod 256): INSERT 0x45000 thru 0x45fff	(0x1000 bytes)
> > +259(  3 mod 256): ZERO     0x1d7d5 thru 0x1f399	(0x1bc5 bytes)	******ZZZZ
> > +260(  4 mod 256): TRUNCATE DOWN	from 0x4eaef to 0x11200	******WWWW
> > +261(  5 mod 256): WRITE    0x43000 thru 0x43fff	(0x1000 bytes) HOLE	***WWWW
> > +262(  6 mod 256): WRITE    0x2200 thru 0x31ff	(0x1000 bytes)
> > +263(  7 mod 256): WRITE    0x15000 thru 0x15fff	(0x1000 bytes)
> > +264(  8 mod 256): WRITE    0x2e400 thru 0x2e7ff	(0x400 bytes)
> > +265(  9 mod 256): COPY 0xd000 thru 0xdfff	(0x1000 bytes) to 0x1d800 thru 0x1e7ff	******EEEE
> > +266( 10 mod 256): CLONE 0x2a000 thru 0x2afff	(0x1000 bytes) to 0x21000 thru 0x21fff
> > +267( 11 mod 256): MAPREAD  0x31000 thru 0x31d0a	(0xd0b bytes)
> > +268( 12 mod 256): SKIPPED (no operation)
> > +269( 13 mod 256): WRITE    0x25000 thru 0x25fff	(0x1000 bytes)
> > +270( 14 mod 256): SKIPPED (no operation)
> > +271( 15 mod 256): MAPREAD  0x30000 thru 0x30577	(0x578 bytes)
> > +272( 16 mod 256): PUNCH    0x1a267 thru 0x1c093	(0x1e2d bytes)
> > +273( 17 mod 256): MAPREAD  0x1f000 thru 0x1f9c9	(0x9ca bytes)
> > +274( 18 mod 256): WRITE    0x40800 thru 0x40dff	(0x600 bytes)
> > +275( 19 mod 256): SKIPPED (no operation)
> > +276( 20 mod 256): MAPWRITE 0x20600 thru 0x22115	(0x1b16 bytes)
> > +277( 21 mod 256): MAPWRITE 0x3d000 thru 0x3ee5a	(0x1e5b bytes)
> > +278( 22 mod 256): WRITE    0x2ee00 thru 0x2efff	(0x200 bytes)
> > +279( 23 mod 256): WRITE    0x76200 thru 0x769ff	(0x800 bytes) HOLE
> > +280( 24 mod 256): SKIPPED (no operation)
> > +281( 25 mod 256): SKIPPED (no operation)
> > +282( 26 mod 256): MAPREAD  0xa000 thru 0xa5e7	(0x5e8 bytes)
> > +283( 27 mod 256): SKIPPED (no operation)
> > +284( 28 mod 256): SKIPPED (no operation)
> > +285( 29 mod 256): SKIPPED (no operation)
> > +286( 30 mod 256): SKIPPED (no operation)
> > +287( 31 mod 256): COLLAPSE 0x11000 thru 0x11fff	(0x1000 bytes)
> > +288( 32 mod 256): COPY 0x5d000 thru 0x5dfff	(0x1000 bytes) to 0x4ca00 thru 0x4d9ff
> > +289( 33 mod 256): TRUNCATE DOWN	from 0x75a00 to 0x1e400
> > +290( 34 mod 256): MAPREAD  0x1c000 thru 0x1d802	(0x1803 bytes)	***RRRR***
> > +Log of operations saved to "/mnt/xfstests/test/junk.fsxops"; replay with --replay-ops
> > +Correct content saved for comparison
> > +(maybe hexdump "/mnt/xfstests/test/junk" vs "/mnt/xfstests/test/junk.fsxgood")
> > 
> > Thanks,
> > Zorro
> 
> Hi Zorro, just to confirm is this on an older kernel that doesnt support
> RWF_ATOMIC or on a kernle that does support it.

I tested on linux 6.16 and current latest linux v6.17+ (will be 6.18-rc1 later).
About the RWF_ATOMIC flag in my system:

# grep -rsn RWF_ATOMIC /usr/include/
/usr/include/bits/uio-ext.h:51:#define RWF_ATOMIC       0x00000040 /* Write is to be issued with torn-write
/usr/include/linux/fs.h:424:#define RWF_ATOMIC  ((__kernel_rwf_t)0x00000040)
/usr/include/linux/fs.h:431:                     RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC |\
/usr/include/xfs/linux.h:236:#ifndef RWF_ATOMIC
/usr/include/xfs/linux.h:237:#define RWF_ATOMIC ((__kernel_rwf_t)0x00000040)

Thanks,
Zorro

> 
> Regards,
> ojaswin
> 


