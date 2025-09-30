Return-Path: <linux-kernel+bounces-837851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F69ABADB1F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8F13A8823
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B658E3081C2;
	Tue, 30 Sep 2025 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k60fs4bf"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585083081A9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759245263; cv=none; b=BuWfJ/UTzjF4nZwaRLyxEr/KaMCedU37WHK7eq6X8WMHMrEoou0bXftqReBUi2qcHVr+gJFN7gVOJr3cWxPLNsatealG/BSaDsDKR1zjhREE8F7vUoDD/mODQIE1TsaRM+z1Toj377YtG89aBTtWsgNxvqfo6WunGP8fT3YZgNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759245263; c=relaxed/simple;
	bh=F2Pg/8PlsKKDveTJhSAGQt0MF4T4X1RzRHH7BD2p+5c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W83zEtXscHSi3RL5h1Wz1zkRFJHtsH//VDVomDjFurKZQsdNbzOHAtx5TRcsdTd4ikldfliLTtQX9bUx0q8Aq5g1z/9yHLN1qovpLYxreuRoEQ51nSUCS6VSy8IdDNnpgHZZ5rBMOSVLAWbLDM02PYn0WECIdL2RWYUHRjJ16rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k60fs4bf; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-28bd8b3fa67so22522695ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759245261; x=1759850061; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9rncmOGQUGwo1DfmFhY7VVo4DMzXg+cQESVF65y7v48=;
        b=k60fs4bfXvcvpT3TraGfHwSK/O6TARgmcMNpyvPJPdRMf5x4lkaw0nWEO6LYsI4T6X
         xxyFBoQT6oURkKY5n8Q/64DWUhK0JuUjY5Bk1vLw4Rm3JeALe9kQ2VVZCsK1IT75nHgc
         3xVquIKNZV2+K8G21N+ydk/FWUJ67xSbfmMos6kNb+u5ItxPyQz6ZdeQH2JdQak3VlE4
         Y2dIOC+zhegcytxJRMP1jpIJA/OJdccA62sTW/Sb4mlXuV3OKQjJYriPZ9DFT5Kd2JOX
         Rg47aTCsAOOPdWUCmixFNBGyhUQYlF6jAcEwLzlbpuQRKvbXtniP3xSUpVLExy3+zrgv
         +EwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759245261; x=1759850061;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9rncmOGQUGwo1DfmFhY7VVo4DMzXg+cQESVF65y7v48=;
        b=WvQ7mKATIoIiFLWDmEHmQ62u1cFpiyr7hfO6PHopN5XZUOt0GY8zX8xCq8T2Q9Mfb/
         fh1B23oRq55ssUNYMgOC/aSOEkjylRGPblTUG8EfQvpOYRotjAxyuKn1r3Giq5os6EPr
         wOxfEfdyYIoMBITGoD0oq2Q+fy9OlOulmkRDF2MJsYszogR8BgT3usUuB9Um8EcWS6EG
         qsx8BK71sDmsXXp7thTkhCySuzwR25cdZTWydaMgx8gFKVzGGOE3WoruOLa0GOfFP6/a
         XqxW41yAXvgh7PlH4J/9RjXg2uejWGxDXmz/m+jpufeAuyN7JuSq63cwZMgaid7l7pHN
         HnBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb+MRwHaanbLSOpgWyqQSJafhgRcEQKKBp8VxXpmfoRAqZ0983GtAvoxU6UQDltSJU+qgte/HKXcxkMpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFXrsN4qIZQ7pDcrz9yxmHZ++0m3UG5mLnlFxDgxoXJ6y2dzo9
	bWiTjIoAeQqggktwdujFfNnc1hd3L91q9hIWuts+pCLvrz/VReAGqQvDbhKJXrggTZEosmct+Ob
	w/XD81Q==
X-Google-Smtp-Source: AGHT+IHQg6BTPI7i+AA/h/5N2kHeRUWEdP58zEE6EeWucPxFQt666vw4B3U2LZ7e4nNYE+79vfzOKIe7mTg=
X-Received: from plei20.prod.google.com ([2002:a17:902:e494:b0:268:cfa:6a80])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c2f:b0:267:cdb8:c683
 with SMTP id d9443c01a7336-28e7f2dcbb3mr1325795ad.27.1759245260716; Tue, 30
 Sep 2025 08:14:20 -0700 (PDT)
Date: Tue, 30 Sep 2025 08:14:19 -0700
In-Reply-To: <aK4cAPeGgy0kXY98@google.com>
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
Message-ID: <aNvzy5-lj3TBLT3I@google.com>
Subject: Re: [PATCH] KVM: selftests: fix irqfd_test on arm64
From: Sean Christopherson <seanjc@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, Sebastian Ott <sebott@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="us-ascii"

