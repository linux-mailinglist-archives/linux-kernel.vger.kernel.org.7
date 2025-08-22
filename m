Return-Path: <linux-kernel+bounces-782481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE00CB320E6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D351CA044AB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672C13126C1;
	Fri, 22 Aug 2025 16:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6UM9I3A"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0658311595
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755881802; cv=none; b=WF2s/rtxQGi9vpq5ImVfeChjSJbvP0Vv90dHDLKIxqgUK8QQrwC0CzNyE2mYoRiW36yusNglqi2S51NoE2xBOWomsnF1NMSKkUt6bqLLl7+r0NfIwcII2V/SmQoHnHwHx5jcgFylehwXbqyOhEWJXPb6XJ51rJdFIpL5wu4SZfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755881802; c=relaxed/simple;
	bh=XJJ2/Z39zusEbBGJnbN/FJrEuCauLKRPKLvOIYi1b3Y=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQnlPj7NQULvdeQ4HiM4m2B3iG3DP2KNWvOVu89tfqw6CUQoEZ/L6tcYJl60cb0Yh5Kcgd0z0C8tyF2rJ7XcMHrDkElYN7qfJWOCTwD1GnpGttIsx5B5Dy+VhE62r/E+EjFRkeG2Nno0yLGdtU2HuTOhJjBM3+l+t4SU8Q1Xq1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6UM9I3A; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-33548b0f979so17581731fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755881799; x=1756486599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N2HS1dqu0u6/zLIQ0iklKxHGjviVaOOzJ9/vcWLgezc=;
        b=I6UM9I3AZI2u1zOzeLbPiMQbzBBDVri+H6Ps2OuZxUvL0uzIXXzPKabf1g2rXvTkLU
         HrsRKYGSNzXkjcfuJblvJ02W0wGLrQjora2IuUGagAChlV+uxfn/wh/bpQfhi8s7iY3A
         G6DemvSEEQyFvKhzEXX8q5A+CW8ngG8Dij6kfbYzRsj4yTwOzU/7O7BP4/8y6BB+gLsi
         bikEgzVHX4+tMPejQRuc+PUC6vK3X/t1LgUV03yaqI67/yccT+7Va4redjF/hnna4dOf
         /XuOuBpJXFZ9usmbAOTlfnMoW1kxyfFnLilQsUOLCI/Wb8qqik/9KaBqHOsJAkGzROa6
         ktjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755881799; x=1756486599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2HS1dqu0u6/zLIQ0iklKxHGjviVaOOzJ9/vcWLgezc=;
        b=RTL+nFF0ye/xrNtUFZf7VCVHb+4R94/iH4vZd0vF9Z/TJUfKTunthCR0G9XCstSdcb
         rlJh5HhlAfUFMbzGr4g2/w/2Msu/d0NskFgZupSjbmklh7Vsu74yli7arO7pcu0CVYmu
         Pt4+JGSET8z+JnntHWRz8vz/AV8rdXkkHKh1onUI08ci53tqZ/BwvTRiVlP40xrEorDj
         vN7ZEfSAen72UgRjFnqmXXQAuRIdfPaQPf31GPTelO93qJC7FtzXCwhN6lyc9syJrk/d
         7x66gNyBsY0HuJJHD1Ve5DXHNF7Zb+iRSrIW/IGRaEpr0aiZSYyksBwRQ4ZQ/Z5c9viV
         3EUw==
X-Forwarded-Encrypted: i=1; AJvYcCUuP1jTyAXe0d+499NK4okLpuhSPs0HTmXAGyeihWiL3+RCPcsvhLNRrw/Hxo2zGYWOdwwDu7gzRchtp10=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgD6F4fg6ELStfaKwWQHY65m3viVuNrjA/q7qNHLu/2IKNwIOG
	Q8hXmGN4jCca3CpyV6gD0vvrwu3hj4EHb7Amt8QX5EmTV4b+93WidqxR
X-Gm-Gg: ASbGncsDN7pnkgpACu3C+WV22NNdjlvsCmC0Z1ofbb6oe6ELGDGLYZ1p2FaCzVHBOuc
	99AB5iM916UakY/Npv/mcaxbxguVn57GV0ZgYnSX5FcVVnxQc8lzqqCy1CI3xzxZsRm1Rm/JR8H
	KUmAWdn+Tj6qxkGj7KtkktjCMMFAXX3EY3pYuS614v/KuLTTTDkvvk1IW+s9vFLUpTYtDcz5Uqh
	5aduUYije0XG7NRKfMv5ImBbzeijIMPyEWAIvyO5/lIwKys3uIcRz8r29aQkzj+rayA7r80Oz9M
	1lLXrwjPcnbAAyxQp0chkpDLBgwj1MjVQyqeOaIA5/xekm2njXloQQS8ibZ+EsFpIjoDRzDHzzr
	ATQAJkOtRhT5PDXnKw8iMIYiLAF1m/Zu/2LCC3BqKZPp5gA81G4zpX/ojjKWR
