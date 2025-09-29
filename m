Return-Path: <linux-kernel+bounces-836833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2063FBAAAF2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 00:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D543C4054
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 22:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3662F223DD0;
	Mon, 29 Sep 2025 22:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bmd3ORQb"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210F32E40E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 22:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759184656; cv=none; b=KI6RtO8YgmHhVdEOLhNrJszIFwexO8D6neayYf0ZZREbzaN6muX5BoyC5kAjQQcY+EZOv96XlkbkZoB9YNYGgaZe61Dd8To01znLozNBQUCkgRt73p3LOasplM265+FlsV4WUA06sBEqkwLGOF5AytVAMv13Gk0Y9NAEp/CXK1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759184656; c=relaxed/simple;
	bh=+QkMh7n9U5/dhCCdFMn1w5z4Yn6XS22/kYuSo8EaVuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmx81dK2SPgpbth0i+LekMmt2y6dPP6dzpQqqlVSOUBS0lkbmnX469UtQnoRtdcUal31VC9M7Sk4jEKdnBmaK+Y3tY9V2hVZgII3E/+whGNShc65G+mgapQXRFT+mTAqkhgx1oprFLFcyzaieBp1LkhESvlIY7As9WynnTPzQ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bmd3ORQb; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2681645b7b6so34085ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 15:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759184654; x=1759789454; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N0RdJkud+E1SzNcaO56lEUH3WicvjYwTDzcVf+h8XfE=;
        b=Bmd3ORQbZuQxeAg0euQbZANi7MeCPx0fdkvXqzv89YtZ4JXEb3C/lXMCSOpbsVXIpx
         1e0Mx0XB3k/5uaxKL/a/Ma0dOFHWQaskwRjUeIXnJG94evtAOxjfs5X4yju68yp5uuJb
         otgC4pflviL6vsIkUElkKWYK+gukdMkIBsciMQpjgXBNJju7XDvbixgCr6nuZMRE6m4u
         wDhO7leSC1rshEfORR7krZxvSZFzQBpkHtAXuqSOcOQF+aM2grUNZnXlQ8SSnTXnJ4cp
         Cufm5hEtw7czAfxO8RVIYMSzUphpwNFtg4h7nVskxJXMd1Kk8oZdmXNZgmR4fIKy9DFS
         Q3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759184654; x=1759789454;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N0RdJkud+E1SzNcaO56lEUH3WicvjYwTDzcVf+h8XfE=;
        b=hYHk/nz0Yikqz8wdKRSZOe8PplckxTWezCS4TTi8aNEtUTLHp6ESYr3mVom2/K65wj
         2IhsxLZfseJyP9UmXIAOWXcDGw/vcYFUcYdi21ED1Yst7/c4+HSmagu0PkG4+VWS/1mK
         HRUhL/pWLKeIvLL/aWWbQTL4cAMduSoOdafiISeYbf9wBdh7zuLvAHd+WTJh47Ed3GDe
         vXj20L70PyIixPgbbCLurdG7YSJWFzr90/RcTYbyXaareB/mJRdS3cF7Xxy9CMgq2Uok
         S0ylmUcVVm70mLYEErOaR6XjWE16VNlzifOMhjpY+nEuFqUg+QoISkkhl4pcGzrq3/mW
         17jw==
X-Forwarded-Encrypted: i=1; AJvYcCVk2nW+GsvT2xGj3PlLNIwp207kAfHzLwezCHxsakklTzSInPcYSlS97jNz55GHhDbSk63t24T/PggvYsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVvupm6ORRuYVB0s22dTOU5p7ypKN8F2nmt+YNsxB3jsTSRAMM
	DNjy1MQl1+3uygL5dMcWKSRpQqDb7xhLCn7qazkCG1Wb6rvPntZML8xuDP2DTQuyKw==
X-Gm-Gg: ASbGncvJeiwt/nfXvhnQ1e9KqcNAaL4bQUSXlho1OS2mhgPm40v1yxQzIo0bDfy5kDy
	7bVzIDXAonzyYowC411GOE3W0EgxewoN/gd5kJKCeMu0W/SsdWwtMq1yTSmaeBAJEqstdLIEa4D
	hRYnAb+27jJCzZz4BeITX3nDGzRUzS/6gMyfJif4oQKhfTQ3t1Xk94QbyuPmPGirLC88BJMeC+e
	Zy5lcw8ZkAWIt8EFgJlSK7VLB7PRWf4ZjHZsCJKW1ivlDswoWM40UuU/0Swy+QJtMPKhHni6MUX
	M4SgpMWwA4IB7X0cQ2cjJIyN/b6QOhY+vtMe2UGBEcrQs/tq1vKezEsRvocyuUE3hd9Zl/LPaX8
	cgh0hj4j7BwEVQi4iky33Rzn+1+jjkJR9iVTRQYxq9Fdv4u7DmNILrQvWDbxE/Zk=
X-Google-Smtp-Source: AGHT+IF4474zNSE/tR3t5AlScavptaVirEjnqy6OeJgr7wLeMqENH4oVXUgbWMO/R26nxFDRknYApQ==
X-Received: by 2002:a17:903:2c07:b0:264:1805:df20 with SMTP id d9443c01a7336-28e147eab98mr2019975ad.4.1759184653958;
        Mon, 29 Sep 2025 15:24:13 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c55a33a8sm12092461a12.46.2025.09.29.15.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 15:24:13 -0700 (PDT)
Date: Mon, 29 Sep 2025 22:24:08 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>, Mostafa Saleh <smostafa@google.com>,
	Liviu Dudau <liviu.dudau@arm.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] iommu/io-pgtable-arm: Implement .iotlb_sync_map
 callback
Message-ID: <aNsHCKdfzQNh9GFj@google.com>
References: <20250927223953.936562-1-danielmentz@google.com>
 <aNrks8eXTfHyVhKl@google.com>
 <CAE2F3rCZhgLOPKMmAqvNaQt3mUdj0kez9_MDxM3nGVOpgr5wuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rCZhgLOPKMmAqvNaQt3mUdj0kez9_MDxM3nGVOpgr5wuA@mail.gmail.com>

On Mon, Sep 29, 2025 at 01:42:29PM -0700, Daniel Mentz wrote:
> On Mon, Sep 29, 2025 at 12:57 PM Pranjal Shrivastava <praan@google.com> wrote:
> >
> > On Sat, Sep 27, 2025 at 10:39:52PM +0000, Daniel Mentz wrote:
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
> >
> > I think we must check the returned value here and break the loop on
> > error. Otherwise, we might burry a failure by continuing the loop.
> > We should add something like:
> >
> > if (ret)
> >         break;
> >
> 
> Now, I'm realising that __arm_lpae_iotlb_sync_map always returns 0, in
> which case I could change the return type to void. Would that work for
> you?

Ah, yes, I just realized that too. I guess we can simply change the
return type to void.

Thanks,
Praan