+Naresh

On Tue, Aug 26, 2025, Sean Christopherson wrote:
> On Tue, Aug 26, 2025, Oliver Upton wrote:
> > On Tue, Aug 26, 2025 at 11:51:18AM -0700, Sean Christopherson wrote:
> > > On Mon, Aug 25, 2025, Oliver Upton wrote:
> > > > The majority of selftests don't even need an irqchip anyway.
> > > 
> > > But it's really, really nice for developers if they can assume a certain level of
> > > configuration is done by the infrastructure, i.e. don't have worry about doing
> > > what is effectively "basic" VM setup.
> > 
> > The more we pile behind what a "basic" VM configuration is the less
> > expressive the tests become. Being able to immediately grok the *intent*
> > of a test from reading it first pass is a very good thing. Otherwise I
> > need to go figure out what the definition of "basic" means when I need
> > to write a test and decide if that is compatible with what I'm trying to
> > do.
> 
> Eh, I don't buy that argument, not as a blanket statement.
> 
> The existence of code doesn't always communicate intent, e.g. the _only_ instance
> I can think of where doing more setup by default caused problems was a few crusty
> x86 tests that relied on an int3 to cause SHUTDOWN due to lack of an IDT.  OMG was
> I increduluous when I figured out what those tests were doing.
> 
> And in that case, _not_ doing the "basic" setup hid the intent of the test.  Aside
> from the fact that deliberately triggering SHUTDOWN was completely unnecessary in
> those tests, IMO forcing such a test to use vm_create_barebones() would better
> capture that the test is doing something odd, i.e. has unusual intent.
> 
> And explicitly doing something doesn't necessarily communicate the intent of the
> test.  E.g. the intent of the irqfd_test is to verify that KVM_IRQFD assign and
> deassign behaves as expected.  The test never generates IRQs, i.e. doesn't actually
> need an IRQCHIP beyond satisfying KVM's requirements for KVM_IRQFD.
> 
> There are undoubtedly other tests that have similar "intent".  E.g. the in-progress
> mediated PMU support for x86 requires an in-kernel local APIC, and so tests like
> pmu_counters_test.c, pmu_event_filter_test.c, and vmx_pmu_caps_test.c will need
> to instantiate an IRQCHIP.  None of those tests actually touch the local APIC in
> any way, e.g. don't generate PMU interrupts, so creating an IRQCHIP is once again
> nothing more than a means to an end, and not indicative of the test's main intent.
> 
> I think the use of vgic_v3_setup() in dirty_log_perf_test.c is also a case where
> the existence of code fails to communicate intent.  Without the comment in
> arch_setup_vm() to explain that having GICv3 somehow reduces the number of exits,
> I would be very confused as to why the test cares about GICv3.
> 
> I agree there's a balance to be had in terms of doing too much.  Unfortunately in
> this case, it sounds like the fundamental problem is that the balance is simply
> different for x86 versus arm64.  Having an in-kernel local APIC is tables stakes
> for x86, to the point where I'm looking for any excuse to have KVM create a local
> APIC by default.  But for arm64, there's tremendous value in having tests do the
> lifting.
> 
> > vm_create_with_irqchip() is delightfully unambiguous.
> >
> > > E.g. x86 selftests creates an IRQCHIP, sets up descriptor tables and exception
> > > handlers, and a handful of other "basic" things, and that has eliminated soooo
> > > much boilerplate code and the associated friction with having to know/discover
> > > that e.g. sending IRQs in a test requires additional setup beyond the obvious
> > > steps like wiring up a handler.
> > 
> > That simply isn't going to happen on arm64. On top of the fact that the
> > irqchip configuration depends on the intent of the test (e.g. wired IRQs
> > v. MSIs), there's a bunch of guest-side initialization that needs to
> > happen too.
> > 
> > We can add an extremely barebones GIC when asked for (although guest
> > init isn't addressed) but batteries are not included on this architecture
> > and I'd rather not attempt to abstract that.
> 
> What about providing an API to do exactly that, instantiate and initialize a
> barebones GIC?  E.g.
> 
> 	void kvm_arch_init_barebones_irqchip(struct kvm_vm *vm)
> 
> Hmm, then we'd also need
> 
> 	void kvm_arch_vm_free(struct kvm_vm *vm)
> 
> to gracefully free the GIC, as done by dirty_log_perf_test.c.  Blech.  Though
> maybe we'll end up with that hook sooner or later?
> 
> All in all, I have no strong preference at this point.

Oliver, any thoughts?  This is causing noise in people's CIs, i.e. we should land
a fix sooner than later, even if it's not the "final" form. 

