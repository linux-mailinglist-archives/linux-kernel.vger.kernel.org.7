Return-Path: <linux-kernel+bounces-791008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 972EDB3B112
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 04:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9E971B23119
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 02:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A51421D3F3;
	Fri, 29 Aug 2025 02:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="AhQqxK7D"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E271FCF41
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 02:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756435250; cv=none; b=WmjUoP6NXUOfDxaU+MnkfNA8nqUUGUVyls7eVCJyRdYJqHiPEB2X283MuS3eGyj9G7rbCgoDy8EFjyiBc88jTIofJ0N49mepo80TIRDjkKOQI5WPedRvMWgcdhyRfGSSTf+X4qxDDE0c8FfShIbChtK41c3k1RQqaiQ8WXsZfKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756435250; c=relaxed/simple;
	bh=1rc25cTIqjjOz8QUgkVtPyp6ikf2DOOaXB7T4eWd4qo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bzSzdDKVx8U3crbVfoHs46YYCUWVVf5Jy045e5t3/stWxgrpsa+e+VCWu2Nj+aMxjXNc72r9Ev22wWdTSKgWIljrkyqj33E5TLL6loA+PPrFgXXlEJs85GuxDJMXmjbxogy5EsLGueRdtYqgw/R2AmxLd963IX/xATDpUZYtzNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=AhQqxK7D; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b297962b24so16456641cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 19:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1756435248; x=1757040048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Zy6qlRujNRvsanVAYiBzYvZ4C5MT/ROGnbV1WkURNs=;
        b=AhQqxK7Djehs0IxZA9g5x9qdRwPs8gD5+88GeMJ9K41QotLivA+FYALXHlZBt492pA
         vZUFRPqCGIUEA6BoS2ZreCNXI/QMoHUiYbRIfyX705mJfuPu2xBcEMzZL5AY6IgIRFRU
         n1K/I6bWb/sBq6KADaK5UaHuejtiYYZlkQZHSPqgbxYyiuaFZo8lz/+F5CqIZYyR6kOU
         7R/ySZGWxOXhnuUltRaIKJJ38f1d/ItzJ5/dewq54chdZvoHD5BHJ/GhDWOZp1QtwiMF
         2owZ8n0baVZhixwrZfCTvwQ6kf4M/Gi1GNgn2jLizQueM8YOYlfvGKRKURm2Z9T0GupF
         gVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756435248; x=1757040048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Zy6qlRujNRvsanVAYiBzYvZ4C5MT/ROGnbV1WkURNs=;
        b=W78OmCpSWwyq9YSRSMoODK/j1lhQsnnIaKIQL2mAL1uTaAbzF217mVZMdDjI3nYtYY
         BkusMTypnX1vLiIkBu9Kf3qZxb8fnnN/LUTTcXuYcZ3uWuS20AmDTrKhUDDiOLrIZ52h
         KcMT81dH3G6hC2EpVjOCPc1BIf+ldIhSqbyrBXGA0QPzU82kYeUsVkOALyyxqP0HotCi
         iQKwj6T9LncxYzbml4KfjBU1PPZAl7GZWwBWTJN5NtdOPsn9xMUcf7X/sSjUBWRgASlF
         SPoMFcLsboACFp40JDfPTCwOkibETeq595Z9RrkgD/9ZCY3UFpAg1sBYIUe3gSJL1Onn
         B0Fw==
X-Forwarded-Encrypted: i=1; AJvYcCXm/rBPnTpcn2izo6QRAjpK4iWX/XT9B8GOt8I9h7jYzNzfCAuBD4g9dJR9UxXtqKmhf1lHdBB3FJu4ip8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH8AbY3lgutKdlOus3D1MBRR/Ns2wREI35oC2FJMsr43La31uE
	uznl6x25CHeuaG3RnqljKnOHWotnIjmY2Y7gAwStYI0vyddRMIbFguoUdkAtGPIkvsnmUSlpXiZ
	Q0a1bGgPQOZiWvTNd1lCrHxVOWTQbzBRKLS1xzYrv0Q==
X-Gm-Gg: ASbGncudDTEEj8QwS81R0ktyiISDknhIkqvZMTpHFWgQRykDMWo/g9T0nSmNAI900Jb
	CV0jB2hUMxq9pPR55+jc1y/wbCfZBj+lWUBCoayv+A6YsNfSnXlKJ/PncvQwtfONagnhAIb68R3
	+fW28TCMlsbWLyF4WgzJtoAqomTbtlnBlvcjIg4RXdlMOgqisIOe0aZ87Yd4abnCspKHNkI0dhC
	bWt
