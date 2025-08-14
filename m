Return-Path: <linux-kernel+bounces-769486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE399B26F55
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 20:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4E3AA41A4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E1C224B01;
	Thu, 14 Aug 2025 18:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E67syZkW"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDB9319865;
	Thu, 14 Aug 2025 18:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755197355; cv=none; b=Zquf0JOTXhUhirann9XQcYJwxWuO7UJ/j6yqT+MZv1nhyWtK9KWBGfYkLsX+oFKz8aZYdeTxRUOKCpEODbpWNAJ3MwUrVSX55eSdzsFhxrpXpCJIUITaiNMBhKvY6g3avqIYcURdmHuA0ZC1HE7xRwzK55DP7Bqv/1E2hU6k1T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755197355; c=relaxed/simple;
	bh=nAnkdeH3APlj2U9iiAF7xZnRZxmcM+3jblEMOPSPbxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sBXVDEhT7P/hmXn0cWmWGbeindPl8FnYHmvhoPk5tgyv+Wcn4Va2LYCl1FWh3g8bUEb9vcnGzeVJrKdgPzFfsDrfU7yb/VaC6FvC+GRafRqgDxBPl3Fwr7ZKvAPNfuGwfvOqYqqrD0Fzwfj0HqIobvopYXrLvURIyZ0hIlotjBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E67syZkW; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24457f44927so2157195ad.0;
        Thu, 14 Aug 2025 11:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755197353; x=1755802153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4iaOrLK6Y8he5/xeu9+Cu/u9QRWTEOaplA8thVvuZI=;
        b=E67syZkWTAbfpkUWkA96xa7fCdObTA4ViHrkwpLFaoWhvoCDKS4d1WBCQvPRLtJVgw
         Q+/lnAEQd5P5Ee9YgLfuj9X35/A+Us/uJtLP+zip8oXuTXERH8Q2t0rhENFZdMi04cfE
         0fqpXO0qaWHJE/6JT7xbBTou39ZbENvjU+eXZ13AdzDgDXTCopIzxgpKQtM6eO2ma0e7
         cs1Wi1CvO4Al022E3X6ztUfAQjfwLZEOm094Gr7sbiIbTdiKYVtj2YF9VvI1i57mfn9w
         o2S9MqnCBONCjND6f6kan93pomBarXM7hAZ0oYQX10F8eEoELp615yDPQcYRbIoPwWj5
         LyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755197353; x=1755802153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4iaOrLK6Y8he5/xeu9+Cu/u9QRWTEOaplA8thVvuZI=;
        b=ibcAMfj8TmZtX+JEUWATvdJOfdvYl2bVax6lvKQjDR8hO3XY/UtKmTROVI/GcvxoDr
         P54nfZAB4pYrorjsYr+qsQ9yphLLVfCblJxunBp32ny0mkftyyCHzJ/b3CCKwztktvb+
         0pxyuOHPiJ/wzLBOGNgxdeicyZrl7wqRwv8uqTLC6vZ1Hh/MU4c3KPROzNloQ24K2KgV
         trB+pKmJkN8n+vO2K4cRYOrlDbI75ajuYs1bCIeKNzznx7alzFmZONkt09bR8bAVUS5f
         0VFwjd4IZFXsgqtKKEJ4Y0obNJoYqy/2gjG8ykYUKGWL2jg4gYblDiJ0f9V8RiOIc57b
         IkFg==
X-Forwarded-Encrypted: i=1; AJvYcCWk/11Zw8B9n7yVjG6fCWpqn3E277kDNt/r2YZ8xWanFzZuGHQnI6dzUfZlV/Kt91IfKpSNbwyZhnHt80o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeF8RW3Sp8t4sUeH/FWAyGiey+U0lSywPdj3b961XEHDyMM989
	R6qcOPsTDiQyk7KJzcIOaTj1YurhK6ATEypT40gBQadQw3ih78AQ7/hm563rCyBycJ8R1MFoovM
	E/9jC5tUh4oJw1k7VnPiglBxBFSSA1dQ=
X-Gm-Gg: ASbGncsIKcFKJPF8zciINwBX/k+CsD2KuS1IcNkstl+NS2W4R4u6TAXsFbRJqO8u/mG
	F6+lcv9K06/QyO9DzYXafHkrw3UrljteIiWQnoas9vGZvpxX4PkoRUjxNxyLH/5ZFlTfDfD4WsP
	Sk6ysE994iMYFCEkf3Z+ih9uIgaZIRlRrUerCg+xMrmo5ItkX7ia1dbgav+O5Xmu/b3DcIU0L3l
	1p2WrCCixd8H2r8imI=
X-Google-Smtp-Source: AGHT+IFZTXQ4KO+d2AI/L7tmBdshgN3ufVMuph7Z641B+fEhmaC3Za3g0GOPTHhNCubEPPasfSWLfm1uU+AD4uolt2s=
X-Received: by 2002:a17:903:1c5:b0:240:8fd6:f798 with SMTP id
 d9443c01a7336-2445851909amr27534995ad.4.1755197353113; Thu, 14 Aug 2025
 11:49:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ec0dcd14-e974-43ff-b4f4-3dfe2f31a91c@t-8ch.de> <20250814162211.566168-2-areejhamid8560@gmail.com>
In-Reply-To: <20250814162211.566168-2-areejhamid8560@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 14 Aug 2025 20:49:00 +0200
X-Gm-Features: Ac12FXwYHuu9UlOPgQRW4suxB6h68H-iKwUS921ZWH_ISDelKyVsKoaH1ooqji4
Message-ID: <CANiq72mbTqu8KuKn1uKM8czesrg+or-S3K9e_ohJz1b6kzdffw@mail.gmail.com>
Subject: Re: [PATCH v2] rust: lib: add if_cfg! macro for conditional compilation
To: Areej Hamid <areejhamid8560@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@linaro.org, aliceryhl@google.com, tmgross@umich.edu, 
	dakr@kernel.org, viresh.kumar@linaro.org, tamird@gmail.com, 
	dingxiangfei2009@gmail.com, gregkh@linuxfoundation.org, 
	thomas.weissschuh@domain.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 6:25=E2=80=AFPM Areej Hamid <areejhamid8560@gmail.c=
om> wrote:
>
> +/// # Key difference from `cfg!()`

Please add an empty docs line after headers. Also before opening examples b=
elow.

> +/// - `cfg!()` evaluates a configuration flag at compile time, but both =
branches must be valid Rust code

Please use intra-doc links wherever they may work. Also please end
sentences with a period in docs and comments.

> +/// - `if_cfg!()` compiles only the active branch, so the inactive branc=
h can reference
> +///   functions, types, or constants that may not exist under certain co=
nfigurations

Perhaps we could say "... branch can, for instance, reference ...", or
that it is not type checked in general, i.e. more things than
undefined items are allowed.

> +/// // FOR CONFIG_64BIT

I would skip this line.

By the way, Tamir suggested in the linked Rust for Linux issue to
match the name of the upstream one in case we want to migrate to the
standard library one eventually. In the commit message, I would also
mention this and link to the tracking issue that Trevor mentioned:
https://github.com/rust-lang/rust/issues/115585.

Finally, we may want to consider putting this into somewhere else,
rather than the root file of the crate.

Cheers,
Miguel

