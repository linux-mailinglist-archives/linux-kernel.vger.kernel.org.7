Return-Path: <linux-kernel+bounces-729185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E646FB032E6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 22:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCD49173276
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 20:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96242882B7;
	Sun, 13 Jul 2025 20:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMQQrEDU"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9574433B1;
	Sun, 13 Jul 2025 20:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752438811; cv=none; b=POt7Y8VrwEqzylnulpV9JMCoEmM6fC6rBEFK5mMNCP3IazbLOXUILMN10JCjjA5BfWeQ/F1XDq9+SPbFozd4HDnW9lnqRsrfyjrvjo/QXDzjimJgbzVvkGz7tlWLJylFPrWp3K63JDFGfk4TPZQWPIWAOYZW453C5SNPV/K97h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752438811; c=relaxed/simple;
	bh=eNybOlOjr8DPWy8LlnwAKg9mJA41tZqOkcZnaUXKeZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMO3yFB2HDvQxj++zFW6N8/8Db4EXK+DEF6GbFsZaHbH3OIh4K2rHL7M5z7cHIHJZ3fXP+ZElJgs4YG436NzJKGm6legvuAT00RjCwwtw++vtSrV1HMArtBLmCNehN/leQZEe/BVjOY3Euqt7ECtKuDWclEkeEyqMMIEV1ocyxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMQQrEDU; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3138e64fc73so975487a91.2;
        Sun, 13 Jul 2025 13:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752438809; x=1753043609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gyy+jDvsccHtl7cJTjnZC+i5et/tj0aZYQWq9uO/b+0=;
        b=BMQQrEDUCEG1IVlouMBeDRyqTmOJC9DwSUWEF65hm2y+Hunsypjs6AuUvv+zFlY3lY
         gWpwXGgQu95PcnsJajRjRZFYZgysnV0pB1FNeMelSwDAV0PkBRsJXxa+s1Q1VeXnT9FI
         A39HGrYsvZ5zGIkQIUdnaCjFe4K3jTQyghpPrUugpxdZKwHQm+frL5f4ck9CgPCCnc5j
         DF/Ib1EQStwVBc+kobdSp8UtuLYHysmE+GbAokwDmI4zLVf6CeuRGhuaSeuRb6YeYSoE
         7tivWWBU7E5a+sk5Humnt6yU/oOBj8PH9weB1g2VLQ5/kiXLKQ78z1mLAXfVF2bGid50
         bo5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752438809; x=1753043609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gyy+jDvsccHtl7cJTjnZC+i5et/tj0aZYQWq9uO/b+0=;
        b=XuhCtw+97lXfwaqJk0Shxi8mJ2mg4oGmmDKv7SDguAVJpqQ+bWxrYEkPRpHPf1HTDW
         5HP4CZ7jktxD6vBZ03v0dJU2mAZ2WPEra945iynrc74XXvo4e4xAPRV9jMkEl6seHnkx
         KwrB682KguH5Pid9kUCSW+wcNPXC79VfFxeR9i3Qb0vAcupfiXjnfUDz/JVu8hsFQ8v1
         z8ykIDbILncnMh7sKb6Mouow1fmvoB85qJYnTHJHqKkzzESz5EQ5AgzF4/VQFv4dnHy1
         rvgk4LhKziEv38Zp6ja9yO8IEJlKIPp5YviQsGomWSjPIa9noCwcslCBNzjjJIlbOgF9
         fPfA==
X-Forwarded-Encrypted: i=1; AJvYcCVQczSMve+00nzZL8c/UpvpEvG8OCTmW0VNPQn5e1UbaVS3o3QFyCXNFMK8Xb2mcpG7+vZXsTMrCIKXuDDfWgw=@vger.kernel.org, AJvYcCWB8GQfjDmc1LRt80qWpnSuPvjIrskNZnbO6gfKO+Jy8D82nKU7PsLVJn40cCFC+s0D44aQpbB2C0TvRug=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPwKxJ/mn+r74tXPaz+Ictq0q1KsEVamw0ktq2oUQcgE/6k+7O
	8CxoKXa6P3EIHJ9CWqgCMY3qs3r2HXRbdBlT6OxjWqpBWzTwkuJbQux1hYOmGK/7FihxsPH8QRJ
	FREHk852e+XT2aPYrNMfavANrnxwdUvI=
X-Gm-Gg: ASbGncvboePpIhi92akQ9XQdToi3hk+aa/xTvNNg5JhG5MCdz4nRRrmHHAPv9JL6rpb
	aby6qioTtALcu0l6/j7tsOlMHhDHaOoTtySbh2FVDgw08rVHALi4iPQJI5Ug3jveNJpGs2U+lUp
	UAYJ4TBprYK5isepi8kWc1ISWxQcpAu5mKDpRO0NFqL2bjcxCUMtciE/NpL1aOwdpSEd0+94skY
	u/z8maH6Ptty7bxfW0=
X-Google-Smtp-Source: AGHT+IFMSmrRW7cXIlO7WhhiGzrkbfgh8C5RDTODYaU4IftiNR6oQ2o6rbML1f8VLxTbAk1sjM2hwHzcpji0gzHvRxQ=
X-Received: by 2002:a17:90b:2747:b0:314:29ff:6845 with SMTP id
 98e67ed59e1d1-31c4cce3657mr6405616a91.4.1752438808944; Sun, 13 Jul 2025
 13:33:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-init-remove-old-workaround-v2-0-a3b1be8fd490@gmail.com> <20250709-init-remove-old-workaround-v2-2-a3b1be8fd490@gmail.com>
In-Reply-To: <20250709-init-remove-old-workaround-v2-2-a3b1be8fd490@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 13 Jul 2025 22:33:15 +0200
X-Gm-Features: Ac12FXwv7qE2pMGrr5xCj5gCnxnFRl2n9SHLsNY0OoTyUtjCI8uB0OXPC3--_UE
Message-ID: <CANiq72=6n0+uLJ-2_LGKW08r-uVKGbdkofoC09xHwfbwDsRzNQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: init: remove old workaround
To: Tamir Duberstein <tamird@gmail.com>
Cc: Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 12:49=E2=80=AFAM Tamir Duberstein <tamird@gmail.com=
> wrote:
>
> `Error::from_errno` is `pub` since commit 5ed147473458 ("rust: error:
> make conversion functions public"), thus remove this workaround which is
> no longer needed.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

This seems the same as this one applied a few weeks ago:

    https://lore.kernel.org/rust-for-linux/20250526152914.2453949-2-ojeda@k=
ernel.org/

Cheers,
Miguel

