Return-Path: <linux-kernel+bounces-804791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2215FB47D01
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 21:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9870175F40
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 19:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C0629B78F;
	Sun,  7 Sep 2025 19:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlRDpmqg"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F4F27FB21;
	Sun,  7 Sep 2025 19:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757273105; cv=none; b=qesMT8S6+yv1zkD/aOsFBYV0YSwVio7Kp+Qw5tBioAdMESnyzwK41tSRi+vAKw+wFiiGZjLsfg3a+v9zvily54WGRmjUTA6K1pZyUu/ENB7h0ZQMuUlYx2ke+XOHpY7bZfQIylSQGwvmolEyJBM/1hHEJz0q3xGYHhHsdHSwJl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757273105; c=relaxed/simple;
	bh=h/1pZc441oFZr7fQJ9/PwQ4CeuCqxaadxa5ZrLrSIOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZUThnZISs0rdaYAoUHEN+gPPAh3q5yeRPmkvzkErdsXTIVKykAwBRg8Ds7Sy2JABlGDyW7VmwttTSKc/GvMyedbz7xSva+lBq3DLPoD40N2vJ6sDq/aHxd8vcEAJcGnthygdpyhZkssHwbUFA3lRkbJyy6HKtg4s9xZxH1hwl8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlRDpmqg; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32d89e962cdso41016a91.0;
        Sun, 07 Sep 2025 12:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757273103; x=1757877903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/1pZc441oFZr7fQJ9/PwQ4CeuCqxaadxa5ZrLrSIOw=;
        b=WlRDpmqgVvga2hqBwW1gcDb7TVHSDkBCeQq3zzo1EHSoV4bAodz0dM6fiqNaT5NPK8
         kyM2PRobN6LxtMgtAWrAgnE5XsZWSzA2AADzRhgriJY9zw4401q9HTpHiT8fjbahf+cm
         Tz9t3T51tS6+kYDon53rdPMFS6zG5xnVd6pmPkE6TCPB+I6JEs1kMmvyP7ZdUynRzcJM
         +ueV2jAYbJbNlW/AcsFOo//SvkzNLZFZYE0lUTvXpEWUArvpnuhrTbUli0CH27SNuRwO
         zFTE1IJIqRSIPyCvNMzsmZBFck8ihIoL9a4Eu56Dl1zl5+kR0x4R8+A+a8qVCsf6z/so
         jk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757273103; x=1757877903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/1pZc441oFZr7fQJ9/PwQ4CeuCqxaadxa5ZrLrSIOw=;
        b=dwHgtrMozWuJUlew6jdnKEC+ryTYXstzvKLwiV4uckfr3cvbZ6Vr7a8xyfEEKehvBV
         zBFfxMBBb/5NivoE3x76MiCQKAS/lRMhe4MQRyKmfr0xz5ScOTjWvo0Y2iOpWVUQne2Y
         cHYPS6FUhDXlwSZC7C9+VX+HWf0wfVA0L4tta64mMFYH5JEXn6poUEBt0+9S+AwE+n9F
         4BANQ2uZHNz0MvHGIxWfTRbWE9+JfxF5Ceq/ZTF1GyIBWgL3ontrc7YKaNA57e0SSumX
         LLuKfTALIIkSXxViphvrGc/j4Bu+idzSE+OfjO+7ZftS/JEsqcGjY6OgDE6GwY7QRm1l
         2Pzw==
X-Forwarded-Encrypted: i=1; AJvYcCU/gaYVmbm6nXRh/k2KcEaCNyHArvNahx5V3+1quAg+1dXyBC6hpLy4zsW5IeXv/XGJyUX7SYt2U8s4avqqc6g=@vger.kernel.org, AJvYcCW6lNrMRv/jKJNPFJGkOP6aERq6grBRu0iFub3iU5jx4ZkLokjV0Iw83lIgu1zK60+5sBOWZtSDNA696j8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnyDj9vnCz+vJV5DajrWbGRyv4F0xNNwH0I8U7NuXFbPObnMFG
	KOgHDhTS98699EfVwfmfZn6nyCFKfiyh4WOdG+Zg4V9WkaUG+1atIHw8/kUiZo1NCMFOPFikuI8
	9m99gfM3VAhCJDNzWZfODxgy0cAn4YjI=
X-Gm-Gg: ASbGncvvPe0IsmWY/ZxI+LgJed5lj6r09kg0L3PY0CqsROsBguU5l+gy1RM2J8Bai1z
	zhD/bf5Plu0Q33TgoeeojN1RS4IUcQ2WSDGATHtDiJRc1Lf/aLUp/oLAmz/SXGHo+8sQblm7Bcx
	p88Ybc8m4PnisSOuwq/mRhAUz1LGryJHk5M7gEFZXhPA3IrupiqJzrBdueUOotte/YXp5z14nma
	HhjEHUpG9m5FAQ/+yMb7iZEdhI7Rm1TvcTVg1b3QbUrhPlSBg5ma50vTAyPEUJ0774QIoWhWe6S
	YnTkc/47KTIBbM36u5P4sVKNVg==
X-Google-Smtp-Source: AGHT+IF+gvFF31rjWr4rNnxVWpKovGVCaH1wlCBgqOPJBdojTtNKLpKnTSgh+Aer2/Ku8UOhYBjLGtdTZm/sR9zUftc=
X-Received: by 2002:a17:90b:4a0b:b0:329:cc8e:247c with SMTP id
 98e67ed59e1d1-32d43fb5ca6mr4263633a91.8.1757273103541; Sun, 07 Sep 2025
 12:25:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818132551.133410-1-shankari.ak0208@gmail.com>
In-Reply-To: <20250818132551.133410-1-shankari.ak0208@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 7 Sep 2025 21:24:51 +0200
X-Gm-Features: AS18NWDDuNBNP-KbuJqZfAx1JPJZomHQdBMfK1O_6T6JpVXBy80zigS869h9baU
Message-ID: <CANiq72nqNaJ8Qr+hUNX6wvzhVOdG=5qcCw8zur4c3V0NYpkUoQ@mail.gmail.com>
Subject: Re: [PATCH] rust: task: update ARef and AlwaysRefCounted imports from sync::aref
To: Shankari Anand <shankari.ak0208@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Christian Brauner <brauner@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 3:26=E2=80=AFPM Shankari Anand
<shankari.ak0208@gmail.com> wrote:
>
> Update call sites in `task.rs` to import `ARef` and
> `AlwaysRefCounted` from `sync::aref` instead of `types`.
>
> This aligns with the ongoing effort to move `ARef` and
> `AlwaysRefCounted` to sync.
>
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1173
> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>

If no one is picking this one, I will -- thanks!

Cheers,
Miguel

