Return-Path: <linux-kernel+bounces-727810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46357B02009
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0F0188C5CF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810CA2EA475;
	Fri, 11 Jul 2025 15:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ry+7g0E6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D9117A2EB;
	Fri, 11 Jul 2025 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752246161; cv=none; b=Hq/Req9mMvIo9PrD5VpnakSelwQrUTh+1lFBfyrXu4dLmDGMbxK8xI3GvO3OQAgqTc7W/hTEZSKKYMHPXa4ddudos9tNbvVhVwsNS3VgdHX8J6Gj4A+e+gralP4UfYWmFdfaanjM/uS4UhiPjTXtB0OmV58Hd2NSoL2wgpLWrHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752246161; c=relaxed/simple;
	bh=WkohEzGpgCArM8YpDzlmzXmA4tTufR/VfgsN4+NpprY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=UtB//G+v0hPVRCXamrbKcnDBBEGPQwK7krXRkxFLP0mtV1bMKEwY7faA1adOzkLvzZPMvfUv29jZHN+7OgEOdD0JzfnufSyb80p/juwMXeVijnm4tGEpyoa0s23A98KWzEAz/TxfoLYDp8kpzNJbVsLMMmHOLBV7FLbOs4iVqBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ry+7g0E6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE29C4CEED;
	Fri, 11 Jul 2025 15:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752246160;
	bh=WkohEzGpgCArM8YpDzlmzXmA4tTufR/VfgsN4+NpprY=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=Ry+7g0E65o6dOo6nnTBWd6S831aTVgPT8/KIJIkRdgO9AEOqsQ7VUYbZs9DiLbGFX
	 m5ryFOPFxE84O8k4i0NIQ/t9IB5aq4MS+lGH4hsnEJbL8VXoA4t3F3bpFFYwItfXej
	 PpI1KC7xoXKcZSYJIsqWBJWSDVKVueFzziKjHsCAEtOvtl440Ad3cqv7PwFJFp6MPH
	 UfTKkzjUQxD2iv0+ndywQyiQt7fkabBh2h9YqjYSnxu3TJwFzCfFG7K4EiZJ6YZIvP
	 +I6+AvS9Fa+sDJroykgaff8vRNRMkXKWM/aghGlMQcBUAAQbvmLZP6xu1lGWI2n7rp
	 5tMjWOB2Cx2Uw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Jul 2025 17:02:35 +0200
Message-Id: <DB9BF6WK8KMH.1RQOOMYBL6UAO@kernel.org>
Cc: "Alistair Popple" <apopple@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "John Hubbard" <jhubbard@nvidia.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Benno Lossin" <lossin@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 1/2] rust: Update PCI binding safety comments and add
 inline compiler hint
References: <20250710022415.923972-1-apopple@nvidia.com>
 <DB87TX9Y5018.N1WDM8XRN74K@kernel.org>
In-Reply-To: <DB87TX9Y5018.N1WDM8XRN74K@kernel.org>

On Thu Jul 10, 2025 at 10:01 AM CEST, Benno Lossin wrote:
> On Thu Jul 10, 2025 at 4:24 AM CEST, Alistair Popple wrote:
>> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
>> index 8435f8132e38..5c35a66a5251 100644
>> --- a/rust/kernel/pci.rs
>> +++ b/rust/kernel/pci.rs
>> @@ -371,14 +371,18 @@ fn as_raw(&self) -> *mut bindings::pci_dev {
>> =20
>>  impl Device {
>>      /// Returns the PCI vendor ID.
>> +    #[inline]
>>      pub fn vendor_id(&self) -> u16 {
>> -        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_de=
v`.
>> +        // SAFETY: by its type invariant `self.as_raw` is always a vali=
d pointer to a
>
> s/by its type invariant/by the type invariants of `Self`,/
> s/always//
>
> Also, which invariant does this refer to? The only one that I can see
> is:
>
>     /// A [`Device`] instance represents a valid `struct device` created =
by the C portion of the kernel.
>
> And this doesn't say anything about the validity of `self.as_raw()`...

Hm...why not? If an instance of Self always represents a valid struct pci_d=
ev,
then consequently self.as_raw() can only be a valid pointer to a struct pci=
_dev,
no?

