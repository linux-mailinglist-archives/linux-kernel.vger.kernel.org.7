Return-Path: <linux-kernel+bounces-752020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4FFB17078
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90AA9A818B8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A232C08DA;
	Thu, 31 Jul 2025 11:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRBZu7aZ"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7632288F9;
	Thu, 31 Jul 2025 11:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753962179; cv=none; b=L15W4cNCpQLeXv9lXZ8xQA1De6ZQoMbxfJot2B7v8nzE1yzsC9Ke4LfM8OIZHnouk3R+67sd5Hzl5oN1t3oGuNsGpTKkGvsoRa4ZVdVPQ4pgE1JcMaJctx5cb3zgh1wCx28NY1EAsKAhJxBniOWrLCu39IsXRIEdaO/9P4lLQAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753962179; c=relaxed/simple;
	bh=uJcxgHp4I/KSbQ5ImVQRvUoAo9jt4x8yg7evAxKAYNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aa3Q61FEa3VjQQHjBBCpNbEWZyXf0IskoR2lYX68GVAOuF3ApEKji9hsL4DWREri7omX+H4DM7vtJcj5IoVMqIcdhQma2FUBRzxXOVSkn1vWZRL7u6KR9sLPh+ePeOfx7BEt+kmfT9COFZc00ZBQSM/otTyLFfxE7waOxOQnaPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRBZu7aZ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b3f2ea2f96fso100663a12.0;
        Thu, 31 Jul 2025 04:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753962177; x=1754566977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJcxgHp4I/KSbQ5ImVQRvUoAo9jt4x8yg7evAxKAYNo=;
        b=QRBZu7aZvMl4NtIuTgPS5wV56+VreTpPQD/pl9bsLWVVZvImo7s2qo8jBfETkf8CLE
         F6EQP8FmgqWHsqXZ/ELAdW9dfelFlA2tlp0ZHz6RywFzd447ZdpTfs4YZvzbhAfvPJNx
         wX5r37fKX4LxoJi1NP1/U0WZNa+55a5/bHggbmk9t8/oVlS5eaUN/1FlRgEL4LZ/bR24
         HovJB727qGzqqBEir6MIbbh/3UPKzxE1SHy5UnfkdL4Na+x5tbMoQz+8wAQIBzWaxMLT
         fOXKGNB7C1XPVrfb7PbyKnNGXvDtJS+LIi6aFsUxA3BMuuDcfZ6Nn/sWDJ6SLyTHJadi
         WMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753962177; x=1754566977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJcxgHp4I/KSbQ5ImVQRvUoAo9jt4x8yg7evAxKAYNo=;
        b=qvwsxCOs/rtRGcFPPRy5MeDNbzO801qEiNjpvqBOmFJK/AWGGDmHOUBJZ8yfb11FIJ
         Bx0IgT7TzENhBx2zkX3enHEBjWKr99F/91Gm2oDgog5Tjkw0vwq8L5HOcxlziDi1QReR
         yh7pGv3/ca6YfakcxZGgEo5sKEX8pYMjMjJQCo5bebRiyXSA3Tuk8Ty25NSmgHATQ5W1
         7osyKEpnrcuScRsL+8waUlhvG/X4HwbxuUcnM5SAlfrDd6jsYj0rm2SmAbBKdMPMEZVW
         7tPEMBQy4/TJlwN7DLMzMZCogtpdiwJs9KORbG6v2kpGP0g1RIoWZflz996q02jNsCiB
         TKyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcKd15hW7gE0dgCNLtgfqyyLZXVZzS5iCZn5r+J14WdwObtZoVKYJyu+DmeahbhCgG0XdrdfkgdYxvKyg=@vger.kernel.org, AJvYcCVpSGjOlPd3ffI/bBW3cBo9n6khDKj76YiXgkulMH/h88eedXbsVGIrrZaKA5txs7u+qy5QvHYJEBMWtwp/YY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAkd9pQnn7fvs77h98sXx6DrZc7UvHrmC+ClzsQ+0WHHyOd9eY
	GO8f+2WFeyn2ZV8HQwnFkjhtnpY7HfJpbrChNVFRy9woYaByCXU4cF0zDVEL41ZWTX+eR0e/O6q
	MxIt3wrIc74iqUTR8fKIU2pjm2IoN7DA=
X-Gm-Gg: ASbGncuGfxVsJyo5AaFkZ5u7jTBfFrBaWVETozeqrEMmLcgHRtmfEF6CZ8HnvCkYl66
	vO0kgdCBxNYq2GmQREF1gE5UE9RY2fJRIxld/YDEZ+ZyawTRmofFSb6nJHAzRwNR7CGBGdukG7c
	iAIUiurhfgGnXClbM/YCxfH56oYE0L+u3WXrQ6DwKE8X8G2nVqD9rS3kvL+vJghGNt6S9AjQQPM
	Cl4TJGaF718H/nRDIQ=
X-Google-Smtp-Source: AGHT+IHEhL8joW012BHO7UBetDbUpSR/OY0S6s97KX3tyJ2K+h9TLb6vbFDNYa0BuFGuutfhOB+IhHAL4tZzfbpoWFw=
X-Received: by 2002:a17:90b:3b46:b0:312:e9d:3fff with SMTP id
 98e67ed59e1d1-31f5ddb2067mr425912a91.1.1753962177205; Thu, 31 Jul 2025
 04:42:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731111234.28602-1-ritvikfoss@gmail.com>
In-Reply-To: <20250731111234.28602-1-ritvikfoss@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 31 Jul 2025 13:42:42 +0200
X-Gm-Features: Ac12FXyp9Hf-Bk1fW4nSupn8K17tKgnpR0B4rmx-XGmWJe5oOjZh7XdhBOINriY
Message-ID: <CANiq72nDY_ZOk7=1MX3RQqzscaXayAm2XkaeQ0UTke-kdy1fnA@mail.gmail.com>
Subject: Re: [PATCH v3] rust: kernel: introduce `unsafe_precondition_assert!` macro
To: Ritvik Gupta <ritvikfoss@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, skhan@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 1:12=E2=80=AFPM Ritvik Gupta <ritvikfoss@gmail.com>=
 wrote:
>
> +/// /// - `buf` must be non-null.
> +/// /// - `buf` must be 16-byte aligned.

We don't know since the full body is not shown, but it is likely this
would need to also be a valid pointer, i.e. it may be an uncommon
example.

Perhaps we could show one of the conditional cases, i.e. the "if `buf`
is non-null, then it must be valid." cases. That could also be a nice
excuse to also introduce an `implies()` function if an example allows
for it. But we can do that later on, no worries.

More importantly, could we have a user of the macro introduced in a
second patch so that it gets already used?

Thanks for the patch!

Cheers,
Miguel

