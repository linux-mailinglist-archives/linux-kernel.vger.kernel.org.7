Return-Path: <linux-kernel+bounces-776243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A377B2CA80
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05DD75A7490
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FFC302CCF;
	Tue, 19 Aug 2025 17:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="R99CMyST"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB36301499;
	Tue, 19 Aug 2025 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755624194; cv=pass; b=kTFTObLiZCQ3ooG+EN3D+VF8sQq7fLu1S1+KH5R7ctqm66FlIzhjq8Nh7hSZkjOwu+iZw0Xjb2GABiRLB1I0g/N+isgyBh3DHWXqiSlWHJ2ibD6ONzIdP0rRPdoRj2k0rA4J9GcHTOqIZCaLWnzDsU0QgdqNUQHXXjXMMdldwb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755624194; c=relaxed/simple;
	bh=CnOw8YxNadoZJ5HjZs0vKB0Rw/Cr6t8fF/7WPy3K+/k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=N7SFiVEDdQd83tkqEBxgsYQ8oM2KZb9UeH4L6hpqVDK7GVjtYeFdAh+geH3wJyhI0Tt9WNeawvCWhzG8UJhK1HF6R3shkOIDKmaUu1OIpfnVDm7MCP//V8udSAMeH2MqQs5h2BNGjRDC2X4IXagjaq149hg6gOKxL9IjITQkN28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=R99CMyST; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1755624170; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dB17iMupUftJlAcD6wb2PYq6XfkpeMPwyMGY1qBl7HKmzi6bPP4WdbqZdDrdUqiNBPlnFm9Pl4Bx6hpzVYPSjmQJcadJsyuCBF43wmhPveoypjdIHSdU24NIxdcxf+U6JgVDIh0H+rI+5oeoSSlzoBFb6pc7CJlRIzYaoY9sTPU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755624170; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IEcw8YukMBSRSfgVR4aQ1OUUrw+SZjoWnTgXZ8LvAnk=; 
	b=YF6Bk7Mt0+IE4c/6EOfrbjtV9WoESHNBs6d/lcbYDKg/5tCV3GN5oTTcLE7nLh1wtfXxYJkIK9aJa3Rck2u/0SktWBY375oS6HlFjYiXtYnRXVI+K7XzBkQnPUi+e5czCsUOYQEr40gOMgOIKQ6Ajb/Xuru6ko3O7ongv5Fpbjg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755624170;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=IEcw8YukMBSRSfgVR4aQ1OUUrw+SZjoWnTgXZ8LvAnk=;
	b=R99CMySTuMb2AjbZ8UU/ldDlpGDB519kO1Tx6MgrQf2pZ6ewYD8pepJvEypBDOaC
	I5piGs1GE+5VAntotzPQdWYwNnbpiGjtMBKyLiakrpgMwfbaaD5OEKsBfZnp74OJkIv
	QPFbDqVLh/ZsRmcNYtTAgJd1LZWO2suYfpdJBe+M=
Received: by mx.zohomail.com with SMTPS id 1755624168270959.8687296541492;
	Tue, 19 Aug 2025 10:22:48 -0700 (PDT)
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
In-Reply-To: <38B2DEA2-774D-45B5-8923-C5330B975FB9@collabora.com>
Date: Tue, 19 Aug 2025 14:22:31 -0300
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
Message-Id: <2E3FBB87-EFCE-425E-8ED8-6EE0EF19C6F2@collabora.com>
References: <20250819-maple-tree-v2-0-229b48657bab@google.com>
 <20250819-maple-tree-v2-3-229b48657bab@google.com>
 <38B2DEA2-774D-45B5-8923-C5330B975FB9@collabora.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Ah, something else,

[=E2=80=A6]

>> +    /// Load the value at the given index.
>> +    ///
>> +    /// # Examples
>> +    ///
>> +    /// Read the value while holding the spinlock.
>> +    ///
>> +    /// ```
>> +    /// use kernel::maple_tree::{MapleTree, InsertErrorKind};
>> +    ///
>> +    /// let tree =3D KBox::pin_init(MapleTree::<KBox<i32>>::new(), =
GFP_KERNEL)?;
>> +    ///
>> +    /// let ten =3D KBox::new(10, GFP_KERNEL)?;
>> +    /// let twenty =3D KBox::new(20, GFP_KERNEL)?;
>> +    /// tree.insert(100, ten, GFP_KERNEL)?;
>> +    /// tree.insert(200, twenty, GFP_KERNEL)?;
>> +    ///
>> +    /// let mut lock =3D tree.lock();
>> +    /// assert_eq!(lock.load(100), Some(&mut 10));
>> +    /// assert_eq!(lock.load(200), Some(&mut 20));
>> +    /// assert_eq!(lock.load(300), None);
>> +    /// # Ok::<_, Error>(())
>> +    /// ```
>> +    ///
>> +    /// Increment refcount while holding spinlock and read =
afterwards.

This sentence can be improved.


