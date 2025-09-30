Return-Path: <linux-kernel+bounces-837381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABFCBAC2FB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A0A1925E93
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6C82F4A1F;
	Tue, 30 Sep 2025 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eu5DNY6a"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB88C24A076
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759223451; cv=none; b=JueWjIn60JDM4NCUgO4Usu+5+3Hfdu778l37FBYFC7ZUnz/foLanfHN2dASy2ruE29sgUohS/Db0FGs8n0HVUw3cPz7DVFtPfG86FSGuipptUq3+jP9O8GGpWvtPtXMn7YgyYExNgzRDN91YxFYhmXP0WKFzmKW1pnAGoOs+yIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759223451; c=relaxed/simple;
	bh=4WefjqGDOXBttHZmJoadNpQptsIzaZDeP+hTJOqWc7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnDOTkYfmzV0etea1ir5e/q6MuFQaNiwDlTxxyg1F1lT6CR2dHTh6f3AC+hJVnsZe7edgqwiqPtGaDhIIEKYOdqB/eNu8mI9TYiifu9pNvEwzE7wSduf+lm7QdeBMVvll5vSmtOWb/xV81ZHTEEjFd/l+nJcVt+ZuIF7ZKamuRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eu5DNY6a; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e32c0e273so37715e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759223448; x=1759828248; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nPGIuH9O5UahXsLPdts/xJkrk4ytPXWvHSE6PjMMeDA=;
        b=eu5DNY6aqslxZsL0NRTzHr8oF3liJgK37/qGS6Zgt1koXrKkCIsMV5by/l8u/5ad4Q
         9YPSqMBGRgnGq1DeKE9N+aj9/cxzCjWeK1D4vmRqzC3vYJAH3LThA1HeQiD71LOqJeH7
         F7CNYy/QybJGMWElPtHsLbZkI7gnbWjjHuQk8YhNJgILTfjz0ruWzQxJUdBkww1T9LQ3
         yhUbEMmCBWWlds+shUkQUT6gK/JEHCphM8n5zEEQA+a1IuhluMvMuAvI2n7Zp+UvQafA
         mje4a2gdZLsY7LeupZv2xzO3EeDp1lBw62dDGKqHmZsFnO8Z0RQ004qZBTou1q7MpuhY
         s+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759223448; x=1759828248;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nPGIuH9O5UahXsLPdts/xJkrk4ytPXWvHSE6PjMMeDA=;
        b=WPVf1MH2OKQtx+kndT0Q/d+netQnNaGibY6pqayW3JhnmqpckSuR/Y31TM34Sa9Rw3
         2FdCP3ZUETJxm3gW0zq8hWIw079oxnSb1voIgVspfaWilP4gFyEHsSlTHE5kYwIcpLto
         PDCKTwccsUqiMg7aQZI43ob4nticAtvxXfEMxIS2T7HOjUoI9rSeoXrDry0EnvHuNAgR
         jgx5lrkKSRRZgPgnMYCwosQpmPJXclzfX7F767KFwqOyfVcLJQm1YQRH95+nHEw3o0d0
         TE766OOZGSbFqrulWIlznnSyBCJQv7Lxn+UzFt7Sp4y6yfLwqF2rtweUU5NNedYZiAUa
         ewWA==
X-Forwarded-Encrypted: i=1; AJvYcCUSwkqvkeghzWtCUacEwjUzT/7xZrFN1FVHrFRq+xYJ7ytg8HDRhXR9tNZbuEp6rmzB7dreE3x2IyJLp1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykt7JrVYfAuWre+nxFSfCx+8zXzTRx9W+SPTBprqxqvv3pH9pQ
	eAFNLmBwKkjC2On7VmAQVpkLGGC5rCasjDc5kVyqAmoFZWfsmFK6Yzf5jmMwVOhLtw==
