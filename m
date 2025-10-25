Return-Path: <linux-kernel+bounces-869865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598C3C08E31
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 11:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 560813B98C7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 09:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9699D2C08CF;
	Sat, 25 Oct 2025 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="deAvh1br";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="dshXT3kk"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747CF18EB0
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761382997; cv=none; b=uS6Hjfi7vKpugcAgS1brB6hAHEsZCGc9tsUXjicVNtZ1B8NRy1mkWNFXUXRP4hmRc0dZ7RDkD3qcioCOVxNlMLKdoKEKktGZvyDI8gEKRPrVVs7iy/WqFKCbr6fCkZ/5nvdAUS5FTodTivJiPSDCEpolS35GeG/2xdDKpw2JbG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761382997; c=relaxed/simple;
	bh=tgrnk8ZuUzx0LKigibkG0ibZjMkNuclNIw3cerFPueE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jk9wPmUgtJKWsDRdzxO8SxB1yfbtB8OOyifOY7XT9Gd9dUG22J6djNdBxosc5k4WkGDQ07Ic173yESnBa7n1Yz5eV8XDZt5c9nTa2pM3zOkVZVgiFSjyxTJgH97UJQI5RLsUvHtC4ykt+a47G/4gNgre6FxS1dtFGY2a72sE3pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=deAvh1br; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=dshXT3kk; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1761382924; x=1761987724;
	d=konsulko.se; s=rsa2;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from;
	bh=tgrnk8ZuUzx0LKigibkG0ibZjMkNuclNIw3cerFPueE=;
	b=deAvh1br0tHehIGIPF7/aghlwGicCKSHKa4trsuoG40HIwkEgcIXYcEuJsaIBcyYp/IahmnLb1l4I
	 epLwzDb5GUGLhRh1ctat0H5jDvpxrXaoh6BKoUhQjRgXcPFaCxnjMC2gPGGgYWB3CXVBneSblN0PBG
	 7KO7hfmWHJEL2hFjZxuCdfM0eLY1p00eV4EkQhiAlIGn8DEyzkKBLmeZ7supZfMiSXZCooeVHuTugW
	 1TWCcO55AqLc+NUqERZgfzKaTGs/ywECC9/DV4mu6F/FQzwnSI2wgY65xxmcmZ/apbkxCydzgAOsTt
	 5HefkmPrNoHS80ji6g9WyQHm1LCIGlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1761382924; x=1761987724;
	d=konsulko.se; s=ed2;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from;
	bh=tgrnk8ZuUzx0LKigibkG0ibZjMkNuclNIw3cerFPueE=;
	b=dshXT3kkGcC+BMy3f8jF5SP7WoexND/l4LCuBsu72T8w1lCtFN88TakJlAVj0i4ngxZXov3EJSJNP
	 LLN+XOkDw==
X-HalOne-ID: 45f74865-b181-11f0-8d26-f3c0f7fef5ee
Received: from smtpclient.apple (host-95-203-14-151.mobileonline.telia.com [95.203.14.151])
	by mailrelay4.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 45f74865-b181-11f0-8d26-f3c0f7fef5ee;
	Sat, 25 Oct 2025 09:02:04 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH v5] rust: rbtree: add immutable cursor
From: Vitaly Wool <vitaly.wool@konsulko.se>
In-Reply-To: <aO9Uds521WM1n8_X@google.com>
Date: Sat, 25 Oct 2025 11:01:53 +0200
Cc: rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5A8E1769-C405-4B6E-8DC2-1E96CF186494@konsulko.se>
References: <20251014123339.2492210-1-vitaly.wool@konsulko.se>
 <aO9Uds521WM1n8_X@google.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.200.121)



> On Oct 15, 2025, at 9:59=E2=80=AFAM, Alice Ryhl <aliceryhl@google.com> =
wrote:
>=20
> On Tue, Oct 14, 2025 at 02:33:39PM +0200, Vitaly Wool wrote:
>> Sometimes we may need to iterate over, or find an element in a read
>> only (or read mostly) red-black tree, and in that case we don't need =
a
>> mutable reference to the tree, which we'll however have to take to be
>> able to use the current (mutable) cursor implementation.
>>=20
>> This patch adds a simple immutable cursor implementation to RBTree,
>> which enables us to use an immutable tree reference. The existing
>> (fully featured) cursor implementation is renamed to CursorMut,
>> while retaining its functionality.
>>=20
>> The only existing user of the [mutable] cursor for RBTrees (binder) =
is
>> updated to match the changes.
>>=20
>> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

@Miguel: is there anything else missing in this one or is it good to go?=20=


~Vitaly=

