Return-Path: <linux-kernel+bounces-723692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECFDAFEA01
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2744B3A81FE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D211C2DCF5B;
	Wed,  9 Jul 2025 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KIifaTmK"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899C9276025
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067390; cv=none; b=hG6nr1ae0li2GoKY6lAA4gMAgQJe5CTOHq4Z2SUPb0sORXtzdQqkHqSZt+Jcu+jOSxYSejUloeM7jgVCKpL+GRnX0eS3Vtd1mY5j9ub96iopMgeAxl+dspCxXLAaIxPA5epVHuW4s0guRmBoBABflTd47XXp7TMXfgBOcQAQXrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067390; c=relaxed/simple;
	bh=oLihLmGKr765QwW6yOTYbdJj4ra7Xr28+HppMym6oZ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p1cXnaib2xq1hWCtcN6F0Z9OcM/VIDstVIfkqcTIgW2hra7v5MJDT7QF0DNOiTJ+GsycNjo+O7AOvlEvQtt9prSU6UKkPjo0/OxH3n86EpJE2YjWfupw5u2QDYdAp84pPPcORHp5EDndQ1D9U5FTkhvl7eFyUiIifABEa4cD0yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KIifaTmK; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-451d30992bcso41040895e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 06:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752067387; x=1752672187; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kgEZMQ9Ie8rjRKEQijQn/j/EhVux9NWCg6JTzmKrPW0=;
        b=KIifaTmKkAz5cVAvvU0Cq9tTSVHCVLmxg0mVRHamICmO/nVY8Bu/IZV0jDH2Krrb8X
         tlU3bH3Wb6BqEswLmI4LGro6LZwLOOUX6vHDvTapdUHCxQQlBZ0ljsDprQvmuep4fMFZ
         1A7a6344CStfafQaDgh3P3h5D8cUhMD2yE0XQuUOcrSuzDO8Hj/QOEDDq8VYQv0xQL8a
         6q7ooquVYGC5aZP8QJHuhBKKxuQ8OjwxKH6eWbFXYTTnXRAD5JsUTfN1PrZXYqG9x7HG
         iWG7hemQ77wWclhBtHod5HeoksxREHSX7VABBGqMz8dw79E3ruKVM9SXqMM6+F5YR811
         WWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752067387; x=1752672187;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kgEZMQ9Ie8rjRKEQijQn/j/EhVux9NWCg6JTzmKrPW0=;
        b=GHGnWeF3u2SP1NRDzCvOVbVNLbt3cGGZk/xleJ2cSxCYcEvkzVe7L9FCfcfV6BCStJ
         +AYnf9IuZ8AhcMrpMnV4HqJnikrWnO0ORLhCKJzhLubONuHEZ0kf07293BahdVggK3Es
         fbiNf3ZdRoUFhuKi44aBNZ/tWKXknsyPw0hH1Mt4YJMTo8aDEksDr7FF5BO6rpQ80QAl
         Sjokgnwm+yh8PbH4AK1xapA21O+zx82taqDdsVBDf9cD5wULQxMxE17Dxyg0kaxRPy5o
         xTq2Z9FwZ4e4nfl25SkT1AMeyriyFX0YicS+IzBiFgGA3mCCkFT7BR8q+Fg5WHmh5S1v
         ZitQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj12lXdbIySwtoXd5Qxr2lffcGtKVu6/YgHRHsgJYnwYOqnD0rn5a1TeArZtB8IHXoTx8vGH/Nt8W5K/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0xqwup7S1tKfMiWyvgTESMkdA6BsUdRV+V+OTEfi6nPlTibQt
	s5WU1JDW2WOpfmzJEcsXL27XRyETKq+/WBQcDP59pDIrwciCA8qk8T2jWJUnxdgiOJ8RrhRg6xn
	Ag50N1ON8EP9zXRIrOg==
