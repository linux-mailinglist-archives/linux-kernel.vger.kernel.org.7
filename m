Return-Path: <linux-kernel+bounces-792320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCE4B3C2A9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 20:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D703BA64294
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA8B1F4C99;
	Fri, 29 Aug 2025 18:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDPvnxOH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F11192D68
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 18:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756493250; cv=none; b=QxEpAXbiZMJihABr472keLOIFSsGVlwTXjTaIgvv/2qPN7X5XUnU0LblNnXOe82fqWbVxFrGomY8xaZz9AZns1PfX1X1M6KHs2xZoCnALLeaQAcu3bR9bIYNf2epRAGv7nC9AnEsSzyd3VboGMpNubk67kmxUUHfxRZjx0+6Xm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756493250; c=relaxed/simple;
	bh=EGsrl7rz3n15ufVe4i49SD1EQ18PX9TeDC0B390PTkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YiJdR0bEL5xKjJR5QBPEvzZ8RbZ8jXrCvbXXvlOTt+nQIfW8YgT7H9KLw63R5iCl/lHVTybVcmEPB3RviWa+u0kjjvV4EEtU+BDf/QDYAFLQU9jFY+8BwcxV03jZC/k2r+lNFUD4OLF1eOWTh2npWp2xuGEI4zO3LaL3h5c7+jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDPvnxOH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4229EC4CEF6
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 18:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756493250;
	bh=EGsrl7rz3n15ufVe4i49SD1EQ18PX9TeDC0B390PTkM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QDPvnxOHQiaw+V/AJpBaKUWuUvF9UjbrFHSJHT0znUaYPxTkiRUk9F6oBoo9v+sK7
	 3ll/lYPhb1TAxlpZVrfrWoGILcQ3boZDh+mSRKEb/Jfj8F2lMX2xFd2tHaX0OjamrV
	 ijMlZYzFk5IZBuQkS+cKcjhMRtwjiXQiemN+iPGwuzeAxe9wo3byWcIzXNYvbackEM
	 Ifg0XrMLqzVsDhD8wXRwQivSOLhMmxGuHRmcP3HqYQqo53pYTfidmbtRqDEtlJx7Wk
	 b04sfCVlU38IhAZht/21vwPfoTmqDpdVPI2FG+3AkVnx3tShvYVkmYmH/vfoYLo48/
	 6jTbkXFLFKINg==
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b7ed944d2so10975e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 11:47:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvm6fojF+HpV6SvUWh/+cLX6nSnH3J8AnctqrZA4UW6ryNtH7s0IYI1yGS5bgc7/xXztGVEV/Rzu2H/M4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlDT2q/3qCMyd1ckX4RwXRJ4Vjemxo7Pi9FU8zDhLtjaOAzQyT
	RIGXi1TKVnfjx0oXvEdHvJmz9ExYN0r7Kyb2D6IPmvxvV+e8q05qX/eYwk3U4p3SJVpStn+snRp
	QX1rxeGV1bG4VRvo8Ob+5m1/gKhsNLH0uoSp0zMsB
X-Google-Smtp-Source: AGHT+IG5VqIPsa1pNgB3YpFXWfQW+7in5f1Vpw/ePfgPKB7etQPfYgqx6A7wIUSMvQ3seox/XRRqlLcg0U88oq9rT90=
X-Received: by 2002:a05:600c:4ba3:b0:45a:207a:eb7c with SMTP id
 5b1f17b1804b1-45b84a46376mr105495e9.0.1756493248442; Fri, 29 Aug 2025
 11:47:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-30-pasha.tatashin@soleen.com> <20250826162019.GD2130239@nvidia.com>
 <aLABxkpPcbxyv6m_@kernel.org>
In-Reply-To: <aLABxkpPcbxyv6m_@kernel.org>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 29 Aug 2025 11:47:17 -0700
X-Gmail-Original-Message-ID: <CAF8kJuN+CsXo2QwrMvcSkn=_WB+zqikgLK9=ydqUDj+8Osmf6Q@mail.gmail.com>
X-Gm-Features: Ac12FXylXHzcyalG6rdr2bLhlKKgB6oI5FD3MKZgay4nA6t-yrJgNr96GL2gOCI
Message-ID: <CAF8kJuN+CsXo2QwrMvcSkn=_WB+zqikgLK9=ydqUDj+8Osmf6Q@mail.gmail.com>
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
To: Mike Rapoport <rppt@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, pratyush@kernel.org, 
	jasonmiu@google.com, graf@amazon.com, changyuanl@google.com, 
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
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
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 12:14=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wr=
ote:
>
> On Tue, Aug 26, 2025 at 01:20:19PM -0300, Jason Gunthorpe wrote:
> > On Thu, Aug 07, 2025 at 01:44:35AM +0000, Pasha Tatashin wrote:
> >
> > > +   err =3D fdt_property_placeholder(fdt, "folios", preserved_size,
> > > +                                  (void **)&preserved_folios);
> > > +   if (err) {
> > > +           pr_err("Failed to reserve folios property in FDT: %s\n",
> > > +                  fdt_strerror(err));
> > > +           err =3D -ENOMEM;
> > > +           goto err_free_fdt;
> > > +   }
> >
> > Yuk.
> >
> > This really wants some luo helper
> >
> > 'luo alloc array'
> > 'luo restore array'
> > 'luo free array'
> >
> > Which would get a linearized list of pages in the vmap to hold the
> > array and then allocate some structure to record the page list and
> > return back the u64 of the phys_addr of the top of the structure to
> > store in whatever.
> >
> > Getting fdt to allocate the array inside the fds is just not going to
> > work for anything of size.
>
> I agree that we need a side-car structure for preserving large (potential=
ly
> sparse) arrays, but I think it should be a part of KHO rather than LUO.

I agree this can be used by components outside of LUO as well. Ideally
as some helper library so every component can use it. I don't have a
strong opinion on KHO or the stand alone library. I am fine with both.

Chris

