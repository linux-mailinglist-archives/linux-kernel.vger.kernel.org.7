Return-Path: <linux-kernel+bounces-893245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D67DC46E46
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2FEBB4EB4B1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810F03112A5;
	Mon, 10 Nov 2025 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgDY+v7W"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D6824887E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781301; cv=none; b=oKUo7q/h8ChdhxJ4JVFAEeG9nz7RC4wvHmtqE9HiBCCQQz78EDwgxp/VXXO7XaIRAzdGB9i0pvsxRGggV+GhSz5BMKQXoM/EZ0bipvi/5IPdHCBCsmz6U07+bFrARQviefTCY4JAePIbgs1QPFF6L80u54qIc20ImpdQzprXKwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781301; c=relaxed/simple;
	bh=bjfTI5/MNKD9oHiCRC+m1AgyC5/Ghs09FtZxTOpiKMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WyLp25AZkfdKfseqvkif7RVZM7LDVhHnWvV33u32b0ttkSfpnj8PjyxFp5KhKjSAO1BgM+8vFZTDN2H1qIJ+UuHCOmUj8auSNMJ6BltAPnFMovFwDcAscC4GQMktPYFBUynr1RMmU9GejQv1ooeWNtV2UvZYsHmLWDTRANbYp1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgDY+v7W; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-295395ceda3so4267555ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762781299; x=1763386099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjfTI5/MNKD9oHiCRC+m1AgyC5/Ghs09FtZxTOpiKMo=;
        b=SgDY+v7WcGKDmmW3A0PrFB85FWWC1Ak5z9CUqCF5j3FqACjhmT8JJ5tJeZ0fO4KVzy
         vqVTT1t/mwugT+hjIfMRxfFCWqGB5Zyc4DrVXoveMdLIsZQXgBm3xkf565sntin50hA1
         xwva0sIkNBm18lEP0K+Ayo5+p+kbjSJocHlRKZr2vCa/H3e55CUXtlxS29y6/J0RXT1b
         nnkHm6k5xH3e3Ca+vW8pmqMu6I4+KdOLomrkzi/FT6zl/8xNFHh2CwpNIVK2KiNUpJXi
         R63+V+c/44vT0UCqbigCNMOlJ4Zr7KtHw946ISaV0TRNba6ywdivWHDBO/IgU4BY1wh7
         BEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762781299; x=1763386099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bjfTI5/MNKD9oHiCRC+m1AgyC5/Ghs09FtZxTOpiKMo=;
        b=bAS0v6yrt3C2ViDmmVrYQq9E0ePE1U01KUphDCSh5g3o4hvqzB9UwoBbL3wY3f0v1V
         6Jdx/H2A4CNHvZIj5LQ8icIjRjMr59W/e7sImnHZQnAetZcaCyR5pHLpWFM1zTmqPq5i
         aBQ69ieLSMHZopxyLgGp0Y6p1k+k5DvRM7eTSmSanPE+bDrYZ9Rqm+RpF+Bk1ab0ycKr
         WutFiDDF0H8NnLUsSBu+WP0W5q+sb28fE4KkUa+mWNEnAiXT2AQpcqpTl1ZgM9bs6jZl
         5OzZRH67pzwR2MoD+3hpUrLOen+UccJEoAFkvGFoK6faDP0eqmYMkN6mECbCmElZklmE
         HShg==
X-Forwarded-Encrypted: i=1; AJvYcCVqsxj2ENhLaKi3GIeJj+CVM6Flq8+4FwV4VobJGWV4PAhbyrewFCErmUidH95e1RGaeMo3UWXGDlOjEA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcxFn/Sg4KXKzqzklyRjMltlq/yLtzi3pvIRRvk/yhYslWkrx7
	sRNyeAYojLiPY8w8onJhQxiSAyqUJNV1LraKVdbJ/KDCIjJ63sf/NHpjTUEJwTEJ4Sp42AJbVpM
	GKX4zLjz0xa4KCKsqbsMvLRvXTX9nXuA=
X-Gm-Gg: ASbGncvcoXwHnOT/sv9xhYM22OPOG7Ons/D/X5ltCcWHdtb0Y52gs5KMfTWPENL847A
	GeqlnAaJ4qmQy8c7WquMr3TtWktZtKYqWMk89U4LTGVOI3WuxoLeyGzA9xvRAe7mP3WH/t8QIMl
	TPGfi9r+TGfSYF8G/vzQ6Q7LxGnyDQk6WjoOdM/DJqSDbHzlZuN0mBYcXmH67719r3KzpvcEPs7
	ZeQQkgOFs1/HocB7qLckyifdN1xkD5UOW3+vojntYLPiv03Nn1IVxD48VfdQmCzVQ993gLO4EDI
	JB5nUEObpJRmPmoLzshSGexlNt5B9V3OveGhuk8oSLE309EW2X2xdv7fkhP/A11zdffejHpQF4d
	9BJaSrZr+5gG+1gNmSCf33nR/
X-Google-Smtp-Source: AGHT+IEyNd/CIr3oQh1rXjWGYDIzhBKFEX331S9clDMfX3PRs9JtaBsmWUbizR9ZvdnMVpJ2wUh49e65b06MdwUpBx0=
X-Received: by 2002:a17:902:d4cd:b0:26b:1871:1f70 with SMTP id
 d9443c01a7336-297e567be2amr59101785ad.5.1762781299138; Mon, 10 Nov 2025
 05:28:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110095025.1475896-1-ojeda@kernel.org> <20251110095025.1475896-10-ojeda@kernel.org>
 <aRHOnGyLx-bEVqcY@google.com> <20251110131049.18e2f5c9@eugeo>
In-Reply-To: <20251110131049.18e2f5c9@eugeo>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 10 Nov 2025 14:28:06 +0100
X-Gm-Features: AWmQ_bmiU7DKmjn-tBgMdy06u7eyya-M3TMlTQsJq9SC-BFptX9Vc5y9iKMzXvs
Message-ID: <CANiq72mGYKYZmQ8g5AbXCsRS+WPxbeaSyngR69jsEpY8akouog@mail.gmail.com>
Subject: Re: [PATCH 09/18] rust: proc-macro2: enable support in kbuild
To: Gary Guo <gary@garyguo.net>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 2:10=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> So I think the implementation here is sensible. I believe Miguel's
> patch is also pretty much replicating the logic in proc-macro2's
> build.rs.

Exactly, I was essentially following what upstream does for stable compiler=
s.

(More generally, even if a feature may work, if upstream doesn't
usually test "older nightlies", then I wonder if we should enable such
combinations/setups anyway, unless we need them for a particular
reason).

Cheers,
Miguel

