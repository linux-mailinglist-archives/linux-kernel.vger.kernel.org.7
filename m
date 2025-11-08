Return-Path: <linux-kernel+bounces-891299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7052EC42612
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 04:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 474E54E56C0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 03:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5135827E1D5;
	Sat,  8 Nov 2025 03:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPYtsMaf"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BE91A262A
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 03:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762572634; cv=none; b=QC93J+DrSKL5pMnC5KQb0vUP+QfBzgIa/68JAORN4xYvNZ0LyXGa/0+1BFw10b6U2VrjIW/xutkakhsdzJv8/l+XJMSzT7N53p9yBtq+Khys7uOwUKSkjfnviLSvQlxs+EKO/BeRI25C557TDPM30BXykKezd7bU1DSUaQ2Hw9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762572634; c=relaxed/simple;
	bh=2YEy1ITQJX+dRDNsaoI2rwt1LIYE4KTWkwVeUHeHmEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhCOIWIB4+uAGJc6HXXrQBQjKA4aeurBFTo0LmB4hyA6akHdBUBt4IhEYIWEhnpzdw4goOw4qPlZTkM64UT9NoPcgAMbug3thWMjUaJ49zgH4RC9ztq590xDJow9rJYn+X+bxlPC0I9E0LgbgohJTM8pPlrmeRQqPFZxJru+aI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPYtsMaf; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-78682bab930so19476417b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 19:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762572631; x=1763177431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MD59kTzjWFWkjp3MAX/YmDqL7bC2/PHEpjJEKrmQLUQ=;
        b=fPYtsMaf/SVpjBxUQ30qZH08VsAJD+79QBtpxNx/Ns2SFw3o8WUvWl/VnhBwrktjuL
         fg1eaX+jfo/77aQSZSogh+GbX+ayW93e7BXOYMe4k/xvwvQqxS1D+yOlJ1YTmnuqyVz5
         68iCbLBjGRTz68jgASa7F97DpI3hn/t8vPuknGecoe8/bp6hfOb7B4QxHDFtahNwyV/n
         M2ujdIZeIdsThngL6dGp/ETMc0v8hDdUN8NJ1S/y1h5s2GcE/clXrB4B+t/YOxYRd/2v
         bObXBROFIriKnQobCB20gucNkhikAMp1PcbdS43Z693xbxI8kEUamT7WXuDGgak/nehv
         tDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762572631; x=1763177431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MD59kTzjWFWkjp3MAX/YmDqL7bC2/PHEpjJEKrmQLUQ=;
        b=g0SU11qUVyVSKCI+E3J/H71nt7rBvD6CHmIneUVmp/mIt8XLI4A0a7FWPWE8xgB2wL
         Dgwix5IClJAvWDymqUHllzjLQu/n4Mw9ZGNtBjugIw/5f9eKSo8zDfiUS+5Xxc2dgKwu
         xJ2ed47qfFptfv8DKSRZ2Hqxnt8ofJpz32kMYQDMgxpZU0uncwvAfBpSUanCBgC8XKpG
         TH+wKBiYSuiDubKIV25+SpYOMq36nAldmU1pB1fxjLrBWPTPhOgUEYu8JOc6Tuqa0bvQ
         zlvK0gOdFDKT7JQeN13vUt4zkmrQUMCfTK+/as4K56a3h1mBSUH4CPxoovc8EzfSU+jy
         Mlmg==
X-Forwarded-Encrypted: i=1; AJvYcCXYDlSYgyvUp3NSPwWasibqZtzJuZYTgKIRud2zFAWGhc1/vQoqv9kQVxGreSW6K/n2pZ6pCNuUlgcQOy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzXeZUFXPw588PeV/s1+Oekibc7s1cGTtUXJJv71IeDqGGZ4Yr
	aA7u/29xN5AUFVkB9dFC11/85dxmfStbpIC6lbfh6APy6YKFWVHmdjme
