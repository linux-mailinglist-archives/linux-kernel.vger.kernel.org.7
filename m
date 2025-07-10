Return-Path: <linux-kernel+bounces-725276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D015AFFCC1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F0481C86A3B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A660828CF4C;
	Thu, 10 Jul 2025 08:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g3iH74tM"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A4328C5CE
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137269; cv=none; b=NINqeyrKBF/yt23mHN+POqm6/Zk4x++bSkzuAf4t8MCBSCmYrRKyBlEUJ+tpcWtp4XMNpuwknT1wLvC6P8vkkUuixD0QmORrUpbNLZTpd4jz1Gpr0JwA1xYdVYVHT1uU7z5pQ9aYVRAEDDJqT+5uoGC/g0Pnw8VDP89coBCwVZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137269; c=relaxed/simple;
	bh=57V0TYHG4HiRpDjObfiX8523KoBb7uejRCFwjUXkGuQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=otXGZdjnkb0VS7pAACkddbCYAy7aFnoTr9FNkwFlhOdyEm29oICiDTtmhujfRm907RB9NWb2MHQau1CqmIKfdQX1AN+T5/QZObZBKI5TzJrf4ri4uhAG24Urah3qlQxNrUX76c/YDi2EUtAKbbllfJdv+koUiXGt4mUgJ77UM50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g3iH74tM; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-453817323afso4081275e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752137265; x=1752742065; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiT+cF5jie4GC59R8tbVZyTkxmY5kyeE7d02aQYTPCo=;
        b=g3iH74tMDT98LkIjPjN1EVqMQnCHFxDi8QJeab45CF+BsyIqroNFjo/6z4eXeCs92E
         KmWmHphBvcOW8o1cFA7AxMFrCjg68tNK/q6TXiHkmQ4u2UYhHdlcRuxENacdD3GCU0w5
         W5GcAXSayuA0N6AIgQhatV8FzfRbbA74uOjSas5JvYqSpSa7QRTc+CfovBt/Gc1Gorj+
         7pDW3q4UG3zfn0rF/16qJVvDNwUXCwnAmYT2z5J3qhwGbPIHmDhRbOGtl8H50SfMgFwg
         3v5ploEMWoSeC19ERIy6HtjTDwLrvgtQXvBmo/hiHxv/goIe60aTaGxMrQ9gIuv9JJBu
         oUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752137265; x=1752742065;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiT+cF5jie4GC59R8tbVZyTkxmY5kyeE7d02aQYTPCo=;
        b=odlyHCuejK5z/MFtl26v45ZRjIBgwFT3GO08l705MhsA6b66FxJpOgOFkuYo0m9ZPo
         QA9yptNMO8dqHqOfOhLgbtGm6f4hoPtk7KnLMp9QZz1ugX/wQvJZRznOxIB8iv+bjOkb
         Xaf+2JjOfuxfxU7/NPtExri0H0Qab7p6f4oRoZzfTdVL/jIuHd3DdT0qZkH0/zMGZKwg
         n6CAkxRATL4vSJi7xkNvW2LWW9Q3m7DZoiKrNJ7cfhKjcUydKGm6QVOOhiO0HRyNHlGG
         7E6JNNlY9oTLR0S2OXc9+tfiyMcSqFMkGvE35DbKO6ZhpTxqZguHRtYI1xK5FZhp56+E
         nDKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI2GdF6ehzVQqyr/stIHJB7WQO2w8mhLGlSlitWKF5zomtd7dPTrXKsW6qk+q3lFVLe95ECeeXBXwtzqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ5C3h8vQcNX5+i+gl8geY3V4Wt910TkKjoLv2+ZahJdq9kzqU
	jQv6xk2pZ354YnDxMmi4bthqtJU9nC/nN5kOBMJdxw4kmY1Njxp0tGu3y2K86SS8gqgYbSCtI1X
	5ce5efFn8biQx8Oibww==
X-Google-Smtp-Source: AGHT+IGK69YzUiltyubhCeTYslvStKPrTGYmrpcKUFP45k02gQ/9NltQd70XDpa+u73OYmjTLWZ0yP9DJqMc6GE=
X-Received: from wmth15.prod.google.com ([2002:a05:600c:8b6f:b0:442:f9fc:2a02])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e55:b0:453:5d8d:d1b8 with SMTP id 5b1f17b1804b1-454db8909a8mr28725405e9.30.1752137265730;
 Thu, 10 Jul 2025 01:47:45 -0700 (PDT)
