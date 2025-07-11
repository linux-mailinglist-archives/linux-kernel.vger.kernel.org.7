Return-Path: <linux-kernel+bounces-728101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 131B2B023A8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 250961CC2970
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F9E2F430B;
	Fri, 11 Jul 2025 18:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtRza2Db"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253DA2ED842;
	Fri, 11 Jul 2025 18:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258639; cv=none; b=pvng0unUs//Vru3Qs5DrePzAQLbNvlQy6P944fDcZooUNgwKwiRjRd6+10Y4z04EHe25TJK1Brm1fVnfV9oCAz9cUk2td1eNVN2ojbuqBLCu32WUc3O4J6vZuly5sWpupvIE7xVqg6zDvzrcXtBViJY6TYcS4nLGytnWPsr2rws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258639; c=relaxed/simple;
	bh=HgBfXAERP9l+i9zQ9Q058LsWgXbaFM1TyxKdpVyVV4E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Og2/HL04iCU2PgBfykCtUTHEVDByrfNfR/uluEif4ODb8jEwhgiNGQI5m9XeqvflP2wcL1yzD16wD65nfdQ7Gf4jCc7TQii4BAcurag6SBu7wgjq20KlkvuIAx8zAb8dN47gizfUjrzh7t9sKCKS5IVEDFRBbVpgoR6LySRvWS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtRza2Db; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9EFC4CEED;
	Fri, 11 Jul 2025 18:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752258638;
	bh=HgBfXAERP9l+i9zQ9Q058LsWgXbaFM1TyxKdpVyVV4E=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=EtRza2Db5xZBGTuV/nKySfUsMGf+07nuEngvN+y34T4g6FpAwqs1dCB+e8A0DXttP
	 MaQhxXZCh7aebd1DtJ1Tmi2qULEF1KI8tpbRpq8NdywfH0NtDnFLeDB5ZKJB9zzF4g
	 cajLlu1bt2i61QPVOsjQTCFUEpT0T59EIWYKSp82/sbc2sB0bzQEQnGZiDvfZ92AjQ
	 PaxooBWqUb1AeD6CfJvXIzlN2D7SUUYcvl8Fz6jiGVXo0HOJZn2tI36p2OOoyVV/lf
	 LsnEDIHgBOol/iZBpM9qf+1O3b+n9xNLp3T1NCdkDML+MdInzIKj3swWUYg58gQRSz
	 VA0Zu6uBsKPZw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Jul 2025 20:30:31 +0200
Message-Id: <DB9FUEJUOH3L.14CYPZ8YQT52E@kernel.org>
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
Subject: Re: [PATCH v2 1/2] rust: Update PCI binding safety comments and add
 inline compiler hint
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250710022415.923972-1-apopple@nvidia.com>
 <DB87TX9Y5018.N1WDM8XRN74K@kernel.org>
 <DB9BF6WK8KMH.1RQOOMYBL6UAO@kernel.org>
In-Reply-To: <DB9BF6WK8KMH.1RQOOMYBL6UAO@kernel.org>

On Fri Jul 11, 2025 at 5:02 PM CEST, Danilo Krummrich wrote:
> On Thu Jul 10, 2025 at 10:01 AM CEST, Benno Lossin wrote:
>> On Thu Jul 10, 2025 at 4:24 AM CEST, Alistair Popple wrote:
>>> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
>>> index 8435f8132e38..5c35a66a5251 100644
>>> --- a/rust/kernel/pci.rs
>>> +++ b/rust/kernel/pci.rs
>>> @@ -371,14 +371,18 @@ fn as_raw(&self) -> *mut bindings::pci_dev {
>>> =20
>>>  impl Device {
>>>      /// Returns the PCI vendor ID.
>>> +    #[inline]
>>>      pub fn vendor_id(&self) -> u16 {
>>> -        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_d=
ev`.
>>> +        // SAFETY: by its type invariant `self.as_raw` is always a val=
id pointer to a
>>
>> s/by its type invariant/by the type invariants of `Self`,/
>> s/always//
>>
>> Also, which invariant does this refer to? The only one that I can see
>> is:
>>
>>     /// A [`Device`] instance represents a valid `struct device` created=
 by the C portion of the kernel.
>>
>> And this doesn't say anything about the validity of `self.as_raw()`...
>
> Hm...why not? If an instance of Self always represents a valid struct pci=
_dev,
> then consequently self.as_raw() can only be a valid pointer to a struct p=
ci_dev,
> no?

While it's true, you need to look into the implementation of `as_raw`.
It could very well return a null pointer...

This is where we can use a `Guarantee` on that function. But since it's
not shorter than `.0.get()`, I would just remove it.

---
Cheers,
Benno

