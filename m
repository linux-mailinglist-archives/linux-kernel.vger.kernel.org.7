Return-Path: <linux-kernel+bounces-787319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E40B3747B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 23:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3303E3B5E77
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 21:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE36299923;
	Tue, 26 Aug 2025 21:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kYNzSa1y"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B5927A11E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 21:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756244319; cv=none; b=GiWuYtP3IbK3jwhGw69LRssyfzoMSfm5OhQiqPBH9ycwU1ZrB0t+dT2n3JpAvr0XLNRiaTuP8lRroDeqN4IdrT0A749dJk59zvuNGdsdeMlXAT9gCIPq8qS/nB1Han1Cm+lUHlFic5nIoUN1u+KZKUrrX+gkixeNe2FvNSU69WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756244319; c=relaxed/simple;
	bh=tjjntmHYd9yX/bQsKUBCFfyjm57RPvKrOHRwfskNRjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ha0EFKjIr/to8l0Cs8HRty2XXj9x/1kRQBKola582AaiYSprRyq+0uwaJH8hWQELhaqySjzwHHhQpbzE253ObQC5TQjo+uLWT5Hyqk/IrQeQNN9jsvaPI/zv17mDDA/7Yb8bt8oTvIrsIhMHs+TtkkmcbKsMVtbx2QDgYDpcbdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kYNzSa1y; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b2dc20aebbso150751cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756244317; x=1756849117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89nUNyghQOdbDMTzejcrMWxMjVoZp0QLNZEDRB294gQ=;
        b=kYNzSa1yl5SEOrAw2kMSyJYcMsEqJqtN2FQ+75SCQp0+JkP7QwFI0Ib7rTsIfXT3Ko
         3xJvrJ+d0idnSejODRLcyKroSSKeMIN4wWLsh4j+k+Sp8xpiEyEEyiCLW85VHsMVcNrD
         1v9egOQ/jjN4Ui9Tbz1POJluvCjQYQbcoD5iJJq7kcg2k1oxLNQw/9GArUCge6kEZyLC
         qH3KbliDM+klvSahqKbeqz4THu6rDJg58tJfJRrL++1uZnlKecZWsGkvZnsVEYZ2uNSd
         t71TZ8c1F2yTLqrnuWpdruBjmUbyw4q4Tv6j4LI+BJw3Mes4OF4s5p6hGzgPsFEBBpER
         TvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756244317; x=1756849117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=89nUNyghQOdbDMTzejcrMWxMjVoZp0QLNZEDRB294gQ=;
        b=SF9IFwAM2HulAZeGybfdst8k16LYNIDbOVwqMWfa/cFSnAIpDX0fJPYrUdXr03OV4j
         Dg7xtl3Ljy9FeiQYqG9TNdGR8Qwx75HUV9mA/ThFDSvldFuhqOF4BEPUjB3PWLcFdVlk
         M0+deQdOtbFECY6U0Ju3OB6BYJQwSooOYLraTTHLg1rwTwBayW7RTUa1SbmxvL5WNImH
         WCeyXMy6Q5itvqP61pbTVgA8VRdMzHHkRXQ1525mDfp56rI/AqsBpiGs/aE1tjogQDAA
         ztud1r0x+i8gcJEefeMDhfh8GF+8glrV8Y+ZO/bOzJT2/YhVG6w+cpNo/cypJHlLADT5
         ki7A==
X-Forwarded-Encrypted: i=1; AJvYcCUlLM5o4CCPs0qOOlRrQzmPeCsC3Jj9NgWT1kS4cntVcV2eT8uueOiZUzdEHVtluKItATh3IYGU7+PdoK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YymbSSEUxIDNZqixBw4ovKm5u4dUCMGSYgiPykFaVN/LuvdjHho
	l5zomHcrPseOOndJ30D6rVTlUmMTKfxKBtgGJBSNdk0eDkhXRW5HKLdbbMClgQN4ez1pub11aXZ
	wOFyVz2UsM3a8NeVfgHZqr7SrzjLTrzOuBiqqT0f7
X-Gm-Gg: ASbGnctllEEmrh9YmUsjdB+ymzFOLHhsRRpkztC8RZGp89q4DXTjFpyv3T7dz9KuSOI
	KA63IRWzNsE7YSIiqerebAy/qH2X6/MPxrozPyzPtYT7Mbrv0K97zpIUb4NgGwaZz83lKR4bi4X
	sEAQd87gTWZ7DWFFn6wZH+Zvni4hh7jtToW/enS5cOkdPdTwryiUFd8X+sQiqC/iIFe1ei0fIiI
	pcbv49hDnKdTQVO3y505UGmERoGBwHoLJnFgRsZNaucbOjTft/ZiUhKVw==
