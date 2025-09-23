Return-Path: <linux-kernel+bounces-829263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9797BB96A3E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4843A18A132A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65146266B66;
	Tue, 23 Sep 2025 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsReMA/L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36F674040;
	Tue, 23 Sep 2025 15:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758642398; cv=none; b=G6gVRMhBihoZWgsJZ+Cf/S1EaHAL7s2umKe1gVQ0235cbwR5SrbvgkX25+37nW6DN5LjBYAnYbV2oB3unyc6HFbPprABmx9U28dSU7MaQwsIQq2iTduRMUzjWCud+WsSlLa56UP4lU6wqyXjl6caLUD7aoApismvyr9kXMY9Y3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758642398; c=relaxed/simple;
	bh=rU/534+tAdpfK6fK/XepGxCqIklAAHyfOm0LbCWIfzs=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=q0Bhl/a0Hg5spUBq7iMCCl4ZD8MDNYylPvIO1yrtFB66TPcTqYk8q6sS1YabYTa29iATZ7PcDPDIWon2aQcIbWtA092c41bJiKknm0E6AJvzMgSzHz4FH63tFuO8nFqdqynchquK4ZrI4uLY1qhH6LVJKLIPbWmbIrpYXI6Yzy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsReMA/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7055BC4CEF5;
	Tue, 23 Sep 2025 15:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758642398;
	bh=rU/534+tAdpfK6fK/XepGxCqIklAAHyfOm0LbCWIfzs=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=bsReMA/LJA7St2AhhGdm48V0/7J4VJ7M6SiGC5b+OEoH8e2ch0WfV7PkAUzVsdzOA
	 Dy4wws80STalatkRqgdV6wGBPRw/HF1ZscQgAYVZqH7UF6DfwMX+dmGXv+PQZCUf6A
	 NEyr87j267yz7gomDyDQsuIQttHpevvSPAnCmqNNYbVQWXlWNqUIGNYyMn/oASgnLu
	 LU0rOOeLwwEzfEJ1dSesr1PNGKYT5EHEuAtklYH66U04llGDwwgWQuMxxDRZ0SR/A4
	 W/qudvsujsvA4/1cCXZZHOvAGWMiL1nEzNBRe4O4d3FOlyBFegghl0zdu7+zInRy6A
	 LjgPYlNIL2blw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Sep 2025 17:46:33 +0200
Message-Id: <DD0AP6DE36C8.V0537W5RGUIQ@kernel.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 1/2] rust: usb: add basic USB abstractions
Cc: "Oliver Neukum" <oneukum@suse.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-usb@vger.kernel.org>
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <20250825-b4-usb-v1-1-7aa024de7ae8@collabora.com>
 <DD07LUJXNZN9.3RHH9NJNRFVNN@kernel.org>
 <2025092356-rounding-eligibly-c4b7@gregkh>
 <f5a802a4-ac9b-4b45-8d1c-871e2e06d7ac@suse.com>
 <2025092307-scoop-challenge-4054@gregkh>
 <13ce0ad0-f0d5-4579-9a48-db727baa177f@kernel.org>
 <2025092356-glorious-unbundle-58f6@gregkh>
 <9995561f-7157-489d-b48e-fe6c92e1f408@kernel.org>
 <2025092303-squeeze-reformed-11ee@gregkh>
In-Reply-To: <2025092303-squeeze-reformed-11ee@gregkh>

On Tue Sep 23, 2025 at 4:49 PM CEST, Greg Kroah-Hartman wrote:
> On Tue, Sep 23, 2025 at 04:42:11PM +0200, Danilo Krummrich wrote:
>> On 9/23/25 4:37 PM, Greg Kroah-Hartman wrote:
>> > Yes, you are right, it can be gotten that way.  But I can't wait to se=
e
>> > how you wrap that C macro in rust :)
>>=20
>> We can either create a Rust helper function for it, or just re-implement=
 it; in
>> the end it boils down to just a container_of() on the parent device.
>
> Yes, and it preserves the "const" of the pointer going into the function
> call, can we do that in rust as well?

Yes, the Rust container_of!() macro should preserve that.

But despite that, I think it doesn't matter too much in this specific case.

Abstractions of C structures are usually contained within the kernel's Opaq=
ue<T>
type, which allows for interior mutability.

Actual mutability is controlled by the corresponding abstraction around the
Opaque<T>.

For instance, a struct device representation looks like this:

	 struct Device<Ctx: DeviceContext =3D Normal>(Opaque<bindings::device>, Ph=
antomData<Ctx>);

In this case, we never give out a mutable reference to a Device, but rather
control mutability internally with the help of the device context.

For instance, if we have a &Device<Core>, we're guranteed that we're called=
 from
a context where the device_lock() is guaranteed to be held, so we can allow=
 for
some interior mutability.

