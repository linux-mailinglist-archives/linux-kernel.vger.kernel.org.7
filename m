Return-Path: <linux-kernel+bounces-788457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F90B384E0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E6E1BA7887
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1EB35A290;
	Wed, 27 Aug 2025 14:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="Bjjks59P";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="PCt/7WLb"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6B73570D4
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 14:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756304655; cv=none; b=ggezImuU06w7UVhT1UWLgANsLArCRC96lnLm9JSoYs+yfffrx2m6DTQ6SRGDRCvrSVUFefbp9un/Rf0Q27U0poPHEqoo2a699x9qCU1TB811v4Y9pNDwoeGEn7f6POi2KAJbuXpL2cTPKy78tIn8v6JMUTEbrp1aGa3ZiU1Ijvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756304655; c=relaxed/simple;
	bh=QdmClbBIjZcLgLk9RIerPv7Tywtt8/G+FbyO/EFyBh4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=oxSPVfhdxFAqO8d7rCnUw2JozxYj1zo3NaYa+8G278o/zJYJ9Aa5EWc3DH0BpS9xHkeL7skNXYjDCpWJLdHzkpAmasNVQRZASLePhTZJ7a1PvR6gYD9+qa0+Qx02xkksjYad9YBvwVmIFDNjVydSYO3jqZF8ddvOFHAEMsVx5O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=Bjjks59P; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=PCt/7WLb; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1756304650; x=1756909450;
	d=konsulko.se; s=rsa2;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from;
	bh=HosDHf8ILmXNfs+W1FVKb7QZ7kgKb/fbwrTqstAIoQU=;
	b=Bjjks59P4Lnkx/2SgdlsQI76U/z52m6ysXbLdjo/76EkNzvoQ3vxKERqeENiVSFPeol/bCCmMePN/
	 m3hv3tCMoihZd95Hjo8pNY6es1WjPkiVVkSy5eGePj1kaHL8ngZCAfMCmQnNzW5/ygvVo1uq6dk6yT
	 qKglOGWd/YH0h+jNw6zeCZbNqi8QbykQUAqLNC5XGHLTPZ+g462rJsRAhW3kraq1PQ3PSTMjRR+n76
	 usqzcsOBFcj83zfRE/cBY9kHZn3TmYk+4+CjBCM8SIYAT4T1HlSCEgizwb6W8JKXg2WjhX2n9ktRfp
	 3vVJaNi47+jaNcqPSE6b6lzUaMLswxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1756304650; x=1756909450;
	d=konsulko.se; s=ed2;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from;
	bh=HosDHf8ILmXNfs+W1FVKb7QZ7kgKb/fbwrTqstAIoQU=;
	b=PCt/7WLbEKLNF3KfvCOQ0X2J0hnpEs467gn30VHNhtEL8vLiSS0OhSK7mu1D3Ug07cRroR8cfWSgx
	 P6JO96NCw==
X-HalOne-ID: 7e22e996-8351-11f0-aecb-632fe8569f3f
Received: from smtpclient.apple (host-90-233-222-89.mobileonline.telia.com [90.233.222.89])
	by mailrelay2.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 7e22e996-8351-11f0-aecb-632fe8569f3f;
	Wed, 27 Aug 2025 14:24:09 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v4 2/2] rust: zpool: add abstraction for zpool drivers
From: Vitaly Wool <vitaly.wool@konsulko.se>
In-Reply-To: <DCCIRTHGQFNX.1M8GXO4TYA7DF@kernel.org>
Date: Wed, 27 Aug 2025 16:24:08 +0200
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
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Yosry Ahmed <yosry.ahmed@linux.dev>,
 Nhat Pham <nphamcs@gmail.com>,
 linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DFA3B588-3650-42DA-8875-7AB7D20A2BCA@konsulko.se>
References: <20250823130420.867133-1-vitaly.wool@konsulko.se>
 <20250823130522.867263-1-vitaly.wool@konsulko.se>
 <DCCIRTHGQFNX.1M8GXO4TYA7DF@kernel.org>
To: Benno Lossin <lossin@kernel.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)



> On Aug 26, 2025, at 7:02 PM, Benno Lossin <lossin@kernel.org> wrote:
>=20
> On Sat Aug 23, 2025 at 3:05 PM CEST, Vitaly Wool wrote:
>> +pub trait ZpoolDriver {
>> +    /// Opaque Rust representation of `struct zpool`.
>> +    type Pool: ForeignOwnable;
>=20
> I think this is the same question that Danilo asked a few versions =
ago,
> but why do we need this? Why can't we just use `Self` instead?

It=E2=80=99s convenient to use it in the backend implementation, like in =
the toy example supplied in the documentation part:

+/// struct MyZpool {
+///     name: &'static CStr,
+///     bytes_used: AtomicU64,
+/// }
=E2=80=A6
+/// impl ZpoolDriver for MyZpoolDriver {
+///     type Pool =3D KBox<MyZpool>;

Does that make sense?
=20
>=20
>> +
>> +    /// Create a pool.
>> +    fn create(name: &'static CStr, gfp: Flags) -> =
Result<Self::Pool>;
>> +
>> +    /// Destroy the pool.
>> +    fn destroy(pool: Self::Pool);
>=20
> This should just be done via the normal `Drop` trait?

Let me check if I=E2=80=99m getting you right here. I take what you are =
suggesting is that we require that Pool implements Drop trait and then =
just do something like:

    extern "C" fn destroy_(pool: *mut c_void) {
        // SAFETY: The pointer originates from an `into_foreign` call.
        unsafe { drop(T::Pool::from_foreign(pool)) }
    }

Is that understanding correct?

~Vitaly


>=20
> ---
> Cheers,
> Benno
>=20
>> +
>> +    /// Allocate an object of size `size` bytes from `pool`, with =
the allocation flags `gfp` and
>> +    /// preferred NUMA node `nid`. If the allocation is successful, =
an opaque handle is returned.
>> +    fn malloc(
>> +        pool: <Self::Pool as ForeignOwnable>::BorrowedMut<'_>,
>> +        size: usize,
>> +        gfp: Flags,
>> +        nid: NumaNode,
>> +    ) -> Result<usize>;
>=20


