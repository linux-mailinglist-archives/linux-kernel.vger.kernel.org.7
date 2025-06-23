Return-Path: <linux-kernel+bounces-699130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B2EAE4E2E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 22:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63D5F17C279
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 20:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901FF2D542E;
	Mon, 23 Jun 2025 20:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rMeKTjxj"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711651F582B
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 20:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750711007; cv=none; b=M3ZQ2clAl8v4WRSjfSukcNjfRi6ongEWSB3EK3oxGrTV3wob3YFbhWS/UgEjJdWNKgJLkQtPSxGguWvfT5zNHMnvvRVvlljZSZiTc6CZyo8O0si9QXuDOf0baJZddKyiSv77EZ03a2dn4+1SyXEySIC765dIT0+dAdLU6ER+S5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750711007; c=relaxed/simple;
	bh=HvLY83A0qe5joWnPbr4N3y4EkbLCpe6dw2k3DnI081c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mz93kYySkb80nJYKEqz41g0iAS8N7EF6Pf5KYy5Mi8FTR3SME4AqaFRgqyqiQ0+nem2JXeBrMPSgBo0YMZhgJ3p5Yxu4oQPtEImhYRbigwDnaCdrPBIDQDZNTEdWrLntcGiDGZtJQ70/C4nQuT73tY8NwdCwkIxhjpmJk5JDack=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rMeKTjxj; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2357c61cda7so10565ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 13:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750711006; x=1751315806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbQ3OJyLytdAQvqvTvM3nBOhCRNYc/c7ff3q42dC1M8=;
        b=rMeKTjxjZtiQyAbCYuWDFPx+H6tatdMVxnLp7gtdVx2rrRO342OrdHlJ5PHmC/kCSd
         MsR45CZuAFvf7l2hQ3ixm3n5E9F3Hy3BnlnfIx8j6fWOs+rHgWJvyXaqIq/HV6M+XUdt
         GVqg53wS5qcoJqwHfwgDITHFZnIYEI9qgg4c1EqoNtLefFlTvfkCTRka+sqW5IiziklQ
         R/MIbK6sV/H3PGy9eimGBNylaCuN/Flh7bL21JFmaNul+n6BqdpGN/6l5BjGKURL1982
         Ky+KIi3CMJrXbaAGkOp3/peBc52feBYLNggffYUI9k9hUdPwaj10mI1GV9LCaIiP+2q8
         Kiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750711006; x=1751315806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UbQ3OJyLytdAQvqvTvM3nBOhCRNYc/c7ff3q42dC1M8=;
        b=DNuM4jowNf777zD6ku6S28S91rmzjv+eT6B2qMWVW0nFYOrB4puY+la7qECuIUfoRx
         IgGzpZqQu3NuHzqoMGgmRNPq59inSFQ3GKIwW2w6mzBv8hHG6ct2mhguL0fnbEQISqPq
         nd8leC7MUypxwQvarric+NgfW2SpTbhziGletFO6d6olfIjYHQsWlGzSfrGBnx5TYfcR
         7l10BO9h1c0RaSZLe18Yto/uSfxFFgnGZrAKfXQi3da2WDwgHHdT6BUz6SKhLvacacBT
         aQSbTomtGMS2MIiLbErSX4AH1VbdHzUIBKDYUQlR3S67hfy/EWdmWU+oUOrIrpa8JFmj
         xKzw==
X-Forwarded-Encrypted: i=1; AJvYcCXWZAKSEBAHrYNOMchWPwn1O+00yNpgnJ7OgBeYlwiRxJphU1OUyAi399ivV29CkepwFGBE8usNXzWNip4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOzXChh2ZKuZDklneAH8GXkzsH8BRLLpaZNq8+xiT2uoazh38j
	726LI4SuhwZkoQc3FJtwEMT54xozF7nkNDTQxeNWddHAzHiO9qq/hu6ibLmPZRPwgO9EueG9iCp
	x1DTpDclZ4FL+jBvsEmM8/Ca2r+nsYrOy4vFV+30K
