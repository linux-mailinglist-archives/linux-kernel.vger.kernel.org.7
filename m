Return-Path: <linux-kernel+bounces-773114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA69B29B95
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 529AF1885995
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E17F27E060;
	Mon, 18 Aug 2025 08:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wkolqyu/"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F4822256F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755504270; cv=none; b=K5EYleFSwPd49HMVTCHR37KG4Xoij3raQxAyqhCSoa3zIpONjOfYEL6nWqtIONmuP884vKs9I5zWRdQu6h+VriFJXOiJZFXqj1pu5VXwzmkrw9t/0PRqrpYM6q9guNIa7dFaqOOqVaFKo0i5NzXyTzIjwxGFMOjFlBrqGDqhtOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755504270; c=relaxed/simple;
	bh=+ogGHNp5B2vuw8Sx3cR50dRQPqv7sPx9Uj4pSENJ8eI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N6ehkHc1CvvzF/24ZEB7aJZyqTxdHHTeltkf54mNBtPC3y/wT1oeBV4ktme/j2n9njqZHCgSAcAq/iMh8q0oAK5gX75MmmcQNijnBVcRVElRQQifRwXPz3aB6/ulufh0E/ATgQVG2BpxcrcIeGW5Fy32FFI15Ip5Xi2g9wvtsvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wkolqyu/; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b9d41c1963so1823723f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 01:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755504267; x=1756109067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ogGHNp5B2vuw8Sx3cR50dRQPqv7sPx9Uj4pSENJ8eI=;
        b=Wkolqyu/+7gjEymkd5EfbpQ4sKgwlle1xv3Omwa66DAwGACFoxKiGJUKVYW4NYZayC
         qMorlle65vAlRUZEKUdvpvA7H/9Q6qr/dwfMmii8HwZr2h9HHl/7579U5ZcBRXhxyO1w
         YF4zkm+KCraamRZD+zrpvERZV50p3Wm5O62lJ9ycez6QjALqOnIu3i6v+0jGbUN7fMxh
         U+NPEv9UQhlcR9xU/7CywN++1scd09szxSxH2vTTB9NkCuxrfMQMNucOhPQmC5iNeKZg
         KQUve7M2X8B+BhwkfpYiae76YCcLxL+e0TMaI1Ycn3nf3a5wkFopn1ez8ibKsNBi9qyQ
         9z6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755504267; x=1756109067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ogGHNp5B2vuw8Sx3cR50dRQPqv7sPx9Uj4pSENJ8eI=;
        b=qF6SVZFxVY0KknLrvFojSS2XND1GD6IxVlgDdAMraqSs09njqdm92dT4Kh4sCl2uo2
         meuJ/plvzoCaDTh5mF2RM+f/C9N3jCLblCdtRRvWsWFTCyHJjjybswFLm/YFMvL567eF
         0UjUsvSUkU8rOCOaduK4UZCQK+h8ZIrD4S4IpQBjew8VYp41hi96Q6KE0c7OraF6jymx
         IBi9fT0u0oUNG8FQV6DVouhsJ9ngnUfe8aJHKpCtzE0J4Ur7L/snrIVsBrT+93eGUh2n
         LSk1cQhqXy5Z3Yt+zmpDDhdyMO8Y5ILq2yda0ZSZbYdnk8yoYULZYj2owdsWIRT5Nrzq
         PszA==
X-Forwarded-Encrypted: i=1; AJvYcCVRVjikFOCPnXe1JLdFeaQBuHcKWysCjZtAS/aI5rZfKYWEoaX6qJKbAUyEKRc3+gUUUF5d1pNb6petDYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXKjCWDXU9OBqe6U4QQAJ7R0zV5JV4Xzo2gmiMil8UvOzY+IEq
	uu4NNkm4D2QB/BmN/dH8WI7l7WQL3Dv99CG36YoXViJAuX5/6aU67LW6J/ADcegoKNFOAbQR4aW
	sAGjvWeTgSL9yMY5iwXvPehC3Pwtty+QNNW9gDkEL
X-Gm-Gg: ASbGnctILw052hlJjtAThsspOTjizhOe6uEu0fDrggjITZtFOsuy9pjASoLjuGPMZMw
	dscCoNqlYN9cDatvfKzD0+KrvN4TUxXEqitK9VcWjXaZK6231XT+ADT7BM8EQWHSzt8OV2ByZW+
	DRbkHUx8Fk8mZ+dj4ev9DsfYX/Q9doZDYnIOuV7+v4E3Yh2Y+vslfggPqqcuFhSNKOFhys3rGXt
	YCGCFvE2jOCjuq7iFzHTN7CLkKRFoR6bDxikYDQpQwPCAOtp6N5N0LYLMPoTvvFxg==
X-Google-Smtp-Source: AGHT+IH5aPA+4lsEWIpz23XPee5Gucilm6/jJy0D1IJSOLJ53lXfZLmhPLBb0e339QHvRNfI1jCf5ECE7BVeDepIOLQ=
X-Received: by 2002:a5d:5849:0:b0:3b7:9d87:97c6 with SMTP id
 ffacd0b85a97d-3bc6aa272aemr6301618f8f.44.1755504266794; Mon, 18 Aug 2025
 01:04:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818012648.1841387-1-lingfuyi@126.com>
In-Reply-To: <20250818012648.1841387-1-lingfuyi@126.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 18 Aug 2025 10:04:11 +0200
X-Gm-Features: Ac12FXzx_I9gusmbozL2_QUwPunlyuZ1-_AVDrLW-ZxrD10YAx95V3gJEW6eTDk
Message-ID: <CAH5fLgh0OSDnVDwO1wY9kd3UjVqaYvk-jJA-nwiz2ghR0Yu3Zg@mail.gmail.com>
Subject: Re: [PATCH] rust: xarray: optimize lock functions with inline attribute
To: lingfuyi@126.com
Cc: Tamir Duberstein <tamird@gmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lingfuyi <lingfuyi@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 3:27=E2=80=AFAM <lingfuyi@126.com> wrote:
>
> From: lingfuyi <lingfuyi@kylinos.cn>
>
> The XArray lock and try_lock functions are simple wrappers around
> the C functions xa_lock and xa_trylock. These Rust functions don't
> add significant logic beyond the unsafe FFI calls and safety guarantees.
>
> Mark them as inline to avoid unnecessary function call overhead in
> hot paths where XArray locking is frequent, such as in page cache
> operations and other kernel data structure management.
>
> This follows the same optimization pattern as other Rust kernel
> modules where simple C function wrappers are marked inline to
> improve performance.
>
> Signed-off-by: lingfuyi <lingfuyi@kylinos.cn>

Thanks for the patch. Please see the Developer=E2=80=99s Certificate of Ori=
gin 1.1
https://docs.kernel.org/process/submitting-patches.html#developer-s-certifi=
cate-of-origin-1-1

You need to use a known identity such as your real name to submit
patches to the kernel. Anonymous contributions aren't possible.

Also please include a version number in the email subject when sending
a new version of a patch.

Alice