X-Google-Smtp-Source: AGHT+IEz482Su99xoGjjCv8Fw83zS6L5IxLFiEqehcr0KB01nslZsEGNuILSniluBt7EM53KnnAd1w==
X-Received: by 2002:a2e:8890:0:b0:32a:ec98:e15c with SMTP id 38308e7fff4ca-33650e71a01mr8259891fa.19.1755881798161;
        Fri, 22 Aug 2025 09:56:38 -0700 (PDT)
Received: from pc636 (host-95-203-25-178.mobileonline.telia.com. [95.203.25.178])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3365e5a950csm278111fa.45.2025.08.22.09.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 09:56:37 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 22 Aug 2025 18:56:34 +0200
To: Brendan Jackman <jackmanb@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, peterz@infradead.org,
	bp@alien8.de, dave.hansen@linux.intel.com, mingo@redhat.com,
	tglx@linutronix.de, akpm@linux-foundation.org, david@redhat.com,
	derkling@google.com, junaids@google.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, reijiw@google.com,
	rientjes@google.com, rppt@kernel.org, vbabka@suse.cz,
	x86@kernel.org, yosry.ahmed@linux.dev,
	Matthew Wilcox <willy@infradead.org>,
	Liam Howlett <liam.howlett@oracle.com>,
	"Kirill A. Shutemov" <kas@kernel.org>,
	Harry Yoo <harry.yoo@oracle.com>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, Andy Lutomirski <luto@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, Kees Cook <kees@kernel.org>
Subject: Re: [Discuss] First steps for ASI (ASI is fast again)
Message-ID: <aKihQv8fWzZIgnAW@pc636>
References: <20250812173109.295750-1-jackmanb@google.com>
 <cdccc1a6-c348-4cae-ab70-92c5bd3bd9fd@lucifer.local>
 <DC83J9RSZZ0E.3VKGEVIDMSA2R@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DC83J9RSZZ0E.3VKGEVIDMSA2R@google.com>

