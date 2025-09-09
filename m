Return-Path: <linux-kernel+bounces-808949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F05BB506C5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E439D5E4836
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251AF35AACA;
	Tue,  9 Sep 2025 20:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="AhslWzII"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EFE35A2B4;
	Tue,  9 Sep 2025 20:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757448765; cv=pass; b=JqaliVitJD5dcshcwJFiKhhWInypV1/GWvd6G/43NjE7Iy/LU+TPaC29hWuqqhOm3YX/SlnZT7bQbayMXABtfymCoTt9Af6Fj+mfehlIfZUkNeWmyOcsk367+K2Ha1J0fJfr/hDt9+Oewy1jRNsIeuQ3NYV8IfuNlYRGxCTfG6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757448765; c=relaxed/simple;
	bh=U9b8NIT0IHIPcBnZngkR0PkBA7eeDB5ceXEVqeMSLaI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ogsEAOIr5tnfZWvUGKvIiBCOX0pC/W1uaz6OLpHIc3eQc+QczNE7HjnkUjbSRo++wIN4VBF4aQSwedBy7dSzM8O0W1S9OkDb9HSllmg+G/gERcxcwoSXNchhmsrwbCN7jc7Wc8ROFIXUMup8M+UY49sCYUDbWpeaGqET9NQjHBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=AhslWzII; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757448740; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kHDqc3/b+1dxUUtUkM2Z+CfdK0v7qebk95ZCCjelqTg8bJkLo9oHghUM5twp7T4TG7pjUS6FwghTwMeIshQT+3VgLMDYzn9TIl3IeuY0FhkmGNhOC3AEtexQGgv+vViyqpmqzT50FDLjxaSrc0AcTdNPqE7/4JjlnZ01bHt/lOA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757448740; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=U9b8NIT0IHIPcBnZngkR0PkBA7eeDB5ceXEVqeMSLaI=; 
	b=JspyMv2uVO7caTv8LdWygsaMJgJUDcE6JJqJdVx+Vympb5zH74/N26X1jDvhrj11Auf+K7rHNQzlvmTlmcFdhkJufAEOnK8QxApuh9odFvCegsS2u2ZjH+J/InSeQclLVNYgkbmlt48FHodZjTpbcjBI2gmOT0Eg2sVNlJAHVZg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757448740;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=U9b8NIT0IHIPcBnZngkR0PkBA7eeDB5ceXEVqeMSLaI=;
	b=AhslWzIIODUgZkw3M7m98VmkUDVPWT8LaBy2LWmsKZBOkO9Y0CNqgBXK6yfrrO3E
	HzbfF0WqLdHcHXepZy9PP8/NiJey+S1TknFgn546MDkB2DSWS7EXPEGrylSjqv57sjq
	6ocC/qM9ZnBC2qgDTIwDN9Rc5KyeuRXCQ53LfB/4=
Received: by mx.zohomail.com with SMTPS id 1757448738705897.8611453818289;
	Tue, 9 Sep 2025 13:12:18 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2 1/1] rust: refactor to_result to return the original
 value
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <CANiq72=NrS1cFJec6sm7ZY-UPqrzxHKVvPu67Rze02Fg_xeWpQ@mail.gmail.com>
Date: Tue, 9 Sep 2025 17:12:00 -0300
Cc: =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 daniel@sedlak.dev,
 dirk.behme@de.bosch.com,
 felipe_life@live.com,
 tamird@gmail.com,
 dakr@kernel.org,
 tmgross@umich.edu,
 aliceryhl@google.com,
 a.hindborg@kernel.org,
 lossin@kernel.org,
 bjorn3_gh@protonmail.com,
 gary@garyguo.net,
 boqun.feng@gmail.com,
 alex.gaynor@gmail.com,
 ojeda@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E64F356B-7EC5-4F46-9ADF-610CBF249651@collabora.com>
References: <20250909170013.16025-1-work@onurozkan.dev>
 <20250909170013.16025-2-work@onurozkan.dev>
 <CANiq72=kWpxpo23JUYTqxwpsY=E0uUvCHgotRuepZpL-qUqXqw@mail.gmail.com>
 <20250909204308.74ccedf4@nimda.home>
 <CANiq72=NrS1cFJec6sm7ZY-UPqrzxHKVvPu67Rze02Fg_xeWpQ@mail.gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 9 Sep 2025, at 17:05, Miguel Ojeda =
<miguel.ojeda.sandonis@gmail.com> wrote:
>=20
> On Tue, Sep 9, 2025 at 7:43=E2=80=AFPM Onur =C3=96zkan =
<work@onurozkan.dev> wrote:
>>=20
>> That change was incompatible with v1 (due to the different signature =
of
>> to_result), which fails to build with my patch. This version (v2)
>> fixes the issue introduced in v1.
>=20
> In that case, please try to avoid mentioning "broken" or "fix" or
> similar, i.e. there is nothing broken in the tree itself (the commit
> message should mention what is done in the patch). If you want to give
> extra clarifications, then you can always add them outside the commit
> message, below the `---` line.
>=20
> In addition, if the changes here are required to be done all at once,
> then please do not rebase on top of regulator -- this would need to go

Merely rebasing on top of the rust tree will crate a conflict with his =
previous regulator patch.

My suggestion is to just wait for rc1.

> into the global Rust tree. Otherwise, any changes that does not need
> to go at the same time should go separately so that it is easier to
> land.
>=20
> Finally, I am not sure I follow the `unwrap_or(0)` here. If one passes
> a negative enough `i64`, wouldn't that mean `Ok` starts to be
> returned? Currently all negatives that are not codes are supposed to
> be bugs.
>=20
> Either way, I think this should probably go on top of
> =
https://lore.kernel.org/rust-for-linux/20250829192243.678079-3-ojeda@kerne=
l.org/,
> since that adds documentation, and thus it would be nice to adjust
> that one to whatever the generic one should do now, especially if the
> semantics are changing.
>=20
> Thanks!
>=20
> Cheers,
> Miguel
>=20


