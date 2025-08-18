Return-Path: <linux-kernel+bounces-774447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DC5B2B257
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 095101B681EB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0AB273803;
	Mon, 18 Aug 2025 20:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3okFoYuI"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A31F2737FB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 20:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755548825; cv=none; b=u0swiq1ONESexGGzX+7E+ffLeCNdLpD5I0FSJ2irC7AeV6oK0jWE02VfiC1D38fog2dgcOzmHe9e+sU50mqn4WngQ9YBdtOginz+IAduqwRHlaogVstjle8FI9gRMKVdBkpCvoT4e/OC9gqaN1PkKfL5ovlDKHtaAd4GTgSs4+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755548825; c=relaxed/simple;
	bh=hvgmrr241O0omuQTqBcv0BmLhvckBaBGJ2+28Ap2InM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R6HC/h2rViDKEKgN/TEn07gPFn1FebZdpLRLzwIWXuFc00x+GSkNKawct7/UsFBqxIv9w5f1FdjdzVzXWRJMkNzU4g4z5fb5NWtaWO0BDmkEEUzgQuWcScYoZ5qrx77xD5TJS8Hrw2/tdnb9NzmRmE11QVUwMnhj3q3uXOVqr8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3okFoYuI; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2e60c3e7so8025791b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755548824; x=1756153624; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=79Pt70RnRHly4tCfPJVu4AbcsMZHZLurZ1iSmeGr4PA=;
        b=3okFoYuIs/dIMZw/OVC1rtIrSY7etnEHQ19mODHACIiM5toSelrAQL3fS233rhFtvK
         Er60WkVc7hLKalH5bA2otYhlDu1cxLAUqBFEo3ErVWzLgUZiiJv5uG5zmqZonmVi+h+s
         B+K29RTvFBGvblGFijW0mDqlWJNGCtYTzwbqf+zs/wQ6NCIESlUpa2ZOg3ypFqak7MDo
         kLBqWxcVLmUzL+vShB9u56KDymAU3nJ98zZZ6VJzx/ddiTeovXdNhdpYBkrD4HP/Q6tg
         ytjAUBBhXUnwQeIqmnZBuD1UI4WWVlnMmiuFr37sgFuaUNj5/YToEMhcI3mPdOkMbEpR
         WP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755548824; x=1756153624;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=79Pt70RnRHly4tCfPJVu4AbcsMZHZLurZ1iSmeGr4PA=;
        b=kkq6NeErIb75z30VJzz+gYrbrBcE/r9kJ0oHqdjdonA71wuGracMj247ffpLhF22YD
         HEFx5Wt8bcGH44XzT1jiWJuGSU3xrWyKpPt4+0uGxREodh0DjXmSad6PWviOLu8R1LRK
         +gf5a4Dq17P9UoAu933HM2LanNL3sLzl4aSaP6wJnOmqcgFNw4gRXVJfusuX28wV1KHl
         6BNRuPnkia3ioZuaXcedQSzCN6ByXVZoGY848a1LHiIcLqGLm/r/Sq6PL/TSqrAIFA68
         D/K30fsQDsBvKKSl8+ksITjjXxuV4uPUhwbR6geGGk25WqCBBlxaFHrRzkCnU3CeLzo9
         zJGg==
X-Forwarded-Encrypted: i=1; AJvYcCXkgmhwwbBOoOaskA75sObB2sI+Rw1j8SUsm0V1NRfMSdwVG9zVBc20T9uaVB1QA5u4wEPhIfugp4VA8T4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7uiJwjpBJJ2yxDGLuNdqcbCFJP7m4uXilW04ethwbLSjjIdGO
	H2ZcB/toqmJgr1Jv5rSh0mT/RDgNVUy5zFnftT23iz0Y98S57Ny369KMC10imcadYx/H+ga7xs/
	mR/32LQ==
