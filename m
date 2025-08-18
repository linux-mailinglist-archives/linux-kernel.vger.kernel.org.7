Return-Path: <linux-kernel+bounces-774506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E7CB2B354
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 23:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E99C7A74E9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262CD2737E3;
	Mon, 18 Aug 2025 21:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TYafCGnY"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC5C3451D0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 21:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755552168; cv=none; b=bY2eR/TNRbwOfVZrV2ZHBHwYkCJS5ZXLjM5EvcJQYilqGF5tcEEaLlx2Rf2iN1gIegMws1pUTe3kr1YUmlkTqj0VwLFbhcRqXrxSTSlpKM9zz2PrO1KyIB3G9cw0F2+u3C0F9U2c2PwQxm6Azp/LxHCcmtFKQVMKBnf3ieDT7jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755552168; c=relaxed/simple;
	bh=SV0SovoncvtQUIWdiz5ZimeTSUpDBwkq5eqoPwW+Sy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jg0nQx+3ALDuMgaSx2rjkxh4sEqZQGs1zkErT/OrVzWZOMQKnC3UnHqadkYaww+jNJuzmqcO71ERGQEXsZURq/sdrAtAZ6MgwXCjOPP61AjG9e0C4VfizuQKWqaZpEPEsLvxBe3r/4jNra/utw2v0CZ7onfLxAE8sMaIEgkz0Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TYafCGnY; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso1144134b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755552165; x=1756156965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SV0SovoncvtQUIWdiz5ZimeTSUpDBwkq5eqoPwW+Sy4=;
        b=TYafCGnYL/KXogHJLkvcXm3NOyc4KE4KkR2QZ513U1WcBGTJsFVPVFqNXzU4iWNMEc
         lCTXxMJs869490o/wIGJbf9EaEGTBPAlSLzVELa+ipCNCswRw0WdOTNeRAKYq+iyfOb6
         t3X0oqwGoxFYhGMHzngc8AERibyBQ1G8V3seOWdZ28MlPuMDY+xZWzLpPqSPLVOyKAsh
         W2rnZyPDyANwOkC6E16dN+KRCAYh3IiaRJFVdVwgmGsmLL99mBMuq1Gc0thfhFnwvZpQ
         rX/BaoZkYALKSugMMOhmAi3qxMxItSZlubNWQ+ayiMum/1jBT+twJ5kFb9tPJuKgVGP0
         kdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755552165; x=1756156965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SV0SovoncvtQUIWdiz5ZimeTSUpDBwkq5eqoPwW+Sy4=;
        b=vrDYCnKe+BZJmbPoHjtQS8lY0UB33oLdWVNPoGEO8Ssib4guvvbWT4gvYqL9xzYcAA
         I9nSXNpnLjUiDQUsMiRJ3fTjogV17u1en7Wfl24uhU02JW3xGZwUvnC8oxVtTr2S2Ah7
         L1LdYXG1tNhpFpGVFLmAoT8m7WfmjYcKpORysICxQsehGgklckg6wwNU/U/wEmqmydlj
         Lf5Uq4OCGQS5pDSVYLyT2KUcWV9HsacESv/t4wsBBJ+WsaX+1gKOFJCn2od6RFGMysIZ
         sQ+TYXkCOkrZJJ2NjPbmT9Jk+VXKyIjOuCzdSwiBKOhWyFA0qMaTjJLbfMNFJxOOL6kV
         gzrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXVB0I0xqaVVHEiWq0JP+KMh8itrDOu5SG4oV9dwk92IXcTwfa+bJpcNKGB3/DGgbU3KAjwWmqzzNlrs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpY8skgZkGj9PA7xEO+2Y/2EH/9iRORb78PEs3hf0DynJSckZl
	aVb9RII37eHeuqZcIcyT6n4RJU6zGRfnqB+LfEISl9FlHQpJR31a8YDLmLhiUbNHquFKdJZk4Hm
	9LuX9eKJICFOOey7hqXDbz5wzBHQK+ocV3wSP1/Xn
X-Gm-Gg: ASbGncvptbUBes7y2LCc0VqTuCaTfzcSF4BNCcIAMeHAs0BaHs2sBlKenMwW3+sLedq
	1NQd7pE0Fppazx67Op5qyLp6j4ugwRVqMXKnMRFKGQNiZp4dCghqv1K4PeFqZS5c/aYwBLLGSOx
	S6+H+0IaYMWTS8A86M+RR0FCGu952xZv1PtxI623717BCSMSuehK4uZ32FEWJIdfP0lGiz2PHb1
	dsp6nw=
X-Google-Smtp-Source: AGHT+IFrpf2SwebDg+GiltDgtPrrGLf0iUO2py4Zq3qOIraT9VCfP5Xv4Pr/eE1gzrWGIUk8h6MeQPTZ/yeBUsgJzAo=
X-Received: by 2002:a05:6a21:3282:b0:22b:3da9:fb33 with SMTP id
 adf61e73a8af0-2430d2fa39bmr98481637.12.1755552165437; Mon, 18 Aug 2025
 14:22:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250816114409.10107-1-shankari.ak0208@gmail.com> <aKKdULYbLFRMS9qe@mail.hallyn.com>
In-Reply-To: <aKKdULYbLFRMS9qe@mail.hallyn.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 18 Aug 2025 17:22:33 -0400
X-Gm-Features: Ac12FXwqH4hs8Wu1pRkY76N_A0MiHuz9hahX6-bMGzQ9hZA7cdN0mZsOzdI8Fsc
Message-ID: <CAHC9VhRwpYx0jVybcAnGdm4AGDno-GwyCzZCS7U+56Fwu2tuCg@mail.gmail.com>
Subject: Re: [PATCH] rust: cred: update AlwaysRefCounted import to sync::aref
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Shankari Anand <shankari.ak0208@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 17, 2025 at 11:26=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com>=
 wrote:
> On Sat, Aug 16, 2025 at 05:14:09PM +0530, Shankari Anand wrote:
> > Update the import of `AlwaysRefCounted` in `cred.rs` to use `sync::aref=
`
> > instead of `types`.
>
> Thank you for forwarding, Miguel.
>
> As far as I can see from the included links, this looks good.
>
> > This is part of the ongoing effort to move `ARef` and
> > `AlwaysRefCounted` to the `sync` module for better modularity.
> >
> > Suggested-by: Benno Lossin <lossin@kernel.org>
> > Link: https://github.com/Rust-for-Linux/linux/issues/1173
> > Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
>
> Acked-by: Serge Hallyn <serge@hallyn.com>

As mentioned previously, I'm still not well versed in Rust so as long
as Serge is happy with it, I'm good with it too :)

I'm guessing it probably makes sense to include rust/kernel/cred.rs in
the creds MAINTAINERS section just as we did (or will do) with the LSM
Rust shim?

--=20
paul-moore.com