X-Gm-Gg: ASbGnctxwQQA75rh2/x97hMd2uS2JVQwHEC4Z4jwvLtrHdARyniejJQFX6mFSKIuK9g
	KScnwpQwnVVxvZl4aj2DsYm0SRZL9EW1Pa16K8Z6OSqL/Pcc5GeAYTrwisZtYns+ZevnwXR+iBh
	Yfrtuw3xpmpcQvOIimaskTqrnVTYbXRyk9kRO8dw7LnJxTG0kD2q4yfW9Bv+jYah9xOorlgpBWT
	l7Xm5HSqdWaaIkQLC+g4WGDeTELGKK60VG5a0qvAdx7M3MOsSfs9/oh9UiY40rY4VFO8CMdsaNg
	Psd9+qQwOR2p5xixfKd6by/sg8vBoBbUiEavs11MvIVsANCl3n0cZpOy9jHap9qxIKcxa+ta1kb
	srmDTNhWhtAIQcPoJN85Rx/KCtcIDG8c4XjNssKDRETKBXL8TEoR7XTPrbZ1/be7lbMWaJ0qSIf
	1TsZXI6fKaDWKN6IM9WrCR+MXpbBucbo+JMHWc5ktg7kG2EZFeZ5k8MQ==
X-Google-Smtp-Source: AGHT+IFtTZV8uCctV+DRq/WPYVS0Et7MbCQXMalMyhn0/VU6fhkR12xGNRBZ1xwXvsb/MYqRb+VusQ==
X-Received: by 2002:a05:690c:600b:b0:787:c607:5eef with SMTP id 00721157ae682-787d4f2f82cmr14787567b3.28.1762572630957;
        Fri, 07 Nov 2025 19:30:30 -0800 (PST)
Received: from localhost (c-73-105-0-253.hsd1.fl.comcast.net. [73.105.0.253])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d6a03a0dsm3394967b3.49.2025.11.07.19.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 19:30:29 -0800 (PST)
Date: Fri, 7 Nov 2025 22:30:28 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Mitchell Levy <levymitchell0@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] rust: cpumask: Bindings for core cpumasks and
 cpumask iterators
Message-ID: <aQ65VJxP83xr1yIW@yury>
References: <20251105-cpumask-iter-v1-0-7536f906d7ed@gmail.com>
 <7107432f-4d0f-4544-9592-76a5e5c6d220@nvidia.com>
 <aQ1NpPIcVIUXqgQS@yury>
 <690e8748.050a0220.22e404.3a1d@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <690e8748.050a0220.22e404.3a1d@mx.google.com>

On Fri, Nov 07, 2025 at 03:56:54PM -0800, Mitchell Levy wrote:
> On Thu, Nov 06, 2025 at 08:38:54PM -0500, Yury Norov wrote:
> > On Wed, Nov 05, 2025 at 04:19:36PM -0800, John Hubbard wrote:
> > > On 11/5/25 3:16 PM, Mitchell Levy wrote:
> > > > The kernel provides a number of very useful CPU masks from the C side,
> > > > including CPU masks for possible and online CPUs. In particular, these
> > > > are very useful when some operation must be done on each CPU (either
> > > > each possible CPU or each online CPU, etc). Therefore, it seems to make
> > > > sense to add both of these functionalities at once.
> > > > 
> > > > Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
> > > > ---
> > > > These patches originated as part of my work on a Rust per-CPU API [1].
> > > > Boqun suggested to me that these may make sense to merge separately, and
> > > > it does seem like these might be useful beyond the per-CPU work.
> > > > 
> > > > [1]: https://lore.kernel.org/rust-for-linux/20251105-rust-percpu-v4-0-984b1470adcb@gmail.com/
> > > 
> > > Even though you are trying to get these two patches merged separately,
> > > I think it's best (for reviewers) if you post a patchset that shows
> > > these things being used. Otherwise it is potentially too unmoored from 
> > > reality, and hard to be sure that it's exactly right from a caller's
> > > point of view.
> > > 
> > > In this case, just posting that 9-patch series might work, and just
> > > say in the cover letter that patches 3 through 9 are not ready for
> > > merging.
> > > 
> > > Something like that.
> > > 
> > > I realize that Rust for Linux is being built from scratch right
> > > now, but including calling code in a patchset is a really valuable
> > > kernel convention that helps validate the code.
> > > 
> > > I say this for the benefit of others who may be reading. :)
> > 
> > Not a big deal. Those two patches are self-consistent enough to take
> > them separately. But I agree that examples are always welcome.
> > 
> > Mitchell, can you resend this small series after addressing my
> > comments to the big one, and also can you illustrate it with the
> > usage examples?
> > 
> > Maybe a small test doing:
> >         
> >         for cpu in CpuMask::possible_cpus().iter()
> >                 ncpus++;
> > 
> >         assert_eq!(ncpus == CpuMask::num_possible_cpus());
> 
> Sure, will do. My current plan is to do rustdoc tests that will double
> as examples in the generated documentation. However, if you'd prefer
> something in `samples/rust` instead (or in addition), please let me
> know.

I like traditional tests. If you do both - even better.

