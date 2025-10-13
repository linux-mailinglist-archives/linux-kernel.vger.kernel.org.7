Return-Path: <linux-kernel+bounces-850210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDEABD23F2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4BB03C34AF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5382FD1D7;
	Mon, 13 Oct 2025 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IcrXebxS"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D2F2FBE1D
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760347220; cv=none; b=b8n3FakJbqMtSruy6dDMTUBd8XUcwwcBBRcHPupiqBmx8TtInjMq9KI17RSjemrjkegkjf4Y9awr3vSdbSR7uWAFH372dHzABH01JE0JEy0TzHhximeCWB1qEOx7qxsw4FQhe+33mdAvY3POc+sgQig7tWGk6Et2M3iOMNsN9S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760347220; c=relaxed/simple;
	bh=QauuifBIivV0CnP0lZumGXahaU8WwHf1ZmuHKkcj6i0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Djr9ompPcVlXKPm1qk3Y8m4PZy43I/SdfUcVkcyuhzBLfWTeviCGBIuFX7UY4SPQLIBkn+g2JUc4eiPBNn+AkBilYiiLp/3OGH8/X10k2U0h823b8T1+bN3ffJB9UK76l3e94RQWSDCzsF9bQskP5FgGoZAb7VxdH9+0v+CYqgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IcrXebxS; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e2c11b94cso27902215e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 02:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760347217; x=1760952017; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/YLIXxu3r1bT61bpUEMmybN5f7kCfaViovXYFbL3SjM=;
        b=IcrXebxSEc584xSJhl1w0zCtaFY68KOOBdmnVh0TtpOO9+CpYFnvOjqK16SvQt6Pha
         yS0KTnELubYytvxtAnFOxvL86uI73P8myh3QJ7D6pIhW74hPskA+mdSGqkFkCznygF9A
         +dguVKf9rwBmKuXMlH1CtAhYWibo5jvbGS8WQxqCRxwKMvqtC8sy+GKmlg7rhytAzyov
         ZT8bdQBpKMEW4WgUAhfeXpcHC/4nBDB9ISQD4RORJ/7qxuelSz9kCy/uP2lNCmcSuF91
         7uPD3mRAjbMDRFBAcjCbN7bhsQ1jfoksXmNANgoerQ+NXyi0gNFaCLDBN2GAwJuBfKDx
         mEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760347217; x=1760952017;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/YLIXxu3r1bT61bpUEMmybN5f7kCfaViovXYFbL3SjM=;
        b=G2MKLxNDKRXk774IF/KgEwLd5HqMqGzKnA8/r8/Lqxpy9SZV6gPpO4tY2NliligteF
         4bfS9hQDg5LUh4RGnit9Xen3uA3pIAATtvyH9p9ruq9BpWgG6AZmSrBBiBldJSkftwdt
         fEPwuIjSvqxEifDHbyegX8yJssOpsDPwj8iOg7btdKnfyTZFYZIhuB8kbTQRezDV9ott
         F192Y03OqSPBusbirBRoS/rV9ifwdQ9GWAp/7tg4cZ4eou4gGEh0pXUIzRqX6ATPioFU
         ThZHa+bR/s+SVDy4WS3Bj+bm3KnIdWPy3i4ACnPqdAdecO9BxQGPNynKfO0RbEGpzcEw
         Vc8g==
X-Forwarded-Encrypted: i=1; AJvYcCXCI+T6oWry4D+X5JKTTBVnElvq4u3U5JZtKleh1rbmJ9q43Nh615cAP0bP2KSBF8veElDbqtun9V6amOs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Mrym0FsMWMmvEAnXwXIzSVPKmnfNxVB++skPrLsdVzTHckTN
	XZzYKYxBI8xw5DtQddQoLdHzEtj9XeUpw2gaibQhvftywq4Y5m2xwHcBHByldppzGLNq4uV1xB3
	omXJlL90CPXHQ7ST72Q==
X-Google-Smtp-Source: AGHT+IHb6VBFw+s5vLpdfRpV683e8ptVQHwXIXwalC0rZp9VrZA2JvEvy5kZ5UvL/xduE9r47vW5HXPH+BxtecY=
X-Received: from wmlu17.prod.google.com ([2002:a05:600c:2111:b0:46e:2eb4:38d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4510:b0:46d:d949:daba with SMTP id 5b1f17b1804b1-46fa9a8f275mr139441695e9.4.1760347216682;
 Mon, 13 Oct 2025 02:20:16 -0700 (PDT)
Date: Mon, 13 Oct 2025 09:20:15 +0000
In-Reply-To: <20251013001422.1168581-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013001422.1168581-1-ojeda@kernel.org>
Message-ID: <aOzET46lagm-p8go@google.com>
Subject: Re: [PATCH] rust: bitmap: clean Rust 1.92.0 `unused_unsafe` warning
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Burak Emir <bqe@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="utf-8"

On Mon, Oct 13, 2025 at 02:14:22AM +0200, Miguel Ojeda wrote:
> Starting with Rust 1.92.0 (expected 2025-12-11), Rust allows to safely
> take the address of a union field [1][2]:
> 
>       CLIPPY L rust/kernel.o
>     error: unnecessary `unsafe` block
>        --> rust/kernel/bitmap.rs:169:13
>         |
>     169 |             unsafe { core::ptr::addr_of!(self.repr.bitmap) }
>         |             ^^^^^^ unnecessary `unsafe` block
>         |
>         = note: `-D unused-unsafe` implied by `-D warnings`
>         = help: to override `-D warnings` add `#[allow(unused_unsafe)]`
> 
>     error: unnecessary `unsafe` block
>        --> rust/kernel/bitmap.rs:185:13
>         |
>     185 |             unsafe { core::ptr::addr_of_mut!(self.repr.bitmap) }
>         |             ^^^^^^ unnecessary `unsafe` block
> 
> Thus allow both instances to clean the warning in newer compilers.
> 
> Link: https://github.com/rust-lang/rust/issues/141264 [1]
> Link: https://github.com/rust-lang/rust/pull/141469 [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>


