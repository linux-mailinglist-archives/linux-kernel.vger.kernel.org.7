Return-Path: <linux-kernel+bounces-863224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4E6BF7497
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DD1E403F6E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302B0340DA5;
	Tue, 21 Oct 2025 15:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihG4IOS3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CB4175A5;
	Tue, 21 Oct 2025 15:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761060049; cv=none; b=lEhGBdxwJwhXYlP9PqSa/16SWyOM6xnfdgXLmmMqd9MXVBWZLFY5TztGZojKR2omEEl8XeapCpPRcIOW/PheH9ZXWEB0YXpFLwzIDB+iSsD4tgNwPaibWqBIl1/HM4tkasNCocBQ44tHe6dxcswQVdonAdGXXGa7c3vDAJkz72k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761060049; c=relaxed/simple;
	bh=FlKhdSj18RuP+dRMPDXQQzSP9m3wGXtoNXCkiETpoIQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=fVi0qpZoRyffVeYFe21m4mSZSAWmXWwCfqHG576w8tnFEy2HX8dmr8WU+U4ut3f1520DEgtRrL10U9NBMSqUGivUfmhmWfzdSGYO/AgQem2J5JP3FqbbtuMKTP6cKpSM11sZjPUl5OuAkeegL+E3vrQwicf7moO2cer1pZXvUOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihG4IOS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B566C4CEF5;
	Tue, 21 Oct 2025 15:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761060047;
	bh=FlKhdSj18RuP+dRMPDXQQzSP9m3wGXtoNXCkiETpoIQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=ihG4IOS3gUXNaTenMxIo9xU0NFu4B2EDiRLYXmz4/XV5PcBN1DoEiK3a/+ZS9NGB9
	 cDJryp9Mz5+I2X6/WH2hVUuVfynUFMqrDRZsm4AbtBH5fg61LttRF8EZlt0ION7p/W
	 +KQpwqILyaaEiwPcw4cGlAFj5VbOPWInoPDvDBpc7WszNbXOp+hQcbnsmARueWHplF
	 CpA1clWjJNVyx4orWIs3RO1emgNF7T5Wm6XVgzosu3YH5l9rfegyk/38oz/hpt3TtZ
	 +qCQyRNqJS/6zQ+5x+pN6y0TiTs258qucgX/5e5m3H/AVmD04/aYDJY6pylbLfMgr0
	 ClDauD/ETO9yg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Oct 2025 17:20:41 +0200
Message-Id: <DDO3OMBHS8TB.2LDODR1AFRCU3@kernel.org>
Subject: Re: [PATCH v2 1/2] rust: add udelay() function
Cc: "FUJITA Tomonori" <fujita.tomonori@gmail.com>, <aliceryhl@google.com>,
 <daniel.almeida@collabora.com>, <a.hindborg@kernel.org>,
 <alex.gaynor@gmail.com>, <ojeda@kernel.org>, <anna-maria@linutronix.de>,
 <bjorn3_gh@protonmail.com>, <boqun.feng@gmail.com>, <frederic@kernel.org>,
 <gary@garyguo.net>, <jstultz@google.com>, <linux-kernel@vger.kernel.org>,
 <lossin@kernel.org>, <lyude@redhat.com>, <rust-for-linux@vger.kernel.org>,
 <sboyd@kernel.org>, <tglx@linutronix.de>, <tmgross@umich.edu>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251021071146.2357069-1-fujita.tomonori@gmail.com>
 <20251021071146.2357069-2-fujita.tomonori@gmail.com>
 <DDNZL452A8JR.K1AA7LHZEXW8@kernel.org>
 <CANiq72m+uAWyRf6y6vAKjCQnwsMqVVGQx3VrHW1yAp4a-5eWew@mail.gmail.com>
 <54328318-c235-413a-a069-5ea93f1dcb2b@kernel.org>
 <CANiq72=eOYk=WM5xfMkHj-REYjedYiYNakVvfto-AUL5E0O8qA@mail.gmail.com>
 <DDO3G26SIZTK.1KV7Q0PQXHWTA@kernel.org>
 <CANiq72nUiizxo3YFgxUZ1jiczRNbY2ATao2YUBiCEC7k5hbv6Q@mail.gmail.com>
In-Reply-To: <CANiq72nUiizxo3YFgxUZ1jiczRNbY2ATao2YUBiCEC7k5hbv6Q@mail.gmail.com>

On Tue Oct 21, 2025 at 5:13 PM CEST, Miguel Ojeda wrote:
> i.e. if they aren't sure what the value is, then I would prefer they
> clamp it explicitly on the callee side (or we provide an explicitly
> clamped version if it is a common case, but it seems to me runtime
> values are already the minority).

Absolutely! Especially given the context udelay() is introduced
(read_poll_timeout_atomic()), the compile time checked version is what we r=
eally
want.

Maybe we should even defer a runtime checked / clamped version until it is
actually needed.

