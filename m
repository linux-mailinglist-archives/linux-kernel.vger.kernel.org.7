Return-Path: <linux-kernel+bounces-851786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF44BD741E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D76F4E80BB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F983074AA;
	Tue, 14 Oct 2025 04:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKbPRYNa"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5688C1DA62E
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760416301; cv=none; b=ttfP2YCG7LyUTBHGcYJ76j8Zz0mBVYwZ7OEULSrlJYMyfwqvYNd66wezZfKfbozYS0A+7coTX81uD7mfz/deM9YEtuLCYkFC/QtWafD4Rq8s9tYhSX9LxW+++PgZ6pTzEcqYR7OzXABk1Mfr1FEHA52WBZiZp5sR11bVso2rhKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760416301; c=relaxed/simple;
	bh=d2WO01Fcsc8CE0HjUp10UGMCCK0Iw48QSHZld1Ov5ZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NVVL8RPnrHr/aIyQjeFyNyKnyRnRHiXVY+LQtPrcV9+cRTsXedchvdfTWRzSeE6QvlEz4s4N0MGq0+FNKDH9EcMqynkSfJdgGZcqAdY39kI1yl5gDnOiD4plqVD3H5NL74fkWQjKQ5VAg0eYBcFbbz0Ix8MFFf9Z8xjeAMu5Uac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKbPRYNa; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-856701dc22aso693956285a.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 21:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760416299; x=1761021099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGqIoZYhEGlF5J9q7UJtMxH13yViEFe+YzUOnnzwEOI=;
        b=FKbPRYNaDrrZraZ8ZDJIVudatb3vaEdWsrcasnwbTZlkJRI+pVOu1jcGqIbtWJ1i3F
         Wv23BaAT8IA1xIcJ8jyQt8kfdgQLULqtoEXpzOWK380Hu1usdViADr8TQ8MF4PpFIIcu
         /ptVAwUwB2siuJiPQkS2MnVzIhA64H/NtqUU/9GR0axoiLI6kiGacAly6dyGBXUQ1GfC
         tVgbwhLB6TNm35VdnyB4Rzpq9v5Ng2dknkES9Pqbf5rUmGJyW1/G91+gir6srxsGIaVp
         o0yUlxsfACBEW3hjEdQwnEUcsaoIC/PvY1QHluATGZrkyT05Fvuy6ES185ptwu9jexnr
         6RSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760416299; x=1761021099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGqIoZYhEGlF5J9q7UJtMxH13yViEFe+YzUOnnzwEOI=;
        b=dpXF1wDv6vTtEgMVoSsiuEulfj3QzVH/3+o9mz0MqObJPJCt29OSPP9iZ8BPCNVk5w
         MhEVLVDDU5iFZzb7vNj/UJtJM40RgYQtabROWld5YLGZTcPDA1SwKFAVdT4BNi7QsUKw
         QeiwGGa1Y7b1zSV9soBIsjoj29DvAzHG4I+UJ4F0psHAtNkiRtFGCgaJtcvIkmZ7/Grg
         g/YVo5PE5MXyEacGxMAg79XcgtuHdLU/jWq2sDZudSsGEkteGpqeqquGB/dVZSCK2whq
         9/IcvD2BfgU4VNExt0bj5cFLKZMchPJfvhXg0ofYPPHtc3pSERNkd5YZPfkwnAKiQMdt
         i40Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtkHiHZzi8eQPGP7JM7H7YYuDTHk2fOxkTHK7TRzywpxSmDLdEdV3nizxGKll49sJ+rr7Z7ZI+Eg/Zm3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxResolOqenBBC1FuCUxza4KR21pUoQPcbWYuXn2Vh3nzNB0FMz
	VTU4XuIe+967BBuGc0/825wRzG+ixQgYqMh2pUuNmgrfkdgpnGPnKbmB7j3Ermcw+xpl2Oujbhk
	i2jrHmeiSbhpbGLERKB5cQnTDkVDprvU=
X-Gm-Gg: ASbGncsfHC5fbypFAtuDvyyVMOnYeifWsF2pJRQaGLHmHrjwrxzAK1pbggeMVoumbvZ
	M4PniT7zqK5HBwreChb4pfki67VCoLsEgYvCC34CgtlJeQZgBb9SCotUrEN1QhYbEyRE5+GFgvT
	s6Z6bpw8belg7myhnJfbv3m7ViJbaWv+NncqsLQRqgIafFPKmSEa2jOvOkklHwU7z2zqOXE0MjI
	DYEVtdXb0Chx9RlBeZP4rxJHdyqWPPuB++a4YFefPqddS94ag07UuJd8ivIOVvME2HO
