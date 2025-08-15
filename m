Return-Path: <linux-kernel+bounces-770436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D96B27AB5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D518682191
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650E527FB2B;
	Fri, 15 Aug 2025 08:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XPtGS6EC"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5F722A4F4
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 08:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755245570; cv=none; b=sS7PusR0q2yxwIzr9CMLlY2wR8wrSNMVy5G9uVqezJX1TgSXKdN8xq4SrMjpVSVe49DJd+jGIR6L3KMmUBwlouMdlKTOq4xHnmMpRftZx0rtf0npDbO+9RRfIZLcBxwkRmAnlEUo5XPEntQqxl2QEvr3NVuFSju/5aoQRpzHtEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755245570; c=relaxed/simple;
	bh=abhrhcISpQjbyoZdKXYTQQvSjPCiAbh+YQdM6HuPjgw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LBrCNiFIoguh/2ri8q/K4ZZ2YRJf83QVMyrxSilF/JpF6tbZDEyN5uQX5joS6A0XHGFUmYAZ853d+EkxWATc+3ASc4OPHu6dOMGe+HtysdwBd8KNEgstfgS1uH5ZLQSWDvXCiTVkBEia3aL4s+QhdF3nXGNX/m1PVHJvhUbNZ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XPtGS6EC; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1b0cb0aaso10553465e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755245566; x=1755850366; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BUuLc6GQjc6I3bOha/5f7UPoVVJZ0dlyEwJUu9zoAI0=;
        b=XPtGS6ECWHx1cp5EPoxTOS+/Q8aYHN33m8H48dnkFACDmbdaoJ2iBPmORHYjsRs9/e
         iMuUgWCaUJRLvZNEeCGJ6RX12JiUj3FgRTh9H/tCpyAOnhZvkSkPHisPTks30FbxdSft
         OWR5hAhyMHoh5Vro8cM7EXXKZweS0Jhs7zBFY8ctr5kssHF01bYIoAEdqemjTDMrBjgg
         ZtmyU+jQVPYv5Gae4L415L+j7acAsbA0F+0jZe0SWKTwCCAUvRrEkppzl8YI3fK7CYUK
         Zgf9EWoG0u2zrAYLyQXjgmUfwo+mvm9wCDT7obeRuF/v/A4M72olQJa0hms6tohoRlJA
         OnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755245566; x=1755850366;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BUuLc6GQjc6I3bOha/5f7UPoVVJZ0dlyEwJUu9zoAI0=;
        b=WzzlUT3BFABDTPGmD/HidBbvkuCSDgByuv/kSG1cH9L8I5CZH1zdLuXgMXAHxmLYJD
         2rah5UX8y81TelORiMiz32m7rU0SfO35mV6KIWNlBj9ZAXy3oXmQ66jQK3jYz3MdcA/k
         k1vSr0sXArnzbVkB7XOBLC52J8pN/+gkNcqe0+EtHxOtpEelgHO/afXAftsnrDDhWnEx
         B/Vco/bh18Of9pT7dQdZzg0T2IwZ/slzg9stdkK3fae/T/RuHBGBJirMiPvysA+S6sHp
         IfSaYkJR6M2/2hM5GHsnkL6TUBcUOYqkcuDJJOfQbl2ytpVfTDIFsggh1tMO8HnXQX+9
         tCBg==
X-Forwarded-Encrypted: i=1; AJvYcCX0/L38sGi716zJAAq585ipSbNjFUjRqXrTJG+GHnbLGKW7a3LTlz83e/LaWiNg6cEXi5DV6TfXzX5M7FU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFXm4CUmVVOumQcxcikRZrWvk3AA3jhAqLUx+kNIA1DoNpJJIt
	egn7UU562TqqfLPIo8wDBdHZ368EYWOq5+8XZvbf7TTTNsYReFNJivuci+nx1hK6soO8saKRgCr
	gGEWcr1IGT3fRL6vnnQ==
X-Google-Smtp-Source: AGHT+IHe7CyNgbL/lpgK6820FIeZcTErDvAuNK2XAyJAFEs6HJRHhOHCUqfeT/GDizrcAd4+Ao4Fdo22KSX1xrc=
X-Received: from wmbeq15.prod.google.com ([2002:a05:600c:848f:b0:459:d6d6:554d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:138f:b0:459:dde3:1a33 with SMTP id 5b1f17b1804b1-45a218631eamr9819375e9.26.1755245566429;
 Fri, 15 Aug 2025 01:12:46 -0700 (PDT)
Date: Fri, 15 Aug 2025 08:12:45 +0000
In-Reply-To: <20250815-rnull-up-v6-16-v5-6-581453124c15@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org> <20250815-rnull-up-v6-16-v5-6-581453124c15@kernel.org>
Message-ID: <aJ7r_W0BzdSYMfT6@google.com>
Subject: Re: [PATCH v5 06/18] rust: str: add `bytes_to_bool` helper function
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Breno Leitao <leitao@debian.org>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Aug 15, 2025 at 09:30:41AM +0200, Andreas Hindborg wrote:
> Add a convenience function to convert byte slices to boolean values by
> wrapping them in a null-terminated C string and delegating to the
> existing `kstrtobool` function. Only considers the first two bytes of
> the input slice, following the kernel's boolean parsing semantics.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/str.rs | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index 5611f7846dc0..ced1cb639efc 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -978,6 +978,16 @@ pub fn kstrtobool(string: &CStr) -> Result<bool> {
>      kernel::error::to_result(ret).map(|()| result)
>  }
>  
> +/// Convert `&[u8]` to `bool` by deferring to [`kernel::str::kstrtobool`].
> +///
> +/// Only considers at most the first two bytes of `bytes`.
> +pub fn bytes_to_bool(bytes: &[u8]) -> Result<bool> {
> +    // `ktostrbool` only considers the first two bytes of the input.
> +    let nbuffer = [*bytes.first().unwrap_or(&0), *bytes.get(1).unwrap_or(&0), 0];
> +    let c_str = CStr::from_bytes_with_nul(nbuffer.split_inclusive(|c| *c == 0).next().unwrap())?;
> +    kstrtobool(c_str)
> +}

Ouch. That's unpleasant. I would probably suggest this instead to avoid
the length computation:

/// # Safety
/// `string` is a readable NUL-terminated string
unsafe fn kstrtobool_raw(string: *const c_char) -> Result<bool> {
    let mut result: bool = false;
    let ret = unsafe { bindings::kstrtobool(string, &raw mut result) };
    kernel::error::to_result(ret).map(|()| result)
}

pub fn kstrtobool(string: &CStr) -> Result<bool> {
    // SAFETY: Caller ensures that `string` is NUL-terminated.
    unsafe { kstrtobool_cstr(string.as_char_ptr()) }
}

pub fn kstrtobool_bytes(string: &[u8]) -> Result<bool> {
    let mut stack_string = [0u8; 3];

    if let Some(first) = string.get(0) {
        stack_string[0] = *first;
    }
    if let Some(second) = string.get(1) {
        stack_string[1] = *second;
    }

    // SAFETY: stack_string[2] is zero, so the string is NUL-terminated.
    unsafe { kstrtobool_cstr(stack_string.as_ptr()) }
}

Alice

