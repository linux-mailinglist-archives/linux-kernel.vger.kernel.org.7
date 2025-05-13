Return-Path: <linux-kernel+bounces-646025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00700AB56CD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 16:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38E4A16212A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 14:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424F22BD01B;
	Tue, 13 May 2025 14:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nGuvO6n8"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3388E1DF277
	for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 14:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747145633; cv=none; b=DkNQwJ/As2HT3h0jBGKmMDojENkKMUIg23bqs6ijVPh1Du1BQ8B0npQMEgw2ireXLenpTpb7FEddhPO+sPhk8mBHgCQx2Wu5pLFrD9KQ4QZn4czbzdznf9oPIFim4KeS442Ka17Dpih1Fb7BjB2YKEOwdU1pewkjKVwHbhMVIAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747145633; c=relaxed/simple;
	bh=71k1cSyZVTbOS1tH1mlJ2LOGRFzFLK01tbuwTjlLE7E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hrinl/OcTsMBNEWzpUDWTrVX6rbNXT6Eb008dEhzQvUiIameTPcuhpJAfvEYvRjfA17h4LOu/FjZX6abIGJQqaYvOQlm3QSz+C7tk6FtiK1Ln0bjTAOZR2+XySRRWxEV6sJvrDzXh9drxto9qFP2xUbqyMm3wiZ81jD++aOBKcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nGuvO6n8; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30ab5d34fdbso5202721a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 07:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747145631; x=1747750431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HQPIZXjJimDteydfajh9qmCSJFtgL60BxuT4DLlRNjY=;
        b=nGuvO6n8toLYnuFKt1YbdXex1KuI6iCV1Vz8EhxqFrWzXTheyzUFIaXOvi5o5JiMUo
         DJJW/Ty5FVe9ZXsEWlywpQRD6/ByGG18SWaR10KlyPpXSc9kzSpL12nGsOecwieMp0un
         kdLELthZnoMROND21BVQPFOCAd7jebxmBJP00EUO1MNOZiQWhTwSST7k3UGgVvdJw7LZ
         julp/sUHfeaE9k59pcrCJPjCETX17r88kwgjTdLr34Wxm4d5IHWI+9h52btjxt5+tP1A
         dIdqkwd+mSKHCW7w4HNuQ3BIcmqJSEtEmfHxWwb8E99OvTuGmIIBpp4ftfp2K23NoJbt
         x3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747145631; x=1747750431;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HQPIZXjJimDteydfajh9qmCSJFtgL60BxuT4DLlRNjY=;
        b=Ef7InxQmzg5VIM6zHMuDl2OpPi/cF7yNdImkKt3GO4Ri9RYYYfa27E9IzIpAsHcGZs
         w0hcnD3CJxWvq/lsloP/cw9WwBodX32eLiRWb+NOGyTEN4YQq+FoIYKaSXfboWzXO0AV
         hztzguM+N+lBhrS88pPspCfLaCg1Lma9eNSB2Ag6UaAlninhtA95VsZyuv9IRdNGxMHk
         15cC9RIkE8jNJ6Qb9ebPwaSaVSSeoaujbWNXrJbS8v9KGYoFzPZtLEN5WgTB3r2x5vgA
         ot7VBIUQQIKGyS1d9luSOhIc1n0Op8Dnra1r3kwTYsPjrrhrXtq6r/3fH6KKnrBLGBbd
         FIew==
X-Forwarded-Encrypted: i=1; AJvYcCWgXV6zD0kI3elghfNt9gFLcatRDLs8zMQIx71Vkr61v0cPi+S7C3pbrjMlNZYUxTogqLJUOUmHnnfAFmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrE8qeKM0QtT2rDR8sqGQAdejY4oXbimrtR6DGveQuXs7+t6Po
	2UxdZi4JEFzQpKNDYmFFMtxwqdQsOjxpjJvIiV2iYvifgDdRHYW5csbuEvDamrRSGB7VcoNhGgL
	Wxw==
