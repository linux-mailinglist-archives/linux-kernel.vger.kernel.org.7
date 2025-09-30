Return-Path: <linux-kernel+bounces-837837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F99BAD668
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FFB31942728
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED02305964;
	Tue, 30 Sep 2025 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QJCf05Z6"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2E4199939
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244299; cv=none; b=SljWOl/zFIC+Q/+81ad9DGscivdG559JYmpGK/Hyn20svBcPczJWblQZvZ1kEam0hLkJSqvS6ZiYuH0EPLLTeEiyU1ag4IgSLUR1h0tQ1S27n3nc0g56qUjh2PwVwisF8aoj+t6xjy3qpV07ZmMKs2PY+7WTUBXMDPhlkYLtx9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244299; c=relaxed/simple;
	bh=BAZpClejLbE/TaGhph3A+ZJPzB3IeFvn8SYUvadWRF8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i3KPJfUBvyCoVDXzTq/rvPlLTOyyoyn3bQi9G1wTQKIldYhUvfJt7rSYGnlLqgz3zuaqdRy2eOzj2URYrfEOXdFIt06fly1MWOLjRZbWuDf7KyxA8OeXeK42P+LqSuRv5CKXwPapnxtgEjcsoNGkQFaJMsu6QX8FwYDjFPWKlkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QJCf05Z6; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3324538ceb0so9543188a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759244296; x=1759849096; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RZdEeuIZmBzDLZbYs/yNXlSKEGLonVMQ6j0Z4GNNa5k=;
        b=QJCf05Z6PViXx6nerJSw9REqTGuRtQ8+OHJTAXCsV9PrRXPHIgL3XBUKYQJq2N+Hz+
         9N+w/aeXtbjIQ5kfcczYqgUc6YJbuE15TSfX6lnv56O8XQJPNw48QWITW2PXLAsbsn8e
         YTPzrDT3tRRsZ1itqQdRilBPp2AyOONcyilaarUkUPqGgZxtBL4SeKtYb46qkU3/xtkq
         sgPq5YB/1qHWm1oRscoijeW/Ge7y7sy6yaLPimrS0XLtLvXopdkh5P69HupioEDgS9oj
         a74ymHqvzHORJwNfqX1pXR3+gNfVk3KfdoQESZmpfH1gsHSKqSLgghOwM+qz6Eqrvzdp
         lTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759244296; x=1759849096;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZdEeuIZmBzDLZbYs/yNXlSKEGLonVMQ6j0Z4GNNa5k=;
        b=OpzSFxHUfutHJjfEV0PXXRe7M4aPVjIxK/TfcIYsv36lffR5EE6k1oOI5w/hnfx3mq
         ciq11nLEzsfRc0TdUvUtDTbXSX0xGDGo6T1oraBuNbXGvVk8Yb/yGhbVwp6bSKuDHE7+
         IXTuxEOFgaG0GVDsM/pMK8L5YTEdrczlWPUpGYih1W7KgmXHkby37p3sz6z7os2u+I0g
         oDu4LoNzVoVMBYyD3ZsrxHCKA/l/3NRRtWqV1q203VWBmfZuTBEArcL0Cwr1OaV+3gLm
         kW2PIlO5h43Vg3qHoYPsSk7LGGyUZtrxITwPyplaM0yqyuFQ7M69IUE00Ws5ccCFjnrf
         kJeA==
X-Forwarded-Encrypted: i=1; AJvYcCWeUemQUt3/elOdIjIZ5nUBf7PNlxH4ac6s9+BoZHuZnGmO0iWqgL8VwMPp96jmZQQexiGbJ8EDA0LK7XA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO0gO70a7Kk/8bs8VwNODJM1gjiOHjMmgQF2bR0TOg9LAEIw1r
	azk7AVcX5XSizg2XSaYCV//y2Yx/PDdC4qQ3hahO3DdOPeF92alYbi5ZJkD83IjWuUy8iqRFVh0
	TvHH3ug==
X-Google-Smtp-Source: AGHT+IETSMM9ujw5b0glTdu6eKbkhEayF+u6JJrEpWt0cq5tgvyVGupQAvG78QacKBP/NJlodlJGlJsgdyU=
X-Received: from pjsa23.prod.google.com ([2002:a17:90a:be17:b0:330:523b:2b23])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b4f:b0:335:5e84:6d37
 with SMTP id 98e67ed59e1d1-3355e846e68mr16804530a91.6.1759244296622; Tue, 30
 Sep 2025 07:58:16 -0700 (PDT)
