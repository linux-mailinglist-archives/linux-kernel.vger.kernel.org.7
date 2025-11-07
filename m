Return-Path: <linux-kernel+bounces-889650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCBCC3E24E
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 02:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C5B3AE3AF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 01:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79802F7465;
	Fri,  7 Nov 2025 01:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHoxJ+Tc"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B842F690B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 01:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762479539; cv=none; b=iiJM9EaNxvbrboTV7I0kV5cI1VsIVYPaOHhN3jtdufsjeMcFZ2N0IkhL9bY4+MDyRd8lGzjPy01YD7vfeXgMk3iF2OzsFdEyXDa3/YFijAyT3SyrKg38kFvalLuXFmurN7nMpMPlzRczzD35DYYRqptef6EaG6PJujikMhsyKLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762479539; c=relaxed/simple;
	bh=2A61AxR6vT49m9916jFoK7ZS90gqn9klHZrsyCdjayU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSsfvgBaiqIWAfeeU9ahuVpaykLhFVD18/T9pCHD++UBQrOXhV70JlPWZLJSecR9b3E+5rfTPW5bDsHDNKoB+wmQUaWCgkP+5sAgehAZpnQhqF0EICS1O5xjrJaXs7W3IJvQUIcpRYcwiXcuhduWXo58uAK/lptGrIl9e9IGBqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHoxJ+Tc; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-891667bcd82so25879285a.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 17:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762479536; x=1763084336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rs98enLfey5dyNKoNpPfMUDvxjgARsAv9EJfv0aQaHM=;
        b=mHoxJ+TcuRahORk4qnKAfnU1KpCtg/SYHR0SVlqYvaPZ9mjV93DNChsUz3f/wpp9b/
         /rAFZskoPXUH0nEaRQPvcyZRrxtmHjAZbwzMsS3C2bacuWF9e0CegqmU0byInVRPZ1Jl
         YUeYdyfnt6/ziPPqm/yoZ7GX5jdTvFuI1FGqNYqUK7VhyST1lTs+kXwkRA7da7yMXk3s
         KEr5mKpZqc4QWyf2IWZ2XP4YIjWKPZEjHoT1LsCmAA3QjSrxhqpO8raIBBPJnBmAFaMp
         jCICdv6nH76Npvh0oZBEKyPxaSwiXSbcdOSTDx7dy9yJmW8+kh38XZzS7FbUeLfXYKNn
         q4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762479536; x=1763084336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rs98enLfey5dyNKoNpPfMUDvxjgARsAv9EJfv0aQaHM=;
        b=ZENaP/qYdhYeySQCg5r2UCWz+toTk3ZwtqkcIqUoZLb2ayMBj2YqlT8o7ycWioVCls
         EayH7cKJleH/VntTSuFoKiJIKZB14p3t5+rLhnoC/Wh4E0zQPg3m7lNESG4wYcDUGqxn
         tRSzSU2fRqUotPGPUBd0iBNPph/XHc3q0hatuj7Z02TxG3dPP1eiERc6//F89i7XV4ZT
         sD+pyVixSkD5VNkfcLNnI2ARvKhmRoVYJlg/QGl5xwKBavDiD0gxN/uq9SXNQGrj/rCC
         3sF0/mcKc01wLK9Aji5XqbuGti3v0nuXQI6VDLSyhTzH+9tmwBbI4xePwOi5V1O9jQES
         E+ag==
X-Forwarded-Encrypted: i=1; AJvYcCUw6q36wKzI4/yV40/hoYs3ts7akqzn07+qY47W2gmNGbJ0vSX2mZ2uHhOWuOcXEdIw8KZhWkbfhIlyaV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydq3W0vJ2dCNFEDRGNQLHVD3fiUVi6gQm+DtNLgfnjzUIwY1wB
	VS/9Tbp3SMmnN/8aO50IuQS3oSF2fl9PpeosGhs1dFaBbRXkxy/K0iAG
