Return-Path: <linux-kernel+bounces-840885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A32A4BB5A85
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 02:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E70C1AE4C71
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 00:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A91BBE49;
	Fri,  3 Oct 2025 00:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KQC8WLHB"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339D815C0
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 00:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759450337; cv=none; b=n1y3W6nS8PMIfD+XZJSs5/QtnfhwMv/g6SQvUGNKKlC8l3xdt4H/8MJuXk/zH2GhyA8iUjLx2812PXEE65aTsa7MhxUSYSgcEC+BRauWOZI24Q1VUjfB5UYhp5Rqqy6fjiTlAYvJmLqALJrtBXwU93cMWrZipCrlLtm3Wxpa51w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759450337; c=relaxed/simple;
	bh=N/zkZP+0LZtLP17Xs3vMEpCfEyZZ1ItxxmOimzq44Q0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sK2kT+EfezE4tcOL6TFbjIPsIv/uFgL7bCSp6sDrR+bFq7iVdR3HVDvePoeSGbODsNTEP+KOlUNs5xrT7RoPg8xCFik539hAHTAbZHHw3rsHMGXHvzHmnZNjWcS0Gt86xd2qauDmZlwM1rzO6RmmpcO8BnJHbz9KO5L5RZDVmCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KQC8WLHB; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-269af520712so15710595ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 17:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759450331; x=1760055131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WPdEjt/xHjJ0lWLh6C12W1rdGBrApuW7akOrulxizXQ=;
        b=KQC8WLHBEK40b5d5u/Ur26hBCZVJZ5/rllQyLVKhq+IcJ6P3DybInZxAIDDDjSYKQM
         QxfG+FFpAPppUkkdNRXIQmzCLw1IoKeFZIL9LqtVNnaSa1jn6Tx733Nm9YrAwwJ48oAb
         b6EX+zqUQkHaiNzKpaOVJK7Lz4sWQzzA/wcOssHJ9Xa8M6dc4450inS1YqkviItA4k81
         06+QEezxrISLVITQUmSjds97SbwBu5JRj9evAlFMVimP7eGX7B/Q23NgTIeD4fhNfCAi
         tXY2jydpoZ1T2rJlFAD5otweXyyeDV9ZQVFDkKHlB0cJJgUEmKMDX7YhIDgwoapuc+L+
         jY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759450331; x=1760055131;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WPdEjt/xHjJ0lWLh6C12W1rdGBrApuW7akOrulxizXQ=;
        b=e+Cn0BEEWLi83y/EZWcNnMZ56H7uzs4IFS7ybf3C/pKuIwKPC++mRzLfEkfhBpLM6Q
         TMbbpm1hNpsHSwi5buOCW5sRoJZ+ZniopFfDbf1hrj7t54DTNFqdj6TdZIFqkm14b3Ra
         nJ6hySnGOuGWuEtjkasKvlxmRwiFKgfa61xveSQe/kxCxMKO9psip+wb3sc2tiKps8Kz
         6ZwFfyrKhW1Tit7iof1rp0avhV0qZNCo9b33BOokaWLEMMkdy4rSYdh8KcYpQKn0094j
         TDnFS4qLiSR8IBb8ruaiMnsWty9xN9DpsM9dER6W1W7HqJ5wSivmNMqrZMxIBX/GfE8w
         LMCg==
X-Forwarded-Encrypted: i=1; AJvYcCUzgZROp7s3k3IIOy0hAqn+IlaRVOhJgMbrP4G3b9mENzHGf5lMX8L2xTzZmpI3lg+q02GcL/rjjsOiOGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBphwUDySsJdZvBX936UKd8OaXcKw/1ykf9wRcsxyr3mK80eND
	Mk+qD5PfpbCmjSzGkjVcrO0S+8xopUeRlDYL0Axjg3zKmf0kFGQFOaEFgXYSU8o0S1fGF0H9BpM
	VTSIUDQ==
X-Google-Smtp-Source: AGHT+IHoyklPfuWfmJXHPs/SfTKlY2scG3kvCp1ofGl7GvfzX+eJGKVR6q69Si5yRV1Gn0G/XXpq74H1nZc=
X-Received: from plw21.prod.google.com ([2002:a17:903:45d5:b0:27e:dc53:d244])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f0d:b0:267:87be:505e
 with SMTP id d9443c01a7336-28e9a596df5mr11683975ad.23.1759450331443; Thu, 02
 Oct 2025 17:12:11 -0700 (PDT)
