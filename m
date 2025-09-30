Return-Path: <linux-kernel+bounces-838101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50052BAE719
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 21:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108B71C7A54
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAB82868B0;
	Tue, 30 Sep 2025 19:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GeSikPyr"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3F0285CAB
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 19:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759260588; cv=none; b=t2PmTygmdms4wBFvMTymqbVa2kfJXG758//9qb4CM+hXzjPQqwcN1AQix9g1mIl0MdKjDV8NaD8Lw+wZa/8MHfxBHPF9SrEl0FeLZrdpfcB1YkTSsxj/ezG0vb1ZAz+dNEa8+cMZGDWbn51issnM3I5fCwbLj0dPBa536/xhvNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759260588; c=relaxed/simple;
	bh=P+qZ2fZAEXfL436ybjprlYZc2AIijh26vuzV2ZNtQnk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KqlyVT23H+sFXmDl1GWlWFKxQ2J2ScpGNLUGtOKWf2OV/Ag7xQ+9YqoFROqLDlDwCd9f3L7MLbgnO5kf54vyhpQlXHZ7q0vN2EBHuEw0A7Bk4sl24FrgEjRnouJqKqLd/p7/BiDqwOIXZ+a+6j1dHhnkz05kt3lOLJm2AHja3kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GeSikPyr; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-267fa90a2fbso2237565ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759260586; x=1759865386; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bRnlDy13lHDP7WqEGAF8ErlJ5mSCGwAed5lppIb8Dzg=;
        b=GeSikPyrgxxfW0mpkkwdm4MvCmz3F9ZjMnMgNRhrAGH+xdqAy3DG6wkzWRVKQpOpBY
         fgTZIWpOJLrdcqzHrTesUAEJcQil3WLdQx44hw6mXLx8u3/u33eyOdJAJOuiaxw3YdhT
         kY6TULqq6EYrFf6X2PcfyAlf83XKPp+3iwSOXSVcq8QGj79RtCXR9bSF7xomc5YQk9vc
         RChZZqSira0XQa397RG4a62vbXnCADMi6kKsL+oQzpKxIvmi4Uv521MmguVvStvBuuAV
         5lfwrxGGGRAy8E5FQE40TyoF8PMvsrN+EQUSIlINY79FDd6pg6FTfuxwfiqQMln9pW7X
         ePJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759260586; x=1759865386;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bRnlDy13lHDP7WqEGAF8ErlJ5mSCGwAed5lppIb8Dzg=;
        b=rg2FCc+ECRBA7GGrlWTXQ+vkwvyrcv4kWT3uaUf+jHGUnqtd0ZcZf7HbVWMAf9ApS4
         bwZiI+kL1tOBa6lqA2ZHUBYDKePu0k1FnjM7gKC6N0Gizj5nG9uzvFTSFVgjQRMcuJnp
         moiFG4j01SlPyHm4z7uvdDnRjSw9m8CUe+Y/1MtubTFUamAhVxNrnKMq6RjZfP+jdTAC
         PFEqPTIKg6G0wHwbnzCgrxwHkIwbNMRYS4Y9P8/OeMFSJrzfvmFcNYD1mXSk4NpwJOGw
         Rdnlgc/3We4lXvAyQAkhp1qL/+6qtkXrOIdxSyXtmXECcN7oaf39y2eaM6n0CvD/mmLv
         oOIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnp4SaeNvB1IAls58a2NPzJ7ihy49n6g3m5I8uRHUYX+ddRz8w19LYg5n9pqCWi1/Y4TIjrD4iMKb3r2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU0Y+ODmECww5tG64Mgx04SXLyLlJd5mermJulLVgTTizJQQqL
	pq4I1nirWa3/mWkEwWz0WCgesgHrCKwHxm7ouhlCHNUeg0/hDwLj1HB75Tfg3RXdvtfGvDwHmHP
	1iuVGgA==
