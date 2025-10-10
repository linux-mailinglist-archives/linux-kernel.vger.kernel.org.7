Return-Path: <linux-kernel+bounces-848255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 750E7BCD041
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9ABE3BC53E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 13:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63822EF677;
	Fri, 10 Oct 2025 13:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfTL8JbQ"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF251C5F27
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760101491; cv=none; b=mlnGciBXirzLj62BPpgHgIcuOV0JZhqJk4aHKSZ++q9gtRcAiB91vhahMA2kw0FyRlRrcAchGmxQZN93epmuOlR7LR7LbBMYtgqU1nwZGhseAvAC1LnJEKpLtR3gQyUwWoFdTiaCqlBEL6ZyiXM4j9auMq4xjgA5i5YUDn0rIjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760101491; c=relaxed/simple;
	bh=fZsy0sd/tS20msY1KlPWxCXhCRLHUme+WfSUdIbiGeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qRn2GdKvBSyh1hgzDyiwgP54UYFrVNo+nS1PtEwPyxyQeGxRevRjNOCZIwG83GrbCIhup8A2zzwnTZIdWwHix8Gcio8MuFjxnitih5RTjGspBuZTY/p/bIwRioIcLl7eQm/DDyaUK9ZbPm41Qfg3WXudmBqeQ97SojB6Q2J9J44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfTL8JbQ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-26816246a0aso3275435ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 06:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760101489; x=1760706289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZsy0sd/tS20msY1KlPWxCXhCRLHUme+WfSUdIbiGeU=;
        b=jfTL8JbQ2TnrNYmvD2h5m/OLa3Yhitw3/jc0ubut2bOkUm4NZ5+uu9fpgvQl6AHncb
         AeHaGlNZk4A2mkOSH0tTlZV00+CfdVnltmJadXHv0FmTkXoq2Cje/sbrzFfzqTCTTnpN
         w0g5BZZBTd9b69/a5qlVTes3XWWmHeVq+j+dw5wtN0sylxUo46PiSFxWfPLBkKlzFF02
         NwD249OcaQopVPMi7wILBcojsFSFcKg6L6E0fxBx4S3lulvg/aPYstrC7ZcKOVRNyKB1
         0QRrbJjIamlz7pDVWvEKmSqebmGi7skpR2Nfua0ivlkjB1yLgqMSKMU3Zx010igUSHCW
         uYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760101489; x=1760706289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZsy0sd/tS20msY1KlPWxCXhCRLHUme+WfSUdIbiGeU=;
        b=rBg6cyIhgkiqH8YjQ1bzu2sXTaT4WGLqmXy19YDACi8MJ5nKO/Kt6eAAz8/jvvm35S
         XtrfL/01H7RWsWvM6lmXhQFlFK60W/Da/FkqGKh/WjCHIrcLYlxD8ruVC+FBaLTdxdRt
         NtTkNRIyOeEDl1saACjAWyP4jgsJVPti3SmD0HpEKBkodiKSc3ygoBrHJ9aRzb2IvZC7
         XYGvTnaYOsaD31Z9JYd8TM3L6OtIpl2QxX3IoguBNPmWXzRCOCeALwK3k5HmiUdScbCI
         qc4QfuQJGC+BTIxbqUIErn/0NTz8P6X7bgHnwN3S1+iNhSeD4hFXkVqyxdJDn/V/IYDk
         NUew==
X-Forwarded-Encrypted: i=1; AJvYcCVW8cFwkhR37lglY/vxa7smxSs8058jQuGbBC7AIP/8/0CssAY00dyS3kV4qoNKPSD6Y2SXY7KQOi32hpY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww9+4mJUdwTBZn6krwpg7rE+Z8/S+yiagXN2hxl/HN33R4JjsF
	EX/zSyAwAbvNo9mlXLCJYOnHZSngHSzUik+TsjxHALbkihGN5r9I9dQXXLW/K/hT+XqgMIn/PEw
	0/Cd4KB8Dfu0HDZbkJNn1mLQjN+fZqJM=
