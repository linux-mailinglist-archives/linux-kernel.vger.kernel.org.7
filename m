Return-Path: <linux-kernel+bounces-885396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 569BFC32C8F
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 20:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DC5B4EB125
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 19:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA322C11CB;
	Tue,  4 Nov 2025 19:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="if1Kxuhz"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A8D8F54
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 19:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762284624; cv=none; b=qEqNSeiE/uJb6kWIB+Y8sk1QlMnjpsBQPmTm55gzXv+nAqqHMkEYvNs2z4j5LkizPTIGAjJn0xyo+4YnBO5GxpR4zPRw/0Cm9LBiaBFfAgxU/ltjFSwbN162uxEDCi/37Jcz2KTPnSWzpa7o2nuGjeG+0Vg2MDYnByppYeWauEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762284624; c=relaxed/simple;
	bh=uYoW/8o2oWvHywWaopv1m5BZj9vCw8WNveRwCymRnA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+9wnT22kJhfgZnNCublUiNATWcqk1blcHsPAZy0trwcdUxTHUro5IDuK7H3ClT9C4r28kV42kDEpNhHvEAQyfOYgNi70YiqbvhYfd5FF8ZVoLhG1UIPM6F4Ed5F/bXD81pD7JMuk18iw7n9U3HH4qzn7G2VkLei283In68vOI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=if1Kxuhz; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ed65fa5e50so5350961cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 11:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762284622; x=1762889422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yrkua1HDR61+GtT/9O/LrkaCogME0nTN9Kn1x1xYcQs=;
        b=if1Kxuhz7kOn3zCAHr23JnBpzwX9jQOzEIfzra22lGBmLZXjly/JMD3rOycw6efEXk
         WLmTjW60EotiMDg40iVrOg7LOQQGRx39YEjStsO0GsCW7PslWWBcU1DJM61wz3reADOl
         kunzY2RcyQ4cTg5iuWcZyabLvP0jBu/e9L9eWloNWwcvFoLbj6jGSj4mhKN1IYppzjUX
         WCudRpkCK77SMhepOClRKG6aVmFk1BA9t+g0Xr4J0jtBmCWYunjdyQgNth6qpEd07FFp
         xgw+R6bwHmcyJrbvtK7MeMS55pbzKtbBuWbvDXiincB50nFx/NQps2E/2jOAXiSlqSJU
         QzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762284622; x=1762889422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yrkua1HDR61+GtT/9O/LrkaCogME0nTN9Kn1x1xYcQs=;
        b=TfLXw8DUztLu7mVes3BSu0rCX0iGNVEqA3ftA/W/kj1XAW56B+MDv5JGRiuuvuN0U8
         5tXu97v6hs3vkh+HhJ+3ZtsqrvZFRExXvzuEAxSuSGkyJdEAot6g+SjvXdxwLyF27rI6
         8OzDByfexQ9Ph9/20owwtzSRA3CtEA+tBbdAv5cTw7iTkj3dkJQVixkhKOY/tmqBIhA9
         D/cs6h9e66JIgpEQKFaHq6+1a/hpR2oAizAj9XbVvTlLE0Gzc3q4AxbJ9FuUC8AiU40/
         QRL37ULRHkm7bQMxuuPlpJwvZUIkCbMZt2JALyS3AA4ccy1+LontfRX2iHhjhysekm5V
         DpKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtUqOfGQnCdlXaZU5Ua4yEl+yMzBI3OhFzIMaZI/ZhBOyBxlLKqJPGJXp2OB64tZPdDHbMNcsr+k5ySd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK3B84llPte7Cl6Nzctw3ChX2SNtWCYRt2c1I3ulv3+CTQcPLQ
	2WNqi1ULOmNNOKO5kXGLrnTKMBRD6LFx5RDoNBJ8+Tl5PlhHHNTbCUuE
