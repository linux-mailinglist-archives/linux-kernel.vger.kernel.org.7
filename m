Return-Path: <linux-kernel+bounces-792969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0CEB3CB01
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 15:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E74467B7689
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 12:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B8F27C172;
	Sat, 30 Aug 2025 13:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNtrWxtg"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459FD12CD96;
	Sat, 30 Aug 2025 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756558843; cv=none; b=lZHsM4ZKSncbByyuZKE0pAuMy7VuUcj+qjWfwHNdL3dQsdbX1yttvKV3Swo5jXpm3SBdw+3PlaJ32igSCqN/sMTpXrkeB01FUxJJV+hWF2X6QzoX/y9fxchSXaPssl0COlS7CEWUNKVaT2zf4xX/eBOvA6A6xh1po+bHCVS5hMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756558843; c=relaxed/simple;
	bh=Bx/hAtyOCoWdaGajFThJspKBa5Qz5b24ZK57VCx3CEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UB5A/QXi1b1mZTdwdVyjTwBnfDJZG/oDfDln+XRakevqYi8NWoqPY+B1+x7Iao5mqwdh7J5MWI2zqTx5AS0sgMURQmI0CediXANh/4TtlrtD9fQuX6aaRvfb9veSTEAKYVKnILYr0aXSIzQc2nY/8iBlnF1jgZ7HLpOCtv0DjqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNtrWxtg; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2489359cc48so6434095ad.2;
        Sat, 30 Aug 2025 06:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756558841; x=1757163641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bx/hAtyOCoWdaGajFThJspKBa5Qz5b24ZK57VCx3CEY=;
        b=CNtrWxtgZrw5RjxTRg672xjuucEbzi2vbcZY8AwGze62YEnReSo7lFWkHHJG9fZxkx
         oa1OmxvZOSUWh3vO33IIsz06+2zSqHxUU9tBtw9x+i4/I9SWrnHuh2bHm51ymQfIIQ6b
         m/4RZQCXK5h/Y1CRUmTezUCNnBdWzNVD5YrcDpvPahA3/rVnb8eINYYMj+8N56g3PTBU
         3hTduW1o/zBTA4ky4poQaCR8qkhOzk7yje6vWqRd9fktPkZnT4yFncqiHURuhdasxmuk
         zfYQs4PChgXX1TNIGXELk+EfP5yl08nlINK4PLQmbnpRWmMgf/S1CfN89NU9jRLJ43dM
         dwog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756558841; x=1757163641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bx/hAtyOCoWdaGajFThJspKBa5Qz5b24ZK57VCx3CEY=;
        b=jpSup0k6y7GN/GhBmbDXVMz2H2L8W7DW0eCMWMmNEbu5B6Vt1YYTyatSckfjdTYXXL
         ZJfT3W5+wOgkiGMp3qVktTZNWv1xUmmL7/E17nNDZo/hBDgV6gKmlL9DmBrOma/EVW9p
         jxQfHpJZQPA2ZcNXIRiFPlHnJBBCPl866wQw27cQ2GKFbP0kE4lf1fSV9XhOQf/g3Wi5
         JMQDOww4k/bVfZ9NUoKX1gCdW72990ZrP/TkoLqsNfuYV9ExcMpjxOYF2l/YKE01jWIm
         hUTaLzUpH4cOOGljdw7hdASQDujvOvg+CJeSNBJC2aKvjB0gT9jJw8atNkZvuyeZxrXh
         SAkA==
X-Forwarded-Encrypted: i=1; AJvYcCVlImWNauozq8WPcEGZa1G2qVHqR7GSAKRrUz0o94llnSbE4E5Zl9WsbPqDq4XkHt3aeH9lafi2O8/g3n+EvN0=@vger.kernel.org, AJvYcCXMa6kreasyZFMsLsuemTHRHiDQqQPo9xd4e2GgqevHZbNlxC0cJqpapMQi7Fu2grIYv2OgEBzFHQIF1RY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjMCbEYw/AlduzYx4urZv3W0DlWIjqcC9tlzb+fNgfu/TqGDfW
	/ixZeajegkupxC2hYgG5o0+gHYwUn1D5lnjKfzG0CJmjiOlXgNMXT4w76xm4fc8HiQ5MPNlNc+y
	S/rWcq62kal54MkGmwsM8K0IG+LsAftU=
X-Gm-Gg: ASbGncstURP26JvesYSFcigC/ws2WZCnK1zE/baSTJZtp1bwWqLMERiK4BmPEMLBRqS
	8sxqLawdHEAkMHatVsG4fteMpnfP3Zw1PqCVYvaGJSjFaNp/25l4csVldyqTq3XavE0RT7RWxYs
	bRYAR3r1smJrfwzU/n86+GFtbM3nMtqqaYIbPtPERP0CWrb8AyHyv+Lbrjum4OcWOUyLWDPxaHl
	N+2r4vdKz+oE0jRauj1qT8p1Pw4ug49lSwQ3Cy5wU+zp7d/+Fpj2kZddEpsQdicbzyt6Hpi/k8K
	u/etsSLN6fzKcAF7y56FlwKZOSyxAQ4/5S0P
X-Google-Smtp-Source: AGHT+IHfl+YASYdINwtLRhRTrD0q/+tMzOV28mEvA8C/FMutP7GVc2CKdomiL4R6Uqe07vKqFV3NQFD8S9pGLI8hSuM=
X-Received: by 2002:a17:902:e546:b0:246:a488:52b1 with SMTP id
 d9443c01a7336-2491e1ed207mr32288185ad.1.1756558840986; Sat, 30 Aug 2025
 06:00:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829192243.678079-1-ojeda@kernel.org> <20250829192243.678079-2-ojeda@kernel.org>
 <DCFR8DTO39D2.1RMIDS2RUJ3H9@nvidia.com>
In-Reply-To: <DCFR8DTO39D2.1RMIDS2RUJ3H9@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 30 Aug 2025 15:00:27 +0200
X-Gm-Features: Ac12FXzGX7FXGSzot6iEYVQnSG3OajW9Y-2Vb2BYM5xN_BpYVdypT8X5l2h2PVs
Message-ID: <CANiq72ms=aqiSm2owBqTbviJVk35CMKQZ6G0XmeR7-0fajxjqg@mail.gmail.com>
Subject: Re: [PATCH 1/3] rust: error: improve `Error::from_errno` documentation
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 2:18=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> Small nit: this leaves a tiny chance of misunderstanding that this
> function actually expects literal negative integers. How about using
> e.g. `bindings::EPERM` instead of `-1`?

Sounds good -- or perhaps `EPERM.to_errno()`?

Thanks!

Cheers,
Miguel

