Return-Path: <linux-kernel+bounces-743396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B01B0FE35
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 02:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8C065851D3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E44219E0;
	Thu, 24 Jul 2025 00:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Wc+gaWEN"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7FEB672
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 00:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753317490; cv=none; b=uewGgbe8X5wZhxkHo1DrC6EYwlGJdapzlKfM8RECkdiiioYy7MinzbWr+ahbdEpUyiE3vx1cjS3Q4s2B+BPp/HSZj0IOI0C8HseBjFZGbycEeUMzJASxg1a50/HUyq2nblGjSlImyhOEpGb1ywyf+2sFizSSuOI9HecjSxURGYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753317490; c=relaxed/simple;
	bh=Gxi4m+vj/J+R8ohyx/BksdJ9xrrB6h7LidiD3KtpEUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SKzQa79AY8c8W/ndkESjY22XGBX4DUP7ElMk7nUklfGIc2jfP31QYSCKRGgwe77UTa2ui4TYH/IRQ2VHxRVLrzoGuOtj0G/wnzFr8AxiCSBva62cUbPt3rVTgupDR7Psvk8g+1QsQFYpDE/Ta8aDv88cmYYAvPgegUp3xUw9MTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Wc+gaWEN; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-313756c602fso69660a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 17:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1753317488; x=1753922288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVzlr0W1TivM5rykoDGW/szIU5hwSlOTrrmV8HajOPk=;
        b=Wc+gaWEN4RZ49G3K2lcJLue4m1dnaY1dWbplrBWrbyVO61XsB3bkHpxnaKG3Id5UQH
         xqABBM+JGkJh8tCIPO7DkGbbgh+zfnwsnKk21H1M6opK7TChLg21guNIhNDpAnxdDEIp
         prIzTkD6IR7hHimrUoYwTPd+3ZUPsqGcCDDHFMcFXgeYq1UN03XzAFdbIPznLX4g545n
         XJraLlWOPKhesYU1di3FWUbV6ClAYQuaZM3mZZ5UDRPY+PvycbDzwaTtB2r5GLSo8ES7
         PbXWjk/Li0GhGnmPNq62IfHA9sPPMBp/pOHoPEjNRuOCAlXclXtaFKISSAcFA5a8APx6
         uTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753317488; x=1753922288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVzlr0W1TivM5rykoDGW/szIU5hwSlOTrrmV8HajOPk=;
        b=W9fcyx/3XSnTD2Qc4PkKS1r1SuHHCFOEVNI5nxeFV8NdyLHnXYIq96X0Od0rQOxqdj
         i4PoBJgcYV4ShAcVlziWm3GpHq2Xa8oyWFhbPaP1nHNEcTclw4BgnDANTYlTXnvJXEFy
         Ln51ncN7pxtFeiMkygRds9DvZwNcGjLIskqyRN7VixPAU39CcpUtcMVjxgUQt/1OJUT7
         uQjWmh7gFxMksYxy56iG1/rxNMD6UX63Jum7FIVITJJr4NhskihR9yQhi9jVouiPCgUJ
         BLrSih86R4ejsLd7kv5TE8YlzaF8kUsfqAQqrJUzpmtBJiPGTGdXKPiuGKm5cYu4dthq
         4pMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvSUM6eHXez3E6QVmX8bdjF5xIxa4HPnbcRdZDzEIXWLgeYxzFxdN53lxJgh/f6vz1NeE3r6rng0S0jJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2zVSMW5FVjKRFuB0CCsnGwf7xjPDDxOHt2GFo+lfQTHbbnUMB
	RvqeknzDlMT9oO9Y4Rkaym3Tfa859JeYaaMjWE1B2rt0OhFvTln3KToa4tLpT7dZ9alxEsq3I/e
	Ewg6KugScgS22iOvr3lNvLSH11cHfvb/TLJnN/UJCyg==
X-Gm-Gg: ASbGncsl47CYa3faLcLCAfiTsPYmXD0Y65Tk8XnCz65WeTMW8dpg37KZXifOsyd47kL
	ZFIAX2uZDEGk5VOTZSeFW4c9rMj1xAsVGWKxSQEtyy0xM0AH+2WuE7H6oHXJViC7YEz13czY9tg
	LsvqT0X75/hN3mGtN7OtPqUAclpVl1Wn/dQd9oPl81pec78fmAp1UelJqodpsJvSYGiED/sJ/1X
	0ddjNxlh0I5aSk7DRI=
