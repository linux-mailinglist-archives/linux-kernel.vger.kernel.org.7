Return-Path: <linux-kernel+bounces-729186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DC5B032E7
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 22:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B092116735E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 20:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07211285C98;
	Sun, 13 Jul 2025 20:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrYCjA1E"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2157C13AD1C;
	Sun, 13 Jul 2025 20:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752438837; cv=none; b=rD+gYeSvE6pGRffJPwOswFaZgcdyb+yI0wH8BkBYcsc/1D5hWTq3QztlAEp6z8QnV3oF2FxI8uBR1gOn5XIIApRzIWTZ57FmYcv9PoB/6Vv75+ZzADXmH5NjlVzHZ1mgIiAb6+H1M4/NL9vlzyjdfHLmfn4B6hfNFLGJ9yBu31M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752438837; c=relaxed/simple;
	bh=P6uc1vFP+hnSDoQ+DeA9YI99SP+F92h3RQ3e6uHt6oM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UpN1MDgI7/ocQ/NGFh2mgOAV1VX4oBE3eIUIboenpeh9QNEgfLrtyoPpC13SWXF/dzFlgA4dC+W99s/ghWfp7/2Gkfe8h3NcwJnSpFEkovO1oGj15cG437x7pCqYIFNNe8+nobyvvDqZccpBvJHTYZT9Au2kOYlGCt0CWneM768=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrYCjA1E; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-234eaea2e4eso4347145ad.0;
        Sun, 13 Jul 2025 13:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752438834; x=1753043634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmXBFNSCdNzdGebBofDUcBBgvM0eW9t5GlHoCUn8/mE=;
        b=WrYCjA1EhVbrV+C7Cawz7d1Idmhbi2IZFmqhf/38dQ5vmuDD02vvNuuHzziMEPMa52
         X4FAUhuf/7qKGoeJAv3audGHA6/3pdQ+u55h/r00QFytvRC5EG5aW+kuxLlNBMbI4hhE
         7PK0UYCby8q4o9knDGpfljKGNcqUUUUTd9Wb2QabLZ7uDOKFM11B4bSSS0rTT/UW8Jmr
         PzjkqV3l7mOR0XuQjMmvz6YavAbmejT7eqVCIst2QXe180G9vSJ33n4YxE5aJY7u238z
         VdR/q0yYcZqFqSHMK/GkiZX5wVXvuRAUvwg//kh7OdFvjS4NLMXQrYOMQNiFHVaDSzyO
         Zwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752438834; x=1753043634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZmXBFNSCdNzdGebBofDUcBBgvM0eW9t5GlHoCUn8/mE=;
        b=SkWYsdNPoEy/yYNYdE9WAedaasaBkpHbzDpmQmpwufNLG4PmsO3YqVzMbd6QgjKtDx
         wAk3wly7skctYFmGf+K/qX1WpGb2krhEBI4nx5MaRGhkVxClzlUj9cLtpIWFDnIwDOfY
         +Vint3B6B0LfN5M8kf4h/STH0+SxPKJ7f2Kugq6oq4+UwoD+FQ038e2D4dgY+hXiNrHV
         cdAhqGSrGSBzDRs4qaqNCKL94AdjwbIXidWS7Ld0SbknzoDFGdjGP3+frt5Bg8g+RJ8B
         1ngIi8v1ADjPQKkHHdO3UDg4ll2r1bT0xgkoaekXh2LTW882EF+JwZvCIdR8vRxmBxZ5
         27hw==
X-Forwarded-Encrypted: i=1; AJvYcCVkt9jV+wVvSUZY5aBNTEPTlO9SW+tLpM2610HAdGltJzKlRnm1ctiUWQFmK/QBe09LUEj1NoEmwQ4oUAc=@vger.kernel.org, AJvYcCXHJepddDb0MjGyOZLNLaNHeR4ktCxuiE8Mz9FSWNb5PLua7LwoOSk44Vpzg+JspMZIcZsHIEuxmEzxHSpbulk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze78Bg7FbhYzAQFsbyIwjq/gJMYk2iQLtLQmMeEUfVJk3Npr8r
	LLDrARsgBA5Ai0RMVytGg7th6XGhd+X+yB2GZKpBSXoDprXeVDx8K/6Nnd+u6X3k8RMiqBY4Exa
	k76RYBjxXDHecqMWJG+yQiwDwqEexUGywdP50Pa8=
X-Gm-Gg: ASbGnct9D8G1hlbdgxGXGVRjrK3Z1TmYVWgBXUx44TZzUxtArXfzzEQQ6GSjKdBbGqo
	k7nZqJmFuwV9c8Ip2np+LHnZym64zDmfw2QBemng9tRPWidgUMu0MHW70FX89jkgXVr89qS5N4x
	HaAZzrOMiwIhkA49ESA0l6lJsgUSmbkL7/rSfdtq64/5Jvt4pWk6YZg3F5/lTCPEAmR6nI/+x+A
	3v292J+
X-Google-Smtp-Source: AGHT+IHN9gHToXFx7qSAICPfNo9uTuuKOtEdftwKY3pThhr0Bi6GfZTjIAB5CeEZl4h7fH9wpPuZOb7wU2SynSXiRCQ=
X-Received: by 2002:a17:902:e5c1:b0:235:e8da:8f4 with SMTP id
 d9443c01a7336-23dedcaa7f5mr61698505ad.0.1752438834404; Sun, 13 Jul 2025
 13:33:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-init-remove-old-workaround-v1-1-a922d32338d2@gmail.com>
In-Reply-To: <20250709-init-remove-old-workaround-v1-1-a922d32338d2@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 13 Jul 2025 22:33:42 +0200
X-Gm-Features: Ac12FXzAOInvGmyWVwzT-OopSWzvIkNJ21Mv2hiw_SBJD06XKbosWHqvwtzqZsA
Message-ID: <CANiq72nWZA_yb3G+E7TAcQTf431XfCEB_u8EMQg=x8EjvkxTkA@mail.gmail.com>
Subject: Re: [PATCH] rust: init: remove old workaround
To: Tamir Duberstein <tamird@gmail.com>
Cc: Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 12:34=E2=80=AFAM Tamir Duberstein <tamird@gmail.com=
> wrote:
>
> `Error::from_errno` is `pub` since commit 5ed147473458 ("rust: error:
> make conversion functions public"), thus remove this workaround which is
> no longer needed.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

This seems the same as this one applied a few weeks ago:

    https://lore.kernel.org/rust-for-linux/20250526152914.2453949-2-ojeda@k=
ernel.org/

Cheers,
Miguel

