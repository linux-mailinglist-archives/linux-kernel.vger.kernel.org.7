Return-Path: <linux-kernel+bounces-774633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A878B2B54D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 02:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14FBB5E7FAB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 00:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C93F52F99;
	Tue, 19 Aug 2025 00:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n4src60p"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FED738B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 00:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755563303; cv=none; b=p+rTWNWaa4avl9aIJSBAJk4HVpYKC6QQh98pmqFEP8V6liHnJxEPutiOo96TvaeGT6G6k2zSaN1Y+uWpdm6WFaGsc5djjD3z4Cg5ir+tuqrNrvbXJL+1p1N71f/KPe7z438c+L45GN/Hkl00KXRAqBYR13yvSiqF7nTieT9wspc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755563303; c=relaxed/simple;
	bh=So6vwH3vSIcoE6qOa2PTExEJcriyM+eAI89EeYJcYCk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SJiM+IowI4RyF1mBefyx9lmYiqaPLfJdOFXTuz41bVSk7Kmzyoe/RDGIA8P7oBBnurp+zrSEZBjO5/CXYXqdYoL+k2MO2qrrC+U23omThNxQrZ0FQu/q2YEkWOXXWC/sIlqV0WVgDsE2zW22UM8B63SasgG7Tui2RIM6w83JFSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n4src60p; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b473910af91so2237327a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 17:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755563299; x=1756168099; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C3S8wWDeJulI9CiJ3E9uvJtgrXwkeVvk9mSwcK+K8+E=;
        b=n4src60pwc+qINKAfkVYOO5HmpjYcNFkyxN4UcM6+NmxhH+XH7egvpR6gtoBDOp5bG
         GGA887WDYs0mB+frBSapQ/8in2UFdKW0SKUqTPea/LqQ3zRF3bYEdDE7goZw+CrbPR4I
         W93q2Vihoa3AxmhIElNC15N/Qk0sIZWQYCY6SaH9vkMt26epDGHbnfSmw22tQTbCx/Pq
         igDOIjOvAFgWeqyXvIP4Y5kcFpUdmLVQalXeH12wolNiOQxDxEzHhe7yPtidSIdv2rGu
         7z6+jNWIS7lTSnCC/P8JY+o1zdsWl09qE2vpTlyXFnOFacc77aGuGrKwgyRIUvstE8f4
         BvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755563299; x=1756168099;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C3S8wWDeJulI9CiJ3E9uvJtgrXwkeVvk9mSwcK+K8+E=;
        b=UYPWXRFRJ1H/8U9DMskltkXumHVROJWP47F88s1I7TApYexOGGPxHW8+M6JEp82ZGW
         G/anvhG3ykMrCYwvfrOghRRgPy5p3IT7dxn+qu4/E1A17oehEYPze4uayfMh6v1M4moq
         LcujSOrnLu87KdzjLHQWsx3zq5rB+/PMbPaUkx8w/fjRZUu84VFIev6X51OFiIK9b/mX
         FtTa9Ka7tBeEUBQtiwEDyJw7u+2j1Mc3YVDlpW03VM+z8lStnujNYXbfzsv7wDNXmXaB
         Ce6QrZ7C+Jjh1OcQdhEEYG5EK/VOEh9SEq29aHX0FcgoLIfx83rPnM6GAeHPZN/Drg5M
         ymHA==
X-Forwarded-Encrypted: i=1; AJvYcCXBNcQHXtjlpOKsh/E16Cl05bn4YZ3hR95EjJp5JTAgwOvoZbuW/68U9GV53Zut9bsnc0a0LvzoHEefoj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/2Mkflvz7ij8sjEhIH0lI6u3XLNLMQZLZsjZuHSeukr90HJzj
	IHrfZkL9AzCTz7BNXU9YxyCs4mtynvmyjj0xomPZQA+aLtXfr1zcgC3FAuegqaULcYHkw8Yk+rh
	/HFoqAA==
X-Google-Smtp-Source: AGHT+IGJOJFpTW1pYcS1SLU4FaNzycAMXCqHFgRUb+bHlPJe66HXZJ0vSkTz5rhG2dhLY6a+kRAIngQI+fM=
X-Received: from pjbqc5.prod.google.com ([2002:a17:90b:2885:b0:31c:4a51:8b75])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4c5:b0:234:1e11:95a3
 with SMTP id d9443c01a7336-245e09d0befmr6001425ad.13.1755563298789; Mon, 18
 Aug 2025 17:28:18 -0700 (PDT)
