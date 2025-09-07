Return-Path: <linux-kernel+bounces-804867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9AAB4810F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 00:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09E823A5392
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 22:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E1C22157F;
	Sun,  7 Sep 2025 22:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwAI5989"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE00191F84;
	Sun,  7 Sep 2025 22:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757284313; cv=none; b=R+b9SlbPYn916GyYD86FNu6miZhyKaeJQzIQ8hJBN2YEPOcRjF0RG3YsD0bGUmJ+W9f/lsbWeo/HJElKAYBSvSB8uhIYI5tzY48KIIBmitJQmdBeHpdtWBxe+xqvtmDZaG7NEHeXP69XllPW7DIqpbWoCdZKvK984OA4yt1JKC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757284313; c=relaxed/simple;
	bh=A0iG2s8NsaHXbe7QwSW3kwFQk8Cle6cuWsR/m31eV/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aTATDngnbqYoOIiUDatNCuKZ38CA0yobN/f+ex+J+7gq555wAe7tcCHT48ELGwmS+d8gnw892MIfHNmAodqIPDBJmRFlF0vcnaNvfNh7Lpqm89tobAvplAZ07w4UOHunorwLMIOFz2Zz0jK0GwMRCmRQvGc19RCjFnn+i8OhXEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwAI5989; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32d69b5d737so81850a91.2;
        Sun, 07 Sep 2025 15:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757284310; x=1757889110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0iG2s8NsaHXbe7QwSW3kwFQk8Cle6cuWsR/m31eV/I=;
        b=mwAI5989r7Cm/X+JLk5TJtMOJE2LGeLsmPcorJwwC/M7XaaiplAvbE7EcippL0Wm4U
         GYTEtMBORXBzdbKUtqzFJKEZLnMhVe6ynYKWbeDtR4yK0P9CUXC/Tpol8XJo3coyiG9C
         WFotQbilSaFYEq0k8zCuR52/VgpBNbhHYH6j7ejwsuxHvP/RiAU4jy24byqGBj13W4C4
         cKfIQf6UvuKAL3SGHIzQpoiO+3l/iPnH4xpUPCa36bw1qe6JMKVZZUsmHoQREjXckmfA
         DPnnDPqJT21JXUrL0GAzbajj0WKQWIpfBhZ2jmn3gYZKpTBcnruLaBXl+YRfykomOVTX
         37ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757284310; x=1757889110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0iG2s8NsaHXbe7QwSW3kwFQk8Cle6cuWsR/m31eV/I=;
        b=nuT9nWGWsrFbEMT8PE5rcd4Sr3dtsSpV/ecbsmX8XMt8Eo5+ToNhMOLFodLkkChGRr
         tyTSGMW8LYy8RaM4nlC6FBb9bjPScCr5hIRLlxuogpuo3FEa/FjpUQKqk3wm1CsJVJ38
         JWKEZBJMz6Nj+LuXTJ7MxlJ6IDTi7qpcGoMcV5WcATIQGGieyGiWjQkA2E+vkpp7H0hw
         2dqKRWp/ykxwB/+zWojeotef/0se2/iO3nDIIcUJCOvE9EnYLPhgDuriz5wwYgciNTIu
         lIjqsqQXgQ6UYiH7B9UUMX3o4yDJtG1vyTAfxtLfrubMD/pHBtpKqH7pLK3lQUHedbEi
         s5lQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2Eo3VhWoxIut52YAMx2H4IAmRnqk9X+BMYwkDtkBqGs+Tz1Zgs0V3+THfmxfg2n65Yfie8fmZl9ZfeNg=@vger.kernel.org, AJvYcCWDnGgmYiUIM1OPhiI4J5KZuN/3u9+6iq0s3p3BPQa9xYXcMUysXPKLQlS+Nr/5tgQuLcr/4xgZ1ORNazmSurg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKosxVEQaNIZjeR8BfBUwwNEcFxjI/0pdKRL8BrFXtg9KQl5iX
	ft4LE/M7lAEos21OKTfsClby1/pcdXMa92EEm6WUNie0FUFKuvl/85HReA4dFVM6sUUWWCRrgyw
	5xAUm4614Pik01kgRQdFSTztnLXzvutg=
X-Gm-Gg: ASbGncv/RECrWuPQIHIcdhidoXRP8he+LdQ9xwGfiQ+3amArCNGfOK+aHO6SiEOcfY9
	SJF8EXpSQOpsJVob91UWzrNYL03q/VtRnEat7nq/op7x3fTWdU+Hb0uW60py6bZPsawEnN8eP5i
	jc+yqLw7hJFt3p59mn69dU8P42fyVZsEPMVusCBiyW4ysgnEa/yhIAjHaup92Xu/UvH051aewCD
	NbPFO2jN5eTvXCz+PReXWzeWZ+vQ/5ZtsXb+tyYxHfFDRWH1Jp3Xg22zzzlr2wkW38LoXNuyEV9
	Ik3IEafPeTt4xn2BCEWpZXVY0Q==
X-Google-Smtp-Source: AGHT+IGG3HpNTb2vTtLsVngngSHh/RfU4AOGJ5c2YYlHpsyA55YVHi/hUAcqVhc4ta/9cft44R1aNjISOp66lrDKDo4=
X-Received: by 2002:a17:902:ea01:b0:246:ed8f:c63e with SMTP id
 d9443c01a7336-25168e74592mr39216555ad.0.1757284310209; Sun, 07 Sep 2025
 15:31:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818132551.133410-1-shankari.ak0208@gmail.com>
In-Reply-To: <20250818132551.133410-1-shankari.ak0208@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 8 Sep 2025 00:31:36 +0200
X-Gm-Features: AS18NWDd7uEDj6f6FN-5qorf6Dg1cnOeL99kuze94D4OJRaDY2wvuvmNYpHyxBA
Message-ID: <CANiq72=hMoVto3grUSWbMs+rOXhQifs7vg=+052b8pMkN3Q26Q@mail.gmail.com>
Subject: Re: [PATCH] rust: task: update ARef and AlwaysRefCounted imports from sync::aref
To: Shankari Anand <shankari.ak0208@gmail.com>, Boqun Feng <boqun.feng@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Christian Brauner <brauner@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 3:26=E2=80=AFPM Shankari Anand
<shankari.ak0208@gmail.com> wrote:
>
> Update call sites in `task.rs` to import `ARef` and
> `AlwaysRefCounted` from `sync::aref` instead of `types`.
>
> This aligns with the ongoing effort to move `ARef` and
> `AlwaysRefCounted` to sync.
>
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1173
> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>

Applied to `rust-next` -- thanks everyone!

And thanks Boqun for confirming to go ahead.

Cheers,
Miguel

