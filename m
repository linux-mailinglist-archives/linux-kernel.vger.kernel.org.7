Return-Path: <linux-kernel+bounces-836666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 005A5BAA421
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 20:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E7A47A3092
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 18:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788FB22A7E9;
	Mon, 29 Sep 2025 18:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LyXZcHJ3"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA02A19F13F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759169450; cv=none; b=U12fzPmn/3vhvTXeKdNftdhmMg7QHInUanQCdcFo0sqa6HYxjsXlHxjmYwpXIDslDRiDKDfJ+7QgX7tk4F6J2bNU2DIpXvjkogyoOhc8iJBO3hDa9dLqoTN6hVn5Gbm87/w+ZM5BI93YK632PoLLT491mgMsTYJvhuI+EbP2Rwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759169450; c=relaxed/simple;
	bh=hTi/1LDjxXLqAzqWGP9Nw1rFwML0IskqpYBN+kRb1b4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cPyPcAFzehYz13/9jrfxY37tIHBy40cQvKQcJwRkGsEzcfQQ7w2fYq498SkjcOZ2U2XXzcx5ggvkblyDkK7q9RPncmNoK3nD8MyuCd07TkDWFDWBUKQP8zm9czX8QRr1biBB/313Ge4NlT46TVFjox49vT98cP2RoqpD2Nbr20k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LyXZcHJ3; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-781253de15aso5385845b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759169448; x=1759774248; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c1YZoUF94m19t8ktsyL6eUQtbJ+D8OzjtqR3WKoUgkk=;
        b=LyXZcHJ3cvXtONE1XhxZ4RCBBnb23NjxvDxuZfn+N0yynEL9pRXLQPPkVp0KXVUW2K
         Om3BfnEaKH5g6QaDUii8sNkNBAgamJzxNgAdlN8gvZBewBG1Rs8IPdiZG9EYmZz5n/fe
         F3G8Ot+eDSkAjiXSQHfSI+V5ELQDfaiSgA6+74PMOo/dGPcZmeaK9549revxQW+ktIjv
         5mkM45IGLUid3+kqyGtwI6WXN0wSEd+SpWQinGMlmrPFX5QOp8Kn7cRsyNeE8wXJi93l
         7K9RfjTA5AQZrVxT0WNAc4pbdpnWAtcYcQIVkSpGDjBmjoa8da4e2HzrO7Mph9yn3/Vu
         yCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759169448; x=1759774248;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c1YZoUF94m19t8ktsyL6eUQtbJ+D8OzjtqR3WKoUgkk=;
        b=fWGg3cAWQphTOLgPfu9YMZF3Fht3G/twNZwZgxJ06E7ldR4uLLkq9gVIKWgc9MB+XE
         PXneda/Ckb33lBjGz5rmO8b3vkuXYwrCHq9jOrIPIUs4UafBS6sXtQsqBokUoMoyrcDW
         NdIJF+ywr96IzxKmUF8n/9cUcPGjz9PdDbihPBm458MlR35yvJ8T84cKJ4SuyOTcGiQM
         TW49SowrLaZmEkQgkKtYToUC8frNupZvkJe8VNbIhaGqLSDs/75o4uV3edj7L9pOUDYp
         q3YWgRYGOyThGFGQdE1diwGiAg7RfC+QgXYFdUrODulfdgS5gA/H7/qYxAwY3uz6+K2D
         dO3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkF5Cu+e/+tH8iaFrkvvs8f3bQrySfCz0zdEeN/qL9YqpwY/wz66fiKoJEno+01o/2wbdfPyCemV/I9ck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt+XFXGmKAPgFFMegHLNYvVvVlJmgY8kGHJcaLJUTcQmDMc1Bd
	EJCNgN0Qd2B6fVBfQvpB6MIbwdYH8Q+WffF/NO5dKPw1SfaF53vZvpgcaVdAzMUgtv8QgYOepus
	gjKe9Mg==
