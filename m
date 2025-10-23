Return-Path: <linux-kernel+bounces-866093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 766A5BFEDC6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 03:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF0153A47DF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 01:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF5A1E3DDB;
	Thu, 23 Oct 2025 01:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cx6JIJ/1"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC8C1D63F5
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761183586; cv=none; b=jH0WhKyfaxl2KS0Cuz13nhGbeHZZhBQRqy0KdzOsp7y/q9aXClUXORjnsRrYmvmS3UB7qMFvDGNqXpT5fxpPXjLaPZy53hicDx0VLE3ljUQU3iB20bVtDP/ikhEOU6aBfr2FUk5nfMTzy45tdJfiHIvNqxNLWpB+lKjMPAYIBdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761183586; c=relaxed/simple;
	bh=hcTwpzJMcuc0GjiCytFV+DwouXcQxWmg3I9x4rFf+us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IAFQcU/mL5Zf6B4oxvV1Sk1/B9Uwkp3V9XFiyafnm8qpmGn6JqFdeB8v96m/bK7OiI8ybkE+eP+hAPNp5sak8ITGJQQxf9/BevefN50P74Wj+1S1swT46cr7m6YCyhQYWnfaVoGf7M6hNqMf6NAPQxfdpcWrcTYeKWXRPByjg3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cx6JIJ/1; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47495477241so1412515e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 18:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761183583; x=1761788383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCgsnRi7DdXq+4PeoxX5w1Bin2sJADD0GjGW6qb07u4=;
        b=cx6JIJ/1A7nmPhB4+zbxTkCuayvNk7uDUgvqtqmFvZb/JQK5jtjTr1mwFseCXTFcvm
         fuM64Kns3ObGtrhJeEAQclx1f+cX9AMQUU82pU5mSsmqMIxf0mqbc6M72ZD8bFkvLRrv
         SX9iVJaPgw65lEs55fkoVB0VoXCgtzW9Un9mE3LA8zTmT9ca0BmyHSaLOhmuzBsnf2qz
         0iq8iNZJGcaRhW23x7bJB1SH5fjURMntRV72DP+j+wdDQAll6qccwGdRPENnkX2oy77U
         bz7lkbj4k/EeaEc4P5DHgOxfdNhaT7zxesLVhskY3nDsnegi1fvkrPYh4pUE/2XPYU1f
         NAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761183583; x=1761788383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCgsnRi7DdXq+4PeoxX5w1Bin2sJADD0GjGW6qb07u4=;
        b=lRYW2akst/fZE/iSVXPAI2a6nHFhkye586dUtIG9gIIejkHIKmDKSlPBTdM3pEeuY8
         edy0pgf4FJDv7PmsIGOM7dxs8qoN2mFs/Xokdo5UFbrOX6Ca1orbZCms4Eb4j9ERrAyn
         74MNAwDJ0cFJn1bbUrru5DmRGcKNNiZzToTTnUaDTlHHxDnWaJ6daMS4pdQSptYH1+ty
         7g2wuKsMDWLawTY+yip0rS/ysbZuRCnVgjN8AOSgkjwTIrKTYbOjAxzUYNS1m+B+C4PL
         yz9RNJ14n5cvw82rk/QEv5Df8ngpnj/uwtFUbRNU18/8HL+mafEcc7gMx7ufMU+6Zl5F
         6HqA==
X-Forwarded-Encrypted: i=1; AJvYcCW+oEXEuryYEHD72IPyOUX0HNfUzqlKN75ns/K/l6X6rZ+GnMTuvwlnAX2lENm5xsgs4rsIqerQRJAEZFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsOH9HR1o+3+D8Z0VLqoRVU17K2OpuTsX2kzpYx8/eG//SFdky
	O4tRAzMIj2X157HzdGzTVodaXM1g58SpDE1FzdZFff7Pl3n3ezSJ3y4pDjln1mxdG0I1pSXLk0P
	fQrhLExJUNPKNYDq7E2mYK7PqAw3xmwY=
