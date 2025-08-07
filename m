Return-Path: <linux-kernel+bounces-759582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A4BB1DFAE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 01:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5486D1AA3874
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 23:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4EF2192FA;
	Thu,  7 Aug 2025 23:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDs6hdk/"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2838C35898
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 23:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754607849; cv=none; b=ltkdjsCjKiLhGcliKSB5HVMKzes3UXv9yQHhsp6Q0X0kcuDe6bWqi6lTZTRbsauY2ip6YnTr9Dfw6zRsRCjV9PqKCE8zLh6J1Gceq5xYKBkrMtUuIkCftpvR+7/sYqSKqUAQTh/dF+9apAt0se8E2KLeLPR4hEO+GxM1kjgA3hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754607849; c=relaxed/simple;
	bh=v/FTxifgp3c8C+qgGI2fGx8ZbWulKLuHt809JWWqgKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l29cNUcUlBXnfm6kOCvN71etV6wJcGbJd129GJU9tEjGtBB7pldl3+TxdGZsyanh8ZMlHGkx+TDOzZIc/2t+BmAoPpyF7EFPT5yFaup3zM8mxWpPYsL6ruqnRn0OfqEzV3m+FKJpk8LdlRD9jqwFW04yVlUkWbWkeS1Ga/YDP0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDs6hdk/; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-87c0166df31so81280039f.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 16:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754607846; x=1755212646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrNipFeLpq6UgP5HYhuOb8lY4sW9AdQWYKf2OVt0juY=;
        b=mDs6hdk/rpjGF48YOymEKX0Tzk4B+GjR06sZJCrZWW2nhr0GbYdS+C9gUU4tlSb9RY
         yDho+ugyG66FgwDoAe5H69wTsZkff5uGyhzjNCiLisEbHyVwlDhW8dT0kZrKlMnBxUPZ
         ne6wZ7NQ5Paf0ZmS/KboKrkXYk3AAVuCrbV+OsXkYJw1OpzCoXEGTZ65LRgROMXdNUFR
         8G8srXB4dvZE7fLrGxS0Vkuj5HSSnLFZaTp0dpqV5uc/Jypa46l+COFLkaqgA8B7pzW4
         DS5cm9nBirt9Ba3Miju1w2zt8sMYnG7I/nOFy/chN/zKNX5bgnK5YloDyz2d4dH6ftiy
         nwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754607846; x=1755212646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MrNipFeLpq6UgP5HYhuOb8lY4sW9AdQWYKf2OVt0juY=;
        b=wF4oyLqZO1gik2KHzxcSRDe/eXfkWsCKM4VW3Zx5JgPf+H1XmT3zgkTQBqufsGb8YA
         9ARCanwQKAmIGxtKd1CXxaDQFCrHOXMkGtx7BkMHflpcF4YALK5FVqxGvSwbNu5R0FqW
         6/Rh/uXnwv9xZZSeCbhI27+eimdP2e7Qh3wACC8nCiiEygRxO9Ajrfc0w8XUsdoxVQtY
         Xpg4jOoo9yejbjHlQIoTlFCViwX76NYtFElhOpGB6Rg5uR2yjoeWrXiUU4u+iwADvT7f
         8zSOiL/CmjuIBmW5LnprBl8HGc1LJKQzO7lkCU9zsJlWmFv4r7EsyMijHzfZ0bDyXMUc
         FYGA==
X-Forwarded-Encrypted: i=1; AJvYcCVAtA+GMacXD7U/VDzNhTISdHF0w3ZaEBikoUkvexwVc+D4bfA01MLQ9LTRQ2U4tgmrdQWtgCPen4wL9LE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Q4V0h5tHeR71YhtD5oVJ8QIl1WMxUneGSAoNfX7aEjwwHvvK
	BFTD//1g6HKHTpH7/2LbAOHEYUtO3HGwNjO12hRgtZW6JTjBhXB6IzpqXejrn/lwXAKDdO4Dvba
	+k+1fWL720w6RRUMvrkJIqzydUR6PRA0=
