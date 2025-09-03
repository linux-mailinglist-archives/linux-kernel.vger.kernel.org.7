Return-Path: <linux-kernel+bounces-799530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445B7B42D30
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E8717C43C6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF8E2EA17B;
	Wed,  3 Sep 2025 23:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/boVlXx"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C1923BCEE;
	Wed,  3 Sep 2025 23:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756940750; cv=none; b=KuubYUE/KyGKEQdOkSNou8R5u+GVO7z23mOTjzBeZKJCO5ZfwIIKEGaWQlYh9VvD12x30V4wsS+Nmxmq6D7v19Fd8amVB8gYj+spo6g+ynOQ6t/ZTTx+qSesZAtC3F/k79h5rpKAl0kMulcY09y68ji8R+UCrEmtRpYGia+weOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756940750; c=relaxed/simple;
	bh=eq7/R5IKf88go9v4Ju5UZ0MbBx+KI8h5xSO/c+W4WRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDDHz4PCaqJocaRPmixoCEBehnnFT4eZhgbb6V/0zkAYk2aNDBlferEcUsoi7o4Lllz4F8/bvEMFVOunhXbeHlJaSs7IfUC1VMzq9FN1BUFRmLflKLFkbxuwDFpZynHQQEnzbnG09wmwfkDCrhumpcgQBAuVCqDizFTHf5SvNz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/boVlXx; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24af8aa2606so705065ad.1;
        Wed, 03 Sep 2025 16:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756940748; x=1757545548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAh+dME9OWSqfZnxDjcTM+6W1pRlteZ4zjfIGpBbxFM=;
        b=k/boVlXxIqvgXkGgqM7VaaoIzIe8uZEHknP1rXVUwa345kUjroRCiMCf5b733TD4NI
         iZEp67BkT/Cws9apDl+Zj+MffZe/hE7aYPgUJvEliYHOm1mVQ4kDxdKCtflSc5SAtrF1
         6Y+83oW41oP976ooV0IlkkotQKMkL0vYkNa1sn7/pposA9fgDCfXIMHUOB5Q7bFMLmUe
         QFAQQp93Zy/vsxGlVHAL5h2tSnYNwYkrHOr3n31c6XM0XUkNEITxwpxWlq7jc4xRRvUj
         bgvmHsakluLOegiwFvsAqVzlU617RL4RlA1Vb7kYxiXpz0hImoixtSOiCIu3zdj8e51P
         RNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756940748; x=1757545548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SAh+dME9OWSqfZnxDjcTM+6W1pRlteZ4zjfIGpBbxFM=;
        b=uxdWmBhIefBhXPm0m6ZsEfsJ5WlRnV2+x2KIzlnKR1mBvtuuSH4Z3iPYz5wf0kLjBT
         6u5zpROTgsBjhYaFD1sHeU9rHxTSdInqCQ/jZIfTgaHndQjMrDBAN6chSWxFYPh3W9Q+
         p8d8ncVYZ/I60LcdM/bSm3zjIju/OqKfA/7vM7s1JMyjnu9BGomVaHesKOtMnCl4wa7u
         G3eQAxfVhddJY3DJuUTsjCcpUkD15UC9YejzzTyqDjfiOK3yyBwYCSOiuDcEFG845/Q6
         WGzjYCk0dDjBPOKgeezovf54zJrRVkSrsDC6Z5w7DGDkS/94dCXFsE+4BL75mEGAMzFZ
         Raag==
X-Forwarded-Encrypted: i=1; AJvYcCVWpimjxH4DCrft8l8KzhxfsRRECTF7Gslb54iJT6pJ574gAIP1YfoHGr8deVupmgA0QRol3Y20BqRxbug=@vger.kernel.org, AJvYcCWVfVDMxAz00j12qH0ynKb7mvgqIpyj6UElpTMPnWJ4mCOgOxVhSZlXuSEqvsfw8tKsG2gAoP4K8PVjOuftPAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7VscNXR/oXLz6ISulu/2/k969Knjd9JOJwonql3K9RKaPEvn2
	LYDVrjLfPT9SuAuIcgusQZ2XRtfjD3d2sQFpqKr4S3ZvNZji9iO0j4JXbIVQVxz0YAgXAgXjoB5
	OQzAQPpLkJFC35SMAUMaBAcyPdi5/AD+ECFP+UKY=
