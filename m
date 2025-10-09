Return-Path: <linux-kernel+bounces-847576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C25EBCB3A3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AC1F935283A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 23:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C184728BAB1;
	Thu,  9 Oct 2025 23:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="aMd7P99H"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FB622688C
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 23:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760053854; cv=none; b=PlvUmc4RO+4k42neECK0an1EZr91gy5lVcRFDe4Me2E5bou2pxmD1puRliRkBsoTNAWFp8tHe6Z6mvNLNs7gfyc/fr3BbzHM1jk8SrlEzKBNHXDROa9Z7OPYpPrEjEvFnChcxZZAib3e3JE09ph9hc/9AC5XK8v/Dw01SR5Wx5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760053854; c=relaxed/simple;
	bh=RBllid+aFWJXPFcDfK2K4LligRlxSufDVtshFkolupE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fd3MIo4d1ovhxK2xh4Jfz0N6l6T0MxXSnLPnmyfROvofpW6FWkSP03Uso5m/TmBIqDsKd7YtR4D811CZhxErmK1hcYMqqbs9DHk8gTbZHPQBFqZvLRlapewq3P2TnHNnMHmHi+JZUvQsRcHKjF98Yb82uRbjOZqw577q3b31of8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=aMd7P99H; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4de659d5a06so8625381cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 16:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760053850; x=1760658650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=duqVUT7go4ZxqESg3UfMQLseHStSvb4cyv2AmihGRqU=;
        b=aMd7P99HMdyKxbj1Df9FQ0LIct+grQh7Iw6Lrs0lNw3+OorXg+IZGHdaukKaqFEE0u
         CDqc2AXBc2i+Lh8liAYO8/GadSGY8LXuVbeJApaxGUvybh53h/peOEu7oBiToD1p1Cpw
         w86uwRV+7V9iZlmNSXgmXwCSwkqAQQxxE4qRQcVEIzD+gXCP89VPlmvOwlRqNmlDiVG6
         fV7GNQUSIhuSx0AxP7cX3oItljKbKftWMGq9yMFSSdOYj7vpFJtFRhAM6PcbH5efEceg
         sAUDA5aWEdiScdhsfXB+jFWtnQQNCHAlqU90bE1AogoHue5gx6njxy68DOld0cm0aByW
         +72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760053850; x=1760658650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=duqVUT7go4ZxqESg3UfMQLseHStSvb4cyv2AmihGRqU=;
        b=rSXMFKgtXm3kGWhioiClx/DPDf2p2OgzvX5Z7fMHaNaMKVG/NQOo49HxfvuU1woVKu
         iorM0BxOqmS654STwkQAggAJTXxhG0YajvzfZtWv4yTOIWRArSFzS1YnhUwZMVRImCjp
         rcf7LUR+TUF2YOFGykKYv7/8vqdlTu0xeNql8589VT/QCVBX3nPUfUTKnKZRf0QSlgSW
         sD97kyg+ubnECAEjjuRSKaLtyR9N8vhDooDAYyCYC11yDZqIj7PfENN/QvvGHXlrNcND
         NTjxcgYyJUfZjN44hAnQlaoSKcq0/oep0a5+sYSaqFqpjKgbFAIqeTBHY8snvlKJT5bV
         4Hcw==
X-Forwarded-Encrypted: i=1; AJvYcCVWslVw8BsJbL429ZyO5h2HF7OJ65Yv1/p3A3hAiswN9lYoXSpVW/HFkoDFDHrwZvThElZgfsORhHoB/PI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrgT8cYo76waySMtoKPMSPQIeTJu2IdO60/drWP9GVl0qfnIUd
	Fk9RTad9hJMag2iE8OtCfv86ZXFxoc6p1NqYBgltAA9OrRFp9d5N1VemIU5qaCWu0KoR4foGE2+
	g+w6ThdXnxKPvWe2QtI6k8oDeM79okroRBcB8u/dv4Q==
X-Gm-Gg: ASbGncspMg3jl2IjSrmRv9aDwb/UMvBBVCUi9SuFBC0efSTF1XdzWuWMra0eQMuF741
	fTY2y9wQa94dtrvcysIEp9U+jTfCw7lzMSXzanaADq0DQqTm6TbUGeVrp/Qilkt184mGO5ZoAaL
	BOgIPV4f/SmTkO+kmVrSrZpqhlol4zksxrSAPUEe5/qjc8kpS6f8cVsHD7Q4dJTeMVmo4DjDrFa
	R5ifh1acST2gcXWayB9fw2tCZ6D
