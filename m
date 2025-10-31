Return-Path: <linux-kernel+bounces-879567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DF3C237BC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A63C3B7658
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 06:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F2130CDA9;
	Fri, 31 Oct 2025 06:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ms1nzK0C"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7472834D3B1
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 06:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761893978; cv=none; b=MEIA6uGwbsDLNmCxoX4yLMkxKgQmdiLiQsLrLb3rEFue9VgYO3l5XX/pE8McOxhDfeSivdNa4PHGw6YANWy3UfpvYr1XAbd65WOkI0YVXzA8bkt4zjM58Ah7lIQrYvwkA7US45R75UekYvafwQWNBNy/YMEQzEPnJ5IYFEh1xg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761893978; c=relaxed/simple;
	bh=9BtHEqneFzU9QLRal6pIwf+tE4qGkklVwsPKkao5v08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KcY5ui1te901eF6ppDyoOuy8EkU06bax8pLraMtqrg9Y1vues04rSlOCx2+pQsLlfxEGFjLrz1kfX9xdIK5Eocoo3V5iIZHF9m4zIChx8E4u+sDiH33pjT0IlVgK7nQ1xTHyRxhK05dw79iNPmqrH/0zvzi1fHMubZgxnGUmSjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ms1nzK0C; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63c4f1e7243so2895831a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 23:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761893975; x=1762498775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bonxoFN411G1mtJ9G7HJf6xneNKoAlfM/6PZsK2PYNc=;
        b=ms1nzK0CoF89uom4Gjb7FaZrsYmkiYRMZZ/T080DjB51X+c60kte+rxgGQBV5PL7ce
         4mHJ3K9BfkqqAFuToQX5x7L+71tYbuN0IGpbBEJEEt5dznbpNp+CPU1jWrsRcEC7N8tm
         3QGpT3sXkVv3b/0cdb0mLoYZ0bKaKarB09U15lB8rE06hgAG5nlubTrm/6nERc7DXHpu
         Baai/aXTpocQU1/SER6lWZZ5i/f/vmUye+lDNvPCvHdBlRpDiVUAix609n60tuniwK9G
         Gfv0SftaKJ5w/J23cY7mxEAKWjgv+Umm7ooJ73Ysk49PsVCm6ebTHvWD8bdffAnabvxi
         //4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761893975; x=1762498775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bonxoFN411G1mtJ9G7HJf6xneNKoAlfM/6PZsK2PYNc=;
        b=lJpZ727pAOatzzmISIG97orah1YNQVXdQAkaEt2B5LVw5Ug56OP8sItsOzKh+2uadz
         L90A8hA0EDdux/FHN8tA3CEYKjJPrKG7Fc0z8hXYJ2lwBdzjwTnl7GxyhgkUHrxUO1IE
         a9bzfOYceHmfhMsDm7G2QCwRU5cGMFdZKvDFXTI8TKb7+WQmJhHD+y3fOGAll2iLaIm0
         qaxwtbeQ6pMD8pGAmHqnprW7S0O27jCTFWu+UBU1keYh3rgdjToe1GXjXMxkJLGsW/z/
         o2tSPREYQjghP1/iut2f2hZbavXHP69vFqdHsQ+990gaUnXobBwCZG0UfmO+pi/23qLE
         KmDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUeRN8DqDvJb59FUObfxbb/N3OJ6DICab1Lt8J70Qn53GVSJON0bAakiIK37nzFfKAwS4xSRxDeYGn5xo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRteFqioNDnBdgO8yD/6Otc1K/sacTQ55zmGtLJrbjU2y5hjXX
	DQI+D1koGmSwKI60YrW3GRNkBRQU0U0Z8kMvF6grrKh2MFjhyg3a+epkKO7+dnFyoPcBPHT+3hW
	XGTO95Ffzftcrd74Yl1/EoXud1yFkkBc=
