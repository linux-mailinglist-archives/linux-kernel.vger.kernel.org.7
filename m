Return-Path: <linux-kernel+bounces-723458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AADCAFE711
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A50E1C41F82
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8CC299A82;
	Wed,  9 Jul 2025 11:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zTEHQjNS"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E470C298242
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059259; cv=none; b=DFDyjhhFyEZu4bIwNj8JBab7w4MtHK3D5iGCdRzD2Z17eLGygi/thlAZ4Xcn8QKRjOIT5W0jUsVK8M9s2HxxGA0h7BnJPvYtLLTzGACrjn07Z/hnJjfEIF3O0IRtVmyR8CtjJpqZ7osBpgDWalHOYaSrWKOwFYUBvz5PzRU6/2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059259; c=relaxed/simple;
	bh=63SYD4eaOgs5Gg5HuONNrg9YMQ+Z7U7kM+4FWEkCPc4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VWuJ/OXg65QSmbShwXPtK6AzKfdcQG1bSYEDD+Pp34M7MW1YuSmmioEScQtthUY7LNIwaI+h7xdx+D2fpLt22axhR72RdnOeb59etciuSZawCfbmXrwVbZUlf4nsy3SwpQt+oMOI9+XQZ0VwjWpeeBQFn8HFX5InJr6dBBFIc7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zTEHQjNS; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a4f65a705dso3226769f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 04:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752059255; x=1752664055; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9FX84mBcDm8TDqY3V/2v3TJ7hZLLCjZ53Mk0+zJyJmc=;
        b=zTEHQjNSrOcN4qInAgUuMLoTL4hpT8Y12iNh+vPrn7SfKyT12panlP2dSjKxhaClIg
         tjJhkuIqG48ou6jM1Fyz3MVmbkA7S6LbUMlmBjY94L9BEsk7roj2yvBbf+CHNhClaWvp
         B8s5L/hg87h/LbqWde/FRrtNKPxr6+kBmPSbUtEcFNBMghtmiqiDTeIpXqe+ksRRGsT8
         GjFJfDi264/1n1udV/jIiwfeOAcPeVzZzXGEu1b+gEwwq8IS02oGiLsCpK2FeQbv7roy
         R/yo8K1P2eFcRtVDN6bfY0+whO0XLKH5Zmq2foa5ePBaYpfXzOxf41Z1IBKWkD4pfL4f
         pjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752059255; x=1752664055;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9FX84mBcDm8TDqY3V/2v3TJ7hZLLCjZ53Mk0+zJyJmc=;
        b=DJgB+87rXwbBnON8+FO0sV7mqT4V9dbYOfz/2Fj5wqYNIhYlGSvcZMdDWmN9tQ1ou0
         RycerQ5gxbZIe+EEcJHZ0f3CMLCWR5j6anohPVjTL9b6x4XzjPnQ/2J3pmREuCgi085C
         9AwRFzaJ+U0BWUYckZolCb9gdm3SDdoMzF85BRxorH/tTaar3uQzVAZwzbBTLmQ68MYf
         RXMOugyOo7mDIsirwjCCULAgAVIBJAxTA2Ze2TzZNKzZ+4//jnVSB/A+gY+rYzNSuhQs
         bHqBYf26SffoIX547BTWR6+9icEcSssYuj51ymzWAo4E4T1HrGEDoKrFjkTjfp+++U5y
         vW3w==
X-Forwarded-Encrypted: i=1; AJvYcCXJF1vHGbFhGvl7M0U1GacKVp88OX1sXT/x8uST6IaqgrG8EjrdAlyL5oI4magk5/VjrPlhhWaRhD6bjig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz52dWhShDFEN2ew9Nmi3lEDVM120qIEJ2DDWpoJ/3JD2JS+5+o
	6af7z5C62hAo+dLy/IILiyDuggVJ2i1VE4czVN60H983m0txFzGr+KNMCiSDLWXUArTs4a3b/Hq
	FsMOZ6ZcmvGjQzIlbjQ==
X-Google-Smtp-Source: AGHT+IHr1vzwJlOP/N9hUoSgZv1OTnc7W/hqgpmkJ9cXGmTUp31a+0v0HLcst7oY7ucW9k1dE2oud1nljCHJgHo=
X-Received: from wmpz12.prod.google.com ([2002:a05:600c:a0c:b0:450:dca1:cf91])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2008:b0:3b3:9c94:eff8 with SMTP id ffacd0b85a97d-3b5e4537eb0mr1551411f8f.27.1752059255109;
 Wed, 09 Jul 2025 04:07:35 -0700 (PDT)
