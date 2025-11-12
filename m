Return-Path: <linux-kernel+bounces-896788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 566CEC513ED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D8383B75FD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6712FD1D9;
	Wed, 12 Nov 2025 08:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGDX5P/C"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC462FD69C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937583; cv=none; b=FIxiOgxNmLzM+Al0+h5JwIrQxxMZyhvMIpNnl855lGZ+7IwWr495Akqw4uSKjkUZxaJcfir1RcttqcziwszIG1/+myhWLhia4G7Uc3XQ86kamo2la1h1FCBI4KZNKveR0JScnKamhhCR1bK/hmyVebWko5jEPRw3zxZjFy2RgNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937583; c=relaxed/simple;
	bh=3Gm4wbPKVKBAfpB1AD9Bxh2A+O6wSR6WjTb9veNJhP8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZicojMTq6UV1wAZayGU00R6AjH+9Sm0n3j+6LcfDgbPjb1oAR8Ss1KUupZDh73Sgc3UOw0FAAMYqFPV3prnKSbyRJtnSR0rbnJFBUudoz6ERDrlaWIWPdkCx3aNBFORmeb27HooBzbaLnoEhaxbv1/w+9bXQYSkZoR/qQmHQD+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGDX5P/C; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7afc154e411so369233b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 00:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762937581; x=1763542381; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ezHl29JJ257PYLhUUv6D8vVZx3H5wVWhTdhSBo2FgQI=;
        b=dGDX5P/CRxURWbA4PrfoEzcFkhYvNnApHO0bZIIPtxhJ2jFaDlKXZkdR8cs6PeboXM
         /0n82QpOlLQ0cc68Wrx8GkHlkguXb9wFfABNP8iSRpsscFnVhCzmxsFbDE7+zstCR2DM
         lQ+DZYQXsa2SAHfLelr8jW1rkWEtjzN0SQDMXNE+2h97QSB5QfmEd7UlcE2TUNaab5Qn
         U+DFC6dYjdqVjLkEyGCb04rJxWkL1YoVU73OBqzwX4O6Q+iKSaDmVGhUsV2h2u+MImIN
         888eQVOpwVKrUzVHaWX5/uLLBmgTbPfSOl6sfyqmoeLgDO37Zi6oOHeGENZ3UMo7AIRk
         LGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762937581; x=1763542381;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezHl29JJ257PYLhUUv6D8vVZx3H5wVWhTdhSBo2FgQI=;
        b=Bw5q88dhaxWhMKdRT0BNlUtMPYIBSwH0TXl805SCSDB3U5Ch9CTD0yRVf2TZe1DoFV
         maO4C/5ZpOYi5DUIyNR5x+Tv0oGQMOqnC+DbgdtDKhYhQwak6oiewPsd9NrB2yQcHF8J
         24t7ZZXrDvWnpbbXVU8xnnnKeqVWclLLeA81CeLwUwtPKcBaxaWiubpR2TOvlSZQ6RmO
         ILi3g4G0ZHVwIIvEe/0Prit9OAGZTVop4DjlYySjNAdEkShPXrfAkKcQX4xO1r+y861u
         9VxCSDY27o+ZjBCbryj4yMbHaVaDVgNpwy3cPbaigLS+P6X5TnamcLHkQpup++RwtWD6
         7dmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSfYqxTPk1qe/IRKLCX4X39fLF59iNdxwaZqSVM8+a+pNd+/7iGKcQPSdBuJBXCLzzDx3vtwNSBlEupdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjWJsXN4wRrahARJ5t0NFIpl0K0mP6GT4KHxKpeTnSFbZt8RL7
	NTCJv5wGg/nQhfHqTz2O6ooIz2msOsYA3/UUWwoxxHbP6IbwRw4wu5nP
