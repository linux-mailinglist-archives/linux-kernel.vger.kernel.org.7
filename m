Return-Path: <linux-kernel+bounces-787326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9DFB374B4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 00:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49C0A1B2616F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 22:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003AA2797B8;
	Tue, 26 Aug 2025 22:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUtamZV8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F8E1DB127
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 22:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756245632; cv=none; b=QvRPt4TgclzXL5PgSomyWzS8o2KhDwD3TvhhqQL91e1v/TlZOnFp5Fk80U5dukaBkzd593hINteaSyPbvtFp9ZwHEQs0EdCgrs676eGerK/BLhhCFCc8hsZygBQZYwJPAE38bDefW/RJXCiyHsSAQuX/hedBVUbXF8Pziv/nnEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756245632; c=relaxed/simple;
	bh=pWOdIofYcd2BVstz+MOo3lsC+kzLhH9iyv0DoflFa54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IGVpuOEQB/kBHC2recnTX5kuXoOJiNV6aJmpZ9kbRLL7hkwtcYuY3TGovuHg13Qqh3hVIOiK8d2E6jhX6Ba0dASAr3HGqWmeKG4ZhYtj46qQBNmL+dbwLJPVLbwH+crkrjWrFDX3y7EiE/JDbIsAV5O3RzEhCCviVM8Zl6TpNCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUtamZV8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7188C116D0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 22:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756245630;
	bh=pWOdIofYcd2BVstz+MOo3lsC+kzLhH9iyv0DoflFa54=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fUtamZV8gWk/4de3o3UGqCPEPue5eEHD0j8H2Ej11wZV2yVn5PyVy6YauGqhE07mq
	 YXsdQcfyNq/ggCU+rxxlZI0wDbh9/yMr517q0qVb45kRFvUS5xHTuIzHaBBB0wu5mQ
	 d34JkK0UuRAmg5kX7FBE59mZp7TyXJkFWsa68KZqsQXxPD0M2Xz6mN+u3sEgZA/tA0
	 ccXaGSFjgw4zW+G4V32Mpsw1zj9+uuyDin/oiV6Z2RKsLa2tcQjLKcpmA7rn3mMSvy
	 37BlY9macyX81A+VxBplILG+F4XXrLJww/5fccuFvTEFubtwUdWRzj+sEqVpePb90C
	 ouhm/qCBG3lBg==
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-459fc675d11so12025e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:00:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVoeRWWlCEwj4cRnPdJr7NKHZ3Ji3lG0qD0xStyLzEVzYvG5/1olTUElQCOVbLCpxYA7Nn+GwjAlGejx4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtLnXoJAfXNBkZRKjqaVJsegIn4ClNAIjuHo2iBXGsZacutopS
	iyq+aTlDRSDSwoqkHLESrX2HuHdx0QcaVZg5G6WAx7J0OL+lLwgzjAZp7pJk67N/A2ZG2zsVjMB
	BnzPCtTipVKYHGntjZuFWKG6NjZAqwma9gkdNzq8H
X-Google-Smtp-Source: AGHT+IFFTxvgOgSqw04QBrhAUuN83/2UNWCNNQoSfb+IBD7KvPA/aZk8w3052+HFEplww/6pof07vUVot5s+RaGWfWs=
X-Received: by 2002:a05:600c:3495:b0:453:65f4:f4c8 with SMTP id
 5b1f17b1804b1-45b6696b9c8mr2691575e9.3.1756245629266; Tue, 26 Aug 2025
 15:00:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com>
In-Reply-To: <20250822192023.13477-1-ryncsn@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 26 Aug 2025 15:00:18 -0700
X-Gmail-Original-Message-ID: <CAF8kJuNinT1sZG1edUDMXbdCJ8W_enDcnviAuj5=MViNZ1AczQ@mail.gmail.com>
X-Gm-Features: Ac12FXzVFLxJhUeNWdbvaFLtBNcpDNkz8bxPDbSkalAjd85ceadZ4fbjUsUIo5c
Message-ID: <CAF8kJuNinT1sZG1edUDMXbdCJ8W_enDcnviAuj5=MViNZ1AczQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] mm, swap: introduce swap table as swap cache (phase I)
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 12:20=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> This is the first phase of the bigger series implementing basic
> infrastructures for the Swap Table idea proposed at the LSF/MM/BPF
> topic "Integrate swap cache, swap maps with swap allocator" [1].
>
> This phase I contains 9 patches, introduces the swap table infrastructure
> and uses it as the swap cache backend. By doing so, we have up to ~5-20%
> performance gain in throughput, RPS or build time for benchmark and
> workload tests. This is based on Chris Li's idea of using cluster size
> atomic arrays to implement swap cache. It has less contention on the swap
> cache access. The cluster size is much finer-grained than the 64M address
> space split, which is removed in this phase I. It also unifies and cleans
> up the swap code base.

Thanks for making this happen. It has gone a long way from my early
messy experimental patches on replacing xarray in swap caches. Beating
the original swap_map in terms of memory usage is particularly hard. I
once received this feedback from Matthew that whoever wants to replace
the swap cache is asking for a lot of pain and suffering. He is
absolutely right.

I am so glad that we are finally seeing the light of the other end of
the tunnel.  We are close to a state that is able to beat the original
swap layer both in terms of memory usage and CPU performance.

Just to recap. The current swap layer per slot memory usage is 3 + 8
bytes. 3 up front static, 1 from swap map, 2 from swap cgroup. The 8
byte dynamic allocations are from the xarray of swap cache.
At the end of this full series (27+ patches) we can completely get rid
of the 3 up front allocation. Only dynamic allocate 8 byte per slot
entry. That is a straight win in terms of memory allocation, no
compromise was made there.
The reason we can beat the previous CPU usage is that each cluster has
512 entries. Much smaller than the 64M xarray tree. The cluster lock
is a much smaller lock than the xarray tree lock. We can do lockless
atomic lookup on the swap cache that is pretty cool as well.

I will do one more review pass on this series again soon.

Very exciting.

Chris

