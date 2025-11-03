Return-Path: <linux-kernel+bounces-883622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7854C2DE72
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F2C93B5076
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140A931D372;
	Mon,  3 Nov 2025 19:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6yylscO"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7351C28D82F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 19:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762198154; cv=none; b=eFO3LKRuumSIwaDmHuQ5KGhTSjru7EbpVCXX1IVA5JixKWyb/1DHiGxGNrTZp/IYQN6XyzC5LzXfggnmhlDA9c+fKFQ+lCFmQPj6jyFK0Z6gulA3qDFH3uoveoP22XOMXzuuMArG3rha40x/biGLIt4EnGLVB93dGcqijw3t4Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762198154; c=relaxed/simple;
	bh=3ixGimuk0/HaHuWo/1PcSWMZCdoIwspA0vWadlpGWeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SoQD1bKrV+yAJQWIKFuhWF3g+/IT4mdO3BK6Z6jn/DuAlU1qW1hzGL7MozN66QqNWi3C89WsKzimFu9n5YeGiCch2MIIZibQbO6Qrlq3JTzB9r6yYN5iQd68fZf9do7H7LF583Bh9OHXjOGtzSNtooTEdCzEhwxZzjWll7f9Zkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6yylscO; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4283be7df63so2571837f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 11:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762198151; x=1762802951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pw1mz3Wmkjtz3arI75Z8UisY7e4ejFDGm7ZA+8DIcLQ=;
        b=l6yylscOgUvQq2XzBc73m3dsQ4lqZk3PKKfncA6Y0KpUo4bRCqPaboACeCKPcEl3QI
         2G3boR/0mKvFx23w0OSrMG1ts/2QruZd0ksArOh3PiEgDdIy6Gq417THbRE08p0SQJW0
         VVTgaJqec52votxFqdryHYmOUAyxhvkDpq3+H5nwtnMdr+ilYpnKc/gM7j37YCJGWY+u
         sCCRXmwa1o18i7dTSVaARYXi8YS0q/fovveVLhANFXkyoB86TeF9N11PU95qY+YvMzXs
         1BMtz3j0ckoVF64RwMz4l92+6jy8/StJULFLiTBnhdtzNuRuheLvU0wWxethjOmcVxoW
         fnsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762198151; x=1762802951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pw1mz3Wmkjtz3arI75Z8UisY7e4ejFDGm7ZA+8DIcLQ=;
        b=UYI605jwS2b4R2G2kNr2UCFuzji6NoDSGreevI5wXkPTWHFMRTaFeWbJfsdDfqacGv
         +RTLyKnOKg/CzYrYnym82aB2TGPwBhvRXeI8MkcNUr4gbRkLTgOknWd2vqgbO3fVckCV
         bQPRyl36XVMhBI380KZGgEdQCRxz0MGHtAMliyQ65JpV0b/WUcC9+DgicXRBm2qFLN9V
         83RkJv3+B0l4ak1GzwcqEag8a/vfiGzBZAYD8fh8KdVuSsY/bD8LdLuwK3NbVijHmu67
         WvBx1RmxByU0ymcrQiNev5ZcItFVp9/L7s8PRqz3N9ve6oeWNVlmFrTgy69Ar5HlW06P
         RsBg==
X-Forwarded-Encrypted: i=1; AJvYcCW0wINFu5l9B6i/hR/feT/dXK6UqdQeOde7c0vAwpriL53c8rsiNpAfCpzSG7r+7D+e0BKlS+3hKNVnU+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy62bKRHYtgh3Yo3/Vc+xCPELOWGkEWxM6ZknfXLQv2QyLlEXdF
	Z8iMUS7BO2r8lgyxDQNHXCqpFC8QT0YsU9Uvp+EJTIjiK5wB2HBB6uDO
X-Gm-Gg: ASbGncu0ulcDD5g8wPHAnjaKBV+IuPfz9UAiLt9hwL9uF/p8qrcCYHfA+3B86GxUSQ1
	LM4dA1d9CecfVMNFRARNlQ9iLw0pPAoveI5SSH402wEb2tqnTfwVUK5i5/WcSLTn8czmg0yN1Zn
	qnXoCFY27E4x1oZTT0kUD/55PFMHySyMSlo83hUGqTGj4rWYCwUN/v1oorSTdsaIMpyOc/v5ZSm
	4eJnXHi9ceGBHAX3SJ/85mLZns95kI5w3QKSg8BNqEEtHnc1pgT8CZAI0FD2WAJUhWOmDxU1Lzm
	yirGaDuliS6LmVOIsLD2swFSbLaLSHc/rrIZUT/tTtDXKqXpw4k7TZ9Q2Y1z0sZBPNAT/2i+P6G
	xJJhPixeTBBLXXOWW7TviiHGGsuEACXNtA5Q2MjP+ICrvS/222EXL9CBFugjaky6qssWq2d1IFh
	XvqA6tuWauEtR3NfX26sLrtUfhUYG5sdMZNwcTr3HH88n8pU5lc0x4
