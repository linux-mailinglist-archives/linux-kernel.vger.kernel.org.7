Return-Path: <linux-kernel+bounces-737254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B976AB0A9E4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5716DAA5AC9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12FF2E7F22;
	Fri, 18 Jul 2025 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vtx6ekOl"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688582E7F08;
	Fri, 18 Jul 2025 18:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752861613; cv=none; b=TBm7gdvAW9XuYSLpLCDVD7qcD76C8kf7SBm+kqbXcVlowUI79mRSARkPzkd5p/CTavDiN1nZXO9dZ4CTH3UOzWvVaM5RKtmXv6fmQAEvlAKHjY7mt+1AMlSxnhC1XmBJEqTdyghXG4QAQsKZaeyhgUXYtOTumFQZG7MwQ/ifoZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752861613; c=relaxed/simple;
	bh=/xwEHrobFmsCgGgMrYXQUSqVl/v8uLkGaDkEC1/OOeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tZI2Q7HLXDRixwuePFAJy+xNYDlLRIUYLzCWhXZwCTu/H6SwxBp0WYAyuuqy/3bAVzX94G5CkNBbMFq21Yqw+Ohaq8YUNnhLr0j4nj9CpZCsod75qoX3cSW7E0F3iODCjSJ6+mc/yk41HD+Vn9sa+oFfnnW0wiuWRR381pQ/6Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vtx6ekOl; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-31308f52248so366457a91.2;
        Fri, 18 Jul 2025 11:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752861610; x=1753466410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5cDl7UpMn5NQofHAaSCQrMbbqbvIVxW1NOwevWmFtY=;
        b=Vtx6ekOlXk3VzmxucYOlbJOuqXLs/3QCmAzZbtHaYeJRmg7/mvJ/g28aHyz1hQYGga
         pXt0VybkKDh5roPtfKD514RJyzMkGJ4PxDv/e9OvSGhYhjdp9dqZrWa7+XL/SXjnRIzO
         8K8Yd748ZInYFt3iwf6iHhlpF4LgQRMAZ22i0EzVFEXHVdkE76ogl3Gn1P0lekoHyT8A
         wRu3p5ckL2dhP2EyBm6b8g8FxcW1UDQe83pGnDFVKLZ6zhPMq3EaES92aw55hxhkdvr8
         IYj8NVI7r17ylnX0of/TclN1Hk6qPuqGOda0Ebj4jc8cKYCsA890okdVRII48vnohlsD
         659g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752861610; x=1753466410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5cDl7UpMn5NQofHAaSCQrMbbqbvIVxW1NOwevWmFtY=;
        b=sVxnBspaxMMIEGThMia/NulPQGU9Pifm88T9qRTPzLrgq2nPNGe+5IzmecSs/6c6+k
         pSICYCIzUChUOITWbarsgNo5KgUf9lpBJpT6moXnwsMbWZbwDFkeYEyHbunNNWiIuRrA
         Jg0yJaIiL3xZmqHbspZve0E4Agt4u2Y69QEE+YqdCHVxnCAy2Ze3+NV4sie6mSAa7sNm
         jH3CCTsSvQtzJYdWiGa8jG2WbEBalvixh2P20UgAQ0XNmmqMdY0T74mAoyn04IBP0FX9
         zqUw3K65UmdvGCLXaQJ1haEiD7zjSyqBgY/v2e9qufwXVvxJC3AaO8icV2/MtPeMdaje
         qRdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMHW1ouwNfCXCy/R42UrTvawMQKF3OFtLUFkTkHSmFt+XZA32vBiqdkYoX5vXLV5tpeXve4n4V1YFyOo4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk9Moe39RCSfjWA8JqHZaGZIvh5+DGHLXM7AucyZD8StWMYBLQ
	wbp//zmmom3SP6RaH0rdOoj2D/JlphmtF6b1YhpP8h82J9EXkpsYIFEeAtuqE63+dhhW5juj6lE
	UIl12i2MRHxqrCHq2LN0x+J1Pr+b2/uA=
X-Gm-Gg: ASbGncu8gLS6Aj5a6DUHXIz/1AskbI8GmWqHA28QCrJzic3vkf+cMIklj6zFZ0pGT1V
	J/G1Y0IlY5FLLuKvcxy8i/vVfiqp6RXG93PPinTNbvFLjsbqDYdOpXnzBCkgvnsx6q+DOo0P+oD
	YXhxn5+RMa/4XBw9JNDylgImCYQAVwB/Hs2tfIGayDI8XhassTFTiGWUG9Eg/9qBXUMIbR8/yMc
	XOskI3H
X-Google-Smtp-Source: AGHT+IE/iSXS0TSQ38cxLFT8YdjwjmWkNWDVWQ9+RczdwIy90TAHOWw+mDsFvXzbGOnKEAGkB5Cqqp9LtcPfLx389Kc=
X-Received: by 2002:a17:90b:5285:b0:313:2bfc:94c with SMTP id
 98e67ed59e1d1-31c9e7afd78mr6651737a91.8.1752861610158; Fri, 18 Jul 2025
 11:00:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718142026.2232366-1-i@truongsinh.pro>
In-Reply-To: <20250718142026.2232366-1-i@truongsinh.pro>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 18 Jul 2025 19:59:57 +0200
X-Gm-Features: Ac12FXzzo5cde_-LN0WM1hdYPeEwZmA_QiTaWUkRuViXzIZuiZzTey3yZzGz30I
Message-ID: <CANiq72n8qdymDJnqtvFqoOsFXJqn1EuvRqBkT+A_ibZmmh7SYw@mail.gmail.com>
Subject: Re: [PATCH] rust: Add #[must_use] to Lock::try_lock,
 GlobalLock::try_lock, and XArray::try_lock
To: TruongSinh Tran-Nguyen <i@truongsinh.pro>, Jason Devers <dev.json2@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 4:20=E2=80=AFPM TruongSinh Tran-Nguyen <i@truongsin=
h.pro> wrote:
>
> This addresses issue #1133 in the rust-for-linux project.

We typically use the "Suggested-by:" and "Links:" tags for this,
please see e.g. how it was done in the patch linked below.

> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index e82fa5be289c..1c2ddade6d6d 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -175,6 +175,7 @@ pub fn lock(&self) -> Guard<'_, T, B> {
>      /// Tries to acquire the lock.
>      ///
>      /// Returns a guard that can be used to access the data protected by=
 the lock if successful.
> +    #[must_use =3D "the lock unlocks immediately when the guard is unuse=
d"]
>      pub fn try_lock(&self) -> Option<Guard<'_, T, B>> {
>          // SAFETY: The constructor of the type calls `init`, so the exis=
tence of the object proves
>          // that `init` was called.

This part was done at:

    https://lore.kernel.org/rust-for-linux/20241212154753.139563-1-dev.json=
2@gmail.com/

which is soon landing in mainline.

We may want to add the comment on top here like in that patch to the
other 2, and possibly make the "reason string" after the `=3D` the same
one too.

Thanks for the patch!

Cheers,
Miguel

