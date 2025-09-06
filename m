Return-Path: <linux-kernel+bounces-804302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D156AB4718D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 16:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE375811E8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 14:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754D7204C1A;
	Sat,  6 Sep 2025 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="kxmQckzF"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228151E1E00;
	Sat,  6 Sep 2025 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757170642; cv=pass; b=NNGfQ0rV62wjKYRQB0tfXcygLEie49qXqN2pPZBwr/sGzHXFvT1B7AvYpcJbs71rF0tyF4Cv0L+o/Ml2ZsiDMUVLJuS6xyQSxxtujDBZtrAWUWtrl2Y5uVt8QsxEUWvz0onPZc0tYD12heDcIPxRoChwWfyLgTmFCIG10IYnxBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757170642; c=relaxed/simple;
	bh=yGVTbbGSln3zcU/ebSXpd0IRjw4GsNTVz1EOh9Nc5cE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Xp2tbVmgXdAgJqCdhJmqEaQwOTtBvwcXBPhTmizIFH2PpczOAk37b70Qv3KAtnpxR3rJMMQvKaRxDpOV5eG2qkp4rS4H8TgQ7ISoivFFfgNUB0tKQ3xQ3uiNLbPTnkiineKMhaSN9DZXUoSI43920DjjYxEq0KF070yeV60eaZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=kxmQckzF; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757170626; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IvpoD5mfEgklB/WyfW0em1Jd6j1tVsmavwBHB5sa17lN3SYd9ScS7AzPItj4KUzZ8bKr0oUevY8J/PEJKVAp7SEggv3nQq6bEn4DQkJ+/QORV7rYOv2W/SJ9gayi7YjsOp2CiSVrXiF8Rs58WkbublymUnOmlHpgd1+0JkVLRGg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757170626; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=O8C/DJfsbnE6LaSqS1bMEgYiPxUfZO2osNHlbL1OPfA=; 
	b=dvT3HtHeGe3UbDkvhc8MZSQrEjb5xkUqv5NwHRDX5BSKcAg06Ek5eFoyM6t1sYHHE+W1XvoRAUwBBEWjoYQUVBtS7zVBz0PSVz3++d4/lhdz7D5GJ3Lwf8CQGUGS7bcUZKoQIB4ID2WpJSp6oGR+UddYmNH4yZ0vx6+44Nm493o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757170626;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=O8C/DJfsbnE6LaSqS1bMEgYiPxUfZO2osNHlbL1OPfA=;
	b=kxmQckzF6edq9nayu3MT/rSFBJJh/tKC8cxO/wiVN/2yhEyNlxk00Ty5b5LCt68c
	GyNEvGwGkCFhdFEMgKJu8wL73EOfeuEHcWtj5ScHd1GPs68OPK3I6KWVqBkQ/nbBEgN
	9I1uIrly4rdjf+sOyzy/bTpupJIZjCATXqrzMKas=
Received: by mx.zohomail.com with SMTPS id 1757170624820333.870751580259;
	Sat, 6 Sep 2025 07:57:04 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 2/2] samples: rust: add a USB driver sample
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <2025090629-economy-geologist-3548@gregkh>
Date: Sat, 6 Sep 2025 11:56:49 -0300
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
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-usb@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FAC86B63-854F-494C-A55E-4A01BE7511D3@collabora.com>
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <20250825-b4-usb-v1-2-7aa024de7ae8@collabora.com>
 <2025090618-smudgy-cringing-a7a4@gregkh>
 <D8EAF874-4FED-42EE-8FD8-E89B6CB0086A@collabora.com>
 <2025090601-iron-glitter-c77d@gregkh>
 <831C4AE2-6964-4699-9E74-E4B721B87B17@collabora.com>
 <2025090629-economy-geologist-3548@gregkh>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 6 Sep 2025, at 10:07, Greg Kroah-Hartman =
<gregkh@linuxfoundation.org> wrote:
>=20
> On Sat, Sep 06, 2025 at 09:41:16AM -0300, Daniel Almeida wrote:
>>=20
>>=20
>>>>=20
>>>> I thought that an iterative approach would work here, i.e.: merge =
this, then
>>>> URBs, then more stuff, etc.
>>>=20
>>> Ah, that makes sense, I didn't realize you want that here.  What USB
>>> device do you want to write a rust driver for?  Are you going to =
need
>>> bindings to the usb major number, or is it going to talk to some =
other
>>> subsystem instead?
>>>=20
>>> Right now, these bindings don't really do anything USB specific at =
all
>>> except allow a driver to bind to a device.
>>>=20
>>> thanks,
>>>=20
>>> greg k-h
>>=20
>> To be honest, I'm trying to pave the way for others.
>>=20
>> I often hear people saying that they would look into Rust drivers if =
only they
>> did not have to write all the surrounding infrastructure themselves. =
On the
>> other hand, there is no infrastructure because there are no drivers. =
It's a
>> chicken and egg problem that I am trying to solve.
>=20
> Sure, but a framework like this (probe/disconnect), really isn't USB,
> it's just driver core stuff :)
>=20
>> It's also a cool opportunity to learn about USB, but I don't have any =
plans
>> for a driver at the moment other than a instructional sample driver =
in Rust.
>=20
> Then let's not add bindings without a real user please.  We don't want
> to maintain them for no good reason.
>=20

That=E2=80=99s OK Greg, I totally see your point here. I guess we can =
shelve this
work for the time being then.

To everybody else: if anyone is willing to write USB drivers, let me =
know. I
will work with you to get the abstractions in place so that we have both =
the
abstractions and a real user.

-- Daniel=

