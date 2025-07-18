Return-Path: <linux-kernel+bounces-737069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E103AB0A757
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F9AAA8417C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF952E498E;
	Fri, 18 Jul 2025 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ryURn2lR"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383BF2E3B06
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752852355; cv=none; b=bPLTYLzcNHabunc+WI6UsNTPef4sw1paCdeANPOgocvfbV5dzRrnR/rouMjm55p1Ct/OF4Tc/vLre2xwPhgJlA8uY2/1RMeypUUpPgXAcKhnh7yMlbj5Vp7eXv1FTgFbkGTwkB6QHcbWXAPOLbehyrcSTfugNiTYVBm1RQOxNuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752852355; c=relaxed/simple;
	bh=D58eD8wUzs33iA8W9iOc6YFS+cpMDFwuN99BUwVXRp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zz2FZbMrhzxoSyVF5qtAhG6GuZvvBSDPv7xbI/Xj/dH5ny5gD+oktEF/wTGUGieWKTyFvBSmNZntj9B1uvhwDdNKB2c7ah7acEn1HS9H7NmZbNobuvVsZuhZzjamALI/wxPeGUI0M1omiBfb+NxnE+stBcrrT//lDoouwmQs2Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ryURn2lR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-454f428038eso18719135e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752852351; x=1753457151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OKELw1rTYkv1B6yffpxYDIyQglfQZjpB1wV9KreHqF0=;
        b=ryURn2lR9ct2X+w9+poDj6WZzP7PQDYPyhm7MPpyHs+wii6ausE+ngVg5x86azyyq1
         ScXsidR7sjVAp2/Hv5eNEsPWPGVMwIC1BHLdn+75H73qzPDjuV8xmyDTzVt9GkceSn8d
         xnBdRFZim7UNhkTOeSOC4mVlac3DJnbxQ6Y527+3ZY9O3nCQobh982TU9qIWrrlD/KXr
         hb9JG3eVcCJqJH5CJcwtZTh9EzE13vfQeluD4s2T8rjpc2ii1cdXrbQvmGWIU1/GBQ99
         scRu53KCVtPBDS9UZXENDCbTvXOxZMJ0vQ2BxyywrmI+e7MDxL/68X+/6/8fGrjeymdA
         /Iaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752852351; x=1753457151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKELw1rTYkv1B6yffpxYDIyQglfQZjpB1wV9KreHqF0=;
        b=CU7+YTTB4X8Ie4BO6b5dXgA0HXf1ym2HmBZHj98w12zqWx+9K5g7GrMoNuX+rgpI6h
         3oc0s2oLkuTgI7GkQg9NPLOUIeUe1/1YFoXk0HQRnE8RDuzBecDGaIwgFgrbIJhZnld+
         JMfXUWK2X3f2iNABrGcvF1GAjEip0GYx6xpVHeXzbESsC8ciKq3wtZ8tFymnCJPXfkqo
         N5Kmjrn2AiJrVJV2+BqzOPPN9usCPUtL5w+rbrHXOWSDGnQxdoCTaUNTDcA9W6MsarwJ
         7rJxtQB2/jFZN6huBY5HBqKUdC7nggt5wqpJHE0MgkdL7rS6d9tu6BOEoGreQLzftafD
         PDrw==
X-Forwarded-Encrypted: i=1; AJvYcCXnaEIzreyCcBG8ggOzgT9MWBy0FI3zVKWMZWpoDSZkHkcN9DYElJ3QxToCNk+mN6zJ6JjECwnlwhFkSm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0uQvCYo8JB/2ZdDd1EHkncLkeD8EM8bzYZ6XAn3QxKkfIq/1T
	lTHFef3IJkR+gEaD91Po5JEleGaF3pU8LHG/DylQQzH8eEWCH/1iY+hrhuo6LQR9dw==
X-Gm-Gg: ASbGncskHQMED8v6+jmI8iOqdycJRnt7Q69Zri5NNiNZA+ySBMAcDQcw6E6hZueOdpy
	8OvIKyE/Em5U1S6AKBx5PhCSrxAMf3tr9lfF1zzkXwAX9FE1BQBFunabfbbEMRdNybLgA6n1a1l
	TVfwohuEpxhtgp4utkDsXYzD0MmX/ZCf86+6f9kz+IK97kMbFo3ws785YE6K/4YGbcEXeix4Oeq
	ObsXiXtO4q1avBiUOocNdG6SPOVoAN6MFiE6Qgvj0McbSjjLyByKK6OdcnT4hU2vOPyjP06wWKI
	npTeEuSoh7dp5lGCBs0cD/lIoC+63SbKxrJGh8I2pIAztGHcbVgIc7AEMYDciOE6RmvP4ZAy+/f
	0mzu61EIwbXTw/GeIZYZM2xianCtTZOfqynpUu8ogTp1bN5rKDJG/MDOh+Xs=