Date: Tue, 30 Sep 2025 07:58:15 -0700
In-Reply-To: <diqza52c1im6.fsf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250926163114.2626257-1-seanjc@google.com> <20250926163114.2626257-7-seanjc@google.com>
 <diqzldlx1fyk.fsf@google.com> <aNrLpkrbnwVSaQGX@google.com> <diqza52c1im6.fsf@google.com>
Message-ID: <aNvwB2fr2p45hhC0@google.com>
Subject: Re: [PATCH 6/6] KVM: selftests: Verify that faulting in private
 guest_memfd memory fails
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 30, 2025, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> > How's this look?
> >
> > static void test_fault_sigbus(int fd, size_t accessible_size, size_t mmap_size)
> > {
> > 	struct sigaction sa_old, sa_new = {
> > 		.sa_handler = fault_sigbus_handler,
> > 	};
> > 	const uint8_t val = 0xaa;
> > 	uint8_t *mem;
> > 	size_t i;
> >
> > 	mem = kvm_mmap(mmap_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd);
> >
> > 	sigaction(SIGBUS, &sa_new, &sa_old);
> > 	if (sigsetjmp(jmpbuf, 1) == 0) {
> > 		memset(mem, val, mmap_size);
> > 		TEST_FAIL("memset() should have triggered SIGBUS");
> > 	}
> > 	if (sigsetjmp(jmpbuf, 1) == 0) {
> > 		(void)READ_ONCE(mem[accessible_size]);
> > 		TEST_FAIL("load at first unaccessible byte should have triggered SIGBUS");
> > 	}
> > 	sigaction(SIGBUS, &sa_old, NULL);
> >
> > 	for (i = 0; i < accessible_size; i++)
> > 		TEST_ASSERT_EQ(READ_ONCE(mem[i]), val);
> >
> > 	kvm_munmap(mem, mmap_size);
> > }
> >
> > static void test_fault_overflow(int fd, size_t total_size)
> > {
> > 	test_fault_sigbus(fd, total_size, total_size * 4);
> > }
> >
> 
> Is it intentional that the same SIGBUS on offset mem + total_size is
> triggered twice? The memset would have worked fine until offset mem +
> total_size, which is the same SIGBUS case as mem[accessible_size]. Or
> was it meant to test that both read and write trigger SIGBUS?

The latter (test both read and write).  I plan on adding this in a separate
commit, i.e. it should be obvious in the actual patches.

> > static void test_fault_private(int fd, size_t total_size)
> > {
> > 	test_fault_sigbus(fd, 0, total_size);
> > }
> >
> 
> I would prefer more unrolling to avoid mental hoops within test code,
> perhaps like (not compile tested):
> 
> static void assert_host_fault_sigbus(uint8_t *mem) 
> {
>  	struct sigaction sa_old, sa_new = {
>  		.sa_handler = fault_sigbus_handler,
>  	};
> 
>  	sigaction(SIGBUS, &sa_new, &sa_old);
>  	if (sigsetjmp(jmpbuf, 1) == 0) {
>  		(void)READ_ONCE(*mem);
>  		TEST_FAIL("Reading %p should have triggered SIGBUS", mem);
>  	}
>         sigaction(SIGBUS, &sa_old, NULL);
> }
> 
> static void test_fault_overflow(int fd, size_t total_size)
> {
> 	uint8_t *mem = kvm_mmap(total_size * 2, PROT_READ | PROT_WRITE, MAP_SHARED, fd);
>         int i;
> 
>  	for (i = 0; i < total_size; i++)
>  		TEST_ASSERT_EQ(READ_ONCE(mem[i]), val);
> 
>         assert_host_fault_sigbus(mem + total_size);
> 
>         kvm_munmap(mem, mmap_size);
> }
> 
> static void test_fault_private(int fd, size_t total_size)
> {
> 	uint8_t *mem = kvm_mmap(total_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd);
>         int i;
> 
>         assert_host_fault_sigbus(mem);
> 
>         kvm_munmap(mem, mmap_size);
> }

Why?  That loses coverage for read to private memory getting SIBUGS.  I genuinely
don't understand the desire to copy+paste uninteresting code.

> assert_host_fault_sigbus() can then be flexibly reused for conversion

assert_host_fault_sigbus() is a misleading name in the sense that it suggests
that the _only_ thing the helper does is assert that a SIGBUS occurred.  It's
not at all obvious that there's a write to "mem" in there.

