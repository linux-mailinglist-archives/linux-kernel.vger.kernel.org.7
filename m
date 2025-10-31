Return-Path: <linux-kernel+bounces-879841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2960BC242C3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2101899CB2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F895329E60;
	Fri, 31 Oct 2025 09:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T2MG73XF"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE842F6931
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903131; cv=none; b=GLvq/yKzEEz6FUqLZChzfa0g/C+xLwEpr8ZeX5n8BwBgrjyO0wGkkilVejeWCMElVjCPzpjjcvPGUaiOcJ3iJaPCao886pGxqKrjBpt0h98Wyd2y8bKPFOB9TkjVKznvKVhTq55YT1qixH8aT8xgvQ02W8MySiK6+0Ha/sXnP6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903131; c=relaxed/simple;
	bh=7MDgQC6YQkMTHiSUf+NQuriTH8gMZgALQRyrpDWav8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/uRccHLtYM2w+YIzMorKYtZwj2hr4drFgQuOyvJoGiv1hS1fMrzLTG8efbMGWk9jfPyZPypQN+m/fUjFuerUpOqv3F08QjDkGcgGD9VAk2H8Fp2L7r0x8s6QAl0JjoC74WZpz7R/RUUMpI+l1KXNBimJtPZaXfxuCXg9WeicUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T2MG73XF; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-475dd559b0bso26531155e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761903128; x=1762507928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RslSawTiA9rDsaIKkA07wlfuV1PduegSYOZOF8JH0M=;
        b=T2MG73XF7tZlRE6vbMwJwez32eYdjf116yd3GfPT6egphKxRNBYryiEpfD1kCNPqFF
         Msa390wt30ih+ryRaF1PljZtgiUjbGyAUrUOtDGozKlt0SPE94dUak19QE8r1XjJ9tJP
         1Hjdqv1lOs8mKZvdRVi9OASAQxOqwl6y1QysZvGaaCI3bBC2ckgB0ELhUuspOqtqfpxa
         CEq/6VLRRNb/CmZdSfgXCICE6XOYCLg6cq8FEyxdHZ+uV90Y0oY6LuGSF24+rfg1Pxub
         Zjup68M/AS31DqlSzq5k6rB6ViPBVljAEeE4ZBl3kSoX1OzTmlR0W7GIBYS6KOdJeZhp
         NUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761903128; x=1762507928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RslSawTiA9rDsaIKkA07wlfuV1PduegSYOZOF8JH0M=;
        b=dAjbV6iAR25DyjDwrjF9EbRuCAgEvHZKm2VhgH4dcHbNx61TTXrERh3d6GACJ0CmqP
         VUS1QLlPVmj6lyXIwOvT46g4Dyl35CyaEOFAJsvLHJfhm+Mt2iH4rqyIlGdELTherord
         aaSCXp4pEBBa/CGie9YBJdTvXWQq/OxQVd/Kd0AakpqCFLohTYCKrp6ATrFRL0hxRezO
         mtNdCtp4E1AYYBWE5/eF4ekgUP5NHMB/Iyqxrwd/lzrFk+ry8I/+p8iQFPNtcOpxZwE9
         F69CWXzhKt2mrT8j6rcsLM8vqaHXh6Eo0Ed1AvkXPc3nOtde6jnL9dSqCJIe5+4F3Bey
         +/nA==
X-Forwarded-Encrypted: i=1; AJvYcCUcC0vzbI0oMJ2w+aZbz20g3Q/DI77y0vhUdtHTqCPBi+mdId5AJAq7+FHYIb5fBEFVbtf0IH8c9mHsvDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjfP2b3fEZ3m2dx8g6Ryl0bB9VuqoHFZn/eJpYfbsQ2G1ndHjK
	Ecn/VqjGifgprbaHj/ceJ37KgsVyp6IR3ESSEEiqO/42gNavVSlrP6aa3BQhSchYR7pdO4RqNwD
	K0LnO9d+Yd17kNzODWluBkH/77nzC8R8jwvqQfeUt
X-Gm-Gg: ASbGncv++efmMT+xQJ8H3YrQTOdyhak7b1aIxF0s/YHjzIEmoAWY2lTk8+hLwuHtQ4c
	aGHSSP/VnfCjSMgYHjUbErMppuJmhtdrgqENEMtWKVAmfPXdL3M4Da5D/zkcrEA0uHJ17VQsjOO
	sUh7EFMYRAAYTMBWwM7adglIoKtkZK6OqBwBLc6bRwJEGPzgMiybAxd/MAqZ2atjMtfYAOG5Ez+
	md7wOoJg67iOz0zGsAcS6Gcm0DAumx/GUuaeNV9YkpKVCIdtAxVHbXfuNheS5KLnH5u9cjdg8lc
	WlgHECkoexAl3hR5nbKQbAxaHg==
