Return-Path: <linux-kernel+bounces-742589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6428DB0F417
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14B58188371A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EA02E7BD9;
	Wed, 23 Jul 2025 13:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="BE/0mlCy"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8512080C0;
	Wed, 23 Jul 2025 13:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753277641; cv=pass; b=nZ16HcfTNZmqVzP7wV35lItLzAG8gZ7AQb8vcKrA+bQSOUIYFyGBuG5KT97GFvo9MQ4FrpfAYZdTvvBX23EfrKanQjn0OhjxlhHwNbEMxxJUeJed4kP/kLqscyKVEfRCVCV0vCzTSaYvhuVeL4YqbMvHrehqaUn24vHTBA8d6WU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753277641; c=relaxed/simple;
	bh=bQG4ktNUSYEgC9vSxNHp1IjSCq455sURuNbCNgnQ5lc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eeKJ+T/xqejQhII4SpAwEJwm30f86e3QEuQzTHsr2Hoopx5361cJ7Gg5DVjqb/WAYemynknbIhkUt4YVpUyVdN6G298NFnIGk7W1TBYtytJpt0hvLL/YaV2dZz0xbBI5fyNznqv69ahk0Vi2K9xnfe6vVko++4nPuU1UK09PY4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=BE/0mlCy; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753277615; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=oJGXFvaPHqeKNTiodRR0n1sWyV3l8huk8h9xS5jNpJ3Tct8Vr3JsKWkKCRfWhgZRqupeOuLZDe9dzDc+py5udaZiBuxXTHO5usTuAfFY1pWnrCxGs/ORe/5D0w1BcQkPCtAhQRGOvxLQGVaJnVlOePqHyzAuYR9YG+2e5Kclz+M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753277615; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bQG4ktNUSYEgC9vSxNHp1IjSCq455sURuNbCNgnQ5lc=; 
	b=flCxk8RUzdHjFN5pvtVi7IVJbay1WWoJzK815yYFusrixdI7HobykTVQwMee/J4SVsr9NY65rnKrC1HObOIzMtfgI51A8cN3M1UH086yRMY0CYHR4IZgxDmNBxjYzbgBoxw1mtkGO/nxTTuqissWNRUuyKHoc+xJ9YnsJ9IJCiM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753277615;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=bQG4ktNUSYEgC9vSxNHp1IjSCq455sURuNbCNgnQ5lc=;
	b=BE/0mlCyGM3s5FU6+fOl193DqSrF9Hq3JTgTmM76CvaUcoHyA7JP3GKKVPlySPPw
	f8YdJ2KkG9EXgoefC4VjgKIU67spFS0Mg/97Lwh5o8QLSHK8TtofsTN7sIMSb/lftTe
	SjJ7jdgD2EmIwEgfOK6WoXD++JPyaat2Nu9aj0JA=
Received: by mx.zohomail.com with SMTPS id 1753277611390721.9876261728012;
	Wed, 23 Jul 2025 06:33:31 -0700 (PDT)
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
In-Reply-To: <6795845d-cda8-44dd-85d2-4d51364e0065@de.bosch.com>
Date: Wed, 23 Jul 2025 10:33:15 -0300
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 Fiona Behrens <me@kloenk.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <63348619-105E-4CBB-B3C8-84395C0EB9EA@collabora.com>
References: <20250717-topics-tyr-platform_iomem-v15-0-beca780b77e3@collabora.com>
 <6795845d-cda8-44dd-85d2-4d51364e0065@de.bosch.com>
To: Dirk Behme <dirk.behme@de.bosch.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 23 Jul 2025, at 04:35, Dirk Behme <dirk.behme@de.bosch.com> wrote:
>=20
> On 17/07/2025 17:55, Daniel Almeida wrote:
>> Changes in v15:
>> - Use a default string in ioremap() if the resource doesn't have a =
name
>> - Fix the doctests in mem.rs to use the new name for io_request_by_*
>> - Link to v14: =
https://lore.kernel.org/r/20250716-topics-tyr-platform_iomem-v14-0-2c27091=
35cb2@collabora.com
>=20
>=20
> I'm not sure if it is too late for this (already applied?) but with
>=20
> =
https://lore.kernel.org/rust-for-linux/dd34e5f4-5027-4096-9f32-129c8a067d0=
a@de.bosch.com/
>=20
> in case it helps:
>=20
> Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
>=20
> Thanks!
>=20
> Dirk
>=20

Applied already, but thanks anyways! :)

=E2=80=94 Daniel=

