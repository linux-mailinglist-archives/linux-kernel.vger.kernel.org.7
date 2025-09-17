Return-Path: <linux-kernel+bounces-821054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22785B803D4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7C514A2131
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4CA258A;
	Wed, 17 Sep 2025 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="QG3Y0H9S"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A19C5C96
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120528; cv=none; b=nYx1x7X48jIgNo25hxXuCCsa2KRzUhyAwOoqnua6K2tePV5xkxFvAkiqNIRXd50I/b/L1ySe+/PehBnxknBY5nH38nh6VXOezvXAJ37zZGmaXcHXd2dyd82EyBzxooQ/DpTNJNk5D5q3b/BH3ErOTFpYryT7GlLpe/geUPvqYTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120528; c=relaxed/simple;
	bh=XM9x1YUJ8g2757RVaFtWbjTlVGCJSyEiu9KsLY58LO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RwbwTRzgdm9ZGNCdpEhmKffE1S15HFdC/AsU5GWZCtynOdHKvOQF7c7nKQEotPeDOe7Sl09u7Hh2B3IwKSR0ipFSS4JD6Y+4lQ5QbZNOvjZvHp4qDdNH1cMY1vC3os/wW9hjDwmFS/zqu38aT6C375GqITBdRTTf7yNtHSWrPS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=QG3Y0H9S; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b61161c35cso77843591cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1758120525; x=1758725325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQPUKsmAc0liILowvxQAIT6pnimYT1OvWOFQs2iiA4k=;
        b=QG3Y0H9SgTEUU3bMbqbUsrQxh8m1/Fd3QTrFPXyj0SPcku2lGMI8HAwuEgtPaHvUZv
         nLr71pgRX6WowAtVMRlbWaOL7X45IEoI0YjKH0nRSy+JjSds+Clf0kVfb6IseAja4kG2
         75xg67PGoWcYuuHV5oFHZrDzt+VLixzH192UUtg7XmBJG7tXletXCQ/hcfWzGH0u3DCy
         9FpcBxXMgOOM0EdgkTmJSX5tGnIiVt8fYO7CmPmQtCp8LMms6CpYnfeorv9Mlc/Rq1ck
         o/EYkYQ7dgyKNqE5bSt32Qa4vOy0cVw1W5IQp3YpJw64M48P7CkRZC9t0HCwrWPzm+Ng
         IJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758120525; x=1758725325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQPUKsmAc0liILowvxQAIT6pnimYT1OvWOFQs2iiA4k=;
        b=HSk4pAN8b0otxd3vSaTYowvPKGgpjdJeCWORtilt18zot7umLazHm8M10wntw4VbWy
         LF5LzpKCtOflJI4vcNbmbSoMy9jRgxrjT36cuUE3KT09b/PZGgvPe6YirTSKqQRtFQb4
         Pb1mnhB9Hn3kphwL+3ZaS6OEvBIoj5yNvQ58nXlnwn3ohdF2xWNi2JhpcnyTipt41kH/
         7jL0oc1vtnPMasGzoOOIiskkFCxGPLX/krEgcP5XAX3SD0p1iOZ+XrqBKrRLGWi71y+v
         3HR1mifWgfYlo5pKhvfI2K65gtqm7AVlrrau9B9hUXFJJuZsCB9PBcre8lXNZ+x47gmi
         0CRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQBFZUJ64+ctaSu//j24ALYv26N1nI/aRhWb/ygIrO+DYF+LOwOVSIjHpm2gh5eewvsuzWWWK1hYX5yYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKEk058vLHfj8RoN+3RAM1y9cUvBE8/0hL2bmSSSqnLvMYQwtt
	1/XN3+8cNb8r+iBHIi9tDdOkRgyKrXF21pDUwESxcorQTv6Tn0BVvbl5UqmCBqCtzHSD50d7/8+
	qFngtYNM7Y48BqUw9FD3eSBK4veyMe0WyFQkxxeJ06w==
X-Gm-Gg: ASbGncth4dSxOelrF+A/G2toEeyGBZoYi3nChOwgFHW+US36yEpmJ/Dvjob/v8xpTvA
	yZEKhec44vBuz96gWRSgl4lnUWixCnE8yG6Ji24Xx0fZihJp+sCCmN0O9XL6rLSeKnVpq855Tz0
	6J0NK70F1mZs88HrtI2dzWxrXS736xvPuyEtEAb8KAPIYZdCDFWVwMYh9lY18Jw52lbZ38V+o10
	fux
X-Google-Smtp-Source: AGHT+IE79GpXyjBV89Avr2S09fmTlI/L2wNAUrwa2E6+rwL+V03nJN++UHPUWlE+FIB9aveMjDTolm2gyToXUS/Nfzg=
X-Received: by 2002:a05:622a:5446:b0:4b5:e9e3:3c90 with SMTP id
 d75a77b69052e-4bbbe28e2bbmr8185321cf.9.1758120525123; Wed, 17 Sep 2025
 07:48:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917025019.1585041-1-jasonmiu@google.com> <20250917113609.GB1086830@nvidia.com>
In-Reply-To: <20250917113609.GB1086830@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 17 Sep 2025 10:48:08 -0400
X-Gm-Features: AS18NWCrgaurUWlppllqWMXv6puRwIeZOjcCB40WylsCdUx_uF-Iq5DWN0oZ-N0
Message-ID: <CA+CK2bCV-UbfDb=QmyJrX3xWMToCO5b5a1R+Px5QOXafF_AqRg@mail.gmail.com>
Subject: Re: [RFC v1 0/4] Make KHO Stateless
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jason Miu <jasonmiu@google.com>, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Changyuan Lyu <changyuanl@google.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Joel Granados <joel.granados@kernel.org>, 
	Marcos Paulo de Souza <mpdesouza@suse.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Mike Rapoport <rppt@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Steven Chen <chenste@linux.microsoft.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 7:36=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Tue, Sep 16, 2025 at 07:50:15PM -0700, Jason Miu wrote:
> > This series transitions KHO from an xarray-based metadata tracking
> > system with serialization to using page table like data structures
> > that can be passed directly to the next kernel.
> >
> > The key motivations for this change are to:
> > - Eliminate the need for data serialization before kexec.
> > - Remove the former KHO state machine by deprecating the finalize
> >   and abort states.
> > - Pass preservation metadata more directly to the next kernel via the F=
DT.
> >
> > The new approach uses a per-order page table structure (kho_order_table=
,
> > kho_page_table, kho_bitmap_table) to mark preserved pages. The physical
> > address of the root `kho_order_table` is passed in the FDT, allowing th=
e
> > next kernel to reconstruct the preserved memory map.
>
> It is not a "page table" structure, it is just a radix tree with bits
> as the leaf.

To be fair above it is referred to as a page table *like* data
structure, but I agree kho radix tree sounds like a good overall name
for this, and it might make sense to rename from kho_page_table to
kho_radix_tree in other places.

>
> Jason

