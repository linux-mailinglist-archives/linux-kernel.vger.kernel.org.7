Return-Path: <linux-kernel+bounces-883641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C792CC2DF50
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 21:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CA7E1894FFC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 20:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC4E242D69;
	Mon,  3 Nov 2025 20:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Trr6tgaN"
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B620A22D9F7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 20:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762200010; cv=none; b=A4b3IgCFSzxDuP1EgLYoDd7K2eWqr/qCj6w6e3LPPor8NUs2CmdIq8g/pw5Eq+RT0dVgzMnhpXtN64YJQ2WKVSKV9ZJytrOi9kEum6I6PqZGEx7AZYhiAusFn4O02eEpgplIpaPignYnfZQ5dIz2PMQ1Ek9+U/v7zeaLpGa4YT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762200010; c=relaxed/simple;
	bh=H2iI4vgRjvJNYnHtrSUqyU1Cq31SNxet0+xmtihJL6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfaCEiMAgwc1l/dDJ5COjMrJiEioy48+gdv/QFZyM7GLaY6FZFxM8IKRmUGCbu2GVcbFM8ovbPsBdAS9xRumpv+4lgCyLcy8Mlrljgd4gOW9ynqf7P2MGUOYXHkrAwOGzVWRRF/Go9yrm/XSAmChzcnUGCqweNFXreaKXf2RByU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Trr6tgaN; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-63f996d4e1aso3007004d50.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 12:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762200008; x=1762804808; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jetwJhKKnP5hEpNy345LkI5gvCQLRWl4+5Sty4m/RRg=;
        b=Trr6tgaNT8FO+C663W9/Mr8knUy7tM67iKP+UkXJ7ZDBfXYUAGRF9nO8SF75mg71M2
         8W7jkD52pcuTfKm7ezn8kwpMdm/uRV7gg6EgFKhazODJS7nYFVd+s8YVVaz40iUZbF20
         B4g6C33r9elPwbZlFjhrhLp8u3a5elRGUFJ7F7O2YSM/vSecPYrKRSnNO1S1bE+Ssq6O
         MfQUnGjy11OxoUO/fvdkhDHNQyAB4OmxPqBMS0gZtLrYZ2gwVPrPJNHjyKWYiA0lFIco
         SFd/GB44zd7gJmM44I7hZB00cHq+MMtGCF/DvExJFsr+qnWtiakuKAC4w3UtswDvK1GS
         vQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762200008; x=1762804808;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jetwJhKKnP5hEpNy345LkI5gvCQLRWl4+5Sty4m/RRg=;
        b=S0M18iTAfUfbUis/ErcldNOLcfk3sYJkyzfMRPReWxedcOTrXBNZzLvHKP4HXy6WqH
         l+4r2enM/kJK4egdWO8IE7+V9bwGYSSR8jg1lMIcCEyOe2LCbkeVPtM8CD9YqGBI13h+
         N0BLMXiE7VfiW+DscG++KkiYJAkfnGvRsGJroATOni3PcZyLeb4fmWZooDaRHWEEp/SR
         UTUxS+sVJU1NLuKrVV0RFXhlGQd8OI6nILT9NPlYHPbkFIwF6q9glFyO1boiQENpSYqx
         t9sqjU42LDFDLUpjNyFSzy/eHUbeOQS7OftLFm7G85UivY2fWUF/AhafatO/1+Gdu5On
         SMmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn8dw7b98TrWsl6XhB+HjqGhmbtbk/IHe6gPcbKjo3hszeIqC6ISagUb9i11TC7f+fKteuV5VU9j994sA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy43go7sWbvn9ukd7VptzAfu/Ov6UNcu+/Rc2yOBJSI9xyruSbo
	XP9bsF4ZGxEueu2ABb6BRZ6+Zr/3SjIGNr/g1SU3y70vUYS+XR93qKtd
