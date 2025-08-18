Return-Path: <linux-kernel+bounces-773119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 493FFB29BA1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D4EB16C1AB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53FE2D8382;
	Mon, 18 Aug 2025 08:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wsb1Om5g"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41D9221FCB;
	Mon, 18 Aug 2025 08:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755504353; cv=none; b=oI5GHlx/gcRBHW/KtTQaca/Scr0aYJI0WIbeCNO56tDMIrR5mL4+k114wEXrREreVszUbFTf7n8/dmmhPM+kmVA3NZZdqw/rXyGDFN6lcoKqsAnp0UCh89BBy8RguZum2kMpNYrAHwhhmjFMMCbyXg2GIg0oZxZX1PyQ4zcWG9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755504353; c=relaxed/simple;
	bh=OtmfUx3db96Xd2qxcVnGYo7dTnC4vwyK/S68IWM16KQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jpZT5P+qy4i08+xBTNW91whwQyeeNObNpWMTBFCDQc/2qyeFdfPwcxQgxbThho7/WNv7iEjZYGTB1gfLyVq8SWeLtblI5rgIwFOtB97dcHxHb2J59AvwZx7G580I7YHTaEcWSQlDoUurtJtqKVm5zjrGesogu2Gj7IArDhHWSS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wsb1Om5g; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b471751142aso705345a12.2;
        Mon, 18 Aug 2025 01:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755504351; x=1756109151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtmfUx3db96Xd2qxcVnGYo7dTnC4vwyK/S68IWM16KQ=;
        b=Wsb1Om5g0Jrqee1DpiWyqUbGItO3ot1B/xGZD75wyi4ddeV43Uo7KYDv4g6DMfFci+
         eCTNp4q9iig4bOBU0UimBOK1FJMWuLxJqm5azM1LS+DimhvKWSII135gpF7SqL0A1qAv
         WL/BMArWxHd5gtpfFm7ZRQ6Z81Io6F3dVgFDFaS3c1Nzhcy46tM8qCXVHy4NYJMtZPhZ
         eVAy4wJnVN5xmU5gfCI5IdVhKMMOYFdYlF74sfno97CqFcYy26OHaKklwyV23p1bzJMF
         GH1Nh9yU8EZiilf7xKgShNM2cB/0KnMy9gg62b2Junmn8tSsxEtAO5lc/tcrNCac2c3s
         DExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755504351; x=1756109151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OtmfUx3db96Xd2qxcVnGYo7dTnC4vwyK/S68IWM16KQ=;
        b=BoXja8J4ZkiVet0i1smbKWKIrrXSBpHOuCo8xYyesF2QWeGgOhtklUM8qE549lFd8Q
         e3pcusFJJUWcZ0iPyo6GWrdN+FFf0osWJXXB+QkFI5xBHDEoEKav2JBHH/XPmTY7dTK9
         02SUt/dRwoYKSaYH41Lu9sJKG73PmR37WfPU5u3EvT3RjJxuygA1we4z46C2aJyboQYa
         RBsKK5O2S/NEmoxVYsvlHLe6Nl70bhTOPfw06qkfHqLEjeTtklnkgvmzuG7hx/r3r04L
         2vVx2Q9GRGpQxTe18h9AvbSiXf7TxKX1Mc+Ys64GzKfrvSoKK3muYpqgnvgSnt6fgUzl
         LLfg==
X-Forwarded-Encrypted: i=1; AJvYcCURIDyNTbTpMgx5sSoIL4vZbbEBERq7qbmQhoy2lWDRS9S+blEwPJF+yZ9WREIWAymyoGc4mb9+tDBRrVU=@vger.kernel.org, AJvYcCVJnh1dU24OxzARZdJ2QD/IB1bt/y1HDmSCgow1FfG8WlRqO0KNOIlW2y5w1NNcDpSj23utb2FJExXW80HNenU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPQnyw7zanQhV7angTrlQoQpIajXyCigx9XNcvT0WQTvcH+pYn
	iGTapjnO111mRjCQ6BMLBWV53o5BbdXixatkR8ruo+Js+fIjf7XxEX2aglshjhgbnDV37+zpoHT
	CrWxT2QSBIRlK+CxS9+nYuK/xN6dUhOM=
X-Gm-Gg: ASbGncsQ/bPCn7fhMkaTai9tgkji1OEIlaLxnXDCUhgXFGnk/WGvjWRc3smveMKVbzg
	6gD+5juoxDZ5W7kroybICyixZtGNzJnL2aGPf3v2cgbvyMmqiWAJufT920Ar9v+HC9uHxfgKewV
	vHI1AW018I7HLhfit44Sf32Jnvhqw2Jd7vFsJ8s/DBwqo/E7V0M/r7E4eacYaRDc5/rWWTzXbzR
	Gz0ktQVtEkVBnm+fVo=
X-Google-Smtp-Source: AGHT+IFvqiKJcyIKJinseaEZIuhYIdgFe3QjepR4bsheIxYKsjBhizUomv5OcBW8nH7WOenfz5wdZwYRRVFGs2I1Tlw=
X-Received: by 2002:a17:902:c952:b0:240:2bc6:8ac4 with SMTP id
 d9443c01a7336-2446d6f55f4mr73577185ad.1.1755504351110; Mon, 18 Aug 2025
 01:05:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818012648.1841387-1-lingfuyi@126.com>
In-Reply-To: <20250818012648.1841387-1-lingfuyi@126.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 18 Aug 2025 10:05:39 +0200
X-Gm-Features: Ac12FXwF3uFdFv38iyqaktwcfyH_EkLLmOSJw78IyannriaajRZHCyNK7g9KcEI
Message-ID: <CANiq72mTDbosz6NjJax7Mam=RgjtrQXrtZfvawr9V1LO3FfMZw@mail.gmail.com>
Subject: Re: [PATCH] rust: xarray: optimize lock functions with inline attribute
To: lingfuyi@126.com
Cc: Tamir Duberstein <tamird@gmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lingfuyi <lingfuyi@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 3:27=E2=80=AFAM <lingfuyi@126.com> wrote:
>
> Signed-off-by: lingfuyi <lingfuyi@kylinos.cn>

The kernel requires using a "known identity" (typically meaning the
full/real name) -- please see
https://docs.kernel.org/process/submitting-patches.html#developer-s-certifi=
cate-of-origin-1-1

Also, please do not resend patches with the same title -- you should
increase the version number if you do so (or, in this case, if you
just wanted to Cc people, you can do that replying to the patch,
saying who you are Cc'ing).

Cheers,
Miguel

