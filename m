Return-Path: <linux-kernel+bounces-892932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BECE6C46284
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 548393A9C7A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1CA30C37A;
	Mon, 10 Nov 2025 11:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgLvWUIj"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAEC30B52F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773015; cv=none; b=jnEM0B5evhVr1OxWBVTfV14eElM/z34gsXGaSzXhSQxnRD/88vaxnWIl+OtfnJUK6dElJgxiNYambzJCS9AIDmtRvUaKk7FO4hGm33/CbdWWW7qPkIwF0wlyY3H4/I1jy8dxZWWAqu3I15mmBCP4SsYSpDp1opWooKwaN2M379w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773015; c=relaxed/simple;
	bh=qYod02zCx1H/VIglPSYtMCLBMHqDjGDF49aeweBgJ6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+uOxOoGmPm32IFEmLb2y+IvcUELH/FplGFGctQg+vReZwnpCbqKZsG6TK35NAcBGHdZUVN7VnAWoLZp+VCu1EXjg/8LZrkAwwGDjnJa4+asDUn3vvT4p4SsAsXmQRdPLsKHQj3CHy5jDI09xJ4i4WrJWYgOwhmG7VVHH8g+iJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgLvWUIj; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b997ae045b7so234004a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 03:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762773013; x=1763377813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYod02zCx1H/VIglPSYtMCLBMHqDjGDF49aeweBgJ6E=;
        b=UgLvWUIjzQk8VSMa2U+laJQrFNGM4W5Hk1rmIuPuSrK9Vj9TwXmMbnzEjulN/PKW7K
         3dpURacGdJNl5DAwLfkz4/djY4g8etVYltVz8hyh6vOAgPSsdaqLnzHFQol7saPx9k/6
         p6JZsxUqUIXTz+oONrniSMuZhG7Z7nKfuwiq2vMrTQL3ts959pzMG1CK1cAfkNjcDaYS
         bNWUEMEOAORCWWZquUl7f5Z2k0DZef9fBQPnhSogNVoF1qVQIoHQcPjC2JzoYh0sy2NA
         hUmgcO0oajwid+mUrxJrmAgwDdNbDKk1Z46SWSNzL232B45WXDoZwFcS9uD0T5el90xE
         CyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762773013; x=1763377813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qYod02zCx1H/VIglPSYtMCLBMHqDjGDF49aeweBgJ6E=;
        b=pVaN34pfkUotSyIrlGe8hG2zxF+lYNq4Gt0Clpnl4qAk4/XqW9vZUw/eWMhLsvV9h0
         kXA4X9zRY5t5VU+jEP+f8R83xv8nFaGSBrY/yaRJXVHvxJARSQmX7rtH84vCRjY+799R
         bjdfwIiiXnlG79zG7WcPHoaSypwtG1OnelFD88LbLSLzdmuW/iXfF+u0IqqLKizwc2mw
         eBJC3mT1JpYSE31IL1kRA96cPtGFB6OEfAODC9sy4KssEpIZjtz8HFUFFSxFTUmaHFeQ
         hazDk3dH4/uJP7veOJdcwyyZmcvrBsAl98l0b3Cca6C8PkjtkGjhVgdaiIEeIgVh9P+t
         iNqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdhum58JOMXNOZ+Ggxrkhku9xWSY4ckPr97XjCuQDeIJ7+A+qT0WImyu0piyRBT3Z6Sa0VH0uHpgkgWto=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb54iPUM6wjj7S2ebDxBIeILIk4xgYSMCE0lXdCy4kQpZUmNRU
	ITg/i1eB22ekaIwJrzAdvACoygicX3mkQXtgm50pOlf38z5G7/FYNXh0LSD7z1B7CbMLkdrbE1z
	tWOS1505D/DS1PxqFdKHFwReYoEJgSz8=
X-Gm-Gg: ASbGncvzz7Bn6OcmQLxs3GIoQJzqnbTxVci86DwbxLx7UuaVQV6Ti7hq/F4Y5VAv2yC
	egK2CObYf4Y99quJYSGZmGTFVojpJSO9KCB1Le9rmLqbgWQ1gQTCQ7qKKVxMXe0s8s/VdteOhhM
	q989ts0SzzYEHxxVUezoedaeF7YTPXPpQPr6/eepmaXkRwJdGWZJx8zXjjPev6wnecW5WOSN5IN
	c7p4srj3hEcZEQpbgL4K3OFIwY9yQRLay7EKZix+5aGzyZ0DDsl/QsVIgmdKX2OJKiKWMrYrN2e
	Mwj1lcuZoWZaES0AYu3ocz1r91NQ9Qwge60dDiWfc77tjwAKno8dgddeCaXrpPpF/G6lARnzo+m
	TvmfBVQOhWYb46A==
X-Google-Smtp-Source: AGHT+IGVXq7fcQEVvIh5RJVo4EGz3TaqkWRnWgnqaRHyeXV2fhzl5cAwdSbAJFL3N5gLtGPGFbMfA/d7S7FryVq/+Z4=
X-Received: by 2002:a17:902:ecc6:b0:267:8b4f:df1f with SMTP id
 d9443c01a7336-297e561612amr56745215ad.1.1762773013490; Mon, 10 Nov 2025
 03:10:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110095025.1475896-1-ojeda@kernel.org> <20251110095025.1475896-2-ojeda@kernel.org>
 <aRG9VjsaCjsvAwUn@google.com>
In-Reply-To: <aRG9VjsaCjsvAwUn@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 10 Nov 2025 12:10:01 +0100
X-Gm-Features: AWmQ_bl715oPxt8H1J_mTcx-bHvv176_Uy8uXuVHipx3MICAaN0f0Hfn-QJfLWg
Message-ID: <CANiq72nQr8a2Qkt10rPGUgb6DciYQZCsLb-fg8S_ZV=0+Y+ZVg@mail.gmail.com>
Subject: Re: [PATCH 01/18] rust: condvar: avoid `pub` in example
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 11:24=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> The unreachable_pub warning normally does not trigger for documentation
> tests since using `pub` in documentation tests is not wrong. So this
> sounds like a bug in our doc-test setup.

Yeah, we can allow the warning for doctests, that is easy.

In any case, this was needed for the future pin-init, not the current
one, so I should have probably removed it (we had a bigger branch with
the new pin-init).

Cheers,
Miguel