X-Google-Smtp-Source: AGHT+IHb5fOkVKQdzNuZzdCQyevCzD2sZ596OHAKOrb01PKV0SZTCwDTR8YFS/+ZmLNpsMuKr3dLp1O8HwuNHMI=
X-Received: from wmbez5.prod.google.com ([2002:a05:600c:83c5:b0:453:ec2:c7bd])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:314c:b0:43c:f44c:72a6 with SMTP id 5b1f17b1804b1-454d5311363mr24682575e9.2.1752067386947;
 Wed, 09 Jul 2025 06:23:06 -0700 (PDT)
Date: Wed, 9 Jul 2025 13:23:05 +0000
In-Reply-To: <20250708-rnull-up-v6-16-v2-3-ab93c0ff429b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250708-rnull-up-v6-16-v2-0-ab93c0ff429b@kernel.org> <20250708-rnull-up-v6-16-v2-3-ab93c0ff429b@kernel.org>
Message-ID: <aG5tObucycBg9dP1@google.com>
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

On Tue, Jul 08, 2025 at 09:44:58PM +0200, Andreas Hindborg wrote:
> Add `NullBorrowFormatter`, a formatter that writes a null terminated string
> to an array or slice buffer. Because this type needs to manage the trailing
> null marker, the existing formatters cannot be used to implement this type.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/str.rs | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index 78b2f95eb3171..05d79cf40c201 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -860,6 +860,65 @@ fn deref_mut(&mut self) -> &mut Self::Target {
>      }
>  }
>  
> +/// A mutable reference to a byte buffer where a string can be written into.
> +///
> +/// The buffer will be automatically null terminated after the last written character.
> +///
> +/// # Invariants
> +///
> +/// `buffer` is always null terminated.
> +pub(crate) struct NullBorrowFormatter<'a> {
> +    buffer: &'a mut [u8],
> +    pos: usize,
> +}

Do you need `pos`? Often I see this kind of code subslice `buffer`
instead.

> +impl<'a> NullBorrowFormatter<'a> {
> +    /// Create a new [`Self`] instance.
> +    pub(crate) fn new(buffer: &'a mut [u8]) -> Result<NullBorrowFormatter<'a>> {
> +        *(buffer.first_mut().ok_or(EINVAL)?) = 0;
> +
> +        // INVARIANT: We null terminated the buffer above.
> +        Ok(Self { buffer, pos: 0 })
> +    }

I would probably just use an Option for this constructor.

> +    #[expect(dead_code)]
> +    pub(crate) fn from_array<const N: usize>(
> +        a: &'a mut [crate::ffi::c_char; N],
> +    ) -> Result<NullBorrowFormatter<'a>> {
> +        Self::new(
> +            // SAFETY: the buffer of `a` is valid for read and write as `u8` for
> +            // at least `N` bytes.
> +            unsafe { core::slice::from_raw_parts_mut(a.as_mut_ptr().cast::<u8>(), N) },
> +        )
> +    }

Arrays automatically coerce to slices, so I don't think this is
necessary. You can just call `new`.

> +    /// Return the position of the write pointer in the underlying buffer.
> +    #[expect(dead_code)]
> +    pub(crate) fn pos(&self) -> usize {
> +        self.pos
> +    }

You delete this function in one of the later patches, so it makes more
sense not to add it.

> +}
> +
> +impl Write for NullBorrowFormatter<'_> {
> +    fn write_str(&mut self, s: &str) -> fmt::Result {
> +        let bytes = s.as_bytes();
> +        let len = bytes.len();
> +
> +        // We want space for a null terminator
> +        if self.pos + len > self.buffer.len() - 1 {

Integer overflow?

> +            return Err(fmt::Error);
> +        }
> +
> +        self.buffer[self.pos..self.pos + len].copy_from_slice(bytes);
> +        self.pos += len;
> +
> +        // INVARIANT: The buffer is null terminated.
> +        self.buffer[self.pos] = 0;
> +
> +        Ok(())
> +    }
> +}
> +
>  /// An owned string that is guaranteed to have exactly one `NUL` byte, which is at the end.
>  ///
>  /// Used for interoperability with kernel APIs that take C strings.
> 
> -- 
> 2.47.2
> 
> 

