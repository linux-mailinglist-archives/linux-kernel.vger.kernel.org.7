Return-Path: <linux-kernel+bounces-813764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B66FB54A6E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F016E1885E76
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315922FD1DA;
	Fri, 12 Sep 2025 10:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1CS5N4k"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7C0257827
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757674377; cv=none; b=rpdqTMBQvc/6si+ODHPf3+oSb+RajEKkGOLFV6CHMK7drRcYR3rzx3bsYypS8qhoarObPQrEAR5qCdJdKIQ+8sAtZZXPdMHw6pr+O8Sj5TUCFeLfR0t7WOMrwKDRm8tZE7aH44RJILeowBveUOlpkMhpfpU45L1vBOwYiSXtOZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757674377; c=relaxed/simple;
	bh=IYJyISY7tMgZaqYQM0sv/AY/Ksbiy70hXgdkc7LLAQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KeAE7Nshp+/Qyen96KJc0WnAgHghf+GmwkOub1deMzzBj0H970vUH6kYYwqFXSwWoNBk8Ei1ksDLg3lAmAHdeN6EbTNRin8j/SmpOfO5XRfN4fUrcj5drBhtQTJ/t7PCrHm8YJl673UiPxqoV15TofKG9ZDZx9nDKufEOi4GWfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1CS5N4k; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3dcce361897so1231859f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757674374; x=1758279174; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1S29IK27tvLbwH90GVH1O/PVAm4A4OJpS41gFvWUg6U=;
        b=H1CS5N4kFFMR4y4I6AKLor2vfLS4+cRL8Hot5aezXUflXXjSOHLpoX8GgHXMrW/UW5
         Hd+J8vuzYkqgwDeaQ/T+VX+Pelb8lh6bQu/ODbChWzM9qvvOU6z4Vk/6jJ1JeyQGLgYj
         mt6h9GEiUNYBwwT+q/mia5kf2F3Y9qvRwIjqwsJQdr9x3kvr2WFySJSo3CD58uqUoTFL
         wf7Zi7Fvw97UDMprM3qw7hbkr7iKizdKOwF7otZGCJw8lg0COwax0qwWrvHZi2FCdEa4
         PSsbEwktn+aYKSPM7TzoF29JKPpB9Qko/EWebPaoDiYDN6IwiGvJcsH/8xrLWHYxW4AM
         p2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757674374; x=1758279174;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1S29IK27tvLbwH90GVH1O/PVAm4A4OJpS41gFvWUg6U=;
        b=BbMYGHC93NB/W/rLj9cqWrbgAgorOPaVnuzDuhGNhdjlSJjr+fTktPL08DXp4ipp0A
         4X8K+Bi5PK5n5b+dtGcoXECeULUc/b63fY8kP9jxjedZfRJwB5/B7jF7aHtB7i5bhbiz
         A64YVvNWKGDTr/FQJXjLVvCqVYJDy1nbEZ4bQWzn9FxhaHG9gIVUybLeIo+KfCAHyPOB
         Lx128Mh4v5iRI9JZTArLsQxVOpDPTfVLZA8dD6bHsx27fiGrZlufFwPaJlhgWaFwBFSp
         2aq5e3GEiYQ7+PZPNhgKofNslRmctgqZ6pvRZdWJwq8fainhir0675qxFgxM+0MkP0pU
         7AdA==
X-Forwarded-Encrypted: i=1; AJvYcCXpPD85en0jCIn7h1/+IZ15gbv6eEUlGb1n2/zXAy4nRcDub9BAUTeqm5RWQEHMKune5qpnVCp7/XIlyDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKsGkTnkWr7ys3KwPu9f4KPh1TE3UakfN7ZyPR7EJ+EI4b+76y
	WsQpEHdsWVfF+JvKWdnjQXGJwsFJEfgjUS3FGkFx1QGlHhcXUNKppjT3
