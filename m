Return-Path: <linux-kernel+bounces-848229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD75BCCF63
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AF6E424E20
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0118B2EFD90;
	Fri, 10 Oct 2025 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="jTH7dhnN"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656CA35949
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760100394; cv=none; b=sLV5Mdryl7OYBNvT1SNq9BMdtHunpdi/S7n5PVBWGNVlNugbo9AuwXO81i11iLGyBSynV+QDfd3qNgVCoopKJ1xSwNTIS3aRyjOSd1T4i54Cd8zGSQocJHmYRu5+twqpSO5jBcRNDXK21XhTfOJ+s2dju2nEKKOa/fKrekRoELo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760100394; c=relaxed/simple;
	bh=cYonixcZbuyHF6K3JhPk4silzO2xyU5l/z1VPiL1Kzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ozE6Tp6FLt7VQD6UbaFwvFF6G+k206s2Vh1BTa//7RLQmDr6pYSFQZAPo5IvZC6TtaMnASgwVT9RlKHPVyc4/ijyd9prMA4xXahvc1tjgrRsSOQTMDguMg8w3ePtcU6faNgsYhdnrJt5SAvc1z8aoUYJZ892YNctFNN0n7mZYFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=jTH7dhnN; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4dfbab4fb0dso25944451cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 05:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760100391; x=1760705191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSdoiDX5nR8jqPMFduOgTUs/SIBXnAYTIt/wPSACCBU=;
        b=jTH7dhnNtPW/Dz0k7tMfL16rG8lybdtk62ELH4BBaXh9m5eE/ERIfPM7/p+IugdCWY
         rA0MtwUPMV48cVy0gDL4KN2pG2sQj6w8FZzRh/vV7NkZ512u4gFFtIokgSxLyuTov7zI
         wQD9ogDOWugnEvKIt446I8UTl0kqTfPNRB5PsGcDVlS+Huwapns5zNoJrR2YovzvekF7
         J+TAwkfuHUq/MzTefzfCe1QC5pCxSA9lMKd9eEBSu1jrs/cdCWohdf986VX/glDgdbx6
         msfGlp0roNHt1ys117bS1eyR8VI1apFnyddTwtIV7q2yfSFzG7J/MBRfZM5nWUsBb43e
         eu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760100391; x=1760705191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kSdoiDX5nR8jqPMFduOgTUs/SIBXnAYTIt/wPSACCBU=;
        b=ayVxXNWTGc98v6wwOAhx7dJcRo4kNlYNuyjD5CLztQOg+ogtPqhh0Otv9mYa1XuVdD
         jSNZ+CscO/m0zo/2n5SRaSRJMyc6nv7SZtESkJ4XGYWBRafy7q3EKoy2SM4wDjgmJxpM
         SOkxrQbZfTLBv2ROahtXsaLg/xBJII5auzLuc5ZZnx2+5ym9fp0euYy8wro26vrQqsmt
         6sC7bj3KF1558Lrd4Gmeufv2m8I/1iJFAuJ12xlH3dfTXJV3QHftEcS+8/hWJVt1w+4s
         plcwOEulJGYbkeUme/LvGUvuyC7fPLEZJo1vNa/oTHBu2bt6jC3D0MN7zgW8dZtMUG8g
         Fj8g==
X-Forwarded-Encrypted: i=1; AJvYcCVlBD8WT5KtnKHwgBL/HNY4YqNXs0JTzDtRfQT2Zy+/kCliEbVt7F8c92MVYQTeC+f5gaLqrdh87jYM75I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn4VDM/JE4Tjk2KaQJYkHiRebtdwVRjV4krJWKuVIm2P9t1y3n
	VIVEM4RwIMR6L02HHeo7fQS9QrDlWzQYM/6jKHoabw+GEOJtMgAevzD+JD7oXkbcCgpKxM1AxmU
	L7riSJYgvl1eqP0eeMTF1+veQnQPN0zOqFR6DrpCKKA==
X-Gm-Gg: ASbGncvt0auFV6/R7q+D5tdINdLV2XALQjygyUhUBSk5Oviv3YzOkmP0g5roeh9jJ2m
	gMC5h3j3T6aufwkKG7D+cLbFMtUH4QracArtuPUN4ghO64VPjkFnoh4ojy5Srro/MSHRrCdZKc1
	UJfRbe/MR1gup6iolBAb/ueeRChosIU0Xbw26K8NURL2VRYB0LiZ355M/RyJJamy39qqwuEe8uX
	gr35/XPJfqLexhZFDdmCp1tr27R2zENpQ==
X-Google-Smtp-Source: AGHT+IF3WkXquYSs0aZNr+CjES7Xeg58N6tZ4SYA03I6oeZM5oBf1kS+Z/F3o89F5+eVQe4l/6epRXKKJ0esSY22H0k=
X-Received: by 2002:ac8:444a:0:b0:4e6:eb6c:fdd4 with SMTP id
 d75a77b69052e-4e6eb6d00c8mr119176221cf.52.1760100390967; Fri, 10 Oct 2025
 05:46:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <CA+CK2bB+RdapsozPHe84MP4NVSPLo6vje5hji5MKSg8L6ViAbw@mail.gmail.com> <mafs0ms5zn0nm.fsf@kernel.org>