X-Gm-Gg: ASbGncvehlRwbYfMxMpaD6psAfBjDHMqXKnNhbtDZuyw+Qsykzb1OZcjC81/adM77s7
	Fu/O6k4C7bzSn95Z8dwqY6XmualrylJuffXJ0Ho+JvCWTmgHaFOQpWoZwZksl8JUGbFm3G49cUZ
	E/zG7G3deK2o8xjpzoc7FRXgFRH7CbTAgkGNOAHZqQYjUNMkRhSYovl0cf71uVGlKvW9Ef+7pho
	tC6948EkbnVEUQQ4OGGahl2uvfN2HHawygghrD3h5p4r4zBU2no49FvZChsGFHp/8nfnf1HjQkg
	By63xv+H6ZvHKUYbABwKBe/JW6jmPsilAVPK9voA4cpPtRca4vrD2dtNio8i1DVBSelWy+JpigS
	IAGM8W8avuZfOdANrtkMqmDp6N8BR4V/eBax886jugCk71KMYOB/zHFvzxZFcfJax/Ay5ARBEPr
	MWFOECP+KWGiZLju4U2xd0xCy4SFq04U7njP0xhYLc9FU=
X-Google-Smtp-Source: AGHT+IGJ87Q3cBow/qm5dM5tdwT1qsmjXZS1JLAYHfLfr72pTqVIDzkShPLVJmss6G2QPZIUMbBmCw==
X-Received: by 2002:a53:d015:0:b0:63f:bd67:7c63 with SMTP id 956f58d0204a3-63fbd67a6a7mr2645920d50.15.1762200007510;
        Mon, 03 Nov 2025 12:00:07 -0800 (PST)
Received: from localhost (c-73-105-0-253.hsd1.fl.comcast.net. [73.105.0.253])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78691fd7e50sm3605907b3.38.2025.11.03.12.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 12:00:06 -0800 (PST)
Date: Mon, 3 Nov 2025 15:00:06 -0500
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
Message-ID: <aQkJxlaHoOdrlrWx@yury>
References: <20251031-bounded_ints-v1-0-e2dbcd8fda71@nvidia.com>
 <20251031-bounded_ints-v1-1-e2dbcd8fda71@nvidia.com>
 <aQgQv6F0Ao4DH6U0@yury>
 <CANiq72mg-NntJLf_jbigz++0hK7G3WAxbvejRq1EzOc7GE+doA@mail.gmail.com>
 <aQi7e6VgFsqpq1Rn@yury>
 <CANiq72=4UXemR3ea5nNbqGt0Zh9q4hwiGVAn+hxfcZ-Zqa8y4w@mail.gmail.com>
 <aQkFx-brq-_njd5D@yury>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQkFx-brq-_njd5D@yury>

On Mon, Nov 03, 2025 at 02:43:04PM -0500, Yury Norov wrote:
> On Mon, Nov 03, 2025 at 03:54:08PM +0100, Miguel Ojeda wrote:
> > On Mon, Nov 3, 2025 at 3:26 PM Yury Norov <yury.norov@gmail.com> wrote:
> > >
> > > This is exactly what the patch does:
> > 
> > No, there are no arithmetic conversions going on here in the sense of
> > C. It defines a particular operation for a set of types.
> > 
> > What you are seeing there is that literals, in Rust, do type
> > inference, and so the compiler picks a type:
> > 
> >     https://doc.rust-lang.org/reference/expressions/literal-expr.html#r-expr.literal.int.infer
> > 
> > Thus if you do:
> > 
> >     let v1 = BitInt::<u8, 4>::from_expr(15);
> >     let v2 = BitInt::<u16, 4>::from_expr(15);
> >     let i = 5;
> >     assert_eq!(v1 + i, 20);
> >     assert_eq!(v2 + i, 20);
> > 
> > That will not build, because `i` cannot have two types. But it will if
> > you comment one of the two asserts.
> > 
> > And if you do:
> > 
> >     let v = BitInt::<u16, 4>::from_expr(15);
> >     assert_eq!(v + 5u8, 20);
> > 
> > It will not build either -- there is not even "widening" going on from
> > `u8` to `u16` in this last example.
> 
> The current BitInt() allows this:
> 
>   let v = BitInt::<u32, 4>::new::<15>();
>   assert_eq!(v * 10, 150);
> 
> It looks and feels like C integer promotion. If Rust doesn't like it,
> we shouldn't allow such things with BitInt()s.

Sorry, send an unfinished answer.

So, 
     let v = BitInt::<u16, 4>::from_expr(5);
     assert_eq!(v + 5, 10);

is OK, 

     assert_eq!(v + 5u8, 10);

is a compile-time error, and 

     assert_eq!(v + 50, 55);

is OK, and in fact an integer promotion unwelcome in Rust.

This is not what I, as the user of BitInts(), would expect to see.

