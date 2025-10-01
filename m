Return-Path: <linux-kernel+bounces-839313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D711BB1564
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 19:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14194A3FBF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 17:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FA32D29C4;
	Wed,  1 Oct 2025 17:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TKRrd63P"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3116B34BA40
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 17:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759338981; cv=none; b=aLwr8f2YmoqZxwD7LBufdlj7A3SJDL0ELPtr1RY+TP1m+2nqy5hLyMUPNrH1g2OLfAoCGzihyAVsvaFaBpOfZfq0ETlZF013HcuNI1T1ZUdTB9w7fCkQrcWKLB9KFGLwcpTJ7ctpNdYhBQqoOZaaFp7UAdkO5DftjPb62C+jeKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759338981; c=relaxed/simple;
	bh=BU0iCG0Wn7FDxsjZpRitcTVVnTYoIX9uyhwNv3w1DQI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iLtsSHM3LUgI7XDkcA1ZWCm7LJIxzYa58Jn/vySa+B3A4fbCFGaKboVxgROKnmcApQ7L8ss0yt3R9+55IrFC3kxoLsLodV6ni+YD3PNyl0V6bTcWzVIaxoRce/OV6GgWUEcUAG+nbNXS9XVijDXxRmJNqwZFWvk8TpRL5sJI8RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TKRrd63P; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-27eca7298d9so604965ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 10:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759338979; x=1759943779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ICohWyZWW3dghRAJfnyRv8OgV+aajXymuvEfhCyvZ0=;
        b=TKRrd63PFYhpOJ97KcMHgfOeL8xPTOXkkckAxOnYaXdheXUfcyRbr7LcW4HurFp6/1
         fHjQjmZ43n6XFgjgSTXlQzT9CM8I/EAPb1V6TehN4VJxgSK9pXXvx2r52kNXcaejXccy
         sO/kngakKHqxJqS497wNIW4+F5AmlefQux3nlgZZ/NArbD0HsVRQ8kU/IN7wMVURbinP
         7ZwsBJZZFz8ZK3PB1JBhknh8XjWVDJeCZMblGoaNBFyRuSHmMKuDwEuCxOfhGPdHTS5M
         x9XzkkVfmAQuBjTvRTAzP7gkVKBNNK7i9eCjnbFN35sIhmK6+cVCFfu+N6YCA3fSVXS8
         LigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759338979; x=1759943779;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4ICohWyZWW3dghRAJfnyRv8OgV+aajXymuvEfhCyvZ0=;
        b=vwROns2sujZQKz1SsU2up3ls3fjmqrAtS0uOfKM4Py3k7vkSbWZ6mPMUCMwGNnoXdw
         aL+Vj7r4T/Q8ELxyMJqJk2rgx8I/0EQvvmR4Pkl+WlMGJw2M8+2/wOqERVWx1aN7UU+L
         XWWVb3yEY/+SjoeQPRwqufzlXY64xnGKrb1rm18Og8utUW5zsyiDEpNGDZR35MwDhz1V
         eJVe4WhOE7WBeOp/sLZr+PGzyH7MvVoacDT/0LyaAu8O8rveyy4i5566QH4AscaKc+IV
         uG69uf9jdnApjDHDTlXcCySV+C40XkY+pHQ9ujnjAQ1fT9cdZ4nxMI9ijubd0wE5xxLp
         zdaw==
X-Forwarded-Encrypted: i=1; AJvYcCXSeLXfA/mY3lfwkRTG/PxqTYK+PT2mGCQM/8n7fDUNo7lg2N5FYf0eZvbn66XWxa1TH+QvyjpoTEQJaBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4kGEBOI4+oSzgKYo2G5tbuVmfCavLlfMfeEMAeByVRLSg5Ptt
	6EUtP2cT7KKFYDhE4/LdRgTYWXbibKjUblbFaK9xx7KPdbqzLiWj2U1BMM2t2h/DGDfke0+LIJm
	PT6bspg==
X-Google-Smtp-Source: AGHT+IF8XxTPJPnhJV6cEfh65/DuXZ5l5db3pgS80gNyNI0nsre7FBM2PokXsB4xATcgCCV21X0DcrZFodU=
X-Received: from pldm6.prod.google.com ([2002:a17:902:db86:b0:267:e559:12b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:15ce:b0:265:47:a7bd
 with SMTP id d9443c01a7336-28e7f28dfbemr49380785ad.4.1759338979403; Wed, 01
 Oct 2025 10:16:19 -0700 (PDT)
Date: Wed, 1 Oct 2025 10:16:17 -0700
In-Reply-To: <CAGtprH-0B+cDARbK-xPGfx4sva+F1akbkX1gXts2VHaqyDWdzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CA+EHjTzdX8+MbsYOHAJn6Gkayfei-jE6Q_5HfZhnfwnMijmucw@mail.gmail.com>
 <diqz7bxh386h.fsf@google.com> <a4976f04-959d-48ae-9815-d192365bdcc6@linux.dev>
 <d2fa49af-112b-4de9-8c03-5f38618b1e57@redhat.com> <diqz4isl351g.fsf@google.com>
 <aNq6Hz8U0BtjlgQn@google.com> <aNshILzpjAS-bUL5@google.com>
 <CAGtprH_JgWfr2wPGpJg_mY5Sxf6E0dp5r-_4aVLi96To2pugXA@mail.gmail.com>
 <aN1TgRpde5hq_FPn@google.com> <CAGtprH-0B+cDARbK-xPGfx4sva+F1akbkX1gXts2VHaqyDWdzA@mail.gmail.com>
Message-ID: <aN1h4XTfRsJ8dhVJ@google.com>
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

On Wed, Oct 01, 2025, Vishal Annapurve wrote:
> On Wed, Oct 1, 2025 at 9:15=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
> >
> > On Wed, Oct 01, 2025, Vishal Annapurve wrote:
> > > On Mon, Sep 29, 2025 at 5:15=E2=80=AFPM Sean Christopherson <seanjc@g=
oogle.com> wrote:
> > > >
> > > > Oh!  This got me looking at kvm_arch_supports_gmem_mmap() and thus
> > > > KVM_CAP_GUEST_MEMFD_MMAP.  Two things:
> > > >
> > > >  1. We should change KVM_CAP_GUEST_MEMFD_MMAP into KVM_CAP_GUEST_ME=
MFD_FLAGS so
> > > >     that we don't need to add a capability every time a new flag co=
mes along,
> > > >     and so that userspace can gather all flags in a single ioctl.  =
If gmem ever
> > > >     supports more than 32 flags, we'll need KVM_CAP_GUEST_MEMFD_FLA=
GS2, but
> > > >     that's a non-issue relatively speaking.
> > > >
> > >
> > > Guest_memfd capabilities don't necessarily translate into flags, so i=
deally:
> > > 1) There should be two caps, KVM_CAP_GUEST_MEMFD_FLAGS and
> > > KVM_CAP_GUEST_MEMFD_CAPS.
> >
> > I'm not saying we can't have another GUEST_MEMFD capability or three, a=
ll I'm
> > saying is that for enumerating what flags can be passed to KVM_CREATE_G=
UEST_MEMFD,
> > KVM_CAP_GUEST_MEMFD_FLAGS is a better fit than a one-off KVM_CAP_GUEST_=
MEMFD_MMAP.
>=20
> Ah, ok. Then do you envision the guest_memfd caps to still be separate
> KVM caps per guest_memfd feature?

Yes?  No?  It depends on the feature and the actual implementation.  E.g.
KVM_CAP_IRQCHIP enumerates support for a whole pile of ioctls.

