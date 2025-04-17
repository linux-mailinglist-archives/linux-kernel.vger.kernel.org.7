Return-Path: <linux-kernel+bounces-608623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 243F0A91600
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 10:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40D1E173272
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 08:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37741D63C4;
	Thu, 17 Apr 2025 08:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="cKHTtMp6"
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5B422B8AC
	for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 08:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744876850; cv=none; b=Ck0gn1ogfkx41+5ZzRG7Jutq0wx4FqFcTTtFJv7O48ybEBI6QSX9YXUHGWh5Wg5O5XMWu+zvwYTy2vyO5XL8xZWB0yiMwkUt1QA2ZC5tYQdthFtvtaLtrYpfMP5uOBbCeuerTtp266ecFhyz9kv7dM/Fu4N/q57XTWXLjvUmVHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744876850; c=relaxed/simple;
	bh=h3M8nRjVuDVmfNgSsps3kLl6ltkWfwPgNKiJY+3KBX4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TCDm7imsxDJhpD9yKXG8Jbm4w44fLijNNw1Us89khWqKwD57Vlz0rBtBrmrP2YfpQyQeYxRarYNVBQUf6lseWCFYjfR+UrC/EnZdpKidb32C3GFEg88XHzXKR+llBWGADpWHFobWy8pksbdBay87CgDCeGBQ6jmqKsu0zaRmyI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=cKHTtMp6; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=mo5kiaaxzzbulfrq7t524gy3u4.protonmail; t=1744876839; x=1745136039;
	bh=h3M8nRjVuDVmfNgSsps3kLl6ltkWfwPgNKiJY+3KBX4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=cKHTtMp6Nl4+wN4xDfq6H98VrQLHDVlci6//HiRQ8BHNReXmvAtYVxy6OehvofENJ
	 XTeujO7jO+x96iupXZRLSVnoKBT/Hg67LA5vJs7qZqlvyNeQpQmaUgPLni4pEJjuZS
	 QqjkQV3np8Xffo2/rGJLQ5EzAINzQajp/MMx+Wef+3lgsygugsi6OMPXXsO/v5LJEv
	 AMWyFlkS9bfbDfjNmUradbjMR4FZ49pqH5MzHxjsIN+OwpQGcPfGjhMfOURgf8SHFK
	 65ijvFFbLOPZFmDolRsjMSBf8v+83Jr5J/4uTfTfdW2dP+qdb3wbu/8XhM/4aOk7pf
	 ZDjlJxev5jWng==
Date: Thu, 17 Apr 2025 08:00:33 +0000
To: Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>, rust-for-linux@vger.kernel.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>, Yury Norov <yury.norov@gmail.com>, Burak Emir <bqe@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V10 11/15] rust: cpufreq: Add initial abstractions for cpufreq framework
Message-ID: <D98R7PHH6TYX.2DUASKIXS5F8W@proton.me>
In-Reply-To: <20250416093720.5nigxsirbvyiumcv@vireshk-i7>
References: <cover.1744783509.git.viresh.kumar@linaro.org> <ac6854885277b23f100c6033fab51a080cdb70eb.1744783509.git.viresh.kumar@linaro.org> <Z_904KuBhKbO738_@pollux> <20250416093720.5nigxsirbvyiumcv@vireshk-i7>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: ae30b957bfe6b8526ed7c4f59e8cc1d7dfe15a54
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Apr 16, 2025 at 11:37 AM CEST, Viresh Kumar wrote:
> On 16-04-25, 11:14, Danilo Krummrich wrote:
>> On Wed, Apr 16, 2025 at 12:09:28PM +0530, Viresh Kumar wrote:
>> > +#[allow(dead_code)]
>>=20
>> Why is this needed?
>
> Looks like leftover from a previous version. Same for the other one.
>
> I have also made a change to the cpufreq driver now to remove
> `dead_code`, hope that is fine:

In the future, instead of using `allow`, you can try to use `expect`. It
will warn, when the code is used.

---
Cheers,
Benno


