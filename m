Return-Path: <linux-kernel+bounces-782681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 881D7B3238C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6614C625176
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208122D6E43;
	Fri, 22 Aug 2025 20:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghm3Az2g"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334FD1FF7D7;
	Fri, 22 Aug 2025 20:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755894270; cv=none; b=ZOE2nsf8+k7DQ7oxGGYG3GQkYOwqntAOLBo/OzgpPnk78eLcVGui3pPeUzu9vd9jhtFP6IIWt9UyxKZCO2x067/SdSzWAXgCM6Vk2CU89b15TjcvL0QtQpoJB6+GSWXhYNBwc60i3Z75G5eXGAovwzL0kJCVvAg3eo+fgF/cZxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755894270; c=relaxed/simple;
	bh=bxZG6p/T1fiVTFwYT8vShK9SXRLGGL4+keW8lCA2SUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S4UCmY3Yujo3DCGCj4Y4zoBIaFbKhlUBTPSGFRVTGvQFVnzuggDMorNRh+6AKTAtVAnmMTILeNyEmstXi3Dc5jxaRHEvDp6dBB8rkeZvjnxvmPhGB0mZi/JZT4FU94/kigboVB6m48++I48W2yqVLHShlhz1G93FU+7z2HCFx2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghm3Az2g; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b47173edabaso405754a12.1;
        Fri, 22 Aug 2025 13:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755894268; x=1756499068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5BZAMJAdNinjmrqtXeK5zr85hiUnHNVxz9y9YGq0B8=;
        b=ghm3Az2gD/pIkMWWUtU5ARnEE62+Bz+yrNrelhDX2lFkDTTQAkevS9+EPraEvsRlfb
         ujf8Lxoz+OJsjrMG/CxaT9IRe2I/RMZZeR5Iq6vbYVncOjd8r1gtoqg3TnAVV049Sqmg
         zP60jmBi01aAF98eyCjkneZYmwQ/gb65kPRf7FqiI1GK2zMvASXA+Ko2dVCn6kCs+S6h
         IjoropjVt473VFAGgTXy88bTBTiRPHH0QwQpiqNC86sIestaodSg18wuw/4Uu+5iPxaA
         tp75/rRu7kEmO1lPEWOz7dLEjDqtMZyVfMnlQQFjZ2Ra/guNDnfm62p+mEWBGAnsFCY9
         3WjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755894268; x=1756499068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5BZAMJAdNinjmrqtXeK5zr85hiUnHNVxz9y9YGq0B8=;
        b=wn2EwxQt5y4yX9CcTvfx2LniwewybJRN0AEqShis4CqxyQrpFaQJRusoYv+fH83RqA
         Iiyeeto5GsPsRgSYSuHju0xVDv+WIIOkNpeB8wC28M7Bq7cEAVw9/NbVwWPfwWFIA5t1
         3ILFgZ3VDOBUYswqVhavY37jfBblB9dPRrVynZS6rxR+GE/gZjMFt3FdeuEL/DBfKHfa
         txrZIesRWIDucMaZ/KWh22m6tLRrcb357aUqLUxLWsJ3CL0oeNR42/sQ47snMRA692Lj
         dQLEGJw6b/KAAcIGLn2k+Tlm4Qdpo2VVHVF48RiQU4DY5kUnpPFhLgA2kHe4VF8k1tQD
         5XWg==
X-Forwarded-Encrypted: i=1; AJvYcCU+44cwemgSntBEYkS5K+v5a03NP0iZmsGEb7P07QjglTZxIBCA2hHmTkAU6DfhSOJnviv72XCsuWgS7ETlWno=@vger.kernel.org, AJvYcCUISOK2sVs3sMBAdvSecAycw3+thlkS+wjfUKTiajWrKghlPy0OF6hg8TnqxT+HA8cmpgJvz16pKXrE5lo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk9CuFACRLjaZtJGHhUFlxqjVrPYwccPX5bjBgp0cEZ9/hZUOY
	J2lT819BtwkV7G3jEBQFDGqD77MNQlGilDozfRH+CsLwUkyKkb7VzPxWvmQDgHFgVmuHFM6FIR7
	C4TRZKibIKdG+2IxsY8ZjYaYmbVASH/Q=
X-Gm-Gg: ASbGncuVooCagf+ZOL2npOwrkKPnZvEo4oJerefdW3xDVvGjzZOqcerkKCw5j9XTscJ
	5r7ZXr1eb95F9la3BG9r9ZBOuuaX/FCILbWSUj8DwONKGfyqTj3kexpuMyfUkCii9ADYjjGKB+h
	t8EsfATuBMRhGNw0FJ6BxArxjy4o2NF6YEwRfei1CukqUSq4ExwGgDoOqrVHkznZue+QSZvrMlV
	j0hj7bOwy2yPhMZN7lmIsRtTM1RSLUToL95wmp4/g2mlrPnKLPaqFhCs66MhaU2VIqrSvnNj1yn
	hg0/3jxE8YYxKcMQVVxq0ih0aA==
X-Google-Smtp-Source: AGHT+IHhYCS+i34yL8mwZtpaljVlQVFlFvjT7BlrbezunK05lKaSzGUBdYFxNjc5hrmCJehwC+1vQkt5CawSg2N0OZg=
X-Received: by 2002:a17:902:db0c:b0:240:9dcd:94c0 with SMTP id
 d9443c01a7336-2462edfb000mr29920735ad.2.1755894268437; Fri, 22 Aug 2025
 13:24:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821091939.14019-1-work@onurozkan.dev> <CAH5fLggt4YJe93xo9KTr=hTQoj28=jjJtaxo=gFmnTbWmm8SRg@mail.gmail.com>
 <20250822080252.773d6f54@nimda.home>
In-Reply-To: <20250822080252.773d6f54@nimda.home>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 22 Aug 2025 22:24:17 +0200
X-Gm-Features: Ac12FXym5dbFGOC1DxZTCMQvo6hwH20UjanpMh4Zi3nDBMHpqgm8FYGQmWowxbI
Message-ID: <CANiq72mstOhnZREwLoO5OR7JdnoFnQ-PDD7wQkJgjm-0A52DkA@mail.gmail.com>
Subject: Re: [PATCH] rust: uaccess: use to_result for error handling
To: =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, dakr@kernel.org, tamird@gmail.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 7:03=E2=80=AFAM Onur =C3=96zkan <work@onurozkan.dev=
> wrote:
>
> Nice catch. I could use `try_into().unwrap_or(0)` but that feels a bit
> iffy since it would silently avoid the error if `isize` happens to be
> much smaller than what `i32` can handle (though I am not sure if it's
> possible in practice in the kernel codebase). Let's just ignore this
> patch.

`isize` is at least 32-bit, but I am not sure that would be more readable.

If we want to make all these cases go through a `to_result`-like
function, then we may want to have variants of that and so on instead
-- Onur created this related Zulip thread:

    https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/top=
ic/returning.20.60Ok.28c_int.29.60.20instead.20of.20.60Ok.28.28.29.29.60.20=
on.20.60to_result.60/near/535616940

Similarly, we also may want to have a function or similar that allows
to perform such infallible casts (that are not infallible in general
Rust but are in the kernel); for reference, a similar recent
discussion at:

    https://lore.kernel.org/rust-for-linux/CANiq72nW=3DXuUFqOB-6XavOPXtpbkH=
sagEkYvcD2JfCEiopYo=3DQ@mail.gmail.com/

Thanks!

Cheers,
Miguel

