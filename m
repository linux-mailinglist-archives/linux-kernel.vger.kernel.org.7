Return-Path: <linux-kernel+bounces-787250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF333B37387
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 21:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73AC3464371
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF2E36CC76;
	Tue, 26 Aug 2025 19:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="YVj0IAHB"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012F330CD8E;
	Tue, 26 Aug 2025 19:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756238376; cv=pass; b=Rhg8O+zN/qskSzHAU6J/YRMGbXFkNUlRooJvT5QY6tFV1k9/dW1CaTmTfFrr7HDBk4IO31X2/C/yzzQdGaZEoHdW8llNBE7c9q9AAMLxAcas2ZXz0GWwfWLioPntbmFQCbn6dR5pe3hSfcVA0eiQuUN21pY1ctX0SqfLALBuk7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756238376; c=relaxed/simple;
	bh=v+qAZpdjFRISbvl6fEV1upnhfsGMwsUi78VSqgFIzo0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=k2h0b2OkLbRrHSlkrGwBUr/gIUtpjzgLc3zxgvrBOxaIvXHmIiLxK3dQZ9EaVjSAkx6QyP8SDJC2X+unisoBUxuR2oqYyeqx8xKu/j72vTEdB5UVdxsQawg4RgMjek+X7y4/SpnrpNZ3spOxQJGsJaUXz7cbuDjKOHtkV51JDqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=YVj0IAHB; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756238346; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VRSWjwP51+Z0Y+5sf9M6tlQX18Gr0SdG8w+GNaY8ZjSWp6Cjea/Ucv32OiPesPkOmbiSkPR5rw9s3B1jPrbmnL2bY4RKiKlutFf3mNh3LAXCOmRCRNjzFAYcH9aSSqnvfvx+96UIQm65ESUJeMe4FfVIbpFZ5OA9NtWW+6WprUs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756238346; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=v+qAZpdjFRISbvl6fEV1upnhfsGMwsUi78VSqgFIzo0=; 
	b=fed0xhGzNgMdmwbYAADg0IM0CiaztmZO/JktpcPB9KvW97LJLIdb6KkiuKtdcdBxZOn7RrkZSXlCtqsGtOCVbG/S/19dnbkWryDvsIxkNT0Gs8+UPEXVQo2TpxKZKxDwiCjoIsB4Y2Ho6I3yUe3Q8A0IUoslHa76us6JT3uHbhk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756238346;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=v+qAZpdjFRISbvl6fEV1upnhfsGMwsUi78VSqgFIzo0=;
	b=YVj0IAHBOiH1Zgh7Ra7DokFIYZqeXyiK4AbcIJFoo0hu35jJKx4tpB8J0PxWFtzE
	OGM4P2d2y8LgeX40oqP/f33btMXfjDDAID5JNmM8efPk84+zByOPqsFGRmGHW+aPvOf
	Np4HTHFqibwa11sInXKemgrUMWWOve+FiOuB94/4=
Received: by mx.zohomail.com with SMTPS id 1756238344788630.6595842451526;
	Tue, 26 Aug 2025 12:59:04 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v3 2/5] rust: dma: add type alias for bindings::dma_addr_t
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <DCCJG1V40J97.1FQA6ZV5JE6RK@kernel.org>
Date: Tue, 26 Aug 2025 16:58:48 -0300
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
Message-Id: <3CC4D02A-9A15-4F98-8DB1-97B457C18E95@collabora.com>
References: <20250825132539.122412-1-dakr@kernel.org>
 <20250825132539.122412-3-dakr@kernel.org>
 <CE0E1F73-69CE-4629-979E-9AE5B6AB055E@collabora.com>
 <DCCJG1V40J97.1FQA6ZV5JE6RK@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 26 Aug 2025, at 14:33, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> On Tue Aug 26, 2025 at 7:15 PM CEST, Daniel Almeida wrote:
>> Hmm, I wonder if this shouldn=E2=80=99t be its own type, instead of =
an alias. This
>> will be handy if we want to enforce that a given address is, in fact, =
a bus
>> address.
>=20
> I'm not sure I understand the idea. How can a new type compared to a =
type alias
> help to guarantee that a DMA address is also a bus address?
>=20
> This depends on whether there is an IOMMU, etc.


I was referring to the term "bus address" as used here [0].

My understanding has always been that a dma_addr_t is a bus address =
regardless
of whether the system has an iommu? If there's no IOMMU then we there's =
a 1:1
correspondence but this doesn't invalidate the use of the term? i.e.: =
it's still
an address that can be directly accessed by a hardware device.

In any case, this is a bit orthogonal to the point I was trying to make, =
my bad
for not expressing it better.

What I mean is, by using a separate type, i.e.:

DmaAddress(bindings::dma_addr_t)

we now ensure that one cannot pass a random u32/u64 value where a =
DmaAddress is
expected. It's a bit like the __iomem or __user C annotation, but =
actually
enforced by the type system.

In fact, this is something that was recently done in uaccess.rs, IIRC.


[0]: =
https://docs.kernel.org/core-api/dma-api-howto.html#cpu-and-dma-addresses=

