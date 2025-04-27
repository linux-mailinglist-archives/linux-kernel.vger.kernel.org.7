Return-Path: <linux-kernel+bounces-621977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 168A7A9E117
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Apr 2025 10:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E16E54633B1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Apr 2025 08:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D7F24C067;
	Sun, 27 Apr 2025 08:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="AaxiIQj+"
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA6C19048A;
	Sun, 27 Apr 2025 08:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745743281; cv=none; b=oZ/gkcG3my55bGe7NPoZ773Q2IPTc8ORnMMygMAhI4bOnckOLA7vm7gVtQ5miT5RMD61+IICR8fPpWZTQHmxatMI3fESQpCjWhY4ztRZYmiipEqnjNfGtZR7jaGxsGwzvVAO5ymKkW85CwrXbpV6kK4dQl7eiPDmmQh8PBZwV5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745743281; c=relaxed/simple;
	bh=6ttQTFlnLRk5umQOwmKH2yxEnh/cM8lnhIS1sNIMgwE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JnIwWUtcRDHqGztUa8VpQXHSYNMN8XvKgedWOoTa1JrjDy3d8aUQuEz0iTyhPYNG714m3/tn54rKoben02yfmy7a1HswAbuddXu8PefYJJWxJTNuRemVopTM+/KOf8A1bztpTc6ygUu+WqiyU9qjMw5oHY6bReN1DiO+Ua9ldh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=AaxiIQj+; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1745743266; x=1746002466;
	bh=EuMz3kZQGQn4bADul2EcojS+v3oCdcGvpvDdhtvlJVw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=AaxiIQj+sRwbNym/0B8oK8rQIsYn42qeTwKNTcAUbPIf8PbRUajZThVJPQzzV71xi
	 zDFvOarPSExw3Elq+3Q5o9e8uRVxMCsIZ89UHEmTXLYvwP+Nlx0X8j+GfNmAWk9Zp+
	 YsTqUGaWYqocGnjGjycMmMqHxX4T2QnKmo1CWs0v7HwAPlkbmWXRCLZhI7myhttxeG
	 Tr3ZoBp/4YQ0nUfMf9gYZ31zxf2KyynwGevbhHzab1tUGc3RVdd3pdEwsJgZjVZdJU
	 2D0wJtl2AAnwwjlfl3zVXP4Olxg81MYTGDsK//vYcB4stO9qBXPWXJ4Z59x9QZfXCf
	 yClrqHjrGKtyA==
Date: Sun, 27 Apr 2025 08:41:02 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com, joelagnelf@nvidia.com, ttabi@nvidia.com, acourbot@nvidia.com, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rust: devres: implement Devres::access_with()
Message-ID: <D9HAC6KW2GTG.ICOFCQX4A2U3@proton.me>
In-Reply-To: <aA1O8Wem1FhyybF5@pollux>
References: <D9GUR8Y08PQ6.2ULV6V4UJAGQB@proton.me> <aA1O8Wem1FhyybF5@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: bb8e0fa1479c64fc29feef18bdaa8bd6644ac35b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat Apr 26, 2025 at 11:24 PM CEST, Danilo Krummrich wrote:
> On Sat, Apr 26, 2025 at 08:28:30PM +0000, Benno Lossin wrote:
>> On Sat Apr 26, 2025 at 3:30 PM CEST, Danilo Krummrich wrote:
>> > +    pub fn access_with<'s, 'd: 's>(&'s self, dev: &'d Device<Bound>) =
-> Result<&'s T> {
>>=20
>> I don't think that we need the `'d` lifetime here (if not, we should
>> remove it).
>
> If the returned reference out-lives dev it can become invalid, since it m=
eans
> that the device could subsequently be unbound. Hence, I think we indeed n=
eed to
> require that the returned reference cannot out-live dev.

I meant the following signature:

    pub fn access_with<'a>(&'a self, dev: &'a Device<Bound>) -> Result<&'a =
T>

You don't need to specify the additional `'d` one, since lifetimes allow
subtyping [1]. So if I have a `&'s self` and a `&'d Device<Bound>` and
`'d: 's`, then I can supply those arguments to my suggested function and
the compiler will shorten `'d` to be `'s` or whatever is correct in the
context.

[1]: https://doc.rust-lang.org/nomicon/subtyping.html#subtyping

---
Cheers,
Benno


