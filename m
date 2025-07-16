Return-Path: <linux-kernel+bounces-734368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA95B080AD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 00:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6710567FA5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 22:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9B12EE979;
	Wed, 16 Jul 2025 22:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpPd7o+L"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10809295504;
	Wed, 16 Jul 2025 22:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752706187; cv=none; b=jq6WJxhrV+8grjn60KLeo2lM5j30LNppth8/FdNo5olfIHOxtX4B1ptgCXHA7jrvxYCGbPx/4Tr/FRP/0+RSoo0fEfEe+jx9c+B7X5usoNqKYPria4d5/Se6esxQzwiegZ5QZeDNAcJeoG6XMI9XWkhr7oeU0gC+AUuQ8nHtnJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752706187; c=relaxed/simple;
	bh=EyJTuRR9KSK4RX5G5/kJLBZK7Ju6ILW5wpu/i9l2HkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DXbK+BHEkeYKL/FM96ydecvBhBlORNtQhcG/fBKYvJo0uqEI/o/9iUsIpLP1JL0Oqzvf1JMKG6wJr8KNCB7hAnn88KlWTzuDwsDPGZzDdztzbxmcCQ+w8nekIIe1Jp1YBvI/AUVv0G0KtOcKHLKynu/+r4lyyH8zHidV29+NHnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpPd7o+L; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-31306794b30so69276a91.2;
        Wed, 16 Jul 2025 15:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752706185; x=1753310985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v//3UBkCMbiLFLeuBtGql5RmFNCDtwUoFx4ncSofsIg=;
        b=PpPd7o+LeRkk8v9OufDo1LpfId32/i2HjIvW8sD03ZZzT6HGTgCAv67SwATbG2qrrh
         pfNyu7Fq7KuzhxjTnAEpMXYjgY2HF3r+SW1AuduoqYM+K//XiVzBGXoP4KHTYyg+YPhG
         KutxabihZJslMsYlSzjXK9KG21UWrRED5XOs+FP8XZ/+KA3TrnqPyXWiNkO8LED2ECOV
         nojfMH3iQpch69Gn9yTaDJH5E5k+92iPAvRiOUacBNlsTUmlyhks71rKpgOr63ca3fAu
         xhn36/uIPLVni6vTOOICCsM/4ZQ66dmlYox+BaGr683rKJXLGJC/fNqSmb86+5xBMxvc
         REYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752706185; x=1753310985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v//3UBkCMbiLFLeuBtGql5RmFNCDtwUoFx4ncSofsIg=;
        b=fEaURp8LsFMUthjNrPfACC9SMTAxGVrIojowE3GS/ouo1d99jeqGO/iXSWVa9t2j2U
         peLCCAB1gkq49jClNlQOlaxKjEXDChDREW2eF0KgCc91PstXiv4ecDXU+q5FuerBQXbQ
         J84Fw1v8dV/ynnkkJb6Ce9B1diI/ez6i6A0vfcsR6NaWykmc/08NDgJq06nQJIgOW2Wv
         sYGMahtO2EU0STjggsvN3A5ERh3UHZjaTPXBFaojSp1ZtKfHeLO89KeDR1oevzmadc//
         NmhuFeRNSNAQ+VO4o3io0z2G/6lkGOSOPde+IZss8Ulu14z20T2GFb51ts0ViknVccZv
         JVdg==
X-Forwarded-Encrypted: i=1; AJvYcCUmzGMMxB+CswOPWgyPUVUjUFxMqvzmGMfKtsBsYAuKBzb2FEXS5eXUaNZ6E2y7RNzXv/w2TWb8S7jHkEOugGY=@vger.kernel.org, AJvYcCXTwKUTd6v6vgVATIWJ9nfAYtC2m3bLonZMFRapyBJuIelLlrRfnpVG0QC1G3mn/LUiLG4yJBCXq4U26JU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIJcjYLtYH3KqcEyKFaQNYfGEhCUNDf21JapAnEz0Q4nd6rCxL
	WbEneMkc8g812XHDZ5OjTfinYTGtOL3Y6cBcQ5EbmPea90ISkIzWOJ9Rf20l+QR3bd2IxFY6K2G
	Dkqb9CuoZoNL++cYHkJhdddddHwHX3M4=
X-Gm-Gg: ASbGncvF1sHLNRao5A3Eky97ZkEidUPKZDO3k7bpR4ygmWMgEb4/jkh+JYBMJk7qw/T
	4SdnrP5SWuRGlonsmvb/CBjAbMAOPk/bR0HtGGBNeMWo7jP2QkhHQCBpVNZoT3JH6Xab9lhAZeC
	y3B1I51YMy6zhJqxHjqzmJTn8HgVZffjS4XL9LTtR5ElyRhbXLbG6kfTWMZSIzR8vjdW6FhODLG
	aCsJA==
X-Google-Smtp-Source: AGHT+IF2FyfdRt4/WjI7YWqu6cvz+ZQn0OnT19l1sxu4Z2oAw3gTfBbYI/cvlgLvUs3kU5QRfXuJ8gwGg8NFl38Sk+I=
X-Received: by 2002:a17:903:1a68:b0:236:71f1:d345 with SMTP id
 d9443c01a7336-23e24ecb7damr28125495ad.1.1752706185220; Wed, 16 Jul 2025
 15:49:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624-opaque-from-raw-v2-0-e4da40bdc59c@google.com>
In-Reply-To: <20250624-opaque-from-raw-v2-0-e4da40bdc59c@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 17 Jul 2025 00:49:32 +0200
X-Gm-Features: Ac12FXz9BaX-Wl5vT6RJ3n-TUcpyTsdzFMKNs4pOPLbp14a-OstkS9DkN8Ggm-c
Message-ID: <CANiq72kyhTMkZxizgL0Uu1NEbeGP=G09VP+Evb47mg4FyxZJZQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add Opaque::cast_from
To: Alice Ryhl <aliceryhl@google.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, dri-devel@lists.freedesktop.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 5:28=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> Since commit b20fbbc08a36 ("rust: check type of `$ptr` in
> `container_of!`") we have enforced that the field pointer passed to
> container_of! must match the declared field. This caused mismatches when
> using a pointer to bindings::x for fields of type Opaque<bindings::x>.
>
> This situation encourages the user to simply pass field.cast() to the
> container_of! macro, but this is not great because you might
> accidentally pass a *mut bindings::y when the field type is
> Opaque<bindings::x>, which would be wrong.
>
> To help catch this kind of mistake, add a new Opaque::cast_from that
> wraps a raw pointer in Opaque without changing the inner type. Also
> rename raw_get() to cast_into() for naming consistency.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Applied (yesterday) to `rust-next` -- thanks everyone!

    [ Removed `HrTimer::raw_get` change. - Miguel ]

Cheers,
Miguel

