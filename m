Return-Path: <linux-kernel+bounces-793572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 482E4B3D55C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 23:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D49723AAABB
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 21:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055A523F26A;
	Sun, 31 Aug 2025 21:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyuHAnBM"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134A4224AF3;
	Sun, 31 Aug 2025 21:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756676399; cv=none; b=FsonE2jRJumTbT+zXWJU2/cFBig34N4JUb4g4Blig2h2tnCSg2cIpwbP+jL/92mMZW4KzNsqr1u2z5k46jzOfBFjvuhyEvbOd72atzR7DdfIe5t5ByAOVE2N9TGTsEWwWFXhrjv9zq9GDnLhsV0DtO7l+4Qi/DuUP/ZS9IGWR6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756676399; c=relaxed/simple;
	bh=HXK1mxtvnM+f5NSrDg17S6f0AjUq3s2kPy4/VmXyLPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=accYmeuK7JyCX8lYGVjPOygEcX+7Yl+8zut3YvXjRJBty/OS+8ONVdgI+dZTJ9fOlvoAZJ3Knb9Ca3IywYjpkrw+VFvzgdhGMuvvE6D1qywcPozK/ONl3pb41ioW2W27sK5MLPBXWM5GbHJmlHDDQH8CH8hA0rUCf16BLSz7Yrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyuHAnBM; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24602f6d8b6so9065305ad.1;
        Sun, 31 Aug 2025 14:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756676397; x=1757281197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Edmamns6ZCKkIL1JrUvunq2gZzEQTzybUOvV7LUz7LQ=;
        b=jyuHAnBMAjOckOM/Dbk1iGskJMzSpuxA83NngsAq3ntjBbHL2MMk3lABwsRIKD244Z
         D4Vt3xbp4VM38bKm4U5RlI+kZRTZtOMweP/6AtjSy0oyuGqxHhJ2ICf5i9R8AJfYd39w
         l/bbRQzxagpyjYpNCa8OmjNvWyzJI/PXYJkaLeR0P8dtZDAdvBUScdSzkVG/bLEGA4k1
         JuwVW8LG2TZJpKIVUVUdYfcZIR7jynVYp3S194RhYuFACiUKIq6DVch+2HshOrRvDpcf
         c3WZWm8dbR7PUmnYkJ2ENtwmFdmfN5atsjeJ/bihLRQv9XecFkjenkwBzL8aS8sWBiVj
         qc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756676397; x=1757281197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Edmamns6ZCKkIL1JrUvunq2gZzEQTzybUOvV7LUz7LQ=;
        b=INxXr/xngtLce7XbZNYY85TcrEhcKQK0rsT4xkz6hrEzoal1WWEaD+4jJppHESvqB2
         LteWp6nwuPS33fmxGXFLDJoeg1YCkitkYSvUGW7prz9NmFW/iAhZnOJrRKkZ1wlP+iAn
         U+4Wiwekp8j5R0Vts9bK0owsaiSjhpHQF1znKtsIcJURcajShsCMvbti7PqzLUmEmWw1
         uQ4JCB7nrQ1l95LtoeiszNiMkzRySjwCm6JrgZgZJmrtbZKj3nOM4e2u2xd0bBq5OwUf
         uM0acrQf843wXNElyZ8Z0gR98kX/U16vrXwDQ6V4SKlpnWJ9pFApj6K8wdcjsIarqsGu
         IMoA==
X-Forwarded-Encrypted: i=1; AJvYcCUweNsM8TZsFH9/y7NUKHcT90ePWozXiTSzShXGadWItFAqLKlqH9VzpfjjsLG/tQ79RbFCGokSgoUfTVVlksk=@vger.kernel.org, AJvYcCV0wGTOAopasjnpBjB+w8peMaQfzDwVegltQm1PH+opxHV8AjzzVP4GTv/QWCs5ztHQkozq0GUj3WCs0kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNqVzMOyxHUXrwIylqIunOCoXaYbNr1GdCMZlSN6bXmQvZqxzo
	V1vn9aqhiWcuGcvzIVPMYcPsAx6lOc44BejPEYm/eEQWHRJkeU8OWnZA7Ot+Tm+qy8ZbtUp0niC
	PRPMeEopYCx2xb2En3WaalblLAq22KFyKt/QVAn6yfg==
X-Gm-Gg: ASbGncvglbYm38s879fAt7YgyVdKEhv+d+3qwhGgiJaE5CfZ2lODlSBdTAPc9DNZ9F2
	9IRMnOIO40Sk/edP2/p0rFIvsdwmbv/HpXiZleGEUSVCrhE5mE06+7L1KMRJ1tFoIKMktaykrF1
	tBs9uBFqXatpe79OtE8rEYSeJH9r8B3hWZhxsP7AR1MyMT0p1+CO2PfiMHH/X108jYCdPfR8ATr
	0zUu5xsmxwPMxi13rP82yLBRVDVKMTFRJjS4+fopnN8VSzjKMLtryo7SgY3YLrj1N0lgoB77p73
	Lfmtgg36+7K5zCeXJdhbEeHr7g==
X-Google-Smtp-Source: AGHT+IFU7QKb5d4h5yBn51TloshpbzipGmSxJWSZMaQZRvQ7NIn0gMWe/YXpQtEM+jJ3sF0J9U4BnEqP4qnffgmHT8M=
X-Received: by 2002:a17:903:186:b0:248:9afa:7bc3 with SMTP id
 d9443c01a7336-2491f246dc8mr55338015ad.8.1756676397269; Sun, 31 Aug 2025
 14:39:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827-file_as_c_str-v1-1-d3f5a3916a9c@google.com>
In-Reply-To: <20250827-file_as_c_str-v1-1-d3f5a3916a9c@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 31 Aug 2025 23:39:45 +0200
X-Gm-Features: Ac12FXwi68ejMP6rZlbFWj5czPxYgWpEG1TbtHfL7vIuuMitNsE9sZ_OM8stz0Q
Message-ID: <CANiq72=8cu5+d8K7DBM1-o3t6auQmd_qq9FxiDKemqwWynWx=w@mail.gmail.com>
Subject: Re: [PATCH] rust: use the new name Location::file_as_c_str() in rustc 1.91.0+
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 3:12=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> As part of the stabilization of Location::file_with_nul(), it was
> brought up that the with_nul() suffix usually means something else in
> Rust APIs, so the API is being renamed prior to stabilization. Thus,
> adjust Linux to use the new name on new rustc versions.
>
> Link: https://www.github.com/rust-lang/rust/pull/145928 [1]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Applied to `rust-fixes` -- thanks everyone!

    [ Kept `cfg` separation. Reworded slightly. - Miguel ]

Cheers,
Miguel