X-Gm-Gg: ASbGncun/QZIzDaeu+ZN+Luc/EKr1Qjc4yUgLZHczrH7hn4ZY4SUld7HR/HhXWAK2fb
	6b43aIGJuII2guiYuojad2THTz5CTbQrIMvzs/MXdYyBgmX+c2sj/NLx8HyMlMyy9PZ4xjiONpA
	0C7bExziXhmIQ7Ts12Ci8x9yHDz7UpI8VQ9ebc7PB3wwP2FN50IqYE5GxBZpa8E14LM28RehUBj
	hueumFTTquyB0BECePApKH3Ft4pfjQTT1fW8Q1EcbdV6dU0Z4RdNhenuazddOouhUgaVFhVsY0A
	ZbSpgLvFAlct+MiT4t07PLLwiA4R8NIi90V3i/SQqDWINXcpRxfyMDqudI1mJ8pTLLok4KlVNXZ
	n074litKtTnXZXw3l5VJyttHKX/c4s1d6I5QqedP3EUfYihU48doKFwDuOFPGrIZGNG7qRv2P0b
	m7T8QTwNI=
X-Google-Smtp-Source: AGHT+IHHZ8QvW/CCOjhJABVz/T5Nuu/Qpdn9xw9nWT38C4aLePVGZ+lIedTnJOWnSxHq59U3rhqb6A==
X-Received: by 2002:ac8:5d12:0:b0:4e8:b812:2e2a with SMTP id d75a77b69052e-4ed7237c610mr9079481cf.24.1762284621840;
        Tue, 04 Nov 2025 11:30:21 -0800 (PST)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed5facb3efsm23437931cf.7.2025.11.04.11.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 11:30:21 -0800 (PST)
Date: Tue, 4 Nov 2025 14:30:19 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Jesung Yang <y.j3ms.n@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: add BitInt integer wrapping type
Message-ID: <aQpUSw49QptgxjFz@yury>
References: <20251031-bounded_ints-v1-0-e2dbcd8fda71@nvidia.com>
 <20251031-bounded_ints-v1-1-e2dbcd8fda71@nvidia.com>
 <aQgQv6F0Ao4DH6U0@yury>
 <DDZ3QBBUM27H.MJS1S3WHWJO0@nvidia.com>
 <aQkEVqbhoVMUc-Km@yury>
 <DDZKZFCK27HZ.DY3QVXKFU3BI@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDZKZFCK27HZ.DY3QVXKFU3BI@nvidia.com>

On Tue, Nov 04, 2025 at 12:13:26PM +0900, Alexandre Courbot wrote:
> On Tue Nov 4, 2025 at 4:36 AM JST, Yury Norov wrote:
> > On Mon, Nov 03, 2025 at 10:42:13PM +0900, Alexandre Courbot wrote:
> >> Hi Yury,

...

>     let a = BitInt::<u8, 3>::new::<3>();
>     let b = BitInt::<u16, 10>::new::<123>() + a.cast::<u16>();
> 
>     let c = a.cast::<u32>() + u32::from(b);
> 
> Note that `b` and `c` are regular `u16` and `u32`. Arithmetic operations
> cannot guarantee that the BitInt invariant will be maintained, so the
> result needs to be converted back if that's what one wants.

What C does and what I proposed is to make BitInt a 1st class type,
just like basic integers. What you implement is really a bounded int.

Both have advantages. C-style BitInt() is a true type with all type
guarantees. And I like it more because it is a natural extension of
the existing integer scheme.

Your bounded ints are actually classical integers with some limitations.
It's not a primitive type in sense of C - it's an object. It also works
fine. You can easily extend it to arbitrary min and max limits; you can
expand it to floating types, and do whatever you can do with the objects.
        
        BitInt(i32, -128, 255)
        BitFloat(f32, -1, 1)

That's why you think that -1i32 fits into BitInt(i32, 4), and even
into BitInt(i8, 4), while I don't.

I don't know which would work better for bitfields. Most likely both
would work reasonably well. And if bitfield will carefully hide
internals, I hope most users will not care much.

You switched name to BitInt, but still think about it as an object,
and that brought all the confusion in my mind. Maybe switch back to
BoundedInt then to avoid this confusion? If you find it lengthy,
probably LimInt or simply Lint will be better for you.

Looking at how good rust macros work to implement bitfields, I thought
that they will be able to mimic native types just as well. But now it
seems like an arbitrary-length integer types requires support on
language side. Just like in C.

With that in mind, I think that bounded integers are a bit out of
scope of basic bit operations, and probably I'm not a right person
to maintain them neither in Rust, nor in C.

Please keep me in CC for next versions.

Thanks,
Yury

