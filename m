Return-Path: <linux-kernel+bounces-851177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F64BD5B12
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5224C4ECA07
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9748A2D3EDB;
	Mon, 13 Oct 2025 18:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="hI9HSNrT"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CF126D4D4
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379833; cv=none; b=gxG9Ol5oms7EMkyuP8jp5xbVuWi7RG6OlmRbmIXxBqALCCOX+BGar0nV8r68er9kxFWr8I6hoK8VBCVlolSm8Mi+qXj9QoLEVYMVRyPok2WXI4dBKiDbYW76t3YYMPDsuJUo7dsse16+UtH5RYqV6POY2YRMafGOdGREXMfWJVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379833; c=relaxed/simple;
	bh=oj3ymEY5ytiQnceXg4xjG/to1YEhk7x+D6HZVhrguMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mHV8yEtoAhIDRk4/eg+8vnBQV4vLv6PKqkjAN68gLeuBsWUERvi9r93woAiIMNnz7keCa1zgIuF35q5LCPmKpbK/KcgJsMBTTPBzvrX2+CA8q6m1+Tfo40gAD22oYLIp/RyZvgb6GceulSEyYZHOZWKGOKOtT08rjqlI47Dn9zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=hI9HSNrT; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-7957e2f6ba8so58856026d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1760379831; x=1760984631; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xGzGudAw74SkMnYY/UmMGm8N5SWqgNLK0B2d1FLukKw=;
        b=hI9HSNrT38RxDJ73UvqPoo2ffnFKe3fAn2psM1ejqq63dkhaBf7Nfc/IUaNq2cLiSX
         GI8kI6yJg6L9pxb97X372ssrMA8Ij2ImlfaeRzOD07bgkJfeLxBGXIsCNNcAL/mPNtX6
         BXK7EXhJifEO6NsDV44ItBNJahHb8sofLpSYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760379831; x=1760984631;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xGzGudAw74SkMnYY/UmMGm8N5SWqgNLK0B2d1FLukKw=;
        b=Mf3YOBOxAkKJtE1+RH+otyPzJtpSV62I2p7WiEMXIId0p7c/tCpyf1oM+xS/gBDtiR
         cVOADANAKHup+mQ3olVblKEepdQdXS9axISeOHSnqlAXxAwza5eEGOntspFg4605xgdQ
         s5A23oCTb2FuGs5O0I6P3qIlILxPd5VeI1So4C5m93NQ3kXXOlDflrzcJCPaHCxfbakV
         ySayaPyzCj6y8uB01BNM529o5js9/UHCk042gm93wF4ie8JyEkmYNW1s8HxMAAG+5AWc
         6jvSH8aqTvth5vvlpPEzT8Bgly6jMPBuZ4Fdn+2PpWyMDhPpscB1Y8/TCQk/9l63gz6V
         V+Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUjuCozt/Xm6mKGr1YBmNn0t5AaUUBbmFFhk84EY8dDi5w/IzLLQxZwZqix2zQancUCTbuC2myV8aiPgUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqdE3yBE31oVJrGgMh24qrLQ/YLrRPzMQ9Np8E5uw6tCQXal6/
	xBUnqL4vFzBhDujkq9vXOQN6wFjfqhy4htPplote/w17ueCGRPd8z679LpBnwnjFNwSWADgHTpx
	9BKe3XYq/C4kj4nQ984atxO9ERxuRMF3l6cUEWwomuA==
X-Gm-Gg: ASbGncsCXGNkdF5l5a2E54KY7KEyiqjBoDx85I2ouU0dZd5V8jt4/2oGWdJgcnIFu/X
	n+E/6OYWFjjsgl7hYhpyXK+mxPWDkeRGjv5XkpopwdzWqueHbe9PeQEruL070EziG+OXyYe5lW1
	dziTjXbhu7AJUkCaiZaFsxHljE7evFyUqXXV8KKkWUz0r8FESgtomANr3aksTFrVJ/zGYQ+DafK
	/zNGILYiVc0wLtWeZs9ZtyadO8bZgj5cynIVPiySLvd4Gn02blM9zN+/0b7OTkxanL2LQ==
X-Google-Smtp-Source: AGHT+IGtyJAi0aIbXMlZXRmaD4YedN5oSr1kFc/9MCeuFwFc9dxYNGFtJjQx0gzvRr7c9odz+OcqN5vYrxq28kaovu8=
X-Received: by 2002:a05:6214:21ca:b0:810:e12a:48fd with SMTP id
 6a1803df08f44-87b2104ef39mr334138546d6.7.1760379830919; Mon, 13 Oct 2025
 11:23:50 -0700 (PDT)
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
 <CAJfpegs85DzZjzyCNQ+Lh8R2cLDBG=GcMbEfr5PGSS531hxAeA@mail.gmail.com> <aO06hoYuvDGiCBc7@bfoster>
In-Reply-To: <aO06hoYuvDGiCBc7@bfoster>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 13 Oct 2025 20:23:39 +0200
X-Gm-Features: AS18NWC-pZdrDsA29gb42TTRpRA_B_lB_N06Y7ycMZ61PDW2_vb89CoarPolXmY
Message-ID: <CAJfpegs0eeBNstSc-bj3HYjzvH6T-G+sVra7Ln+U1sXCGYC5-Q@mail.gmail.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
To: Brian Foster <bfoster@redhat.com>
Cc: lu gu <giveme.gulu@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Oct 2025 at 19:40, Brian Foster <bfoster@redhat.com> wrote:

> If I follow the report correctly, we're basically producing an internal
> inconsistency between mtime and cache state that falsely presents as a
> remote change, so one of these attr change checks can race with a write
> in progress and invalidate cache. Do I have that right?

Yes.

>
> But still a few questions..
>
> 1. Do we know where exactly the mtime update comes from? Is it the write
> in progress that updates the file mtime on the backend and creates the
> inconsistency?

It can be a previous write.  A write will set STATX_MTIME in
fi->inval_mask, indicating that the value cached in i_mtime is
invalid.  But the auto_inval code will ignore that and use  cached
mtime to compare against the new value.

We could skip data invalidation if the cached value of mtime is not
valid, but this could easily result in remote changes being missed.

>
> 2. Is it confirmed that auto_inval is the culprit here? It seems logical
> to me, but it can also be disabled dynamically so couldn't hurt to
> confirm that if there's a reproducer.

Yes, reproducer has auto_inval_data turned on (libfuse turns it on by default).

>
> 3. I don't think we should be able to invalidate "dirty" folios like
> this. On a quick look though, it seems we don't mark folios dirty in
> this write path. Is that right?

Correct.

>
> If so, I'm a little curious if that's more of a "no apparent need" thing
> since the writeback occurs right in that path vs. that is an actual
> wrong thing to do for some reason. Hm?

Good question.  I think it's wrong, since dirtying the pages would
allow the witeback code to pick them up, which would be messy.

> Agreed in general. IIUC, this is ultimately a heuristic that isn't
> guaranteed to necessarily get things right for the backing fs. ISTM that
> maybe fuse is trying too hard to handle the distributed case correctly
> where the backing fs should be the one to implement this sort of thing
> through exposed mechanisms. OTOH so long as the heuristic exists we
> should probably at least work to make it internally consistent.

Yes, that's my problem.  How can we fix this without adding too much
complexity and without breaking existing uses?

Thanks,
Miklos