X-Google-Smtp-Source: AGHT+IE78WkBOFZpjBW8uPN1lnIxmEpEFLNS96Wf2/GXDz81pjOZfJGsUaoO1CMv0KsumeZoy8UT9eytn3s=
X-Received: from pfbhw13.prod.google.com ([2002:a05:6a00:890d:b0:771:ea87:e37d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1953:b0:783:cb49:c67b
 with SMTP id d2e1a72fcca58-783cb49c7cdmr7979337b3a.32.1759169448174; Mon, 29
 Sep 2025 11:10:48 -0700 (PDT)
Date: Mon, 29 Sep 2025 11:10:46 -0700
In-Reply-To: <diqzldlx1fyk.fsf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250926163114.2626257-1-seanjc@google.com> <20250926163114.2626257-7-seanjc@google.com>
 <diqzldlx1fyk.fsf@google.com>
Message-ID: <aNrLpkrbnwVSaQGX@google.com>
Subject: Re: [PATCH 6/6] KVM: selftests: Verify that faulting in private
 guest_memfd memory fails
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 29, 2025, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > Add a guest_memfd testcase to verify that faulting in private memory gets
> > a SIGBUS.  For now, test only the case where memory is private by default
> > since KVM doesn't yet support in-place conversion.
> >
> > Cc: Ackerley Tng <ackerleytng@google.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  .../testing/selftests/kvm/guest_memfd_test.c  | 62 ++++++++++++++-----
> >  1 file changed, 46 insertions(+), 16 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
> > index 5dd40b77dc07..b5a631aca933 100644
> > --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> > +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
> > @@ -40,17 +40,26 @@ static void test_file_read_write(int fd, size_t total_size)
> >  		    "pwrite on a guest_mem fd should fail");
> >  }
> >  
> 
> I feel that the tests should be grouped by concepts being tested
> 
> + test_cow_not_supported()
>     + mmap() should fail
> + test_mmap_supported()
>     + kvm_mmap()
>     + regular, successful accesses to offsets within the size of the fd
>     + kvm_munmap()
> + test_fault_overflow()
>     + kvm_mmap()
>     + a helper (perhaps "assert_fault_sigbus(char *mem)"?) that purely
>       tries to access beyond the size of the fd and catches SIGBUS
>     + regular, successful accesses to offsets within the size of the fd
>     + kvm_munmap()
> + test_fault_private()
>     + kvm_mmap()
>     + a helper (perhaps "assert_fault_sigbus(char *mem)"?) that purely
>       tries to access within the size of the fd and catches SIGBUS
>     + kvm_munmap()
> 
> I think some code duplication in tests is okay if it makes the test flow
> more obvious.

Yeah, depends on what is being duplicated, and how much.