X-Gm-Gg: ASbGncvUKB9rl4DoM/QSOPy8FBmDHFQujVnSVI5L37j4V7YDKKO8CgGI4FyhQ9jtNLp
	6nA2aHOQOPVYM8VN9KDX/Y1GPh+JPeCavCZNiEQP7A4HIxJwIj94VZn0IWIhiQc6UZq0HslZ7iW
	3ujxyG10KxyMX+csLWAdHOpam2VmbiwiKBSlzFILTt0Iqo943YIowcXJrgxRCrj17CRs0Pfd2Ke
	nlnWIKe0rXEyPFDRVFHe9SCDK2Evs8U97rI7MoIqYhL/JBMNAK1MZvrgtYtR3rQxtdt75AAEQsi
	pm3m/bav9EEsBZ70b1+RI6IALMJId99qn7hHCZvjPHc+D9geEbp18OqW0x9M7v78qoJDXpukZv2
	hzLPoIYclTegfDH9I/aWZyMZmEMR8SSPCWlnUZusdRRXbflhX/fdRJipJgQUYU0uHYxN08rbQlZ
	1H3vVJ6AqTUHL+0HQEYDdfTzNHHQ==
X-Google-Smtp-Source: AGHT+IEWSkbFb5VicmOJKTu7n+clcEM5yHSBrBKSgC0+RfyuBu9aS1hrvYGZ7FIwH96AwQT50YFbaQ==
X-Received: by 2002:a05:600c:68a:b0:45f:2e6d:c9ee with SMTP id 5b1f17b1804b1-46e59ccd62dmr1107735e9.6.1759223447901;
        Tue, 30 Sep 2025 02:10:47 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc6de90f9sm22005390f8f.48.2025.09.30.02.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 02:10:47 -0700 (PDT)
Date: Tue, 30 Sep 2025 09:10:44 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Pranjal Shrivastava <praan@google.com>,
	Liviu Dudau <liviu.dudau@arm.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] iommu/io-pgtable-arm: Implement .iotlb_sync_map
 callback
Message-ID: <aNuelC9K24z_Ph_G@google.com>
References: <20250927223953.936562-1-danielmentz@google.com>
 <aNp5sS7VpPirrRGE@google.com>
 <CAE2F3rB6TYjy0a9yecW4zwBLraaj75YBafEz3DUh8zrLChnuCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rB6TYjy0a9yecW4zwBLraaj75YBafEz3DUh8zrLChnuCg@mail.gmail.com>

