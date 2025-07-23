Return-Path: <linux-kernel+bounces-742351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E04EB0F06B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600FB3BACDD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0945C289810;
	Wed, 23 Jul 2025 10:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxGM2WYz"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1501F24DCF6;
	Wed, 23 Jul 2025 10:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753267914; cv=none; b=HLGmDYZNAYdLlP71IBvDRwO4hixENkNmwk/IMEZ1rf1oynwsBaGPDAu0A3u9MD9szlEDB7tPtyyMhVVe7PDeLJMU5XUgqYInnKilgwReQiLF4zJZ5DVbG/fqWuAmGh16lQAk7vgtGcFWRwQINOfiHfSDlHbGImFjJNYV4ThZ6ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753267914; c=relaxed/simple;
	bh=DZfurw41CNNs9J3PkRReIrN8BqDiUci52fRvR95/8iA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fskFs2Kj27lmK3ZAjm5Sq05KNwumHmGl3+xtwaiCC17i4EksVz5fB1q2qXKr8trLFSv+7z7zGE9U2CchcIBF7x3TAgiunfhZs7vyhzD8l5qgXQNxdE5rgkR8HUUJHHgulrFHFY1p9U1BSI5kg+y1rzaLAIfW186BEKEx4lXNapo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxGM2WYz; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-312a806f002so1106325a91.3;
        Wed, 23 Jul 2025 03:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753267912; x=1753872712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIrdtlzwhoIuMLPg7/asNdEgduChv5Q6hEiZ2nKwrk4=;
        b=gxGM2WYzoxowxQp1enMicw4vqMtCdzPcU05z6396yxHKIkHFATkJ0gu2PXYHmUJnMy
         jJCm7+uSkN3sjNJU1zWgQtWI1hQpueS+J2/wRyNH3TQOEu8TmsxsQaoupr/1+l3OxwPJ
         4THvvqXkNqQUgQIc/gAJct++ncUXyTIjL1hos8lc/a3tsPUgoJuhwe5rAiyUs5FwiEu3
         xUPjVvjuiW8/yzm44d78VzXXmYJii4NBG0ujx9Mbty7jerLWhB7NfRVrWvzqf7P95PX7
         ymPaOZjDrb+iFJgdow020mncUlVG3xIm8WY2px3bkLXYMqYcosUkRsQOzE7y06/YdcOH
         98AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753267912; x=1753872712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hIrdtlzwhoIuMLPg7/asNdEgduChv5Q6hEiZ2nKwrk4=;
        b=HsBUfEqpWN6TF+lYLCOUSIeOhMaD79USl91Z9kdpBdC7OevLVFKZs/fx6OxXysz8CK
         maTo0nlw2/BXtMBNcSXYDOQGbZiZEXPU5zWUZkfLSmCJF5iG0x2uhYt1MqRk1BikwRKP
         5TWpuj2nSXKFEEawklgdrFOHbrRT4/uFtju3jMEaJ3GcLTF9rZSRV8humlZ2tW1QTpH4
         IpCDyFZ1GT9pnKPjeg19KPEZv5tRtwcztOYFjHY3PxxqQBWmFIxxbVhzAX2v7wIMWvpN
         bWocCol8Mlh9L3iyyyhQzYFbuaEUnvy3gwYrztzD+FWy3NGrcrFHLrMhyiZJ3P9GhtgY
         S72Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlFntpPwDO77sOIFIUfaFhOukZbbpsJo1afIcaJphXeiFtheO0C9uQqqG+Eg42PD+KWsyy8nm+TNM0jTU=@vger.kernel.org, AJvYcCXQt+SucU/8MAEH5vVxb9rZ6yTzRkzEb9+cJKlMZb+vGpX+QiDjXUY/aEyVKFjxalxZw1KUohXtZb8dfRewxFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMsIITCnpGCF83qAik1ufGufY10wgPrDKTM86PfTeEu5phDWic
	SZtovZEdfvr4s1GiDQwcORRIcPX9sCuoNHbTbsPHtalz+JjtpdbO3OytCu36exc6W1K9zC4uzj1
	pFLjciOevjral1Y5YyJ8fbZ6bb5p0Kso=
X-Gm-Gg: ASbGncssIcvzZwLgFCCBl7cqBSUx9R9l9FH9l3FhO4pAQD7Idba1ZM8T+KdZA2gbtV6
	Qnd6fR3cNIls1WIN763eQ4yG+uGzDZMWNVnyC5xhoxigpR/MCtNsn/YDmDTTXUW7eRBM2jpa6+x
	9Z5URIAkQvpv9/iZIpWmB9rHwRyFwggIoXKRa+0bC0/rClUq9+Gn9QSyKIgjhZreyRyzbQCv48A
	lwqJLwa
X-Google-Smtp-Source: AGHT+IE+Ayr97X8dO8e1JeJQrjmyf0eziFiwpkLm1piCAGQtZnFVciegIVClUZDYatMUAw3Hg1nSby42QHwbmsgE7lA=
X-Received: by 2002:a05:6a20:728a:b0:1ee:e1a4:2b4a with SMTP id
 adf61e73a8af0-23d48fe046bmr1643455637.2.1753267912311; Wed, 23 Jul 2025
 03:51:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722121441.224439-1-lossin@kernel.org> <9bae0d3c-7900-474a-a0af-d2f90ec65012@sedlak.dev>
In-Reply-To: <9bae0d3c-7900-474a-a0af-d2f90ec65012@sedlak.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 23 Jul 2025 12:51:39 +0200
X-Gm-Features: Ac12FXxy5OZhm75DAn8_gk5KWF_RQB5NU8tT5YcoQesECHG6jcfvbJRulCrfWaY
Message-ID: <CANiq72=UqCnGzRgjigtEmsyh=7Ky7q6oNZRu3xZXummOTB2pTg@mail.gmail.com>
Subject: Re: [PATCH] rust: sync: extend module documentation of aref
To: Daniel Sedlak <daniel@sedlak.dev>
Cc: Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Shankari Anand <shankari.ak0208@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 12:25=E2=80=AFPM Daniel Sedlak <daniel@sedlak.dev> =
wrote:
>
> It got me curios. Why is it required to declare the doc reference for
> Arc and Arc<T>, but not ARef<MyType> and ARef<T>?
>
> Is it because ARef is in file scope but not the Arc?
>
> If so, you could just add
>
>         use crate::sync::Arc;

That would be unused -- i.e. we don't add imports in the actual code
only for docs.

The compiler also warns about it (`unused_imports`).

Thanks!

Cheers,
Miguel

