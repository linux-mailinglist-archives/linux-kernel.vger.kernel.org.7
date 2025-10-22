Return-Path: <linux-kernel+bounces-864412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B90FABFABD3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94E941A038A3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9712749DC;
	Wed, 22 Oct 2025 08:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Nvca4rWi"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E62C2F2916
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120036; cv=none; b=BP3x5ySuKeJoAv+ghjedffkfMZ2fcxvTT2MhIwMvMzW2cyp0V6n5L5AwFRM6cI9s9keGHnLhAxkHvQaaT4KbNM8efS85BS45sS3Rsjlu1cJUDTXzDjvbCJpQBx3oPq5ZAW66b9UmZfVP8ut7TwA9tzuCum3ONtcJzzouWwwfZ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120036; c=relaxed/simple;
	bh=MkLK0qPpYtKZpjcAyMQTkYlFiGwAm7/ThuH7elBveD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQcD4if5GQeQU1fxlxrTddVK+xaTqkW2yzoxjAQSCBzugzx64bIzrsc/3InSQtUlL26JMpLIQTZHubGmJidncROFqxS99+0hEKSxtX9+ZJkLGZMviFSHVJVxC8xfofBJpWRuEhj3PcpncVDEhIft46/HZUTvbTMkvU0BbpSPBIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Nvca4rWi; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b6cdba26639so597555a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1761120032; x=1761724832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vi75g88dnn+ezywzRSA2gvfzEVMFz+4qzKUpyRCo3Yc=;
        b=Nvca4rWi4l7T2gBXo6fdci7yl1kamaS2cn6EJU9UpDSiC2jCfOB74W5WVeFEC1UQY+
         BKiMNuJyaiSrt3gro1ZDbbfzzr0OdLhIGsQodBWv48FzoZzMuHIc4BTVEtBYILpCZiX9
         YTrJXjqXINFRdUm6Y+lkezHIxP724kuK2NvZ/HybqKxVEbiYd1hn59MtT0Zrw0h3CmZb
         piEdGtQIaewqiVFEaSfCY978HX/Ex+pILd5+nUBZURWllYCVA2Ry7O7+qIm6arwM2AdC
         s3ooRvX2bQo9K4C9pQQr4XHw/b9TuSs3/voaMq68aqC1K9M7uIKnoBiEf8sAgJmpsRRb
         tARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120032; x=1761724832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vi75g88dnn+ezywzRSA2gvfzEVMFz+4qzKUpyRCo3Yc=;
        b=KT5olFG66hl2rC081M99On0ZVX8/nQvyWGqs9Y5AHB+Z0AFqtyA/NipNgKta3/G5fx
         p2UIwcdpZVUvtsukSetRPrtOJif/3mvL2y1ev6uuWrBCeUCQTa018iXEWEbf5UUA38a8
         FVwM3E6cEr4o9qW+I1BRVJWfZIFD/okVAgnYuPBOL6wcz0t9tuCUNAndlBZ6m91QuTJ1
         5Cuicl01q74JNncnB/ywpaHKDLHHhQMtnuEhsKbaj7vJWT0aGfuO553byrD2Fh73V8C+
         E0LK4QodrCD5iDCvYqt6hAGtKwGWc/WkmO0rDoPqy3P0ae4k4IxJWXhK5cpbcJNRBUCq
         vR0A==
X-Forwarded-Encrypted: i=1; AJvYcCUTP2nWJIrz3k77pi/SOMasiDF/vcZkGTX2nRctDQczXFe1UHbCHfarP4dqKZJLYXVMm7YIvT3fydkm+SY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhT+zDYZq3wsf9sii37900yMhrC1GRbnDy6EWJ0n6b32gkETir
	90gHJg5iI6iEVPnyGTRWduSVti/snC5tLnuE0hJohvQXfpDkyVt/Kv7gab0cr+kIZcsYya49MnQ
	sCZZb
X-Gm-Gg: ASbGncsFUD+oOFy+6Vse9tW70QUEAxUXeqEq309tjewGP16UkSen//ZJJU9n5BfB0LY
	5xlVaZTPmiOmh1R+ufENbIApRI8km1GcM62ZXlbHbclKR6ibdoRhBkdeqSv5l7zCmwYcwOrTS5N
	O6QmxTTL+HgkaZBA35rLWUqqdA2RSLY7hrIYwmoVpfXgA8y5I3I2r+N6BIEo/X5bQtMzeoKrh7g
	fHoSBIqR3geBV5bo8JQLELAHNNgnfmayKGW+TM5qUVoZd98S/f200ALJsX24ocxFVPT52RQVk37
	NgZRBFOMRi1Y7vixrL3YW41kIv1XN5hz1hj9oZypbODsKXTHsZKPzTsG/R8YUqlBYLDSkAlURo5
	Wr0fTYx+so7RfAgaTBEanxv6LAjlDA/vMDwLwPFPneETbNl+rGYwRbJdp8BvBhIRzZlrunU0y1V
	D5bppMOQgA3NzgdV9AaDewvZnZ8CK7KTiwh2F6Zz92ZSOb8YuicSne0ngDs/LD95Dfs5M4wgdy
