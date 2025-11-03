Return-Path: <linux-kernel+bounces-882653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6795CC2B0B4
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D1D54F0D14
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040AE2FD7D9;
	Mon,  3 Nov 2025 10:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zIxJkZKH"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D792FDC4F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165626; cv=none; b=ON4Wi0fZi16mT15VYSyj6CoOg6tluTjPBH+jG2G9l4oIQzXms9BbcwbPS2gA+T0FPu8l8iljJF9wC6Ufwb+U1gw9MjCSs79JTpaz23W3gvpq03l7uO2AeijXo7HKa1uxHqjKFjUjbut8lZJ7vLw8/V4vu+Rlg5XPACX4csN0e6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165626; c=relaxed/simple;
	bh=zeOd2iozLHY5E9/h0Dlh5Vw9vcim7rHAVynPoeVlDd8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=na4HMGxyw6RMJTvaaftnIvQIcTrbKJiwWALHwgJKt+2QFprJdAVGHkPTWLgUwF737mIZUCdzT4eSeixnAn8jgTSN0xWjEgLtIcIlj9brfxnLL1hsJGHnyqwcOLQalGATkE7gYUfYOgAJWWg4d6vQ2h0P7Gm7kG5liqLkLIWG7oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zIxJkZKH; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-640b3754206so855789a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 02:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762165622; x=1762770422; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wfDOrMXlo4clgAlmd0PnLLaSk5oU7JsCtleVfGyOwWI=;
        b=zIxJkZKHSZ3lz3lJLBL+zcCRrFzuoWJeOor3hsp6P+YtJAJPCG37FeEze8N69kb5UD
         GW7694VoF4U5fMr2+632bubmariUisxjfBr9V5UmWcvF11ZrtJegEM89VN+g3h1pr22B
         GLHXqIfJ/eIiP/uwPiORfCtjwf2pSkxzv9O817JXvtIs6TRyqTFQa1k0jlE0kzcyrx8u
         EYJ5Lrg+HooYSBe2k5bPThTZYf7UzUmCZ8gZ15y78rwc+aDVA1eONWYtUQMOj4QJRB5+
         THO01hJ+Be0ZlyVfQMQkHL/lrxo9Go9wzmpICGvycLMeqf/IcJTLKsMf8vUjT9WHw1Kg
         VrpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762165622; x=1762770422;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wfDOrMXlo4clgAlmd0PnLLaSk5oU7JsCtleVfGyOwWI=;
        b=K3hqPBoHi9+YK0I9A4Wjcy0KCjkaDVD+CYpkEHXS7FjmJAzWCdDQOe3sr+TljaLnhq
         nezvW5OCJWx0+0wV5kmPtvsmbSQXDJpCqUoQsqk+3jLv6yMBPzI628Gr3QgWp6FPh1I4
         PNj9dhLpH3ebIR0h38cCCL8PI64PFJdzn1Ra8lFmDiwBga1kk62EbDuoamB8Z3U+U779
         1Qthn1M0/44tEkCs6Ivba2+EaYGjQ+U6LsJkHcVwzr8N78nkxwEL5GvS0+28oeHrTDdz
         nXU3dcDRyXrZCaWYvDHvvbTlMBlIIzskUXCTgNoQCsrVgDvSBuNvhjDQ0DHF+7dUAdh2
         pcFA==
X-Forwarded-Encrypted: i=1; AJvYcCVIhE5d2uBTsSUN8lAOs1XSbe28DPkmPvnfbNY6oS+FUm1Yzg9DlvwYxM6WcrXaRC5GmEK7f51H+p+jj78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6J/ThbtIcP2YrABLvNdzmjbva37V4tPeZ22mdthw0HUwJcV3C
	eMCs/v+WtcN7EKdsBV0vpAzQFAlNZvz5DQtLu84DTb9if5OADx7/4GRt5w4Zsd4m9ekCd+e2HAX
	8zAlbkR40/Fy+FpRGKA==
X-Google-Smtp-Source: AGHT+IHA/3waiBho0mXu28WwEu1WqeXYiiwR6bIsXlP4vDe3/Ww+rW0qIjmyU+AvmPyU6HG0yyjcIpqx3mZy7js=
X-Received: from ednd3.prod.google.com ([2002:a50:f683:0:b0:640:9915:7946])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:42d2:b0:639:4c9:9c9e with SMTP id 4fb4d7f45d1cf-64076f745edmr9836758a12.10.1762165622423;
 Mon, 03 Nov 2025 02:27:02 -0800 (PST)
Date: Mon, 3 Nov 2025 10:27:01 +0000
In-Reply-To: <20251102212853.1505384-2-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251102212853.1505384-1-ojeda@kernel.org> <20251102212853.1505384-2-ojeda@kernel.org>
Message-ID: <aQiDdZvRNrBkrB-U@google.com>
Subject: Re: [PATCH 2/2] rust: kbuild: workaround `rustdoc` doctests modifier bug
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sun, Nov 02, 2025 at 10:28:53PM +0100, Miguel Ojeda wrote:
> The `rustdoc` modifiers bug [1] was fixed in Rust 1.90.0 [2], for which
> we added a workaround in commit abbf9a449441 ("rust: workaround `rustdoc`
> target modifiers bug").
> 
> However, `rustdoc`'s doctest generation still has a similar issue [3],
> being fixed at [4], which does not affect us because we apply the
> workaround to both, and now, starting with Rust 1.91.0 (released
> 2025-10-30), `-Zsanitizer` is a target modifier too [5], which means we
> fail with:
> 
>       RUSTDOC TK rust/kernel/lib.rs
>     error: mixing `-Zsanitizer` will cause an ABI mismatch in crate `kernel`
>      --> rust/kernel/lib.rs:3:1
>       |
>     3 | //! The `kernel` crate.
>       | ^
>       |
>       = help: the `-Zsanitizer` flag modifies the ABI so Rust crates compiled with different values of this flag cannot be used together safely
>       = note: unset `-Zsanitizer` in this crate is incompatible with `-Zsanitizer=kernel-address` in dependency `core`
>       = help: set `-Zsanitizer=kernel-address` in this crate or unset `-Zsanitizer` in `core`
>       = help: if you are sure this will not cause problems, you may use `-Cunsafe-allow-abi-mismatch=sanitizer` to silence this error
> 
> A simple way around is to add the sanitizer to the list in the existing
> workaround (especially if we had not started to pass the sanitizer
> flags in the previous commit, since in that case that would not be
> necessary). However, that still applies the workaround in more cases
> than necessary.
> 
> Instead, only modify the doctests flags to ignore the check for
> sanitizers, so that it is more local (and thus the compiler keeps checking
> it for us in the normal `rustdoc` calls). Since the previous commit
> already treated the `rustdoc` calls as kernel objects, this should allow
> us in the future to easily remove this workaround when the time comes.
> 
> By the way, the `-Cunsafe-allow-abi-mismatch` flag overwrites previous
> ones rather than appending, so it needs to be all done in the same flag.
> Moreover, unknown modifiers are rejected, and thus we have to gate based
> on the version too.

Ah .. we may want to file a bug for that.

> Finally, `-Zsanitizer-cfi-normalize-integers` is not affected, so it is
> not needed in the workaround.
> 
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
> Link: https://github.com/rust-lang/rust/issues/144521 [1]
> Link: https://github.com/rust-lang/rust/pull/144523 [2]
> Link: https://github.com/rust-lang/rust/issues/146465 [3]
> Link: https://github.com/rust-lang/rust/pull/148068 [4]
> Link: https://github.com/rust-lang/rust/pull/138736 [5]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