X-Gm-Gg: ASbGncuxfJPaQBst5rDyZK8h6AdSjGPeJvxwm/NDGPpG6WSxWEHOLvPRXbqShueHhuO
	mQJhsN0rqUJk7VpSiiTjxdj3ND/4NdRXpbqdtE5sWT7eOhTnN7kgSzsmmMKQQkS1T8JnYs6Nrxk
	zBxf4j15lPlewoNQQsP0WQd+7YMS11IGdQvxhZncXY08fICLktf/EQGITSPNdZf5Kwxr9diLHjF
	iLhYMI=
X-Google-Smtp-Source: AGHT+IHzCce16jMONBYZgK4Xchaa92Tf2pNW7UGvTsjjnXWLsSszeIN1SNg2ryPEbiZZkMOvJs7XZq+TehJ7wEjx9XY=
X-Received: by 2002:a05:6e02:250c:b0:3e5:1a42:8cf3 with SMTP id
 e9e14a558f8ab-3e5331676damr20504855ab.21.1754607845931; Thu, 07 Aug 2025
 16:04:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807181616.1895-1-sj@kernel.org>
In-Reply-To: <20250807181616.1895-1-sj@kernel.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 7 Aug 2025 16:03:54 -0700
X-Gm-Features: Ac12FXzGdfX3pnCo_8_UE28mRL8KvhR1z0p1nq4sERc8-YyjVEwnxubQXWWkYe0
Message-ID: <CAKEwX=Nm08xZVR0Zk2fOvXBmeWe5wggvTXN6+hD84S7T9L=eBQ@mail.gmail.com>
Subject: Re: [PATCH] mm/zswap: store <PAGE_SIZE compression failed page as-is
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	David Hildenbrand <david@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Takero Funaki <flintglass@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 11:16=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote=
:
>
> When zswap writeback is enabled and it fails compressing a given page,
> the page is swapped out to the backing swap device.  This behavior
> breaks the zswap's writeback LRU order, and hence users can experience
> unexpected latency spikes.  If the page is compressed without failure,
> but results in a size of PAGE_SIZE, the LRU order is kept, but the
> decompression overhead for loading the page back on the later access is
> unnecessary.

Maybe add the writeback disabled story - we added to get around this
latency issue, but that solution was not satisfactory either: wasting
cpu cycles retrying incompressible pages, especially when we're under
reclaim/memory pressure, and we've reclaimed most if not all other
sources.

This problem was pointed out by Yosry:

https://lore.kernel.org/all/CAJD7tkZXS-UJVAFfvxJ0nNgTzWBiqepPYA4hEozi01_qkt=
kitg@mail.gmail.com/

