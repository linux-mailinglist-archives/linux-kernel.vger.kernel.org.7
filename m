Return-Path: <linux-kernel+bounces-857771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BDABE7E6B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D81B5E69B8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B83B20C48A;
	Fri, 17 Oct 2025 09:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1VTGjfv"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C48F2DCF7B
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760694826; cv=none; b=fxxYFWt6Pxq1ZLDgAQvidn9dRI2gBHh9SSmD2K4Qt2wZC4RwAr030eu8CBBi47yW5Ud5dZxhBWdhEUSaKK+rCIZIaR3EHcFR83yXiaRqNnLxYXFxlX/oa2SHjWAozdAuwI08JivIEv02FMFXmNI6NOXIg/dkpyI+16sS/VM4QBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760694826; c=relaxed/simple;
	bh=e+Xv1Q5eStHuLboRX7hqNdqbltXtyBicS6/Lhqmx7Mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTg7rRIlwQEpkTwYXBD/C1THdZ+YhazJ7khmOGfA6L4iCH2qK8jzZzlE69yoC439a0+064/XXdR4N6P8slcITmIq5co9Mtm5bhMSDWjXBKzAIe2c5+YJL4+KsGeOfreZXfbtHUtRYesUMCoaz2ERTARWJrP7YrLTMiB1ORHg244=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1VTGjfv; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b48d8deafaeso362313366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 02:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760694823; x=1761299623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EepmnhOf2b8cv48i7uBzvZdSo/kJi3CKbYL63TM2s2s=;
        b=i1VTGjfvOlsgQI1YaCNKsmGOdj9nmbt01tcU2T2YlZyzX37UrovVurcrSjsEotP7a4
         19FARLQaPLC8aVUJOnRwk77+YxuAvw5XwJWWBPiOCukxA1VMrG3vahgW0KfOWfc2GncQ
         BkBPgnA2qTYxrsUqSYQSRtA3S3RELQmn4Wktd8fNfsd6WK3cyIku4G7+8tR6Do/ngKMD
         Koy9sWyAMSp+5Nt9PWht4ji3mokdCjeMd7fgaFgaSmfJFFvfFsBNowhRTgiiE5L5t9Ob
         4WEh8CZC+CYhLoytks6oHWi1iP/q9gjnNKffQsL4E8ngkBRB3My27bW4622vSfsSUsSX
         7umQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760694823; x=1761299623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EepmnhOf2b8cv48i7uBzvZdSo/kJi3CKbYL63TM2s2s=;
        b=fsfdPfnxP0VYvs/jAB4SDzq1fF+VsZndRkh3SulVgjq9YjqZ+f//L/WltYLUfszO+D
         Nph0Pyx3ROTWvdTa5+MF9zL40qXM+FxeeTJ3IpOB/k18lQOj3Xfo1AWXeNZvQ9gsScHU
         Bpr7xqSAHSDY5lNoLFV9OnyycZ2RT1e8E2d1agrWm0fnP7RwqLIG8YzdCUIDxjGfDsV/
         GXlRjQaxqLlcOKUR3/1SlqkUYNjEbdCg7bRDZuBgY1cdZcqgsaONLWvSRAO6GUdRHwA7
         OrSyPVVbbfwdITn2gnBRjayT+wT9LC+XAKkeUIoVwgPGaDU77Oi6zWbffA5jBw3azf3U
         ucWg==
X-Forwarded-Encrypted: i=1; AJvYcCVvpX/e2+jUsGrdRqSgxHqGYi34oBjSAVq84SKOcxmSF2M0jlg9oWGUveilcBGZ1nKxhfClh68wiuZyfvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwMz6XhNS9V810SFbX/WcPmmawKfMC0/6ENukfov80VacFUPMz
	u79n1blXtGjN4U4NyrQpd0F7lohfx8j1uQulh1qJaEhtr8lt022ZFJ7cy3rGmZJbq/D+tIwg8E8
	BMVRDOdHOoxLz+YSXda3skVjTACLqIOc=
