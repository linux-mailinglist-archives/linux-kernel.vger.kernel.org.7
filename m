Return-Path: <linux-kernel+bounces-839581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A60BB1F4F
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 00:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE11C7A32C0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 22:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D34E2D9EC9;
	Wed,  1 Oct 2025 22:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZRhXDU1k"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0652A1E7C2E
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 22:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759356837; cv=none; b=GKS81cmLEjJR23ogR0k1TG3Bklw8EnBUTjU2+CCEcfjlvvx1vfiV2tJfI8dJsF3I24CvOopLt40x1Cs/iA1cvx5aEvU0GZSb8L9ZLd3fLsOmqYsmK+MQVBtaA9f0pUkLHH/rHeZHb1Q0KizrHawY7DmssX2Lw5IQPE7D4InAA2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759356837; c=relaxed/simple;
	bh=H0OAOdmyR1ZoRO95yFgAROXm6VgYaxEMWEP38o3+ZTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKbz7q0JMZL2fTUBiCZCENonVzIeACQyqwpXYsYQAjkv31j3x+YyS1M4GTTYFivyvpdx2SFGGAcSoGFE+6yankE4U7n5ptr6K4tEOvXF6X4o/uGoGSNiO8WJTnRRnU1dSZd/MqE0Gv3/BMULn+pVIRHnuGrglRneyAURDgBDq1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZRhXDU1k; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2731ff54949so36675ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 15:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759356835; x=1759961635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mv+VHJbI5XgvwzaFFCg9rehwr5b6AGY449O1Y14oPG4=;
        b=ZRhXDU1kYeKFPamB6ABCHeH0pYqOENS3eiDagypaE+OXvcjnxBp8o1ehSxR8sYZNTe
         crjk7zdAL9CUf9S4lXJua+2p32AHC3CTEgmvFYQurfDNl1QfWcPEnCGrzKul6Sday7Kp
         vG1OBBvvN7uA3DHtrskSzH9sLa9KkqI3ySZui6oASB3h0LU1j7bYyABXh0KPlzmWy3Tp
         5Nzqnh4roPt3YU2VNj9pBy0z+hE01A55pGlATSEvnyfrDcv7YBhAZtBCqDobKxLpkOQO
         f7X5yVp4hNYie/jG4i487qUg0vpGfXoacJ/HHlObFWtKryqC1cwqwB8fH1WhR3Oh8FAP
         CoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759356835; x=1759961635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mv+VHJbI5XgvwzaFFCg9rehwr5b6AGY449O1Y14oPG4=;
        b=vMF8y9dF72Q6C1LvMLlWWNLEhZEhrWwnE/ZNFjOt7BU8eMb3zotxfJyk/VYXbKBhtv
         3ququ0N2Rz1CL6UaVUlXH6c1DTsewuCi/e7LhLg+FhNnMXKd8a+Vjj8T9fWfcaAINTaP
         EOmnMNSO5lMbjiae0CgUqRejImstgh3Ph92mcNcbfJ6C/mifsW6QUsrv5MSoDGiQGPGZ
         mF9EWON/vQDKpa60nrgSN7KwHxgM1tZ22yA8HO29cIe/7rkI8K8CQWbL9IKlvt3AbRMn
         vQ5v4RF9ZWO1jA30aJJNd2wNed+5qjYTaolTofbB2NIjG64XrLPBPCgIhB7d/RYPjZCS
         fl4A==
X-Forwarded-Encrypted: i=1; AJvYcCXVRq32gQZnYOZMJyBqtX1v6gplBoQubUGZevluLum6p5UyLAOuVtrPkcEVk3YvxHJrOLuQCr0m37OHjiw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy70HgqwCPwsSkbvuBzfIxCqGbgzCGV29UUm1nlXBkiP6IVLfd3
	ORRCPPZq2PEn4tFQ1PHT5Zd9upSH8PLPXI2W4X275Yj5/Ic+96cYZ+hn79xb3GaIm8WKTOCQ3xi
	aKYxF/XVcA7+nhb86x5ww2d67DKAQnxyPY6O7IuOe
X-Gm-Gg: ASbGncsldGhgYdf+5dSky4M8szYOkUoAor6hpZctRetUWg0raUCZ8lowVMlAY9VcN8x
	zeAzpnirvHFWW0PiJeGtfNaCuoSx8ef19MToxUBXBnW9S3B2ncG1cdPqVY4KB6tYdbshVABtXFU
	50ZTmkhwzkNzfZ4oxzKQCcUFDkNe55FZmLis6N89aRoiYQyLrsgR43/WR98/Tv5In16JqzM3AZk
	rCCa1tdzCkgINd6Xoy95eswok+UHSWBqwuulti9GZj58mKz2N4eGOLLQx+iPGwSENE4/556/Re0
	eX0=