X-Google-Smtp-Source: AGHT+IH4VTNJrurz6Qk0XlK+5MoFyD1kgLcpcng5VkI23KoPcgTNi8H+hvLg2MhXAytRFMo4TVGnDbgexwbZuZL+CIo=
X-Received: by 2002:a17:90b:4b52:b0:311:c5d9:2c8b with SMTP id
 98e67ed59e1d1-31e5082c398mr3391035a91.5.1753317487789; Wed, 23 Jul 2025
 17:38:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711002322.1303421-1-cachen@purestorage.com>
 <CALCePG3a6wG+3Nu7-JHha+LMtyRRNF3sXp13sS-=Xv1pvsX09Q@mail.gmail.com> <2272d95.4512.197f7b1354f.Coremail.00107082@163.com>
In-Reply-To: <2272d95.4512.197f7b1354f.Coremail.00107082@163.com>
From: Casey Chen <cachen@purestorage.com>
Date: Wed, 23 Jul 2025 17:37:56 -0700
X-Gm-Features: Ac12FXz6YP-uwsEzBgKW14HU9FxDMDgMIWxUuN9SFGhPeADgC7PX8sOXbrv3-gw
Message-ID: <CALCePG0Q8vAEzP+5ASzY-ytnN_eph8F=-F3MQya5MaYcwMNMBg@mail.gmail.com>
Subject: Re: [PATCH v3] alloc_tag: add per-NUMA node stats
To: David Wang <00107082@163.com>
Cc: akpm@linux-foundation.org, surenb@google.com, kent.overstreet@linux.dev, 
	corbet@lwn.net, dennis@kernel.org, tj@kernel.org, cl@gentwo.org, 
	vbabka@suse.cz, mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, 
	ziy@nvidia.com, rientjes@google.com, roman.gushchin@linux.dev, 
	harry.yoo@oracle.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, yzhong@purestorage.com, souravpanda@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks David.
The calling site doesn't detect NUMA imbalance by itself. We know its
imbalance from per-NUMA stats. I would think a software developer
makes global memory scheme based on information provided by per-NUMA
stats. For example, the system has several major consumers of memory,
most of them request memory from NUMA node 0, leading to imbalance. By
detecting the imbalance, we let some of them request memory from NUMA
node 1, by hard-coding.

"What if the numa nodes usage are almost balanced globally, but
strangely unbalance locally for some calling site."
I didn't see such an issue so I have no idea about this.

I wonder if Sourav Panda or David Rientjes could provide us with some
examples. Thanks

On Thu, Jul 10, 2025 at 9:16=E2=80=AFPM David Wang <00107082@163.com> wrote=
:
>
>
> At 2025-07-11 08:42:05, "Casey Chen" <cachen@purestorage.com> wrote:
> >Hi All,
> >
> >Thanks for reviewing my previous patches. I am replying some comments
> >in our previous discussion
> >https://lore.kernel.org/all/CAJuCfpHhSUhxer-6MP3503w6520YLfgBTGp7Q9Qm9kg=
N4TNsfw@mail.gmail.com/T/#u
> >
> >Most people care about the motivations and usages of this feature.
> >Internally, we used to have systems having asymmetric memory to NUMA
> >nodes. Node 0 uses a lot of memory but node 1 is pretty empty.
> >Requests to allocate memory on node 0 always fail. With this patch, we
> >can find the imbalance and optimize the memory usage. Also, David
> >Rientjes and Sourav Panda provide their scenarios in which this patch
> >would be very useful. It is easy to turn on an off so I think it is
> >nice to have, enabling more scenarios in the future.
> >
> >Andrew / Kent,
> >* I agree with Kent on using for_each_possible_cpu rather than
> >for_each_online_cpu, considering CPU online/offline.
> >* When failing to allocate counters for in-kernel alloc_tag, panic()
> >is better than WARN(), eventually the kernel would panic at invalid
> >memory access.
> >* percpu stats would bloat data structures quite a bit.
> >
> >David Wang,
> >I don't really understand what is 'granularity of calling sites'. If
> >NUMA imbalance is found, the calling site could request memory
> >allocation from different nodes. Other factors can affect NUMA
> >balance, those information can be implemented in a different patch.
>
> I think my concern mostly due to my lack of knowledge and experience of N=
UMA,
> but I still wondering what action to take when " the calling site could r=
equest memory
> allocation from different nodes", does the calling site needs to detect n=
uma unbalance at runtime
>  or it should change to hard coded numa node?
>
> By 'granularity of calling sites', i meant to emphasize that information =
is local per calling site,
> not global.  What if the numa nodes usage are almost balanced globally, b=
ut strangely unbalance locally for some calling site.
>
> "what adjustment the calling site would make to solve numa unbalance" is =
the *big* question to me
>
> Thanks
> David
>
> >
> >Thanks,
> >Casey
> >

