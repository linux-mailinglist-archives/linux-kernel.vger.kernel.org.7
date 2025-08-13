Return-Path: <linux-kernel+bounces-767342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCEFB25312
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87B12568296
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4331529B8E0;
	Wed, 13 Aug 2025 18:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6/aWqly"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C400303C9D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 18:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755109994; cv=none; b=ZZ3XH+5qLglx93alWswIHISmnTKw9vhEwjecpSq9ZRL53ro8ApAQ/20fPzzklYr9U9FUvJMdXdJlFprbmupI2lKvR8L4GBpQokz+j79TVV0c3Rs1mGx7o7jbXCVhnmR2cq3yEMynyFJx0XM/CA+8Yma7r3qh5AoQ02ZRWcTdMiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755109994; c=relaxed/simple;
	bh=O9oeyCMoYLQ4OGFSt9Hyh8oCvCp8yeKaCwxDYmlVtGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iz3y/IKZ5atPh1azcGoNvqExgI8nojE0q26dsYSO8rA2H4MQltZxG+669mBYnVd1p01rOOJHhNKS6U3wmc/x2hq/G/vmXChqC6lIhZG7HdjGX5+6ekumpgLEvzVh9Aud5njS52IFvvj5C9dyk+GaAI1s8oY4pmO6AbB5SENT8io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6/aWqly; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-61bd4a7b02fso107029eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 11:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755109990; x=1755714790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONwL100N6xPJzY3LKqxJvxeIT24I19t6heDt6lpQxPA=;
        b=i6/aWqlyMFJnG6JXQHmHUvby6ZdlB/AT5s+B2rnpwnbxXUGB1Ks0MN2a+Ziz+TspI+
         sk11LYMqVQQCP1qnOnJhxTOH6zw8OOJLjkzOSV7Mou5Vb68NSfcJBuY3bvIPHYEhYQG6
         aFJTYfWo88DQF3GnStRGMis6g7ERHwOEjl5a6UBkMebXHYl6MCzpTRSNG47sVZqevnor
         JuNpxc1eVgD57pa/AUxYTiFJMlTxMkhz7gEQre+gYliSJNUIa+xe+aWcKK5W/LS66/NR
         eO8aFPnqVq2/OIeqeJs6dKCi3mjjkhLEJ8zj8Ng2wF0Y6DF5FMBhIeIsWCB+cDQmL3eD
         C/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755109990; x=1755714790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ONwL100N6xPJzY3LKqxJvxeIT24I19t6heDt6lpQxPA=;
        b=n0UNimQaCkXCGRUG9/ku4mS5zkgPOiyhjGgO2u/vcKZQKl4E+cfv4NTO3SFg2Lf146
         RB2B75E6xiVCh5dDgon9lJ7FsmBAnYXUpQ7gjNpUyN5WGgkmvmYLZtMAF7EXGnnvNicZ
         WSmFbeb9aPn/MhwSJSnBq5L2wXnnGtqnarMYcQM4n1h+F0j4sj5GqHSzMuXr2bf+xvrc
         ctEAgXWEyS6jIu4vCNPZSrAJZn9Q/1cLxeBf8t/bj+h1EyPc61QAybB1ftBziCOuMbAc
         5vjUyMq+r3b9QANIPPDoiAouTFL4QNur3Uz4doDdd2gq6JyqeUC4Po/k8XgUo9sI48Rc
         jmiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRsvCpV9kUfRjJISljYnlGloUhinNmgd3dgTN3yNLvn5TX6O6ZmcbOfDEtTDI3zYAGTFmFuKd5n5NzFLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpLPlr3kUwoeR9VMaeDoungk/0Wg8fxQThRWg6BqAIbH2fIMNo
	YsGTSguk+34wduN+pMKhJ5DfH0Odf6Tn0BCGIge5zHhkpTNzEhpK5ch1+FmYraxEDhFE8hElYPD
	y6n1+oMkdvz7U6bb3u8eFZQP413meQ6M=
X-Gm-Gg: ASbGncuYvzL5fRh8hqUA+jzBeoHImwUZxxpg5farmNIh9j1EBnpZOsJmcj87e9jaZxg
	C/3bIcNVUp3TYRABlmeJqiKINkjtrbTkaWbz8ldTq/VcO1+ATWm3SdqZ3+VK4DgWnxIXACG8SBs
	PuZOGeOmYTDB1xXOxhNbbxSBuv4Uv9X44YotC5x6MX736CS/MlT9vxt0xTIHCQ+GSY+OmiUq4Z2
	x1Z
