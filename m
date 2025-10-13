Return-Path: <linux-kernel+bounces-850588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4C0BD33D2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C444189D856
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC188307AEA;
	Mon, 13 Oct 2025 13:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="gVxihb3W"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84FFDDAB
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760362804; cv=none; b=ew9M4y+i3iOM+nhHHxd2ryq4TFJWZDkMtCr20sR+CVOHLBtHzEgvxe6CfgQtDXkRE39C4SLR3himLX8t0Jc3YL+v9xAlbEGYyjuA5F8Ga0LFRaS8MWsqNlPsLYCOhB+JGMWQeldI8fWHKZpahuBrg6HfmGHnKCRacWu14gu0qNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760362804; c=relaxed/simple;
	bh=/SZddqTDHvFmJ8WnuB3yvf2qsI4FrpmT2/XBh1/tvBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qBn7bPhBJu/2NahY701oCDKUT/0VSjmpXEuzYYEzUu7V72V53HPbirWLCwybAmD9/cA8/0629VEFQbrnUyxYqevy7tWV+qELXUP+P9llnIgrVtqOtD41qX76jYaDvvKqDxiuP0cxffJs7ZDfS9/YzkgzqM1/dCrMZQwY/lZKsx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=gVxihb3W; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-85cee530df9so654582885a.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1760362800; x=1760967600; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1ael769XdQAurw6SzkNsrk7kOhVP8THhk7j0vfz4ptc=;
        b=gVxihb3WuQc/kJpkYOGl0AOsfXSpVLzUUHE2GWcVZvBin3Ve2C6Gn/nP9j1TBD233J
         v/jHXBfxDXuCO639N7NKOBDbYZ7c7TeSdfbnC8ityUrzdQTrfRdvTQh0g4eUYrESJ1To
         FFU7gH6eiO3dPCMk96cWm+59atSaqd4ukIMBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760362800; x=1760967600;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ael769XdQAurw6SzkNsrk7kOhVP8THhk7j0vfz4ptc=;
        b=qkB9uPJTWmbNqM3UmObQ1w4RQeyg+82qvVLHgYp4dmj8USBn+TOUqOUoWhTQ3rzaLq
         mGZsV1Ln/2zLripSJLbO+rt5QkyI4x/BnYv4LBiJYgj1PeNrow/e7n1xHUhiqiBkhEOa
         1hVMyWH4/SfgtgzHJXJsz/wjwOgD3WjqRwwID8StCPXob4oyPRF4rx5c3aIwMOYu9021
         dsU/qnI3oH/Cr5MiiNB2wuMu2+Pn1NN36C4+80ta7XniZmp3J05UKEWlm3tQRliR7Lck
         KemyUzZcxT2fv8aH83OMWvu6AETO0bZeD2NU/SyQ+8VJ6h9/vzeVOg0hQA0nfbkIo64h
         /6sA==
X-Forwarded-Encrypted: i=1; AJvYcCU/JyKjERJs8n1u85m3SOTtZftletlFzVIqcJZL2Unta6laFvP5UcWoqcEU8LdBo9RUW47qWoJh6pNFF9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv2/uXWSaMcCOdRJa/G0JzAv1vo6ZhwrwD/6ObPWrCTlzjF+cU
	N0I1a6x0HmHRjGgVaOutT4bQEBJfavANDwNS7y4zB8ecagHwdY/bQo6xX62G191WGwRC+uX9ivf
	5upR9trx+UolRVcR7oODp2xf0wLFg1HBYdQFfi0Og8w==
X-Gm-Gg: ASbGncvZvvQDUfdlvKEa/Fy10YoQCvatSnidlW99seFKfMWIRFS0U+Mccv8C7JbScdw
	O+ZhKb5SYmYnofev5KvXupRuJ6gWPcWTh7jBMtZLP5yznY2J3YP9i74kDY8dijp/Z4vZfY/xvf2
	WbJPOUmGEkB5Z4LsbVqgiTKWNErBks3J9YQgaWQI3T/d230nwl648+SOGkZ8FGhj2S/1rfra4Kw
	CiPyReXjDfGMI63kSNfSOKMLAtBWe1u+V3YCwYQJHPpPNvh/jG77ETTLhA8Zr+jEDMdcw==
X-Google-Smtp-Source: AGHT+IFheY30RzrU3sDF6n44M2PKpielzVq2MlVSYa0x+WyNPbrLyKfpfV8feWHI7+C35UIHXBFmUc53mtCYWL8EtGs=
X-Received: by 2002:a05:622a:1f89:b0:4b3:119b:ce78 with SMTP id
 d75a77b69052e-4e6eacdfa4fmr316471191cf.6.1760362800525; Mon, 13 Oct 2025
 06:40:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009110623.3115511-1-giveme.gulu@gmail.com>
 <CAJnrk1aZ4==a3-uoRhH=qDKA36-FE6GoaKDZB7HX3o9pKdibYA@mail.gmail.com>
 <CAFS-8+VcZn7WZgjV9pHz4c8DYHRdP0on6-er5fm9TZF9RAO0xQ@mail.gmail.com>
 <CAFS-8+V1QU8kCWV1eF3-SZtpQwWAuiSuKzCOwKKnEAjmz+rrmw@mail.gmail.com> <CAJfpegsFCsEgG74bMUH2rb=9-72rMGrHhFjWik2fV4335U0sCw@mail.gmail.com>
In-Reply-To: <CAJfpegsFCsEgG74bMUH2rb=9-72rMGrHhFjWik2fV4335U0sCw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 13 Oct 2025 15:39:48 +0200
X-Gm-Features: AS18NWCT88AfXUeX9IOJh8Hxp7Iccu8BeGHe0mSVwvBE_3NDd8GXl21wXgwKvcY
Message-ID: <CAJfpegs85DzZjzyCNQ+Lh8R2cLDBG=GcMbEfr5PGSS531hxAeA@mail.gmail.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
To: lu gu <giveme.gulu@gmail.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brian Foster <bfoster@redhat.com>, 
	Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Oct 2025 at 10:46, Miklos Szeredi <miklos@szeredi.hu> wrote:

> My idea is to introduce FUSE_I_MTIME_UNSTABLE (which would work
> similarly to FUSE_I_SIZE_UNSTABLE) and when fetching old_mtime, verify
> that it hasn't been invalidated.  If old_mtime is invalid or if
> FUSE_I_MTIME_UNSTABLE signals that a write is in progress, the page
> cache is not invalidated.

[Adding Brian Foster, the author of FUSE_AUTO_INVAL_DATA patches.
Link to complete thread:
https://lore.kernel.org/all/20251009110623.3115511-1-giveme.gulu@gmail.com/#r]

In summary: auto_inval_data invalidates data cache even if the
modification was done in a cache consistent manner (i.e. write
through). This is not generally a consistency problem, because the
backing file and the cache should be in sync.  The exception is when
the writeback to the backing file hasn't yet finished and a getattr()
call triggers invalidation (mtime change could be from a previous
write), and the not yet written data is invalidated and replaced with
stale data.

The proposed fix was to exclude concurrent reads and writes to the same region.

But the real issue here is that mtime changes triggered by this client
should not cause data to be invalidated.  It's not only racy, but it's
fundamentally wrong.  Unfortunately this is hard to do this correctly.
Best I can come up with is that any request that expects mtime to be
modified returns the mtime after the request has completed.

This would be much easier to implement in the fuse server: perform the
"file changed remotely" check when serving a FUSE_GETATTR request and
return a flag indicating whether the data needs to be invalidated or
not.

Thoughts?

Thanks,
Miklos