X-Gm-Gg: ASbGncvAXCvXLkmBQZtdd46pzx0JHbRrZ8zHypmrT+X7TAvoaExL3HXyFYT4ltICWCm
	jcX4W+NvPgyLHVWgdTEYRMTaC44yDKe3OS87knr35kZKenPSn71N9zgREFgnvMJlbIOr52UUm6T
	ENNbSpz6UucpQRrsXpjxeZnS/VVHvKPoYzTpKtHp1JxZ6tzS/1owjKGzIsCqyG8n9ugJGmEFmHN
	sq/Fqfu5yL/2HGgccpsOAhdWScC+u2FWjOdjwufZ5Nc31VdVpV8V/PVXHjIt0TwJFDDVJB0PAVZ
	sTNw7s/eJU/WNmLw3lfuWRHi5dhr
X-Google-Smtp-Source: AGHT+IHaoIGDfmHhdkPRo4MNsgmOBYeFnVuSgdjaRFMt6OjYkcbtKdwZsGshPjXi1FZxU1k9s1QNF+wMZKYGxIIs7as=
X-Received: by 2002:a05:600c:34d0:b0:46f:c0c9:6961 with SMTP id
 5b1f17b1804b1-475cafae8b8mr3068325e9.14.1761183582636; Wed, 22 Oct 2025
 18:39:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930115600.709776-2-aleksei.nikiforov@linux.ibm.com>
 <20251008203111.e6ce309e9f937652856d9aa5@linux-foundation.org>
 <335827e0-0a4c-43c3-a79b-6448307573fd@linux.ibm.com> <20251022030213.GA35717@sol>
 <20251022143604.1ac1fcb18bfaf730097081ab@linux-foundation.org>
In-Reply-To: <20251022143604.1ac1fcb18bfaf730097081ab@linux-foundation.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 22 Oct 2025 18:39:31 -0700
X-Gm-Features: AS18NWCpy-eVIKqwjq3HvvI-t1t4YZx5136aumXfPGuarDyJS0x745rdekxcgMU
Message-ID: <CAADnVQ+o4kE84u05kCgDui-hdk2BK=9vvAOpktiTsRThYRK+Pw@mail.gmail.com>
Subject: Re: [PATCH] mm/kmsan: Fix kmsan kmalloc hook when no stack depots are
 allocated yet
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Harry Yoo <harry.yoo@oracle.com>, Michal Hocko <mhocko@suse.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>
Cc: Eric Biggers <ebiggers@kernel.org>, 
	Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev <kasan-dev@googlegroups.com>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 2:36=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 21 Oct 2025 20:02:13 -0700 Eric Biggers <ebiggers@kernel.org> wro=
te:
>
> > On Fri, Oct 10, 2025 at 10:07:04AM +0200, Aleksei Nikiforov wrote:
> > > On 10/9/25 05:31, Andrew Morton wrote:
> > > > On Tue, 30 Sep 2025 13:56:01 +0200 Aleksei Nikiforov <aleksei.nikif=
orov@linux.ibm.com> wrote:
> > > >
> > > > > If no stack depot is allocated yet,
> > > > > due to masking out __GFP_RECLAIM flags
> > > > > kmsan called from kmalloc cannot allocate stack depot.
> > > > > kmsan fails to record origin and report issues.
> > > > >
> > > > > Reusing flags from kmalloc without modifying them should be safe =
for kmsan.
> > > > > For example, such chain of calls is possible:
> > > > > test_uninit_kmalloc -> kmalloc -> __kmalloc_cache_noprof ->
> > > > > slab_alloc_node -> slab_post_alloc_hook ->
> > > > > kmsan_slab_alloc -> kmsan_internal_poison_memory.
> > > > >
> > > > > Only when it is called in a context without flags present
> > > > > should __GFP_RECLAIM flags be masked.
> > > > >
> > > > > With this change all kmsan tests start working reliably.
> > > >
> > > > I'm not seeing reports of "hey, kmsan is broken", so I assume this
> > > > failure only occurs under special circumstances?
> > >
> > > Hi,
> > >
> > > kmsan might report less issues than it detects due to not allocating =
stack
> > > depots and not reporting issues without stack depots. Lack of reports=
 may go
