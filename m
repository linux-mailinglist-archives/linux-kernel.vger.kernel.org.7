Return-Path: <linux-kernel+bounces-796876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1668B408B5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E10E4E41F1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFF52DFA26;
	Tue,  2 Sep 2025 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="Jrv1bsXb";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="x1Ao2l9M"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A1425EFBF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756826186; cv=none; b=Oe2NNn3BLlGVFfBL8TMpQ10oHv2RKb+GLJphjpXyzzOr+iQ8O8OipOrLUt82pMNgNSjVuSylVHG2RwgR63ez55Sj9NZ14/IfUtiYm5vQkVAJQvLIl27kKOvrmRw0nYjkbGrFdaNWbh7m19r83HwWpR4L0dvpkX7tg4QXg1Nf+Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756826186; c=relaxed/simple;
	bh=Hvb4wccZRjNtKraptVsMtyIUp9QMrQzrtgemNpw46AY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eSKMsqzO7Oa0IyAEEMvQg15dO+Pz2rspJLpyfKctJF/4ZK3tuWqzwnDzFIBc5/L48Wjeil3sV9ko0ZvAMaU/75pypgLpjtlSaadxOtxhPy8BHL6cCGF0JRpdphGOokVBUMBzEMDmdSYRbVMluKd3MaFKpfmpEX2TuAONcEgiSNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=Jrv1bsXb; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=x1Ao2l9M; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1756826176; x=1757430976;
	d=konsulko.se; s=rsa2;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from;
	bh=Hvb4wccZRjNtKraptVsMtyIUp9QMrQzrtgemNpw46AY=;
	b=Jrv1bsXbUJ3THtZIWGG7MUC8qs9VZN1GXubux7akLZ7yM53era3Gm0J2xz0qd9OVfPa/ykNkS6Fuc
	 oPOQvpgirLiWArshd4UMzz9cn0gXx+UM3EGNXhk2aMt1xNwLyb0+KsshlZIrAIYAFwjpzZGgU6Jhi7
	 bU4FiLCQ0Xu1U8kMQe4fkSq0K/gcjWFdOQ1GVNf+/b6tM19XRT3vVqm9z17vMTAoD8IjKjVzVUbokR
	 nVtMswwp5YoDk0aAlIjMvYQgqtOQsmoD7KFnBefSCG//Za6lRRUptkuqDrtcsdYzZIIEoorykdsj1f
	 7aJQXsOEKzjO7vPVqWfKVXWZyfAex8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1756826176; x=1757430976;
	d=konsulko.se; s=ed2;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from;
	bh=Hvb4wccZRjNtKraptVsMtyIUp9QMrQzrtgemNpw46AY=;
	b=x1Ao2l9Mpv6jH+md0cd2Tv3zs7yF71gVyD2DYoFgxhSRGM0NUPo8yudV9jEg3qQTwRBxz6n/F6lJ7
	 JdB3PTGCw==
X-HalOne-ID: c33fefa2-880f-11f0-81fc-f78b1f841584
Received: from smtpclient.apple (host-95-203-10-34.mobileonline.telia.com [95.203.10.34])
	by mailrelay1.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id c33fefa2-880f-11f0-81fc-f78b1f841584;
	Tue, 02 Sep 2025 15:16:15 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH v4 0/2] rust: zpool: add abstraction for zpool drivers
From: Vitaly Wool <vitaly.wool@konsulko.se>
In-Reply-To: <20250827130705.GA7480@cmpxchg.org>
Date: Tue, 2 Sep 2025 17:16:04 +0200
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
Message-Id: <47BCEE04-1759-4242-BF5F-727E2C2E0772@konsulko.se>
References: <20250823130420.867133-1-vitaly.wool@konsulko.se>
 <20250826124454.GA1502@cmpxchg.org>
 <CB3E7E9C-2192-4C60-B79A-932AD6CB005A@konsulko.se>
 <20250827130705.GA7480@cmpxchg.org>
To: Johannes Weiner <hannes@cmpxchg.org>
X-Mailer: Apple Mail (2.3826.200.121)



> On Aug 27, 2025, at 3:07=E2=80=AFPM, Johannes Weiner =
<hannes@cmpxchg.org> wrote:
>=20
> On Tue, Aug 26, 2025 at 04:56:46PM +0200, Vitaly Wool wrote:
>>=20
>>=20
>>> On Aug 26, 2025, at 2:44 PM, Johannes Weiner <hannes@cmpxchg.org> =
wrote:
>>>=20
>>> On Sat, Aug 23, 2025 at 03:04:19PM +0200, Vitaly Wool wrote:
>>>> Zpool is a common frontend for memory storage pool implementations.
>>>> These pools are typically used to store compressed memory objects,
>>>> e. g. for Zswap, the lightweight compressed cache for swap pages.
>>>>=20
>>>> This patch provides the interface to use Zpool in Rust kernel code,
>>>> thus enabling Rust implementations of Zpool allocators for Zswap.
>>>=20
>>> The zpool indirection is on its way out.
>>>=20
>>> When you submitted an alternate allocator backend recently, the
>>> resounding feedback from the zswap maintainers was that improvements
>>> should happen to zsmalloc incrementally. It is a lot of code and has =
a
>>> lot of features that go beyond allocation strategy. We do not want =
to
>>> fork it and fragment this space again with niche, incomplete =
backends.
>>>=20
>>> It's frustrating that you not only ignored this, but then went ahead
>>> and made other people invest their time and effort into this as =
well.
>>>=20
>>=20
>> I don=E2=80=99t think we have a consensus on that.
>>=20
>> And zblock is, after some additional improvements, just better than
>> zsmalloc in all meaningful aspects, let alone the simplicity. It is
>> fas easier to implement in Rust than zsmalloc, too. Besides, zram is
>> a good candidate to be rewritten in Rust as well and after that is
>> done, zblock will be even safer and faster. So while not being
>> =E2=80=9Cincomplete", it=E2=80=99s zsmalloc that is becoming a niche =
backend moving
>> forward, and I would argue that it could make more sense to
>> eventually obsolete *it* rather than the zpool API.
>=20
> That's your opinion, and I disagree with all of these claims. I would
> also be surprised if you found much alignment on this with the other
> folks who develop and use these features on a daily basis.

By features you mean zsmalloc? I certainly respect the effort put in it =
but if not for it being rather sluggish and error prone in non-4K page =
environments, we=E2=80=99d not come up with zblock.

> That being said, by all means, you can propose alternate
> allocators. But you don't need the zpool API for that. Just provide
> alternate implementations of the "zs_*" API and make it compile-time
> selectable.
>=20
zpool API is neutral and well-defined, I don=E2=80=99t see *any* good =
reason for it to be phased out.

> As it stands, it's hard to justify the almost 700 lines of code to
> support *runtime-switching* of zswap backends when there is only one
> backend in-tree (and even you suggest there should only be one, albeit
> a different one).

No, I don=E2=80=99t. What I said was that zsmalloc was arguably becoming =
a niche allocator. And the point here is, the toy allocator written in =
Rust (just as an example of how zpool API could be used) shows in some =
tests similar results to zsmalloc both performance and compression =
density wise.=20


