Return-Path: <linux-kernel+bounces-804880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B5FB48155
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 01:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8D1F174D50
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 23:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF98230BF8;
	Sun,  7 Sep 2025 23:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aae61bQB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2F81922FD;
	Sun,  7 Sep 2025 23:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757287518; cv=none; b=b/WLNNHfnAYdDI3brBYDbdQBfv/hvc4YylcuBXb2yrAXvfE/MVx6xlezpJtpbbli8lzVCpty1hFgP4EvF0s+lPnBHgkNmLM5rJsat2lmG8FXJsaXhAzpNQIq8S1zhPi275pexwlpPemLG3q2rsCQCMeSfv9IWKjSlWrUABziwac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757287518; c=relaxed/simple;
	bh=2IK1HntqZit2+7T9ga7A2o5l9tYj6VYkyIJ5hFhuKIc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=mKTsgEqHussoA9fZh9RTcJnZNmD+myMCWjSiHk//UFGGehWu//mHwYgk9c0gO7oYM56lrOrV240hoex3iAjZLD7GeKhoaculG2L7LKNNtXIXH9vj/S40peplf1hguu2DM/4HoZrC94DtUgQjLq6E7XCnY61go6g5L1KMquVYObU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aae61bQB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22472C4CEF0;
	Sun,  7 Sep 2025 23:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757287516;
	bh=2IK1HntqZit2+7T9ga7A2o5l9tYj6VYkyIJ5hFhuKIc=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Aae61bQBmyoZgaEUDNSECYT3wALjb0jNytP9riTlucETh91KIjUrgenJXcsoBXpCJ
	 m5Jr+yPszE2KN8/2GsRTdEVuD9kC/X7IzmwvgkUbf7y3gc5bDtTQ+1tqIyUIYWzei2
	 Jm/XqoVd35xFDnaYj+fdeOiXMYfwTnKeZCE0+7YR/RLrqDApZAp6RV9lZOPyqW83T3
	 ZdV1/NB3WrT9DNqwyhVbz18dVC8bbNLXGxJtUviKJPX/5/cP+pCbtk07HaC18a/wvh
	 JGLxTbEst1/eNqXN+nu+kKbZfi8ptO89nMpxSX35yIJbyw7eL1VpmfptzBALZlNqrH
	 4bFwmz0DXnNMg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Sep 2025 01:25:11 +0200
Message-Id: <DCMYFLXXMOHT.M34887LRPXHH@kernel.org>
Subject: Re: [PATCH v11 5/7] samples: rust: Add debugfs sample driver
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Benno Lossin" <lossin@kernel.org>, "Dirk Beheme"
 <dirk.behme@de.bosch.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Matthew Maurer" <mmaurer@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
 <20250904-debugfs-rust-v11-5-7d12a165685a@google.com>
 <DCKQS4126EVC.38ZJ0GOFDYCP7@kernel.org>
 <CAGSQo01He7cNvcOQBxAqLicSjKniSp=97K6GupnxS4B=G9p4rw@mail.gmail.com>
In-Reply-To: <CAGSQo01He7cNvcOQBxAqLicSjKniSp=97K6GupnxS4B=G9p4rw@mail.gmail.com>

On Sat Sep 6, 2025 at 5:19 AM CEST, Matthew Maurer wrote:
> On Fri, Sep 5, 2025 at 2:00=E2=80=AFAM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>>
>> On Thu Sep 4, 2025 at 11:13 PM CEST, Matthew Maurer wrote:
>> > +kernel::acpi_device_table!(
>> > +    ACPI_TABLE,
>> > +    MODULE_ACPI_TABLE,
>> > +    <RustDebugFs as platform::Driver>::IdInfo,
>> > +    [(acpi::DeviceId::new(c_str!("LNUXDEBF")), ())]
>>
>> This should use "LNUXBEEF", as we explicitly reserved it for sample and =
test
>> code.
>>
>> I think we could reserve more if we see a benefit, but so far it's only =
used by
>> the platform driver sample, so we should be good.
>>
>> Either way, no need to resend for this only, it can be fixed up on apply=
. :)
>
> Ah, thanks, I was unaware that it was specially reserved and so tried
> to pick something distinct. You fixing up this and the `OF_ID_TABLE`
> on apply SGTM.

Ok, I will wait for Greg to have a look first.

- Danilo

