Return-Path: <linux-kernel+bounces-774410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CEDB2B1DD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C42E17D8A6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F45C25C81F;
	Mon, 18 Aug 2025 19:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AbZG7fsr"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613C486349
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 19:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755546380; cv=none; b=XufxzpUmcXIAMz6KmWUwxEcL41oQzwEM1SGq1Jx8j+bsdaTDeU2zkttPH+f85PS+BwVCczJNunEWK82IxD/mIfcqW63sRtIz9S4qZowwVZV24j88FQDOmRPSo94RXdck4aeJiREPgY0wCnYgj9EE4WO0w0jD+GPydD5Gs8T8Fsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755546380; c=relaxed/simple;
	bh=d0A3DcV3A2jhIoR0GuVjSSscRv+d/kUtS49txd07hyE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rYagVJvONRuDSpD0kkr9LGA1XUqZLcfTyUqzbLUiMNsb7FEzX+cIEzcyqzoJdZCKPyrZXT7HW/ogqXEi5m1TziPmsoP77IAEbC/z7/P4FOQlyFWSWwcj4n5wBhQPJT73KzqfdTh5QJwar9SuscTDGY6tlPhgXO/i8PxFY7v1bCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AbZG7fsr; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-323267915ebso9266088a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755546376; x=1756151176; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FdgBkSsc0yZtACXuGldQ6piq696oK3E+XrT/8S5+H9I=;
        b=AbZG7fsrxYOAtxIUBfRyg9+uGy34fgHDuhtgIHc3FSLHABD170Xuyc5Byl91unKy8p
         asWFnJSGKDpMonW6n0G2fPCXO0yx0qfKm3PeOvULZL9qOwp1JThZvWlJB2dxEUDbh4ZV
         lqm/mdvqdz5J1Peri2rr/88zku5mTxZTwSchrKBHNNT4KqdrH6/6j8PRdsNfi3sqMGpW
         jqMJuaUrMNMqNd1vK/Bfwxe5VjMqOl3oL1+dOeB5czzKuncrdBtsmtElj9bqM/Lp/TGS
         5EMNXS5BKbhAf9DyoLsRAImhTRDRE37hIysA+oZmoqIF43L+mI5VYtYidcBfbzsdCX8N
         v/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755546376; x=1756151176;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FdgBkSsc0yZtACXuGldQ6piq696oK3E+XrT/8S5+H9I=;
        b=LMGkU0RvoL1sJPIAQl11lSpKAwaUjHpaQCHofh8nUPbM0usrLHTjB0MXQjpKNjxQGT
         gP9uEsp2kmi9ScxFu3XQ/qji7RzaBFp3RcFz3e7g8HWPAdeez0lz4ELYw05FCmNWoFY1
         NLvHwOU88/tX3YrFnaFd/4Z5B8psEEHZd9m7I4wftJpqyS45+ZA2QbKEDFZerjavNJsV
         5Z2XILPyS9hKtKqfxOMw9TzzOEP46JxNIduDcD8Bw2jsZ62OH/Hb65QNufl6Ew8P1sss
         jz4CWYQHUlWXUU5C4QGSz5PFeBUyBazP6dQnQ5W2R06ZGRovcDGkv0YvsgwoHL637vgM
         jYWw==
X-Forwarded-Encrypted: i=1; AJvYcCWP8uajYNYQj0I87aTgvT9OfJ1Oqbxt5/EdQQliD5O/VdFXXVZSFYwtQb3+hyqCaa1JaMT3WdPIwsH4Qr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgRB2K60Ur+6mSGNA2XVAEJbktD3YaDDwXUqdiQzf5goQZ73gs
	0xe2mfO7VciMQmvq6woJFNmuYLFy3I+6rtDcmeBUcbze1fZzjbi22sd0SkAv0x6Jmfc7UJvGfVL
	0kCeWZg==
