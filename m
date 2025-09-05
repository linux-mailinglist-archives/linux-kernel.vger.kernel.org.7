Return-Path: <linux-kernel+bounces-803473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BB1B46026
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7732DA44F53
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C0334DCCF;
	Fri,  5 Sep 2025 17:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="G6Tb45vb";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="ScBdqIlz"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B865AC8FE
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757093455; cv=none; b=BS23KeuWVfDvIaYhJPdejiETzuGck/GMHrIspKaBi7/RP6sTxmoW0E61eDMNz+S8ajDmJj4yyMrQCCBR1arsfS/IUtWZEN6hGfHUzVCL8ECRjtDSGDnCBjWZXlQlDXO4xl5pmBAkvIZgtd1mMeDifUJl/E6DqvATWG4FuTfx5B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757093455; c=relaxed/simple;
	bh=xYznXoj0LadUc74UzmhfValiEd8WFaYCzjByoJ5nLFg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZHQaLe8gU+pB3b3j1LVTpDNMlCROIN7K1DLmOFFbESCxS4q8vx1A8NJ1nWR/YFuGeOmrOhkRVgONODEoTp1lGdgILUjlfvBr9LBqm/I08Dcekw+iuDfdKlz719gmqpMkYHCdsWjqM62o4Rv58tVU6rUrK3H0tMjh3RxWsdFS6C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=G6Tb45vb; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=ScBdqIlz; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757093449; x=1757698249;
	d=konsulko.se; s=rsa2;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from;
	bh=5m8UH08LTP4ut6uuU8yNxhh1MPFlrpE1c2LvhdEhzxI=;
	b=G6Tb45vbasAgjWIOFaNA8aDgJeolGoHkozY9c3NZLkIe8e2ylzKJahLD1rYcZ108WMtZ4VhSo4Vhy
	 mQEx+j6ZGH5oSQPOWaB/FDpIw83Rx4nSjDWyJvRI3vPTpFOV6jCXjxZL00fgN2kvjfVJrL0N9cfaw3
	 WM8Y/3EnNvJGWcJnUiVGhrPO8HWdhTfE1S12lhjpJFVoLTmnWJSAJ70kZDDs4kEvfraVhooI3JYuA6
	 IvEgGYuMPXcgjl1Ecd37Myz8MGIQnnh4B4kfEWMrozJuUYTG1ZHwelUdrXii8qWXWDbVIlBduBOfL3
	 gLas9yltSQ8tL5i+bwPl60DvYPwLjwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757093449; x=1757698249;
	d=konsulko.se; s=ed2;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from;
	bh=5m8UH08LTP4ut6uuU8yNxhh1MPFlrpE1c2LvhdEhzxI=;
	b=ScBdqIlzAcvOk+5gx8VDe3Q0OETCBkU1cARZ2jwpCFr2HX76vZESmEuMhkWmepfX36EJzNk+JivDM
	 wxeiBTiCA==
X-HalOne-ID: 0f612de6-8a7e-11f0-8aa1-fb5fec76084d
Received: from smtpclient.apple (host-95-203-0-209.mobileonline.telia.com [95.203.0.209])
	by mailrelay3.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 0f612de6-8a7e-11f0-8aa1-fb5fec76084d;
	Fri, 05 Sep 2025 17:30:48 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] rust: rbtree: add immutable cursor
From: Vitaly Wool <vitaly.wool@konsulko.se>
In-Reply-To: <aLqmmKZMDAAFCBsX@google.com>
Date: Fri, 5 Sep 2025 19:30:47 +0200
Cc: rust-for-linux <rust-for-linux@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F53AA863-91B7-459E-98B2-74FA44BA48AB@konsulko.se>
References: <20250904142552.2790602-1-vitaly.wool@konsulko.se>
 <aLqmmKZMDAAFCBsX@google.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)