X-Google-Smtp-Source: AGHT+IGzqqa1G0zf+VY5jF5o2/K3FQsYskXGylhSVDPQarH8ovd8yjaXj+2lxEhldlKlDevfO9Pxw709v3uWNVO/hiM=
X-Received: by 2002:a05:622a:1144:b0:4d2:1a1f:135b with SMTP id
 d75a77b69052e-4e6eaccc2d9mr144181361cf.3.1760053849859; Thu, 09 Oct 2025
 16:50:49 -0700 (PDT)
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
Date: Thu, 9 Oct 2025 19:50:12 -0400
X-Gm-Features: AS18NWA4BkWoWx107a5jn9RdQA3zHB-3kx_1Bn3qMWWFPgKkAAD4CNjnYqMlYPA
Message-ID: <CA+CK2bB6F634HCw_N5z9E5r_LpbGJrucuFb_5fL4da5_W99e4Q@mail.gmail.com>
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

Thanks for the feedback. The FLB Global State is not replacing the LUO
subsystems. On the contrary, it's a higher-level abstraction that is
itself implemented as a LUO subsystem. The goal is to provide a
solution for a pattern that emerged during the PCI and IOMMU
discussions.

You can see the WIP implementation here, which shows it registering as
a subsystem named "luo-fh-states-v1-struct":
https://github.com/soleen/linux/commit/94e191aab6b355d83633718bc4a1d27dda39=
0001

The existing subsystem API is a low-level tool that provides for the
preservation of a raw 8-byte handle. It doesn't provide locking, nor
is it explicitly tied to the lifecycle of any higher-level object like
a file handler. The new API is designed to solve a more specific
problem: allowing global components (like IOMMU or PCI) to
automatically track when resources relevant to them are added to or
removed from preservation. If HugeTLB requires a subsystem, it can
still use it, but I suspect it might benefit from FLB Global State as
well.

> Here is how I imagine the proposed API would compare against subsystems
> with hugetlb as an example (hugetlb support is still WIP, so I'm still
> not clear on specifics, but this is how I imagine it will work):
>
> - Hugetlb subsystem needs to track its huge page pools and which pages
>   are allocated and free. This is its global state. The pools get
>   reconstructed after kexec. Post-kexec, the free pages are ready for
>   allocation from other "regular" files and the pages used in LUO files
>   are reserved.
>
> - Pre-kexec, when a hugetlb FD is preserved, it marks that as preserved
>   in hugetlb's global data structure tracking this. This is runtime data
>   (say xarray), and _not_ serialized data. Reason being, there are
>   likely more FDs to come so no point in wasting time serializing just
>   yet.
>
>   This can look something like:
>
>   hugetlb_luo_preserve_folio(folio, ...);
>
>   Nice and simple.
>
>   Compare this with the new proposed API:
>
>   liveupdate_fh_global_state_get(h, &hugetlb_data);
>   // This will have update serialized state now.
>   hugetlb_luo_preserve_folio(hugetlb_data, folio, ...);
>   liveupdate_fh_global_state_put(h);
>
>   We do the same thing but in a very complicated way.
>
> - When the system-wide preserve happens, the hugetlb subsystem gets a
>   callback to serialize. It converts its runtime global state to
>   serialized state since now it knows no more FDs will be added.
>
>   With the new API, this doesn't need to be done since each FD prepare
>   already updates serialized state.
>
> - If there are no hugetlb FDs, then the hugetlb subsystem doesn't put
>   anything in LUO. This is same as new API.
>
> - If some hugetlb FDs are not restored after liveupdate and the finish
>   event is triggered, the subsystem gets its finish() handler called and
>   it can free things up.
>
>   I don't get how that would work with the new API.

The new API isn't more complicated; It codifies the common pattern of
"create on first use, destroy on last use" into a reusable helper,
saving each file handler from having to reinvent the same reference
counting and locking scheme. But, as you point out, subsystems provide
more control, specifically they handle full creation/free instead of
relying on file-handlers for that.

> My point is, I see subsystems working perfectly fine here and I don't
> get how the proposed API is any better.
>
> Am I missing something?

No, I don't think you are. Your analysis is correct that this is
achievable with subsystems. The goal of the new API is to make that
specific, common use case simpler.

Pasha

