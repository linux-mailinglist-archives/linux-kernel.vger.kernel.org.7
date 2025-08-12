Return-Path: <linux-kernel+bounces-765447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A16B235BA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57EAD7BAD7F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51C02FF163;
	Tue, 12 Aug 2025 18:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUzX9CN6"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027632FF160
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 18:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755024784; cv=none; b=UudJqKzipK1q82PHPM8IeYdJWOhOJhfVgmh0zuTCVoNLE5B+sZeChVYqllI8e7puqJYgsMgIeJ1eEh4FlUgfsFx1Gm5mzS/tmnfCA45xa+r40kUEJmKutAVC/R1FeLFYHTYszkzB3BSguTpskkT8XPKdyoSDUq+QBwdAv3yMgco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755024784; c=relaxed/simple;
	bh=YghnqfOerNM01uQ2+EaOBBDHEmJD73U2igD4Vu0RBRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6NDNpZyoiSqtlYhjT39mpeMmbK8NQffQRhABonfvbiLxhdy8ey75Jehm48o8Jb6M6cazV+CPgpYz5FA5KhOlvDAKO2YcosJTOS5e4Fg6l8OTfbMkGsDw4LUZhW9kSiX8fp/6uv5jJyl9ui6Gt72DGXZgPPXpWKKeqkBmzkpVzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUzX9CN6; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-8817b8d2d0eso197933239f.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 11:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755024782; x=1755629582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84nI/MGeGp9rr+2mbYdPCJy5541yv4hPY1ah4+PSWJc=;
        b=VUzX9CN6xbEbvCNUFb4Ty0fRh4uKblAnEpqedmu4YJ7cEJnlxj7I2vz7ec1g4hgjZh
         QrljMGo6NvV5hFCUFZhKnxY/UB6SCSpIskPVvrSsrMjKb5b17WoCxjz09hbihyapIiJm
         Js67ooj7eYCFd67+2v7jBNto5yFzzE9qyrTDlG+ylKns5QXu3IkFeKSsd8rZ3nRxP537
         RNXmVr9GYv4DPi84nlyzdw6P9r2wxBzvw2QYhiF0o+fiXrDOvScOMSq5Z3pHIp61i8ng
         U4sp93ZSk/6w3nJRaUixYwu9CObFmJSdGeBHxeUygDN6t8sTj4bTAE5krSVXmpgPZ+lq
         zXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755024782; x=1755629582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=84nI/MGeGp9rr+2mbYdPCJy5541yv4hPY1ah4+PSWJc=;
        b=mVHeoDYI3B9mngqHUl8jInSQvGk5rOipdjcal/uxlnsLVAtjewEg/DbWOxTgLa3KEW
         9mD1Mrvep+7+UKsoYuV5HjGW16c7yhPSL0B59HLaCr529sVUEsf3FVwP9lhkUl9s5z7r
         mL0x9cOYjEg1gYPD96p1tYeNCeYiqjhuTj+zaS5zYR6T/WdexQr6EmAGDbb7RGETZ3I6
         8LGxlnaYaLcMkmNO3C7gJct2EmrWYkxEMYTUC6/5uGAbzu6JmzjhFCqjvfmYW1lo6ox5
         50kRLxUaf/dUZOdM/Lu//QwnVyK4Sz5h0ktw+VdPTcRrN74PFeJsbqBnubL9Zl8dfhfE
         8Znw==
X-Forwarded-Encrypted: i=1; AJvYcCXfpObuGNkGaYjxKH68xNJHrieALDyNP2OYzI4Mn/6t8jIxlmMOhAsRKyv0cL/zaXftH8sraRk38oyl7QY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbmmgZs6zDd1oV0rWnTWT/BqziaaNQougycTsXpNmkvbtGhUc7
	MUtkkgpsTw3zCIYNBfh+QWx6dwrb+hwSgtgwYPUMIVi4Uu16HlXPgODO9sL31IM+bg0DsHtH8ju
	mBLeoQ+KZOtF3rwsmXfkZZ6ZN1aAt64c=
