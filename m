Return-Path: <linux-kernel+bounces-883150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C556BC2C84C
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 15:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E62FB3BC115
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 14:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C99334385;
	Mon,  3 Nov 2025 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJY014VW"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8658B284690
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 14:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181664; cv=none; b=t7GA526veD7SpKua2G6WBRHvxqcIg5awOVESAgl05y+uzgFN1Ss33hxbbJglV7gi/jOJZxZAljIaf7S7FqeEo9922nTM2X3PDUlvVRnUP2v9xxuIRL32X4PMYE8VU0PyM1OuP9lXYvdJHIt6hfCMvtSLtXRY4iSgwR3exi0fXgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181664; c=relaxed/simple;
	bh=CfuwIHPDQmryroqS5zJUoyuxZn1pCBzzOLe0OXbOiAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fwVVesNhp6SRxNuwEdkq38K1DtQ9MEqgkp3P3JkIO21cmCLXbFQKqkkWZjrS6zudAIOVfE+HmnnRQBVWQ9ZfIDe8jCtCHznmxfQ09gyrvS2coqnFV5kfX2njDMmLjrST4bE7E7dPUL+iJ1yIhPO5xMbFhDmTdvPegD4GwLzsLfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJY014VW; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29498a10972so5226765ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 06:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762181662; x=1762786462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGcJLqwF2c7XiGCzl/4Dx0kZfB4HHUCiMyybkRLYqWA=;
        b=aJY014VWhdesFHneuyewR8bEzcB23WZLZK3BsqQ4eGQUJYQRCgxYtkahTK01Mr5SNr
         nCCLEcTkLt9yo45B9mQVzNGCSaR0Qyt9ffbYRn1oq24KKIDHTWvK6vRnd3jz6eZBoKpP
         ssbQmmb1+aRsqjI/Iap8kDtZA8C/pETeBLl+VW4+0heb8y8bALKZo3j6FuvD2iKkEEFd
         gZdiBR1XXRAt3oGUlbp9IJFR+xVHqtwcYoQXZAMUW46SW9XH3juMdxx3khIGd2COrWsE
         qcfRSTJQFUtSqB6aLTKHWsetQqXbQiBrYMbNMNLXtEA4EBzW7SzzHDHGPcs0Ee7oYw4O
         5HLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762181662; x=1762786462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGcJLqwF2c7XiGCzl/4Dx0kZfB4HHUCiMyybkRLYqWA=;
        b=aC/vVoxNHyvtC/TQVGeK+ActxyeFWkO2XmuA1Y+w7enWHOkTFiaaI2DfBCIkeXb9zg
         HRWWgrWw8ABsN2hVpc9gM7kMgO1WQQ5R8ITlnzYjO7ECtIyulZtCQYsmbHjsYpnz3U1j
         cPpkjp6+inR3aVTSmubl3lGSGU/g5NeYZ8Yv6B4SqFD9SRq+PqI10mwRSubqh4jgAkBy
         LyBpEbDz4GgeW+J/OIhZOsmdPE3Uqm1E2Ab1fXKDifysUVbc2DljilxeST1yLfHdUsdc
         GWt+MV6YdZxsH8cuRnRPGb9ITGtCH1GpmEMuQ7zMwVEeKQ5NK8sKp3dddN0wqTH+tdY2
         iEPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcchYZRJwWfI/kD/4iUIlw49KhXYVmndN+k6hNKa9oJk+behRimlp3/7ztNrG1rZl1Uk31iRFXJHPZMC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY7AV2lHZeUOFpcaGRvyZitMeFfy/CRDphIkztXLX+MOy9gQcN
	IPzxqqKsh+rVY2CNcO89wnX20Xe8B6mUSMfTf7gu8gbaeT0c6yLeZHNiwA5wqEC+5LLPuYaFsaI
	J7cI+YBIMkpABI5sOzOCveQCH5yunXIg=
X-Gm-Gg: ASbGncujq6Gh2IipJaU3yXBr1ckl6zmCjIcWPXPpkIRgZ9E7D6AbkLC0yVCD7unU4/h
	gs4fZMKO2Midw1t3yfgj4NYLbM39fHxrSAbtothX1G4y/DYFLrr17+JJ0gV/hmI6enBDrAU5tUs
	yhgUgUV8HRvZgd3XczvkH5rl3mEj3Zzbyb7XW2KIlyAFsm1yrhD90w9ji4H4cYyMv75/RGnko5t
	miMux6UJt4ZC8NWO9s5CgYyJuyN2CRFXF8NRi2nEstQku/mE49AIG3IDT2t22Qkk5+pD4FVFdhF
	ADBCoKL9kKi+mrkYq8Mq4/wg+RcQkbPn8aFQVCPbeDoXXL1/G7kH0scUDj5GZhwFaay5qdozD/X
	Ww0b763q5r/opHA==
X-Google-Smtp-Source: AGHT+IF2duoky+NM8f4/33jjIQnYvFb0ADfwWmZJzGiMMxqRwi7/BedNBWl7f8IPHRBvKgr7QLnax9M257phzS375FY=
X-Received: by 2002:a17:902:d48f:b0:26b:1871:1f70 with SMTP id
 d9443c01a7336-2951a40cc4dmr90644255ad.5.1762181661810; Mon, 03 Nov 2025
 06:54:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031-bounded_ints-v1-0-e2dbcd8fda71@nvidia.com>
 <20251031-bounded_ints-v1-1-e2dbcd8fda71@nvidia.com> <aQgQv6F0Ao4DH6U0@yury>
 <CANiq72mg-NntJLf_jbigz++0hK7G3WAxbvejRq1EzOc7GE+doA@mail.gmail.com> <aQi7e6VgFsqpq1Rn@yury>
In-Reply-To: <aQi7e6VgFsqpq1Rn@yury>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 3 Nov 2025 15:54:08 +0100
X-Gm-Features: AWmQ_blCg000_2OneJ2R30enMvqJWPDFlAOjeiP7bYGOSrzFcFJ8-nZgZdW_JUo
Message-ID: <CANiq72=4UXemR3ea5nNbqGt0Zh9q4hwiGVAn+hxfcZ-Zqa8y4w@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: add BitInt integer wrapping type
To: Yury Norov <yury.norov@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Jesung Yang <y.j3ms.n@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 3:26=E2=80=AFPM Yury Norov <yury.norov@gmail.com> wr=
ote:
>
> This is exactly what the patch does:

No, there are no arithmetic conversions going on here in the sense of
C. It defines a particular operation for a set of types.

What you are seeing there is that literals, in Rust, do type
inference, and so the compiler picks a type:

    https://doc.rust-lang.org/reference/expressions/literal-expr.html#r-exp=
r.literal.int.infer

Thus if you do:

    let v1 =3D BitInt::<u8, 4>::from_expr(15);
    let v2 =3D BitInt::<u16, 4>::from_expr(15);
    let i =3D 5;
    assert_eq!(v1 + i, 20);
    assert_eq!(v2 + i, 20);

That will not build, because `i` cannot have two types. But it will if
you comment one of the two asserts.

And if you do:

    let v =3D BitInt::<u16, 4>::from_expr(15);
    assert_eq!(v + 5u8, 20);

It will not build either -- there is not even "widening" going on from
`u8` to `u16` in this last example.

Cheers,
Miguel

