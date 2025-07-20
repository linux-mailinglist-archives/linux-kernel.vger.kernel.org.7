Return-Path: <linux-kernel+bounces-737998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87183B0B2FF
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 02:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9F8178ABE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 00:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AED33993;
	Sun, 20 Jul 2025 00:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="HhUbH1e+"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622612770B;
	Sun, 20 Jul 2025 00:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752971711; cv=pass; b=rLGcZh1Sloz0J4sejCbrQmeeJXX1CnqHAxMZTf2bI/+xoG68n+SjrQ/X9/Bi8AUdMl/9rb7Wu6I7fn93gS2Sy6baik1CMwERMN8QkDrRpyeotybjZokEf/h0aAlwp41Rr1NOpGro0i3EHtupx/N9RrR9yI33HH0/H1XglICfcyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752971711; c=relaxed/simple;
	bh=HDIoeqn9e+rYQnfJ067hljH9zFzxB0jCy8mHESmaUm0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=JFToNO7DqekLNrfSwp7FNo6zsJHlcyu7GfR3RGS/8NZdmW5Z45BGfNOF19tHOJjJjHQt/wrCLZV6IBNZUAJqVg6UDYB1DuUdn6Vj/d40LKMFOoqHoCR1hB1+o6YaWQ3Xszp3BfRIKb1PUmgbEFQRDVyymtRjYyIndAkMlYxKBx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=HhUbH1e+; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752971688; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DuQeVYCmDEKoan5ifO2S8SAfqvau9PZUj8NogYxheUnCA/GDaxag6taN6lyeANTLALMz00+HBxvpjU2j0cA1h9O9L9AvxTOK4JfG//VR//ZxUHLVLgAAjmCAihQVNggdGteL2nvWI0mW/YH5KWZmRFdDuGQ4+DwJDmFW0UP9154=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752971688; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+oh6ARwng4DpdAfGJjaWcONvM1A731eJcDO1LFA43h0=; 
	b=VJ06SxOm0A/O0iWq4nZIGeKWlS4BEQNtclq3VL0OTEoV6zna58upv/jxLtMfSUk7xBt+N2aPVSCa9//oH47zDWHOtMrBEzAmsKiDx/mW3HIMEHE/63RedAPrd6dAX4Z4jbP9Fqxpjm1unRn5OBUXHC6yY40ecYyBGQkpNR22+0I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752971688;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=+oh6ARwng4DpdAfGJjaWcONvM1A731eJcDO1LFA43h0=;
	b=HhUbH1e+zVA8AiIZ6nY0R6/WjRnknEG+rdUe3hCbsIjXia6iMg42XoBbwb3CQArg
	IVtAYukxJ2DUAc+XA1xid5iD0zKLeahQqxc1Adei8+0Tiniifb87et/jMqQu75lgNSh
	O2XYiewgkkvfp0ZQ2jrtx2Ock/UrCE2JgtFv7RiI=
Received: by mx.zohomail.com with SMTPS id 1752971686447615.9635102011046;
	Sat, 19 Jul 2025 17:34:46 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v15 0/3] rust: platform: add Io support
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <2025071913-coach-prior-d71e@gregkh>
Date: Sat, 19 Jul 2025 21:34:29 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 Fiona Behrens <me@kloenk.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7C1E7AC4-67A0-4CD5-8B22-490F53BDBF1E@collabora.com>
References: <20250717-topics-tyr-platform_iomem-v15-0-beca780b77e3@collabora.com>
 <2025071913-coach-prior-d71e@gregkh>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Greg,

> On 19 Jul 2025, at 05:01, Greg Kroah-Hartman =
<gregkh@linuxfoundation.org> wrote:
>=20
> On Thu, Jul 17, 2025 at 12:55:21PM -0300, Daniel Almeida wrote:
>> ---
>> Daniel Almeida (3):
>>      rust: io: add resource abstraction
>>      rust: io: mem: add a generic iomem abstraction
>>      rust: platform: add resource accessors
>>=20
>> rust/bindings/bindings_helper.h |   1 +
>> rust/helpers/io.c               |  41 ++++++
>> rust/kernel/io.rs               |   5 +
>> rust/kernel/io/mem.rs           | 283 =
++++++++++++++++++++++++++++++++++++++++
>> rust/kernel/io/resource.rs      | 229 =
++++++++++++++++++++++++++++++++
>> rust/kernel/platform.rs         |  60 ++++++++-
>> 6 files changed, 618 insertions(+), 1 deletion(-)
>=20
> Who is going to be responsible for the new files you have added?

As Danilo said, there will be a separate entry for the Rust I/O code, =
which
I=E2=80=99ve agreed to share the responsibility for.

>=20
> And no real objection, but no copyright info was added to them either,
> was that intentional?  I know some companies frown on that as it goes
> against their corporate policy (but some don't care, it's hard to keep
> track of who likes what at times...)
>=20
> thanks,
>=20
> greg k-h
>=20

Good catch. It wasn't intentional, but I don't think it will be a =
problem.

-- Daniel=

