Return-Path: <linux-kernel+bounces-738317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAE1B0B70F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 18:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A79ED18944EB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 16:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE3722127B;
	Sun, 20 Jul 2025 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkLd7zup"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B64FBA27;
	Sun, 20 Jul 2025 16:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753030720; cv=none; b=ELNpz1cRxII1KpIpDIMZmQl9QTtuXxFb6K1cKP3hteTUEb31M6mEsA1KLDCgEzT5eJGk0on7d89pc9t1r6O//Me+A9W1YcyjjQ3/4miigRtwB89/uVWjoK1Rl9BGNkN+zrYHZI66/N0zYeL9oEGSAwgh14Up1imCOy6qgyshRgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753030720; c=relaxed/simple;
	bh=2yubbmRxH5LsZ5ooN51JPkfNPv+HNZTZUvgg+LmM9Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjeGT/4Uh/Q6C1A+zjHd5eY1VTMvntxEc2R4qUatAegt22JzU585d1EORTBjrLJA6XLdAlLX2FAH4lwyzU6rYhNJcTfv4FFmaa1AxyodptcLGyaDNvilg8UrDPpfMDhevBGROHDHlhHxhkQ5VCNbjY1JoRY9PByoIlqnpJXleM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkLd7zup; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-313fab41fd5so962204a91.1;
        Sun, 20 Jul 2025 09:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753030716; x=1753635516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdUYeYp5Z76EjDA83XxC6VbsBdz0bcceUKl/5FQeX1s=;
        b=bkLd7zupxRT5mniNz23MN/1lA1jbZ5m7CACYHI/J/PhgFbOzF6dnSNzOTSLncvETZj
         WaugwTwybxK6Se8jfwHO9i4lAmHhV7cjx48Uu+8xu2pZa9aYu0y2NLZTVYTNNT9Zrkx0
         7UELct9AQ4/hFJRF/TGS8LkO6WBVlDZGxIwStjjOGBOTYb9Acm2y6VT1fwwjGnNOcQfx
         IJMqYrg3cPBnO7UrFLgZgvsyN0qD0l/PD3ipy+Tn5PBfaRCItqGFpPWk3nUfiIy6PIN2
         K70tRN36XWhmRi7wMuLjomtNnFp70wbjBNGZZcZdgppuu791z6fDFDSXCVrWGbACwZdw
         YiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753030716; x=1753635516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wdUYeYp5Z76EjDA83XxC6VbsBdz0bcceUKl/5FQeX1s=;
        b=erNl4OwQbEYcw8t9J29DazvR+473uEsZFoQUhMlpMryzOs/ZDZl1uerzf9J2c0Wbuz
         bFVIofNMN6qFKpAhMnVhSxNfYa+6MUkoj2iqbQPqp1kDPxkWl5I8dFAnT9SHznKapfJW
         cfoNO2SrxvBo2hsI5R15DjkUnbKBak9gd7tMcULowo9POttjRJu7c3AUqYZdQzEg8zJj
         nCQ7C3Jvv0liwb8lylu3eWTsPEW0eDd4yz9ZgJ/2Jdt8DQo9gq491g+LFZ4JjojaO/cy
         OlNrkUSELKGhjawkbWla2mWBKoH5edoX1RSSFgHNskLXJIgX44oZ0s/Cg1TV+9ztMhdJ
         5PtA==
X-Forwarded-Encrypted: i=1; AJvYcCUF1+CrTdRiqoJV7Up7EdNgjofW4f9ijbbQDxESsA8AUZH8hrVIQLCuoOWSMO7rBr+Jm2swvzsJHqnCwzw=@vger.kernel.org, AJvYcCX3zPqU9DTeaYXY/H5ZpHyYZH0l8OueXiRyBZueHsIyWzBOwNrwVA1IB10P2DwYedQH16G6pPLWyNHJHxZDUh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkAbceD9x3mc8Ks2EwiGuu95npnKAbt2/ZpmMRNMQQKFTPjxO+
	RmzO8LLw459OveZkC3NWgG9GxrmUAxOIaKwvnes5sIphQOkGiVcyhieuhd7yunZ0NeKRN4ZZjPc
	Q+7AxsZ4aeTIrUY/x6eyAUYNCcbTkn2I=
