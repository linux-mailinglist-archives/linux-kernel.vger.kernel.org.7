Return-Path: <linux-kernel+bounces-762527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0E0B20808
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33C817CFE6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22152D29C2;
	Mon, 11 Aug 2025 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1E8Yn8a"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1987DDF6C;
	Mon, 11 Aug 2025 11:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754912427; cv=none; b=OfNNPTqAINVkoj422A6+vIAOt/kjebqxAyaSaCltd161pcLEPTC8Obl4LhH+mxXN8b00iyFD0mUhwlCL58NPGQqZ43GMKhWycKw5N/pyPuFSmuLV3thAL+kDVsW4uLCGIZQd1lsJ3kb8zB3vmJJTZtMD0nQJySzri7dcqkRBDeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754912427; c=relaxed/simple;
	bh=aY1/v2vYacmu029BEs0gmPRFN4q4+3GQdnp0j66cyQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmBwkLm74mg8QYImyQnRFBMnk+M8QEcg3aFSsUozO7V1+iL4obVTkvN0tHVH5PjOw6ODtAGQROTvSkPAMB7O1BRXFr6qftL3sCutV3bpcsGst4oP4ZBMDY6Kx6Sh8mKpKcgABUHhi1SH76EkDO5ikOMPeVUpwl37A9pMe7b7MSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1E8Yn8a; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76bd202ef81so5416371b3a.3;
        Mon, 11 Aug 2025 04:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754912425; x=1755517225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tVd+PaoPv29GhtyZaa2oKmb/IOsF7WgMozB6NnJzQ6o=;
        b=S1E8Yn8aA1ZYPGn8wC/AUkdsu/ardJr/zI8vb2ApOGVa6h1udFplPtLLY+9xNcr6Si
         j9omnf4WWn/1GDgknw9VAMDhanZb1F63Q3YVxXAahmQ62BfxLoNDIFo1QVVjCC4S2ycA
         7bLy67bKrqXB36hEnEjTbhwqyoHx+63ymv81EByMhtuKQaA8/7js0tkwz6+Obr0yIlgg
         MDw+0GIOK8GA/ie0jcOa1RkzRZMcW7uxc/K7Ola8zVwsEXDm7ruDNDRmOM7U+37LtwVC
         0YuxV+2DU8VXUwPhprb+a7MwTtoqVzw4dl13aamYnSmeMujYCsnCU7z0N83JxDYs4veN
         spwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754912425; x=1755517225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVd+PaoPv29GhtyZaa2oKmb/IOsF7WgMozB6NnJzQ6o=;
        b=Zda5pu3x0ekuwJcn6zbQYGkQ2CnjoNX84/9hdgbUJCTWBH3GYzZp11a5JDG//LrLKC
         ix0tHYSt0WLi/iso5EREI9n/EaGi7MAozCjees0L3jCHJAiLsEyOE8+mkJSoZ48jrYL1
         rfwfv/P8aDZgql6jo0RpyJfbjyX98y7S/V51+nrW9FkLCJ9upqPWV/n6K2UQrC8xO4EP
         UaNdn0n1QIaD0JkutM55qLlY8nxBSF1mnqD8VjcrB0QNIXTgxA9EDdYApjYNbEwWMFeY
         9S8AE7MbkhLwm0MSC+v1tsVhEmhQPHFCaQVYdRGQ3dKYL/IteerfSXp7STIAWLk/d6UY
         RGEA==
X-Forwarded-Encrypted: i=1; AJvYcCU2GVjjoNyVv5WOaayOz8PJPZ6ggD6GfMwtTNQ4+IWJc2mLerMsQJh+Tm+tDcI9+Progi+IXAGrg/reeqY=@vger.kernel.org, AJvYcCVVHgCnmCa9wYqCmrMdhUw2uB8klBvOKcMrHj2Y3ILSjnWsnAD9L3Hn36STeuSROiB/E6t2QNLzOww2JpGm2hE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2lrwHUByccBKXE15ow6q0e0mJQHiwTaG4vqHivpH0YWRO0Kdf
	vBU464V6X+A7UtXBIAuHUJyeY1TDu+ycWZQpr5nfTKOjug3+6/j4HJUuvbRolw==
X-Gm-Gg: ASbGnctPIa24ogc7v+nkX2AcpzvTxbTY0G8aCpU230a5//sx4KmBVmDGOyZlh9jBKOO
	s3mHM8aZsPPFLCrZ3APy+aVafFL/HiL3ryerP3qGMI7y3FVhVBG0I53dB5gxjVm/TUwbbbDVHRU
	+hTk15DWSUDc1K9sWX58eoDSD7FFNoIrgdyULcrtPF5c8qk6GNzFyXAq1pHqyj6HvziL1wTfQO/
	bw2OjKNn8WERTY1n9Y51tbYL4Ke2o/esuckhZ3YopOlWm0NaKSNP1Mof8sGmB57DnnE4mbS6vk3
	xkJ4FwuHsc9PsH0V9fAa+OTIMW8uwVYYGMqz1rAI2YQuNAh9NU1Fo8+u9IYXe4p33mWC4x75paU
	E4cLPjtisaIVewHRW6vCrKqGrnQiP3A==
X-Google-Smtp-Source: AGHT+IEH9vgTlcxdiF6XhfOIZ03uZg7cVj9D2X5Kcvl8l+VjTxJYJ7B4eonG3Ob9wEjzq5TdghQxaw==
X-Received: by 2002:a05:6a00:2daa:b0:749:b41:2976 with SMTP id d2e1a72fcca58-76c46095e41mr19801888b3a.3.1754912425266;
        Mon, 11 Aug 2025 04:40:25 -0700 (PDT)
Received: from fedora ([2405:201:5501:4085:eece:e0ff:6b68:de2e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce89132sm26837930b3a.29.2025.08.11.04.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 04:40:24 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:10:52 +0530
From: Ritvik Gupta <ritvikfoss@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Tamir Duberstein <tamird@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4] rust: kernel: introduce `unsafe_precondition_assert!`
 macro
Message-ID: <aJnWxD7qyOOXz543@fedora>
References: <20250808192005.209188-1-ritvikfoss@gmail.com>
 <aJm1iWpM_mR7mkMh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJm1iWpM_mR7mkMh@google.com>

> > +    ($cond:expr, $($arg:tt)+) => {
> > +        $crate::unsafe_precondition_assert!(@inner $cond, ::core::format_args!($($arg)+))
> 
> Tamir, taking your fmt series into account, what's the correct
> replacement for ::core::format_args! here?

Whoops! I wasn't aware of the fmt-series! Thanks for mentioning it :)

After a quick search, `kernel::prelude::fmt!` type/macro [1,2] seems to be the relevant replacement.
So, the line would look like:

	`$crate::unsafe_precondition_assert!(@inner $cond, $crate::prelude::fmt!($($arg)+))`

Does that sound right?

[1]: https://github.com/Rust-for-Linux/linux/blob/8f5ae30d69d7543eee0d70083daf4de8fe15d585/rust/kernel/prelude.rs#L36
[2]: https://lore.kernel.org/rust-for-linux/20250719-core-cstr-fanout-1-v2-4-1ab5ba189c6e@gmail.com/

