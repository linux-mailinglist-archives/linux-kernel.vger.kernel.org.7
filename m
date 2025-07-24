Return-Path: <linux-kernel+bounces-744760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E468DB11092
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFA443BED62
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC692ECD1A;
	Thu, 24 Jul 2025 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyKJ0+Du"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E952EBB98;
	Thu, 24 Jul 2025 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753379876; cv=none; b=NCF800by2dhYbJeVVQKgzsxeY+dL/MBlnm9OCQ2YDjnK5o4VopcI0sGTAAJyBL2+EJAL02Gzh7o/cMTeUfK1f94XeEZzVa/4CFLYK9TsRdT48nKYaDvJDEQFdMMNZy6KZ4QuxUhDaRPvQxV/0El8dUwhyF6Mz1xCkUqs/gMZobY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753379876; c=relaxed/simple;
	bh=SKzcnYmuoMfWCYOd1dGFE4CApBWuDFnC7AzBLZTYlWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nl7IP3OFTVojTmrUit6oHCQlTRCeMixiqRTOUW1XyqrgOW/05fDqWoRj90y9lgJeBbgk5NEjjRto8w0zjdOHvIEnprN+gu6Zcqhj2SebiFoth5KjIJsOq5sGAYi807UgPGWJqCuGl9G8s9TgXzRNl6T//MqXHleE+6gYw/gBwO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyKJ0+Du; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2369dd5839dso196195ad.3;
        Thu, 24 Jul 2025 10:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753379874; x=1753984674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8UvJuIn0OPJI+DjMgO3jk5kaVoeuzRgCCA1dECQ/gA=;
        b=XyKJ0+DuzsNIfpuWJgzE9vgkEjme2PbHxUhIFGDYXTLkdFkaUD53ta+sisj0eZaf/N
         efJ3O8ZB52QKaK9eXFSsnQERyYkbPvE9WKX9fMVxrqWTgcpLVdNJzQEcXLcJ4Q1hVer1
         QNGqtR8x+DJz8OoCUEeGgcXTr5l2N9nlaXvT3ngNv0bOPLv5bacD6DADb7d+HgaNfzcr
         +S3w0yM5QpIVgobJK54UIne2myM62bFrrLk5oVPoTOwb4BTlFji4cnIJvjI8s9kiworf
         R0KDbv6l6Xd9g54tbKFgowaNdX1rKnE7mFip/1PVLerxXzUysZp635Qkxt4YuHqAEzXX
         K7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753379874; x=1753984674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8UvJuIn0OPJI+DjMgO3jk5kaVoeuzRgCCA1dECQ/gA=;
        b=Hd4ZwNS9WdAk535wPvyFYoCX7uksAHrQpoAPaAwHUFG7jsbU7sJelhyUiwCavRtVqA
         PG0ArgdRMinZpJ61X8deMXf54H5n+Thnh2pSW5h2GxmnWJ7K+rZYwmReFbDnzGlxgdpB
         mCbgwqF5fDh+VjEd8/FimVUsMOSIn54HHPkRQVg1i9XLBL2+EybMgD0BOaO2lhsO5Von
         GOBzUw2Hy8lAktb6Q9MEL6ZNe7aUhcpX6Fw8hFflQuZpYPkIHVd9Nw5IxJcIaHeLUA7A
         bOY4KZO86Y01TgEKCio6w+7xakVSxXDN7MGL1GHOCfihiyMIWG/WGxsodKN9H31aROdj
         EMag==
X-Forwarded-Encrypted: i=1; AJvYcCWqbHudGbm/WgmouOhhhF2vkIdIN53LRZHs7ODhD+ZVHzmw9Oz3og5I0n3ejZTIB5ISCUDRS8qZKgATOQs=@vger.kernel.org, AJvYcCXq5SJHDSvICephh8iP5bQh04jeAB/lAGKJT2uAC13OTBSZt2sF1CBbLdHOKM9uZlkPWgrKc5VrFTzavc65X8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1pCRVvUkuuOv5Nc9Ah1P/SS3PnslB0MWL/0MfbR0ESxllWu61
	qDTcbKtCf+6IIOJNFFaiJLbpe83I86mVibpOmZN5AhRHK67zK+/ivcLuEWmhixtXHUMalYpdali
	P3WYLLZlq48jWZZ/vjlDy2moT2we/IzI=
X-Gm-Gg: ASbGncsZajwBdXcLQiItKs4zHpx857fJph4ZQihfteAJZiu3y7HuTAnaNvErcDP8nT/
	ir7VimcbSIfY2bZd4DoaLbAmPR+tIAMJwlXyIqQZIFrf6B712gb8uTMEVAtKApkpPl6afovox4P
	s6SBPxY3qNXJ7IczsijrIKTJ0Mb1jB668LnvkZOPcEZAJLMpahspUo1jwRPmVcSATEdbCA9GiH3
	UqjhLrd
X-Google-Smtp-Source: AGHT+IEAhOyud9kcbqXxowjJUbxNlqWbJT7GJpdyKPEF2m9XE+mf16rjfgmV2MlnEZtVjRLDvU7+lrC48/cD3la2z1c=
X-Received: by 2002:a17:903:1aac:b0:23f:9aae:6f0d with SMTP id
 d9443c01a7336-23f9aae7183mr37615165ad.6.1753379873956; Thu, 24 Jul 2025
 10:57:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724165441.2105632-1-ojeda@kernel.org> <DBKG6CA32OO0.368N1Y6VMIUTL@kernel.org>
In-Reply-To: <DBKG6CA32OO0.368N1Y6VMIUTL@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 24 Jul 2025 19:57:40 +0200
X-Gm-Features: Ac12FXwN0CMehniS1G7J0FWaHdQIDWYqXa1YTpgsiVMs45pPNA405NE1QlSsAHI
Message-ID: <CANiq72ktx9JsTXN_HTfjGWHxpBh430tkxHE2xL_1BQB2yb16rA@mail.gmail.com>
Subject: Re: [PATCH] drm: nova-drm: fix 32-bit arm build
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alex Gaynor <alex.gaynor@gmail.com>, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 7:05=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> I think I will follow up with a function to perform the conversion in a s=
ingle
> place, but I really like the idea of a special clippy annotation to tell =
clippy
> to not warn about unnecessary into() conversions for a specific type alia=
s, such
> as ResourceSize.
>
> Do we agree that we want something like this? Do we even have a feature r=
equest
> for this already?

I think we should at least ask -- done here:

    https://github.com/rust-lang/rust-clippy/issues/15337

Though, thinking about it, an explicit function may provide value
nevertheless to clearly see where this happens, and it also means that
when we see `into()` we know it cannot be a no-op.

Having said that, regardless of what we do for that lint, giving more
information to the compiler is generally a good idea, even if only for
notes/diagnostics etc.

Cheers,
Miguel

