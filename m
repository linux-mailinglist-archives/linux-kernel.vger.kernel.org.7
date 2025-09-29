Return-Path: <linux-kernel+bounces-836090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AC3BA8B1F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CAB93AD21C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F942C3242;
	Mon, 29 Sep 2025 09:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V2Q2hkXv"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CB72C2361
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138733; cv=none; b=gmJfkKpKBBgchGV7J1qpCyLUBeQfrUtp4dtRHy0Z+HMMYgXH0gtnRMF+BfjUJs23TMOSh48z0oiZKI7zKgu7NlHtm77NwH7nDlU7E3TIl0v04KIqEYlFpGKx0d3OLgc2v/ITTelXLhIzCEwYaAXuI1J8MZHLuOtRhbRPnT9ZnoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138733; c=relaxed/simple;
	bh=5uH+LvoEI4iHG7AuV+rb+aBRzn1IhYD1uxOjR0lBqs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jDrKaAboZS+3H4UJ3pKZoTQlb2T11ab97NgCLKR+xghAsLUN2qX8XJypItv0cmuwy8JMzElfGYV1f2UVd3FSYqiV3J8QoSwG5gOgzITvzIZyjoVEYPGOOu1LqGcl4mAU/w5GZS/OStKfFlJkGRWI0isy+qWUculJZDYHp39If4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V2Q2hkXv; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3fa528f127fso3423667f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759138729; x=1759743529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmXRL3+AOO5eD+C5xVvr3oBjtZLeMgi3gjCsnw2jQz0=;
        b=V2Q2hkXvYyBllAwmRscSDMMjNk7F0Y5KM/y+CZ+4goC0JSnOKX06H/LhLmowhz3F0i
         kOK0L+6D+LDu+dLJgorPzvmeogQ1O8KxlPTPMcdd5SaoqkEc93vc6jwTGb9ukj4Rxdgw
         VxMeUjiHc3ev5F05XENESfFQv0TNbLnrMbgCxHvoVhmMRSeE1FiFTUDJ9/7hiMIQa09r
         xkNuEbVWKoIv51scyOnJnZOAo6lBjj9nALR1QY2qQ9yBJndicacY6KEhk7+PTZqjAD8F
         DCw1+LcPSge3ataFUxlszVka3VeobOPusCG5WOmZUr4x2qM9FLO+DLQgcEtzfTqrhc2r
         t47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759138729; x=1759743529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KmXRL3+AOO5eD+C5xVvr3oBjtZLeMgi3gjCsnw2jQz0=;
        b=nAr/2Mq6pHme7BBEaykfXsxM+5fjFEjcwhLBwfVDa8lb3YXYCMqdXzryH0gx8Pl+5y
         hcIuuMeUv+9k33m51yfuvWFEFV6xuoNqmQjJ8np0WoYHLvSCuw1jz0vCD3sceI4SQUAT
         w3oRDSiGTWui20pKplgYWZ5F1z0XUGQZRL3WUT69Kjk5Ex1p7zuSWS2YuCsV4i9YzzSF
         hBNd2VCEXYhHLTu9pOcDN7x0BKmRizGvZvptPFvThqF52NZJjbbSZI86oG9iDy0RQ7mq
         4/T9XtvcCYDfPhM2HAQxKoX6aWbH5kyQKH0UMMVemDnj1R8H8/6nwss0L5MOvw7e9ncc
         asEw==
X-Forwarded-Encrypted: i=1; AJvYcCW4UlwLOMStil7U4+A0dq5p6ZSP5d4JFmsae8Ddo9TUZKdKcB7GqAWlEtVMYVkgHykNoopJZBihOHKJK6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4vq9/vH9b1sXPTf6NlM+EdhYm6DMcjQ4YyhDnkGiHaM1W9lcj
	MH7D2W7JTlqUhgsufKd5PnCBOROtmeoT5xX7RlnQNVxYuf9ENufQnKmrGPyjd6SzLfSN2/nM6c5
	BbBQVTzCipLxEOefug5G919cR5RW1E+dR9YvCKhNA
X-Gm-Gg: ASbGncsV71/KNQlg/MsSObPOnBB5EXn7nnDhISnNo8AyA3kzEhMUr909tzcfjAcqflt
	I9ktuBY7t9iRAI/Fo+8/S2ErhKD3PnXKjgacG9OwVLW7S1nul+8AfrxB+NbeyslobF39UAXbPN7
	Fi/ZnlgZkR/wpB8qNb/Qt4p13LwU+HpJ+oSury9C1Byfug8SdrC0Pze5P1cBGjvlT8EtFMINVSQ
	o2fjkQ98aAE+aB52674XUTriSyqEtJDIUccRvrIMbIv56YwaNtzFHQ=
X-Google-Smtp-Source: AGHT+IF16DgZ+7ywtMeiLQa1MSZI2VtZgG+RmJTTzTn+yGI5kYhoC8WlQLJ4KboLi6SkD1Ym3CdKdkNwNyav2sERmuI=
X-Received: by 2002:a05:6000:40c8:b0:3ec:db88:bf1 with SMTP id
 ffacd0b85a97d-418005f50dfmr6649437f8f.12.1759138729294; Mon, 29 Sep 2025
 02:38:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915135954.2329723-2-thorsten.blum@linux.dev>
In-Reply-To: <20250915135954.2329723-2-thorsten.blum@linux.dev>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 29 Sep 2025 11:38:37 +0200
X-Gm-Features: AS18NWCtoSpHr44rzHyKkTO58WExQSeh2zI_DEs-0RDMqj1GhpnInyuLbAY2TzQ
Message-ID: <CAH5fLgg0_NBtfVMNBwXOe4BpyUKz_S=v0CiDxyKNYZcS9j7WHw@mail.gmail.com>
Subject: Re: [PATCH] rust: cpufreq: streamline find_supply_names
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 4:01=E2=80=AFPM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> Remove local variables from find_supply_names() and use .and_then() with
> the more concise kernel::kvec![] macro, instead of KVec::with_capacity()
> followed by .push() and Some().
>
> No functional changes intended.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/cpufreq/rcpufreq_dt.rs | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt=
.rs
> index 7e1fbf9a091f..224d063c7cec 100644
> --- a/drivers/cpufreq/rcpufreq_dt.rs
> +++ b/drivers/cpufreq/rcpufreq_dt.rs
> @@ -28,15 +28,11 @@ fn find_supply_name_exact(dev: &Device, name: &str) -=
> Option<CString> {
>  /// Finds supply name for the CPU from DT.
>  fn find_supply_names(dev: &Device, cpu: cpu::CpuId) -> Option<KVec<CStri=
ng>> {
>      // Try "cpu0" for older DTs, fallback to "cpu".
> -    let name =3D (cpu.as_u32() =3D=3D 0)
> +    (cpu.as_u32() =3D=3D 0)
>          .then(|| find_supply_name_exact(dev, "cpu0"))
>          .flatten()
> -        .or_else(|| find_supply_name_exact(dev, "cpu"))?;
> -
> -    let mut list =3D KVec::with_capacity(1, GFP_KERNEL).ok()?;
> -    list.push(name, GFP_KERNEL).ok()?;
> -
> -    Some(list)
> +        .or_else(|| find_supply_name_exact(dev, "cpu"))
> +        .and_then(|name| kernel::kvec![name].ok())

This is a pre-existing issue, but ... this treats allocation failure
and non-existence the same way. That sounds wrong.

Alice

