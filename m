Return-Path: <linux-kernel+bounces-725768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE10B003BB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D93985C4633
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3982690FB;
	Thu, 10 Jul 2025 13:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Q0GSggId"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2BA259C92;
	Thu, 10 Jul 2025 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154472; cv=pass; b=umePTkAuN1a+n3l/UpQtHDbeX/vBoNmHMwweODuH4woqTfq6fUKoTbMnLuX/sUPEd75g6aPRFDny0ONr96ESE0fyL/wTc48yeKQZEvHrvqLBmS5qWbVx6++J1DMwWjNw37vPoMgnoJDiNw1XZIJJq44/Pn9C89w2IJHhKMnya+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154472; c=relaxed/simple;
	bh=Nxjw+T1n4EsFTBt+Qhwe1cqn8ER3+UeUuzBXZDsiNYY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ckUbYy7L3GT7BSNh0+0GxDVRZbNAuTchMtVe0Y3MXTPovPYnDOYAojI56p0/XVDKZ/nT4ZHKzL6e1l9U8C7E5tZ60UC10DiD57JUkC0XIXqe0YW1o20fITASrRM+RPvqdd68PUATsxt2Hxwudkua/4LRXCd/mCSmyca/htKMTPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Q0GSggId; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752154450; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FHFqKTx5NAiFnuObcP4T/bITxfXJuaLI/VL8OD5VfzwLZVJg4qBXVdzp0kIOKFF7aWiDkg0M1/cnxfBpUMSTzl3M5Aa7Y4qdMpmkP0ytG3FtEJvDex6kqCWYOfK5p/QnRJIeiOZyPRzZQwi8+YKzoy5NKie/u6Dwzd/g1T7pmUY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752154450; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Jnokwj1iwVq0KKKajiTm1xVOKLUaFB96+sjBk1UptGU=; 
	b=P3ySmjieVyLPJI9CAeg4UmWNwt9yG4V50loEPjZew9JIP1HN3qpYF1BfDahorb5H+VHGppK/c7HEDgjbmUY3Dh/HHJxEquHFaPmIhP5Bntl7DiZQ+xF223wJxeK7fm8zzQ0onEyU284/bwEQyKonLcCRPxSDFAbVe/JGlZp+eic=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752154450;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=Jnokwj1iwVq0KKKajiTm1xVOKLUaFB96+sjBk1UptGU=;
	b=Q0GSggId8tZf8xc8UH57JpSB/LZdkeQMAwDBEa0Bj+rpp1SoCw15eE6rArXbC8uv
	7olAa8swju+hoHGxGttT05whrxx0DdY/tRP46rLSu1txgEfq6hy0eiNL+NPvvtn10vb
	Hv0FnWtfMJDejbMeO+Uoq+XYCy12O5jVgMRPOIqg=
Received: by mx.zohomail.com with SMTPS id 1752154447317218.32548583021992;
	Thu, 10 Jul 2025 06:34:07 -0700 (PDT)
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
Date: Thu, 10 Jul 2025 10:33:50 -0300
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
Message-Id: <D7735793-D99E-44D4-945C-2AC0B500E1F9@collabora.com>
References: <20250704-topics-tyr-platform_iomem-v12-0-1d3d4bd8207d@collabora.com>
 <20250704-topics-tyr-platform_iomem-v12-1-1d3d4bd8207d@collabora.com>
 <aGt6CZAUeuK0XnmP@google.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

[=E2=80=A6]

>=20
>> +    }
>> +
>> +    /// Returns the name of the resource.
>> +    pub fn name(&self) -> &'static CStr {
>> +        let inner =3D self.0.get();
>> +        // SAFETY: safe as per the invariants of `Resource`
>> +        unsafe { CStr::from_char_ptr((*inner).name) }
>> +    }
>> +
>> +    /// Returns the flags associated with the resource.
>> +    pub fn flags(&self) -> Flags {
>> +        let inner =3D self.0.get();
>> +        // SAFETY: safe as per the invariants of `Resource`
>> +        let flags =3D unsafe { *inner }.flags;
>> +
>> +        Flags(flags)
>> +    }
>> +}
>> +
>> +// SAFETY: `Resource` only holds a pointer to a C `struct resource`, =
which is
>> +// safe to be used from any thread.
>> +unsafe impl Send for Resource {}
>> +
>> +// SAFETY: `Resource` only holds a pointer to a C `struct resource`, =
references
>> +// to which are safe to be used from any thread.
>> +unsafe impl Sync for Resource {}
>> +
>> +/// Resource flags as stored in the C `struct resource::flags` =
field.
>> +///
>> +/// They can be combined with the operators `|`, `&`, and `!`.
>> +///
>> +/// Values can be used from the [`flags`] module.
>> +#[derive(Clone, Copy, PartialEq)]
>> +pub struct Flags(usize);
>=20
> Based on usage it looks like the correct type is c_int?

Shouldn=E2=80=99t this be c_ulong because of:

#[repr(C)]
#[derive(Copy, Clone)]
pub struct resource {
    pub start: resource_size_t,
    pub end: resource_size_t,
    pub name: *const ffi::c_char,
    pub flags: ffi::c_ulong, <=E2=80=94=E2=80=94

In any case, we will have to cast this because __request_region
expects c_int.

=E2=80=94 Daniel