X-Gm-Gg: ASbGncstMiMLxjRTONNjO0/v3u098m3NLuCAYedFFvOLh2LAgyyj7RQKV66S514+R13
	b5GGYQc9uhl7eaJ06woZk9ZIRHUdbvQAY1lT+rF2pQMT+EkAOq+eUMiw6QZt6D12fUc2SR4VAt1
	9PGcnlGAOtOybXQ7OXWljmcobkJTit8wwf9fvwQGS0bwE4Kqow1LVG01IxVRNAyjPUCfzeqeHmH
	dzInXE/2ioGUzZTcGUfBW5ffRondvKC7v/NNhodUhOrEHW+2gfKdAHq8LFavdGOlHFHiZf/krWZ
	tizaz83Nly8Ysmtt/8KaqJDkr4oKUHx41tncgK2lsBPQp0d3Id2UOlC5GJBvbqO0voo9yZX6CV8
	Xo5iRsL1SCh+Zp000nc8q7x9R5lO9064jEfbeqao38vl69APT4DGNtiWRAAATMG15dwWicWTgkk
	XTBogdFVePk2aZvXVDF/H9YqXPJ3Qpp11IfUMNFmT4hjZppaShy2AGpdtFnPTOJbMX1b5C0FP1C
	ujKzjfK8BouHBvPsfv1CQ==
X-Google-Smtp-Source: AGHT+IELMHgcHN0Rd99ypTZDkVpVLhDqHiZKTu61iMaVvnkDSCt9UR5AaCNm+bZFIRupx2m+PRTS/w==
X-Received: by 2002:a05:6a21:33a8:b0:352:220d:e5fe with SMTP id adf61e73a8af0-3590c200fc9mr2880955637.50.1762937580424;
        Wed, 12 Nov 2025 00:53:00 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b81cd4a98asm1115386b3a.22.2025.11.12.00.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 00:52:59 -0800 (PST)
Date: Wed, 12 Nov 2025 17:52:56 +0900
Message-ID: <m2bjl7y6mv.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: hch@infradead.org,
	linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 00/13] nommu UML
In-Reply-To: <0a84c16f862026c82271c0adbc91d98b812a78b4.camel@sipsolutions.net>
References: <cover.1762588860.git.thehajime@gmail.com>
	<aRGs8lPjH22NqMZc@infradead.org>
	<m2framxerm.wl-thehajime@gmail.com>
	<0a84c16f862026c82271c0adbc91d98b812a78b4.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII



On Tue, 11 Nov 2025 17:01:25 +0900,
Johannes Berg wrote:
> 
> On Mon, 2025-11-10 at 21:18 +0900, Hajime Tazaki wrote:
> > 
> >   What is it for ?
> >   ================
> >   
> >   - Alleviate syscall hook overhead implemented with ptrace(2)
> >   - To exercises nommu code over UML (and over KUnit)
> >   - Less dependency to host facilities
> 
> FWIW, in some way, this order of priorities is exactly why this hasn't
> been going anywhere, and every time I looked at it I got somewhat
> annoyed by what seems to me like choices made to support especially the
> first bullet.

over the past versions, I've been emphasized that the 2nd bullet (testing)
is the primary usecase as I saw several actually cases from mm folks,

https://lists.infradead.org/pipermail/maple-tree/2024-November/003775.html
https://lore.kernel.org/all/cb1cf0be-871d-4982-9a1b-5fdd54deec8d@lucifer.local/

and I think this is not limited to mm code.

other 2 bullets are additional benefits which we observed in a
comment, and our experience.

https://lore.kernel.org/all/20241122121826.GA26024@lst.de/
[2] https://static.sched.com/hosted_files/ossna2020/ec/kollerr_linux_um_nommu.pdf

but those are not the primary goal, so I'm not pushing this aspect
with usecases.

> I suspect that the first and third bullet are not even really true any
> more, since you moved to seccomp (per our request), yet I think design
> choices influenced by them persist.

this observation is not true; the first bullet is still true even
using seccomp.  please look at the benchmark result in the patch
[12/13], quoted below.

summary: most of tests show that um-nommu+seccomp is x4 to x20 faster
than um-mmu+seccomp (and ptrace).

.. csv-table:: lmbench (usec)
  :header: ,native,um,um-mmu(s),um-nommu(s)

  select-10    ,0.5319,36.1214,24.2795,2.9174
  select-100   ,1.6019,34.6049,28.8865,3.8080
  select-1000  ,12.2588,43.6838,48.7438,12.7872
  syscall      ,0.1644,35.0321,53.2119,2.5981
  read         ,0.3055,31.5509,45.8538,2.7068
  write        ,0.2512,31.3609,29.2636,2.6948
  stat         ,1.8894,43.8477,49.6121,3.1908
  open/close   ,3.2973,77.5123,68.9431,6.2575
  fork+sh      ,1110.3000,7359.5000,4618.6667,439.4615
  fork+execve  ,510.8182,2834.0000,2461.1667,139.7848