X-Google-Smtp-Source: AGHT+IGduvry/wYzrkfuxXUxa8wdplbLIidGYgQBi3n47WTXCWsmsGQK5w2XtRr8wN1GQkSurJM/mw==
X-Received: by 2002:a17:903:245:b0:279:373b:407f with SMTP id d9443c01a7336-2935b50852amr7825425ad.5.1761120032249;
        Wed, 22 Oct 2025 01:00:32 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fdee2sm131384155ad.92.2025.10.22.01.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:00:30 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1vBTlj-00000000Wcc-3XuP;
	Wed, 22 Oct 2025 19:00:27 +1100
Date: Wed, 22 Oct 2025 19:00:27 +1100
From: Dave Chinner <david@fromorbit.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kiryl Shutsemau <kirill@shutemov.name>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
Message-ID: <aPiPG1-VDV7ZV2_F@dread.disaster.area>
References: <20251017141536.577466-1-kirill@shutemov.name>
 <20251019215328.3b529dc78222787226bd4ffe@linux-foundation.org>
 <44ubh4cybuwsb4b6na3m4h3yrjbweiso5pafzgf57a4wgzd235@pgl54elpqgxa>
 <aPgZthYaP7Flda0z@dread.disaster.area>
 <CAHk-=wjaR_v5Gc_SUGkiz39_hiRHb-AEChknoAu9BUrQRSznAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjaR_v5Gc_SUGkiz39_hiRHb-AEChknoAu9BUrQRSznAw@mail.gmail.com>

On Tue, Oct 21, 2025 at 06:25:30PM -1000, Linus Torvalds wrote:
> On Tue, 21 Oct 2025 at 13:39, Dave Chinner <david@fromorbit.com> wrote:
> >
> > > > >   1. Locate a folio in XArray.
> > > > >   2. Obtain a reference on the folio using folio_try_get().
> > > > >   3. If successful, verify that the folio still belongs to
> > > > >      the mapping and has not been truncated or reclaimed.
> >
> > What about if it has been hole-punched?
> 
> The sequence number check should take care of anything like that. Do
> you have any reason to believe it doesn't?

Invalidation doing partial folio zeroing isn't covered by the page
cache delete sequence number.

> Yes, you can get the "before or after or between" behavior, but you
> can get that with perfectly regular reads that take the refcount on
> the page.

Yes, and it is the "in between" behaviour that is the problem here.

Hole punching (and all the other fallocate() operations) are
supposed to be atomic w.r.t. user IO. i.e. you should see either the
non-punched data or the punched data, never a mix of the two. A mix
of the two is a transient data corruption event....

This invalidation race does not exist on XFS, even on this
new fast path.  We protect all buffered reads with the
inode->i_rwsem, so we guarantee they can't race
with fallocate() operations performing invalidations because
fallocate() takes the i_rwsem exclusively. This IO exclusion model
was baked into the XFS locking architecture over 30 years ago.

The problem is the other filesystems don't use this sort of IO
exclusion model (ext4, btrfs, etc) but instead use the page cache
folio locking to only avoid concurrent modification to the same file
range.

Hence they are exposed to this transient state because they rely on
folio locks for arbitrating concurrent access to the page cache and
buffered reads run completely unlocked. i.e. because....

> Reads have never taken the page lock, and have never been serialized that way.

... they are exposed to transient data states in the page cache
during invalidation operations. The i_size checks avoid these
transient states for truncation, but there are no checks that can be
made to avoid them for other sources of invalidation operations.


The mapping->invalidate_lock only prevents page cache instantiation
from occurring, allowing filesystems to create a barrier that
prevents page cache repopulation after invalidation until the
invalidate lock is dropped. This allows them to complete the
fallocate() operation before exposing the result to users.

However, it does not prevent buffered read cache hits racing with
overlapping invalidation operations, and that's the problem I'm
pointing out that this new fast path will still hit, even though it
tries to bounce-buffer it's way around transient states.

So, yes, you are right when you say:

> So the fast case changes absolutely nothing in this respect that I can see.

But that does not make the existing page cache behaviour desirable.
Reading corrupt data faster is still reading corrupt data :/

Really, though, I'm only mentioning this stuff beacuse both the
author of the patch and the reviewer did not seem to know how i_size
is used in this code to avoid truncate races. truncate races are the
simple part of the problem, hole punching is a lot harder to get
right.  If the author hasn't thought about it, it is likely there
are subtle bugs lurking....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

