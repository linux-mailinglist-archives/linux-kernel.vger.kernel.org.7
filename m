Return-Path: <linux-kernel+bounces-787106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC17B3717C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60B057AA4EE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A641429DB88;
	Tue, 26 Aug 2025 17:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="XyZ5kdkL"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71767273810;
	Tue, 26 Aug 2025 17:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756230140; cv=pass; b=uN0YXtiK0Emo+L7JBtITHOfak6l9VgZBTFPz73LWhHz2P84YZpkb0C4HEUUpWbbG81ZcvC1OE0SEQjzJk7uwiUqYzGYdJ7HFeUKJy1sjo3l36cim+xc8GaCmEuWpwcphxvC7OMOJuvjchVOrWsKzFJ0rRLuibZ3Jcu1v9XNAPqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756230140; c=relaxed/simple;
	bh=SKa6oB+xZENU1ER26ztNgtC5zGJI5gY3JHY5TsSDDTs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=B2D0yh5jB2QRkwBfN1NCCqOlVqVgR3TLkEDZ3Q1dprhZ30xEVHbyTtv1VyKlK22Nhv6rLN8Tk232m6oLCMCkxshSH74V62rRzh411GmqZxsD4PWajj6bC+sUddKc4pyNUKTX48eOHRfbj4UvsUyQz21hvElEIvtZxudxyARX9Wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=XyZ5kdkL; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756230120; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MbCLR1N4T7xxHhjrV8fss6M5bmbFo3z4XgCfqouyEh9gVoantbMMcOqTQAhtbn49PY/jwCGLp4myHyzKdKBxdhaLZ9vkELDkihRkpEka+8AJqtZu8j3iWMPlbB/Mo0hcrxnuvzC9UiM/kQMTGqp8DNTyUWhxDeqRsi53Pf++1nw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756230120; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SK8f+GG2IKB3kWovus7R8gqvSJJ5ghEPh02buSFYcBs=; 
	b=oGMOv7X6xkMCttZ8Id39EO9kdAHm7vTLO/lPodSRb+n8P9xRtpzkmhSOy/tOrQ/TBFcf4FGeKk1JUTMbjo1F/mBJKwSuA/0TTFREUlxTeuc4mTCUqnLkpbafN4nMVE+bFmIPjGPIq/rMZ946f7M+DQq1nIGuJqaZm5rmWGSmX9Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756230120;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=SK8f+GG2IKB3kWovus7R8gqvSJJ5ghEPh02buSFYcBs=;
	b=XyZ5kdkLbxt9k5kI4kLuev94pk7VygW1xlLf1/9dREhh+fWcRpnY0hMCRWASiZvW
	4DJePATnF/JTgkTCGMC2RIxzlUxoVvbpN1a0uAi7NMFOXtBVuotf6gYZxj+lZoQLkfi
	kB61A/b4Jn9J6PiR28Ig2VUM28J27PqYh7zm4l8g=
Received: by mx.zohomail.com with SMTPS id 1756230118134842.9731315739924;
	Tue, 26 Aug 2025 10:41:58 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v3 3/5] rust: scatterlist: Add abstraction for sg_table
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <DCCFL57R0B4B.D289IWKTOTOE@kernel.org>
Date: Tue, 26 Aug 2025 14:41:43 -0300
Cc: Alice Ryhl <aliceryhl@google.com>,
 akpm@linux-foundation.org,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 boqun.feng@gmail.com,
 gary@garyguo.net,
 bjorn3_gh@protonmail.com,
 lossin@kernel.org,
 a.hindborg@kernel.org,
 tmgross@umich.edu,
 abdiel.janulgue@gmail.com,
 acourbot@nvidia.com,
 jgg@ziepe.ca,
 lyude@redhat.com,
 robin.murphy@arm.com,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7DF83F8C-C036-4E0B-BADF-E915CCA0702C@collabora.com>
References: <20250825132539.122412-1-dakr@kernel.org>
 <20250825132539.122412-4-dakr@kernel.org> <aK3BsV_s-xMQLF4d@google.com>
 <DCCFL57R0B4B.D289IWKTOTOE@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 26 Aug 2025, at 11:32, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> On Tue Aug 26, 2025 at 4:16 PM CEST, Alice Ryhl wrote:
>> On Mon, Aug 25, 2025 at 03:24:42PM +0200, Danilo Krummrich wrote:
>> Overall LGTM. With comments addressed:
>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>>=20
>>> +impl RawSGTable {
>>> +    fn new(
>>> +        pages: &mut [*mut bindings::page],
>>=20
>> This should probably be unsafe due to the raw pointer. Or could we =
pass
>> any pointer here?
>=20
> Good catch, we should indeed make this unsafe and add the =
corresponding safety
> requirements:
>=20
> diff --git a/rust/kernel/scatterlist.rs b/rust/kernel/scatterlist.rs
> index e76e5c2cbdc7..a562c0360842 100644
> --- a/rust/kernel/scatterlist.rs
> +++ b/rust/kernel/scatterlist.rs
> @@ -251,7 +251,12 @@ unsafe impl Send for RawSGTable {}
> unsafe impl Sync for RawSGTable {}
>=20
> impl RawSGTable {
> -    fn new(
> +    /// # Safety
> +    ///
> +    /// - `pages` must be a slice of valid `struct page *`.
> +    /// - The pages pointed to by `pages` must remain valid for the =
entire lifetime of the returned
> +    ///   [`RawSGTable`].
> +    unsafe fn new(
>         pages: &mut [*mut bindings::page],
>         size: usize,
>         max_segment: u32,
> @@ -355,7 +360,11 @@ fn new(
>         };
>=20
>         Ok(try_pin_init!(&this in Self {
> -            sgt <- RawSGTable::new(&mut page_vec, size, max_segment, =
flags),
> +            // SAFETY:
> +            // - `page_vec` is a `KVec` of valid `struct page *` =
obtained from `pages`.
> +            // - The pages contained in `pages` remain valid for the =
entire lifetime of the
> +            //   `RawSGTable`.
> +            sgt <- unsafe { RawSGTable::new(&mut page_vec, size, =
max_segment, flags) },
>             dma <- {
>                 // SAFETY: `this` is a valid pointer to uninitialized =
memory.
>                 let sgt =3D unsafe { &raw mut (*this.as_ptr()).sgt =
}.cast();
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>