X-Gm-Gg: ASbGncs/D1nHV/LQG7tKv2hZtuKiuus4jZV/iKX4RfarEPEHd3rl5UaDQJMkoC/lhgM
	FZ/9gpozL+PTC1eE1VksTiMayxRyUrGhWsQpvqUQovaTAK2UUOsmRjzHtsEJJz1m0bOOuKy2Olu
	YjxeBXKPcuujuYesDXpcuTKvRqESJI9vxy3xYo18wrq3Ry6FI43aF/ALqIWueKQ8S5UAbb3gNrU
	QBrvymFAaXN5fzXPvSv++iKhqmrjsW8wfg53Ez5pOCbhXp9me4N8f46tdud354xXpEj8Vwt2hKA
	7w0citMY+dRVKtGoaRowV2/Rcg==
X-Google-Smtp-Source: AGHT+IG3ySswXqKjDVnI6DYwqiLKZ+zahBDaGUECQtFUfaWb6/E3RF2IzUEhOFKBc0MKjkW2U6s15CTFTiZJNbe+kmE=
X-Received: by 2002:a17:902:ea0a:b0:248:7a43:e1c5 with SMTP id
 d9443c01a7336-2491f112bdbmr141413195ad.7.1756940748238; Wed, 03 Sep 2025
 16:05:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828-rust-percpu-v3-0-4dd92e1e7904@gmail.com> <20250828-rust-percpu-v3-5-4dd92e1e7904@gmail.com>
In-Reply-To: <20250828-rust-percpu-v3-5-4dd92e1e7904@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 4 Sep 2025 01:05:36 +0200
X-Gm-Features: Ac12FXzihGQzDs_GFutYOUS54a14oRZ9cA9ZcvsQfbCtCM9R-v8HIZFcT-sGIq0
Message-ID: <CANiq72nnWmzOfZ1PhSid4t_e-yWEgi_hVx5Uj4hrB9wzpuP6nA@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] rust: percpu: Support non-zeroable types for DynamicPerCpu
To: Mitchell Levy <levymitchell0@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Andrew Morton <akpm@linux-foundation.org>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Danilo Krummrich <dakr@kernel.org>, Benno Lossin <lossin@kernel.org>, Yury Norov <yury.norov@gmail.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Tyler Hicks <code@tyhicks.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 9:01=E2=80=AFPM Mitchell Levy <levymitchell0@gmail.=
com> wrote:
>
> +    /// Get a `*mut MaybeUninit<T>` to the per-CPU variable on the CPU r=
epresented by `cpu`. Note
> +    /// that without some kind of synchronization, use of the returned p=
ointer may cause a data
> +    /// race. It is the caller's responsibility to use the returned poin=
ter in a reasonable way.

Please try to make the first paragraph ("short description" / title) smalle=
r.

Does "reasonable" mean anything different than any other raw pointer?

> +    /// # Safety

Newline after section headers (also elsewhere).

> +    /// - The returned pointer is valid only if `self` is (that is, it p=
oints to a live allocation
> +    ///   correctly sized and aligned to hold a `T`)
> +    /// - The returned pointer is valid only if the bit corresponding to=
 `cpu` is set in
> +    ///   `Cpumask::possible()`.

It sounds like the returned pointer can be invalid without triggering
UB -- could you please clarify why the method is `unsafe`?

In addition, please use intra-doc links wherever possible (e.g. there
a was also an `Arc` elsewhere).

> +        // SAFETY: The requirements of this function ensure this call is=
 safe.
> +        unsafe { bindings::per_cpu_ptr(self.0.cast(), cpu.as_u32()) }.ca=
st()

Please try to explain why, not just that it is. It isn't clear how the
safety preconditions, which only seem to talk about the returned
pointer, make this OK.

Thanks!

Cheers,
Miguel

