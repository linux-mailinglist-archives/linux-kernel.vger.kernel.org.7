Return-Path: <linux-kernel+bounces-738845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133B0B0BE10
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 09:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49CC23B3E53
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 07:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0334C283FD2;
	Mon, 21 Jul 2025 07:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KTpHwn2D"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4CB199947
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 07:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753084158; cv=none; b=geoRnbOHxRNLO085qLZBtLJ4oZ+TlFEQI2ewUV2EYBKfcLu1uz/vGKZwGaFWHG+kU+fBNWjU3VnoFBzrjiGBu155rN0X0Dsmy5P9fANk3HpN7LTg+ZTgaGyVgfRgIsDWZBSBEsuC1cmFVa/TGPX8bMTGXdBFEIvNdxDlILHCG4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753084158; c=relaxed/simple;
	bh=VOtCbcVt0gGNHLvbj63WBHKbZ6X+uMuPLPPZJmm635U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKBHI/thEexSbB946UpzmIJf9U0QpyQH6+BFsg/AieyUSWpIGmPQrlpeRH/ahX2ONJayG9G60m/UKBAhwsmfQkT2SIZGct84Gh8OQgwyrmMEfR71dmCLOzUfO4JOB8FFcCCAOHBWXEmbzc2dgwReDN+ua19kX3OyQHVTzV80iXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KTpHwn2D; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45629702e52so16564515e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 00:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753084154; x=1753688954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kKg1W6M4USiwNTbJCkdBvx9IOQ14GKTE6DwJxmpiYlk=;
        b=KTpHwn2D1V731ECf6Svpzs8L3US8IIPvQM7jN5YHCcM4xOnSonU97lkyz66kQ04K+q
         EZYGMtF3wLuOS/r20L05itNE3IiKgPd3jw0rFCMbqeJTDe8YPaG0i9lfMH0LcGg+d4Vr
         fdSKAECmCx7xu8EUu7cNG5xVK+IyO8X+tzMhrfDId9yqqee0Z2O+uSFxWdVhOgZgnf1l
         T9Q/VeHzUvlpk7TMdBDfKzo6BsQI+kuZMR4An5hLjoNbv8hY61hH/yyL01wzxmRZnF18
         Ni+Ob8IkZmBIOiQUZ54HhaizjqO4kJ8M7GqjHQdd011pQIiFfDkuUZshJakUpoFJZxtO
         joSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753084154; x=1753688954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKg1W6M4USiwNTbJCkdBvx9IOQ14GKTE6DwJxmpiYlk=;
        b=UErHpZijhAqqQiulKys/2jLwkkaN3qY1CPvcM4ROXpFj92q1xcnw/nLMUTM9FIH+U8
         VjqcEN5h2vkD8uf2KWQNctW3XkgsW0ajxC/y+Zr5pNn2ZidHGQY9kXarQ8uKs6IN6Le0
         f1IQ+fJzfYNfanBhjQ42ai83Q9Wsm9Y/MOya+Gu1+hrjxwH+HidFLZzoWtLs686waUmX
         svo/MHRJAACoyL0AQ6AHYbFViXVI9gYxKc+fF1gExQ3N/dJCVUQ0h1G4/O2F27/+ZXxy
         u+agBl7XkzPVBiZw464h3J05jPv7UwZlHqQVU/w/avtwGIxY2KkToECsSwxKjzTVQgPJ
         49pA==
X-Forwarded-Encrypted: i=1; AJvYcCWWAOwXSv92wy1m5LtctM0NE24dqPPuTbsRNeoj59phSn6Ca1OqDikIj0e1czoRx9bQ8JsvYN8cI1O5om4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxjpCXwZnXobwhoJWUvUbaaiq2K6vvB5yE6VTaW8kd8+ICZXzD
	OWXXHVsrQnNVi5BhLQscH/11aIHV2giLQmq5uG8C0HvB94LZZUqpDIIiS7hnQw5hEm4T6lKjktd
	hpTlW3dAv
X-Gm-Gg: ASbGncvGG3bhp/+enZDf/jzTv172qxV5NIM/4ThTztysZbKh7q8WZEaP7ZPaB1mOQge
	EVrB3e87zfrvk1dAQyLpRxmyB5FwO/4Vt42yAjcYY27iA4tR9MoT6l/TIxy+2Up19wW+4M5oF2X
	4YLZuftWTxYpcjagCv0v42BZ92ObbdsnF4Mn200PrAw7soUM0x9CG7JIuCXiJ6lE4u52ZZrYQO7
	7b0oanTLKA4igMH9M4tOucSmArG9P7m7Qr0vsX4RgzrKSmRwCPCze62zgqe/kDzOsow6KWRFt5Y
	803qM1n7QCDD0YfNvcYXRmPDMdyf2fQyydFbyo8UTFtELbkfIBZXy7mzNNb9n9S7vy5l98VsuMu
	pIju3+Xg/LV4BmZYseOnv4xN6wpYZ1Sq2uiDTnGnpKWjnUAfZ+2HDqruiJAMnRskGcqAw5g==
X-Google-Smtp-Source: AGHT+IHLCPN08G76cpeAjmGFh2SwOYUq7PKTpI10Q0DJaIHMug/5GI7V+ike5MmSquAW5czvaJ/6xw==
X-Received: by 2002:a05:6000:2902:b0:3a4:f038:af74 with SMTP id ffacd0b85a97d-3b60e518418mr15229224f8f.51.1753084153650;
        Mon, 21 Jul 2025 00:49:13 -0700 (PDT)
