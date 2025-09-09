Return-Path: <linux-kernel+bounces-808126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 093F1B4FA11
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1454E46DC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AE232CF92;
	Tue,  9 Sep 2025 12:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="BM/ws7gy"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CB7304BB5;
	Tue,  9 Sep 2025 12:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419986; cv=pass; b=h2BgbtToAfrNGc8ZOALbTeyeUEd9HVD7KoBLXToclyq1oOTMh5XCOMMpwalmE5Rq0EeuapZsjr7+uMkwtNV4XhjnU5OnDhSiFSsKntEpzlRT0oTUuSPwqQMBJx8j9V2dVrEOy9Jxey000YnwjoiFJsV2SbcjN5gK9LUMR9tl8k4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419986; c=relaxed/simple;
	bh=qRTm08wogJ6IEQYYX7Nk2zH1EbLuhk9DI/DPby6mwQ0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SgoL0OYjvB0BPmYVQDshoM0ZBM5AlW4FOlykY83ENNn1eeH7ZyB6AHF61Rh/7bv69euDAh6NmmzbvK/2knc5g/Or4deDPvKjTmr7rrb9NESYk0fliEDimCsumlxthot+sWGA9PYPKca+56QXmbS2Q2arARKUxO2G0fnrTpBJeCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=BM/ws7gy; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757419961; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cZa6GESQ97dMg+rynhdCMUAoIPsAuEcDQg0rWghvSxu1jKqvfYcYxqW/xE1hXuc4r/VQVzxTHrFdDlcb031kAnMPENwN5hMtFXCgpLxABC9WzsIWsebsvBQQ64d65ZsArTj1qdBpOMoHq3gddgCUKfytObT5BvfNEKiWwnVEzFk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757419961; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qRTm08wogJ6IEQYYX7Nk2zH1EbLuhk9DI/DPby6mwQ0=; 
	b=azFE/VIRrRK5vv5Eebiu89uHK6509YStWkplsKOQ3aMG/lDG6nXvUb9ZOOtYFfL+ex8o9kZcjGEFFK3RJ6Ffqx4ieqwGsaUbEIu3m223mnz7TXl7meelAYxpRERJTT/y8e2Jkw0MaP3JmS4x1jimdcbK0E6ULjFPNJ26JFwpAdM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757419961;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=qRTm08wogJ6IEQYYX7Nk2zH1EbLuhk9DI/DPby6mwQ0=;
	b=BM/ws7gycQgRHCFozthJdHDoQ36qwU3lBS0AOSxzZW4PuCrsSi1cJ1SP4j6rDldR
	Ev0k+SeeWreurDcv20q5a1uNqy1NrMmtuH0wA6UnxmmIIKm8hn0XQmu54xS8ezQR8Jg
	gZVusSraG8T22r+UKG47R5TjFP7Q9cIgSJOCXGUE=
Received: by mx.zohomail.com with SMTPS id 1757419958375181.19043421461697;
	Tue, 9 Sep 2025 05:12:38 -0700 (PDT)
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
In-Reply-To: <3aca9e74-b67c-4bfe-a206-9a6eecdf76ab@rwth-aachen.de>
Date: Tue, 9 Sep 2025 09:12:21 -0300
Cc: Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Michal Wilczynski <m.wilczynski@samsung.com>,
 Igor Korotin <igor.korotin.linux@gmail.com>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-usb@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <77E6BE1A-B928-4A36-98C4-74FB4A7C19C0@collabora.com>
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <20250825-b4-usb-v1-2-7aa024de7ae8@collabora.com>
 <2025090618-smudgy-cringing-a7a4@gregkh>
 <D8EAF874-4FED-42EE-8FD8-E89B6CB0086A@collabora.com>
 <2025090601-iron-glitter-c77d@gregkh>
 <831C4AE2-6964-4699-9E74-E4B721B87B17@collabora.com>
 <DCLQZZHU42HN.4Y4PP0PPR10O@kernel.org>
 <9657C897-087E-4544-849B-964E99D95A50@collabora.com>
 <DCLTJMIAMCVL.35U236MMS5CCK@kernel.org>
 <85B643A9-1657-43ED-BE98-BE7E502D08DA@collabora.com>
 <3aca9e74-b67c-4bfe-a206-9a6eecdf76ab@rwth-aachen.de>
To: Simon Neuenhausen <simon.neuenhausen@rwth-aachen.de>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Greg,

> On 9 Sep 2025, at 08:19, Simon Neuenhausen =
<simon.neuenhausen@rwth-aachen.de> wrote:
>=20
> Hi,
>=20
>> On 06.09.25 17:46, Daniel Almeida wrote:
>=20
>> As I said to Greg above, I=E2=80=99m here to help if anyone wants to =
write a USB driver. Those interested
> are free to reach out to me and we will work together to merge the =
required abstractions with a real user in mind. Hopefully this =
encourages others to join in this work :)
> I had planned on writing a USB driver for TI nspire calculators, that =
would make them mountable as USB mass storage devices, since they use a =
proprietary USB protocol, that usually requires paid software from TI. =
At the time I gave up on that, due to the lack of USB support in RFL, =
but I could revive the effort using this.
>=20
> I'll admit that this is pretty gimmicky, but if it helps to get this =
merged, I would be happy to do it.
>=20
> Greetings
>=20
> Simon Neuenhausen

We apparently have a user :)

Would you be ok if I continue this work? I can look into gadget zero as =
you and
Alan said.

=E2=80=94 Daniel=

