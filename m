Return-Path: <linux-kernel+bounces-721748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C88EAAFCD63
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B87A564AA7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DE42E0405;
	Tue,  8 Jul 2025 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="Sd6+l4ET"
Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC552E03F1;
	Tue,  8 Jul 2025 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984525; cv=none; b=Jz8gGb2ftybKWt3Jz5tvcfuVW56RqhGZW6hONDpokApcHUdkdaE73yy98/iXHUaX9cyKE4nX0P/TcUCW8HGDvPvl87R4cviH6svQRzvUOFEquZSOZBPYWSTeXEK8+Ml7ERWS3oscnmfis7axZFdnJHKIjmiY7IBzzUIuaKNIpKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984525; c=relaxed/simple;
	bh=DH6dfVAww/N3ud1HbrtA6oaDaN+wQqsJ2R2Jm6z9coY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b89pah88nhGj10sdY/chvLCI2QIY+4lkYJ95sdLhtQrX0vELIYwAkge+1xRCVIOorjXYCwOFHZid8GeBtwVeKVfGIoSe/nOdh3hs2kBOjhTx2Rso9MzVVhRYqVKaFIxs9GCh51t0qzuCCh29XVp0KxIbK3GY6PyQZtDIv5Uuxow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=Sd6+l4ET; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:e0cb:0:640:3e34:0])
	by forward502d.mail.yandex.net (Yandex) with ESMTPS id 6A82061208;
	Tue,  8 Jul 2025 17:21:54 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id nLidoEgMOKo0-Z2M3B1ca;
	Tue, 08 Jul 2025 17:21:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1751984513;
	bh=oLyaLZbxnfJRaG45+ieXAi9qVb5FUUkzxh78rrfH43E=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=Sd6+l4ETRk2kbA4Ht8CpdvvJAu78Qc9M6TGMzsN3mciY3M8o5YOGdHLRI+xgDoi31
	 qijbMtWq5vzjm22/pxf0uCOjOxxEgXfotVbylobrCJwRgfo4d2CFH+98WSpwTi5eEc
	 FbkiWHAu9P5/+UiCz+TkfiRtLvf9SOxAWtzyFIFA=
Authentication-Results: mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Tue, 8 Jul 2025 17:21:47 +0300
From: Onur <work@onurozkan.dev>
To: "Benno Lossin" <lossin@kernel.org>
Cc: "Boqun Feng" <boqun.feng@gmail.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <gary@garyguo.net>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
 <longman@redhat.com>, <felipe_life@live.com>, <daniel@sedlak.dev>,
 <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH v5 2/3] implement ww_mutex abstraction for the Rust tree
Message-ID: <20250708172147.1d694eb1@nimda.home>
In-Reply-To: <DB62ZN1LTO31.1HVWDLAWJWVM8@kernel.org>
References: <20250621184454.8354-1-work@onurozkan.dev>
	<20250621184454.8354-3-work@onurozkan.dev>
	<DASY7BECFRCT.332X5ZHZMV2W@kernel.org>
	<aFlQ7K_mYYbrG8Cl@Mac.home>
	<DATYHYJVPL3L.3NLMH7PPHYU9@kernel.org>
	<aFlpFQ4ivKw81d-y@Mac.home>
	<DAU0ELV91E2Q.35FZOII18W44J@kernel.org>
	<20250707163913.5ffc046d@nimda.home>
	<DB5XIWGZ8U36.1VB58YBJFL7OT@kernel.org>
	<20250707210613.2fd5bb55@nimda.home>
	<DB62ZN1LTO31.1HVWDLAWJWVM8@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 07 Jul 2025 21:48:07 +0200
"Benno Lossin" <lossin@kernel.org> wrote:

> >> > Instead of `begin` and `custom`, why not something like this:
> >> >
> >> > 	let (a, c, d) = ctx.init()
> >> > 	    .lock(a)
> >> >             .lock(b)
> >> >             .lock(c)
> >> >             .unlock(b)
> >> >             .lock(d)
> >> >             .finish();
> >> >
> >> > Instead of `begin`, `init` would be better naming to imply `fini`
> >> > on the C side, and `unlock` instead of `custom` would make the
> >> > intent clearer when dropping locks mid chain.
> 
> Also, I'm not really fond of the name `init`, how about `enter`?

I don't have a strong feeling on any of them, they are all the same
at some point. The reason why I suggested `init` was to keep it as
close/same as possible to the C implementation so people with C
knowledge would adapt to Rust implementation easier and quicker.

> Oh yeah the name was just a placeholder.
> 
> The advantage of custom is that the user can do anything in the
> closure.

Right, that is a good plus compared to alternatives. :)

Regards,
Onur