Date: Wed, 9 Jul 2025 11:07:34 +0000
In-Reply-To: <878qkyoi6d.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250704-iov-iter-v2-0-e69aa7c1f40e@google.com>
 <U16UjMBBh1b7dLeO-Nhqw__nw_JwypctB1ze_G44BtsX0l_eVK6Sp-efbobmnuF44J0wQNgnK7b8nCmBX0KS_Q==@protonmail.internalid>
 <20250704-iov-iter-v2-1-e69aa7c1f40e@google.com> <878qkyoi6d.fsf@kernel.org>
Message-ID: <aG5NdqmUdvUHqUju@google.com>
Subject: Re: [PATCH v2 1/4] rust: iov: add iov_iter abstractions for ITER_SOURCE
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Matthew Maurer <mmaurer@google.com>, Lee Jones <lee@kernel.org>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Benno Lossin <lossin@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Tue, Jul 08, 2025 at 04:45:14PM +0200, Andreas Hindborg wrote:
> "Alice Ryhl" <aliceryhl@google.com> writes:
> > +/// # Invariants
> > +///
> > +/// Must hold a valid `struct iov_iter` with `data_source` set to `ITER_SOURCE`. For the duration
> > +/// of `'data`, it must be safe to read the data in this IO vector.
> 
> In my opinion, the phrasing you had in v1 was better:
> 
>   The buffers referenced by the IO vector must be valid for reading for
>   the duration of `'data`.
> 
> That is, I would prefer "must be valid for reading" over "it must be
> safe to read ...".

If it's backed by userspace data, then technically there aren't any
buffers that are valid for reading in the usual sense. We need to call
into special assembly to read it, and a normal pointer dereference would
be illegal.

> > +    /// Returns the number of bytes available in this IO vector.
> > +    ///
> > +    /// Note that this may overestimate the number of bytes. For example, reading from userspace
> > +    /// memory could fail with `EFAULT`, which will be treated as the end of the IO vector.
> > +    #[inline]
> > +    pub fn len(&self) -> usize {
> > +        // SAFETY: It is safe to access the `count` field.
> 
> Reiterating my comment from v1: Why?

It's the same reason as why this is safe:

struct HasLength {
    length: usize,
}
impl HasLength {
    fn len(&self) -> usize {
        // why is this safe?
        self.length
    }
}

I'm not sure how to say it concisely. I guess it's because all access to
the iov_iter goes through the &IovIterSource.

> > +        unsafe {
> > +            (*self.iov.get())
> > +                .__bindgen_anon_1
> > +                .__bindgen_anon_1
> > +                .as_ref()
> > +                .count
> > +        }
> > +    }
> > +
> > +    /// Returns whether there are any bytes left in this IO vector.
> > +    ///
> > +    /// This may return `true` even if there are no more bytes available. For example, reading from
> > +    /// userspace memory could fail with `EFAULT`, which will be treated as the end of the IO vector.
> > +    #[inline]
> > +    pub fn is_empty(&self) -> bool {
> > +        self.len() == 0
> > +    }
> > +
> > +    /// Advance this IO vector by `bytes` bytes.
> > +    ///
> > +    /// If `bytes` is larger than the size of this IO vector, it is advanced to the end.
> > +    #[inline]
> > +    pub fn advance(&mut self, bytes: usize) {
> > +        // SAFETY: `self.iov` is a valid IO vector.
> > +        unsafe { bindings::iov_iter_advance(self.as_raw(), bytes) };
> > +    }
> > +
> > +    /// Advance this IO vector backwards by `bytes` bytes.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// The IO vector must not be reverted to before its beginning.
> > +    #[inline]
> > +    pub unsafe fn revert(&mut self, bytes: usize) {
> > +        // SAFETY: `self.iov` is a valid IO vector, and `bytes` is in bounds.
> > +        unsafe { bindings::iov_iter_revert(self.as_raw(), bytes) };
> > +    }
> > +
> > +    /// Read data from this IO vector.
> > +    ///
> > +    /// Returns the number of bytes that have been copied.
> > +    #[inline]
> > +    pub fn copy_from_iter(&mut self, out: &mut [u8]) -> usize {
> > +        // SAFETY: We will not write uninitialized bytes to `out`.
> 
> Can you provide something to back this claim?

I guess the logic could go along these lines:

* If the iov_iter reads from userspace, then it's because we always
  consider such reads to produce initialized data.
* If the iov_iter reads from a kernel buffer, then the creator of the
  iov_iter must provide an initialized buffer.

Ultimately, if we don't know that the bytes are initialized, then it's
impossible to use the API correctly because you can never inspect the
bytes in any way. I.e., any implementation of copy_from_iter that
produces uninit data is necessarily buggy.

Alice

