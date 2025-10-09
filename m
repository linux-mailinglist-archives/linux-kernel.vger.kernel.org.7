Return-Path: <linux-kernel+bounces-847377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D023BCAAC6
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 21:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B9B4422506
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 19:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0609F257427;
	Thu,  9 Oct 2025 19:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDUS1M/m"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E471E1E12
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 19:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760037596; cv=none; b=OUnqWkXByZ0D3bk62nZVPHvgh5bVpIE6YlXx6uA2iGogyAfS+pY8k4gPfl3M8JfNweJA4AM/z2pSaT9EoRFjroBNRNmvT2WtrUxEUGyU/ARCwdFQSWydIrktPXp9y/LZC5MDa8SfOPG4M5r+7HRtQ3bOwUx3v1Jm2T/2UrSNIm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760037596; c=relaxed/simple;
	bh=rcXwgJGTpWZU2t3OdSFiom5bqnzub6a4TGqV+K3Njdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdgO38xbpcP5S9DEF9fHyII+as8rnZ3bb5CBgPwbjYxdNE/hPU52jLfPuFr0L3Qp/fOTq1K/ueyHQaFn2elrHJNiTkSZgNFxGJBYao8ylffbHG2j08zI95OvKfyv8M/eB23niTm3UT/EcrlIk751KHxPe31pR+EqBSd0q1Y+RHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDUS1M/m; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-269ba651d06so2057325ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 12:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760037594; x=1760642394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcXwgJGTpWZU2t3OdSFiom5bqnzub6a4TGqV+K3Njdc=;
        b=DDUS1M/m2NjcgqjAWe16s5a3sjd8lkMcDUmRNbQwT68x26OhjjI4mWnGkAUI1PvOBB
         dD7ud9NcgAPeI45KEEgrp1poBvR3BAzO4SYEZ/XLYQENhytrMuE7UWvVVmB+/l6Lk4BV
         XefqpoAsvmfYPE3W64i7WleBt2+yd1JnjD0hKcc6bhPRgW8yHqOzCNbYNRhTPpjNj9Y1
         WvR9C1aqOrRtE+QHG+B1NpbN+GTM1xiLk9mUpsytyPxea+o7MtGnqcpP/nJdyJ5dBaeS
         sLeLMVo+JJ2Bv90zs0aqxDB91Kk7QQS9k+MiBne///h1Ukv4c2WENbTgoFHNmseMKlwB
         0P/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760037594; x=1760642394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcXwgJGTpWZU2t3OdSFiom5bqnzub6a4TGqV+K3Njdc=;
        b=YM6/js0srnP4WIej9+WOpmyacJeBtgkLTcN/2yesDxjEbi+YdPaz4wcVSEDtLxr4Gi
         MBsia2h8jysie78eFaIL5FKWp6IbR5gVCHllNFJ7N+qZ7ude0FptT4YcpWyiZuPq9gAf
         NCK1Kr2qAUtsvTJHdi761bVorXA2ACOkrWrUYkG917IFYgjarivFzZ11BvD+47/6eNW7
         xiTm/R+7Luu71tyr1BA/OJ7JKIuPfFl9cfthOFW6b9baGKkpPh7H21/0p6hPhMPPW/Ph
         oLlkxumO3Z8eDPKZAAh5zf907GLqij4zUx3HBYSR3Bn1JdUjq8gQq131M+Jb6+9S3F0T
         8Osw==
X-Forwarded-Encrypted: i=1; AJvYcCUP7AtvUgi/V+WeBNFYMBAGXGP04XDmkGAPazBrDyIJP8FxV99JTgF+uW7RIwgpEHEJZ9dY0F8C0OY3C04=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpJbPZmLicSDHz1JoJcksAnuHOaMm1kvb5FxxFeh2yN5wMMMBl
	3Fsd8QHua+Jzmuop8rw7pXOohmgJi5n+ZQgc6GhfAXNnYtIs9JcGzB9GyDDdtHB7z1n2AMXBWTU
	EiggfaUXXEFJ/YI7CtcUR+Jevnoxx7oA=
X-Gm-Gg: ASbGncsvwv5lWyys05KkJUgD7aiSYxCDHXf6pX8Rs7PK+KVm6PWYIPlefuSjwSzshZa
	FPTDKWxCpbIWNKj/5jH8naOInJ9xrwRZ13pFRy2h/8kVYAA0SBqBrV7bUAqymacHEOyxwKvkyO6
	HEZST6FIou5+w2QMvCIHoDonM+8POJHevk5C17PHEqI35gzXfzmSKyL3m6cKY0EO4FGeD3/erGg
	8mLZ/l2W1FtDwPVbX+RY0SiSSFIgUHQjAkJ5eWdFzyZfavH/+6Xmg4sd95NmRwczjCTC9Aw6NCi
	LerCsEW+bPrDFP47NfAOL3DaYnmD6OcOGOQRByLzFOm1I4vJtA==
X-Google-Smtp-Source: AGHT+IGoblUKEeISrZbv72jxa9PiUckqqLQlj3DZjUWlLcO9V1Ny9+gENsT9PTdE7jTdp3qFnpKB0Hp3UsFuterm8Ys=
X-Received: by 2002:a17:902:d2c9:b0:269:96d2:9c96 with SMTP id
 d9443c01a7336-2902724dcb1mr61748135ad.0.1760037594340; Thu, 09 Oct 2025
 12:19:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009-bounded_ints-v2-0-ff3d7fee3ffd@nvidia.com>
 <20251009-bounded_ints-v2-3-ff3d7fee3ffd@nvidia.com> <aOflmmHe8O6Nx9Hp@yury>
 <DDDYOBOZTF7Q.124VJDF4C76B6@kernel.org> <aOf-s-XuhbN7MUlx@yury>
In-Reply-To: <aOf-s-XuhbN7MUlx@yury>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 9 Oct 2025 21:19:42 +0200
X-Gm-Features: AS18NWAcMteSg_vVIc0g1AxzGZB7uiQHfY0qKY6Biz_FAtZhjrTWuqxAC8PWrD4
Message-ID: <CANiq72n7i7mpP3SXnY_opUKAm=UjOne=kECc4QdyXo4gz0qWVA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 3/3] gpu: nova-core: use BoundedInt
To: Yury Norov <yury.norov@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Jesung Yang <y.j3ms.n@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feong@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, nouveau@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 8:28=E2=80=AFPM Yury Norov <yury.norov@gmail.com> wr=
ote:
>
> Up to you guys. But having in mind that C is the only language that
> really works for system engineering, I would rather consider to stay
> in line with it on semantic level.
>
> If your goal is to make rust adopted by system engineers, you may
> want to make your language somewhat familiar to what people already
> know.

I am not sure what you mean here, but just to clarify: our goal is to
improve Linux with Rust, not to increase its adoption (even if
obviously many of us would like that). And just in case, it is not
"our" language either -- most of us do not come from upstream Rust.

In general, we do try to make things as familiar as possible, but
sometimes it doesn't make much sense, so we don't follow C blindly.

For instance, C23 also got checked integer arithmetic macros, but that
doesn't mean we should start using names like `ckd_add`, returning
booleans and, worse, using macros for those. C23 also got `nullptr_t`
-- similar story.

Cheers,
Miguel