X-Gm-Gg: ASbGncuGI5L/3wjaov+N1JLxvh6sYt0NAYDV0thP4OYVZk/FCMJBnnZ0lvbcN/o8SrF
	f+qtvM4UVVZDdE+G4gHwZj47DLRWbYxM0hBXzhNaG1fXkCMVoM0ZDPUJBsXxjtHaHbHW02Tz2Im
	2Q21k1hmx44FghjIWjkdwSVVyKsd1csIQUtDAZUC99tg8elZCrwLZBZ0I33vZG+ecz1ignGjGES
	gRZpwVxqxER7W11KHjs6KuDzaWEjzXmJDCbB5vROjGIeBdhqcS66SAsOdjIlczWtA3E2EcKdPZU
	mhTXnO9z65/RBD5j4VnS0Ml/aXF/J3PT+oqrgGjYNqaEtYx7HGoqQPrpjSpF4TKYgqXvYLIaSc6
	wMs0Jl9BcyuGqqsSsE+RH8l8k2xkXsDGpGvC/lA==
X-Google-Smtp-Source: AGHT+IHKIxSqLjisSEAZCL3MgYJBWWQLMULmTpoAMEA3vgmwbnbaVLhvHvX9Jz1tbqtWEw2s1ZyCnQ==
X-Received: by 2002:a05:6000:228a:b0:3a4:d6ed:8df8 with SMTP id ffacd0b85a97d-3e7659e7a52mr2326013f8f.39.1757674373954;
        Fri, 12 Sep 2025 03:52:53 -0700 (PDT)
Received: from devbig569.cln6.facebook.com ([2a03:2880:31ff:5::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd27dsm5993202f8f.41.2025.09.12.03.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:52:53 -0700 (PDT)
Date: Fri, 12 Sep 2025 03:52:51 -0700
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
Message-ID: <aMP7g7ts8n2Gubql@devbig569.cln6.facebook.com>
References: <20250909234942.1104356-1-surenb@google.com>
 <20cafc1c.a658.199394de44e.Coremail.00107082@163.com>
 <aMLvCCZbmpSE/aql@devbig569.cln6.facebook.com>
 <902f5f32-2f03-4230-aab0-a886fd8e4793@gmail.com>
 <20250911143132.ca88948c48df874f71983218@linux-foundation.org>
 <CAJuCfpEoWtgv8k4vApkGsNNUYFBnvS-N2DPQu2JrreCUPbT5dA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpEoWtgv8k4vApkGsNNUYFBnvS-N2DPQu2JrreCUPbT5dA@mail.gmail.com>

On Thu, Sep 11, 2025 at 05:25:12PM -0700, Suren Baghdasaryan wrote:
> On Thu, Sep 11, 2025 at 2:31 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Thu, 11 Sep 2025 12:00:23 -0400 Usama Arif <usamaarif642@gmail.com> wrote:
> >
> > > > I think simply adding * to the end of function name or filename is sufficient
> > > > as they are already str.
> > > >
> > >
> > > Instead of:
> > >
> > > 49152*      48* arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_create
> > >
> > > Could we do something like:
> > >
> > > 49152      48 arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_create(inaccurate)
> >
> > Can we add another row, saying "the previous row was inaccurate"?  I
> > guess that would break parsers also.
> >
> >
> >
> > I don't know if this was by design, but the present format does provide
> > extensibility.  It is basically
> >
> >         NNNN NNN name:value name:value
> >
> > one could arguably append a third name:value and hope that authors of
> > existing parsers figured this out.
> 
> Actually that sounds like the best idea so far. Currently the format is:
> 
> <bytes> <count> <file>:<line> [<module>] func:<function>
> 
> We can adopt a rule that after this, the line can contain additional
> key:value pairs. In that case for inaccurate lines we can add:
> 
> 49152      48 arch/x86/kernel/cpu/mce/core.c:2709
> func:mce_device_create accurate:no
> 
> In the future we can append more key:value pairs if we need them.
> Parsers which don't know how to parse a new key can simply ignore
> them.
> 
> Does that sound good to everyone?

Yeah I agree on this proposal. We can keep this convention.

> 
> >
> >
> > Whatev.  I'll drop this version from mm.git.

