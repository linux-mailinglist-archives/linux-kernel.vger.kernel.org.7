Return-Path: <linux-kernel+bounces-730912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06593B04C5B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 01:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587404A250E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E2027E052;
	Mon, 14 Jul 2025 23:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fm83a6l9"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BDA2561D1;
	Mon, 14 Jul 2025 23:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752535925; cv=none; b=S6bED6nPabSMG7MmOYSNJWJfWM4u89+T3eBtsXzGVv4HNFVyEXDwiie3WcNG/+/n7mjFLnYpf3ga8qcxpvcLAOqeVa0D8g818P8D/Zhx/5XN2I+07ZcowBKWoghW3/fpvLv+aV+ik9GZJ39OPmKys6WHhjoSsAvglp54/YZ2MoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752535925; c=relaxed/simple;
	bh=mVVGYqCik/JBPNYCBJ32BiKvfDLaKSh2X2qssOJjFiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jeE2vkCKQ/5z8fcWByrIL++h3PPGHZDEIvf2hGhspxzJJwqKCFvOmnmo5mfuh4QJRTvZ+dtEHzNi6onBEH9F3Jdj3a6jTbV/skfLoeldmaltF2XgLgnQuyiSsSuDZ5ZWNo7lcUxlmRX6Jjdi73zJePToCKP70oNdyJWpJBEFpQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fm83a6l9; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b26fabda6d9so904116a12.1;
        Mon, 14 Jul 2025 16:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752535923; x=1753140723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVVGYqCik/JBPNYCBJ32BiKvfDLaKSh2X2qssOJjFiA=;
        b=fm83a6l9UubzvOAGiBsRyQ5IuDnGTLs4LPkqou8A+Xj41DqlSrF9QGoxGg0Po9NYIf
         Hen/AGENaxJMm4L3HOcInXjOJr0cZUFuXTn5rTDM5yqBRGsrFq42zuPieGyvO/3GlbIG
         uOEAO5oWeLspwZnhzcvIPTbKGnngRp11U1SuNoYvpDIGAxw8W2C8j3+kOEHJVjIBubVH
         fPutEG7UZQ6XnwVG2tfxEG4RbrQo8JhtHVIoGUFRTsjj7CU4VJsmGBuR+VS42KCu0v8e
         nODbkqAO9yJMVFKD8+OAduovddcGCUMt9gEJVuAIkTxjtNr6YDR+93oyzngGzYhbF63L
         4S/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752535923; x=1753140723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVVGYqCik/JBPNYCBJ32BiKvfDLaKSh2X2qssOJjFiA=;
        b=Ewi1w1g8T6YavrYOM6XHb+Is6GnwrmE+QLn/6waW2XfQ0H8u3iZy4t3T5bGPJY+Lou
         wnjAMdkpA+iiMQtYv9BEu+0VsNMcvnaMhXiBg9OrMx2AGpxWc9wSBMKpxmG9hvgSiPpy
         cUCq+reC85I0oxljfZ6o2RsKsWMICZGl1wlqa6URRdX4l24ODk/jCog6n+Dp4aEzLhUn
         F1XkpXHNmYUoVSYYDCJuYwfATp8pfP40KQQ9oHz/F77y8gzQbuO/hsB2XLyjWIZLkWt1
         ed5uNgoGoaFkM2s3Blcrx/3vRRbXpVwNo59UgwukTkpgwvO9aGP2hk5zguuo/C8VhRfA
         KzKA==
X-Forwarded-Encrypted: i=1; AJvYcCUuGinnM/B+RLNsSW9lpbdHRiYPffPNKtmhfbYCh8xQuhZQgdwazFzmmrcDScd1YvVXyoduubu6gMYGgyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNoSkruL4o6RqqxgmgDvU485E19EROOD6Jc/1GdrERCJnQq0lP
	45PYAd396+/9tTNYmJxoc4LN0iL9FBMZ4b4eVvz7MMDV9U2doMQA0SNJErcOAtxRLC+6Ium12nW
	J+cpnuIhstZmdYhkTF83GeGz+Trmeva30tAmSFxs=
X-Gm-Gg: ASbGncvttvWGjN4N8wmNv7AnvjuWbq2ZmOBkx3UHz8IdwKxJdu5LcZJoZ03mBgPIfki
	HEvxuHPxjaWa5vPuv0eMjcJ+IJgtIAdzUEuQCqhHFHNbfM6CVSjnnzdLJlOd3pURbzui886EOeO
	AHxxEl+69JeoK0hdFtW8Ao3cEDgXW+0JhxyKuGfnXj7s25NIx4OF9xAEbOIHyFm2nK4GZm1HBYS
	ejPqT5+/NyGgSKY0CYMsK/Gms0kLw==
X-Google-Smtp-Source: AGHT+IHDNDcngNndydTMXpjbQJ2u3lI4GlBEduRS3Q/woLCQwszYiYa+9wQWeJVaXsQek/MUsOlRtVtKIzadJiqSbUw=
X-Received: by 2002:a17:90b:5303:b0:2ff:7970:d2b6 with SMTP id
 98e67ed59e1d1-31c4f545a20mr9202132a91.5.1752535923011; Mon, 14 Jul 2025
 16:32:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708075850.25789-1-work@onurozkan.dev>
In-Reply-To: <20250708075850.25789-1-work@onurozkan.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 15 Jul 2025 01:31:50 +0200
X-Gm-Features: Ac12FXwXvKgChD7j6AHIPKE_cZjEBdh9nv5SN50tRnsSfOAyK3MJPxZ0NqxOf1Y
Message-ID: <CANiq72=OYZtvwSYWv+kyAaEOUWvaFRyyqvtf97V94NsHnD=ePA@mail.gmail.com>
Subject: Re: [PATCH v2] rust: rbtree: simplify finding `current` in `remove_current`
To: =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	dakr@kernel.org, mattgilbride@google.com, wedsonaf@gmail.com, 
	daniel@sedlak.dev, tamird@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 9:59=E2=80=AFAM Onur =C3=96zkan <work@onurozkan.dev>=
 wrote:
>
> The previous version used a verbose `match` to get
> `current`, which may be slightly confusing at first
> glance.
>
> This change makes it shorter and more clearly expresses
> the intent: prefer `next` if available, otherwise fall
> back to `prev`.
>
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

