Return-Path: <linux-kernel+bounces-783627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E296B32FDF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 14:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CAA217F0EA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 12:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E822D7DEE;
	Sun, 24 Aug 2025 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWwZCbFe"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35892D7398;
	Sun, 24 Aug 2025 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756036831; cv=none; b=iKRlscLuzHE2pqEWelw6I/oN7+6iDumTjvkq3shGuQe+ihC76Gp3bEtualmsVPBzP3ukpKXzjt8ZsEnOzRUeQUGHvey+NiJt6dqeoeh/maHj8nXNXbhKvYJwMM99Ob+hIDQd15QRGiHKaBZLr8z4K71+4qj/ZNe1ugktN2MyiFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756036831; c=relaxed/simple;
	bh=SggRvyijX4RjduZ7C6/IEGyEkW6WZyVdIg5qeaQ3MKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PeqLSlN5rcQkKEpBh3ZPj8cvjt/Hms4GSRfIt2OFMgWeuv43kPldHwEsSG6/EsgN+XMSWrz/ubW4WMNA0FcACopLmaA/uGCGicNfOWRiGi0NduC1aGlMjUIXMd5nq+uGvydRfqud/lBfrdtrk8hEHKuRr6aI8BcFHOrD5aKDLw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWwZCbFe; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24687bbe3aaso2136645ad.2;
        Sun, 24 Aug 2025 05:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756036829; x=1756641629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+NeJuihasHMpSZQlKaDLtA0kfMP+hJSsZw6DgFT0I8=;
        b=VWwZCbFeJIFyMkUDqyRBpkp/tClBekK/zlsnT/6G5bCoErNJyDt2uD3CNC/9U1a7S7
         7RNh3t2yWtWnqIdLg21fyjt2m+D6aQvL8FJf15pxg0LjUtBCKnUlrxw+POT9UpwpapzN
         lDOptTFcBijcuGUe9E3NgoOAn9PrZ4s7U1wV12jcLHCY7lxcfq8PwS3lFtqepy1+bftY
         MbgCogvWla10QgiU+RtuzPZDP3DnS9fVTJ5bdFpeqkPBff1PTOW8WI+RMwmEhSY2izgu
         Sm7KTXD0H+aPHFhdlrX4YKwpeZ7iUse6DWgN7ivUxoaYoMtRzWF2iXoPnsiTF4zrLV03
         0gbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756036829; x=1756641629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+NeJuihasHMpSZQlKaDLtA0kfMP+hJSsZw6DgFT0I8=;
        b=Z0xYsZz5vGlKd2b8q0AyapKS9SdfYidTogIfaOXpK5oQbEWOpqRHUKeIf4SGaPJTAa
         BYwObmjXH4Su7lPYi1U9vIHbX2eDm34E0n5bdmjYP0WRwemVi7xcOp5hTIdjTYlHMd5/
         EUbDhX7fOMbw/5n8Ye4CkMH7+lClqu2wAmNmAAX+BNAeWcLlsKtixTVw8gGKmNTj/ZLP
         MDiXUHDQ9Xx2I+Bqd40M0gxPqOLA8WPPgOcUQ+biM0f8/mra1m9w/LffqNOAMIJyRL7v
         G0iitkvjwMtdWCyA9whBpFyGkm+dpEe8Zdn41XBqeAcVWTRQcrns1Tw0lMs6D6ysLbtM
         VzPw==
X-Forwarded-Encrypted: i=1; AJvYcCWGpfaKbsVmjLvJEllIGJeMgOnU+k93syq3Dk6Bh1VQccb+hiCBpeMjMvCQvJddtDJ3pck3Ai4D3Fe46Xc=@vger.kernel.org, AJvYcCWnAcf903NUmHVD86DLKW7G9l0It/Q08hd8IacsEmShrjTpibF7WW62SEYZfkXfhY0XqmPbmiKrU9glknPAd94=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfuB52zLbd29eTb2ch9A9nRJV1kwtM7i/VqXsrQEREWgiGvMHA
	vo+vs1EAkXGxAYQaTTSWykv2ecalbFQU4xRVTQJhEKFZdt2PzPMuD94Ird1rj97gSZJQ+wnjcWG
	T7Z7GUMftiUsB6VNdzVDV48P4Tu21JfY=
