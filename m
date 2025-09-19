Return-Path: <linux-kernel+bounces-824740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E29B8A0D9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CE831BC264D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87579313D78;
	Fri, 19 Sep 2025 14:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GJuQwsn3"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982FB227EA8
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293073; cv=none; b=d5rKouyKmABttt+P1fX/pA/UvW9BBLZRMVmx9ZfCBZk7bj/xfeCNCqZoWhOY8LUVDOW5rKuLWd/Nh2YJ1zhFN5MG245ThjLNK6uAmKxyItTAqcyBjE2ttdw5+NTbTZMpBqxBcxA9gwupJ1Z0luOsisc9RU0zzpEUw8F2gleQl5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293073; c=relaxed/simple;
	bh=MUj53GleMCqeyfJjFbQ9TQUfYZaREMrgUs/wU8N2VTY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fcokOE7xLvvTOzjdUpMmZ2sdErx7pzf2fdwD11/yPFOEIJYrwGa/PLyt6Fk+RNepi2pzQ+BhLvBWGLVR5IzsWxx9P0Tu1gMPANZobFNSe9T7WbO2bvEohwdW1jBzvjU0+gAoxqLinTO64TmxCzLecvUeZF6EmavB3gXnMELI7JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GJuQwsn3; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2698b5fbe5bso22580005ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758293071; x=1758897871; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4jjvVkgxhUaeqBeONQFEa5pWQaTCfdaimymDJt0jOmE=;
        b=GJuQwsn3yiLEDCx7qH62k+49YtfC1BaobppZyZOBbmju4Vo5/86KIX08i/xQIyRfKp
         RdjELlpEKF3IieKX+uWkUUwL928PcxreoBdl1D82aH/Za0spI4NW5MCJW+bvhvVT/c4X
         mzXhvrzFX1IgslDWW6z5SuSvZnVbvUa7WYO5rWoo/1uA5y8j7BRQBj4VPzgVy/+qSpmF
         4CoR85jOrJJ0OQyHyMnrXVILiYcx/5JxNHHjYzvTQ39wsbTVGCZygEN/Rcl5HnOg7/Vh
         z9IJvAYsq+V2PkU9AArtaqSiX18WuA9PlSJG1IyrB0XZXjwV0JjXZiIMG7pkYnJSURsz
         Z0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758293071; x=1758897871;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4jjvVkgxhUaeqBeONQFEa5pWQaTCfdaimymDJt0jOmE=;
        b=sH/xglHL/o+E5+CdaBZ6Y1QzWu5GXO7R+f+sT0GOR0Q3ThM25ZDXyFOdiU6mcJg2rU
         MGCovq/Z8eZH3skjnkvC0mRUQ7EC2vLDnXG0BHn4cWDM14uEGECYVUrrKW7vhtKOud/f
         bo4GJdK35ofwmGv/aVDzGZUQ/WTtp67lq5jiNVCWReZGSLRCge2CyYkUknYCtkNNbItv
         1yksr/5JkCNj1EYa13oEoiz9hT9njOuXkUbiQsFZECXR56EKtw5Gl9iUkfasCw9RlEJG
         qIieiA7sWHdlAQd7Pmv+b+FiKOqApX9RpnlhsTI1rz2jgJiTYF2p769S36v5AMXJILA3
         39Ug==
X-Forwarded-Encrypted: i=1; AJvYcCVK/pDodKVptU00QaTTud6dkE3P4miaTyjz8XsN5pbBd6E2+OSl4kZTI6zxjgEsnfXdPnk3QSzIQrGoVBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmpVKYfYOHVRmRbHdR+FbIau3CpmYZc7dTHm0OEP16ldMYYQIA
	a2H2aIgLrYY+HqpX0F1jq35Z31tlO3TuHJ1lbdbtYkgBQxf1V6Z8W7Yp2X84BtfA52Q6mhOdpUT
	v3zA1/g==
X-Google-Smtp-Source: AGHT+IEn8X8S7vgSHRiAQYwhDeWozAPVLoysbzfdeOtu6hQCaqgsUdc41VBhlqwjXMLIOm7dR99ZKzBuIek=
X-Received: from pjbqn15.prod.google.com ([2002:a17:90b:3d4f:b0:32e:aa46:d9ab])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32c7:b0:246:2b29:71c7
 with SMTP id d9443c01a7336-269ba4804b7mr43995485ad.25.1758293070937; Fri, 19
 Sep 2025 07:44:30 -0700 (PDT)
Date: Fri, 19 Sep 2025 07:44:29 -0700
In-Reply-To: <73txiv6ycd3umvlptnqnepsc6hozuo4rfmyqj4rhtv7ahkm43k@37jbftataicw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919002136.1349663-1-seanjc@google.com> <20250919002136.1349663-6-seanjc@google.com>
 <73txiv6ycd3umvlptnqnepsc6hozuo4rfmyqj4rhtv7ahkm43k@37jbftataicw>
Message-ID: <aM1sTc36cXIKxCDb@google.com>
Subject: Re: [PATCH v3 5/6] KVM: SVM: Move global "avic" variable to avic.c
From: Sean Christopherson <seanjc@google.com>
To: Naveen N Rao <naveen@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 19, 2025, Naveen N Rao wrote:
> On Thu, Sep 18, 2025 at 05:21:35PM -0700, Sean Christopherson wrote:
> > @@ -1141,15 +1149,9 @@ void avic_vcpu_unblocking(struct kvm_vcpu *vcpu)
> >  	avic_vcpu_load(vcpu, vcpu->cpu);
> >  }
> >  
> > -/*
> > - * Note:
> > - * - The module param avic enable both xAPIC and x2APIC mode.
> > - * - Hypervisor can support both xAVIC and x2AVIC in the same guest.
> > - * - The mode can be switched at run-time.
> > - */
> > -bool __init avic_hardware_setup(struct kvm_x86_ops *svm_ops)
> > +static bool __init avic_want_avic_enable(void)
> 
> Maybe avic_can_enable()?

That was actualy one of my first names, but I didn't want to use "can" because
(to me at least) that doesn't capture that the helper is incorporating input from
the user, i.e. that it's also checking what the user "wants".

I agree the name isn't great.  Does avic_want_avic_enabled() read any better?

> >  {
> > -	if (!npt_enabled)
> > +	if (!avic || !npt_enabled)
> >  		return false;
> >  
> >  	/* AVIC is a prerequisite for x2AVIC. */
> > @@ -1174,6 +1176,20 @@ bool __init avic_hardware_setup(struct kvm_x86_ops *svm_ops)
> >  		pr_warn("AVIC unsupported in CPUID but force enabled, your system might crash and burn\n");
> >  
> >  	pr_info("AVIC enabled\n");
> 
> I think it would be good to keep this in avic_hardware_setup() alongside 
> the message printing "x2AVIC enabled".

+1, looks waaay better that way.