X-Gm-Gg: ASbGncu9p3Gxhp9+R01WZzCsWrcpqNpizrQaJFHPaBVtHk5hUV7E+RQg1d4Tu/fU2Ub
	UZs12X+3XSIYm0mxJk4HB3yP0sBWaO5/cEnRFxM7rVrZXwMQPeZ9S4UsFNzr5XurWHZ+VZETwgx
	Sn4rek6Y+PLZg4BdmLCdbGkIniX029/P1TR8y6DpqJPVUweVfuCYZYeyHQ+eWfQf369Wo9J8YY
X-Google-Smtp-Source: AGHT+IEw/f0sozGMlA0bFf5Ae+FpgBqfFjEvBMC5i7acuqIBfYfgSwOKrUE5w5RQz7upwTZYtyssRpazzKVHriZo2zg=
X-Received: by 2002:a17:902:ea0c:b0:215:65f3:27ef with SMTP id
 d9443c01a7336-23802a59e4cmr758025ad.12.1750711005265; Mon, 23 Jun 2025
 13:36:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611095158.19398-1-adrian.hunter@intel.com>
 <20250611095158.19398-2-adrian.hunter@intel.com> <CAGtprH_cpbPLvW2rSc2o7BsYWYZKNR6QAEsA4X-X77=2A7s=yg@mail.gmail.com>
 <e86aa631-bedd-44b4-b95a-9e941d14b059@intel.com> <CAGtprH_PwNkZUUx5+SoZcCmXAqcgfFkzprfNRH8HY3wcOm+1eg@mail.gmail.com>
 <0df27aaf-51be-4003-b8a7-8e623075709e@intel.com> <aFNa7L74tjztduT-@google.com>
 <4b6918e4-adba-48b2-931c-4d428a2775fc@intel.com> <aFVvDh7tTTXhX13f@google.com>
 <CAGtprH-an308biSmM=c=W2FS2XeOWM9CxB3vWu9D=LD__baWUQ@mail.gmail.com>
In-Reply-To: <CAGtprH-an308biSmM=c=W2FS2XeOWM9CxB3vWu9D=LD__baWUQ@mail.gmail.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Mon, 23 Jun 2025 13:36:33 -0700
X-Gm-Features: AX0GCFsiFjiHgPiU9WIyS_dwzjn4ukQVIKAEqhgBTJmMGmJbqgX93HxUOnpzMsg
Message-ID: <CAGtprH_9uq-FHHQ=APwgVCe+=_o=yrfCS9snAJfhcg3fr7Qs-g@mail.gmail.com>
Subject: Re: [PATCH V4 1/1] KVM: TDX: Add sub-ioctl KVM_TDX_TERMINATE_VM
To: Sean Christopherson <seanjc@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, pbonzini@redhat.com, kvm@vger.kernel.org, 
	rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com, 
	kai.huang@intel.com, reinette.chatre@intel.com, xiaoyao.li@intel.com, 
	tony.lindgren@linux.intel.com, binbin.wu@linux.intel.com, 
	isaku.yamahata@intel.com, linux-kernel@vger.kernel.org, yan.y.zhao@intel.com, 
	chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 9:14=E2=80=AFAM Vishal Annapurve <vannapurve@google=
