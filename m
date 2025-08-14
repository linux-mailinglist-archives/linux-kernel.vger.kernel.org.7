Return-Path: <linux-kernel+bounces-769128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 461D0B26A95
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F35B7562CAC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29A921A445;
	Thu, 14 Aug 2025 15:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="bZk5HtTP"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EBE20B1E8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755183946; cv=none; b=UXGXT6XEq2n64RAqFQEVPakjYt0q6Fg6nqwcDSM3Lpu6dFyuvsXxYyU9pjrGOwQs1s5JY1fGUFdrpsWUKL9oBAxaHIkg2IVNFwDKA9HRXxZ2xi5JH4Aip/dd6CZqFX3IWFxaqqCk/irLdiP5q7jSUfMyXnIO0+v9MFViDxYP8yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755183946; c=relaxed/simple;
	bh=MYtHCpNH7rm/Grf+WS5Mwx7BfujxUdXEAVIXm4oRgeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FKy7we1/enGeWcJqucrvM22t67EfHFKMn6iTfTQCcWtAg6x6lBVk/GVRHZqWauHX33MZNiggOEWv4ximveg+nnDVgVX/IF59/EibmqhdsCc0bI4XR9lbv64ImH2dNezHr5kpAIPsaok9YLzQDSsjD7+g3bqdeiYPcHqoK17iEy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=bZk5HtTP; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b0faa6601cso21451401cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1755183943; x=1755788743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zaTlP5pzo/qg9qINxtiKx2DfK943m3JT2OR6iyYMuY=;
        b=bZk5HtTP3xdifzseYfqy3JsWZKqx2xgMaoYvXb9szp4i5kpLke+Yt8ifotwtltcyd0
         /PJzV27vjC6pOU/v5rHOF66UH8gE3fpwZSCUBkQFRQBKHfZMRlOvsGHFlOPd1TUYKovu
         1bzkN8JisNI8cral03BJDzCDUP65OiViBh/1cWd6Yk3X2thq6v68kq1Zp7kwdBjV8tqq
         QlhqqKTC0VAWAksy3QLMqid6llYtFGrnZVJbh7NXhb2Ra0BgBPehaDzOx3UcsBi5SaJk
         KLBr6VIShk0tjB9KXAW8M+80j+n9AgzHchRfxxmxL93fG3CKYgwX6hErgyyQf2LBSXLw
         QRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755183943; x=1755788743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4zaTlP5pzo/qg9qINxtiKx2DfK943m3JT2OR6iyYMuY=;
        b=afqnnqkNAcmLSzv1VEgdjfwMW/umkl5atTl30AzCfQmxV5Oi3IhauGEAY16OK7ahNs
         uO1kmVFJvGr/w0CSPokZ5jBziWv0fv+zjFA3a2OUAW8IV4imkyxTU+kczT2s0ZaaXJWr
         ujliWfG/VQLL5DuFxqMp5RJOfqLmVWPIkwZlESeM61gOXjQ1Rno/4D0IVW5NJmcEsQNo
         zrycLCB982y6azJkU0REhBkNiydklgScd8Vra0Otd/3jczvP2vyRPORTtpdCk/GORglp
         1Jvcu8QP2l7lS5eV+WKmD9Xz28w+Ax3XnRJfX8OzQ6GIMlh0+Y2OBM/gvX6f42H7nw8R
         eDgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3otoM3OnUwWeyzJpYHXCZS/kGWd3LKIjGmxtW5PA+i33XkoviHD6wipsxwQeDd+dhLLunJ6TmH2PktnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlUkeaXLf/fvyNgQpopZJFBZLHzJb1RKIY36RMnGAL41UZtQHx
	s0gfKRx8HrRNWDf6o2sUtoDvGPbsbKvhEYRYtEnSGrN3yXLsABPAuyrCdTB/xGhNUM5yAcpSIw1
	tOg7j0C1CCidD0UWQ0OERBiLqLOEOhMQ5I/hzyGxBwQ==
X-Gm-Gg: ASbGncvmthA8uaXJZaCgHNhZmWt0AS7ixzcUWqMTid6Ba/PDAl3/GuBNpmaMzYY4ecV
	o3NJeI/ocg+cTYlz1A6DDmE9Qj5XCZeyTn3dxpDL/3TQDIn4LbI3DrTEcZutfqjPGWwIrfVsq9Q
	XP0L8JVxQQ4GrNg8ZC4RTbE6L3Llkumdp13+mFJvSpA2UpPoQj2BPkXz3dKX/P1jlLQkBNqJjbA
	oEPT0xZmVYLJZ8=
X-Google-Smtp-Source: AGHT+IGd/DJ84Imu5KYRHkgnpNm4NZ636lX1WUQFrgSI87aMZKq+0zSxGBg+110FdN/squBIYOywjRpAp8ettpbigko=
X-Received: by 2002:a05:622a:5e09:b0:4b1:1109:6090 with SMTP id
 d75a77b69052e-4b1110964camr21827551cf.4.1755183943358; Thu, 14 Aug 2025
 08:05:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-8-pasha.tatashin@soleen.com> <20250814132233.GB802098@nvidia.com>
In-Reply-To: <20250814132233.GB802098@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 14 Aug 2025 15:05:04 +0000
X-Gm-Features: Ac12FXy7hDZjxYMY4c9rpouOJZeOk5g8OwQ5wREtab5YlBDjZqQf27ADm8vAB8Y
Message-ID: <CA+CK2bCbjmRKtVVAok7GH8xvh8JWrga5Oj-iK-p=1M79AqvhRA@mail.gmail.com>
Subject: Re: [PATCH v3 07/30] kho: add interfaces to unpreserve folios and
 physical memory ranges
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 1:22=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Thu, Aug 07, 2025 at 01:44:13AM +0000, Pasha Tatashin wrote:
> > +int kho_unpreserve_phys(phys_addr_t phys, size_t size)
> > +{
>
> Why are we adding phys apis? Didn't we talk about this before and
> agree not to expose these?

It is already there, this patch simply completes a lacking unpreserve part.

We can talk about removing it in the future, but the phys interface
provides a benefit of not having to preserve  power of two in length
objects.

>
> The places using it are goofy:
>
> +static int luo_fdt_setup(void)
> +{
> +       fdt_out =3D (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
> +                                          get_order(LUO_FDT_SIZE));
>
> +       ret =3D kho_preserve_phys(__pa(fdt_out), LUO_FDT_SIZE);
>
> +       WARN_ON_ONCE(kho_unpreserve_phys(__pa(fdt_out), LUO_FDT_SIZE));
>
> It literally allocated a page and then for some reason switches to
> phys with an open coded __pa??
>
> This is ugly, if you want a helper to match __get_free_pages() then
> make one that works on void * directly. You can get the order of the
> void * directly from the struct page IIRC when using GFP_COMP.

I will make this changes.

>
> Which is perhaps another comment, if this __get_free_pages() is going
> to be a common pattern (and I guess it will be) then the API should be
> streamlined alot more:
>
>  void *kho_alloc_preserved_memory(gfp, size);
>  void kho_free_preserved_memory(void *);

Hm, not all GFP flags are compatible with KHO preserve, but we could
add this or similar API, but first let's make KHO completely
stateless: remove, finalize and abort parts from it.

>
> Which can wrapper the get_free_pages and the preserve logic and gives
> a nice path to possibly someday supporting non-PAGE_SIZE allocations.
>
> Jason

