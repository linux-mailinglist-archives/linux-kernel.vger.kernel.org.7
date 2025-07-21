Return-Path: <linux-kernel+bounces-739237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D467CB0C3BD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18726540BF6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F632D0C69;
	Mon, 21 Jul 2025 11:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n7iIJYOI"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4043D2BE7BB
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 11:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753098984; cv=none; b=VEusP1dnXuhKPbFhnPjtbUqtBYyu7rI9CNOVRWxogAD97hPy5sPRu17uBtxZQ9PHjxBewGpKkwBz/k+Ig7HUvS7h47xmcamDMDnNEtwNc891TH4QbxeTuEA3bSKD4wgkYgqLBybj2IlFIqngzpMUACNS6X54NLvZKj7/NWMWkvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753098984; c=relaxed/simple;
	bh=MQgb7py7kA8qFAawQP8Xi376AvWUHjEvnrKVu5HiRW0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CTIaYQpRVlOZcs2Ep7OhjgISNZzkZYImnsF/Gfw6I5fXG16pgQkTJl6K/cP+4QbYCY9h/w5LXvaaKMGgX6dTc0HICpINft+gOAncA/NG2cJC9f1VriQ8/KlRKT3J8jFAP85G7CPAt/MWont9MXFrUdt2IFZD4uR3rVwmpKRt6cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n7iIJYOI; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a50049f8eeso2360341f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 04:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753098982; x=1753703782; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PYI2UsizWZCb5wSLeFRus42pLlQIGazAov/EfOWZBzY=;
        b=n7iIJYOIi99dqjdXw3F78PY7/Oq4SV836RA34ANPCGA5S05BnRLXPYvmoDDBFHKeXT
         6nOqCQA8XycC9r1vYKI0D1BCP+y/GNrD7WC32WRs6SnlwUV8l2VIkGxiG2gi8k7QdcPC
         +WsN9ANlRBswM1VDlo4EWb1y8ahbN6w9JNPmLWErkV8xDuXpY6JLvBWOzFRTR5YHHanK
         57dWSmn9WpmlelpFQDKn3BiTGWIlUGeC+hl9z1c21ERqEzm3JXz2r3sbOgZidxSHAInz
         XWZrrZORNo7Zu2xyX4VC0FCe7tdQjZ3rHwvCbZOW7DtObksjGIwKiXOWXYJj0/AqBVV1
         iTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753098982; x=1753703782;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYI2UsizWZCb5wSLeFRus42pLlQIGazAov/EfOWZBzY=;
        b=xPQkf1ITY49Vdm58EgCaGet0ARNLG8ITIxaP+fj3+DDCNmnHgBOgJCyX3YjQCZ4o+X
         RPONd7y4W7I+Xt2vQ58aEwTHIIIIFWJlae+IdtR5dx3MB5+EJuwzy4CJE3J3b99kGRhP
         Os112CPuHcJdmNCwyJteNgP5nF09ODnrsL2cdFtwSM4Z+R8B61b27+Zw7ZD51MHBuY7D
         H5NhCqSk575cFE5its0wtsWbNw3GQ0vfJMn0TV/om3tzbmYpMQhwV/Rr6jI/fGR6gg15
         w4XUTzT4MDlRffjlLkeom5Bi3aJdMbv/CHs0nbw/KSgMt75lMojxprA9r/Q8wtfkooWq
         lVvg==
X-Forwarded-Encrypted: i=1; AJvYcCVpIg/9RXjVhHyDfrsuzQmupWE9RSZTBnu+R/v4Itbj9h4Yduk9oyBLcmgWygEdN3mDp61FxQJQfJiJRQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSrSQgs9ghE9HIHpxxgY4jIoPm3ySg3I1STRpYMJTeQTESfoXt
	1ySspku/sBYpb2IrQi40KLDd5sB4vcPAl/cJIF0mbrIe6o84G0Zi2K07gjMFZeiViXpzUAUSioQ
	0bGEJWGYyllm3Rc5e3w==
X-Google-Smtp-Source: AGHT+IEcFbj4EFix3ciRpXJYDPsXwCXJhfsHqcvc311AYGTCfDwpV/wkDnDzlBmx+/8BP4664mzipt5VeEQf3xc=
X-Received: from wmqd13.prod.google.com ([2002:a05:600c:34cd:b0:456:23aa:8bf])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2282:b0:3b7:54b3:c512 with SMTP id ffacd0b85a97d-3b754b3c63dmr5273340f8f.58.1753098981719;
 Mon, 21 Jul 2025 04:56:21 -0700 (PDT)
Date: Mon, 21 Jul 2025 11:56:20 +0000
In-Reply-To: <20250720-rust-remove-compiler-builtins-deps-v3-1-0df3a493973f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250720-rust-remove-compiler-builtins-deps-v3-1-0df3a493973f@gmail.com>
Message-ID: <aH4q5CA6SfFFtpwc@google.com>
Subject: Re: [PATCH v3] rust: remove spurious compiler_builtins dependents
From: Alice Ryhl <aliceryhl@google.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sun, Jul 20, 2025 at 01:20:40PM -0400, Tamir Duberstein wrote:
> The dependency on `compiler_builtins.o` was first added in commit
> 2f7ab1267dc9 ("Kbuild: add Rust support") to `alloc` which matches the
> standard library[0] but was copied to other targets in:
> - commit ecaa6ddff2fd ("rust: add `build_error` crate")
> - commit d072acda4862 ("rust: use custom FFI integer types")
> - commit 4e1746656839 ("rust: uapi: Add UAPI crate")
> - commit d7659acca7a3 ("rust: add pin-init crate build infrastructure")
> 
> The alloc crate was removed in commit 392e34b6bc22 ("kbuild: rust:
> remove the `alloc` crate and `GlobalAlloc`"). As far as I can tell none
> of the other dependencies are required; it is only required that
> compiler_builtins be linked into the rust-enabled kernel. In the
> standard library, compiler_builtins is a dependency of std[1].
> 
> Remove these dependency edges. Add a dependency edge from
> `compiler_builtins` to `core` to `scripts/generate_rust_analyzer.py` to
> match `rust/Makefile`. This has been incorrect since commit 8c4555ccc55c
> ("scripts: add `generate_rust_analyzer.py`")
> 
> Link: https://github.com/rust-lang/rust/blob/f820b75feef00654924c9351a2faca8d34818339/library/alloc/Cargo.toml#L19 [0]
> Link: https://github.com/rust-lang/rust/blob/f820b75feef00654924c9351a2faca8d34818339/library/std/Cargo.toml#L21 [1]
> Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/rust-analyzer.20improvements/near/510200959
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

