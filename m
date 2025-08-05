Return-Path: <linux-kernel+bounces-756602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BEEB1B68D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0AE57A47F2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC79727875C;
	Tue,  5 Aug 2025 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E1sDohLH"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DDE13DDAE
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 14:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754404234; cv=none; b=UAOFRs1AR1p/uYla/zdr3Y5AWlBZzbGcTTxFED3AmS3U0IxyM88/PsanuPd0jDsbnMX62floz7HIg0hdi57ZVyEhw22i3ImtUZFmYqGa0GNJ9es2CRxd2QGGWvZ/6i54QIuDR+XwwnxhcMssniu7fJRIcNjtOIhCenclXKXutBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754404234; c=relaxed/simple;
	bh=jvhhtj6TrjlXl4ZoQhwuK/Q/vdS0xxAfIVA7yf0P24w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F6hRyzgToNn/BrBs0c8ChUwdcKUzqTHe6vuPlR0TV6GCTCK+lQxPusBiFRmNTk6k++x3yrmM5gfzDbltShyeGdoFjIehenMmNf9j9vfk4XwBanm1jBHK1e6kCO9Yt4LuNmRI3JiFZ8Uj+1X2NH3Tl9t0OjgZsHqJJilNRvlzbj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E1sDohLH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-240708ba498so166235ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 07:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754404232; x=1755009032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1i2rBdhFSYihK8Kc3DJvKw5YMobx28fVn5y7WwYE/yE=;
        b=E1sDohLH4bOmRPP+fXG9N9vka6nAkB5I1ZQOWPXT3qhqQDT+F5HVmjR6S0QqPSZT+F
         m0yQAKLTVZvTbNGeqRjeBZCIHpgzdEMBTVnAzWAWXKnrjvo0sVz0+qvFhgwIQDqNcK7X
         IeqKwYIP9BB1wYqzn6OKRVwdgfv1Wi7oQACLP36Cd6muHzVTCl1kUX2QzT/EuJzfb+ab
         TE7XgW5eoYr7SAoRqWPo1tyu7jhhtYWvDMlQ03zekSD9r4yb3aQMgD6IQd1SccFsDvCb
         ChKc3Jg6Mo0cBWrBR3tu84K6T+mFRK2ehJpj0972962thr9tCMWhUy7BmS2uC0CmFv4D
         OyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754404232; x=1755009032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1i2rBdhFSYihK8Kc3DJvKw5YMobx28fVn5y7WwYE/yE=;
        b=ScTfDC4bcKV9mFQ90B7HSEFfSAgAUm0Kx4vohgMqcZQpF+YR9y84hZz0hfwa3JB8+t
         gBJIHqgDUy88i0VD57eeL+P2s1RARttqYecanmasA52ZtJT+NIwYw0fElPijAL/oWBKw
         UfQ7suqn4740ftXeiTG4LQDdtQg6ipQLFiHMvg/QZgePdDrd+Sjw5JHNxw48x/UPDIDQ
         XvWerU+dLWxsBAt//KIPtzviYk9cXEvN2c0BXISX+CPiNBaPmcT5Ypkgxk0MiYewfUce
         6rjUzxfYkrGQd7fDIMS+umeExAzeS5FEkS1B3nbg47Iyvo1bedHUhT26AFj8vdZQcEwD
         hdMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDyXj3ZqZQAL9PQ4MMvGQt+7yZkp3c7+dGv6SIAfqeeNuXNfsd1Y8S2nDcRmpnpTwEMx2PC/H7952CKPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjQNfBP9w6tWRvBL+XTYA1TmXvJN9kJ4rL32SZHpfeBtpKw2Ft
	KAhneFWP5LD4CIkYHIzBwVTa1iTKN4mwjMUV59YJp/N4SJuaC7oSppG8Zrr/tzmIzY/xzzXAxyB
	hdI1ezzFULl3JtIeTjdFIqBN0AYUhNhSnAn6YQl4G
X-Gm-Gg: ASbGnct+ftpdqcUHyhTGxuPHHwNPXGVtS+e/HWwEvTxX00z3VgOKz1vW4YOrjf+Tts7
	LXQ9wM8jzCR9UW4MmiLYqiXiM92kxygacIZ3/4QDbR1GKUmRNxWoCMJ8eE1QnsRsShAwGK7hVCR
	ZIguxmzQOIrblET3AZSfRJnxyahJvblUc7xL6JUSSRHpjIwwRt7nblCNU4YH8kaTtc/I59ILN9m
	uTrjPlYRbpYKiDA8pWG4pkv4Q3n6gd+RFFXUKQokaO7nngVzD4=
X-Google-Smtp-Source: AGHT+IFGBIJJxNfbTEzjP5sTG/ngpGPS905pLSPahMPjbF4yfSdDjgsjpkpPj5UzxYl4JVDbWkCmjVcCGzFqhrKq6lc=
X-Received: by 2002:a17:902:f552:b0:240:4d65:509d with SMTP id
 d9443c01a7336-2428e724724mr2701805ad.0.1754404230273; Tue, 05 Aug 2025
 07:30:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aHEwT4X0RcfZzHlt@google.com> <aHSgdEJpY/JF+a1f@yzhao56-desk>
 <aHUmcxuh0a6WfiVr@google.com> <aHWqkodwIDZZOtX8@yzhao56-desk>
 <aHoQa4dBSi877f1a@yzhao56-desk.sh.intel.com> <CAGtprH9kwV1RCu9j6LqToa5M97_aidGN2Lc2XveQdeR799SK6A@mail.gmail.com>
 <aIdHdCzhrXtwVqAO@yzhao56-desk.sh.intel.com> <CAGtprH-xGHGfieOCV2xJen+GG66rVrpFw_s9jdWABuLQ2hos5A@mail.gmail.com>
 <aIgl7pl5ZiEJKpwk@yzhao56-desk.sh.intel.com> <6888f7e4129b9_ec573294fa@iweiny-mobl.notmuch>
 <aJFOt64k2EFjaufd@google.com> <CAGtprH9ELoYmwA+brSx-kWH5qSK==u8huW=4otEZ5evu_GTvtQ@mail.gmail.com>
