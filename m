Return-Path: <linux-kernel+bounces-879205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5A7C22853
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D1AB4E1A7F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF5C33468F;
	Thu, 30 Oct 2025 22:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OzQ9cZTw"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF3E2FD7B2
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 22:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761862226; cv=none; b=MGW+liKy39Ysp5Bdnlpdk5btPGXVphyVDLVRKUcyob0jckWWCt4chYa0w6bkemhbs4K45fzkywE8YnNA6NTuVID9eiUePh58Gaa6OstpkAVcCUl/rQ/XYYlXe1oVY8ENMMf3z2k+91r2bqVi4QYaR/dqThJZhJhz31kVatFg0PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761862226; c=relaxed/simple;
	bh=yi3VN5iGYK0efOoeR4bO5a0LbuJ3TDjRF5ahHiHQFIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6wCybiyL09mJOEhNPr36DV5SYroAyYzxJTSLO5jY+cGmJF1VnF3sQ06/dDGwFQNBMh2ub7YceafDRmmSMpTzY8zgdgqK+i2fq74m71X+3GSzWRyuFDU93tCzIWk52rotFQ931Rc0gOF9Ew6HyJZLabodWGsTphHQzQBJZEbXMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OzQ9cZTw; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6406b8e1fb8so1554466a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761862223; x=1762467023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yi3VN5iGYK0efOoeR4bO5a0LbuJ3TDjRF5ahHiHQFIw=;
        b=OzQ9cZTwp5Kdtm7TZ1v1+LSqhLknw5BJozH/7Jjiz0h+YDtceXWFnk4aXT2T+Vo3oO
         wtJuLnSlYNSMaxQ5LjSqOWs8X6tYxx42SyBGupbRvJ7htcbh71CEeTjx2ubcA88awNMM
         kG/hMK3fIn3rnChkrWtAH4J5sdWeFjP7e5PshZMQEsSuvSGg7ERZNNyBeyEgWtVskLs2
         jEMBVxtZjZmmNxcyGGzPGI0MBvE3qz5MYDYLgAaiXZJQwqmd5S3zWnfOKx6mWDAyquzw
         kDSlfxsXZjj3W8i8Zw7hDtMUKIqyX/e+kBa29t+0t6Sh4NI4N5AUUWOjk7U8qvRy2QC4
         rtFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761862223; x=1762467023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yi3VN5iGYK0efOoeR4bO5a0LbuJ3TDjRF5ahHiHQFIw=;
        b=ORrwqQo16yNt7rD7Ed+P0UGIifbugK2GImIkLjUhMNpN04Us+12o60xw7vdn8W4Kw3
         NEAbeyadHxKteUy2z6KEJrrulRNUdFT6CYttC5kEJrUSQCB0kVRB2/1itTNp42WR3x8E
         9UxqYBw84BzM2RtIvWBIgQlm1NttMh/Jqp3zq6Lrwv10fIw2vm+qJ1ryxxiF/i8zruwm
         IYuyapSds8tjzg1kFnwVFf/Usq2QLF84IrPpWtxbVX6x4hKowSZeq2ZmlPLklpMPjpjL
         H2ioq++p9aAYi352Q68qtqPbDGbV3E+WmpmL3vDRKumjh5w70yDpwfMGVy8htpouyQRL
         bSAg==
X-Forwarded-Encrypted: i=1; AJvYcCU68ndfKX7aaB4xzZygXcUXRMOUoP/671NSFHrnGbTy0wCtWQfQ30MyQ7QPzaa8wuMsox1+/lU/98OQQa8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd+NYTy7IcjlThHjSHAHa3tid8K/emOPLVFlM4dPE6eNjfQOZn
	Tq+YPCfcgHzAK2Sk1nqQ0vntHnAdFQIBnfflVqA4YU/ZgVQOCSIm3D8fQXN/cjEXrr0=