X-Gm-Gg: ASbGncv9KEXabGXDIIuyTsYXmaE3ZJB1mwFpuyPmkOgRINAr2MeXWAxh8FNyFQUkEHy
	uDWVAJxlnrGcBQRNEk6GlwDSMBV1wQ7CS54evNN9fv+C2WDDxXJYO0oPmWWyiQXrVcDsFacRZtJ
	HqCewhKejgWm4ZICwn4N3y+nsLTxMoHmn4F25CgrAwWt06j+1TdgwH1EzyRL523SOP21QjvcIkc
	KzOcUVoYKKTBhQmvkhS6kGfN2vwQDvyDJnTGCgx2GMmRkqFbcRNjHUbymYl
X-Google-Smtp-Source: AGHT+IHGr1hi2b+pfVxXmRcZv7A2p33ANK3bqTjSjN3kzwzBVtrMI2IKzUdQ/4oNe6YhVGFoplORFbICYJmdH9bYSvE=
X-Received: by 2002:a05:6402:3494:b0:634:a8fb:b91d with SMTP id
 4fb4d7f45d1cf-64076de1816mr1872200a12.0.1761893974392; Thu, 30 Oct 2025
 23:59:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com> <bvavihwrtkbnsqgjbotwihckxzmnhdd4e6jre4j7xdiyyeyv5o@dnnuyacthvms>
In-Reply-To: <bvavihwrtkbnsqgjbotwihckxzmnhdd4e6jre4j7xdiyyeyv5o@dnnuyacthvms>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 31 Oct 2025 14:58:58 +0800
X-Gm-Features: AWmQ_bngUH51OPE8Nr1L_1C4UgHIWE6Hp2m_74eI1jG787uNXrEWhtGWTucSHxA
Message-ID: <CAMgjq7AC9D6nOcU46ceWcLxCcPp=dezeOeaoMwsdHdSsLp85Ew@mail.gmail.com>
Subject: Re: [PATCH 00/19] mm, swap: never bypass swap cache and cleanup flags
 (swap table phase II)
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Youngjun Park <youngjun.park@lge.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 7:05=E2=80=AFAM Yosry Ahmed <yosry.ahmed@linux.dev>=
 wrote:
>
> On Wed, Oct 29, 2025 at 11:58:26PM +0800, Kairui Song wrote:
> > This series removes the SWP_SYNCHRONOUS_IO swap cache bypass code and
> > special swap bits including SWAP_HAS_CACHE, along with many historical
> > issues. The performance is about ~20% better for some workloads, like
> > Redis with persistence. This also cleans up the code to prepare for
> > later phases, some patches are from a previously posted series.
> >
> > Swap cache bypassing and swap synchronization in general had many
> > issues. Some are solved as workarounds, and some are still there [1]. T=
o
> > resolve them in a clean way, one good solution is to always use swap
> > cache as the synchronization layer [2]. So we have to remove the swap
> > cache bypass swap-in path first. It wasn't very doable due to
> > performance issues, but now combined with the swap table, removing
> > the swap cache bypass path will instead improve the performance,
> > there is no reason to keep it.
> >
> > Now we can rework the swap entry and cache synchronization following
> > the new design. Swap cache synchronization was heavily relying on
> > SWAP_HAS_CACHE, which is the cause of many issues. By dropping the usag=
e
> > of special swap map bits and related workarounds, we get a cleaner code
> > base and prepare for merging the swap count into the swap table in the
> > next step.
> >
> > Test results:
> >
> > Redis / Valkey bench:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Testing on a ARM64 VM 1.5G memory:
> > Server: valkey-server --maxmemory 2560M
> > Client: redis-benchmark -r 3000000 -n 3000000 -d 1024 -c 12 -P 32 -t ge=
t
> >
> >         no persistence              with BGSAVE
> > Before: 460475.84 RPS               311591.19 RPS
> > After:  451943.34 RPS (-1.9%)       371379.06 RPS (+19.2%)
> >
> > Testing on a x86_64 VM with 4G memory (system components takes about 2G=
):
> > Server:
> > Client: redis-benchmark -r 3000000 -n 3000000 -d 1024 -c 12 -P 32 -t ge=
t
> >
> >         no persistence              with BGSAVE
> > Before: 306044.38 RPS               102745.88 RPS
> > After:  309645.44 RPS (+1.2%)       125313.28 RPS (+22.0%)
> >
> > The performance is a lot better when persistence is applied. This shoul=
d
> > apply to many other workloads that involve sharing memory and COW. A
> > slight performance drop was observed for the ARM64 Redis test: We are
> > still using swap_map to track the swap count, which is causing redundan=
t
> > cache and CPU overhead and is not very performance-friendly for some
> > arches. This will be improved once we merge the swap map into the swap
> > table (as already demonstrated previously [3]).
> >
> > vm-scabiity
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > usemem --init-time -O -y -x -n 32 1536M (16G memory, global pressure,
> > simulated PMEM as swap), average result of 6 test run:
> >
> >                            Before:         After:
> > System time:               282.22s         283.47s
> > Sum Throughput:            5677.35 MB/s    5688.78 MB/s
> > Single process Throughput: 176.41 MB/s     176.23 MB/s
> > Free latency:              518477.96 us    521488.06 us
> >
> > Which is almost identical.
> >
> > Build kernel test:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Test using ZRAM as SWAP, make -j48, defconfig, on a x86_64 VM
> > with 4G RAM, under global pressure, avg of 32 test run:
> >
> >                 Before            After:
> > System time:    1379.91s          1364.22s (-0.11%)
> >
> > Test using ZSWAP with NVME SWAP, make -j48, defconfig, on a x86_64 VM
> > with 4G RAM, under global pressure, avg of 32 test run:
> >
> >                 Before            After:
> > System time:    1822.52s          1803.33s (-0.11%)
> >
> > Which is almost identical.
> >
> > MySQL:
> > =3D=3D=3D=3D=3D=3D
> > sysbench /usr/share/sysbench/oltp_read_only.lua --tables=3D16
> > --table-size=3D1000000 --threads=3D96 --time=3D600 (using ZRAM as SWAP,=
 in a
> > 512M memory cgroup, buffer pool set to 3G, 3 test run and 180s warm up)=
.
> >
> > Before: 318162.18 qps
> > After:  318512.01 qps (+0.01%)
> >
> > In conclusion, the result is looking better or identical for most cases=
,
> > and it's especially better for workloads with swap count > 1 on SYNC_IO
> > devices, about ~20% gain in above test. Next phases will start to merge
> > swap count into swap table and reduce memory usage.
> >
> > One more gain here is that we now have better support for THP swapin.
> > Previously, the THP swapin was bound with swap cache bypassing, which
> > only works for single-mapped folios. Removing the bypassing path also
> > enabled THP swapin for all folios. It's still limited to SYNC_IO
> > devices, though, this limitation can will be removed later. This may
> > cause more serious thrashing for certain workloads, but that's not an
> > issue caused by this series, it's a common THP issue we should resolve
> > separately.
> >
> > Link: https://lore.kernel.org/linux-mm/CAMgjq7D5qoFEK9Omvd5_Zqs6M+TEoG0=
3+2i_mhuP5CQPSOPrmQ@mail.gmail.com/ [1]
> > Link: https://lore.kernel.org/linux-mm/20240326185032.72159-1-ryncsn@gm=
ail.com/ [2]
> > Link: https://lore.kernel.org/linux-mm/20250514201729.48420-1-ryncsn@gm=
ail.com/ [3]
> >
> > Suggested-by: Chris Li <chrisl@kernel.org>
> > Signed-off-by: Kairui Song <kasong@tencent.com>
>
> Unfortunately I don't have time to go through the series and review it,
> but I wanted to just say awesome work here. The special cases in the
> swap code to avoid using the swapcache have always been a pain.
>
> In fact, there's one more special case that we can probably remove in
> zswap_load() now, the one introduced by commit 25cd241408a2 ("mm: zswap:
> fix data loss on SWP_SYNCHRONOUS_IO devices").

Thanks! Oh, now I remember that one, it can be removed indeed. There
are several more cleanup and optimizations that can be done after this
series, it's getting too long already so I didn't include everything.

But removing 25cd241408a2 is easy to do and easy to review, I can
include it in the next update.