.com> wrote:
>
> On Fri, Jun 20, 2025 at 7:24=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Thu, Jun 19, 2025, Adrian Hunter wrote:
> > > On 19/06/2025 03:33, Sean Christopherson wrote:
> > > > On Wed, Jun 18, 2025, Adrian Hunter wrote:
> > > >> On 18/06/2025 09:00, Vishal Annapurve wrote:
> > > >>> On Tue, Jun 17, 2025 at 10:50=E2=80=AFPM Adrian Hunter <adrian.hu=
nter@intel.com> wrote:
> > > >>>>> Ability to clean up memslots from userspace without closing
> > > >>>>> VM/guest_memfd handles is useful to keep reusing the same guest=
_memfds
> > > >>>>> for the next boot iteration of the VM in case of reboot.
> > > >>>>
> > > >>>> TD lifecycle does not include reboot.  In other words, reboot is
> > > >>>> done by shutting down the TD and then starting again with a new =
TD.
> > > >>>>
> > > >>>> AFAIK it is not currently possible to shut down without closing
> > > >>>> guest_memfds since the guest_memfd holds a reference (users_coun=
t)
> > > >>>> to struct kvm, and destruction begins when users_count hits zero=
.
> > > >>>>
> > > >>>
> > > >>> gmem link support[1] allows associating existing guest_memfds wit=
h new
> > > >>> VM instances.
> > > >>>
> > > >>> Breakdown of the userspace VMM flow:
> > > >>> 1) Create a new VM instance before closing guest_memfd files.
> > > >>> 2) Link existing guest_memfd files with the new VM instance. -> T=
his
> > > >>> creates new set of files backed by the same inode but associated =
with
> > > >>> the new VM instance.
> > > >>
> > > >> So what about:
> > > >>
> > > >> 2.5) Call KVM_TDX_TERMINATE_VM IOCTL
> > > >>
> > > >> Memory reclaimed after KVM_TDX_TERMINATE_VM will be done efficient=
ly,
> > > >> so avoid causing it to be reclaimed earlier.
> > > >
> > > > The problem is that setting kvm->vm_dead will prevent (3) from succ=
eeding.  If
> > > > kvm->vm_dead is set, KVM will reject all vCPU, VM, and device (not =
/dev/kvm the
> > > > device, but rather devices bound to the VM) ioctls.
> > >
> > > (3) is "Close the older guest memfd handles -> results in older VM in=
stance cleanup."
> > >
> > > close() is not an IOCTL, so I do not understand.
> >
> > Sorry, I misread that as "Close the older guest memfd handles by deleti=
ng the
> > memslots".
> >
> > > > I intended that behavior, e.g. to guard against userspace blowing u=
p KVM because
> > > > the hkid was released, I just didn't consider the memslots angle.
> > >
> > > The patch was tested with QEMU which AFAICT does not touch  memslots =
when
> > > shutting down.  Is there a reason to?
> >
> > In this case, the VMM process is not shutting down.  To emulate a reboo=
t, the
> > VMM destroys the VM, but reuses the guest_memfd files for the "new" VM.=
  Because
> > guest_memfd takes a reference to "struct kvm", through memslot bindings=
, memslots
>
> guest_memfd takes a reference on the "struct kvm" only on
> creation/linking, currently memslot binding doesn't add additional
> references.
>
> Adrian's suggestion makes sense and it should be functional but I am
> running into some issues which likely need to be resolved on the
> userspace side. I will keep this thread updated.
>
> Currently testing this reboot flow:
> 1) Issue KVM_TDX_TERMINATE_VM on the old VM.
> 2) Close the VM fd.
> 3) Create a new VM fd.
> 4) Link the old guest_memfd handles to the new VM fd.
> 5) Close the old guest_memfd handles.
> 6) Register memslots on the new VM using the linked guest_memfd handles.
>

Apparently mmap takes a refcount on backing files.

So basically I had to modify the reboot flow as:
1) Issue KVM_TDX_TERMINATE_VM on the old VM.
2) Close the VM fd.
3) Create a new VM fd.
4) Link the old guest_memfd handles to the new VM fd.
5) Unmap the VMAs backed by the guest memfd
6) Close the old guest_memfd handles. -> Results in VM destruction
7) Setup new VMAs backed by linked guest_memfd handles.
8) Register memslots on the new VM using the linked guest_memfd handles.

I think the issue simply is that we have tied guest_memfd lifecycle
with VM lifecycle and that discussion is out of scope for this patch.

