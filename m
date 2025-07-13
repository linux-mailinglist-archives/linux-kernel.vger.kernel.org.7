Return-Path: <linux-kernel+bounces-729220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34132B0337E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 01:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1EB177014
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 23:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F6120C038;
	Sun, 13 Jul 2025 23:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHsQj0IE"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2022033A;
	Sun, 13 Jul 2025 23:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752449836; cv=none; b=MxJlHfDYvMPq1PlY+9zzAFw80whXx5rOyekDU7A0+bnWumhQj0lxTAIS9zG2OcaVn7j1Vilc4/cqbCs6sxDU2S4qqaQkxr+G0U9tiRCs2GOzh4lV+ewD8dTj242//qg0grgSd34UFiCoiCHVRchUIqnuKmmKFEt1KzR0IRbY7uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752449836; c=relaxed/simple;
	bh=ia8YusRYqbv8u4jjDVxff6mRXlYfwdBKEdvfZsd8kaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LoZZHcjVWH6OYYgMCJACHbZMYnIHq41IGdOs48InrSef4A0GA4P9oGUfRg1FbKZSZ/dXgL9zkZSjcPWK9z40Ls+yJiybjBIOsmhnX04YxVKX6JcagzYRBNhOjL7OWnbLev+YwKP60/7GPbb0C5/JdiSL61fkQ50UMc7SiyC4mSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHsQj0IE; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-313067339e9so743670a91.2;
        Sun, 13 Jul 2025 16:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752449834; x=1753054634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xki2w5eQHb1fLcDO93URZ4RBKttkZT0EQouQZSyMJfc=;
        b=kHsQj0IEKz/purBWD94ehpiCU1EDI8leUwCVuzixiTsC1f11E7ep7Zrc9gIKCKJXJF
         McRM8Kn1u9zwh51ZUeWiOluE0O9KnGJ4g2NFSYaLyc0QQyQ8tFSV1hk8fek5iRLLoSxj
         3LrXq77JJD5OJN0evmMa7366p4HCj+jO5nklaVcHmctqqT2P0LZqili+dEUiHfoD9lbK
         FP8fNHTLkhFU+Jo66Scwh/ih8kWmPVfX9siFGX//6/HjRqPtZMKJ+sLaRSP36RF06xuL
         qPBzuARbhIM8xTI7ohpENQWc56JkuwY7EMd+QcnTv1la2mS9mclKfLTKemqidIQmdMWe
         qnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752449834; x=1753054634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xki2w5eQHb1fLcDO93URZ4RBKttkZT0EQouQZSyMJfc=;
        b=ByVMFvKzyah34mzgg0VcagOIzCIKr8AUaizt/R/kFGqHYkgf1XMhNiP3Cief4NHmkD
         jih2oCA0HljQaFllQ40NqVl2+b4rkSIt1SQYn8c1wqVnaoTp6Yoe8mtAQ5rWztIaDPzk
         lxT1mtYzq+PNiHUOfWY55vFGFXRuUYF95BFBV3bw/H8fERumLcV/E2BZaO8wRrfePN+z
         k0+H7FPolXIYbw36J8L5NcFXsNygY0JWGfuwjNTDQKqYmL9VdRXecQ1nH/MMvvej2hfD
         x4EAHe2vgBJ3OvBJwrXy1og+DKGoS+tz6aO5NeOwcOc/iIfg33gtW/xQYWliuesW4814
         eN6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4rceDExUMyp2ZVhPlp0ycICWeH22tKyiGRtF1x9q7QUiug/9taH28s5QPHPHbKCJv0Ax0p5ooSAHR7PU=@vger.kernel.org, AJvYcCXRVUEWjBKjVNaL9CGrJ1ktuPM6c6jobipu5Swj06NvFPjmM6elRuo1NGcJwQFC2GJl5Shwe/Ppc/zo8O9VGaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdJZy/370TqvK6sOtAintEyb3nFPs3TiOP2SmgdkWddtBmXIY4
	vL2C6aaFcxSE8Rk5gcjr4T+xzmmIpc4V1smWjeU3cnPBSqs3+YFvrjYOg1OBM+ntgITUsyVtn1i
	hog131Rdf7d9UEGZPyWa0nmEUOGzLOIBzRhq/5Kw=
X-Gm-Gg: ASbGncvwg+KY3Wx0xE0XZUTnlkybjisY37vh/sc3BSiTtcFEQEzusCFx+IwsQdKaaT7
	LfSQmvccqMSUHp/uWwgoLwkVd/3v1EyO+mQNO2XuHl3Ag4QOcw2yzTrxkFxJwY8iVIkyAIx9jjU
	11YT3lHU9XW+kUOJAUE6SmQuyPGoq4pbWrlHpjNPgmeZP4yqAY4bAif05CnQOmYKTeRG5vrEJ+U
	Ezurvoe
X-Google-Smtp-Source: AGHT+IGVnYdOmnvQAM3xQImU5seBhdG+QWcvE59fKe5VUpuLcAp36PUpTfD7+IpzMmXkXu+XtwTqCe8e7C4Je5dlxso=
X-Received: by 2002:a17:90b:2711:b0:311:9c9a:58e2 with SMTP id
 98e67ed59e1d1-31c4f563077mr5444680a91.7.1752449834028; Sun, 13 Jul 2025
 16:37:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616-strncpy-from-user-v5-0-2d3fb0e1f5af@google.com>
In-Reply-To: <20250616-strncpy-from-user-v5-0-2d3fb0e1f5af@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 14 Jul 2025 01:37:01 +0200
X-Gm-Features: Ac12FXzOCsGxXB56fgbLYMskSiCz_Z_xUYfMnPoyv9J8VPmC5ClxWFQG2Aovnhk
Message-ID: <CANiq72kG1TarXDJPbRnWJhBkUVdO+EOPEk70rAyDK6svt7TxNA@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] strncpy_from_user for Rust
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 2:42=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> There is currently no easy way to read NUL-terminated strings from
> userspace. Trying to use the ordinary read function on an array of the
> maximum length doesn't work because it could fail with EFAULT when the C
> string is shorter than the maximum length. In this case,
> strncpy_from_user is better because it doesn't return EFAULT even if it
> encounters a page fault on bytes that are after the NUL-terminator but
> before the maximum length.
>
> I don't see a clear owner of uaccess in MAINTAINERS, so I suggest that
> it lands through Miguel's tree.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Applied to `rust-next` -- thanks everyone!

    [ Reworded title. - Miguel ]

    [ Use `from_mut` to clean `clippy::ref_as_ptr` lint. Reworded
      title. - Miguel ]

Cheers,
Miguel