On Thu, Aug 21, 2025 at 12:15:04PM +0000, Brendan Jackman wrote:
> On Thu Aug 21, 2025 at 8:55 AM UTC, Lorenzo Stoakes wrote:
> > +cc Matthew for page cache side
> > +cc Other memory mapping folks for mapping side
> > +cc various x86 folks for x86 side
> > +cc Kees for security side of things
> >
> > On Tue, Aug 12, 2025 at 05:31:09PM +0000, Brendan Jackman wrote:
> >> .:: Intro
> >>
> >> Following up to the plan I posted at [0], I've now prepared an up-to-date ASI
> >> branch that demonstrates a technique for solving the page cache performance
> >> devastation I described in [1]. The branch is at [5].
> >
> > Have looked through your branch at [5], note that the exit_mmap() code is
> > changing very soon see [ljs0]. Also with regard to PGD syncing, Harry introduced
> > a hotfix series recently to address issues around this generalising this PGD
> > sync code which may be usefully relevant to your series.
> >
> > [ljs0]:https://lore.kernel.org/linux-mm/20250815191031.3769540-1-Liam.Howlett@oracle.com/
> > [ljs1]:https://lore.kernel.org/linux-mm/20250818020206.4517-1-harry.yoo@oracle.com/
> 
> Thanks, this is useful info.
> 
> >>
> >> The goal of this prototype is to increase confidence that ASI is viable as a
> >> broad solution for CPU vulnerabilities. (If the community still has to develop
> >> and maintain new mitigations for every individual vuln, because ASI only works
> >> for certain use-cases, then ASI isn't super attractive given its complexity
> >> burden).
> >>
> >> The biggest gap for establishing that confidence was that Google's deployment
> >> still only uses ASI for KVM workloads, not bare-metal processes. And indeed the
> >> page cache turned out to be a massive issue that Google just hasn't run up
> >> against yet internally.
> >>
> >> .:: The "ephmap"
> >>
> >> I won't re-hash the details of the problem here (see [1]) but in short: file
> >> pages aren't mapped into the physmap as seen from ASI's restricted address space.
> >> This causes a major overhead when e.g. read()ing files. The solution we've
> >> always envisaged (and which I very hastily tried to describe at LSF/MM/BPF this
> >> year) was to simply stop read() etc from touching the physmap.
> >>
> >> This is achieved in this prototype by a mechanism that I've called the "ephmap".
> >> The ephmap is a special region of the kernel address space that is local to the
> >> mm (much like the "proclocal" idea from 2019 [2]). Users of the ephmap API can
> >> allocate a subregion of this, and provide pages that get mapped into their
> >> subregion. These subregions are CPU-local. This means that it's cheap to tear
> >> these mappings down, so they can be removed immediately after use (eph =
> >> "ephemeral"), eliminating the need for complex/costly tracking data structures.
> >
> > OK I had a bunch of questions here but looked at the code :)
> >
> > So the idea is we have a per-CPU buffer that is equal to the size of the largest
> > possible folio, for each process.
> >
> > I wonder by the way if we can cache page tables rather than alloc on bring
> > up/tear down? Or just zap? That could help things.
> 
> Yeah if I'm catching your gist correctly, we have done a bit of this in
> the Google-internal version. In cases where it's fine to fail to map
> stuff (as is the case for ephmap users in this branch) you can just have
> a little pool of pre-allocated pagetables that you can allocate from in
> arbitrary contexts. Maybe the ALLOC_TRYLOCK stuff could also be useful
> here, I haven't explored that.
> 
> >>
> >> (You might notice the ephmap is extremely similar to kmap_local_page() - see the
> >> commit that introduces it ("x86: mm: Introduce the ephmap") for discussion).
> >
> > I do wonder if we need to have a separate kmap thing or whether we can just
> > adjust what already exists?
> 
> Yeah, I also wondered this. I think we could potentially just change the
> semantics of kmap_local_page() to suit ASI's needs, but I'm not really
> clear if that's consistent with the design or if there are perf
> concerns regarding its existing usecase. I am hoping once we start to
> get the more basic ASI stuff in, this will be a topic that will interest
> the right people, and I'll be able to get some useful input...
> 
> > Presumably we will restrict ASI support to 64-bit kernels only (starting with
> > and perhaps only for x86-64), so we can avoid the highmem bs.
> 
> Yep.
> 
> >>
> >> The ephmap can then be used for accessing file pages. It's also a generic
> >> mechanism for accessing sensitive data, for example it could be used for
> >> zeroing sensitive pages, or if necessary for copy-on-write of user pages.
> >>
> >> .:: State of the branch
> >>
> >> The branch contains:
> >>
> >> - A rebased version of my "ASI integration for the page allocator" RFC [3]. (Up
> >>   to "mm/page_alloc: Add support for ASI-unmapping pages")
> >> - The rest of ASI's basic functionality (up to "mm: asi: Stop ignoring asi=on
> >>   cmdline flag")
> >> - Some test and observability conveniences (up to "mm: asi: Add a tracepoint for
> >>   ASI page faults")
> >> - A prototype of the new performance improvements (the remainder of the
> >>   branch).
> >>
> >> There's a gradient of quality where the earlier patches are closer to "complete"
> >> and the later ones are increasingly messy and hacky. Comments and commit message
> >> describe lots of the hacky elements but the most important things are:
> >>
> >> 1. The logic to take advantage of the ephmap is stuck directly into mm/shmem.c.
> >>    This is just a shortcut to make its behaviour obvious. Since tmpfs is the
> >>    most extreme case of the read/write slowdown this should give us some idea of
> >>    the performance improvements but it obviously hides a lot of important
> >>    complexity wrt how this would be integrated "for real".
> >
> > Right, at what level do you plan to put the 'real' stuff?
> >
> > generic_file_read_iter() + equivalent or something like this? But then you'd
> > miss some fs obv., so I guess filemap_read()?
> 
> Yeah, just putting it into these generic stuff seemed like the most
> obvious way, but I was also hoping there could be some more general way
> to integrate it into the page cache or even something like the iov
> system. I did not see anything like this yet, but I don't think I've
> done the full quota of code-gazing that I'd need to come up with the
> best idea here. (Also maybe the solution becomes obvious if I can find
> the right pair of eyes).
> 
> Anyway, my hope is that the number of filesystems that are both a) very
> special implementation-wise and b) dear to the hearts of
> performance-sensitive users is quite small, so maybe just injecting into
> the right pre-existing filemap.c helpers, plus one or two
> filesystem-specific additions, already gets us almost all the way there.
> 
> >>
> >> 2. The ephmap implementation is extremely stupid. It only works for the simple
> >>    shmem usecase. I don't think this is really important though, whatever we end
> >>    up with needs to be very simple, and it's not even clear that we actually
> >>    want a whole new subsystem anyway. (e.g. maybe it's better to just adapt
> >>    kmap_local_page() itself).
> >
> > Right just testing stuff out, fair enough. Obviously not an upstremable thing
> > but sort of test case right?
> 
> Yeah exactly. 
> 
> Maybe worth adding here that I explored just using vmalloc's allocator
> for this. My experience was that despite looking quite nicely optimised
> re avoiding synchronisation, just the simple fact of traversing its data
> structures is too slow for this usecase (at least, it did poorly on my
> super-sensitive FIO benchmark setup).
> 
Could you please elaborate here? Which test case and what is a problem
for it?

You can fragment the main KVA space where we use a rb-tree to manage
free blocks. But the question is how important your use case and
workload for you?

Thank you!

--
Uladzislau Rezki

