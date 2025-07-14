Return-Path: <linux-kernel+bounces-730534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BEDB045E2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419C0188909A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D0025C6E2;
	Mon, 14 Jul 2025 16:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxJzWuim"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA74427470;
	Mon, 14 Jul 2025 16:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511772; cv=none; b=Ci3J0OAa6Yw9flTjN16JkO9/+UsaL9A22sLTre4zuwEgC7uHrxOns0tzQ/HUPKsFIlAFMm1KYV8Fp5tI6G3yWdlEWXdL9IcjQWyxtGRp+X2KgxVhN6UkyRp1XS+rPbUHydxXFgqaVnotiKJlCKwfvtRx9o5rvjUuPk6DFGzJ13U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511772; c=relaxed/simple;
	bh=F3n3V4Luz/JT6U4pUZqkAcRtEeYBFe3axNzOYeHa0To=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWOc5/bP2kkhJA3w8x0gUWXMSzbzpNny5nyUkoVBDTlElS7OZ2ovSe0JOSCw9XIQ6fxwjaJI9Y7SB6hTJfm3Ia0YYUtQh+4MABfGsfxyIfC2eaJ4bfWAkWCS7kzUaGnBQ9y0O/RUpeQMYrczIOcVjpJeGXv8pcxwXguj7F+YEGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxJzWuim; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-31306794b30so728026a91.2;
        Mon, 14 Jul 2025 09:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752511770; x=1753116570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMaGzs93jlELahs0rig1FTyg0FWKuWnjkUHeg3IWFQc=;
        b=AxJzWuim/Mdj2lo63YbTvlK+Mnt9FY8xSJS0EQXdXV2ZBsyJ/LjcMNqN4nJ9sH6crO
         U7ODOzVpU2nERKbZ1cWDNeuZKfgKXB+ro2RaeXleMAcHqutlHFUbwHT5YqVMOCKGsD8F
         7WAEAn3JO3F36sdQ8sqtcoZ8VROIvaDuDoQawFnCkG3+nDiIM3+1DNSP/VE6vD4gd1BW
         gEuXn5Jx5LU3QL+SefrHvV7rNQc+tgFuuVJ91LzdgglRCZwPqw2HpgBUOSwOyLyil2T2
         0O8L7T3IaOabNpoVnd1TdhBieV/q1UCO7hk5h9fU+dxnxbMbRuTETq5UZRbwf87q2oc4
         Dskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752511770; x=1753116570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMaGzs93jlELahs0rig1FTyg0FWKuWnjkUHeg3IWFQc=;
        b=nDAmM9E/uVlYU6Qjy0DoSwpes0HMFF46tW/wQSSRQPsNqmnrmc6Cd9AkSrTuOXUvCT
         nFbXMCvQZ6eb91bjn62nwStSpimYVw8RFWyTrBoCnpvkTPDO6FuxDp2EgGsyx/xOddNB
         PrmRIYqINrz0q/WjF2Akd45P4i6gQXAfj1agfNFBp8jd8ZzyNtfdeSuEHSIe9uGIpDKh
         a4t1aVaWx11QJuh/r5L+bksRjVlQvuiFJtAtLIn9VGQjaqt3L6e+YL8/eD/eBdRG5GSn
         AwpDaZ/8nlL1dfwBkMGlpkRgxEO79hBTmqqeIKa/sBBdQbW+NIeWYbVNCB6my9h+uAOt
         nkwA==
X-Forwarded-Encrypted: i=1; AJvYcCU5PQCogCUEv1Oa4UyNogPhD8IM+oG6LrGRD3+uBeMjRyprMagbP4vvQq9xgdliY863Ozl/8VfdwL1cnXDK5OY=@vger.kernel.org, AJvYcCWufSL3SaxbuAN0Ws6yKrUxt3hUEklSr3O0WuxFYnjQSIrh/8UNMFKMCxQisSmrjCQ+l8pa/GkeKPOPEtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Kh+e23l2cyhxM8pUvzbsd92L+tzINMGYIDE6Fc/VhLO25LMJ
	lVw+V5tTlQ6LPoiXZHYH1jSthMJ0ZfyB9ZCSfElIp+GNB4Sqjmnv7dOEXOzmmBOYIBFlsNsp120
	mpyreN44EacNgSZIZV+Knu3sqB31tBP4=
X-Gm-Gg: ASbGncs4khlBchQhCXOE10lz3sFZxpZSZZtB2uQVHjVTqYpivV5GLjwlWNxZreHuIfv
	HUeBroMAHchSZze6q/OmOFslQGyYiqYtHDVyunNWPA8bB8bQXqbc9hWE11yHziX0oHwA7hD86Wp
	wZst6UxW/CsrpSivQ7qKeXVTfGedCXYyDUO9JRMymukX/mDEh7rg2h87O1R59LGoCYvbz5ir8Hc
	zHwouYs
X-Google-Smtp-Source: AGHT+IF9VUiu5LPlclakBgM3GjB0x7a7WdSL8pK58j4wRhwnqb6evRDCQ2/FJ1svGKQsOjvPuueCSoQoypWeAnUKwMU=
X-Received: by 2002:a17:90b:5303:b0:2ff:7970:d2b6 with SMTP id
 98e67ed59e1d1-31c4f545a20mr8544225a91.5.1752511769896; Mon, 14 Jul 2025
 09:49:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250713213614.188921-1-shankari.ak0208@gmail.com>
 <20250713213614.188921-2-shankari.ak0208@gmail.com> <DBBNCQQ5HF3N.3HXQWJR71RZ8S@kernel.org>
In-Reply-To: <DBBNCQQ5HF3N.3HXQWJR71RZ8S@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 14 Jul 2025 18:49:16 +0200
X-Gm-Features: Ac12FXwXO2KNcdQV3tlX-rY7Yz59jrBSbZYooFPejMZSrz3E3NZnZ7iFxrUjBHY
Message-ID: <CANiq72=NSRMV_6UxXVgkebmWmbgN4i=sfRszr-G+x3W5A4DYOg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] rust: update ARef and AlwaysRefCounted call sites
 to import from sync::aref
To: Benno Lossin <lossin@kernel.org>
Cc: Shankari Anand <shankari.ak0208@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 10:49=E2=80=AFAM Benno Lossin <lossin@kernel.org> w=
rote:
>
> We probably want to split this by subsystem and not remove the
> re-exports this cycle. @Miguel what do you think?

Indeed, unless we get quick Acked-bys and so on, it is likely we want
to do this (i.e. the second patch) in 2 kernel cycles.

Shankari: i.e. one cycle that cleans up most of the code (which you
can submit split by subsystem so that each maintainer picks on their
own, which typically helps to get patches merged quicker), and then
another kernel cycle that finally cleans anything new (which ideally
are very few) that was added meanwhile and removes the re-export.

There was recent discussion on this sort of split recently on Tamir's
series, in this subthread, in case it helps:

    https://lore.kernel.org/rust-for-linux/CANiq72kta=3DWk=3D3764A5SzxB6Mq=
=3DsJfm9DyMZXFC91ojUSj1TeQ@mail.gmail.com/

Sorry if this is (I think) one of your first series sent -- in Rust
moving types around modules is a bit painful. At least the first patch
should not have this issue.

Thanks!

Cheers,
Miguel

