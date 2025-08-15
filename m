Return-Path: <linux-kernel+bounces-770415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA709B27A78
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2CE6046C4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A332D0C6E;
	Fri, 15 Aug 2025 07:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qj9AzmOc"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59CC2C2AA2
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755244648; cv=none; b=hfBuJk8ZYl/vFTlNDMppYbk4p7YLg9evd1BWEaci5mpZsY4FoEafUYq4yP7d6B/tzCz8AFpVSPbHzVE9VTdj8FIOD9v5RmMFZp9L6jK5NaqiO6ZeC/Bcq89xTpKF0YY9mcNRGnEQnrRqINgTGKdW7as2ZDCZ5CIlgaR84I6IKYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755244648; c=relaxed/simple;
	bh=S3PyHRya11+qZZoLBhC4j0hGymegURexx3ja0gfDP5k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f+sUGI0jc2HP0lWhZcsINqGcn6f9J+RY+ACaq1v1yQ3nMmNSUW7We48FVVTMC4j/btfMwWenWO0hXarB5PDFpyIcQINBzV/vawryiDtA0MsPaDEakUBMRSyckhAZ094xkArTpm8QgOBEt6C+K8rorZEf3IEOY333PJ2EGeOhviU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qj9AzmOc; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3b9d41b82beso1303182f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 00:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755244644; x=1755849444; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JliYzecp+8vx7iCZ9GJLeCQ8PS5q6wpUw4vUME/s30E=;
        b=qj9AzmOcz3WUQgVM4tdjs3eex1wsrDoeEJjNl3xnmVMPb08wEluHqA++N9Fe7RHUdB
         QR0b4yXBfF5tJAYpDB6hsjyDuZf3pCQeYscuguRifQSaarqsHpJRBANyLjoEqyWUhgbR
         lhZdNA9lHGeod6htN/XYU+av0ljusDFLNfNDPkOhYbxOyd7yuXTi1H85sB8WZ9ywbT2Y
         d8KjLBdBQXU2+Q1xSHWszHt6DrKyKktAjc5IYK1sf9KBMd+f1e9/XEKCDpQTVK1Emlxs
         ezwn/XtSjmuYQwV0zkwVOjcEZj2rdyf6u8O3OrJzggQhl0M30WNnABVso9ChiDg8rjlN
         QGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755244644; x=1755849444;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JliYzecp+8vx7iCZ9GJLeCQ8PS5q6wpUw4vUME/s30E=;
        b=rK2PlfBxpQUaO9q+Dq/pKkPSQeF1vPScfhR3o/Co1fiibsQ4C5gcvq9eT0coU0OtfB
         aR3ctFFWCPQJIl4o919QLMNICE8tn3GwmK0bsFfV6Y7KwZqCEXPkXg0ChQi9GaBUu6p3
         MXRhRKeoNqeEV1EN4/ApI9y5xNbG13H7xy0mnO9Ih2IAn2IwgGWrikYhcxNwkRLe/gDO
         PlfZunq9pl5ZrrIVpK5ynhgN6lnrWec4ZZ1Ji3h++NlVHhAjqhfKr2SKLB21XAJTOFes
         3K14tubo4JlANNYDGnj5MLQYW/ZTBtouRqP1CCBOL2Z4koMfhQwR2xhHPuVPBtITJ9t7
         BTHA==
X-Forwarded-Encrypted: i=1; AJvYcCU6DB1QkrgVi9vi6IoHZkxXxYTv0xdKKzoAQj+qq88yByQSTQeMUn3v3ISYY4qRxi7vyFJsAEGdWlgKEOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzb//WYAtOjn9qT+Wvxeo/FZnXcwagHehnkWDw+PBIEs+vrI0m
	sFZ/8TKIClpNs3dER1L3aUdEm4fhARa/XKjoDbuk/4F8sCSmL84/achZTuFlrxtImp3xe2fOuId
	BG43t8+c8tCrfXUkr4Q==
