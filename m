Return-Path: <linux-kernel+bounces-725767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3614CB003AE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F395E5471D9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0357265CA0;
	Thu, 10 Jul 2025 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z1FVPxqw"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59E326463E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154461; cv=none; b=hotaBwtHrwT9Pw9CC69wWjBuavsO+RY/b680T93HYt0Ow/j4e95cz0EhMlI9pcNoTrxllCKDXKjJ06aV/S+6HoX6/Akw5d3ZXiOImvnp1Zcf6aEYn3MGU3j4klmhAxV19kbA7bJ7U9+a+WF8qKpKAJq9cT5qyjXOs7T05Xdjz5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154461; c=relaxed/simple;
	bh=PdnAmJI/ibMqf5UpOzfaxAEl/qpkrqa532gIvvDVcpM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iC8OUGv83Ed6WTj0tJb7CzhbysEplxIX2VG6W5xwlZ2qasPPQTeKBtBuvNAq1TqYxuT4EsszWQ5Sw6Hvz0XUu5ja7EY3/xsAHi8Lp+E6qgDstX44naT2rdAeThHuBKA7sIOu9sJsm0rS92bZkAmBQCUvzTuNI/aSzpGTCN7+RaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z1FVPxqw; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748b4d5c045so1043505b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 06:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752154457; x=1752759257; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wr3J+RHblG5GJaM0j5JuIylNt4iRFZX8BEhZw6kzZM4=;
        b=z1FVPxqwrNaV2BBJYvZLJjwV37OOefCjESZxdpighHDipB39hacMw/RI1wFGYy0ZM1
         O/H0cvbbqATu/BcsfSIhrgeQme/M14d6v8IYZp68VM7sVJ1rnWa8NDNeedUAWOKaYAhP
         6pc7DCuLn2lVKvRVSp4fEH6iejlyOqJZdtGvNMUx30SLDnLb28mOCNIKrvqnr73vsGag
         w4sbaM3NvLJMi6x1uaogGg4lwf4ARl3e9bU3M5usM17xE8LTqJQGt0qsmyUo6tViA0BL
         bH8nE7F1/mSs4HWLr8xVCAXZVNyPCQ5hTT4Y9BAIjCZoalk4vC+/iKl1PjmfW2KT9vYJ
         V+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752154457; x=1752759257;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wr3J+RHblG5GJaM0j5JuIylNt4iRFZX8BEhZw6kzZM4=;
        b=gjvz9B9WJhelAnOuc7gttcI9RyUVmCPPU8n+yHN1ZKJfksUtirH2TrhNm0nEd1I8Hs
         h67pvgNSzfsPQ+cQEu2lldbDsyw3kCcKVW0UVQ1305MP5vihqQsOJ4THXhKPEcNQXyua
         Gk8JVY9squArmG1OjyoheYlTw8imxpkMU0W+8RmYqJMsb7+TFVBmphUM/bgZswRwcYH/
         x43ZmOz6mzcB0PTqOJbag2T0lX3hsCRT3gKCgLt5mtgQBR/7s0hisiErDGAO4dl7jZnu
         W4P9C2gjnClmrwgh21sLL5Vao16HIg23Z+nMwPR1qdr8YVSi/gk/FTncZSkZEY4Kz3Sv
         X8UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWsJWEPmmvYFIZinPSbvNIyFcrFYKeIZcvBfQ5skDp1035yRRwI2h8TuONZW2OM0tdfZajlX+auZxsiEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynzs27kfKU5P65FxjLPgAMw2cpBpYlGCeKa+rcE86izRv09lOi
	TNOGmxJud9IQSZaewRTsaDwU3H8JbIHzVMoI8paWCV6K2F/leyt1tN788IcTKwIxZx4iosDexr5
	8DG5QVA==
X-Google-Smtp-Source: AGHT+IGSaHIBRoN/S9txevmPNNTrr4Q5vAkgijLk90fjXn6DImx6okraCPXWwkAGxJiWt5+DBd6m7A0lCUs=
X-Received: from pfbil5.prod.google.com ([2002:a05:6a00:8d45:b0:748:2476:b25f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1789:b0:742:a91d:b2f6
 with SMTP id d2e1a72fcca58-74eb8f7c144mr4500112b3a.13.1752154457032; Thu, 10
 Jul 2025 06:34:17 -0700 (PDT)
Date: Thu, 10 Jul 2025 06:34:15 -0700
In-Reply-To: <aG9i5BHDHRlFRFnb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250624092256.1105524-1-keirf@google.com> <20250624092256.1105524-4-keirf@google.com>
 <aFrANSe6fJOfMpOC@google.com> <aGJf7v9EQoEZiQUk@google.com>
 <aGwWvp_JeWe9tIJx@google.com> <aG9i5BHDHRlFRFnb@google.com>
Message-ID: <aG_BV_tKzqktRlOA@google.com>
Subject: Re: [PATCH 3/3] KVM: Avoid synchronize_srcu() in kvm_io_bus_register_dev()
From: Sean Christopherson <seanjc@google.com>
To: Keir Fraser <keirf@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Li RongQing <lirongqing@baidu.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 10, 2025, Keir Fraser wrote:
> On Mon, Jul 07, 2025 at 11:49:34AM -0700, Sean Christopherson wrote:
> Would it be satisfactory to put a patch along the lines of your
> suggestions below into a v2 of this patch series?

Ya, works for me.

> I have made some comments below.
> 
> > 
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index 4953846cb30d..057fb4ce66b0 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -5861,6 +5861,9 @@ static int handle_invalid_guest_state(struct kvm_vcpu *vcpu)
> >                 if (kvm_test_request(KVM_REQ_EVENT, vcpu))
> >                         return 1;
> >  
> > +               /* Or maybe smp_mb()?  Not sure what this needs to be. */
> > +               barrier();
> > +
> 
> Looks weak but maybe strong enough for x86? Maybe smp_rmb() would be better
> statement of intention?

Hmm, yeah, smp_rmb() is better.  I was thinking it just needs to be a compiler
barrier, to ensure KVM reads kvm->buses as needed for each emulated instruction.
But ignoring that x86 is strongly ordered, KVM also needs to ensure a store to
kvm->buses that is supposed to be observed by the next guest instruction is fully
visibile before that instruction executes.

> 
> >                 if (!kvm_emulate_instruction(vcpu, 0))
> >                         return 0;
> >  

...

> I guess kvm_io_bus_read() is to be done as well? Perhaps the barrier
> and dereference should be pulled into a helper with the comment, just
> in one place?

Ya, +1 to a helper.