Received: from google.com (120.142.205.35.bc.googleusercontent.com. [35.205.142.120])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4894asm9640037f8f.49.2025.07.21.00.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 00:49:13 -0700 (PDT)
Date: Mon, 21 Jul 2025 07:49:10 +0000
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
Message-ID: <aH3w9t78dvxsDjhV@google.com>
References: <20250716110737.2513665-1-keirf@google.com>
 <20250716110737.2513665-3-keirf@google.com>
 <kb7nwrco6s7e6catcareyic72pxvx52jbqbfc5gbqb5zu434kg@w3rrzbut3h34>
 <aHphgd0fOjHXjPCI@google.com>
 <5zpxxmymnyzncdnewdonnglvmvbtggjyxyqvkf6yars2bbyr4b@gottasrtoq2s>
 <aHtQG_k_1q3862s3@google.com>
 <4i65mgp4rtfox2ttchamijofcmwjtd6sefmuhdkfdrjwaznhoc@2uhcfv2ziegj>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4i65mgp4rtfox2ttchamijofcmwjtd6sefmuhdkfdrjwaznhoc@2uhcfv2ziegj>

On Sun, Jul 20, 2025 at 08:08:30AM +0800, Yao Yuan wrote:
> On Sat, Jul 19, 2025 at 07:58:19AM +0000, Keir Fraser wrote:
> > On Sat, Jul 19, 2025 at 10:15:56AM +0800, Yao Yuan wrote:
> > > On Fri, Jul 18, 2025 at 08:00:17AM -0700, Sean Christopherson wrote:
> > > > On Thu, Jul 17, 2025, Yao Yuan wrote:
> > > > > On Wed, Jul 16, 2025 at 11:07:35AM +0800, Keir Fraser wrote:
> > > > > > In preparation to remove synchronize_srcu() from MMIO registration,
> > > > > > remove the distributor's dependency on this implicit barrier by
> > > > > > direct acquire-release synchronization on the flag write and its
> > > > > > lock-free check.
> > > > > >
> > > > > > Signed-off-by: Keir Fraser <keirf@google.com>
> > > > > > ---
> > > > > >  arch/arm64/kvm/vgic/vgic-init.c | 11 ++---------
> > > > > >  1 file changed, 2 insertions(+), 9 deletions(-)
> > > > > >
> > > > > > diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
> > > > > > index 502b65049703..bc83672e461b 100644
> > > > > > --- a/arch/arm64/kvm/vgic/vgic-init.c
> > > > > > +++ b/arch/arm64/kvm/vgic/vgic-init.c
> > > > > > @@ -567,7 +567,7 @@ int kvm_vgic_map_resources(struct kvm *kvm)
> > > > > >  	gpa_t dist_base;
> > > > > >  	int ret = 0;
> > > > > >
> > > > > > -	if (likely(dist->ready))
> > > > > > +	if (likely(smp_load_acquire(&dist->ready)))
> > > > > >  		return 0;
> > > > > >
> > > > > >  	mutex_lock(&kvm->slots_lock);
> > > > > > @@ -598,14 +598,7 @@ int kvm_vgic_map_resources(struct kvm *kvm)
> > > > > >  		goto out_slots;
> > > > > >  	}
> > > > > >
> > > > > > -	/*
> > > > > > -	 * kvm_io_bus_register_dev() guarantees all readers see the new MMIO
> > > > > > -	 * registration before returning through synchronize_srcu(), which also
> > > > > > -	 * implies a full memory barrier. As such, marking the distributor as
> > > > > > -	 * 'ready' here is guaranteed to be ordered after all vCPUs having seen
> > > > > > -	 * a completely configured distributor.
> > > > > > -	 */
> > > > > > -	dist->ready = true;
> > > > > > +	smp_store_release(&dist->ready, true);
> > > > >
> > > > > No need the store-release and load-acquire for replacing
> > > > > synchronize_srcu_expedited() w/ call_srcu() IIUC:
> > > >
> > > > This isn't about using call_srcu(), because it's not actually about kvm->buses.
> > > > This code is concerned with ensuring that all stores to kvm->arch.vgic are ordered
> > > > before the store to set kvm->arch.vgic.ready, so that vCPUs never see "ready==true"
> > > > with a half-baked distributor.
> > > >
> > > > In the current code, kvm_vgic_map_resources() relies on the synchronize_srcu() in
> > > > kvm_io_bus_register_dev() to provide the ordering guarantees.  Switching to
> > > > smp_store_release() + smp_load_acquire() removes the dependency on the
> > > > synchronize_srcu() so that the synchronize_srcu() call can be safely removed.
> > >
> > > Yes, I understand this and agree with your point.
> > >
> > > Just for discusstion: I thought it should also work even w/o
> > > introduce the load acqure + store release after switch to
> > > call_srcu(): The smp_mb() in call_srcu() order the all store
> > > to kvm->arch.vgic before store kvm->arch.vgic.ready in
> > > current implementation.
> >
> > The load-acquire would still be required, to ensure that accesses to
> > kvm->arch.vgic do not get reordered earlier than the lock-free check
> > of kvm->arch.vgic.ready. Otherwise that CPU could see that the vgic is
> > initialised, but then use speculated reads of uninitialised vgic state.
> >
> 
> Thanks for your explanation.
> 
> I see. But there's "mutex_lock(&kvm->slot_lock);" before later
> acccessing to the kvm->arch.vgic, so I think the order can be
> guaranteed. Of cause as you said a explicitly acquire-load +
> store-release is better than before implicitly implementation.

If vgic_dist::ready is observed true by the lock-free read (the one
which is turned into load-acquire by this patch) then the function
immediately returns with no mutex_lock() executed. It is reads of
vgic_dist *after* return from kvm_vgic_map_resources() that you have
to worry about, and which require load-acquire semantics.

> 
> > > >

