Return-Path: <linux-kernel+bounces-805777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 399E7B48D40
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48CF1B28319
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0494A2FFDC4;
	Mon,  8 Sep 2025 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NI4OKK0x"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF4C2FE05C;
	Mon,  8 Sep 2025 12:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333941; cv=none; b=szsWdot4NB/FsZoS8m3NcQ9KoD/gZh5tZPSWqKIi+ITCQ2J+vpfNcLduCoiMxQyhGD9Vs+SQpl3zq5LhSOJ3TX9hUZTWM3DHVXjDr2KZF+41ERKuP++teqJbDGdZOLF449iUg5bOyiuabfKvELeeWvpMDWVIYPBtnbJ6iAMNt8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333941; c=relaxed/simple;
	bh=Bjt5TTPVSQZ/tHjsIJfb/E1h7CryZzk5zV0k9z3ue8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VtqYCyf75YO5oNlnRiCBw0lsDSy2v6DtfI3I/Bn1Ksj4IpBUAVouJNqEbXEs5V3eu+vxFqcZwTZDpHl6SDILF+SsIXffMtlW7Zz6YkDOPALEV1G2ZVlYLTkHMCvYFW0UweQnGjZDLmAnMtJic8RvxyDbJa3xQfDA10A/zSaI7UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NI4OKK0x; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3296a9d17d3so280715a91.1;
        Mon, 08 Sep 2025 05:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757333939; x=1757938739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnVwoVyn//Z2vM4s+si2Kxwai71xQMgGvo/eM3BxEEQ=;
        b=NI4OKK0x0eqw6FWz4cX9/Rx1GwX2q8YEDCVD5DP68KQN1odGqjGoMOotcQmMgI4AL0
         VI4JplN7qpwC8x8uURM67fH2YYc8bNX7jt4Q8PzVa7/PqGnZLPehpGALniQVtdg7LDCY
         E3DR4zA4WiB65h3XOXi3Mqmy34iO7Qo4fUVlL2scAjCGAc9rK3XOKKCVGZ82EuMJ+0qc
         Pu2P0U8+/ErVAraO8rtRkJwT6W7M4wTF8828MEHCHo3/9WuxiQOHSodIdAIqvg306/+X
         aiO/3pOANpN/nkFsb6zib4AVleP7+z5N0Xd+KsmbWFiO4CWkDblaaAJExYrp2/IACSKa
         k9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757333939; x=1757938739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnVwoVyn//Z2vM4s+si2Kxwai71xQMgGvo/eM3BxEEQ=;
        b=XQqIBvzTco9ePSkUhEcZV6UHdJfw/2iHCcXMEpaoU3pSpBa9qM4zSDozhP4TIyBOxR
         dmH+HzaMu7zUU1O0n29GHFxztx+jMz0OhkfTxxGV66cInvt174Hmx110BP0AMHewYJ+f
         8TPFUb+yk7EPja3BsBKVb4B8jEZ1q2MvqyYyciKYIQ1oj5RBCZuFjcFpGOKbe0T/L6OX
         cbv0GBgpjfCXZpgomD90/IfJgHfab13nITjr9JiYTD8ZcUCfBZHwd1XvVWZ51IVRHyCN
         87HhhExU2/egSRKddv1/hRYC75WU9URpRdKsFd62W995mSb0wlpABY/4bA79N3Tu+R9+
         6AOA==
X-Forwarded-Encrypted: i=1; AJvYcCXErNfXbYMqLonjQIHA4yhepDyPzUQDyfud5ec54/RAE1hK0FqgqYfOQGE76quavUXIf9ULG9NU4nO5GRw=@vger.kernel.org, AJvYcCXXFNtBaL612EOxsun/9oiL02gWNm1rA4djYKTmVrBuU7iY65Z51q7qL26b/EmBGOQrBr3NUNKqBftsFnclFJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIY2h9d8AIAvYITMsYPkUgjGDu6jzn7gcSpqqGCPu8kVOOfqLY
	79S42kBq/M2ZJ/B4DbkIpua/mIFG66tJa0MN4hbtgpyu6QFfkFpPxJ/yO0Gg0AAhITyhcgq7Hx7
	o4GqewveFM0zSB2LvbRDjMI3ENduTibU=
X-Gm-Gg: ASbGncvxvdNMWp9UKxmz3mFdKyfISq6QRx5ITJBGtFQkdIQ2AcnmV6ANz6X0bB8g1FM
	i179QaVM/lTGm5iXx42awc5jVwWJ/lT4B9lvAVbDuUvaX1T2rwHe+aIONJZ3RiBkhYQAaYMtWd9
	5ry0DkLqVFlT+Qb8jMEYs+6cz3U/vJOp58ITn/gDF0QtdNG1hxttK0cJqTvHyNyg8n761t2IH7L
	gHGrcNAFINs50jp3TrVWjw00B+Bq2yhPnkgNkTThI0E4zhNE9Jwo36cWEp+mz2yOFWybsrSMgip
	73Kcnhp8tLzs6K3MbvCnianxIv3CQ0Jee0Pu
X-Google-Smtp-Source: AGHT+IExp7vrnfrB+oYdUfZxpaoGpWB4pYjPADczIeby99Fh1CAe5jhOpEJKx/4M3VoqQi9Cy2FogH2NYNCkfA8iWfc=
X-Received: by 2002:a17:90b:1e53:b0:32b:7082:b4 with SMTP id
 98e67ed59e1d1-32d43eff842mr6206525a91.1.1757333939205; Mon, 08 Sep 2025
 05:18:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821-num-v4-0-1f3a425d7244@nvidia.com> <20250821-num-v4-1-1f3a425d7244@nvidia.com>
In-Reply-To: <20250821-num-v4-1-1f3a425d7244@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 8 Sep 2025 14:18:46 +0200
X-Gm-Features: AS18NWA_7SYOMxlej0IqsywHZCPkpSHFIWWWt1sNnYld0p5CsJB3tagME3ZntpI
Message-ID: <CANiq72=wsLQtOmXuqAnLJbppq7BgdU=XoZ7hT86LkwLYEWp3nQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] rust: add `Alignment` type
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 2:42=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> +/// TODO: Temporary substitute for the [`Alignment`] nightly type from t=
he standard library, and to
> +/// be eventually replaced by it.

Should this be a comment, i.e. `//`, rather than part of the docs? (It
is fine intermixing if needed, or putting them at the end of the docs
too).

> +    /// Validates that `align` is a power of two at runtime, and returns=
 an
> +    /// [`Alignment`] of the same value.
> +    ///
> +    /// [`None`] is returned if `align` is not a power of two.

"Returns [`None`] if ..." is probably simpler.

(Sending these two nits since you will send a new version with the
const generic.)

Thanks!

Cheers,
Miguel