Date: Thu, 2 Oct 2025 17:12:09 -0700
In-Reply-To: <CAGtprH_evo=nyk1B6ZRdKJXX2s7g1W8dhwJhEPJkG=o2ORU48g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <diqz4isl351g.fsf@google.com> <aNq6Hz8U0BtjlgQn@google.com>
 <aNshILzpjAS-bUL5@google.com> <CAGtprH_JgWfr2wPGpJg_mY5Sxf6E0dp5r-_4aVLi96To2pugXA@mail.gmail.com>
 <aN1TgRpde5hq_FPn@google.com> <CAGtprH-0B+cDARbK-xPGfx4sva+F1akbkX1gXts2VHaqyDWdzA@mail.gmail.com>
 <aN1h4XTfRsJ8dhVJ@google.com> <CAGtprH-5NWVVyEM63ou4XjG4JmF2VYNakoFkwFwNR1AnJmiDpA@mail.gmail.com>
 <aN3BhKZkCC4-iphM@google.com> <CAGtprH_evo=nyk1B6ZRdKJXX2s7g1W8dhwJhEPJkG=o2ORU48g@mail.gmail.com>
Message-ID: <aN8U2c8KMXTy6h9Q@google.com>
Subject: Re: [PATCH 1/6] KVM: guest_memfd: Add DEFAULT_SHARED flag, reject
 user page faults if not set
From: Sean Christopherson <seanjc@google.com>
To: Vishal Annapurve <vannapurve@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>, David Hildenbrand <david@redhat.com>, 
	Patrick Roy <patrick.roy@linux.dev>, Fuad Tabba <tabba@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nikita Kalyazin <kalyazin@amazon.co.uk>, shivankg@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 02, 2025, Vishal Annapurve wrote:
> On Wed, Oct 1, 2025 at 5:04=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> >
> > On Wed, Oct 01, 2025, Vishal Annapurve wrote:
> > > On Wed, Oct 1, 2025 at 10:16=E2=80=AFAM Sean Christopherson <seanjc@g=
oogle.com> wrote:
> > > >
> > > > On Wed, Oct 01, 2025, Vishal Annapurve wrote:
> > > > > On Wed, Oct 1, 2025 at 9:15=E2=80=AFAM Sean Christopherson <seanj=
c@google.com> wrote:
> > > > > >
> > > > > > On Wed, Oct 01, 2025, Vishal Annapurve wrote:
> > > > > > > On Mon, Sep 29, 2025 at 5:15=E2=80=AFPM Sean Christopherson <=
seanjc@google.com> wrote:
> > > > > > > >
> > > > > > > > Oh!  This got me looking at kvm_arch_supports_gmem_mmap() a=
nd thus
> > > > > > > > KVM_CAP_GUEST_MEMFD_MMAP.  Two things:
> > > > > > > >
> > > > > > > >  1. We should change KVM_CAP_GUEST_MEMFD_MMAP into KVM_CAP_=
GUEST_MEMFD_FLAGS so
> > > > > > > >     that we don't need to add a capability every time a new=
 flag comes along,
> > > > > > > >     and so that userspace can gather all flags in a single =
ioctl.  If gmem ever
> > > > > > > >     supports more than 32 flags, we'll need KVM_CAP_GUEST_M=
EMFD_FLAGS2, but
> > > > > > > >     that's a non-issue relatively speaking.
> > > > > > > >
> > > > > > >
> > > > > > > Guest_memfd capabilities don't necessarily translate into fla=
gs, so ideally:
> > > > > > > 1) There should be two caps, KVM_CAP_GUEST_MEMFD_FLAGS and
> > > > > > > KVM_CAP_GUEST_MEMFD_CAPS.
> > > > > >
> > > > > > I'm not saying we can't have another GUEST_MEMFD capability or =
three, all I'm
> > > > > > saying is that for enumerating what flags can be passed to KVM_=
CREATE_GUEST_MEMFD,
> > > > > > KVM_CAP_GUEST_MEMFD_FLAGS is a better fit than a one-off KVM_CA=
P_GUEST_MEMFD_MMAP.
> > > > >
> > > > > Ah, ok. Then do you envision the guest_memfd caps to still be sep=
arate
> > > > > KVM caps per guest_memfd feature?
> > > >
> > > > Yes?  No?  It depends on the feature and the actual implementation.=
  E.g.