X-Google-Smtp-Source: AGHT+IH1bWUY8FkF2HhurIrAUzTTRQ4VGJ5bod6IIBHHxyPqEJfKC6m1+htyXiiZejpOwxTJ3slYWVHOqVdCS+fuTwU=
X-Received: by 2002:a05:6808:d4c:b0:41e:9fd0:bd2c with SMTP id
 5614622812f47-435df7c1c40mr163198b6e.18.1755109990047; Wed, 13 Aug 2025
 11:33:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812170046.56468-1-sj@kernel.org> <CAF8kJuN1BH0rqC6czj9govNOugd_5K9ijYcxbWYpEpUdQKn0-A@mail.gmail.com>
In-Reply-To: <CAF8kJuN1BH0rqC6czj9govNOugd_5K9ijYcxbWYpEpUdQKn0-A@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 13 Aug 2025 11:32:59 -0700
X-Gm-Features: Ac12FXzPXLQ7gqnSjSM7ZZyDFngw6vQJDXLffW208GO3eaHtGTf8ysAiSLoJZDk
Message-ID: <CAKEwX=MzHu+kXygCx=AC7MptExsy8CS9c6-fBbFK=shYDD4S7w@mail.gmail.com>
Subject: Re: [PATCH v2] mm/zswap: store <PAGE_SIZE compression failed page as-is
To: Chris Li <chrisl@kernel.org>
Cc: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, David Hildenbrand <david@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Takero Funaki <flintglass@gmail.com>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 10:07=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote=
:
>
> Hi SeongJae,
>
> Thanks for doing that. I am working on something related to this as
> well. Please consider CC me on your next version.
>
> On Tue, Aug 12, 2025 at 10:00=E2=80=AFAM SeongJae Park <sj@kernel.org> wr=
ote:
> >
> > When zswap writeback is enabled and it fails compressing a given page,
> > the page is swapped out to the backing swap device.  This behavior
> > breaks the zswap's writeback LRU order, and hence users can experience
> > unexpected latency spikes.  If the page is compressed without failure,
> > but results in a size of PAGE_SIZE, the LRU order is kept, but the
> > decompression overhead for loading the page back on the later access is
> > unnecessary.
> >
> > Keep the LRU order and optimize unnecessary decompression overheads in
> > those cases, by storing the original content as-is in zpool.  The lengt=
h
> > field of zswap_entry will be set appropriately, as PAGE_SIZE,  Hence
> > whether it is saved as-is or not (whether decompression is unnecessary)
> > is identified by 'zswap_entry->length =3D=3D PAGE_SIZE'.
> >
> > Because the uncompressed data is saved in zpool, same to the compressed
> > ones, this introduces no change in terms of memory management including
> > movability and migratability of involved pages.
>
> If you store uncompressed data in the zpool, zpool has metadata
> overhead, e.g. allocating the entry->handle for uncompressed pages.
> If the page is not compressed, another idea is just skip the zpool,
> store it as a page in the zswap entry as page. We can make a union of
> entry->handle and entry->incompressble_page. If entry->length =3D=3D
> PAGE_SIZE, use entry->incompressable_page as a page.
>
> The pros is that, on the page fault, there is no need to allocate a
> new page. You can just move the uncompressed_page into the swap_cache.
> You save one memcpy on the page fault as well. That will make the
> incompressible page fault behave very similar to the minor page fault.
>
> The cons is that, now zpool does not account for uncompressed pages,
> on the second thought, that can be a con as well, the page is not
> compressed, why should it account as compressed pages?
>
> I know Hugh has some idea to store incompressible pages in the swap
> cache as well. Hugh?

I've also proposed that approach internally - keeping the page in
swapcache, while adding them to the zswap LRU for writeback to disk
(and so that we do not consider them for zswap again in the future).

But after a while, we decided against it, mostly due to the complexity
of the solution. On the zswap side, we need to distinguish between the
ordinary struct zswap_entry and the struct page on zswap's LRU list.
Externally, we need to handle moving a page currently in the zswap LRU
to the main memory anon LRUs too.

Migration is another concern. Zswap needs to be notified that the
"backend" of a zswap entry has changed underneath it. Not impossible,
but again that's just more surgery.

So we decided to start with a simple solution (this one), and iterate
as issues cropped up. At least then, we have production justifications
for any future improvements.