X-Google-Smtp-Source: AGHT+IFEsX6w3p5b6OeCBzStdZQoPsSCNKy051XczTJ053zdaGJ5GR0dhN6hyLaShk4ohHEKc14IQw==
X-Received: by 2002:a05:600c:450f:b0:453:5fde:fb5b with SMTP id 5b1f17b1804b1-4562e39ba98mr114063145e9.19.1752852351230;
        Fri, 18 Jul 2025 08:25:51 -0700 (PDT)
Received: from google.com (120.142.205.35.bc.googleusercontent.com. [35.205.142.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b76148asm23877905e9.35.2025.07.18.08.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 08:25:50 -0700 (PDT)
Date: Fri, 18 Jul 2025 15:25:46 +0000
From: Keir Fraser <keirf@google.com>
To: Yao Yuan <yaoyuan@linux.alibaba.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
	Eric Auger <eric.auger@redhat.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 2/4] KVM: arm64: vgic: Explicitly implement
 vgic_dist::ready ordering
Message-ID: <aHpnev3hf1bEllsy@google.com>
References: <20250716110737.2513665-1-keirf@google.com>
 <20250716110737.2513665-3-keirf@google.com>
 <kb7nwrco6s7e6catcareyic72pxvx52jbqbfc5gbqb5zu434kg@w3rrzbut3h34>
 <aHpf9vuRK691J7HD@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHpf9vuRK691J7HD@google.com>

On Fri, Jul 18, 2025 at 02:53:42PM +0000, Keir Fraser wrote:
> On Thu, Jul 17, 2025 at 01:44:48PM +0800, Yao Yuan wrote:
> > On Wed, Jul 16, 2025 at 11:07:35AM +0800, Keir Fraser wrote:
> > > In preparation to remove synchronize_srcu() from MMIO registration,
> > > remove the distributor's dependency on this implicit barrier by
> > > direct acquire-release synchronization on the flag write and its
> > > lock-free check.
> > >
> > > Signed-off-by: Keir Fraser <keirf@google.com>
> > > ---
> > >  arch/arm64/kvm/vgic/vgic-init.c | 11 ++---------
> > >  1 file changed, 2 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
> > > index 502b65049703..bc83672e461b 100644
> > > --- a/arch/arm64/kvm/vgic/vgic-init.c
> > > +++ b/arch/arm64/kvm/vgic/vgic-init.c
> > > @@ -567,7 +567,7 @@ int kvm_vgic_map_resources(struct kvm *kvm)
> > >  	gpa_t dist_base;
> > >  	int ret = 0;
> > >
> > > -	if (likely(dist->ready))
> > > +	if (likely(smp_load_acquire(&dist->ready)))
> > >  		return 0;
> > >
> > >  	mutex_lock(&kvm->slots_lock);
> > > @@ -598,14 +598,7 @@ int kvm_vgic_map_resources(struct kvm *kvm)
> > >  		goto out_slots;
> > >  	}
> > >
> > > -	/*
> > > -	 * kvm_io_bus_register_dev() guarantees all readers see the new MMIO
> > > -	 * registration before returning through synchronize_srcu(), which also
> > > -	 * implies a full memory barrier. As such, marking the distributor as
> > > -	 * 'ready' here is guaranteed to be ordered after all vCPUs having seen
> > > -	 * a completely configured distributor.
> > > -	 */
> > > -	dist->ready = true;
> > > +	smp_store_release(&dist->ready, true);
> > 
> > No need the store-release and load-acquire for replacing
> > synchronize_srcu_expedited() w/ call_srcu() IIUC:
> > 
> > Tree SRCU on SMP:
> > call_srcu()
> >  __call_srcu()
> >   srcu_gp_start_if_needed()
> >     __srcu_read_unlock_nmisafe()
> > 	 #ifdef	CONFIG_NEED_SRCU_NMI_SAFE
> > 	   	  smp_mb__before_atomic() // __smp_mb() on ARM64, do nothing on x86.
> > 	 #else
> >           __srcu_read_unlock()
> > 		   smp_mb()
> > 	 #endif
> 
> I don't think it's nice to depend on an implementation detail of
> kvm_io_bus_register_dev() and, transitively, on implementation details
> of call_srcu().

Also I should note that this is moot because the smp_mb() would *not*
safely replace the load-acquire.

> kvm_vgic_map_resources() isn't called that often and can afford its
> own synchronization.
> 
>  -- Keir
> 
> > TINY SRCY on UP:
> > Should have no memory ordering issue on UP.
> > 
> > >  	goto out_slots;
> > >  out:
> > >  	mutex_unlock(&kvm->arch.config_lock);
> > > --
> > > 2.50.0.727.gbf7dc18ff4-goog
> > >