X-Google-Smtp-Source: AGHT+IF4UAIGeGPcDCFJRIRqOWfB2t00wIC/GdVYBLo4fLARPgG9tdEIjrdMKNGCFc4KqwkU7tZqFWVeQcaemCw=
X-Received: from wmbep25.prod.google.com ([2002:a05:600c:8419:b0:456:2003:32a5])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5850:0:b0:3a4:e68e:d33c with SMTP id ffacd0b85a97d-3bb693b1d7dmr874644f8f.47.1755244644250;
 Fri, 15 Aug 2025 00:57:24 -0700 (PDT)
Date: Fri, 15 Aug 2025 07:57:23 +0000
In-Reply-To: <20250815-rnull-up-v6-16-v5-5-581453124c15@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org> <20250815-rnull-up-v6-16-v5-5-581453124c15@kernel.org>
Message-ID: <aJ7oY9pxlrnfAv8s@google.com>
Subject: Re: [PATCH v5 05/18] rust: str: introduce `kstrtobool` function
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Breno Leitao <leitao@debian.org>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Aug 15, 2025 at 09:30:40AM +0200, Andreas Hindborg wrote:
> Add a Rust wrapper for the kernel's `kstrtobool` function that converts
> common user inputs into boolean values.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/str.rs | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index d8326f7bc9c1..5611f7846dc0 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -4,6 +4,7 @@
>  
>  use crate::{
>      alloc::{flags::*, AllocError, KVec},
> +    error::Result,
>      fmt::{self, Write},
>      prelude::*,
>  };
> @@ -920,6 +921,63 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
>      }
>  }
>  
> +/// Convert common user inputs into boolean values using the kernel's `kstrtobool` function.
> +///
> +/// This routine returns `Ok(bool)` if the first character is one of 'YyTt1NnFf0', or
> +/// \[oO\]\[NnFf\] for "on" and "off". Otherwise it will return `Err(EINVAL)`.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// # use kernel::{c_str, str::kstrtobool};
> +///
> +/// // Lowercase
> +/// assert_eq!(kstrtobool(c_str!("true")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("tr")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("t")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("twrong")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("false")), Ok(false));
> +/// assert_eq!(kstrtobool(c_str!("f")), Ok(false));
> +/// assert_eq!(kstrtobool(c_str!("yes")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("no")), Ok(false));
> +/// assert_eq!(kstrtobool(c_str!("on")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("off")), Ok(false));
> +///
> +/// // Camel case
> +/// assert_eq!(kstrtobool(c_str!("True")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("False")), Ok(false));
> +/// assert_eq!(kstrtobool(c_str!("Yes")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("No")), Ok(false));
> +/// assert_eq!(kstrtobool(c_str!("On")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("Off")), Ok(false));
> +///
> +/// // All caps
> +/// assert_eq!(kstrtobool(c_str!("TRUE")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("FALSE")), Ok(false));
> +/// assert_eq!(kstrtobool(c_str!("YES")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("NO")), Ok(false));
> +/// assert_eq!(kstrtobool(c_str!("ON")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("OFF")), Ok(false));
> +///
> +/// // Numeric
> +/// assert_eq!(kstrtobool(c_str!("1")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("0")), Ok(false));
> +///
> +/// // Invalid input
> +/// assert_eq!(kstrtobool(c_str!("invalid")), Err(EINVAL));
> +/// assert_eq!(kstrtobool(c_str!("2")), Err(EINVAL));
> +/// ```
> +pub fn kstrtobool(string: &CStr) -> Result<bool> {
> +    let mut result: bool = false;
> +
> +    // SAFETY: `string` is a valid null-terminated C string, and `result` is a valid
> +    // pointer to a bool that we own.
> +    let ret =
> +        unsafe { bindings::kstrtobool(string.as_char_ptr(), core::ptr::from_mut(&mut result)) };

Using ptr::from_mut here seesm excessive IMO. I think that function
makes sense when it replaces an explicit `as` cast, but now when it can
be done by a coercion. This is perfectly readable:

let ret = unsafe { bindings::kstrtobool(string.as_char_ptr(), &mut result) };

Or if you insist, you could directly create a raw pointer:

let ret = unsafe { bindings::kstrtobool(string.as_char_ptr(), &raw mut result) };

Alice