X-Google-Smtp-Source: AGHT+IF5F3WIQ14BvXYYKK8coAqeR7NqeKnM/sNLJDk+1DZxPsJu3iO33ShTmyn79EL/jVws/rkPw3b2Mhs=
X-Received: from pjvi5.prod.google.com ([2002:a17:90a:dc05:b0:329:ccdd:e725])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f647:b0:269:aba9:ffd7
 with SMTP id d9443c01a7336-28d1713873fmr61157175ad.25.1759260586135; Tue, 30
 Sep 2025 12:29:46 -0700 (PDT)
Date: Tue, 30 Sep 2025 12:29:44 -0700
In-Reply-To: <aNwgyhZO0BXQVExn@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250825155203.71989-1-sebott@redhat.com> <aKy-9eby1OS38uqM@google.com>
 <87zfbnyvk9.wl-maz@kernel.org> <aKzRgp58vU6h02n6@google.com>
 <aKzX152737nAo479@linux.dev> <aK4CJnNxB6omPufp@google.com>
 <aK4J5EA10ufKJZsU@linux.dev> <aK4cAPeGgy0kXY98@google.com>
 <aNvzy5-lj3TBLT3I@google.com> <aNwgyhZO0BXQVExn@linux.dev>
Message-ID: <aNwvqAEZG9ustuDo@google.com>
Subject: Re: [PATCH] KVM: selftests: fix irqfd_test on arm64
From: Sean Christopherson <seanjc@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, Sebastian Ott <sebott@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 30, 2025, Oliver Upton wrote:
> On Tue, Sep 30, 2025 at 08:14:19AM -0700, Sean Christopherson wrote:
> > > What about providing an API to do exactly that, instantiate and initialize a
> > > barebones GIC?  E.g.
> > > 
> > > 	void kvm_arch_init_barebones_irqchip(struct kvm_vm *vm)
> > > 
> > > Hmm, then we'd also need
> > > 
> > > 	void kvm_arch_vm_free(struct kvm_vm *vm)
> > > 
> > > to gracefully free the GIC, as done by dirty_log_perf_test.c.  Blech.  Though
> > > maybe we'll end up with that hook sooner or later?
> > > 
> > > All in all, I have no strong preference at this point.
> > 
> > Oliver, any thoughts?  This is causing noise in people's CIs, i.e. we should land
> > a fix sooner than later, even if it's not the "final" form. 
> 
> The lack of a default VGICv3 wound up getting in my way with some
> changes to promote selftests to run in VHE EL2, cc'ed you on that series
> since I wound up walking back my gripes here :)
> 
>   https://lore.kernel.org/kvmarm/20250917212044.294760-1-oliver.upton@linux.dev

Hah!  I saw the series but didn't read the cover letter. :-)

> That's now in Paolo's tree as of this morning. With that said, I think
> irqfd_test needs a bit more attention (below).
> 
> Thanks,
> Oliver
> 
> >From 4d0a035fb7e6cead74af4edb24fbcfdec076d321 Mon Sep 17 00:00:00 2001
> From: Oliver Upton <oliver.upton@linux.dev>
> Date: Tue, 30 Sep 2025 10:53:14 -0700
> Subject: [PATCH] KVM: selftests: Fix irqfd_test for non-x86 architectures
> 
> The KVM_IRQFD ioctl fails if no irqchip is present in-kernel, which
> isn't too surprising as there's not much KVM can do for an IRQ if it
> cannot resolve a destination.
> 
> As written the irqfd_test assumes that a 'default' VM created in
> selftests has an in-kernel irqchip created implicitly. That may be the
> case on x86 but it isn't necessarily true on other architectures.
> 
> Add an arch predicate indicating if 'default' VMs get an irqchip and
> make the irqfd_test depend on it. Work around arm64 VGIC initialization
> requirements by using vm_create_with_one_vcpu(), ignoring the created
> vCPU as it isn't used for the test.
> 
> Fixes: 7e9b231c402a ("KVM: selftests: Add a KVM_IRQFD test to verify uniqueness requirements")

Reported-by: Sebastian Ott <sebott@redhat.com>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>

Acked-by: Sean Christopherson <seanjc@google.com>

