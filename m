Return-Path: <linux-kernel+bounces-870443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6DEC0AD24
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 17:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A057188BC7B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 16:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF6622423A;
	Sun, 26 Oct 2025 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0o1OXDJ"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235DC20371E
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761495077; cv=none; b=aHe0cFUADkHQUIR22k0ektpocNjhWRuPs7KAldTGZ6g5/0eo/JfQKpQ0QLgDXC4GX+9bNy3CAGCO//Lh1+KTnBxiKfisNzt39e/mTw6A82pLMxbf5U5zcsBjGg0XzNsQHzQ1hRU8OgxCkXBEwQ98l8cEHPR33ZQUPNiXXkoSYJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761495077; c=relaxed/simple;
	bh=b/cnNI5DLYSQ1LNmhLxai52Jbx0+rBEUqUBkQ49bPvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBoEUQG3wlq2HlHsNPfnv3Wp0LjvhC0+JVIkaiSnBtaMK38PH74AP6UqxD9eqi1iA++h/pS5+MNVRZNtuhhj5oVW+y25AsXpdPfGjbnIF0QO/Bq6tD54AZEUx1EfdA4fBmOtC2w0o1CbHBTMJISmda0jafDaz7jjKGvMGKyQ36o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0o1OXDJ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-26987b80720so6768995ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 09:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761495075; x=1762099875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQau2nuAPBGeqn7nXR606yrFTjooTnZ5gmJ89ZW511o=;
        b=G0o1OXDJR4Ov9pbnT2bujSglqNdu5axd2DEowrwhS11c5CT2QbPH350ozcsznhu04m
         Myu5+hMer9YNLsGvLtBQsv9jVlCeFmk2xU7Z1hiV7Es8SlxRQ3N3wSh/S637xXuxr09/
         C9bF1mFkWuWpfnksn1nZ5azTDWZzvViPl+6b/py9Z93tWOD6NqMZlZnShMcHZt4tRqui
         MfC9pJfnGFpC2ri06gggGe28yGOXGhkTQXCvAu9GveMjx5EQW0oUA0A2tn7AZTVBxhVz
         PszKd8Z2qdb9sE6wVXuBBf/PR2DxYacQLxv21qGASzErsvJPHHpPLU6Joc2CY6YTYIYB
         J2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761495075; x=1762099875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQau2nuAPBGeqn7nXR606yrFTjooTnZ5gmJ89ZW511o=;
        b=TaCDYfG4L8/bv5CtBqlpog6FPsLJd1IBsbiVZOIBws+s4E3pU4e9hIhuN6S/yGRBGS
         xOMplfdjYqjOEs6FzTLQvA9xFsU/o1MiwIrcQ8+mZf+odQMdOJQXrMiULwxpXaR57lfV
         6UMRJB1w+XmWdWGp+oTIkXSB9bk7nqRG1781Z0+EVcw8ghfJL9h8AHTOaNv+e0Xa6Aic
         jXBnobpGGypagX4ZcQuFNap3yMDNDr5b/YMYluRUxYqooBzUcyXBN8AKCxF5TMZhqy49
         CKaJsi3fWLy2ODAJGHa+pgXpoj9NabnEVhhiWALEMQR95Jkisaa1B+ElLT6ftq+wd6gT
         kCcg==
X-Forwarded-Encrypted: i=1; AJvYcCW8rP2bvhy2EFPlqOqWJ2HTMDzGhS20RPLwwAv9u+8MK/JKYhP48SnC04k9ZhFwXoAYDZFa1Rpf6kZpJDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwG8KbqXC87DV67p/axSTU4/GqzHOygBdHGhlB+FgCIQfqDQmf
	kuiNxehfC49Fzc9wE5+B00GDzyu4rCEUku8d8d3MybR56C5jE7F0LXB6EnTgwRxfJT6XNMWXlxi
	dn1lD5ONzPswVKf8oVhsOTNxWPIqa6cU=
X-Gm-Gg: ASbGncunauSAwQbWmsz/UMfa4Q/KwJzZy44Nfwvo2/dHXAupcp57twfDGD1/06JfxCE
	wEUhzuvTWHN2juxqGMNHXPMWdfI61xt550QeGmslhbeXk5/ithp8Tstx3bpDP0e5IZUNv4DSeAz
	vnI8yKNpYrS/37ZV5veJ1J1/4g23ap9we3r8bOWDASqJUR4bq8XM5LUmDQWcsADjkA1o7ZEXg3F
	bOEelCnTaeXw22GDeTwSssF+lEt4VT6ejINKyltrRGxpHNFpGi5lBHUH7qiZsfPSoQgUa8luf8M
	VYfT8Vr+wRlLU9EfFVwuXgh8I8kC1L0p+NU/B0bTnP56ncJL/6YduFDKnl6z5KC9CXLXrvTceDu
	u5L8=
X-Google-Smtp-Source: AGHT+IFI6sg3xeU/Y+7ewS/quTbjQS82OqC83SGue3QsM3IMT+1H7kuNPGEtqVWO3pz2NXoXOmWS4q2L435vkLC65I8=
X-Received: by 2002:a17:903:1a0b:b0:27e:eb9b:b80f with SMTP id
 d9443c01a7336-292d3e50f14mr137740975ad.2.1761495075335; Sun, 26 Oct 2025
 09:11:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026-nova-as-v1-0-60c78726462d@nvidia.com> <20251026-nova-as-v1-7-60c78726462d@nvidia.com>
In-Reply-To: <20251026-nova-as-v1-7-60c78726462d@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 26 Oct 2025 17:11:03 +0100
X-Gm-Features: AWmQ_blYJsh-bUnlNpdDu-je1LAAZ23ehLx8sNiiMWM4JI3qmhDsJ4Jmtvqb2i4
Message-ID: <CANiq72m9ms-OznWQ5+4_JvAs4yruwgBRcm1u0gCAnasqO8uJOA@mail.gmail.com>
Subject: Re: [PATCH 7/7] gpu: nova-core: justify remaining uses of `as`
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, John Hubbard <jhubbard@nvidia.com>, 
	Alistair Popple <apopple@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Timur Tabi <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 3:40=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> +            // `as u32` is used on purpose since we do want to strip the=
 upper bits, which will be
> +            // written to `NV_PFALCON_FALCON_DMATRFBASE1`.
>              .set_base((dma_start >> 8) as u32)
>              .write(bar, &E::ID);

We are not very consistent on this yet, but I would suggest using `//
CAST:`. We are working on getting `// PANIC:` in Clippy, and we could
get others like this one eventually.

Cheers,
Miguel

