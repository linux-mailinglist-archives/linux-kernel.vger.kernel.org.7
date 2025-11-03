Return-Path: <linux-kernel+bounces-882654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C836C2B09D
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A6D188D88F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F7B2FDC2F;
	Mon,  3 Nov 2025 10:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t3psV4M8"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D7D2FD7DF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165652; cv=none; b=FFxaFx0wOsGa7JRnWcECtuEC3XgbYOO5xB0feGMmR+/TGSWmf6crSCJh7oIVf8YynxX2Xb/T4VPa7kz82iM/BuGVvWfk/oso4q7BQJ17CaVf1xv/NEod9p9m3rOfdF756pa5U5k4hLw59ReRSNwAww48niP41MOfuEv3D+/BBSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165652; c=relaxed/simple;
	bh=7d+yejdsrlH3QQoIfQu3T9oGfryOAb9jPCpBbY/QV74=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RITKDxkvscrOWPpnPgLKRp7wJnW15C4SbBq926xQpKkTBmbscHIu1b6WU5YoO90+ztRxEqmC74BkdZ0SiDvGcO/09BBQY/pmFpAqHEBreOSonywOix+K7pNIF0nWo5BurPZzaod9i5dBsXGQ5j3vqhCyGHArmf7g6V+zUmUrsig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t3psV4M8; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4774836c376so6570215e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 02:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762165647; x=1762770447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4JHB89kHBneKoONN1Bve8Z56wcJWNGQNkd4dI7+uRh8=;
        b=t3psV4M8sBiC5wL0AKipN6A3IrlFy0APywoz2aiucWz2VlZzGGW62hvg1om5xxf1Fd
         jkpcPT+k36GmhFs5gVUIHAS+fIGtZK5uYYAt3Hm3ZiIN7a1wBNICHYAu7+0zsAWcFpbQ
         H+rkZLZMdKms592MzVJbfytz/8YOK65QQK6XBDrKDxBgdR8nEYA2ZMV2cPEQ90hL7OBt
         QRcPM2LKD9SIiD3hiaoD1uyOwe5f2+kLhk0bczMPORe8pWHX6/nQ1qC517fFB1jr2ipz
         vfCJzyilaeUPK4zXEc5S7pld8HT/FBKVhFd7tmU25nC2f/MdR1JPDBzTUBlHTJfQIf9J
         7o9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762165647; x=1762770447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4JHB89kHBneKoONN1Bve8Z56wcJWNGQNkd4dI7+uRh8=;
        b=m8OOwiFhLs5uJwetVJ1mYGaToqlA0qMUeRCLdCrOvw5SMmpeZNXL+HZ+TP3CyAYcRC
         ogfpbOUTg9pJuMUF1t/C3Y203F3M5N7wskXKEbWb65yH09QRo02lCS+fXQK8Lxq9Kcfb
         dYWEJ3uy5eHI3/89TeqEgwsSouhQxAF4vS/8iHW443njpfJWTEGHTzbYyEpOFsYBzhVJ
         d9RMTyhn/UZ5F0g0jaExaqP/3wOL3j14nCOvwKf/g156x/g9PSGvwqD0eX9qNkASmKS1
         QqaDTgPGGrWDeh69+tJTuxKldHxg7Ql7EEiAA64+E5/mY3433AsypdyBoshUoQNt89J3
         KzFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWeMhNqy+HxeYhg0ciRHwZ2AV7TXWv+aERmOEzRCnYcbayQG0nYQSdDajdyH3Wp38y+hGtpggMtYFri3E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy40zlWBGQ0/zIG8su9y42820xvFvehxh6iO0+pVWGOIPWCgDdP
	F2/e3rCCe9KN2L06T2nsnPER47xhSgUZXHQkO3MDcLCa9eOxac+Ov0DawjJrCBH8EZ8iGaJpNXB
	n/6R61icGvZwg7Nr2ng==
X-Google-Smtp-Source: AGHT+IEOG3seXsKMf1FLja+ssKrdPSGK1FgK6Bcd/d5/Kurpa+pvamoJuJNwVwnI8+e1f24CsMe+Xpt2EsZzMZQ=
X-Received: from wmlf12.prod.google.com ([2002:a7b:c8cc:0:b0:477:d21:4a92])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:538e:b0:46e:33b2:c8da with SMTP id 5b1f17b1804b1-47730890e99mr120076125e9.32.1762165647584;
 Mon, 03 Nov 2025 02:27:27 -0800 (PST)
Date: Mon, 3 Nov 2025 10:27:26 +0000
In-Reply-To: <20251102212853.1505384-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251102212853.1505384-1-ojeda@kernel.org>
Message-ID: <aQiDjuHK0qpgmj1J@google.com>
Subject: Re: [PATCH 1/2] rust: kbuild: treat `build_error` and `rustdoc` as
 kernel objects
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

On Sun, Nov 02, 2025 at 10:28:52PM +0100, Miguel Ojeda wrote:
> Even if normally `build_error` isn't a kernel object, it should still
> be treated as such so that we pass the same flags. Similarly, `rustdoc`
> targets are never kernel objects, but we need to treat them as such.
> 
> Otherwise, starting with Rust 1.91.0 (released 2025-10-30), `rustc`
> will complain about missing sanitizer flags since `-Zsanitizer` is a
> target modifier too [1]:
> 
>     error: mixing `-Zsanitizer` will cause an ABI mismatch in crate `build_error`
>      --> rust/build_error.rs:3:1
>       |
>     3 | //! Build-time error.
>       | ^
>       |
>       = help: the `-Zsanitizer` flag modifies the ABI so Rust crates compiled with different values of this flag cannot be used together safely
>       = note: unset `-Zsanitizer` in this crate is incompatible with `-Zsanitizer=kernel-address` in dependency `core`
>       = help: set `-Zsanitizer=kernel-address` in this crate or unset `-Zsanitizer` in `core`
>       = help: if you are sure this will not cause problems, you may use `-Cunsafe-allow-abi-mismatch=sanitizer` to silence this error
> 
> Thus explicitly mark them as kernel objects.
> 
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
> Link: https://github.com/rust-lang/rust/pull/138736 [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

