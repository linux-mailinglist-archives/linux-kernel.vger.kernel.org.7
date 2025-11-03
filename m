Return-Path: <linux-kernel+bounces-883631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B500DC2DEC6
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2289718925FE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3F9320A04;
	Mon,  3 Nov 2025 19:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NedCAgLH"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADF229BD8E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 19:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762198987; cv=none; b=SDlURCN7QXh6M/+asWUy5fzstQfBS1b8LwWL+2LPx1Nq3/1uKgqvgP9PBocH4DaSshKRYok4YMLACY1u80bov8t/PGejxU1vkVhS0ScKutKoocWV4y86aDirEom1YuL9GuVGLlWjGmeuN93nYCxM3ZIr3B0HwAgVAoK8egGsnp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762198987; c=relaxed/simple;
	bh=fOiJfNe1tSBKrwGibXYlMtACCEW3Rvf2nRPH3J4KIx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svVCbxQefAav2bOEoNbgwMSfLFp6q6/tSb+11mLJXfi3Jd4AnhDiF4SZ32p95STsokFLq62qIQOyIL0vCRx79OS25sjTBI0wZw2FwYIxZu6iueZURLg1XsyF7mTa2L7GJ2wlfYu0rPrKhl1GV9nCF2CtgqY695inTgzo0es4khQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NedCAgLH; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-78665368a5cso20704457b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 11:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762198984; x=1762803784; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8gLU3NQzBLMJ6ClUYjW6e6xNfxycqseBuORt8dGPGVI=;
        b=NedCAgLHhYE9g7q+rAfDZlbPWMIZ/2Af92Mq02CXFB9M4i4XE43H6AKeAFo3Swm+SS
         Z6m1jFQ9j6YIR9gm2KNu2eIuvL3Jm7jXvRmXmb6hgCxk4CdhjIMx1vnTRfQa90fhJgzU
         abJjJn+HXolFVJHrAuh2d0GpvYhOaSodmNvn/yRq5n3RRVengQkkwf0CfsGBD4+KyDUf
         AOetAN33UVQ/GGyuuPIfCcO5v9rduhZrWEP35hyPzHcVkMWnWD3OUUU19O6G56x01hUh
         XvsdrjYkojpnHwT6T1nEI7Cmjuo8WLm32G7lJ+raAGxMpfEwje4q0LKoyzztnhSzF/Qk
         v8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762198984; x=1762803784;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gLU3NQzBLMJ6ClUYjW6e6xNfxycqseBuORt8dGPGVI=;
        b=Zv2Wbrzh0AZy6lr/wB7KEHjQzt3ELQ95C8d0RYOhVRYXXjPaSSTVbGvpFLrWWzlt1M
         6fmp5Di63gTVk/xnOwChgkUWCStX62tYYGbtgt9J2W+FiwYyJkbZWuY11geOjPVIjcri
         m+XATfmW1rwX6Cu1Gc5yvcaqnCbv2NAMkGLsLCjd1hbkWitYSPqe1CvjmExWEx0pklE4
         GDT8bLaLPoy/MvNUuA234ddlRi89FNXr6XVUukqwv45ufnbvnPtBstkyosXG5GqAbNCB
         /7jcfUcpNFbL5c/PJyOc9tuUQNeCPlU9vo/chtjsKE7dgKw6Z5uC6E0WJgClDqxJTAs1
         bbfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV48Epd2EZTmxOwfBJloHMxlFF/dcWQZpUY9sUgU0ySVN02ce7nQGJ+nMNz/Mx2MVvjbIU7cShkpcj0S9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgcAu5tjPUWIgUE+63kk4qwAty36eiiBqTmF8ESpqdj/LtzmxU
	wF/eg/HkIzFfKqz6C9Ffbbg6VrfD4FhVLwX0rhq5iBsLeBVy0sr0MsNK
