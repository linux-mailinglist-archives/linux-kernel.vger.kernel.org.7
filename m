Return-Path: <linux-kernel+bounces-737623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0262B0AE81
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 09:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 878BE7B9BF6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 07:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BB4233736;
	Sat, 19 Jul 2025 07:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vODRF+kC"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF78222D4E2
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 07:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752911907; cv=none; b=EUdZQ2n3Y+620eLqH+xN8RtFJ3ih6WL7V7bXCqY+/8VORv1cHEuCZd/D/pFAKy8O51JZPkxOYXrOOdXjdonki+f4TNo92exUZil7uiBQDhLWE/NCt9kqrMXjHc0sDvwMBjNCp5+T1c4n5Aw1Fg2oDOAi2sy75yMzLRJHHo+3od8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752911907; c=relaxed/simple;
	bh=tJ1uWbUjnxLlGM3QoOhkMA4nYAs8lfUm3ulVKnjtvSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=In1zsrOL6Ok8U8Y0cfxTrrtIHvh9c99sX40qDJS5hryEV3fk9TkIQ82+ICRlYgK1p6zCY03DlWd7m0o1bnUhxiaWKkHYKt5LwmkZXiv232Zs/fae90JdtE3XGJPQ3JXSgnKsBHzPJV3WZSZ7MJiUePzdZiU+2J3YFaq2HEsxaJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vODRF+kC; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so2567341f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 00:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752911904; x=1753516704; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TfRByUZViUlkhtvwbgJ9kqHK2zRV37bvsO8dM/mnyeg=;
        b=vODRF+kC95FT79zjGsl+L9B3K1IsbTrfSFnd7wsYCj/GmlykdgMt4NaRn3GYHZtrRr
         pskjfi6iMiM4SZKN6xu7/4E4L8Mf08++LLxiZv3dMYrY+GGNClqi4kfp7VbKGKLyK+9F
         NMNR73ak2Ui35J5ouqolASqhz6CQxK2lAyzkYKq25vdNSO6AZASgG8/0OZ3XYzDoIjV9
         GOaPdMvOhsalcO17ySnZXpwAbtNDCzR8T+Ezw+Yry+42pjftTAdM331+GXnBfjVgFqXB
         NGQyxWtAbgmnt18+m/VR4Vd4dePGXURR9gtCBF2381pKASSgUWS8RrgXjmxOpWjrMwsy
         QsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752911904; x=1753516704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfRByUZViUlkhtvwbgJ9kqHK2zRV37bvsO8dM/mnyeg=;
        b=G5h6Op9389pW9j4fW5CiOml2wOaNIe9mk5Wo6p+D0C19SCW8j4gLGG+cb5ocJcjgzI
         QzA/Puqz3jfjN9VmUY090WXpvqDmqQFetzeJTRAonIMTygnd/Gd2h0wVuc82bksRpGFz
         HTPcqvrov0CdROF4qiq6Q8akBbTO29Xah1B+Bt8x94V19JPz8mWXFs1u4mva/Dj6Q5wN
         7oFp1lyJF5CZ2yFvmJ/9tjiHHFlVvaaHkvMfhjXsmPV2JYCNotGnrNxojaWSUJqQWdLz
         yXQD8xKkSC5HjH83XHnn65aX6S14kzIUh//0NRWE6XkeZn1uPRt9Kvld0sVIvvlEQhaN
         ROWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeAJeGdFBdBdx5SzRlyEJNRJI9wT0WdQsgkya1uUEqJTxUgtJvHzgmNE4sybdqzv1hiBxZk/zd++mIYnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxppwDRB/2bQV8oKB4v2/uyBW1zQ0LdOg+ziLKl2+NZAl+GJatC
	NAl1Ex+bbVPcRK4PIvl3NwAJIjmmtktoBo+ovdnyNv3e5nJ7aSGEsATN8SNcD6XTFA==
X-Gm-Gg: ASbGnctSOUPw3f6bRS2GnPMroUx4XUyH4w1vG8g+jhXNfajtDEjURUX+WTs9nMOFcnU
	LY5WsnCBcx+/eO6PzUHdvH8I0KcXxeDpBljcu6qmjDhOYbLmoOobW0efeYLKk1ATHg46jt8RHuk
	d2tjH7h2iDrOocGSOJWm69W8nm1UdpQL+oXJn1xxUl3xLbxrHoexZNp5/wnMF2txoY2Pqr/0TN3
	EMGNTi63beDzh80pJliLapjFTVQxbv/aZ+8WkqcOaHtHVfaSvzYvDZ5NUlGiOKyzWeq2k/N9jqw
	ZxNTmb1nqsaA+YrZkPHO0ueJ5vsqJs1TuTXfXkEJUhE3nxblcel7GIigiFWSTrX8QCiWT+2ITnS
	CQE0UMFkOgGjUz/vvXwkHO6McXlkHu0u0D5SKjTvLrX3JAeT+kA6ArFALbxX44Lj0VfjFng==