X-Google-Smtp-Source: AGHT+IHVW9gRiLRGB944Rz36W14NIcQ5Ba63BfMWhrPuRlSDJmTZXG3ttEq/AU93Gs8xmVzXuqCewt/98l0=
X-Received: from pjx3.prod.google.com ([2002:a17:90b:5683:b0:313:551:ac2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7c1:b0:321:c2fb:bcca
 with SMTP id 98e67ed59e1d1-32476a135ebmr161011a91.3.1755546376586; Mon, 18
 Aug 2025 12:46:16 -0700 (PDT)
Date: Mon, 18 Aug 2025 12:46:15 -0700
In-Reply-To: <lhuwm70qvac.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <87frdoybk4.ffs@tglx> <lhuect8sol1.fsf@oldenburg.str.redhat.com>
 <87cy8sy2n6.ffs@tglx> <lhuwm70qvac.fsf@oldenburg.str.redhat.com>
Message-ID: <aKODByTQMYFs3WVN@google.com>
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
> * Thomas Gleixner:
> 
> > On Mon, Aug 18 2025 at 16:15, Florian Weimer wrote:
> >> * Thomas Gleixner:
> >>> It's trivial to reproduce. All it needs is to have in the source:
> >>>
> >>> __weak ptrdiff_t __rseq_offset;
> >>>
> >>> w/o even being referenced and creating a pthread. Reproducer below.
> >>
> >> Well, that's sort of expected.  You can't define glibc symbols that are
> >> not intended for interposition and expect things to work.  It's kind of
> >> like writing:
> >>
> >> int _rtld_global;
> >>
> >> That's going to fail rather spectaculary, too.  We make an exception for
> >> symbols that are not reserved (you can build in ISO C mode and define
> >> open, close, etc., at least as long as you link to glibc only).  But
> >> __rseq_offset is a reserved name, so that is not applicable here.
> >>
> >> The real change here is GCC changing from -fcommon (which made a lot of
> >> these things work in the past) to -fno-common.
> >
> > Thanks for the explanation!
> >
> > So the only way to make this actually work is to revert that commit and
> > the folks who want to link that statically need to come up with:
> >
> > #ifdef _BUILD_STATICALLY
> > extern ....
> >
> > #else
> >         ptr = dlsym(...);
> > #endif
> >
> > or something daft like that. A proper function interface would avoid all
> > that nonsense, but we can't have nice things or can we?
> 
> I don't understand why a function would be different.  Well, a function
> *declaration* would be implicitly extern, in a way a variable
> declaration is not (without -fcommon).  Maybe it's just about the
> missing extern keyword?
> 
> You could add the extern keyword and check &__rseq_offset for NULL if
> you want to probe for the availability of the signal?

That will fail to link if the glibc version doesn't support rseq in any capacity,
which is why I added the __weak crud.

>Or use:
> 
> #if __has_include(<sys/rseq.h>)
> #include <sys/rseq.h>
> /* Code that depends on glibc's rseq support goes here. */

FWIW, the code in question doesn't depend on rseq per se, rather the problem is
that attempting to register a restartable sequence fails if glibc has already
"claimed" rseq.

What about something horrific like this?  Or if __has_include(<sys/rseq.h>) is
preferrable to checking the glibc version, go with that.  The idea with checking
LIBC_RSEQ_STATIC_LINK is to give folks a way to force static linking if their
libc registers rseq, but doesn't satisfy the glibc version checks for whatever
reason.

diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 663a9cef1952..1a88352fcff3 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -36,17 +36,18 @@
 #include "../kselftest.h"
 #include "rseq.h"
 
-/*
- * Define weak versions to play nice with binaries that are statically linked
- * against a libc that doesn't support registering its own rseq.
- */
-__weak ptrdiff_t __rseq_offset;
-__weak unsigned int __rseq_size;
-__weak unsigned int __rseq_flags;
+#if defined(LIBC_RSEQ_STATIC_LINK) || __GLIBC__ > 2 || (__GLIBC__ == 2 && __GLIBC_MINOR__ >= 35)
+extern ptrdiff_t __rseq_offset;
+extern unsigned int __rseq_size;
+extern unsigned int __rseq_flags;
+#define GLIBC_RSEQ_PTR(x) &x
+#else
+#define GLIBC_RSEQ_PTR(x) NULL
+#endif
 
-static const ptrdiff_t *libc_rseq_offset_p = &__rseq_offset;
-static const unsigned int *libc_rseq_size_p = &__rseq_size;
-static const unsigned int *libc_rseq_flags_p = &__rseq_flags;
+static const ptrdiff_t *libc_rseq_offset_p = GLIBC_RSEQ_PTR(__rseq_offset);
+static const unsigned int *libc_rseq_size_p = GLIBC_RSEQ_PTR(__rseq_size);
+static const unsigned int *libc_rseq_flags_p = GLIBC_RSEQ_PTR(__rseq_flags);
 
 /* Offset from the thread pointer to the rseq area. */
 ptrdiff_t rseq_offset;
@@ -209,7 +210,7 @@ void rseq_init(void)
         * libc not having registered a restartable sequence.  Try to find the
         * symbols if that's the case.
         */
-       if (!*libc_rseq_size_p) {
+       if (!libc_rseq_size_p || !*libc_rseq_size_p) {
                libc_rseq_offset_p = dlsym(RTLD_NEXT, "__rseq_offset");
                libc_rseq_size_p = dlsym(RTLD_NEXT, "__rseq_size");
                libc_rseq_flags_p = dlsym(RTLD_NEXT, "__rseq_flags");

