Return-Path: <linux-kernel+bounces-804190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF7FB46C31
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 14:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0AA5A2458
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 12:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08621285C8A;
	Sat,  6 Sep 2025 12:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="XTipPaZH"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDBBBA4A;
	Sat,  6 Sep 2025 12:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757160284; cv=pass; b=N7bf0a0sushFUIEVLz364lmyrwKOCc3F20XawBji31kZwS9jDCh5MXsOdP0kW4HQOFdVPh1Vkewzem6Ficj7Lw5Xn+YpyrvN3Oikxiw20mfCBnmnBXmrd/kR0NDq61RIvHox1p7dh3b3wUW56pCgc13poFB13mwb/mgtxLCCXTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757160284; c=relaxed/simple;
	bh=mWcHetSjsF2dlN8vR/mVQ5wk5y7HtVkm+F1SdIZ/jIA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Derrn5ZXc57waQ0u9QGjHiDGzlgAt76cONE5WNJRYG6Kbr82fUI65SVD3Jr20u2JVYlIdhkkRptb7WHa5AFgOnprzbTOngQZ9V5FVT8wkssrE+HGwWO5h8cSvsIpnY+uHQ3aafHiItIamqPvZHK8yYjc9G/9RW/adnsFfzZvR3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=XTipPaZH; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757160263; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Y/FL/n/QhKVZ+Lt9Ka1jOT7vZnBwSUTz3K/C+m+h9724Jdh4h7LpHdi1ysK5q951d/I2MoEAfrlqyiiwVLsh2/NGre3rFFo9fbbtjJBgsCegFZWMFUbBqH8LNqU5rUgXglsFZAR4o3k5SHYJxLfM8nBrWz3CmwKUB8trqyFF8oA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757160263; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cgS2LFhfqoOwMMZF35dVsRyk0A8wU/fwZfnbwYwViMQ=; 
	b=Pba9uHYSEK/tnxqoyHyCwmMLrwfmIQooxFes4JmHF3zDn0Xwavh55D3Wrrq1wW2S7ZwfDZ7pn9geKRpXEq4FTtIqjmWqR7vav6Q6s6pzN6PSxyD9KgvLFgn2aOHpnIlxHGym/1VkIbQQvZwWTjo9qAzg/3QuKU0waciFcGbRpzA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757160263;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=cgS2LFhfqoOwMMZF35dVsRyk0A8wU/fwZfnbwYwViMQ=;
	b=XTipPaZH81StLxyWq/eav9OBZXpKPBzYNbfzFxGi0sEhnrRj5u6IPmzaYuJ++JXG
	krmVYhpcyP+ThBy6ziN0ogDyBPVDIKRxHHBxj5Jg49/Vz4HtRBGRh3+REqto7NFSzs8
	mfCu4zRjYkc4vgJ11jkx+ICigXR8z4+LPkB67idU=
Received: by mx.zohomail.com with SMTPS id 1757160261040224.5192787006066;
	Sat, 6 Sep 2025 05:04:21 -0700 (PDT)
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
In-Reply-To: <2025090618-smudgy-cringing-a7a4@gregkh>
Date: Sat, 6 Sep 2025 09:04:04 -0300
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
Message-Id: <D8EAF874-4FED-42EE-8FD8-E89B6CB0086A@collabora.com>
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <20250825-b4-usb-v1-2-7aa024de7ae8@collabora.com>
 <2025090618-smudgy-cringing-a7a4@gregkh>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Greg,

[=E2=80=A6]

>=20
> Sorry for the delay.
>=20
> But these bindings really are only for a usb interface =
probe/disconnect
> sequence, right?  no real data flow at all?
>=20
> I recommend looking at the usb-skeleton.c driver, and implementing =
that
> as your sample driver for rust.  That will ensure that you actually =
have
> the correct apis implemented and the reference count logic working
> properly.  You have urb anchors and callbacks and other stuff as well =
to
> ensure that you get right.  That driver pretty much should handle
> everything that you need to do to write a usb driver for any type of
> "real" device.
>=20
> thanks,
>=20
> greg k-h


I thought that an iterative approach would work here, i.e.: merge this, =
then
URBs, then more stuff, etc.

In any case that=E2=80=99s OK. I will work on the other stuff you listed =
here.

=E2=80=94 Daniel=