X-Gm-Gg: ASbGncuK+MvxlRENQ3idS0+zKZnTFQDSGexA1qeDbAz+45X6dMK8RkzBmQdE9tqB8pN
	d0iyUEeOmmJH7Yd61RA+mbzN9NxiNOO08IvpZV5krfnC376EiWBa7J0LH8yrfQRI2AFbgJCJD7e
	WbuAJ30D2H3dbUjqWVGGt2O5WORCw0nRkVGinUPQ2JqQ+wNr5AQIzUs46LfDX4Yy+QJ7RcPnJ2T
	Dq7nb5ftBYj8nK2yBIY6aRKdmnZBhY/zlt98TvkKbDx1C0wz8ZvytIRYoTEZnVOe5MuJosKxtFs
	Qimbh1EyBvGhluIXnzQdNlgmrA==
X-Google-Smtp-Source: AGHT+IHq14WfvQVN2TPU5HtrsXUNFTlyTBG9f1RlHid6TgbDRw6jgP2E+avDfL8EiE18+8qhzl8ZfGVrl0YkxjLvu90=
X-Received: by 2002:a17:903:b43:b0:240:4cf6:b07b with SMTP id
 d9443c01a7336-2462f1d4b53mr60218555ad.9.1756036829143; Sun, 24 Aug 2025
 05:00:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-maple-tree-v2-0-229b48657bab@google.com>
 <20250819-maple-tree-v2-2-229b48657bab@google.com> <DC6DC244ZIUL.304JSP7JFDE9Z@kernel.org>
 <aKRx8xsY8CpzbeEm@google.com> <DC6F7BN2L19O.1APQU9KWZV7H5@kernel.org>
 <CANiq72=xdryEKzo73-1vaBqGNNme2kRU0atP5PYOnOOXjNxZZg@mail.gmail.com>
 <DC8WOHIEAHQD.21VWTH8VI8QG5@kernel.org> <CANiq72=ZZ7+tMi_XsRKunGAqm_v+kehFqzpEMMqm2qcTvzA9Mw@mail.gmail.com>
 <DC8XIFWZN1SE.ZZP90D2N843X@kernel.org> <CANiq72nJiJ4K6jy17x-YRYnJpjqTnohYWvoFrLkYQp0X4tLL=w@mail.gmail.com>
 <DC9ADTLUFTUC.8OVFMY20FXLF@kernel.org>
In-Reply-To: <DC9ADTLUFTUC.8OVFMY20FXLF@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 24 Aug 2025 14:00:16 +0200
X-Gm-Features: Ac12FXzzpP8Mk2Aa4-XFn8fnT48IU6Jv3-wrUTIyBaZNdXiPt4TSLWJJp3dGXqE
Message-ID: <CANiq72k=7+1DFerVniSFeJaPDouu6xBG6vtP1zdtKXm3asRpaA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] rust: maple_tree: add MapleTree
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Andrew Ballance <andrewjballance@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	maple-tree@lists.infradead.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 11:49=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> As for
>
>         assert_eq!(foo().unwrap_err().kind(), ErrorKind::NotFound);
>
> vs.
>
>         assert!(foo().is_err_and(|e| x.kind() =3D=3D ErrorKind::NotFound)=
);
>
> the only thing I can think of is that the former fails differently for wh=
en
> foo() is Ok() vs. the error kind does not match. I assume that's what you=
 mean?
>
> If so, I agree it's indeed a downside.

Yeah, the former checks independently the not-`Ok` part; plus we could
make `assert_eq!` print the actual values when it is the error code
part that fails like the real one.

Cheers,
Miguel