On Mon, Sep 29, 2025 at 02:00:09PM -0700, Daniel Mentz wrote:
> On Mon, Sep 29, 2025 at 5:21 AM Mostafa Saleh <smostafa@google.com> wrote:
> >
> > On Sat, Sep 27, 2025 at 10:39:52PM +0000, Daniel Mentz wrote:
> > > On systems with a non-coherent SMMU, the CPU must perform cache
> > > maintenance operations (CMOs) after updating page table entries (PTEs).
> > > This ensures that the SMMU reads the latest version of the descriptors
> > > and not stale data from memory.
> > >
> > > This requirement can lead to significant performance overhead,
> > > especially when mapping long scatter-gather lists where each sg entry
> > > maps into an iommu_map() call that only covers 4KB of address space.
> > >
> > > In such scenarios, each small mapping operation modifies a single 8-byte
> > > PTE but triggers a cache clean for the entire cache line (e.g., 64
> > > bytes). This results in the same cache line being cleaned repeatedly,
> > > once for each PTE it contains.
> > >
> > > A more efficient implementation performs the cache clean operation only
> > > after updating all descriptors that are co-located in the same cache
> > > line. This patch introduces a mechanism to defer and batch the cache
> > > maintenance:
> > >
> > > A new boolean flag, defer_sync_pte, is added to struct io_pgtable_cfg.
> > > When this flag is set, the arm-lpae backend will skip the cache sync
> > > operation for leaf entries within its .map_pages implementation.
> > >
> > > A new callback, .iotlb_sync_map, is added to struct io_pgtable_ops.
> > > After performing a series of mapping operations, the caller is
> > > responsible for invoking this callback for the entire IOVA range. This
> > > function then walks the page tables for the specified range and performs
> > > the necessary cache clean operations for all the modified PTEs.
> > >
> > > This allows for a single, efficient cache maintenance operation to cover
> > > multiple PTE updates, significantly reducing overhead for workloads that
> > > perform many small, contiguous mappings.
> > >
> > > Signed-off-by: Daniel Mentz <danielmentz@google.com>
> > > ---
> > >  drivers/iommu/io-pgtable-arm.c | 66 +++++++++++++++++++++++++++++++++-
> > >  include/linux/io-pgtable.h     |  7 ++++
> > >  2 files changed, 72 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> > > index 7e8e2216c294..a970eefb07fb 100644
> > > --- a/drivers/iommu/io-pgtable-arm.c
> > > +++ b/drivers/iommu/io-pgtable-arm.c
> > > @@ -353,7 +353,7 @@ static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
> > >       for (i = 0; i < num_entries; i++)
> > >               ptep[i] = pte | paddr_to_iopte(paddr + i * sz, data);
> > >
> > > -     if (!cfg->coherent_walk)
> > > +     if (!cfg->coherent_walk && !cfg->defer_sync_pte)
> > >               __arm_lpae_sync_pte(ptep, num_entries, cfg);
> > >  }
> > >
> > > @@ -582,6 +582,69 @@ static int arm_lpae_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
> > >       return ret;
> > >  }
> > >
> > > +static int __arm_lpae_iotlb_sync_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
> > > +                           size_t size, int lvl, arm_lpae_iopte *ptep)
> > > +{
> > > +     struct io_pgtable *iop = &data->iop;
> > > +     size_t block_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
> > > +     int ret = 0, num_entries, max_entries;
> > > +     unsigned long iova_offset, sync_idx_start, sync_idx_end;
> > > +     int i, shift, synced_entries = 0;
> > > +
> > > +     shift = (ARM_LPAE_LVL_SHIFT(lvl - 1, data) + ARM_LPAE_PGD_IDX(lvl - 1, data));
> > > +     iova_offset = iova & ((1ULL << shift) - 1);
> > > +     sync_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
> > > +     sync_idx_end = (iova_offset + size + block_size - ARM_LPAE_GRANULE(data)) >>
> > > +             ARM_LPAE_LVL_SHIFT(lvl, data);
> > > +     max_entries = arm_lpae_max_entries(sync_idx_start, data);
> > > +     num_entries = min_t(unsigned long, sync_idx_end - sync_idx_start, max_entries);
> > > +     ptep += sync_idx_start;
> > > +
> > > +     if (lvl < (ARM_LPAE_MAX_LEVELS - 1)) {
> > > +             for (i = 0; i < num_entries; i++) {
> > > +                     arm_lpae_iopte pte = READ_ONCE(ptep[i]);
> > > +                     unsigned long synced;
> > > +
> > > +                     WARN_ON(!pte);
> > > +
> > > +                     if (iopte_type(pte) == ARM_LPAE_PTE_TYPE_TABLE) {
> > > +                             int n = i - synced_entries;
> > > +
> > > +                             if (n) {
> > > +                                     __arm_lpae_sync_pte(&ptep[synced_entries], n, &iop->cfg);
> > > +                                     synced_entries += n;
> > > +                             }
> > > +                             ret = __arm_lpae_iotlb_sync_map(data, iova, size, lvl + 1,
> > > +                                                             iopte_deref(pte, data));
> > > +                             synced_entries++;
> > > +                     }
> > > +                     synced = block_size - (iova & (block_size - 1));
> > > +                     size -= synced;
> > > +                     iova += synced;
> > > +             }
> > > +     }
> > > +
> > > +     if (synced_entries != num_entries)
> > > +             __arm_lpae_sync_pte(&ptep[synced_entries], num_entries - synced_entries, &iop->cfg);
> > > +
> > > +     return ret;
> > > +}
> >
> > Can't we rely on the exisiting generic table walker "__arm_lpae_iopte_walk",
> > instead writing a new one, that is already used for iova_to_phys and dirty bit.
> 
> The performance gains of .iotlb_sync_map are achieved by performing
> CMOs on a range of descriptors as opposed to individually on each
> descriptor in isolation. The function __arm_lpae_iopte_walk is
> inherently incompatible with this, because it calls the .visit
> callback once for each descriptor it finds in the specified range. I
> guess I could work around this limitation by saving some state in
> io_pgtable_walk_data and developing a .visit function that tries to
> coalesce individual descriptors into contiguous ranges and delays CMOs
> until it finds a break in continuity. I'm afraid, though, that that
> might hurt performance significantly.

Exactly, I think that would be the way, I don’t have a strong opinion
though, but I’d avoid open coding a new walker unless it’s necessary.
Also, the current walker won’t do ranges, it needs some more changes,
I did that as part of (half of the patch doesn’t apply for this case):
https://lore.kernel.org/all/20241212180423.1578358-38-smostafa@google.com/

Thanks,
Mostafa