> > > unnoticed, that's why you don't get reports of kmsan being broken.
> >
> > Yes, KMSAN seems to be at least partially broken currently.  Besides th=
e
> > fact that the kmsan KUnit test is currently failing (which I reported a=
t
> > https://lore.kernel.org/r/20250911175145.GA1376@sol), I've confirmed
> > that the poly1305 KUnit test causes a KMSAN warning with Aleksei's patc=
h
> > applied but does not cause a warning without it.  The warning did get
> > reached via syzbot somehow
> > (https://lore.kernel.org/r/751b3d80293a6f599bb07770afcef24f623c7da0.176=
1026343.git.xiaopei01@kylinos.cn/),
> > so KMSAN must still work in some cases.  But it didn't work for me.
>
> OK, thanks, I pasted the above para into the changelog to help people
> understand the impact of this.
>
> > (That particular warning in the architecture-optimized Poly1305 code is
> > actually a false positive due to memory being initialized by assembly
> > code.  But that's besides the point.  The point is that I should have
> > seen the warning earlier, but I didn't.  And Aleksei's patch seems to
> > fix KMSAN to work reliably.  It also fixes the kmsan KUnit test.)
> >
> > I don't really know this code, but I can at least give:
> >
> > Tested-by: Eric Biggers <ebiggers@kernel.org>
> >
> > If you want to add a Fixes commit I think it is either 97769a53f117e2 o=
r
> > 8c57b687e8331.  Earlier I had confirmed that reverting those commits
> > fixed the kmsan test too
> > (https://lore.kernel.org/r/20250911192953.GG1376@sol).
>
> Both commits affect the same kernel version so either should be good
> for a Fixes target.
>
> I'll add a cc:stable to this and shall stage it for 6.18-rcX.
>
> The current state is below - if people want to suggest alterations,
> please go for it.

Thanks for cc-ing and for extra context.

>
>
> From: Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>
> Subject: mm/kmsan: fix kmsan kmalloc hook when no stack depots are alloca=
ted yet
> Date: Tue, 30 Sep 2025 13:56:01 +0200
>
> If no stack depot is allocated yet, due to masking out __GFP_RECLAIM
> flags kmsan called from kmalloc cannot allocate stack depot.  kmsan
> fails to record origin and report issues.  This may result in KMSAN
> failing to report issues.
>
> Reusing flags from kmalloc without modifying them should be safe for kmsa=
n.
> For example, such chain of calls is possible:
> test_uninit_kmalloc -> kmalloc -> __kmalloc_cache_noprof ->
> slab_alloc_node -> slab_post_alloc_hook ->
> kmsan_slab_alloc -> kmsan_internal_poison_memory.
>
> Only when it is called in a context without flags present should
> __GFP_RECLAIM flags be masked.

I see. So this is a combination of gfpflags_allow_spinning()
and old kmsan code.
We hit this issue a few times already.

I feel the further we go the more a new __GFP_xxx flag could be justified,
but Michal is strongly against it.
This particular issue actually might tilt it in favor of Michal's position,
since fixing kmsan is the right thing to do.

The fix itself makes sense to me. No better ideas so far.

What's puzzling is that it took 9 month to discover it ?!
and allegedly Eric is seeing it by running kmsan selftest,
but Alexander couldn't repro it initially?
Looks like there is a gap in kmsan test coverage.
People that care about kmsan should really step up.

> With this change all kmsan tests start working reliably.
>
> Eric reported:
>
> : Yes, KMSAN seems to be at least partially broken currently.  Besides th=
e
> :_fact that the kmsan KUnit test is currently failing (which I reported a=
t
> :_https://lore.kernel.org/r/20250911175145.GA1376@sol), I've confirmed th=
at
> :_the poly1305 KUnit test causes a KMSAN warning with Aleksei's patch
> :_applied but does not cause a warning without it.  The warning did get
> :_reached via syzbot somehow
> :_(https://lore.kernel.org/r/751b3d80293a6f599bb07770afcef24f623c7da0.176=
1026343.git.xiaopei01@kylinos.cn/),
> :_so KMSAN must still work in some cases.  But it didn't work for me.
>
> Link: https://lkml.kernel.org/r/20250930115600.709776-2-aleksei.nikiforov=
@linux.ibm.com
> Link: https://lkml.kernel.org/r/20251022030213.GA35717@sol
> Fixes: 97769a53f117 ("mm, bpf: Introduce try_alloc_pages() for opportunis=
tic page allocation")
> Signed-off-by: Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>
> Reviewed-by: Alexander Potapenko <glider@google.com>
> Tested-by: Eric Biggers <ebiggers@kernel.org>
> Cc: Dmitriy Vyukov <dvyukov@google.com>
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> Cc: Marco Elver <elver@google.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>  mm/kmsan/core.c   |    3 ---
>  mm/kmsan/hooks.c  |    6 ++++--
>  mm/kmsan/shadow.c |    2 +-
>  3 files changed, 5 insertions(+), 6 deletions(-)
>
> --- a/mm/kmsan/core.c~mm-kmsan-fix-kmsan-kmalloc-hook-when-no-stack-depot=
s-are-allocated-yet
> +++ a/mm/kmsan/core.c
> @@ -72,9 +72,6 @@ depot_stack_handle_t kmsan_save_stack_wi
>
>         nr_entries =3D stack_trace_save(entries, KMSAN_STACK_DEPTH, 0);
>
> -       /* Don't sleep. */
> -       flags &=3D ~(__GFP_DIRECT_RECLAIM | __GFP_KSWAPD_RECLAIM);
> -
>         handle =3D stack_depot_save(entries, nr_entries, flags);
>         return stack_depot_set_extra_bits(handle, extra);
>  }
> --- a/mm/kmsan/hooks.c~mm-kmsan-fix-kmsan-kmalloc-hook-when-no-stack-depo=
ts-are-allocated-yet
> +++ a/mm/kmsan/hooks.c
> @@ -84,7 +84,8 @@ void kmsan_slab_free(struct kmem_cache *
>         if (s->ctor)
>                 return;
>         kmsan_enter_runtime();
> -       kmsan_internal_poison_memory(object, s->object_size, GFP_KERNEL,
> +       kmsan_internal_poison_memory(object, s->object_size,
> +                                    GFP_KERNEL & ~(__GFP_RECLAIM),
>                                      KMSAN_POISON_CHECK | KMSAN_POISON_FR=
EE);
>         kmsan_leave_runtime();
>  }
> @@ -114,7 +115,8 @@ void kmsan_kfree_large(const void *ptr)
>         kmsan_enter_runtime();
>         page =3D virt_to_head_page((void *)ptr);
>         KMSAN_WARN_ON(ptr !=3D page_address(page));
> -       kmsan_internal_poison_memory((void *)ptr, page_size(page), GFP_KE=
RNEL,
> +       kmsan_internal_poison_memory((void *)ptr, page_size(page),
> +                                    GFP_KERNEL & ~(__GFP_RECLAIM),
>                                      KMSAN_POISON_CHECK | KMSAN_POISON_FR=
EE);
>         kmsan_leave_runtime();
>  }
> --- a/mm/kmsan/shadow.c~mm-kmsan-fix-kmsan-kmalloc-hook-when-no-stack-dep=
ots-are-allocated-yet
> +++ a/mm/kmsan/shadow.c
> @@ -208,7 +208,7 @@ void kmsan_free_page(struct page *page,
>                 return;
>         kmsan_enter_runtime();
>         kmsan_internal_poison_memory(page_address(page), page_size(page),
> -                                    GFP_KERNEL,
> +                                    GFP_KERNEL & ~(__GFP_RECLAIM),
>                                      KMSAN_POISON_CHECK | KMSAN_POISON_FR=
EE);
>         kmsan_leave_runtime();
>  }
> _
>

