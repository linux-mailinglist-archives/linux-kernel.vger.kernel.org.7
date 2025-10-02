Return-Path: <linux-kernel+bounces-840422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 249AABB461B
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 17:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C97B83BD3B9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 15:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC702264C7;
	Thu,  2 Oct 2025 15:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0UZ56mjI"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95124223DD0
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 15:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759419730; cv=none; b=p2dNR2A6f3kcxD6PaGRT4MDczY0qxeVt1bWKD6psKDyy9XTOVO/duhyp0UcHTLMBWeIAohdJdF+er/3SkHzqJprtQag0t3r+ptUVlljD+eyg+TqdYHEwC1Bmfb3hijP/1xJK6HApK7gIPVwFoNrqEL6s6ea+1AGdrLuhtnW/G60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759419730; c=relaxed/simple;
	bh=ELnqNe+Yjy1W6DliVLfikXo5OG04QMhkg2KzQdKNat0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWWH9neDgCa8Lkrvddm1cIIg++rjrD9NZGa992bMjpqU7Q9ZzAvS2VTVe/LmwPaFt1zcPAiI/6QeeE6NAJjhCfBxPkx5WEOzvXrLXwAdbb+uP0LhLlB6RSeEhRzTI0WE57q/RaG16hXxxAHpBOgu3pd1VkN666xluWMixdKH7dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0UZ56mjI; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2731ff54949so172725ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 08:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759419728; x=1760024528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3/8YZKb78qfaKUeDi5eSNNRwUxESShbW+B1O8PpqLE=;
        b=0UZ56mjIbj/w4YezkPNMOm4ImiRSaqKgG+kCKJUWhyuV4tbUxyKtuuVKqRaZn/Iluu
         eIFbMb0T2ECxscc9YbeZkEnisZtbxNCOwCEzGnPBnDbXDB5zNsGAeEFVm/+vXJfu4Vch
         7a1AXc3GAaI31WbOVl8sYQRHwLWM3TXB6pX2bq6j5q9sGsqClmA9HY1yHuZbLHzzJ1pt
         pkG6q2EG3GKRpvQHp967POGCmiTYl95kNhrZEelNGeoI9toTAgeHnxpDZGzdrE5k+Q63
         lxmPqZrLNFTzWNZZmZ6DZnAKLUkyIJoAxCngizIDsDPwpF45FiMhcUq575tuBNGBjVce
         kEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759419728; x=1760024528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3/8YZKb78qfaKUeDi5eSNNRwUxESShbW+B1O8PpqLE=;
        b=I/qVwohix/DUWeEVqRV0giSri4RyyHL9FD9rZx2bikDo2YPICejyz3PrYrQVZFhQiR
         TLOYQahEwt+xGma+R4ZrdX6jgKTfuwyckJ5bbwzCKuv8T6fxRAKONm9rEh9tR3bMNIES
         7OdsZrzAnrqecjopP1fZ5hheIB7JWN20IR7+q5VR6A4nXmCJcyDNg009OC9ke5wxpNqI
         svhokXHYluBNODj83RSmWUmM5YAWW6X+2dFnEY6URurndzdG9BRsE26aq3PpojN35ai5
         lRJBjFygiQpLJ1bKhA58JNQqyBnH3txpISFI/up6LGqQgU/hd9MRiHzzr3ENu3xrW4WH
         SHPA==
X-Forwarded-Encrypted: i=1; AJvYcCVe9PBKAcE2hpOVX1t37IzFboqLKNyqxNETq4PPjQKw5AU3VF60WqMnN+zSZgjlFd6XOtCEAIUA7OJweKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxebf8yyIVBN07FQqME8SwA5FBb7+0xB9sLyWXsLJwBtsX6YXkm
	JNYrMDjE0mGn6OSDvh3L3wUlXbg23CmN/e1vUyfqlFYP1QZPHyrwGwQz9geFwkgVptWQLUeEyXN
	xNTLak6KGtAbR4kNBCSuCR+Qjl/qmONsDfL85KenW
X-Gm-Gg: ASbGncs/BXXsBDj+zPrMdWznq6awWaZDWA9Pn84/PFw13v+JBYoHT6S4MdTlAWs0aYL
	+p7ljF4Iw5efs0/CUtUqjiH1bzTGRuKsm6uz/fHM3rfjB9QVuDnLUlZoHl6dxb3XN0o1OPeDHPD
	MbxX4dFnBfM5ixkm2dEXfbbFd66F3gWq9ufMvi35IekwQ+WAoHjv91qR7XNPvtDsVlr63yBIgTL
	u6AxsFTkLnQffKsaSWcN1CO7hDkXBjRc8wI18w+RDPxYLBj63cxBAEsrJwB7TrZtbPNI2Q7RU5x
	YjlI6w==
X-Google-Smtp-Source: AGHT+IGiYc77i8nX+Z2g2INjozhLBkRfFMX1H3oJMQJTQ9c5FFCBUYoMWU0i/9BJoLlAJlBLBN+UnC4qkbLI8K2O4nQ=
X-Received: by 2002:a17:902:cf0f:b0:26a:a69:1d8c with SMTP id
 d9443c01a7336-28e8ea947c7mr4078255ad.17.1759419727349; Thu, 02 Oct 2025
 08:42:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a4976f04-959d-48ae-9815-d192365bdcc6@linux.dev>
 <d2fa49af-112b-4de9-8c03-5f38618b1e57@redhat.com> <diqz4isl351g.fsf@google.com>
 <aNq6Hz8U0BtjlgQn@google.com> <aNshILzpjAS-bUL5@google.com>
 <CAGtprH_JgWfr2wPGpJg_mY5Sxf6E0dp5r-_4aVLi96To2pugXA@mail.gmail.com>
 <aN1TgRpde5hq_FPn@google.com> <CAGtprH-0B+cDARbK-xPGfx4sva+F1akbkX1gXts2VHaqyDWdzA@mail.gmail.com>
 <aN1h4XTfRsJ8dhVJ@google.com> <CAGtprH-5NWVVyEM63ou4XjG4JmF2VYNakoFkwFwNR1AnJmiDpA@mail.gmail.com>
 <aN3BhKZkCC4-iphM@google.com>
