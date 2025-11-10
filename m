Return-Path: <linux-kernel+bounces-894176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C2FC496BE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9D23188D88F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33EB331A51;
	Mon, 10 Nov 2025 21:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="kZhaUjga"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF582BFC73
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 21:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762810420; cv=none; b=tutQXxMTNPM9U7fHVZ78FH9bET7OnVu+PGrCq0RwVQVHSCxCujRxWR6gzI8Y5XqErJ8zfAczNHHlzFbjYAlu+HMoT0zYI/lNu5co1EaVwRrV1qTiKNyvb5aesQ4ctbaoAaEaNmO70qW7IGkpl4BktE+n0GYd3cC114X26lN3QXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762810420; c=relaxed/simple;
	bh=zCkKKVg19c5cxq77+q3GwYQQR79PB9nvGpzFEBpyE/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZzlKRoNUszA+2maNyKaC9RHhB0bHkds9mthdnJuzati/DwR+DRMBEOZgJkRb9Yt9qguyzBv5qb73xu7eIhFr5i7E9FZE5GxJZjg3nihiC8hoegxqexw9MaACcHnvYEuQpiulv0xJnzeIXz3cQCjZB8yWkufKir4pfR4rPj6csg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=kZhaUjga; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so2884016a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1762810418; x=1763415218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SvM9ffGyDnNBYQvg+LznWRsq+EE4XVPlNR8iz1yg4y0=;
        b=kZhaUjgaREGTNavqnFP3TwTIUdylvNBvPrZODXT7zqCDrk0o5xk7DxPu7enRZ5BF/q
         uocMBVkwes/avytgIsvZR3/Re+xvgwqg+YSg6v1JYM1y9VpxOohdWbMqQBsZh08rjHrz
         x5QBdMoF/5Dz6g0UPJE4dult8cAcTUGD/Fe8YyWvGKeQMquLHYzpOMysv8f/1TDGPpWq
         iaixTALdNU9fe9CV0HshGmxSeCkSUVJyNG2NNlP3qxR2d1dgj+MqXIwungtZluYndI9z
         OYXOm+FwnkMlJ5pE+Q64sVkShfs1L7Yi3rvf7H0+wDS2TnSVHUEGJYeDXzppapqCwEle
         2eGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762810418; x=1763415218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SvM9ffGyDnNBYQvg+LznWRsq+EE4XVPlNR8iz1yg4y0=;
        b=vInGJLJOBOe2eXcLqwNdMSnCeuFVdWhMxbAHK/pJ8czejdScv6XHzekZ+aMZmgHTHh
         Bl0CeGrg/0KC/LpfCoQl/6AkAfqyP1z8szEPHqfao0tVQ7OSVoStZBSChera2/MJGXr3
         Bikcp+IYkWQqOg3rqILiw4hYipzgvPOP9QPZ+L4mXHHobiAf0drJjSB6yLIxhpk2y4wN
         7sNBOb1OvUQEPeyDVF4ryham+OCsNyERpxQAK78hcaj5sOQ0eiGxYAwUD1+taGvl5RsR
         oU5T+84VXueO3pIcEnaYBDKEyv3bAFponxl/cCa8R2jhihKpzxHov/UJnIJYHmWkY+R9
         xV4Q==
X-Forwarded-Encrypted: i=1; AJvYcCX/A7xblMgs2DXfyxf1tz0BXRF4praQzh9A0auxmLWdJlu6o4djwRkGXt70ArgY4IQnWqXK3XYU1MNUWzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtOk5OlbaugrZT4HAkLOg9/q7uZaNZ2F6qcWBO1AElgw5F1UMc
	PrT5ikyoZB5kJMXJy3oHO0irY5CjWHTTrE8/Vm1R4B/cTdFaQB6ZQ+EK/n2G62EA39I=
X-Gm-Gg: ASbGncvH2Mv01rDoywkHdDRBd6v6mseCoT73z/m6fAvi1Pp1NaAJpcvraux2WprTtvc
	IOQRJgGheRdG6Kadkg4n6ceUFgV9lHs5LJpz+9q9HYAcB8AMZmVmrHbQ4K1GV3OMKqkonYccUf3
	7HOg7Su2HEAjcw+Vo8HIC0jx1vwbjRM/z8ARslXk8nYC9iWWGSy7vmiLouLDREOR1CzNSTH5ffd
	3eRs+MUzWoZAiK3us8MqwlNd1Ca6JFtEVMRG6P3yxvxIX+rlDWHK6XNcWRyrwpVItAdnyJgRqOd
	WzZRB11nJ8Vipqw2N1Jq/e3NBVXodQ5JUU/kReaPJmi/59TxUP50xHUclixOYg4/h9NGqmICTQj
	DI8ZhCYTlzAhwdDl2YtbixSJud1bamBaNBBZ//AS4uI3PPK5s5L24noPi3xtIwMJijbtS4iEnAR
	4T6/4Hy8PN5d5CTzGlkZdzLkzQd3T6viDhdZk+T/FUfq9V1sl8nW0=
X-Google-Smtp-Source: AGHT+IE9Gy3zLsAHXnLViJPwf3Ayy1iV4+M7p8/z+XXoIz8O+RbPg3Grxn6wKe3lT/+eSU+c3SDd4w==
X-Received: by 2002:a17:903:a90:b0:295:7f1f:a808 with SMTP id d9443c01a7336-297e56b8c0cmr118357695ad.38.1762810417526;
        Mon, 10 Nov 2025 13:33:37 -0800 (PST)