X-Google-Smtp-Source: AGHT+IGVw03ZwNv354mGFU9Pl/PFszB28i4M15oqcxUWbfuLwkD+ig2nSbKABqmyGr9RhF5lU4cTa8w9VmU=
X-Received: from pjbnd16.prod.google.com ([2002:a17:90b:4cd0:b0:2fc:11a0:c549])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:558f:b0:2ea:a9ac:eee1
 with SMTP id 98e67ed59e1d1-30c3cefb7a6mr29813429a91.10.1747145631366; Tue, 13
 May 2025 07:13:51 -0700 (PDT)
Date: Tue, 13 May 2025 07:13:49 -0700
In-Reply-To: <CADrL8HURpnXgN0ux4sUk0nVze=A6d488i_ztiZTwGZUdDMoTvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250508141012.1411952-1-seanjc@google.com> <20250508141012.1411952-4-seanjc@google.com>
 <CADrL8HURpnXgN0ux4sUk0nVze=A6d488i_ztiZTwGZUdDMoTvg@mail.gmail.com>
Message-ID: <aCNTnXf5qZ1MMSNi@google.com>
Subject: Re: [PATCH v2 3/5] KVM: Conditionally reschedule when resetting the
 dirty ring
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Xu <peterx@redhat.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025, James Houghton wrote:
> On Thu, May 8, 2025 at 7:11=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
> > ---
> >  virt/kvm/dirty_ring.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/virt/kvm/dirty_ring.c b/virt/kvm/dirty_ring.c
> > index e844e869e8c7..97cca0c02fd1 100644
> > --- a/virt/kvm/dirty_ring.c
> > +++ b/virt/kvm/dirty_ring.c
> > @@ -134,6 +134,16 @@ int kvm_dirty_ring_reset(struct kvm *kvm, struct k=
vm_dirty_ring *ring,
> >
> >                 ring->reset_index++;
> >                 (*nr_entries_reset)++;
> > +
> > +               /*
> > +                * While the size of each ring is fixed, it's possible =
for the
> > +                * ring to be constantly re-dirtied/harvested while the=
 reset
> > +                * is in-progress (the hard limit exists only to guard =
against
> > +                * wrapping the count into negative space).
> > +                */
> > +               if (!first_round)
> > +                       cond_resched();
>=20
> Should we be dropping slots_lock here?

Could we?  Yes.  Should we?  Eh.  I don't see any value in doing so, becaus=
e in
practice, it's extremely unlikely anything will be waiting on slots_lock.

kvm_vm_ioctl_reset_dirty_pages() operates on all vCPUs, i.e. there won't be
competing calls to reset other rings.  A well-behaved userspace won't be mo=
difying
memslots or dirty logs, and won't be toggling nx_huge_pages.

That leaves kvm_vm_ioctl_set_mem_attributes(), kvm_inhibit_apic_access_page=
(),
kvm_assign_ioeventfd(), snp_launch_update(), and coalesced IO/MMIO (un)regi=
stration.
Except for snp_launch_update(), those are all brutally slow paths, e.g. req=
uire
SRCU synchronization and/or zapping of SPTEs.  And snp_launch_update() is p=
robably
fairly slow too.

And dropping slots_lock only makes any sense for non-preemptible kernels, b=
ecause
preemptible kernels include an equivalent check in KVM_MMU_UNLOCK().

It's also possible that dropping slots_lock in this case could be a net neg=
ative.
I don't think it's likely, but I don't think it's any more or less likely t=
hat
droppings slots_lock is a net positive.  Without performance data to guide =
us,
it'd be little more than a guess, and I really, really don't want to set a
precedence of dropping a mutex on cond_resched() without a very strong reas=
on
for doing so.

> It seems like we need to be holding slots_lock to call kvm_reset_dirty_gf=
n(),
> but that's it. Userspace can already change the memslots after enabling t=
he
> dirty ring, so `entry->slot` can already be stale, so dropping slots_lock=
 for
> the cond_resched() seems harmless (and better than not dropping it).

