Return-Path: <linux-kernel+bounces-777723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDEDB2DD1D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B761C4157B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B8631A049;
	Wed, 20 Aug 2025 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBQfWlXE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C9621ABB0;
	Wed, 20 Aug 2025 12:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755694619; cv=none; b=nvcHGymKRpeQX+29CoufUhamoY74MekDBfTQNk/bY65DdMjDNELTjW/kB+3Uy8ZY7o2VZ5HvypnXJRNNDbZxzYWViH16fOVmGPc6JY7IRrjb26GnvoT9ffbG0UlLUHHwiMy1TUEKWGgCeLo8Gz9+Ry3sV37JmymHkP4vYVjIRNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755694619; c=relaxed/simple;
	bh=WUtS7YH/SFTY41jyLTuZUHacFQDyALN4XUUiWqnxkf0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=ZK+rm4nvGAPS+eej94MD6QvRjfqVDttAGEzw05lQ4OlGO7e5rqkI8XyDe9dWoOt29bTUeeja7jk4L+UObjdXmapxMkRXdtAx2JmPBcrKRsvYiJSYX2SjGSLbmuPNumA4QfsRI+s0xijaptTEsLVq3IyTAVT/5DSCbdhGH3Zq2BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBQfWlXE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64EB6C4CEEB;
	Wed, 20 Aug 2025 12:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755694617;
	bh=WUtS7YH/SFTY41jyLTuZUHacFQDyALN4XUUiWqnxkf0=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=uBQfWlXE6egP51AfpugeaQe+SRkMjqQaTFBS08ZywfPjrF2ejzmvwEvs6wLFBj+Iv
	 cKynCShXKVxGNHaslpmbD8mq9Q//X/eXIcouF/4iHgK9Bo2V+XmCwlVTj6B3DHHCP4
	 YOsfgu5Hoi30iGRZZpYbwsOqNcHeKPNg67BEn3BcSUNyTq0tCIu/bqnMLQMTddeumP
	 OIZqcgRzqcEswUlLJRWRiw6EVcCZ/59IJjSQau1Xvj/O7KfEw4TWsvIWAdjwc88GTl
	 nUttOPV0065mEh9WQ80pjADloLlb3iGegfP1dOwaRtyET+k3MIUpkYIGTGQdiJjU6M
	 PoQ5b8m+BoCTQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Aug 2025 14:56:52 +0200
Message-Id: <DC79SQDWVVMI.3A6WCE173M511@kernel.org>
Subject: Re: [PATCH v3] rust: alloc: implement Box::pin_slice()
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "Uladzislau Rezki" <urezki@gmail.com>, "Alice Ryhl" <aliceryhl@google.com>,
 "Vlastimil Babka" <vbabka@suse.cz>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>, "Bjorn
 Roy Baron" <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor Gross"
 <tmgross@umich.edu>
To: "Vitaly Wool" <vitaly.wool@konsulko.se>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250811101456.2901694-1-vitaly.wool@konsulko.se>
 <3e922cc6-6d27-49ad-9719-5662c6102b6b@konsulko.se>
In-Reply-To: <3e922cc6-6d27-49ad-9719-5662c6102b6b@konsulko.se>

On Wed Aug 20, 2025 at 10:07 AM CEST, Vitaly Wool wrote:
> On 8/11/25 12:14, Vitaly Wool wrote:
>> From: Alice Ryhl <aliceryhl@google.com>
>>=20
>> Add a new constructor to Box to facilitate Box creation from a pinned
>> slice of elements. This allows to efficiently allocate memory for e.g.
>> slices of structrures containing spinlocks or mutexes. Such slices may
>> be used in kmemcache like or zpool API implementations.
>>=20
>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
>
>  From what I could see, there were no objections to this one. Danilo,=20
> would you be up for picking it or is there something missing about it sti=
ll?

This looks good now.

There's a few minor nits, e.g. it'd be nice to have an  empty line between
struct definitions in the example and sentences ending with a period. But I=
 can
fix those up on apply.

