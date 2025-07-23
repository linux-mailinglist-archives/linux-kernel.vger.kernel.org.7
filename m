Return-Path: <linux-kernel+bounces-742463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF513B0F1F9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A58A3B72A7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A2C2E5B19;
	Wed, 23 Jul 2025 12:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="IgpSw4gk"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FA52E54D9;
	Wed, 23 Jul 2025 12:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753272734; cv=pass; b=nexantpOqwnPBzAhUEmKHpBlOenR/5JAw2Al1CfjXnoZtG1/qlbxEyjgM9z9p9tszE+Bgpbjv/Cdwldb+aqWnCu+Nvy9jTiCluKRdEiUzttCrUHSCDKL/qt1uvP7qNh9H8dYHWnpiU494ByxSlO5Hf1x7hIddL/Gv1TFk4mSCQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753272734; c=relaxed/simple;
	bh=sjFQxIj61JDLMwhDe5OPXuFmiX3XUxnM+/kq9zkvwTw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WkZoJarn61Y/SlSzIEeJESjIFTyRA7uJkCl3vcf/D/v4JQFHJwl4U3slzwpxMFwmLyd7etKE4S+yrVV5517whJulNU261qosMdeWnYeCvIC8JrB3JsnvXdEWCFrZ96CWeCwB17I3LkTsZq0ehjvg44BOAoGt8B8OAi9Ib3SFZXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=IgpSw4gk; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753272718; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DB8pDu0SWwcTP45d2OpQHGGU+/RCcO8z506I521PJj/TesQYoCo3QBbVkhzurS2+8RjMeANt3JBptilqGMjeIzS2PLxhUjOuriAFBjxu82uZXCvWFYDvot3s4a9oj0tBP2vChCcDfS0/ZOJKD9FGd8jrB7mi+qvw6Q0BoTmTDgg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753272718; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OO7YUegIWrJgxs5c9U4V8z+lHWXerzMa7nTmg8y0I9Q=; 
	b=WpLwVDG7hI8kQFRhXd5t8Ib/aWOmizKtrab+awmm60NWyEAp4ebha2hXVrrD/9l5XcGdKf0hlUb4x4jqhW+jXCdUILqow8wpdpHQy1V23cJMesyQNJqdqLa6vpDgYm5DeMXhMJ85y6YZPy6Rc2PdrFMcZql9aM3QdQubvV0Mru8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753272718;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=OO7YUegIWrJgxs5c9U4V8z+lHWXerzMa7nTmg8y0I9Q=;
	b=IgpSw4gkvkZaay/5sR+M93C0YsSsyO7Q7lM9Lyh/aqP1WznKptBO5ks7b1/iv2Q3
	MDeGQt3awKZNlk4TgjgaC317DdSUPgaJKG6ZQVQJEgbxMLOmJe8KxfAZcP4/g631m9j
	1blyRqQVJWKpcqSjhH1XHgcU8b5Gf3i+fYhaG9bI=
Received: by mx.zohomail.com with SMTPS id 175327271587516.38887700809562;
	Wed, 23 Jul 2025 05:11:55 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH 0/2] Clean up Rust LockClassKey
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250723-lock-class-key-cleanup-v1-0-85fa506b8ca4@google.com>
Date: Wed, 23 Jul 2025 09:11:41 -0300
Cc: Boqun Feng <boqun.feng@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <789725BF-8D13-4334-A498-F2C51B546B6F@collabora.com>
References: <20250723-lock-class-key-cleanup-v1-0-85fa506b8ca4@google.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Alice,

> On 23 Jul 2025, at 08:49, Alice Ryhl <aliceryhl@google.com> wrote:
>=20
> This series applies the suggestion from Benno [1] and various other
> improvements I found when looking over the LockClassKey =
implementation.
>=20
> Based on rust-next.
>=20
> [1]: =
https://lore.kernel.org/all/DBIJLR7XNI6U.21PMPODHE83DZ@kernel.org/
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Alice Ryhl (2):
>      rust: sync: refactor static_lock_class!() macro
>      rust: sync: clean up LockClassKey and its docs
>=20
> rust/kernel/sync.rs | 77 =
+++++++++++++++++++++++++++++++++++++++--------------
> 1 file changed, 57 insertions(+), 20 deletions(-)
> ---
> base-commit: dff64b072708ffef23c117fa1ee1ea59eb417807
> change-id: 20250723-lock-class-key-cleanup-a3baf53b123a
>=20
> Best regards,
> --=20
> Alice Ryhl <aliceryhl@google.com>
>=20
>=20


Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

=E2=80=94 Daniel=