> On Sep 5, 2025, at 11:00 AM, Alice Ryhl <aliceryhl@google.com> wrote:
>=20
> On Thu, Sep 04, 2025 at 04:25:52PM +0200, Vitaly Wool wrote:
>> Sometimes we may need to iterate over, or find an element in a read
>> only (or read mostly) red-black tree, and in that case we don't need =
a
>> mutable reference to the tree, which we'll however have to take to be
>> able to use the current (mutable) cursor implementation.
>>=20
>> This patch adds a simple immutable cursor implementation to RBTree,
>> which enables us to use an immutable tree reference. The existing
>> (fully featured) cursor implementation is renamed to CursorMut,
>> while retaining its functionality.
>>=20
>> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
>=20
> Overall looks good to me!
>=20
> A few comments below:
>=20
>> -// SAFETY: The [`Cursor`] has exclusive access to both `K` and `V`, =
so it is sufficient to require them to be `Send`.
>> -// The cursor only gives out immutable references to the keys, but =
since it has excusive access to those same
>> -// keys, `Send` is sufficient. `Sync` would be okay, but it is more =
restrictive to the user.
>> -unsafe impl<'a, K: Send, V: Send> Send for Cursor<'a, K, V> {}
>> +// SAFETY: The [`CursorMut`] has exclusive access to both `K` and =
`V`, so it is sufficient to
>> +// require them to be `Send`.
>> +// The cursor only gives out immutable references to the keys, but =
since it has excusive access to
>> +// those same keys, `Send` is sufficient. `Sync` would be okay, but =
it is more restrictive to the
>> +// user.
>> +unsafe impl<'a, K: Send, V: Send> Send for CursorMut<'a, K, V> {}
>>=20
>> -// SAFETY: The [`Cursor`] gives out immutable references to K and =
mutable references to V,
>> +// SAFETY: The [`CursorMut`] gives out immutable references to K and =
mutable references to V,
>> // so it has the same thread safety requirements as mutable =
references.
>> -unsafe impl<'a, K: Sync, V: Sync> Sync for Cursor<'a, K, V> {}
>> +unsafe impl<'a, K: Sync, V: Sync> Sync for CursorMut<'a, K, V> {}
>=20
> We should also have Send/Sync impls for the new immutable Cursor type.
> They need to look like this since the immutable cursor only has shared
> access and not exclusive access.
>=20
> unsafe impl<'a, K: Sync, V: Sync> Send for Cursor<'a, K, V> {}
> unsafe impl<'a, K: Sync, V: Sync> Sync for Cursor<'a, K, V> {}
>=20
>> +    /// # Safety
>> +    ///
>> +    /// - `node` must be a valid pointer to a node in an [`RBTree`].
>> +    /// - The caller has immutable access to `node` for the duration =
of `'b`.
>> +    unsafe fn to_key_value<'b>(node: NonNull<bindings::rb_node>) -> =
(&'b K, &'b V) {
>> +        // SAFETY: the caller guarantees that `node` is a valid =
pointer in an `RBTree`.
>> +        let (k, v) =3D unsafe { Self::to_key_value_raw(node) };
>> +        // SAFETY: the caller guarantees immutable access to `node`.
>> +        (k, unsafe { &*v })
>> +    }
>> +
>> +    /// # Safety
>> +    ///
>> +    /// - `node` must be a valid pointer to a node in an [`RBTree`].
>> +    /// - The caller has immutable access to the key for the =
duration of `'b`.
>> +    unsafe fn to_key_value_raw<'b>(node: NonNull<bindings::rb_node>) =
-> (&'b K, *mut V) {
>=20
> The mutable cursor has `to_key_value_raw` because it needs both a &V =
and
> `&mut V` version, but the immutable Cursor doesn't have that so it
> doesn't need a raw version either.
>=20
> That said, perhaps we could share this logic between the two cursor
> types? We can make these methods standalone instead of being part of =
the
> cursor so that both cursors can use the same helper methods instead of
> duplicating them.
>=20

I was thinking about doing some paste macro magic, but maybe it=E2=80=99s =
better to go the way Boqun is suggesting in another reply and introduce =
a helper function returning Option<NonNull<..>>. What would you prefer?

Best regards,
Vitaly=