X-Gm-Gg: ASbGncuqyOAKWEeUycH91nx7HH98bH27nlComulzLX2w2KGCzX89TiztcuSpP2isex/
	Z6JbpRTcYKHIgFaK7mETCZHLGn5+ywt34EICoPFkIYtjme4wW8ZkQBrzeQXRhrlKk0d5x9Oc0IP
	a3HYHQChCIHgr7KdCTSW9VnIGAm7LqG0yCN0TVIq/7uX/gQjislWmGxtcrItU/YKRzPdNuNhpg3
	IMmkp2w
X-Google-Smtp-Source: AGHT+IGAc+gtLe8Qb4KNS8ONEk7Q/QSPFMu0n3d3UxXiHgpBsldkiiwmN5Y/vwVUneZ5jUXJn361lx7fu3zB8li3FyY=
X-Received: by 2002:a17:90a:da8d:b0:311:e8cc:4250 with SMTP id
 98e67ed59e1d1-31c9e75ef95mr9753409a91.3.1753030716342; Sun, 20 Jul 2025
 09:58:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250629024310.97937-1-contact@antoniohickey.com> <20250629024310.97937-2-contact@antoniohickey.com>
In-Reply-To: <20250629024310.97937-2-contact@antoniohickey.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 20 Jul 2025 18:58:23 +0200
X-Gm-Features: Ac12FXyb3QGPSWcSpcqGY5NOR9WJVM0DYT_BhBpsFtG5MN0u6oZdRWYQ_Qy3j68
Message-ID: <CANiq72mAODXhvakhvbSAWXi+Hb6AvVS+yRXGcqQtkykq5qTzcA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] rust: kernel: create `overflow_assert!` macro
To: Antonio Hickey <contact@antoniohickey.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Cote <danielstonecote@gmail.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Antonio,

Since you are sending likely a new version, a couple quick comments...

On Sun, Jun 29, 2025 at 4:43=E2=80=AFAM Antonio Hickey
<contact@antoniohickey.com> wrote:
>
> Co-developed-by: Daniel Cote <danielstonecote@gmail.com>
> Signed-off-by: Daniel Cote <danielstonecote@gmail.com>
> Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
> Link: https://github.com/Rust-for-Linux/linux/issues/1159
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>

The usual order of the tags would be:

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1159
Co-developed-by: Daniel Cote <danielstonecote@gmail.com>
Signed-off-by: Daniel Cote <danielstonecote@gmail.com>
Signed-off-by: Antonio Hickey <contact@antoniohickey.com>

> /// This macro is only active when `CONFIG_RUST_OVERFLOW_CHECKS` is enabl=
ed.

I would probably add another paragraph to clarify/warn that,
therefore, one can only use this macro to add extra checks for users
that don't mind panics in such a case, but that it cannot be relied
for things that need to be always tested for (to prevent UB, access
checks, etc.), similar to what the standard library says for
`debug_assert!` like Tamir mentions or the `WARN*()` docs in C.

> +/// # Examples
> +///
> +/// ```
> +/// overflow_assert!(3 <=3D 10);
> +/// overflow_assert!(5 <=3D 5);
> +///
> +/// const X: u8 =3D 5;
> +/// overflow_assert!(X + 3 < 10);
> +///
> +/// const MAX: i32 =3D 42;
> +/// const fn f(x: i32) -> i32 {
> +///     x + 1
> +/// }
> +/// overflow_assert!(f(40) < MAX);
> +/// overflow_assert!(f(40) < MAX, "f(x) must not overflow the max value.=
");
> +/// ```

Since now the macro takes just a `bool`, I would probably try to keep
two or so of these, and I would add a couple comments and try to have
a more "real life" example if possible.

Thanks!

Cheers,
Miguel