>
> > This change is also not increasing per zswap entry metadata overhead.
> > But as the number of incompressible pages increases, total zswap
> > metadata overhead is proportionally increased.  The overhead should not
> > be problematic in usual cases, since the zswap metadata for single zswa=
p
> > entry is much smaller than PAGE_SIZE, and in common zswap use cases
> > there should be a sufficient amount of compressible pages.  Also it can
> > be mitigated by the zswap writeback.
> >
> > When the writeback is disabled, the additional overhead could be
> > problematic.  For the case, keep the current behavior that just returns
> > the failure and let swap_writeout() put the page back to the active LRU
> > list in the case.
> >
> > Knowing how many compression failures happened will be useful for futur=
e
> > investigations.  investigations.  Add a new debugfs file, compress_fail=
,
> > for the purpose.
>
> Again, I think we should distinguish the crypto engine fail vs ration fai=
lure.
>
> >
> > Tests
> > -----
> >
> > I tested this patch using a simple self-written microbenchmark that is
> > available at GitHub[1].  You can reproduce the test I did by executing
> > run_tests.sh of the repo on your system.  Note that the repo's
> > documentation is not good as of this writing, so you may need to read
> > and use the code.
> >
> > The basic test scenario is simple.  Run a test program making artificia=
l
> > accesses to memory having artificial content under memory.high-set
> > memory limit and measure how many accesses were made in given time.
> >
> > The test program repeatedly and randomly access three anonymous memory
> > regions.  The regions are all 500 MiB size, and accessed in the same
> > probability.  Two of those are filled up with a simple content that can
> > easily be compressed, while the remaining one is filled up with a
> > content that read from /dev/urandom, which is easy to fail at
> > compressing to <PAGE_SIZE size.  The program runs for two minutes and
> > prints out the number of accesses made every five seconds.
> >
> > The test script runs the program under below seven configurations.
> >
> > - 0: memory.high is set to 2 GiB, zswap is disabled.
> > - 1-1: memory.high is set to 1350 MiB, zswap is disabled.
> > - 1-2: On 1-1, zswap is enabled without this patch.
> > - 1-3: On 1-2, this patch is applied.
> >
> > For all zswap enabled cases, zswap shrinker is enabled.
> >
> > Configuration '0' is for showing the original memory performance.
> > Configurations 1-1, 1-2 and 1-3 are for showing the performance of swap=
,
> > zswap, and this patch under a level of memory pressure (~10% of working
> > set).
> >
> > Because the per-5 seconds performance is not very reliable, I measured
> > the average of that for the last one minute period of the test program
> > run.  I also measured a few vmstat counters including zswpin, zswpout,
> > zswpwb, pswpin and pswpout during the test runs.
> >
> > The measurement results are as below.  To save space, I show performanc=
e
> > numbers that are normalized to that of the configuration '0' (no memory
> > pressure), only.  The averaged accesses per 5 seconds of configuration
> > '0' was 36493417.75.
> >
> >     config            0       1-1     1-2      1-3
> >     perf_normalized   1.0000  0.0057  0.0235   0.0367
> >     perf_stdev_ratio  0.0582  0.0652  0.0167   0.0346
> >     zswpin            0       0       3548424  1999335
> >     zswpout           0       0       3588817  2361689
> >     zswpwb            0       0       10214    340270
> >     pswpin            0       485806  772038   340967
> >     pswpout           0       649543  144773   340270
> >
> > 'perf_normalized' is the performance metric, normalized to that of
> > configuration '0' (no pressure).  'perf_stdev_ratio' is the standard
> > deviation of the averaged data points, as a ratio to the averaged metri=
c
> > value.  For example, configuration '0' performance was showing 5.8%
> > stdev.  Configurations 1-1 and 1-3 were having about 6.5% and 6.1%
> > stdev.  Also the results were highly variable between multiple runs.  S=
o
> > this result is not very stable but just showing ball park figures.
> > Please keep this in your mind when reading these results.
> >
> > Under about 10% of working set memory pressure, the performance was
> > dropped to about 0.57% of no-pressure one, when the normal swap is used
> > (1-1).  Note that ~10% working set pressure is already extreme, at leas=
t
> > on this test setup.  No one would desire system setups that can degrade
> > performance to 0.57% of the best case.
> >
> > By turning zswap on (1-2), the performance was improved about 4x,
> > resulting in about 2.35% of no-pressure one.  Because of the
> > incompressible pages in the third memory region, a significant amount o=
f
> > (non-zswap) swap I/O operations were made, though.
> >
> > By applying this patch (1-3), about 56% performance improvement was
> > made, resulting in about 3.67% of no-pressure one.  Reduced pswpin of
> > 1-3 compared to 1-2 let us see where this improvement came from.
> >
> > Related Works
> > -------------
> >
> > This is not an entirely new attempt.  Nhat Pham and Takero Funaki tried
> > very similar approaches in October 2023[2] and April 2024[3],
> > respectively.  The two approaches didn't get merged mainly due to the
> > metadata overhead concern.  I described why I think that shouldn't be a
> > problem for this change, which is automatically disabled when writeback
> > is disabled, at the beginning of this changelog.
> >
> > This patch is not particularly different from those, and actually built
> > upon those.  I wrote this from scratch again, though.  Hence adding
> > Suggested-by tags for them.  Actually Nhat first suggested this to me
> > offlist.
> >
> > Historically, writeback disabling was introduced partially as a way to
> > solve the LRU order issue.  Yosry pointed out[4] this is still
> > suboptimal when the incompressible pages are cold, since the
> > incompressible pages will continuously be tried to be zswapped out, and
> > burn CPU cycles for compression attempts that will anyway fail.  One
> > imaginable solution for the problem is reusing the swapped-out page and
> > its struct page to store in the zswap pool.  But that's out of the scop=
e
> > of this patch.
> >
> > [1] https://github.com/sjp38/eval_zswap/blob/master/run.sh
> > [2] https://lore.kernel.org/20231017003519.1426574-3-nphamcs@gmail.com
> > [3] https://lore.kernel.org/20240706022523.1104080-6-flintglass@gmail.c=
om
> > [4] https://lore.kernel.org/CAJD7tkZXS-UJVAFfvxJ0nNgTzWBiqepPYA4hEozi01=
_qktkitg@mail.gmail.com
> >
> > Suggested-by: Nhat Pham <nphamcs@gmail.com>
> > Suggested-by: Takero Funaki <flintglass@gmail.com>
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> > Changes from v1
> > (https://lore.kernel.org/20250807181616.1895-1-sj@kernel.org)
> > - Optimize out memcpy() per incompressible page saving, using
> >   k[un]map_local().
> > - Add a debugfs file for counting compression failures.
> > - Use a clear form of a ternary operation.
> > - Add the history of writeback disabling with a link.
> > - Wordsmith comments.
> >
> > Changes from RFC v2
> > (https://lore.kernel.org/20250805002954.1496-1-sj@kernel.org)
> > - Fix race conditions at decompressed pages identification.
> > - Remove the parameter and make saving as-is the default behavior.
> > - Open-code main changes.
> > - Clarify there is no memory management changes on the cover letter.
> > - Remove 20% pressure case from test results, since it is arguably too
> >   extreme and only adds confusion.
> > - Drop RFC tag.
> >
> > Changes from RFC v1
> > (https://lore.kernel.org/20250730234059.4603-1-sj@kernel.org)
> > - Consider PAGE_SIZE compression successes as failures.
> > - Use zpool for storing incompressible pages.
> > - Test with zswap shrinker enabled.
> > - Wordsmith changelog and comments.
> > - Add documentation of save_incompressible_pages parameter.
> >
> >  mm/zswap.c | 36 ++++++++++++++++++++++++++++++++++--
> >  1 file changed, 34 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 3c0fd8a13718..0fb940d03268 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -60,6 +60,8 @@ static u64 zswap_written_back_pages;
> >  static u64 zswap_reject_reclaim_fail;
> >  /* Store failed due to compression algorithm failure */
> >  static u64 zswap_reject_compress_fail;
> > +/* Compression into a size of <PAGE_SIZE failed */
> > +static u64 zswap_compress_fail;
> >  /* Compressed page was too big for the allocator to (optimally) store =
*/
> >  static u64 zswap_reject_compress_poor;
> >  /* Load or writeback failed due to decompression failure */
> > @@ -976,8 +978,26 @@ static bool zswap_compress(struct page *page, stru=
ct zswap_entry *entry,
> >          */
> >         comp_ret =3D crypto_wait_req(crypto_acomp_compress(acomp_ctx->r=
eq), &acomp_ctx->wait);
> >         dlen =3D acomp_ctx->req->dlen;
> > -       if (comp_ret)
> > -               goto unlock;
> > +
> > +       /*
> > +        * If a page cannot be compressed into a size smaller than PAGE=
_SIZE,
> > +        * save the content as is without a compression, to keep the LR=
U order
> > +        * of writebacks.  If writeback is disabled, reject the page si=
nce it
> > +        * only adds metadata overhead.  swap_writeout() will put the p=
age back
> > +        * to the active LRU list in the case.
> > +        */
> > +       if (comp_ret || dlen >=3D PAGE_SIZE) {
> > +               zswap_compress_fail++;
>
> I feel that mixing comp_ret and dlen size if tested here complicates
> the nested if statement and the behavior as well.
> One behavior change is that, if the comp_ret !=3D 0, it means the
> compression crypt engine has some error. e.g. have some bad chip
> always fail the compression. That is a different error case than the
> compression was successful and the compression rate is not good. In
> this case the patch makes the page store in zpool for cryto engine
> failure, which does not help.
>
> Is there any reason you want to store the page in zpool when the
> compression engine (not the ratio) fails?

It helps if you want to write them back to disk later, in the LRU
order. SJ pointed that out in the patch changelog, I believe.