X-Gm-Gg: ASbGncs8mJ6R/7iX95k7XyMqAK50JV1lrjqa0ar60ld37usGczOTW4MKBvcCpZm6+3F
	bthTS7IUwmb8/6N/tJBRdRCm9wunuH8a4FdhGCKzkHFJFFvuJmUimJhOQC6yG4+KpXy2RT4T4Sm
	zS2TjfIHQmaYbEyXHjpEdENcLgICPMiIXymQrg4LPtgXfAqocj5urs/5FuheYUQE24Hv0lDIqch
	cDlWtEGgLVbA8N1KmhC1yisVJ2qt2Z2vafyiqs3HRYBKqjP4VnpkaGbj2pdSlAnk2GPhy4s73IX
	jdQ0/fRF69CTfssnRj59ATOCcRJlPHYCm/Ic+hPKExLgRXjVr3un1TRN56OvQXRRbaWg//cAlvy
	bSr0JYKJsBa3ukm268UoBlLmjjDrO3/zv7VJ0uIuAMNkggRFuJsd7kU5WOvx2aiCEfoWYgj1jr8
	hP5/W+XTrJA5xwbV81XjpoTjSTMRr97ICof+cIQAuwdCE=
X-Google-Smtp-Source: AGHT+IHwMU0YW6t+/jtkuK4ML1S33Ru9VA7vEWVrGzHmpOczVpCN5ItTFIIAY8V0BNYQg9Q1CuATbw==
X-Received: by 2002:a05:690c:dc6:b0:786:57b8:1a1c with SMTP id 00721157ae682-78657b81c81mr105968757b3.65.1762198984615;
        Mon, 03 Nov 2025 11:43:04 -0800 (PST)
Received: from localhost (c-73-105-0-253.hsd1.fl.comcast.net. [73.105.0.253])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7869201ddaasm3421497b3.51.2025.11.03.11.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 11:43:04 -0800 (PST)
Date: Mon, 3 Nov 2025 14:43:03 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Jesung Yang <y.j3ms.n@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: add BitInt integer wrapping type
Message-ID: <aQkFx-brq-_njd5D@yury>
References: <20251031-bounded_ints-v1-0-e2dbcd8fda71@nvidia.com>
 <20251031-bounded_ints-v1-1-e2dbcd8fda71@nvidia.com>
 <aQgQv6F0Ao4DH6U0@yury>
 <CANiq72mg-NntJLf_jbigz++0hK7G3WAxbvejRq1EzOc7GE+doA@mail.gmail.com>
 <aQi7e6VgFsqpq1Rn@yury>
 <CANiq72=4UXemR3ea5nNbqGt0Zh9q4hwiGVAn+hxfcZ-Zqa8y4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=4UXemR3ea5nNbqGt0Zh9q4hwiGVAn+hxfcZ-Zqa8y4w@mail.gmail.com>

On Mon, Nov 03, 2025 at 03:54:08PM +0100, Miguel Ojeda wrote:
> On Mon, Nov 3, 2025 at 3:26 PM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > This is exactly what the patch does:
> 
> No, there are no arithmetic conversions going on here in the sense of
> C. It defines a particular operation for a set of types.
> 
> What you are seeing there is that literals, in Rust, do type
> inference, and so the compiler picks a type:
> 
>     https://doc.rust-lang.org/reference/expressions/literal-expr.html#r-expr.literal.int.infer
> 
> Thus if you do:
> 
>     let v1 = BitInt::<u8, 4>::from_expr(15);
>     let v2 = BitInt::<u16, 4>::from_expr(15);
>     let i = 5;
>     assert_eq!(v1 + i, 20);
>     assert_eq!(v2 + i, 20);
> 
> That will not build, because `i` cannot have two types. But it will if
> you comment one of the two asserts.
> 
> And if you do:
> 
>     let v = BitInt::<u16, 4>::from_expr(15);
>     assert_eq!(v + 5u8, 20);
> 
> It will not build either -- there is not even "widening" going on from
> `u8` to `u16` in this last example.

The current BitInt() allows this:

  let v = BitInt::<u32, 4>::new::<15>();
  assert_eq!(v * 10, 150);

It looks and feels like C integer promotion. If Rust doesn't like it,
we shouldn't allow such things with BitInt()s.