X-Gm-Gg: ASbGncti4hfI6uHCT5rCFWWPIhQM7CYf6joDqVfuOHQ0PrS1JLXClUaZvY8JwQJvJ6K
	lhCIrnInqcaioXlFAArWc3Nh8KXGIIds+Uno2ZwXqVgU52CJDKgOFCQn1Sa+t1zjumqo3c4LJQz
	xQlD4AEoaOJWEbnsO8oQiTKc+Uw3noNPKBA1Gmxwl+S/hG8+D+JrbmiFA48M7nui1vIP128yiQY
	zVYKClnQSab49mv8ISTriymb4LQ4FPGBdp4OTV/dZ0+BRlL/YcHZAvS+hFEP4tEl4Ctn6TZZ2IX
	mZk4cuUz8z/sYYKiV5Y5MOVpyeXbNofYPGcwyXdFPpvdM7pTLFzU5Y1a2MNCa+mInH3Oy/bP4aD
	nsjOF3tGBmQjoLiVmyA9cQqY04OBFH7PpfZFryWXFBCnx3YdO8XLFmeiPvHsby0y9pYOur82l8Y
	WAYJV3CA==
X-Google-Smtp-Source: AGHT+IEr5KfO9g5XB5M1oZw7bGno87HZnZZWw7Q18m6dtyDaC7sCL6xNw6zqoj036IrByLM0+eD+5w==
X-Received: by 2002:a05:6402:3596:b0:63e:b49:c9c3 with SMTP id 4fb4d7f45d1cf-64077082133mr839973a12.31.1761862223219;
        Thu, 30 Oct 2025 15:10:23 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-6407b390d7dsm60738a12.10.2025.10.30.15.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 15:10:22 -0700 (PDT)
Date: Thu, 30 Oct 2025 23:10:19 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Subject: Re: [PATCH] pwm: fix Rust formatting
Message-ID: <m3shamaznoachabbsxsknzk3snp7nrkmkwqmnfibbwmdfbhgy4@3seayfxsb7kh>
References: <20251029182502.783392-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="stxqejammn4geqdw"
Content-Disposition: inline
In-Reply-To: <20251029182502.783392-1-ojeda@kernel.org>


--stxqejammn4geqdw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: fix Rust formatting
MIME-Version: 1.0

Hello,

On Wed, Oct 29, 2025 at 07:25:02PM +0100, Miguel Ojeda wrote:
> We do our best to keep the repository `rustfmt`-clean [1], thus run the
> tool to fix the formatting issue.
>=20
> A trailing empty comment [2] is added in order to preserve the wanted
> style for imports (otherwise the tool will compact the first two items).
>=20
> Link: https://rust-for-linux.com/contributing#submit-checklist-addendum [=
1]
> Link: https://docs.kernel.org/rust/coding-guidelines.html#style-formattin=
g [2]
> Fixes: a3d5a2b8da94 ("rust: pwm: Add complete abstraction layer")
> Fixes: 121931a7b4dc ("rust: pwm: Add Kconfig and basic data structures")
> Fixes: fb3957af9ec6 ("pwm: Add Rust driver for T-HEAD TH1520 SoC")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E

Thanks!
Uwe

--stxqejammn4geqdw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkD4kgACgkQj4D7WH0S
/k7ZFwgArUy6vPY6bP//G90gYhm0oJvRmV9rUOHtEWSHy7Y+GEm32WlMa6z3ojWB
DHu/TuxL8wOTYetKoEyYOvVeP8RJuRB3y9PX5FUJBUKTan2TyLB6UglIsCOYmICn
KHSXiLmsiXBkCwCiNZW7v/3kFsfBbzL7oGsbGEUOuV9V53F6Eg2vSkmWVQ4TgmpA
IqUvkgohJ/HvrJcXJhy8wrCvKVtpkaTnA4rEtJPyCeGm3EJhitm1NF1VjVg1aT7U
iPgPBELbJYM+X1j9V6lmfaLGNo1wJ5ubgmXzyAnSwuaS5Tj+XOFYkhAwynjOyQS3
L3ute5H0Sj2hyzf7FHvWac/JBcO9EQ==
=IT7F
-----END PGP SIGNATURE-----

--stxqejammn4geqdw--

