Return-Path: <linux-kernel+bounces-837920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F46BAE0EA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 687C64E259E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BB523ABAF;
	Tue, 30 Sep 2025 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ear9hBDB"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957321EE02F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759250065; cv=none; b=s6sFNse/zMKxztVTLSCPUjwlsJthYQGeA6gA5HyM8hlop0HUp4FoypmQF48Q8knDTQRRb3MdmpCdlSJCRP5uWim8w+U2xsXxlYZKsJIy8RpB2/0cUr4I+FEP1n4G09kmkGfVTBpebxC8SyIBNIXaKB1SCNCjliayqA3jQIptcGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759250065; c=relaxed/simple;
	bh=TzPIt5QqZ/ncsUjXjePi75S8DUEZ/jVmGu8XXDEiJAM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VGSbKkQZ8MJFM8KZAjLWOtX4L8EtYcjp+2U7yQ7I+bWfmnK6cBAM10uvRI1gwdSqhluTEH6lJ9S1DQa+hUwI8GJLSm7Kdv45nm4hmeiQGigWC2t0seBajLAMlxf4+ORSPOZYXG4VHg+e4hkAi1pva0exh0W2E3ijB4SIxmocPCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ear9hBDB; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b5527f0d39bso8431513a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 09:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759250062; x=1759854862; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ts11PRKQJbECWFlSkrZaC2Cq1Up8eQN07d9pIiZQ+5k=;
        b=ear9hBDBT0q689TC9nk/l4JP1uGm4eoDjqdTuu4nGAprd8u8bMqkYLzLQJBOMdNWqU
         uVWNFTVhql+FzfgJhGY1x/8Z3SOppUfik63zYukLIyBnDRNomX80lIXO/+hGiYbV43j6
         rZSQ8uUiKPAMRZpvNpqKNhOH4U07YdkJ+npv1hKKQPT2WCon6+aMTYmUf8PWUMt7bBz0
         QJ8ipq1fBbt/IYt2hOjZ8dWHnMBFi2FKh9NrDmcQXbnYUiSNFmjDJnofBzUT7yl9h6PW
         TrmccK2AGV/g1EvES9i3c3oXZifPNrz4OnaHl4MiaXHoem1pef5n3VeS2D48RFWXk3Ob
         wj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759250062; x=1759854862;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ts11PRKQJbECWFlSkrZaC2Cq1Up8eQN07d9pIiZQ+5k=;
        b=a7/m2yzQSHk5gD9Z/ituIViuZjMVl5jEQO65VBBDTZyO7sGmRz6BhmM9INIbH0lmKc
         eDfJNCboZi38aIiiINUGYqJPx5pOjEyposZprtaPlWJDvvdk+KWQyQtE2U60PemVn7SQ
         6BsNbJLcZTyFO9LzU5ce0Oz8X/+2rRzQD3X0Tj7Xq4gK4/OlwyYATlBrmzuYAqvWOJK2
         YFU2o3ZxzZPX83QZGKgiGYLQaAxsLmA1PViX93bfAFLUsghVoeKV+YipPa8er7Lc5Lwx
         F6Hm4qHvIM5UXjmEvIgY+O02slQsd1zGfFcNoZkYH8Q8VSVA0qqGBMu9/vKyvQvCjo9f
         heSg==
X-Forwarded-Encrypted: i=1; AJvYcCV8oBlBLU/A67x6dLaktC41lcaDV5PIVkzZRtCl1thM1l8VaDfDJFO0KlY8HMgxO3FRaN4U3EbSMvJYMno=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu3kMzLZR14jkMXsL2/Jej6Wb+z30ZK4rX0oNjmdjDnlxeqLmX
	rD+FtAIAOtfxFWW1fFbNaheSTVQEn/8Vyhn0qPmiH4W9Z8AMryIQGgT0CdbSNnqmTTfKKCwc5xi
	NbqpZug==
X-Google-Smtp-Source: AGHT+IFX4CBMrBfFxnkGRFgOYRHXTZmNWaYLzdc89aJiDnP/g8eaLWlThAkjYKzlvZmnAhY1DXZxav01xFw=
X-Received: from pjzg20.prod.google.com ([2002:a17:90a:e594:b0:339:9a75:1b1e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:38cb:b0:338:3dca:e0a3
 with SMTP id 98e67ed59e1d1-339a6ec7e16mr119884a91.16.1759250061911; Tue, 30
 Sep 2025 09:34:21 -0700 (PDT)
Date: Tue, 30 Sep 2025 09:34:20 -0700
In-Reply-To: <aNwFTLM3yt6AGAzd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919214259.1584273-1-seanjc@google.com> <aNvLkRZCZ1ckPhFa@yzhao56-desk.sh.intel.com>
 <aNvT8s01Q5Cr3wAq@yzhao56-desk.sh.intel.com> <aNwFTLM3yt6AGAzd@google.com>
Message-ID: <aNwGjIoNRGZL3_Qr@google.com>
Subject: Re: [PATCH] KVM: x86: Drop "cache" from user return MSR setter that
 skips WRMSR
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 30, 2025, Sean Christopherson wrote:
> On Tue, Sep 30, 2025, Yan Zhao wrote:
> > On Tue, Sep 30, 2025 at 08:22:41PM +0800, Yan Zhao wrote:
> > > On Fri, Sep 19, 2025 at 02:42:59PM -0700, Sean Christopherson wrote:
> > > > Rename kvm_user_return_msr_update_cache() to __kvm_set_user_return_msr()
> > > > and use the helper kvm_set_user_return_msr() to make it obvious that the
> > > > double-underscores version is doing a subset of the work of the "full"
> > > > setter.
> > > > 
> > > > While the function does indeed update a cache, the nomenclature becomes
> > > > slightly misleading when adding a getter[1], as the current value isn't
> > > > _just_ the cached value, it's also the value that's currently loaded in
> > > > hardware.
> > > Nit:
> > > 
> > > For TDX, "it's also the value that's currently loaded in hardware" is not true.
> > since tdx module invokes wrmsr()s before each exit to VMM, while KVM only
> > invokes __kvm_set_user_return_msr() in tdx_vcpu_put().
> 
> No?  kvm_user_return_msr_update_cache() is passed the value that's currently
> loaded in hardware, by way of the TDX-Module zeroing some MSRs on TD-Exit.
> 
> Ah, I suspect you're calling out that the cache can be stale.  Maybe this?
> 
>   While the function does indeed update a cache, the nomenclature becomes
>   slightly misleading when adding a getter[1], as the current value isn't
>   _just_ the cached value, it's also the value that's currently loaded in
>   hardware (ignoring that the cache holds stale data until the vCPU is put,
>   i.e. until KVM prepares to switch back to the host).
> 
> Actually, that's a bug waiting to happen when the getter comes along.  Rather
> than document the potential pitfall, what about adding a prep patch to mimize
> the window?  Then _this_ patch shouldn't need the caveat about the cache being
> stale.

Ha!  It's technically a bug fix.  Because a forced shutdown will invoke
kvm_shutdown() without waiting for tasks to exit, and so the on_each_cpu() calls
to kvm_disable_virtualization_cpu() can call kvm_on_user_return() and thus
consume a stale values->curr.

