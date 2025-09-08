Return-Path: <linux-kernel+bounces-806044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 402D7B49146
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40C261B25C98
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1ED030CD92;
	Mon,  8 Sep 2025 14:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBbBuTnw"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20C630CDB6;
	Mon,  8 Sep 2025 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341301; cv=none; b=j1nCkQV+65qj0FQ2/JvgqbAGnqftLPG0MMPUscJ72ER8VRxjQ+A6m0Vxyxg45dbFIsBlHJIcgm9FMYLCVYVEgrbvbJtr3blZTQlXML+Mp/AYbIFXqC92psdhZCVw4m3aDaaf0g4oXwgnULb5YadlLc3Iw1TBQqNZQSfxte08itk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341301; c=relaxed/simple;
	bh=XeuQJKx+F8QDaqesC40rVF81yiQ01EIBgBmzXvLUCrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I4Fvt9KMcqLYMCdRanqrLqep7+uaXR93iLdp2yb3tG2Z2ph8Mg7IEQA8TKWu2u8xYwNZ+b67vBWVVVK7tfFdQKIBtFR1Hculbejv5mCVNbJSCmTfpDNaRM2e5PdTJLDRnfqachmCrorZaMdwIv+JE/V3kTjzKGKgBj7IuSv/9XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBbBuTnw; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b4741e1cde5so494421a12.3;
        Mon, 08 Sep 2025 07:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757341299; x=1757946099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fX9DC1fZNQkRHn2ACjPhGN+9jbwsbcB0Idr+2XnvFo=;
        b=RBbBuTnwaZdxr53a11XuezcfgkXIGBTlnNIACfD8gz21gD+fN/R4nhMg+FUCROBfqd
         cWREc7PR0G066kChcVQheFisroGzgUQzHLQ+FYTmPjdm06TYOtWGHlnft7kNlBmsxbqz
         38KGriYd7m5pQC5T5WAfeGTwZ0mgp6RT1nioiSogEkwkFhE3BmcnK8JXtdWlhKsWcxQQ
         aZS3wgD8if6Ky1MKxRwyFFHIHrajonX3MXzwsG4OkA/k/rpYvJzvau+fiaXhbj9yyyYR
         FJoF8vWugpVGN2OyCvTicdOFHQAbgQ8gGNDU2kz/u3zAMZfqDNmvRv8z7aaUKn5J6Jnf
         vnkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757341299; x=1757946099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fX9DC1fZNQkRHn2ACjPhGN+9jbwsbcB0Idr+2XnvFo=;
        b=fqlG5MbSRvquCgti1dpZZ9L1ez6YHobUl3j4KziMAP40fkgeivqyugljkpKHYZx9NE
         ebdx+nyUIgjQ5M8Zz7Bv0jLOtkTvKKcmZiD8YOOU2/QezeIbiSUobqRUNyoNCP0pPV4x
         ztuikJGwqo0a27Pr5DtuVWSf0CQdayhFfy6eO/LeAn4FovDKduBXLH1APkkZEgUjt5Qn
         QIJT2zLPczH+t5dHpSGypvsmXAs1yapikDuT5McC0TtMH3YlwbBnF7XHGKBLRW3POvft
         VGrr+bj12i6RH6Obbig6CR4O5agECzRfCIONHpNlCh56Xhq6kI3EedNk9cbKEhPLSPNo
         4CeA==
X-Forwarded-Encrypted: i=1; AJvYcCUwfP1nQaZjfqwZkZ9mOAP0coT3AFgAC37hgBOoJOGRJ62dsHGVJRtYXRrJBB/fFzmnSOvX1GSF1kG4AYQ=@vger.kernel.org, AJvYcCXWMyXxhFrYvMaPRDQj4qt5H6Mgq9Lwz1HWJp6TZt9q6FtH+QkoSfqeO4QXlG5cNsVEy91SPmA1YHet3xRvX2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcrbth+I6PzIkTPwAN6F3h8iFmKBErrN2sLuJs1dgl4LQgF+S3
	N1x2pGsZwQ2ZhYqluYYioPxqLEA2vaEJC9JnfAHzyJpviyCMrDTfwEOvUikoJg5D71FYfKUzVmR
	QZR++0NFHxrlCL1Rf1+gPzlwQ2L5fpXs=
X-Gm-Gg: ASbGncuANZYdj0d6G7q/F1bRBUWR3tysch+1YXo/WLsqzLee8PC10xKXw4uFQMxZy/j
	9w+YgH/+Y44oCeTJkNXNqQXu0kcOZ4M623Hj9d9PUx817+06jMEwxeW/b4yEMLhbx49tZD5QbW/
	sraOFT19MO9GDMW/xsNfgEcKBVOeCwR7njA3ECfBMzwmZr3RBlaf7w4LKMvgugyx2GLKnH2VmsD
	SZZ2z2Z5cfV00nRKxPC6yQK4f6lyhco232qz6r6rb0v/7R4W9DW6/3otpLBDdPiiCljd/NX+w6D
	A4qevXLvfece+Od6gL/ctnvev+RLuYt5fE6y
X-Google-Smtp-Source: AGHT+IGFDNWEzR+hV5I6QdUVy03a1/7tXTmOQLf+GpNdlfKZ504RA/zXUJf2avq4t3EcVfEw/QWRxQ/DDabXjK9CYqI=
X-Received: by 2002:a17:90b:1e53:b0:32b:7082:b4 with SMTP id
 98e67ed59e1d1-32d43eff842mr6514245a91.1.1757341299091; Mon, 08 Sep 2025
 07:21:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908-num-v5-0-c0f2f681ea96@nvidia.com> <20250908-num-v5-1-c0f2f681ea96@nvidia.com>
In-Reply-To: <20250908-num-v5-1-c0f2f681ea96@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 8 Sep 2025 16:21:26 +0200
X-Gm-Features: AS18NWAfR5raXlS_a2FxsPSSP3cBVpNTWSI1d9yZGzogiu6fnijmKILcUd_FVZM
Message-ID: <CANiq72kUsG10+E-W6zhFXhexZV+O_a-K1Px0kGkWPKvMMhAztQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] rust: add `Alignment` type
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 3:26=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.c=
om> wrote:
>
> +        if ALIGN.is_power_of_two() {
> +            // INVARIANT: `align` is a power of two.
> +            // SAFETY: `align` is a power of two, and thus non-zero.
> +            Self(unsafe { NonZero::new_unchecked(ALIGN) })
> +        } else {
> +            build_error!("Provided alignment is not a power of two.");
> +        }

Would `build_assert!` at the top work instead?

> +    /// Returns this alignment as a `usize`.

Intra-doc link.

> +            // SAFETY: per the invariants, `self.0` is always a power of=
 two so this block will

"Per".

I can pick this, with or without the user -- or do you need this in
Nova this cycle?

Thanks!

Cheers,
Miguel

