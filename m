Return-Path: <linux-kernel+bounces-722127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F7DAFD59C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32551C20C08
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D092E62C2;
	Tue,  8 Jul 2025 17:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="RLNQB+LE"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFA721CFFD;
	Tue,  8 Jul 2025 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751996663; cv=pass; b=uQVekUbON2KFWGD7GDH6lzsoAPisU2SsX5VuZWnX9/FM3kVuvsi+pJf+OCn2aJXFaUchDIHiEk0mbzr8hJxTkWbTf7F7hXi7hoJPXogQ7w2HLdmYWi4Rperd5RK0RnnzEksjhEP8hbWpPifYInsD1ZoGduv40j4YtWJQvFEL29c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751996663; c=relaxed/simple;
	bh=xzfGNWA/W4VURIV6s4NhjzHwu/DUZQJc70I8LyEN5hQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BJt/VUscKqWgaENUWhlDbXizefOm2CjSIQGqA9yC/id43u7AMxZCYDhiW7+fgOhI1RXOYrm0+ovfWb5i15EJkdqdqlaWQEm8+CI07jbWl/7iFgIvoCbfFIUEmtKMWkzNeaf7EHo5k8J9TVdwn+yPuEbG75trtVOsy8O0XgCGrQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=RLNQB+LE; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751996632; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jnD1zxkDvkV8CPZGoevIrdlgfYz5Ec0KR92RJipuBtT7I8ROUKRh8CW1s3R2xI2N+/s2hwQKm+QXjSlJWgoRt25q8ncBCKUPmrVm9PqauvxioGUxgQtjZza51R0tpM/b7+x5JcE2XB93IPrC42U6fctn6/D+1xlXynDllWkWOmM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751996632; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=L/J9V/m/bQt+h2uQUtg/Qt9JlVPTPrPt9k9u1Wdzraw=; 
	b=L+oo7WgkmcW92TkIf4rEq1fp6z+eaBFPy+xNVuXpPlFh3Vll54h+mCh5P5zuDig5xXP8ayKs5cgR4T2iBb+ZKdPEvxzLjyYXb5nLpB8r1yUyojgSKm5ruZRFvhVH+xP/o6LGVwxTH5mked8SAmJ1VBmYn0r/L1+qD6LPGptPtsM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751996632;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=L/J9V/m/bQt+h2uQUtg/Qt9JlVPTPrPt9k9u1Wdzraw=;
	b=RLNQB+LEoEB6mGWlNDo6zJlicHdCtIR5txVoP0384hiaQyIc+2MGjv/+LM6DpUxm
	FpMsQN8Uc0n0JRyGQ8lt8GGhrj1XARNa51izjM0GnJk3Hs6dbbS3hnkwI60JtCiw84p
	EAPv+WKB2wknMmtYKN6WXoen/9tAqcNvZOIUfYSU=
Received: by mx.zohomail.com with SMTPS id 1751996630986809.7878015874878;
	Tue, 8 Jul 2025 10:43:50 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v12 1/3] rust: io: add resource abstraction
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <aGt6CZAUeuK0XnmP@google.com>
Date: Tue, 8 Jul 2025 14:43:33 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Ying Huang <huang.ying.caritas@gmail.com>,
 Benno Lossin <lossin@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 Fiona Behrens <me@kloenk.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F1EA22CF-1C01-495D-97ED-59D51A45A8B0@collabora.com>
References: <20250704-topics-tyr-platform_iomem-v12-0-1d3d4bd8207d@collabora.com>
 <20250704-topics-tyr-platform_iomem-v12-1-1d3d4bd8207d@collabora.com>
 <aGt6CZAUeuK0XnmP@google.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Alice,

[=E2=80=A6]


>> +
>> +impl Resource {
>> +    /// Creates a reference to a [`Resource`] from a valid pointer.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// The caller must ensure that for the duration of 'a, the =
pointer will
>> +    /// point at a valid `bindings::resource`.
>> +    ///
>> +    /// The caller must also ensure that the [`Resource`] is only =
accessed via the
>> +    /// returned reference for the duration of 'a.
>> +    pub(crate) const unsafe fn as_ref<'a>(ptr: *mut =
bindings::resource) -> &'a Self {
>=20
> We usually call this method `from_raw`.

Hmm, pretty sure I have seen the exact opposite being asked. In fact, =
this was
discussed a bit at length a while ago. See the thread starting at [0] =
for context.

>=20
>> +            )
>> +        };
>> +
>> +        Some(Region(NonNull::new(region)?))
>> +    }
>> +
>> +    /// Returns the size of the resource.
>> +    pub fn size(&self) -> ResourceSize {
>> +        let inner =3D self.0.get();
>> +        // SAFETY: safe as per the invariants of `Resource`.
>> +        unsafe { bindings::resource_size(inner) }
>> +    }
>> +
>> +    /// Returns the start address of the resource.
>> +    pub fn start(&self) -> u64 {
>> +        let inner =3D self.0.get();
>> +        // SAFETY: safe as per the invariants of `Resource`.
>> +        unsafe { *inner }.start
>=20
> This needs to be
>=20
> unsafe { (*inner).start }
>=20
> What you wrote is not equivalent. (*inner) is a place expression, but
> when you write `unsafe { <place expr> }` that turns it into a value
> expression by reading the value. So this code copies the entire struct
> to the stack, and then you read `start` from the copy on the stack.

To be honest, I've seen a bug where the opposite was going on, a field =
was
being written on the value that was copied to the stack, leaving the =
original unchanged.

In any case, I thought this would be optimized away by the compiler. =
Also, IMHO
there should be a lint for this, because it does not make sense to copy =
a struct
just to read a field if we can just read the original location.

Thanks for catching that though, I will fix it on the next iteration :)

[=E2=80=A6]

Thanks for the other comments,

=E2=80=94 Daniel

[0] =
https://lore.kernel.org/rust-for-linux/B3564D77-9E26-4019-9B75-B0C53B26B64=
F@collabora.com/