>
> Keep the LRU order and optimize unnecessary decompression overheads in
> those cases, by storing the original content as-is in zpool.  The length
> field of zswap_entry will be set appropriately, as PAGE_SIZE,  Hence
> whether it is saved as-is or not (whether decompression is unnecessary)
> is identified by 'zswap_entry->length =3D=3D PAGE_SIZE'.
>
> Because the uncompressed data is saved in zpool, same to the compressed
> ones, this introduces no change in terms of memory management including
> movability and migratability of involved pages.
>
> This change is also not increasing per zswap entry metadata overhead.
> But as the number of incompressible pages increases, total zswap
> metadata overhead is proportionally increased.  The overhead should not
> be problematic in usual cases, since the zswap metadata for single zswap
> entry is much smaller than PAGE_SIZE, and in common zswap use cases
> there should be a sufficient amount of compressible pages.  Also it can
> be mitigated by the zswap writeback.
>
> When the writeback is disabled, the additional overhead could be
> problematic.  For the case, keep the current behavior that just returns
> the failure and let swap_writeout() put the page back to the active LRU
> list in the case.  It is known to be suboptimal when the incompressible
> pages are cold, since the incompressible pages will continuously be
> tried to be zswapped out, and burn CPU cycles for compression attempts
> that will anyway fails.  One imaginable solution for the problem is
> reusing the swapped-out page and its struct page to store in the zswap
> pool.  But that's out of the scope of this patch.
>
> Tests
> -----
>
> I tested this patch using a simple self-written microbenchmark that is
> available at GitHub[1].  You can reproduce the test I did by executing
> run_tests.sh of the repo on your system.  Note that the repo's
> documentation is not good as of this writing, so you may need to read
> and use the code.
>
> The basic test scenario is simple.  Run a test program making artificial
> accesses to memory having artificial content under memory.high-set
> memory limit and measure how many accesses were made in given time.
>
> The test program repeatedly and randomly access three anonymous memory
> regions.  The regions are all 500 MiB size, and accessed in the same
> probability.  Two of those are filled up with a simple content that can
> easily be compressed, while the remaining one is filled up with a
> content that read from /dev/urandom, which is easy to fail at
> compressing to <PAGE_SIZE size.  The program runs for two minutes and
> prints out the number of accesses made every five seconds.
>
> The test script runs the program under below seven configurations.
>
> - 0: memory.high is set to 2 GiB, zswap is disabled.
> - 1-1: memory.high is set to 1350 MiB, zswap is disabled.
> - 1-2: On 1-1, zswap is enabled without this patch.
> - 1-3: On 1-2, this patch is applied.
>
> For all zswap enabled case, zswap shrinker is enabled.
>
> Configuration '0' is for showing the original memory performance.
> Configurations 1-1, 1-2 and 1-3 are for showing the performance of swap,
> zswap, and this patch under a level of memory pressure (~10% of working
> set).
>
> Because the per-5 seconds performance is not very reliable, I measured
> the average of that for the last one minute period of the test program
> run.  I also measured a few vmstat counters including zswpin, zswpout,
> zswpwb, pswpin and pswpout during the test runs.
>
> The measurement results are as below.  To save space, I show performance
> numbers that are normalized to that of the configuration '0' (no memory
> pressure), only.  The averaged accesses per 5 seconds of configuration
> '0' was 36493417.75.
>
>     config            0       1-1     1-2      1-3
>     perf_normalized   1.0000  0.0057  0.0235   0.0367
>     perf_stdev_ratio  0.0582  0.0652  0.0167   0.0346
>     zswpin            0       0       3548424  1999335
>     zswpout           0       0       3588817  2361689
>     zswpwb            0       0       10214    340270
>     pswpin            0       485806  772038   340967
>     pswpout           0       649543  144773   340270
>
> 'perf_normalized' is the performance metric, normalized to that of
> configuration '0' (no pressure).  'perf_stdev_ratio' is the standard
> deviation of the averaged data points, as a ratio to the averaged metric
> value.  For example, configuration '0' performance was showing 5.8%
> stdev.  Configurations 1-1 and 1-3 were having about 6.5% and 6.1%
> stdev.  Also the results were highly variable between multiple runs.  So
> this result is not very stable but just showing ball park figures.
> Please keep this in your mind when reading these results.
>
> Under about 10% of working set memory pressure, the performance was
> dropped to about 0.57% of no-pressure one, when the normal swap is used
> (1-1).  Note that ~10% working set pressure is already extreme, at least
> on this test setup.  No one would desire system setups that can degrade
> performance to 0.57% of the best case.
>
> By turning zswap on (1-2), the performance was improved about 4x,
> resulting in about 2.35% of no-pressure one.  Because of the
> incompressible pages in the third memory region, a significant amount of
> (non-zswap) swap I/O operations were made, though.
>
> By applying this patch (1-3), about 56% performance improvement was
> made, resulting in about 3.67% of no-pressure one.  Reduced pswpin of
> 1-3 compared to 1-2 let us see where this improvement came from.

Nice.