X-Google-Smtp-Source: AGHT+IHwXj+LBZuJEcqAH63FcF7Bf6gg8caP9O+PnQGOchIvb5/XFjh6XaIc3WnVFKQjw020TTzcQhZZqWvU0FReMKg=
X-Received: by 2002:ac8:5e49:0:b0:4b2:9ac2:686e with SMTP id
 d75a77b69052e-4b2aab4a159mr308961841cf.77.1756435247854; Thu, 28 Aug 2025
 19:40:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612114210.2786075-1-mclapinski@google.com>
 <685c67525ba79_2c35442945@iweiny-mobl.notmuch> <CAAi7L5cq9OqRGdyZ07rHhsA8GRh2xVXYGh7n20UoTCRfQK03WA@mail.gmail.com>
 <CAAi7L5djEJCVzWWjDMO7WKbXgx6Geba6bku=Gjj2DnBtysQC4A@mail.gmail.com> <68b0f92761d25_293b329449@iweiny-mobl.notmuch>
In-Reply-To: <68b0f92761d25_293b329449@iweiny-mobl.notmuch>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 28 Aug 2025 22:40:11 -0400
X-Gm-Features: Ac12FXwmgsLWCvC9t_zrDymTIu_H7ymCFDa4DGCwoCVIx5lOzsb8sPf1krkiuUE
Message-ID: <CA+CK2bAPJR00j3eFZtF7WgvgXuqmmOtqjc8xO70bGyQUSKTKGg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] libnvdimm/e820: Add a new parameter to configure
 many regions per e820 entry
To: Ira Weiny <ira.weiny@intel.com>
Cc: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev, 
	"Paul E. McKenney" <paulmck@kernel.org>, Thomas Huth <thuth@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 8:48=E2=80=AFPM Ira Weiny <ira.weiny@intel.com> wro=
te:
>
> Micha=C5=82 C=C5=82api=C5=84ski wrote:
> > On Tue, Jul 1, 2025 at 2:05=E2=80=AFPM Micha=C5=82 C=C5=82api=C5=84ski =
<mclapinski@google.com> wrote:
> > >
> > > On Wed, Jun 25, 2025 at 11:16=E2=80=AFPM Ira Weiny <ira.weiny@intel.c=
om> wrote:
> > > >
> > > > Michal Clapinski wrote:
> > > > > This includes:
> > > > > 1. Splitting one e820 entry into many regions.
> > > > > 2. Conversion to devdax during boot.
> > > > >
> > > > > This change is needed for the hypervisor live update. VMs' memory=
 will
> > > > > be backed by those emulated pmem devices. To support various VM s=
hapes
> > > > > I want to create devdax devices at 1GB granularity similar to hug=
etlb.
> > > > > Also detecting those devices as devdax during boot speeds up the =
whole
> > > > > process. Conversion in userspace would be much slower which is
> > > > > unacceptable while trying to minimize
> > > >
> > > > Did you explore the NFIT injection strategy which Dan suggested?[1]
> > > >
> > > > [1] https://lore.kernel.org/all/6807f0bfbe589_71fe2944d@dwillia2-xf=
h.jf.intel.com.notmuch/
> > > >
> > > > If so why did it not work?
> > >
> > > I'm new to all this so I might be off on some/all of the things.
> > >
> > > My issues with NFIT:
> > > 1. I can either go with custom bios or acpi nfit injection. Custom
> > > bios sounds rather aggressive to me and I'd prefer to avoid this. The
> > > NFIT injection is done via initramfs, right? If a system doesn't use
> > > initramfs at the moment, that would introduce another step in the boo=
t
> > > process. One of the requirements of the hypervisor live update projec=
t
> > > is that the boot process has to be blazing fast and I'm worried
> > > introducing initramfs would go against this requirement.
> > > 2. If I were to create an NFIT, it would have to contain thousands of
> > > entries. That would have to be parsed on every boot. Again, I'm
> > > worried about the performance.
> > >
> > > Do you think an NFIT solution could be as fast as the simple command
> > > line solution?
> >
> > Hello,
> > just a follow up email. I'd like to receive some feedback on this.
>
> Apologies.  I'm not keen on adding kernel parameters so I'm curious what
> you think about Mike's new driver?[1]

Hi Ira,

Mike's proposal and our use case are different.

What we're proposing is a way to automatically convert emulated PMEM
into DAX/FSDAX during boot and subdivide it into page-aligned chunks
(e.g., 1G/2M). We have a userspace agent that then manages these
devdax devices, similar to how HugeTLB pages are handled, allowing the
chunks to be used in a cloud environment to support guest memory for
live updates.

To be clear, we are not trying to make the carved-out PMEM region
scalable. The hypervisor's memory allocation stays the same, and these
PMEM/DAX devices are used exclusively for running VMs. This approach
isn't intended for the general-purpose, scalable persistent memory use
case that Mike's driver addresses.

Pasha

