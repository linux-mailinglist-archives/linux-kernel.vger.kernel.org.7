Return-Path: <linux-kernel+bounces-782668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A17B32363
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B1AB082BF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63762D738F;
	Fri, 22 Aug 2025 20:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzFBg8ph"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3AD28726F;
	Fri, 22 Aug 2025 20:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755893323; cv=none; b=bsQf/ZufDmKl3NGnxURY/a9H2yz+aBiu1WgSukmnWUTfBpqx1ZpaLMr4sr/6VN5so+GqZ2RtYABcvh/U9P1iO9wrz6P9jn9SdnqOeTfYE5PAXufAm6B93+DV4sV8ZSNpTlGSadkEfr6aUuUWd75Szcwozs5Zbfa3OCRrMmorOgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755893323; c=relaxed/simple;
	bh=kcWH8At3XsuwMQuBllx2sYdu3LXXHPZRwLzgueFcJj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yvp+hTAB7c9ArGoEH/m6nubQ1zFmfmDKDsnZxZB+TCFzVKHvjhE+RvmCflbn4mN2QBGvk6ZRNgd29ZosXNXNaeyPQ4MD30Eni5CzBnNRAPNH1cQ1XppEvIotMCVvlGzWKyWvElpIBPJQyr8rafP7qv5DH/63wEaMmxt0Npzwzuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzFBg8ph; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77030079854so139323b3a.2;
        Fri, 22 Aug 2025 13:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755893321; x=1756498121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A64V3WFx8DOv57ADN25EluBt/3jj5eOB8nLgBpqNI3A=;
        b=dzFBg8pheKdu1s9VvFhrgAQVq3gnlQ1VDfVXO7AAWxiyLCpJCe+pqBi78BFBVKzfZi
         IAnSVqNaYCGzsKG9FsBtXqtr7PFS0lyMZO5KOyEZp9/woQg3qRU5npRBAYRYSiWYM87K
         kQoRYtow8cBdQ8+jUjwLVEBX+liEaSWAvYHSJzzZrGQCVT2FcTUffeDbLXfIJ5Uzzv+R
         w8nYDDB7daamPgionrBpL1jB8WdfTdapbqdirpftVSJMiWVFGJh6MSBoy/kiV9PF0WQI
         j5MUWxvo2YJzqypdXD02CQD2d+4HiqwWZ5EvCqrW0DVEQC7FDuXbrCiY7iJ58dpnCTAj
         LO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755893321; x=1756498121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A64V3WFx8DOv57ADN25EluBt/3jj5eOB8nLgBpqNI3A=;
        b=n8Oq1hCDA1+3ldYWMhDunhkYROyDwFWGEelD1tm87C3YuTdo3I9ARmUPm3+OVekFsk
         j4+f4jW1DAuMRoL40J8xFXgf0e0D3by0tn2hcmvsgl/GL6Qg6M+2l2WhHW3lvj343Pi/
         QTTgsP3KIaWjo4/zSKxkowA+zYTFenws9DcHiW0w8IeSvO+M3vwFO3SURB2BNnFcUux0
         WKEMx3zPODCxMd9IVnF6DK2/rnW3SRf+QbR7wbqerrn+WqjKMZxi/odWqM6+WeuUKmuW
         0J2r8JTSiltE0Z4ROTVQisibB5uSJ+P5++iGPTR1zM2oK+jWyEsrBNEfQTWewOH1c6jA
         SFTw==
X-Forwarded-Encrypted: i=1; AJvYcCUMCSEHLji13TFo0leHdwKl/pdMJHPQ68G4YSAUuAk7+41FyP/D5YIft371FOyLoer72B+AJLtsQBOAYJQ=@vger.kernel.org, AJvYcCX7Dt12PqeN6xD8qne477csrOEG58MTPB8Fm6+MVtdFnRK8lCPgw8Gp8PhvFwmB5m6392j2hvuw5FhGVcF0Ugw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYixHsCKXWiK1z20PfSJPBb0pPKmQmJTo/2YpG7b+Uh65PFMgZ
	pRAz6yB6qRjkyfk5gIjynTNf7sudYQtU8AcgXJ+3U+PkVAN6be3QASCXZwgGz9Cmm7CNR/9G2M4
	5mdYrbq/wkXw0OUpePCXjBhBxXGz/ihU=