> > > > KVM_CAP_IRQCHIP enumerates support for a whole pile of ioctls.
> > >
> > > I think I am confused. Is the proposal here as follows?
> > > * Use KVM_CAP_GUEST_MEMFD_FLAGS for features that map to guest_memfd
> > > creation flags.
> >
> > No, the proposal is to use KVM_CAP_GUEST_MEMFD_FLAGS to enumerate the s=
et of
> > supported KVM_CREATE_GUEST_MEMFD flags.  Whether or not there is an ass=
ociated
> > "feature" is irrelevant.  I.e. it's a very literal "these are the suppo=
rted
> > flags".
> >
> > > * Use KVM caps for guest_memfd features that don't map to any flags.
> > >
> > > I think in general it would be better to have a KVM cap for each
> > > feature irrespective of the flags as the feature may also need
> >                                                    ^^^
> > > additional UAPIs like IOCTLs.
> >
> > If the _only_ user-visible asset that is added is a KVM_CREATE_GUEST_ME=
MFD flag,
> > a CAP is gross overkill.  Even if there are other assets that accompany=
 the new
> > flag, there's no reason we couldn't say "this feature exist if XYZ flag=
 is
> > supported".
> >
> > E.g. it's functionally no different than KVM_CAP_VM_TYPES reporting sup=
port for
> > KVM_X86_TDX_VM also effectively reporting support for a _huge_ number o=
f things
> > far beyond being able to create a VM of type KVM_X86_TDX_VM.
> >
>=20
> What's your opinion about having KVM_CAP_GUEST_MEMFD_MMAP part of
> KVM_CAP_GUEST_MEMFD_CAPS i.e. having a KVM cap covering all features
> of guest_memfd?

I'd much prefer to have both.  Describing flags for an ioctl via a bitmask =
that
doesn't *exactly* match the flags is asking for problems.  At best, it will=
 be
confusing.  E.g. we'll probably end up with code like this:

	gmem_caps =3D kvm_check_cap(KVM_CAP_GUEST_MEMFD_CAPS);

	if (gmem_caps & KVM_CAP_GUEST_MEMFD_MMAP)
		gmem_flags |=3D GUEST_MEMFD_FLAG_MMAP;
	if (gmem_caps & KVM_CAP_GUEST_MEMFD_INIT_SHARED)
		gmem_flags |=3D KVM_CAP_GUEST_MEMFD_INIT_SHARED;

Those types of patterns often lead to typos causing problems (LOL, case in =
point,
there's a typo above; I'm leaving it to illustrate my point).  That can be =
largely
solved by userspace via macro shenanigans, but userspace really shouldn't h=
ave to
jump through hoops for such a simple thing.

An ever worse outcome is if userspace does something like:

	gmem_flags =3D kvm_check_cap(KVM_CAP_GUEST_MEMFD_CAPS);

Which might actually work initially, e.g. if KVM_CAP_GUEST_MEMFD_MMAP and
GUEST_MEMFD_FLAG_MMAP have the same value.  But eventually userspace will b=
e sad.

Another issue is that, while unlikely, we could run out of KVM_CAP_GUEST_ME=
MFD_CAPS
bits before we run out of flags.

And if we use memory attributes, we're also guaranteed to have at least one=
 gmem
capability that returns a bitmask separately from a dedicated one-size-fits=
-all
cap, e.g.

	case KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES:
		if (vm_memory_attributes)
			return 0;

		return kvm_supported_mem_attributes(kvm);

Side topic, looking at this, I don't think we need KVM_CAP_GUEST_MEMFD_CAPS=
, I'm
pretty sure we can simply extend KVM_CAP_GUEST_MEMFD.  E.g.=20

#define KVM_GUEST_MEMFD_FEAT_BASIC		(1ULL << 0)
#define KVM_GUEST_MEMFD_FEAT_FANCY		(1ULL << 1)

	case KVM_CAP_GUEST_MEMFD:
		return KVM_GUEST_MEMFD_FEAT_BASIC |
		       KVM_GUEST_MEMFD_FEAT_FANCY;

> That seems more consistent to me in order for userspace to deduce the
> supported features and assume flags/ioctls/...  associated with the featu=
re
> as a group.

If we add a feature that comes with a flag, we could always add both, i.e. =
a
feature flag for KVM_CAP_GUEST_MEMFD along with the natural enumeration for
KVM_CAP_GUEST_MEMFD_FLAGS.  That certainly wouldn't be my first choice, but=
 it's
a possibility, e.g. if it really is the most intuitive solution.  But that'=
s
getting quite hypothetical.