X-Gm-Gg: ASbGnctGnIF39XFwQYWPwtcT43uwx87iyVTgJQsOArZlbuQtUfHccEKDlsfAgoMRQmm
	KyRnf0OAxovNz55EdS/eu+QjIotHcqXXFxTxTZEnM/1RsIbH6EBGABjRKJOh5BsNmHDYZcleUal
	SWqu5v6XxHJtAiF5HnxsaL+CyPEtIsPIu/6hzfW6l8wer2KBrQ8RQeZ9hu929um6nAC4wca3EaH
	WpJZsQSfgXrcbVYHiKmj6cH9Ff6fbsJLfw3NH5FkOS1y6ho+bY3RQCs5jSye2i0jAb6bpuR92La
	gSSdRM6GplzbNnjZ96hAhT2dWiJ54Qy8gajHCgs5qUH3ee6JnvspNV8UmSVG9rgFFAoczAuvkZh
	iQwjczUVNGBPjipEFYdrUS8zV4ApHCcNhIsBTXGJ8+7aXuBfXQIfYJ+R1Q6wBA9KTb9/IstFT
X-Google-Smtp-Source: AGHT+IE+jU0nfXyJlqbjQMtkdY1xgzkKPYrFMIiy7CQmxQlV/Ewmcl9+im0LNVd5Kf6M61OnD9aj+g==
X-Received: by 2002:a05:620a:4095:b0:891:7008:f2e0 with SMTP id af79cd13be357-8b24d697a9bmr943285a.8.1762479536513;
        Thu, 06 Nov 2025 17:38:56 -0800 (PST)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2357dbae1sm308372185a.30.2025.11.06.17.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 17:38:55 -0800 (PST)
Date: Thu, 6 Nov 2025 20:38:54 -0500
From: Yury Norov <yury.norov@gmail.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Mitchell Levy <levymitchell0@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
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
Message-ID: <aQ1NpPIcVIUXqgQS@yury>
References: <20251105-cpumask-iter-v1-0-7536f906d7ed@gmail.com>
 <7107432f-4d0f-4544-9592-76a5e5c6d220@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7107432f-4d0f-4544-9592-76a5e5c6d220@nvidia.com>

On Wed, Nov 05, 2025 at 04:19:36PM -0800, John Hubbard wrote:
> On 11/5/25 3:16 PM, Mitchell Levy wrote:
> > The kernel provides a number of very useful CPU masks from the C side,
> > including CPU masks for possible and online CPUs. In particular, these
> > are very useful when some operation must be done on each CPU (either
> > each possible CPU or each online CPU, etc). Therefore, it seems to make
> > sense to add both of these functionalities at once.
> > 
> > Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
> > ---
> > These patches originated as part of my work on a Rust per-CPU API [1].
> > Boqun suggested to me that these may make sense to merge separately, and
> > it does seem like these might be useful beyond the per-CPU work.
> > 
> > [1]: https://lore.kernel.org/rust-for-linux/20251105-rust-percpu-v4-0-984b1470adcb@gmail.com/
> 
> Even though you are trying to get these two patches merged separately,
> I think it's best (for reviewers) if you post a patchset that shows
> these things being used. Otherwise it is potentially too unmoored from 
> reality, and hard to be sure that it's exactly right from a caller's
> point of view.
> 
> In this case, just posting that 9-patch series might work, and just
> say in the cover letter that patches 3 through 9 are not ready for
> merging.
> 
> Something like that.
> 
> I realize that Rust for Linux is being built from scratch right
> now, but including calling code in a patchset is a really valuable
> kernel convention that helps validate the code.
> 
> I say this for the benefit of others who may be reading. :)

Not a big deal. Those two patches are self-consistent enough to take
them separately. But I agree that examples are always welcome.

Mitchell, can you resend this small series after addressing my
comments to the big one, and also can you illustrate it with the
usage examples?

Maybe a small test doing:
        
        for cpu in CpuMask::possible_cpus().iter()
                ncpus++;

        assert_eq!(ncpus == CpuMask::num_possible_cpus());

Thanks,
Yury