In-Reply-To: <mafs0ms5zn0nm.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 10 Oct 2025 08:45:52 -0400
X-Gm-Features: AS18NWD1lDKPEljKLMW4w1nOwJRnWgZiJv6poOU8kRsyRJy9732wSgdXfAOypQY
Message-ID: <CA+CK2bAKdu4-bZQgopNguE_gVtfZ-mpCo+0zOk-9wu8LW8QQwg@mail.gmail.com>
Subject: Re: [PATCH v4 00/30] Live Update Orchestrator
To: Pratyush Yadav <pratyush@kernel.org>
Cc: jasonmiu@google.com, graf@amazon.com, changyuanl@google.com, 
	rppt@kernel.org, dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn, 
	linux@weissschuh.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org, 
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com, hughd@google.com, skhawaja@google.com, chrisl@kernel.org, 
	steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 6:58=E2=80=AFPM Pratyush Yadav <pratyush@kernel.org>=
 wrote:
>
> On Tue, Oct 07 2025, Pasha Tatashin wrote:
>
> > On Sun, Sep 28, 2025 at 9:03=E2=80=AFPM Pasha Tatashin
> > <pasha.tatashin@soleen.com> wrote:
> >>
> [...]
> > 4. New File-Lifecycle-Bound Global State
> > ----------------------------------------
> > A new mechanism for managing global state was proposed, designed to be
> > tied to the lifecycle of the preserved files themselves. This would
> > allow a file owner (e.g., the IOMMU subsystem) to save and retrieve
> > global state that is only relevant when one or more of its FDs are
> > being managed by LUO.
>
> Is this going to replace LUO subsystems? If yes, then why? The global
> state will likely need to have its own lifecycle just like the FDs, and
> subsystems are a simple and clean abstraction to control that. I get the
> idea of only "activating" a subsystem when one or more of its FDs are
> participating in LUO, but we can do that while keeping subsystems
> around.
>
> >
> > The key characteristics of this new mechanism are:
> > The global state is optionally created on the first preserve() call
> > for a given file handler.
> > The state can be updated on subsequent preserve() calls.
> > The state is destroyed when the last corresponding file is unpreserved
> > or finished.
> > The data can be accessed during boot.
> >
> > I am thinking of an API like this.
> >
> > 1. Add three more callbacks to liveupdate_file_ops:
> > /*
> >  * Optional. Called by LUO during first get global state call.
> >  * The handler should allocate/KHO preserve its global state object and=
 return a
> >  * pointer to it via 'obj'. It must also provide a u64 handle (e.g., a =
physical
> >  * address of preserved memory) via 'data_handle' that LUO will save.
> >  * Return: 0 on success.
> >  */
> > int (*global_state_create)(struct liveupdate_file_handler *h,
> >                            void **obj, u64 *data_handle);
> >
> > /*
> >  * Optional. Called by LUO in the new kernel
> >  * before the first access to the global state. The handler receives
> >  * the preserved u64 data_handle and should use it to reconstruct its
> >  * global state object, returning a pointer to it via 'obj'.
> >  * Return: 0 on success.
> >  */
> > int (*global_state_restore)(struct liveupdate_file_handler *h,
> >                             u64 data_handle, void **obj);
> >
> > /*
> >  * Optional. Called by LUO after the last
> >  * file for this handler is unpreserved or finished. The handler
> >  * must free its global state object and any associated resources.
> >  */
> > void (*global_state_destroy)(struct liveupdate_file_handler *h, void *o=
bj);
> >
> > The get/put global state data:
> >
> > /* Get and lock the data with file_handler scoped lock */
> > int liveupdate_fh_global_state_get(struct liveupdate_file_handler *h,
> >                                    void **obj);
> >
> > /* Unlock the data */
> > void liveupdate_fh_global_state_put(struct liveupdate_file_handler *h);
>
> IMHO this looks clunky and overcomplicated. Each LUO FD type knows what
> its subsystem is. It should talk to it directly. I don't get why we are
> adding this intermediate step.
>
> Here is how I imagine the proposed API would compare against subsystems
> with hugetlb as an example (hugetlb support is still WIP, so I'm still
> not clear on specifics, but this is how I imagine it will work):
>
> - Hugetlb subsystem needs to track its huge page pools and which pages
>   are allocated and free. This is its global state. The pools get
>   reconstructed after kexec. Post-kexec, the free pages are ready for
>   allocation from other "regular" files and the pages used in LUO files
>   are reserved.

Thinking more about this, HugeTLB is different from iommufd/iommu-core
vfiofd/pci because it supports many types of FDs, such as memfd and
guest_memfd (1G support is coming soon!). Also, since not all memfds
or guest_memfd instances require HugeTLB, binding their lifecycles to
HugeTLB doesn't make sense here. I agree that a subsystem is more
appropriate for this use case.

Pasha