In-Reply-To: <aN3BhKZkCC4-iphM@google.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 2 Oct 2025 08:41:54 -0700
X-Gm-Features: AS18NWCJxtIe6xIIIw7eyTkEkDk9o_zgkLRq6XWM0vDf2Pb1z9fDhfHRGlEOtAA
Message-ID: <CAGtprH_evo=nyk1B6ZRdKJXX2s7g1W8dhwJhEPJkG=o2ORU48g@mail.gmail.com>
Subject: Re: [PATCH 1/6] KVM: guest_memfd: Add DEFAULT_SHARED flag, reject
 user page faults if not set
To: Sean Christopherson <seanjc@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>, David Hildenbrand <david@redhat.com>, 
	Patrick Roy <patrick.roy@linux.dev>, Fuad Tabba <tabba@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nikita Kalyazin <kalyazin@amazon.co.uk>, shivankg@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 5:04=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Wed, Oct 01, 2025, Vishal Annapurve wrote:
> > On Wed, Oct 1, 2025 at 10:16=E2=80=AFAM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > On Wed, Oct 01, 2025, Vishal Annapurve wrote:
> > > > On Wed, Oct 1, 2025 at 9:15=E2=80=AFAM Sean Christopherson <seanjc@=
google.com> wrote:
> > > > >
> > > > > On Wed, Oct 01, 2025, Vishal Annapurve wrote:
> > > > > > On Mon, Sep 29, 2025 at 5:15=E2=80=AFPM Sean Christopherson <se=
anjc@google.com> wrote:
> > > > > > >
> > > > > > > Oh!  This got me looking at kvm_arch_supports_gmem_mmap() and=
 thus
> > > > > > > KVM_CAP_GUEST_MEMFD_MMAP.  Two things:
> > > > > > >
> > > > > > >  1. We should change KVM_CAP_GUEST_MEMFD_MMAP into KVM_CAP_GU=
EST_MEMFD_FLAGS so
> > > > > > >     that we don't need to add a capability every time a new f=
lag comes along,
> > > > > > >     and so that userspace can gather all flags in a single io=
ctl.  If gmem ever
> > > > > > >     supports more than 32 flags, we'll need KVM_CAP_GUEST_MEM=
FD_FLAGS2, but
> > > > > > >     that's a non-issue relatively speaking.
> > > > > > >
> > > > > >
> > > > > > Guest_memfd capabilities don't necessarily translate into flags=
, so ideally:
> > > > > > 1) There should be two caps, KVM_CAP_GUEST_MEMFD_FLAGS and
> > > > > > KVM_CAP_GUEST_MEMFD_CAPS.
> > > > >
> > > > > I'm not saying we can't have another GUEST_MEMFD capability or th=
ree, all I'm
> > > > > saying is that for enumerating what flags can be passed to KVM_CR=
EATE_GUEST_MEMFD,
> > > > > KVM_CAP_GUEST_MEMFD_FLAGS is a better fit than a one-off KVM_CAP_=
GUEST_MEMFD_MMAP.
> > > >
> > > > Ah, ok. Then do you envision the guest_memfd caps to still be separ=
ate
> > > > KVM caps per guest_memfd feature?
> > >
> > > Yes?  No?  It depends on the feature and the actual implementation.  =
E.g.
> > > KVM_CAP_IRQCHIP enumerates support for a whole pile of ioctls.
> >
> > I think I am confused. Is the proposal here as follows?
> > * Use KVM_CAP_GUEST_MEMFD_FLAGS for features that map to guest_memfd
> > creation flags.
>
> No, the proposal is to use KVM_CAP_GUEST_MEMFD_FLAGS to enumerate the set=
 of
> supported KVM_CREATE_GUEST_MEMFD flags.  Whether or not there is an assoc=
iated
> "feature" is irrelevant.  I.e. it's a very literal "these are the support=
ed
> flags".
>
> > * Use KVM caps for guest_memfd features that don't map to any flags.
> >
> > I think in general it would be better to have a KVM cap for each
> > feature irrespective of the flags as the feature may also need
>                                                    ^^^
> > additional UAPIs like IOCTLs.
>
> If the _only_ user-visible asset that is added is a KVM_CREATE_GUEST_MEMF=
D flag,
> a CAP is gross overkill.  Even if there are other assets that accompany t=
he new
> flag, there's no reason we couldn't say "this feature exist if XYZ flag i=
s
> supported".
>
> E.g. it's functionally no different than KVM_CAP_VM_TYPES reporting suppo=
rt for
> KVM_X86_TDX_VM also effectively reporting support for a _huge_ number of =
things
> far beyond being able to create a VM of type KVM_X86_TDX_VM.
>

What's your opinion about having KVM_CAP_GUEST_MEMFD_MMAP part of
KVM_CAP_GUEST_MEMFD_CAPS i.e. having a KVM cap covering all features
of guest_memfd? That seems more consistent to me in order for
userspace to deduce the supported features and assume flags/ioctls/...
associated with the feature as a group.

