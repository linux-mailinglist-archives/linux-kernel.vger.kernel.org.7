Return-Path: <linux-kernel+bounces-787120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC420B371AA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A1B1B64DD1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69514288C25;
	Tue, 26 Aug 2025 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="TvsgFoRu"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D4E269AFB;
	Tue, 26 Aug 2025 17:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756230430; cv=pass; b=bk4bqVT5ZQcVREnmANz9uwG610bhGjmCiYdzmfhigpTVxSfgozVIqoROXdmt74K5ET2VIT7+XWh/iKW2oJrX5Al8dBx5g3yHCCrifeX7miklqLTQYfoQYb+/rxakWX9zcwq3r7QwhucV74I4j4jurTTDvU7N9hkysatARK3ySGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756230430; c=relaxed/simple;
	bh=JjCgSmucIFiQfoUaMJX25rcAluJyAEBBe/rn5XMOCas=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=sMYhrk/qhnEEOo8pkesCxFWzTrSzugnfNQ8VT8K9JHLGGYNS7mSWH1i9dp5uwNNoUTcvGpjUfoDCBR7vd9RQkBmQ1X00NKE1KHOWng4RZ1nkCN85u4677VzBNTbX6gukc9TEvHTRuR3CTBKEAiPzXGNaU2SM7fQk0uegZdV+Vno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=TvsgFoRu; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756230410; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Cuu3XgiW71R5vGVtMTrAV11SLDMms5/KDjwkzlJEPG4mR1/bkH9GKpI9ctJKb8iGYDfnKGZqn4qzmohiTM2+80U8Q5YUeAfnga8ZC+bH3ElzkwOq0EA6eb8N0g94tzkmOrWkCqoeqeazolfIxKRl8QjfaeHHPEP0vJtv+/VVn48=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756230410; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bQqm5EKAB0xZdSbsy5P+qCPeygkLJAl+EXVWYSBGNIM=; 
	b=WJR5QJziJTfk4a65So35ivfXLUtbe+oBn67v46TrH0NWWCkzTfkCHWGkkZjvEeq/zJu0rkTIUS/kEY8/ZBTx71g4Ue8L7vBWcodLpCnjd3bjJ+B/ZXtt86qDWMCczFHynubU9V0/iQ3h83dJ4HEDI2YSfLFUjYnf13dRyy/9stQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756230410;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=bQqm5EKAB0xZdSbsy5P+qCPeygkLJAl+EXVWYSBGNIM=;
	b=TvsgFoRuQxXxMIflZqF6OrvS7ntPwWmt8aJIzNRhHdeoh1LZx5PVE4GKyORsnI2O
	DVpsi36GISbA8n+LCZdsSqat5n72Dn93gZo0UOC94MdlWq2yFA0sLysQfWeLTVthVe0
	ctQvca7r635Ju+iqSiWqOa8xbNTEpDCvmR2PjjoM=
Received: by mx.zohomail.com with SMTPS id 1756230408153544.1999054284919;
	Tue, 26 Aug 2025 10:46:48 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v3 4/5] samples: rust: dma: add sample code for SGTable
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250825132539.122412-5-dakr@kernel.org>
Date: Tue, 26 Aug 2025 14:46:31 -0300
Cc: akpm@linux-foundation.org,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 boqun.feng@gmail.com,
 gary@garyguo.net,
 bjorn3_gh@protonmail.com,
 lossin@kernel.org,
 a.hindborg@kernel.org,
 aliceryhl@google.com,
 tmgross@umich.edu,
 abdiel.janulgue@gmail.com,
 acourbot@nvidia.com,
 jgg@ziepe.ca,
 lyude@redhat.com,
 robin.murphy@arm.com,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A8A69C22-632D-4E89-AAAA-1891DFA11416@collabora.com>
References: <20250825132539.122412-1-dakr@kernel.org>
 <20250825132539.122412-5-dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 25 Aug 2025, at 10:24, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> Add sample code for allocating and mapping a scatter-gather table
> (`SGTable`).
>=20
> Co-developed-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
> samples/rust/rust_dma.rs | 35 ++++++++++++++++++++++++++---------
> 1 file changed, 26 insertions(+), 9 deletions(-)
>=20
> diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
> index c5e7cce68654..04007e29fd85 100644
> --- a/samples/rust/rust_dma.rs
> +++ b/samples/rust/rust_dma.rs
> @@ -7,15 +7,19 @@
> use kernel::{
>     bindings,
>     device::Core,
> -    dma::{CoherentAllocation, Device, DmaMask},
> -    pci,
> +    dma::{CoherentAllocation, DataDirection, Device, DmaMask},
> +    page, pci,
>     prelude::*,
> +    scatterlist::{Owned, SGTable},
>     types::ARef,
> };
>=20
> +#[pin_data(PinnedDrop)]
> struct DmaSampleDriver {
>     pdev: ARef<pci::Device>,
>     ca: CoherentAllocation<MyStruct>,
> +    #[pin]
> +    sgt: SGTable<Owned<VVec<u8>>>,
> }
>=20
> const TEST_VALUES: [(u32, u32); 5] =3D [
> @@ -70,21 +74,30 @@ fn probe(pdev: &pci::Device<Core>, _info: =
&Self::IdInfo) -> Result<Pin<KBox<Self
>             kernel::dma_write!(ca[i] =3D MyStruct::new(value.0, =
value.1))?;
>         }
>=20
> -        let drvdata =3D KBox::new(
> -            Self {
> +        let size =3D 4 * page::PAGE_SIZE;
> +        let pages =3D VVec::with_capacity(size, GFP_KERNEL)?;
> +
> +        let sgt =3D SGTable::new(pdev.as_ref(), pages, =
DataDirection::ToDevice, GFP_KERNEL);
> +
> +        let drvdata =3D KBox::pin_init(
> +            try_pin_init!(Self {
>                 pdev: pdev.into(),
>                 ca,
> -            },
> +                sgt <- sgt,
> +            }),
>             GFP_KERNEL,
>         )?;
>=20
> -        Ok(drvdata.into())
> +        Ok(drvdata)
>     }
> }
>=20
> -impl Drop for DmaSampleDriver {
> -    fn drop(&mut self) {
> -        dev_info!(self.pdev.as_ref(), "Unload DMA test driver.\n");
> +#[pinned_drop]
> +impl PinnedDrop for DmaSampleDriver {
> +    fn drop(self: Pin<&mut Self>) {
> +        let dev =3D self.pdev.as_ref();
> +
> +        dev_info!(dev, "Unload DMA test driver.\n");
>=20
>         for (i, value) in TEST_VALUES.into_iter().enumerate() {
>             let val0 =3D kernel::dma_read!(self.ca[i].h);
> @@ -99,6 +112,10 @@ fn drop(&mut self) {
>                 assert_eq!(val1, value.1);
>             }
>         }
> +
> +        for (i, entry) in self.sgt.iter().enumerate() {
> +            dev_info!(dev, "Entry[{}]: DMA address: {:#x}", i, =
entry.dma_address());
> +        }
>     }
> }
>=20
> --=20
> 2.51.0
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>


