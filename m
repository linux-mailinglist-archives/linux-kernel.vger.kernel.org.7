Return-Path: <linux-kernel+bounces-814932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B42B55A95
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 02:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10C65C31AE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 00:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B69712B94;
	Sat, 13 Sep 2025 00:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bGYDJcYF"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBA8C2E0
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 00:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757722701; cv=none; b=LOI64IJF7ZTBEl9s4T70/NCUpeStC09ycnBvKCjf/FkxmCU0qioybNLkxYHCL/Eh8rulcxSr3yF4BoKSVHJkyDkVrAwNc9mKsxwARptaeC2Hq7bBnpXKg8sqhQAFMqkRZ1XIKb0RI/myxYV5g6nxO3GHUSEHnItFDFD18YvhYv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757722701; c=relaxed/simple;
	bh=Mh6aGJrEoSKc8SjghJ9/lN7NlH7QvKqYibdt1arxBbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAHEPOAeB4USy/62f4H5yP6eoHF3LGJpH51SwJeDDvzlZqvy1AlJ0qAwQaoOgiktIjGFE190nxFpFRfTj9AqDkL6JPKUXZI/U+2m+ZIpBjPoqsfxcOPBUAKQFjj7dNKke3TMvg59mMEKwzG8WOQ8jrhj8RGTXFO2QGADJ2oIq3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bGYDJcYF; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-25c90c3ba65so68785ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 17:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757722700; x=1758327500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oE3G8ORdwUU6jAQHJONdXUYaEO2BnYkTOmxj8OqkFn8=;
        b=bGYDJcYFTB8L6n5vjTI6ouZqtNyQs6JGh00JjAaQv8Ed8aFEVz694UhhtOEkwYI8mV
         6ASzX/HgppuN0Y4ZH3EbnD6hE5XBrTTLD/r1Wowp+0NpTVqfCVTLZdeIdGyoIeelpOJN
         d2j+ZEvar4GAhtHSXlzIpsJysS8WFp6nWY8Vq6G6lZPFjJfD1GdXCvhQ0sRlMN9FTJRp
         IDXhswjxb8OkVGl939tGbOFD92whrxIQTka0cNeUbi/Z3fjgDaVzkqsY92Qjmslt5fzm
         4CTfX1cAqESLcn483nYWvdCReceUV6aB3ZzrJ8frEZeySS6bATxAskN+xj17BLzZjsWf
         LwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757722700; x=1758327500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oE3G8ORdwUU6jAQHJONdXUYaEO2BnYkTOmxj8OqkFn8=;
        b=bR/GXVaorXpUBoV9ExMPK4cm9dZ2AcvqY6fFrtIKwdRMbwtNZJ+J2L2DWSOXiTceql
         UALtk/y/LiU8cGKkf8DWxqpYwEKY7O3vHNDBfW9aHa93MypT5czj8ZLC7OQWG8/AnYbX
         1jvbNNAiTvWruwqkiDKojwatBiIdjy9MXRv5aYvMn7uYksgQlTqWgM4C/vb4V7VZyEzL
         fY037ik9iDl8g1ifKtFJHUhTHiZSMoWZdYQPFWfo6TI4Fh+10uliD6FRvIRooL7xAeiC
         puotHlG0JrKm/SVw29OKNC3s5sjYTUplDFeAZJrv4umJpa/zcYrQZ/coxEvyyW8re+f8
         /mog==
X-Forwarded-Encrypted: i=1; AJvYcCXxiibrtLIMYpv795NWS25ZsHr3MlJCGX42isoLSJoX0J1/34Eh7IhVgRoHyOpQt4OMwPp0f5FyXAFvkaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiIa/Pfm1VnSV4u6IBw7jsuVWj5Usdi99uj5mqptMyLYOIb5as
	5NmXaVK+R/tKBQI0wuKpUcOJnq9RkT2kILLFzwXNjOX09tw5NJ2HZKeqqvzsb0Hwa5BW8yZrdtW
	4+dz8od7/kA32lVB02qaRj0Sbs5smxRtJfNtYMMkU
X-Gm-Gg: ASbGncv9rgdNQXfwZ64EvjUL3Cvv/VOv6ytTQxlD+/3Iz9c9Lhw+4cRPhOMC1g8cAiI
	VX7KkTSWTRCXX4A6Guf7zauHeAs2SyIUpPvxv1Ho7HVcEzfJDfdrtzRtUgf+ucsutow3wPr/1if
	gaA7MLyrgUl2qhpq0C/Hfkwt7oN3rdYb9bPvdgobm8eHej95EOmxgbqgXndGWpcKwIaaGJjiSIP
	dVHOmIqBmIr71xNXnwKNLFupFotwVGonobJyWJZ36TG
