Return-Path: <linux-kernel+bounces-748381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CD3B14079
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E8897A6F64
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6A2274FD9;
	Mon, 28 Jul 2025 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKGEAs/K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A9326D4CD;
	Mon, 28 Jul 2025 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753720778; cv=none; b=E4fApK6kn/nLwmyZhJKHizUVTyqNmB4MdeYNYF2wgOp1d8fBgN1/EW0B8Bt2TNLYocWIo2xRKL+ndA//0R/ATE0Xsn6j/Js0mwXN9Lbs3ccUPYHrrkdci4m4P/kOypdAPlf5VICgdnocpDrNaB560VAALnwGnoHUsoyOXUYMDR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753720778; c=relaxed/simple;
	bh=/ov/rk2cjeihsiSkEYV6bT+tgrRGVDD07ASZNj862Qc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=YurVEzriWARmbIASVoZryljsKQg1ufvtGQ6qjkGS+Apecq7RN/gPq7HADS8cEpADXfut1B3UdGROk5UGiatqwPNpEAp1BNnqV5yvbCM4DoUMYVK+Lyzb1gjssUF3DXVhiZfZ0w1aSbpFbk/YdW9gEeNUeTFx+net9jyDhsI2+tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKGEAs/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332DCC4CEE7;
	Mon, 28 Jul 2025 16:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753720775;
	bh=/ov/rk2cjeihsiSkEYV6bT+tgrRGVDD07ASZNj862Qc=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=MKGEAs/KG5gX+3jiwpP1Xj1E1Pf1d6o1ajUpyRq7oA/oJXi4g7O6y1Q8qV7NoptzR
	 0cF/FxJirOD+0VQ35WbrHmVfs0Yp6wPTTnonXGktCbPeJ1sqRLafK48waU34SVINKa
	 AMiwFMYk+LbehkaovZW6q2QvyDVqiVaELn52fD4GyxZE5MH8OXCZjwMujfZfQiDm/q
	 2cU5LEDDV2qoNJpHl4zLJiWi57MhXbHGLCr+tVDHuopu47DYY8Zfkhaz6JsJFgqRNI
	 236FEZPFQrNGbGAnf2JifrukjEAEPf/tDOjXoB1IcNHLPJxOrGH9atIydeXZRuCPGT
	 gu0xfGzoJXNSw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Jul 2025 18:39:29 +0200
Message-Id: <DBNU4N9KCD5J.2G97H1EI7DO1W@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 1/3] rust: maple_tree: add MapleTree
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Andrew Ballance" <andrewjballance@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-kernel@vger.kernel.org>, <maple-tree@lists.infradead.org>,
 <rust-for-linux@vger.kernel.org>, <linux-mm@kvack.org>
References: <20250726-maple-tree-v1-0-27a3da7cb8e5@google.com>
 <20250726-maple-tree-v1-1-27a3da7cb8e5@google.com>
 <aIefe_MEPd_yicde@tardis-2.local>
In-Reply-To: <aIefe_MEPd_yicde@tardis-2.local>

On Mon Jul 28, 2025 at 6:04 PM CEST, Boqun Feng wrote:
> On Sat, Jul 26, 2025 at 01:23:22PM +0000, Alice Ryhl wrote:
>> The maple tree will be used in the Tyr driver to allocate and keep track
>> of GPU allocations created internally (i.e. not by userspace). It will
>> likely also be used in the Nova driver eventually.
>>=20
>> This adds the simplest methods for additional and removal that do not
>> require any special care with respect to concurrency.
>>=20
>> This implementation is based on the RFC by Andrew but with significant
>> changes to simplify the implementation.
>>=20
>> Co-developed-by: Andrew Ballance <andrewjballance@gmail.com>
>> Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>> ---
> [...]
>> +    /// Free all `T` instances in this tree.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// This frees Rust data referenced by the maple tree without remov=
ing it from the maple tree.
>> +    /// The caller must ensure that no reference that remains in the ma=
ple tree is used incorrectly
>> +    /// after this call.
>> +    unsafe fn free_all_entries(self: Pin<&mut Self>) {
>> +        // SAFETY: The pointer references a valid maple tree.
>> +        let ma_state =3D unsafe { Opaque::new(bindings::MA_STATE(self.t=
ree.get(), 0, usize::MAX)) };
>> +
>
> A meta comment here for the future direction: I think it really makes a
> lot of sense if we could have the Rust abstraction for struct ma_state,
> that'll allow us to have flexible locking strategy and Iterator-like
> interface. Maybe it's something Andrew can take a deeper look when
> MapleTree binding is in-tree (no word play intented ;-))?
>
> For example, with a ma_state binding, we can do:
>
>     let mas =3D MAState::new(self, 0..);
>
>     while let Some(v) =3D mas.next() {
>     	drop(v)
>     }

FYI: Left a similar comment on MapleLock [1]. :)

I'd rather have that sooner than later, free_all_entries() is a good intern=
al
user.

[1] https://lore.kernel.org/all/DBNO0N1TDAGI.2OEWH6Y60JNYZ@kernel.org/