>
> Related Works
> -------------
>
> This is not an entirely new attempt.  Nhat Pham and Takero Funaki tried
> very similar approaches in October 2023[2] and April 2024[3],
> respectively.  The two approaches didn't get merged mainly due to the
> metadata overhead concern.  I described why I think that shouldn't be a
> problem for this change, which is automatically disabled when writeback
> is disabled, at the beginning of this changelog.
>
> This patch is not particularly different from those, and actually built
> upon those.  I wrote this from scratch again, though.  Hence adding
> Suggested-by tags for them.  Actually Nhat first suggested this to me
> offlist.
>
> [1] https://github.com/sjp38/eval_zswap/blob/master/run.sh
> [2] https://lore.kernel.org/20231017003519.1426574-3-nphamcs@gmail.com
> [3] https://lore.kernel.org/20240706022523.1104080-6-flintglass@gmail.com
>
> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> Suggested-by: Takero Funaki <flintglass@gmail.com>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
> Changes from RFC v2
> (https://lore.kernel.org/20250805002954.1496-1-sj@kernel.org)
> - Fix race conditions at decompressed pages identification.
> - Remove the parameter and make saving as-is the default behavior.
> - Open-code main changes.
> - Clarify there is no memory management changes on the cover letter.
> - Remove 20% pressure case from test results, since it is arguably too
>   extreme and only adds confusion.
> - Drop RFC tag.
>
> Changes from RFC v1
> (https://lore.kernel.org/20250730234059.4603-1-sj@kernel.org)
> - Consider PAGE_SIZE compression successes as failures.
> - Use zpool for storing incompressible pages.
> - Test with zswap shrinker enabled.
> - Wordsmith changelog and comments.
> - Add documentation of save_incompressible_pages parameter.
>
>  mm/zswap.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 3c0fd8a13718..2db2da130ec4 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -976,8 +976,25 @@ static bool zswap_compress(struct page *page, struct=
 zswap_entry *entry,
>          */
>         comp_ret =3D crypto_wait_req(crypto_acomp_compress(acomp_ctx->req=
), &acomp_ctx->wait);
>         dlen =3D acomp_ctx->req->dlen;
> -       if (comp_ret)
> -               goto unlock;
> +
> +       /*
> +        * If a page cannot be compressed into a size smaller than PAGE_S=
IZE,
> +        * save the content as is without a compression, to keep the LRU =
order
> +        * of writebacks.  If writeback is disabled, reject the page sinc=
e it
> +        * only adds metadata overhead.  swap_writeout() will put the pag=
e back
> +        * to the active LRU list in the case.
> +        */
> +       if (comp_ret || dlen >=3D PAGE_SIZE) {
> +               if (mem_cgroup_zswap_writeback_enabled(
> +                                       folio_memcg(page_folio(page)))) {
> +                       comp_ret =3D 0;
> +                       dlen =3D PAGE_SIZE;
> +                       memcpy_from_page(dst, page, 0, dlen);

I wonder if we can save one memcpy here. Would it be safe to map the page:

dst =3D kmap_local_page(page);

then, after we're done with storing (i.e after zpool_obj_write()), do:

if (dlen =3D=3D PAGE_SIZE)
    kunmap(dst);

(don't forget to unmap the page in the failure paths too!)

> +               } else {
> +                       comp_ret =3D comp_ret ? : -EINVAL;

Does this keep the value of comp_ret if comp_ret !=3D 0 lol. Syntax
looks weird to me.

> +                       goto unlock;
> +               }
> +       }

Also, can we fix the counter value?

I assume we want:

else if (comp_ret || dlen =3D=3D PAGE_SIZE)
     zswap_reject_compress_fail++;

or something like that.

And what happened to the incompressible page stored counter? :)


>
>         zpool =3D pool->zpool;
>         gfp =3D GFP_NOWAIT | __GFP_NORETRY | __GFP_HIGHMEM | __GFP_MOVABL=
E;
> @@ -1012,6 +1029,14 @@ static bool zswap_decompress(struct zswap_entry *e=
ntry, struct folio *folio)
>         acomp_ctx =3D acomp_ctx_get_cpu_lock(entry->pool);
>         obj =3D zpool_obj_read_begin(zpool, entry->handle, acomp_ctx->buf=
fer);
>
> +       /* zswap entries of PAGE_SIZE are not compressed. */
of length?


> +       if (entry->length =3D=3D PAGE_SIZE) {
> +               memcpy_to_folio(folio, 0, obj, entry->length);
> +               zpool_obj_read_end(zpool, entry->handle, obj);
> +               acomp_ctx_put_unlock(acomp_ctx);
> +               return true;
> +       }
> +
>         /*
>          * zpool_obj_read_begin() might return a kmap address of highmem =
when
>          * acomp_ctx->buffer is not used.  However, sg_init_one() does no=
t
>
> base-commit: 2ec534125ae474292175ae198483c545eac2161d
> --
> 2.39.5

