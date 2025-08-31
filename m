Return-Path: <linux-kernel+bounces-793577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE98B3D568
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 23:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFEE17AA601
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 21:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556CF24291B;
	Sun, 31 Aug 2025 21:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmOvrJl5"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772E9E573;
	Sun, 31 Aug 2025 21:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756676695; cv=none; b=afYG/K8WbGZP3byg10gSWImUO9jDPRgDD2ZIGmaR5f6fFL64TrAMDE23R8UHRM0BM0KEsxo1N9sXsrZ1jEX37i9xFJxBdb89n/lCJ0BJU7455aCqOsA/l0xNH0UrB2L3qxGCyyXFs0ZgvMlYkBKLdc1wdD9hX0TYSjwFOMKQ4sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756676695; c=relaxed/simple;
	bh=ATlX29eggwecSHBFWVx+XL5nfZNPfYyOe/RUNhsSQVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZhuEJItRER8oWL8yslrrM2tAt9CiO4zJl6tyeTq5zsW4zRhfBioRWN4WYCL5Br6MYHwQh0uYbnlmSHSUBzOg54nvXVISo/3zxh1GJuFMwPPVOzxMo6IHIBfrTm1kFJxevry+GR8ESvY8RgeEKH6Gz+4myEhgofCKuZt4PmpcemU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmOvrJl5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24adcc94338so646275ad.2;
        Sun, 31 Aug 2025 14:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756676693; x=1757281493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATlX29eggwecSHBFWVx+XL5nfZNPfYyOe/RUNhsSQVE=;
        b=XmOvrJl5xcvvpkLDwr+Nur2ZE78vmT6uYFmS0q4hLy0ygE7tuowmNdA5jw0fzzt0Uc
         bFx0y1sdvCTGmT6+AI4JhwJfqP+CwzGt9TxWL9R5GQCypwz51SdYWNPeLd+ilvbboAc3
         rrYIComN/NJ46zsFhRpqKveZRD2uuyr30TdtCL0K9cmaSNadRP+DVscLIJRX9ac7cNNU
         cHSf9ZDd0I3LL9vKdnfNGI25km/i3XtsiQd1UrH/okKnOZ4Y5BfWxdsG1FCLSmWJM+77
         qDx2X82HyjOmK2muY52QItEs9BnUcRKNHz4Xif8+NV4O1tmegCVSS1PkPoGs5UUJws5K
         1Oag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756676693; x=1757281493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ATlX29eggwecSHBFWVx+XL5nfZNPfYyOe/RUNhsSQVE=;
        b=Vcjux8LLIw+cnwvOW5dbS30WbTqUTLBIVBjax1dvKDbvcqTS7Ik4OQCJXj2CzB9X9N
         uIdMPJ2ybPIPDCOBZp1cbrhcUtc5G/HnxLNiMHsKTTX5FAvAshj6pGW3Xey89PzcJICF
         ADKAtOyF+NQL/VXumlB8510wzye0nNtSNqFOiyUlrJ5eEHd6RJnVH0COtxbLBAfhp/Rs
         pQE0EReiZhnLkuHnzc9jnaNEK5CGBJdidpEIiHpXvjzn/Mm1sDGG7yhomVAwdAdbQOsh
         RTFHabcVnKpUZWVRhvlLt1CJdo+/quiuAAotQdlTYsrcKqGMcuTmr3Fqil7gVVXUTAOB
         RnYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn2eDU4lBI0rVAXZCcx4n+FFrEkdDPUcpfLhyREMT7XOib9zsa00Y3IXA8r5YdIZ9O1J0oy4wLEjZqOLs=@vger.kernel.org, AJvYcCWs4nnfbBczU8j5Kv2P1YGqkMyO9gDHZMg0ori6vbqvw44f13b6jYLL6Szo+So08vjftLKf4/BSb9CUOw7GLbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpw3DqxDLpVuWI/PK4VMDrPTooM/FCA4dBazCawQHgxL8ckkZp
	AdyW1R7VqOSW1v7JNdpONc7Z85BTEehqz1k7eQMQ+XLNyc3ZlrUGW534BSo/pgsaAQovYn8Qzwf
	BOQIy/MRgTK041x7/jmlmHLWU2ZPTdD4=
X-Gm-Gg: ASbGnctZnDl0+jMNrL6w9/6sZld/ixhvpB0paQ4n2NpUq/+HartGaFF1Tw+NOUIUXCk
	w4qTLCsfG1aqyP38Mm146EihZotHSATx0L2gdLKykoZNN0WB0aEgxI+HLh6YL6EfE++dWIlFVJc
	v8Ad4/vqmeWdLCgsfKcSd55juy5JXIXalcCPuadKYFGstX0Xtnb0u3nvro/moROGJ+l15v09bIq
	bRIp6vwk9x0dyHqIer3Pfa4q54qgc0HYgxIRZ70TsrM1WkxvsDTCIb0yDLkPN1bcKC799RL+X32
	JP/Db7bepylWIfNOm3RkZCpHNQ==
X-Google-Smtp-Source: AGHT+IHn8X2bk0G5dh7IMtbUmjvB3ATMrDad+r+JYlgB/nrfuB8xgJXEqdwDFEde9aacqWBGOAXr0FBhUY9DnbpUeos=
X-Received: by 2002:a17:90b:4c4a:b0:327:e781:3d37 with SMTP id
 98e67ed59e1d1-327f5be1809mr6603432a91.6.1756676692690; Sun, 31 Aug 2025
 14:44:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829195525.721664-1-ojeda@kernel.org>
In-Reply-To: <20250829195525.721664-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 31 Aug 2025 23:44:40 +0200
X-Gm-Features: Ac12FXyChBItJccN3j0dFvHJBmKuYD7SYQmA2dMr5jm5bR3YjQ5JkmRcM0hMeJw
Message-ID: <CANiq72=yJzJTP54WSmp2d0_Ox32KzE9WCDX1-e37GC3b2Mu5Dg@mail.gmail.com>
Subject: Re: [PATCH] rust: support Rust >= 1.91.0 target spec
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	Waffle Maybe <waffle.lapkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 9:55=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Starting with Rust 1.91.0 (expected 2025-10-30), the target spec format
> has changed the type of the `target-pointer-width` key from string
> to integer [1].
>
> Thus conditionally use one or the other depending on the version.
>
> Cc: Waffle Maybe <waffle.lapkin@gmail.com>
> Link: https://github.com/rust-lang/rust/pull/144443 [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> Conditional to the PR getting merged.

The PR landed, so applied to `rust-fixes`.

I may be able to take tags tomorrow, so those are welcome of course
(thanks in advance!), although it is already getting tested in the
Rust CI, so it should be pretty safe.

Cheers,
Miguel