In-Reply-To: <CAGtprH9ELoYmwA+brSx-kWH5qSK==u8huW=4otEZ5evu_GTvtQ@mail.gmail.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 5 Aug 2025 07:30:17 -0700
X-Gm-Features: Ac12FXzo1obXx2T2eEnEuW66PcYTBiOTK0DSZ9yVoJ5Lzp8BWhPiYrcn6BBY6yg
Message-ID: <CAGtprH-VcO4VJkgRZJPS8SEpdO6Xsjmw3CeGYCFchjkdROoMLg@mail.gmail.com>
Subject: Re: [RFC PATCH] KVM: TDX: Decouple TDX init mem region from kvm_gmem_populate()
To: Sean Christopherson <seanjc@google.com>
Cc: Ira Weiny <ira.weiny@intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rick.p.edgecombe@intel.com, kai.huang@intel.com, 
	adrian.hunter@intel.com, reinette.chatre@intel.com, xiaoyao.li@intel.com, 
	tony.lindgren@intel.com, binbin.wu@linux.intel.com, dmatlack@google.com, 
	isaku.yamahata@intel.com, david@redhat.com, ackerleytng@google.com, 
	tabba@google.com, chao.p.peng@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 6:20=E2=80=AFPM Vishal Annapurve <vannapurve@google.=
com> wrote:
>
> On Mon, Aug 4, 2025 at 5:22=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> > > > > > IIUC, the suggestion in the link is to abandon kvm_gmem_populat=
e().
> > > > > > For TDX, it means adopting the approach in this RFC patch, righ=
t?
> > > > > Yes, IMO this RFC is following the right approach as posted.
> >
> > I don't think we want to abandon kvm_gmem_populate().  Unless I'm missi=
ng something,
> > SNP has the same AB-BA problem as TDX.  The copy_from_user() on @src ca=
n trigger
> > a page fault, and resolving the page fault may require taking mm->mmap_=
lock.
> >
> > Fundamentally, TDX and SNP are doing the same thing: copying from sourc=
e to guest
> > memory.  The only differences are in the mechanics of the copy+encrypt,=
 everything
> > else is the same.  I.e. I don't expect that we'll find a magic solution=
 that works
> > well for one and not the other.
> >
> > I also don't want to end up with wildly different ABI for SNP vs. every=
thing else.
> > E.g. cond_resched() needs to be called if the to-be-initialzied range i=
s large,
> > which means dropping mmu_lock between pages, whereas kvm_gmem_populate(=
) can
> > yield without dropping invalidate_lock, which means that the behavior o=
f populating
> > guest_memfd memory will be quite different with respect to guest_memfd =
operations.
>
> I would think that TDX/CCA VMs [1] will run into the similar behavior
> of needing to simulate stage2 faults i.e. KVM will end up picking up
> and dropping mmu_lock for each page anyways at least for these two
> platforms.
>
> [1] https://lore.kernel.org/kvm/20250611104844.245235-5-steven.price@arm.=
com/
> (rmi_rtt_create())
>
> >
> > Pulling in the RFC text:
> >
> > : I think the only different scenario is SNP, where the host must write
> > : initial contents to guest memory.
> > :
> > : Will this work for all cases CCA/SNP/TDX during initial memory
> > : population from within KVM:
> > : 1) Simulate stage2 fault
> > : 2) Take a KVM mmu read lock
> >
> > Doing all of this under mmu_lock is pretty much a non-starter.

Looking closer at CPU <-> PSP communication which is not implemented
to work within an atomic context, I agree now that this wouldn't work
for SNP VMs.


> >
> > : 3) Check that the needed gpa is mapped in EPT/NPT entries
> >
> > No, KVM's page tables are not the source of truth.  S-EPT is a special =
snowflake,
> > and I'd like to avoid foisting the same requirements on NPT.
>
> I agree this would be a new requirement.
>
> >
> > : 4) For SNP, if src !=3D null, make the target pfn to be shared, copy
> > : contents and then make the target pfn back to private.
> >
> > Copying from userspace under spinlock (rwlock) is illegal, as accessing=
 userspace
> > memory might_fault() and thus might_sleep().
>
> I would think that a combination of get_user_pages() and
> kmap_local_pfn() will prevent this situation of might_fault().
>
> >
> > : 5) For TDX, if src !=3D null, pass the same address for source and
> > : target (likely this works for CCA too)
> > : 6) Invoke appropriate memory encryption operations
> > : 7) measure contents
> > : 8) release the KVM mmu read lock
> > :
> > : If this scheme works, ideally we should also not call RMP table
> > : population logic from guest_memfd, but from KVM NPT fault handling
> > : logic directly (a bit of cosmetic change).
> >

