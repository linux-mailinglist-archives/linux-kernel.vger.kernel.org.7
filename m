Return-Path: <linux-kernel+bounces-852036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2483DBD7FF6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1C4A3B9419
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD0730E0E7;
	Tue, 14 Oct 2025 07:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="F079Hd0Z"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABB52D3218
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760428129; cv=none; b=FpwA8FZsswhH0s5SIfIHYMw4CYZot7YGKHq8AmPNyJYCeq2NrNmExza1w1Vo25Qhc3ZG7P6Bu/17q/9sLHfK7YAdOPO0U9DP/SGBOh/eTHVIbkz52wkwkQq7TocH9KqQQOXJv1PBlTwp7OTeQD32sSzqMaADmjD7lhhlXO5UJ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760428129; c=relaxed/simple;
	bh=zPfak/uLuE6QIa2Kix1FYCn474UeI220vFuuIJA6bBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ekKiFAySOeV0ugHFViNgQyDIHEQgAkmmglrKmCSGy5WO+Ikp6MbdyJ00ksEUZ4V+7Ldj0DrjpC+hLx/rw0jnGOP7Z9Rcg+/sQhO4OZ66VtRpKncxS79ySD3cCQo2yAxbsSeaIyfmd8We1TAeybRjmCzoDpC6lH+rwKOLQDHQmUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=F079Hd0Z; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-855733c47baso977392985a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1760428126; x=1761032926; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BSbg7IxQb2NmRhKX1MyQBOKjUnzdftnCDBYAUuaxwcA=;
        b=F079Hd0ZdgTO0VKMN1pYXagD3ZLMyvWJ1g2Dvv9VHOnGlXexk1t6VjizP5CDo1xpBl
         S0UF8XGNDWkgrj/rTiiEPIFUYwk14+1p0nSstbPk+HLuEdv3ALJ6x92KCNNGAHOBt8ns
         etsg+4RvRgZ28oF3Y/jIayMXwG+Nh0ffBjd+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760428126; x=1761032926;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BSbg7IxQb2NmRhKX1MyQBOKjUnzdftnCDBYAUuaxwcA=;
        b=An0mJBBf08fpMqclZ6YzccQI1bvzsDDW9mv5tuiaraCt7BgtmX/+qB3TxJI/VXeuVa
         wb0vSFnh96uhr06EcqtObSU9Qam+GjH5q96raid5uioLeL1qD+qppr9hhrxviLSH0ilw
         tNFPT0hia5HEo5Nqdk5EOWtMMwvybaFhWQGe74H0sjGgXMDveB9MWdv2WRbmizg9lUMq
         hYqWwRxwkN8/RWQDpqc5LmEUDQsEkm20/JFxhUxWJDzIu9r54hmGgrm6NTB0/kD9t7Xm
         r7FAnAasF90Y5xxHq/UCd7PLV0yUVMa8MZtNx2o49suAA9JVIkKxKoHlP9t9hbja7hET
         4bYg==
X-Forwarded-Encrypted: i=1; AJvYcCV7Bi6i9MRbSQ8egb/fuoyEACGr62hxAcCoGeURnacZso0Lo8ZqyptLlY1LSbdl1daCK7jhcV0u7dviblw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz37As3jmi1P3y8XoLoPqxc9QCdWwl1powFZx4eNgGwfvSVTNws
	+G/kgWE+r40PhGI24A/AZQsyZA0i0ue1UBKFTtEliVYK7n24Bi/xGNaztcnKcMEjZgQgfGWDRsg
	vo/XEbnw6/20QOZ+OHnEz4k7a6TE+3BHziWZ4fG2/OjLveY/n8W7c0dQ=
X-Gm-Gg: ASbGncvilg6fxKNj8ZqvOwxaAr3Kd8dRU9BelnHkt5jzh/z8AuhPng8wDdGiYdMyOOm
	HYhkKgoZCzIHmfQuJcV8J357XyhwCu/shGAmtIl/SV+UZITXNzdMfiKpCu1npfsvKe62aLUBgW+
	xeneVNeXJ7BpsSCupJNkowa1zaAW53su6NI2aZND98cxc3LfY7DOIKjTfo+PtZhInVngBgv0uqo
	Fha2WY8WWPj6kHd0bc6AV/vGRPrm+n1agFR86d2sXyI07t82JaTSmKEusL6mcZiamzO7g==
X-Google-Smtp-Source: AGHT+IGvncMdJBcaFFlcJKGNDdS3S6WpUqvcLztZPqtXvHeu0D5NWwCna3KyK4CVJzrme0al0MWNsayaUn1S8sAsCrY=
X-Received: by 2002:a05:620a:394d:b0:85b:8a42:eff9 with SMTP id
 af79cd13be357-883525c0d7amr3079631585a.53.1760428125643; Tue, 14 Oct 2025
 00:48:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009110623.3115511-1-giveme.gulu@gmail.com>
 <CAJnrk1aZ4==a3-uoRhH=qDKA36-FE6GoaKDZB7HX3o9pKdibYA@mail.gmail.com>
 <CAFS-8+VcZn7WZgjV9pHz4c8DYHRdP0on6-er5fm9TZF9RAO0xQ@mail.gmail.com>
 <CAFS-8+V1QU8kCWV1eF3-SZtpQwWAuiSuKzCOwKKnEAjmz+rrmw@mail.gmail.com>
 <CAJfpegsFCsEgG74bMUH2rb=9-72rMGrHhFjWik2fV4335U0sCw@mail.gmail.com>
 <CAJfpegs85DzZjzyCNQ+Lh8R2cLDBG=GcMbEfr5PGSS531hxAeA@mail.gmail.com>
 <aO06hoYuvDGiCBc7@bfoster> <CAJfpegs0eeBNstSc-bj3HYjzvH6T-G+sVra7Ln+U1sXCGYC5-Q@mail.gmail.com>
 <aO1Klyk0OWx_UFpz@bfoster>
In-Reply-To: <aO1Klyk0OWx_UFpz@bfoster>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 14 Oct 2025 09:48:34 +0200
X-Gm-Features: AS18NWBf3ks7a6dxyjB1ace7scEWFB77UTP0wHqY44cLPDV1w5ckKEDyJMj02IQ
Message-ID: <CAJfpeguoN5m4QVnwHPfyoq7=_BMRkWTBWZmY8iy7jMgF_h3uhA@mail.gmail.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
To: Brian Foster <bfoster@redhat.com>
Cc: lu gu <giveme.gulu@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Oct 2025 at 20:49, Brian Foster <bfoster@redhat.com> wrote:

> Hrm Ok. But even if we did miss remote changes, whose to say we can even
> resolve that correctly from the kernel anyways..?

No, I'm worrying about the case of

- range1 cached locally,
- range1 changed remotely (mtime changed)
- range2 changed locally (mtime changed, cached mtime invalidated)
- range1 read locally

That last one will update mtime in cache, see that old cached mtime is
stale and happily read the stale data.

What we currently have is more correct in the sense that it will
invalidate data on any mtime change, be it of local or remote origin.

> > Yes, reproducer has auto_inval_data turned on (libfuse turns it on by default).
> >
>
> I was more wondering if the problem goes away if it were disabled..

I haven't tried, @guangming?

> Ah, yeah that makes sense. Though invalidate waits on writeback. Any
> reason this path couldn't skip the dirty state but mark the pages as
> under writeback across the op?

Maybe that'd work.  It *is* under writeback after all.

Maybe the solution is to change the write-through to regular cached
write + fsync range?  That could even be a complexity reduction.

Thanks,
Miklos