X-Google-Smtp-Source: AGHT+IEK1Vpz9Egp/lLu8aNOuk9sM4DTRSkzqirUw9B9yuBpU63FECc4XYXC1vijYJUmRARwxWevuR/ubJlXoWz0e5E=
X-Received: by 2002:a05:620a:a119:b0:88b:72c0:aaec with SMTP id
 af79cd13be357-88b72c0b574mr135616185a.88.1760416299121; Mon, 13 Oct 2025
 21:31:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013101636.69220-1-21cnbao@gmail.com> <927bcdf7-1283-4ddd-bd5e-d2e399b26f7d@suse.cz>
 <877bwyxvvl.fsf@linux.dev>
In-Reply-To: <877bwyxvvl.fsf@linux.dev>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 14 Oct 2025 12:31:26 +0800
X-Gm-Features: AS18NWBKX6vcaZdIWLrNvH9v8Z7LxGQUtWG9jfBGvwWNdS5B-18jtKFOlQNZSPg
Message-ID: <CAGsJ_4xpSG1D+nkFUMe-XvmKPGR-CdEi_G881snG-QgZBiFozw@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network buffer allocation
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Jonathan Corbet <corbet@lwn.net>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Huacai Zhou <zhouhuacai@oppo.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Harry Yoo <harry.yoo@oracle.com>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 6:47=E2=80=AFAM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> Vlastimil Babka <vbabka@suse.cz> writes:
>
> > On 10/13/25 12:16, Barry Song wrote:
> >> From: Barry Song <v-songbaohua@oppo.com>
> >>
> >> On phones, we have observed significant phone heating when running app=
s
> >> with high network bandwidth. This is caused by the network stack frequ=
ently
> >> waking kswapd for order-3 allocations. As a result, memory reclamation=
 becomes
> >> constantly active, even though plenty of memory is still available for=
 network
> >> allocations which can fall back to order-0.
> >>
> >> Commit ce27ec60648d ("net: add high_order_alloc_disable sysctl/static =
key")
> >> introduced high_order_alloc_disable for the transmit (TX) path
> >> (skb_page_frag_refill()) to mitigate some memory reclamation issues,
> >> allowing the TX path to fall back to order-0 immediately, while leavin=
g the
> >> receive (RX) path (__page_frag_cache_refill()) unaffected. Users are
> >> generally unaware of the sysctl and cannot easily adjust it for specif=
ic use
> >> cases. Enabling high_order_alloc_disable also completely disables the
> >> benefit of order-3 allocations. Additionally, the sysctl does not appl=
y to the
> >> RX path.
> >>
> >> An alternative approach is to disable kswapd for these frequent
> >> allocations and provide best-effort order-3 service for both TX and RX=
 paths,
> >> while removing the sysctl entirely.
>
> I'm not sure this is the right path long-term. There are significant
> benefits associated with using larger pages, so making the kernel fall
> back to order-0 pages easier and sooner feels wrong, tbh. Without kswapd
> trying to defragment memory, the only other option is to force tasks
> into the direct compaction and it's known to be problematic.

I guess the benefits depend on the hardware: for loopback, they might be
significant, while for slower network devices, order-3 memory may provide
much smaller gains?

On the other hand, I wonder if we could make kcompactd more active when
kswapd is woken for order-3 allocations, instead of reclaiming
order-0 pages to form order-3.

>
> I wonder if instead we should look into optimizing kswapd to be less
> power-hungry?

People have been working on this for years, yet reclaiming a folio still
requires a lot of effort, including folio_referenced, try_to_unmap_one,
and compressing folios to swap out to zRAM.

>
> And if you still prefer to disable kswapd for this purpose, at least it
> should be conditional to vm.laptop_mode. But again, I don't think it's
> the right long-term approach.

My point is that phones generally have much slower network hardware
compared to PCs, and far slower hardware compared to servers, so they
are likely not very sensitive to whether memory is order-3 or order-0. On
the other hand, phones are highly sensitive to power consumption. As a
result, the power cost of creating order-3 pages is likely to outweigh any
benefit that order-3 memory might offer for network performance.

It might be worth extending the existing net_high_order_alloc_disable_key
to the RX path, as I mentioned in my reply to Eric[1], allowing users to
decide whether network or power consumption is more important?

[1]  https://lore.kernel.org/linux-mm/20251014035846.1519-1-21cnbao@gmail.c=
om/

Thanks
Barry