Received: from dread.disaster.area (pa49-181-58-136.pa.nsw.optusnet.com.au. [49.181.58.136])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297e2484bfbsm92087665ad.26.2025.11.10.13.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 13:33:37 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1vIZW2-0000000961M-2l4D;
	Tue, 11 Nov 2025 08:33:34 +1100
Date: Tue, 11 Nov 2025 08:33:34 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Florian Weimer <fw@deneb.enyo.de>, Florian Weimer <fweimer@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Hans Holmberg <hans.holmberg@wdc.com>, linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	libc-alpha@sourceware.org
Subject: Re: [RFC] xfs: fake fallocate success for always CoW inodes
Message-ID: <aRJaLn72i4yh1mkp@dread.disaster.area>
References: <20251106133530.12927-1-hans.holmberg@wdc.com>
 <lhuikfngtlv.fsf@oldenburg.str.redhat.com>
 <20251106135212.GA10477@lst.de>
 <aQyz1j7nqXPKTYPT@casper.infradead.org>
 <lhu4ir7gm1r.fsf@oldenburg.str.redhat.com>
 <20251106170501.GA25601@lst.de>
 <878qgg4sh1.fsf@mid.deneb.enyo.de>
 <aRESlvWf9VquNzx3@dread.disaster.area>
 <20251110093701.GB22674@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110093701.GB22674@lst.de>

On Mon, Nov 10, 2025 at 10:37:01AM +0100, Christoph Hellwig wrote:
> On Mon, Nov 10, 2025 at 09:15:50AM +1100, Dave Chinner wrote:
> > On Sat, Nov 08, 2025 at 01:30:18PM +0100, Florian Weimer wrote:
> > > * Christoph Hellwig:
> > > 
> > > > On Thu, Nov 06, 2025 at 05:31:28PM +0100, Florian Weimer wrote:
> > > >> It's been a few years, I think, and maybe we should drop the allocation
> > > >> logic from posix_fallocate in glibc?  Assuming that it's implemented
> > > >> everywhere it makes sense?
> > > >
> > > > I really think it should go away.  If it turns out we find cases where
> > > > it was useful we can try to implement a zeroing fallocate in the kernel
> > > > for the file system where people want it.
> > 
> > This is what the shiny new FALLOC_FL_WRITE_ZEROS command is supposed
> > to provide. We don't have widepsread support in filesystems for it
> > yet, though.
> 
> Not really.  FALLOC_FL_WRITE_ZEROS does hardware-offloaded zeroing.

That is not required functionality - it is an implementation
optimisation.

WRITE_ZEROES requires that the subsequent write must not need to
perform filesystem metadata updates to guarantee data integrity.
How the filesystem implements that is up to the filesystem....

> I.e., it does the same think as the just write zeroes thing as the
> current glibc fallback and is just as bad for the same reasons.

No, it is not like the current glibc posix_fallocate() fallback.
That is a compatibility slow-path, not an IO path performance
optimisation.

i.e. WRITE_ZEROES is for applications that overwrite in place and
are very sensitive to IO latency.  The zeroing is done
in a context that is not performance sensitive, and it results in
much lower long tail latencies in the performance sensitive IO
paths.

WRITE_ZEROES is a more efficient way of running
FALLOC_FL_ALLOC_RANGE and then writing zeroes to convert the range
from unwritten to written extents because it allows ithe kernel to
use hardware offloads if they are available.

Applications that need pure overwrite behaviour are not going to be
using COW files or storage that requires always-COW IO paths in the
filesystems (e.g. on zoned storage hardware).

Hence we just don't care that:

> It
> also is something that doesn't make any sense to support in a write
> out of place file system.

... COW files cannot support WRITE_ZEROES functionality because
optimisations for overwrite-in-place aren't valid for COW-based
IO...

> > Failing to check the return value of a library call that documents
> > EOPNOTSUPP as a valid error is a bug. IOWs, the above code *should*
> > SIGBUS on the mmap access, because it failed to verify that the file
> > extension operation actually worked.
> > 
> > I mean, if this was "ftruncate(1); mmap(); *p =1" and ftruncate()
> > failed and so SIGBUS was delivered, there would be no doubt that
> > this is an application bug. Why is should we treat errors returned
> > by fallocate() and/or posix_fallocate() any different here?
> 
> I think what Florian wants (although I might be misunderstanding him)
> is an interface that will increase the file size up to the passed in
> size, but never reduce it and lose data.

Ah, that's not a "zeroing fallocate()" like was suggested. These are
the existing FALLOC_FL_ALLOCATE_RANGE file extension semantics.

AFAICT, this is exactly what the proposed patch implements - it
short circuits the bit we can't guarantee (ENOSPC prevention via
preallocation) but retains all the other aspects (non-destructive
truncate up) when it returns success.

I don't see how a glibc posix_fallocate() fallback that does a
non-desctructive truncate up though some new interface is any better
than just having the filesystem implement ALLOCATE_RANGE without the
ENOSPC guarantees in the first place?

> > > If we can get an fallocate mode that we can use as a fallback to
> > > increase the file size with a zero flag argument, we can definitely
> > 
> > The fallocate() API already support that, in two different ways:
> > FALLOC_FL_ZERO_RANGE and FALLOC_FL_WRITE_ZEROS. 
> 
> They are both quite different as they both zero the entire passed in
> range, even if it already contains data, which is completely different
> from the posix_fallocate or fallocate FALLOC_FL_ALLOCATE_RANGE semantics
> that leave any existing data intact.

Yes. However:

	fallocate(fd, FALLOC_FL_WRITE_ZEROES, old_eof, new_eof - old_eof);

is exactly the "zeroing truncate up" operation that was being
suggested. It will not overwrite any existing data, except if the
application is racing other file extension operations with this one.
In which case, the application is buggy, not the fallocate() code.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

