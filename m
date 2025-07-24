Return-Path: <linux-kernel+bounces-744875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90270B111FE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC1D1AE6922
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB46423ABA8;
	Thu, 24 Jul 2025 20:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wo7OKpkx"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE171FC3;
	Thu, 24 Jul 2025 20:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753387693; cv=none; b=A76zlYq/6L1F/q3PDD7PpmaEA+pRBIThZHry6jdvUmxCRObx1ueAm0r5YDi1wGKWmdE/LiAvOX0CANeXaTnFoeTv8++hkbjSoIznOtFCGf/Fl4SGnJIS2MEdtg0//Hbg0+ONdmXewDu7CbKHHOQKgLKAgJdc7TkDjb+9VZOpCXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753387693; c=relaxed/simple;
	bh=8QQdEzJ82nd35nwhRkeUVOhoRBlEZSyFuM+s01Ovw30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iTd/MbOiLOoOD3r3Zq6PuNFjO5qnJebFtVHuHACbG9q2PCllIowkON0szYtFEQuf1STUC9BQgVXbV3jM2KVLjGQ3ALfoOgHHv+viCNPpmD2ZqPDrg9PWMU1+D4m7Tp0AHj0SWkASeOSdEn2l+YwDZzJZFrHe6mmp82lFlIHwR9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wo7OKpkx; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b31ef5f24b7so25337a12.0;
        Thu, 24 Jul 2025 13:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753387691; x=1753992491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aq6vSt/gKpynoxg46L4WtPmYZt0C/ql1cFaqfd18uko=;
        b=Wo7OKpkxKPBxEpZo5TYQGnLRJBh8Vd80l3cnXRmSiD7x8IPS3B2V6BmrEsZKClXQab
         ncBL0XRSdE6wzIBcFIxozxhPm+rGT1mNNu2G7DAH3FHqzKm44L9FMBuRGbTpxNoF2b0U
         cLaxqj8NuHOfbLajCHx0YVEtnWkmWiL3thgzRbRIHPma9d6qIlF6Ryt77I3wEcUhHw+n
         O+S2EXsGSEShPu7eaxcBDKj0kjZ9P7feJSR+MwfOPOXycdPzlze+Dhk/TQmg8PrFKt4e
         gWcYMbJPRT04ftBbiLnBpt4IUgLSwdUfy44f7gwn7R60F+T201dU+56N9Q4zVklCcsXi
         RL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753387691; x=1753992491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aq6vSt/gKpynoxg46L4WtPmYZt0C/ql1cFaqfd18uko=;
        b=P9uJxK/vBMkAbKxDg2Zs/Y/dq2lpp3JHkRgwWVDk+oSSM5bLY2sq2fTODszvnJFRGr
         P+OHwEkDgLEQXQlMWXLyUDuTwYXKJgCa+JzdvOFJegDHPazd04dlm8B3m2Bg8n/XlkNa
         peaMQgA1jxhzVAtvyAPMrd5318JUnxlgEl41c9PQXLMlH+TDnDDqiOKo/g9Foe5qtj7a
         gsdhgrxp3A2DB2zVo85Xu/H5nsf1UUkfbvW03jWUtKYoWN3v8uKrWRMUi5JTcnX+kk0B
         pNc7VrHJkwJMlm7lB3i8XHyQMDeNuTdRapstIWn0lwrZaPa12xmGAWdVawNqh6peCLb5
         tk5w==
X-Forwarded-Encrypted: i=1; AJvYcCVxZybFvjGrewL1nDY8NLUI1Sf4l8UFwzyhA8pYY161JKvGe73xgY4nP6K/InUKzwVR9zx8tuzAPggAqVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzglghkpHRLVC2Yyzc7KhGFvW3zVaLBFApdfjoBt/t9ybmRO3kO
	rv7n0DyWg+FXaYCFmBGp3zPhjUjRcj783gFWqnotENylAdwbAvBKd9b1hpzg99QZGPGuICuOD8y
	0Zte/UDr3uX2fWW2AqFHaguXUDlyD1Ec=
X-Gm-Gg: ASbGnctZCmh1HFG4GYEQt4oVPnduI9wjsxqL5rpNJOS/phwX1zNajJ69QCydaqGRWnO
	fdQHt3g5jKi81Ltz7PctSPvmYdGL7RbGt6R7YNbzPaFsZXiB75U9MRE5M1YG4BHi6M1Duqj3ZDq
	BIDsxgHdW8Sa0x7J38NLCO8Ofx307XqB9xLusiKjkw5MTHaMqcm/VfQpetzqQIp32+vQAWT/Gj9
	pjlF6n2
X-Google-Smtp-Source: AGHT+IFdiuukc345cAZZvkOT7+Y9gWk8ZjyBMJdQTx0HdnJk1zh8Gb998xz2jy8Wsp9xj/Ow2MFFK8i7tfbMctUdlqM=
X-Received: by 2002:a17:903:1c6:b0:234:f4a3:f73e with SMTP id
 d9443c01a7336-23f981ba426mr48600555ad.9.1753387691128; Thu, 24 Jul 2025
 13:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724182754.549489-1-lyude@redhat.com>
In-Reply-To: <20250724182754.549489-1-lyude@redhat.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 24 Jul 2025 22:07:58 +0200
X-Gm-Features: Ac12FXzzZZe_kHvMkGVNuul-TLDgBsy-aFznsv7bkrP8VpvStsRg3BMYdLRuXFs
Message-ID: <CANiq72k3jOKNxsDwCE8XPhb=SddwOnCh20ATpFX_H_99r7u04w@mail.gmail.com>
Subject: Re: [PATCH v2] rust: lock: Export Guard::do_unlocked()
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 8:28=E2=80=AFPM Lyude Paul <lyude@redhat.com> wrote=
:
>
> +    /// Releases this [`Guard`]'s lock temporary, executes `cb` and then=
 re-acquires it.

temporarily?

> +    /// If the closure returns a value, it will be returned by this func=
tion.

Perhaps we can simplify by avoiding the conditional:

    It returns the value returned by the closure.

> +    /// # use pin_init::stack_pin_init;
> +    ///
> +    /// fn assert_held<T, B: Backend>(guard: &Guard<'_, T, B>, lock: &Lo=
ck<T, B>) {

We need to remove the newline to avoid an empty line in the rendered output=
.

Cheers,
Miguel