X-Gm-Gg: ASbGncuA2Ty89GhzmPkKB59KkUegnp56as0Qo+ZFyV0L69a/akIR9ntFhAeubLUzbid
	IEWYRbqdLHsMQR+mCU7wM3Qj2ZaQtK61xnTS78ACOZpZRK11xL55z2s3a+KuhSzBvQwjg9tJfXe
	wEJpuQGoeSQJ559Gl9hZm4gMJT6Qz6OpfYcug4IUNL+/wb8V6TpbEaaLWzaQBVZqM6EEuPeLh+1
	lEze0VRIN7MSp74YYrqhr01IiFJHLsuWdg/qjRfFCYcth/Ny+r6Bfye3lpTDX6s6eA15aTbDA==
X-Google-Smtp-Source: AGHT+IGnkkXRL26RjJocOTbDHT6wQpAjD7i7LZQcNZb0xfoSFRP0gYibjbMJ3dbGukJMMqFIxLuRJqHhFH9k/kdc2Ow=
X-Received: by 2002:a17:907:25cc:b0:b38:6689:b9f5 with SMTP id
 a640c23a62f3a-b6471d45e6bmr377170466b.3.1760694822635; Fri, 17 Oct 2025
 02:53:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7e3e7327-9402-bb04-982e-0fb9419d1146@google.com>
 <CAAPL-u-d6taxKZuhTe=T-0i2gdoDYSSqOeSVi3JmFt_dDbU4cQ@mail.gmail.com>
 <20250917174941.000061d3@huawei.com> <5A7E0646-0324-4463-8D93-A1105C715EB3@gmail.com>
 <20250925160058.00002645@huawei.com> <aNVbC2o8WlYKjEfL@gourry-fedora-PF4VCD3F>
 <20250925162426.00007474@huawei.com> <aNVohF0sPNZSuTgI@gourry-fedora-PF4VCD3F>
 <20250925182308.00001be4@huawei.com> <aNWRuKGurAntxhxG@gourry-fedora-PF4VCD3F>
 <aNzWwz5OYLOjwjLv@gourry-fedora-PF4VCD3F>
In-Reply-To: <aNzWwz5OYLOjwjLv@gourry-fedora-PF4VCD3F>
From: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
Date: Fri, 17 Oct 2025 11:53:31 +0200
X-Gm-Features: AS18NWCQ9wXgY3ohNhZ8GKQ15VfNgQtd-CWHjxzqk37o1eOtpgk7IRUwEDn2cR4
Message-ID: <CAOi6=wTsY=EWt=yQ_7QJONsJpTM_3HKp0c42FKaJ8iJ2q8-n+w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/8] mm: Hot page tracking and promotion infrastructure
To: Gregory Price <gourry@gourry.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, Wei Xu <weixugc@google.com>, 
	David Rientjes <rientjes@google.com>, Matthew Wilcox <willy@infradead.org>, 
	Bharata B Rao <bharata@amd.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	dave.hansen@intel.com, hannes@cmpxchg.org, mgorman@techsingularity.net, 
	mingo@redhat.com, peterz@infradead.org, raghavendra.kt@amd.com, 
	riel@surriel.com, sj@kernel.org, ying.huang@linux.alibaba.com, ziy@nvidia.com, 
	dave@stgolabs.net, nifan.cxl@gmail.com, xuezhengchu@huawei.com, 
	akpm@linux-foundation.org, david@redhat.com, byungchul@sk.com, 
	kinseyho@google.com, joshua.hahnjy@gmail.com, yuanchu@google.com, 
	balbirs@nvidia.com, alok.rathore@samsung.com, yiannis@zptcorp.com, 
	Adam Manzanares <a.manzanares@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 9:22=E2=80=AFAM Gregory Price <gourry@gourry.net> wr=
