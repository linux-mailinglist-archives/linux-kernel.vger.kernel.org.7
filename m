Return-Path: <linux-kernel+bounces-817625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CF6B584A5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8504D1A27706
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2948279788;
	Mon, 15 Sep 2025 18:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjM4ykUw"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5064C1DED52
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757961083; cv=none; b=lor5EXIWdnAlrVVuZ10BShfEu8R9rpncS2nEIhWnmZiGjjCnHqNKpmDTKdzy5eGzShL28/pES8Lacn2xOE5JHwP0LrX2+N7o4IeEKnUn+olp3Wq8azmqyEHH302egUXZZj4wLkWbljuYDcV1fIeKQT8QnNUMa4Tf7mHTn0dBhE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757961083; c=relaxed/simple;
	bh=R4rYTeNbWd9DXYY0+8EBMyejUZmSzQpmZZq50ukQWWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJGHmdBw2JFjLQ2fpr6wiDJ8cZ+GTuvdXTA/3u4AEf7xGYTbMYPOPWfPvyYAQPmWHoYf/0WD9bOa3APjeXvhSINY61R5nAYKqDeorhQx8VL2pZt1xIaVOZWRIzTAS9NJQCRyWBbMNAMgr1s5VHQ+3K5bbhF8/JY/w4AR+igEUCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjM4ykUw; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso33478245e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757961079; x=1758565879; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p71UH1Nz4vAWpVd3QQTKqUa33PkUmJwyPvAlZiO7WkQ=;
        b=kjM4ykUwG+exyi3XEDEWuvbDYaUys4jRfTF5g9UVf8ZL65GXlh+TsOirGwO9qVbJgF
         m0YHunzcKeV+sRJY8lZH+om8I195KJKs3Y4SrYgJfd4XmQgMqin+lBr698pXNa/PZEX9
         tiW/tysK6sYSlb+ce1OJ8FLiZJv0pJTkzF9dj6NMV9nkRynkh2xq6ShDFphr/gaU/3D0
         ZjVGoTOrAm1dvVNRkM56DsaOWrOOxfNIWo8E+KYmfm+DwkZaYhk/diUT9bw9OVjlIOsq
         ZLxNAbfkpE1y+aOoVuzKJ15xdNR0Q8i632Z279HQVntlc/et8dh1Fd6ncselFe8XWSWR
         9+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757961079; x=1758565879;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p71UH1Nz4vAWpVd3QQTKqUa33PkUmJwyPvAlZiO7WkQ=;
        b=DLi5Js82Kz5tcLcgKM9SdUq2L8LU0HQRs0c34IGMGwrjpo5mUT2Rn28KIn6n4287bq
         jHvLJYtx3K27hPaJaOnosHYyCSbOu+A1zkAMTy3FUvIjP8UvyhXUyj2ZvFcVo6fkhaZw
         35z2PbE409Vx7tO3HC6RkPLsak3jwDEzOfbBwUoJ83hZADCbEDSBgHdihJ+TL96U1muS
         hEdBCkaMqwgBRGuuE5ks0nCWAWsX3UNXSgyKfcSB025Qf0u4AyTRvkwVrxD0LrTglJuI
         40/CP20CPnYp5Otxno4Vn4hVabb1klajWt1eTV/gF6mnHiG6T1rCH7uFYQ+ml1aKq7Ym
         Gp7A==
X-Forwarded-Encrypted: i=1; AJvYcCVh+NBQAiiRsJ2PiuGxd0N9KuDeeGiPHOisYixhgXvL9/undMjJYzVDein/tyPpUu9Mm+Q/DIXs/HgiBKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGbHaQ2MheE372Ulq95KdmB8Ml5RFY47C6mFO4TQl9rHAjG2eO
	wcpoHQy6qwTEwSXCh26syBkQUu34iJq/tL1SRxZl8E6hjPxOnPQL8O+F
X-Gm-Gg: ASbGncsWjKw7gFpPBBWdcJyzy159IZaxY7fSuYuEbvPeD5Bt3MTbk5+uZjBBSudy37g
	ST62B4yyQTVkchhdHXvAo/qEI41HlhQb8gFbdrxUQGZF3sauMCZ+NGV5/S67LZSkuhTSawG8BLX
	B2atk+SFTl+b/OFeD1gmH6ftBgE3MEVxh92NDOodqmNLXiyon3St/J8BvkyDJUEOGcfCEQfEYRE
	CRdVpyV1aFDc6Ry5A8aXPYjlgxOa8jHf8uzVxrp6HJWUGUfsHoWtxtkV7UdIKRyCm03t9GXElX4
	riZor5d47y4fFE32+6xXK4MOcsHGnsc4E598R1yqDWLAzfG8raBEOP5KHbQes3Vx7w/rjEigg8C
	oKfEUM36RLZHK2AUyyFJXB/0LieXzNuorDhP14gjsPVgcP1VczTy8FFbJYSo=
