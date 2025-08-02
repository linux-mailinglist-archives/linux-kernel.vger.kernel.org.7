Return-Path: <linux-kernel+bounces-754157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE04B18F19
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 16:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366D3189E4C3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 14:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1822723A99F;
	Sat,  2 Aug 2025 14:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMUFMl65"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2B5230D0A;
	Sat,  2 Aug 2025 14:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754144305; cv=none; b=KONghyZNV7Lk9x7lCTzXiNrcqLzlGU+jQ6HDXtKd8X6RyXZKWaQqJhA1eiKzesqJ7bEUcHkpUUTOflCxbENctEK/dAe1dCE5Mq6K6SSrCLD+hP2mMJvJBkuuRtsCdvBHMAU5QlIjjWNFXhAdScgLU4E7Mvy35aFrCGkEfOtXhl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754144305; c=relaxed/simple;
	bh=UZdj7s2Q6LJo42TazOB32nZEdZKxZSkQWC/CRy/5iMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJ9bcO2pwoF3KauW7eaPbwFSKU+t1X9fyma25POmIlIBFwd1qSCEkR6ekrKGZEt9lKhwwUTjtH8M6DC8rr/5tydmQuaYiTvpHrCCyl+UjOCyO81VrI+eTlB2TisfmvdT9kRcpAX7fApGk3I8PaCfuK+7D+caGUXRXW8++ynUoBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMUFMl65; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32116dd55dcso209606a91.3;
        Sat, 02 Aug 2025 07:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754144303; x=1754749103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RL+4avU1H8oGKZXlNOwDFTlYSKmu/Vf7eqNV14tYb/M=;
        b=SMUFMl65IvG8ISDbxluNKYK9A5STTUj2kqdGKCp14l9ycXWOEbb+Gkl+Mg97GZA1Og
         v3Uxevs6Jb9T0vTLrApF/hDUyqR/4dpFSnvYUmV1FvSs82+gh7PA7BqitlHWfP4wzNUE
         vWFvXGgrD7+a9Q/LAKTBjZgstJebiLJmoCJ3L9wh5x6x+E/l78qAJmhujnk8iLDvyUtX
         PY7rtfi4qB/ADBxI1jJ8Y0qw9mVFLyp9bx6et2J3V56tQiEGzeSXlk1OtcYnHpJr+QgG
         YmYov0IxSwRhzE4Q0VUskIk5neCl1VG24hGq6UXRsaB41k8pUwFnffkynjPIDowatRnY
         UNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754144303; x=1754749103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RL+4avU1H8oGKZXlNOwDFTlYSKmu/Vf7eqNV14tYb/M=;
        b=MNeqHSGNJ11m7PmMvh/dLFwpKN4rtA2GFi8nM4TXyeVf/rGOFpU1ET/yzxHXRVe8rQ
         IG8mdiXP7zVWuAuQbpQDd4pWSX3P7FQYyIVZTqnYNEI15pqXukEh+O6EXqy5u1j5AtIn
         JtYcYMMnDeDaOgMvBv8TJCZYE3gl8jhlGdQiL/zOSLDDcS+L976fjQTlea1pQ+mZv47r
         rM9YRHvhyqvT3BkOnao48gC5cfBZOUjmoYsZlYdaw/4yKLpg9OATdhacBsmZNe+HjFFh
         Jy3eTTYXI77P/Yh69+mYh9EjjqseL/IkAyOEUpzmY7dYXKzWkrNqPKML34LZvC8KlNeh
         f6fQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBmh1+WQR49E5TgNTzuGchzWvJvwsF4mzqk9a0Hkel+XjWN2mLtrgYbYh/JonGps5J0J1UAnY/TrWVHx8=@vger.kernel.org, AJvYcCXVIDc11WANsJgSSGkQWep7uXdbDBP3YacZcJeCGgIVlmEcVnm8bwGQDg+4Zbf78K93kF1FqKub4OLIRlKkUsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI17bCoN9SQsPPDoX2f2Rk42LuNNofFqpR2DYjxoTHfroVt5+4
	oRYk7E8ep1E+LboL9G/uZLGMIoviBu2Lzs68nJv1svi0Y3eMQ1BI2SCLFNChkUgvivsls39ZvcS
	f9Xwf0wchTqQ/BHfCYv3VvuD0AW/ExDA=
X-Gm-Gg: ASbGncsJ3BmaUaA6idx7lhPh+SIcFJ+zZCLXk1LDDvW8MMk1cHEvsITsQldiTUc7BbN
	nRY8yU9N3CAaXS6Uf2GMzUEboYnHfXNlXb18JcGNfbj3482frqwbNTeyW/CHP4vonw3GWqHX2Df
	z9Ho7882ECJwNb9HrdCLVH3kUNw/nt472VRApGxawuSko30jpcIjziI3+lJe2CV67VH+F96X3YS
	CPVhLhb
X-Google-Smtp-Source: AGHT+IEYyK4FnrbzDvIfn4l13uARdRAi1BsUu+rKXOV0Jybw3LuyofhD64+Vp6yv6vQyxgpYLpFrKDkYAuq4rhRVUTw=
X-Received: by 2002:a17:90b:38cf:b0:31f:3f2d:25ad with SMTP id
 98e67ed59e1d1-321162b5699mr1806962a91.3.1754144303280; Sat, 02 Aug 2025
 07:18:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620-num-v1-0-7ec3d3fb06c9@nvidia.com> <20250620-num-v1-1-7ec3d3fb06c9@nvidia.com>
 <CANiq72=BSnom-nQgzLvv-cqwSknK1uJ=CXGP51r0WRj1Y553Ew@mail.gmail.com>
 <DAREXAUV51B6.7X7TPOJKK249@nvidia.com> <CAH5fLghRJ7QqGKJdUq5Nic542cJsHKX_C+EL+xma_rFJrHd2QQ@mail.gmail.com>
 <DBRZX7EAK13R.LTIJJPA9CCSO@nvidia.com>
In-Reply-To: <DBRZX7EAK13R.LTIJJPA9CCSO@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 2 Aug 2025 16:18:11 +0200
X-Gm-Features: Ac12FXzP6tbJ3FK59a8caJxtumpeBsG760k67kwwrIw1GCiks-gr_mjRWnNBb2Q
Message-ID: <CANiq72mjT5jJiRG2J4KAL7pupv5WoCb-T+hXJ=H5NG_4n0HLOQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] rust: add `num` module with `PowerOfTwo` type
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
	Nouveau <nouveau-bounces@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 2, 2025 at 4:02=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.c=
om> wrote:
>
> Belated thanks for the suggestion; I have finally opened an ACP for
> `last_set_bit` (and `first_set_bit` while we are at it):
> https://github.com/rust-lang/libs-team/issues/631
>
> I am still entangled with how to best leverage `Alignment` for our
> purposes, but think I am getting close to a v2 of this patchset.

Thanks for filling that one -- linked now from our usual lists :)

    https://github.com/Rust-for-Linux/linux/issues/514

Cheers,
Miguel

