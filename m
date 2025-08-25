Return-Path: <linux-kernel+bounces-784483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F24D5B33C8A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5377D17859E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B172DF714;
	Mon, 25 Aug 2025 10:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NWHK3YLK"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6100E2C3248
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117473; cv=none; b=C6nKrhUBzwVW7BoVkSocCkHd+hMrX0hHTruuCWtyNFRZ2IXKv//CrIRRe4ZdH14S8eUZ9CH5VgLa64gtAW0hqiiAMX1FKvDOCSVGK5GzeP1anmMDqJQ3n6lcT+URnDCRLLJE2tnXJxftaYM3VZztICtCGlXkhTv7GW1dSzvODhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117473; c=relaxed/simple;
	bh=UDEd9cYvcyaP9oV0NSC9/XLH9axOgsAFUUP1hlXxyEk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b9YUTJ2E0oF//IiYTl04Y3RXxtM9HI2LRmgwKD40BGh0mwocnB1Tm/i32c9iyqeL+NRDGOULLz0AjHRB9HU/0ubeAANNumKTSAp+UB5ZwjH/p5Szr8UHdecZ85BOnA/yImjBBxCs7TXW8qkvhtsy5cPthhm+QO7V8fAHc78vsAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NWHK3YLK; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-afe73808e6cso153464466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 03:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756117469; x=1756722269; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5MQEgOUOrrXTS2cU4ZCo/UoZQZZfBzq+JYf6Z784MuI=;
        b=NWHK3YLKNMxZXXk2MB/PWxI53ckHu4HcRVF3HWMJosxDB58ouLoshdzc/liMMZiGA2
         NALqtMk+gM5oCP1YT7z6tmoDUrUmcMysx3br1QvcMHhcZsfE2IB5ogIjEcbrB5XwKOOV
         pF2zQ34PNz1IFqe3HZUl52EYd0sIh7W1E0YyVfM9AJJzBo5lg2PeVLBig8G+i5i5YETS
         JPAVZhzZxetqpOy1FUlnH0BJMdLxYZXn8aIMg99+t+9kXb+IgbvdPmymojU+OzMb7PvP
         yIW7aj4JC9X6tRaUle8qz8R2qe7lJNfT4KO/tCZfa2Rc9uYg7H8kBu4byDVBoH4rH/Z6
         esRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756117469; x=1756722269;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5MQEgOUOrrXTS2cU4ZCo/UoZQZZfBzq+JYf6Z784MuI=;
        b=NIpKwswaMQP6Tb7JyqTBoXKOOB3W/y18HWWv67o+5BHDfbUudyRP5dewZKI7xM5SIf
         PwLCBNuCmpRj0hguXt7rxCSW51639w99h8FF7Ji82nYVHQaVIoVqO4RYQaHKe9EKtSvM
         ItJREOEreBrggiJCH2lMQYlfmrExNIeuti+kDaRdwVMSEEHFekPP3LT9+2s6SG0+Wfid
         wYhITUTxj7gzRyu6njTQbQUKMkaYJebTmH8ugVbIrqgtPT9zEHkayw81+4dR+bP4pvvI
         Y6Y0KiwGiwz56fdG30/ykdTq8N4piQ+Oj110o18l+vM2SGZODvnnIKvqtWUDTuE7uGGA
         MrKg==
X-Forwarded-Encrypted: i=1; AJvYcCXsI9vUo52Zh31Y/41LO6iUwmx0w0SSm+mlLPty5mKPDksGM+zqLZqOn0JAPZwRKpqkEo9kZ763RsYFuSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5ylxuQ1vX7oDYWu3xTGVFG1JWeRoQPPVDfGZ0Mzt+uc0qrWDY
	+Kr7JpJ916SgKc2iAblQQVchNk/uVO6j9VDLGkrVIuz3uMRQNa5HucLGSZUchPB5zYI03J+xwQo
	TErp3F9ZrPKgy5b6EfQ==
X-Google-Smtp-Source: AGHT+IHUVy9LyT5/15d+7X1nkmpkZk73IXNTDmcKtFQv1QrG5bju8e0D3a2W3PEqdlihwLepVjmRILpk1lF7tCI=
X-Received: from ejctl9.prod.google.com ([2002:a17:907:c309:b0:afe:316:7808])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:60d3:b0:af9:5b1f:b87a with SMTP id a640c23a62f3a-afe2902ee1emr992637066b.20.1756117469548;
 Mon, 25 Aug 2025 03:24:29 -0700 (PDT)
Date: Mon, 25 Aug 2025 10:24:26 +0000
In-Reply-To: <20250824213134.27079-1-christiansantoslima21@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250824213134.27079-1-christiansantoslima21@gmail.com>
Message-ID: <aKw52m-lh62DXwz7@google.com>
Subject: Re: [PATCH v10] rust: transmute: Add methods for FromBytes trait
From: Alice Ryhl <aliceryhl@google.com>
To: "Christian S. Lima" <christiansantoslima21@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ~lkcamp/patches@lists.sr.ht, 
	richard120310@gmail.com
Content-Type: text/plain; charset="utf-8"

On Sun, Aug 24, 2025 at 06:31:33PM -0300, Christian S. Lima wrote:
> The two methods added take a slice of bytes and return those bytes in
> a specific type. These methods are useful when we need to transform
> the stream of bytes into specific type.
> 
> Since the `is_aligned` method for pointer types has been stabilized in
> `1.79` version and is being used in this patch. I'm enabling the
> feature. In this case, using this method is useful to check the
> alignment and avoid a giant boilerplate, such as `(foo.as_ptr() as
> usize) % core::mem::align_of::<T>() == 0`.
> 
> Even enabling in `rust/kernel/lib.rs` when compiling with `make LLVM=1
> CLIPPY=1` a warning is issued, so in order to compile, it was used
> locally the `#[allow(clippy::incompatible_msrv)]`.
> 
> Link: https://github.com/Rust-for-Linux/linux/issues/1119
> Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Christian S. Lima <christiansantoslima21@gmail.com>

With my comments addressed:
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> -pub unsafe trait FromBytes {}
> +pub unsafe trait FromBytes {
> +    /// Converts a slice of bytes to a reference to `Self`.
> +    ///
> +    /// When the reference is properly aligned and the size of slice is equal to that of `T`
> +    /// and is different from zero.
> +    ///
> +    /// In another case, it will return `None`.
> +    #[allow(clippy::incompatible_msrv)]

Does the warning appear on all configurations? If so, this #[allow]
should be an #[expect].

>  macro_rules! impl_frombytes {
>      ($($({$($generics:tt)*})? $t:ty, )*) => {
> @@ -28,7 +94,6 @@ macro_rules! impl_frombytes {
>  
>      // SAFETY: If all bit patterns are acceptable for individual values in an array, then all bit
>      // patterns are also acceptable for arrays of that type.
> -    {<T: FromBytes>} [T],

Why is this impl removed? I would think that with the Self: Sized
bounds, you don't need to remove it anymore.

Alice