X-Google-Smtp-Source: AGHT+IE/UV/vTi/s32thL/cWYnnHUFWhAvh43fmoicl3MzgGOK99WIqVH97ELR7KohgrB+VH6IMCgIUkETXg3sn45lk=
X-Received: by 2002:a05:6000:4381:b0:427:45f:ee21 with SMTP id
 ffacd0b85a97d-429bd683f4bmr2420461f8f.27.1761903127736; Fri, 31 Oct 2025
 02:32:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029183538.226257-1-lyude@redhat.com> <c1ff48ea-53ca-40ea-9541-85abd1a528d0@redhat.com>
 <e0112480a6786c64fa65888b5ce8befbba72a230.camel@redhat.com>
In-Reply-To: <e0112480a6786c64fa65888b5ce8befbba72a230.camel@redhat.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 31 Oct 2025 10:31:55 +0100
X-Gm-Features: AWmQ_bkMgg2TYXHac5akbNYgRQ_r8IVs7J3FhWkFVFR2TItTmPGYFFkV8h0Phw0
Message-ID: <CAH5fLgiWceOs-VtDnFkx5EBxCbAnJ3cLkRwp9adQC7x9oJCDFQ@mail.gmail.com>
Subject: Re: [PATCH v4] rust: lock: Export Guard::do_unlocked()
To: Lyude Paul <lyude@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Benno Lossin <lossin@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 6:41=E2=80=AFPM Lyude Paul <lyude@redhat.com> wrote=
:
>
> On Thu, 2025-10-30 at 11:43 +0100, Paolo Bonzini wrote:
> > On 10/29/25 19:35, Lyude Paul wrote:
> > > +    /// // Since we hold work.lock, which work will also try to acqu=
ire in WorkItem::run. Dropping
> > > +    /// // the lock temporarily while we wait for completion works a=
round this.
> > > +    /// g.do_unlocked(|| work.done.wait_for_completion());
> > > +    ///
> > > +    /// assert_eq!(*g, 42);
> > > +    /// ```
> > > +    pub fn do_unlocked<U>(&mut self, cb: impl FnOnce() -> U) -> U {
> > >           // SAFETY: The caller owns the lock, so it is safe to unloc=
k it.
> > >           unsafe { B::unlock(self.lock.state.get(), &self.state) };
> >
> > Getting self as &mut is incorrect.  That's because owning a lock guard
> > implicitly tells you that no other thread can observe the intermediate
> > states of the object.  (The same is even more obviously true for a
> > RefCell's mutable borrow, i.e. core::cell::RefMut)
> >
> > Let's say you have a lock-protected data structure with an invariant
> > that is preserved at the end of every critical section.  Let's say also
> > that you have a function
> >
> >      fn do_something() {
> >          let g =3D self.inner.lock();
> >          g.mess_up_the_invariant();          // (1)
> >          self.do_something_else(&mut g);     // uses do_unlocked()
> >          g.fix_the_invariant();              // (2)
> >      }
> >
> > Because the function holds a guard between the calls (1) and (2), it
> > expects that other thread cannot observe the temporary state.  The fact
> > that do_unlocked() takes a &mut doesn't help, because the common case
> > for RAII objects is that they're passed around mutably.
> >
> > Instead, do_unlocked should take the guard and return another one:
> >
> >      fn do_something() {
> >          let mut g =3D self.inner.lock();
> >          g.mess_up_the_invariant();          // (1)
> >          g =3D self.do_something_else(g);      // uses do_unlocked()
> >          g.fix_the_invariant();              // (2)
> >      }
> >
> > This version of the interface makes it clear that (1) and (2) are in a
> > separate critical section.  Unfortunately it makes the signature uglier
> > for do_unlocked() itself:
> >
> >      #[must_use]
> >      pub fn do_unlocked<U>(self, cb: impl FnOnce() -> U) -> (Self, U)
>
> Hm, it seems then that we should probably fix this before exporting it th=
en!
> Thank you for pointing this out, I'll fix it in the next respin.

I do agree that this behavior has a lot of potential to surprise
users, but I don't think it's incorrect per se. It was done
intentionally for Condvar, and it's not unsound. Just surprising.

Of course, that doesn't mean we can't change it. Condvar could be
updated to use ownership in that way, and doing say may be a good
idea.

Alice