Date: Thu, 10 Jul 2025 08:47:44 +0000
In-Reply-To: <87qzypjrdm.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250708-rnull-up-v6-16-v2-0-ab93c0ff429b@kernel.org>
 <20250708-rnull-up-v6-16-v2-3-ab93c0ff429b@kernel.org> <kpVk60lBMPJ_b4glgS0w-BfbIjN1cMCDSKDoM0RAB4p1Bg1BNfIdA4YRuOu70BbSZjlserkd8EJDwy0vVmR7yQ==@protonmail.internalid>
 <aG5tObucycBg9dP1@google.com> <87qzypjrdm.fsf@kernel.org>
Message-ID: <aG9-MAwbNbjuoR0i@google.com>
Subject: Re: [PATCH v2 03/14] rust: str: introduce `NullBorrowFormatter`
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Jul 09, 2025 at 05:49:57PM +0200, Andreas Hindborg wrote:
> "Alice Ryhl" <aliceryhl@google.com> writes:
> 
> > On Tue, Jul 08, 2025 at 09:44:58PM +0200, Andreas Hindborg wrote:
> >> Add `NullBorrowFormatter`, a formatter that writes a null terminated string
> >> to an array or slice buffer. Because this type needs to manage the trailing
> >> null marker, the existing formatters cannot be used to implement this type.
> >>
> >> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> >> ---
> >>  rust/kernel/str.rs | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 59 insertions(+)
> >>
> >> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> >> index 78b2f95eb3171..05d79cf40c201 100644
> >> --- a/rust/kernel/str.rs
> >> +++ b/rust/kernel/str.rs
> >> @@ -860,6 +860,65 @@ fn deref_mut(&mut self) -> &mut Self::Target {
> >>      }
> >>  }
> >>
> >> +/// A mutable reference to a byte buffer where a string can be written into.
> >> +///
> >> +/// The buffer will be automatically null terminated after the last written character.
> >> +///
> >> +/// # Invariants
> >> +///
> >> +/// `buffer` is always null terminated.
> >> +pub(crate) struct NullBorrowFormatter<'a> {
> >> +    buffer: &'a mut [u8],
> >> +    pos: usize,
> >> +}
> >
> > Do you need `pos`? Often I see this kind of code subslice `buffer`
> > instead.
> 
> How would that work? Can I move the start index of `buffer` in some way
> without an unsafe block?

Yes. I think this will work:

let buffer = mem::take(&mut self.buffer);
self.buffer = &mut buffer[pos..];

Temporarily storing an empty slice avoids lifetime issues.

> >> +    #[expect(dead_code)]
> >> +    pub(crate) fn from_array<const N: usize>(
> >> +        a: &'a mut [crate::ffi::c_char; N],
> >> +    ) -> Result<NullBorrowFormatter<'a>> {
> >> +        Self::new(
> >> +            // SAFETY: the buffer of `a` is valid for read and write as `u8` for
> >> +            // at least `N` bytes.
> >> +            unsafe { core::slice::from_raw_parts_mut(a.as_mut_ptr().cast::<u8>(), N) },
> >> +        )
> >> +    }
> >
> > Arrays automatically coerce to slices, so I don't think this is
> > necessary. You can just call `new`.
> 
> Nice!

I'm guessing it used to be necessary back when we used core::ffi::c_char
since &[i8;N] doesn't coerce to &[u8]. But now that we use the right
c_char definition, that isn't the case anymore.

> >> +impl Write for NullBorrowFormatter<'_> {
> >> +    fn write_str(&mut self, s: &str) -> fmt::Result {
> >> +        let bytes = s.as_bytes();
> >> +        let len = bytes.len();
> >> +
> >> +        // We want space for a null terminator
> >> +        if self.pos + len > self.buffer.len() - 1 {
> >
> > Integer overflow?
> 
> In the subtraction? `buffer.len()` is at least 1, because of the type invariant.
> 
> Or do you mean I should do a checked add for `self.pos + len`?

Ah, I guess self.pos and len are both <= the length of a slice, which is
at most isize::MAX, so the addition can't overflow an usize. Would be
good to comment this, though.

Alice