> > -static void test_mmap_supported(int fd, size_t total_size)
> > +static void *test_mmap_common(int fd, size_t size)
> >  {
> > -	const char val = 0xaa;
> > -	char *mem;
> > -	size_t i;
> > -	int ret;
> > +	void *mem;
> >  
> > -	mem = mmap(NULL, total_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
> > +	mem = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
> >  	TEST_ASSERT(mem == MAP_FAILED, "Copy-on-write not allowed by guest_memfd.");
> >
> 
> When grouped this way, test_mmap_common() tests that MAP_PRIVATE or COW
> is not allowed twice, once in test_mmap_supported() and once in
> test_fault_sigbus(). Is that intentional?

Hmm, no?  I suspect I just lost track of what was being tested.

> > -	mem = kvm_mmap(total_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd);
> > +	mem = kvm_mmap(size, PROT_READ | PROT_WRITE, MAP_SHARED, fd);
> > +
> > +	return mem;
> 
> I feel that returning (and using) the userspace address from a test
> (test_mmap_common()) is a little hard to follow.

Agreed.  Should be easy enough to eliminate this helper.

> > -static void test_fault_overflow(int fd, size_t total_size)
> > +static void *test_fault_sigbus(int fd, size_t size)
> >  {
> >  	struct sigaction sa_old, sa_new = {
> >  		.sa_handler = fault_sigbus_handler,
> >  	};
> > -	size_t map_size = total_size * 4;
> > -	const char val = 0xaa;
> > -	char *mem;
> > -	size_t i;
> > +	void *mem;
> >  
> > -	mem = kvm_mmap(map_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd);
> > +	mem = test_mmap_common(fd, size);
> >  
> >  	sigaction(SIGBUS, &sa_new, &sa_old);
> >  	if (sigsetjmp(jmpbuf, 1) == 0) {
> > -		memset(mem, 0xaa, map_size);
> > +		memset(mem, 0xaa, size);
> >  		TEST_ASSERT(false, "memset() should have triggered SIGBUS.");
> >  	}
> >  	sigaction(SIGBUS, &sa_old, NULL);
> >  
> > +	return mem;
> 
> I think returning the userspace address from a test is a little hard to
> follow. This one feels even more unexpected because a valid address is
> being returned (and used) from a test that has sigbus in its name.

Yeah, and it's fugly all around.  If we pass in the "accessible" size, then we
can reduce the amount of copy+paste, eliminate the weird return and split mmap()
versus munmap(), and get bonus coverage that reads SIGBUS as well.

How's this look?

static void test_fault_sigbus(int fd, size_t accessible_size, size_t mmap_size)
{
	struct sigaction sa_old, sa_new = {
		.sa_handler = fault_sigbus_handler,
	};
	const uint8_t val = 0xaa;
	uint8_t *mem;
	size_t i;

	mem = kvm_mmap(mmap_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd);

	sigaction(SIGBUS, &sa_new, &sa_old);
	if (sigsetjmp(jmpbuf, 1) == 0) {
		memset(mem, val, mmap_size);
		TEST_FAIL("memset() should have triggered SIGBUS");
	}
	if (sigsetjmp(jmpbuf, 1) == 0) {
		(void)READ_ONCE(mem[accessible_size]);
		TEST_FAIL("load at first unaccessible byte should have triggered SIGBUS");
	}
	sigaction(SIGBUS, &sa_old, NULL);

	for (i = 0; i < accessible_size; i++)
		TEST_ASSERT_EQ(READ_ONCE(mem[i]), val);

	kvm_munmap(mem, mmap_size);
}

static void test_fault_overflow(int fd, size_t total_size)
{
	test_fault_sigbus(fd, total_size, total_size * 4);
}

static void test_fault_private(int fd, size_t total_size)
{
	test_fault_sigbus(fd, 0, total_size);
}

> > +static void test_fault_private(int fd, size_t total_size)
> > +{
> > +	void *mem = test_fault_sigbus(fd, total_size);
> > +
> > +	kvm_munmap(mem, total_size);
> > +}
> > +
> 
> Testing that faults fail when GUEST_MEMFD_FLAG_DEFAULT_SHARED is not set
> is a good idea. Perhaps it could be even clearer if further split up:
> 
> + test_mmap_supported()
>     + kvm_mmap()
>     + kvm_munmap()
> + test_mmap_supported_fault_supported()
>     + kvm_mmap()
>     + successful accesses to offsets within the size of the fd
>     + kvm_munmap()
> + test_mmap_supported_fault_sigbus()
>     + kvm_mmap()
>     + expect SIGBUS from accesses to offsets within the size of the fd
>     + kvm_munmap()
> 
> >  static void test_mmap_not_supported(int fd, size_t total_size)
> >  {
> >  	char *mem;
> > @@ -274,9 +299,12 @@ static void __test_guest_memfd(struct kvm_vm *vm, uint64_t flags)
> >  
> >  	gmem_test(file_read_write, vm, flags);
> >  
> > -	if (flags & GUEST_MEMFD_FLAG_MMAP) {
> > +	if (flags & GUEST_MEMFD_FLAG_MMAP &&
> > +	    flags & GUEST_MEMFD_FLAG_DEFAULT_SHARED) {
> >  		gmem_test(mmap_supported, vm, flags);
> >  		gmem_test(fault_overflow, vm, flags);
> > +	} else if (flags & GUEST_MEMFD_FLAG_MMAP) {
> > +		gmem_test(fault_private, vm, flags);
> 
> test_fault_private() makes me think the test is testing for private
> faults, but there's nothing private about this fault,

It's a user fault on private memory, not sure how else to describe that :-)
The CoCo shared vs. private and MAP_{SHARED,PRIVATE} collision is unfortunate,
but I think we should prioritize standardizing on CoCo shared vs. private since
that is what KVM will care about 99.9% of the time, i.e. in literally everything
except kvm_gmem_mmap().

> and the fault doesn't even come from the guest.

Sure, but I don't see what that has to do with anything, e.g. fault_overflow()
isn't a fault from the guest either.

> >  	} else {
> >  		gmem_test(mmap_not_supported, vm, flags);
> >  	}
> 
> If split up as described above, this could be
> 
> 	if (flags & GUEST_MEMFD_FLAG_MMAP &&
> 	    flags & GUEST_MEMFD_FLAG_DEFAULT_SHARED) {
> 		gmem_test(mmap_supported_fault_supported, vm, flags);
> 		gmem_test(fault_overflow, vm, flags);
> 	} else if (flags & GUEST_MEMFD_FLAG_MMAP) {
> 		gmem_test(mmap_supported_fault_sigbus, vm, flags);

I find these unintuitive, e.g. is this one "mmap() supported, test fault sigbus",
or is it "mmap(), test supported fault sigbus".  I also don't like that some of
the test names describe the _result_ (SIBGUS), where as others describe _what_
is being tested.

In general, I don't like test names that describe the result, because IMO what
is being tested is far more interesting.  E.g. from a test coverage persective,
I don't care if attempting to fault in (CoCO) private memory gets SIGBUS versus
SIGSEGV, but I most definitely care that we have test coverage for the "what".

Looking at everything, I think the only that doesn't fit well is the CoW
scenario.  What if we extract that to its own helper?  That would eliminate the
ugly test_mmap_common(), 

So my vote would be to keep things largely the same:

	if (flags & GUEST_MEMFD_FLAG_MMAP &&
	    flags & GUEST_MEMFD_FLAG_DEFAULT_SHARED) {
		gmem_test(mmap_supported, vm, flags);
		gmem_test(mmap_cow, vm, flags);
		gmem_test(fault_overflow, vm, flags);
		gmem_test(mbind, vm, flags);
		gmem_test(numa_allocation, vm, flags);
	} else if (flags & GUEST_MEMFD_FLAG_MMAP) {
		gmem_test(fault_private, vm, flags);
	} else {
		gmem_test(mmap_not_supported, vm, flags);
	}

