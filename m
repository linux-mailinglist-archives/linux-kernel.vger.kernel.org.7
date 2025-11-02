Return-Path: <linux-kernel+bounces-881791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F7BC28EE1
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 13:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 271751883FBF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 12:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB82259CAF;
	Sun,  2 Nov 2025 12:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNF+/GA+"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6231411DE
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 12:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762084854; cv=none; b=k78jgx416LMkVgobcyuTNinfL/m3NCQtiilkAlH8NzRWjZeqDIeTdppnsBwHjUo9p/+vTqooRW65pJR6i2deK9CkPNq6fFVEOz9aNGhIL8PIbObLRC2BsvL1UGvLcluE8n8GPYRZ5MeHZbtInQ26otAke5oV3vjjXFmuS9pkTnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762084854; c=relaxed/simple;
	bh=ImPMRxZE4lvqKQdH+wgO71LR1NW3tyk8kMwFImMi8M8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gu2XkcySRaNXXlcI8VqPN/Qa/czd9HQ25pho2HDb7d61ud/cg/dIOCxrW+ODa176H/goEkzU7nVfYm+g1MhD4BHSkKheMFvD3A1t73FEdf18FSTQuuChh02aApMWkT6IJJGnYIu7Eiy8crzfTRoiO90Jz+cYTEelc5vXmrdoSvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNF+/GA+; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a271fc7e6bso644343b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 04:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762084852; x=1762689652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImPMRxZE4lvqKQdH+wgO71LR1NW3tyk8kMwFImMi8M8=;
        b=WNF+/GA+oenV6oX0hToWpSZCPYGFt35BVbRPVsIX8XJSYp8Hd7i1pRt++3/2ZATxAi
         CWjUa2/oFWjBSqFP7i2OvOX97HKMsclwvHGQa1aLQLyHMqNHw3/u+bk+y7Ml+kW+77Ih
         4OCFE+jByBkJMBfGDRt3azoe9mADmHCZ2+6z9ZpYk0nzGkH0u9ViTaaEdYQSRYgh+BG+
         kBSlBHgmRXTdL3XakBeqkW6qB+oDRPo3fyCccn8r/00o/ezxRhThCcHi7aARiHVem/x8
         He+8qz0nfXXOBoZ8Hqn1Mg35J5HWxiOrufhQwlRVyTz7Mpwmg99UQfg8mZBIoUWic4Eu
         AL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762084852; x=1762689652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ImPMRxZE4lvqKQdH+wgO71LR1NW3tyk8kMwFImMi8M8=;
        b=MoAQlEWOnxUz1Mpcd+yQmFtNgfDK4pYOKkjTGKIBWj35sn42KLE6N8odHDQWgsM5Yw
         I1GkcaZyiKQFz28OzP/yYlx8Z046uQlylb+9aUmukEqavWfmcO174Dm7Meh36dYZOyFa
         ufbEhCHBSSofwCx3vAwl/3IgQTJqrQ8Gsv4khzIhdxmaJevmJ2FgCrNP5G45srBz/GQT
         OokYg0WChwpto5koPUXGuVHXPmFVe0KcKl4yPDc7eLwy2w7XwCMt2spF9cg0rVH9RACZ
         KCeOW/ZdbAb8p4NTTQ2vZ8tujFfDEeRNzvcVvf6RuJr5Kjqi7BriADa9HaNamxZQckuX
         6X7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzGDHBaUXs8hT3H0+6m+dR/TKhdv3kIjw79VWBXl8nMdMdtuKpXrRmRNc6s0OqExBoaobPR0YfZ+2B0IU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCbhgq2Jv7fU5mPwopQhAoYjP9Ji1rokTb80jnvd8dy+kZljFy
	TrZbzGfj+BZDiaIiid//OP6E9bNyKohbrtf+gwCBCTwpN7v97+DlXzHufwkliM88GF9cNfIsHge
	34Vpw7F/isNY/V2Zm7krz/gO8frPmzbk=