X-Google-Smtp-Source: AGHT+IG9E1JtTvidP583R53j5bBTJPbJF1srG8AqCiJj0EtVLzMHTEtGEhQTJ8NId4KrB33ezdvuuQDjkAxtUmnw9jA=
X-Received: by 2002:a17:903:904:b0:269:63ea:6d3f with SMTP id
 d9443c01a7336-28e8dbd1da2mr2095205ad.8.1759356834777; Wed, 01 Oct 2025
 15:13:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+EHjTzdX8+MbsYOHAJn6Gkayfei-jE6Q_5HfZhnfwnMijmucw@mail.gmail.com>
 <diqz7bxh386h.fsf@google.com> <a4976f04-959d-48ae-9815-d192365bdcc6@linux.dev>
 <d2fa49af-112b-4de9-8c03-5f38618b1e57@redhat.com> <diqz4isl351g.fsf@google.com>
 <aNq6Hz8U0BtjlgQn@google.com> <aNshILzpjAS-bUL5@google.com>
 <CAGtprH_JgWfr2wPGpJg_mY5Sxf6E0dp5r-_4aVLi96To2pugXA@mail.gmail.com>
 <aN1TgRpde5hq_FPn@google.com> <CAGtprH-0B+cDARbK-xPGfx4sva+F1akbkX1gXts2VHaqyDWdzA@mail.gmail.com>
 <aN1h4XTfRsJ8dhVJ@google.com>
In-Reply-To: <aN1h4XTfRsJ8dhVJ@google.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Wed, 1 Oct 2025 15:13:42 -0700
X-Gm-Features: AS18NWAgSpisLEAI2LvYegyGzVLyI5bmHv7KNkJ2hmFok9NUYzPEeQdcIwsVpNQ
Message-ID: <CAGtprH-5NWVVyEM63ou4XjG4JmF2VYNakoFkwFwNR1AnJmiDpA@mail.gmail.com>
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

On Wed, Oct 1, 2025 at 10:16=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, Oct 01, 2025, Vishal Annapurve wrote:
> > On Wed, Oct 1, 2025 at 9:15=E2=80=AFAM Sean Christopherson <seanjc@goog=
le.com> wrote:
> > >
> > > On Wed, Oct 01, 2025, Vishal Annapurve wrote:
> > > > On Mon, Sep 29, 2025 at 5:15=E2=80=AFPM Sean Christopherson <seanjc=
@google.com> wrote:
> > > > >
> > > > > Oh!  This got me looking at kvm_arch_supports_gmem_mmap() and thu=
s
> > > > > KVM_CAP_GUEST_MEMFD_MMAP.  Two things:
> > > > >
> > > > >  1. We should change KVM_CAP_GUEST_MEMFD_MMAP into KVM_CAP_GUEST_=
MEMFD_FLAGS so
> > > > >     that we don't need to add a capability every time a new flag =
comes along,
> > > > >     and so that userspace can gather all flags in a single ioctl.=
  If gmem ever
> > > > >     supports more than 32 flags, we'll need KVM_CAP_GUEST_MEMFD_F=
LAGS2, but
> > > > >     that's a non-issue relatively speaking.
> > > > >
> > > >
> > > > Guest_memfd capabilities don't necessarily translate into flags, so=
 ideally:
> > > > 1) There should be two caps, KVM_CAP_GUEST_MEMFD_FLAGS and
> > > > KVM_CAP_GUEST_MEMFD_CAPS.
> > >
> > > I'm not saying we can't have another GUEST_MEMFD capability or three,=
 all I'm
> > > saying is that for enumerating what flags can be passed to KVM_CREATE=
_GUEST_MEMFD,
> > > KVM_CAP_GUEST_MEMFD_FLAGS is a better fit than a one-off KVM_CAP_GUES=
T_MEMFD_MMAP.
> >
> > Ah, ok. Then do you envision the guest_memfd caps to still be separate
> > KVM caps per guest_memfd feature?
>
> Yes?  No?  It depends on the feature and the actual implementation.  E.g.
> KVM_CAP_IRQCHIP enumerates support for a whole pile of ioctls.

I think I am confused. Is the proposal here as follows?
* Use KVM_CAP_GUEST_MEMFD_FLAGS for features that map to guest_memfd
creation flags.
* Use KVM caps for guest_memfd features that don't map to any flags.

I think in general it would be better to have a KVM cap for each
feature irrespective of the flags as the feature may also need
additional UAPIs like IOCTLs.

I fail to see the benefits of KVM_CAP_GUEST_MEMFD_FLAGS over
KVM_CAP_GUEST_MEMFD_MMAP:
1) It limits the possible values to 32 even though we could pass 64 flags t=
o
the original ioctl.
2) Userspace has to anyways assume the semantics of each bit position.
3) Userspace still has to check for caps for features that carry extra
UAPI baggage.

KVM_CAP_GUEST_MEMFD_MMAP allows userspace to assume that mmap is
supported and userspace can just pass in the mmap flag that it anyways
has to assume.

