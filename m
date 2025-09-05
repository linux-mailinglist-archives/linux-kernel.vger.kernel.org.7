Return-Path: <linux-kernel+bounces-803006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEECB45961
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DFA6BA1761
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C941135335C;
	Fri,  5 Sep 2025 13:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lyupn+QJ"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90854352FF9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079658; cv=none; b=IF/mFJ/1QCf01/R0M2ip2ZAEiLczfNn6WMvTgQo7FEJF1qT4p67VAJ9Myay0kpjB9BLvftKB+jMx/5l2DzBs7auuTqTOahIwBpQwXyOSvQD5lvt/k15DUlUOz7/Uv0bMaiM7czeWIMD4Qd0V7joY8zCOcQ0cWNbAztidhjyU5gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079658; c=relaxed/simple;
	bh=voOmW3RsbWCewMWd2r+Mg3J40TZ8+mXmnPEOSB0HzG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kvLogqcFdPqErrQbaqonDDDCk5rd91cLqQWbKfo5RrVwinkDDOAofrm0zdutKAYqHz6DBBeH+UPe+HNK/Q51vQ0WORK7MhXKBX/ebcgskrZI3b/sFMTHCyAmBgprkOsVjHYlLEvLBowCcb0Ur97wOjOW/sXf3XD2XmvB76vNiTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lyupn+QJ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so6683705e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 06:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757079655; x=1757684455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLbhypj/XaQGR3EoITdFfKg7Bji/N7jJGeDDXFKfJiI=;
        b=lyupn+QJbMiq4zxIhMMVJA353p2sybirTzEFCo+gVHdmcgT+f3CTfeH3S8LxtpvCHs
         0+aZqsYEyLwv+YFAd9UFu181F3gAmwbBCxl7zxXJKvekDyrggKx2h+OhQvNFvAZ/WIrs
         fPGYVcVmVFhuc2oEueym5ARs8vROYWzD5oBOlZu+KVAp1XUbru9xuvBdKLmDUBr8orNH
         dSCbrdHEm+7upkam9SKM2w2FhLDK7ZVQuAvqTbgpF+lM9BW2zCnNJ+C2pI+Yapmal2xn
         syPD+gdw4omAbeIn1edYqeqO1ZSmBzeu/EBPT1nPju2sFSV9CemP5K81S00Vtn72WcoI
         ywZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757079655; x=1757684455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLbhypj/XaQGR3EoITdFfKg7Bji/N7jJGeDDXFKfJiI=;
        b=J/aRAjYq78UG7LYIIytF7QzuOcQ2lwljWFTcRGF0CZa7XN1TcQo1UZWwOlSTIgN2Z3
         lY1GGtLIYezFG1MXXMA9GTbCESWN7Igza9f2jR0rGEGv4Bywlyj51dbSCQPdH36NAUCZ
         RkbzO+TU4dsG1/R0/EuTVBQebLGNEwRhjmnpIlotMzCDeGQX0OYmArh0GpBP+aS1qqRs
         1iAUDl4cFL5PfHfn8Dnp5Ypw/bE/n6pTToBs9R1xP813NCZn3y6cE/GjxL1oa6oxRmFa
         3XOiUWSYrnWws06Fn3xAYHfBGGvsLEHlqW8AqSaQboS1CFgaDubnQxTMnfJH7iH5LtCL
         NBxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIiDsbTuk/hc5DBFH1dkbk1jAyyKjSsaeOj1p51iYa6yHraKt0OOQUM6OjlzkvOihzNqyhT4bL5BPMBmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSbwYN3iGhysaXA/xNYXafEvSzQxkbxVyzBMhyJMcfiKZxqZTT
	Mf5si9Iy5F4iTU7qJR7jwT9gFRUBAEvVKLyzlyhbOhV9K0yp1VkdLj52adsI+YwUBzqL+fSZh4p
	68JuUaYJ43hsBEzaAiFeXyYyyH6Z9IYpfB2G9Omwx
X-Gm-Gg: ASbGnctjd3cJa4UUv9zO3uyV7b+B0/pVL3kJjvZUHhtYJMoPIWpBqjIlDYVyN21zB5Z
	asLpMxnQ6MTXwGxaUtybDGDkqGryQZvshvrTDpTcFTMtpseh2Au8dNv0fEy4XWtDabg1FH7suDO
	rfi6gRYdeJxnx2cwPwhTqHDQN95k0k+xTVYnFygV+ldgYF2UKftcuZUNOstC+2hxrLMU4y7u0K4
	IC6x9KnlPNiahr891q8ZbzDVM94sar+HynX1frPaxyMD2T/O6gVhrYj/sk5vSAniyRVOep7h8q+
X-Google-Smtp-Source: AGHT+IEE8xO/KRFQuhi+RnL+UVzSRNYl1mvi1FQz4z8HtUo3MeJ8h9Cv5q4pPdBWC/rV1bprpoRNO+upVHUwkCD/bms=
X-Received: by 2002:a05:600c:a107:b0:45d:cfd0:55a2 with SMTP id
 5b1f17b1804b1-45dd5b30b2emr23719205e9.5.1757079654731; Fri, 05 Sep 2025
 06:40:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905133401.3312707-1-lossin@kernel.org> <20250905133401.3312707-3-lossin@kernel.org>
In-Reply-To: <20250905133401.3312707-3-lossin@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 5 Sep 2025 15:40:42 +0200
X-Gm-Features: Ac12FXzp-hxMnPrbay2SNTSIFeZcHR9SPtkB0WwNY1bsCkUYOWnnCCqhah1QSHA
Message-ID: <CAH5fLghuF=EM-F8vzs+AzNrXzHEVE8i7_ZMW1SpJCZ96Ao3HkA@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: pin-init: README: add information banner on the
 rename to `pin-init`
To: Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 3:34=E2=80=AFPM Benno Lossin <lossin@kernel.org> wro=
te:
>
> Link: https://github.com/Rust-for-Linux/pin-init/pull/81/commits/3cf4658e=
2db96b4a6b26db9478250de2ffcfa1fe
> Signed-off-by: Benno Lossin <lossin@kernel.org>
> ---
>  rust/pin-init/README.md | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/rust/pin-init/README.md b/rust/pin-init/README.md
> index a4c01a8d78b2..723e275445d4 100644
> --- a/rust/pin-init/README.md
> +++ b/rust/pin-init/README.md
> @@ -6,6 +6,18 @@
>  ![GitHub Workflow Status](https://img.shields.io/github/actions/workflow=
/status/Rust-for-Linux/pin-init/test.yml)
>  # `pin-init`
>
> +> [!NOTE]
> +>
> +> This crate was originally named [`pinned-init`], but the migration to
> +> `pin-init` is not yet complete. The `legcay` branch contains the curre=
nt

typo