X-Google-Smtp-Source: AGHT+IHxeU94g08Uyt0q7MmK7MW0edM6nUge+D9EPJ9mUhKKigCb+AZKXdltlf0UfavBccb1nXT9sGeBu0yaftb6UHI=
X-Received: by 2002:ac8:7d41:0:b0:4b2:d4cb:be58 with SMTP id
 d75a77b69052e-4b2e2c1b598mr6770261cf.9.1756244316909; Tue, 26 Aug 2025
 14:38:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com> <20250821042915.3712925-16-sagis@google.com>
 <aK3vZ5HuKKeFuuM4@google.com> <68ae1604a387c_300e8f2947e@iweiny-mobl.notmuch>
 <CAAhR5DHPMPOb2XCJodyNMf2RTQfTZpAaCGMg6WeWxSWPLtkO4Q@mail.gmail.com>
 <CAAhR5DGeTQ4G-w2o5YCvNWkZZWFcXe=6rro+RcfhR18-4sT+PQ@mail.gmail.com> <aK4nwZ4FE1r8-GYd@google.com>
In-Reply-To: <aK4nwZ4FE1r8-GYd@google.com>
From: Sagi Shahar <sagis@google.com>
Date: Tue, 26 Aug 2025 16:38:25 -0500
X-Gm-Features: Ac12FXx43YYHIALem9VlFRybUWvBdHC-shjMO3WBIHuazSzxmrkHbtA3djEtUZc
Message-ID: <CAAhR5DHLhoY=wz3QQLqjtqhSNewSfFqGk5wonA5TiJwnPmPLsw@mail.gmail.com>
Subject: Re: [PATCH v9 15/19] KVM: selftests: Hook TDX support to vm and vcpu creation
To: Sean Christopherson <seanjc@google.com>
Cc: Ira Weiny <ira.weiny@intel.com>, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 4:31=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Aug 26, 2025, Sagi Shahar wrote:
> > On Tue, Aug 26, 2025 at 3:29=E2=80=AFPM Sagi Shahar <sagis@google.com> =
wrote:
> > >
> > > On Tue, Aug 26, 2025 at 3:14=E2=80=AFPM Ira Weiny <ira.weiny@intel.co=
m> wrote:
> > > >
> > > > Sean Christopherson wrote:
> > > > > Ugh.  IMO, this is a KVM bug.  Allowing KVM_CREATE_IRQCHIP for a =
TDX VM is simply
> > > > > wrong.  It _can't_ work.  Waiting until KVM_CREATE_VCPU to fail s=
etup is terrible
> > > > > ABI.
> > > > >
> > > > > If we stretch the meaning of ENOTTY a bit and return that when tr=
ying to create
> > > > > a fully in-kernel IRQCHIP for a TDX VM, then the selftests code J=
ust Works thanks
> > > > > to the code below, which handles the scenario where KVM was be bu=
ilt without
> > > >          ^^^^^^^^^^
> > > >
> > > > I'm not following.  Was there supposed to be a patch attached?
> > > >
> > >
> > > I think Sean refers to the original implementation which was out of
> > > the scope for the git diff so it was left out of the patch:
>
> Yep, exactly.
>

I took a stab at updating the KVM ABI and sent out a small patch [1]
to fail KVM_CREATE_IRQCHIP with ENOTTY and the test passes without the
special handling for SPLIT_IRQCHIP for TDX.

[1] https://lore.kernel.org/lkml/20250826213455.2338722-1-sagis@google.com/

> > /*
> >  * Allocate a fully in-kernel IRQ chip by default, but fall back to a
> >  * split model (x86 only) if that fails (KVM x86 allows compiling out
> >  * support for KVM_CREATE_IRQCHIP).
> >  */
> > r =3D __vm_ioctl(vm, KVM_CREATE_IRQCHIP, NULL);
> > if (r && errno =3D=3D ENOTTY && kvm_has_cap(KVM_CAP_SPLIT_IRQCHIP))
> >         vm_enable_cap(vm, KVM_CAP_SPLIT_IRQCHIP, 24);
> > else
> >         TEST_ASSERT_VM_VCPU_IOCTL(!r, KVM_CREATE_IRQCHIP, r, vm);