Date: Mon, 18 Aug 2025 17:28:17 -0700
In-Reply-To: <87349oxk2n.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <87frdoybk4.ffs@tglx> <lhuect8sol1.fsf@oldenburg.str.redhat.com>
 <87cy8sy2n6.ffs@tglx> <lhuwm70qvac.fsf@oldenburg.str.redhat.com>
 <aKODByTQMYFs3WVN@google.com> <lhujz30qu9f.fsf@oldenburg.str.redhat.com>
 <aKOMlWxic86puw4C@google.com> <87349oxk2n.ffs@tglx>
Message-ID: <aKPFIQwg5zxSS5oS@google.com>
Subject: Re: BUG: rseq selftests and librseq vs. glibc fail
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Florian Weimer <fweimer@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	LKML <linux-kernel@vger.kernel.org>, Michael Jeanson <mjeanson@efficios.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Wei Liu <wei.liu@kernel.org>, 
	Samuel Thibault <sthibault@debian.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 19, 2025, Thomas Gleixner wrote:
> On Mon, Aug 18 2025 at 13:27, Sean Christopherson wrote:
> > On Mon, Aug 18, 2025, Florian Weimer wrote:
> >> You need both (extern and weak) to get a weak symbol reference instead
> >> of a weak symbol definition.  You still need to check &__rseq_offset, of
> >> course.
> >
> > Ooh, you're saying add "extern" to the existing __weak symbol, not replace it.
> > Huh, TIL weak symbol references are a thing.
> >
> > This works with static and dynamic linking, with and without an rseq-aware glibc.
> >
> > Thomas, does this fix the problem you were seeing?
> >
> > diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
> > index 663a9cef1952..d17ded120d48 100644
> > --- a/tools/testing/selftests/rseq/rseq.c
> > +++ b/tools/testing/selftests/rseq/rseq.c
> > @@ -40,9 +40,9 @@
> >   * Define weak versions to play nice with binaries that are statically linked
> >   * against a libc that doesn't support registering its own rseq.
> >   */
> > -__weak ptrdiff_t __rseq_offset;
> > -__weak unsigned int __rseq_size;
> > -__weak unsigned int __rseq_flags;
> > +extern __weak ptrdiff_t __rseq_offset;
> > +extern __weak unsigned int __rseq_size;
> > +extern __weak unsigned int __rseq_flags;
> >  
> >  static const ptrdiff_t *libc_rseq_offset_p = &__rseq_offset;
> >  static const unsigned int *libc_rseq_size_p = &__rseq_size;
> > @@ -209,7 +209,7 @@ void rseq_init(void)
> >          * libc not having registered a restartable sequence.  Try to find the
> >          * symbols if that's the case.
> >          */
> > -       if (!*libc_rseq_size_p) {
> > +       if (!libc_rseq_offset_p || !*libc_rseq_size_p) {

Doh, I meant to check libc_rseq_size_p for NULL, i.e.

	if (!libc_rseq_size_p || !*libc_rseq_size_p) {

> 
> If I make that:
> 
> +       if (!*libc_rseq_offset_p || !*libc_rseq_size_p) {
> 
> then it makes sense and actually works. The pointer can hardly be NULL,
> even when statically linked, no?

IIUC, it is indeed the pointers that are set to NULL/0, because for unresolved
symbols, the symbol itself, not its value, is set to '0'.  Which makes sense,
because if there is no symbol, then it can't have a value.

I.e. the address of the symbol is '0', and its value is undefined.

E.g. statically linking this against glibc without rseq support:

diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 663a9cef1952..959bdcb32e96 100644
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
@@ -209,7 +209,12 @@ void rseq_init(void)
         * libc not having registered a restartable sequence.  Try to find the
         * symbols if that's the case.
         */
-       if (!*libc_rseq_size_p) {
+       printf("libc_rseq_offset_p = %lx (%lx), libc_rseq_size_p = %lx (%lx)\n",
+              (unsigned long)libc_rseq_offset_p, (unsigned long)libc_rseq_size_p,
+              (unsigned long)&__rseq_offset, (unsigned long)&__rseq_size);
+       printf("__rseq_size = %u\n", __rseq_size);
+
+       if (!libc_rseq_size_p || !*libc_rseq_size_p) {
                libc_rseq_offset_p = dlsym(RTLD_NEXT, "__rseq_offset");
                libc_rseq_size_p = dlsym(RTLD_NEXT, "__rseq_size");
                libc_rseq_flags_p = dlsym(RTLD_NEXT, "__rseq_flags");

Generates this output:

  $ ./rseq_test 
  libc_rseq_offset_p = 0 (0), libc_rseq_size_p = 0 (0)
  Segmentation fault

Because trying to dereference __rseq_size hits NULL/0.

