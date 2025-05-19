Return-Path: <linux-kernel+bounces-653499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C08CABBA7E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 12:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C75F1881F5A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 09:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D2526C391;
	Mon, 19 May 2025 09:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u3kKSL6g"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F4F26D4EC
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 09:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747648705; cv=none; b=acKOPVO8ad3kDgOJ63Y8DpVkZ1IHerUPkVq5eSxdEIEMiOp3AGwOhsJAgnq/4fhzXq7ziucr7/1ttFWfIyyGOaRIEa7kCVu24r6PvYUwiE+6R/mHvXNC42zBLCOZi5YUiSSBaIWf3y5Ty6FTvCbC/9UaUcCg2oY6f8mnr/fJW2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747648705; c=relaxed/simple;
	bh=9ZrSYtXZNV36ReXjN1cyyFacq399yxsM28VasbnyhBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDpB/V/3PXaptHSAevJ/n46hym8eD8qcbmmrbHVHMgtlPnjmn7glAto3farXof4Dn8w5+h8s9bcScsILocM/LsRqmP/c/o8F1Wy2TuoMPrIjhMuNYKErgEEl1DYTTQssqvSabKvcll8qxWIW/mlWZMnJ6lIQhT+e9B/bEoLTPhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u3kKSL6g; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-30e8daea8c6so2137095a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 02:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747648703; x=1748253503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8YfUtIKRuXb9JY1BcI3EzXnVUtQz9qLLJZfzR5tXeT8=;
        b=u3kKSL6gRqLTaHbYjSQNPjIj8GY9BRBP7V5Rcx3XxEJBAumzUlpR5Y1fs96DJk4tMI
         g/pHJKFd+TW0fOkd2QJ6AbON7yKY7wSKxY+Bq0TIGabL3bPSaEVdXK0KJaO/uQjawDkK
         R8qvaz/hZ+1ITvJsHZtWwI4EsQJJwwHcVmXZviwxe4T6cPICgbTDUh2Fe2EiLShj7oyl
         9M0W/eh/wuhrAz67FFb/RdLWw51Cyae1MFlw22o9/8U80W8+CYOV1wD/sGkwfq+0xqzl
         iIE/0W2SW8pFGTT0ALvAFvyyXVqerQaR32E2xlzYG31ULHtaalcruQL8MjfquVVIRxkS
         4Rkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747648703; x=1748253503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YfUtIKRuXb9JY1BcI3EzXnVUtQz9qLLJZfzR5tXeT8=;
        b=HQ6RIT17JB73VwRnKFXCNqGcBN3+75Ijlr6e2tKEHbggHWlJJf3k27oo4KceSkdNLp
         OybvfNgPicYbvoauwFGIUKI2vWtCOPpiCUjPSmkoSVQP++8YrXu/2xjYvWzjbmfqlLCZ
         jjGCf4MA2UQDE6N//eC4gCSTaS+TZ8Z+mUBL+dAE+3n2ULy01VU+relC8bVjYDZT8pxS
         3ci8PXY15ZnnkVfZ3IzGJcVvmjqFFpZJGzpRiSh7N0C9Balgu9QS5LYdbMHs1dMu88gW
         GEgwDdRYmi0vQ/ZLS2rUoDpaPnv85LAXsQhE+RGvJ/E4W4Nixq78yl7gJG0dwf2nqGNL
         pxaw==
X-Forwarded-Encrypted: i=1; AJvYcCWJCeGS1Ec3qSIEWFi1ozs3PUJfFZrM7f/y8AsFjcOsTAxUyChZhDWMdE74ZJINa8//fXW+x/JJ/F1jNZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCwVZ7ZGs+G6hBPPfWOfm2I45ANWxENqCPvbdKee7tjtBTUzJf
	Gs18zvfuje6DakNoUOhEiVY9kZRU2nyABOjyUX+jpKM/89yOf0KSZzpFhMeobrQYdYE=
X-Gm-Gg: ASbGnctJUV77lNqI3czPlQHhUn7OOqSCrykBr/zVRC0ISyqZS+04ZMmKK0AomNWjZSw
	C7VxHs4NR/e9zQon+GoCd5YHElnpzIlly6H4atISO274IyRS1PV3csbfcztS++ct5ag7xrYRvmc
	nwSu1CtVkT8FT4dpnLHNo4N3/SqWD23DAAO7rGTk0tPLPtgacxiljnY1uWg6ncqTBsv4pcGa5x+
	SA7JbvqpMB40zTsg17E4gr47vjdSmvnoM42mND/9QqbMHniFKdUIJLz6Skj2MR2OcPFrT/Rk3t5
	5EOvpg2vau4gJM0vnZdER0aN407nf49jNtq92zCspxz2FbspZMHbcyGQ0Gc5oB4=
X-Google-Smtp-Source: AGHT+IFuN4PIJtc43pQLr5XwTeREs6uTt7w0XKP4X6Augem7eTNNda+/TECXA7tAATZlEUrMWLMBag==
X-Received: by 2002:a17:90a:d604:b0:30a:9316:75a2 with SMTP id 98e67ed59e1d1-30e7d52adcfmr20450446a91.10.1747648702910;
        Mon, 19 May 2025 02:58:22 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26f0824702sm5331260a12.62.2025.05.19.02.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 02:58:22 -0700 (PDT)
Date: Mon, 19 May 2025 15:28:20 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Benno Lossin <lossin@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	Yury Norov <yury.norov@gmail.com>, Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Andrew Ballance <andrewjballance@gmail.com>,
	Anisse Astier <anisse@astier.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V12 06/15] rust: macros: enable use of hyphens in module
 names
Message-ID: <20250519095820.b2ha3ud2uddfjdya@vireshk-i7>
References: <cover.1747634382.git.viresh.kumar@linaro.org>
 <21b4c30db60f22d56cc6386a18564705ad3a6f4a.1747634382.git.viresh.kumar@linaro.org>
 <D9ZZ93ZGKC3N.9VGUE5QBJS4H@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9ZZ93ZGKC3N.9VGUE5QBJS4H@kernel.org>

On 19-05-25, 10:00, Benno Lossin wrote:
> I think this is supposed to read "But Rust identifier cannot contain
> hyphens, so replace them with underscores.".
 
> I think we could just name this variable `ident`.

Fixed both. Thanks.

-- 
viresh