> tests (coming up) at various offsets from the mmap()-ed addresses.
> 
> At some point, sigaction, sigsetjmp, etc could perhaps even be further
> wrapped. For testing memory_failure() for guest_memfd we will want to
> check for SIGBUS on memory failure injection instead of on host fault.
> 
> Would be nice if it looked like this (maybe not in this patch series):
> 
> + TEST_ASSERT_WILL_SIGBUS(READ_ONCE(mem[i]))
> + TEST_ASSERT_WILL_SIGBUS(WRITE_ONCE(mem[i]))
> + TEST_ASSERT_WILL_SIGBUS(madvise(MADV_HWPOISON))

Ooh, me likey.  Definitely can do it now.  Using a macro means we can print out
the actual action that didn't generate a SIGUBS, e.g. hacking the test to read
byte 0 generates:

	'(void)READ_ONCE(mem[0])' should have triggered SIGBUS

Hmm, how about TEST_EXPECT_SIGBUS?  TEST_ASSERT_xxx() typically asserts on a
value, i.e. on the result of a previous action.  And s/WILL/EXPECT to make it
clear that the action is expected to SIGBUS _now_.

And if we use a descriptive global variable, we can extract the macro to e.g.
test_util.h or kvm_util.h (not sure we want to do that right away; probably best
left to the future).

static sigjmp_buf expect_sigbus_jmpbuf;
void fault_sigbus_handler(int signum)
{
	siglongjmp(expect_sigbus_jmpbuf, 1);
}

#define TEST_EXPECT_SIGBUS(action)						\
do {										\
	struct sigaction sa_old, sa_new = {					\
		.sa_handler = fault_sigbus_handler,				\
	};									\
										\
	sigaction(SIGBUS, &sa_new, &sa_old);					\
	if (sigsetjmp(expect_sigbus_jmpbuf, 1) == 0) {				\
		action;								\
		TEST_FAIL("'%s' should have triggered SIGBUS", #action);	\
	}									\
	sigaction(SIGBUS, &sa_old, NULL);					\
} while (0)

static void test_fault_sigbus(int fd, size_t accessible_size, size_t map_size)
{
	const char val = 0xaa;
	char *mem;
	size_t i;

	mem = kvm_mmap(map_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd);

	TEST_EXPECT_SIGBUS(memset(mem, val, map_size));
	TEST_EXPECT_SIGBUS((void)READ_ONCE(mem[accessible_size]));

	for (i = 0; i < accessible_size; i++)
		TEST_ASSERT_EQ(READ_ONCE(mem[i]), val);

	kvm_munmap(mem, map_size);
}

> >> If split up as described above, this could be
> >> 
> >> 	if (flags & GUEST_MEMFD_FLAG_MMAP &&
> >> 	    flags & GUEST_MEMFD_FLAG_DEFAULT_SHARED) {
> >> 		gmem_test(mmap_supported_fault_supported, vm, flags);
> >> 		gmem_test(fault_overflow, vm, flags);
> >> 	} else if (flags & GUEST_MEMFD_FLAG_MMAP) {
> >> 		gmem_test(mmap_supported_fault_sigbus, vm, flags);
> >
> > I find these unintuitive, e.g. is this one "mmap() supported, test fault sigbus",
> > or is it "mmap(), test supported fault sigbus".  I also don't like that some of
> > the test names describe the _result_ (SIBGUS), where as others describe _what_
> > is being tested.
> >
> 
> I think of the result (SIGBUS) as part of what's being tested. So
> test_supported_fault_sigbus() is testing that mmap is supported, and
> faulting will result in a SIGBUS.

For an utility helper, e.g. test_fault_sigbus(), or test_write_sigbus(), that's
a-ok.  But it doesn't work for the top-level test functions because trying to
follow that pattern effectively prevents bundling multiple individual testcases,
e.g. test_fallocate() becomes what?  And test_invalid_punch_hole_einval() is
quite obnoxious.

> > In general, I don't like test names that describe the result, because IMO what
> > is being tested is far more interesting.  E.g. from a test coverage persective,
> > I don't care if attempting to fault in (CoCO) private memory gets SIGBUS versus
> > SIGSEGV, but I most definitely care that we have test coverage for the "what".
> >
> 
> The SIGBUS is part of the contract with userspace and that's also part
> of what's being tested IMO.

I don't disagree, but IMO bleeding those details into the top-level functions
isn't necessary.  Random developer that comes along isn't going to care whether
KVM is supposed to SIGBUS or SIGSEGV unless there is a failure.  And as above,
doing so either singles out sigbus or necessitates truly funky names.