.. csv-table:: do_getpid bench (nsec)
  :header: ,native,um,um-mmu(s),um-nommu(s)

  getpid , 161 , 34477 , 26242 , 2599

the 1st bullet saying ptrace(2) is somehow misleading now.  this might
be rephrased with "a separate process handling userspace", instead of
"ptrace".

# when I started this patchset, the seccomp patch wasn't in upstream.
  saying ptrace(2) wasn't not that much wrong.

> People are definitely interested in the second bullet, mostly for kunit,
> and I'd be willing to support them in that to some extent.

so (again) the 2nd bullet is the primary use case at this stage.

> However, I'm not yet convinced that all of the complexities presented in
> this patchset (such as completely separate seccomp implementation) are
> actually necessary in support of _just_ the second bullet. These seem to
> me like design choices necessary to support the _first_ bullet [1].

separate seccomp implementation is indeed needed due to the design
choice we made, to use a single process to host a (um) userspace.  I
think there is no reason to unify the seccomp part because the
signal handlers and filter installation do the different jobs.

I don't see why you see this as a _complexity_, as functionally both
seccomp handling don't interfere each other.  we have prepared
separate sub-directories for nommu to avoid unnecessary if/else
clauses in .c/.h files.  we haven't seen any functional regressions
since this RFC version (which was 6.12 kernel).

> [1] and then I suppose the third, which I'm reading as "doesn't need
> seccomp or ptrace", but I'm not really quite sure what you meant
> 
> I've thought about what would happen if we stuck to creating a (single)
> separate process on the host to execute userspace, and just used
> CLONE_VM for it. That way, it's still no-MMU with full memory access,
> but there's some implicit isolation between the kernel and userspace
> processes which will likely remove complexities around FP/SSE/AVX
> handling, may completely remove the need for a separate seccomp
> implementation, etc.

this would be doable I think, but we went the different way, as
using separate host processes (with ptrace/seccomp) is slow and add
complexity by the synchronization between processes, which we think
it's not easy to maintain in the future.

this was natural for us (not sure for maintainers) when we add a new
functionality, consider several options to implement, and took one of the
option which is faster, simpler, and having less cost to maintain.

the avoidance of separate processes is probably the core of our design
choice we made for nommu UML.  I'm not strongly pushing the benefits
of 1st/3rd bullets, but I thought describing the characteristics of
what _this_ patchset can should be useful.  thus in the document.

additionally, if the design choice we made introduces any breakages on
existing code, or maintenance burdens, I would understand your concern
on the complexity, but I don't think this is the case.

> It would, on the other hand, make it completely non-viable to achieve
> the first and third bullets, so given your pursuit of those, one some
> level I understand the design right now. I'm yet to be convinced,
> however, that those are even worthy goals for (upstream) UML, what use
> case would that enable that we really need?

the usecase for those are inherited from the original implementation,
[2] above, which is running UML on containers with less host dependency
and speedups.  but again, this is not the primary goal at this stage.

if you think that the document should not describe the potential
benefits/usecases which are not related to the primary goal of the
functionality, I'd agree to remove those descriptions.

> Especially considering that
> over a longer perspective, NOMMU architectures _are_ on their way out,
> and UML will certainly follow once that happens, it won't be the last
> remaining NOMMU architecture.

I'm aware of this nommu removal discussion, but also saw there are
expressions not to support this direction.  This patchset is still
useful even now.

> So the only value I see in this is for testing over the net couple of
> years, which really doesn't need any sort of significant optimisation or
> less reliance on host facilities.

I agree the former, but not the latter.

- there is a value with a real usecase,
- there are different ways to implement it but this went with the
  one with potential (additional) benefits,
- without breakages to the exising (MMU) uml code.

with that, we're proposing this patchset.

> Where do you see this differently?

thanks for the careful prompt for me.
I hope my answer clarifies your concerns.

I also wish to understand concerns of maintainers, due to the single
process design of nommu for um userspace, and the codebase is still
young so may have unexpected influence to others.  but this is exactly
the reason why I also put myself to MAINTAINERS in order to take care
of this patchset even it is small (1.3k loc).


-- Hajime