X-Gm-Gg: ASbGncuhFJkzaJ2KdSTtNzXWOJ4miWX2sAzAabs7apOLps+bQUF25kgfBq0N21psoLp
	qNRL5BfkAIEqPf6+s2GgE3sE/yqyeQK5U6GLZNI8eVOy2fhcPwNPUNfsLGOfywcEcEKXt65zECS
	3LdzCXqIEK6RX4DrcL5lSaRUySUF2MM+WnYH5wUcrbGLUBCCA62kHjKxXd1SyOyjdhnJ1R9zsPy
	hvzbJVxoK9JhfxzJT7S0mpTWGCVPQ2zN0KDi9d1WQSG20MsMR6sZ4E349Wo7CDJGCZ/sECQx2hE
	8oTzrs6+Q29Hs5+n8Wrsd7/JPHO+7Cdlt/mwYciZx+4y
X-Google-Smtp-Source: AGHT+IHctbYyDSdEesc3Os/a9pgB+AQdDwE+Ntk73IR/L6Vt/U6ucoy8bCnQDqUIyz26++WUnRY9zE90ykw9QTMNvXM=
X-Received: by 2002:a17:903:2342:b0:275:c066:33dd with SMTP id
 d9443c01a7336-2902745bef8mr75368735ad.10.1760101489019; Fri, 10 Oct 2025
 06:04:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755235180.git.y.j3ms.n@gmail.com> <CANiq72nbERSOWKRUTJ96YYKCDeAoHLBuiVP+XkDUKg7JYkoyiA@mail.gmail.com>
 <CA+tqQ4KG98XcWh3rkAxEOiACSUtPf7KM0Wqh9Af=POgVDHJzzw@mail.gmail.com>
In-Reply-To: <CA+tqQ4KG98XcWh3rkAxEOiACSUtPf7KM0Wqh9Af=POgVDHJzzw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 10 Oct 2025 15:04:35 +0200
X-Gm-Features: AS18NWACc6jJI62ULqH_q_jHKtWGfejkpxt52RfXiBIGzY9GSvEv_f9PahKrFhg
Message-ID: <CANiq72kE89ukxpf3L0_jFOdv51TDtjjj3r=1mjJzdGWJwmAbaQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] rust: add `TryFrom` and `Into` derive macros
To: Jesung Yang <y.j3ms.n@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 12:08=E2=80=AFPM Jesung Yang <y.j3ms.n@gmail.com> w=
rote:
>
> That said, it becomes a bit trickier when dealing with conversions
> between signed and unsigned types, particularly when `u128` and `i128`
> are involved. For example:

Yeah, it is why I said it was a dummy unsigned case -- I didn't mean
that single comparison would work for all cases.

But what case do you think we cannot assert? We can always take the
discriminant and reject whatever inputs (e.g. ranges) we decide, no?
And we know what type we are going into, so we can always decide what
the values to check will be, i.e. we could in principle even support
infallible conversions of the discriminant to other types like, say,
the bounded integers or powers of two.

Maybe the issue is in what you say at "the discriminant value
interpreted as the target type" -- I am not sure what you mean by
"interpreted", i.e. I would think of this as accepting only some bit
patterns, i.e. working with in the discriminant space, not the target
type one.

I may be missing something, but in any case, at the end of the day,
within a proc macro "everything" should be possible one way or another
-- even if we had to inspect manually the literals :) And it seems
worth to remove the pitfall.

If really needed, we can always drop support for certain combinations.
We already do, in the sense that we don't cover every single other
type out there, like the ones I mention above, e.g. `Alignment`. But,
just in case, I assume with that approach you mean skipping some
combinations early (the ones that cannot be checked) and then still
asserting the discriminants, right? Otherwise the caveat is still
there.

Thanks!

Cheers,
Miguel