X-Google-Smtp-Source: AGHT+IH9Zj8Sie+1djBoT8jRSDy8Q+NDwYSbOAjVh0kWnwssstjjIHWaSUiNz3Ecv1vUll7ozzg2eA==
X-Received: by 2002:a05:6000:42c6:b0:3a3:7115:5e7a with SMTP id ffacd0b85a97d-3b60dd7b0dbmr8359452f8f.42.1752911903972;
        Sat, 19 Jul 2025 00:58:23 -0700 (PDT)
Received: from google.com (120.142.205.35.bc.googleusercontent.com. [35.205.142.120])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2b803sm3923821f8f.19.2025.07.19.00.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 00:58:23 -0700 (PDT)
Date: Sat, 19 Jul 2025 07:58:19 +0000
From: Keir Fraser <keirf@google.com>
To: Yao Yuan <yaoyuan0329os@gmail.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Yao Yuan <yaoyuan@linux.alibaba.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 2/4] KVM: arm64: vgic: Explicitly implement
 vgic_dist::ready ordering
Message-ID: <aHtQG_k_1q3862s3@google.com>
References: <20250716110737.2513665-1-keirf@google.com>
 <20250716110737.2513665-3-keirf@google.com>
 <kb7nwrco6s7e6catcareyic72pxvx52jbqbfc5gbqb5zu434kg@w3rrzbut3h34>
 <aHphgd0fOjHXjPCI@google.com>
 <5zpxxmymnyzncdnewdonnglvmvbtggjyxyqvkf6yars2bbyr4b@gottasrtoq2s>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5zpxxmymnyzncdnewdonnglvmvbtggjyxyqvkf6yars2bbyr4b@gottasrtoq2s>

On Sat, Jul 19, 2025 at 10:15:56AM +0800, Yao Yuan wrote:
> On Fri, Jul 18, 2025 at 08:00:17AM -0700, Sean Christopherson wrote:
> > On Thu, Jul 17, 2025, Yao Yuan wrote:
> > > On Wed, Jul 16, 2025 at 11:07:35AM +0800, Keir Fraser wrote:
> > > > In preparation to remove synchronize_srcu() from MMIO registration,
> > > > remove the distributor's dependency on this implicit barrier by
> > > > direct acquire-release synchronization on the flag write and its
> > > > lock-free check.
> > > >
> > > > Signed-off-by: Keir Fraser <keirf@google.com>
> > > > ---
> > > >  arch/arm64/kvm/vgic/vgic-init.c | 11 ++---------
> > > >  1 file changed, 2 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
> > > > index 502b65049703..bc83672e461b 100644
> > > > --- a/arch/arm64/kvm/vgic/vgic-init.c
> > > > +++ b/arch/arm64/kvm/vgic/vgic-init.c
> > > > @@ -567,7 +567,7 @@ int kvm_vgic_map_resources(struct kvm *kvm)
> > > >  	gpa_t dist_base;
> > > >  	int ret = 0;
> > > >
> > > > -	if (likely(dist->ready))
> > > > +	if (likely(smp_load_acquire(&dist->ready)))
> > > >  		return 0;
> > > >
> > > >  	mutex_lock(&kvm->slots_lock);
> > > > @@ -598,14 +598,7 @@ int kvm_vgic_map_resources(struct kvm *kvm)
> > > >  		goto out_slots;
> > > >  	}
> > > >
> > > > -	/*
> > > > -	 * kvm_io_bus_register_dev() guarantees all readers see the new MMIO
> > > > -	 * registration before returning through synchronize_srcu(), which also
> > > > -	 * implies a full memory barrier. As such, marking the distributor as
> > > > -	 * 'ready' here is guaranteed to be ordered after all vCPUs having seen
> > > > -	 * a completely configured distributor.
> > > > -	 */
> > > > -	dist->ready = true;
> > > > +	smp_store_release(&dist->ready, true);
> > >
> > > No need the store-release and load-acquire for replacing
> > > synchronize_srcu_expedited() w/ call_srcu() IIUC:
> >
> > This isn't about using call_srcu(), because it's not actually about kvm->buses.
> > This code is concerned with ensuring that all stores to kvm->arch.vgic are ordered
> > before the store to set kvm->arch.vgic.ready, so that vCPUs never see "ready==true"
> > with a half-baked distributor.
> >
> > In the current code, kvm_vgic_map_resources() relies on the synchronize_srcu() in
> > kvm_io_bus_register_dev() to provide the ordering guarantees.  Switching to
> > smp_store_release() + smp_load_acquire() removes the dependency on the
> > synchronize_srcu() so that the synchronize_srcu() call can be safely removed.
> 
> Yes, I understand this and agree with your point.
> 
> Just for discusstion: I thought it should also work even w/o
> introduce the load acqure + store release after switch to
> call_srcu(): The smp_mb() in call_srcu() order the all store
> to kvm->arch.vgic before store kvm->arch.vgic.ready in
> current implementation.

The load-acquire would still be required, to ensure that accesses to
kvm->arch.vgic do not get reordered earlier than the lock-free check
of kvm->arch.vgic.ready. Otherwise that CPU could see that the vgic is
initialised, but then use speculated reads of uninitialised vgic state.

> >