X-Gm-Gg: ASbGncuBtDPcaJJorlmSXsLh+radG1/ZeGdNS4b9lzEgIoCezyGlqGioA/VGfcfkOuX
	NcjOqiAI53CLzKDndf6WVPOy0e3deWAZQYAXsbkEBAXH21++PkO0kecSpVQ/X2wXAYqbFfybs6a
	U2wapBLHqXVorPM//3A15TevmWNw2EQWdZTPhI12nVYLgUFqRyv75RJx+UEDGT9C0qUXTTh97ws
	TnW
X-Google-Smtp-Source: AGHT+IFZq2uXSn511PC7hnm8fMyDqEVmE5Td+oKPsz7r9QNsLauOAV/Zk5wOUF7yJGrCUsoR4hWfj6h4w+Tfk868jgc=
X-Received: by 2002:a05:6e02:19cb:b0:3e5:4b2e:3b02 with SMTP id
 e9e14a558f8ab-3e567260ed3mr3484605ab.0.1755024781709; Tue, 12 Aug 2025
 11:53:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812170046.56468-1-sj@kernel.org>
In-Reply-To: <20250812170046.56468-1-sj@kernel.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 12 Aug 2025 11:52:50 -0700
X-Gm-Features: Ac12FXwIsLOyoa1vNGfMPpXo700C4eZd_F_UHAymOv6ARngqzldGZx6Jx_qfgUQ
Message-ID: <CAKEwX=O2ZgRycpOiLAWNdyaEY_UE=8X-unJCaMmMvL-4DGZreQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/zswap: store <PAGE_SIZE compression failed page as-is
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	David Hildenbrand <david@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Takero Funaki <flintglass@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 10:00=E2=80=AFAM SeongJae Park <sj@kernel.org> wrot=
e:
>
> When zswap writeback is enabled and it fails compressing a given page,
> the page is swapped out to the backing swap device.  This behavior
> breaks the zswap's writeback LRU order, and hence users can experience
> unexpected latency spikes.  If the page is compressed without failure,
> but results in a size of PAGE_SIZE, the LRU order is kept, but the
> decompression overhead for loading the page back on the later access is
> unnecessary.
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
> list in the case.
>
> Knowing how many compression failures happened will be useful for future
> investigations.  investigations.  Add a new debugfs file, compress_fail,
> for the purpose.
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
> For all zswap enabled cases, zswap shrinker is enabled.
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
> Historically, writeback disabling was introduced partially as a way to
> solve the LRU order issue.  Yosry pointed out[4] this is still
> suboptimal when the incompressible pages are cold, since the
> incompressible pages will continuously be tried to be zswapped out, and
> burn CPU cycles for compression attempts that will anyway fail.  One
> imaginable solution for the problem is reusing the swapped-out page and
> its struct page to store in the zswap pool.  But that's out of the scope
> of this patch.
>
> [1] https://github.com/sjp38/eval_zswap/blob/master/run.sh
> [2] https://lore.kernel.org/20231017003519.1426574-3-nphamcs@gmail.com
> [3] https://lore.kernel.org/20240706022523.1104080-6-flintglass@gmail.com
> [4] https://lore.kernel.org/CAJD7tkZXS-UJVAFfvxJ0nNgTzWBiqepPYA4hEozi01_q=
ktkitg@mail.gmail.com
>
> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> Suggested-by: Takero Funaki <flintglass@gmail.com>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
> Changes from v1
> (https://lore.kernel.org/20250807181616.1895-1-sj@kernel.org)
> - Optimize out memcpy() per incompressible page saving, using
>   k[un]map_local().
> - Add a debugfs file for counting compression failures.
> - Use a clear form of a ternary operation.
> - Add the history of writeback disabling with a link.
> - Wordsmith comments.
>
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
>  mm/zswap.c | 36 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)

I'll let Johannes chime in as well, but LGTM.

Acked-by: Nhat Pham <nphamcs@gmail.com>

Thanks!