X-Gm-Gg: ASbGncv0tzDvUa7Iu/rGzCBP/U6nt8uUZkqLqjyN7uXvxxol7gwpvZX7s7BHqlAGCzY
	U8zRku36pEkPtpr5xv7brwo9IAKr2DFQdloc70uUhmhEkza4dUIK6zEj5dJ5jemvTXocJKX8eZx
	fB0Shqz6ayOqKhd0djMyEagSrQ/KdbjCKr2v1s9a7NPfdksexwocDlSe2OB8sxcYO9ROKQi9n6m
	YsByj3fY7jvbPFZrJdxYsqn4txW7LoeEenV+qv9LBc7jz+Cu8MasPpi/pH74vsedn+jVTfI+6sX
	vKHaeEB994PC3Zbwrq7Jx6wIRNDhyX1BlhMYzLYnslNYoM/dSPoLpbjxx2TDvDI7NSSPkiH9f2A
	FQL8i4DuYR1o1kA==
X-Google-Smtp-Source: AGHT+IFlgxIxcweJjpgvdwNQZG2ObtUFGP6xwJxym9cLEe/yblvm5Um+k4aAXaoyZYzWM0OT+gOTsLm5UbIq0wEpl3A=
X-Received: by 2002:a17:902:ec87:b0:295:8da5:c633 with SMTP id
 d9443c01a7336-2958da5cad3mr14628385ad.10.1762084851701; Sun, 02 Nov 2025
 04:00:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101-b4-as-flattened-v1-1-860f2ebeedfd@nvidia.com>
 <CANiq72n6KLjA5XQmAhy=SRTnWY8sCCmp9ETnB-dTSVZ84-mjzw@mail.gmail.com> <DDXUPAELH6C2.3JK5JVGP87V8N@nvidia.com>
In-Reply-To: <DDXUPAELH6C2.3JK5JVGP87V8N@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 2 Nov 2025 13:00:38 +0100
X-Gm-Features: AWmQ_blSZ_mArdZ9J5G_VoH8zTPY8nJrqB6TsxhMMXSS3qgYUhTO7Nq8nGrdlro
Message-ID: <CANiq72nakhVrfK=pyz8VBo95NJHpoeDXRkqUBc4GXSdroYuAQQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] rust: enable slice_flatten feature and abstract it
 through an extension trait
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 2, 2025 at 3:25=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.c=
om> wrote:
>
> Also not all of these seem to be tied to a feature;
> `RUSTC_HAS_FILE_AS_C_STR` appears to refer to the
> `Location::file_as_c_str` method, which is behind the `file_with_nul`
> feature.

So what happens there is that there are 3 states: "not implemented",
"unstable" and "unstable but changed". That is, one transition is when
the stdlib added it and the other when it changed.

Now, normally there are only 2: "not implemented" and "unstable", and
thus using the feature name makes sense there, because we use the
Kconfig symbol to enable the feature conditionally, not individual
methods (and a feature may contain different methods or even language
features etc.).

There is also the "stable" state of course -- the features don't get
removed internally when stabilized, and in fact there is a lint that
tells you about it (using that information), but we allow it, so it
all works without extra complexity.

In this case, we have 2 states but the other ones: "unstable" and
"unstable but changed", because `slice_flatten` exists for way longer
than our MSRV. And for this transition, for the other feature, we used
the renamed method name, which makes sense since that is what got
renamed, e.g. it could happen that a feature has 10 methods, and 2 get
renamed in version X.

So I think what you have in your patch actually makes more sense,
since you are in the rename transition, not the feature addition one
(i.e. we unconditionally enable `slice_flatten`).

I guess we could come up with a different naming scheme to distinguish
both cases or similar. For instance, we could add `FEATURE_` to the
cases of the first transition. Anyway, it is not a big deal since we
don't expect to have a ton of these -- quite the opposite, hopefully
we can get rid them soon. And I wouldn't invert the logic of those
equations, I think that gets even more confusing.

So apologies for the noise there :) At least I hope it clarifies a bit...

Cheers,
Miguel