X-Google-Smtp-Source: AGHT+IFpiqSwtwVakQgiIGNOpIio8KWCT1PA9Z3Xvc9kv/KXoN45p2qT5yH0IIvazHro5uQKAPWE5w==
X-Received: by 2002:a05:6000:2891:b0:3d1:8d1e:8e9 with SMTP id ffacd0b85a97d-3e765a130a2mr8789630f8f.32.1757961079282;
        Mon, 15 Sep 2025 11:31:19 -0700 (PDT)
Received: from Yueyangs-MacBook-Pro.local ([2001:620:618:5c0:2:80b3:0:8d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e95b111b68sm8881241f8f.32.2025.09.15.11.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 11:31:18 -0700 (PDT)
Date: Mon, 15 Sep 2025 20:31:16 +0200
From: Yueyang Pan <pyyjason@gmail.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>, David Wang <00107082@163.com>,
	kent.overstreet@linux.dev, vbabka@suse.cz, hannes@cmpxchg.org,
	rientjes@google.com, roman.gushchin@linux.dev, harry.yoo@oracle.com,
	shakeel.butt@linux.dev, pasha.tatashin@soleen.com,
	souravpanda@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] alloc_tag: mark inaccurate allocation counters in
 /proc/allocinfo output
Message-ID: <aMhbdAA-o7UE6bYw@Yueyangs-MacBook-Pro.local>
References: <20250909234942.1104356-1-surenb@google.com>
 <20cafc1c.a658.199394de44e.Coremail.00107082@163.com>
 <aMLvCCZbmpSE/aql@devbig569.cln6.facebook.com>
 <902f5f32-2f03-4230-aab0-a886fd8e4793@gmail.com>
 <20250911143132.ca88948c48df874f71983218@linux-foundation.org>
 <CAJuCfpEoWtgv8k4vApkGsNNUYFBnvS-N2DPQu2JrreCUPbT5dA@mail.gmail.com>
 <aMP7g7ts8n2Gubql@devbig569.cln6.facebook.com>
 <CAJuCfpEy7kQdDzU9GR6T=nz7HB6EnSkfx3vXmTBEuvJPqhxyfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpEy7kQdDzU9GR6T=nz7HB6EnSkfx3vXmTBEuvJPqhxyfQ@mail.gmail.com>

On Fri, Sep 12, 2025 at 12:38:01PM -0700, Suren Baghdasaryan wrote:
> On Fri, Sep 12, 2025 at 3:52 AM Yueyang Pan <pyyjason@gmail.com> wrote:
> >
> > On Thu, Sep 11, 2025 at 05:25:12PM -0700, Suren Baghdasaryan wrote:
> > > On Thu, Sep 11, 2025 at 2:31 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > >
> > > > On Thu, 11 Sep 2025 12:00:23 -0400 Usama Arif <usamaarif642@gmail.com> wrote:
> > > >
> > > > > > I think simply adding * to the end of function name or filename is sufficient
> > > > > > as they are already str.
> > > > > >
> > > > >
> > > > > Instead of:
> > > > >
> > > > > 49152*      48* arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_create
> > > > >
> > > > > Could we do something like:
> > > > >
> > > > > 49152      48 arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_create(inaccurate)
> > > >
> > > > Can we add another row, saying "the previous row was inaccurate"?  I
> > > > guess that would break parsers also.
> > > >
> > > >
> > > >
> > > > I don't know if this was by design, but the present format does provide
> > > > extensibility.  It is basically
> > > >
> > > >         NNNN NNN name:value name:value
> > > >
> > > > one could arguably append a third name:value and hope that authors of
> > > > existing parsers figured this out.
> > >
> > > Actually that sounds like the best idea so far. Currently the format is:
> > >
> > > <bytes> <count> <file>:<line> [<module>] func:<function>
> > >
> > > We can adopt a rule that after this, the line can contain additional
> > > key:value pairs. In that case for inaccurate lines we can add:
> > >
> > > 49152      48 arch/x86/kernel/cpu/mce/core.c:2709
> > > func:mce_device_create accurate:no
> > >
> > > In the future we can append more key:value pairs if we need them.
> > > Parsers which don't know how to parse a new key can simply ignore
> > > them.
> > >
> > > Does that sound good to everyone?
> >
> > Yeah I agree on this proposal. We can keep this convention.
> 
> Ok, if no further objections I'll post the next version and will
> document that v2 allows additional key:value pairs in each line.
> Thanks,
> Suren.
> 

Agree on this.

> >
> > >
> > > >
> > > >
> > > > Whatev.  I'll drop this version from mm.git.

Thanks
Pan

