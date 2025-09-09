Return-Path: <linux-kernel+bounces-808950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB8CB506C7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47BBD17FE47
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B8C1D799D;
	Tue,  9 Sep 2025 20:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="IMQqXXh9"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837F918FDBE;
	Tue,  9 Sep 2025 20:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757448875; cv=pass; b=T8+9Up6wRSyKHIbK0MtGD+5lLW7sbxJNPGJd+0zOV1ADa5YTNmPT3k22rpVhH/ZK6iLlZtIi4iyuq0294LCEbYNcrTiKOxg6fp4aiqInEL9Z2PggmPBUrkfMEVA1f71wlHcSVIXg5m6hID7heMRAudt1z/iujknay6sTUekY36c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757448875; c=relaxed/simple;
	bh=XYP8FOZl6arVwSH9tqj6Uzxqg7yEkGDjl7z/cd2+GUk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Tw9u15kBnIiUi5GjdzU0p+i4eGsFvCDdPo6BxNa3sYZ7ixBOiLOGwE5RczbFtGdbntUKearlbyGi6iv0tR0b5UzczEBO2a3WltdFDfuTKadynToD87ShYdmraASn4NrPVm++zKybW4i7P+HSq6REulFDZJ/XmcJvfzmZNNPsmYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=IMQqXXh9; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757448849; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZS+PXXkXJMF8nmLyWxF8MLLj2xdgJG01tt3zIfdLgg9H8i7wRFU6P84E4L2dTn2w0Nwq06uigAYP8GISRyt/LE8KFx6s1x+uvqMGPLHynhXDEQdEXvDw84I8xmt2SdEU3mxldnu1sV8Os/UaekXTLnbpzTtaatP/9aCkXSEX3v8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757448849; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XYP8FOZl6arVwSH9tqj6Uzxqg7yEkGDjl7z/cd2+GUk=; 
	b=e98UMGMd/qqcpQEQs58ssV6sajBFpNRE51umasms0muUEAScTVjLJ7VvuQhrlFidmtLgJ1m24wwCXnpprYn6eRzT53kZp/nfzGXD5M51rkbmskZbJ7tzKBZDZJ99UB0yi/bPbH6mKUmP5icFVbURaXQeo9YaMATZhg9f4NcrQKI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757448849;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=XYP8FOZl6arVwSH9tqj6Uzxqg7yEkGDjl7z/cd2+GUk=;
	b=IMQqXXh9fZdzTzCv0jHOq5/Bp2avzzp/jAuqj6mUihJmIQoB+HNNq7S/4WIcOt6h
	7smqVKabvbjmFdBjMR3uPWk4OScPggIl08n4qu4bV2hvZZaWugJ3ZXZ4vmP8SkB/Nj+
	mitVn4itXriHrDHkfFGpjIzIJb8Ri46Eu95x3GLc=
Received: by mx.zohomail.com with SMTPS id 1757448847246298.0135545057768;
	Tue, 9 Sep 2025 13:14:07 -0700 (PDT)
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
In-Reply-To: <20250909215330.4a2f050f@nimda.home>
Date: Tue, 9 Sep 2025 17:13:49 -0300
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
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
Message-Id: <7E1CF096-2886-483A-929F-1EEF5E94AD47@collabora.com>
References: <20250909170013.16025-1-work@onurozkan.dev>
 <20250909170013.16025-2-work@onurozkan.dev>
 <CANiq72=kWpxpo23JUYTqxwpsY=E0uUvCHgotRuepZpL-qUqXqw@mail.gmail.com>
 <20250909204308.74ccedf4@nimda.home>
 <468A76F2-FC02-4B54-974B-7C52D946ECEB@collabora.com>
 <20250909215330.4a2f050f@nimda.home>
To: =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

[=E2=80=A6]

> If you look at the changes in rust/kernel/error.rs, you will see that
> the `to_result` function has been modified and some of its callers =
were
> updated because the function signature changed.
>=20
> The regulator patch I sent earlier is unrelated to this one. They are
> not doing the same thing. That patch aimed to make use of `to_result`

This is the piece of information I was missing, thanks.

> instead of handling errors manually. This patch on the other hand,
> changes how `to_result` itself works and some of its callers need to =
be
> updated accordingly just like in the other modules included here. The
> reason for changing the `to_result` function is explained in the =
commit
> description.
>=20
> -Onur=20

=E2=80=94 Daniel=

