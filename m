Return-Path: <linux-kernel+bounces-770439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F28B27ABA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08E841C26845
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B54F21ADA4;
	Fri, 15 Aug 2025 08:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/rxpttw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5491347DD;
	Fri, 15 Aug 2025 08:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755245772; cv=none; b=MIRNrwPqkQY/I3/ag8iGGxFpAHWPo3jNeBV7BB9oKk1mAhae6M8EJsKYekuf2mQZsvMXS2FtWjfxWtFYJ8+MBV3+let8PeX4C74s/KTpAPMrZuMrnuwLicRdv2XHOlojJSpklE46ZEEBrc9NgPlkIZO6WLu8SH+I4ym3qLLo4Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755245772; c=relaxed/simple;
	bh=EnBsv2KuM+YMlktAA95G+A/R+SrkNakjj0KT9Bb+uJ4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Oep0HDAOLM7UYzDQlPNzONDXkFnw5vWIi+9hBgIRsb6zyLk8q6SAeAQJoY9SSEQNHuGsly9SEuM9UzZPAga+UgZkOcudH+/tnOE04R1RJgBXX1Fj07a+X11isTJ6+v93Al1r904jhs1GagKzHpZihkYAjmhRSJf3nsCZGkfw4go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/rxpttw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2894C4CEEB;
	Fri, 15 Aug 2025 08:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755245772;
	bh=EnBsv2KuM+YMlktAA95G+A/R+SrkNakjj0KT9Bb+uJ4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=D/rxpttwz+g1Unn+2V6/KUOU8EsR5BR84ty+3QYkdWhpcq5u/LihO6st5oh4awFhB
	 l2T2w9EseFxB4tpbvhxVviFJQhNd4+f6yGVHYnm4vfBUA5sBMPGm2YoDbq800DjZ5P
	 DUDkN4VbIrYU7d83WRFT4/WGJrK9ILVDRn7AL/YKaPjKlUDBV7OljXN/Qbu9wsOOCh
	 xxnoOgmAcPigkmiAnsBL8kjnaRJaDf2xVms+sTRuO7r8xElrwMuazofjetTYj03B9C
	 WTkZ80nmmVt9ifAVbG+gEM4MNbTlSOuK2uVOkT0PZOpP6XOI93GB1aAysUu1/U/qja
	 9fAhF2kuLnm9w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 15 Aug 2025 10:16:07 +0200
Message-Id: <DC2UP1Q4D5L3.2SOGYHJGXPTWS@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <a.hindborg@linaro.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <viresh.kumar@linaro.org>, <tamird@gmail.com>,
 <dingxiangfei2009@gmail.com>, <gregkh@linuxfoundation.org>,
 <thomas.weissschuh@domain.com>
Subject: Re: [PATCH v2] rust: lib: add if_cfg! macro for conditional
 compilation
From: "Benno Lossin" <lossin@kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Areej Hamid"
 <areejhamid8560@gmail.com>
X-Mailer: aerc 0.20.1
References: <ec0dcd14-e974-43ff-b4f4-3dfe2f31a91c@t-8ch.de>
 <20250814162211.566168-2-areejhamid8560@gmail.com>
 <CANiq72mbTqu8KuKn1uKM8czesrg+or-S3K9e_ohJz1b6kzdffw@mail.gmail.com>
In-Reply-To: <CANiq72mbTqu8KuKn1uKM8czesrg+or-S3K9e_ohJz1b6kzdffw@mail.gmail.com>

On Thu Aug 14, 2025 at 8:49 PM CEST, Miguel Ojeda wrote:
> By the way, Tamir suggested in the linked Rust for Linux issue to
> match the name of the upstream one in case we want to migrate to the
> standard library one eventually. In the commit message, I would also
> mention this and link to the tracking issue that Trevor mentioned:
> https://github.com/rust-lang/rust/issues/115585.

Didn't we also want to vendor the `cfg-if` crate? Or am I missing
something?

> Finally, we may want to consider putting this into somewhere else,
> rather than the root file of the crate.

Yeah, let's have it in a `cfg_if.rs` or whatever the macro will be
called.

---
Cheers,
Benno

