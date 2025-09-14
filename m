Return-Path: <linux-kernel+bounces-815923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CB3B56CF6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 01:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FBB217A0BB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 23:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E61245021;
	Sun, 14 Sep 2025 23:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnMJM/rT"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DD510A1E
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 23:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757891972; cv=none; b=aPTWY3Bpa3hsXltU42x0jOjEJ8EesSGrHASBY95MeM7rZBhBBeO77GYoEdqey1/odurI9L+6X8QlG4Jb57VnSu3bOaG8Ac6AIM55ez1zy6T4kPR84ObNuR20lWiZVPYXUSv45CpXRkGFCLO+sbLdcoHSLGcJamVh0P8B1laWw2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757891972; c=relaxed/simple;
	bh=m0I/xnWWzA/0fP8qZdIDb3sUbPySbToI/7+4msNB60s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g8Njx/zJr2tQQs81GCrg8WFUEDAT0XRaLAWS0tuTUmb4hAY6nikZkbBcjXvheppmJ367/OoO949xFe2Sg35XPtrsahpsK1tC0U0r5iyLVWHFnI7fYN01WL+lAwKVdj8POomv5yNne/lB0pZ8YMaoBXZAuHt+8nihVAKpAyn7cYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnMJM/rT; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-262346a67c9so3022775ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 16:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757891970; x=1758496770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0I/xnWWzA/0fP8qZdIDb3sUbPySbToI/7+4msNB60s=;
        b=bnMJM/rTPU9AGT9BmhGFpqpmERJzCpd/yWi9kjtXpkbkZa9gSxmjnR+zuzrHftwlgD
         giRtHQcC9GP82vLKynxcUwRQAFA3GBIefdjaxYgxX3XW+n7xSDfXLXWABJDSoheY7DlP
         qZenBaYIW+7otHfzorDAXxYj5SZqZRHhuPTdtE1Xqzz2a+rFOPFsF4bn0DYSsPfR6HRF
         yNtB322mlDv3YU3li9WuQuLc9Qvi4t02oz7qu1DncEpnvUbcNMQblAJYjpfJMbKyK3e1
         FCGBZ9zmdWaXs+2IqfJazP0CxtZXSWiW+oEXttBD609F9jAgeI7/jyg0bdsUViJUIMx+
         eUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757891970; x=1758496770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0I/xnWWzA/0fP8qZdIDb3sUbPySbToI/7+4msNB60s=;
        b=S6YpTgG1f4BGGnJSniuTYD0omgQulH7DkTfh2mSGTmw3LZbnL7PyQIQxdlzIMiNP3o
         DIniP64vgpwayQpdRsD9z4WY7rjx+ajgdAIGZfI/j0116gdB0mJ9uQBjR8ADWHHq/iWV
         F2oQ1HNIqEi8p1SHolZvJt61KWLaHGMybYA4gCcSvfcmDyi/eiz+bwvvsLTO6b1bxh8m
         E9RSjN5QU/TQWWvTCNW6Hb8JNQ/C85J/ewB5oEvCByd3JzRziS7E/q7IZgZW/S2sd7tx
         XtisT2ZYPFEXeushw1tXgx3Fin2t0lOwkn2io5/zJTSaOxGgGDhjTJO+QnedlW7huLZz
         YjtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR+14kiC0JptCdmMetle+uH7hV2zPKAMQcPFmqvUX1E2eTMp3pc6YNzZfR5iNS8q2TExrbklDRRuPPIvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+/1f/S6R6869EHRn58CXdSeLImVTkJNWyV84WHx/xZlzdWpIr
	PeTiMMm5mOT0nD0v8xVTZBBtD8mRHqotO1PDpr8dHRnsxaWRfT7cYPEjEyLp2qKznIJWGdxRTnq
	3+M1X+xcslXP7AHibjpnk7SdH7D6++A4=
X-Gm-Gg: ASbGncsERz3TaeL5nGnY/nVoDu/r4mVGkeUQQAzLL4UZUZ+0eFn51c7651ASB+iw3zn
	GTlrU6Jv/kOPPWeaXkf2WI47qxFT/PWNocFhQDUbUMETdvDTvTRgoJ0GPY4R8rAEp9/z0vgj4BB
	FRa+qI6108LCXcEUGnn0qomR+b3dHpY4pWhj3D7SlAUsV/oO6tArEfDy6EeQxal90kucRB+Hk6R
	yPKkilgZJBEs5eeLzNgJ7rkwAPl9sJa/yK4iL+a7ZH+8yA6yTO5X4cYkvnCbTwfsiByF/usJf4N
	DkYZX/GDjpRcWj0/aHpcnVwFXkCK/9B9eIx5
X-Google-Smtp-Source: AGHT+IEL4fTrsytJhQUaldsh+1WXyGODbkNk8V4WUTM+8P8Hw+jJU6kT/D3QhsNp2JyUY/ta0A6bPAm5mVBqkbwu3H8=
X-Received: by 2002:a17:903:708:b0:267:8b4f:df1f with SMTP id
 d9443c01a7336-2678b4fe1d2mr309415ad.1.1757891970032; Sun, 14 Sep 2025
 16:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722121441.224439-1-lossin@kernel.org>
In-Reply-To: <20250722121441.224439-1-lossin@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 15 Sep 2025 01:19:14 +0200
X-Gm-Features: AS18NWApSI_6yUDnJg9YwpBR_rWNHqaJWiXdYcO5dNgirLlwr2sfICJcrOinX3w
Message-ID: <CANiq72nD6qb425Ujkey7KBoGHT=cmgOcAmWHThd5+BktGeQWPA@mail.gmail.com>
Subject: Re: [PATCH] rust: sync: extend module documentation of aref
To: Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Shankari Anand <shankari.ak0208@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 2:14=E2=80=AFPM Benno Lossin <lossin@kernel.org> wr=
ote:
>
> Commit 07dad44aa9a9 ("rust: kernel: move ARef and AlwaysRefCounted to
> sync::aref") moved `ARef` and `AlwaysRefCounted` into their own module.
> In that process only a short, single line description of the module was
> added. Extend the description by explaining what is meant by "internal
> reference counting", the two items in the trait & the difference to
> `Arc`.
>
> Signed-off-by: Benno Lossin <lossin@kernel.org>

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

