Return-Path: <linux-kernel+bounces-869194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D659EC073EE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E00F1B834E6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29933272805;
	Fri, 24 Oct 2025 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="YsMGk5G2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CYUcwwKJ"
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E041FC7C5;
	Fri, 24 Oct 2025 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322617; cv=none; b=gpnL8BFnh6RlKyF1P++qltb4e+nRRa2QIb+5HU3soYn+M5WxtfssWBQhrUHh/JLRwZJi+ILjBG7g8Jka1fupn0LGCnp77OsUWCy9SfxEb5rJNUUo+kNmsFZYttJrgkC5hh8Fvs8Axw8yowd363sXtfByIezQ6pIeTWrmShVvfvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322617; c=relaxed/simple;
	bh=K7yYTqiR0royI2noh1oE3d68mswInGqVewIkm4N72qo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=X3wFDBE50DKeRWV7RLiEP7HHW36Lt74p4egB4GE9jMP7claB2UHuQBg5VplXRKPjQGQqLhN/zRg7BK+XN4m9WQJGMUFjiu6/FFkojOqMdBIw90MoCXnGTdv00A+ekI2zysRYNiFyLZ8W4Y47Myg2Mm2Ar8Gt5CyV1LKpmXBD5pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=YsMGk5G2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CYUcwwKJ; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 781AF1D0019E;
	Fri, 24 Oct 2025 12:16:53 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 24 Oct 2025 12:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761322613;
	 x=1761409013; bh=K7yYTqiR0royI2noh1oE3d68mswInGqVewIkm4N72qo=; b=
	YsMGk5G2q4dVUrpCgzfG5eqHj97P4kyC8OJdMqmdHiKPcBItAhQkQDSXU/fa3JyB
	UMwWLiSQBr92YQlWGfbJddnQE8/JvzlW7o1I9m1o6Uwchm7CqoLEL30V8kh6OrqP
	Yw2I0Kry0+NzkbFdOKud878bTaxfqfu+GEXYntbAs+49/OiPmvv/1tHahBJ2cTTF
	BzK9E7WS4giFELLQNNA1YfJU90Tgb95TRLWg6LlHfX4jy7eJts5PS+uxUXI4wI6M
	1JtgIj25Wf7I5HIucqC73OgK4fRqrt+M+ODtZK+PA45iAOhVpwNw5nU31Nt6izLg
	x2GCrwrjoa5UxnFyNe6+xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761322613; x=
	1761409013; bh=K7yYTqiR0royI2noh1oE3d68mswInGqVewIkm4N72qo=; b=C
	YUcwwKJLyg6RiRsB3VrlF7J7ztHWb5PB1D9i2YhN+ODmpKIPlUVOawd6Kxx5RfuM
	3QaGRlEqM3hNWtnWjXA4DrOWqQxiQRer5bjwJhIhP/aM16J05+k2yS+NOe3ATxw+
	a1yjs/gP1FELnYZS1o3NpuOhC86TWDjIWtMqIcmx9NRMFlFaIsHpYC5Xo74BwGU4
	lvzGkX94TS7+Jq2tsoRkmz9mYW2IMLahNN0RZbtgHsQ8M9w6J1hSq49fVtW00vDm
	28lTxhbD2fsTniu4kEgWc5GDWCJPUoBqzBQ3cbZtLq+kp706b1cchcJcwd57cXiw
	Hd/9Tly5I7kBoupohHG/g==
X-ME-Sender: <xms:dKb7aPOx6HtXEO2SLCwHEa4KvykLgvvlqV6B_uyc3kMuv98HHs2qMw>
    <xme:dKb7aEzqhnN5M-mbHHeFB8MvLZzmH8VzCchpmP6QqDl-ow_zTGAY7esK4qtWsQbjw
    auWTT4hnXFMApDVVY1Oqhf8ygOj7lO3Ay6Up4HvaqIXPSmSfO_pkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeelkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegrlh
    gvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghoqhhunhdrfhgv
    nhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohephihurhihrdhnohhrohhvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhr
    tghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhoshhsihhnsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:dKb7aDJtH3r47w9024dGM0W1XMMMdvrU8Mjh0B2yDqncbW8axxe2Pw>
    <xmx:dKb7aGmO-1zLejQOV-B20r9CRWBjiYEJMrKgFcrUJ1NrmWu_did_DA>
    <xmx:dKb7aMz9BIR3ulg4qQS0aTiFVNXnWjtFzlExuapYgiXqw1gJitsn1g>
    <xmx:dKb7aAvL38X570dcAPLwUWJj0fWUJw37R9hY5tZJWfHIJHVCi3Zimw>
    <xmx:dab7aAUGClVJWwoNlPGZxpZd_9_LFGvmHJ4p-tLO628aR64iXgh--z9->
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9711C700054; Fri, 24 Oct 2025 12:16:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A9Ox7Xt16jvc
Date: Fri, 24 Oct 2025 18:16:29 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Danilo Krummrich" <dakr@kernel.org>
Cc: "Alex Gaynor" <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 "John Hubbard" <jhubbard@nvidia.com>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 "Benno Lossin" <lossin@kernel.org>,
 "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Message-Id: <64e953b7-bec9-404c-88b6-b3febd238afc@app.fastmail.com>
In-Reply-To: <20251024154754.99768-1-yury.norov@gmail.com>
References: <20251024154754.99768-1-yury.norov@gmail.com>
Subject: Re: [PATCH v2] uaccess: decouple INLINE_COPY_FROM_USER and CONFIG_RUST
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 24, 2025, at 17:47, Yury Norov (NVIDIA) wrote:
> Commit 1f9a8286bc0c ("uaccess: always export _copy_[from|to]_user with
> CONFIG_RUST") exports _copy_{from,to}_user() unconditionally, if RUST
> is enabled. This pollutes exported symbols namespace, and spreads RUST
> ifdefery in core files.
>
> It's better to declare a corresponding helper under the rust/helpers,
> similarly to how non-underscored copy_{from,to}_user() is handled.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Tested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

