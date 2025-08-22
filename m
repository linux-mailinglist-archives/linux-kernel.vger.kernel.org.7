Return-Path: <linux-kernel+bounces-782386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 897F3B31FB9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CAC3B60454
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7592921254F;
	Fri, 22 Aug 2025 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="YMa17ozj"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48618238149;
	Fri, 22 Aug 2025 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755877445; cv=pass; b=ufCmrM1o2Nrk+2GJZvH0fcjjU7p7d/UQD35nZNP+omzBMClbu4YlbRs6j2LA5ghvInqwhKYkB0iTbz9UKJJUgdeOj+2zhmH9db888MK2DE2C/RaaKIPUNvfXIRkCsxrvp/ZUY35mthpKy85I67LCPzNpHp1JbppTK3KI3KNVikY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755877445; c=relaxed/simple;
	bh=o9nh+d9r/zyynTtqiHYBqtVMaB6vk5fmJd0JfpRsFsc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=h2gUioa2At5MY+AuPKGxf3HkvHRsuzGj31NAVznPWuT41vPeSwIKg5BYLrfbZ1MBk+Qz7A81miSejXvrkzTNcPBKPWZ0LU4H8dOYjApY7vNTg9zsV6oKIixCh8n5CBxQIQDLzKpHR03skydvEt8I7Zk6pNBfTZ2Pft94Hm2U5x4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=YMa17ozj; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1755877419; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZLj7PhIDrAAGOK1HcqBj9174GgMM/NrCu6pQaUWEjDkYCAZp695q5c8s1daNnGtmuURLWDDhWlDI4av0pMsHSHjbKyM6fOHLKVAU55ZZPvuX5EKAjqn2NJ5GzWq00vJ3lElwJaP2MyNxe8BBBkDmBAKZj62D9uAmDzCTvmZupZo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755877419; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PqUCUnihyJxvxzkXqOwwRycVnt4eGXHpARTB8PXlkd4=; 
	b=mAMf1ce8SjIPMNcV5WrE8n0Ibe3VOjJ/uZQPwKKQHqlZ7Fx7pe/GY4z3Euvyko5RJwQ4lGM8YVNBg8w/W7fwzioLwFxzjd2ToXYc2tiVxTTlYNzwDsScnvjqCNZidh4iYwFApWn6pr6bSsBhlrrvSGY3BeLliCSIrTSFxUYStSY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755877419;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=PqUCUnihyJxvxzkXqOwwRycVnt4eGXHpARTB8PXlkd4=;
	b=YMa17ozjFiGBqdgmByRQBEdRvbipYETo7tl/7XaV71HtPJuo8CaITtsujNXWGT5M
	H3GTjeeKeRO0LsrtSTXp8UM6dNUbV8JEo4dyzbYqMCfkGhPtQxtn+DZ/88xRGcmueax
	6yOhHWhelQ067nk++opz3l5/UeeYYB6lRxlkSrdI=
Received: by mx.zohomail.com with SMTPS id 175587741672544.27711383068004;
	Fri, 22 Aug 2025 08:43:36 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2 3/5] rust: maple_tree: add MapleTree::lock() and load()
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <mrc7a7s7g4ylxvxfezwx3rf7ry7sng4adn64i443aikpjfz5ik@jq4co7zq7ryq>
Date: Fri, 22 Aug 2025 12:43:20 -0300
Cc: Alice Ryhl <aliceryhl@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Andrew Ballance <andrewjballance@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 linux-kernel@vger.kernel.org,
 maple-tree@lists.infradead.org,
 rust-for-linux@vger.kernel.org,
 linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FD22178C-8BCE-478B-8A2A-12FEFFA8DFC3@collabora.com>
References: <20250819-maple-tree-v2-0-229b48657bab@google.com>
 <20250819-maple-tree-v2-3-229b48657bab@google.com>
 <38B2DEA2-774D-45B5-8923-C5330B975FB9@collabora.com>
 <mrc7a7s7g4ylxvxfezwx3rf7ry7sng4adn64i443aikpjfz5ik@jq4co7zq7ryq>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Liam,

[=E2=80=A6]

>>=20
>>> +    ///
>>> +    /// # Examples
>>> +    ///
>>> +    /// Iterate the maple tree.
>>> +    ///
>>> +    /// ```
>>> +    /// use kernel::maple_tree::{MapleTree, InsertErrorKind};
>>> +    /// use kernel::sync::Arc;
>>> +    ///
>>> +    /// let tree =3D KBox::pin_init(MapleTree::<Arc<i32>>::new(), =
GFP_KERNEL)?;
>>> +    ///
>>> +    /// let ten =3D Arc::new(10, GFP_KERNEL)?;
>>> +    /// let twenty =3D Arc::new(20, GFP_KERNEL)?;
>>> +    /// tree.insert(100, ten, GFP_KERNEL)?;
>>> +    /// tree.insert(200, twenty, GFP_KERNEL)?;
>>> +    ///
>>> +    /// let mut ma_lock =3D tree.lock();
>>> +    /// let mut iter =3D ma_lock.ma_state(0, usize::MAX);
>>> +    ///
>>> +    /// assert_eq!(*iter.mas_find(usize::MAX).unwrap(), 10);
>>> +    /// assert_eq!(*iter.mas_find(usize::MAX).unwrap(), 20);
>>> +    /// assert!(iter.mas_find(usize::MAX).is_none());
>>> +    /// # Ok::<_, Error>(())
>>> +    /// ```
>>> +    #[inline]
>>> +    pub fn mas_find(&mut self, max: usize) -> =
Option<T::BorrowedMut<'_>> {
>>=20
>> Should we drop the =E2=80=9Cmas=E2=80=9D prefix here? I think that =
=E2=80=9Cfind()=E2=80=9D is fine.
>=20
> The maple tree has two interfaces, the advanced one which starts with
> mas_ and the simple on that uses mt_.  This is probably why the mas_ =
is
> here?
>=20

Yeah but we should probably not expose this nomenclature directly in =
Rust, or
at least not in the function name itself. Perhaps we can implement the =
mt_* API
as a separate type, with its own find() function?

=E2=80=94 Daniel



