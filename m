Return-Path: <linux-kernel+bounces-732264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AB3B06441
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B10563BA78F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C289F26738D;
	Tue, 15 Jul 2025 16:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgzXR1ON"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EDA2A1B2;
	Tue, 15 Jul 2025 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752596620; cv=none; b=URREeDmJAmKN6nFVNpZ2Kv2DSY58dybDzDwaNav3+9LKaEkwH5Zq8O/YWc+d3q63EOXfdF932/tVIenpYlGIbikonw2muEI6VDDzQPMrEBwuXFfvblIeZ2lejkO6/JRQZczizMY7mBwX7LHUyKVic2hccvbyba1MEZfKaIG0bC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752596620; c=relaxed/simple;
	bh=JXat8KTZck6err4CGBimEf5WOpec5w1uv5OjM2flM1k=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=BhjkA/qQl/LUWB3J5gDRjzxMVDA7uLmV8XjNxTAuLyWFXTRBOaN6pr6Rmvzpn/sqa5YAxVhaDc2k2S9k8kPeMP9OU0Jkl8sB4id0XsF/8h1TGbxJSC0MfeGvJHTa9J6zxWmqsOn37VBOhytn8/Ew3MeTrCk6gUKYPYchjFXGbpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgzXR1ON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4B1C4CEE3;
	Tue, 15 Jul 2025 16:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752596619;
	bh=JXat8KTZck6err4CGBimEf5WOpec5w1uv5OjM2flM1k=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=jgzXR1ONnnTCbRp/B5eAEWhsiSwHJNYJAGG0Hu7+irqQodWkegYm9d1zyt4TaD9gQ
	 pm4OeDcpB48dcABw4SjPgEAxofcARXkA2iE1DySd0xc/xduhCmbSMnb9jjH4tCkhL6
	 qur+aUC1xpDBO97HPAB5XkG7fKf57GMHGD+IB1o0OwJafsctdamoP9kcuaf5u40V/X
	 ocZ58+I8AC/yRpHF1rBDIwh+CcmrnXsY+FAcSK+fbDN/unh/u/blYB9aYWdIV5ZZad
	 2xoXl6D8ma9Datky2JwKzfRoYD3dkr+GPSeVoZr/XC8p1ZqdB9PGZqCfM7A3iTgGfc
	 iSOvhxFX2De0g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Jul 2025 18:23:34 +0200
Message-Id: <DBCRNDVHJB6Q.1OJRPHLWAA16P@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 2/2] rust: alloc: take the allocator into account for
 FOREIGN_ALIGN
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Matthew Wilcox"
 <willy@infradead.org>, "Tamir Duberstein" <tamird@gmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Trevor Gross"
 <tmgross@umich.edu>, <linux-mm@kvack.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Benno Lossin" <lossin@kernel.org>
References: <20250715-align-min-allocator-v1-0-3e1b2a5516c0@google.com>
 <20250715-align-min-allocator-v1-2-3e1b2a5516c0@google.com>
 <DBCR5IFQFMUU.23UNP95G4NKWA@kernel.org>
In-Reply-To: <DBCR5IFQFMUU.23UNP95G4NKWA@kernel.org>

On Tue Jul 15, 2025 at 6:00 PM CEST, Benno Lossin wrote:
> Do we at some point also want to give people the option to use vmalloc
> for `Arc`?

I'm not sure how useful that is. Typically, larger allocations (e.g. buffer=
s)
are members of smaller reference counted objects that manage their lifetime=
,
etc.

