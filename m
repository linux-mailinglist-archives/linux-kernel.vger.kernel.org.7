Return-Path: <linux-kernel+bounces-745871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D48BCB11FD7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10EB67A6B3E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0431F4CB6;
	Fri, 25 Jul 2025 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="FqY2p5Dw"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15AE1B6CE9;
	Fri, 25 Jul 2025 14:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753452821; cv=pass; b=RZHN6okfeb/LSKSfkDMx5U73BPe+zuQ6uP9qB4X6TelebtKUuCd+mzG6NiqquXF8HzrdYI26Ndn7uRBpFCgRTSF4XkGr3uEKPalCB4i2MLBH6/yTPx0wTy8TO3x2Cwuq8GaS9wCCCR4pXLJeDBUi1KBHfiGFOeAiOCdudaBnBHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753452821; c=relaxed/simple;
	bh=+8mHHoqWPfakZvUKQJlGS1iEaCdlX+UMxzGntzN1kfI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=AvwsHRf1iWgiLdTPPO/MSDHSdcOZ8Q81zogxWb9NR+x0coS6CUUCjJQAWqKYYfF2HR+vRNk2Qd22vX4qAlBFO5GvLikRlSu+cCXzxj+Dxn9CFTCFRDtt1TSH87iR53BJ1HhurpDYlTlpMPeq9vq+7+m3X6jT2EOOrTS2U5ZsC0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=FqY2p5Dw; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753452783; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jSaK8mppRizdIC4dmEgqfyv4h1h+nEhypRqXME1ONjOXv151HNF8q3/AsUi5CWYOcgbAsdUfsjOoeOYn2PiFZCbzkIRFUrKzkJrHxuSN1L37gwz3pwEQxdRKuQVr8Yx4xScs5FBgernCUGqpXVBbvAn/H+g6RbH+6P/gwhq/6uo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753452783; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KZgW370kSmyKfPg+Nr+XVEFnkfSlEBBkCZNRQBFM3cc=; 
	b=eOOlpwfcG7rmr/ec1J68US54HTP8Kyycv9YMiBnqIopqoSHqzmm8pPlmTrnVVBG1c6NwluLhPe1Qsj96gKVAe15Q/HcC9kFJl9ZPAen2QwhY7Kj/LBW3Tq1xgKdxAgY9tRSM+h/B1opgIqd14c9Lw8Y+d8vjuinhs34U1ISlSV8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753452783;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=KZgW370kSmyKfPg+Nr+XVEFnkfSlEBBkCZNRQBFM3cc=;
	b=FqY2p5Dw725I/lzf4Mr51OYsQ+7utTsWGEUEZOQxDS1w+vvLsJD3Je5WiG7o9LRU
	D/ytPFabS4bNF01p4hy+ITAMEP+cLQeyWg3McsXx46/63kRKoiYnvOX4tPdVPomLfoZ
	mqhOI6SQPwqGOG9r7pq2GrIUaCSwpvZyrBo7NIYk=
Received: by mx.zohomail.com with SMTPS id 1753452781206676.9579877298089;
	Fri, 25 Jul 2025 07:13:01 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v6 6/7] rust: time: Add Instant::from_nanos()
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250724185236.556482-7-lyude@redhat.com>
Date: Fri, 25 Jul 2025 11:12:46 -0300
Cc: rust-for-linux@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org,
 Andreas Hindborg <a.hindborg@kernel.org>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <46A998B0-8101-4F51-91DE-857B237F6CC5@collabora.com>
References: <20250724185236.556482-1-lyude@redhat.com>
 <20250724185236.556482-7-lyude@redhat.com>
To: Lyude Paul <lyude@redhat.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 24 Jul 2025, at 15:49, Lyude Paul <lyude@redhat.com> wrote:
>=20
> For implementing Rust bindings which can return a point in time.
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
>=20
> ---
> V4:
> * Turn from_nanos() into an unsafe function in order to ensure that we
>  uphold the invariants of Instant
> V5:
> * Add debug_assert!() to from_nanos
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
> rust/kernel/time.rs | 23 +++++++++++++++++++++++
> 1 file changed, 23 insertions(+)
>=20
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 64c8dcf548d63..75088d080b834 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -200,6 +200,29 @@ pub fn elapsed(&self) -> Delta {
>     pub(crate) fn as_nanos(&self) -> i64 {
>         self.inner
>     }
> +
> +    /// Create an [`Instant`] from a time duration specified in =
nanoseconds without checking if it
> +    /// is positive.
> +    ///
> +    /// # Panics
> +    ///
> +    /// On debug builds, this function will panic if `nanos` violates =
our safety contract.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller promises that `nanos` is in the range from 0 to =
`KTIME_MAX`.
> +    #[expect(unused)]
> +    #[inline]
> +    pub(crate) unsafe fn from_nanos(nanos: i64) -> Self {
> +        debug_assert!(nanos >=3D 0);

Since you=E2=80=99re already checking the lower bound, wouldn=E2=80=99t =
it make sense to check the upper bound as well?=20

> +
> +        // INVARIANT: Our safety contract ensures that `nanos` is in =
the range from 0 to
> +        // `KTIME_MAX`.
> +        Self {
> +            inner: nanos as bindings::ktime_t,
> +            _c: PhantomData,
> +        }
> +    }
> }
>=20
> impl<C: ClockSource> core::ops::Sub for Instant<C> {
> --=20
> 2.50.0
>=20
>=20