ote:
>
> On Thu, Sep 25, 2025 at 03:02:16PM -0400, Gregory Price wrote:
> > On Thu, Sep 25, 2025 at 06:23:08PM +0100, Jonathan Cameron wrote:
> > > On Thu, 25 Sep 2025 12:06:28 -0400
> > > Gregory Price <gourry@gourry.net> wrote:
> > >
> > > > It feels much more natural to put this as a zswap/zram backend.
> > > >
> > > Agreed.  I currently see two paths that are generic (ish).
> > >
> > > 1. zswap route - faulting as you describe on writes.
> >
> > aaaaaaaaaaaaaaaaaaaaaaah but therein lies the rub
> >
> > The interposition point for zswap/zram is the PTE present bit being
> > hacked off to generate access faults.
> >
>
> I went digging around a bit.
>
> Not only this, but the PTE is used to store the swap entry ID, so you
> can't just use a swap backend and keep the mapping. It's just not a
> compatible abstraction - so as a zswap-backend this is DOA.
>
> Even if you could figure out a way to re-use the abstraction and just
> take a hard-fault to fault it back in as read-only, you lose the swap
> entry on fault.  That just gets nasty trying to reconcile the
> differences between this interface and swap at that point.
>
> So here's a fun proposal.  I'm not sure of how NUMA nodes for devices
> get determined -
>
> 1. Carve out an explicit proximity domain (NUMA node) for the compressed
>    region via SRAT.
>    https://docs.kernel.org/driver-api/cxl/platform/acpi/srat.html
>
> 2. Make sure this proximity domain (NUMA node) has separate data in the
>    HMAT so it can be an explicit demotion target for higher tiers
>    https://docs.kernel.org/driver-api/cxl/platform/acpi/hmat.html
This makes sense. I've done a dirty hardcoding trick in my prototype
so that my node is always the last target. I'll have a look on how to
make this right.
>
> 3. Create a node-to-zone-allocator registration and retrieval function
>    device_folio_alloc =3D nid_to_alloc(nid)
>
> 4. Create a DAX extension that registers the above allocator interface
>
> 5. in `alloc_migration_target()` mm/migrate.c
>    Since nid is not a valid buddy-allocator target, everything here
>    will fail.  So we can simply append the following to the bottom
>
>    device_folio_alloc =3D nid_to_alloc(nid, DEVICE_FOLIO_ALLOC);
>    if (device_folio_alloc)
>        folio =3D device_folio_alloc(...)
>    return folio;
In my current prototype alloc_migration_target was working (naively).
Steps 3, 4 and 5 seem like an interesting thing to try after all this
discussion.
>
> 6. in `struct migration_target_control` add a new .no_writable value
>    - This will say the new mapping replacements should have the
>      writable bit chopped off.
>
> 7. On write-fault, extent mm/memory.c:do_numa_page to detect this
>    and simply promote the page to allow writes.  Write faults will
>    be expensive, but you'll have pretty strong guarantees around
>    not unexpectedly running out of space.
>
>    You can then loosen the .no_writable restriction with settings if
>    you have high confidence that your system will outrun your ability
>    to promote/evict/whatever if device memory becomes hot.
That looks modular enough that will allow me to test both writable and
no_writable and being able to compare.
>
> The only thing I don't know off hand is how shared pages will work in
> this setup.  For VMAs with a mapping that exist at demotion time, this
> all works wonderfully - less so if the mapping doesn't exist or a new
> VMA is created after a demotion has occurred.
I'll keep that in mind.
>
> I don't know what will happen there.
>
> I think this would also sate the desire for a "separate CXL allocator"
> for integration into other paths as well.
>
> ~Gregory
Thanks a lot for all the discussion and the input. I can move my
prototype towards this direction and will get back with what I 've
learned and an RFC if it makes sense. Please keep me in the loop in
any related discussions.

Best,
/Yiannis