X-Gm-Gg: ASbGncs1qFvtvDIxf1ZicpZQdhPU0Zruc8b75amPN9IPWeGwQ3B5UI2NtkK/B081l+b
	BQaA6Jkfozxjl/tbomllSSGSz6iZ+LVbaa8nbCZ7f44mTHWkDjrnnQwC6vWtdiDDY6KHBJ/IKVb
	5auh8jwbQ77/2uyg79mX5Y6HasgC5gUn26Kt7nHSBPk/SKs1aA+Y6RYjpz+SVZhJ/n5RBO0+91z
	13eME2L7emuZAkg5ADkl8Gzq4AIPNrl2lxFu3VpApWlRxD2Jv8vF8sbBcRgoqbUJ00po72FYSqb
	9YYeD4DjadfLssyzzWreEBtq4w==
X-Google-Smtp-Source: AGHT+IGDXUpwhHcoqNE2jOVISXRAz6TT/o/sRxggefFveEMIvbakTVfQ+++qCEzLjfyaGrE3/h7nj7fv7zOiG/JZC+w=
X-Received: by 2002:a17:902:e78f:b0:240:4d65:508f with SMTP id
 d9443c01a7336-2462ef99564mr28783925ad.6.1755893321256; Fri, 22 Aug 2025
 13:08:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811213851.65644-1-christiansantoslima21@gmail.com>
 <DC0INEKNZPSE.WLEQH24SLW1I@nvidia.com> <5204b598-7792-460b-bec2-e3a4a4c7e32d@gmail.com>
 <DC5INTQKY0EX.1T4HD6OU8C4PI@nvidia.com> <CABm2a9cyvsXd1OS+tvDoDDEfMgBOJeetBVQU0x3m5E1vV1CApw@mail.gmail.com>
 <DC828042PKDV.16NDVKIGBNTJH@nvidia.com> <CANiq72kDUK0nScg+nK-M2U=MmxTmhayyRUv7n4E3UMQHr8RLQg@mail.gmail.com>
 <DC8MK2TAQ5D7.GHE5F2OREOD7@nvidia.com> <CANiq72mWYBAQYj_kWc+6XxrPVzguOd1vUB9f5JXzYdNx9EoXyw@mail.gmail.com>
 <DC906GRT9ESF.2ZV7RUZR0XZEK@nvidia.com>
In-Reply-To: <DC906GRT9ESF.2ZV7RUZR0XZEK@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 22 Aug 2025 22:08:29 +0200
X-Gm-Features: Ac12FXxiBkhuswwDZMdnMbgm7l8Q0QI9OycBEp6n-ZH1Po5dOnIygeQLegcv8wU
Message-ID: <CANiq72k4qgwDrAUmJWb1=P5HHZzKRoWQjVUuu=k9f5vMd5AUuw@mail.gmail.com>
Subject: Re: [PATCH v9] rust: transmute: Add methods for FromBytes trait
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Christian <christiansantoslima21@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ~lkcamp/patches@lists.sr.ht, 
	richard120310@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 3:50=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> Strangely though, even after enabling the feature, I am still occasionall=
y getting this warning:
>
>   CLIPPY L rust/kernel.o
> warning: current MSRV (Minimum Supported Rust Version) is `1.78.0` but th=
is item is stable since `1.79.0`

Yeah, that one is a downside of the MSRV config -- please just allow it loc=
ally.

I hope we don't need more than a couple of those (we only had a case
elsewhere so far), and we will increase the minimum in the coming
months, so e.g. this one would go away. If it becomes too painful, I
will just disable it temporarily.

Thanks!

Cheers,
Miguel

