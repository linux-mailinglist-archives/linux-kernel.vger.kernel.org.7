Return-Path: <linux-kernel+bounces-737938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4C3B0B239
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 00:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DE7617953D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 22:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20F2238141;
	Sat, 19 Jul 2025 22:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGbbkHBr"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40E91C862D;
	Sat, 19 Jul 2025 22:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752963391; cv=none; b=TNON/AD4Ml9tWz+TpaDvmxM4E6ccTmz773UT3dNGaRppMudvBIHNBqaQAtRuCLNKPcGR6Xdj1+OG3bx48rxGAsAqOCFPGwI4tTnzp/d6ChRDR6yoD/0ToJ6duhI5XvzBr3i2xP3kmgrHyGZ/9iz/31GCFMWLZoapZL26GLOj1IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752963391; c=relaxed/simple;
	bh=NpkpzpedYY4EMfcvwrKPMwxu3YU5wekHKDu3bm/eEJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHs9nCqsEBlnLKKgvUmjKbHTRaAz80iDdBPiZKaAfULQiBCOcvIEvrRorcr8T+CEjP9s/3dejfjF73CFkPXCh89xXufNOUXqprQENAWOtZX1y2KEPmHMku0KPi+DeLBmAPVK6CeWCpeMjw5XyPitE5zZBIeLhK2X3yPKAkB74RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGbbkHBr; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-312a806f002so571646a91.3;
        Sat, 19 Jul 2025 15:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752963389; x=1753568189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpkpzpedYY4EMfcvwrKPMwxu3YU5wekHKDu3bm/eEJU=;
        b=GGbbkHBr0lXETCQpmeLFjcKDzufJQzHYWFQ1DYacyxYeOW27rdZc66785iDTYJuUC7
         GU5dbbelBoHtkZ216rl/U7d3+NsnVDfvQCWWUmmXxg0Hybt045g6Kf0GCfVDWdP1m0tL
         dUrUfPDmnQyzwqNm8IwDVGXZqxpQvYrhfjdp6TZH54mSRs142fPASVxBfD1xX9CTTyqo
         kCOfI9e3ykVnfC4zdUt69kXE/zJzYHrSb2Rp7Bifwid1Zoc9NbyRLZkE8UgIJCtORyrv
         ZQ7v954zAHvj1ZgNDcxko6qlvQyh+XV/pCnC4LYUQhTU/j/qJOnahyejx9GpJIttRTUK
         rZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752963389; x=1753568189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NpkpzpedYY4EMfcvwrKPMwxu3YU5wekHKDu3bm/eEJU=;
        b=xGXHeTVWVYaUOb0aSK1cAezneMXqQjafG8M1aJ96/wAKwzNfg7RNzs7YG3d9rY413S
         EayUEpEcohwkc+kk0HV2/FS1XXttrmgSxKEPWo/zw+haOUKSFEITC1o4jxm9OnlVVR0h
         wft0qKjRneCOCDNixo1EQa5YARYw/O5Uf9h9aYbPgLeqQbPbrlsDR0ONgRXKn15k5FnS
         s09uiqbxx1VmcwiyvXFYQwr6J5g9OvThameqx3IBTDgRSMtPonjqNjC6Afr3tkAUBZbf
         giK0MRiSK3Jrz8n80+v9YKZu8OzAD50Tcz1isAElnMbudkc273Od10/nESYV/HzbIDO5
         /dvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUnmGeoO3O8A51ZumFEHIV2IY9gdJLbtcsQ/DfGgXY71uuR7TunZk8f/HhqWFu+cT3U16ghpvab6Slqc4=@vger.kernel.org, AJvYcCXGziYsgUmyNOU0wXS4NLjH/GPyRCkTBWv+hTCwuPdfLu+I8Hu3S2dSfkLtczSZMgInH5v4B6qZn2+MXWYBjUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBLusnmv37wpLMAmRuaR9PmEz733hdJ/C3OEbJhV1LmPCs+C22
	Z/NjLFylL7QIFBLv9yd3dsuSfLtLBUwUZ6Q7JqibLj8Jw4CFRYFYowEJVXtvS/NKVPj3IJG6xm7
	TLFb/1L8JqnDrAY0h2fsYnPvgJAvCngU=
X-Gm-Gg: ASbGncu4VoWXDvlHh4xUnrzmRnJ3IcpB5iZFo/j876EBTP8Psh1Y6B0kmTNx9Khuiww
	p8NDYPeWFQpMIzFzA0az/dWpDRE8JJEwCYgGbNeCYvzvjX3WyXfQJyNqNXlhZICtFeg7ptS6NDB
	b7Fq24L5yejuVqi1kLzLtSBpggdByhrdPFa1F+tBLEP0h8KATrcUtP5FchmjFRoHoCFRozlnMwp
	2+7y2TX
X-Google-Smtp-Source: AGHT+IH6BKo2lnSTjkKm7n7x884y5POek1ffq9Xc270brisl+upX+noMOrw7jbWwO/I56s4/GJsH0QZB9o1iIRnlP48=
X-Received: by 2002:a17:90b:1348:b0:313:f9fc:7214 with SMTP id
 98e67ed59e1d1-31c9e6ec8c7mr9435742a91.1.1752963388984; Sat, 19 Jul 2025
 15:16:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250719183649.596051-1-ojeda@kernel.org>
In-Reply-To: <20250719183649.596051-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 20 Jul 2025 00:16:16 +0200
X-Gm-Features: Ac12FXwbHDJLi_zasTuQDMfRLkeGyZbrsVlDTOxOdBX5LYNwt4g6FSLKRrHf9Oo
Message-ID: <CANiq72=6HE=wz3M1fqAKAUyypSKZXMe7vFXTyYNWSf_0+ysC4Q@mail.gmail.com>
Subject: Re: [PATCH] rust: list: undo unintended replacement of method name
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 19, 2025 at 8:37=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> When we renamed `Opaque::raw_get` to `cast_into`, there was one
> replacement that was not supposed to be there.
>
> It does not cause an issue so far because it is inside a macro rule (the
> `ListLinksSelfPtr` one) that is unused so far. However, it will start
> to be used soon.
>
> Thus fix it now.
>
> Fixes: 64fb810bce03 ("rust: types: rename Opaque::raw_get to cast_into")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