X-Google-Smtp-Source: AGHT+IHYs5EHtdbLQ31bA8ynjR13PDPzLHtaVEeR4zaHKfzTTXsohXDUQMxaCvrHy/5BlWzCy38Hie14b5w=
X-Received: from pjbta5.prod.google.com ([2002:a17:90b:4ec5:b0:2e0:915d:d594])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:12c8:b0:240:dc9:71cf
 with SMTP id adf61e73a8af0-2430a83bbafmr982758637.38.1755548823648; Mon, 18
 Aug 2025 13:27:03 -0700 (PDT)
Date: Mon, 18 Aug 2025 13:27:01 -0700
In-Reply-To: <lhujz30qu9f.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <87frdoybk4.ffs@tglx> <lhuect8sol1.fsf@oldenburg.str.redhat.com>
 <87cy8sy2n6.ffs@tglx> <lhuwm70qvac.fsf@oldenburg.str.redhat.com>
 <aKODByTQMYFs3WVN@google.com> <lhujz30qu9f.fsf@oldenburg.str.redhat.com>
Message-ID: <aKOMlWxic86puw4C@google.com>
Subject: Re: BUG: rseq selftests and librseq vs. glibc fail
From: Sean Christopherson <seanjc@google.com>
To: Florian Weimer <fweimer@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>, 
	LKML <linux-kernel@vger.kernel.org>, Michael Jeanson <mjeanson@efficios.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Wei Liu <wei.liu@kernel.org>, 
	Samuel Thibault <sthibault@debian.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 18, 2025, Florian Weimer wrote:
> * Sean Christopherson:
> 
> > On Mon, Aug 18, 2025, Florian Weimer wrote:
> >> You could add the extern keyword and check &__rseq_offset for NULL if
> >> you want to probe for the availability of the signal?
> >
> > That will fail to link if the glibc version doesn't support rseq in
> > any capacity, which is why I added the __weak crud.
> 
> You need both (extern and weak) to get a weak symbol reference instead
> of a weak symbol definition.  You still need to check &__rseq_offset, of
> course.

Ooh, you're saying add "extern" to the existing __weak symbol, not replace it.
Huh, TIL weak symbol references are a thing.

This works with static and dynamic linking, with and without an rseq-aware glibc.

Thomas, does this fix the problem you were seeing?

diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 663a9cef1952..d17ded120d48 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -40,9 +40,9 @@
  * Define weak versions to play nice with binaries that are statically linked
  * against a libc that doesn't support registering its own rseq.
  */
-__weak ptrdiff_t __rseq_offset;
-__weak unsigned int __rseq_size;
-__weak unsigned int __rseq_flags;
+extern __weak ptrdiff_t __rseq_offset;
+extern __weak unsigned int __rseq_size;
+extern __weak unsigned int __rseq_flags;
 
 static const ptrdiff_t *libc_rseq_offset_p = &__rseq_offset;
 static const unsigned int *libc_rseq_size_p = &__rseq_size;
@@ -209,7 +209,7 @@ void rseq_init(void)
         * libc not having registered a restartable sequence.  Try to find the
         * symbols if that's the case.
         */
-       if (!*libc_rseq_size_p) {
+       if (!libc_rseq_offset_p || !*libc_rseq_size_p) {
                libc_rseq_offset_p = dlsym(RTLD_NEXT, "__rseq_offset");
                libc_rseq_size_p = dlsym(RTLD_NEXT, "__rseq_size");
                libc_rseq_flags_p = dlsym(RTLD_NEXT, "__rseq_flags");

> >>Or use:
> >> 
> >> #if __has_include(<sys/rseq.h>)
> >> #include <sys/rseq.h>
> >> /* Code that depends on glibc's rseq support goes here. */
> >
> > FWIW, the code in question doesn't depend on rseq per se, rather the problem is
> > that attempting to register a restartable sequence fails if glibc has already
> > "claimed" rseq.
> 
> You can set GLIBC_TUNABLES=glibc.pthread.rseq=0 as an environment
> variable to prevent glibc from registering it.  For a test that's
> probably okay?  It won't help with other libcs that might use rseq
> eventually.

I vaguely recall exploring that option when trying to get static linking working.
I think I shied away from it because I wanted to have something that Just Worked
for all users, and didn't like the idea of hardcoding that into the KVM selftests
makefile.

