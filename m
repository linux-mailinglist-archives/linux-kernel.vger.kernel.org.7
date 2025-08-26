Return-Path: <linux-kernel+bounces-786861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5812BB36C91
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F34F64E14DC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9DA223322;
	Tue, 26 Aug 2025 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="eGzcwv8F";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="QM5zKPtG"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887CF1F872D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756220223; cv=none; b=F2i6R2tLMnqaSY1nlhK9WNBk8GgnUMN4E0iElszFXN5aAisro2Z06lO7C6zv8/eSjEaCxH8cItwDoE4Xrnp13JGoEK/+iro4gPxKgWXm0KZDqcL4afslaT8OGMBCVfzR8l4lKMlgNWHHTGlL0GlfVD4v2r6x0MJ3pRhf/2flfGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756220223; c=relaxed/simple;
	bh=QauaDj0jCrgvgctb9q1Ow+lVmL4ZP34xzKj7rrO7Uk8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ua1OZRUylDaRqmgSwOBKs34NgH2SZg5qCrDgWjxsMwqtVmsMpJq1qb+Wbi9rkyuv4O7bVsARtJUNNDifOj+tK4hz54HSb6o4HcGchmD8AQ+WcOJ4R39m/EVYu/k+yNgL7HlN9DG9Mg8Y7W9NctRBimrIoBzDsOhIJM3nEZEzlhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=eGzcwv8F; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=QM5zKPtG; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1756220213; x=1756825013;
	d=konsulko.se; s=rsa2;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from;
	bh=QauaDj0jCrgvgctb9q1Ow+lVmL4ZP34xzKj7rrO7Uk8=;
	b=eGzcwv8Fu8Bjldc3VG5ugIT20ar78EMccNQF820p2u+pKzVdhMqP6kmp7uvDz8P+X23EFKvbMCjwx
	 th9wfzycYtQcB4V2Iup8Nitds9zLRN6j6hBKmdPUA7unIKadP0lLVk+Wr5lTqLubRwMpnVwDLnIv9q
	 5sDTvzc2iA2+HSM6glAOZcHteSaIYN8eHuutH+U2bpVkGPpZNbR6EG9bmZsKlR5HXInoC3FjDuZIIR
	 XUnhGdsNn6NFKufvFe6Ry41NQJZUx+OuwFzHFitjfFKMH4yoNmx7zxf+m9oozSzQPVvZv+BBnk/W8V
	 eRKcwMYDZBixt4242xU/3HzTdtVINFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1756220213; x=1756825013;
	d=konsulko.se; s=ed2;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from;
	bh=QauaDj0jCrgvgctb9q1Ow+lVmL4ZP34xzKj7rrO7Uk8=;
	b=QM5zKPtGz1LsmXfWiCV4vIplJh/aFZ3MfOhmPm/fpzEd02l+vkvHnXH+NFd5WmFimc7D91ALZGU4o
	 79rWK1HBQ==
X-HalOne-ID: e4e2ffef-828c-11f0-b5cb-d510462faafc
Received: from smtpclient.apple (unknown [195.250.75.242])
	by mailrelay4.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id e4e2ffef-828c-11f0-b5cb-d510462faafc;
	Tue, 26 Aug 2025 14:56:52 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v4 0/2] rust: zpool: add abstraction for zpool drivers
From: Vitaly Wool <vitaly.wool@konsulko.se>
In-Reply-To: <20250826124454.GA1502@cmpxchg.org>
Date: Tue, 26 Aug 2025 16:56:46 +0200
Cc: rust-for-linux <rust-for-linux@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Yosry Ahmed <yosry.ahmed@linux.dev>,
 Nhat Pham <nphamcs@gmail.com>,
 linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CB3E7E9C-2192-4C60-B79A-932AD6CB005A@konsulko.se>
References: <20250823130420.867133-1-vitaly.wool@konsulko.se>
 <20250826124454.GA1502@cmpxchg.org>
To: Johannes Weiner <hannes@cmpxchg.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)



> On Aug 26, 2025, at 2:44 PM, Johannes Weiner <hannes@cmpxchg.org> =
wrote:
>=20
> On Sat, Aug 23, 2025 at 03:04:19PM +0200, Vitaly Wool wrote:
>> Zpool is a common frontend for memory storage pool implementations.
>> These pools are typically used to store compressed memory objects,
>> e. g. for Zswap, the lightweight compressed cache for swap pages.
>>=20
>> This patch provides the interface to use Zpool in Rust kernel code,
>> thus enabling Rust implementations of Zpool allocators for Zswap.
>=20
> The zpool indirection is on its way out.
>=20
> When you submitted an alternate allocator backend recently, the
> resounding feedback from the zswap maintainers was that improvements
> should happen to zsmalloc incrementally. It is a lot of code and has a
> lot of features that go beyond allocation strategy. We do not want to
> fork it and fragment this space again with niche, incomplete backends.
>=20
> It's frustrating that you not only ignored this, but then went ahead
> and made other people invest their time and effort into this as well.
>=20

I don=E2=80=99t think we have a consensus on that.

And zblock is, after some additional improvements, just better than =
zsmalloc in all meaningful aspects, let alone the simplicity. It is fas =
easier to implement in Rust than zsmalloc, too. Besides, zram is a good =
candidate to be rewritten in Rust as well and after that is done, zblock =
will be even safer and faster. So while not being =E2=80=9Cincomplete", =
it=E2=80=99s zsmalloc that is becoming a niche backend moving forward, =
and I would argue that it could make more sense to eventually obsolete =
*it* rather than the zpool API.

~Vitaly=