X-Google-Smtp-Source: AGHT+IEIOBDfz+HBIHDphP6uzoI17aYjvF3ZSriDyVBLsupCrmaZDmFmWse/BayuXmJV7U9EbfA7ug==
X-Received: by 2002:a05:6000:2411:b0:427:928:789e with SMTP id ffacd0b85a97d-429bd6d583dmr12073376f8f.61.1762198150371;
        Mon, 03 Nov 2025 11:29:10 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c4af7c7sm175165915e9.7.2025.11.03.11.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 11:29:10 -0800 (PST)
Date: Mon, 3 Nov 2025 19:29:08 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, Guan-Chun Wu
 <409411716@gms.tku.edu.tw>, Andrew Morton <akpm@linux-foundation.org>,
 ebiggers@kernel.org, tytso@mit.edu, jaegeuk@kernel.org, xiubli@redhat.com,
 idryomov@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, home7438072@gmail.com, linux-nvme@lists.infradead.org,
 linux-fscrypt@vger.kernel.org, ceph-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] lib/base64: add generic encoder/decoder, migrate
 users
Message-ID: <20251103192908.1d716a7b@pumpkin>
In-Reply-To: <aQjxjlJvLnx_zRx8@smile.fi.intel.com>
References: <20251029101725.541758-1-409411716@gms.tku.edu.tw>
	<20251031210947.1d2b028da88ef526aebd890d@linux-foundation.org>
	<aQiC4zrtXobieAUm@black.igk.intel.com>
	<aQiM7OWWM0dXTT0J@google.com>
	<20251103132213.5feb4586@pumpkin>
	<aQi_JHjSi46uUcjB@smile.fi.intel.com>
	<aQjxjlJvLnx_zRx8@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Nov 2025 20:16:46 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Nov 03, 2025 at 04:41:41PM +0200, Andy Shevchenko wrote:
> > On Mon, Nov 03, 2025 at 01:22:13PM +0000, David Laight wrote:  
> > > On Mon, 3 Nov 2025 19:07:24 +0800
> > > Kuan-Wei Chiu <visitorckw@gmail.com> wrote:  
> > > > On Mon, Nov 03, 2025 at 11:24:35AM +0100, Andy Shevchenko wrote:  
> > > > > On Fri, Oct 31, 2025 at 09:09:47PM -0700, Andrew Morton wrote:    
> > > > > > On Wed, 29 Oct 2025 18:17:25 +0800 Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:  
> 
> ...
> 
> > > > > > Looks like wonderful work, thanks.  And it's good to gain a selftest
> > > > > > for this code.
> > > > > >     
> > > > > > > This improves throughput by ~43-52x.    
> > > > > > 
> > > > > > Well that isn't a thing we see every day.    
> > > > > 
> > > > > I agree with the judgement, the problem is that this broke drastically a build:
> > > > > 
> > > > > lib/base64.c:35:17: error: initializer overrides prior initialization of this subobject [-Werror,-Winitializer-overrides]
> > > > >    35 |         [BASE64_STD] = BASE64_REV_INIT('+', '/'),
> > > > >       |                        ^~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > lib/base64.c:26:11: note: expanded from macro 'BASE64_REV_INIT'
> > > > >    26 |         ['A'] =  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, \
> > > > >       |                  ^
> > > > > lib/base64.c:35:17: note: previous initialization is here
> > > > >    35 |         [BASE64_STD] = BASE64_REV_INIT('+', '/'),
> > > > >       |                        ^~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > lib/base64.c:25:16: note: expanded from macro 'BASE64_REV_INIT'
> > > > >    25 |         [0 ... 255] = -1, \
> > > > >       |                       ^~
> > > > > ...
> > > > > fatal error: too many errors emitted, stopping now [-ferror-limit=]
> > > > > 20 errors generated.
> > > > >     
> > > > Since I didn't notice this build failure, I guess this happens during a
> > > > W=1 build? Sorry for that. Maybe I should add W=1 compilation testing
> > > > to my checklist before sending patches in the future. I also got an
> > > > email from the kernel test robot with a duplicate initialization
> > > > warning from the sparse tool [1], pointing to the same code.
> > > > 
> > > > This implementation was based on David's previous suggestion [2] to
> > > > first default all entries to -1 and then set the values for the 64
> > > > character entries. This was to avoid expanding the large 256 * 3 table
> > > > and improve code readability.
> > > > 
> > > > Since I believe many people test and care about W=1 builds,  
> > > 
> > > Last time I tried a W=1 build it failed horribly because of 'type-limits'.
> > > The kernel does that all the time - usually for its own error tests inside
> > > #define and inline functions.
> > > Certainly some of the changes I've seen to stop W=1 warnings are really
> > > a bad idea - but that is a bit of a digression.
> > > 
> > > Warnings can be temporarily disabled using #pragma.
> > > That might be the best thing to do here with this over-zealous warning.
> > > 
> > > This compiles on gcc and clang (even though the warnings have different names):
> > > #pragma GCC diagnostic push
> > > #pragma GCC diagnostic ignored "-Woverride-init"
> > > int x[16] = { [0 ... 15] = -1, [5] = 5};
> > > #pragma GCC diagnostic pop
> > >   
> > > > I think we need to find another way to avoid this warning?
> > > > Perhaps we could consider what you suggested:
> > > > 
> > > > #define BASE64_REV_INIT(val_plus, val_comma, val_minus, val_slash, val_under) { \
> > > > 	[ 0 ... '+'-1 ] = -1, \
> > > > 	[ '+' ] = val_plus, val_comma, val_minus, -1, val_slash, \
> > > > 	[ '0' ] = 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, \
> > > > 	[ '9'+1 ... 'A'-1 ] = -1, \
> > > > 	[ 'A' ] = 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, \
> > > > 		  23, 24, 25, 26, 27, 28, 28, 30, 31, 32, 33, 34, 35, \
> > > > 	[ 'Z'+1 ... '_'-1 ] = -1, \
> > > > 	[ '_' ] = val_under, \
> > > > 	[ '_'+1 ... 'a'-1 ] = -1, \
> > > > 	[ 'a' ] = 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, \
> > > > 		  49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, \
> > > > 	[ 'z'+1 ... 255 ] = -1 \
> > > > }  
> > > 
> > > I just checked, neither gcc nor clang allow empty ranges (eg [ 6 ... 5 ] = -1).
> > > Which means the coder has to know which characters are adjacent as well
> > > as getting the order right.
> > > Basically avoiding the warning sucks.
> > >   
> > > > Or should we just expand the 256 * 3 table as it was before?  
> > > 
> > > That has much the same issue - IIRC it relies on three big sequential lists.
> > > 
> > > The #pragma may be best - but doesn't solve sparse (unless it processes
> > > them as well).  
> > 
> > Pragma will be hated.

They have been used in a few other places.
and to disable more 'useful' warnings.

> > I believe there is a better way to do what you want. Let me cook a PoC.  
> 
> I tried locally several approaches and the best I can come up with is the pre-generated
> (via Python script) pieces of C code that we can copy'n'paste instead of that shortened
> form. So basically having a full 256 tables in the code is my suggestion to fix the build
> issue. Alternatively we can generate that at run-time (on the first run) in
> the similar way how prime_numbers.c does. The downside of such an approach is loosing
> the const specifier, which I consider kinda important.
> 
> Btw, in the future here might be also the side-channel attack concerns appear, which would
> require to reconsider the whole algo to get it constant-time execution.

The array lookup version is 'reasonably' time constant.
One option is to offset all the array entries by 1 and subtract 1 after reading the entry.
That means that the 'error' characters have zero in the array (not -1).
At least the compiler won't error that!
The extra 'subtract 1' is probably just measurable.

But I'd consider raising a bug on gcc :-)
One of the uses of ranged designated initialisers for arrays is to change the
default value - as been done here.
It shouldn't cause a warning.

	David

> 
> > > > [1]: https://lore.kernel.org/oe-kbuild-all/202511021343.107utehN-lkp@intel.com/
> > > > [2]: https://lore.kernel.org/lkml/20250928195736.71bec9ae@pumpkin/  
> 