X-Google-Smtp-Source: AGHT+IGzaRnKMgioFkIn9MZTAWIdQlLt1DnmIKhZcaFLkMy9Q3yssinqrzxX1g/AzMrr4tSaSGNncmZBKNCa8ms9HGE=
X-Received: by 2002:a17:903:2343:b0:25b:fba3:afa7 with SMTP id
 d9443c01a7336-260e5f7673cmr1151165ad.10.1757722699324; Fri, 12 Sep 2025
 17:18:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902111951.58315-1-kalyazin@amazon.com> <20250902111951.58315-2-kalyazin@amazon.com>
 <CADrL8HV8+dh4xPv6Da5CR+CwGJwg5uHyNmiVmHhWFJSwy8ChRw@mail.gmail.com>
 <87d562a1-89fe-42a8-aa53-c052acf4c564@amazon.com> <8e55ba3a-e7ae-422a-9c79-11aa0e17eae9@redhat.com>
 <bc26eaf1-9f01-4a65-87a6-1f73fcd00663@amazon.com> <55b727fc-8fd3-4e03-8143-1ed6dcab2781@redhat.com>
In-Reply-To: <55b727fc-8fd3-4e03-8143-1ed6dcab2781@redhat.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 12 Sep 2025 17:18:06 -0700
X-Gm-Features: Ac12FXw70ExrJvBQi4rgyWRbyc1xOL8CupFdmrDzb2GfYcck5L74n4hu4AFRWBE
Message-ID: <CAGtprH8QjeuR90QJ7byxoAPfb30kmUEDhRhzqNZqSpR8y_+z9g@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] KVM: guest_memfd: add generic population via write
To: David Hildenbrand <david@redhat.com>
Cc: kalyazin@amazon.com, James Houghton <jthoughton@google.com>, 
	"Kalyazin, Nikita" <kalyazin@amazon.co.uk>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"shuah@kernel.org" <shuah@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "michael.day@amd.com" <michael.day@amd.com>, 
	"Roy, Patrick" <roypat@amazon.co.uk>, "Thomson, Jack" <jackabt@amazon.co.uk>, 
	"Manwaring, Derek" <derekmn@amazon.com>, "Cali, Marco" <xmarcalx@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 8:39=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> >>>> What's meant to happen if we do use this for CoCo VMs? I would expec=
t
> >>>> write() to fail, but I don't see why it would (seems like we need/wa=
nt
> >>>> a check that we aren't write()ing to private memory).
> >>>
> >>> I am not so sure that write() should fail even in CoCo VMs if we acce=
ss
> >>> not-yet-prepared pages.  My understanding was that the CoCoisation of
> >>> the memory occurs during "preparation".  But I may be wrong here.
> >>
> >> But how do you handle that a page is actually inaccessible and should
> >> not be touched?
> >>
> >> IOW, with CXL you could crash the host.
> >>
> >> There is likely some state check missing, or it should be restricted t=
o
> >> VM types.
> >
> > Sorry, I'm missing the link between VM types and CXL.  How are they rel=
ated?
>
> I think what you explain below clarifies it.
>
> >
> > My thinking was it is a regular (accessible) page until it is "prepared=
"
> > by the CoCo hardware, which is currently tracked by the up-to-date flag=
,
> > so it is safe to assume that until it is "prepared", it is accessible
> > because it was allocated by filemap_grab_folio() ->
> > filemap_alloc_folio() and hasn't been taken over by the CoCo hardware.
> > What scenario can you see where it doesn't apply as of now?
>
> Thanks for clarifying, see below.
>
> >
> > I am aware of an attempt to remove preparation tracking from
> > guest_memfd, but it is still at an RFC stage AFAIK [1].
> >
> >>
> >> Do we know how this would interact with the direct-map removal?
> >
> > I'm using folio_test_uptodate() to determine if the page has been
> > removed from the direct map as kvm_gmem_mark_prepared() is what
> > currently removes the page from the direct map and marks it as
> > up-to-date.  [2] is a Firecracker feature branch where the two work in
> > combination.
>
> Ah, okay. Yes, I recalled [1] that we wanted to change these semantics
> to be "uptodate: was zeroed", and that preparation handling would be
> essentially handled by the arch backend.

Yes, I think we should not be overloading uptodate flag to be an
indicator of what is private for CoCo guests. Uptodate flag should
just mean zeroed/fresh folio. It's possible that future allocator
backing for huge pages already provides uptodate folios.

If there is no current use case for read/write for CoCo VMs, I think
it makes sense to disable it for now by checking the VM type before
adding further overloading of uptodate flags.

>
> --
> Cheers
>
> David / dhildenb
>
>

